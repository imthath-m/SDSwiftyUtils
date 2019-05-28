//
//  UUIDextension.swift
//
//  Created by Imthath M on 23/05/19.
//  No Copyright.
//

import Foundation

public extension UUID {
    var short: String {
        return String(self.uuidString.suffix(6))
    }

    var dateShort: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyy"
        return dateFormatter.string(from: Date()) + "-" + short
    }
}
