//
//  HMToastModel.swift
//  HMToasts
//
//  Created by Артур Данилов on 09.06.2023.
//

import Foundation
import SwiftUI

public struct HMToastModel: Identifiable, Equatable {
    
    public let id: UUID = .init()
    public let systemImageName: String
    public let color: Color
    public let title: String
    public let body: String
}
