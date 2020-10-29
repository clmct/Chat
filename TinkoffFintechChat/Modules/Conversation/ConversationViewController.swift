//
//  ConversationViewController.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ThemesPickerDelegate {
  
  var theme: ThemeApp = ThemeApp(theme: .classic)
  private let identifire = "conversation"
  var data: [MessageModel] = [MessageModel]()
  lazy private var tableView = UITableView()
  var messageTextField = String()
  var id: String?
  weak var VC: ConversationsListViewController?
  
  lazy var inputContainerView: UIView = {
    let containerView = UIView()
    containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 80)
    containerView.autoresizingMask = [.flexibleHeight]
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.backgroundColor = theme.barTint.withAlphaComponent(0.97)
    
    let textField = UITextField()
    textField.placeholder = "Enter message..."
    textField.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(textField)
    textField.delegate = self
    textField.returnKeyType = UIReturnKeyType.send
    textField.textColor = theme.textIncoming
    textField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 30).isActive = true
    textField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -30).isActive = true
    textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
    textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30).isActive = true
    
    let separatorLineView = UIView()
    separatorLineView.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(separatorLineView)
    separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
    separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
    separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    return containerView
  }()
  
  override var inputAccessoryView: UIView? {
      return inputContainerView
  }
  
  override var canBecomeFirstResponder: Bool { return true }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    VC?.fetchData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createTableView()
    tableView.keyboardDismissMode = .interactive
    tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 60, right: 0)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  func updateTheme(theme: ThemeApp) {
    self.theme = theme
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
      cell.configure(with: message)
      cell.updateTheme(theme: theme)
      return cell
    } else {
      let cell = UITableViewCell()
      cell.backgroundColor = theme.backgroundColor
      return cell
    }
  }
}

extension ConversationViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let id = id, let message = textField.text {
      FireStoreService.shared.createMessage(identifire: id, newMessage: message)
      textField.text = ""
      FireStoreService.shared.fetchDataMessages(identifire: id) { data in
        self.data = data
        self.tableView.reloadData()
      }
    }
    return true
  }
}
