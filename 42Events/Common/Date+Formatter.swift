//
//  Date+Formatter.swift
//  42Events
//
//  Created by Phuc Nguyen on 15/06/2021.
//

import Foundation

struct Formatter {
    static let startDateFormatter = { () -> DateFormatter in
        let startDateFormatter = DateFormatter()
        startDateFormatter.dateFormat = "dd MMM yyyy (HH:mm)"
        return startDateFormatter
    }()
    
    static let endDateFormatter = { () -> DateFormatter in
        let endDateFormatter = DateFormatter()
        endDateFormatter.dateFormat = "dd MMM yyyy (HH:mm) O"
        return endDateFormatter
    }()
    
    static let isoDateFormatter = { () -> ISO8601DateFormatter in
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return dateFormatter
    }()
    
    static func date(from dateString: String) -> Date? {
        isoDateFormatter.date(from: dateString)
    }
}

extension Date {
    func toStartString() -> String {
        return Formatter.startDateFormatter.string(from: self)
    }
    
    func toEndString() -> String {
        return Formatter.endDateFormatter.string(from: self)
    }
}
