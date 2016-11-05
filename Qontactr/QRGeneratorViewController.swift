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

class QRGeneratorViewController: UIViewController, GADBannerViewDelegate {

    let data = Data.sharedInstance
    
    var timesViewDidAppear: Int = 0
    
    //image view that the QR code gets put onto
    @IBOutlet var qrImage: UIImageView!
    
    //labels
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    
    //bottom ad banner
    @IBOutlet var bannerView: GADBannerView!
    
    //saves whatever image is on qrimage imageview after alert prompt
    @IBAction func saveQRPhotoButton(sender: UIButton) {
        let alertController = UIAlertController(title: "Save QR code to camera roll?", message:
            nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default,handler: {(alert: UIAlertAction!) in
            
            print("QR Photo saved to camera roll")
            UIImageWriteToSavedPhotosAlbum(self.qrImage.image!, nil, nil, nil)
        
        }))

        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default,handler: {(alert: UIAlertAction!) in
            
            print("User denied saving to camera roll")
            
        }))
    
        self.presentViewController(alertController, animated: true, completion: nil)
    
    }
    
    @IBAction func scanSegueButton(sender: AnyObject) {
        self.performSegueWithIdentifier("scanSegue", sender: UIButton.self)
    }
    @IBAction func profileSegueButton(sender: AnyObject) {
        self.performSegueWithIdentifier("profileSegue", sender: UIButton.self)
    }
    
    //present an alert to the user
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //loads User Defaults from memory and handles them if there are none
    func setupDefaults(){
        let currentLaunchCount = NSUserDefaults.standardUserDefaults().integerForKey("launchCount")
        print("The user has launched the app \(currentLaunchCount) times")
        
        //if this is the first time the user launches the app, make the stored qard array the default one
        if currentLaunchCount == 1 {
            print("First time launching app, making default Qard array...")
            let qardArray: [Qard] = [data.selectedQard]
            let encodedQardArray = NSKeyedArchiver.archivedDataWithRootObject(qardArray)
            NSUserDefaults.standardUserDefaults().setObject(encodedQardArray, forKey: "encodedQardArray")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            self.performSegueWithIdentifier("profileSegue", sender: nil)
            presentAlert("Welcome To Qontactr", message: "This is your Qontact Qard, enter your info and select what you want to display in your QR code")
        }
        
        let encodedQardArray = NSUserDefaults.standardUserDefaults().objectForKey("encodedQardArray") as! NSData
        let decodedQardArray = NSKeyedUnarchiver.unarchiveObjectWithData(encodedQardArray) as! [Qard]
        
        data.myQards = decodedQardArray
        data.selectedQard = data.myQards[0]
    }
    
    @IBAction func qardListButton(sender: AnyObject) {
        self.performSegueWithIdentifier("qardListSegue", sender: UIButton.self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaults()
        
        nameLabel.text = data.selectedQard.firstName
        companyLabel.text = data.selectedQard.companyName
        qrImage.image = data.selectedQard.contactQR()
        
        //bring the ad over the temp banner
        view.bringSubviewToFront(bannerView)
        
        //ad stuff
        bannerView.adUnitID = "ca-app-pub-7526118464921133/5484331603"
        bannerView.delegate = self
        bannerView.rootViewController = self
        let request = GADRequest()
        request.testDevices = data.testDevices
        bannerView.loadRequest(request)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        nameLabel.text = data.selectedQard.firstName
        companyLabel.text = data.selectedQard.companyName
        qrImage.image = data.selectedQard.contactQR()
    }
    
    


}
