//
//  List.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 22/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData


class List: NSManagedObject {

    @NSManaged func addItemsObject(value: Item)
    @NSManaged func removeItemsObject(value: Item)

}
