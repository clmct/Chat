//
//  OperationDataManager.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 14.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class OperationDataManager: DataManagerProtocol {
  
  var fileManager = FileManagerComponent()
  
  func write(data: Data, urlString: String) {
    let operation = {
      self.fileManager.write(data: data, urlString: urlString)
    }
    let operationQueue = OperationQueue()
    //    let operation = ReadOperation()
    operationQueue.addOperation(operation)
  }
  
  func read(urlString: String, completion: @escaping (Data?) -> Void) {
    let operation = {
      let data = self.fileManager.read(urlString: urlString)
      completion(data)
    }
    let operationQueue = OperationQueue()
    //    let operation = WriteOperation()
    operationQueue.addOperation(operation)
  }
}

//class ReadOperation: Operation {
//
//  override init() {
//  }
//
//  override func main() {
//
//  }
//}
//
//class WriteOperation: Operation {
//
//  override init() {
//  }
//
//  override func main() {
//
//  }
//}
