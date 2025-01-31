//
//  HTTPClientProtocol.swift
//  AppNetworking
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation

struct DataResponse {
    let data: Data
    let response: URLResponse
}

extension DataResponse {
    
    
    func handleNetworkResponse<T: Decodable>(model: T.Type) throws -> T {
        guard let response = response as? HTTPURLResponse else {throw APIError.badRequest}
        let statusCode = response.statusCode
        print("StatusCode: \(statusCode)")
        switch response.statusCode {
        case 200...299:
            return try map(data, model: T.self)
        case 401...500:
            throw APIError.authenticationError
        case 501...599:
            throw APIError.badRequest
        case 600:
            throw APIError.outdated
        default:
            throw APIError.failed
        }
    }

    private func map<T: Decodable>(_ data: Data, model: T.Type) throws -> T {
        do {
            let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            print(jsonData as Any)
            let obj:T = try JSONDecoder().decode(T.self, from: data)
            return obj
        }catch let error {
            throw error
        }
    }
}
