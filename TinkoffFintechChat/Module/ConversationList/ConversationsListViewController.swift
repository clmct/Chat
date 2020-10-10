//
//  ConversationsListViewController.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

extension UITableView {
    func deselectSelectedRow(animated: Bool) {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }
}

class ConversationsListViewController: UIViewController, UITableViewDelegate, ThemesPickerDelegate {
  
  func updateTheme(theme: ThemeApp) {
    self.theme = theme
    tableView.reloadData()
    navigationController?.navigationBar.barTintColor = theme.navigationBar
    UINavigationBar.appearance().barStyle = theme.barStyle
    navigationController?.navigationBar.titleTextAttributes = [
      NSAttributedString.Key.foregroundColor:
      theme.navigationBarTitle ]
  }
  
  var theme = ThemeApp(theme: .night)
  
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
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    
    if let controller = storyboard.instantiateViewController(withIdentifier: "profile") as? ProfileViewController {
      let navVC = UINavigationController(rootViewController: controller)
      controller.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(cancelMethod))
      controller.updateTheme(theme: theme)
      show(navVC, sender: nil)
    } else {
      return
    }
  }
  @objc func settingsMethod() {
    let storyboard = UIStoryboard(name: "Themes", bundle: nil)
    if let controller = storyboard.instantiateViewController(withIdentifier: "settings") as? ThemesViewController {
      controller.delegate = self
      controller.theme = theme
      controller.closure = {  [weak self] theme in
        self?.theme = theme
        self?.tableView.reloadData()
        self?.navigationController?.navigationBar.barTintColor = theme.navigationBar
        UINavigationBar.appearance().barStyle = theme.barStyle
        self?.navigationController?.navigationBar.titleTextAttributes = [
          NSAttributedString.Key.foregroundColor:
          theme.navigationBarTitle ]
      }
      
      navigationController?.pushViewController(controller, animated: true)
    }
  }
  
  @objc func cancelMethod() {
    dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    title = "Tinkoff Chat"
    navigationController?.navigationBar.prefersLargeTitles = false
    button.setImage(image?.resized(withBounds: CGSize(width: 36, height: 36)), for: .normal)
    button.layer.cornerRadius = 18
    button.clipsToBounds = true
    button.addTarget(self, action: #selector(methodBar), for: .touchUpInside)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .done, target: self, action: #selector(settingsMethod))
    createTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.tableView.deselectSelectedRow(animated: true)
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
  

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

      let label = UILabel()
      label.text = sectionTitles[section]
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.textColor = theme.sectionHeaderText

    label.translatesAutoresizingMaskIntoConstraints = false
      let containerView = UIView()
    containerView.backgroundColor = theme.sectionHeader

      containerView.addSubview(label)
      label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
      label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true


      return containerView
  }


  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    35
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let controller = ConversationViewController()
    let model = data[indexPath.section][indexPath.row].messages
    controller.data = model
    controller.updateTheme(theme: theme)
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
      cell.updateTheme(theme: theme)
      
      return cell
    } else {
      return UITableViewCell()
    }
  }
}
