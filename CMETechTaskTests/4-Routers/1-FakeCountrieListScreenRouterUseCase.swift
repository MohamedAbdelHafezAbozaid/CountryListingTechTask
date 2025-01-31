//
//  FakeCountrieListScreenRouterUseCase.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import XCTest
import AppCore
import CMETechTask
import SwiftUI

class FakeCountrieListScreenRouterUseCaseTests: XCTestCase, RouterTester {
    var fakeMainFCompositeRoot = FakeMainCompositeRoute()
    
    private func makeSut() -> CountrieListScreenRouterProtocol {
        CountrieListScreenRouter(
            mainSession: fakeMainFCompositeRoot
        )
    }
    
    @MainActor
    func test_FakeCountrieListScreenRouterUseCase_NavigationRouter_ShouldRouteToFavouriteListSuccessfully() {
        // Arrange
        let sut = makeSut()
        
        let route = MainRoute
            .favoriteCountryListView(
                mainSession: fakeMainFCompositeRoot
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
                .openFavouritesScreen()
        }
    }
}

class FakeCountrieListScreenRouterUseCase: CountrieListScreenRouterProtocol {
    var views = [TestViews]()
    
    func openFavouritesScreen() {
        views.append(.favouriteListView)
    }
}
