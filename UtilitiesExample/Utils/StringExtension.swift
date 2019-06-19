//
//  StringExtension.swift
//
//  Created by Imthath M on 28/03/19.
//  No Copyright.
//

import Foundation

extension String {

    /// enables subscripting string with an int to get the character at the index
    public subscript(position: Int) -> Element {
        return self[self.index(startIndex, offsetBy: position)]
    }

    /// decode and return codable types 
    public func objects<T: Codable>() -> [T]? {
        guard let data = self.data(using: .utf8) else { return nil }
        guard let objects = try? JSONDecoder().decode([T].self, from: data) else { return nil }
        return objects
    }

    public func getTimeIntervalSince1970(with dateFormatter: DateFormatter) -> TimeInterval? {
        guard let date = Date.get(from: self, with: dateFormatter) else { return nil }
        return date.timeIntervalSince1970
    }
    
    public var isEmail: Bool {
        let emailRegEx = "(?=.{6,64}$)[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,56}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }
    
    public var isMobileNumber: Bool {
        let mobileRegEx = "[0-9]{10}"
        let input = self.replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "/", with: "")
        return NSPredicate(format: "SELF MATCHES %@", mobileRegEx).evaluate(with: input)
    }
    
}

extension Int {
    var isMobile: Bool {
        return self > 1000000000 && self < 10000000000
    }
}
