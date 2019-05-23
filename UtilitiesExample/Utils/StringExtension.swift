//
//  StringExtension.swift
//  UtilitiesExample
//
//  Created by Imthath M on 28/03/19.
//  Copyright © 2019 Sky Dev. All rights reserved.
//

import Foundation

extension String {

    /// decode and return codable types 
    public func objects<T: Codable>() -> [T]? {
        guard let data = self.data(using: .utf8) else { return nil }
        guard let objects = try? JSONDecoder().decode([T].self, from: data) else { return nil }
        return objects
    }

    func getTimeIntervalSince1970(with dateFormatter: DateFormatter) -> TimeInterval? {
        guard let date = Date.get(from: self, with: dateFormatter) else { return nil }
        return date.timeIntervalSince1970
    }

    /// returns start index and end index of the matching string
    /// returns (0, 0) if no match is found
    func find(in another: String) -> (Int, Int) {
        for (index, character) in another.enumerated() {
            var nextChar = character
            for (ind, char) in self.enumerated() {
                if char != nextChar { break }
                if char == self.last { return (index - another.count + 1, index) }
                nextChar = another[index + ind + 1]
            }
        }
        return (0, 0)
    }
}
