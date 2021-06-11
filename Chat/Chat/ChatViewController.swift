//
//  ChatViewController.swift
//  GroupedMessagesLBTA
//
//  Created by Brian Voong on 8/25/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

class ChatViewController: UITableViewController {

  let chatMessages = Data.chatMessages

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "Сообщения"
    navigationController?.navigationBar.prefersLargeTitles = true

    tableView.register(ChatMessageCell.self, forCellReuseIdentifier: ChatMessageCell.cellId)
    tableView.separatorStyle = .none
    tableView.backgroundColor = .systemGray5
    tableView.allowsSelection = false
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return chatMessages.count
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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

  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chatMessages[section].count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatMessageCell.cellId, for: indexPath) as? ChatMessageCell else {
      fatalError("Not found '\(ChatMessageCell.self)")
    }
    let chatMessage = chatMessages[indexPath.section][indexPath.row]
    cell.chatMessage = chatMessage
    return cell
  }

}
