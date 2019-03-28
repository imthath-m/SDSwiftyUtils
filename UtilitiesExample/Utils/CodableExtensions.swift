//
//  CodableExtensions.swift
//
//  Created by Imthath M on 21/02/19.
//  Copyright © 2019 Sky Dev. All rights reserved.
//

import Foundation

internal let encoder = JSONEncoder()
internal let decoder = JSONDecoder()

extension Encodable {
    public var jsonString: String? {
        do {
            return String(data: try encoder.encode(self), encoding: .utf8)
        } catch {
            return nil
        }
    }

    public var jsonData: Data? {
        return try? encoder.encode(self)
    }
}

extension Decodable {
    public init?(from jsonString: String) {
        let data = Data(jsonString.utf8)
        guard let object = try? decoder.decode(Self.self, from: data) else { return nil }
        self = object
    }

    public init?(from jsonData: Data) {
        guard let object = try? decoder.decode(Self.self, from: jsonData) else { return nil }
        self = object
    }
}

protocol Imitable: Codable {
    var copy: Self? { get }
}

extension Imitable {
    var copy: Self? {
        guard let data = try? encoder.encode(self) else { return nil }
        return try? decoder.decode(Self.self, from: data)
    }
}

protocol Distinguishable: Codable {
    func isDistinct(from other: Self) -> Bool
}

extension Distinguishable {
    func isDistinct(from other: Self) -> Bool {
        return self.jsonData != other.jsonData
    }
}
