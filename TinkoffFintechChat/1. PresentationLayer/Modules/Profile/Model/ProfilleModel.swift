//
//  Model.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 12.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

protocol ProfileModelProtocol: class {
//  func read() -> ProfileData
  func read(type: Type, completion: @escaping (ProfileData) -> Void)
  func write(type: Type, profileData: ProfileData)
  var delegate: ProfileModelDelegateProtocol? { get set }
}

protocol ProfileModelDelegateProtocol: class {
  func showAlertError()
  func showAlertOK()
  func blockUI()
  func unBlockUI()
}

struct ProfileData {
  var name: String?
  var description: String?
  var image: UIImage?
}

enum Type {
  case gcd
  case operation
}

class ProfileModel: ProfileModelProtocol {
  
  var delegate: ProfileModelDelegateProtocol?
  
  let urlName = "name"
  let urlDescription = "description"
  let urlImage = "image"
  
  internal func write(type: Type, profileData: ProfileData) { // вынести в сущность и сделть клмпдищн
    
//    delegate?.blockUI()
    
    var dataManager: DataManagerProtocol
    if type == .gcd {
      dataManager = dataManagerGCD
    } else {
      dataManager = dataManagerOperation
    }
    
    if let name = profileData.name {
      if let data = name.data(using: .utf8) {
        dataManager.write(data: data, urlString: urlName)
      }
    }
    
    if let description = profileData.description {
      if let data = description.data(using: .utf8) {
        dataManager.write(data: data, urlString: urlDescription)
      }
    }
    
    if let image = profileData.image {
      if let data = image.pngData() {
        dataManager.write(data: data, urlString: urlImage)
      }
    }
    
//    delegate?.unBlockUI()
    
  }
  
  func read(type: Type, completion: @escaping (ProfileData) -> Void) {
    var profileData = ProfileData(name: nil, description: nil, image: nil)
    
    var dataManager: DataManagerProtocol
    if type == .gcd {
      dataManager = dataManagerGCD
    } else {
      dataManager = dataManagerOperation
    }
    
    dataManager.read(urlString: urlName) { data in
      if let data = data {
        profileData.name = String(decoding: data, as: UTF8.self)
      }
      
      dataManager.read(urlString: self.urlDescription) { data in
        if let data = data {
          profileData.description = String(decoding: data, as: UTF8.self)
        }
        
        dataManager.read(urlString: self.urlImage) { data in
          if let data = data {
            profileData.image = UIImage(data: data)
          }
          completion(profileData)
        }
      }
    }
  }
  
  // init
  var dataManagerGCD: DataManagerProtocol
  var dataManagerOperation: DataManagerProtocol
  
  init(dataManagerGCD: DataManagerProtocol, dataManagerOperation: DataManagerProtocol) {
    self.dataManagerGCD = dataManagerGCD
    self.dataManagerOperation = dataManagerOperation
  }
  
  }
