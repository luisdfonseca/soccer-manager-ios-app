//
//  ViewController.swift
//  Soccer-App
//
//  Created by luis daniel fonseca on 11/26/16.
//  Copyright © 2016 luis daniel fonseca. All rights reserved.
//

import UIKit

class StatTableViewController: UITableViewController {
    
    let store = StatStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.stats.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        let stat = store.stats[indexPath.row]
        
        cell.textLabel?.text = stat.name
        
        // store a color to be use in the cell
        var color = UIColor()
        
        // displays the name of the game depending of the result ( green = won, etc..)
        if Int(stat.goals!) > Int(stat.oGoals!) {
            color = UIColor.greenColor()
        } else if Int(stat.goals!) == Int(stat.oGoals!){
            color = UIColor.grayColor()
        }else {
            color = UIColor.redColor()
        }
        
        cell.textLabel?.textColor = color

        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowItem" {
            
            if let row = tableView.indexPathForSelectedRow?.row {
                
               let stat = store.stats[row]
                let detailViewController = segue.destinationViewController as! StatDetailViewController
               detailViewController.stat = stat
                detailViewController.indexPath = row
            }
        }
    }
    
}

