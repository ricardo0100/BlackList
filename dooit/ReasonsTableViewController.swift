//
//  ReasonsTableViewController.swift
//  BlackList
//
//  Created by Ricardo Gehrke Filho on 19/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class ReasonsTableViewController: UITableViewController {
    
    var person: Person?
    var managedContext: NSManagedObjectContext?
    var personReasons = [Reason]()
    var reasons = [Reason]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedContext = appDelegate.managedObjectContext
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest = NSFetchRequest(entityName: "Reason")
        
        do {
            let results = try managedContext!.executeFetchRequest(fetchRequest)
            reasons = results as! [Reason]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func newReasonClicked(sender: AnyObject) {
        let alert = UIAlertController(title: "New Reason", message: "Add a new reason", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            self.saveReasonWithTitle(textField!.text!)
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
    
    func saveReasonWithTitle(title: String) {
        let entity =  NSEntityDescription.entityForName("Reason", inManagedObjectContext:managedContext!)
        
        let reason = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Reason
        
        reason.title = title
        
        do {
            try managedContext!.save()
            reasons.append(reason)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reasons.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Reason Cell", forIndexPath: indexPath) as! ReasonTableViewCell
        let reason = reasons[indexPath.row]
        
        cell.addReasonToPersonCallback = addReasonCallback
        cell.removeReasonToPersonCallback = removeReasonCallback
        
        cell.reasonSelected = person!.reasons!.containsObject(reason)
        cell.reason = reason
        cell.title.text = reason.title
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let reason = reasons[indexPath.row]

            reasons.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            deleteReason(reason)
        }
    }
    
    func deleteReason(reason: Reason) {
        managedContext!.deleteObject(reason)
        do {
            try managedContext!.save()
        } catch let error as NSError  {
            print("Could not delete \(error), \(error.userInfo)")
        }
    }
    
    func addReasonCallback(reason: Reason) {
        person?.addReasonsObject(reason)
    }
    
    func removeReasonCallback(reason: Reason) {
        person?.removeReasonsObject(reason)
    }
}
