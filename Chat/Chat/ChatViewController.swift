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

//  private let scrollView = ChatScrollView()

  private let tableView = UITableView()
  private let messageView = InputMessageBar()

  let notificationCenter = NotificationCenter.default

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "Сообщения"
    navigationController?.navigationBar.prefersLargeTitles = true

    view.backgroundColor = .systemGray5

//    setupScollView()
    setupChatView()
    setupTableView()

    // Listen for keyboard events
    notificationCenter.addObserver(self, selector: #selector(keyboardWillChangeFrame(_ :)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  deinit {
    notificationCenter.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  @objc private func keyboardWillChangeFrame(_ notification: Notification) {
    
  }

  @objc private func keyboardWillShow(_ notification: Notification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      print("notification: Keyboard will show")
      if self.view.frame.origin.y == 0{
        self.view.frame.origin.y -= keyboardSize.height
      }
    }
  }

  @objc private func keyboardWillHide(_ notification: Notification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      if self.view.frame.origin.y != 0 {
        self.view.frame.origin.y += keyboardSize.height
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
    view.addSubview(messageView)

    let guide = view.safeAreaLayoutGuide

    let constraints = [
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: messageView.topAnchor, constant: -16),

      messageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -16),
      messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      messageView.heightAnchor.constraint(lessThanOrEqualToConstant: 250)
    ]

    NSLayoutConstraint.activate(constraints)

  }

  fileprivate func setupTableView() {
    tableView.register(ChatMessageCell.self, forCellReuseIdentifier: ChatMessageCell.cellId)
    tableView.separatorStyle = .none
    tableView.allowsSelection = false

    tableView.backgroundColor = .clear

    tableView.delegate = self
    tableView.dataSource = self
  }

//  fileprivate func setupScollView() {
//
//    view.addSubview(scrollView)
//
//    let constraints = [
//      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//    ]
//
//    NSLayoutConstraint.activate(constraints)
//
//  }

}
