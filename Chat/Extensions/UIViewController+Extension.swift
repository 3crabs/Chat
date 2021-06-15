//
//  UIViewController+Extension.swift
//  Chat
//
//  Created by Maxim Butin on 15.06.2021.
//

import UIKit


extension UIViewController {
  func hideKeyboard() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
