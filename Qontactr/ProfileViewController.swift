//
//  ProfileViewController.swift
//  Qontactr
//
//  Created by John Chiaramonte on 10/26/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let data = Data.sharedInstance
        
    //linking textFields
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var twitterField: UITextField!
    @IBOutlet var snapchatField: UITextField!
    @IBOutlet var facebookField: UITextField!
    @IBOutlet var instagramField: UITextField!
    @IBOutlet var websiteField: UITextField!
    
    //linking switch outlets
    @IBOutlet var firstNameSwitch: UISwitch!
    @IBOutlet var lastNameSwitch: UISwitch!
    @IBOutlet var phoneNumberSwitch: UISwitch!
    @IBOutlet var emailSwitch: UISwitch!
    @IBOutlet var twitterSwitch: UISwitch!
    @IBOutlet var snapchatSwitch: UISwitch!
    @IBOutlet var facebookSwitch: UISwitch!
    @IBOutlet var instagramSwitch: UISwitch!
    @IBOutlet var websiteSwitch: UISwitch!
    
    //load info from a Qard object into the form
    func loadForm(qard: Qard) {
        //loading the text from the qard into the fields
        firstNameField.text = qard.firstName
        lastNameField.text = qard.lastName
        phoneNumberField.text = qard.phoneNumber
        emailField.text = qard.emailAddress
        twitterField.text = qard.twitter
        snapchatField.text = qard.snapchat
        facebookField.text = qard.facebook
        instagramField.text = qard.instagram
        websiteField.text = qard.website
        
        //setting switches to the state of the variables
        firstNameSwitch.setOn(qard.showFirstName, animated: true)
        lastNameSwitch.setOn(qard.showLastName, animated: true)
        phoneNumberSwitch.setOn(qard.showPhoneNumber, animated: true)
        emailSwitch.setOn(qard.showEmailAddress, animated: true)
        twitterSwitch.setOn(qard.showTwitter, animated: true)
        snapchatSwitch.setOn(qard.showSnapchat, animated: true)
        facebookSwitch.setOn(qard.showFacebook, animated: true)
        instagramSwitch.setOn(qard.showInstagram, animated: true)
        websiteSwitch.setOn(qard.showWebsite, animated: true)
    }
    
    func saveFormToQard(qard: Qard){
        //values set
        qard.firstName = firstNameField.text!
        qard.lastName = lastNameField.text!
        qard.phoneNumber = phoneNumberField.text!
        qard.emailAddress = emailField.text!
        qard.twitter = twitterField.text!
        qard.snapchat = snapchatField.text!
        qard.facebook = facebookField.text!
        qard.instagram = instagramField.text!
        qard.website = websiteField.text!
        
        //bools set
        qard.showFirstName = firstNameSwitch.on
        qard.showLastName = lastNameSwitch.on
        qard.showPhoneNumber = phoneNumberSwitch.on
        qard.showEmailAddress = emailSwitch.on
        qard.showTwitter = twitterSwitch.on
        qard.showSnapchat = snapchatSwitch.on
        qard.showFacebook = facebookSwitch.on
        qard.showInstagram = instagramSwitch.on
        qard.showWebsite = websiteSwitch.on
        
        qard.printStatuses()
        
        data.saveQards()
    }
    
    //one action for every switch
    @IBAction func switchToggled(sender: AnyObject) {
        saveFormToQard(data.selectedQard)
    }

    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func tapAnywhere(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        saveFormToQard(data.selectedQard)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        
        loadForm(data.selectedQard)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

}
