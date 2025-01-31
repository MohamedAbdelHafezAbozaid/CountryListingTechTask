//
//  TestingDecoder.swift
//  AppCore
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation

class TestingDecoder {
    static func decode<P: Decodable>(_ mockFileName: String) async throws -> P {
        if
            let task = Bundle(for: TestingDecoder.self)
                .url(forResource: mockFileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: task)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(P.self, from: data)
                return jsonData
            } catch {
                throw NSError(domain: "MockError", code: 1, userInfo: [NSLocalizedDescriptionKey: "\(mockFileName) Data issue"])
            }
        } else {
            throw NSError(domain: "MockError", code: 1, userInfo: [NSLocalizedDescriptionKey: "\(mockFileName) Not Found"])
        }
    }
}
