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