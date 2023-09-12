//
//  ToastView.swift
//  HMToasts
//
//  Created by Артур Данилов on 11.06.2023.
//

import SwiftUI

struct ToastView: View {
    
    let toast: HMToastModel
    
    @StateObject var toastViewModel: HMToastsViewModel = .shared
    
    var body: some View {
        
        HStack(spacing: 10) {
            
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
        }
        .padding([.vertical, .leading], 5)
        .padding(.trailing, 10)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 10)
        .overlay {
            
            RoundedRectangle(cornerRadius: 20)
                .stroke(toast.color.opacity(0.7))
        }
        .padding()
        .contextMenu(actions: [
            
            .init(title: "Copy", image: .init(systemName: "doc.on.doc")) { _ in
                UIPasteboard.general.string = toast.body
            },
            
            .init(title: "Close", image: .init(systemName: "xmark"), attributes: .destructive) { _ in
                
            }
            
        ], willEnd:  {
           
            withAnimation {
                toastViewModel.isToastActive = false
            }
            
        }, willDisplay:  {
                        
            withAnimation {
                toastViewModel.isToastActive = true
            }
        })
    }
    
}

struct ToastView_preview: PreviewProvider {
    
    static var previews: some View {
        
        ToastView(toast: .init(systemImageName: "info.square.fill", color: .indigo, title: "Did you now?", body: "Some description"))
    }
}
