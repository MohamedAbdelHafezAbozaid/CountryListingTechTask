//
//  LoadCountriesUseCase.swift
//  AppCore
//
//  Created by mohamed ahmed on 30/01/2025.
//
import Commons
import CoreLocation

public protocol GetCountriesUseCase {
    var countriesRepo: CountriesLoaderRepositoryProtocol { get }
    func getAllCountries() async throws -> [Country]
}


extension GetCountriesUseCase {
    public func getAllCountries() async throws -> [Country] {
        let response = try await countriesRepo.loadCountries()
        return response.toPresentable()
    }
}

extension Array where Element == RemoteCountry {
    public func toPresentable() -> [Country] {
        return map {
            Country(
                name: $0.name?.official ?? "Not Found",
                currency: mapCurrency($0.currencies),
                flag: $0.flag ?? "",
                capital: $0.capital?.first ?? "Not Found",
                coordinate: getCoordinated(latlng: $0.latlng)
            )
        }
    }
    
    private func mapCurrency(_ remoteCurrencies: [String: RemoteCurrenciesInfo]?) -> String {
        guard
            let remoteCurrencies = remoteCurrencies ,
            remoteCurrencies.count >= 1 else {
            return "Not Found"
        }
        let firstCurrency = remoteCurrencies.first?.value
        
        let symbol = firstCurrency?.name ?? "Not Found"
        let name = firstCurrency?.name ?? "Not Found"
        
        return "\(symbol) - (\(name))"
    }
    
    private func getCoordinated(latlng: [Double]?) -> CLLocationCoordinate2D? {
        guard let latlng = latlng else { return nil }
        return CLLocationCoordinate2D(latitude: latlng.first ?? 0, longitude: latlng.last ?? 0)
    }
}
