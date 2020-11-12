//
//  CoreDataService.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 09.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation
import CoreData
protocol CoreDataServiceProtocol {
  func printDataStatisitics()
  var mainContext: NSManagedObjectContext { get }
  var coreDataStack: CoreDataStackProtocol { get }
}

class CoreDataService: CoreDataServiceProtocol {
  lazy var mainContext: NSManagedObjectContext = {
    return coreDataStack.mainContext
  }()
  
  func printDataStatisitics() {
    coreDataStack.enableObservers()
    coreDataStack.didUpdateDataBase = { a in
      a.printDataStatisitics()
    }
  }
  
  var coreDataStack: CoreDataStackProtocol
  
  init(coreDataStack: CoreDataStackProtocol) {
    self.coreDataStack = coreDataStack
    self.coreDataStack.enableObservers()
  }
  
}
  
