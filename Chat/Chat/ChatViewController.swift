//
//  ChatViewController.swift
//  GroupedMessagesLBTA
//
//  Created by Brian Voong on 8/25/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  private let chatMessages = Data.chatMessages

  private let tableView = UITableView()
  private let messageView = InputMessageBar()
  
  private var bottomContainerConstraint: NSLayoutConstraint!

  let notificationCenter = NotificationCenter.default

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "Сообщения"
    navigationController?.navigationBar.prefersLargeTitles = false

    view.backgroundColor = .systemGray5

    setupChatView()
    setupTableView()

    // Listen for keyboard events
    notificationCenter.addObserver(self, selector: #selector(handleKeyBoard(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(handleKeyBoard(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  deinit {
    notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  @objc private func handleKeyBoard(_ notification: Notification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey]
                            as? NSValue)?.cgRectValue {
      let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
      bottomContainerConstraint.constant = isKeyboardShowing ? -keyboardSize.height : 0

      UIView.animate(withDuration: 5, delay: 0, options: .curveEaseOut) {
        self.view.layoutIfNeeded()
      } completion: { _ in

      }
    }
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return chatMessages.count
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let firstMessageInSection = chatMessages[section].first else { return nil }

    let dateString = DateFormatter().localeDateFormatter(locale: "ru").string(from: firstMessageInSection.date)

    let label = DateHeaderLabel()
    label.text = dateString

    let containerView = UIView()

    containerView.addSubview(label)
    label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

    return containerView
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chatMessages[section].count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatMessageCell.cellId, for: indexPath) as? ChatMessageCell else {
      fatalError("Not found '\(ChatMessageCell.self)")
    }
    let chatMessage = chatMessages[indexPath.section][indexPath.row]
    cell.chatMessage = chatMessage
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    messageView.messageTextView.endEditing(true)
  }

  fileprivate func setupChatView() {
    tableView.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(tableView)
    
    let containerView = UIView()
    containerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(containerView)

    containerView.backgroundColor = .systemGray6
    containerView.addSubview(messageView)
    
    bottomContainerConstraint = NSLayoutConstraint(
      item: containerView,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: view,
      attribute: .bottom,
      multiplier: 1,
      constant: 0
    )
    bottomContainerConstraint.isActive = true
  
    let constraints = [
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: containerView.topAnchor),
      
//      containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      messageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      messageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      messageView.heightAnchor.constraint(lessThanOrEqualToConstant: 100),
      messageView.topAnchor.constraint(equalTo: containerView.topAnchor),
//      messageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
    ]

    NSLayoutConstraint.activate(constraints)
    
    messageView.attachSafelyBottomInContainer(to: containerView, margin: 0)
  }

  fileprivate func setupTableView() {
    tableView.register(ChatMessageCell.self, forCellReuseIdentifier: ChatMessageCell.cellId)
    tableView.separatorStyle = .none
//    tableView.allowsSelection = false
    tableView.rowHeight = UITableView.automaticDimension

    tableView.backgroundColor = .clear

    tableView.delegate = self
    tableView.dataSource = self
  }
}
