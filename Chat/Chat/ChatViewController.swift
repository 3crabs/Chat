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
  private let messageView = UIView()

  override func loadView() {
    super.loadView()

    setupChatView()

  }

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "Сообщения"
    navigationController?.navigationBar.prefersLargeTitles = true

    tableView.register(ChatMessageCell.self, forCellReuseIdentifier: ChatMessageCell.cellId)
    tableView.separatorStyle = .none
    tableView.backgroundColor = .systemGray5
    tableView.allowsSelection = false

    tableView.delegate = self
    tableView.dataSource = self
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

    messageView.translatesAutoresizingMaskIntoConstraints = false
    messageView.backgroundColor = .systemBlue


    view.addSubview(tableView)
    view.addSubview(messageView)

    let constraints = [
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: messageView.topAnchor),

      messageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      messageView.heightAnchor.constraint(equalToConstant: 60)
    ]

    NSLayoutConstraint.activate(constraints)

  }

}
