//
//  ToastView.swift
//  Hummel Toasts
//
//  Created by Archibbald on 09.04.2024.
//

import SwiftUI

struct ToastView: View {
    var title: String
    var symbol: String?
    var tint: Color
    
    var body: some View {
        HStack {
            if let symbol {
                Image(systemName: symbol)
                    .font(.title3)
                    .padding(.trailing, 10)
            }
            
            Text(title)
                .lineLimit(1)
        }
        .foregroundStyle(tint)
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
        .background(.background)
        .clipShape(.capsule)
        .shadow(radius: 10)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
    }
}
