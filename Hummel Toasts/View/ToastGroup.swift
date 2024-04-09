//
//  ToastGroup.swift
//  Hummel Toasts
//
//  Created by Archibbald on 09.04.2024.
//

import SwiftUI

struct ToastGroup: View {
    @StateObject var model = Toast.shared
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            
            ZStack {
                ForEach(model.toasts) { toast in
                    ToastView(item: toast)
                        .scaleEffect(scale(toast))
                        .offset(y: offsetY(toast))
                        .zIndex(Double(model.toasts.firstIndex(where: { $0.id == toast.id }) ?? 0))
                }
            }
            .padding(.top, safeArea.bottom == .zero ? 15 : 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
    
    func offsetY(_ item: ToastItem) -> CGFloat {
        let index = CGFloat(model.toasts.firstIndex(where: { $0.id == item.id }) ?? 0)
        let totalCount = CGFloat(model.toasts.count) - 1
        
        return (totalCount - index) >= 2 ? -20 : ((totalCount - index) * -10)
    }
    
    func scale(_ item: ToastItem) -> CGFloat {
        let index = CGFloat(model.toasts.firstIndex(where: { $0.id == item.id }) ?? 0)
        let totalCount = CGFloat(model.toasts.count) - 1
        
        return 1.0 - ((totalCount - index) >= 2 ? 0.2 : ((totalCount - index) * 0.1))
    }
}
