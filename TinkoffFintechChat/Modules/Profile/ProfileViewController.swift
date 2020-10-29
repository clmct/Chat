//
//  ViewController.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 13.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, ThemesPickerDelegate, UITextFieldDelegate { // TO DO fix and upgrade
  func updateTheme(theme: ThemeApp) {
    self.theme = theme
  }
  
  var theme = ThemeApp(theme: .classic)
  
  @IBOutlet weak var activityIndicatorOutlet: UIActivityIndicatorView!
  @IBOutlet weak var nameTexrFieldOutlet: UITextField!
  @IBOutlet weak var descriptionTextViewOutlet: UITextView!
  
  @IBOutlet weak var viewOutlet: UIView!
  @IBOutlet weak var imageViewOutlet: UIImageView!
  
  @IBOutlet weak var GCDButton: UIButton!
  @IBOutlet weak var OperationButton: UIButton!
  
  @IBOutlet weak var leftConstraint: NSLayoutConstraint!
  @IBOutlet weak var rightConstraint: NSLayoutConstraint!
  
  lazy var GCD = GCDDataManager(vc: self)
  lazy var Operation = OperationDataManager(vc: self)
  
  private var isGCD = false
  private var isEdit = false
  
  var nameString = ""
  var descriptionString = ""
  var image = UIImage()
  
  func create() {
    title = "My Profile"
    
    leftConstraint.constant = view.bounds.width / 2 + 10
    rightConstraint.constant = view.bounds.width / 2 + 10
    
     _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { _ in
      self.view.frame.origin.y = -150
    }
    
    _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { _ in
      self.view.frame.origin.y = 0.0
    }
    
  }
  
  func buttonBlock() {
    GCDButton.isUserInteractionEnabled = false
    OperationButton.isUserInteractionEnabled = false
    GCDButton.isHighlighted = true
    OperationButton.isHighlighted = true
  }
  
  func buttonUnBlock() {
    GCDButton.isUserInteractionEnabled = true
    OperationButton.isUserInteractionEnabled = true
    GCDButton.isHighlighted = false
    OperationButton.isHighlighted = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    create()
    buttonBlock()
    
    GCDButton.backgroundColor = theme.profileButton
    OperationButton.backgroundColor = theme.profileButton
    view.backgroundColor = theme.backgroundColor
    nameTexrFieldOutlet.textColor = theme.profileText
    descriptionTextViewOutlet.textColor = theme.profileText
    imageViewOutlet.image = imageInitials(name: nameTexrFieldOutlet.text)
    nameTexrFieldOutlet.delegate = self
    
    //    GCD.read()
    Operation.read()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    imageViewOutlet.layer.cornerRadius = imageViewOutlet.layer.frame.height / 2
    GCDButton.layer.cornerRadius = GCDButton.layer.frame.height / 3
    OperationButton.layer.cornerRadius = OperationButton.layer.frame.height / 3
  }
  
  @IBAction func editPhotoButtonAction(_ sender: Any) {
    if isEdit {
      showPhotoPicker()
    }
  }
  
  @IBAction func editButtonAction(_ sender: Any) {
    self.nameTexrFieldOutlet.isUserInteractionEnabled = true
    self.descriptionTextViewOutlet.isUserInteractionEnabled = true
    nameTexrFieldOutlet.becomeFirstResponder()
    isEdit = true
  }
  
  @IBAction func GCDButtonAction(_ sender: Any) {
    GCDButtonActionFunc()
  }
  @IBAction func OperationButtonAction(_ sender: Any) {
    OperationButtonActionFunc()
  }
  
  func GCDButtonActionFunc() {
    isGCD = true
    buttonBlock()
    GCD.name = nameTexrFieldOutlet.text
    GCD.description = descriptionTextViewOutlet.text
    GCD.image = imageViewOutlet.image
    GCD.write()
    self.nameTexrFieldOutlet.isUserInteractionEnabled = false
    self.descriptionTextViewOutlet.isUserInteractionEnabled = false
    isEdit = false
    GCD.read()
  }
  
  func OperationButtonActionFunc() {
    isGCD = false
    buttonBlock()
    Operation.name = nameTexrFieldOutlet.text
    Operation.description = descriptionTextViewOutlet.text
    Operation.image = imageViewOutlet.image
    activityIndicatorOutlet.isHidden = false
    Operation.write()
    self.nameTexrFieldOutlet.isUserInteractionEnabled = false
    self.descriptionTextViewOutlet.isUserInteractionEnabled = false
    isEdit = false
    sleep(1)
    Operation.read()
  }
}

extension ProfileViewController {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    descriptionTextViewOutlet.resignFirstResponder()
    checkEditing()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    nameTexrFieldOutlet.resignFirstResponder()
    checkEditing()
    return true
  }
  
  func checkEditing() {
    
    guard let name = nameTexrFieldOutlet.text,
      let description = descriptionTextViewOutlet.text,
      let imag = imageViewOutlet.image else { return }
    
    if isEdit == true, nameString == name, descriptionString == description, image == imag {
      buttonBlock()
    } else if isEdit == true {
      buttonUnBlock()
    } else {
      buttonBlock()
    }
    
  }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  // MARK: - Alert Helper Methods
  func alertCameraSimulator() {
    let alert = UIAlertController(title: "Упс... На симуляторе нет камеры!",
                                  message: "Попробуйте на реальном девайсе. Кнопка представлена на симуляторе в целях прототипирования для разработчиков.", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }
  
  func alertOK() {
    let alert = UIAlertController(title: "Данные сохранены", message: "", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
    checkEditing()
  }
  
  func alertError() {
    let alert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    let repeatAction = UIAlertAction(title: "Повторить", style: .default, handler: { _ in
      if self.isGCD {
        self.GCDButtonActionFunc()
        self.checkEditing()
      } else {
        self.OperationButtonActionFunc()
        self.checkEditing()
      }
    })
    alert.addAction(cancelAction)
    alert.addAction(repeatAction)
    present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Image Helper Methods
  
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
  
  // MARK: - Image Picker Delegates
  
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
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    
    imageViewOutlet.image = image
    checkEditing()
    dismiss(animated: true)
  }
  
}
