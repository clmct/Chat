//
//  Logger.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 13.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit
import os.log

struct Logger {
  
  #if DEBUG
    static var isPrintButtonFrame = true
  #else
    static var isPrintButtonFrame = false
  #endif
  
  #if DEBUG
    static var isPrintLogs = false
  #else
    static var isPrintLogs = false
  #endif
  
  enum StateAD: String {
    case notrunning = "Not running"
    case inactive = "Inactive"
    case active = "Active"
    case background = "Background"
    case terminated = "Terminated"
  }
  
  enum StateVC: String {
    case appearing = "Appearing"
    case appeared = "Appeared"
    case disappearing = "Disappereaing"
    case disappeared = "Disappeared"
  }
  
  
  static func printLogsVC(nameFuncVC: String, stateFrom: StateVC, stateTo: StateVC, vc: String) {
    if isPrintLogs {
      let log  = OSLog(subsystem: "TinkoffFintechChat", category: vc)
      os_log("ViewController moved from %s to %s: %s", log: log, type: .info, stateFrom.rawValue, stateTo.rawValue, nameFuncVC)
    }
  }
  
  static func printLogsVC(nameFuncVC: String, vc: String) {
    if isPrintLogs {
    let log  = OSLog(subsystem: "TinkoffFintechChat", category: vc)
    os_log("%s", log: log, type: .info, nameFuncVC)
    }
  }
  
  static func printLogsAD(nameFuncAD: String, stateFrom: StateAD, stateTo: StateAD) {
    if isPrintLogs {
    let log = OSLog(subsystem: "tinkoffchatapp", category: "AppDelegate")
    os_log("Application moved from %s to %s: %s", log: log, type: .info, stateFrom.rawValue, stateTo.rawValue, nameFuncAD)
    }
  }
  
  static func printSaveButtonFrame(buttonFrame: CGRect, nameFunc: String) {
    if isPrintButtonFrame {
      print("Save button frame: \(buttonFrame) from function: \(nameFunc)")
    }
  }
  
}

