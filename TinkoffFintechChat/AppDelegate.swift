//
//  AppDelegate.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 13.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  private let rootAssembly = RootAssembly()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Logger.printLogsAD(nameFuncAD: #function, stateFrom: .notrunning, stateTo: .inactive)

//    CoreDataStack.shared.enableObservers()
//    CoreDataStack.shared.didUpdateDataBase = { stack in
//      stack.printDataStatisitice() // Логи выводятся два раза из за двух контекстов
//    }
    FirebaseApp.configure()
    let themeMain = ThemeApp(theme: .classic)
    if let defaults = UserDefaults.standard.object(forKey: "theme") as? String {
      switch defaults {
      case "classic":
        themeMain.theme = .classic
      case "day":
        themeMain.theme = .day
      case "night":
        themeMain.theme = .night
      default: break
      }
    }
    
    window = UIWindow()
//    let controller = ConversationsListViewController()
//    controller.updateTheme(theme: themeMain)
//    controller.navigationController?.navigationBar.barTintColor = themeMain.navigationBar
//    window?.rootViewController = UINavigationController(rootViewController: controller)
//    window?.makeKeyAndVisible()
    
    let controller = rootAssembly.presentationAssembly.conversationsListViewController()
    controller.updateTheme(theme: themeMain)
    let navigationController = UINavigationController(rootViewController: controller)
    window?.rootViewController = navigationController
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
