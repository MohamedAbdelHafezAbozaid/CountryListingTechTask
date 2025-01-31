//
//  FakeMainCompositeRoot.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//
import Foundation
import SwiftUI
import UIKit
import CMETechTask

public final class FakeRouter: UINavigationController {
    public var presentCalled: Bool = false
    public var pushViewControllerCalled: Bool = false
    public var popViewControllerCalled: Bool = false
    public var setViewControllersCalled: Bool = false

    public var presentedViewControler: UIViewController?
    public var pushedViewControllers: [UIViewController] = []
    public var poppedViewController: UIViewController?
    public var setViewControllers: [UIViewController] = []

    public var animatedFlag: Bool?

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCalled = true
        presentedViewControler = viewControllerToPresent
        animatedFlag = flag
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }

    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
        pushedViewControllers.append(viewController)
        animatedFlag = animated
        super.pushViewController(viewController, animated: animated)
    }

    override public func popViewController(animated: Bool) -> UIViewController? {
        popViewControllerCalled = true
        animatedFlag = animated
        let poppedVC = super.popViewController(animated: animated)
        poppedViewController = poppedVC
        return poppedVC
    }

    override public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        setViewControllersCalled = true
        setViewControllers = viewControllers
        animatedFlag = animated
        super.setViewControllers(viewControllers, animated: animated)
    }

    public func reset() {
        presentCalled = false
        pushViewControllerCalled = false
        popViewControllerCalled = false
        setViewControllersCalled = false

        presentedViewControler = nil
        pushedViewControllers.removeAll()
        poppedViewController = nil
        setViewControllers.removeAll()

        animatedFlag = nil
    }
}


class FakeMainCompositeRoute: RouteSessionCachable {
    
    public lazy var coordinator: NavigationStateProtocol = {
        MainCoordinator(
            router: FakeRouter(),
            compositeRoot: self
        )
    }()

    public lazy var localStorage: LocalCountryLoader = {
        LocalCountryStore.create()
    }()

    public init() {}
}
