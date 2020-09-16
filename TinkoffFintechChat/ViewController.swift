//
//  ViewController.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 13.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Logger.printLogsVC(nameFuncVC: #function, vc: .first)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    Logger.printLogsVC(nameFuncVC: #function, stateFrom: .disappeared, stateTo: .appearing, vc: .first)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    Logger.printLogsVC(nameFuncVC: #function, stateFrom: .appearing, stateTo: .appeared, vc: .first)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    Logger.printLogsVC(nameFuncVC: #function, vc: .first)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    Logger.printLogsVC(nameFuncVC: #function, vc: .first)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    Logger.printLogsVC(nameFuncVC: #function, stateFrom: .appeared, stateTo: .disappearing, vc: .first)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    Logger.printLogsVC(nameFuncVC: #function, stateFrom: .disappearing, stateTo: .disappeared, vc: .first)
  }
  
}

