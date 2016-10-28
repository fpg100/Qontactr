//
//  Qard.swift
//  Qontactr
//
//  Created by John Chiaramonte on 10/26/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import Foundation
import UIKit
import SwiftQRCode

class Qard {
    
    var firstName: String
    var lastName: String
    var phoneNumber: String = ""
    var emailAddress: String = ""
    var twitter: String = ""
    var snapchat: String = ""
    var facebook: String = ""
    var instagram: String = ""
    
    init(first: String, last: String){
        firstName = first
        lastName = last
    }

    //all the bools for showing or not showing certain information in a qr code
    var showFirstName: Bool = true
    var showLastName: Bool = true
    var showPhoneNumber: Bool = false
    var showEmailAddress: Bool = false
    var showTwitter: Bool = false
    var showSnapchat: Bool = false
    var showFacebook: Bool = false
    var showInstagram: Bool = false
    
    func printStatuses(){
        print("\n========================================================")
        print("First Name:\(firstName) Status: \(showFirstName)")
        print("Last Name:\(lastName) Status: \(showLastName)")
        print("Phone Number:\(phoneNumber) Status: \(showPhoneNumber)")
        print("Email:\(emailAddress) Status: \(showEmailAddress)")
        print("Twitter:\(twitter) Status: \(showTwitter)")
        print("Snapchat:\(snapchat) Status: \(showSnapchat)")
        print("Facebook:\(facebook) Status: \(showFacebook)")
        print("Instagram:\(instagram) Status: \(showInstagram)")
        print("========================================================\n")
    }
    
    func jsonify(title: String,value: String) -> String {
        var jsonString = ""
        
        jsonString = "\"" + title + "\":\"" + value + "\","
        
        return jsonString
    }
    
    func contactQR() -> UIImage {
        var contactJsonString = "{"
        
        //append the json string with data if and only if the value isnt blank and the slider is set to yes
        if showFirstName && firstName != "" {
            contactJsonString += jsonify("first", value: firstName)
        }
        
        if showLastName && lastName != "" {
            contactJsonString += jsonify("last", value: lastName)
        }
        if showPhoneNumber && phoneNumber != "" {
            contactJsonString += jsonify("number", value: phoneNumber)
        }
        
        if showEmailAddress && emailAddress != "" {
            contactJsonString += jsonify("email", value: emailAddress)
        }
        //*
        if showTwitter && twitter != "" {
            contactJsonString += jsonify("twitter", value: twitter)
        }
        
        if showSnapchat && snapchat != "" {
            contactJsonString += jsonify("snapchat", value: snapchat)
        }
        if showFacebook && facebook != "" {
            contactJsonString += jsonify("facebook", value: facebook)
        }
        
        if showInstagram && instagram != "" {
            contactJsonString += jsonify("instagram", value: instagram)
        }
        
        contactJsonString += "}"
        
        print(contactJsonString)
        
        return QRCode.generateImage(contactJsonString, avatarImage: nil)!
        
    }

}
