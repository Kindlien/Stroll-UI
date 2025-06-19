//
//  CarouselView.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 18/06/25.
//

import SwiftUI

struct CarouselView: View {
    let items: [CarouselItem]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(items) { item in
                    ZStack {
                        if item.isHidden {
                            // TODO: Implement the blur functionality, replace temp hidden image with this functionality when done, WIP 90%
//                            ZStack {
//                                item.image
//                                    .resizable()
//                                    .scaledToFill()
//                                    .frame(width: 145, height: 205)
//                                    .clipped()
//                                    .blur(radius: 20)
//                                    .cornerRadius(20)
//
//
//                                // Bottom gradient overlay (approx. 40% height)
//                                VStack {
//                                    Spacer()
//                                    LinearGradient(
//                                                gradient: Gradient(colors: [
//                                                    Color.black.opacity(0.6),
//                                                    Color.black.opacity(0.0)
//                                                ]),
//                                                startPoint: .bottom,
//                                                endPoint: .top
//                                            )
//                                }
//                                .frame(width: 145, height: 205)
//                                .cornerRadius(20)
//                            }

                            item.imageHiddenTemp
                                .resizable()
                                .scaledToFill()
                                .frame(width: 145, height: 205)
                                .clipped()
                                .cornerRadius(20)
                        } else {
                            item.image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 145, height: 205)
                                .clipped()
                                .cornerRadius(20)
                        }


                        VStack {
                            // Made a move display
                            if item.madeAMove {
                                Text("📣 They made a move!")
                                    .font(.system(size: 9, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 10)
                                    .background(Color(hex: "#0B0C0D"))
                                    .cornerRadius(10)
                                    .shadow(color: Color.gray.opacity(0.6), radius: 15.3)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                    .frame(minWidth: 0, maxWidth: 110, minHeight: 19, maxHeight: 19)
                            } else if item.madeAMoveShort {
                                HStack {
                                    Text("📣")
                                        .font(.system(size: 9, weight: .semibold))
                                        .frame(width: 20, height: 20)
                                        .background(Color(hex: "#0B0C0D"))
                                        .cornerRadius(20)
                                    Spacer()
                                }
                            }
                            Spacer()
                            // Action text
                            if item.showActionText && item.isHidden {
                                Text("Tap to answer")
                                    .font(.custom("ProximaNova-bold", size: 10).weight(.bold))
                                    .foregroundColor(Color(hex: "#A8AFB7"))
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                                    .opacity(0.5)
                            }

                            Spacer()

                            VStack(spacing: 4) {
                                Text(item.title)
                                    .font(.system(size: 15).weight(.bold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)

                                Text(item.subtitle)
                                    .font(.custom("ProximaNova-bold", size: 10))
                                    .foregroundColor(Color(hex: "#B5B2FF"))
                                    .padding(.horizontal, 4)
                                    .cornerRadius(4)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding()
                        .frame(width: 145, height: 205)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
