//
//  SaveListViewModel.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 28/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData

class SaveListViewModel {
    
    let emptyTitleErrorMessage = "You must provide a title for the list"
    let savingSuccessMessage = "List saved"
    
    var delegate: SaveListViewModelDelegate
    var managedObjectContext: NSManagedObjectContext
    var list: List
    
    init (delegate: SaveListViewModelDelegate, managedObjectContext: NSManagedObjectContext) {
        self.delegate = delegate
        self.managedObjectContext = managedObjectContext
        let entity =  NSEntityDescription.entityForName("List", inManagedObjectContext:managedObjectContext)
        list = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! List
    }
    
    init (delegate: SaveListViewModelDelegate, managedObjectContext: NSManagedObjectContext, list: List) {
        self.delegate = delegate
        self.managedObjectContext = managedObjectContext
        self.list = list
    }
    
    func saveList() {
        do {
            try managedObjectContext.save()
            delegate.showSuccessMessage(savingSuccessMessage)
        } catch _ as NSError {
            delegate.showErrorMessage(emptyTitleErrorMessage)
        }
    }
    
}

protocol SaveListViewModelDelegate {
    
    func showSuccessMessage(message: String)
    func showErrorMessage(message: String)
    
}