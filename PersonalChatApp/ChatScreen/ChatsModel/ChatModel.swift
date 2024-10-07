//
//  ChatModel.swift
//  PersonalChatApp
//
//  Created by NNMacMini on 05/10/24.
//

import Foundation


struct Message {
    let chattext: String
    let isReceived: Bool
    let dateReceived: Date
    
    // Initialize from parameters
    init(chattext: String, isReceived: Bool, dateReceived: Date) {
        self.chattext = chattext
        self.isReceived = isReceived
        self.dateReceived = dateReceived
    }
    
    // Initialize from a Core Data managed object
    init(entity: ChatsReceived) {
        self.chattext = entity.chattext ?? ""
        self.isReceived = entity.isReceived
        self.dateReceived = entity.dateReceived ?? Date()
    }
}

