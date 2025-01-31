//
//  ViewModelOutput.swift
//  Commons
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation

@MainActor
open class ViewModelOutput: ObservableObject {
    public init(){}
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var presentableError = ""

    public let defaultError = NSError(domain: "SomeThing went wrong please try again later", code: 0)

    @Published public var dataStatus: DataState? {
        didSet {
            switch dataStatus {
            case let .failure(err):
                presentableError = err.localizedDescription
                showAlert = true
                if isLoading {
                    isLoading = false
                }
                
            case let .success(value):
                switch value {
                case .loading:
                    isLoading = true
                case .finished:
                    isLoading = false
                    presentableError = ""
                    showAlert = false
                }
                
            case .none:
                break
            }
            
        }
    }
}
