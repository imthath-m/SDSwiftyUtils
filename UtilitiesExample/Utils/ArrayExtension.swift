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

extension Sequence {

    /// performs the given operation using DisptachQueue().async
    /// and hence will return before the entire operation is complete
    @inlinable public func parallelLoop(_ body: @escaping (Self.Element) -> Void) {
        let dispatchQueue = DispatchQueue(label: "parallel", attributes: .concurrent)

        for element in self {
            dispatchQueue.async {
                body(element)
            }
        }

    }

    /// performs the given transformation using DisptachQueue().async
    /// and hence will return before the entire operation is complete
    @inlinable public func parallelMap<Result>(_ transform: @escaping (Self.Element) -> Result) -> [Result] {
        let dispatchQueue = DispatchQueue(label: "parallel", attributes: .concurrent)

        var result = [Result]()

        for element in self {
            dispatchQueue.async {
                result.append(transform(element))
            }
        }

        return result
    }
}

extension Array {

    /// performs the given operation using DispatchQueue.concurrent perfom
    @inlinable public func concurrentLoop(_ body: @escaping (Element) -> Void) {
        DispatchQueue.concurrentPerform(iterations: self.count) { index in
            body(self[index])
        }
    }

    /// performs the given transformation using DispatchQueue.concurrent perfom
    @inlinable public func concurrentMap<Result>(_ transform: @escaping (Element) -> Result) -> [Result] {

        var result = [Result]()

        DispatchQueue.concurrentPerform(iterations: self.count) { index in
            result.append(transform(self[index]))
        }

        return result
    }
}

extension Array where Element: Hashable {

    /// returns a dictionary with each unique element as key and the count it is present in the array as value
    public func uniqueCount() -> [Element: Int] {

        var result = [Element: Int]()

        for element in self {
            if let count = result[element] {
                result[element] = count + 1
            } else {
                result[element] = 1
            }
        }

        return result
    }
}

extension Array where Element: Equatable {

    /// returns start index and end index of the matching sub array
    public func findMatch(like another: [Element]) -> (Int, Int)? {

        var count: Int
        for (index, element) in self.enumerated() {
            var nextElement = element
            count = 0

            for (ind, elem) in another.enumerated() {
                if elem != nextElement { break }
                count += 1

                if count == another.count {
                    return (index, index + another.count - 1)
                }

                if index == self.count - 1 { return nil }

                nextElement = self[index + ind + 1]
            }
        }

        return nil
    }
}

extension Array {
    
    /// returns the first element which satisfies the given condition
    public func filterFirst(_ condition: (Element) throws -> Bool) rethrows -> Element? {
        for element in self where try condition(element) {
            return element
        }
        
        return nil
    }
    
    mutating public func appendOptional(_ newElement: Element?) {
        if let element = newElement {
            self.append(element)
        }
    }
}
