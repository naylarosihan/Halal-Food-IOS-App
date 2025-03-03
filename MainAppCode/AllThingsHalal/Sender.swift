//
//  Sender.swift
//  AllThingsHalal
//
//  Created by PettaMarukka on 3/6/2024.
//

import UIKit
import MessageKit



class Sender: SenderType {
    var senderId: String
    var displayName: String
    
    init(id: String, name: String) {
        self.senderId = id
        self.displayName = name
    }
}
