//
//  ImageCreator.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 17.01.2022.
//  Copyright © 2022 Алмат Кульбаев. All rights reserved.
//

import UIKit

class ImageCreator {
  static let shared = ImageCreator()
  
  private init() {}
  
  func imageInitials(name: String?) -> UIImage? {
    let frame = CGRect(x: 0, y: 0, width: 480, height: 480)
    let nameLabel = UILabel(frame: frame)
    nameLabel.textAlignment = .center
    nameLabel.backgroundColor = UIColor(red: 0.89, green: 0.91, blue: 0.17, alpha: 1.00)
    nameLabel.textColor = UIColor(red: 0.21, green: 0.22, blue: 0.22, alpha: 1.00)
    nameLabel.font = UIFont.systemFont(ofSize: 240)
    var initials = "?"
    
    if let initialsArray = name?.components(separatedBy: " ") {
      if let firstWord = initialsArray.first, let firstLetter = firstWord.first {
        initials = String(firstLetter).capitalized
      }
      if let lastWord = initialsArray.last, initialsArray.count > 1, let lastLetter = lastWord.first {
        initials += String(lastLetter).capitalized
      }
    }
    
    nameLabel.text = initials
    UIGraphicsBeginImageContext(frame.size)
    guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
    nameLabel.layer.render(in: currentContext)
    let nameImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return nameImage
  }
}
