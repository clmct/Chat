//
//  Button.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 06.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

protocol ThemesPickerDelegate: class {
  func updateTheme(theme: ThemesStruct)
}

class ThemesViewController: UIViewController {
  
  @IBOutlet weak var classicOutlet: UIButton!
  
  @IBOutlet weak var dayOutlet: UIButton!
  
  @IBOutlet weak var nightOutlet: UIButton!
  
  weak var delegate: ThemesPickerDelegate?
  
  
  override func viewDidLoad() {
    view.backgroundColor = UIColor(red: 0.10, green: 0.21, blue: 0.38, alpha: 1.00)
    classicOutlet.layer.cornerRadius = 18
    classicOutlet.layer.masksToBounds  = true
    dayOutlet.layer.cornerRadius = 18
    dayOutlet.layer.masksToBounds  = true
    nightOutlet.layer.cornerRadius = 18
    nightOutlet.layer.masksToBounds  = true
    standartBorder()
  }
  
  func standartBorder() {
    classicOutlet.layer.borderColor = UIColor(red: 0.18, green: 0.47, blue: 0.94, alpha: 1.00).cgColor
    dayOutlet.layer.borderColor = UIColor(red: 0.18, green: 0.47, blue: 0.94, alpha: 1.00).cgColor
    nightOutlet.layer.borderColor = UIColor(red: 0.18, green: 0.47, blue: 0.94, alpha: 1.00).cgColor
    classicOutlet.layer.borderWidth = 0.5
    dayOutlet.layer.borderWidth = 0.5
    nightOutlet.layer.borderWidth = 0.5
  }
  
  func classicSelected() {
    standartBorder()
    classicOutlet.layer.borderWidth = 4
  }
  
  func daySelected() {
    standartBorder()
    dayOutlet.layer.borderWidth = 4
  }
  
  func nightSelected() {
    standartBorder()
    nightOutlet.layer.borderWidth = 4
  }
  func classic() {
    delegate?.updateTheme(theme: .init(theme: .classic))
    classicSelected()
  }
  
  func day() {
    delegate?.updateTheme(theme: .init(theme: .day))
    daySelected()
  }
  
  func night() {
    delegate?.updateTheme(theme: .init(theme: .night))
    nightSelected()
  }
  
  @IBAction func classicAction(_ sender: Any) {
    classic()
  }
  
  @IBAction func dayAction(_ sender: Any) {
    day()
  }
  
  @IBAction func nightAction(_ sender: Any) {
    night()
  }
  
  @IBAction func classicButton(_ sender: Any) {
    classic()
  }
  
  @IBAction func dayButton(_ sender: Any) {
    day()
  }
  
  @IBAction func nightButton(_ sender: Any) {
    night()
  }
  
}
