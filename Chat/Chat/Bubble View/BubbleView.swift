//
//  BubbleView.swift
//  Chat
//
//  Created by Maxim Butin on 18.06.2021.
//

import UIKit

class BubbleView: UIView {
  
  private let messageView: MessageView = {
    let view = MessageView()
    return view
  }()
  
  private let triangleView: TriangleView = {
    let view = TriangleView()
    return view
  }()
  
  private var incomingConstraints: [NSLayoutConstraint]!
  private var comingConstraints: [NSLayoutConstraint]!
  
  var isIncoming: Bool! {
    didSet {
      triangleView.isIncoming = isIncoming
      messageView.messageLabel.textColor = isIncoming ? .black : .white
      messageView.backgroundColor = isIncoming ? .white : .systemOrange
      
      if isIncoming {
        NSLayoutConstraint.activate(incomingConstraints)
        NSLayoutConstraint.deactivate(comingConstraints)
      } else {
        NSLayoutConstraint.activate(comingConstraints)
        NSLayoutConstraint.deactivate(incomingConstraints)
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
  
  public func setMessage(_ message: String) {
    messageView.setMessage(message)
  }
  
  private func setup() {
    backgroundColor = .systemBlue
    translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(messageView)
    addSubview(triangleView)
    
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
    
    let commonConstraints = [
      messageView.topAnchor.constraint(equalTo: topAnchor),
      messageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      messageView.centerYAnchor.constraint(equalTo: triangleView.centerYAnchor),
    ]
    
    NSLayoutConstraint.activate(commonConstraints)
  }
}

