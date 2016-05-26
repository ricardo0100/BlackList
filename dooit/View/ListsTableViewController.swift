//
//  ViewController.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 12/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class ListsTableViewController: UITableViewController {
    
    var managedContext: NSManagedObjectContext?
    var lists: [List] = []
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCoreData()
        setUpTitle()
    }
    
    func setUpCoreData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedContext = appDelegate.managedObjectContext
    }
    
    func setUpTitle() {
        let attributedText = NSMutableAttributedString(string: "dooit")
        let color = UIColor.whiteColor()
        let blackFont = UIFont(name: "Avenir-Black", size: 20)!
        let attributeBlack = [NSForegroundColorAttributeName: color, NSFontAttributeName: blackFont]
        attributedText.addAttributes(attributeBlack, range: NSRange(location: 0, length: 3))
        let blackLight = UIFont(name: "Avenir-Light", size: 24)!
        let attributeLight = [NSForegroundColorAttributeName: color, NSFontAttributeName: blackLight]
        attributedText.addAttributes(attributeLight, range: NSRange(location: 3, length: 2))
        let titleLabel = UILabel()
        titleLabel.attributedText = attributedText
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchLists()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "List Selected" {
            let itemsViewController = segue.destinationViewController as! ItemsTableViewController
            let list = lists[tableView.indexPathForSelectedRow!.row]
            itemsViewController.title = list.name
            itemsViewController.list = list
        }
    }
    
    // MARK: - UITableView DataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("List Cell")
        let list = lists[indexPath.row]
        
        cell!.textLabel!.textColor = UIColor.whiteColor()
        cell!.textLabel!.text = list.name
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let list = lists[indexPath.row]
            lists.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            deleteList(list)
        }
    }
    
    // MARK: - Actions

    @IBAction func addName(sender: AnyObject) {
        let alert = UIAlertController(title: "New List", message: "Add a new list name", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            self.saveListWithName(textField!.text!)
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
    
    func fetchLists() {
        let fetchRequest = NSFetchRequest(entityName: "List")
        do {
            let results = try managedContext!.executeFetchRequest(fetchRequest)
            lists = results as! [List]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func saveListWithName(name: String) {
        let entity =  NSEntityDescription.entityForName("List", inManagedObjectContext:managedContext!)
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! List
        person.name = name
        do {
            try managedContext!.save()
            fetchLists()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func deleteList(list: List) {
        managedContext!.deleteObject(list)
        do {
            try managedContext!.save()
        } catch let error as NSError  {
            print("Could not delete \(error), \(error.userInfo)")
        }
    }
    
}

