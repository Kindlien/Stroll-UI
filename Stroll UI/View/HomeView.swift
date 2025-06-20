//
//  HomeView.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 18/06/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    HeaderView()
                        .padding(.top, 10)
                        .padding(.bottom, 15)

                    // Carousel
                    CarouselView(items: viewModel.carouselItems)
                        .padding(.bottom, 13)

                    VStack(alignment: .leading, spacing: 0) {
                        // Tab Selector
                        VStack(alignment: .leading) {
                            HStack(spacing: 20) {
                                ForEach(0..<viewModel.tabs.count, id: \.self) { index in
                                    Text(viewModel.tabs[index])
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundColor(viewModel.selectedTab == index ? .white : Color(hex: "#5F5F60"))
                                        .overlay(
                                            VStack {
                                                Spacer()
                                                HStack {
                                                    Rectangle()
                                                        .frame(height: 2)
                                                        .foregroundColor(viewModel.selectedTab == index ? .white : .clear)

                                                    Spacer(minLength: 5)
                                                }
                                            }
                                            .padding(.top, 25)
                                        )
                                        .onTapGesture {
                                            viewModel.selectedTab = index
                                        }
                                }
                                Spacer()
                            }
                            .padding(.bottom, 10)

                            Text("The ice is broken. Time to hit it off")
                                .font(.system(size: 12))
                                .italic()
                                .foregroundColor(Color(hex: "#A8AFB7"))
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 19)
                        .padding(.top, 20)

                        // Chat List
                        ChatListView(chats: viewModel.chats)

                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height / 2)
                    .background(Color(hex: "#08070D"))
                }
            }

            // Footer
            FooterView(selectedTab: $viewModel.selectedScreen)
        }
        .foregroundColor(.white)
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        )
    }
}
