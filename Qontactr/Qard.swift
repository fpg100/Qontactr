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

class Qard: NSObject, NSCoding {
    
    var firstName: String
    var lastName: String
    var phoneNumber: String = ""
    var emailAddress: String = ""
    var twitter: String = ""
    var snapchat: String = ""
    var facebook: String = ""
    var instagram: String = ""
    var website: String = ""
    
    var profileImage: UIImage = UIImage(named: "twitterIcon")!
    
    init(first: String, last: String){
        firstName = first
        lastName = last
    }

    //all the bools for showing or not showing certain information in a qr code
    var showFirstName: Bool = true
    var showLastName: Bool = true
    var showPhoneNumber: Bool = true
    var showEmailAddress: Bool = false
    var showTwitter: Bool = false
    var showSnapchat: Bool = false
    var showFacebook: Bool = false
    var showInstagram: Bool = false
    var showWebsite: Bool = false
    
    //NSCoding Stuff------------------------------------------------------
        //encoder
    func encodeWithCoder(coder: NSCoder) {
        /*
        coder.encodeObject(self.title, forKey: "title")
        coder.encodeObject(self.author, forKey: "author")
        coder.encodeInt(Int32(self.pageCount), forKey: "pageCount")
        coder.encodeObject(self.categories, forKey: "categories")
        coder.encodeBool(self.available, forKey: "available")
        */
        
        //all the strings
        coder.encodeObject(firstName, forKey: "firstName")
        coder.encodeObject(lastName, forKey: "lastName")
        coder.encodeObject(phoneNumber, forKey: "phoneNumber")
        coder.encodeObject(emailAddress, forKey: "emailAddress")
        coder.encodeObject(twitter, forKey: "twitter")
        coder.encodeObject(snapchat, forKey: "snapchat")
        coder.encodeObject(facebook, forKey: "facebook")
        coder.encodeObject(instagram, forKey: "instagram")
        coder.encodeObject(website, forKey: "website")
        
        //all the bools
        coder.encodeBool(showFirstName, forKey: "showFirstName")
        coder.encodeBool(showLastName, forKey: "showLastName")
        coder.encodeBool(showPhoneNumber, forKey: "showPhoneNumber")
        coder.encodeBool(showEmailAddress, forKey: "showEmailAddress")
        coder.encodeBool(showTwitter, forKey: "showTwitter")
        coder.encodeBool(showSnapchat, forKey: "showSnapchat")
        coder.encodeBool(showFacebook, forKey: "showFacebook")
        coder.encodeBool(showInstagram, forKey: "showInstagram")
        coder.encodeBool(showWebsite, forKey: "showWebsite")
        
        //the image
        let imageData = UIImagePNGRepresentation(profileImage)
        coder.encodeObject(imageData, forKey: "imageData")
    }
    
        //decoder
    required convenience init?(coder decoder: NSCoder) {
        guard let firstName = decoder.decodeObjectForKey("firstName") as? String,
            let lastName = decoder.decodeObjectForKey("lastName") as? String,
            let phoneNumber = decoder.decodeObjectForKey("phoneNumber") as? String,
            let emailAddress = decoder.decodeObjectForKey("emailAddress") as? String,
            let twitter = decoder.decodeObjectForKey("twitter") as? String,
            let snapchat = decoder.decodeObjectForKey("snapchat") as? String,
            let facebook = decoder.decodeObjectForKey("facebook") as? String,
            let instagram = decoder.decodeObjectForKey("instagram") as? String,
            let website = decoder.decodeObjectForKey("website") as? String,
            let imageData = decoder.decodeObjectForKey("imageData") as? NSData?
        else {
            return nil
        }
        
        self.init(
            first: firstName,
            last: lastName
        )
        
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.twitter = twitter
        self.snapchat = snapchat
        self.facebook = facebook
        self.instagram = instagram
        self.website = website
        
        self.profileImage = UIImage(data: imageData!)!
        
        self.showFirstName = decoder.decodeBoolForKey("showFirstName")
        self.showLastName = decoder.decodeBoolForKey("showLastName")
        self.showPhoneNumber = decoder.decodeBoolForKey("showPhoneNumber")
        self.showEmailAddress = decoder.decodeBoolForKey("showEmailAddress")
        self.showTwitter = decoder.decodeBoolForKey("showTwitter")
        self.showSnapchat = decoder.decodeBoolForKey("showSnapchat")
        self.showFacebook = decoder.decodeBoolForKey("showFacebook")
        self.showInstagram = decoder.decodeBoolForKey("showInstagram")
        self.showWebsite = decoder.decodeBoolForKey("showWebsite")
        
    }
    
    //--------------------------------------------------------------------
    
    
    func printStatuses(){
        print("\n========================================================")
        print("First Name: \(firstName) Status: \(showFirstName)")
        print("Last Name: \(lastName) Status: \(showLastName)")
        print("Phone Number: \(phoneNumber) Status: \(showPhoneNumber)")
        print("Email: \(emailAddress) Status: \(showEmailAddress)")
        print("Twitter: \(twitter) Status: \(showTwitter)")
        print("Snapchat: \(snapchat) Status: \(showSnapchat)")
        print("Facebook: \(facebook) Status: \(showFacebook)")
        print("Instagram: \(instagram) Status: \(showInstagram)")
        print("Website: \(website) Status: \(showWebsite)")
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
        
        if showWebsite && website != "" {
            contactJsonString += jsonify("website", value: website)
        }
        
        contactJsonString += "}"
        
        print(contactJsonString)
        
        return QRCode.generateImage(contactJsonString, avatarImage: profileImage)!
        
    }

}
