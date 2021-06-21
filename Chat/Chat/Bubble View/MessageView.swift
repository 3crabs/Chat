//
//  MessageView.swift
//  Chat
//
//  Created by Maxim Butin on 18.06.2021.
//

import UIKit

class MessageView: UIView {

  var isIncoming: Bool! {
    didSet {
      backgroundColor = isIncoming ? .white : .systemOrange

      if isIncoming {
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(timeLabel)
        timeLabel.textColor = .systemGray
      } else {
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(messageLabel)
        timeLabel.textColor = .systemGray6
      }
    }
  }
  
  let messageLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 16)
    label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
    return label
  }()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 10
    return stackView
  }()
  
  private let timeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.italicSystemFont(ofSize: 8)
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
//    addSubview(messageLabel)ё
    
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

