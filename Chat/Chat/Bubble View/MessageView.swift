//
//  MessageView.swift
//  Chat
//
//  Created by Maxim Butin on 18.06.2021.
//

import UIKit

class MessageView: UIView {
  
  let messageLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func setMessage(_ message: String) {
    messageLabel.text = message
  }
  
  private func setup() {
    translatesAutoresizingMaskIntoConstraints = false
    layer.cornerRadius = 12
    backgroundColor = .systemGray2
    messageLabel.backgroundColor = .systemPink
    
    addSubview(messageLabel)
    
    let constraints = [
      topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
      leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -8),
      bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
      trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 8)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
}

