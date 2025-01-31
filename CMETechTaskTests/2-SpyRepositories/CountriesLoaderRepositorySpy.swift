//
//  MainCountries.swift
//  AppCore
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation
import Commons
import AppCore

class CountriesLoaderRepositorySpy: CountriesLoaderRepositoryProtocol {
    let spy: CountriesLoaderAPI
    public init(spy: CountriesLoaderAPI) {
        self.spy = spy
    }
    
    func loadCountries() async throws -> [RemoteCountry] {
        try await spy.fetchCountries()
    }
}
