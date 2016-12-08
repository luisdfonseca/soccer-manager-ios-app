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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //store.fetchAllGames()
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.stats.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        let stat = store.stats[indexPath.row]
        //let game = store.getGame[indexPath.row]
        
        
        cell.textLabel?.text = stat.name
        
        var color = UIColor()
        
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
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            //store.removeGame(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
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
    
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        if editing {
            sender.setTitle("Edit", forState: .Normal)
            
            setEditing(false, animated: true)
        } else{
            sender.setTitle("Done", forState: .Normal)
            
            setEditing(true, animated: true)
        }
    }
    
    /*required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }*/
    
}

