//
//  CellProtocol.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 29.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

protocol ConfiguratableView {
  
  associatedtype ConversationModel
  
  func configure(with model: ConversationModel)
}
