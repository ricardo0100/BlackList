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

class EditListViewModelTests: XCTestCase {
    
    var viewModel: EditListViewModel?
    var viewModelDelegate: EditListViewModelDelegateDouble?
    var managedObjectContext: NSManagedObjectContext?
    
    override func setUp() {
        super.setUp()
        viewModelDelegate = EditListViewModelDelegateDouble()
        managedObjectContext = InMemoryCoreDataStack.sharedInstance.managedObjectContext
    }
    
    override func tearDown() {
        InMemoryCoreDataStack.sharedInstance.clearStore()
        super.tearDown()
    }
    
    func testNewListShouldCreateNewEntity() {
        viewModel = EditListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
        XCTAssertNotNil(viewModel!.list)
    }
    
    func testNewListShouldHaveCreationTime() {
        viewModel = EditListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
        XCTAssertNotNil(viewModel!.list.creationTime)
    }
    
    func testBlankTitleShouldPresentErrorMessage() {
        viewModel = EditListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
        viewModel!.saveList()
        XCTAssertTrue(viewModelDelegate!.showErrorMessageCalled)
        XCTAssertEqual(viewModelDelegate!.errorMessage, viewModel?.emptyTitleErrorMessage)
    }
    
    func testSaveListShouldShowSuccessMessage() {
        viewModel = EditListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
        viewModel!.list.title = "Go to gym"
        viewModel!.saveList()
        XCTAssertTrue(viewModelDelegate!.showSuccessMessageCalled)
        XCTAssertEqual(viewModelDelegate!.successMessage, viewModel?.savingSuccessMessage)
    }
    
    func testSaveListShouldPersistInStore() {
        let title = "Make a cake"
        viewModel = EditListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
        viewModel!.list.title = title
        viewModel!.saveList()
        let lists = CoreDataHelpers.retrieveAllLists()
        XCTAssertEqual(lists.count, 1)
        XCTAssertEqual(lists[0].title, title)
    }
    
    func testCancelEditingNewListShouldDiscardNewEntity() {
        viewModel = EditListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
        viewModel!.list.title = "Go to Japan"
        viewModel!.cancelEditing()
        let lists = CoreDataHelpers.retrieveAllLists()
        XCTAssertEqual(lists.count, 0)
        XCTAssertTrue(viewModelDelegate!.cancelEditingCallBackCalled)
    }
    
    func testPresentExistingList() {
        let list = CoreDataHelpers.createListWithTitle("Eat Sushi")
        viewModel = EditListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!, list: list)
        XCTAssertTrue(viewModelDelegate!.presentExistingListForEditingCalled)
    }
    
    func testEditExistingListShouldSaveChangesInStore() {
        let newTitle = "Play Soccer"
        let list = CoreDataHelpers.createListWithTitle("Play Hockey")
        viewModel = EditListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!, list: list)
        viewModel!.list.title = newTitle
        viewModel!.saveList()
        let lists = CoreDataHelpers.retrieveAllLists()
        XCTAssertEqual(lists.count, 1)
        XCTAssertEqual(lists[0].title, newTitle)
    }
    
    func testCancelEditingExistingListShouldNotSaveChanges() {
        let title = "Move to Floripa"
        let newTitle = "Move to Palhoça"
        let list = CoreDataHelpers.createListWithTitle(title)
        viewModel = EditListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!, list: list)
        viewModel!.list.title = newTitle
        viewModel!.cancelEditing()
        let lists = CoreDataHelpers.retrieveAllLists()
        XCTAssertEqual(lists.count, 1)
        XCTAssertEqual(lists[0].title, title)
    }
    
}

class EditListViewModelDelegateDouble: EditListViewModelDelegate {
    
    var showErrorMessageCalled = false
    var showSuccessMessageCalled = false
    var cancelEditingCallBackCalled = false
    var presentExistingListForEditingCalled = false
    var errorMessage = ""
    var successMessage = ""
    
    func showSaveListErrorMessage(message: String) {
        showErrorMessageCalled = true
        errorMessage = message
    }
    
    func showSaveListSuccessMessage(message: String) {
        showSuccessMessageCalled = true
        successMessage = message
    }
    
    func cancelEditingCallBack() {
        cancelEditingCallBackCalled = true
    }
    
    func presentExistingListForEditing() {
        presentExistingListForEditingCalled = true
    }
    
}
