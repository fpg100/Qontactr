//
//  Data.swift
//  Qontactr
//
//  Created by John Chiaramonte on 9/4/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import Foundation
import GoogleMobileAds
import Contacts

class Data {
    
    static let sharedInstance = Data()
    init(){}
    
    var selectedQard: Qard = Qard(first: "Dank Memington")
    var myQards: [Qard] = []
    
    //save current myQards array to user defaults
    func saveQards(){
        
        let encodedQardArray = NSKeyedArchiver.archivedDataWithRootObject(myQards)
        NSUserDefaults.standardUserDefaults().setObject(encodedQardArray, forKey: "encodedQardArray")
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    let testDevices: [AnyObject] = ["a602ccfafd871943181aea6dc7401ddf",kGADSimulatorID]
    //let testDevices: [AnyObject] = []
    
}
