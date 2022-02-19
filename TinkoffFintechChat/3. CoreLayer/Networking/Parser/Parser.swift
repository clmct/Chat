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
}

struct DataModel: Codable {
  let hits: [Images]
}

struct Images: Codable, ImagesProtocol {
  var previewURL: String?
}
