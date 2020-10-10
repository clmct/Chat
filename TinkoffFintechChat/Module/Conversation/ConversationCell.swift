//
//  ConversationCell.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell, ConfiguratableView, ThemesPickerDelegate { // два прототипа ячейки
  
  var theme: ThemeApp = ThemeApp(theme: .classic)

  func updateTheme(theme: ThemeApp) {
    bubblebackroundView.backgroundColor = messageIncoming ? theme.messageIncoming : theme.messageOutcoming
    messageLbael.textColor = messageIncoming ? theme.textIncoming : theme.textOutcoming
    backgroundColor = theme.backgroundColor
  }


  typealias ConversationModel = MessageCellModel
  
  func configure(with model: ConversationModel) {
    messageLbael.text = model.text
    messageIncoming = model.isIncoming
    bubblebackroundView.backgroundColor = model.isIncoming ? UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.00) : UIColor(red: 0.86, green: 0.97, blue: 0.77, alpha: 1.00) 
    
    if model.isIncoming {
      trailingConstraints?.isActive = false
      leadingConstraint?.isActive = true
    } else {
      leadingConstraint?.isActive = false
      trailingConstraints?.isActive = true
    }
    
  }
  
  var messageIncoming = false
  lazy private var messageLbael = UILabel()
  lazy private var bubblebackroundView = UIView()
  private var leadingConstraint: NSLayoutConstraint?
  private var trailingConstraints: NSLayoutConstraint?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.isUserInteractionEnabled = false
    bubblebackroundView.layer.cornerRadius = 12
    bubblebackroundView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(bubblebackroundView)
    addSubview(messageLbael)
    messageLbael.numberOfLines = 0
    messageLbael.translatesAutoresizingMaskIntoConstraints = false
    
    let constraints = [
      messageLbael.topAnchor.constraint(equalTo: topAnchor, constant: 32),
      messageLbael.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
      messageLbael.widthAnchor.constraint(lessThanOrEqualToConstant: 3/4 * self.frame.width),
      
      bubblebackroundView.topAnchor.constraint(equalTo: messageLbael.topAnchor, constant: -16),
      bubblebackroundView.bottomAnchor.constraint(equalTo: messageLbael.bottomAnchor, constant: 16),
      bubblebackroundView.leadingAnchor.constraint(equalTo: messageLbael.leadingAnchor, constant: -16),
      bubblebackroundView.trailingAnchor.constraint(equalTo: messageLbael.trailingAnchor, constant: 16)
    ]
    
    NSLayoutConstraint.activate(constraints)
    
    leadingConstraint = messageLbael.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
    trailingConstraints = messageLbael.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
