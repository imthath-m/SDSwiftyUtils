//
//  DateExtension.swift
//
//  Created by Imthath M on 21/02/19.
//  No Copyright.
//

extension Date {
    
    public static func get(from string: String?, with formatter: DateFormatter, in timezone: TimeZone? = nil) -> Date? {
        
        guard let dateString = string else {
            return nil
        }
        
        if let timeZone = timezone {
            formatter.timezone = timeZone
        }
        
        return formatter.date(from: dateString)
    }
    
    public func string(with formatter: DateFormatter, in timezone: TimeZone? = nil) -> String {
        
        if let timeZone = timezone {
            formatter.timezone = timeZone
        }
        
        return formatter.string(from: self)
    }
}


extension Date {
    
    public var startOfWeek: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }
    
    public var endOfWeek: Date {
        return Calendar.current.date(byAdding: .day, value: 6, to: self.startOfWeek)!
    }
    
    public var dayOfWeek: Int {
        return Calendar.current.component(.weekday, from: self)-1
    }
    
    public var startOfMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
    
    public var endOfMonth: Date {
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: self.startOfMonth)!
        return Calendar.current.date(byAdding: .day, value: -1, to: nextMonth)!
    }
}
