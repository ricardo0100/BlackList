//
//  ViewController.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 12/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class ListsTableViewController: UITableViewController, ShowListsViewModelDelegate, DeleteListViewModelDelegate {
    
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
        } else if segue.identifier == "Edit Existing List" {
            let editListNavigationController = segue.destinationViewController as! UINavigationController
            let editListViewController = editListNavigationController.topViewController as! EditListTableViewController
            editListViewController.dismissCallback = showListsViewModel!.fetchLists
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let list = showListsViewModel!.lists[indexPath!.row]
            editListViewController.list = list
        } else if segue.identifier == "New List" {
            let editListNavigationController = segue.destinationViewController as! UINavigationController
            let editListViewController = editListNavigationController.topViewController as! EditListTableViewController
            editListViewController.dismissCallback = showListsViewModel!.fetchLists
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
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) in
            let list = self.showListsViewModel!.lists[indexPath.row]
            self.deleteList(list)
        }
        let editAction = UITableViewRowAction(style: .Normal, title: "Edit") { (action, indexPath) in
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            self.performSegueWithIdentifier("Edit Existing List", sender: cell)
        }
        return [deleteAction, editAction]
    }
    
    func deleteList(list: List) {
        let deleteListViewModel = DeleteListViewModel(delegate: self, managedObjectContext: SQLiteCoreDataStack.sharedInstance.managedObjectContext)
        deleteListViewModel.deleteList(list)
    }
    
}

