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
    
    var managedContext: NSManagedObjectContext?
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
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Reason
        
        person.title = title
        
        do {
            try managedContext!.save()
            reasons.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reasons.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Reason Cell", forIndexPath: indexPath) as! ReasonTableViewCell
        
        return cell
    }
    
}
