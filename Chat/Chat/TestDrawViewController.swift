//
//  TestDrawViewController.swift
//  Chat
//
//  Created by Maxim Butin on 18.06.2021.
//

import UIKit

class TestDrawViewController: UIViewController {

  private let bubbleView = BubbleView()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Тестовые сообщения"

//    bubbleView. isIncoming = false
//    bubbleView.setMessage("Рисую тестовое сообщение. Хочу посмотреть перенос строки, и вообще как выглядит это все вместе с хвостом")
    
    view.backgroundColor = .darkGray
    view.addSubview(bubbleView)

//    bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
    bubbleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    bubbleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    let constraint = NSLayoutConstraint(
      item: bubbleView,
      attribute: .width,
      relatedBy: .lessThanOrEqual,
      toItem: view,
      attribute: .width,
      multiplier: 3/4,
      constant: 0)
    constraint.priority = UILayoutPriority(1000)
    constraint.isActive = true
  }
}
