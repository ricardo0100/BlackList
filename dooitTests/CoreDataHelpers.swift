//
//  CoreDataHelpers.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 02/06/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData
@testable import dooit

class CoreDataHelpers {
    
    static func createListWithTitle(title: String) -> List {
        let moc = InMemoryCoreDataStack.sharedInstance.managedObjectContext
        let entity =  NSEntityDescription.entityForName("List", inManagedObjectContext: moc)
        let list = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: moc) as! List
        list.title = title
        try! moc.save()
        return list
    }
    
    static func createItemForList(list: List, withTitle title: String) -> Item {
        let moc = InMemoryCoreDataStack.sharedInstance.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Item", inManagedObjectContext:moc)
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: moc) as! Item
        item.title = title
        list.addItemsObject(item)
        try! moc.save()
        return item
    }
    
    static func createItemForList(list: List, withTitle title: String, andMarked marked: Bool) -> Item {
        let moc = InMemoryCoreDataStack.sharedInstance.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Item", inManagedObjectContext:moc)
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: moc) as! Item
        item.title = title
        item.marked = marked
        list.addItemsObject(item)
        try! moc.save()
        return item
    }
    
    static func retrieveAllLists() -> [List] {
        let moc = InMemoryCoreDataStack.sharedInstance.managedObjectContext
        let results = try! moc.executeFetchRequest(NSFetchRequest(entityName: "List"))
        let lists = results as! [List]
        return lists
    }
    
    static func retrieveAllItemsForList(list: List) -> [Item] {
        let moc = InMemoryCoreDataStack.sharedInstance.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Item")
        let results = try! moc.executeFetchRequest(fetchRequest)
        let items = results as! [Item]
        return items
    }
    
}
