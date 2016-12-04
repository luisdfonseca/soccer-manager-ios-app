//
//  ViewController.swift
//  Soccer-App
//
//  Created by luis daniel fonseca on 11/26/16.
//  Copyright © 2016 luis daniel fonseca. All rights reserved.
//

import UIKit
import CoreData

class UserViewController: UIViewController, UITableViewDataSource, UITabBarDelegate {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    let playerstore = PlayerStore.sharedInstance
    var playerPhotos = [UIImage]()
   
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
       
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerstore.getCount()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        let player = playerstore.getPlayer(indexPath.row)
        
        let pNumber = player.playerNumber
        let pFName = player.firstName
        let pLName = player.lastName
        
        // Customize separator width
        tableView.separatorInset = UIEdgeInsetsZero
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        
        //Create Image
        let imageView = UIImageView(frame: CGRectMake(10, 5, 50, 50))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.image = playerstore.getPlayerImage(indexPath.row)
        cell.contentView.addSubview(imageView)
 
        // Create textLabel
        let textLabel = UILabel(frame: CGRectMake(70, 0, self.view.frame.width, 20))
        textLabel.font = UIFont(name: "Arial", size: 15.0)
        textLabel.textAlignment = .Left
        textLabel.text = pNumber + " " + pFName + " " + pLName
        cell.contentView.addSubview(textLabel)
        
        return cell
    }
 
    @IBAction func editButton(sender: UIBarButtonItem) {

            if(self.tableview.editing == true)
            {
                self.tableview.editing = false
                editButton.title = "Edit"
            }
            else
            {
                self.tableview.editing = true
                editButton.title = "Done"
            }
    }

    func tableView(tableView: UITableView,commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            playerstore.removePlayer(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    
    
    @IBAction func addPlayer(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Player",
                                      message: "Add the new player's Jersey Number",
                                      preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        let textField = alert.textFields!.first
                                        
                                        if !self.playerstore.checkPNumExists(textField!.text!) {
                                            
                                        
                                        
                                        let player:Player = Player(playerNumber: textField!.text!, firstName: "First Name", lastName: "Last Name", phoneNumber: "", age: "", email: "", address: "", height: "", weight: "", birthdate: "")
                                        
                                        //After getting player number, create alert that gives instructions
                                        let instructionAlert: UIAlertController = UIAlertController(title: "Update New Player", message: "Tap on the players number you just added to finish updating information about the new player.", preferredStyle: .Alert)
                                        instructionAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                                        self.presentViewController(instructionAlert, animated: true, completion: nil)
                                        
                                        
                                        self.playerstore.addPlayer(player)
                                        self.tableview.reloadData()
                                        }
                                        else{
                                            let instructionAlert: UIAlertController = UIAlertController(title: "Number Already Exists", message: "Sorry, this number is already assigned to another player.", preferredStyle: .Alert)
                                            instructionAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                                            self.presentViewController(instructionAlert, animated: true, completion: nil)
                                        }
                                        
        
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
                              animated: true,
                              completion: nil)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "playerDetailSegue" {
            
            //Figure out what row was just tapped.
            if (tableview.indexPathForSelectedRow?.row) != nil {
                
                let detailViewController = segue.destinationViewController as! UserDetailViewController
                
                detailViewController.index = tableview.indexPathForSelectedRow!.row
              
            }
        }
    }
    
    
}

