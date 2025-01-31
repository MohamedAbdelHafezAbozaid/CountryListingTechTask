//
//  ViewDidLoad.swift
//  Commons
//
//  Created by mohamed ahmed on 30/01/2025.
//

import SwiftUI

public struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    let action: () -> Void

    public func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action()
                }
            }
    }
}

public extension View {
    func onViewDidLoad(perform action: @escaping () -> Void) -> some View {
        modifier(ViewDidLoadModifier(action: action))
    }
}
