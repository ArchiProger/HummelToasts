//
//  Toast.swift
//  Hummel Toasts
//
//  Created by Archibbald on 09.04.2024.
//

import Foundation
import SwiftUI

public final class Toast: ObservableObject {
    public static let shared = Toast()
    
    @Published var toasts: [ToastItem] = []
    
    public func present(
        title: String,
        symbol: String?,
        tint: Color = .primary,
        isUserInteractionEnabled: Bool = false,
        timing: ToastTime = .medium
    ) {
        withAnimation(.snappy) {     
            let view = ToastView(title: title, symbol: symbol, tint: tint)
            let item = ToastItem(isUserInteractionEnabled: isUserInteractionEnabled, timing: timing, view: .init(view))
            
            toasts.append(item)
        }
    }
    
    public func present(
        isUserInteractionEnabled: Bool = false,
        timing: ToastTime = .medium,
        @ViewBuilder content: () -> some View
    ) {
        withAnimation(.snappy) {
            let item = ToastItem(isUserInteractionEnabled: isUserInteractionEnabled, timing: timing, view: .init(content()))
            
            toasts.append(item)
        }
    }
}
