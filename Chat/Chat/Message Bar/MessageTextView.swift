//
//  MessageTextView.swift
//  Chat
//
//  Created by Maxim Butin on 15.06.2021.
//

import UIKit

class MessageTextView: UITextView {

  private var maxHeight: CGFloat = 80

  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)

    delegate = self
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  private func setup() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .white
    layer.cornerRadius = 10
    layer.borderColor = UIColor.systemGray3.cgColor
    layer.borderWidth = 1.0
    textColor = .lightGray
    font = UIFont.systemFont(ofSize: 16)
    text = "Введите текст сообщения"
    autocapitalizationType = .words
    isScrollEnabled = false
  }

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
}

extension MessageTextView: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == .lightGray {
      textView.text = nil
      textView.textColor = .black
    }
  }

  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if(text == "\n") {
      textView.resignFirstResponder()
      return false
    }
    return true
  }


  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "Введите текст сообшения"
      textView.textColor = UIColor.lightGray
    }
  }

  func textViewDidChange(_ textView: UITextView) {
//    textView.sizeToFit()
    invalidateIntrinsicContentSize()
  }
}
