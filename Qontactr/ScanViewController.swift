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

class ScanViewController: UIViewController, GADBannerViewDelegate {

    let data = Data.sharedInstance
    
    @IBOutlet var bannerView: GADBannerView!
    
    let scanner = QRCode()
    
    @IBAction func buttonPressed(sender: AnyObject) {
        scanner.startScan()
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerView.adUnitID = "ca-app-pub-7526118464921133/7997146000"
        bannerView.delegate = self
        bannerView.rootViewController = self
        let request = GADRequest()
        request.testDevices = data.testDevices
        bannerView.loadRequest(request)
        
        scanner.prepareScan(view) { (stringValue) -> () in
            print(stringValue)
            let stringData: NSData = stringValue.dataUsingEncoding(NSUTF8StringEncoding)!
            let json = JSON(data: stringData)
            
            let first = json["first"].stringValue
            let last = json["last"].stringValue
            let number = json["number"].stringValue
            
            
            print(first)
            print(last)
            print(number)
            
            if first != "" {
                self.data.createContact(first, last: last, number: number)
            
                self.presentAlert("Contact Added", message: "\(first) \(last) added to Contacts")
            } else {
                self.presentAlert("No Contact Added", message: "Not a Qontactr QR Code")
            }
            
        }
        scanner.scanFrame = view.bounds
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scanner.startScan()
    }
    
    
}
