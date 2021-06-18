//
//  TestDrawViewController.swift
//  Chat
//
//  Created by Maxim Butin on 18.06.2021.
//

import UIKit

class TestDrawViewController: UIViewController {

  let bubbleView = BubbleView()

  override func viewDidLoad() {
    super.viewDidLoad()

    bubbleView.isIncoming = true
    view.backgroundColor = .darkGray

    view.addSubview(bubbleView)

    bubbleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    bubbleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    bubbleView.widthAnchor.constraint(equalToConstant: 200).isActive = true
  }
}


class BubbleView: UIView {

  private let messageView = UIView()
  let messageLabel = UILabel()

  private var triangleView = TriangleView()

  private var triangleLeadingConstraints: [NSLayoutConstraint]!
  private var triangleTrailingConstraints: [NSLayoutConstraint]!

  var isIncoming: Bool! {
    didSet {
      triangleView.isIncoming = isIncoming
      messageLabel.textColor = isIncoming ? .black : .white
      messageView.backgroundColor = isIncoming ? .white : .systemOrange

      if isIncoming {
        triangleView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        triangleView.trailingAnchor.constraint(equalTo: messageView.leadingAnchor).isActive = true
//        NSLayoutConstraint.deactivate(triangleLeadingConstraints)
//        NSLayoutConstraint.activate(triangleTrailingConstraints)
//        NSLayoutConstraint.deactivate(triangleTrailingConstraints)
//        NSLayoutConstraint.activate(triangleLeadingConstraints)
      } else {
        NSLayoutConstraint.deactivate(triangleLeadingConstraints)
        NSLayoutConstraint.activate(triangleTrailingConstraints)
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

    messageLabel.text = "Рисую тестовое сообщение. Хочу посмотреть перенос строки, и вообще как выглядит это все вместе с хвостом"

    messageLabel.font = UIFont.systemFont(ofSize: 16)

    translatesAutoresizingMaskIntoConstraints = false
    messageView.translatesAutoresizingMaskIntoConstraints = false
    triangleView.translatesAutoresizingMaskIntoConstraints = false
    messageLabel.translatesAutoresizingMaskIntoConstraints = false

    messageView.layer.cornerRadius = 12

    messageLabel.numberOfLines = 0
    messageLabel.font = UIFont.systemFont(ofSize: 16)

    addSubview(messageView)
    addSubview(triangleView)

    messageView.addSubview(messageLabel)


    triangleTrailingConstraints = [
      triangleView.trailingAnchor.constraint(equalTo: trailingAnchor),
      triangleView.leadingAnchor.constraint(equalTo: messageView.trailingAnchor),
    ]

    triangleLeadingConstraints = [
      triangleView.leadingAnchor.constraint(equalTo: leadingAnchor),
      triangleView.trailingAnchor.constraint(equalTo: messageView.leadingAnchor),
    ]

    let allConstraints = [
      triangleView.centerYAnchor.constraint(equalTo: messageView.centerYAnchor),

      messageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      messageView.topAnchor.constraint(equalTo: topAnchor),
      messageView.bottomAnchor.constraint(equalTo: bottomAnchor),

      messageView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
      messageView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -8),
      messageView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
      messageView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 8),
    ]

//    triangleTrailingConstraint = leadingAnchor.constraint(equalTo: messageView.trailingAnchor)
//    triangleTrailingConstraint.isActive = false
//
//    triangleLeadingConstraint = triangleView.trailingAnchor.constraint(equalTo: messageView.leadingAnchor)
//    triangleLeadingConstraint.isActive = true
//
//    leadingMessageConstraint = messageLabel.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 16)
//    leadingMessageConstraint.isActive = false
//
//    trailingMessageConstraint = messageLabel.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -16)
//    trailingMessageConstraint.isActive = true

    NSLayoutConstraint.activate(allConstraints)
  }
}
