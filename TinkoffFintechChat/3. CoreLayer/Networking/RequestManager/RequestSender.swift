//
//  RequestSender.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 16.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.

import Foundation

enum RequestError: Error {
  case urlRequestError
  case clientError
  case serverError
  case noData
  case dataDecodingError
}

protocol RequestSenderProtocol {
  func send(completionHandler: @escaping (Result<[Images], RequestError>) -> Void)
}

class RequestSender: RequestSenderProtocol {
  
  var config: RequestConfig
  
  init(requestConfig config: RequestConfig) {
    self.config = config
  }
  
  let session = URLSession.shared
  
  func send(completionHandler: @escaping (Result<[Images], RequestError>) -> Void) {

    guard let urlRequest = config.request.urlRequest else {
      completionHandler(.failure(.urlRequestError))
      return
    }
    
    let task = session.dataTask(with: urlRequest) { (data, response, error) in
      
      guard error == nil else {
        completionHandler(.failure(.clientError))
        return
      }
      
      guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
        completionHandler(.failure(.serverError))
        return
      }
      
      guard let data = data else {
        completionHandler(.failure(.noData))
        return
      }
      
      guard let parsedModel: [Images] = self.config.parser.parse(data: data) else {
        completionHandler(.failure(.dataDecodingError))
        return
      }
      
      completionHandler(.success(parsedModel))
    }
    task.resume()
  }
}
