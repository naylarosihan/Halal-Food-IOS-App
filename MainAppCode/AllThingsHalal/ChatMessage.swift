//
//  ChatMessage.swift
//  AllThingsHalal
//
//  Created by PettaMarukka on 3/6/2024.
//

import UIKit
import MessageKit


class ChatMessage: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    init(sender: SenderType, messageId: String, sentDate: Date, message: String) {
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = .text(message)
    }
}
