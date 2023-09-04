//
//  PersistanceStorage.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 22/10/22.
//

import Foundation
import CoreData
final class PersistanceStorage{
    private init (){
        
    }
    
    static let shared = PersistanceStorage()
    
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "SpeciesData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    lazy var context  = persistentContainer.viewContext
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
             
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        let request = SpeciesDataModel.fetchRequest() as NSFetchRequest <SpeciesDataModel>
        let sort = NSSortDescriptor(key: "pokemonNo", ascending: true)
        request.sortDescriptors = [sort]
        do {
            guard let result = try PersistanceStorage.shared.context.fetch(request) as? [T] else {return nil}
            
            
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
}
