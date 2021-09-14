//
//  Date+Additions.swift
//  Todo
//
//  Created by Drew Barnes on 13/09/2021.
//

import UIKit

extension Date {
    init?(_ string: String, format: String = "yyyy-MM-dd") {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        guard let date = dateFormatter.date(from: string) else { return nil }
        self = date
    }

    func string(format: String = "yyyy-MM-dd", timeZone: TimeZone? = nil) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        if let tz = timeZone {
            dateFormatter.timeZone = tz
        }
        return dateFormatter.string(from: self)
    }

    var date: Date? {
        let calender = Calendar.current
        var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
        dateComponents.timeZone = NSTimeZone.system
        return calender.date(from: dateComponents)
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }

    func stringForDisplay(longFormat: String? = "MM/d/yy") -> String? {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"

        let today = Date()

        let offsetComponents = calendar.dateComponents([.year, .month, .day], from: today)

        guard let midnight = calendar.date(from: offsetComponents) else {
            return nil
        }

        if compare(midnight) == .orderedDescending {
            dateFormatter.dateFormat = "h:mm a"
        } else {
            var componentsToSubtract = DateComponents()
            componentsToSubtract.day = -7
            guard let lastWeek = calendar.date(byAdding: componentsToSubtract, to: today) else {
                return nil
            }

            if compare(lastWeek) == .orderedDescending {
                dateFormatter.dateFormat = "EEE"
            } else {
                dateFormatter.dateFormat = "MM/d/yy"
            }
        }

        return dateFormatter.string(from: self)
    }

}
