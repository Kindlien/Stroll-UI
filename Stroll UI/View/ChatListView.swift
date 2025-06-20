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
                        .frame(width: 52, height: 52)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Text(chat.user.name)
                                .font(.system(size: 16, weight: .bold))
                                .lineLimit(1)

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
                        }.frame(maxWidth: .infinity, alignment: .leading)

                        if !chat.user.isVoiceMessage {
                            Text(chat.user.lastMessage)
                                .font(.system(size: 14, weight: chat.user.hasSeen ? .regular : .semibold))
                                .foregroundColor(chat.user.hasSeen ? Color(hex: "#818181") : Color(hex: "#E5E5E5"))
                                .lineLimit(2)
                        } else {
                            Image("voiceMessage_temp")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 105, height: 19)
                        }
                        Spacer()
                    }



                    VStack(alignment: .trailing, spacing: 4) {
                        Text(chat.user.timestamp)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(chat.user.timestamp == "Wed" ? Color(hex: "#A8AFB7") : Color(hex: "#555390"))

                        if chat.user.isNewChat {
                            Image("ChatTag_favorite")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 18, height: 14)

                        } else if let count = chat.user.unreadCount {
                            Text("\(count)")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.black)
                                .padding(5)
                                .background(Circle().fill(Color(hex: "#B5B2FF")))
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 3)
                .padding(.top, 6)

                Divider()
                    .background(Color.gray.opacity(0.3))
                    .padding(.leading, 62)
            }
        }
    }
}
