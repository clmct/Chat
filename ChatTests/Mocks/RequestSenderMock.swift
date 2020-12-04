//
//  RequestSenderMock.swift
//  ChatTests
//
//  Created by Алмат Кульбаев on 03.12.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation
@testable import ChatTF

class RequestSenderMock: RequestSenderProtocol {
  
  var imagesStub: [Images]
  var isSuccess: Bool
  
  init(imagesStub: [Images], isSuccess: Bool) {
    self.imagesStub = imagesStub
    self.isSuccess = isSuccess
  }
  
  func send(completionHandler: @escaping (Result<[Images], RequestError>) -> Void) {
    if isSuccess {
      completionHandler(.success(imagesStub))
    } else {
      completionHandler(.failure(.serverError))
    }
    
  }
}
