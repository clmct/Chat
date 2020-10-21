//
//  TableView + .swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 11.10.2020.
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
