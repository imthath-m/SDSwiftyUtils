//
//  FileIO.swift
//
//  Created by Imthath M on 28/11/18.
//  No Copyright.
//

import Foundation

private let encoder = JSONEncoder()
private let decoder = JSONDecoder()

public class FileIO {
    
    let logger: LoggerProtocol
    let shared = FileIO(logger: Console.shared)
    
    public init(logger: LoggerProtocol) {
        self.logger = logger
    }

    public func getOjbectsFromFile<T: Codable>(named name: String, withType type: FileType) -> [T] {
        var objects = [T]()
        do {
            if let data = readData(from: name, type: type) {
                objects = try decoder.decode([T].self, from: data)
            }
        } catch let error as NSError {
            logger.log("unable to decode objects from text file: \(error.description)")
        }
        return objects
    }

    public func getOjbectFromFile<T: Codable>(named name: String, withType type: FileType) -> T? {
        var object: T?
        do {
            if let data = readData(from: name, type: type) {
                object = try decoder.decode(T.self, from: data)
            }
        } catch let error as NSError {
            logger.log("unable to decode object from text file: \(error.description)")
        }
        return object
    }

    public func save<T>(_ object: T, to name: String, as type: FileType = .text) where T: Codable {
        do {
            encoder.outputFormatting = .prettyPrinted
            
            let url = try getUrl(of: name, type: type)
            let data = try encoder.encode(object)
            
            switch type {
            case .text:
                if let text = String(data: data, encoding: .utf8) {
                    try text.write(to: url, atomically: true, encoding: .utf8)
                    logger.log("Saved text file \(name)")
                }
            case .json:
                try data.write(to: url)
                logger.log("Saved \(name).\(type.rawValue)")
            }            
            
        } catch let error as NSError {
            logger.log("unable to save: \(error.description)")
        }
    }

    public func readData(from name: String, type: FileType) -> Data? {
        var result: Data?
        do {
            let url = try getUrl(of: name, type: type)
            result = try Data(contentsOf: url)
        } catch let error as NSError {
            logger.log("unable to read data of type \(type.rawValue) from file \(name)")
            logger.log("Error: \(error.description)")
        }
        return result
    }

    public func readText(from name: String) -> String? {
        var result: String?
        do {
            let url = try getUrl(of: name)
            result = try String(contentsOf: url)
        } catch let error as NSError {
            logger.log("unable to read text from file \(name)")
            logger.log("Error: \(error.description)")
        }
        return result
    }

    public func getUrl(of name: String, type: FileType = .text) throws -> URL {
        let docDirectoryUrl = try FileManager.default.url(for: .documentDirectory,
                                                          in: .userDomainMask, appropriateFor: nil, create: true)
        return docDirectoryUrl.appendingPathComponent(name).appendingPathExtension(type.rawValue)
    }
}

public enum FileType: String {
    case text = "txt"
    case json = "json"
}
