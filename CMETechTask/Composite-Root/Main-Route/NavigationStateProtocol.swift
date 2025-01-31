// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import UIKit

//@MainActor

public protocol Coordinator {
  var router: UINavigationController { get }
  func getInitialScreen(_ route: MainRoute)
}

public protocol NavigationStateProtocol: Coordinator {
    func goTo(_ route: MainRoute)
    func goBack()
}
