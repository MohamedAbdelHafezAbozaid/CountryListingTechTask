//
//  ManagedCountryItem.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Foundation
import CoreData
import struct Commons.Country

@objc(ManagedCountryItem)
public class ManagedCountryItem: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var flag: String
    @NSManaged var currency: String
    @NSManaged var capital: String
}

extension ManagedCountryItem {
    static func images(from product: [Country], in context: NSManagedObjectContext) -> NSOrderedSet {
        let images = NSOrderedSet(array: product.map { local in
            let managed = ManagedCountryItem(context: context)
            managed.id = local.id
            managed.name = local.name
            managed.flag = local.flag
            managed.currency = local.currency
            managed.capital = local.capital
            return managed
        })
        context.userInfo.removeAllObjects()
        return images
    }
    
    
    convenience init(country: Country ,context: NSManagedObjectContext){
        self.init(context: context)
        id = country.id
        name = country.name
        flag = country.flag
        currency = country.currency
        capital = country.capital
    }
    
    public var presentableCart: Country {
        return Country(
            name: name,
            currency: currency,
            flag: flag,
            capital: capital,
            coordinate: nil
        )
    }
}
