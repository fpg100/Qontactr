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
    
    @IBOutlet var testImageView: UIImageView!
    
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
    
    func setStatuses(qard: Qard){
        qard.showFirstName = firstNameSwitch.on
        qard.showLastName = lastNameSwitch.on
        qard.showPhoneNumber = phoneNumberSwitch.on
        qard.showEmailAddress = emailSwitch.on
        qard.showTwitter = twitterSwitch.on
        qard.showSnapchat = snapchatSwitch.on
        qard.showFacebook = facebookSwitch.on
        qard.showInstagram = instagramSwitch.on
        qard.showWebsite = websiteSwitch.on
    }
    
    //one action for every switch
    @IBAction func switchToggled(sender: AnyObject) {
        setStatuses(data.selectedQard)
        data.selectedQard.printStatuses()
    }
    
    @IBAction func qrButtonTemp(sender: AnyObject) {
    
        testImageView.image = data.selectedQard.contactQR()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data.selectedQard = Qard(first: "John", last: "Chiaramonte")
        
        data.selectedQard.phoneNumber = "9178463124"
        data.selectedQard.emailAddress = "jchiaramonte18@regis.org"
        
        data.selectedQard.printStatuses()
        
        loadForm(data.selectedQard)
        
        testImageView.image = data.selectedQard.contactQR()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}
