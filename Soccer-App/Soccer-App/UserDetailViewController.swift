//
//  UserDetailViewController.swift
//  Soccer-App
//
//  Created by michael jason juarez on 12/2/16.
//  Copyright © 2016 luis daniel fonseca. All rights reserved.
//

import CoreData
import UIKit

class UserDetailViewController: UIViewController {


    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var playerNumber: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var birthdate: UITextField!
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    var players = [NSManagedObject()]
    //var thePlayerProperties = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadPlayerProperties()
    }

    func loadPlayerProperties(){
        let thePlayer = players[0]
        
        let firstName = thePlayer.valueForKey("firstName") as? String
        let lastName = thePlayer.valueForKey("lastName") as? String
        let playerNumber = thePlayer.valueForKey("playerNumber") as? String
        let phoneNumber = thePlayer.valueForKey("phoneNumber") as? String
        let age = thePlayer.valueForKey("age") as? String
        let email = thePlayer.valueForKey("email") as? String
        let address = thePlayer.valueForKey("address") as? String
        let height = thePlayer.valueForKey("height") as? String
        let weight = thePlayer.valueForKey("weight") as? String
        let birthdate = thePlayer.valueForKey("birthdate") as? String
        
        
        self.fName.text = firstName
        self.lName.text = lastName
        self.playerNumber.text = playerNumber
        self.phoneNumber.text = phoneNumber
        self.age.text = age
        self.email.text = email
        self.address.text = address
        self.height.text = height
        self.weight.text = weight
        self.birthdate.text = birthdate
        
        /*
        thePlayerProperties.append(firstName!)
        thePlayerProperties.append(lastName!)
        thePlayerProperties.append(playerNumber!)
        thePlayerProperties.append(phoneNumber!)
        thePlayerProperties.append(age!)
        thePlayerProperties.append(email!)
        thePlayerProperties.append(address!)
        thePlayerProperties.append(height!)
        thePlayerProperties.append(weight!)
        thePlayerProperties.append(birthdate!)
        */
        
        self.title = firstName! + " " + lastName!
        
    }
    
    
    /*
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
        
        
        //4
        do {
            try managedContext.save()
            //5
            players.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }*/
    
}
