//
//  SaveItemForListViewModel.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 08/06/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData

class SaveItemForListViewModel {
    
    let emptyTitleErrorMessage = "You must provide a title for the item"
    let savingSuccessMessage = "Item saved"
    
    var delegate: SaveItemForListViewModelDelegate
    var managedObjectContext: NSManagedObjectContext
    var list: List
    
    init(delegate: SaveItemForListViewModelDelegate, managedObjectContext: NSManagedObjectContext, list: List) {
        self.delegate = delegate
        self.managedObjectContext = managedObjectContext
        self.list = list
    }
    
    func saveNewItemWithTitle(title: String) {
        let entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: managedObjectContext)
        let item = NSManagedObject.init(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! Item
        item.title = title
        list.addItemsObject(item)
        do {
            try managedObjectContext.save()
            delegate.showSaveItemSuccessMessage(savingSuccessMessage)
        } catch _ as NSError {
            delegate.showSaveItemErrorMessage(emptyTitleErrorMessage)
        }
    }
    
}

protocol SaveItemForListViewModelDelegate {
    
    func showSaveItemSuccessMessage(message: String)
    func showSaveItemErrorMessage(message: String)
    
}
