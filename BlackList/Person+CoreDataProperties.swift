//
//  Person+CoreDataProperties.swift
//  BlackList
//
//  Created by Ricardo Gehrke Filho on 20/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Person {

    @NSManaged var name: String?
    @NSManaged var reasons: NSSet?

    @NSManaged func addReasonsObject(value: Reason)
    @NSManaged func removeReasonsObject(value: Reason)
}
