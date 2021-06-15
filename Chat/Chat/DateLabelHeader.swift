//
//  DateLabelHeader.swift
//  Chat
//
//  Created by Maxim Butin on 11.06.2021.
//

import UIKit

class DateHeaderLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .systemGray
    textColor = .white
    textAlignment = .center
    translatesAutoresizingMaskIntoConstraints = false
    font = UIFont.boldSystemFont(ofSize: 14)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    let originalContentSize = super.intrinsicContentSize
    let height = originalContentSize.height + 12
    layer.cornerRadius = height / 2
    layer.masksToBounds = true
    return CGSize(width: originalContentSize.width + 20, height: height)
  }
  
}
