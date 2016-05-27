//
//  ShowListsViewModelDelegateDouble.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 25/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
@testable import dooit

class ShowListsViewModelDelegateDouble: ShowListsViewModelDelegate {
    
    var showListsCalled = false
    var showBlankstateCalled = false
    
    func showLists() {
        showListsCalled = true
    }
    
    func showBlankstate() {
        showBlankstateCalled = true
    }
    
}
