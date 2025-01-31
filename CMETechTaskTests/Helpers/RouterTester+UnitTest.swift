//
//  RouterTester+UnitTest.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Combine
import XCTest
import CMETechTask

protocol RouterTester: XCTestCase {
    func expectedNavigation(
        tocompleteWith completionAction: @escaping () -> Void,
        when action: () -> Void,
        file: StaticString,
        line: UInt
    )
}

extension RouterTester {
    @MainActor
    func expectedNavigation(
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
        wait(for: [expectation], timeout: 10.0)
    }
}
