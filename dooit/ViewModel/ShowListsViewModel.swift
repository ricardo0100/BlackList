//
//  ShowListsViewModel.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 25/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData

class ShowListsViewModel {
    
    var delegate: ShowListsViewModelDelegate
    var managedObjectContext: NSManagedObjectContext
    
    var lists: [List] = []
    
    init(delegate: ShowListsViewModelDelegate, managedObjectContext: NSManagedObjectContext) {
        self.delegate = delegate
        self.managedObjectContext = managedObjectContext
    }
    
    func fetchLists() {
        let fetchRequest = NSFetchRequest(entityName: "List")
        do {
            let results = try managedObjectContext.executeFetchRequest(fetchRequest)
            lists = results as! [List]
            presentLists()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    private func presentLists() {
        if lists.count == 0 {
            delegate.showBlankstate()
        } else {
            delegate.showLists()
        }
    }
    
}

protocol ShowListsViewModelDelegate {
    
    func showLists()
    func showBlankstate()
    
}
