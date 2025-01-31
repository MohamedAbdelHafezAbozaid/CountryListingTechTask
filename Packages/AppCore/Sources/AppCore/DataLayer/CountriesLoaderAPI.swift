//
//  CountriesLoaderAPI.swift
//  AppCore
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation
import struct Commons.RemoteCountry
import protocol AppNetworking.HTTPClient

public protocol CountriesLoaderAPI: HTTPClient {
    func fetchCountries() async throws -> [RemoteCountry]
}
