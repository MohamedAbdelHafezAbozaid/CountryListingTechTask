//
//  LocalCountryStore.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation


public class LocalCountryStore: ObservableObject {
        
    public static func create()  -> LocalCountryLoader {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let specificStoreURL = cacheDirectory.appendingPathComponent("\(type(of: self)).store")
        let store = try! CoreDataCountryStore(storeURL: specificStoreURL)
        let loader = LocalCountryLoader(store: store)
        return loader
    }
}
