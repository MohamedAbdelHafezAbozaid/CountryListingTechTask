//
//  LoaderModifier.swift
//  Commons
//
//  Created by mohamed ahmed on 30/01/2025.
//
import SwiftUI

public struct LoaderModifier: ViewModifier {
    @Binding var showLoader: Bool

    public func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(showLoader)
            if showLoader {
                ProgressView()
            }
        }
    }
}

extension View {
    public func loadingModifier(showLoader: Binding<Bool>) -> some View {
        modifier(LoaderModifier(showLoader: showLoader))
    }
}
