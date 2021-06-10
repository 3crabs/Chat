//
//  ViewController.swift
//  Chat
//
//  Created by Maxim Butin on 10.06.2021.
//

import UIKit

struct ChatMessage {
  let text: String
  let isIncoming: Bool
}

class ViewController: UITableViewController {

  fileprivate let cellId = "id"

  let chartMessage = [
    ChatMessage(text: "Это мое первое сообщение", isIncoming: true),
    ChatMessage(text: "Я пишу очень длинное сообщение тебе в ответ чтобы поспотреть перенос строки", isIncoming: true),
    ChatMessage(text: "Я пишу очень длинное сообщение тебе в ответ чтобы поспотреть перенос строки Я пишу очень длинное сообщение тебе в ответ чтобы поспотреть перенос строки Я пишу очень длинное сообщение тебе в ответ чтобы поспотреть перенос строки ", isIncoming: false),
    ChatMessage(text: "Приве", isIncoming: false),
    ChatMessage(text: "Купи молока, яблок, соли, сахара и других продуктов в магазине лента", isIncoming: true),
    ChatMessage(text: "Хорошо!", isIncoming: false),
    ChatMessage(text: "Может что нибудь еще купить?", isIncoming: false),
    ChatMessage(text: "Нет спасибо не надо!", isIncoming: true),
  ]


  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "Сообщения"
    navigationController?.navigationBar.prefersLargeTitles = true

    tableView.register(CharMessageCell.self, forCellReuseIdentifier: cellId)
    tableView.separatorStyle = .none
    tableView.backgroundColor = .systemGray5
    tableView.allowsSelection = false
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chartMessage.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CharMessageCell
    let message = chartMessage[indexPath.row]
    cell.chatMessage = message

    return cell
  }
}

