//
//  FooterView.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 18/06/25.
//

import SwiftUI

struct FooterView: View {
    @Binding var selectedTab: Int
    let tabs = ["Cards", "Bonfire", "Matches", "Profile"]
    let icons = ["cards_ic", "bonfire_ic", "matches_ic", "profile_ic"]

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            ZStack(alignment: .top) {
                // Shadow at the top of footer
                Rectangle()
                    .fill(Color.black.opacity(1))
                    .frame(height: 60)
                    .blur(radius: 20)
                    .offset(y: -30)

                // Footer content
                HStack(spacing: 5) {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        VStack(spacing: 4) {
                            ZStack(alignment: .topTrailing) {
                                Image(selectedTab == index ? "\(icons[index])" : icons[index])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                                    .scaleEffect(selectedTab == index ? 1.2 : 1.0)
                                    .animation(.easeInOut(duration: 0.2), value: selectedTab)

                                if tabs[index] == "Cards" {
                                    Text("10")
                                        .font(.system(size: 7))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .frame(width: 16, height: 13)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color(hex: "#B5B2FF"))
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color(hex: "#111315"), lineWidth: 1.4)
                                        )
                                        .offset(x: 8, y: -8)
                                }
                            }

                            Text(tabs[index])
                                .font(.system(size: selectedTab == index ? 12 : 10))
                                .foregroundColor(Color(hex: selectedTab == index ? "#B5B2FF" : "#5F5F60"))
                                .animation(.easeInOut(duration: 0.2), value: selectedTab)
                        }
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedTab = index
                        }
                    }
                }
                .padding(.horizontal, 5)
                .padding(.top, 3)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, minHeight: 80)
                .background(
                    Color(hex: "#0F1115")
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(hex: "#1E1E1E")),
                            alignment: .top
                        )
                )
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
