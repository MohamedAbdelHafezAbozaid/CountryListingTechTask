//
//  BaseRouter.swift
//  Router
//
//  Created by mohamed ahmed on 30/01/2025.
//

import SwiftUI
import UIKit

final public class MainCoordinator: NavigationStateProtocol, CountriesListViewFactoryProtocol {
    public let router: UINavigationController
    let compositeRoot: RouteSessionCachable
    
    public init(
        router: UINavigationController,
        compositeRoot: RouteSessionCachable
    ) {
        self.router = router
        self.compositeRoot = compositeRoot
    }
    
    public func goTo(_ route: MainRoute) {
        let customViewController = UIHostingController(
            rootView: route
        )
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(customBackButtonTapped)
        )
        backButton.tintColor = .black
        customViewController.navigationItem.leftBarButtonItem = backButton
        
        router.pushViewController(customViewController, animated: true)
    }
    
    public func goBack() {
        router.popViewController(animated: true)
    }
    
    public func getInitialScreen(_ route: MainRoute) {
        let hostingController = UIHostingController(
            rootView: route
        )
        router.pushViewController(hostingController, animated: false)
    }
    
    @objc private func customBackButtonTapped() {
        goBack()
    }
}
