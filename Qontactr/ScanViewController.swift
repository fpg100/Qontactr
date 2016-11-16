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
    
    @IBOutlet var defaultBanner: UIImageView!
    
    @IBOutlet var bottomView: UIView!
    
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

        bottomView.bringSubviewToFront(bannerView)
        
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
            if stringValue.hasPrefix("http://cointrak.me"){
                var qontactString = stringValue
                
                let range = qontactString.startIndex...qontactString.startIndex.advancedBy(18)
                
                qontactString.removeRange(range)
                
                self.presentAlert("QR Scanned", message: qontactString)
                
                let stringData: NSData = qontactString.dataUsingEncoding(NSUTF8StringEncoding)!
                let json = JSON(data: stringData)
                
                //parse this JSON data into local variables
                let first = json["first"].stringValue
                let company = json["company"].stringValue
                let number = json["number"].stringValue
                let linkedin = json["linkedin"].stringValue
                let twitter = json["twitter"].stringValue
                let facebook = json["facebook"].stringValue
                let instagram = json["instagram"].stringValue
                let website = json["website"].stringValue
                
                let newQard = Qard(first: first)
                
                newQard.companyName = company
                newQard.phoneNumber = number
                newQard.linkedin = linkedin
                newQard.twitter = twitter
                newQard.facebook = facebook
                newQard.instagram = instagram
                newQard.website = website
                
                self.data.qardRolodex.append(newQard)
                
                self.data.saveRolodex()
                
                
                
            } else {
                self.presentAlert("Not a Qontactr QR Code", message: stringValue)
            }
            
        }
        scanner.scanFrame = view.bounds
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //start the scan by default
        scanner.startScan()
    }
    
    
}
