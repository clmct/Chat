//
//  NetworkService.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 20.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
  func sendRequest(completionHandler: @escaping (Result<[URL], Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
  
  func sendRequest(completionHandler: @escaping (Result<[URL], Error>) -> Void) {
    var urls: [URL] = []
    
    requestSender.send { result in
      
      switch result {
      case .success(let successValues):
        successValues.forEach { image in
          if let urlString = image.previewURL {
            if let url = URL(string: urlString) {
              urls.append(url)
            }
          }
        }
        completionHandler(.success(urls))
        
      case .failure(let error):
        print(error)
        completionHandler(.failure(error))
      }
      
    }
  }

  let requestSender: RequestSenderProtocol
  
  init(requestSender: RequestSenderProtocol) {
    self.requestSender = requestSender
  }
}
