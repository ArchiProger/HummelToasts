//
//  HMToastsViewModel.swift
//  HMToasts
//
//  Created by Артур Данилов on 09.06.2023.
//

import Foundation
import Combine
import SwiftUI

public class HMToastsViewModel: ObservableObject {
    
    @Published var isToastActive = false
    
    @Published private(set) var activeToast: HMToastModel? = nil
    
    private var queue = DispatchQueue(label: "com.hummel.toasts")
    private var cancellable: Set<AnyCancellable> = .init()
    
    static let shared: HMToastsViewModel = .init()
    
    private func pushToast(_ toast: HMToastModel, seconds: Float = 3) {
        
        queue.async {
            
            let group = DispatchGroup()
            group.enter()
            
            Task {
                
                DispatchQueue.main.async {
                    self.activeToast = toast
                }
                
                self.$isToastActive
                    .dropFirst()
                    .removeDuplicates()
                    .eraseToAnyPublisher()
                    .receive(on: RunLoop.main)
                    .sink { active in
                        
                        if active {
                            group.enter()
                        } else {
                            group.leave()
                        }
                    }
                    .store(in: &self.cancellable)
                
                try? await Task.sleep(nanoseconds: .init(seconds * 1_000_000_000))
                
                group.leave()
            }
            
            group.wait()
        }
        
        queue.async {
            
            DispatchQueue.main.async {
                self.activeToast = nil
            }
        }
    }
}

extension HMToastsViewModel {
    
    public func showCustomToast(systemImageName: String,
                                color: Color,
                                title: String,
                                body: String,
                                seconds: Float = 3
    ) {
        
        pushToast(.init(systemImageName: systemImageName, color: color, title: title, body: body), seconds: seconds)
    }
    
    public func error(title: String,
                      body: String,
                      seconds: Float = 3
    ) {
        
        showCustomToast(systemImageName: "exclamationmark.square.fill", color: .red, title: title, body: body, seconds: seconds)
    }
    
    public func warning(title: String,
                        body: String,
                        seconds: Float = 3
    ) {
        
        showCustomToast(systemImageName: "questionmark.square.fill", color: .yellow, title: title, body: body, seconds: seconds)
    }
    
    public func notification(title: String,
                             body: String,
                             seconds: Float = 3
    ) {
        
        showCustomToast(systemImageName: "info.square.fill", color: .blue, title: title, body: body, seconds: seconds)
    }
}
