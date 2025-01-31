//
//  RemoteCountries.swift
//  Commons
//
//  Created by mohamed ahmed on 30/01/2025.
//

public struct RemoteCountry: Decodable {
    public var name: RemoteCountryName?
    public var currencies: [String: RemoteCurrenciesInfo]?
    public var flag: String?
    public var capital: [String]?
    public var latlng: [Double]?
}
