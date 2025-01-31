//
//  FavouriteListScreenRouter.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//
import struct Commons.Country

public class FavouriteListScreenRouter: FavouriteListScreenRouterProtocol {
    let mainSession: RouteSessionCachable
    let coordinator: any NavigationStateProtocol
    public init(mainSession: RouteSessionCachable) {
        self.mainSession = mainSession
        self.coordinator = mainSession.coordinator
    }
    
    public func toDetails(country: Country) {
        coordinator
            .goTo(
                .detailCountryView(
                    mainSession: mainSession,
                    country: country
                )
            )
    }
}
