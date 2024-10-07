//
//  ChatsReceived+CoreDataProperties.swift
//  PersonalChatApp
//
//  Created by NNMacMini on 05/10/24.
//
//

import Foundation
import CoreData


extension ChatsReceived {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatsReceived> {
        return NSFetchRequest<ChatsReceived>(entityName: "ChatsReceived")
    }

    @NSManaged public var dateReceived: Date?
    @NSManaged public var isReceived: Bool
    @NSManaged public var chattext: String?

}

extension ChatsReceived : Identifiable {

}
