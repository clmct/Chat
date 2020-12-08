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
  
  lazy var key = Bundle.main.object(forInfoDictionaryKey: "Token")
  
  var baseUrl: String? {
    if let key = key {
      return "https://pixabay.com/api/?key=\(key)&q=yellow+flowers&image_type=%20photo&pretty=true&\(limitPage)"
    } else {
      return nil
    }
  }
  // MARK: - RequestProtocol
  
  var urlRequest: URLRequest? {
    guard let urlString: String = baseUrl else { return nil }
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
