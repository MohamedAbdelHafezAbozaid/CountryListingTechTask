//
//  FavouriteListViewModel.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation
import Commons
import Combine

public protocol FavouriteListViewModelProtocol {
    var input: FavouriteListViewModel.Input { get }
    var output: FavouriteListViewModel.Output { get }
}

extension FavouriteListViewModel {
    public class Input: ObservableObject {
        public let ipActions: AnyUIEvent<Events> = .create()
    }
}

extension FavouriteListViewModel {
    public class Output: ViewModelOutput {
        @Published public var countries: [Country] = []
    }
}

public final class FavouriteListViewModel: BaseViewModel, @preconcurrency FavouriteListViewModelProtocol {
    
    public var cancellables = Set<AnyCancellable>()
    
    public let input: Input
    public let output: Output
    
    public var countryLocalRepo: LocalCountryLoader
    public let router: FavouriteListScreenRouterProtocol
    
    
    public init(
        countryLocalRepo: LocalCountryLoader,
        router: FavouriteListScreenRouterProtocol
    ) {
        
        self.countryLocalRepo = countryLocalRepo
        self.router = router
        
        self.input = .init()
        self.output = .init()
        
        observeInputs()
    }
    
    private func observeInputs() {
        input
            .ipActions
            .sink { [weak self] event in
                guard
                    let self else { return }
                
                receive(event)
            }
            .store(in: &cancellables)
    }
    
    public enum Events {
        case fetchSavedCountries
        case toDetails(Country)
        case delete(offsets: IndexSet)
    }
    
    @MainActor
    public func receive(_ event: Events) {
        switch event {
        case .fetchSavedCountries:
            output.countries = countryLocalRepo.savedCountries
        case let .toDetails(country):
            router.toDetails(country: country)
        case let .delete(offsets):
            deleteFromFavourite(at: offsets)
        }
    }
    
    private func deleteFromFavourite(at offsets: IndexSet) {
        for index in offsets {
            let item = output.countries[index]
            output.countries = countryLocalRepo.TappedCountry(country: item, state: .delete)
        }
    }
}
