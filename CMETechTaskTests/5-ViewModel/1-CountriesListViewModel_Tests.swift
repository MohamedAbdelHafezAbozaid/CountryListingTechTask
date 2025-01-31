//
//  1-CountriesListViewModel_Tests.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 31/01/2025.
//
import XCTest
import AppCore
import CMETechTask
import SwiftUI
import Commons
import CoreLocation
import Combine

final class CountriesListViewModelTests: XCTestCase, ViewModelTester {
    typealias T = CountriesListViewModel
    
    var cancellable: Set<AnyCancellable> = []
    
    let router = FakeCountrieListScreenRouterUseCase()
    var fakeMainFCompositeRoot = FakeMainCompositeRoute()
    
    override func setUp() {
        super.setUp()
        router.views.append(.countriesListView)
    }
    
    private func makeSuccessCountriesLoaderApi() -> CountriesLoaderAPI {
        CountriesLoaderApiSuccessSpy(
            httpClient: MockHTTPClient(
                mockFileName: "MockCountries"
            ))
    }
    
    @MainActor
    private func makeSUT() -> CountriesListViewModel {
        CountriesListViewModel(
            countriesRepo: CountriesLoaderRepositorySpy(
                spy: makeSuccessCountriesLoaderApi()
            ),
            countryLocalRepo: fakeMainFCompositeRoot.localStorage,
            locationManager: LocationManager(),
            router: router
        )
    }
    
    @MainActor
    func test_CountriesListViewModel_Navigation_toFavouritListListCalledOnce() throws {
        // Arrange
        let sut = makeSUT()
        // Act
        expectedNavigation(sut) { [weak self] in
            guard let self else { return }
            XCTAssertEqual(router.views, [.countriesListView, .favouriteListView])
        } when: {
            sut
                .input
                .ipActions
                .send(
                    .toFavScreen
                )
        }
    }
}
