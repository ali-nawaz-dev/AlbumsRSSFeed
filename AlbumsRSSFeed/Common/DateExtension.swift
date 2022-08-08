//
//  DateExtension.swift
//  AlbumsRSSFeed
//
//  Created by Sheikh Ali on 08/08/2022.
//

import Foundation

extension DateFormatter {
    static let serverDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar.current
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    static let dateOnly: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateFormat = "MMM d, yyyy"
         return formatter
    }()

    static func string(iso string: String) -> String {
        let date = DateFormatter.serverDateFormatter.date(from: string)!
        return  DateFormatter.dateOnly.string(from: date)
    }
}
