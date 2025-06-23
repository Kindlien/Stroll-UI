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
            HStack(spacing: 20) {
                Rectangle()
                    .fill(Color(hex: "#B0B0B0"))
                    .frame(height: 4)
                    .cornerRadius(100)
                
                Rectangle()
                    .fill(Color(hex: "#505050"))
                    .frame(height: 4)
                    .cornerRadius(100)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 5)
            .padding(.top, 10)
            // Header with back button and menu
            HStack {
                Button(action: {
                    withAnimation(.smooth()) {
                        showRecordingView = false
                    }
                }) {
                    VStack{
                        Image("back_ic")
                            .resizable()
                            .frame(width: 6, height: 11)
                    }
                    .frame(width: 44, height: 44)
                }
                
                Spacer()
                Text(item.title)
                    .font(.system(size: 18).weight(.bold))
                    .foregroundColor(Color(hex: "#FFFFFF"))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button(action: {}) {
                    VStack{
                        Image("menu_ic")
                            .resizable()
                            .frame(width:22, height: 4.4)
                    }
                    .frame(width: 44, height: 44)
                }
            }
            .padding(.horizontal, 15)
            
            Spacer()
            // Profile Info
            VStack(spacing: 8) {
                ZStack {
                    // Circle + profile image
                    ZStack {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 60, height: 60)
                        
                        item.image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    
                    // Capsule below with 10px overlap
                    VStack {
                        Capsule()
                            .fill(Color(hex: "#121518").opacity(0.9)) // #121518E5
                            .frame(width: 105, height: 20)
                            .overlay(
                                Text("Stroll question")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(Color(hex: "#F5F5F5"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                            )
                            .shadow(color: Color.black.opacity(0.3), radius: 16, y: 14)
                            .offset(y: 30) // 10px overlap from bottom of circle (60/2 + 10)
                    }
                    .frame(height: 60 + 10 + 20) // ensures enough vertical space
                }
                
                Text(item.subtitle)
                    .font(.system(size: 24).weight(.bold))
                    .foregroundColor(Color(hex: "#F5F5F5"))
                    .multilineTextAlignment(.center)
                
                Text(item.subtitleAnswer)
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "#CBC9FF"))
                    .opacity(0.7)
                    .italic()
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            
            formattedDisplayTime
                .padding(.vertical, 32) // ori 42
            
            // Waveform Display
            WaveformView(audioRecorder: audioRecorder)
                .frame(height: 21)
                .padding(.leading, 35)
                .padding(.trailing, 30)
                .padding(.bottom, 35) // ori 45
            
            VStack(spacing: 22) {
                // Control Buttons
                HStack(spacing: 40) {
                    // Delete Button
                    Button(action: audioRecorder.deleteRecording) {
                        Text("Delete")
                            .font(.system(size: 17))
                            .foregroundColor(audioRecorder.canDelete ? Color(hex: "#F5F5F5") : Color(hex: "#5C6770"))
                    }
                    .disabled(!audioRecorder.canDelete)
                    
                    
                    // Main Control Button
                    Button(action: handleMainAction) {
                        mainButtonContent
                            .frame(width: 50, height: 50)
                    }
                    
                    
                    // Submit Button
                    Button(action: submitRecording) {
                        Text("Submit")
                            .font(.system(size: 17))
                            .foregroundColor(audioRecorder.canSubmit ? Color(hex: "#F5F5F5") : Color(hex: "#5C6770"))
                    }
                    .disabled(!audioRecorder.canSubmit)
                }
                Text("Unmatch")
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "#BE2020"))
            }
            .padding(.bottom, 33)
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
    }
    
    private var formattedDisplayTime: some View {
        HStack(spacing: 0) {
            Spacer()
            if audioRecorder.state == .playing {
                Text(audioRecorder.formattedCurrentTime)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "#B5B2FF"))
                
                Text(" / \(audioRecorder.formattedDuration)")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "#AEADAF"))
            } else if audioRecorder.state == .stopped {
                Text(audioRecorder.formattedCurrentTime)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "#AEADAF"))
                
                Text(" / \(audioRecorder.formattedDuration)")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "#AEADAF"))
            } else {
                Text(audioRecorder.formattedTime)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "#AEADAF"))
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal)
    }
    
    private var mainButtonContent: some View {
        Group {
            switch audioRecorder.state {
            case .ready:
                ZStack {
                    // Background circle
                    Circle()
                        .strokeBorder(Color(hex: "#B4B4B4"), lineWidth: 1)
                        .frame(width: 50, height: 50)
                    
                    // Inner circle with stroke
                    Circle()
                        .fill(Color(hex: "#21204B"))
                        .frame(width: 41.67, height: 41.67)
                }

            case .countdown:
                ProgressViewRecording(progress: $audioRecorder.countdownProgress, scaleFactorWidth: 1.0, scaleFactorHeight: 1.0)

            case .recording:
                ZStack{
                    Circle()
                        .strokeBorder(Color(hex: "#B4B4B4"), lineWidth: 2)
                        .frame(width: 50, height: 50)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(hex: "#4F4CB1"))
                        .frame(width: 18, height: 18)
                }

            case .stopped:
                ZStack{
                    Circle()
                        .strokeBorder(Color(hex: "#B4B4B4"), lineWidth: 2)
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: "play.fill")
                        .foregroundColor(Color(hex: "#4F4CB1"))
                        .frame(width: 18, height: 20)
                }

            case .playing:
                ZStack{
                    Circle()
                        .strokeBorder(Color(hex: "#B4B4B4"), lineWidth: 2)
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: "pause.fill")
                        .foregroundColor(Color(hex: "#4F4CB1"))
                        .frame(width: 18, height: 20)
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
        withAnimation(.smooth()) {
            showRecordingView = false
        }
        
        // Trigger completion handler (which shows checkmark)
        onComplete()
    }
}
