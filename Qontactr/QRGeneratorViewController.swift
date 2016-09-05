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
    
    //runs when user taps anywhere
    @IBAction func tapAnywhere(sender: UITapGestureRecognizer) {
        //close keyboard
        view.endEditing(true)
    }
    
    
    @IBAction func qrButton(sender: UIButton) {
        createQR()
    }
    
    //segue back to ain VC
    @IBAction func backButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //segue to the contacts page
    @IBAction func contactButton(sender: UIButton) {
        performSegueWithIdentifier("contactSegue", sender: UIButton.self)
    }
    
    //creates a QR code based upon the data in the form
    func createQR() {
        
        //imageDataString for converting the image data to a string for passing over the QR code as JSON
        
        var contactImage: UIImage = UIImage(named: "DOGE")!
        if data.contacts[data.selectedContact].imageDataAvailable{
            if let contactImageData = data.contacts[data.selectedContact].thumbnailImageData {
                contactImage = UIImage(data: contactImageData)!
            }
        }
        
        //creates json string from the data in the form and stores it for parsing later
        let contactString = "{" + data.jsonify("first",value: nameField.text!) + data.jsonify("last", value: lastField.text!) + data.jsonify("number", value: numberField.text!) + "}"
        
        print(contactString)
        

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ad stuff
        bannerView.adUnitID = "ca-app-pub-7526118464921133/5484331603"
        bannerView.delegate = self
        bannerView.rootViewController = self
        let request = GADRequest()
        request.testDevices = data.testDevices
        bannerView.loadRequest(request)
        
        //load the form with initial data
        loadTextFields(data.contacts[data.selectedContact])
        createQR()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        timesViewDidAppear+=1
        loadTextFields(data.contacts[data.selectedContact])
        if timesViewDidAppear != 1{
           createQR()
        }
    }
    
    


}
