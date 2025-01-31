//
//  AppConfigManager.swift
//  AppNetworking
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation

enum AppBaseURL: String, Codable {
    case staging = "https://restcountries.com/v3.1"
}

class AppConfigManager {
    static let shared = AppConfigManager()
    
    //MARK: BaseURL
    func selectBaseUrl(_ url: AppBaseURL) {
        NetworkingAppDefault.shared.save(url, forKey: .baseUrl)
    }
    
    func getSelectedBaseURL() -> String {
        guard let baseUrl: AppBaseURL = NetworkingAppDefault.shared.get(.baseUrl) else { return AppBaseURL.staging.rawValue }
        return baseUrl.rawValue
    }
}


