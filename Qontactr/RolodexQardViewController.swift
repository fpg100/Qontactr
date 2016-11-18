//
//  RolodexQardViewController.swift
//  Qontactr
//
//  Created by John Chiaramonte on 11/15/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import UIKit

class RolodexQardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let data = Data.sharedInstance
    
    @IBOutlet var infoTable: UITableView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    
    var titles: [String] = []
    var values: [String] = []

    
    func loadQardToForm(qard: Qard) {
        
        nameLabel.text = qard.firstName
        companyLabel.text = qard.companyName
        profileImageView.image = qard.profileImage
        
        
    }
    
    func setupArrays(qard: Qard) {
        if qard.phoneNumber != "" {
            values.append(qard.phoneNumber)
            titles.append("Phone Number")
        }
        if qard.emailAddress != "" {
            values.append(qard.emailAddress)
            titles.append("Email Address")
        }
        if qard.linkedin != "" {
            values.append(qard.linkedin)
            titles.append("Linkedin")
        }
        if qard.twitter != "" {
            values.append(qard.twitter)
            titles.append("Twitter")
        }
        if qard.facebook != "" {
            values.append(qard.facebook)
            titles.append("Facebook")
        }
        if qard.instagram != "" {
            values.append(qard.instagram)
            titles.append("Instagram")
        }
        if qard.website != "" {
            values.append(qard.website)
            titles.append("Website")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dataCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = values[indexPath.row]
        cell.detailTextLabel!.text = titles[indexPath.row]
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupArrays(data.selectedRolodexQard)
        loadQardToForm(data.selectedRolodexQard)
        
        infoTable.delegate = self
        infoTable.dataSource = self
        

        
        print("====================================")
        print("\(data.selectedRolodexQard.firstName)\n\(data.selectedRolodexQard.companyName)\n\(data.selectedRolodexQard.phoneNumber)\n\(data.selectedRolodexQard.emailAddress)\n\(data.selectedRolodexQard.linkedin)\n\(data.selectedRolodexQard.twitter)\n\(data.selectedRolodexQard.facebook)\n\(data.selectedRolodexQard.instagram)\n\(data.selectedRolodexQard.website)")
        print("====================================")
        
        
        
    }

}
