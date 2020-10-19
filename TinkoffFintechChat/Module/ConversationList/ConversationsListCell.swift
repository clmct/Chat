//
//  ConversationListCell.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class ConversationsListCell: UITableViewCell, ConfiguratableView, ThemesPickerDelegate {
  
  var theme: ThemeApp = ThemeApp(theme: .night)
  
  func updateTheme(theme: ThemeApp) {
    backgroundColor = isOnline ? theme.onlineBackground : theme.backgroundColor
    nameLabel.textColor = isOnline ? theme.onlineName : theme.nameColor
    messageLabel.textColor = theme.messageColor
    dateLabel.textColor = theme.messageColor
  }
  


  typealias ConversationModel = ConversationCellModel
  
  var delegate = "delegate"
  var closure = "closure"
  var isOnline = true
  
  func configure(with model: ConversationModel) {
    nameLabel.text = model.name
    dateLabel.text = Date.stringFromDate(day: model.date)
    messageLabel.text = model.message
    if messageLabel.text == "No messages yet" {
      messageLabel.font = UIFont(name: "Futura", size: 14)
      dateLabel.text = ""
    } else {
      messageLabel.font = model.hasUnreadMessages ? UIFont.boldSystemFont(ofSize: 14) : UIFont.systemFont(ofSize: 14)
    }
    backgroundColor = model.isOnline ? UIColor(red: 1.00, green: 0.95, blue: 0.74, alpha: 1.00) : .clear
    isOnline = model.isOnline
  }
  
  lazy private var nameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy private var dateLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .right
    label.font = UIFont.systemFont(ofSize: 15)
    label.textColor = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.60)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy private var messageLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.textAlignment = .left
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  func addLabels() {
    addSubview(nameLabel)
    addSubview(messageLabel)
    addSubview(dateLabel)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    accessoryType = .disclosureIndicator
    addLabels()
    let constraints = [
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      nameLabel.heightAnchor.constraint(equalToConstant: 20),
      nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      
      dateLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
      dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
      dateLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
      dateLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
      
      messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
      messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
      messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

