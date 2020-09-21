//
//  Logger.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 13.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation
import os.log

struct Logger {
  
  static var isPrint: Bool = false // switch
  
  static var logVC = OSLog(subsystem: "tinkoffchatapp", category: "VC")
  static var logVC2 = OSLog(subsystem: "tinkoffchatapp", category: "VC2")
  static var logAD = OSLog(subsystem: "tinkoffchatapp", category: "AD")
  
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
  
  enum NumberVC : Int {
    case first = 1
    case second = 2
  }
  
  static func printLogsVC(nameFuncVC: String, stateFrom: StateVC, stateTo: StateVC, vc: NumberVC) {
    if isPrint {
      os_log("ViewComtroller moved from %s to %s: %s", log: vc.rawValue == 1 ? logVC : logVC2, type: .info, stateFrom.rawValue, stateTo.rawValue, nameFuncVC)
    }
  }
  
  static func printLogsVC(nameFuncVC: String, vc: NumberVC) {
    if isPrint {
      os_log("%s", log: vc.rawValue == 1 ? logVC : logVC2, type: .info, nameFuncVC)
    }
  }
  
  static func printLogsAD(nameFuncAD: String, stateFrom: StateAD, stateTo: StateAD) {
    if isPrint {
      os_log("Application moved from %s to %s: %s", log: logAD, type: .info, stateFrom.rawValue, stateTo.rawValue, nameFuncAD)
    }
  }
  
}

