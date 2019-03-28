//
//  EquatableExtension.swift
//
//  Created by Imthath M on 28/11/18.
//  Copyright © 2019 Sky Dev. All rights reserved.
//

import Foundation

extension Equatable {
    public func findFirstMatch(in array: [Self]) -> Self? {
        for element in array where element == self {
            return element
        }
        return nil
    }
}
