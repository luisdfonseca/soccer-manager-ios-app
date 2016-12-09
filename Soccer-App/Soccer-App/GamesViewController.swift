//
//  ViewController.swift
//  Soccer-App
//
//  Created by luis daniel fonseca on 11/26/16.
//  Copyright © 2016 luis daniel fonseca. All rights reserved.
//

import UIKit

class GamesViewController: UITableViewController {
    
    let store = GameDatabase.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        store.fetchAllGames()
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.games.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "GameTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GameTableViewCell
        
        let game = store.games[indexPath.row]
        
        // Format the date and time text to be displayed in the table view controller
        let gamedate = game.date
        
        let formater = NSDateFormatter()
        formater.dateFormat = "d"
        let dayString = formater.stringFromDate(gamedate)
        
        formater.dateFormat = "MMM"
        let monthString = formater.stringFromDate(gamedate)
        
        formater.dateFormat = "h:mm a"
        let timeString = formater.stringFromDate(gamedate)

        
        cell.nameLabel.text = game.name
        cell.dateLabel.text = dayString
        cell.monthLabel.text = monthString.uppercaseString
        cell.timeLabel.text = timeString.uppercaseString
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            
            let title = "Delete Game"
            let message = "Are you sure you want to delete this?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel,
                                             handler: nil)
            ac.addAction(cancelAction)
            
            let deletAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
                (action) -> Void in
                
                self.store.removeGame(indexPath.row)
                
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                
            })
            
            ac.addAction(deletAction)
            presentViewController(ac, animated: true, completion: nil)
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowItem" {
            
            if let row = tableView.indexPathForSelectedRow?.row {
                
                let game = store.games[row]
                let detailViewController = segue.destinationViewController as! GameDetailViewController
                detailViewController.game = game
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
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
}

