//
//  Country.swift
//  Commons
//
//  Created by mohamed ahmed on 30/01/2025.
//
import Foundation
import CoreLocation

public struct Country: Identifiable {
    public var id: String { UUID().uuidString }
    public var name: String
    public var currency: String
    public var flag: String
    public var capital: String
    public var coordinate: CLLocationCoordinate2D?
    
    public init(name: String, currency: String, flag: String, capital: String, coordinate: CLLocationCoordinate2D?) {
        self.name = name
        self.currency = currency
        self.flag = flag
        self.capital = capital
        self.coordinate = coordinate
    }
}
