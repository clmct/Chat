//
//  Date.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 30.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

extension Date {
  static func dateFromCustomString(customString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
    return dateFormatter.date(from: customString) ?? Date()
  }
  
  static func stringFromDate(day: Date) -> String {
    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateFormat = "dd MMM"

    let dateFormatter2 = DateFormatter()
    dateFormatter2.dateFormat = "HH:mm"

    let dateFormatter3 = DateFormatter()
    dateFormatter3.dateFormat = "yyyy/MM/dd"
    
    let today = Date()
    let strToday = dateFormatter3.string(from: today)
    
    if strToday == dateFormatter3.string(from: day) {
      return dateFormatter2.string(from: day)
    } else {
      return dateFormatter1.string(from: day)
    }
  }
}
