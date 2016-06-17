//
//  EditListTableViewController.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 12/06/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class EditListTableViewController: UITableViewController, SaveListViewModelDelegate {

    var saveListViewModel: SaveListViewModel!
    
    @IBOutlet weak var listTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpViewModel()
    }
    
    func setUpViews() {
    }
    
    func setUpViewModel() {
        saveListViewModel = SaveListViewModel(delegate: self, managedObjectContext: SQLiteCoreDataStack.sharedInstance.managedObjectContext)
    }
    
    @IBAction func saveList(sender: AnyObject) {
        saveListViewModel.list.title = listTitleTextField.text
        saveListViewModel.saveList()
    }
    
    @IBAction func cancelEditing(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showSaveListSuccessMessage(message: String) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showSaveListErrorMessage(message: String) {
        let alert = UIAlertController(title: "Warning!", message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
}
