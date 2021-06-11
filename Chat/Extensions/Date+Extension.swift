//
//  Date+Extension.swift
//  Chat
//
//  Created by Maxim Butin on 11.06.2021.
//

import Foundation

extension Date {
  static func dateFromCustomString(customString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return dateFormatter.date(from: customString) ?? Date()
  }
}
