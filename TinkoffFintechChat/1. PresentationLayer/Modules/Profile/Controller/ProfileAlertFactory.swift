//
//  ProfileAlertFactory.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 17.01.2022.
//  Copyright © 2022 Алмат Кульбаев. All rights reserved.
//

import UIKit

class ProfileAlertFactory {
  
  static let shared = ProfileAlertFactory()
  
  private init() {}
  
  func alertCameraSimulator() -> UIAlertController {
    let alert = UIAlertController(title: "Упс... На симуляторе нет камеры!",
                                  message: "Попробуйте на реальном девайсе. Кнопка представлена на симуляторе в целях прототипирования для разработчиков.", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
    alert.addAction(cancelAction)
    return alert
  }
  
  func alertOK() -> UIAlertController {
    let alert = UIAlertController(title: "Данные сохранены", message: "", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    return alert
  }
  
  func alertError(repeatActionHandler: (() -> Void)?) -> UIAlertController {
    let alert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    let repeatAction = UIAlertAction(title: "Повторить", style: .default) { _ in
      repeatActionHandler?()
    }
    alert.addAction(cancelAction)
    alert.addAction(repeatAction)
    return alert
  }
  
  func photoPicker(cameraActionHandler: (() -> Void)?,
                   libraryActionHandler: (() -> Void)?,
                   photoServerActionHandler: (() -> Void)?) -> UIAlertController {
    let photoAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
    photoAlert.addAction(cancelAction)
    
    let cameraAction = UIAlertAction(title: "Сделать фото", style: .default) { _ in
      cameraActionHandler?()
    }
    photoAlert.addAction(cameraAction)
    
    let libraryAction = UIAlertAction(title: "Установить из галлереи", style: .default) { _ in libraryActionHandler?()
    }
    photoAlert.addAction(libraryAction)
    
    let photoServerAction = UIAlertAction(title: "Загрузить", style: .default) { _ in
      photoServerActionHandler?()
    }
    photoAlert.addAction(photoServerAction)
    return photoAlert
  }
}
