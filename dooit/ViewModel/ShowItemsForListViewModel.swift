//
//  ShowItemsForListViewModel.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 02/06/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData

class ShowItemsForListViewModel {
    
    var delegate: ShowItemsForListViewModelDelegate
    var managedObjectContext: NSManagedObjectContext
    var list: List
    var items: [Item] = []
    
    init(delegate: ShowItemsForListViewModelDelegate, managedObjectContext: NSManagedObjectContext, list: List) {
        self.delegate = delegate
        self.managedObjectContext = managedObjectContext
        self.list = list
    }
    
    func fetchItems() {
        items = Array(list.items)
        if items.count == 0 {
            delegate.presentBlankState()
        } else {
            delegate.presentItems()
        }
    }
    
}

protocol ShowItemsForListViewModelDelegate {
    
    func presentItems()
    func presentBlankState()
    
}