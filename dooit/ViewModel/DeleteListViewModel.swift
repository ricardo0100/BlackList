//
//  DeleteListViewModel.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 31/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData

class DeleteListViewModel {
    
    var delegate: DeleteListViewModelDelegate
    var managedObjectContext: NSManagedObjectContext
    
    init (delegate: DeleteListViewModelDelegate, managedObjectContext: NSManagedObjectContext) {
        self.delegate = delegate
        self.managedObjectContext = managedObjectContext
    }
    
    func deleteList(list: List) {
        managedObjectContext.deleteObject(list)
        do {
            try SQLiteCoreDataStack.sharedInstance.managedObjectContext.save()
            delegate.deleteListSuccessCallback()
        } catch _ as NSError  {
            delegate.deleteListErrorCallback()
        }
    }
    
}

protocol DeleteListViewModelDelegate {
    
    func deleteListSuccessCallback()
    func deleteListErrorCallback()
    
}