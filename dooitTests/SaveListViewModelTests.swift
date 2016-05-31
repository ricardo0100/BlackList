//
//  SaveListViewModelTests.swift
//  dooitTests
//
//  Created by Ricardo Gehrke Filho on 28/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import XCTest
import CoreData
@testable import dooit

class SaveListViewModelTests: XCTestCase {
    
    var viewModel: SaveListViewModel?
    var viewModelDelegate: SaveListViewModelDelegateDouble?
    var managedObjectContext: NSManagedObjectContext?
    
    override func setUp() {
        super.setUp()
        viewModelDelegate = SaveListViewModelDelegateDouble()
        managedObjectContext = InMemoryCoreDataStack.sharedInstance.managedObjectContext
        InMemoryCoreDataStack.sharedInstance.clearStore()
    }
    
    func testEntityCreation() {
        viewModel = SaveListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
        XCTAssertNotNil(viewModel!.list)
    }
    
    func testEntityCreationTime() {
        viewModel = SaveListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
        XCTAssertNotNil(viewModel!.list.creationTime)
    }
    
    func testBlankTitleErrorMessagePresentation() {
        viewModel = SaveListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
        viewModel!.saveList()
        XCTAssertTrue(viewModelDelegate!.showErrorMessageCalled)
        XCTAssertEqual(viewModelDelegate!.errorMessage, viewModel?.emptyTitleErrorMessage)
    }
    
    func testSuccessMessage() {
        viewModel = SaveListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
        viewModel!.list.title = "Go to gym"
        viewModel!.saveList()
        XCTAssertTrue(viewModelDelegate!.showSuccessMessageCalled)
        XCTAssertEqual(viewModelDelegate!.successMessage, viewModel?.savingSuccessMessage)
    }
    
    func testListPersistenceInStore() {
        viewModel = SaveListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
        viewModel!.list.title = "Make a cake"
        viewModel!.saveList()
        let fetchRequest = NSFetchRequest(entityName: "List")
        let results = try! managedObjectContext!.executeFetchRequest(fetchRequest)
        let lists = results as! [List]
        XCTAssertEqual(lists.count, 1)
    }
    
}

class SaveListViewModelDelegateDouble: SaveListViewModelDelegate {
    
    var showErrorMessageCalled = false
    var showSuccessMessageCalled = false
    var errorMessage = ""
    var successMessage = ""
    
    func showErrorMessage(message: String) {
        showErrorMessageCalled = true
        errorMessage = message
    }
    
    func showSuccessMessage(message: String) {
        showSuccessMessageCalled = true
        successMessage = message
    }
    
}