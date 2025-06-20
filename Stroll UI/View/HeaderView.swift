//
//  HeaderView.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 18/06/25.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            // Left side
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 12) {
                    Text("Your Turn")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(hex: "#F5F5F5"))
                    
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#B49AD1"))
                            .frame(width: 16, height: 16)
                        
                        Text("7")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(Color(hex: "#0E0E0E"))
                        
                    }
                }
                
                Text("Make your move, they are waiting 🎵")
                    .font(.system(size: 12))
                    .italic()
                    .foregroundColor(Color(hex: "#A8AFB7"))
            }
            
            Spacer()
            
            // TODO: Functionality Work In Progress, Replace Arc_Temp with ArcProgressView when ready
            // ArcProgressView(progress: 0.9)
            ZStack {
                // Profile picture
                Circle()
                    .fill(Color(hex: "#B5B2FF").opacity(0.25)) // #B5B2FF40 = 25% opacity
                    .frame(width: 50, height: 50)
                    .blur(radius: 20)
                    .rotationEffect(.degrees(22.95))
//                    .offset(x: -6.3, y: 10.8)

                Image("profilePic_icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
                Image("arc_temp")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35, height: 35)
                    .padding(.bottom, 10)
                
                VStack {
                    Spacer()
                    Text("90")
                        .font(.system(size: 10.8, weight: .bold))
                        .foregroundColor(Color(hex: "#E5E5E5"))
                        .padding(.horizontal, 8)
                        .background(
                            Capsule()
                                .fill(Color(hex: "#12161F"))
                                .frame(width: 42, height: 18.4)
                        )
                        .padding(.top, 43)
                }
            }
        }
        .padding(.horizontal)
    }
}
