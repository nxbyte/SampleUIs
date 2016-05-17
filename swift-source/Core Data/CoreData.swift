// Developer: Warren Seto
//      File: CoreData.swift
//   Purpose: Standard Singleton that manages the Core Data stack

import UIKit
import CoreData

public final class CoreData
{
    /** Core Data Singleton Instance. An entry point to use the Core Data Stack */
    static let app = CoreData()
    
    /** Main Core Data variable to access data */
    lazy var managedObjectContext: NSManagedObjectContext =
    {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType),
            context = NSPersistentStoreCoordinator(managedObjectModel: NSManagedObjectModel(contentsOfURL: NSBundle.mainBundle().URLForResource("CoreData", withExtension: "momd")!)!),
            storeURL = NSURL(string: "SingleViewCoreData.sqlite", relativeToURL: NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first)
            
        do
        {
            try context.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        }
        catch let err as NSError
        {
            print("Could not perform operation: \(err), \(err.userInfo)")
            abort()
        }
        
        managedObjectContext.persistentStoreCoordinator = context
        return managedObjectContext
    }()
    
    /** Core Data save function. Essentially serves as a COMMIT */
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