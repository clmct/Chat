//
//  ViewController.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 13.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, ThemesPickerDelegate, UITextFieldDelegate, ProfileModelDelegateProtocol {
  
  // MARK: Stored Properties
  private var isGCD = false
  private var isEdit = false
  var nameString = ""
  var descriptionString = ""
  var image = UIImage()
  var presentationAssembly: PresentationAssemblyProtocol?
  var model: ProfileModelProtocol?
  var theme = ThemeApp(theme: .classic)
  lazy var animationButton = AnimationButton(button: photoButtonOutlet)
  
  // MARK: IBoutlets
  @IBOutlet weak var activityIndicatorOutlet: UIActivityIndicatorView!
  @IBOutlet weak var nameTexrFieldOutlet: UITextField!
  @IBOutlet weak var descriptionTextViewOutlet: UITextView!
  
  @IBOutlet weak var viewOutlet: UIView!
  @IBOutlet weak var imageViewOutlet: UIImageView!
  
  @IBOutlet weak var GCDButton: UIButton!
  @IBOutlet weak var OperationButton: UIButton!
  @IBOutlet weak var photoButtonOutlet: UIButton!
  
  @IBOutlet weak var leftConstraint: NSLayoutConstraint!
  @IBOutlet weak var rightConstraint: NSLayoutConstraint!
  
  // MARK: View Controller Life Cycle
  func setProperties(model: ProfileModelProtocol, presentationAssembly: PresentationAssemblyProtocol) {
    self.model = model
    self.presentationAssembly = presentationAssembly
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  func setImage(image: UIImage) {
    self.imageViewOutlet.image = image
  }
  
  private func setup() {
    create()
    checkEditing()
    model?.read(type: .gcd, completion: { data in
      DispatchQueue.main.async {
        if data.name != "", data.description != "", data.image != nil {
          self.nameTexrFieldOutlet.text = data.name
          self.descriptionTextViewOutlet.text = data.description
          self.imageViewOutlet.image = data.image
        }
      }
      
    })
     
    GCDButton.backgroundColor = theme.profileButton
    GCDButton.accessibilityIdentifier = "gcd"
    OperationButton.backgroundColor = theme.profileButton
    OperationButton.accessibilityIdentifier = "operation"
    view.backgroundColor = theme.backgroundColor
    nameTexrFieldOutlet.textColor = theme.profileText
    descriptionTextViewOutlet.textColor = theme.profileText
    imageViewOutlet.image = ImageCreator.shared.imageInitials(name: nameTexrFieldOutlet.text)
    nameTexrFieldOutlet.delegate = self
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    imageViewOutlet.layer.cornerRadius = imageViewOutlet.layer.frame.height / 2
    GCDButton.layer.cornerRadius = GCDButton.layer.frame.height / 3
    OperationButton.layer.cornerRadius = OperationButton.layer.frame.height / 3
  }
  
  // MARK: IBActions
  @IBAction func editPhotoButtonAction(_ sender: Any) {
    if isEdit {
      animationButton.animationToogle()
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
  
  // MARK: Methods
  func updateTheme(theme: ThemeApp) {
    self.theme = theme
  }
  
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
  
  func GCDButtonActionFunc() {
    let data = ProfileData(name: nameTexrFieldOutlet.text, description: descriptionTextViewOutlet.text, image: imageViewOutlet.image)
    model?.write(type: .gcd, profileData: data)
  }
  
  func OperationButtonActionFunc() {
    let data = ProfileData(name: nameTexrFieldOutlet.text, description: descriptionTextViewOutlet.text, image: imageViewOutlet.image)
    model?.write(type: .operation, profileData: data)
  }
  
  private func isUserInteractionEnabled(isEnabled: Bool) {
    self.navigationItem.rightBarButtonItem?.isEnabled = isEnabled
    self.activityIndicatorOutlet.isHidden = isEnabled
    GCDButton.isUserInteractionEnabled = isEnabled
    OperationButton.isUserInteractionEnabled = isEnabled
    self.nameTexrFieldOutlet.isUserInteractionEnabled = isEnabled
    self.descriptionTextViewOutlet.isUserInteractionEnabled = isEnabled
    self.photoButtonOutlet.isUserInteractionEnabled = isEnabled
  }
  
  private func presentImagePickerController(sourceType: UIImagePickerController.SourceType ) {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = sourceType
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true, completion: nil)
  }
}

// MARK: extension text field
extension ProfileViewController {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    nameTexrFieldOutlet.resignFirstResponder()
    checkEditing()
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    print("textFieldDidEndEditing")
  }
  
  func checkEditing() {
    guard let name = nameTexrFieldOutlet.text,
          let description = descriptionTextViewOutlet.text,
          let imag = imageViewOutlet.image else { return }
    
    if isEdit == true, nameString != name, descriptionString != description, image != imag {
      GCDButton.isUserInteractionEnabled = true
      OperationButton.isUserInteractionEnabled = true
      photoButtonOutlet.isUserInteractionEnabled = true
    } else {
      GCDButton.isUserInteractionEnabled = false
      OperationButton.isUserInteractionEnabled = false
      photoButtonOutlet.isUserInteractionEnabled = false
    }
  }
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  // MARK: - Alert Helper Methods
  func alertCameraSimulator() {
    let alert = ProfileAlertFactory.shared.alertCameraSimulator()
    present(alert, animated: true, completion: nil)
  }
  
  func alertOK() {
    let alert = ProfileAlertFactory.shared.alertOK()
    present(alert, animated: true, completion: nil)
    checkEditing()
  }
  
  func alertError() {
    let alert = ProfileAlertFactory.shared.alertError {
      if self.isGCD {
        self.GCDButtonActionFunc()
        self.checkEditing()
      } else {
        self.OperationButtonActionFunc()
        self.checkEditing()
      }
    }
    present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Image Helper Methods
  
  func showPhotoPicker() {
    let alert = ProfileAlertFactory.shared.photoPicker {
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
        self.takePhotoWithCamera()
      } else {
        self.alertCameraSimulator()
      }
    } libraryActionHandler: {
      self.choosePhotoFromLibrary()
    } photoServerActionHandler: {
      self.photoFromServer()
    }
    present(alert, animated: true, completion: nil)
  }
  
  func photoFromServer() {
    if let presentation = presentationAssembly {
      let controller = presentation.picturesViewController()
      controller.vc = self
      showDetailViewController(controller, sender: nil)
    }
  }
  
  // MARK: - Image Picker Delegates
  func takePhotoWithCamera() {
    presentImagePickerController(sourceType: .camera)
  }
  
  func choosePhotoFromLibrary() {
    presentImagePickerController(sourceType: .photoLibrary)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    
    imageViewOutlet.image = image
    checkEditing()
    dismiss(animated: true)
  }
  
}

extension ProfileViewController {
  
  func read(data: ProfileData) {
    self.nameTexrFieldOutlet.text = data.name
    self.descriptionTextViewOutlet.text = data.description
    self.imageViewOutlet.image = data.image
  }
  
  func showAlertError() {
    self.alertError()
  }
  
  func showAlertOK() {
    self.alertOK()
  }
  
  func blockUI() {
    isUserInteractionEnabled(isEnabled: false)
  }
  
  func unBlockUI() {
    isUserInteractionEnabled(isEnabled: true)
  }
}
