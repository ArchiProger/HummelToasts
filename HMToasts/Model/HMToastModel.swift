//
//  HMToastModel.swift
//  HMToasts
//
//  Created by Артур Данилов on 09.06.2023.
//

import Foundation
import SwiftUI

struct HMToastModel: Identifiable, Equatable {
    
    let id: UUID = .init()
    let systemImageName: String
    let color: Color
    let title: String
    let body: String
}
