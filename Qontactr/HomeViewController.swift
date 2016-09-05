//
//  HomeViewController.swift
//  Qontactr
//
//  Created by John Chiaramonte on 9/4/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //segue to scanner view controller
    @IBAction func scanVCButton(sender: UIButton) {
        performSegueWithIdentifier("scanSegue", sender: UIButton.self)
    }
    //segue to qr generation view controller
    @IBAction func qrVCButton(sender: UIButton) {
        performSegueWithIdentifier("qrSegue", sender: UIButton.self)
    }
    //runs when view loads in for the first time
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
