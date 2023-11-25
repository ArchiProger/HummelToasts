//
//  ToastView.swift
//  HMToasts
//
//  Created by Артур Данилов on 11.06.2023.
//

import SwiftUI

struct ToastView: View {
    
    let toast: HMToastModel
    
    @StateObject var toastViewModel: HMToasts = .shared
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            toast.image
                .renderingMode(.template)
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
        }
        .padding([.vertical, .leading], 5)
        .padding(.trailing, 10)
        .background(.background)
        .shadow(radius: 10)
        .overlay {
            
            RoundedRectangle(cornerRadius: 20)
                .stroke(toast.color.opacity(0.7))
        }
        .contextMenu([
            .init(title: "Copy", image: .init(systemName: "doc.on.doc")) { _ in
                UIPasteboard.general.string = toast.body
            },
            
            .init(title: "Close", image: .init(systemName: "xmark.circle"), attributes: .destructive) { _ in
                
            }
        ]) {
            withAnimation {
                toastViewModel.isToastActive = true
            }
        } onDismiss: {
            withAnimation {
                toastViewModel.isToastActive = false
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct ToastView_preview: PreviewProvider {
    
    static var previews: some View {
        
        ZStack {
            
            Color.gray.ignoresSafeArea()
            
            ToastView(toast: HMToasts.NotificationStyle.info.generateToast(title: "Error", body: "Notification Body"))
        }
    }
}
