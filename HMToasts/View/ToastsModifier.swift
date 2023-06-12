//
//  SwiftUIView.swift
//  HMToasts
//
//  Created by Артур Данилов on 09.06.2023.
//

import SwiftUI

extension View {
    
    func hummelToasts(
        animation: Animation = .easeIn,
        duration: CGFloat = 4,
        animationSpeed: CGFloat = 0.5) -> some View {
            
            self
                .modifier(ToastsModifier(animation: animation, duration: duration, animationSpeed: animationSpeed))
        }
}

fileprivate struct ToastsModifier: ViewModifier {
    
    @GestureState private var scaleEffect: CGFloat = 1
    @StateObject private var toastViewModel: HMToastsViewModel = .shared
        
    init(animation: Animation, duration: CGFloat, animationSpeed: CGFloat) {
        
        toastViewModel.defaultAnimation = animation.speed(animationSpeed)
        toastViewModel.defaultToastDuration = duration
        toastViewModel.defaultAnimationSpeed = animationSpeed
    }
    
    func body(content: Content) -> some View {
        
        content
            .blur(radius: toastViewModel.isCurrentToastActive ? 10 : 0)
            .overlay(alignment: .bottom) {
                
                let condition = toastViewModel.currentToast != nil
                
                Group {
                    
                    if let toast = toastViewModel.currentToast {
                        
                        ToastView(toast: toast, isOpen: $toastViewModel.isCurrentToastActive) {
                            
                            withAnimation(.spring) {
                                
                                toastViewModel.isCurrentToastActive = false
                            }
                        }
                        .scaleEffect(scaleEffect)
                        .gesture(
                            
                            LongPressGesture(minimumDuration: 0.5)
                                .updating($scaleEffect) { currentState, gestureState, transaction in
                                    
                                    gestureState += 0.1
                                    transaction.animation = .easeIn
                                }
                                .onEnded { finished in
                                    
                                    withAnimation(.spring) {
                                        
                                        self.toastViewModel.isCurrentToastActive = finished
                                    }
                                }
                        )
                    }
                }
                .opacity(condition ? 1 : 0)
                .animation(toastViewModel.currentToast?.animation ?? toastViewModel.defaultAnimation, value: condition)
            }
    }
}


struct ToastsWrapper_preview: PreviewProvider {
    
    static var previews: some View {
        
        ZStack {
            
            Color.cyan.ignoresSafeArea()
            
            Button("Show Alert") {
                
                HMToastsViewModel.shared.showCustomToast(
                    systemImageName: "exclamationmark.square.fill",
                    color: .red,
                    title: "Сетевая ошибка",
                    body: "Не уалось подключиться к серверу...\nПопробуйте позднее"
                )
            }
        }
        .hummelToasts()
    }
}
