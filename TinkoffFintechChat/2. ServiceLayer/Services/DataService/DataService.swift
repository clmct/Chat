//
//  DataService.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 13.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

protocol DataServiceProtocol {
  var operation: DataComponentProtocol { get set }
  var gcd: DataComponentProtocol { get set }
}

class DataService: DataServiceProtocol {
  
  var operation: DataComponentProtocol
  var gcd: DataComponentProtocol
  
  init(gcd: DataComponentProtocol, operation: DataComponentProtocol) {
    self.gcd = gcd
    self.operation = operation
  }
  
  func operationRead() {
    operation.read()
  }
  
  func operationWrite() {
    operation.write()
  }
  
  func gcdRead() {
    gcd.read()
  }
  
  func gcdWrite() {
    gcd.write()
  }
  
}
