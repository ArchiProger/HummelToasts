//
//  ToastWrapper.swift
//  Hummel Toasts
//
//  Created by Archibbald on 09.04.2024.
//

import SwiftUI

struct ToastWrapper: View {
    var item: ToastItem
    /// View Properties
    @State private var delayTask: DispatchWorkItem?
    @State private var size: CGSize = .zero
    
    var body: some View {
        item.view
            .size { size in
                self.size = size
            }
            .gesture(
                DragGesture(minimumDistance: 20)
                    .onEnded { value in
                        guard item.isUserInteractionEnabled else { return }
                        let endY = value.translation.height
                        let velocityY = value.velocity.height
                        
                        if (endY + velocityY) < 100 {
                            /// Removing Toast
                            removeToast()
                        }
                    }
            )
            .onAppear {
                guard delayTask == nil else { return }
                
                delayTask = .init {
                    removeToast()
                }
                
                if let delayTask {
                    DispatchQueue.main.asyncAfter(deadline: .now() + item.timing.rawValue, execute: delayTask)
                }
            }                    
            .transition(.offset(y: -100 - size.height))
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
