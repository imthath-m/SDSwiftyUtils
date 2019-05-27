//
//  StringExtension.swift
//  UtilitiesExample
//
//  Created by Imthath M on 28/03/19.
//  Copyright © 2019 Sky Dev. All rights reserved.
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
    
}
