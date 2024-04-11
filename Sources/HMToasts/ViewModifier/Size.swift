//
//  Size.swift
//
//
//  Created by Archibbald on 11.04.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func size(perform: @escaping (CGSize) -> Void) -> some View {
        self
            .background {
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            perform(geometry.size)
                        }
                }
            }
    }
}
