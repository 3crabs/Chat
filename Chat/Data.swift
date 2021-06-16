//
//  Data.swift
//  Chat
//
//  Created by Maxim Butin on 11.06.2021.
//

import Foundation

class Data {

  static var shared: Data = {
    let instance = Data()
    instance.grouppedMessages()
    return instance
  }()

  private init() { }

  var serverMessages: [ChatMessage] = []
  var chatMessages = [[ChatMessage]]()

  var lastSection: Int {
    return !chatMessages.isEmpty ? chatMessages.count - 1 : 0
  }

  var lastRow: Int {
    guard let last = chatMessages.last else { return 0 }
    return last.count - 1
  }

  func grouppedMessages() {
    chatMessages.removeAll()

    let grouppedMessages = Dictionary(grouping: serverMessages) { (date) -> DateComponents in
      let sort = Calendar.current.dateComponents([.day, .month, .year], from: date.date)
      return sort
    }

    let sortedKeys = grouppedMessages.sorted {
      Calendar.current.date(from: $0.key) ?? Date.distantFuture < Calendar.current.date(from: $1.key) ?? Date.distantFuture
    }

    sortedKeys.forEach { key, values in
      let values = grouppedMessages[key]
      chatMessages.append(values ?? [])
    }
  }


  func addMessage(message: String, isIncoming: Bool) {
    serverMessages.append(ChatMessage(text: message, isIncoming: isIncoming, date: Date()))
    grouppedMessages()
  }

}

extension Data: NSCopying {
  func copy(with zone: NSZone? = nil) -> Any {
    return self
  }
}
