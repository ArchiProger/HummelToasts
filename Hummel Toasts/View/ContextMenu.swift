//
//  ContextMenu.swift
//  HMToasts
//
//  Created by Артур Данилов on 12.09.2023.
//

import Foundation
import SwiftUI

extension View {
    
    @ViewBuilder
    func contextMenu(_ actions: [UIAction],
                     onAppear: (() -> Void)? = nil,
                     onDismiss: (() -> Void)? = nil
    ) -> some View {
        self
            .modifier(ContextMenuModifier(actions: actions, onAppear: onAppear, onDismiss: onDismiss))
    }
}

struct ContextMenuModifier: ViewModifier {
    let actions: [UIAction]
    let onAppear: (() -> Void)?
    let onDismiss: (() -> Void)?
    
    @State private var size: CGSize? = nil
    
    func body(content: Content) -> some View {
        
        ContextMenuController(actions: actions, onAppear: onAppear, onDismiss: onDismiss) {
            
            content
                .size { size in
                    self.size = size
                }
        }
        .frame(width: size?.width, height: size?.height)
    }
}

struct ContextMenuController<Content: View>: UIViewControllerRepresentable {
    
    let actions: [UIAction]
    let onAppear: (() -> Void)?
    let onDismiss: (() -> Void)?
    
    @ViewBuilder let view: Content
        
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let contextMenu = UIContextMenuInteraction(delegate: context.coordinator)
        let controller = UIHostingController(rootView: view)
        controller.view.addInteraction(contextMenu)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {  }
    
    func makeCoordinator() -> Coordinator {
        
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UIContextMenuInteractionDelegate {
        let parent: ContextMenuController
        
        init(_ parent: ContextMenuController) {
            self.parent = parent
        }
        
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
            
            UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [self] suggestedActions in
                
                return UIMenu(title: "", children: parent.actions)
            }
        }
                
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willDisplayMenuFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
            
            parent.onAppear?()
        }
        
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willEndFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
            
            parent.onDismiss?()
        }
    }
}
