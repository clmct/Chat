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
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    // MARK: - Frame button - init
    // Logger.printSaveButtonFrame(buttonFrame: saveButtonOutlet.frame, nameFunc: #function)
    // Ошибка. Так как кнопка еще не инициализирована и имеет знаечние nil. Мы не можем обратится к свойсву frame!
    // Если мы распечатаем saveButtonOutlet, то убедимся в этом сами.
    // print(saveButtonOutlet)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageViewOutlet.image = UIImage(named: "Logo_profile")
    saveButtonOutlet.layer.cornerRadius = 14
    imageViewOutlet.layer.cornerRadius = imageViewOutlet.frame.height/2
    
    Logger.printSaveButtonFrame(buttonFrame: saveButtonOutlet.frame, nameFunc: #function)
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    Logger.printSaveButtonFrame(buttonFrame: saveButtonOutlet.frame, nameFunc: #function)
    // MARK: - Frame button - viewDidAppear
    // Frame кнопки отличается из за того, что в Main.storyboard выбран iPhone SE(2nd generation), а в качестве запускаемого симулятора выбран iPhone 11.
    // В методе viewDidLoad выводятся кординаты кнопки в iPhone SE(2nd generation), а в методе viewDidAppear кординаты кнопки в симуляторе iPhone 11.
    // ViewDidLoad загружает view,
    // Отличаются только кординаты по X и по Y, высота и ширина не изменяются, так как размеры кнопки зафиксированы.
  }
  
  @IBAction func editButton(_ sender: Any) {
    showPhotoPicker()
  }
  
  @IBAction func saveButton(_ sender: Any) {
    
  }
  
  func alertCameraSimulator() {
    let alert = UIAlertController(title: "Упс... На симуляторе нет камеры!", message: "Попробуйте на реальном девайсе. Кнопка представлена на симуляторе в целях прототипирования для разработчиков.", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
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
      } else {
        self.alertCameraSimulator()
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
