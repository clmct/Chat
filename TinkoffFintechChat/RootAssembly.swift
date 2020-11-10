//
//  RootAssembly.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 08.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

class RootAssembly {
  lazy var presentationAssembly: PresentationAssemblyProtocol = PresentationAssembly(serviceAssembly: self.serviceAssembly)
  private lazy var serviceAssembly: ServiceAssemblyProtocol = ServiceAssembly(coreAssembly: self.coreAssembly)
  private lazy var coreAssembly: CoreAssemblyProtocol = CoreAssembly()
}
