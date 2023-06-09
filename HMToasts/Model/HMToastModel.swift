//
//  HMToastModel.swift
//  HMToasts
//
//  Created by Артур Данилов on 09.06.2023.
//

import Foundation

struct HMToastModel: Identifiable, Equatable {
    
    var id: UUID = .init()
    var body: String
}
