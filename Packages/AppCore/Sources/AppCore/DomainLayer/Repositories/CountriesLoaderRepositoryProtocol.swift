//
//  CountriesLoaderRepositoryProtocol.swift
//  AppCore
//
//  Created by mohamed ahmed on 30/01/2025.
//
import struct Commons.RemoteCountry

public protocol CountriesLoaderRepositoryProtocol {
    func loadCountries() async throws -> [RemoteCountry]
}

public final class CountriesLoaderRepository: CountriesLoaderRepositoryProtocol {
    let remoteDataSource: CountriesLoaderAPI
    
    public init(remoteDataSource: CountriesLoaderAPI) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func loadCountries() async throws -> [RemoteCountry] {
        let response = try await remoteDataSource.fetchCountries()
        return response
    }
}
