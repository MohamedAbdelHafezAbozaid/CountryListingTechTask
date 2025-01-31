//
//  CoreDataCountryStore.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import CoreData
import Combine
import struct Commons.Country

public final class CoreDataCountryStore: CountryStore {
    
    private static let modelName = "UserFavourite"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle.main)
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    
    public init(storeURL: URL) throws {
        container = try NSPersistentContainer.load(name: CoreDataCountryStore.modelName, model: CoreDataCountryStore.model!, url: storeURL)
        context = container.viewContext
    }
    
    
    public func save(item: Country) {
        perform { context in
            _ = ManagedCountryItem(country: item, context: context)
            try! context.save()
            print("Product added to cart")
        }
    }
    
    public func getItem(title: String, completion: @escaping (ManagedCountryItem?) -> Void) {
        perform { context in
            let predicate = NSPredicate(format: "%K == %@", #keyPath(ManagedCountryItem.name), title)
            let product = self.fetch(ManagedCountryItem.self, predicate: predicate, managedContext: context)
            completion(product?.first)
        }
    }
    
    public func deleteCountry(title: String) {
        perform { context in
            self.getItem(title: title) { product in
                if let product = product {
                    context.delete(product)
                    try! context.save()
                    print("Product deleted from cart")
                }
            }
        }
    }
    
    public func fetchAllCountries() -> AnyPublisher<[Country], Error> {
        let cachedCountry = self.fetch(ManagedCountryItem.self, managedContext: context)
        return Future<[Country], Error> { Promise in
            var data = [Country]()
            guard let cachedCountry = cachedCountry else {
               return Promise(.success([]))
            }
            for country in cachedCountry {
                data.append(country.presentableCart)
            }
            Promise(.success(data))
        }.eraseToAnyPublisher()
        
    }
    
    private func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context)}
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil, managedContext:  NSManagedObjectContext)->[T]?{
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = predicate
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0 {
                return result as? [T]
            } else {
                print("No saved objects")
            }
        } catch let error {
            print("Could not fetch. \(error), \(error.localizedDescription)")
        }
        return nil
    }
}
