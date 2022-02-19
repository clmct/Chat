//
//  CoreAssembly.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 08.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

protocol CoreAssemblyProtocol {
  var coreDataStack: CoreDataStackProtocol { get set }
  var requestSender: RequestSenderProtocol { get }
  var fileManagerComponent: FileManagerComponentProtocol { get }
}

class CoreAssembly: CoreAssemblyProtocol {
  lazy var fileManagerComponent: FileManagerComponentProtocol = FileManagerComponent()
  lazy var coreDataStack: CoreDataStackProtocol = CoreDataStack()
  lazy var requestSender: RequestSenderProtocol = RequestSender(requestConfig: RequestConfig(request: Request()))
}
