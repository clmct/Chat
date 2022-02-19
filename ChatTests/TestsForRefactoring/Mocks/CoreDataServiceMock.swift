//
//  CoreDataServiceMock.swift
//  ChatTests
//
//  Created by Almat Kulbaev on 28.12.2021.
//  Copyright © 2021 Алмат Кульбаев. All rights reserved.
//

import Foundation
import CoreData
@testable import ChatTF

class CoreDataServiceMock: CoreDataServiceProtocol {
  var mainContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
  
  var printDataStatisiticsCount = 0
  
  func printDataStatisitics() {
    printDataStatisiticsCount += 0
  }
}
