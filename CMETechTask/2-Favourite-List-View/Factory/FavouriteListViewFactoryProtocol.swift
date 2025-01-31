//
//  FavouriteListViewFactoryProtocol.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

public protocol FavouriteListViewFactoryProtocol {
    func createFavouriteListView(mainSession: RouteSessionCachable) -> FavouriteListView
}

extension FavouriteListViewFactoryProtocol {
    
    @MainActor
    public func createFavouriteListView(mainSession: RouteSessionCachable) -> FavouriteListView {
        FavouriteListView (
            viewModel: FavouriteListViewModelCreator(
                mainSession: mainSession
            )
        )
    }
    
    @MainActor
    private func FavouriteListViewModelCreator(mainSession: RouteSessionCachable) -> FavouriteListViewModelProtocol {
        FavouriteListViewModel(
            countryLocalRepo: mainSession.localStorage,
            router: FavouriteListScreenRouter(
                mainSession: mainSession
            )
        )
    }
}
