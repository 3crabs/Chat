//
//  ChatMessage.swift
//  Chat
//
//  Created by Maxim Butin on 11.06.2021.
//

import UIKit

enum MessageType {
  case file
  case photo
  case message
}

struct ChatMessage {
  let text: String?
  let image: UIImage?
  let isIncoming: Bool
  let date: Date
  let type: MessageType
}
