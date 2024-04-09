//
//  ToastsCore.swift
//  Hummel Toasts
//
//  Created by Archibbald on 09.04.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func initializeToasts() -> some View {
        self
            .modifier(RootViewModifier())
    }
}

fileprivate struct RootViewModifier: ViewModifier {
    @State private var overlayWindow: UIWindow?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, overlayWindow == nil {
                    let window = PassthroughWindow(windowScene: windowScene)
                    window.backgroundColor = .clear
                    /// View Controller
                    let rootController = UIHostingController(rootView: ToastGroup())
                    rootController.view.frame = windowScene.keyWindow?.frame ?? .zero
                    rootController.view.backgroundColor = .clear
                    window.rootViewController = rootController
                    window.isHidden = false
                    window.isUserInteractionEnabled = true
                    window.tag = 1009
                    
                    overlayWindow = window
                }
            }
    }
}
