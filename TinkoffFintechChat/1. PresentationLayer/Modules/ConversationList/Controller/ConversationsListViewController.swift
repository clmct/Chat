//
//  ConversationsListViewController.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit
//import Firebase
import CoreData

class ConversationsListViewController: UIViewController, UITableViewDelegate, ThemesPickerDelegate {
  // MARK: Stored Properties
  private var tableView = UITableView()
  private let identifire = "conversationsList"
  private let presentationAssembly: PresentationAssemblyProtocol
  internal var theme = ThemeApp(theme: .night)
  private let model: ConversationsListModelProtocol
  
  // MARK: Lazy Stored Properties
  lazy var fetchedResultsController: NSFetchedResultsController<ChannelMO> = {
    let fetchRequest = NSFetchRequest<ChannelMO>()
    let enity = ChannelMO.entity()
    let sort1 = NSSortDescriptor(key: "lastActivity", ascending: false)
    let sort2 = NSSortDescriptor(key: "name", ascending: true)
    fetchRequest.entity = enity
    fetchRequest.sortDescriptors = [sort1, sort2]
    fetchRequest.resultType = .managedObjectResultType
    
    let fetchedRequestController = NSFetchedResultsController(
      fetchRequest: fetchRequest,
      managedObjectContext: self.model.mainContext,
      sectionNameKeyPath: nil,
      cacheName: nil)
    
    fetchedRequestController.delegate = self
    return fetchedRequestController
  }()
  
  lazy private var image = imageInitials(name: "Marina Dudarenko")
  
  lazy private var button: UIButton = {
    var btn = UIButton()
    return btn
  }()
  
  // MARK: Objective-C Functions
  @objc func methodBar() {
    if let controller = presentationAssembly.profileViewController() {
      controller.updateTheme(theme: theme)
      show(controller, sender: nil)
//      showDetailViewController(controller, sender: nil)
    } else {
      return
    }
  }
  
  @objc func settingsMethod() {
    if let controller = presentationAssembly.themesViewController() {
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
  
  @objc func addChannelMethod() {
    let alert = UIAlertController(title: "Название канала", message: "", preferredStyle: .alert)
    alert.addTextField(configurationHandler: nil )
    let createAction = UIAlertAction(title: "Создать", style: .default) { UIAlertAction in
      let nameChannel = alert.textFields?.first?.text
      
      UIAlertAction.isEnabled = false
      self.model.createChannel(newChannel: nameChannel ?? "")
    }
    let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
    alert.addAction(createAction)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }
  
  @objc func handleRefreshControl() {
    model.fetchData()
    DispatchQueue.main.async {
      self.tableView.refreshControl?.endRefreshing()
    }
  }
  
  // MARK: View Controller Cycle
  init(model: ConversationsListModelProtocol, presentationAssembly: PresentationAssemblyProtocol) {
    self.model = model
    self.presentationAssembly = presentationAssembly
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Tinkoff Chat"
    navigationController?.navigationBar.prefersLargeTitles = false
    button.setImage(image?.resized(withBounds: CGSize(width: 36, height: 36)), for: .normal)
    button.layer.cornerRadius = 18
    button.clipsToBounds = true
    button.addTarget(self, action: #selector(methodBar), for: .touchUpInside)
    let imageButton = UIBarButtonItem(customView: button)
    imageButton.accessibilityIdentifier = "profileButton"
    let addChannelButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addChannelMethod))
    self.navigationItem.rightBarButtonItems = [imageButton, addChannelButton]
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .done, target: self, action: #selector(settingsMethod))
    createTableView()
    
    model.fetchData()
    performFetch()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tableView.deselectSelectedRow(animated: true)
  }
  
  deinit {
    fetchedResultsController.delegate = nil
  }
  
  // MARK: Methods
  
    func performFetch() {
      do {
        try
        fetchedResultsController.performFetch()
//        tableView.reloadData()
      } catch {
        fatalError()
      }
    }
    
    func configureRefreshControl() {
      tableView.refreshControl = UIRefreshControl()
      tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    func updateTheme(theme: ThemeApp) { // загружать тип темы из памяти, а не передовать
      self.theme = theme
  //    tableView.reloadData()
      navigationController?.navigationBar.barTintColor = theme.navigationBar
      UINavigationBar.appearance().barStyle = theme.barStyle
      navigationController?.navigationBar.titleTextAttributes = [
        NSAttributedString.Key.foregroundColor:
          theme.navigationBarTitle ]
    }
  
  func createTableView() {
    self.tableView = UITableView(frame: view.bounds, style: .plain)
    tableView.register(ConversationsListCell.self, forCellReuseIdentifier: identifire)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(tableView)
    configureRefreshControl()
  }
  
  func validateIndexPath(_ indexPath: IndexPath) -> Bool {
    if let sections = self.fetchedResultsController.sections,
      indexPath.section < sections.count {
         if indexPath.row < sections[indexPath.section].numberOfObjects {
            return true
         }
      }
      return false
  }
}

// MARK: UITableViewDataSource
extension ConversationsListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.text = "Channels"
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
    let id = fetchedResultsController.object(at: indexPath).identifier
    let controller = presentationAssembly.conversationViewController(idChannel: id, id: id)
    controller.updateTheme(theme: self.theme)
    controller.title = self.fetchedResultsController.object(at: indexPath).name
    controller.VC = self
    self.navigationController?.pushViewController(controller, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let count = fetchedResultsController.fetchedObjects?.count ?? 0

    return count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath) as? ConversationsListCell {
      let modelCell = fetchedResultsController.object(at: indexPath)
      cell.configure(with: modelCell)
      cell.updateTheme(theme: theme)
      if self.validateIndexPath(indexPath) == false { return UITableViewCell() }
      return cell
    } else {
      return UITableViewCell()
    }
  }
}

// MARK: NSFetchedResultsControllerDelegate
extension ConversationsListViewController: NSFetchedResultsControllerDelegate {
  
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
