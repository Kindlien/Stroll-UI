//
//  CarouselItem.swift
//  Stroll UI
//
//  Created by William Kindlien Gunawan on 18/06/25.
//

import Foundation
import SwiftUI

struct CarouselItem: Identifiable, Equatable{
    let id = UUID()
    let title: String
    let subtitle: String
    let showActionText: Bool
    let isHidden: Bool
    let image: Image
    let madeAMove: Bool
    let madeAMoveShort: Bool
    let imageHiddenTemp: Image
    let subtitleAnswer: String
    let imageRecording: Image
    let profileImage: Image
}
