//
//  dooitTests.swift
//  dooitTests
//
//  Created by Ricardo Gehrke Filho on 23/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import XCTest
import CoreData
@testable import dooit

class ShowListsViewModelTests: XCTestCase {
    
    var viewModel: ShowListsViewModel?
    var viewModelDelegate: ShowListsViewModelDelegateDouble?
    var managedObjectContext: NSManagedObjectContext?
    
    override func setUp() {
        super.setUp()
        viewModelDelegate = ShowListsViewModelDelegateDouble()
        managedObjectContext = InMemoryCoreDataStack.sharedInstance.managedObjectContext
        viewModel = ShowListsViewModel(delegate: viewModelDelegate!, managedObjectContext: managedObjectContext!)
    }
    
    override func tearDown() {
        let fetchRequest = NSFetchRequest(entityName: "List")
        let items = try! managedObjectContext!.executeFetchRequest(fetchRequest) as! [NSManagedObject]
        for item in items {
            managedObjectContext!.deleteObject(item)
        }
        try! managedObjectContext!.save()
        super.tearDown()
    }
    
    func testShouldPresentBlankState() {
        viewModel?.fetchLists()
        XCTAssertTrue(viewModelDelegate!.showBlankstateCalled)
    }
    
    func testShouldPresentOneList() {
        let listName = "Shake it"
        addListWithName(listName)
        viewModel?.fetchLists()
        XCTAssertTrue(viewModelDelegate!.showListsCalled)
        XCTAssertEqual(viewModel?.lists.count, 1)
        XCTAssertEqual(viewModel?.lists[0].title, listName)
    }
    
    func testShouldPresentTwoLists() {
        addListWithName("Shake it")
        addListWithName("Move it")
        viewModel?.fetchLists()
        XCTAssertTrue(viewModelDelegate!.showListsCalled)
        XCTAssertEqual(viewModel?.lists.count, 2)
    }
    
    // MARK: - Test Helpers
    
    func addListWithName(name: String) {
        let entity =  NSEntityDescription.entityForName("List", inManagedObjectContext:managedObjectContext!)
        let list = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext!) as! List
        list.title = name
        try! managedObjectContext!.save()
    }
    
}
