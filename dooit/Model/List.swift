//
//  List.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 23/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData

@objc(List)
class List: NSManagedObject {

    @NSManaged func addItemsObject(value: Item)
    @NSManaged func removeItemsObject(value: Item)

}
