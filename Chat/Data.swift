//
//  Data.swift
//  Chat
//
//  Created by Maxim Butin on 11.06.2021.
//

import Foundation

class Data {
  static let chatMessages = [
    [
      ChatMessage(text: "Это мое первое сообщение", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
      ChatMessage(text: "Я собираюсь отправить еще одно длинное сообщение, в котором будет перенос слов", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
    ],
    [
      ChatMessage(text: "Я собираюсь отправить еще одно длинное сообщение с переносом по словам, я собираюсь отправить еще одно длинное сообщение с переносом по словам, я собираюсь отправить еще одно длинное сообщение с переносом по словам", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2018")),
      ChatMessage(text: "Эй, чувак, как дела?", isIncoming: false, date: Date()),
      ChatMessage(text: "Это сообщение должно появиться слева с белым пузырем на фоне.", isIncoming: true, date: Date.dateFromCustomString(customString: "09/15/2018")),
    ],
    [
      ChatMessage(text: "Сообщение третьего раздела", isIncoming: true, date: Date.dateFromCustomString(customString: "10/31/2018"))
    ]
  ]
}
