//
//  ShowListsViewModel.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 25/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

class ShowListsViewModel {
    
    var delegate: ShowListsViewModelDelegate
    
    init(delegate: ShowListsViewModelDelegate) {
        self.delegate = delegate
    }
    
    func showLists() {
        delegate.showBlankstate()
    }
    
}

protocol ShowListsViewModelDelegate {
    
    func numberOfListsToShow() -> Int
    func listAtPosition(position: Int) -> List
    func showLists()
    func showBlankstate()
    
}