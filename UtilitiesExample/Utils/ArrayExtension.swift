//
//  ArrayExtension.swift
//  UtilitiesExample
//
//  Created by Imthath M on 15/04/19.
//  Copyright © 2019 mohammed-7418. All rights reserved.
//

import Foundation

extension Array {

    /// returns an array of the total number of elements requested or
    /// elements until the condition fails
    ///
    /// - Parameters:
    ///     - total: number of elements required
    ///     - until: closure that takes the element and returns a bool indicating to stop
    public func repeatingList(of total: Int?, orUntil condition: (Element) -> Bool) -> [Element] {
        var result = [Element]()

        guard self.count > 0 else { return result }

        var element = self[0]
        var index = 0
        var count = 0

        while true {
            if condition(element) {
                break
            }

            if let totalCount = total,
                count >= totalCount {
                break
            }

            result.append(element)
            count += 1
            updateIndex(&index)
            element = self[index]
        }

        return result
    }

    /// returns an array of the total number of elements requested
    ///
    /// - Parameters:
    ///     - total: number of elements required
    public func repeatingList(of total: Int) -> [Element] {
        var result = [Element]()

        guard self.count > 0 else { return result }

        var element = self[0]
        var index = 0
        var count = 0

        while true {
            if count >= total {
                break
            }

            result.append(element)
            count += 1
            updateIndex(&index)
            element = self[index]
        }

        return result
    }

    /// returns an array of elements until the condition fails
    ///
    /// - Parameters:
    ///     - until: closure that takes the element and returns a bool indicating to stop
    public func repeatingList(until condition: (Element) -> Bool) -> [Element] {
        var result = [Element]()

        guard self.count > 0 else { return result }

        var element = self[0]
        var index = 0

        while true {
            if condition(element) {
                break
            }

            result.append(element)
            updateIndex(&index)
            element = self[index]
        }

        return result
    }

    private func updateIndex(_ index: inout Int) {
        if index == self.count - 1 {
            index = 0
        } else {
            index += 1
        }
    }
}
