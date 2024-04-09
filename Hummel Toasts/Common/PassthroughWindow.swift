//
//  PassthroughWindow.swift
//  Hummel Toasts
//
//  Created by Archibbald on 09.04.2024.
//

import UIKit

final class PassthroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else { return nil }
        
        return rootViewController?.view == view ? nil : view
    }
}
