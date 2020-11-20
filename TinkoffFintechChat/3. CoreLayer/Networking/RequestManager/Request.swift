//
//  Request.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 20.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

protocol RequestProtocol {
  var urlRequest: URLRequest? { get }
}

class Request: RequestProtocol {
  
  private var limitPage: String {
    return "per_page=\(pages)"
  }
  private var pages: Int
  
  private var key = "19126079-3610682771ee6f29f84a45736"
  
  lazy var baseUrl: String = "https://pixabay.com/api/?key=\(key)&q=yellow+flowers&image_type=%20photo&pretty=true&\(limitPage)"
  
  // MARK: - RequestProtocol
  
  var urlRequest: URLRequest? {
    let urlString: String = baseUrl
    if let url = URL(string: urlString) {
      return URLRequest(url: url)
    }
    return nil
  }
  
  // MARK: - Initialization
  
  init(pages: Int = 150) {
    self.pages = pages
  }
}
