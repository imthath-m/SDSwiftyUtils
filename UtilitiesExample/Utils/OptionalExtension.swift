//
//  OptionalExtension.swift
//
//  Created by Imthath M on 17/12/18.
//  Copyright © 2019 Sky Dev. All rights reserved.
//

import Foundation

extension Optional {

    public func safeUnwrap(to object: inout Wrapped?) {
        if let strongSelf = self {
            object = strongSelf
        }
    }

    public func safeUnwrap(to object: inout Wrapped) {
        if let strongSelf = self {
            object = strongSelf
        }
    }

    public var isNil: Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }
}
