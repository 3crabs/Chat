//
//  BubbleView.swift
//  Chat
//
//  Created by Maxim Butin on 18.06.2021.
//

import UIKit

class BubbleView: UIView {
  
  private let messageView = MessageView()
  private let triangleView = TriangleView()
  
  private var incomingConstraints: [NSLayoutConstraint]!
  private var comingConstraints: [NSLayoutConstraint]!

  var chatMessage: ChatMessage! {
    didSet {
      triangleView.isIncoming = chatMessage.isIncoming
      messageView.chatMessage = chatMessage
//      messageView.isIncoming = chatMessage.isIncoming
      if chatMessage.isIncoming {
        NSLayoutConstraint.deactivate(comingConstraints)
        NSLayoutConstraint.activate(incomingConstraints)
      } else {
        NSLayoutConstraint.deactivate(incomingConstraints)
        NSLayoutConstraint.activate(comingConstraints)
      }
      triangleView.setNeedsDisplay()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  private func setup() {
    translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(triangleView)
    addSubview(messageView)
    
    let commonConstraints = [
      messageView.topAnchor.constraint(equalTo: topAnchor),
      messageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      messageView.centerYAnchor.constraint(equalTo: triangleView.centerYAnchor),
    ]
    
    NSLayoutConstraint.activate(commonConstraints)
    
    comingConstraints = [
      messageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      triangleView.trailingAnchor.constraint(equalTo: trailingAnchor),
      triangleView.leadingAnchor.constraint(equalTo: messageView.trailingAnchor),
    ]
    
    incomingConstraints = [
      messageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      triangleView.trailingAnchor.constraint(equalTo: messageView.leadingAnchor),
      triangleView.leadingAnchor.constraint(equalTo: leadingAnchor)
    ]
  }
}

