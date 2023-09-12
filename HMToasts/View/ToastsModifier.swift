//
//  SwiftUIView.swift
//  HMToasts
//
//  Created by Артур Данилов on 09.06.2023.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    public func configureHummelToasts() -> some View {
        
        self
            .modifier(ToastsModifier())
    }
}

struct ToastsModifier: ViewModifier {
    
    @StateObject private var toastViewModel: HMToastsViewModel = .shared
    
    func body(content: Content) -> some View {
        
        ZStack {
            
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            
            Group {
                
                if let toast = toastViewModel.activeToast {
                    
                    ToastView(toast: toast)
                        .transition(.scale)
                }
            }
            .animation(.default, value: toastViewModel.activeToast)
        }
    }
}


struct ToastsWrapper_preview: PreviewProvider {
    
    static var previews: some View {
        
        ZStack {
            
//            Color.cyan.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Image(systemName: "globe")
                
                Button("Show Notification") {                                        
                    
                    HMToastsViewModel.shared.notification(title: "Notification \(Int.random(in: 0...255))", body: "Some notification")
                }
            }
        }
        .configureHummelToasts()
    }
}
