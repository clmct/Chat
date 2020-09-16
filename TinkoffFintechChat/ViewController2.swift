//
//  ViewController2.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 16.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Logger.printLogsVC(nameFuncVC: #function, vc: .second)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    Logger.printLogsVC(nameFuncVC: #function, stateFrom: .disappeared, stateTo: .appearing, vc: .second)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    Logger.printLogsVC(nameFuncVC: #function, stateFrom: .appearing, stateTo: .appeared, vc: .second)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    Logger.printLogsVC(nameFuncVC: #function, vc: .second)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    Logger.printLogsVC(nameFuncVC: #function, vc: .second)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    Logger.printLogsVC(nameFuncVC: #function, stateFrom: .appeared, stateTo: .disappearing, vc: .second)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    Logger.printLogsVC(nameFuncVC: #function, stateFrom: .disappearing, stateTo: .disappeared, vc: .second)
  }
  
}
