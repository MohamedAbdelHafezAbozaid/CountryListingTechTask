//
//  MainRoute.swift
//  Router
//
//  Created by mohamed ahmed on 30/01/2025.
//
import SwiftUI
import Commons

@MainActor
public enum MainRoute: Hashable, Equatable {
    case countryListView(mainSession: RouteSessionCachable)
    case favoriteCountryListView(mainSession: RouteSessionCachable)
    case detailCountryView(mainSession: RouteSessionCachable, country: Country)
    public static func == (lhs: MainRoute, rhs: MainRoute) -> Bool {
        switch (lhs, rhs) {
        case (.countryListView, .countryListView):
            return true
        case (.favoriteCountryListView, .favoriteCountryListView):
            return true
        case (.detailCountryView, .detailCountryView):
            return true
        default:
            return false
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .countryListView:
            hasher.combine(0)
        case .favoriteCountryListView:
            hasher.combine(1)
        case let .detailCountryView(_, countrt):
            hasher.combine(countrt.name)
        }
    }
}


extension MainRoute: View ,
                     CountriesListViewFactoryProtocol,
                     FavouriteListViewFactoryProtocol,
                     DetailsViewFactoryProtocol{
    public var body: some View {
        switch self {
        case let .countryListView(route):
            createInitialContactsView(
                mainSession: route
            ).navigationBarBackButtonHidden(true)
        case let .favoriteCountryListView(mainSession):
            createFavouriteListView(
                mainSession: mainSession
            ).navigationBarBackButtonHidden(true)
        case let .detailCountryView(mainSession, country):
            createFavouriteListView(
                mainSession: mainSession,
                country: country
            ).navigationBarBackButtonHidden(true)
        }
    }
}
