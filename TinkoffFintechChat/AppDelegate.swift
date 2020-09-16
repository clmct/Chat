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

