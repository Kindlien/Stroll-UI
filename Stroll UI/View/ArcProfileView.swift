//
//  ArcProfileView.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 19/06/25.
//

import SwiftUI

struct ArcProgressView: View {
    let progress: Double // 0.0 to 1.0, e.g., 0.9 for 90%

    var body: some View {
        VStack(spacing: 2) {
            ZStack {
                // Background arc
                ArcShape(startAngle: .degrees(225), endAngle: .degrees(315), clockwise: false)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color(hex: "#363636"), location: 0.0),
                                .init(color: .clear, location: 0.15),
                                .init(color: Color(hex: "#363636"), location: 0.35),
                                .init(color: Color(hex: "#363636"), location: 0.97),
                                .init(color: .clear, location: 1.0),
                            ]),
                            center: .center,
                            startAngle: .degrees(180),
                            endAngle: .degrees(450)
                        ),
                        style: StrokeStyle(lineWidth: 3, lineCap: .round)
                    )
                    .frame(width: 44.374, height: 44.374)

                // Foreground arc (progress)
                ArcShape(
                    startAngle: .degrees(225),
                    endAngle: .degrees(225 - 180 * progress),
                    clockwise: true
                )
                .stroke(
                    AngularGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color(hex: "#36631A"), location: 0.0),
                            .init(color: Color(hex: "#4C8D25"), location: 0.1),
                            .init(color: .clear, location: 0.7),
                            .init(color: Color(hex: "#36631A"), location: 0.77),
                            .init(color: Color(hex: "#4C8D25"), location: 1.0),
                        ]),
                        center: .center,
                        startAngle: .degrees(-0.77),
                        endAngle: .degrees(360)
                    ),
                    style: StrokeStyle(lineWidth: 3, lineCap: .round)
                )
                .frame(width: 44.374, height: 44.374)

                // Indicator
                GeometryReader { geo in
                    let size = geo.size
                    let radius = size.width / 2
                    let angle = 135 - 270 * progress
                    let rad = angle * .pi / 180

                    Rectangle()
                        .fill(Color(hex: "#B5B2FF"))
                        .frame(width: 8, height: 1)
                        .rotationEffect(.degrees(-angle))
                        .position(
                            x: size.width / 2 + radius * CGFloat(cos(rad)),
                            y: size.height / 2 - radius * CGFloat(sin(rad))
                        )
                }
                .frame(width: 44.374, height: 44.374)

                // Center profile image
                Image("profilePic_icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
            }

            // Label
            Text("\(Int(progress * 100))")
                .font(.system(size: 10))
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background(
                    Capsule()
                        .fill(Color(hex: "#12161F"))
                        .frame(width: 42, height: 18.4)
                )
        }
    }
}
