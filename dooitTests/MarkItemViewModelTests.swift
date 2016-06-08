//
//  MarkItemViewModelTests.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 08/06/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import XCTest
@testable import dooit

class MarkItemViewModelTests: XCTestCase {
    
    var viewModel: MarkItemViewModel?
    var delegate: MarkItemViewModelDelegateDouble?
    var list: List?

    override func setUp() {
        super.setUp()
        delegate = MarkItemViewModelDelegateDouble()
        viewModel = MarkItemViewModel(delegate: delegate!, managedObjectContext: InMemoryCoreDataStack.sharedInstance.managedObjectContext)
        list = CoreDataHelpers.createListWithTitle("Build a boat 🚣")
    }
    
    func testItemChangedToMarkedStatusTrue() {
        let item = CoreDataHelpers.createItemForList(list!, withTitle: "Make a sandwich", andMarked: false)
        viewModel!.changeMarkedStatusForItem(item)
        let items = CoreDataHelpers.retrieveAllItemsForList(list!)
        XCTAssertTrue(delegate!.setMarkedCallBackCalled)
        XCTAssertTrue(items[0].marked)
    }
    
    func testItemChangedToMarkedStatusFalse() {
        let item = CoreDataHelpers.createItemForList(list!, withTitle: "Make a sandwich", andMarked: true)
        viewModel!.changeMarkedStatusForItem(item)
        let items = CoreDataHelpers.retrieveAllItemsForList(list!)
        XCTAssertTrue(delegate!.setUnmarkedCallBackCalled)
        XCTAssertFalse(items[0].marked)
    }
    
}

class MarkItemViewModelDelegateDouble: MarkItemViewModelDelegate {
    
    var setMarkedCallBackCalled = false
    var setUnmarkedCallBackCalled = false
    
    func setMarkedCallBack(item: Item) {
        setMarkedCallBackCalled = true
    }
    
    func setUnmarkedCallBack(item: Item) {
        setUnmarkedCallBackCalled = true
    }
    
}