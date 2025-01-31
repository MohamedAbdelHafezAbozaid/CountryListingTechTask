//
//  LocalCountryLoader.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation
import struct Commons.Country
import Combine

public class LocalCountryLoader: ObservableObject {
    private let store: CountryStore
    
    private var cancellables = Set<AnyCancellable>()
    public var savedCountries = [Country]()
    
    public init(store: CountryStore) {
        self.store = store
        fetchAllCountries()
    }
}

extension LocalCountryLoader {
    public func fetchAllCountries(completion: @escaping([Country]) -> Void = {_ in}) {
        store.fetchAllCountries().sink(receiveCompletion:{ [weak self] completion in
            guard self != nil else {return}
            switch completion {
            case .failure:
                break
            case .finished:
                break
            }
        }, receiveValue: { [weak self]
            value in
            guard let self = self else {return}
            self.savedCountries = value
        }).store(in: &cancellables)
    }
    
    public enum state {
        case save
        case delete
    }
    
    @discardableResult
    public func TappedCountry(country: Country, state: state) -> [Country] {
        switch state {
        case .save:
            if !checkIfCountryAlreadyAdded(country:country) {
                save(item: country)
            }
        case .delete:
            deleteCountry(country: country)
        }
        return savedCountries
    }
    
    private func deleteCountry(country: Country) {
        store.deleteCountry(title: country.name)
        savedCountries = savedCountries.filter{$0.name != country.name}
    }
    
    private func save(item: Country) {
        if savedCountries.count < 5 {
            store.save(item: item)
            savedCountries.append(item)
        } else {
            
        }
    }
    
    public func checkIfCountryAlreadyAdded(country: Country) -> Bool {
        savedCountries.contains(where: {$0.name == country.name})
    }
}
