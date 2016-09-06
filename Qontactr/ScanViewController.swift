//
//  HomeViewController.swift
//  Qontactr
//
//  Created by John Chiaramonte on 9/4/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import UIKit
import GoogleMobileAds
import SwiftyJSON
import SwiftQRCode
import Contacts

class ScanViewController: UIViewController, GADBannerViewDelegate {

    let data = Data.sharedInstance
    
    //banner ad
    @IBOutlet var bannerView: GADBannerView!
    
    //qr scanner
    let scanner = QRCode()
    
    //initializes the scanner object to start scanning (user can now see camera output)
    @IBAction func buttonPressed(sender: AnyObject) {
        scanner.startScan()
    }
    
    //segue back to main VC
    @IBAction func backButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //present an alert to the user
    func presentAlertContactAdd(title: String, message: String, contact: CNContact) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Okay",style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in
            
            self.data.createContact(contact.givenName, last: contact.familyName, number: (contact.phoneNumbers[0].value as! CNPhoneNumber).stringValue)
            
            print("Contact \(contact.givenName) \(contact.familyName) Added")
            
            
        }))
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default,handler: {(alert: UIAlertAction!) in
            
            print("Contact not added")
            
        }))
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //present an alert to the user
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //set this value as it segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        data.didComeFromTable = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ad stuff
        bannerView.adUnitID = "ca-app-pub-7526118464921133/7997146000"
        bannerView.delegate = self
        bannerView.rootViewController = self
        let request = GADRequest()
        request.testDevices = data.testDevices
        bannerView.loadRequest(request)
        
        //executes when the scanner picks up a QR code
        scanner.prepareScan(view) { (stringValue) -> () in
            print(stringValue)
            //translate the string from the QR code into JSON, which is theoretically created from another user
            let stringData: NSData = stringValue.dataUsingEncoding(NSUTF8StringEncoding)!
            let json = JSON(data: stringData)
            
            //parse this JSON data into local variables
            let first = json["first"].stringValue
            let last = json["last"].stringValue
            let number = json["number"].stringValue
            
            //print it out
            print(first)
            print(last)
            print(number)
            
            //if there is no first name, IE if it isn't a QR code generated from the app itself, then don't add any contact and alert the user, otherwise create contact from the data
            if first != "" {
                self.data.createContact(first, last: last, number: number)
                
                let newContact: CNMutableContact = CNMutableContact()
                newContact.givenName = first
                newContact.givenName = last
                newContact.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: number))]
                
            
                self.presentAlertContactAdd("Contact Added", message: "Add \(first) \(last) to Contacts?", contact: newContact as CNContact)
                
            } else {
                self.presentAlert("No Contact Added", message: "Not a Qontactr QR Code")
            }
            
        }
        scanner.scanFrame = view.bounds
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //start the scan by default
        data.didComeFromTable = false
        scanner.startScan()
    }
    
    
}
