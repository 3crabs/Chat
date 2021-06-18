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
  
  private let bubbleView = BubbleView()
  
  private var leadingConstraint: NSLayoutConstraint!
  private var trailingConstraint: NSLayoutConstraint!

  var chatMessage: ChatMessage! {
    didSet {
      bubbleView.isIncoming = chatMessage.isIncoming
      bubbleView.setMessage(chatMessage.text)
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
    
    addSubview(bubbleView)
    
    let constraints = [
      bubbleView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      bubbleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
    ]
    NSLayoutConstraint.activate(constraints)
    
    let constraint = NSLayoutConstraint(
      item: bubbleView,
      attribute: .width,
      relatedBy: .lessThanOrEqual,
      toItem: self,
      attribute: .width,
      multiplier: 3/5,
      constant: 0)
    constraint.priority = UILayoutPriority(950)
    constraint.isActive = true
    
    leadingConstraint = bubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
    leadingConstraint.isActive = false
    
    trailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
    trailingConstraint.isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
