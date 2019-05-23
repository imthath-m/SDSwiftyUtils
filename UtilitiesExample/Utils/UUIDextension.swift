//
//  UUIDextension.swift
//  UtilitiesExample
//
//  Created by Imthath M on 23/05/19.
//  Copyright © 2019 Sky Dev. All rights reserved.
//

import Foundation

extension UUID {
    var short: String {
        return String(self.uuidString.suffix(6))
    }
    
    var dateShort: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyy"
        return dateFormatter.string(from: Date()) + "-" + short
    }
}
