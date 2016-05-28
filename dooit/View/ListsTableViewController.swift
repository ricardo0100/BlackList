//
//  ViewController.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 12/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class ListsTableViewController: UITableViewController, ShowListsViewModelDelegate {
    
    //Remove managedContext reference after save implementation
    @IBOutlet var blankStateView: UIView!
    var managedContext: NSManagedObjectContext?
    var viewModel: ShowListsViewModel?
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTitle()
        setUpViewModel()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        viewModel!.fetchLists()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "List Selected" {
            let itemsViewController = segue.destinationViewController as! ItemsTableViewController
            let list = viewModel!.lists[tableView.indexPathForSelectedRow!.row]
            itemsViewController.title = list.title
            itemsViewController.list = list
        }
    }
    
    func showLists() {
        tableView.backgroundView = nil
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    }
    
    func showBlankstate() {
        tableView.backgroundView = blankStateView
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.reloadData()
    }
    
    func setUpTitle() {
        let titleLabel = UILabel()
        titleLabel.attributedText = GUIHelpers.setUpTitle()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    func setUpViewModel() {
        managedContext = SQLiteCoreDataStack.sharedInstance.managedObjectContext
        viewModel = ShowListsViewModel(delegate: self, managedObjectContext: managedContext!)
    }
    
    // MARK: - UITableView DataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.lists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("List Cell")
        let list = viewModel!.lists[indexPath.row]
        print()
        cell!.textLabel!.textColor = UIColor.whiteColor()
        cell!.textLabel!.text = list.title
        return cell!
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let list = viewModel!.lists[indexPath.row]
            deleteList(list)
        }
    }
    
    // MARK: - Actions

    @IBAction func addName(sender: AnyObject) {
        let alert = UIAlertController(title: "New List", message: "Add a new list name", preferredStyle: .Alert)
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            self.saveListWithTitle(textField!.text!)
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
    
    // MARK: - Core Data
    
    func saveListWithTitle(title: String) {
        let entity =  NSEntityDescription.entityForName("List", inManagedObjectContext:managedContext!)
        let list = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! List
        list.title = title
        list.creationTime = NSDate()
        do {
            try managedContext!.save()
            viewModel!.fetchLists()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func deleteList(list: List) {
        managedContext!.deleteObject(list)
        do {
            try managedContext!.save()
            viewModel!.fetchLists()
        } catch let error as NSError  {
            print("Could not delete \(error), \(error.userInfo)")
        }
    }
    
}

