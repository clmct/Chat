//
//  PresentationAssembly.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 08.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit
import Foundation

protocol PresentationAssemblyProtocol {
  func conversationsListViewController() -> ConversationsListViewController
  func conversationViewController(idChannel: String) -> ConversationViewController
  func profileViewController() -> ProfileViewController
  func themesViewController() -> ThemesViewController
}

class PresentationAssembly: PresentationAssemblyProtocol {
  private let serviceAssembly: ServiceAssemblyProtocol
  
  init(serviceAssembly: ServiceAssemblyProtocol) {
    self.serviceAssembly = serviceAssembly
  }
  
  func conversationsListViewController() -> ConversationsListViewController {
    let viewController = ConversationsListViewController()
    return viewController
  }
  
  func conversationViewController(idChannel: String) -> ConversationViewController {
    let viewController = ConversationViewController()
    return viewController
  }
  
  func profileViewController() -> ProfileViewController {
    let viewController = ProfileViewController()
    return viewController
  }
  
  func themesViewController() -> ThemesViewController {
    let viewController = ThemesViewController()
    return viewController
  }
  
  private func conversationsListModel() -> ConversationsListModelProtocol {
    let model = ConversationsListModel()
    return model
  }
}
