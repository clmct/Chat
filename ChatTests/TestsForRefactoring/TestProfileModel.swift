//
//  TestProfileModel.swift
//  ChatTests
//
//  Created by Almat Kulbaev on 28.12.2021.
//  Copyright © 2021 Алмат Кульбаев. All rights reserved.
//

import XCTest
@testable import ChatTF

class TestProfileModel: XCTestCase {
  // MARK: read
  // Структурированное базисное тестирование
  
  func testProfileModel_read_shouldReadGCD() {
    // given
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    let expectation = expectation(description: "AsyncExpectation")
    model.read(type: .gcd) { _ in
      expectation.fulfill()
    }
    
    // then
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertEqual(dataManagerGCDMock.writeCount, 0)
    XCTAssertEqual(dataManagerGCDMock.readCount, 3)
    XCTAssertEqual(dataManagerOperation.writeCount, 0)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  func testProfileModel_read_shouldReadOperation() {
    // given
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    let expectation = expectation(description: "AsyncExpectation")
    model.read(type: .operation) { _ in
      expectation.fulfill()
    }
    
    // then
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertEqual(dataManagerGCDMock.writeCount, 0)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 0)
    XCTAssertEqual(dataManagerOperation.readCount, 3)
  }
  
  // MARK: write
  // Структурированное базисное тестирование
  
  // MARK: GCD
  // MARK: 0
  
  func testProfileModel_write_shouldWriteGCD_0() {
    // given
    let profileData = ProfileData(name: nil, description: nil, image: nil)
    
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .gcd, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 0)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 0)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  // MARK: 1
  
  func testProfileModel_write_shouldWriteGCD_1_name() {
    // given
    let profileData = ProfileData(name: "name", description: nil, image: nil)
    
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .gcd, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 1)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 0)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  func testProfileModel_write_shouldWriteGCD_1_description() {
    // given
    let profileData = ProfileData(name: nil, description: "description", image: nil)
    
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .gcd, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 1)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 0)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  func testProfileModel_write_shouldWriteGCD_1_image() {
    // given
    let profileData = ProfileData(name: nil, description: nil, image: UIImage(named: "tinkoff"))
    
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .gcd, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 1)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 0)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  // MARK: 2
  
  func testProfileModel_write_shouldWriteGCD_2_name_description() {
    // given
    let profileData = ProfileData(name: "name", description: "description", image: nil)
    
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .gcd, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 2)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 0)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  func testProfileModel_write_shouldWriteGCD_2_description_image() {
    // given
    let profileData = ProfileData(name: nil, description: "description", image: UIImage(named: "tinkoff"))
    
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .gcd, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 2)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 0)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  func testProfileModel_write_shouldWriteGCD_2_name_image() {
    // given
    let profileData = ProfileData(name: "name", description: nil, image: UIImage(named: "tinkoff"))
    
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .gcd, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 2)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 0)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  // MARK: 3
  
  func testProfileModel_write_shouldWriteGCD_3() {
    // given
    let profileData = ProfileData(name: "name", description: "description", image: UIImage(named: "tinkoff"))
    
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .gcd, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 3)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 0)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  // MARK: Operation
  
  // MARK: 0
  
  func testProfileModel_write_shouldWriteOperation_0() {
    // given
    let profileData = ProfileData(name: nil, description: nil, image: nil)
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .operation, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 0)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 0)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  // MARK: 1
  
  func testProfileModel_write_shouldWriteOperation_1_name() {
    // given
    let profileData = ProfileData(name: "name", description: nil, image: nil)
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .operation, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 0)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 1)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  func testProfileModel_write_shouldWriteOperation_1_description() {
    // given
    let profileData = ProfileData(name: nil, description: "description", image: nil)
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .operation, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 0)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 1)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  func testProfileModel_write_shouldWriteOperation_1_image() {
    // given
    let profileData = ProfileData(name: nil, description: nil, image: UIImage(named: "tinkoff"))
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .operation, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 0)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 1)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  // MARK: 2
  
  func testProfileModel_write_shouldWriteOperation_name_description() {
    // given
    let profileData = ProfileData(name: "name", description: "description", image: nil)
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .operation, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 0)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 2)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  func testProfileModel_write_shouldWriteOperation_2_description_image() {
    // given
    let profileData = ProfileData(name: nil, description: "description", image: UIImage(named: "tinkoff"))
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .operation, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 0)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 2)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  func testProfileModel_write_shouldWriteOperation_name_image() {
    // given
    let profileData = ProfileData(name: "name", description: nil, image: UIImage(named: "tinkoff"))
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .operation, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 0)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 2)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
  
  // MARK: 3
  
  func testProfileModel_write_shouldWriteOperation_3() {
    // given
    let profileData = ProfileData(name: "name", description: "description", image: UIImage(named: "tinkoff"))
    let dataManagerGCDMock = DataManagerMock()
    let dataManagerOperation = DataManagerMock()
    let model: ProfileModelProtocol = ProfileModel(dataManagerGCD: dataManagerGCDMock,
                                                   dataManagerOperation: dataManagerOperation)
    
    // when
    model.write(type: .operation, profileData: profileData)
    
    // then
    XCTAssertEqual(dataManagerGCDMock.writeCount, 0)
    XCTAssertEqual(dataManagerGCDMock.readCount, 0)
    XCTAssertEqual(dataManagerOperation.writeCount, 3)
    XCTAssertEqual(dataManagerOperation.readCount, 0)
  }
}
