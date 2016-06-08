//
//  MarkItemViewModel.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 08/06/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData

class MarkItemViewModel {
    
    var managedObjectContext: NSManagedObjectContext
    var delegate: MarkItemViewModelDelegate
    
    init(delegate: MarkItemViewModelDelegate, managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        self.delegate = delegate
    }
    
    func changeMarkedStatusForItem(item: Item) {
        item.marked = !item.marked
        do {
            try managedObjectContext.save()
            if item.marked {
                delegate.setMarkedCallBack(item)
            } else {
                delegate.setUnmarkedCallBack(item)
            }
        } catch (_ as NSError) {
            
        }
    }
}

protocol MarkItemViewModelDelegate {
    
    func setMarkedCallBack(item: Item)
    func setUnmarkedCallBack(item: Item)
    
}