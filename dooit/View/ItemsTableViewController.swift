//
//  ReasonsTableViewController.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 19/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class ItemsTableViewController: UITableViewController, ShowItemsForListViewModelDelegate, MarkItemViewModelDelegate {
    
    @IBOutlet var blankStateView: UIView!
    
    var list: List?
    var showItemsForListViewModel: ShowItemsForListViewModel?
    var markItemViewModel: MarkItemViewModel?
    
    // MARK: - UIViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModel()
    }
    
    func setUpViewModel() {
        showItemsForListViewModel = ShowItemsForListViewModel(delegate: self, managedObjectContext: SQLiteCoreDataStack.sharedInstance.managedObjectContext, list: list!)
        markItemViewModel = MarkItemViewModel(delegate: self, managedObjectContext: SQLiteCoreDataStack.sharedInstance.managedObjectContext)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        showItemsForListViewModel!.fetchItems()
    }
    
    // MARK: - UITableView DataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showItemsForListViewModel!.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Item Cell", forIndexPath: indexPath) as! ItemTableViewCell
        let item = showItemsForListViewModel!.items[indexPath.row]
        cell.item = item
        cell.markedTapped = setMarkedTapped
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let item = showItemsForListViewModel!.items[indexPath.row]
            deleteItem(item)
            showItemsForListViewModel!.fetchItems()
        }
    }
    
    func presentItems() {
        tableView.backgroundView = nil
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.reloadData()
    }
    
    func presentBlankState() {
        tableView.backgroundView = blankStateView
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func newItemClicked(sender: AnyObject) {
        let alert = UIAlertController(title: "New Item", message: "Add a new item", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            self.saveItemWithName(textField!.text!)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveItemWithName(title: String) {
        let moc = SQLiteCoreDataStack.sharedInstance.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Item", inManagedObjectContext:moc)
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: moc) as! Item
        
        item.title = title
        list!.addItemsObject(item)
        
        do {
            try moc.save()
            showItemsForListViewModel!.fetchItems()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func setMarkedTapped(item: Item) {
        markItemViewModel!.changeMarkedStatusForItem(item)
    }
    
    func setMarkedCallBack(item: Item) {
        let index = showItemsForListViewModel!.items.indexOf(item)
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index!, inSection: 0)) as! ItemTableViewCell
        cell.marked = true
        
    }
    
    func setUnmarkedCallBack(item: Item) {
        let index = showItemsForListViewModel!.items.indexOf(item)
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index!, inSection: 0)) as! ItemTableViewCell
        cell.marked = false
    }
    
    func deleteItem(item: Item) {
        SQLiteCoreDataStack.sharedInstance.managedObjectContext.deleteObject(item)
        do {
            try SQLiteCoreDataStack.sharedInstance.managedObjectContext.save()
        } catch let error as NSError  {
            print("Could not delete \(error), \(error.userInfo)")
        }
    }
}
