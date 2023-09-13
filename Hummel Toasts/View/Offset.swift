//
//  Offset.swift
//  HMToasts
//
//  Created by Артур Данилов on 13.09.2023.
//

import Foundation
import SwiftUI

struct PreferenceSize: PreferenceKey {
        
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension View {
    
    @ViewBuilder
    func size(perform: @escaping (CGSize) -> Void) -> some View {
        
        self
            .background {
                
                GeometryReader { geometry in
                    
                    Color.clear
                        .preference(key: PreferenceSize.self, value: geometry.size)
                        .onPreferenceChange(PreferenceSize.self, perform: perform)
                }
            }
    }
}
