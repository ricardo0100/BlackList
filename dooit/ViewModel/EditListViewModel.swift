//
//  EditListViewModel.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 28/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData

class EditListViewModel {
    
    let emptyTitleErrorMessage = "You must provide a title for the list"
    let savingSuccessMessage = "List saved"
    
    var delegate: EditListViewModelDelegate
    var managedObjectContext: NSManagedObjectContext
    var list: List
    
    init (delegate: EditListViewModelDelegate, managedObjectContext: NSManagedObjectContext) {
        self.delegate = delegate
        self.managedObjectContext = managedObjectContext
        let entity =  NSEntityDescription.entityForName("List", inManagedObjectContext:managedObjectContext)
        list = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! List
    }
    
    init (delegate: EditListViewModelDelegate, managedObjectContext: NSManagedObjectContext, list: List) {
        self.delegate = delegate
        self.managedObjectContext = managedObjectContext
        self.list = list
        delegate.presentExistingListForEditing()
    }
    
    func saveList() {
        do {
            try managedObjectContext.save()
            delegate.showSaveListSuccessMessage(savingSuccessMessage)
        } catch _ as NSError {
            delegate.showSaveListErrorMessage(emptyTitleErrorMessage)
        }
    }
    
    func cancelEditing() {
        managedObjectContext.reset()
        delegate.cancelEditingCallBack()
    }
    
}

protocol EditListViewModelDelegate {
    
    func showSaveListSuccessMessage(message: String)
    func showSaveListErrorMessage(message: String)
    func presentExistingListForEditing()
    func cancelEditingCallBack()
    
}
