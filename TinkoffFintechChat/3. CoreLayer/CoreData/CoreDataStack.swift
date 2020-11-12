//
//  CoreDataStack.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 25.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataStackProtocol {
  func printDataStatisitics()
  func enableObservers()
  var didUpdateDataBase: ((CoreDataStack) -> Void)? { get set }
  var mainContext: NSManagedObjectContext { get }
  func performSave(_ block: (NSManagedObjectContext) -> Void)
}

class CoreDataStack: CoreDataStackProtocol {
  
//  static var shared = CoreDataStack()
  
  var didUpdateDataBase: ((CoreDataStack) -> Void)?
  
  private var storeUrl: URL = {
    guard let documentUrl = FileManager.default.urls(for: .documentDirectory,
                                                     in: .userDomainMask).last else {
                                                      fatalError("document patch not found") }
    return documentUrl.appendingPathComponent("Chat.sqlite")
  }()
  
  private let dataModelName = "Chat"
  private let dataModelExtension = "momd"
  
  // MARK: - init Stack
  
  private(set) lazy var managedObjectModel: NSManagedObjectModel = {
    guard let modelURL = Bundle.main.url(forResource: self.dataModelName,
                                         withExtension: self.dataModelExtension) else {
                                          fatalError("model not found")
    }
    guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
      fatalError("managedObjectModel cound not be created")
    }
    return managedObjectModel
  }()
  
  private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = { // отдельная очередь
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    do {
      try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                         configurationName: nil,
                                         at: self.storeUrl,
                                         options: nil)
    } catch {
      fatalError(error.localizedDescription)
    }
    return coordinator
  }()
  
  // MARK: - Сontexts
  
  private lazy var writterContext: NSManagedObjectContext = {
    let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    context.persistentStoreCoordinator = persistentStoreCoordinator
    context.mergePolicy = NSOverwriteMergePolicy
    return context
  }()
  
  private(set) lazy var mainContext: NSManagedObjectContext = {
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.parent = writterContext
    context.automaticallyMergesChangesFromParent = true
    context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    return context
  }()
  
  private func saveContext() -> NSManagedObjectContext {
    let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    context.parent = mainContext
    context.automaticallyMergesChangesFromParent = true
    context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    return context
  }
  
  // MARK: - Save Context
  
  func performSave(_ block: (NSManagedObjectContext) -> Void) {
    let context = saveContext()
    context.performAndWait {
      block(context)
      if context.hasChanges {
        do {
          try context.obtainPermanentIDs(for: Array(context.insertedObjects))
          try performSave(in: context)
        } catch {
          assertionFailure(error.localizedDescription)
        }
      }
    }
  }
  
  private func performSave(in context: NSManagedObjectContext) throws {
    try context.save()
    if let parent = context.parent { try performSave(in: parent) }
  }

  // MARK: - CoreData Observers
  
  func enableObservers() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self,
                                   selector: #selector(managedObjectContextObjectsDidChange(notification:)),
                                   name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                   object: mainContext)
  }
  
  @objc
  private func managedObjectContextObjectsDidChange(notification: NSNotification) {
    guard let userInfo = notification.userInfo else { return }
    didUpdateDataBase?(self)
//    print("\n\n-------------------\n")
    if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>, inserts.count > 0 {
//      print("Добавлено обьектов: ", inserts.count)
    }
    if let updated = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject>, updated.count > 0 {
//      print("Обновлено обьектов: ", updated.count)
    }
    if let deleted = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject>, deleted.count > 0 {
//      print("Удалено обьектов: ", deleted.count)
    }
  }
  
  func printDataStatisitics() {
    mainContext.perform {
      do {
        print("\n-------------------")
        let countChannels = try self.mainContext.count(for: ChannelMO.fetchRequest())
        print("Всего чатов: \(countChannels) ")
        let countMessages = try self.mainContext.count(for: MessageMO.fetchRequest())
        print("Всего ообщений: \(countMessages) ")
        let array = try self.mainContext.fetch(ChannelMO.fetchRequest()) as? [ChannelMO] ?? []
        array.forEach { item in
          let index = array.firstIndex(of: item)
          print("\nИндекс чата: \(index ?? 0)")
          print(item.about)
        }
      } catch {
        fatalError(error.localizedDescription)
      }
    }
  }
  
}
