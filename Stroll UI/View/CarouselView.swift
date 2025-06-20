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
                            //                                    .frame(width: 145 * 1.05, height: 205 * 1.05)
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
                            //                                .frame(width: 145 * 1.05, height: 205 * 1.05)
                            //                                .cornerRadius(20)
                            //                            }

                            item.imageHiddenTemp
                                .resizable()
                                .scaledToFill()
                                .frame(width: 145 * 1.05, height: 205 * 1.05)
                                .clipped()
                                .cornerRadius(20)
                        } else {
                            ZStack(alignment: .bottom) {
                                item.image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 145 * 1.05, height: 205 * 1.05)
                                    .clipped()
                                    .cornerRadius(20)

                                // Gradient overlay
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: Color(hex: "#0B0D0E").opacity(0.0), location: 0.0071),
                                        .init(color: Color(hex: "#0B0D0E"), location: 0.5),
                                        .init(color: Color(hex: "#0B0D0E"), location: 0.9929)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .cornerRadius(20)
                                .frame(width: 145 * 1.05, height: 205 * 1.05)
                            }
                        }


                        VStack {
                            // Made a move display
                            if item.madeAMove {
                                Text("📣 They made a move!")
                                    .kerning(-0.3) // tighter letter spacing
                                    .font(.system(size: 9, weight: .semibold))
                                    .foregroundColor(Color(hex: "#E5E5E5"))
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 10)
                                    .background(Color(hex: "#0B0C0D"))
                                    .cornerRadius(10)
                                    .shadow(color: Color.gray.opacity(0.6), radius: 15.3)
                                    .lineLimit(1)
                                //  .minimumScaleFactor(0.5)
                                    .frame(minWidth: 0, maxWidth: 110 * 1.1, minHeight: 19, maxHeight: 19)
                            } else if item.madeAMoveShort {
                                HStack {
                                    ZStack{
                                        Circle()
                                            .fill(Color(hex: "#0B0C0D"))
                                            .frame(width: 24, height: 24)

                                        Text("📣")
                                            .font(.system(size: 12))
                                    }
                                    .padding(.horizontal, 5)

                                    Spacer()
                                }
                            }

                            Spacer()
                            // Action text
                            if item.showActionText && item.isHidden {
                                Text("Tap to answer")
                                    .font(.system(size: 10))
                                    .fontWeight(.bold)
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
                                    .font(.custom("ProximaNova-reguler", size: 10))
                                    .foregroundColor(Color(hex: "#CFCFFE"))
                                    .opacity(0.7)
                                    .padding(.horizontal, 4)
                                    .cornerRadius(4)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 4)
                        .frame(width: 145 * 1.05, height: 205 * 1.05)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
