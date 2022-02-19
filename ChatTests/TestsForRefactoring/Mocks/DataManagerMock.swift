//
//  DataManagerMock.swift
//  ChatTests
//
//  Created by Almat Kulbaev on 28.12.2021.
//  Copyright © 2021 Алмат Кульбаев. All rights reserved.
//

import Foundation
@testable import ChatTF

class DataManagerMock: DataManagerProtocol {
  var writeCount = 0
  var readCount = 0
  
  func write(data: Data, urlString: String) {
    writeCount += 1
  }
  
  func read(urlString: String, completion: @escaping (Data?) -> Void) {
    readCount += 1
    completion(nil)
  }
}
