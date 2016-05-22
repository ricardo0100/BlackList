//
//  ReasonsTableViewController.swift
//  BlackList
//
//  Created by Ricardo Gehrke Filho on 19/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class ItemsTableViewController: UITableViewController {
    
    var list: List?
    var managedContext: NSManagedObjectContext?
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedContext = appDelegate.managedObjectContext
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        items = Array(list!.items)
    }
    
    @IBAction func newReasonClicked(sender: AnyObject) {
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
    
    func saveItemWithName(name: String) {
        let entity =  NSEntityDescription.entityForName("Item", inManagedObjectContext:managedContext!)
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Item
        
        item.name = name
        list!.addItemsObject(item)
        
        do {
            try managedContext!.save()
            items.append(item)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Item Cell", forIndexPath: indexPath) as! ItemTableViewCell
        let item = items[indexPath.row]
        
        cell.item = item
        cell.setMarked = setItemMarked
        cell.setUnmarked = setItemUnmarked
        
        return cell
    }
    
    func setItemMarked(item: Item) {
        item.marked = true
        do {
            try managedContext!.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func setItemUnmarked(item: Item) {
        item.marked = false
        do {
            try managedContext!.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let item = items[indexPath.row]

            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            deleteItem(item)
        }
    }
    
    func deleteItem(item: Item) {
        managedContext!.deleteObject(item)
        do {
            try managedContext!.save()
        } catch let error as NSError  {
            print("Could not delete \(error), \(error.userInfo)")
        }
    }
}
