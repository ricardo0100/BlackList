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
        InMemoryCoreDataStack.sharedInstance.clearStore()
        viewModel = DeleteListViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
    }
    
    func testDeleteListPersistenceStoreSuccess() {
        addListWithName("Find a planet")
        let list = retrieveListsInStore()[0]
        viewModel!.deleteList(list)
        let lists = retrieveListsInStore()
        XCTAssertTrue(viewModelDelegate!.deleteListSuccessCallbackCalled)
        XCTAssertEqual(lists.count, 0)
    }
    
    // MARK: - Test Helpers
    
    func addListWithName(name: String) {
        let entity =  NSEntityDescription.entityForName("List", inManagedObjectContext:managedObjectContext!)
        let list = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext!) as! List
        list.title = name
        try! managedObjectContext!.save()
    }
    
    func retrieveListsInStore() -> [List] {
        let results = try! managedObjectContext!.executeFetchRequest(NSFetchRequest(entityName: "List"))
        let lists = results as! [List]
        return lists
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