//
//  WaveFormView.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 23/06/25.
//

import SwiftUI

// MARK: - Waveform Visualization
struct WaveformView: View {
    @ObservedObject var audioRecorder: AudioRecorder
    @State private var lastScrollUpdate: Date = .distantPast
    let scaleFactorWidth: CGFloat
    let scaleFactorHeight: CGFloat
    private let amplificationFactor: CGFloat = 50
    private let minSpikeHeight: CGFloat = 2
    private let placeholderCount = 112
    private let defaultLineHeight: CGFloat = 1
    private let barSpacing: CGFloat = 1  // Add spacing between bars

    var body: some View {
        GeometryReader { geometry in
            let viewHeight = geometry.size.height
            let fixedBarWidth: CGFloat = 2 * scaleFactorWidth
            let sampleCount = audioRecorder.waveformData.count

            let totalBars = placeholderCount + sampleCount
            let contentWidth = CGFloat(totalBars) * fixedBarWidth + CGFloat(max(0, totalBars - 1)) * barSpacing
            let currentIndex = calculateCurrentIndex(totalBars: totalBars)

            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    ZStack(alignment: .topLeading) {
                        // Continuous baseline for the entire waveform
                        Rectangle()
                            .fill(Color(hex: "#36393E").opacity(0.95))
                            .frame(width: UIScreen.main.bounds.width - 60 * scaleFactorWidth, height: defaultLineHeight * scaleFactorWidth)
                            .offset(y: viewHeight / 2) // Center vertically

                        HStack(alignment: .center, spacing: barSpacing * scaleFactorWidth) {
                            ForEach(0..<totalBars, id: \.self) { index in
                                let sampleIndex = index - placeholderCount
                                let hasSample = sampleIndex >= 0 && sampleIndex < sampleCount

                                if hasSample {
                                    // Get sample value
                                    let sample = audioRecorder.waveformData[sampleIndex]

                                    // Calculate bar heights
                                    // TODO: Optional Normalization of bar height to make the spikes more or less sensitive to the audio
                                    //                                    let allSamples = audioRecorder.waveformData
                                    //                                    let minSample = allSamples.min() ?? 0
                                    //                                    let maxSample = allSamples.max() ?? 1
                                    //                                    let normalizedRaw = (sample - minSample) / max((maxSample - minSample), 0.001)
                                    //                                    let normalized = pow(normalizedRaw, 0.6) // Adjust this value (0.3–0.6) to tune compression
                                    //                                    let spikeHalfHeight = max(minSpikeHeight, normalized * viewHeight / 2)

                                    let allSamples = audioRecorder.waveformData
                                    let minSample = allSamples.min() ?? 0
                                    let maxSample = allSamples.max() ?? 1
                                    let normalized = (sample - minSample) / (maxSample - minSample)
                                    let spikeHalfHeight = max(minSpikeHeight, normalized * viewHeight / 2)

                                    let barColor: Color = {
                                        switch audioRecorder.state {
                                        case .ready, .minimalRecording(progress: _), .recording:
                                            return Color(hex: "#36393E").opacity(0.95)
                                        case .stopped, .playing :
                                            if index == currentIndex {
                                                return Color(hex: "#B5B2FF") // current wave form
                                            } else if index < currentIndex {
                                                return Color(hex: "#B5B2FF") // past wave form
                                            } else {
                                                return Color(hex: "#36393E").opacity(0.95)
                                            }
                                        }
                                    }()

                                    // Sample bar with separation
                                    VStack(spacing: 0) {
                                        Rectangle()
                                            .fill(barColor)
                                            .frame(height: spikeHalfHeight)
                                        Rectangle()
                                            .fill(barColor)
                                            .frame(height: spikeHalfHeight)
                                    }
                                    .frame(width: fixedBarWidth, height: viewHeight)
                                    .background(.black)
                                } else {
                                    // Placeholder - just maintains spacing
                                    Color.clear
                                        .frame(width: fixedBarWidth, height: viewHeight)
                                }
                            }
                        }
                        .frame(width: contentWidth * scaleFactorWidth, height: viewHeight)
                    }
                    .frame(width: contentWidth * scaleFactorWidth, height: viewHeight)
                    .onChange(of: currentIndex) { newIndex in
                        let now = Date()
                        let threshold: TimeInterval = 0.0 // 150ms throttle

                        if now.timeIntervalSince(lastScrollUpdate) > threshold {
                            lastScrollUpdate = now

                            switch audioRecorder.state {
                            default:
                                proxy.scrollTo(newIndex, anchor: .center)
                            }
                        }
                    }
                    .onAppear {
                        withAnimation {
                            proxy.scrollTo(currentIndex, anchor: .center)
                        }
                    }
                }
            }
        }
    }

    private func calculateCurrentIndex(totalBars: Int) -> Int {
        switch audioRecorder.state {
        case .recording, .minimalRecording:
            return placeholderCount + audioRecorder.waveformData.count - 1
        default:
            let sampleRate = 0.1
            guard sampleRate > 0, audioRecorder.totalDuration > 0 else {
                return placeholderCount > 0 ? placeholderCount - 1 : 0
            }

            let sampleIndex = Int(audioRecorder.currentPlaybackTime / sampleRate)
            let clampedIndex = min(sampleIndex, audioRecorder.waveformData.count - 1)
            return placeholderCount + clampedIndex
        }
    }
}
