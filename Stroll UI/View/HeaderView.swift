//
//  HeaderView.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 18/06/25.
//

import SwiftUI

struct HeaderView: View {
    let scaleFactorWidth: CGFloat
    let scaleFactorHeight: CGFloat
    var body: some View {
        HStack {
            // Left side
            VStack(alignment: .leading, spacing: 4 * scaleFactorWidth) {
                HStack(spacing: 12 * scaleFactorWidth) {
                    Text("Your Turn")
                        .font(.system(size: 22 * scaleFactorWidth, weight: .bold))
                        .foregroundColor(Color(hex: "#F5F5F5"))
                    
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#B49AD1"))
                            .frame(width: 16 * scaleFactorWidth, height: 16 * scaleFactorWidth)

                        Text("7")
                            .font(.system(size: 10 * scaleFactorWidth, weight: .bold))
                            .foregroundColor(Color(hex: "#0E0E0E"))
                        
                    }
                }
                
                Text("Make your move, they are waiting 🎵")
                    .font(.system(size: 12 * scaleFactorWidth))
                    .italic()
                    .foregroundColor(Color(hex: "#A8AFB7"))
            }
            
            Spacer()
            
            // TODO: Functionality Work In Progress, Replace Arc_Temp with ArcProgressView when ready
            // ArcProfileView(progress: 0.9)
            ZStack {
                // Profile picture
                Circle()
                    .fill(Color(hex: "#B5B2FF").opacity(0.25)) // #B5B2FF40 = 25% opacity
                    .frame(width: 50 * scaleFactorWidth, height: 50 * scaleFactorWidth)
                    .blur(radius: 20)
                    .rotationEffect(.degrees(22.95))

                Image("profilePic_icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35 * scaleFactorWidth, height: 35 * scaleFactorWidth)
                    .clipShape(Circle())
                
                Image("arc_temp")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35 * scaleFactorWidth, height: 35 * scaleFactorWidth)
                    .padding(.bottom, 10 * scaleFactorWidth)

                VStack {
                    Spacer()
                    Text("90")
                        .font(.system(size: 10.8 * scaleFactorWidth, weight: .bold))
                        .foregroundColor(Color(hex: "#E5E5E5"))
                        .padding(.horizontal, 8 * scaleFactorWidth)
                        .background(
                            Capsule()
                                .fill(Color(hex: "#12161F"))
                                .frame(width: 42 * scaleFactorWidth, height: 18.4 * scaleFactorWidth)
                        )
                        .padding(.top, 43 * scaleFactorWidth)
                }
            }
        }
        .padding(.horizontal, 10 * scaleFactorWidth)
    }
}
