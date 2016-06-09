//
//  SaveItemForListViewModelTests.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 08/06/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import XCTest
@testable import dooit

class SaveItemForListViewModelTests: XCTestCase {
    
    var viewModel: SaveItemForListViewModel?
    var delegate: SaveItemForListViewModelDelegateDouble?

    override func setUp() {
        super.setUp()
        let list = CoreDataHelpers.createListWithTitle("Go to the gym 🏋🏻")
        delegate = SaveItemForListViewModelDelegateDouble()
        viewModel = SaveItemForListViewModel(delegate: delegate!, managedObjectContext: InMemoryCoreDataStack.sharedInstance.managedObjectContext, list: list)
    }
    
    override func tearDown() {
        InMemoryCoreDataStack.sharedInstance.clearStore()
        super.tearDown()
    }
    
    func testBlankTitleErrorMessagePresentation() {
        viewModel!.saveNewItemWithTitle("")
        XCTAssertTrue(delegate!.showSaveItemErrorMessageCalled)
    }
    
    func testSuccessMessagePresentation() {
        viewModel!.saveNewItemWithTitle("Eat burgers")
        XCTAssertTrue(delegate!.showSaveItemSuccessMessageCalled)
    }
    
}

class SaveItemForListViewModelDelegateDouble: SaveItemForListViewModelDelegate {
    
    var showSaveItemSuccessMessageCalled = false
    var showSaveItemErrorMessageCalled = false
    
    func showSaveItemSuccessMessage(message: String) {
        showSaveItemSuccessMessageCalled = true
    }
    
    func showSaveItemErrorMessage(message: String) {
        showSaveItemErrorMessageCalled = true
    }
    
}
