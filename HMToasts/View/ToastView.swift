//
//  ToastView.swift
//  HMToasts
//
//  Created by Артур Данилов on 11.06.2023.
//

import SwiftUI

struct ToastView: View {
    
    let toast: HMToastModel
    
    @Binding var isOpen: Bool
    let onCloseButtonPress: () -> Void
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            if isOpen {
                
                Image(systemName: toast.systemImageName)
                    .foregroundStyle(toast.color)
                    .padding(10)
                    .background(toast.color.opacity(0.3))
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    
                    Text(toast.title)
                        .foregroundStyle(Color.primary)
                        .font(.caption.weight(.bold))
                    
                    Text(toast.body)
                        .foregroundStyle(toast.color)
                        .font(.caption2.weight(.bold))
                }
                .frame(maxWidth: isOpen ? .infinity : nil, alignment: .leading)
                
                Button(action: onCloseButtonPress) {
                    
                    Image(systemName: "xmark")
                        .padding(.horizontal)
                        .foregroundStyle(Color.gray)
                }
                
            } else {
                
                Image(systemName: toast.systemImageName)
                    .foregroundStyle(toast.color)
                    .padding(10)
                    .background(toast.color.opacity(0.3))
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    
                    Text(toast.title)
                        .foregroundStyle(Color.primary)
                        .font(.caption.weight(.bold))
                    
                    Text(toast.body)
                        .foregroundStyle(toast.color)
                        .font(.caption2.weight(.bold))
                }
                
                if isOpen {
                    
                    Button(action: onCloseButtonPress) {
                        
                        Image(systemName: "xmark")
                            .padding(.horizontal)
                            .foregroundStyle(Color.gray)
                    }
                }
            }
        }
        .padding(5)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 10)
        .overlay {
            
            RoundedRectangle(cornerRadius: 20)
                .stroke(toast.color.opacity(0.7))
        }
        .padding()
    }
    
}

struct ToastView_preview: PreviewProvider {
    
    static var previews: some View {
        
        ToastView(toast: .init(systemImageName: "info.square.fill", color: .indigo, title: "Did you now?", body: "Some description"), isOpen: .constant(false), onCloseButtonPress: {})
    }
}
