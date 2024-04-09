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
    var isUserInteractionEnabled: Bool    
    var timing: ToastTime = .medium
    var view: AnyView
}

public enum ToastTime: CGFloat {
    case short = 1.0
    case medium = 3.0
    case long = 5.0
}
