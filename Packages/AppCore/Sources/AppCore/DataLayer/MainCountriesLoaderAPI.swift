//
//  MainCountriesLoaderAPI.swift
//  AppCore
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation
import struct Commons.RemoteCountry
import AppNetworking

public class MainCountriesLoaderAPI: CountriesLoaderAPI {
    public init() {}
    public func fetchCountries() async throws -> [RemoteCountry] {
        let request: [RemoteCountry] = try await sendRequest(
            ApiBuilder
                .allCountries
        )
        return request
    }
}
