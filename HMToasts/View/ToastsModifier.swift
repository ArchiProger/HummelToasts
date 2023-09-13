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

fileprivate struct ToastsModifier: ViewModifier {
    
    @StateObject private var toastViewModel: HMToasts = .shared
    
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
    
    @State static var counter = 0
    
    static var previews: some View {
        
        VStack(spacing: 20) {
            
            Image(systemName: "globe")
            
            Button("Show Notification \(counter)") {
                
                counter += 1
                
                HMToasts.shared.showCustomToast(systemImageName: "globe", color: .green, title: "Titile", body: "BodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBody")
            }
        }
        .configureHummelToasts()
    }
}
