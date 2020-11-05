//
//  ConversationCell.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell, ConfiguratableView, ThemesPickerDelegate {
  
  var theme: ThemeApp = ThemeApp(theme: .classic)
  
  func updateTheme(theme: ThemeApp) {
    bubblebackroundView.backgroundColor = messageIncoming ? theme.messageOutcoming : theme.messageIncoming
    messageLbael.textColor = messageIncoming ? theme.textOutcoming : theme.textIncoming
    backgroundColor = theme.backgroundColor
  }
  
  typealias ConversationModel = MessageMO
  
  func configure(with model: ConversationModel) {
    messageLbael.text = model.content
    nameLbael.text = model.senderName
    if model.senderId != UIDevice.current.identifierForVendor?.uuidString {
      trailingConstraint?.isActive = false
      leadingConstraint?.isActive = true
      nameTopAnchor?.isActive = true
      bubblebackroundView.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.00)
      if model.senderName.count > model.content.count {
        bubbleConstarintMessage?.isActive = false
        bubbleConstarintName?.isActive = true
      } else {
        bubbleConstarintName?.isActive = false
        bubbleConstarintMessage?.isActive = true
      }
      messageIncoming = false
    } else {
      leadingConstraint?.isActive = false
      trailingConstraint?.isActive = true
      bubblebackroundView.backgroundColor = UIColor(red: 0.86, green: 0.97, blue: 0.77, alpha: 1.00)
      messageIncoming = true
      bubbleConstarintName?.isActive = false
      bubbleConstarintMessage?.isActive = false
      messageTopAnchor?.isActive = true
      nameLbael.isHidden = true
    }
  }
  
  var messageIncoming = false
  lazy private var messageLbael = UILabel()
  lazy private var nameLbael = UILabel()
  lazy private var bubblebackroundView = UIView()
  private var leadingConstraint: NSLayoutConstraint?
  private var trailingConstraint: NSLayoutConstraint?
  private var bubbleConstarintName: NSLayoutConstraint?
  private var bubbleConstarintMessage: NSLayoutConstraint?
  private var nameTopAnchor: NSLayoutConstraint?
  private var messageTopAnchor: NSLayoutConstraint?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.isUserInteractionEnabled = false
    bubblebackroundView.layer.cornerRadius = 12
    bubblebackroundView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(bubblebackroundView)
    addSubview(messageLbael)
    addSubview(nameLbael)
    messageLbael.numberOfLines = 0
    messageLbael.translatesAutoresizingMaskIntoConstraints = false
    nameLbael.font = UIFont.boldSystemFont(ofSize: 14)
    nameLbael.translatesAutoresizingMaskIntoConstraints = false
    nameLbael.font = UIFont.boldSystemFont(ofSize: 14)
    nameLbael.textColor = .systemOrange
    
    let constraints = [
      messageLbael.topAnchor.constraint(equalTo: topAnchor, constant: 32),
      messageLbael.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
      messageLbael.widthAnchor.constraint(lessThanOrEqualToConstant: 3 / 4 * self.frame.width),
      nameLbael.bottomAnchor.constraint(equalTo: messageLbael.topAnchor, constant: 0),
      nameLbael.leadingAnchor.constraint(equalTo: messageLbael.leadingAnchor, constant: 0),
      bubblebackroundView.bottomAnchor.constraint(equalTo: messageLbael.bottomAnchor, constant: 8),
      bubblebackroundView.leadingAnchor.constraint(equalTo: messageLbael.leadingAnchor, constant: -8),
      bubblebackroundView.trailingAnchor.constraint(equalTo: messageLbael.trailingAnchor, constant: 8)
    ]
    NSLayoutConstraint.activate(constraints)
    leadingConstraint = messageLbael.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
    trailingConstraint = messageLbael.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
    bubbleConstarintName = bubblebackroundView.trailingAnchor.constraint(equalTo: nameLbael.trailingAnchor, constant: 8)
    bubbleConstarintMessage = bubblebackroundView.trailingAnchor.constraint(equalTo: messageLbael.trailingAnchor, constant: 8)
    nameTopAnchor = bubblebackroundView.topAnchor.constraint(equalTo: nameLbael.topAnchor, constant: -8)
    messageTopAnchor = bubblebackroundView.topAnchor.constraint(equalTo: messageLbael.topAnchor, constant: -8)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
