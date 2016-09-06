//
//  QRGeneratorViewController.swift
//  Qontactr
//
//  Created by John Chiaramonte on 9/4/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import UIKit
import SwiftQRCode
import GoogleMobileAds
import Contacts

class QRGeneratorViewController: UIViewController, UITextFieldDelegate, GADBannerViewDelegate {

    let data = Data.sharedInstance
    
    var timesViewDidAppear: Int = 0
    
    //image view that the QR code gets put onto
    @IBOutlet var qrImage: UIImageView!
    
    //form text field
    @IBOutlet var nameField: UITextField!
    @IBOutlet var lastField: UITextField!
    @IBOutlet var numberField: UITextField!
    
    //bottom ad banner
    @IBOutlet var bannerView: GADBannerView!
    
    //main scroll view that contains everything
    @IBOutlet var elderScroll: UIScrollView!
    
    //runs when user taps anywhere
    @IBAction func tapAnywhere(sender: UITapGestureRecognizer) {
        //close keyboard
        view.endEditing(true)
    }
    
    
    @IBAction func qrButton(sender: UIButton) {
        createQR()
    }
    
    //segue to scanner VC
    @IBAction func scanButton(sender: UIButton) {
        performSegueWithIdentifier("scanSegue", sender: UIButton.self)
    }
    
    //segue to the contacts page
    @IBAction func contactButton(sender: UIButton) {
        performSegueWithIdentifier("contactSegue", sender: UIButton.self)
    }
    
    @IBAction func setDefaultContactButton(sender: UIButton) {
        
        print("Default Contact Button Pressed! Adding Default Contact.")
        
        let defaultContact = CNMutableContact()
        defaultContact.givenName = nameField.text!
        defaultContact.familyName = lastField.text!
        defaultContact.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: numberField.text!))]

        let completedContact: CNContact = defaultContact
        data.assignDefaultContact(completedContact)
    }
    //creates a QR code based upon the data in the form
    func createQR() {

        //default avatar image  image
        var contactImage: UIImage = UIImage(named: "DOGE")!
        
        //if there is data, make the image the new one, if not, then keep the default
        if let contactImageData = data.contacts[data.selectedContact].thumbnailImageData{
            contactImage = UIImage(data: contactImageData)!
        }
        
        //creates json string from the data in the form and stores it for parsing later
        let contactString = "{" + data.jsonify("first",value: nameField.text!) + data.jsonify("last", value: lastField.text!) + data.jsonify("number", value: numberField.text!) + "}"
        
        print("QR Generating with following data: " + contactString)
        

        //create the qr code and put in on the image view
        qrImage.image = QRCode.generateImage(contactString, avatarImage: contactImage)
        
    }
    
    //data.contacts[data.selectedContact]
    
    //loads the form with contact data from a passed CNContact
    func loadTextFields(contact: CNContact){
        //retrieve first phone number from that contact as a CNPhoneNumber object
        let phoneNumber = contact.phoneNumbers[0].value as! CNPhoneNumber
        
        //fill in the forms
        nameField.text = contact.givenName
        lastField.text = contact.familyName
        numberField.text = phoneNumber.stringValue
    }
    
    //text field methods for positioning and whatnot
    
    //runs when you begin editing
    func textFieldDidBeginEditing(textField: UITextField) {
        elderScroll.setContentOffset(CGPointMake(0, 60), animated: true)
    }
    
    //allows enter to close the text field
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
            elderScroll.setContentOffset(CGPointMake(0, 0), animated: true)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NSUserDefaults.standardUserDefaults().stringForKey("defaultFirst") == nil {
            print("No default contact, adding the first contact as the default")
            
            let newDefaultContact = CNMutableContact()
            newDefaultContact.givenName = data.contacts[0].givenName
            newDefaultContact.familyName = data.contacts[0].familyName
            newDefaultContact.phoneNumbers = data.contacts[0].phoneNumbers
            
            let newDefaultContactCompleted: CNContact = newDefaultContact
            
            data.assignDefaultContact(newDefaultContactCompleted)
            print("Successfully added New Default Contact")
        } else {
            print("There is a default contact, loading up the data")
            let defaultContact = CNMutableContact()
            
            let first = NSUserDefaults.standardUserDefaults().stringForKey("defaultFirst")
            let last = NSUserDefaults.standardUserDefaults().stringForKey("defaultLast")
            let number = NSUserDefaults.standardUserDefaults().stringForKey("defaultNumber")
            //let imageData = NSUserDefaults.standardUserDefaults().objectForKey("defaultImageData")!.data
            
            defaultContact.givenName = first!
            defaultContact.familyName = last!
            defaultContact.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: number!))]
            //defaultContact.imageData = imageData
            
            let defaultSetContact: CNContact = defaultContact
            
            data.assignDefaultContact(defaultSetContact)
            print("Successfully added Default Contact from Cache")
        }
        
        //ad stuff
        bannerView.adUnitID = "ca-app-pub-7526118464921133/5484331603"
        bannerView.delegate = self
        bannerView.rootViewController = self
        let request = GADRequest()
        request.testDevices = data.testDevices
        bannerView.loadRequest(request)
        
        loadTextFields(data.defaultContact)
        createQR()
 
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        timesViewDidAppear+=1
        
        if timesViewDidAppear != 1{
            loadTextFields(data.contacts[data.selectedContact])
            createQR()
        }
    }
    
    


}
