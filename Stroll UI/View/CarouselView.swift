//
//  CarouselView.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 18/06/25.
//

import SwiftUI

struct CarouselView: View {
    @ObservedObject var viewModel: HomeViewModel
    let items: [CarouselItem]
    let scaleFactorWidth: CGFloat
    let scaleFactorHeight: CGFloat
    let animationNamespace: Namespace.ID
#if targetEnvironment(simulator)
    let isSimulator = true
#else
    let isSimulator = false
#endif
    let selectedItemId: UUID?
    let showRecordingView: Bool
    var onItemSelected: (CarouselItem) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18 * scaleFactorWidth) {
                ForEach(items) { item in
                    if viewModel.removedItems[item.id] != true {
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
                                    .frame(width: (145 * 1.05) * scaleFactorWidth, height: (205 * 1.05) * scaleFactorWidth)
                                    .clipped()
                                    .cornerRadius(20)
                            } else {
                                ZStack(alignment: .bottom) {
                                    item.image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: (145 * 1.05) * scaleFactorWidth, height: (205 * 1.05) * scaleFactorWidth)
                                        .clipped()
                                        .cornerRadius(20)
                                    //
                                    //                                // Gradient overlay
                                    //                                LinearGradient(
                                    //                                    gradient: Gradient(stops: [
                                    //                                        .init(color: Color(hex: "#0B0D0E").opacity(0.0), location: 0.0071),
                                    //                                        .init(color: Color(hex: "#0B0D0E"), location: 0.5),
                                    //                                        .init(color: Color(hex: "#0B0D0E"), location: 0.9929)
                                    //                                    ]),
                                    //                                    startPoint: .top,
                                    //                                    endPoint: .bottom
                                    //                                )
                                    //                                .cornerRadius(20)
                                    //                                .frame(width: (145 * 1.05) * scaleFactorWidth, height: (125 * 1.05) * scaleFactorWidth)
                                } .overlay(
                                    Image("gradient_overlay")
                                        .resizable()
                                        .scaledToFill()
                                )
                            }
                            
                            VStack(spacing: 23  * scaleFactorWidth) {
                                // Made a move display
                                if item.madeAMoveShort {
                                    HStack {
                                        ZStack{
                                            Circle()
                                                .fill(Color(hex: "#0B0C0D"))
                                                .frame(width: 24 * scaleFactorWidth, height: 24 * scaleFactorWidth)
                                            
                                            Text("📣")
                                                .font(.system(size: 12 * scaleFactorWidth))
                                        }
                                        .padding(.horizontal, 5 * scaleFactorWidth)
                                        
                                        Spacer()
                                    }
                                } else {
                                    Text("📣 They made a move!")
                                        .kerning(-0.3) // tighter letter spacing
                                        .font(.system(size: 9 * scaleFactorWidth, weight: .semibold))
                                        .foregroundColor(Color(hex: "#E5E5E5"))
                                        .padding(.vertical, 4 * scaleFactorWidth)
                                        .padding(.horizontal, 10 * scaleFactorWidth)
                                        .background(Color(hex: "#0B0C0D"))
                                        .cornerRadius(10)
                                        .shadow(color: Color.gray.opacity(0.6), radius: 15.3)
                                        .lineLimit(1)
                                        .frame(minWidth: 0, maxWidth: (110 * 1.1) * scaleFactorWidth, minHeight: 19 * scaleFactorWidth, maxHeight: 19 * scaleFactorWidth)
                                        .opacity(item.madeAMove ? 1 : 0)
                                }
                                
                                Spacer()
                                
                                // Action text
                                Text("Tap to answer")
                                    .font(.system(size: 10 * scaleFactorWidth))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: "#A8AFB7"))
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                                    .opacity(item.showActionText && item.isHidden ? 0.5 : 0)
                                
                                VStack(spacing: 5 * scaleFactorWidth) {
                                    Spacer()
                                    Text(item.title)
                                        .font(.system(size: 15 * scaleFactorWidth).weight(.bold))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                    
                                    Text(item.subtitle)
                                        .font(.custom("ProximaNova-reguler", size: 10 * scaleFactorWidth))
                                        .foregroundColor(Color(hex: "#CFCFFE"))
                                        .opacity(item.isHidden || item.isDimText ? 0.65 : 1)
                                        .padding(.horizontal,
                                                 scaleFactorWidth >= 1.1 ? 15 :  scaleFactorWidth > 1.0 ? 12 * scaleFactorWidth :
                                                    scaleFactorWidth == 1.0 ? (isSimulator ? 12 * scaleFactorWidth : 7 * scaleFactorWidth) :
                                                    10 * scaleFactorWidth
                                        )
                                        .cornerRadius(4)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(height: 80 * scaleFactorWidth)
                            }
                            .padding(.vertical, 50 * scaleFactorWidth)
                            .padding(.horizontal, 5 * scaleFactorWidth)
                            .frame(width: (145 * 1.05) * scaleFactorWidth, height: (205 * 1.05) * scaleFactorWidth)
                            
                            if item.id == viewModel.completedItemId {
                                ZStack {
                                    // Background Blur Circle
                                    Circle()
                                        .fill(Color(hex: "#908CE3"))
                                        .frame(width: 25 * scaleFactorWidth, height: 25 * scaleFactorWidth)
                                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4) // box-shadow
                                        .overlay(
                                            Circle()
                                                .stroke(Color.black.opacity(0.1), lineWidth: 0) // Optional inset simulation
                                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -2) // inset shadow approximation
                                        )
                                        .blur(radius: 10) // Optional slight blur for glow effect
                                    
                                    // Checkmark image
                                    Image("checkmark_ic")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30 * scaleFactorWidth, height: 30 * scaleFactorWidth)
                                }
                            }
                        }
                        .matchedGeometryEffect(id: "profile_\(item.id)", in: animationNamespace)
                        .onTapGesture {
                            let isSelectedAndRecording = showRecordingView && selectedItemId == item.id
                            let isCompleted = viewModel.completedItemId == item.id
                            let isRemoved = viewModel.removedItems[item.id] == true
                            
                            if !isSelectedAndRecording && !isCompleted && !isRemoved {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    onItemSelected(item)
                                }
                            }
                        }
                        // Add removal animations
                        .opacity(viewModel.removedItems[item.id] == true ? 0 : 1)
                        .scaleEffect(viewModel.removedItems[item.id] == true ? 0.8 : 1)
                        .animation(.easeInOut(duration: 0.4), value: viewModel.removedItems[item.id])
                    }
                }
            }
            .padding(.horizontal, 10 * scaleFactorWidth)
        }
    }
}
