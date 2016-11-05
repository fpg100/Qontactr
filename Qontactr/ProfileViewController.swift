//
//  ProfileViewController.swift
//  Qontactr
//
//  Created by John Chiaramonte on 10/26/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let data = Data.sharedInstance
        
    //linking textFields
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var companyNameField: UITextField!
    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var twitterField: UITextField!
    @IBOutlet var linkedinField: UITextField!
    @IBOutlet var facebookField: UITextField!
    @IBOutlet var instagramField: UITextField!
    @IBOutlet var websiteField: UITextField!
    
    //linking switch outlets
    @IBOutlet var firstNameSwitch: UISwitch!
    @IBOutlet var companyNameSwitch: UISwitch!
    @IBOutlet var phoneNumberSwitch: UISwitch!
    @IBOutlet var emailSwitch: UISwitch!
    @IBOutlet var twitterSwitch: UISwitch!
    @IBOutlet var linkedinSwitch: UISwitch!
    @IBOutlet var facebookSwitch: UISwitch!
    @IBOutlet var instagramSwitch: UISwitch!
    @IBOutlet var websiteSwitch: UISwitch!
    
    //image outlet
    @IBOutlet var profileImageView: UIImageView!
    
    //load info from a Qard object into the form
    func loadForm(qard: Qard) {
        //loading the text from the qard into the fields
        firstNameField.text = qard.firstName
        companyNameField.text = qard.companyName
        phoneNumberField.text = qard.phoneNumber
        emailField.text = qard.emailAddress
        twitterField.text = qard.twitter
        linkedinField.text = qard.linkedin
        facebookField.text = qard.facebook
        instagramField.text = qard.instagram
        websiteField.text = qard.website
        
        //setting switches to the state of the variables
        firstNameSwitch.setOn(qard.showFirstName, animated: true)
        companyNameSwitch.setOn(qard.showCompanyName, animated: true)
        phoneNumberSwitch.setOn(qard.showPhoneNumber, animated: true)
        emailSwitch.setOn(qard.showEmailAddress, animated: true)
        twitterSwitch.setOn(qard.showTwitter, animated: true)
        linkedinSwitch.setOn(qard.showLinkedin, animated: true)
        facebookSwitch.setOn(qard.showFacebook, animated: true)
        instagramSwitch.setOn(qard.showInstagram, animated: true)
        websiteSwitch.setOn(qard.showWebsite, animated: true)
        
        //set image to profile image of qard
        profileImageView.image = qard.profileImage
    }
    
    func saveFormToQard(qard: Qard){
        //values set
        qard.firstName = firstNameField.text!
        qard.companyName = companyNameField.text!
        qard.phoneNumber = phoneNumberField.text!
        qard.emailAddress = emailField.text!
        qard.twitter = twitterField.text!
        qard.linkedin = linkedinField.text!
        qard.facebook = facebookField.text!
        qard.instagram = instagramField.text!
        qard.website = websiteField.text!
        
        //bools set
        qard.showFirstName = firstNameSwitch.on
        qard.showCompanyName = companyNameSwitch.on
        qard.showPhoneNumber = phoneNumberSwitch.on
        qard.showEmailAddress = emailSwitch.on
        qard.showTwitter = twitterSwitch.on
        qard.showLinkedin = linkedinSwitch.on
        qard.showFacebook = facebookSwitch.on
        qard.showInstagram = instagramSwitch.on
        qard.showWebsite = websiteSwitch.on
        
        qard.profileImage = profileImageView.image!
        
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
    
    @IBAction func changePicButton(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Change the Picture", message: "Choose From", preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .Default, handler: { (action) in
            pickerController.sourceType = .Camera
            self.presentViewController(pickerController, animated: true, completion: nil)
        
        })
        let galleryAction = UIAlertAction(title: "Photo Library", style: .Default, handler: { (action) in
            pickerController.sourceType = .PhotoLibrary
            self.presentViewController(pickerController, animated: true, completion: nil)
            
        })
        
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    //image picker delegate function
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.image = data.cropToBounds(pickedImage, width: 100, height: 100)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadForm(data.selectedQard)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

}
