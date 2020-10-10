//
//  ConversationViewController.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ThemesPickerDelegate {
  func updateTheme(theme: ThemeApp) {
    self.theme = theme
  }
  
  var theme: ThemeApp = ThemeApp(theme: .classic)
  
  private let identifire = "conversation"
  
  var data: [Messages] = [Messages]()
  
  lazy private var tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createTableView()
    }
  
  func createTableView() {
    tableView = UITableView(frame: view.bounds, style: .plain)
    tableView.separatorStyle = .none
    tableView.register(ConversationCell.self, forCellReuseIdentifier: identifire)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(tableView)
  }
  
  // MARK: Table View
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath) as? ConversationCell {
      
      let message = data[indexPath.row]
      
      let conf = MessageCellModel(text: message.message, isIncoming: message.isIncoming)
      cell.configure(with: conf)
      cell.updateTheme(theme: theme)
      return cell
    } else {
      return UITableViewCell()
    }
  }
}
