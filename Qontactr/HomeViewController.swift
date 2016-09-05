//
//  HomeViewController.swift
//  Qontactr
//
//  Created by John Chiaramonte on 9/4/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBAction func scanVCButton(sender: UIButton) {
        performSegueWithIdentifier("scanSegue", sender: UIButton.self)
    }
    
    @IBAction func qrVCButton(sender: UIButton) {
        performSegueWithIdentifier("qrSegue", sender: UIButton.self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
