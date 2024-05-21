//
//  ToastsCore.swift
//  Hummel Toasts
//
//  Created by Archibbald on 09.04.2024.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func initializeToasts() -> some View {
        self
            .modifier(RootViewModifier())
    }
}

fileprivate struct RootViewModifier: ViewModifier {
    @State private var overlayWindow: UIWindow?
    
    @Environment(\.colorScheme) var scheme
    
    func body(content: Content) -> some View {
        content
            .onAppear(perform: onCreate)
            .onChange(of: scheme, perform: onSchemeChange(scheme:))
    }
    
    private func onCreate() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        guard let windowScene, overlayWindow == nil else { return }
                        
        /// View Controller
        let rootController = UIHostingController(rootView: ToastGroup())
        rootController.view.frame = windowScene.keyWindow?.frame ?? .zero
        rootController.view.backgroundColor = .clear
        
        let window = PassthroughWindow(windowScene: windowScene)
        window.backgroundColor = .clear
        window.rootViewController = rootController
        window.isHidden = false
        window.isUserInteractionEnabled = true
        window.tag = 1009
        window.overrideUserInterfaceStyle = .init(scheme)
        
        overlayWindow = window
    }
    
    private func onSchemeChange(scheme: ColorScheme?) {
        guard let overlayWindow else { return }
        
        UIView.transition(with: overlayWindow, duration: 0.3, options: .transitionCrossDissolve) {
            overlayWindow.overrideUserInterfaceStyle = .init(scheme)
        }
    }
}
