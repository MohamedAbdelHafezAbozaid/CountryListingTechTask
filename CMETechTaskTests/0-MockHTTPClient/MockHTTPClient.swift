//
//  MockHTTPClient.swift
//  AppCore
//
//  Created by mohamed ahmed on 30/01/2025.
//

import AppNetworking
import Foundation

class MockHTTPClient: HTTPClient {
    var mockFileName: String?
    init(mockFileName: String? = nil) {
        self.mockFileName = mockFileName
    }
    
    func sendRequest<T: EndPointType, P: Decodable>(_ requestBuilder: T) async throws -> P {
        guard let mockFileName = mockFileName else {
            throw NSError(
                domain: "MockError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Mock file name not set"]
            )
        }
        do {
            let jsonData: P = try await TestingDecoder.decode(mockFileName)
            return jsonData
        } catch {
            throw error
        }
    }
}
