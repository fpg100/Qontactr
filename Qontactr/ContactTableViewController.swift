//
//  ContactTableViewController.swift
//  Qontactr
//
//  Created by John Chiaramonte on 11/5/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import UIKit

class ContactTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let data = Data.sharedInstance
    
    @IBOutlet var contactTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
