//
//  RolodexQardViewController.swift
//  Qontactr
//
//  Created by John Chiaramonte on 11/15/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import UIKit

class RolodexQardViewController: UIViewController {

    let data = Data.sharedInstance
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var linkedinLabel: UILabel!
    @IBOutlet var twitterLabel: UILabel!
    @IBOutlet var facebookLabel: UILabel!
    @IBOutlet var instagramLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    
    func loadQardToForm(qard: Qard) {
        
        nameLabel.text = qard.firstName
        companyLabel.text = qard.companyName
        phoneNumberLabel.text = qard.phoneNumber
        emailLabel.text = qard.emailAddress
        linkedinLabel.text = qard.linkedin
        twitterLabel.text = qard.twitter
        facebookLabel.text = qard.facebook
        instagramLabel.text = qard.instagram
        websiteLabel.text = qard.website
        
        profileImageView.image = qard.profileImage
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadQardToForm(data.selectedRolodexQard)
        
        print("====================================")
        print("\(data.selectedRolodexQard.firstName)\n\(data.selectedRolodexQard.companyName)\n\(data.selectedRolodexQard.phoneNumber)\n\(data.selectedRolodexQard.emailAddress)\n\(data.selectedRolodexQard.linkedin)\n\(data.selectedRolodexQard.twitter)\n\(data.selectedRolodexQard.facebook)\n\(data.selectedRolodexQard.instagram)\n\(data.selectedRolodexQard.website)")
        print("====================================")
        

        
    }

}
