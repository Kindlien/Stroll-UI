//
//  CarouselItem.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 18/06/25.
//

import Foundation
import SwiftUI

struct CarouselItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let showActionText: Bool
    let isHidden: Bool
    let image: Image
    let madeAMove: Bool
    let madeAMoveShort: Bool
    let imageHiddenTemp: Image
}
