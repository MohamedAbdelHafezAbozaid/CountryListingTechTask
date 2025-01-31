//
//  CountryStore.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation
import CoreData
import Combine
import struct Commons.Country

public protocol CountryStore {
    func save(item: Country)
    func getItem(title: String, completion: @escaping (ManagedCountryItem?) -> Void)
    func deleteCountry(title: String)
    func fetchAllCountries() -> AnyPublisher<[Country], Error>
}
