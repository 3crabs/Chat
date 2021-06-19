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
    label.backgroundColor = .yellow
//    label.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
//    label.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
    return label
  }()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillProportionally
    stackView.spacing = 0
    return stackView
  }()
  
  private let timeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.italicSystemFont(ofSize: 12)
    label.backgroundColor = .systemBlue
    label.textColor = .systemGray3
    label.text = "12:38"
    label.numberOfLines = 1
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
    
    addSubview(stackView)
    
    stackView.addArrangedSubview(messageLabel)
    stackView.addArrangedSubview(timeLabel)
    
//    addSubview(messageLabel)
    
    let constraints = [
      timeLabel.widthAnchor.constraint(equalToConstant: 32),
      topAnchor.constraint(equalTo: stackView.topAnchor, constant: -8),
      leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -8),
      bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
      trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 8)
    ]
    
    
    NSLayoutConstraint.activate(constraints)
  }
}

