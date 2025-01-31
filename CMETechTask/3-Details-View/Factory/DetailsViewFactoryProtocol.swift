//
//  DetailsViewFactoryProtocol.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//
import Commons

public protocol DetailsViewFactoryProtocol {
    func createFavouriteListView(mainSession: RouteSessionCachable, country: Country) -> DetailsView
}

extension DetailsViewFactoryProtocol {
    @MainActor
    public func createFavouriteListView(mainSession: RouteSessionCachable, country: Country) -> DetailsView {
        DetailsView(
            viewModel: DetailsViewModelCreator (
                mainSession: mainSession,
                country: country
            )
        )
    }
    
    @MainActor
    private func DetailsViewModelCreator(mainSession: RouteSessionCachable, country: Country) -> DetailsViewModelProtocol {
        DetailsViewModel(country: country)
    }
}
