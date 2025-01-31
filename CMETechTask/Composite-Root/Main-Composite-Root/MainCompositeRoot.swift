//
//  MainCompositeRoot.swift
//  Router
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation


public protocol Cachable {
    var localStorage: LocalCountryLoader { get }
}

public protocol Navigatables {
    var coordinator: NavigationStateProtocol { get }
}

public typealias RouteSessionCachable = Navigatables & Cachable

@MainActor
public final class MainCompositeRoot: RouteSessionCachable {
    public lazy var coordinator: NavigationStateProtocol = {
        MainCoordinator(
            router: BaseNavigationController(),
            compositeRoot: self
        )
    }()
    
    public lazy var localStorage: LocalCountryLoader = {
        LocalCountryStore.create()
    }()
    
    public init() {}
}
