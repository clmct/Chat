//
//  DataComponentProtocol.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 13.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

protocol DataComponentProtocol {
  var name: String? { get set }
  var description: String? { get set }
  var image: UIImage? { get set }
  func write()
  func read()
}
