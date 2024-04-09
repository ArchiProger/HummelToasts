//
//  Toast.swift
//  Hummel Toasts
//
//  Created by Archibbald on 09.04.2024.
//

import Foundation
import SwiftUI

final class Toast: ObservableObject {
    static let shared = Toast()
    
    @Published var toasts: [ToastItem] = []
    
    func present(title: String, symbol: String?, tint: Color = .primary, isUserInteractionEnabled: Bool = false, timing: ToastTime = .medium) {
        withAnimation(.snappy) {
            toasts.append(
                .init(
                    title: title,
                    symbol: symbol,
                    tint: tint,
                    isUserInteractionEnabled: isUserInteractionEnabled,
                    timing: timing
                )
            )
        }
    }
}
