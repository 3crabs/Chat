//
//  CharMessageCell.swift
//  Chat
//
//  Created by Maxim Butin on 10.06.2021.
//

import UIKit

class CharMessageCell: UITableViewCell {

  let messageLabel = UILabel()
  let bubbleBackgroundView = UIView()

  var leadingConstraint: NSLayoutConstraint!
  var trailingConstraint: NSLayoutConstraint!

  var chatMessage: ChatMessage! {
    didSet {
      bubbleBackgroundView.backgroundColor = chatMessage.isIncoming ? .white : .systemBlue
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
    bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    bubbleBackgroundView.layer.cornerRadius = 12
    addSubview(bubbleBackgroundView)

    addSubview(messageLabel)
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    messageLabel.numberOfLines = 0

    let constraints = [
      messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),

      messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
      messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),

      bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
      bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
      bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
      bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
    ]
    NSLayoutConstraint.activate(constraints)

    leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
    trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
