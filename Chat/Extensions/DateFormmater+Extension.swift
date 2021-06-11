//
//  DateFormmater+Extension.swift
//  Chat
//
//  Created by Maxim Butin on 11.06.2021.
//

import Foundation

extension DateFormatter {
  func localeDateFormatter(locale: String) -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMM, yyyy"
    dateFormatter.locale = Locale(identifier: "ru")
    return dateFormatter
  }
}
