//
//  OperationDataManager.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 14.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit


class OperationDataManager: DataManagerProtocol {
  
  private let nameFile = "name.txt"
  private let descriptionFile = "description.txt"
  private let imageFile = "image.png"
  private var vc: ProfileViewController
  
  var name: String?
  var description: String?
  var image: UIImage?
  
  init(vc: ProfileViewController) {
    self.vc = vc
  }
  
  func write() {
    vc.activityIndicatorOutlet.isHidden = false
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      let nameURL = dir.appendingPathComponent(self.nameFile)
      let descriptionURL = dir.appendingPathComponent(self.descriptionFile)
      let imageURL = dir.appendingPathComponent(self.imageFile)
      let operationQueue = OperationQueue()
      let operation = writeOperation(vc: vc)
      operation.nameURL = nameURL
      operation.descriptionURL = descriptionURL
      operation.imageURL = imageURL
      operation.nameString = name
      operation.descriptionString = description
      operation.image = image
      operationQueue.addOperation(operation)
      vc.activityIndicatorOutlet.isHidden = true
    }
  }
  
  
  func read() {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      let nameURL = dir.appendingPathComponent(self.nameFile)
      let descriptionURL = dir.appendingPathComponent(self.descriptionFile)
      let imageURL = dir.appendingPathComponent(self.imageFile)
      let operationQueue = OperationQueue()
      let operation = readOperation(vc: vc)
      operation.nameURL = nameURL
      operation.descriptionURL = descriptionURL
      operation.imageURL = imageURL
      operationQueue.addOperation(operation)
    }
    
  }
  
}





class writeOperation: Operation {
  var nameURL: URL?
  var descriptionURL: URL?
  var imageURL: URL?
  
  var nameString: String?
  var descriptionString: String?
  var image: UIImage?
  
  private var vc: ProfileViewController
  
  init(vc: ProfileViewController) {
    self.vc = vc
  }
  
  override func main() {
    do {
      if let nameURL = nameURL {
        try nameString?.write(to: nameURL, atomically: false, encoding: .utf8)
      }
      
      if let descriptionURL = descriptionURL {
        try descriptionString?.write(to: descriptionURL, atomically: false, encoding: .utf8)
      }
      
      if let imageURL = imageURL {
        try image?.pngData()?.write(to: imageURL)
      }
    } catch {
    }
    
  }
}

class readOperation: Operation {
  var nameURL: URL?
  var descriptionURL: URL?
  var imageURL: URL?

  var vc: ProfileViewController
  
  init(vc: ProfileViewController) {
    self.vc = vc
  }
  override func main() {
    do {
      guard let nameURL = nameURL,
        let descriptionURL = descriptionURL,
        let imageURL = imageURL else { return }
      
      
      let nameString = try String(contentsOf: nameURL, encoding: .utf8)
      let descriptionString = try String(contentsOf: descriptionURL, encoding: .utf8)
      let imageData = try Data(contentsOf: imageURL)
      let image = UIImage(data: imageData)
      
      DispatchQueue.main.async {
        self.vc.nameTexrFieldOutlet.text = nameString
        self.vc.descriptionTextViewOutlet.text = descriptionString
        self.vc.imageViewOutlet.image = image
        
        self.vc.nameString = nameString
        self.vc.descriptionString = descriptionString
        self.vc.image = image ?? UIImage()
        self.vc.activityIndicatorOutlet.isHidden = true
      }
      
    } catch  {
      print("error write operation")
    }
    
  }
}

