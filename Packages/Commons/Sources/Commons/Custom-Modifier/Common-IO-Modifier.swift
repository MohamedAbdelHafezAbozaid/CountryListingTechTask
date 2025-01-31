//
//  Common-IO-Modifier.swift
//  Commons
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation
import SwiftUI

public extension View {
    @MainActor
    public func commonIOModifiers(
        vmOutput: ViewModelOutput,
        viewonAppear onaction: @escaping () -> Void = { },
        viewDidLoad action: @escaping () -> Void = { },
        viewDidDisAppear disaction: @escaping () -> Void = { },
        errorCallBackAction: @escaping () -> Void = { }
    ) -> some View {
        let bindableVMOutput: Binding<ViewModelOutput> = .constant(vmOutput)
        return self
            .loadingModifier(showLoader: bindableVMOutput.isLoading)
            .alert(
                bindableVMOutput.presentableError.wrappedValue,
                isPresented: bindableVMOutput.showAlert
            ) {
                Button("OK", role: .cancel) {
                    errorCallBackAction()
                }
            }
            .onAppear(perform: onaction)
            .onViewDidLoad(perform: action)
            .onDisappear(perform: disaction)
    }
}
