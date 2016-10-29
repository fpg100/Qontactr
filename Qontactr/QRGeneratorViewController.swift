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
    
    //bottom ad banner
    @IBOutlet var bannerView: GADBannerView!
    
    //master View owned by the VC
    @IBOutlet var masterView: UIView!
    
    //view that covers the toolbar
    @IBOutlet var toolbarView: UIView!
    
    //main scroll view that contains everything
    @IBOutlet var elderScroll: UIScrollView!
    
    //runs when user taps anywhere
    @IBAction func tapAnywhere(sender: UITapGestureRecognizer) {
        //close keyboard
        view.endEditing(true)
    }
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        data.selectedQard = Qard(first: "John", last: "Chiaramonte")
        data.selectedQard.phoneNumber = "9178463124"
        data.selectedQard.emailAddress = "jchiaramonte18@regis.org"
        data.selectedQard.twitter = "jchiaramonte_"
        data.selectedQard.snapchat = "jc-17"
        data.selectedQard.instagram = "jchiaramonte_"
        data.selectedQard.facebook = "Testing"
        data.selectedQard.website = "cointrak.me"
        data.selectedQard.printStatuses()
        
        qrImage.image = data.selectedQard.contactQR()
        
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
        qrImage.image = data.selectedQard.contactQR()
    }
    
    


}
