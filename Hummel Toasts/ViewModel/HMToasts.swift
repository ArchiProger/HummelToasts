//
//  HMToastsViewModel.swift
//  HMToasts
//
//  Created by Артур Данилов on 09.06.2023.
//

import Foundation
import Combine
import SwiftUI
import OSLog

public class HMToasts: ObservableObject {
    
    public static let shared: HMToasts = .init()
    
    @Published var isToastActive = false
    
    @Published private(set) var activeToast: HMToastModel? = nil
    
    private var queue = DispatchQueue(label: "com.hummel.toasts")
    private var cancellable: Set<AnyCancellable> = .init()
    
    private func pushToast(_ toast: HMToastModel, seconds: Double = 3, onDelivered: (() -> Void)? = nil) {
        
        queue.async {
            
            let group = DispatchGroup()
            group.enter()
            
            Task {
                
                DispatchQueue.main.async {
                    self.activeToast = toast
                }
                
                onDelivered?()
                
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

extension HMToasts {
    
    public enum NotificationStyle {
        
        case info
        case warning
        case error
        case success
        
        func generateToast(title: String, body: String) -> HMToastModel {
            
            switch self {
                case .info: 
                    return .init(image: .init(systemName: "info.square.fill"),
                                 color: .blue,
                                 title: title,
                                 body: body)
                case .warning:
                    return .init(image: .init(systemName: "questionmark.square.fill"),
                                 color: .yellow,
                                 title: title,
                                 body: body)
                case .error:
                    return .init(image: .init(systemName: "exclamationmark.square.fill"),
                                 color: .red,
                                 title: title,
                                 body: body)
                    
                case .success:
                    return .init(image: .init(systemName: "checkmark.circle.fill"),
                                 color: .green,
                                 title: title,
                                 body: body)
            }
        }
    }
    
    public func notification(title: String,
                             body: String,
                             style: NotificationStyle,
                             seconds: Double = 3,
                             feedback: Bool = true,
                             onDelivered: (() -> Void)? = nil
    ) {
        
        let toast = style.generateToast(title: title, body: body)
        
        pushToast(toast, seconds: seconds) {
            
            onDelivered?()
            
            if feedback {
                
                let feedback = UINotificationFeedbackGenerator()
                
                switch style {
                    case .warning: feedback.notificationOccurred(.warning)
                    case .error: feedback.notificationOccurred(.error)
                    default: feedback.notificationOccurred(.success)
                }
            }
        }
    }
    
    public func notification(title: String,
                             body: String,
                             image: String,
                             color: Color,
                             seconds: Double = 3,
                             onDelivered: (() -> Void)? = nil
    ) {
        
        let toast: HMToastModel = .init(image: .init(image), color: color, title: title, body: body)
        
        pushToast(toast, seconds: seconds, onDelivered: onDelivered)
    }
    
    public func notification(title: String,
                             body: String,
                             systemImage: String,
                             color: Color,
                             seconds: Double = 3,
                             onDelivered: (() -> Void)? = nil
    ) {
        
        let toast: HMToastModel = .init(image: .init(systemName: systemImage), color: color, title: title, body: body)
        
        pushToast(toast, seconds: seconds, onDelivered: onDelivered)
    }
}
