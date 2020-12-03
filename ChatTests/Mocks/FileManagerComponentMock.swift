//
//  FileManagerComponentMock.swift
//  FileManagerComponentMock
//
//  Created by Алмат Кульбаев on 03.12.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation
@testable import ChatTF

final class FileManagerComponentMock: FileManagerComponentProtocol {
  
  var callsCount = 0
  var urlString: String?
  var data: Data?

  func write(data: Data, urlString: String) {
    callsCount += 1
    self.urlString = urlString
    self.data = data
  }
  
  func read(urlString: String) -> Data? {
    callsCount += 1
    self.urlString = urlString
    return data
  }
  
}
