//
//  CountriesListViewModel.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//
import Foundation
import Commons
import Combine
import AppCore
import CoreLocation

public protocol CountriesListViewModelProtocol {
    var input: CountriesListViewModel.Input { get }
    var output: CountriesListViewModel.Output { get }
}

extension CountriesListViewModel {
    public class Input: ObservableObject {
        public let ipActions: AnyUIEvent<Events> = .create()
        @Published public var searchText: String = ""
    }
}

extension CountriesListViewModel {
    public class Output: ViewModelOutput {
        @Published public var presentableCountries: [Country] = []
        @Published public var FavCount: Int = 0
        
        public init(FavCount: Int) {
            self.FavCount = FavCount
        }
    }
}

public final class CountriesListViewModel: BaseViewModel, CountriesListFlowProtocol, @preconcurrency CountriesListViewModelProtocol {
    
    public var cancellables = Set<AnyCancellable>()
    private var Countries: [Country] = []
    
    public let input: Input
    public let output: Output
    
    public var countriesRepo: CountriesLoaderRepositoryProtocol
    public var countryLocalRepo: LocalCountryLoader
    public let router: CountrieListScreenRouterProtocol
    let locationManager: LocationManagerCallBackDelegate
    
    
    public init(
        countriesRepo: CountriesLoaderRepositoryProtocol,
        countryLocalRepo: LocalCountryLoader,
        locationManager: LocationManagerCallBackDelegate,
        router: CountrieListScreenRouterProtocol
    ) {
        
        self.countriesRepo = countriesRepo
        self.countryLocalRepo = countryLocalRepo
        self.router = router
        self.locationManager = locationManager
        
        self.input = .init()
        self.output = .init(FavCount: countryLocalRepo.savedCountries.count)
        
        setupBindings()
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
    
    @MainActor
    private func setupBindings() {
        input
            .$searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .compactMap { $0 }
            .removeDuplicates()
            .map { [weak self] searchText in
                self?.filterCountries(searchText: searchText, countries: self?.Countries ?? []) ?? []
            }
            .assign(to: &output.$presentableCountries)
        
        
        locationManager
            .getAccess
            .compactMap {$0}
            .sink { [weak self] access in
                guard let self, access == false else { return }
                guard let myCountry = filterCountries(searchText: "Egypt", countries: Countries).first else { return }
                receive(.addToFav(myCountry))
            }
            .store(in: &cancellables)
        
        locationManager
            .userLocation
            .compactMap {$0}
            .combineLatest(locationManager.getAccess)
            .sink {[weak self] location, access in
                guard let self, let access = access, access == true else { return }
                    let closest = closestCountry(to: location, from: Countries)
                    guard let closest else { return }
                    receive(.addToFav(closest))
            }
            .store(in: &cancellables)
            
    }
    
    
    
    public enum Events {
        case fetchCountries
        case addToFav(Country)
        case toFavScreen
        case updateCount
    }
    
    @MainActor
    public func receive(_ event: Events) {
        switch event {
        case .fetchCountries:
            fetchAllCountries()
        case let .addToFav(country):
            FavCountChecker(country)
        case .toFavScreen:
            router.openFavouritesScreen()
        case .updateCount:
            output.FavCount = countryLocalRepo.savedCountries.count
        }
    }
    
    private func FavCountChecker(_ country: Country) {
        if countryLocalRepo.savedCountries.count == 5 {
            output.dataStatus = .success(.loading)
            output.dataStatus = .failure(CustomError.maxAmountReached)
        } else {
            let saved = countryLocalRepo.TappedCountry(country: country, state: .save)
            output.FavCount = saved.count
        }
    }
    
    private func fetchAllCountries() {
        Task {
            do {
                output.dataStatus = .success(.loading)
                Countries =  try await self.getAllCountries()
                locationManager.startUpdatingLocation()
                output.presentableCountries = Countries
                output.dataStatus = .success(.finished)
            } catch {
                output.dataStatus = .failure(error)
            }
        }
    }
    
    
    func closestCountry(to userLocation: CLLocationCoordinate2D, from countries: [Country]) -> Country? {
        guard !countries.isEmpty else { return nil }
        
        return countries
            .compactMap { country -> (Country, CLLocationDistance)? in
                guard let coordinate = country.coordinate else { return nil }
                
                let countryLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                let userLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
                let distance = userLocation.distance(from: countryLocation)
                
                return (country, distance)
            }
            .min(by: { $0.1 < $1.1 })?
            .0
    }
}
