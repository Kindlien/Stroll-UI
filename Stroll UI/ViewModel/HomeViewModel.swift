//
//  HomeViewModel.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 18/06/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var carouselItems: [CarouselItem] = [
        CarouselItem(
            title: "Amanda, 22",
            subtitle: "What is your most favorite childhood memory?",
            showActionText: true,
            isHidden: true,
            image: Image("amanda_profile_placeholder"),
            madeAMove: false,
            madeAMoveShort: false,
            imageHiddenTemp: Image("amanda_profile_placeholder_hidden")
        ),
        CarouselItem(
            title: "Malte, 31",
            subtitle: "What is the most important quality in friendships to you?",
            showActionText: true,
            isHidden: true,
            image: Image("malte_profile_placeholder"),
            madeAMove: true,
            madeAMoveShort: false,
            imageHiddenTemp: Image("malte_profile_placeholder_hidden")
        ),
        CarouselItem(
            title: "Binghan, 29",
            subtitle: "If you could choose to have one superpower, what would it be?",
            showActionText: false,
            isHidden: false,
            image: Image("binghan_profile_placeholder"),
            madeAMove: false,
            madeAMoveShort: true,
            imageHiddenTemp: Image("malte_profile_placeholder_hidden")
        )
    ]

    @Published var chats: [Chat] = [
        Chat(user: .jessica),
        Chat(user: .amanda),
        Chat(user: .sila),
        Chat(user: .marie),
        Chat(user: .jessica2)
    ]

    @Published var selectedScreen = 2 // Default to Matches tab
    @Published var selectedTab = 0 // Default to Chats tab
    let tabs = ["Chats", "Pending"]
}
