//
//  ContactsTableViewController.swift
//  Qontactr
//
//  Created by John Chiaramonte on 9/4/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import UIKit
import Contacts

class ContactsTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    let data = Data.sharedInstance
    
    @IBOutlet var contactsTable: UITableView!

    //number of rows is number of contacts
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.contacts.count
    }
    
    //whats in the cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel!.text = data.contacts[indexPath.row].givenName + " " + data.contacts[indexPath.row].familyName
        return cell
        
    }
    
    //tap a row
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        data.selectedContact = indexPath.row
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //this function alows me to do slide-out things, even with no code
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let defaultAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Default Contact", handler: {(action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            let newDefaultContact = CNMutableContact()
            newDefaultContact.givenName = self.data.contacts[indexPath.row].givenName
            newDefaultContact.familyName = self.data.contacts[indexPath.row].familyName
            newDefaultContact.phoneNumbers = self.data.contacts[indexPath.row].phoneNumbers
            
            let newCompletedDefaultContact: CNContact = newDefaultContact
            
            self.data.assignDefaultContact(newCompletedDefaultContact)
            
            self.data.selectedContact = indexPath.row
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })
        return [defaultAction]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}
