//
//  Functions.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit
import CoreData

public func imageInitials(name: String?) -> UIImage? {
  
  let frame = CGRect(x: 0, y: 0, width: 480, height: 480)
  let nameLabel = UILabel(frame: frame)
  nameLabel.textAlignment = .center
  nameLabel.backgroundColor = UIColor(red: 0.89, green: 0.91, blue: 0.17, alpha: 1.00)
  nameLabel.textColor = UIColor(red: 0.21, green: 0.22, blue: 0.22, alpha: 1.00)
  nameLabel.font = UIFont.systemFont(ofSize: 240)
  var initials = "?"
  
  if let initialsArray = name?.components(separatedBy: " ") {
    if let firstWord = initialsArray.first {
      if let firstLetter = firstWord.first {
        initials = String(firstLetter).capitalized
      }
    }
    if let lastWord = initialsArray.last, initialsArray.count > 1 {
      if let lastLetter = lastWord.first {
        initials += String(lastLetter).capitalized
      }
    }
  }
  
  nameLabel.text = initials
  UIGraphicsBeginImageContext(frame.size)
  if let currentContext = UIGraphicsGetCurrentContext() {
    nameLabel.layer.render(in: currentContext)
    let nameImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return nameImage
  }
  return nil
}

public func getChannelByID(context: NSManagedObjectContext, id: String) -> ChannelMO? {
  let request: NSFetchRequest<ChannelMO> = ChannelMO.fetchRequest()
  request.predicate = NSPredicate(format: "identifier == %@", id)
  request.fetchLimit = 1
  do {
    let result = try context.fetch(request)
    return result.first
  } catch {
    print(error.localizedDescription)
  }
  return nil
}
