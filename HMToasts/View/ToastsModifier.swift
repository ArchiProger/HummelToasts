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
    
    func body(content: Content) -> some View {
        
        content
            .padding()
    }
}


//struct ToastsWrapper_preview: PreviewProvider {
//    
//    static var previews: some View {
//
//        ToastsWrapper()
//    }
//}
