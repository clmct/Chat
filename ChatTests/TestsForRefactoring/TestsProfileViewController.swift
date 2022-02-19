//
//  TestsForRefactoring.swift
//  ChatTests
//
//  Created by Almat Kulbaev on 28.12.2021.
//  Copyright © 2021 Алмат Кульбаев. All rights reserved.
//

import XCTest
@testable import ChatTF

class TestsProfileViewController: XCTestCase {
  
  // MARK: checkEditing
  // Структурированное базисное тестирование
  // Тестирование, основанное на потоках данных
  
  func testProfileViewController_checkEditing_shouldUnblockUI() throws {
    // given
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "profile")
            as? ProfileViewController else { return }
    viewController.loadView()
    viewController.viewDidLoad()
    
    let nameString = viewController.nameString
    let descriptionString = viewController.descriptionString
    let image = viewController.image
    
    viewController.nameTexrFieldOutlet.text = nameString
    viewController.descriptionTextViewOutlet.text = descriptionString
    viewController.imageViewOutlet.image = image
    
    // when
    viewController.checkEditing()
    
    // then
    XCTAssert(!viewController.GCDButton.isUserInteractionEnabled)
    XCTAssert(!viewController.OperationButton.isUserInteractionEnabled)
    XCTAssert(!viewController.photoButtonOutlet.isUserInteractionEnabled)
  }
  
  func testProfileViewController_checkEditing_shouldBlockUI_name() throws {
    // given
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "profile")
            as? ProfileViewController else { return }
    viewController.loadView()
    viewController.viewDidLoad()
    
    let nameString = viewController.nameString
    let descriptionString = viewController.descriptionString
    let image = viewController.image
    
    viewController.nameTexrFieldOutlet.text = nameString + "string"
    viewController.descriptionTextViewOutlet.text = descriptionString
    viewController.imageViewOutlet.image = image
    
    // when
    viewController.checkEditing()
    
    // then
    XCTAssert(!viewController.GCDButton.isUserInteractionEnabled)
    XCTAssert(!viewController.OperationButton.isUserInteractionEnabled)
    XCTAssert(!viewController.photoButtonOutlet.isUserInteractionEnabled)
  }
  
  func testProfileViewController_checkEditing_shouldBlockUI_description() throws {
    // given
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "profile")
            as? ProfileViewController else { return }
    viewController.loadView()
    viewController.viewDidLoad()
    
    let nameString = viewController.nameString
    let descriptionString = viewController.descriptionString
    let image = viewController.image
    
    viewController.nameTexrFieldOutlet.text = nameString
    viewController.descriptionTextViewOutlet.text = descriptionString + "string"
    viewController.imageViewOutlet.image = image
    
    // when
    viewController.checkEditing()
    
    // then
    XCTAssert(!viewController.GCDButton.isUserInteractionEnabled)
    XCTAssert(!viewController.OperationButton.isUserInteractionEnabled)
    XCTAssert(!viewController.photoButtonOutlet.isUserInteractionEnabled)
  }
  
  func testProfileViewController_checkEditing_shouldBlockUI_image() throws {
    // given
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "profile")
            as? ProfileViewController else { return }
    viewController.loadView()
    viewController.viewDidLoad()
    
    let nameString = viewController.nameString
    let descriptionString = viewController.descriptionString
    
    viewController.nameTexrFieldOutlet.text = nameString
    viewController.descriptionTextViewOutlet.text = descriptionString + "string"
    viewController.imageViewOutlet.image = UIImage(named: "tinkoff")
    
    // when
    viewController.checkEditing()
    
    // then
    XCTAssert(!viewController.GCDButton.isUserInteractionEnabled)
    XCTAssert(!viewController.OperationButton.isUserInteractionEnabled)
    XCTAssert(!viewController.photoButtonOutlet.isUserInteractionEnabled)
  }
  
  func testProfileViewController_checkEditing_shouldBlockUI_name_description() throws {
    // given
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "profile")
            as? ProfileViewController else { return }
    viewController.loadView()
    viewController.viewDidLoad()
    
    let nameString = viewController.nameString
    let descriptionString = viewController.descriptionString
    let image = viewController.image
    
    viewController.nameTexrFieldOutlet.text = nameString + "string"
    viewController.descriptionTextViewOutlet.text = descriptionString + "string"
    viewController.imageViewOutlet.image = image
    
    // when
    viewController.checkEditing()
    
    // then
    XCTAssert(!viewController.GCDButton.isUserInteractionEnabled)
    XCTAssert(!viewController.OperationButton.isUserInteractionEnabled)
    XCTAssert(!viewController.photoButtonOutlet.isUserInteractionEnabled)
  }
  
  func testProfileViewController_checkEditing_shouldBlockUI_name_image() throws {
    // given
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "profile")
            as? ProfileViewController else { return }
    viewController.loadView()
    viewController.viewDidLoad()
    
    let nameString = viewController.nameString
    let descriptionString = viewController.descriptionString
    
    viewController.nameTexrFieldOutlet.text = nameString + "string"
    viewController.descriptionTextViewOutlet.text = descriptionString
    viewController.imageViewOutlet.image = UIImage(named: "tinkoff")
    
    // when
    viewController.checkEditing()
    
    // then
    XCTAssert(!viewController.GCDButton.isUserInteractionEnabled)
    XCTAssert(!viewController.OperationButton.isUserInteractionEnabled)
    XCTAssert(!viewController.photoButtonOutlet.isUserInteractionEnabled)
  }
  
  func testProfileViewController_checkEditing_shouldBlockUI_description_image() throws {
    // given
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "profile")
            as? ProfileViewController else { return }
    viewController.loadView()
    viewController.viewDidLoad()
    
    let nameString = viewController.nameString
    let descriptionString = viewController.descriptionString
    
    viewController.nameTexrFieldOutlet.text = nameString
    viewController.descriptionTextViewOutlet.text = descriptionString + "string"
    viewController.imageViewOutlet.image = UIImage(named: "tinkoff")
    
    // when
    viewController.checkEditing()
    
    // then
    XCTAssert(!viewController.GCDButton.isUserInteractionEnabled)
    XCTAssert(!viewController.OperationButton.isUserInteractionEnabled)
    XCTAssert(!viewController.photoButtonOutlet.isUserInteractionEnabled)
  }
  
  func testProfileViewController_checkEditing_shouldBlockUI_name_description_image() throws {
    // given
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "profile")
            as? ProfileViewController else { return }
    viewController.loadView()
    viewController.viewDidLoad()
    
    let nameString = viewController.nameString
    let descriptionString = viewController.descriptionString
    let image = viewController.image
    
    viewController.nameTexrFieldOutlet.text = nameString + "string"
    viewController.descriptionTextViewOutlet.text = descriptionString + "string"
    viewController.imageViewOutlet.image = image
    
    // when
    viewController.checkEditing()
    
    // then
    XCTAssert(!viewController.GCDButton.isUserInteractionEnabled)
    XCTAssert(!viewController.OperationButton.isUserInteractionEnabled)
    XCTAssert(!viewController.photoButtonOutlet.isUserInteractionEnabled)
  }
  
  func testProfileViewController_checkEditing_shouldBlockUI_nameNil() throws {
    // given
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "profile")
            as? ProfileViewController else { return }
    viewController.loadView()
    viewController.viewDidLoad()

    let descriptionString = viewController.descriptionString
    let image = viewController.image

    viewController.nameTexrFieldOutlet.text = nil
    viewController.descriptionTextViewOutlet.text = descriptionString
    viewController.imageViewOutlet.image = image

    // when
    viewController.checkEditing()

    // then
    XCTAssert(!viewController.GCDButton.isUserInteractionEnabled)
    XCTAssert(!viewController.OperationButton.isUserInteractionEnabled)
    XCTAssert(!viewController.photoButtonOutlet.isUserInteractionEnabled)
  }
  
  func testProfileViewController_checkEditing_shouldBlockUI_descriptionNil() throws {
    // given
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "profile")
            as? ProfileViewController else { return }
    viewController.loadView()
    viewController.viewDidLoad()

    let nameString = viewController.nameString
    let image = viewController.image

    viewController.nameTexrFieldOutlet.text = nameString
    viewController.descriptionTextViewOutlet.text = nil
    viewController.imageViewOutlet.image = image

    // when
    viewController.checkEditing()

    // then
    XCTAssert(!viewController.GCDButton.isUserInteractionEnabled)
    XCTAssert(!viewController.OperationButton.isUserInteractionEnabled)
    XCTAssert(!viewController.photoButtonOutlet.isUserInteractionEnabled)
  }
  
  func testProfileViewController_checkEditing_shouldReturn_imageNil() throws {
    // given
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "profile")
            as? ProfileViewController else { return }
    viewController.loadView()
    viewController.viewDidLoad()
    
    let nameString = viewController.nameString
    let descriptionString = viewController.descriptionString

    viewController.nameTexrFieldOutlet.text = nameString
    viewController.descriptionTextViewOutlet.text = descriptionString
    viewController.imageViewOutlet.image = nil

    let x1 = viewController.GCDButton.isUserInteractionEnabled
    let x2 = viewController.OperationButton.isUserInteractionEnabled
    let x3 = viewController.photoButtonOutlet.isUserInteractionEnabled
    
    // when
    viewController.checkEditing()

    // then
    XCTAssertEqual(x1, viewController.GCDButton.isUserInteractionEnabled)
    XCTAssertEqual(x2, viewController.OperationButton.isUserInteractionEnabled)
    XCTAssertEqual(x3, viewController.photoButtonOutlet.isUserInteractionEnabled)
  }
  
  // MARK: blockUI
  // Тестирование, основанное на потоках данных
  
  func testProfileViewController_blockUI_shouldBlockUI() throws {
    // given
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "profile")
            as? ProfileViewController else { return }
    viewController.loadView()
    viewController.viewDidLoad()
    
    // when
    viewController.blockUI()
    
    // then
    XCTAssert(!viewController.activityIndicatorOutlet.isHidden)
    XCTAssert(!viewController.GCDButton.isUserInteractionEnabled)
    XCTAssert(!viewController.OperationButton.isUserInteractionEnabled)
    XCTAssert(!viewController.nameTexrFieldOutlet.isUserInteractionEnabled)
    XCTAssert(!viewController.descriptionTextViewOutlet.isUserInteractionEnabled)
    XCTAssert(!viewController.photoButtonOutlet.isUserInteractionEnabled)
  }
  
  // MARK: unblockUI
  // Классы хороших данных
  
  func testProfileViewController_unBlockUI_shouldUnBlockUI() throws {
    // given
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "profile")
            as? ProfileViewController else { return }
    viewController.loadView()
    viewController.viewDidLoad()
    
    // when
    viewController.unBlockUI()
    
    // then
    XCTAssert(viewController.activityIndicatorOutlet.isHidden)
    XCTAssert(viewController.GCDButton.isUserInteractionEnabled)
    XCTAssert(viewController.OperationButton.isUserInteractionEnabled)
    XCTAssert(viewController.nameTexrFieldOutlet.isUserInteractionEnabled)
    XCTAssert(viewController.descriptionTextViewOutlet.isUserInteractionEnabled)
    XCTAssert(viewController.photoButtonOutlet.isUserInteractionEnabled)
  }
  
  // MARK: read
  // Тестирование, основанное на потоках данных
  // Классы хороших данных
  
  func testProfileViewController_read_shouldRead() throws {
    
    // given
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "profile")
            as? ProfileViewController else { return }
    viewController.loadView()
    viewController.viewDidLoad()
    
    let data = ProfileData(name: "name", description: "description", image: UIImage(named: "tinkoff"))
    
    // when
    viewController.read(data: data)
    
    // then
    XCTAssertEqual(viewController.nameTexrFieldOutlet.text, data.name)
    XCTAssertEqual(viewController.descriptionTextViewOutlet.text, data.description)
    XCTAssertEqual(viewController.imageViewOutlet.image, data.image)
  }
}
