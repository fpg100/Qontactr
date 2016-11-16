//
//  MyQardsViewController.swift
//  Qontactr
//
//  Created by John Chiaramonte on 10/29/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import UIKit

class MyQardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let data = Data.sharedInstance
    
    @IBOutlet var qardTable: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data.isMyQardsSelected {
            return data.myQards.count
        } else {
            return data.qardRolodex.count
        }
        
    }
    
    //present an alert to the user
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func presentAlertBool(title: String, message: String) -> Bool {
        var returnBool: Bool = false
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            returnBool = true
        }))
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) -> Void in
            returnBool = false
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        return returnBool
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        if data.isMyQardsSelected {
            cell.textLabel?.text = data.myQards[indexPath.row].firstName
            
            cell.detailTextLabel?.text = data.myQards[indexPath.row].companyName
            
            cell.imageView!.image = data.myQards[indexPath.row].profileImage
        } else  {
            cell.textLabel?.text = data.qardRolodex[indexPath.row].firstName
            
            cell.detailTextLabel?.text = data.qardRolodex[indexPath.row].companyName
            
            cell.imageView!.image = data.qardRolodex[indexPath.row].profileImage
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if data.isMyQardsSelected {
            data.selectedQard = data.myQards[indexPath.row]
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            data.selectedRolodexQard = data.qardRolodex[indexPath.row]
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            presentAlert("Rolodex Qontact \(data.selectedRolodexQard.firstName) Selected", message: "")
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    @IBAction func addQard(sender: UIBarButtonItem) {
        data.myQards.append(Qard(first: "Firstname Lastname"))
        data.selectedQard = data.myQards[data.myQards.count-1]
        data.saveQards()
        self.performSegueWithIdentifier("myQardsToEdit", sender: UIBarButtonItem.self)
        
    }
    
    //this function alows me to do slide-out things, even with no code
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
     
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete", handler: {(action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            if self.data.isMyQardsSelected {
                if self.data.myQards.count > 1 {
                    self.data.myQards.removeAtIndex(indexPath.row)
                    self.qardTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                    self.data.selectedQard = self.data.myQards[0]
                    self.data.saveQards()
                    
                } else {
                    print("Attempt to delete last Qontact denied")
                    self.presentAlert("Can't Delete", message: "You must have at least 1 Qard.  You can always edit it.")
                }
 
            } else {
                print("delete feature not implemented yet")
            }
        })
        
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Edit", handler: {(action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
        
            self.data.selectedQard = self.data.myQards[indexPath.row]
            self.performSegueWithIdentifier("myQardsToEdit", sender: self)
            
        })
        
        var actionArray: [UITableViewRowAction] = []
        
        if data.isMyQardsSelected {
            actionArray = [editAction, deleteAction]
        } else {
            actionArray = [deleteAction]
        }
        

        return actionArray
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        qardTable.reloadData()
    }


}
