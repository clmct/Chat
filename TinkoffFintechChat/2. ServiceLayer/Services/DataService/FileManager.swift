//
//  FileManager.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 17.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

protocol FileManagerComponentProtocol {
  func write(data: Data, urlString: String)
  func read(urlString: String) -> Data?
}

class FileManagerComponent: FileManagerComponentProtocol {
  
  private let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
  
  func write(data: Data, urlString: String) {
    do {
      guard let dir = dir else {
        print("couldn't create url")
        return }
      let url = dir.appendingPathComponent(urlString)
      try data.write(to: url)
    } catch {
      print("couldn't write data")
    }
  }
  
  func read(urlString: String) -> Data? {
    do {
      guard let dir = dir else {
        print("couldn't create url")
        return nil }
      let url = dir.appendingPathComponent(urlString)
      let data = try Data(contentsOf: url)
      return data
    } catch {
      print("couldn't read data")
      return nil
    }
  }
}
