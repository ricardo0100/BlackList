//
//  List.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 26/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData

@objc(List)
class List: NSManagedObject {

    @NSManaged func addItemsObject(value: Item)
    @NSManaged func removeItemsObject(value: Item)
    
    override func willSave() {
        if self.updateTime == nil {
            self.updateTime = NSDate()
        }
    }
    
    
}
