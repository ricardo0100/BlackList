//
//  EditListTableViewController.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 12/06/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class EditListTableViewController: UIViewController, EditListViewModelDelegate {

    var list: List?
    var editListViewModel: EditListViewModel!
    var dismissCallback: ((Void) -> Void)!
    
    @IBOutlet weak var listTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModel()
    }
    
    func setUpViewModel() {
        if let existingList = list {
            editListViewModel = EditListViewModel(delegate: self, managedObjectContext: SQLiteCoreDataStack.sharedInstance.managedObjectContext, list: existingList)
        } else {
            editListViewModel = EditListViewModel(delegate: self, managedObjectContext: SQLiteCoreDataStack.sharedInstance.managedObjectContext)
        }
    }
    
    @IBAction func saveList(sender: AnyObject) {
        editListViewModel.list.title = listTitleTextField.text
        editListViewModel.saveList()
    }
    
    @IBAction func cancelEditing(sender: AnyObject) {
        editListViewModel.cancelEditing()
    }
    
    func showSaveListSuccessMessage(message: String) {
        dismissViewControllerAnimated(true, completion: nil)
        dismissCallback()
    }
    
    func showSaveListErrorMessage(message: String) {
        let alert = UIAlertController(title: "Warning!", message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func cancelEditingCallBack() {
        dismissViewControllerAnimated(true, completion: nil)
        dismissCallback()
    }
    
    func presentExistingListForEditing() {
        listTitleTextField.text = list!.title
    }
}
