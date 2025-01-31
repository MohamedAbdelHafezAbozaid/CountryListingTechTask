//
//  HTTPClient.swift
//
//
//  Created by mohamed ahmed on 11/05/2024.
//

import Foundation

public protocol HTTPClient {
    func sendRequest<T: EndPointType, P: Decodable>(_ requestBuilder: T) async throws -> P
}

extension HTTPClient {
    public func sendRequest<T: EndPointType, P: Decodable>(_ requestBuilder: T) async throws -> P {
        let router = Router<T>()
        let (data, response) = try await router.request(requestBuilder)
        let dataResponse = DataResponse(data: data, response: response)
        return try dataResponse.handleNetworkResponse(model: P.self)
    }
}
