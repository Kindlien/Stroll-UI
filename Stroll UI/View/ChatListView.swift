//
//  ChatListView.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 18/06/25.
//

import SwiftUI

struct ChatListView: View {
    let chats: [Chat]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(chats) { chat in
                HStack(spacing: 12) {
                    Image(chat.user.profileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(chat.user.name)
                                .font(.headline)

                            if chat.user.isNewChat {
                                Image("ChatTag_new")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 16)
                            } else if chat.user.isYourMove{
                                Image("ChatTag_yourMove")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 64, height: 16)
                            }
                        }

                        if !chat.user.isVoiceMessage {
                            Text(chat.user.lastMessage)
                                .font(.subheadline)
                                .fontWeight(chat.user.hasSeen ? .regular : .bold)
                                .foregroundColor(.white)
                                .lineLimit(1)
                        } else {
                            Image("voiceMessage_temp")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 105, height: 19)
                        }
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 4) {
                        Text(chat.user.timestamp)
                            .font(.caption)
                            .foregroundColor(chat.user.timestamp == "Wed" ? .gray : Color(hex: "#B5B2FF"))

                        if chat.user.isNewChat {
                            Image("ChatTag_favorite")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 18, height: 14)

                        } else if let count = chat.user.unreadCount {
                            Text("\(count)")
                                .font(.caption2)
                                .foregroundColor(.black)
                                .padding(5)
                                .background(Circle().fill(Color(hex: "#B5B2FF")))
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 12)

                Divider()
                    .background(Color.gray.opacity(0.3))
                    .padding(.leading, 62)
            }
            .frame(height: 37)
        }
    }
}
