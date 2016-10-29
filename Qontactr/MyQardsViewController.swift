//
//  MyQardsViewController.swift
//  Qontactr
//
//  Created by John Chiaramonte on 10/29/16.
//  Copyright © 2016 John Chiaramonte. All rights reserved.
//

import UIKit

class MyQardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let data = Data.sharedInstance
    
    @IBOutlet var qardTable: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.myQards.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = data.myQards[indexPath.row].firstName + " " + data.myQards[indexPath.row].lastName
        
        cell.imageView!.image = data.myQards[indexPath.row].profileImage
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
