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
  let date: Date
}

extension Date {
  static func dateFromCustomString(customString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return dateFormatter.date(from: customString) ?? Date()
  }
}

class ViewController: UITableViewController {
  
  fileprivate let cellId = "id"
  
//  let chatMessages = [
//    [
//      ChatMessage(text: "Это мое первое сообщение", isIncoming: true, date: Date.dateFromCustomString(customString: "12/12/2021")),
//      ChatMessage(text: "Я пишу очень длинное сообщение тебе в ответ чтобы поспотреть перенос строки", isIncoming: true, date: Date.dateFromCustomString(customString: "12/12/2021"))
//    ],
//    [
//      ChatMessage(text: "Может что нибудь еще купить?", isIncoming: false, date: Date.dateFromCustomString(customString: "14/12/2021")),
//      ChatMessage(text: "Нет спасибо не надо!", isIncoming: true, date: Date.dateFromCustomString(customString: "14/12/2021")),
//    ],
//    [
//      ChatMessage(text: "Приве", isIncoming: false, date: Date.dateFromCustomString(customString: "1/1/2022")),
//      ChatMessage(text: "Купи молока, яблок, соли, сахара и других продуктов в магазине лента", isIncoming: true, date: Date.dateFromCustomString(customString: "1/1/2022")),
//    ]
//  ]
  
  var chatMessages = [[ChatMessage]]()
  
  let messagesFromServer = [
    ChatMessage(text: "Это мое первое сообщение", isIncoming: true, date: Date.dateFromCustomString(customString: "12/12/2021")),
    ChatMessage(text: "Я пишу очень длинное сообщение тебе в ответ чтобы поспотреть перенос строки", isIncoming: true, date: Date.dateFromCustomString(customString: "12/12/2021")),
    ChatMessage(text: "Это мое первое сообщение", isIncoming: true, date: Date.dateFromCustomString(customString: "12/12/2021")),
    ChatMessage(text: "Я пишу очень длинное сообщение тебе в ответ чтобы поспотреть перенос строки", isIncoming: true, date: Date.dateFromCustomString(customString: "12/12/2021")),
    ChatMessage(text: "Это мое первое сообщение", isIncoming: true, date: Date.dateFromCustomString(customString: "12/12/2021")),
    ChatMessage(text: "Я пишу очень длинное сообщение тебе в ответ чтобы поспотреть перенос строки", isIncoming: true, date: Date.dateFromCustomString(customString: "12/12/2021")),
    ChatMessage(text: "Это мое первое сообщение", isIncoming: true, date: Date.dateFromCustomString(customString: "12/12/2021")),
    ChatMessage(text: "Я пишу очень длинное сообщение тебе в ответ чтобы поспотреть перенос строки", isIncoming: true, date: Date.dateFromCustomString(customString: "12/12/2021"))
  ]
  
  fileprivate func attemptToAssemblyGrouppedMessages() {
    print("asdfsdfasdf")
    
    let grouppedMessages = Dictionary(grouping: messagesFromServer) { (element) -> Date in
      return element.date
    }
    
    let sortedKeys = grouppedMessages.keys.sorted()
    sortedKeys.forEach { (key) in
      let values = grouppedMessages[key]
      chatMessages.append(values ?? [])
    }
    
//    grouppedMessages.keys.forEach { (key) in
//      let values = grouppedMessages[key]
//      
//      chatMessages.append(values ?? [])
//    }
    
//    chatMessages = grouppedMessages.values
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    attemptToAssemblyGrouppedMessages()
    
    navigationItem.title = "Сообщения"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    tableView.register(CharMessageCell.self, forCellReuseIdentifier: cellId)
    tableView.separatorStyle = .none
    tableView.backgroundColor = .systemGray5
    tableView.allowsSelection = false
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return chatMessages.count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if let messageInSection = chatMessages[section].first {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd/MM/yyyy"
      let dateString = dateFormatter.string(from: messageInSection.date)
      return dateString
    }
    return "dsf"
    
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chatMessages[section].count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CharMessageCell
    let message = chatMessages[indexPath.section][indexPath.row]
    cell.chatMessage = message
    
    return cell
  }
}

