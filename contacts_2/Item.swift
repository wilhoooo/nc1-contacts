//
//  Item.swift
//  contacts_2
//
//  Created by Emanuele De Rogatis on 20/11/23.
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
