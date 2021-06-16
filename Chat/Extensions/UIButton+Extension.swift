//
//  UIButton+Extension.swift
//  Chat
//
//  Created by Maxim Butin on 16.06.2021.
//

import UIKit

extension UIButton {
  func setup(
    image: UIImage?,
    tintColor: UIColor,
    width: CGFloat
  ) {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.setImage(image, for: .normal)
    self.tintColor = tintColor
    self.widthAnchor.constraint(equalToConstant: width).isActive = true
    self.heightAnchor.constraint(equalToConstant: width).isActive = true
  }
}

