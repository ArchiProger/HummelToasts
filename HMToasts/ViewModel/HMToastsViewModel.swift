//
//  HMToastsViewModel.swift
//  HMToasts
//
//  Created by Артур Данилов on 09.06.2023.
//

import Foundation
import SwiftUI

public class HMToastsViewModel: ObservableObject {
    
    @Published private(set) var currentToast: HMToastModel? = nil
    
    @Published private var toasts: [HMToastModel] = []
    
    public static let shared: HMToastsViewModel = .init()
    
    let queue = DispatchQueue(label: "com.hummel.HMToasts.queue")
    
    private func showToast(_ toast: HMToastModel) {
                                                        
        queue.async {
            
            let group = DispatchGroup()
            
            self.currentToast = toast            
            
            group.enter()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                
                self.currentToast = nil
                
                group.leave()
            }
            
            group.wait()
        }
    }
}

extension HMToastsViewModel {
    
    public func showCustomToast() {
                        
        showToast(.init(body: "\(Int.random(in: 0...100))"))
    }
}
