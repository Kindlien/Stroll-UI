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
                HStack(spacing: 8) {
                    Text("Your Turn")
                        .font(.system(size: 22, weight: .bold))

                    ZStack {
                        Circle()
                            .fill(Color(hex: "#B5B2FF"))
                            .frame(width: 20, height: 20)
                        Text("7")
                            .font(.system(size: 8))
                            .foregroundColor(.black)
                    }
                }

                Text("Make your move, they are waiting 🎵")
                    .font(.system(size: 12))
                    .italic()
                    .foregroundColor(.gray)
            }

            Spacer()

            // TODO: Functionality Work In Progress, Replace Arc_Temp with ArcProgressView when ready
            // ArcProgressView(progress: 0.9)
            ZStack {
                // Profile picture
                Image("blur_profile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)

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
                    .font(.system(size: 10))
                    .foregroundColor(.white)
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
