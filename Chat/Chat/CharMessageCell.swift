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
  
  private let messageLabel = UILabel()
  private let bubbleBackgroundView = UIView()
  private let triangleView = TriangleView()
  
  private var leadingConstraint: NSLayoutConstraint!
  private var trailingConstraint: NSLayoutConstraint!

  private var triangleLeadingConstraint: NSLayoutConstraint!
  private var triangleTrailingConstraint: NSLayoutConstraint!
  
  var chatMessage: ChatMessage! {
    didSet {
      bubbleBackgroundView.backgroundColor = chatMessage.isIncoming ? .white : .systemOrange
//      triangleView.isComming = chatMessage.isIncoming
      messageLabel.textColor = chatMessage.isIncoming ? .black : .white
      
      messageLabel.text = chatMessage.text
      
      if chatMessage.isIncoming {
        leadingConstraint.isActive = true
        trailingConstraint.isActive = false

        triangleLeadingConstraint.isActive = true
        triangleTrailingConstraint.isActive = false
      } else {
        leadingConstraint.isActive = false
        trailingConstraint.isActive = true

        triangleLeadingConstraint.isActive = false
        triangleTrailingConstraint.isActive = true

        triangleView.setNeedsDisplay()
      }
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .clear
    bubbleBackgroundView.layer.cornerRadius = 12
    bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    triangleView.translatesAutoresizingMaskIntoConstraints = false

    messageLabel.numberOfLines = 0
    messageLabel.font = UIFont.systemFont(ofSize: 16)
    
    addSubview(bubbleBackgroundView)
    addSubview(triangleView)
    addSubview(messageLabel)

    let constraints = [
      messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
      
      bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
      bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -8),
      bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
      bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 8),

      triangleView.centerYAnchor.constraint(equalTo: bubbleBackgroundView.centerYAnchor)
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

    triangleTrailingConstraint = triangleView.leadingAnchor.constraint(equalTo: bubbleBackgroundView.trailingAnchor)
    triangleTrailingConstraint.isActive = false

    triangleLeadingConstraint = triangleView.trailingAnchor.constraint(equalTo: bubbleBackgroundView.leadingAnchor)
    triangleLeadingConstraint.isActive = true

    leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
    leadingConstraint.isActive = false
    
    trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    trailingConstraint.isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
