//
//  GCDDataManager.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 14.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit


class GCDDataManager: DataManagerProtocol  {
  init(vc: ProfileViewController) {
    self.vc = vc
  }
  
  private var serialQueue = DispatchQueue(label: "serial")
  
  private var test1 = "Marina Dudarenko"
  private var test2 = "UX/UI designer, web-designer Moscow, Russia"
  
  private let vc: ProfileViewController
  var name: String?
  var description: String?
  var image: UIImage?
  
  private let nameFile = "name.txt"
  private let descriptionFile = "description.txt"
  private let imageFile = "image.png"
  
  func write() {
    vc.activityIndicatorOutlet.isHidden = false
    serialQueue.asyncAfter(deadline: .now(), execute: {
      
      if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let nameURL = dir.appendingPathComponent(self.nameFile)
        let descriptionURL = dir.appendingPathComponent(self.descriptionFile)
        let imageURL = dir.appendingPathComponent(self.imageFile)
        do {
          if let name = self.name {
            try name.write(to: nameURL, atomically: false, encoding: .utf8)
          }
          
          if let description = self.description {
            try description.write(to: descriptionURL, atomically: false, encoding: .utf8)
          }
          
          if let image = self.image {
            try image.pngData()?.write(to: imageURL)
          }
          
          DispatchQueue.main.async {
            self.vc.activityIndicatorOutlet.isHidden = true
            self.vc.alertOK()
            
          }
        } catch {
          print("error write GCD")
          self.vc.alertError()
          
        }
      }
      
      
    })
    
  }
  
  func read() {
    serialQueue.asyncAfter(deadline: .now(), execute: {
      
      
      if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let nameURL = dir.appendingPathComponent(self.nameFile)
        let descriptionURL = dir.appendingPathComponent(self.descriptionFile)
        let imageURL = dir.appendingPathComponent(self.imageFile)
        do {
          let name = try String(contentsOf: nameURL, encoding: .utf8)
          let description = try String(contentsOf: descriptionURL, encoding: .utf8)
          let imageData = try Data(contentsOf: imageURL)
          let image = UIImage(data: imageData)
          
          
          DispatchQueue.main.async {
            self.vc.nameTexrFieldOutlet.text = name
            self.vc.descriptionTextViewOutlet.text = description
            self.vc.imageViewOutlet.image = image
            
            self.vc.nameString = name
            self.vc.descriptionString = description
            self.vc.image = image ?? UIImage()
          }
          
        } catch {
          print("error read")
          print(error)
        }
        
      }
    })
    
  }
  
}
