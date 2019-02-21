//
//  CodableExtensions.swift
//
//  Created by Imthath M on 21/02/19.
//  No Copyright.
//

extension String {
    func objects<T: Codable>() -> [T]? {
        guard let data = self.data(using: .utf8) else { return nil }
        guard let objects = try? JSONDecoder().decode([T].self, from: data) else { return nil }
        return objects
    }
}

extension Encodable {
    var jsonString: String {
        guard let jsonData = try? JSONEncoder().encode(self) else { return "" }
        if jsonData.count <= 2 { return "" }
        return String(decoding: jsonData, as: UTF8.self)
    }
    
    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }
}

extension Decodable {
    init?(from jsonString: String) {
        let data = Data(jsonString.utf8)
        guard let object = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
        self = object
    }
}

protocol Imitable: Codable {
    func copy() -> Self?
}

extension Imitable {
    func copy() -> Self? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}

protocol CustomEquatable: Codable {
    func isEqualTo(_ other: Self) -> Bool
}

extension CustomEquatable {
    func isEqualTo(_ other: Self) -> Bool {
        return self.jsonData == other.jsonData
    }
}