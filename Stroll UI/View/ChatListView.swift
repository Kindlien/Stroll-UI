//
//  ChatListView.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 18/06/25.
//

import SwiftUI

struct ChatListView: View {
    let chats: [Chat]
    let scaleFactorWidth: CGFloat
    let scaleFactorHeight: CGFloat
    var body: some View {
        VStack(spacing: 0) {
            ForEach(chats) { chat in
                HStack(spacing: 12 * scaleFactorWidth) {
                    Image(chat.user.profileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 52 * scaleFactorWidth, height: 52 * scaleFactorWidth)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 2 * scaleFactorWidth) {
                        HStack {
                            Text(chat.user.name)
                                .font(.system(size: 16 * scaleFactorWidth, weight: .bold))
                                .lineLimit(1)

                            if chat.user.isNewChat {
                                Image("ChatTag_new")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70 * scaleFactorWidth, height: 16 * scaleFactorWidth)
                            } else if chat.user.isYourMove{
                                Image("ChatTag_yourMove")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 64 * scaleFactorWidth, height: 16 * scaleFactorWidth)
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)

                        if !chat.user.isVoiceMessage {
                            Text(chat.user.lastMessage)
                                .font(.system(size: 14 * scaleFactorWidth, weight: chat.user.hasSeen ? .regular : .semibold))
                                .foregroundColor(chat.user.hasSeen ? Color(hex: "#818181") : Color(hex: "#E5E5E5"))
                                .lineLimit(2)
                        } else {
                            Image("voiceMessage_temp")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 105 * scaleFactorWidth, height: 19 * scaleFactorWidth)
                        }
                        Spacer()
                    }



                    VStack(alignment: .trailing, spacing: 4 * scaleFactorWidth) {
                        Text(chat.user.timestamp)
                            .font(.system(size: 12 * scaleFactorWidth, weight: .semibold))
                            .foregroundColor(chat.user.timestamp == "Wed" ? Color(hex: "#A8AFB7") : Color(hex: "#555390"))

                        if chat.user.isNewChat {
                            Image("ChatTag_favorite")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 18 * scaleFactorWidth, height: 14 * scaleFactorWidth)

                        } else if let count = chat.user.unreadCount {
                            Text("\(count)")
                                .font(.system(size: 10 * scaleFactorWidth, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.vertical, 5 * scaleFactorWidth)
                                .padding(.horizontal, 5 * scaleFactorWidth)
                                .background(Circle().fill(Color(hex: "#B5B2FF")))
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal, 15 * scaleFactorWidth)
                .padding(.bottom, 3 * scaleFactorWidth)
                .padding(.top, 6 * scaleFactorWidth)

                HStack {
                    Spacer(minLength: 73 * scaleFactorWidth)

                    Rectangle()
                        .fill(Color(hex: "#292B2E"))
                        .frame(height: 0.5 * scaleFactorWidth)

                    Spacer(minLength: 15 * scaleFactorWidth)
                }
            }
        }
    }
}
