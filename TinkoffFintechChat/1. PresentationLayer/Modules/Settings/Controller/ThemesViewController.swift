//
//  Button.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 06.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

protocol ThemesPickerDelegate: class {
  func updateTheme(theme: ThemeApp)
  var theme: ThemeApp { get set }
}

// retain cycle мог возникунть при сильных ссылках
// двух классов друг на друга
// в нашем случае он не мог возникнуть

class ThemesViewController: UIViewController { // TO DO upgrade?
  
  @IBOutlet weak var classicOutlet: UIButton!
  
  @IBOutlet weak var dayOutlet: UIButton!
  
  @IBOutlet weak var nightOutlet: UIButton!
  
  var delegate: ThemesPickerDelegate?
  
  var closure: ((ThemeApp) -> Void )?
  
  var theme = ThemeApp(theme: .night)
  
  @objc func backToInitial(sender: AnyObject) {
    self.navigationController?.popViewController(animated: true)
    
  }

  deinit {
//    print("deinit")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    print("init")
    view.backgroundColor = UIColor(red: 0.10, green: 0.21, blue: 0.38, alpha: 1.00)
    classicOutlet.layer.cornerRadius = 18
    classicOutlet.layer.masksToBounds = true
    classicOutlet.accessibilityIdentifier = "classic"
    dayOutlet.layer.cornerRadius = 18
    dayOutlet.layer.masksToBounds = true
    dayOutlet.accessibilityIdentifier = "day"
    nightOutlet.layer.cornerRadius = 18
    nightOutlet.layer.masksToBounds = true
    nightOutlet.accessibilityIdentifier = "night"
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
  func classicMode() {
    theme.theme = .classic
    updateTheme()
    classicSelected()
  }
  
  func dayMode() {
    theme.theme = .day
    updateTheme()
    daySelected()
  }
  
  func nightMode() {
    theme.theme = .night
    updateTheme()
    nightSelected()
  }
  
  func updateTheme() {
    navigationController?.navigationBar.barTintColor = theme.navigationBar
    DispatchQueue.main.async {
//      self.delegate?.updateTheme(theme: self.theme)
      self.closure?(self.theme)
      UserDefaults.standard.set(self.theme.theme.rawValue, forKey: "theme")
    }
  }
  
  @IBAction func classicAction(_ sender: Any) {
    classicMode()
  }
  
  @IBAction func dayAction(_ sender: Any) {
    dayMode()
  }
  
  @IBAction func nightAction(_ sender: Any) {
    nightMode()
  }
  
  @IBAction func classicButton(_ sender: Any) {
    classicMode()
  }
  
  @IBAction func dayButton(_ sender: Any) {
    dayMode()
  }
  
  @IBAction func nightButton(_ sender: Any) {
    nightMode()
  }
  
}
