//
//  ProgressViewRecording.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 23/06/25.
//

import SwiftUI

struct ProgressViewRecording: View {
    @Binding var progress: Double
    let scaleFactorWidth: CGFloat
    let scaleFactorHeight: CGFloat
    
    var body: some View {
        ZStack {
            // Background circle (base color)
            Circle()
                .strokeBorder(Color(hex: "#7B7B7B"), lineWidth: progress == 0 ? 2 : 1.4)
                .frame(width: 50, height: 50)
            
            RoundedRectangle(cornerRadius: 2)
                .fill(Color(hex: "#7B7B7B"))
                .frame(width: 18, height: 18)
            
            // Full Angular Gradient stroke
            Circle()
                .trim(from: 0, to: progress) // Animate `progress` (0.0 to 1.0)
                .rotation(.degrees(-90)) // Start from top (12 o'clock)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color(hex: "#21204B"), location: 0.0),
                            .init(color: Color(hex: "#4F4CB1"), location: 0.5),  // ~1/3 of 95%
                            .init(color: Color(hex: "#CFCFFE"), location: 1.0)  // ~2/3 of 95%
                        ]),
                        center: .center,
                        startAngle: .degrees(-90), // Start from top
                        endAngle: .degrees(-90 + 360 * progress) // Match arc length
                    ),
                    style: StrokeStyle(lineWidth: 3, lineCap: .round)
                )
                .shadow(color: Color.white.opacity(0.5), radius: 1) // subtle glow
                .animation(.linear(duration: 0.1), value: progress)
                .frame(width: 50, height: 50)
        }
        .frame(width: 50, height: 50)
        
    }
}
