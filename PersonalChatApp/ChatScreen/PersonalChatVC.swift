//
//  PersonalChatVC.swift
//  PersonalChatApp
//
//  Created by NNMacMini on 04/10/24.
//

import UIKit
import CoreData

class PersonalChatVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    
    var chats: [ChatsReceived] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setup()
        chatRequest()
//        clearAllChats()
        initialChatLoading()
      
    }
    
    func setup() {
        
        textField.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ReceivedCell", bundle: nil), forCellReuseIdentifier: "ReceivedCell")
        tableView.register(UINib(nibName: "SendCell", bundle: nil), forCellReuseIdentifier: "SendCell")
        
    }
    
    func clearAllChats() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ChatsReceived.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try AppDelegate.shared.context.execute(deleteRequest)
            chatRequest()
        } catch {
            print("Error clearing chats: \(error)")
        }
    }
    
    //Chat Fetch
    func chatRequest() {
        let fetchRequest: NSFetchRequest<ChatsReceived> = ChatsReceived.fetchRequest()
        do {
            chats = try AppDelegate.shared.context.fetch(fetchRequest)
            tableView.reloadData()
//            scrollToBottom() // Scroll to bottom after fetching messages
        } catch {
            print("Failed to fetch messages: \(error)")
        }
        
    }
    
    func initialChatLoading() {
        let fetchRequest: NSFetchRequest<ChatsReceived> = ChatsReceived.fetchRequest()
        do {
            let count = try AppDelegate.shared.context.count(for: fetchRequest)
            if count == 0 {
                let staticMessage = ChatsReceived(context: AppDelegate.shared.context)
                staticMessage.chattext = "Hello!"
                staticMessage.isReceived = true
                staticMessage.dateReceived = Date()
                AppDelegate.shared.saveContext()
            }
        } catch {
            print("Failed to fetch messages count: \(error)")
        }
    }
    
    @IBAction func sendButtonAction(_ sender: UIButton) {
        
        guard let text = textField.text, !text.isEmpty else { return }
        let newChat = ChatsReceived(context: AppDelegate.shared.context)
        newChat.chattext = text
        newChat.isReceived = false
        newChat.dateReceived = Date()
        AppDelegate.shared.saveContext()
        textField.text = ""
        chatRequest()
        
        
    }
    
}


extension PersonalChatVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = chats[indexPath.row]
        if message.isReceived {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedCell", for: indexPath) as! ReceivedCell
            cell.selectionStyle = .none
            cell.labelReceived.text = message.chattext
            return cell
        }
        else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SendCell", for: indexPath) as! SendCell
            cell.labelSend.text = message.chattext
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
