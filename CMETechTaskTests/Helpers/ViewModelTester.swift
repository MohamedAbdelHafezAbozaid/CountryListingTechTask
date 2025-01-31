//
//  ViewModelTester.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Combine
import XCTest
import CMETechTask
import Commons

protocol ViewModelTester: XCTestCase {
    var cancellable: Set<AnyCancellable> { get set }
    associatedtype T: BaseViewModel
    func expect(_ sut: T,
                fulfillmentCount: Int,
                tocompleteWith completionAction: @escaping () -> Void,
                when action: () -> Void,
                file: StaticString,
                line: UInt
    )

    func expectedNavigation(_ sut: T,
                            tocompleteWith completionAction: @escaping () -> Void,
                            when action: () -> Void,
                            file: StaticString,
                            line: UInt
    )
}

extension ViewModelTester {
    @MainActor
    func expect(_ sut: T,
                fulfillmentCount: Int = 1,
                tocompleteWith completionAction: @escaping () -> Void,
                when action: () -> Void,
                file: StaticString = #filePath,
                line: UInt = #line
    ) {
        let exp = expectation(description: "wait for load completion")
        exp.expectedFulfillmentCount = fulfillmentCount
        var currentFulfillmentCount = 0
        sut
            .output
            .$dataStatus
            .sink { value in
                switch value {
                case let .success(result) where result == .finished:
                    currentFulfillmentCount += 1
                    exp.fulfill()
                    if currentFulfillmentCount == fulfillmentCount {
                        completionAction()
                    }
                case .failure:
                    XCTFail("Expected success, but received failure", file: file, line: line)
                default:
                    break
                }
            }
            .store(in: &cancellable)
        action()
        wait(for: [exp], timeout: 2.0)
    }

    @MainActor
    func expectedNavigation(_ sut: T,
                            tocompleteWith completionAction: @escaping () -> Void,
                            when action: () -> Void,
                            file: StaticString = #filePath,
                            line: UInt = #line
    ) {
        let expectation = XCTestExpectation(description: "Navigation should route")
        action()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionAction()
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }
}
