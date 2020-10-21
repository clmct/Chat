//
//  ThemesModel.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 08.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

enum ThemeMode: String {
  case classic = "classic"
  case day = "day"
  case night = "night"
}

class ThemeApp {
  
  var theme: ThemeMode
  
  init(theme: ThemeMode) {
    self.theme = theme
  }
  
  var messageIncoming: UIColor {
    
    switch theme {
    case .classic:
      return UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.00)
    case .night:
      return UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
    case .day:
      return UIColor(red: 0.92, green: 0.92, blue: 0.93, alpha: 1.00)
    }
  }
  
  var messageOutcoming: UIColor {
    switch theme {
    case .classic:
      return UIColor(red: 0.86, green: 0.97, blue: 0.77, alpha: 1.00)
    case .night:
      return UIColor(red: 0.36, green: 0.36, blue: 0.36, alpha: 1.00)
    case .day:
      return UIColor(red: 0.26, green: 0.54, blue: 0.98, alpha: 1.00)
    }
  }
  
  var textIncoming: UIColor {
    switch theme {
    case .classic:
      return UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    case .night:
      return UIColor(red: 0.92, green: 0.92, blue: 0.93, alpha: 1.00)
    case .day:
      return UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    }
  }
  
  var textOutcoming: UIColor {
    switch theme {
    case .classic:
      return UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    case .night:
      return UIColor(red: 0.92, green: 0.92, blue: 0.93, alpha: 1.00)
    case .day:
      return UIColor(red: 0.92, green: 0.92, blue: 0.93, alpha: 1.00)
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
  
  var sectionHeader: UIColor {
    switch theme {
    case .classic, .day:
      return UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00)
    case .night:
      return UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 0.95)
    }
  }
  
  var sectionHeaderText: UIColor {
    switch theme {
    case .classic, .day:
      return UIColor.black
    case .night:
      return UIColor.white
    }
  }
  
  var navigationBar: UIColor {
    switch theme {
    case .classic, .day:
      return UIColor(red: 1, green: 1, blue: 1, alpha: 0.90)
    case .night:
      return UIColor(red: 0, green: 0, blue: 0, alpha: 0.90)
    }
  }
  
  var navigationBarTitle: UIColor {
    switch theme {
    case .classic, .day:
      return UIColor.black
    case .night:
      return UIColor.white
    }
  }
  
  var barStyle: UIBarStyle {
    switch theme {
    case .classic, .day:
      return .default
    case .night:
      return .blackTranslucent
    }
  }
  
  var barTint: UIColor {
    switch theme {
    case .classic, .day:
      return UIColor.white
    case .night:
      return UIColor.black
    }
  }
  
  // MARK: - Profile Page
  
  var profileText: UIColor {
    switch theme {
    case .classic, .day:
      return UIColor.black
    case .night:
      return UIColor.white
    }
  }
  
  var profileButton: UIColor {
    switch theme {
    case .classic, .day:
      return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
    case .night:
      return UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00)
    }
  }
  
}
