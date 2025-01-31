//
//  APIError.swift
//  AppNetworking
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation

enum APIError: Swift.Error, LocalizedError {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
}
