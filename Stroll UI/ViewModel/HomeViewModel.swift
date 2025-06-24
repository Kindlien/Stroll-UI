//
//  HomeViewModel.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 18/06/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var completedItemId: UUID?
    @Published var removedItems: [UUID: Bool] = [:]
    @Published var carouselItems: [CarouselItem] =
    [
        CarouselItem(
            title: "Amanda, 22",
            subtitle: "What is your most favorite childhood memory?",
            showActionText: true,
            isHidden: false,
            image: Image("amanda_profile_placeholder"),
            madeAMove: false,
            madeAMoveShort: false,
            imageHiddenTemp: Image("amanda_profile_placeholder_hidden"),
            subtitleAnswer: "\"Mine is definitely sneaking the late night snacks.\"",
            imageRecording: Image("amanda_profile_placeholder_recording"),
            profileImage: Image("amanda_profile_recording"),
            isDimText: true
        ),
        CarouselItem(
            title: "Malte, 31",
            subtitle: "What is the most important quality in friendships to you?",
            showActionText: false,
            isHidden: false,
            image: Image("malte_profile_placeholder"),
            madeAMove: false,
            madeAMoveShort: false,
            imageHiddenTemp: Image("malte_profile_placeholder_hidden"),
            subtitleAnswer: "\"For me, it's definitely trust and honesty.\"",
            imageRecording: Image("malte_profile_placeholder"),
            profileImage: Image("malte_profile_placeholder"),
            isDimText: true
        ),
        CarouselItem(
            title: "Binghan, 29",
            subtitle: "If you could choose to have one superpower, what would it be?",
            showActionText: false,
            isHidden: false,
            image: Image("binghan_profile_placeholder"),
            madeAMove: false,
            madeAMoveShort: false,
            imageHiddenTemp: Image("malte_profile_placeholder_hidden"),
            subtitleAnswer: "\"I would choose teleportation, so I can travel anywhere instantly.\"",
            imageRecording: Image("binghan_profile_placeholder"),
            profileImage: Image("binghan_profile_placeholder"),
            isDimText: false
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

    func markCompleted(itemId: UUID) {
        completedItemId = itemId
    }

    func removeItem(itemId: UUID) {
        // Mark item for removal with animation
        withAnimation(.easeInOut(duration: 0.4)) {
            removedItems[itemId] = true
        }

        // Actually remove after animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.carouselItems.removeAll { $0.id == itemId }
            self.completedItemId = nil
            self.removedItems[itemId] = nil
        }
    }
}
