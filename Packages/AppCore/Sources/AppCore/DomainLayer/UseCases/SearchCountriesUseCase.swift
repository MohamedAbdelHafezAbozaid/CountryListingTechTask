//
//  SearchCountriesUseCase.swift
//  AppCore
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Commons

public protocol SearchCountriesUseCase {
    func filterCountries(searchText: String, countries: [Country]) -> [Country]
}

extension SearchCountriesUseCase {
    public func filterCountries(searchText: String, countries: [Country]) -> [Country] {
        let filteredCountries = countries
            .filter {
                let matched = matchingSearchChecker($0, searchText)
                return matched
            }
        return filteredCountries
    }
    
    private func matchingSearchChecker(_ country: Country, _ searchText: String) -> Bool {
        guard !searchText.isEmpty else { return true }
        
        return country.name.range(
            of: searchText,
            options: .caseInsensitive
        ) != nil
    }
}
