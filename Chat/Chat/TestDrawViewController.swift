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

    bubbleView.isIncoming = false
    bubbleView.setMessage("Рисую тестовое сообщение. Хочу посмотреть перенос строки, и вообще как выглядит это все вместе с хвостом")
    
    view.backgroundColor = .darkGray
    view.addSubview(bubbleView)

    bubbleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    bubbleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    bubbleView.widthAnchor.constraint(equalToConstant: 200).isActive = true
  }
}
