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
    
    @IBOutlet var qrImage: UIImageView!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var lastField: UITextField!
    @IBOutlet var numberField: UITextField!
    
    @IBOutlet var bannerView: GADBannerView!
    
    @IBAction func tapAnywhere(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func qrButton(sender: UIButton) {
        createQR()
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func contactButton(sender: UIButton) {
        performSegueWithIdentifier("contactSegue", sender: UIButton.self)
    }
    
    func createQR() {
        let contactString = "{" + data.jsonify("first",value: nameField.text!) + data.jsonify("last", value: lastField.text!) + data.jsonify("number", value: numberField.text!) + "}"
        
        print(contactString)
        
        qrImage.image = QRCode.generateImage(contactString, avatarImage: nil)
    }
    
    //data.contacts[data.selectedContact]
    
    func loadTextFields(contact: CNContact){
        let phoneNumber = contact.phoneNumbers[0].value as! CNPhoneNumber
        
        nameField.text = contact.givenName
        lastField.text = contact.familyName
        numberField.text = phoneNumber.stringValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = "ca-app-pub-7526118464921133/5484331603"
        bannerView.delegate = self
        bannerView.rootViewController = self
        let request = GADRequest()
        request.testDevices = data.testDevices
        bannerView.loadRequest(request)
        
        loadTextFields(data.contacts[data.selectedContact])
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadTextFields(data.contacts[data.selectedContact])
        createQR()
    }
    
    


}
