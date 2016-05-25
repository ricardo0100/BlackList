//
//  dooitTests.swift
//  dooitTests
//
//  Created by Ricardo Gehrke Filho on 23/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import XCTest

class ShowListsViewModelTests: XCTestCase {
    
    var showListsViewModel: ShowListsViewModel?
    var showListsViewModelDelegate: ShowListsViewModelDelegateDouble?
    
    override func setUp() {
        super.setUp()
        showListsViewModelDelegate = ShowListsViewModelDelegateDouble()
        showListsViewModel = ShowListsViewModel(delegate: showListsViewModelDelegate!)
    }
    
    func testEmpty() {
        showListsViewModel?.showLists()
        XCTAssertTrue(showListsViewModelDelegate!.showBlankstateCalled)
    }
    
}
