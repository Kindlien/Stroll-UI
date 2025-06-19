//
//  User.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 18/06/25.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    let name: String
    let age: Int?
    let lastMessage: String
    let timestamp: String
    let unreadCount: Int?
    let profileImage: String
    let isFavorite: Bool
    let isNewChat: Bool
    let isYourMove: Bool
    let isVoiceMessage: Bool
    let hasSeen: Bool
}

extension User {
    static let jessica = User(
        name: "Jessica",
        age: nil,
        lastMessage: "New chat",
        timestamp: "6:21 pm",
        unreadCount: nil,
        profileImage: "jessica_profile_temp",
        isFavorite: true,
        isNewChat: true,
        isYourMove: false,
        isVoiceMessage: true,
        hasSeen: true
    )

    static let amanda = User(
        name: "Amanda",
        age: 22,
        lastMessage: "Lol I love house music too",
        timestamp: "6:21 pm",
        unreadCount: nil,
        profileImage: "amanda_profile_temp",
        isFavorite: false,
        isNewChat: false,
        isYourMove: true,
        isVoiceMessage: false,
        hasSeen: false
    )

    static let sila = User(
        name: "Sila",
        age: nil,
        lastMessage: "You: I love the people there tbh, have you been?",
        timestamp: "Wed",
        unreadCount: nil,
        profileImage: "sila_profile_temp",
        isFavorite: false,
        isNewChat: false,
        isYourMove: false,
        isVoiceMessage: false,
        hasSeen: true
    )

    static let marie = User(
        name: "Marie",
        age: nil,
        lastMessage: "Hahaha that’s interesting, it does seem like people here are starting to like house music more",
        timestamp: "6:21 pm",
        unreadCount: 4,
        profileImage: "marie_profile_temp",
        isFavorite: false,
        isNewChat: false,
        isYourMove: true,
        isVoiceMessage: false,
        hasSeen: false
    )

    static let jessica2 = User(
        name: "Jessica",
        age: nil,
        lastMessage: "New chat",
        timestamp: "6:21 pm",
        unreadCount: nil,
        profileImage: "sila_profile_temp",
        isFavorite: false,
        isNewChat: false,
        isYourMove: true,
        isVoiceMessage: false,
        hasSeen: true
    )
}
