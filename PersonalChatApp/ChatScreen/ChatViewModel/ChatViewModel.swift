//
//  ChatModel.swift
//  PersonalChatApp
//
//  Created by NNMacMini on 05/10/24.
//

import Foundation
import CoreData

class ChatViewModel {
    private let context = AppDelegate.shared.context
    
    func fetchMessages() -> [ChatsReceived] {
        let request: NSFetchRequest<ChatsReceived> = ChatsReceived.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch failed")
            return []
        }
    }
}
