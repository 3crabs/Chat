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

  private let messageTextView = CustomTextView()

  override func loadView() {
    super.loadView()

    setupChatView()

  }

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "Сообщения"
    navigationController?.navigationBar.prefersLargeTitles = true

    view.backgroundColor = .systemGray5

    tableView.register(ChatMessageCell.self, forCellReuseIdentifier: ChatMessageCell.cellId)
    tableView.separatorStyle = .none
    tableView.backgroundColor = .clear
    tableView.layer.cornerRadius = 20
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
    messageView.backgroundColor = .systemOrange
    messageView.layer.cornerRadius = 10
    messageView.layer.shadowColor = UIColor.black.cgColor
    messageView.layer.shadowOpacity = 0.3
    messageView.layer.shadowOffset = .zero
    messageView.layer.shadowRadius = 10


    view.addSubview(tableView)
    view.addSubview(messageView)

    let sendButton = UIButton(type: .system)
    sendButton.translatesAutoresizingMaskIntoConstraints = false
    sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
    sendButton.tintColor = .white
    sendButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
    sendButton.heightAnchor.constraint(equalToConstant: 35).isActive = true

    let documentButton = UIButton(type: .system)
    documentButton.translatesAutoresizingMaskIntoConstraints = false
    documentButton.setImage(UIImage(systemName: "paperclip"), for: .normal)
    documentButton.tintColor = .white
    documentButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
    documentButton.heightAnchor.constraint(equalToConstant: 35).isActive = true


    messageTextView.backgroundColor = .white
    messageTextView.layer.cornerRadius = 10
    messageTextView.textColor = .lightGray
    messageTextView.font = UIFont.systemFont(ofSize: 16)
    messageTextView.text = "Введите текст сообщения"
    messageTextView.translatesAutoresizingMaskIntoConstraints = false
    messageTextView.autocapitalizationType = .words

    messageTextView.isScrollEnabled = false

    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .top
    stackView.distribution = .fill
    stackView.spacing = 8
    stackView.addArrangedSubview(messageTextView)
    stackView.addArrangedSubview(documentButton)
    stackView.addArrangedSubview(sendButton)

    messageView.addSubview(stackView)

    let guide = view.safeAreaLayoutGuide

    let constraints = [
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: messageView.topAnchor, constant: -16),

      messageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
      messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      messageView.heightAnchor.constraint(lessThanOrEqualToConstant: 250),

      stackView.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -16),
      stackView.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 16),
      stackView.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: -16),
    ]

    NSLayoutConstraint.activate(constraints)

  }

}


class CustomTextView: UITextView, UITextViewDelegate {

  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)

    delegate = self
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  var maxHeight: CGFloat = 200

  override var intrinsicContentSize: CGSize {
    var size = super.intrinsicContentSize
    if size.height > maxHeight {
      size.height = maxHeight
      isScrollEnabled = true
    } else {
      isScrollEnabled = false
    }
    return size
  }

  override var text: String! {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }

  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == .lightGray {
      textView.text = nil
      textView.textColor = .white
    }
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "Введите текст сообшения"
      textView.textColor = UIColor.lightGray
    }
  }

  func textViewDidChange(_ textView: UITextView) {
    textView.sizeToFit()
    invalidateIntrinsicContentSize()
  }

}
