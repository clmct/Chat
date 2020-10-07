//
//  ThemesModel.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 08.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

struct ThemesStruct {
  enum themeMode {
    case classic
    case day
    case night
  }
  
  var theme = themeMode.day
  
  var messageIncoming: UIColor {
    
    switch theme {
    case .classic:
      return UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.00)
    case .night:
      return UIColor(red: 0.36, green: 0.36, blue: 0.36, alpha: 1.00)
    case .day:
      return UIColor(red: 0.26, green: 0.54, blue: 0.98, alpha: 1.00)
    }
  }
  
  var messageOutcoming: UIColor {
    switch theme {
    case .classic:
      return UIColor(red: 0.86, green: 0.97, blue: 0.77, alpha: 1.00)
    case .night:
      return UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
    case .day:
      return UIColor(red: 0.92, green: 0.92, blue: 0.93, alpha: 1.00)
    }
  }
  
  var textIncoming: UIColor {
    switch theme {
    case .classic:
      return UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    case .night:
      return UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    case .day:
      return UIColor(red: 0.92, green: 0.92, blue: 0.93, alpha: 1.00)
    }
  }
  
  var textOutcoming: UIColor {
    switch theme {
    case .classic:
      return UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    case .night:
      return UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    case .day:
      return UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    }
  }
  
  var backgroundColor: UIColor {
    switch theme {
    case .classic:
      return UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    case .night:
      return UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    case .day:
      return UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    }
  }
  
  //
  var nameColor: UIColor {
    switch theme {
    case .classic, .day:
      return UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    case .night:
      return UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    }
  }
  
  var messageColor: UIColor {
    switch theme {
    case .classic, .day:
      return UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.60)
    case .night:
      return UIColor(red: 0.55, green: 0.55, blue: 0.58, alpha: 1.00)
  }
  }
  
  var onlineBackground: UIColor {
    return UIColor(red: 1.00, green: 0.95, blue: 0.74, alpha: 1.00)
  }
  
  var onlineName: UIColor {
    return UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    
  }
}
