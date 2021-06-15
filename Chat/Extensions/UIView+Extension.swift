//
//  UIView+Extension.swift
//  Chat
//
//  Created by Maxim Butin on 15.06.2021.
//

import UIKit

extension UIView {
  func attachSafelyBottomInContainer(
    to superView: UIView,
    margin: CGFloat = 0
  ) {
    if #available(iOS 11.0, *) {
      bottomAnchor.constraint(
        equalTo: superview!.safeAreaLayoutGuide.bottomAnchor,
        constant: margin
      ).isActive = true
    } else {
      bottomAnchor.constraint(
        equalTo: superview!.bottomAnchor,
        constant: margin
      ).isActive = true
    }
  }
  
  func addShadow(
    shadowColor: UIColor,
    opacity: Float,
    offset: CGSize,
    radius: CGFloat
  ) {
    layer.shadowColor = shadowColor.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offset
    layer.shadowRadius = radius
  }
}

