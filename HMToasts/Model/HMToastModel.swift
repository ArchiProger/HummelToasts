//
//  HMToastModel.swift
//  HMToasts
//
//  Created by Артур Данилов on 09.06.2023.
//

import Foundation
import SwiftUI

struct HMToastModel: Identifiable, Equatable {
    
    var id: UUID = .init()
    var systemImageName: String
    var color: Color
    var title: String
    var body: String
    var duration: CGFloat? = nil
    var animation: Animation? = nil
    var animationSpeed: CGFloat? = nil
    
    enum ToastPosition {
        
        case top
        case bottom
        case center
    }
}
