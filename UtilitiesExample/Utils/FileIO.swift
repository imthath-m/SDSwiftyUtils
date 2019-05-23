//
//  FileIO.swift
//
//  Created by Imthath M on 28/11/18.
//  Copyright © 2019 Sky Dev. All rights reserved.
//

import Foundation

private let encoder = JSONEncoder()
private let decoder = JSONDecoder()

public class FileIO {
    public static func getOjbectFromFile<T: Codable>(named name: String) -> T? {
        var object: T?
        do {
            if let data = readData(from: name) {
                object = try decoder.decode(T.self, from: data)
            }
        } catch let error as NSError {
            print("unable to decode object from text file: \(error.description)")
        }
        return object
    }

    public static func save<T>(_ object: T, to name: String) where T: Codable {
        do {
            encoder.outputFormatting = .prettyPrinted
            let text = String(data: try encoder.encode(object), encoding: .utf8)!
            try text.write(to: getUrlOf(fileName: name)!, atomically: true, encoding: .utf8)
            print("Saved \(name)")
        } catch let error as NSError {
            print("unable to save: \(error.description)")
        }
    }

    public static func readData(from name: String) -> Data? {
        var result: Data?
        do {
            if let url = getUrlOf(fileName: name) {
                let string = try String(contentsOf: url)
                result = Data(string.utf8)
            }
        } catch let error as NSError {
            print("unable to read from file at \(getUrlOf(fileName: name)?.absoluteString ?? name)")
            print("Error: \(error.description)")
        }
        return result
    }

    public static func readText(from name: String) -> String? {
        var result: String?
        do {
            if let url = getUrlOf(fileName: name) {
                result = try String(contentsOf: url)
            }
        } catch let error as NSError {
            print("unable to read from file at \(getUrlOf(fileName: name)?.absoluteString ?? name)")
            print("Error: \(error.description)")
        }
        return result
    }

    public static func getUrlOf(fileName name: String, fileType type: String = "txt") -> URL? {
        var fileUrl: URL?
        do {
            let docDirectoryUrl = try FileManager.default.url(for: .documentDirectory,
                                                              in: .userDomainMask, appropriateFor: nil, create: true)
            fileUrl = docDirectoryUrl.appendingPathComponent(name).appendingPathExtension(type)
        } catch let error as NSError {
            print("unable to get file url: \(error.description)")
        }
        return fileUrl
    }
}
