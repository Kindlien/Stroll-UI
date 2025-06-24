//
//  HomeView.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 18/06/25.
//

import SwiftUI

struct HomeView: View {
    @Namespace private var animationNamespace
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedCarouselItem: CarouselItem?
    @State private var showRecordingView = false
    @State private var showSplash: Bool = true
    var body: some View {
        if showSplash {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.showSplash = false
                    }
                }
        } else {
            GeometryReader { geometry in
                let scaleFactorWidth = geometry.size.width / 390 // iphone 14 base
                let scaleFactorHeight = geometry.size.height / 844 // iphone 14 base
                
                ZStack {
                    if let item = selectedCarouselItem, showRecordingView {
                        RecordingView(
                            showRecordingView: $showRecordingView,
                            item: item,
                            onComplete: {
                                viewModel.markCompleted(itemId: item.id)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    viewModel.removeItem(itemId: item.id)
                                }
                            },
                            scaleFactorWidth: scaleFactorWidth,
                            scaleFactorHeight: scaleFactorHeight, animationNamespace: animationNamespace
                        )
                        .zIndex(2)
                        
                    } else {
                        ZStack(alignment: .bottom) {
                            ScrollView {
                                VStack(alignment: .leading, spacing: 0) {
                                    // Header
                                    HeaderView(scaleFactorWidth: scaleFactorWidth, scaleFactorHeight: scaleFactorHeight)
                                        .padding(.top, 10 * scaleFactorWidth)
                                        .padding(.bottom, 15 * scaleFactorWidth)
                                    
                                    // Carousel
                                    CarouselView(
                                        viewModel: viewModel,
                                        items: viewModel.carouselItems,
                                        scaleFactorWidth: scaleFactorWidth,
                                        scaleFactorHeight: scaleFactorHeight,
                                        animationNamespace: animationNamespace,
                                        selectedItemId: selectedCarouselItem?.id,
                                        showRecordingView: showRecordingView,
                                        onItemSelected: { item in
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                selectedCarouselItem = item
                                                showRecordingView = true
                                            }
                                        }
                                    )
                                    .padding(.bottom, 13 * scaleFactorWidth)
                                    
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        // Tab Selector
                                        VStack(alignment: .leading) {
                                            HStack(spacing: 20 * scaleFactorWidth) {
                                                ForEach(0..<viewModel.tabs.count, id: \.self) { index in
                                                    Text(viewModel.tabs[index])
                                                        .font(.system(size: 22 * scaleFactorWidth, weight: .bold))
                                                        .foregroundColor(viewModel.selectedTab == index ? .white : Color(hex: "#5F5F60"))
                                                        .overlay(
                                                            VStack {
                                                                Spacer()
                                                                HStack {
                                                                    Rectangle()
                                                                        .frame(height: 2 * scaleFactorWidth)
                                                                        .foregroundColor(viewModel.selectedTab == index ? .white : .clear)
                                                                    
                                                                    Spacer(minLength: 5 * scaleFactorWidth)
                                                                }
                                                            }
                                                                .padding(.top, 25 * scaleFactorWidth)
                                                        )
                                                        .onTapGesture {
                                                            viewModel.selectedTab = index
                                                        }
                                                }
                                                Spacer()
                                            }
                                            .padding(.bottom, 10 * scaleFactorWidth)
                                            
                                            Text("The ice is broken. Time to hit it off")
                                                .font(.system(size: 12 * scaleFactorWidth))
                                                .italic()
                                                .foregroundColor(Color(hex: "#A8AFB7"))
                                        }
                                        .padding(.horizontal)
                                        .padding(.bottom, 19 * scaleFactorWidth)
                                        .padding(.top, 20 * scaleFactorWidth)
                                        
                                        // Chat List
                                        ChatListView(chats: viewModel.chats, scaleFactorWidth: scaleFactorWidth, scaleFactorHeight: scaleFactorHeight)
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height / 2)
                                    .background(Color(hex: "#08070D"))
                                }
                            }
                            
                            // Footer
                            FooterView(selectedTab: $viewModel.selectedScreen, scaleFactorWidth: scaleFactorWidth, scaleFactorHeight: scaleFactorHeight)
                        }
                        .foregroundColor(.white)
                        .background(
                            Image("background")
                                .resizable()
                                .scaledToFill()
                                .ignoresSafeArea(.all)
                        )
                        .zIndex(1)
                    }
                }
            }
        }
    }
}
