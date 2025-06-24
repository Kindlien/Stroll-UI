//
//  SegmentedTabBar.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 24/06/25.
//

import SwiftUI

struct SegmentedTabBar: View {
    @Binding var selectedIndex: Int
    let scaleFactorWidth: CGFloat
    let scaleFactorHeight: CGFloat

    var body: some View {
        HStack(spacing: 20 * scaleFactorWidth) {
            ForEach(0..<2) { index in
                Rectangle()
                    .fill(selectedIndex == index ? Color(hex: "#B0B0B0") : Color(hex: "#505050"))
                    .frame(height: 4 * scaleFactorWidth)
                    .cornerRadius(100)
                    .onTapGesture {
                        withAnimation {
                            selectedIndex = index
                        }
                    }
            }
        }
        .padding(.horizontal, 20 * scaleFactorWidth)
        .padding(.bottom, 5 * scaleFactorWidth)
        .padding(.top, 10 * scaleFactorWidth)
    }
}
