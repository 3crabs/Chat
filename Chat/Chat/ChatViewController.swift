//
//  ChatViewController.swift
//  GroupedMessagesLBTA
//
//  Created by Brian Voong on 8/25/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  private var chatMessages = Data.shared.chatMessages

  private let tableView = UITableView()
  private let messageView = InputMessageBar()
  
  private var bottomContainerConstraint: NSLayoutConstraint!

  let notificationCenter = NotificationCenter.default

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "Сообщения"
    navigationController?.navigationBar.prefersLargeTitles = true

    view.backgroundColor = .systemGray5

    setupChatView()
    setupTableView()

    // Listen for keyboard events
    notificationCenter.addObserver(self, selector: #selector(handleKeyBoard(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(handleKeyBoard(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)

    messageView.sendMessageAction = { [weak self] message in
      guard let message = message else { return }
      let isIncoming = Data.shared.serverMessages.count % 2 == 0
      Data.shared.addMessage(message: message, isIncoming: isIncoming)
      self?.chatMessages = Data.shared.chatMessages
      self?.tableView.reloadData()
      self?.tableView.scrollToRow(at: IndexPath(row: Data.shared.lastRow, section: Data.shared.lastSection), at: .bottom, animated: true)
      self?.messageView.messageTextView.text = ""
    }
  }

  deinit {
    notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  @objc private func handleKeyBoard(_ notification: Notification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                            as? NSValue)?.cgRectValue {
      let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
      bottomContainerConstraint.constant = isKeyboardShowing ? -keyboardSize.height : 0

      UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut) {
        self.view.layoutIfNeeded()
      } completion: { _ in
        if !self.chatMessages.isEmpty {
          let indextPath = IndexPath(row: Data.shared.lastRow, section: Data.shared.lastSection)
          self.tableView.scrollToRow(at: indextPath, at: .bottom, animated: true)
        }
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

      containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      messageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      messageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      messageView.heightAnchor.constraint(lessThanOrEqualToConstant: 100),
      messageView.topAnchor.constraint(equalTo: containerView.topAnchor),
    ]

    NSLayoutConstraint.activate(constraints)
    
    messageView.attachSafelyBottomInContainer(to: containerView, margin: 0)
  }

  fileprivate func setupTableView() {
    tableView.register(ChatMessageCell.self, forCellReuseIdentifier: ChatMessageCell.cellId)
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.rowHeight = UITableView.automaticDimension

    tableView.backgroundColor = .clear

    tableView.delegate = self
    tableView.dataSource = self

    let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardTableView))
    tableView.addGestureRecognizer(tap)
  }

  @objc func hideKeyboardTableView() {
    messageView.messageTextView.resignFirstResponder()
  }
}
