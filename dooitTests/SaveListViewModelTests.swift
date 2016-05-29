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
    
    func testShouldPresentErrorMessageForEmptyTitle() {
        let entity =  NSEntityDescription.entityForName("List", inManagedObjectContext:managedObjectContext!)
        let list = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! List
        
        viewModel = SaveListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
        viewModel!.saveList(list)
        
        XCTAssertTrue(viewModelDelegate!.showErrorMessageCalled)
        XCTAssertEqual(viewModelDelegate!.errorMessage, viewModel!.emptyTitleError)
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