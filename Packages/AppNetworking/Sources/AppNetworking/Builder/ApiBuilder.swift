//
//  ApiBuilder.swift
//  AppNetworking
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation

public enum ApiBuilder {
    case allCountries
}

extension ApiBuilder: EndPointType {
    
    
    var parameters: Parameters? {
        switch self {
        case .allCountries:
            return nil
        }
    }
    
    public var headers: HTTPHeaders? {
        switch self {
        default:
            return defaultHeaders
        }
    }
    
    public var task: HTTPTask {
        switch self {
        default:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: parameters, additionHeaders: headers)
        }
        
    }
    
    public var path: ServerPaths {
        switch self {
        case .allCountries:
            return .all
        }
    }
    
    public var pathArgs: [String]? {
        switch self {
        case .allCountries:
            return nil
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
}




