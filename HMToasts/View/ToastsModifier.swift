//
//  SwiftUIView.swift
//  HMToasts
//
//  Created by Артур Данилов on 09.06.2023.
//

import SwiftUI

extension View {
    
    func hummelToasts() -> some View {
        
        self
            .modifier(ToastsModifier())
    }
}

fileprivate struct ToastsModifier: ViewModifier {
    
    @StateObject private var toastViewModel: HMToastsViewModel = .shared        
    
    func body(content: Content) -> some View {
        
        content
            .overlay(alignment: .bottom) {
                
                let condition = toastViewModel.currentToast != nil
                
                Text(toastViewModel.currentToast?.body ?? "")
                    .foregroundStyle(.bar)
                    .frame(maxWidth: .infinity)
                    .background {
                        
                        Color.black
                            .cornerRadius(20)
                    }
                    .padding()
                    .opacity(condition ? 1 : 0)
                    .animation(.easeInOut(duration: 0.5), value: condition)
            }
    }
}


struct ToastsWrapper_preview: PreviewProvider {
    
    static var previews: some View {

        ZStack {
            
            Color.cyan.ignoresSafeArea()
            
            Button("Show Alert") {
                
                HMToastsViewModel.shared.showCustomToast()
            }
        }
        .hummelToasts()
    }
}
