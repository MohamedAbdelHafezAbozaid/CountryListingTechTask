//
//  DetailsViewModel.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation
import Commons
import Combine

public protocol DetailsViewModelProtocol {
    var input: DetailsViewModel.Input { get }
    var output: DetailsViewModel.Output { get }
}

extension DetailsViewModel {
    public class Input: ObservableObject {
//        public let ipActions: AnyUIEvent<Events> = .create()
    }
}

extension DetailsViewModel {
    public class Output: ViewModelOutput {
        @Published public var country: Country
        public init(country: Country) {
            self.country = country
        }
    }
}

public final class DetailsViewModel: BaseViewModel, @preconcurrency DetailsViewModelProtocol {
    
    public var cancellables = Set<AnyCancellable>()
    
    public let input: Input
    public let output: Output
    
    public init(
        country: Country
    ) {
//        self.router = router
        
        self.input = .init()
        self.output = .init(country: country)
        
//        observeInputs()
    }
    
//    private func observeInputs() {
//        input
//            .ipActions
//            .sink { [weak self] event in
//                guard
//                    let self else { return }
//                
//                receive(event)
//            }
//            .store(in: &cancellables)
//    }
    
//    public enum Events {
//        case goBack
//    }
//    
//    @MainActor
//    public func receive(_ event: Events) {
//        switch event {
//        case .goBack:
//            router.goBack()
//        }
//    }
}
