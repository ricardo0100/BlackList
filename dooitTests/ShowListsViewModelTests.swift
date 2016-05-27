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
    
    func testShouldPresentBlankState() {
        viewModel?.fetchLists()
        XCTAssertTrue(viewModelDelegate!.showBlankstateCalled)
    }
    
    func testShouldPresentOneList() {
        addListWithName("Richard")
        viewModel?.fetchLists()
        XCTAssertTrue(viewModelDelegate!.showListsCalled)
        XCTAssertEqual(viewModel?.lists[0].name, "Richard")
    }
    
    func addListWithName(name: String) {
        let entity =  NSEntityDescription.entityForName("List", inManagedObjectContext:managedObjectContext!)
        let list = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext!) as! List
        list.name = name
        
        do {
            try managedObjectContext!.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
}
