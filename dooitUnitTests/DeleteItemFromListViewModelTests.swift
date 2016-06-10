//
//  DeleteItemFromListViewModelTests.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 09/06/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import XCTest
@testable import dooit

class DeleteItemFromListViewModelTests: XCTestCase {
    
    var delegate: DeleteItemFromListViewModelDelegateDouble?
    var viewModel: DeleteItemFromListViewModel?
    var list: List?

    override func setUp() {
        super.setUp()
        list = CoreDataHelpers.createListWithTitle("Go to Rio de Janeiro")
        delegate = DeleteItemFromListViewModelDelegateDouble()
        viewModel = DeleteItemFromListViewModel(delegate: delegate!, managedObjectContext: InMemoryCoreDataStack.sharedInstance.managedObjectContext, list: list!)
    }
    
    override func tearDown() {
        InMemoryCoreDataStack.sharedInstance.clearStore()
        super.tearDown()
    }
    
    func testItemDeletedFromListInPersistenceStore() {
        let item = CoreDataHelpers.createItemForList(list!, withTitle: "Build a plane")
        var lists = CoreDataHelpers.retrieveAllItemsForList(list!)
        XCTAssertEqual(lists.count, 1)
        viewModel!.deleteItem(item)
        lists = CoreDataHelpers.retrieveAllItemsForList(list!)
        XCTAssertEqual(lists.count, 0)
        XCTAssertTrue(delegate!.deleteItemFromListSuccessCallbackCalled)
    }
    
}

class DeleteItemFromListViewModelDelegateDouble: DeleteItemFromListViewModelDelegate {
    
    var deleteItemFromListSuccessCallbackCalled = false
    var deleteItemFromListErrorCallbackCalled = false
    
    func deleteItemFromListSuccessCallback() {
        deleteItemFromListSuccessCallbackCalled = true
    }
    
    func deleteItemFromListErrorCallback() {
        deleteItemFromListErrorCallbackCalled = true
    }
    
}
