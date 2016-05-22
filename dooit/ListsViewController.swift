//
//  ViewController.swift
//  HitList
//
//  Created by Ricardo Gehrke Filho on 12/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class ListsViewController: UITableViewController {
    var managedContext: NSManagedObjectContext?
    var lists = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedContext = appDelegate.managedObjectContext
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest = NSFetchRequest(entityName: "List")
        
        do {
            let results = try managedContext!.executeFetchRequest(fetchRequest)
            lists = results as! [List]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
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
            let person = lists[indexPath.row]
            lists.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            deleteList(person)
        }
    }

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
    
    func saveListWithName(name: String) {
        let entity =  NSEntityDescription.entityForName("List", inManagedObjectContext:managedContext!)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! List
        
        person.name = name
        
        do {
            try managedContext!.save()
            lists.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func deleteList(person: List) {
        managedContext!.deleteObject(person)
        do {
            try managedContext!.save()
        } catch let error as NSError  {
            print("Could not delete \(error), \(error.userInfo)")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "List Selected" {
            let itemsViewController = segue.destinationViewController as! ItemsTableViewController
            let list = lists[tableView.indexPathForSelectedRow!.row]
            itemsViewController.list = list
        }
    }
}

