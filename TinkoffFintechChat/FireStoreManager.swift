//
//  class.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 18.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation
import Firebase

class FireStoreService {
  lazy var reference = Firestore.firestore().collection("channels")
  private init() {}
  static var shared = FireStoreService()
  let senderId = UIDevice.current.identifierForVendor?.uuidString
  
  func configure() {
    FirebaseApp.configure()
  }
  
  func fetchData() {
    var dataChannels = [ChannelModel]()
//    // MARK: - Mock Data
//    let test1 = ChannelModel(identifier: "1", name: "name1", lastMessage: "1", lastActivity: Date())
//    let test2 = ChannelModel(identifier: "2", name: "name2", lastMessage: "2", lastActivity: Date())
//    let test3 = ChannelModel(identifier: "3", name: "name3", lastMessage: "3", lastActivity: Date())
//    let test4 = ChannelModel(identifier: "4", name: "name4", lastMessage: "4", lastActivity: Date())
//    dataChannels.append(test1)
//    dataChannels.append(test2)
//    dataChannels.append(test3)
//    dataChannels.append(test4)
    
    reference.getDocuments { QuerySnapshot, _ in
      _ = QuerySnapshot?.documents.map({ QueryDocumentSnapshot in
        let id = QueryDocumentSnapshot.documentID
        let data = QueryDocumentSnapshot.data()
        guard let name = data["name"] as? String else { return }
        let isEmptyString = name.components(separatedBy: " ").filter { $0 != ""}
        if isEmptyString.isEmpty { return }
        let lastMessage = data["lastMessage"] as? String
        let lastActivity = data["lastActivity"] as? Timestamp
        let model = ChannelModel(identifier: id, name: name, lastMessage: lastMessage, lastActivity: lastActivity?.dateValue())
        dataChannels.append(model)
      })
      ChatRequest(coreDataStack: CoreDataStack.shared).makeRequestChannels(channelModels: dataChannels)
      
    }
  }
  
  func createChannel(newChannel channel: String) {
    let isEmptyString = channel.components(separatedBy: " ").filter { $0 != ""}
    if isEmptyString.isEmpty { return }
    reference.addDocument(data: ["name": channel] )
  }
  
  func fetchDataMessages(identifire id: String, completion: @escaping ([MessageModel]) -> Void) { 
    var dataMessages = [MessageModel]()
    reference.document(id).collection("messages").getDocuments { QuerySnapshot, _ in
      _ = QuerySnapshot?.documents.map({ QueryDocumentSnapshot in
        let data = QueryDocumentSnapshot.data()
        guard let content = data["content"] as? String else { return }
        let isEmptyString = content.components(separatedBy: " ").filter { $0 != ""}
        if isEmptyString.isEmpty { return }
        guard let created = data["created"] as? Timestamp else { return }
        guard let senderId = data["senderId"] as? String else { return }
        guard let senderName = data["senderName"] as? String else { return }
        let model = MessageModel(identifier: id, content: content, created: created.dateValue(), senderId: senderId, senderName: senderName)
        dataMessages.append(model)
      })
//      self.fetchData { dataChannels in
//        ChatRequest(coreDataStack: CoreDataStack.shared).makeRequestChannelWithMessages(channelModels: dataChannels, messagesModels: dataMessages)
//      }
      completion(dataMessages)
    }
  }
  
  func createMessage(identifire id: String, newMessage message: String) {
    guard let senderId = senderId else { return }
    reference.document(id).collection("messages").addDocument(
      data: [
        "content": message,
        "created": Timestamp(date: Date()),
        "senderId": senderId,
        "senderName": "Alex"])
  }
}
