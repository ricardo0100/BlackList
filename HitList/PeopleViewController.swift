//
//  ViewController.swift
//  HitList
//
//  Created by Ricardo Gehrke Filho on 12/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class PeopleViewController: UITableViewController {
    var managedContext: NSManagedObjectContext?
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedContext = appDelegate.managedObjectContext
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        do {
            let results = try managedContext!.executeFetchRequest(fetchRequest)
            people = results as! [Person]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let person = people[indexPath.row]
            people.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            deletePerson(person)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Person Cell")
        let person = people[indexPath.row]
        
        cell!.textLabel!.textColor = UIColor.whiteColor()
        cell!.textLabel!.text = person.name
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    @IBAction func addName(sender: AnyObject) {
        let alert = UIAlertController(title: "New Person", message: "Add a new person name", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            self.savePersonWithName(textField!.text!)
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
    
    func savePersonWithName(name: String) {
        let entity =  NSEntityDescription.entityForName("Person", inManagedObjectContext:managedContext!)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Person
        
        person.name = name
        
        do {
            try managedContext!.save()
            people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func deletePerson(person: Person) {
        managedContext!.deleteObject(person)
        do {
            try managedContext!.save()
        } catch let error as NSError  {
            print("Could not delete \(error), \(error.userInfo)")
        }
    }
}
