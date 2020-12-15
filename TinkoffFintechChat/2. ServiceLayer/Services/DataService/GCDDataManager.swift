//
//  GCDDataManager.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 14.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

protocol DataManagerProtocol {
  func write(data: Data, urlString: String)
  func read(urlString: String, completion: @escaping (Data?) -> Void)
}

class GCDDataManager: DataManagerProtocol {

  private var serialQueue = DispatchQueue(label: "serial")
  
  var fileManager: FileManagerComponentProtocol
  
  init(fileManager: FileManagerComponentProtocol) {
    self.fileManager = fileManager
  }
  
  func write(data: Data, urlString: String) {
    serialQueue.asyncAfter(deadline: .now(), execute: {
      self.fileManager.write(data: data, urlString: urlString)
    })
  }
  
  func read(urlString: String, completion: @escaping (Data?) -> Void) {
    serialQueue.asyncAfter(deadline: .now(), execute: {
      let data = self.fileManager.read(urlString: urlString)
      completion(data)
      })
  }
  
}
