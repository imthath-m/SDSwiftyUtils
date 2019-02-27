//
//  EquatableExtension.swift
//
//  Created by Imthath M on 28/11/18.
//  No Copyright.
//

import Foundation

extension Equatable {
    
    public func findFirstMatch(in array: [Self]) -> Self? {
        for element in array {
            if element == self {
                return element
            }
        }
        return nil
    }
}
