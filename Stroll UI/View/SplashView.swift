//
//  SplashView.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 24/06/25.
//

import Foundation
import SwiftUI

struct SplashView: View {
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 20) {
            Image("AppIconImage")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(20)
                .scaleEffect(isAnimating ? 1 : 0.5)  // Animate the scale
                .animation(.easeOut(duration: 1.0), value: isAnimating)
                .onAppear {
                    isAnimating = true
                }

            Text("Stroll")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .opacity(1)  // Fade in animation
                .animation(.easeIn(duration: 1.0).delay(0.5), value: isAnimating)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.8))
    }
}
