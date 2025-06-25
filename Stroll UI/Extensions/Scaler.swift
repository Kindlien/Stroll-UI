//
//  Scaler.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 25/06/25.
//

import SwiftUI

struct Scaler {
    // Hardcode the design reference size (e.g., iPhone 14: 390x844)
    static let baseDesignSize = CGSize(width: 390, height: 844)

    static func scale(for geometry: GeometryProxy) -> (width: CGFloat, height: CGFloat) {
        return (
            width: geometry.size.width / baseDesignSize.width,
            height: geometry.size.height / baseDesignSize.height
        )
    }
}
