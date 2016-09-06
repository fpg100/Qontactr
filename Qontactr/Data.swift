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
    
    //bool that tells the main VC if the segue was from the table vc or not
    var didComeFromTable: Bool = false
    
    //default contact, gets imported at startup
    var defaultContact = CNContact()

    //equivalent of the selected cell in the conacts table VC
    var selectedContact = 0
    
    let testDevices: [AnyObject] = ["a602ccfafd871943181aea6dc7401ddf",kGADSimulatorID]
    //let testDevices: [AnyObject] = []

    //formats a title and a value into json format 
        //  "title":"value",
    func jsonify(title: String,value: String) -> String {
        var jsonString = ""
        
        jsonString = "\"" + title + "\":\"" + value + "\","
        
        return jsonString
    }
    
    //creates an array of all of the user's contacts
    lazy var contacts: [CNContact] = {
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataAvailableKey,
            CNContactThumbnailImageDataKey]
        
        // Get all the containers
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containersMatchingPredicate(nil)
        } catch {
            print("Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        // Iterate all containers and append their contacts to our results array
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainerWithIdentifier(container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContactsMatchingPredicate(fetchPredicate, keysToFetch: keysToFetch)
                results.appendContentsOf(containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }
        
        return results
    }()
    
    func assignDefaultContact(contact: CNContact) {
        
        let first = contact.givenName
        let last = contact.familyName
        let phoneNumber = contact.phoneNumbers[0].value as! CNPhoneNumber
        let number = phoneNumber.stringValue
        
        print("Attempting to assign \(first) \(last) as default contact")
        
        var imageData = NSData()
        
        //default image
        if let imageDataLocal = contact.thumbnailImageData {
            
            print("Attempted Default contact has thumbnail image data, attempting to archive it...")
            
            let attemptedImage: UIImage = UIImage(data: imageDataLocal)!
            print(attemptedImage)
            
            let encodedImageData = UIImagePNGRepresentation(UIImage(data: imageDataLocal)!)
            imageData = NSKeyedArchiver.archivedDataWithRootObject(encodedImageData!)
            
            
            
        } else if let imageDataLocal = contact.imageData {
            
            print("Attempted Default contact has imageData, attempting to archive it...")
            
            let attemptedImage: UIImage = UIImage(data: imageDataLocal)!
            print(attemptedImage)
            
            let encodedImageData = UIImagePNGRepresentation(UIImage(data: imageDataLocal)!)
            imageData = NSKeyedArchiver.archivedDataWithRootObject(encodedImageData!)
            
        } else {
            
            print("Attempted Default contact has no image data, attempting to archive default image...")
            
            let attemptedImage: UIImage = UIImage(named: "DOGE")!
            print(attemptedImage)
            
            let encodedImageData = UIImagePNGRepresentation(UIImage(named: "DOGE")!)
            imageData = NSKeyedArchiver.archivedDataWithRootObject(encodedImageData!)
            
        }
    
        
        NSUserDefaults.standardUserDefaults().setObject(first, forKey: "defaultFirst")
        NSUserDefaults.standardUserDefaults().setObject(last, forKey: "defaultLast")
        NSUserDefaults.standardUserDefaults().setObject(number, forKey: "defaultNumber")
        NSUserDefaults.standardUserDefaults().setObject(imageData, forKey: "defaultImageData")
        NSUserDefaults.standardUserDefaults().synchronize()

        defaultContact = contact
        
        
        print(defaultContact.givenName + " " + defaultContact.familyName + " is now the Default Contact")
        
    }
    
    

    
    //creates a contact with the provided values
    func createContact(first: String, last: String, number: String){
        let newContact = CNMutableContact()
        
        newContact.givenName = first
        newContact.familyName = last
        
        let cnPhoneNumber = CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: number))
        newContact.phoneNumbers = [cnPhoneNumber]
        
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.addContact(newContact, toContainerWithIdentifier:nil)
        try! store.executeSaveRequest(saveRequest)

    }
    
}