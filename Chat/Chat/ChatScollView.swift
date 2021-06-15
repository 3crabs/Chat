//
//  ChatScollView.swift
//  Chat
//
//  Created by Maxim Butin on 15.06.2021.
//

import UIKit

class ChatScrollView: UIScrollView {

  let contentView = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    delegate = self

    backgroundColor = .clear

    translatesAutoresizingMaskIntoConstraints = false
    showsHorizontalScrollIndicator = false
    isDirectionalLockEnabled = true

    contentView.translatesAutoresizingMaskIntoConstraints = false

    contentView.backgroundColor = .clear

    addSubview(contentView)

    let guide = safeAreaLayoutGuide

    let constraints = [
      contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
      contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
      contentView.topAnchor.constraint(equalTo: topAnchor),
      contentView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
    ]

    NSLayoutConstraint.activate(constraints)

    let heightConstraint = NSLayoutConstraint(
      item: contentView,
      attribute: .height,
      relatedBy: .equal,
      toItem: self,
      attribute: .height,
      multiplier: 1,
      constant: 0
    )
    heightConstraint.priority = UILayoutPriority(rawValue: 250)
    heightConstraint.isActive = true

    let widthConstraint = NSLayoutConstraint(
      item: contentView,
      attribute: .width,
      relatedBy: .equal,
      toItem: self,
      attribute: .width,
      multiplier: 1,
      constant: 0
    )
    widthConstraint.priority = UILayoutPriority(rawValue: 1000)
    widthConstraint.isActive = true
  }
}

extension ChatScrollView: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.x > 0 {
      scrollView.contentOffset.x = 0
    }
  }
}
