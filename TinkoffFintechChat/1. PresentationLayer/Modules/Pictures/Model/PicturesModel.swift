//
//  PicturesModel.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 15.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

protocol PicturesModelProtocol {
  func send()
  var delegate: ModelDelegate? { get set }
}

protocol ModelDelegate: class {
    func setup(dataSource: [URL])
}

class PicturesModel: PicturesModelProtocol {
  
  var delegate: ModelDelegate?
  
  var urlsImages: [URL]?
  
  func send() {
    networkService.sendRequest { result in

      switch result {
      case .success(let urls):
        print(urls)
        DispatchQueue.main.async {
          self.delegate?.setup(dataSource: urls)
        }
       
      case .failure(let error):
        print(error.localizedDescription) 
      }
    }
  }
  
  var networkService: NetworkServiceProtocol
  
  init(networkService: NetworkServiceProtocol) {
    self.networkService = networkService
  }
  
}
