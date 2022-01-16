//
//  Functions.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit
import CoreData

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
