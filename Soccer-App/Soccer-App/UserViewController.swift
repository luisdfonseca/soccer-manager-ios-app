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
    
    var players = [NSManagedObject]()
    var playerPhotos = [UIImage]()
   
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Player")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            players = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        let player = players[indexPath.row]
       
        let fName = player.valueForKey("playerNumber") as? String
        //let lName = player.valueForKey("lastName") as? String
        
        let displayText = fName! //+ " " + lName!

        cell.textLabel!.text = displayText
        
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
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            managedContext.deleteObject(players[indexPath.row] as NSManagedObject)
            players.removeAtIndex(indexPath.row)
            do {
                try managedContext.save()
            } catch _ {
            }

            
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
                                        self.saveName(textField!.text!)
                                        self.tableview.reloadData()
        
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
    
    func saveName(name: String) {
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Player",
                                                        inManagedObjectContext:managedContext)
        
        let person = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: managedContext)
        
        //3
        person.setValue(name, forKey: "playerNumber")
        person.setValue("", forKey: "firstName")
        person.setValue("", forKey: "lastName")
        person.setValue("", forKey: "phoneNumber")
        person.setValue("", forKey: "age")
        person.setValue("", forKey: "email")
        person.setValue("", forKey: "address")
        person.setValue("", forKey: "height")
        person.setValue("", forKey: "weight")
        person.setValue("", forKey: "birthdate")
        
        //4
        do {
            try managedContext.save()
            //5
            players.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //If the triggered segue is the "Showitem" segue
        if segue.identifier == "playerDetailSegue" {
            
            //Figure out what row was just tapped.
            if (tableview.indexPathForSelectedRow?.row) != nil {
                
                //Get the item associated with this row and pass it along
                let item:[NSManagedObject] = players
                
                let detailViewController = segue.destinationViewController as! UserDetailViewController
                
                detailViewController.players = item
              
            }
        }
    }
    
   
}

