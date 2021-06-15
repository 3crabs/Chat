//
//  InputMessageBar.swift
//  Chat
//
//  Created by Maxim Butin on 15.06.2021.
//

import UIKit

class InputMessageBar: UIView {

  private let messageTextView = MessageTextView()
  private let stackView = UIStackView()
  private let sendButton = UIButton(type: .system)
  private let documentButton = UIButton(type: .system)

  private let widthConstant: CGFloat = 35.0

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupShadow(
    shadowColor: UIColor,
    opacity: Float,
    offset: CGSize,
    radius: CGFloat
  ) {
    layer.shadowColor = shadowColor.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offset
    layer.shadowRadius = radius
  }

  private func setupButton(
    _ button: UIButton,
    image: UIImage?,
    tintColor: UIColor
  ) {
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(image, for: .normal)
    button.tintColor = tintColor
    button.widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
    button.heightAnchor.constraint(equalToConstant: widthConstant).isActive = true
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
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .white
    layer.cornerRadius = 10

    setupShadow(shadowColor: .black, opacity: 0.3, offset: .zero, radius: 10)
    setupButton(sendButton, image: UIImage(systemName: "paperplane"), tintColor: .systemOrange)
    setupButton(documentButton, image: UIImage(systemName: "paperclip"), tintColor: .systemOrange)
    setupStackView(stackView, subviews: [messageTextView, documentButton, sendButton])

    addSubview(stackView)

    let constraints = [
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
    ]

    NSLayoutConstraint.activate(constraints)
  }
}
