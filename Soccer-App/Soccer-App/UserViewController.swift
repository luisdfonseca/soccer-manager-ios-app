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
    
    var players = [NSManagedObject]()
    var playerPhotos = [[UIImage]]()
   
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
       
        let fName = player.valueForKey("firstName") as? String
        //let lName = player.valueForKey("lastName") as? String
        let displayText = fName! //+ " " + lName!

        cell.textLabel!.text = displayText
        
        return cell
    }
    
    @IBAction func addPlayer(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Player",
                                      message: "Add the new Player's First Name",
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
        person.setValue(name, forKey: "firstName")
        
        //4
        do {
            try managedContext.save()
            //5
            players.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

   
}

