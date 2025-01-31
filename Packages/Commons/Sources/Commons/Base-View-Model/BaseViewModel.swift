//
//  BaseViewModel.swift
//  Commons
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation
import Combine

@MainActor
public protocol BaseViewModel {
    associatedtype Input: ObservableObject
    associatedtype Output: ViewModelOutput
    var input: Input { get }
    var output: Output { get }
}

