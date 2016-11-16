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
    var qardRolodex: [Qard] = []
    var selectedRolodexQard: Qard = Qard(first: "Rolo Dex")
    
    var isMyQardsSelected: Bool = true
    
    //save current myQards array to user defaults
    func saveQards(){
        
        let encodedQardArray = NSKeyedArchiver.archivedDataWithRootObject(myQards)
        NSUserDefaults.standardUserDefaults().setObject(encodedQardArray, forKey: "encodedQardArray")
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    func saveRolodex(){
        let encodedQardArray = NSKeyedArchiver.archivedDataWithRootObject(qardRolodex)
        NSUserDefaults.standardUserDefaults().setObject(encodedQardArray, forKey: "encodedRolodexArray")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    /*
    //contacts array for import reasons
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
    */
    
    let testDevices: [AnyObject] = ["a602ccfafd871943181aea6dc7401ddf",kGADSimulatorID]
    //let testDevices: [AnyObject] = []
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let contextImage: UIImage = UIImage(CGImage: image.CGImage!)
        
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRectMake(posX, posY, cgwidth, cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage!, rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(CGImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
}
