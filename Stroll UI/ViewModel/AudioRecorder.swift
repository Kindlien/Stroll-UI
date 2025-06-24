//
//  AudioRecorder.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 23/06/25.
//

import Foundation
import SwiftUI
import AVFoundation

// MARK: - Audio Recorder View Model
class AudioRecorder: NSObject, ObservableObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    enum State: Equatable {
        case ready
        case countdown(Int)
        case recording
        case stopped
        case playing
    }

    @Published var state: State = .ready
    @Published var elapsedTime: TimeInterval = 0
    @Published var waveformData: [CGFloat] = []
    @Published var countdownProgress: Double = 0.0
    @Published var totalDuration: TimeInterval = 0
    @Published var currentPlaybackTime: TimeInterval = 0
    private var timer: Timer?
    private var recordingTimer: Timer?
       private var playbackTimer: Timer?
    private var countdownTimer: Timer?

    private var recorder: AVAudioRecorder?
    private var player: AVAudioPlayer?
    private var recordingURL: URL?

    override init() {
        super.init()
        prepareRecording()
    }

    private func prepareRecording() {
        resetState()
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if granted {
                    self.setupRecorder()
                } else {
                    print("Microphone permission not granted")
                    // Optionally update UI to inform user
                }
            }
        }
    }

    private func setupRecorder() {
        let fileName = "recording_\(Date().timeIntervalSince1970).m4a"
        let path = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        recordingURL = path

        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            recorder = try AVAudioRecorder(url: path, settings: settings)
            recorder?.delegate = self
            recorder?.isMeteringEnabled = true
            recorder?.prepareToRecord()
        } catch {
            print("Failed to prepare recorder: \(error)")
        }
    }

    private func resetState() {
        state = .ready
        elapsedTime = 0
        totalDuration = 0
        currentPlaybackTime = 0
        waveformData = []
        countdownProgress = 0
        recordingURL = nil
    }

    var canDelete: Bool {
        state != .ready
    }

    var canSubmit: Bool {
        switch state {
        case .stopped, .playing:
            return true
        default:
            return false
        }
    }

    var formattedTime: String {
        formatTime(time: elapsedTime)
    }

    var formattedCurrentTime: String {
        formatTime(time: currentPlaybackTime)
    }

    var formattedDuration: String {
        formatTime(time: totalDuration)
    }

    private func formatTime(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func startCountdown() {
        print("Starting countdown...")
        countdownProgress = 0.0
        state = .countdown(3)

        let duration: TimeInterval = 3.0
        let interval: TimeInterval = 0.01
        var elapsed: TimeInterval = 0.0

        countdownTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            guard let self = self else { timer.invalidate(); return }

            elapsed += interval
            self.countdownProgress = elapsed / duration

            if elapsed >= duration {
                timer.invalidate()
                self.state = .recording
                self.startRecording()
            }
        }
    }

    func cancelCountdown() {
        countdownTimer?.invalidate()
        state = .ready
    }

    func startRecording() {
        guard let recorder = recorder else { return }

        elapsedTime = 0
        waveformData = []
        totalDuration = 0
        currentPlaybackTime = 0

        do {
            try AVAudioSession.sharedInstance().setActive(true)
            recorder.record()

            // Use RECORDING timer
            recordingTimer?.invalidate()
            recordingTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                self.elapsedTime += 0.1
                recorder.updateMeters()
                let power = recorder.averagePower(forChannel: 0)
                let normalized = max(0.1, CGFloat((power + 160) / 160))
                self.waveformData.append(normalized)
            }
        } catch {
            print("Failed to start recording: \(error)")
            state = .ready
        }
    }

    func stopRecording() {
        recorder?.stop()
        recordingTimer?.invalidate() // Use recording-specific timer
        totalDuration = elapsedTime
        state = .stopped
        currentPlaybackTime = 0  // Reset playback position
    }

    func playRecording() {
        guard let url = recordingURL else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.currentTime = currentPlaybackTime
            player?.prepareToPlay()
            player?.play()
            state = .playing

            // Start PLAYBACK timer (not recording timer)
            playbackTimer?.invalidate()
            playbackTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                guard let self = self, self.state == .playing else { return }

                if let player = self.player {
                    self.currentPlaybackTime = player.currentTime

                    if !player.isPlaying {
                        self.state = .stopped
                        self.playbackTimer?.invalidate()
                    }
                }
            }
        } catch {
            print("Failed to create player: \(error)")
            state = .stopped
        }
    }

    func pauseRecording() {
        player?.pause()
        playbackTimer?.invalidate() // Invalidate PLAYBACK timer
        state = .stopped
    }

    func deleteRecording() {
        recorder?.stop()
        player?.stop()
        timer?.invalidate()
        countdownTimer?.invalidate()
        recordingTimer?.invalidate() // Use recording-specific timer

        if let url = recordingURL {
            try? FileManager.default.removeItem(at: url)
        }

        resetState()
        prepareRecording()
    }

    func saveRecording() {
        print("Recording saved to: \(recordingURL?.path ?? "unknown path")")
    }

    // MARK: - Player Delegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        currentPlaybackTime = 0
        state = .stopped
        playbackTimer?.invalidate() // Invalidate PLAYBACK timer
    }
}
