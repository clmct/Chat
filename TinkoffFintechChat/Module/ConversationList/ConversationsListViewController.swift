//
//  ConversationsListViewController.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, UITableViewDelegate {
    
  var data: [[ConversationModel]] = [[ConversationModel]]()
  
  lazy private var tableView = UITableView()
  private let identifire = "conversationsList"
  
  private let sectionTitles = ["Online","History"]
  
  lazy private var image = imageInitials(name: "Marina Dudarenko")
  
  lazy private var button: UIButton = {
    var btn = UIButton()
    return btn
  }()
  
  @objc func methodBar() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    if let controller = storyboard.instantiateViewController(withIdentifier: "profile") as? ProfileViewController {
      let navVC = UINavigationController(rootViewController: controller)
      controller.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(candelMethod))
      show(navVC, sender: nil)
    } else {
      return
    }
  }
  
  @objc func candelMethod() {
    dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() { 
    super.viewDidLoad()
    title = "Tinkoff Chat"
    navigationController?.navigationBar.prefersLargeTitles = true
    button.setImage(image?.resized(withBounds: CGSize(width: 36, height: 36)), for: .normal)
    button.layer.cornerRadius = 18
    button.clipsToBounds = true
    button.addTarget(self, action: #selector(methodBar), for: .touchUpInside)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    createTableView()
  }
  
  func createTableView() {
    self.tableView = UITableView(frame: view.bounds, style: .plain)
    tableView.register(ConversationsListCell.self, forCellReuseIdentifier: identifire)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(tableView)
  }
}

extension ConversationsListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    data.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionTitles[section]
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let controller = ConversationViewController()
    let model = data[indexPath.section][indexPath.row].messages
    controller.data = model
    controller.title = data[indexPath.section][indexPath.row].name
    navigationController?.pushViewController(controller, animated: true)
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    data[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath) as? ConversationsListCell {

      let model = data[indexPath.section][indexPath.row]
      var message = "No messages yet"
      var date = Date()
      if let mes = model.messages.last {
        message = mes.message
        date = mes.date
      }
      
      let conf = ConversationCellModel(name: model.name,
                                       message: message,
                                       date: date,
                                       isOnline: model.isOnline,
                                       hasUnreadMessages: model.hasUnreadMessages)
      cell.configure(with: conf)
      
      return cell
    } else {
      return UITableViewCell()
    }
  }
}
