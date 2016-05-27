//
//  InMemoryCoreDataStack.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 26/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData

class InMemoryCoreDataStack: NSObject {
    
    func managedObjectContext() -> NSManagedObjectContext {
        let modelURL = NSBundle.mainBundle().URLForResource("dooit", withExtension: "momd")!
        let mom = NSManagedObjectModel(contentsOfURL: modelURL)!
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: mom)
        let failureReason = "There was an error creating or loading the application's saved data."
        
        do {
            try coordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }
    
}