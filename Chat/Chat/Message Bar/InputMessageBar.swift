//
//  InputMessageBar.swift
//  Chat
//
//  Created by Maxim Butin on 15.06.2021.
//

import UIKit

class InputMessageBar: UIView {

  private let topBorderView = UIView()
  let messageTextView = MessageTextView()
  private let stackView = UIStackView()
  private let sendButton = UIButton(type: .system)
  private let documentButton = UIButton(type: .system)

  private let widthConstant: CGFloat = 35.0

  var sendMessageAction: ((String?) -> Void)?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupTopBorderView(_ borderView: UIView, borderColor: UIColor, width: CGFloat) {
    borderView.translatesAutoresizingMaskIntoConstraints = false
    borderView.backgroundColor = borderColor
    borderView.heightAnchor.constraint(equalToConstant: width).isActive = true
  }

  private func setupStackView(_ stackView: UIStackView, subviews: [UIView]) {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .top
    stackView.distribution = .fill
    stackView.spacing = 8

    for subView in subviews {
      stackView.addArrangedSubview(subView)
    }
  }

  private func setup() {
    messageTextView.sendButtonEnabledAction = { [weak self] isEnabled in
      self?.sendButton.isEnabled = isEnabled
    }
    
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .clear

    sendButton.setup(image: UIImage(systemName: "paperplane"), tintColor: .systemOrange, width: widthConstant)
    sendButton.isEnabled = false
    sendButton.addTarget(self, action: #selector(sendMessage(_ :)), for: .touchUpInside)
    
    documentButton.setup(image: UIImage(systemName: "paperclip"), tintColor: .systemOrange, width: widthConstant)
    documentButton.isEnabled = false

    setupStackView(stackView, subviews: [messageTextView, documentButton, sendButton])
    setupTopBorderView(topBorderView, borderColor: .systemGray3, width: 0.5)
    
    addSubview(topBorderView)
    addSubview(stackView)

    let constraints = [
      topBorderView.leadingAnchor.constraint(equalTo: leadingAnchor),
      topBorderView.topAnchor.constraint(equalTo: topAnchor),
      topBorderView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
      stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
    ]

    NSLayoutConstraint.activate(constraints)
  }

  @objc private func sendMessage(_ button: UIButton) {
    sendMessageAction?(messageTextView.text)
  }
}
