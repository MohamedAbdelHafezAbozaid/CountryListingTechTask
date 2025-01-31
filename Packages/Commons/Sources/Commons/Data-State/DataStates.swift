//
//  DataStates.swift
//  Commons
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation

public enum DataStates: Hashable {
  case loading
  case finished
}

public typealias DataState =  Result<DataStates, Error>

