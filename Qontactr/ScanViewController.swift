//
//  HomeViewController.swift
//  Qontactr
//
//  Created by John Chiaramonte on 9/4/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVFoundation
import SwiftQRCode

class ScanViewController: UIViewController, GADBannerViewDelegate, AVCaptureMetadataOutputObjectsDelegate {

    let data = Data.sharedInstance
    
    @IBOutlet var cameraView: UIView!
    @IBOutlet var bannerView: GADBannerView!
    
    let scanner = QRCode()
    
    @IBAction func buttonPressed(sender: AnyObject) {
        scanner.startScan()
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
        }
        scanner.scanFrame = view.bounds
        
    }
    
    
}
