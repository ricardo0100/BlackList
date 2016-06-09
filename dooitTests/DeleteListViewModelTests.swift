//
//  DeleteListViewModelTests.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 31/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import XCTest
import CoreData
@testable import dooit

class DeleteListViewModelTests: XCTestCase {
    
    var viewModel: DeleteListViewModel?
    var viewModelDelegate: DeleteListViewModelDelegateDouble?
    var managedObjectContext: NSManagedObjectContext?
    
    override func setUp() {
        super.setUp()
        viewModelDelegate = DeleteListViewModelDelegateDouble()
        managedObjectContext = InMemoryCoreDataStack.sharedInstance.managedObjectContext
        viewModel = DeleteListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
    }
    
    override func tearDown() {
        InMemoryCoreDataStack.sharedInstance.clearStore()
        super.tearDown()
    }
    
    func testDeleteListInPersistenceStoreSuccess() {
        let list = CoreDataHelpers.createListWithTitle("Find a planet")
        viewModel!.deleteList(list)
        let lists = CoreDataHelpers.retrieveAllLists()
        XCTAssertTrue(viewModelDelegate!.deleteListSuccessCallbackCalled)
        XCTAssertEqual(lists.count, 0)
    }
    
}

class DeleteListViewModelDelegateDouble: DeleteListViewModelDelegate {
    
    var deleteListSuccessCallbackCalled = false
    var deleteListErrorCallbackCalled = false
    
    func deleteListSuccessCallback() {
        deleteListSuccessCallbackCalled = true
    }
    
    func deleteListErrorCallback() {
        deleteListErrorCallbackCalled = true
    }
    
}