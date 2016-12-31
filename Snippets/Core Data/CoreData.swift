
/*
    Developer: Warren Seto
    File: CoreData.swift
    Purpose: Standard Singleton that manages the Core Data stack
*/

 
import UIKit
import CoreData

public final class CoreData
{
    /** Core Data Singleton Instance. An entry point to use the Core Data Stack */
    static let app = CoreData()
    
    /** Main Core Data variable to access data */
    lazy var managedObjectContext: NSManagedObjectContext =
        {
            let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType),
            context = NSPersistentStoreCoordinator(managedObjectModel: NSManagedObjectModel(contentsOf: Bundle.main.url(forResource: "CoreData", withExtension: "momd")!)!),
            storeURL = URL(string: "SingleViewCoreData.sqlite", relativeTo: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)
            
            do
            {
                try context.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            }
            catch let err as NSError
            {
                print("Could not perform operation: \(err), \(err.userInfo)")
                abort()
            }
            
            managedObjectContext.persistentStoreCoordinator = context
            return managedObjectContext
    }()
    
    /** Core Data save function. Essentially serves as a COMMIT in database sense */
    internal func save()
    {
        if managedObjectContext.hasChanges
        {
            do
            {
                try managedObjectContext.save()
            }
            catch let err as NSError
            {
                print("Could not save: \(err), \(err.userInfo)")
                abort()
            }
        }
    }
}
