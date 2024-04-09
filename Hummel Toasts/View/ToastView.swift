//
//  ToastView.swift
//  Hummel Toasts
//
//  Created by Archibbald on 09.04.2024.
//

import SwiftUI

struct ToastView: View {
    var item: ToastItem
    /// View Properties
    @State private var delayTask: DispatchWorkItem?
    
    var body: some View {
        HStack(spacing: 0) {
            if let symbol = item.symbol {
                Image(systemName: symbol)
                    .font(.title3)
                    .padding(.trailing, 10)
            }
            
            Text(item.title)
                .lineLimit(1)
        }
        .foregroundStyle(item.tint)
        .padding(.horizontal, 15)
        .padding(.vertical, 8)        
        .contentShape(.capsule)
        .gesture(
            DragGesture(minimumDistance: 20)
                .onEnded({ value in
                    guard item.isUserInteractionEnabled else { return }
                    let endY = value.translation.height
                    let velocityY = value.velocity.height
                    
                    if (endY + velocityY) < 100 {
                        /// Removing Toast
                        removeToast()
                    }
                })
        )
        .onAppear {
            guard delayTask == nil else { return }
            delayTask = .init(block: {
                removeToast()
            })
            
            if let delayTask {
                DispatchQueue.main.asyncAfter(deadline: .now() + item.timing.rawValue, execute: delayTask)
            }
        }
        /// Limiting Size
        .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
        .transition(.offset(y: -100))
    }
    
    func removeToast() {
        if let delayTask {
            delayTask.cancel()
        }
        
        withAnimation(.snappy) {
            Toast.shared.toasts.removeAll(where: { $0.id == item.id })
        }
    }
}
