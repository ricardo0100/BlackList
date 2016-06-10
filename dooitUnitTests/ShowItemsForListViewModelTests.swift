//
//  ShowItemsForListViewModelTests.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 02/06/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import XCTest
import CoreData
@testable import dooit

class ShowItemsForListViewModelTests: XCTestCase {
    
    var viewModel: ShowItemsForListViewModel?
    var viewModelDelegate: ShowItemsForListViewModelDelegateDouble?
    var list: List?
    
    override func setUp() {
        super.setUp()
        viewModelDelegate = ShowItemsForListViewModelDelegateDouble()
        list = CoreDataHelpers.createListWithTitle("Eat bacon 🐽")
        let moc = InMemoryCoreDataStack.sharedInstance.managedObjectContext
        viewModel = ShowItemsForListViewModel(delegate: viewModelDelegate!, managedObjectContext: moc, list: list!)
        
    }
    
    override func tearDown() {
        InMemoryCoreDataStack.sharedInstance.clearStore()
        super.tearDown()
    }
    
    func testPresentBlankState() {
        viewModel!.fetchItems()
        XCTAssertTrue(viewModelDelegate!.presentBlankStateCalled)
    }
    
    func testPresentOneItemForList() {
        CoreDataHelpers.createItemForList(list!, withTitle: "Buy land")
        viewModel!.fetchItems()
        XCTAssertTrue(viewModelDelegate!.presentItemsCalled)
        XCTAssertEqual(viewModel!.items.count, 1)
    }
    
    func testPresentTwoItemsForList() {
        CoreDataHelpers.createItemForList(list!, withTitle: "Write a book")
        CoreDataHelpers.createItemForList(list!, withTitle: "Hire an architect")
        viewModel!.fetchItems()
        XCTAssertTrue(viewModelDelegate!.presentItemsCalled)
        XCTAssertEqual(viewModel!.items.count, 2)
    }
    
}

class ShowItemsForListViewModelDelegateDouble: ShowItemsForListViewModelDelegate {
    
    var presentItemsCalled = false
    var presentBlankStateCalled = false
    
    func presentItems() {
        presentItemsCalled = true
    }
    
    func presentBlankState() {
        presentBlankStateCalled = true
    }
    
}