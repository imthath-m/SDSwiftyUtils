//
//  StringExtension.swift
//  UtilitiesExample
//
//  Created by Imthath M on 28/03/19.
//  Copyright © 2019 Sky Dev. All rights reserved.
//

import Foundation

extension String {
    public func objects<T: Codable>() -> [T]? {
        guard let data = self.data(using: .utf8) else { return nil }
        guard let objects = try? decoder.decode([T].self, from: data) else { return nil }
        return objects
    }

    func getTimeIntervalSince1970(with dateFormatter: DateFormatter) -> TimeInterval? {
        guard let date = Date.get(from: self, with: dateFormatter) else { return nil }
        return date.timeIntervalSince1970
    }
}
