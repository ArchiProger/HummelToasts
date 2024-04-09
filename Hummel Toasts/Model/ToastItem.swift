//
//  ToastItem.swift
//  Hummel Toasts
//
//  Created by Archibbald on 09.04.2024.
//

import Foundation
import SwiftUI

struct ToastItem: Identifiable {
    let id: UUID = .init()
    /// Custom Properties
    var title: String
    var symbol: String?
    var tint: Color
    var isUserInteractionEnabled: Bool
    /// Timing
    var timing: ToastTime = .medium
}

enum ToastTime: CGFloat {
    case short = 1.0
    case medium = 3.0
    case long = 5.0
}
