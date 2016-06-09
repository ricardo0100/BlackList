//
//  DeleteItemFromListViewModel.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 08/06/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData

class DeleteItemFromListViewModel {
    
    var managedObjectContext: NSManagedObjectContext
    var delegate: DeleteItemFromListViewModelDelegate
    var list: List
    
    init(delegate: DeleteItemFromListViewModelDelegate, managedObjectContext: NSManagedObjectContext, list: List) {
        self.managedObjectContext = managedObjectContext
        self.delegate = delegate
        self.list = list
    }
    
    func deleteItem(item: Item) {
        managedObjectContext.deleteObject(item)
        do {
            try managedObjectContext.save()
            delegate.deleteItemFromListSuccessCallback()
        } catch _ as NSError {
            delegate.deleteItemFromListErrorCallback()
        }
    }
    
}

protocol DeleteItemFromListViewModelDelegate {
    
    func deleteItemFromListSuccessCallback()
    func deleteItemFromListErrorCallback()
    
}
