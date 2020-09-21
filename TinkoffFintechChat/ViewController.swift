//
//  ViewController.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 13.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var viewOutlet: UIView!
  
  @IBOutlet weak var imageViewOutlet: UIImageView!
  
  @IBOutlet weak var labelNameOutlet: UILabel!
  
  @IBOutlet weak var labelDescreptionOutlet: UILabel!
  
  @IBOutlet weak var saveButtonOutlet: UIButton!
    
  convenience init() {
    self.init()
    print(saveButtonOutlet.frame)
    print(1)
    //
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageViewOutlet.image = UIImage(named: "Logo_profile")
    saveButtonOutlet.layer.cornerRadius = 14
    imageViewOutlet.layer.cornerRadius = imageViewOutlet.frame.height/2
    
    print(saveButtonOutlet.frame)
    print(2)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    print(saveButtonOutlet.frame)
    print(3)
  }
  
  @IBAction func editButton(_ sender: Any) {
    showPhotoPicker()
  }
  
  @IBAction func saveButton(_ sender: Any) {
    
  }
  
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK:- Image Helper Methods
  
  func showPhotoPicker() {
    let photoAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
    photoAlert.addAction(cancelAction)
    
    let cameraAction = UIAlertAction(title: "Сделать фото", style: .default, handler: { _ in
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
        self.takePhotoWithCamera()
      }
    })
    photoAlert.addAction(cameraAction)
    
    let libraryAction = UIAlertAction(title: "Установить из галлереи", style: .default, handler: { _ in self.choosePhotoFromLibrary() })
    photoAlert.addAction(libraryAction)
    
    present(photoAlert, animated: true, completion: nil)
  }
  
  // MARK:- Image Picker Delegates
  
  func takePhotoWithCamera() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .camera
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true, completion: nil)
  }
  
  func choosePhotoFromLibrary() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .photoLibrary
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true, completion: nil)
  }
  
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    
    imageViewOutlet.image = image
    dismiss(animated: true)
  }
  
}
