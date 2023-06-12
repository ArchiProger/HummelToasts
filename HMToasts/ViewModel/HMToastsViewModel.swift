//
//  HMToastsViewModel.swift
//  HMToasts
//
//  Created by Артур Данилов on 09.06.2023.
//

import Foundation
import SwiftUI

public class HMToastsViewModel: ObservableObject {
    
    @Published var isCurrentToastActive = false {
        
        didSet {
            
            guard oldValue != isCurrentToastActive, currentToast != nil else { return }
            
            if isCurrentToastActive {
                
                group.enter()
                
            } else {
                
                group.leave()
            }
        }
    }
    
    @Published private(set) var currentToast: HMToastModel? = nil
    
    @Published private var toasts: [HMToastModel] = []
    
    public static let shared: HMToastsViewModel = .init()
    
    private let queue = DispatchQueue(label: "com.hummel.HMToasts.queue")
    private let group = DispatchGroup()
    
    internal var defaultAnimationSpeed: CGFloat!
    internal var defaultToastDuration: CGFloat!
    internal var defaultAnimation: Animation!
    
    private func showToast(_ toast: HMToastModel) {
                                        
        queue.async {
                        
            self.isCurrentToastActive = false
            self.group.suspend()
            self.group.enter()
            
            self.currentToast = toast
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (toast.duration ?? self.defaultToastDuration)) {
                
                self.group.leave()
            }
            
            self.group.wait()
        }
        
        queue.async {
            
            let group = DispatchGroup()
            group.enter()
            
            self.currentToast = nil
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (toast.animationSpeed ?? self.defaultAnimationSpeed)) {
                                
                group.leave()
            }
            
            group.wait()
        }
    }
}

extension HMToastsViewModel {
    
    public func showCustomToast(systemImageName: String, color: Color, title: String, body: String) {
        
        showToast(.init(systemImageName: systemImageName, color: color, title: title, body: body))
    }
}
