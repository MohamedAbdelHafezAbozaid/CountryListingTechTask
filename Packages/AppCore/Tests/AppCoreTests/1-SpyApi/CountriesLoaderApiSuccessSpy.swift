//
//  CountriesLoaderApiSuccessSpy.swift
//  AppCore
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation
import Commons

final class CountriesLoaderApiSuccessSpy: CountriesLoaderAPI {
    // MARK: - Properties

    let httpClient: HTTPClient
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    // MARK: - Methods

    func fetchCountries() async throws -> [RemoteCountry]{
        let response: [RemoteCountry] = try await httpClient
            .sendRequest(
                ApiBuilder.allCountries
            )
        return response
    }
}
