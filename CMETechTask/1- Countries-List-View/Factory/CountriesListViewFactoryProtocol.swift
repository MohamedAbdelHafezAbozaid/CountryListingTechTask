//
//  CountriesListViewFactoryProtocol.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import AppCore

public protocol CountriesListViewFactoryProtocol {
    func createInitialContactsView(mainSession: RouteSessionCachable) -> CountriesListView
}

extension CountriesListViewFactoryProtocol {
    
    @MainActor
    public func createInitialContactsView(mainSession: RouteSessionCachable) -> CountriesListView {
        CountriesListView(
            viewModel: CountriesListViewModelCreator(
                mainSession: mainSession
            )
        )
    }
    
    @MainActor
    private func CountriesListViewModelCreator(mainSession: RouteSessionCachable) -> CountriesListViewModelProtocol {
        CountriesListViewModel(
            countriesRepo: makeCountriesRepo(),
            countryLocalRepo: mainSession.localStorage,
            locationManager: LocationManager(),
            router: CountrieListScreenRouter(
                mainSession: mainSession
            )
        )
    }
    
    private func makeCountriesRepo() -> CountriesLoaderRepositoryProtocol {
        CountriesLoaderRepository(
            remoteDataSource: MainCountriesLoaderAPI()
        )
    }
}
