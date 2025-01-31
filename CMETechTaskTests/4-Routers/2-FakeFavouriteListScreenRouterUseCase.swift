//
//  2-FakeFavouriteListScreenRouterUseCase.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//
import XCTest
import AppCore
import CMETechTask
import SwiftUI
import Commons
import CoreLocation

class FakeFavouriteListScreenRouterUseCaseTests: XCTestCase, RouterTester {
    var fakeMainFCompositeRoot = FakeMainCompositeRoute()
    
    private func makeSut() -> FavouriteListScreenRouterProtocol {
        FavouriteListScreenRouter(
            mainSession: fakeMainFCompositeRoot
        )
    }
    
    @MainActor
    func test_FakeFavouriteListScreenRouterUseCase_NavigationRouter_ShouldRouteToDetailsViewSuccessfully() {
        // Arrange
        let sut = makeSut()
        
        let country = Country(
            name: "test",
            currency: "test",
            flag: "test",
            capital: "test",
            coordinate: CLLocationCoordinate2D(
                latitude: 2.0,
                longitude: 1.0
            )
        )
        
        let route = MainRoute
            .detailCountryView(
                mainSession: fakeMainFCompositeRoot,
                country: country
            )
        expectedNavigation { [weak self] in
            guard let self else { return }
            
            if
                let fakeRouter = fakeMainFCompositeRoot.coordinator.router as? FakeRouter {
                let pushedVC = fakeRouter.pushedViewControllers
                XCTAssertTrue(!pushedVC.isEmpty)
                XCTAssertTrue(fakeRouter.pushViewControllerCalled)
                if
                    let vco = pushedVC[0] as? UIHostingController<MainRoute> {
                    XCTAssertEqual(vco.rootView, route)
                }
            } else {
                XCTFail("failed")
            }
        } when: {
            sut
                .toDetails(
                    country: country
                )
        }
    }
}

class FakeFavouriteListScreenRouterUseCase: FavouriteListScreenRouterProtocol {
    var views = [TestViews]()
    
    func toDetails(country: Country) {
        views.append(.detailsView)
    }
}
