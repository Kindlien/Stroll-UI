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
    let scaleFactorWidth: CGFloat
    let scaleFactorHeight: CGFloat
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            ZStack(alignment: .top) {
                // Shadow at the top of footer
                Rectangle()
                    .fill(Color.black.opacity(1))
                    .frame(height: 60 * scaleFactorWidth)
                    .blur(radius: 20)
                    .offset(y: -35 * scaleFactorWidth)

                // Footer content
                HStack(spacing: 5 * scaleFactorWidth) {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        VStack(spacing: 4 * scaleFactorWidth) {
                            ZStack(alignment: .topTrailing) {
                                Image(selectedTab == index ? "\(icons[index])" : icons[index])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: selectedTab == index ? 26 * scaleFactorWidth : 22 * scaleFactorWidth, height: selectedTab == index ? 24 * scaleFactorWidth : 22 * scaleFactorWidth)
                                    .animation(.easeInOut(duration: 0.2), value: selectedTab)
                                
                                if tabs[index] == "Cards" {
                                    Text("10")
                                        .font(.system(size: 7 * scaleFactorWidth))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .frame(width: 16 * scaleFactorWidth, height: 13 * scaleFactorWidth)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color(hex: "#B5B2FF"))
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color(hex: "#111315"), lineWidth: 1.4 * scaleFactorWidth)
                                        )
                                        .offset(x: 6 * scaleFactorWidth, y: -4 * scaleFactorWidth)
                                }
                            }
                            
                            Text(tabs[index])
                                .font(.system(size: 10 * scaleFactorWidth))
                                .fontWeight(.semibold)
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
                .padding(.horizontal, 5 * scaleFactorWidth)
                .padding(.top, 10 * scaleFactorWidth)
                .padding(.bottom, 30 * scaleFactorWidth)
                .frame(maxWidth: .infinity, minHeight: 70 * scaleFactorWidth)
                .background(
                    Color(hex: "#0F1115")
                        .overlay(
                            Rectangle()
                                .frame(height: 1 * scaleFactorWidth)
                                .foregroundColor(.black),
                            alignment: .top
                        )
                )
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
