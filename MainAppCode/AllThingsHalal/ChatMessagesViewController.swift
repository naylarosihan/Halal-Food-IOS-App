//
//  ChatMessagesViewController.swift
//  AllThingsHalal
//
//  Created by PettaMarukka on 4/6/2024.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import FirebaseFirestore

class ChatMessagesViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate {
    
    
    var sender: Sender?
    var currentChannel: Channel?
    var messagesList = [ChatMessage]()
    var channelRef: CollectionReference?
    var databaseListener: ListenerRegistration?
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "HH:mm dd/MM/yy"
        return formatter
    }()
    
    
    var currentSender: SenderType {
        return Sender(id: "",name: "")
    }
    
    
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messagesList[indexPath.section]
    }
    
    
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        
        return messagesList.count
    }
    
    
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes:
            [NSAttributedString.Key.font:UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font:UIFont.preferredFont(forTextStyle: .caption2)])
        
    }
    
    
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        if text.isEmpty {
            return
        }
        
        channelRef?.addDocument(data: [
            "senderId" : sender!.senderId,
            "senderName" : sender!.displayName,
            "text" : text,
            "time" : Timestamp(date: Date.init())
        ])
        
        inputBar.inputTextView.text = ""
    }
    
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 18
    }
    
    
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 17
    }
    
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 20
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 16
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        
        return .bubbleTail(tail, .curved)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        scrollsToLastItemOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
        
        if currentChannel != nil {
            let database = Firestore.firestore()
            channelRef = database.collection("channels")
                .document(currentChannel!.id).collection("messages")
            navigationItem.title = "\(currentChannel!.name)"
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        databaseListener = channelRef?.order(by: "time").addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            if let error = error {
                print(error)
                return
            }
            
            querySnapshot?.documentChanges.forEach { change in
                if change.type == .added {
                    let snapshot = change.document
                    let id = snapshot.documentID
                    let senderId = snapshot["senderId"] as! String
                    let senderName = snapshot["senderName"] as! String
                    let messageText = snapshot["text"] as! String
                    let sentTimestamp = snapshot["time"] as! Timestamp
                    let sentDate = sentTimestamp.dateValue()
                    let sender = Sender(id: senderId, name: senderName)
                    let message = ChatMessage(sender: sender, messageId: id, sentDate: sentDate, message: messageText)
                    self.messagesList.append(message)
                    self.messagesCollectionView.insertSections([self.messagesList.count - 1])
                }
            }
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseListener?.remove()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

