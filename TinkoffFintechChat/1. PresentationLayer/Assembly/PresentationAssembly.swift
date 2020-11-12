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
  func conversationViewController(idChannel: String, id: String) -> ConversationViewController
  func profileViewController() -> ProfileViewController?
  func themesViewController() -> ThemesViewController?
}

class PresentationAssembly: PresentationAssemblyProtocol {
  private let serviceAssembly: ServiceAssemblyProtocol
  
  init(serviceAssembly: ServiceAssemblyProtocol) {
    self.serviceAssembly = serviceAssembly
  }
  
  func conversationsListViewController() -> ConversationsListViewController {
    var model = conversationsListModel()
    let viewController = ConversationsListViewController(model: model, presentationAssembly: self)
    model.delegateFRC = viewController
    return viewController
  }
  
  func conversationViewController(idChannel: String, id: String) -> ConversationViewController {
    let model = conversationModel()
    let viewController = ConversationViewController(model: model, id: id)
    viewController.id = idChannel
    return viewController
  }
  
  func profileViewController() -> ProfileViewController? {
    let model = profileModel()
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "profile") as? ProfileViewController
    viewController?.setProperties(model: model)
    return viewController
  }
  
  func themesViewController() -> ThemesViewController? {
    let storyboard = UIStoryboard(name: "Themes", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "settings") as? ThemesViewController
    
    return viewController
  }
  
  private func conversationsListModel() -> ConversationsListModelProtocol {
    let model = ConversationsListModel(coreDataService: serviceAssembly.coreDataService, fireStoreService: serviceAssembly.fireStoreService)
    return model
  }
  
  private func conversationModel() -> ConversationViewModelProtocol {
    let model = ConversationViewModel(coreDataService: serviceAssembly.coreDataService, fireStoreService: serviceAssembly.fireStoreService)
    return model
  }
  
  private func profileModel() -> ProfileModelProtocol {
    let model = ProfileModel()
    return model
  }
  
//  private func settingsModel() -> ConversationViewModelProtocol {
//    let model = ConversationViewModel(coreDataService: serviceAssembly.coreDataService, fireStoreService: serviceAssembly.fireStoreService)
//    return model
//  }
}
