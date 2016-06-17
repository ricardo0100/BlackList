//
//  ViewController.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 12/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class ListsTableViewController: UITableViewController, ShowListsViewModelDelegate, SaveListViewModelDelegate, DeleteListViewModelDelegate {
    
    @IBOutlet var blankStateView: UIView!
    var showListsViewModel: ShowListsViewModel?
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTitle()
        setUpViewModel()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        showListsViewModel!.fetchLists()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "List Selected" {
            let itemsViewController = segue.destinationViewController as! ItemsTableViewController
            let list = showListsViewModel!.lists[tableView.indexPathForSelectedRow!.row]
            itemsViewController.title = list.title
            itemsViewController.list = list
        }
    }
    
    func showLists() {
        tableView.backgroundView = nil
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.reloadData()
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
        showListsViewModel = ShowListsViewModel(delegate: self, managedObjectContext: SQLiteCoreDataStack.sharedInstance.managedObjectContext)
    }
    
    func showSaveListSuccessMessage(message: String) {
        showListsViewModel!.fetchLists()
    }
    
    func showSaveListErrorMessage(message: String) {
        let alert = UIAlertController(title: "Warning!", message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func deleteListSuccessCallback() {
        showListsViewModel!.fetchLists()
    }
    
    func deleteListErrorCallback() {
        let alert = UIAlertController(title: "Warning!", message: "Error on deleting list", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - UITableView DataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showListsViewModel!.lists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("List Cell")
        let list = showListsViewModel!.lists[indexPath.row]
        cell!.textLabel!.textColor = UIColor.whiteColor()
        cell!.textLabel!.text = list.title
        return cell!
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let list = showListsViewModel!.lists[indexPath.row]
            deleteList(list)
        }
    }
    
    func deleteList(list: List) {
        let deleteListViewModel = DeleteListViewModel(delegate: self, managedObjectContext: SQLiteCoreDataStack.sharedInstance.managedObjectContext)
        deleteListViewModel.deleteList(list)
    }
    
}

