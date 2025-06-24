//
//  RecordingView.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 22/06/25.
//

import SwiftUI
import AVFoundation

struct RecordingView: View {
    @Binding var showRecordingView: Bool
    @StateObject private var audioRecorder = AudioRecorder()
    @State private var showCheckmark = false
    @State private var submittedItemId: UUID?
    @State private var selectedTab = 0
    let item: CarouselItem
    let onComplete: () -> Void
    let scaleFactorWidth: CGFloat
    let scaleFactorHeight: CGFloat
    private let tabs = ["Details", "Info"]
    
    var body: some View {
        VStack(spacing: 0) {
            // Segmented Tabs
            SegmentedTabBar(selectedIndex: $selectedTab, scaleFactorWidth: scaleFactorWidth, scaleFactorHeight: scaleFactorHeight)

            // Header with back button and menu
            HStack {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        showRecordingView = false
                    }
                }) {
                    VStack{
                        Image("back_ic")
                            .resizable()
                            .frame(width: 6 * scaleFactorWidth, height: 11 * scaleFactorWidth)
                    }
                    .frame(width: 44 * scaleFactorWidth, height: 44 * scaleFactorWidth)
                }
                
                Spacer()
                Text(item.title)
                    .font(.system(size: 18 * scaleFactorWidth).weight(.bold))
                    .foregroundColor(Color(hex: "#FFFFFF"))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button(action: {}) {
                    VStack{
                        Image("menu_ic")
                            .resizable()
                            .frame(width: 22 * scaleFactorWidth, height: 4.4 * scaleFactorWidth)
                    }
                    .frame(width: 44 * scaleFactorWidth, height: 44 * scaleFactorWidth)
                }
            }
            .padding(.horizontal, 15 * scaleFactorWidth)

            Spacer()
            // Profile Info
            VStack(spacing: 8 * scaleFactorWidth) {
                ZStack {
                    // Circle + profile image
                    ZStack {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 60 * scaleFactorWidth, height: 60 * scaleFactorWidth)

                        item.profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50 * scaleFactorWidth, height: 50 * scaleFactorWidth)
                            .clipShape(Circle())
                    }
                    
                    // Capsule below with 10px overlap
                    VStack {
                        Capsule()
                            .fill(Color(hex: "#121518").opacity(0.9))
                            .frame(width: 105 * scaleFactorWidth, height: 20 * scaleFactorWidth)
                            .overlay(
                                Text("Stroll question")
                                    .font(.system(size: 11 * scaleFactorWidth, weight: .semibold))
                                    .foregroundColor(Color(hex: "#F5F5F5"))
                                    .padding(.horizontal, 12 * scaleFactorWidth)
                                    .padding(.vertical, 4 * scaleFactorWidth)
                            )
                            .shadow(color: Color.black.opacity(0.3), radius: 16 * scaleFactorWidth, y: 14 * scaleFactorWidth)
                            .offset(y: 30 * scaleFactorWidth) // 10px overlap from bottom of circle (60/2 + 10)
                    }
                    .frame(height: (60 + 10 + 20) * scaleFactorWidth) // ensures enough vertical space
                }
                
                Text(item.subtitle)
                    .font(.system(size: 24 * scaleFactorWidth).weight(.bold))
                    .foregroundColor(Color(hex: "#F5F5F5"))
                    .multilineTextAlignment(.center)
                
                Text(item.subtitleAnswer)
                    .font(.system(size: 13 * scaleFactorWidth))
                    .foregroundColor(Color(hex: "#CBC9FF"))
                    .opacity(0.7)
                    .italic()
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            
            formattedDisplayTime
                .padding(.vertical, 36 * scaleFactorWidth) // ori 42

            // Waveform Display
            WaveformView(audioRecorder: audioRecorder, scaleFactorWidth: scaleFactorWidth, scaleFactorHeight: scaleFactorHeight)
                .frame(height: 15 * scaleFactorWidth)
                .padding(.leading, 35 * scaleFactorWidth)
                .padding(.trailing, 35 * scaleFactorWidth)
                .padding(.bottom, 39 * scaleFactorWidth) // ori 45

            VStack(spacing: 22 * scaleFactorWidth) {
                // Control Buttons
                HStack(spacing: 40 * scaleFactorWidth) {
                    // Delete Button
                    Button(action: audioRecorder.deleteRecording) {
                        Text("Delete")
                            .font(.system(size: 17 * scaleFactorWidth))
                            .foregroundColor(audioRecorder.canDelete ? Color(hex: "#F5F5F5") : Color(hex: "#5C6770"))
                    }
                    .disabled(!audioRecorder.canDelete)

                    // Main Control Button
                    Button(action: handleMainAction) {
                        mainButtonContent
                            .frame(width: 50 * scaleFactorWidth, height: 50 * scaleFactorWidth)
                    }
                    
                    
                    // Submit Button
                    Button(action: submitRecording) {
                        Text("Submit")
                            .font(.system(size: 17 * scaleFactorWidth))
                            .foregroundColor(audioRecorder.canSubmit ? Color(hex: "#F5F5F5") : Color(hex: "#5C6770"))
                    }
                    .disabled(!audioRecorder.canSubmit)
                }
                Text("Unmatch")
                    .font(.system(size: 13 * scaleFactorWidth))
                    .foregroundColor(Color(hex: "#BE2020"))
            }
            .padding(.bottom, 33 * scaleFactorWidth)
        }
        .background(
            ZStack {
                VStack {
                    item.imageRecording
                        .resizable()
                        .scaledToFill()
                        .frame(height: UIScreen.main.bounds.height * 0.70)
                    
                    Spacer()
                }
                
                VStack {
                    Image("recording_overlay")
                        .resizable()
                        .scaledToFill()
                }
            }
                .ignoresSafeArea()
        )
        .foregroundColor(.white)
        .scaleEffect(showRecordingView ? 1 : 0.8)
        .opacity(showRecordingView ? 1 : 0)
    }
    
    private var formattedDisplayTime: some View {
        HStack(spacing: 0) {
            Spacer()
            if audioRecorder.state == .playing {
                Text(audioRecorder.formattedCurrentTime)
                    .font(.system(size: 14 * scaleFactorWidth))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "#B5B2FF"))
                
                Text(" / \(audioRecorder.formattedDuration)")
                    .font(.system(size: 14 * scaleFactorWidth))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "#AEADAF"))
            } else if audioRecorder.state == .stopped {
                Text(audioRecorder.formattedCurrentTime)
                    .font(.system(size: 14 * scaleFactorWidth))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "#AEADAF"))
                
                Text(" / \(audioRecorder.formattedDuration)")
                    .font(.system(size: 14 * scaleFactorWidth))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "#AEADAF"))
            } else {
                Text(audioRecorder.formattedTime)
                    .font(.system(size: 14 * scaleFactorWidth))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "#AEADAF"))
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, 10 * scaleFactorWidth)
    }
    
    private var mainButtonContent: some View {
        Group {
            switch audioRecorder.state {
            case .ready:
                ZStack {
                    // Background circle
                    Circle()
                        .strokeBorder(Color(hex: "#B4B4B4"), lineWidth: 1 * scaleFactorWidth)
                        .frame(width: 50 * scaleFactorWidth, height: 50 * scaleFactorWidth)

                    // Inner circle with stroke
                    Circle()
                        .fill(Color(hex: "#21204B"))
                        .frame(width: 41.67 * scaleFactorWidth, height: 41.67 * scaleFactorWidth)
                }

            case .countdown:
                ProgressViewRecording(progress: $audioRecorder.countdownProgress, scaleFactorWidth: scaleFactorWidth, scaleFactorHeight: scaleFactorHeight)

            case .recording:
                ZStack{
                    Circle()
                        .strokeBorder(Color(hex: "#B4B4B4"), lineWidth: 2 * scaleFactorWidth)
                        .frame(width: 50 * scaleFactorWidth, height: 50 * scaleFactorWidth)

                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(hex: "#4F4CB1"))
                        .frame(width: 18 * scaleFactorWidth, height: 18 * scaleFactorWidth)
                }

            case .stopped:
                ZStack{
                    Circle()
                        .strokeBorder(Color(hex: "#B4B4B4"), lineWidth: 2 * scaleFactorWidth)
                        .frame(width: 50 * scaleFactorWidth, height: 50 * scaleFactorWidth)

                    Image(systemName: "play.fill")
                        .foregroundColor(Color(hex: "#4F4CB1"))
                        .frame(width: 18 * scaleFactorWidth, height: 20 * scaleFactorWidth)
                }

            case .playing:
                ZStack{
                    Circle()
                        .strokeBorder(Color(hex: "#B4B4B4"), lineWidth: 2 * scaleFactorWidth)
                        .frame(width: 50 * scaleFactorWidth, height: 50 * scaleFactorWidth)

                    Image(systemName: "pause.fill")
                        .foregroundColor(Color(hex: "#4F4CB1"))
                        .frame(width: 18 * scaleFactorWidth, height: 20 * scaleFactorWidth)
                }
            }
        }
    }

    private func handleMainAction() {
        switch audioRecorder.state {
        case .ready:
            audioRecorder.startCountdown()
        case .countdown:
            audioRecorder.cancelCountdown()
        case .recording:
            audioRecorder.stopRecording()
        case .stopped:
            audioRecorder.playRecording()
        case .playing:
            audioRecorder.pauseRecording()
        }
    }
    
    private func submitRecording() {
        audioRecorder.saveRecording()
        
        // Close recording view with animation
        withAnimation(.easeInOut(duration: 0.4)) {
            showRecordingView = false
        }
        
        // Trigger completion handler (which shows checkmark)
        onComplete()
    }
}
