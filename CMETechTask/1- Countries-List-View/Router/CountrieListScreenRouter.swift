//
//  CountrieListScreenRouter.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//


public class CountrieListScreenRouter: CountrieListScreenRouterProtocol{
    let mainSession: RouteSessionCachable
    let coordinator: NavigationStateProtocol
    public init(mainSession: RouteSessionCachable) {
        self.mainSession = mainSession
        self.coordinator = mainSession.coordinator
    }
    
    public func openFavouritesScreen() {
        coordinator.goTo(
            .favoriteCountryListView(
                mainSession: mainSession
            )
        )
    }
}
