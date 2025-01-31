//
//  ViewModelType.swift
//  Commons
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation
import Combine

public typealias AnyUIEvent<T> = AnySubject<T, Never>

public extension AnyUIEvent {
    static func create<T>() -> AnyUIEvent<T> {
        return PassthroughSubject<T, Never>().eraseToAnySubject()
    }
}

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
