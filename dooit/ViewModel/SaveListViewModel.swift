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
    
    let emptyTitleError = "You must provide a title for the list"
    
    var delegate: SaveListViewModelDelegate
    var managedObjectContext: NSManagedObjectContext
    var list: List?
    
    init (delegate: SaveListViewModelDelegate, managedObjectContext: NSManagedObjectContext) {
        self.delegate = delegate
        self.managedObjectContext = managedObjectContext
    }
    
    init (delegate: SaveListViewModelDelegate, managedObjectContext: NSManagedObjectContext, list: List) {
        self.delegate = delegate
        self.managedObjectContext = managedObjectContext
        self.list = list
    }
    
    func saveList(list: List) {
        delegate.showErrorMessage(emptyTitleError)
    }
    
}

protocol SaveListViewModelDelegate {
    
    func showSuccessMessage(message: String)
    func showErrorMessage(message: String)
    
}