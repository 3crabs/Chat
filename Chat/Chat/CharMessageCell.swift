//
//  ChatMessageCell.swift
//  GroupedMessagesLBTA
//
//  Created by Brian Voong on 8/25/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {

  static let cellId = "\(ChatMessageCell.self)"
  
  let messageLabel = UILabel()
  let bubbleBackgroundView = UIView()
  
  var leadingConstraint: NSLayoutConstraint!
  var trailingConstraint: NSLayoutConstraint!
  
  var chatMessage: ChatMessage! {
    didSet {
      bubbleBackgroundView.backgroundColor = chatMessage.isIncoming ? .white : .systemOrange
      messageLabel.textColor = chatMessage.isIncoming ? .black : .white
      
      messageLabel.text = chatMessage.text
      
      if chatMessage.isIncoming {
        leadingConstraint.isActive = true
        trailingConstraint.isActive = false
      } else {
        leadingConstraint.isActive = false
        trailingConstraint.isActive = true
      }
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .clear
    bubbleBackgroundView.backgroundColor = .yellow
    bubbleBackgroundView.layer.cornerRadius = 12
    bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    messageLabel.numberOfLines = 0
    
    addSubview(bubbleBackgroundView)
    addSubview(messageLabel)

    let constraints = [
      messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
//      messageLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 3/5),
      
      bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
      bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
      bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
      bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
    ]
    NSLayoutConstraint.activate(constraints)
    
    let constraint = NSLayoutConstraint(
      item: messageLabel,
      attribute: .width,
      relatedBy: .lessThanOrEqual,
      toItem: self,
      attribute: .width,
      multiplier: 3/5,
      constant: 0)
    constraint.priority = UILayoutPriority(999)
    constraint.isActive = true
    
    leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
    leadingConstraint.isActive = false
    
    trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
    trailingConstraint.isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
