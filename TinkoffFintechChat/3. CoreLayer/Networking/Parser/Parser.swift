//
//  Parser.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 19.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

protocol ImagesProtocol {
  var previewURL: String? { get set }
}
struct RequestConfig {
  let request: RequestProtocol
  let parser: Parser
}

struct DataModel: Decodable {
  let hits: [Images]
}

struct Images: Decodable, ImagesProtocol {
  var previewURL: String?
}

protocol ParserProtocol {
  func parse(data: Data) -> [Images]?
}

class Parser: ParserProtocol {
  
  func parse(data: Data) -> [Images]? {
    do {
      let images = try JSONDecoder().decode(DataModel.self, from: data).hits
      return images
    } catch {
      return nil
    }
  }
}
