//
//  CodableExtensions.swift
//
//  Created by Imthath M on 21/02/19.
//  No Copyright.
//

extension String {
    public func objects<T: Codable>() -> [T]? {
        guard let data = self.data(using: .utf8) else { return nil }
        guard let objects = try? JSONDecoder().decode([T].self, from: data) else { return nil }
        return objects
    }
}

extension Encodable {
    public var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }
}

extension Decodable {
    public init?(from jsonString: String) {
        let data = Data(jsonString.utf8)
        guard let object = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
        self = object
    }
}

protocol Imitable: Codable {
    var copy: Self? { get }
}

extension Imitable {
    var copy: Self? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return try? JSONDecoder().decode(Self.self, from: data)
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
