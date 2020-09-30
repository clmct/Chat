//
//  AppDelegate.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 13.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Logger.printLogsAD(nameFuncAD: #function, stateFrom: .notrunning, stateTo: .inactive)
    
    var data = [ConversationModel]()
    var messages = [Messages]()
    var messagesToday = [Messages]()
    
    for _ in 0...5 {
      messages.append(Messages(message: "Hello", isIncoming: true, date: Date.dateFromCustomString(customString: "2019/10/08 20:01")))
      messages.append(Messages(message: "What are you doing tomorrow? Will you be busy? Can we watch the movie tomorrow?", isIncoming: true, date: Date.dateFromCustomString(customString: "2019/10/08 20:01")))
      messages.append(Messages(message: "Sorry, I'l be busy! Maybe later?", isIncoming: true, date: Date.dateFromCustomString(customString: "2019/10/08 21:01")))
      messages.append(Messages(message: "Sorry, I'l be busy! Maybe later?", isIncoming: false, date: Date.dateFromCustomString(customString: "2020/02/05 21:01")))
    }
    
    for _ in 0...5 {
      messagesToday.append(Messages(message: "Hello", isIncoming: true, date: Date.dateFromCustomString(customString: "2019/10/08 20:01")))
      messagesToday.append(Messages(message: "What are you doing tomorrow? Will you be busy? Can we watch the movie tomorrow?", isIncoming: false, date: Date.dateFromCustomString(customString: "2019/10/08 20:01")))
      messagesToday.append(Messages(message: "Sorry, I'l be busy! Maybe later? What are you doing next week? orry, I'l be busy! Maybe later? What are you doing next week?", isIncoming: true, date: Date()))
    }
    
    for _ in 0...2 {
      data.append(ConversationModel(name: "Alex Martin",messages: messages, isOnline: true, hasUnreadMessages: true ))
      data.append(ConversationModel(name: "Kate", messages: messagesToday, isOnline: true, hasUnreadMessages: true ))
      data.append(ConversationModel(name: "Jack",messages: messages, isOnline: false, hasUnreadMessages: false ))
      data.append(ConversationModel(name: "Marina", messages: messagesToday, isOnline: false, hasUnreadMessages: false ))
      data.append(ConversationModel(name: "Harry", messages: messages, isOnline: true, hasUnreadMessages: false ))
      data.append(ConversationModel(name: "Jack Martin", messages: messagesToday, isOnline: true, hasUnreadMessages: false ))
      data.append(ConversationModel(name: "Jack London", messages: messages, isOnline: false, hasUnreadMessages: true ))
      data.append(ConversationModel(name: "Tony", messages: messagesToday, isOnline: false, hasUnreadMessages: true ))
      
      data.append(ConversationModel(name: "Martin", messages: [], isOnline: true, hasUnreadMessages: true ))
      data.append(ConversationModel(name: "Martin", messages: [], isOnline: false, hasUnreadMessages: false ))
      data.append(ConversationModel(name: "Martin", messages: [], isOnline: true, hasUnreadMessages: false ))
      data.append(ConversationModel(name: "Martin", messages: [], isOnline: false, hasUnreadMessages: true ))
    
    }
    
    var sortData: [[ConversationModel]] = [[],[]]
    
    data.forEach { (element) in
      if element.isOnline {
        sortData[0].append(element)
      } else if element.messages.count >= 1 {
        sortData[1].append(element)
      } else {
        return
      }
    }
    
    
    window = UIWindow()
    let controller = ConversationsListViewController()
    controller.data = sortData
    window?.rootViewController = UINavigationController(rootViewController: controller)
    window?.makeKeyAndVisible()
    
    return true
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    Logger.printLogsAD(nameFuncAD: #function, stateFrom: .inactive, stateTo: .active)
  }
  func applicationWillResignActive(_ application: UIApplication) {
    Logger.printLogsAD(nameFuncAD: #function, stateFrom: .active, stateTo: .inactive)
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    Logger.printLogsAD(nameFuncAD: #function, stateFrom: .inactive, stateTo: .background)
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    Logger.printLogsAD(nameFuncAD: #function, stateFrom: .background, stateTo: .inactive)
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    Logger.printLogsAD(nameFuncAD: #function, stateFrom: .background, stateTo: .terminated)
  }
  
}

