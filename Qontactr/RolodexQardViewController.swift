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
    
    @IBOutlet var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        testLabel.text = "\(data.selectedRolodexQard.firstName)\n\(data.selectedRolodexQard.companyName)\n\(data.selectedRolodexQard.phoneNumber)\n\(data.selectedRolodexQard.emailAddress)\n\(data.selectedRolodexQard.linkedin)\n\(data.selectedRolodexQard.twitter)\n\(data.selectedRolodexQard.facebook)\n\(data.selectedRolodexQard.instagram)\n\(data.selectedRolodexQard.website)"
        
    }

}
