//
//  ConversationViewController.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit
import CoreData

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ThemesPickerDelegate {
  // MARK: Stored Properties
  var theme: ThemeApp = ThemeApp(theme: .classic)
  var id: String
  weak var VC: ConversationsListViewController? // подумать над другим решением
  
  private let identifire = "conversation"
  private var messageTextField = String()
  private let model: ConversationViewModelProtocol
  // MARK: Lazy Stored Properties
  lazy private var tableView = UITableView()
  
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
  
  lazy var fetchedResultsController: NSFetchedResultsController<MessageMO> = {
    let fetchRequest = NSFetchRequest<MessageMO>()
    let enity = MessageMO.entity()
    let sort1 = NSSortDescriptor(key: "created", ascending: true)
    fetchRequest.predicate = NSPredicate(format: "identifier = %@", id)
    fetchRequest.entity = enity
    fetchRequest.sortDescriptors = [sort1]
    fetchRequest.resultType = .managedObjectResultType
    
    let fetchedRequestController = NSFetchedResultsController(
      fetchRequest: fetchRequest,
      managedObjectContext: self.model.mainContext,
      sectionNameKeyPath: nil,
      cacheName: nil)
    
    fetchedRequestController.delegate = self
    return fetchedRequestController
  }()
  
  // MARK: Override Properties
  override var inputAccessoryView: UIView? {
    return inputContainerView
  }
  override var canBecomeFirstResponder: Bool { return true }
  
  // MARK: View Controller Cycle
  init(model: ConversationViewModelProtocol, id: String) {
    self.model = model
//    self.data = data
    self.id = id
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    createTableView()
    //    model.fireStoreService.fetchDataMessages(identifire: id)
    model.fetchDataMessages(identifire: id)
    performFetch()
  }
  
  deinit {
    fetchedResultsController.delegate = nil
    //    NotificationCenter.default.removeObserver()
//    print("deinit ConversationViewController")
  }
  
  func performFetch() {
    do {
      try fetchedResultsController.performFetch()
    } catch {
      fatalError()
    }
    DispatchQueue.global().async {
      self.tableView.reloadData()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    VC?.performFetch()
  }
  
  // MARK: Methods
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
    tableView.keyboardDismissMode = .interactive
    tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 60, right: 0)
    view.addSubview(tableView)
  }
  
  // MARK: Table View
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let count = fetchedResultsController.fetchedObjects?.count ?? 0
    return count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath) as? ConversationCell {
      let message = fetchedResultsController.object(at: indexPath)
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

// MARK: UITextFieldDelegate
extension ConversationViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let message = textField.text {
      model.createMessage(identifire: id, newMessage: message)
      textField.text = ""
    }
    return true
  }
}

// MARK: NSFetchedResultsControllerDelegate
extension ConversationViewController: NSFetchedResultsControllerDelegate {
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//    print("\(#function)")
    self.tableView.beginUpdates()
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//    print("\(#function)")
    self.tableView.endUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                  didChange anObject: Any,
                  at indexPath: IndexPath?,
                  for type: NSFetchedResultsChangeType,
                  newIndexPath: IndexPath?) {
    
    switch type {
    case .insert:
//      print("\(#function) - type insert")
      guard let newIndexPath = newIndexPath else { return }
      tableView.insertRows(at: [newIndexPath], with: .automatic)
    case .move:
//      print("\(#function) - type move")
      guard let newIndexPath = newIndexPath, let indexPath = indexPath else { return }
      tableView.deleteRows(at: [indexPath], with: .automatic)
      tableView.insertRows(at: [newIndexPath], with: .automatic)
    case .update:
//      print("\(#function) - type update")
      guard let indexPath = indexPath else { return }
      if let cell = tableView.cellForRow(at: indexPath) as? ConversationsListCell {
        guard let channel = controller.object(at: indexPath) as? ChannelMO else { return }
        cell.configure(with: channel)
      }
      tableView.reloadRows(at: [indexPath], with: .automatic)
    case .delete:
//      print("\(#function) - type delete")
      guard let indexPath = indexPath else { return }
      tableView.deleteRows(at: [indexPath], with: .automatic)
    default:
      print("switch type is defuailt")
    }
    
  }
  
}
