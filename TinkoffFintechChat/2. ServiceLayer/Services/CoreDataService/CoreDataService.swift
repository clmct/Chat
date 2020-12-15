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
}

class CoreDataService: CoreDataServiceProtocol {
  
  func printDataStatisitics() {
//    coreDataStack.enableObservers()
    coreDataStack.didUpdateDataBase = { a in
      a.printDataStatisitics()
    }
  }
  
  lazy var mainContext: NSManagedObjectContext = {
    return coreDataStack.mainContext
  }()

  var coreDataStack: CoreDataStackProtocol

  init(coreDataStack: CoreDataStackProtocol) {
    self.coreDataStack = coreDataStack
    self.coreDataStack.enableObservers()
  }

}
