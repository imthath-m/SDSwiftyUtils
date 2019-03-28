//
//  DateExtension.swift
//
//  Created by Imthath M on 21/02/19.
//  Copyright © 2019 Sky Dev. All rights reserved.
//

import Foundation

private let currentCal = Calendar.current

extension Date {

    public static func get(from string: String?, with formatter: DateFormatter, in timezone: TimeZone? = nil) -> Date? {

        guard let dateString = string else {
            return nil
        }

        if let timeZone = timezone {
            formatter.timeZone = timeZone
        }

        return formatter.date(from: dateString)
    }

    public func string(with formatter: DateFormatter, in timezone: TimeZone? = nil) -> String {

        if let timeZone = timezone {
            formatter.timeZone = timeZone
        }

        return formatter.string(from: self)
    }
}

extension Date {

    public var startOfWeek: Date {
        return currentCal.date(from: currentCal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }

    public var endOfWeek: Date {
        return currentCal.date(byAdding: .day, value: 6, to: self.startOfWeek)!
    }

    public var dayOfWeek: Int {
        return currentCal.component(.weekday, from: self)-1
    }

    public var startOfMonth: Date {
        return currentCal.date(from: currentCal.dateComponents([.year, .month], from: self))!
    }

    public var endOfMonth: Date {
        let nextMonth = currentCal.date(byAdding: .month, value: 1, to: self.startOfMonth)!
        return currentCal.date(byAdding: .day, value: -1, to: nextMonth)!
    }
}
