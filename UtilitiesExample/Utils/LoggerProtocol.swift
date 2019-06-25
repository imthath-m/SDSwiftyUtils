//
//  LoggerProtocol.swift
//
//  Created by Imthath M on 25/06/19.
//  No Copyright.
//

import Foundation

public protocol LoggerProtocol {
    func log(_ message: String)
}

internal class Console: LoggerProtocol {
    static let shared = Console()
    
    private init() { }
    
    func log(_ message: String) {
        print(message)
    }
}
