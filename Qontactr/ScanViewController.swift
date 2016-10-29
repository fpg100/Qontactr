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
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //set this value as it segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //data.didComeFromTable = false
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
            
            //if there is no first name, IE if it isn't a QR code generated from the app itself, then don't add any contact and alert the user, otherwise create contact from the data
            
            self.presentAlert("QR Scanned", message: stringValue)
            
            
        }
        scanner.scanFrame = view.bounds
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //start the scan by default
        scanner.startScan()
    }
    
    
}
