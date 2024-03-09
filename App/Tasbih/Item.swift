//
//  Item.swift
//  Tasbih
//
//  Created by Abdullah Alhaider on 09/03/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
