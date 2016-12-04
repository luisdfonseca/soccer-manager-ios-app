//
//  playerStore.swift
//  Soccer-App
//
//  Created by michael jason juarez on 12/2/16.
//  Copyright © 2016 luis daniel fonseca. All rights reserved.
//

import CoreData
import UIKit

struct Player {
    var playerNumber : String
    var firstName : String
    var lastName : String
    var phoneNumber : String
    var age : String
    var email : String
    var address : String
    var height : String
    var weight : String
    var birthdate : String
}

final class PlayerStore: NSObject {
    
    static let sharedInstance = PlayerStore()
    
    private var playersCoreData = [NSManagedObject]()
    private var pStore = [Player]()
    
    private override init () {
        super.init()
        
        self.fillPlayerStore()
    }
    
    private func fillPlayerStore () {
        
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
            playersCoreData = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        for i in 0..<playersCoreData.count {
            print(String(i) + " < " + String(playersCoreData.count) )
            let playerCoreData = playersCoreData[i]
            
            let playerNumber = playerCoreData.valueForKey("playerNumber") as? String
            let firstName = playerCoreData.valueForKey("firstName") as? String
            let lastName = playerCoreData.valueForKey("lastName") as? String
            let phoneNumber = playerCoreData.valueForKey("phoneNumber") as? String
            let age = playerCoreData.valueForKey("age") as? String
            let email = playerCoreData.valueForKey("email") as? String
            let address = playerCoreData.valueForKey("address") as? String
            let height = playerCoreData.valueForKey("height") as? String
            let weight = playerCoreData.valueForKey("weight") as? String
            let birthdate = playerCoreData.valueForKey("birthdate") as? String
            
            let player : Player = Player(playerNumber: playerNumber!, firstName: firstName!, lastName: lastName!, phoneNumber: phoneNumber!, age: age!, email: email!, address: address!, height: height!, weight: weight!, birthdate: birthdate!)
            
            pStore.append(player)
        }
    }
    
    
    func getpStore() -> [Player] {
        return pStore
    }
    
    func removePlayer(index:Int) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        managedContext.deleteObject(playersCoreData[index] as NSManagedObject)
        pStore.removeAtIndex(index)
        do {
            try managedContext.save()
        } catch _ {
        }
        
    }
    
    func getCount() -> Int {
        return pStore.count
    }
    
    func getPlayer(index : Int) -> Player {
        return pStore[index]
    }
    
    func addPlayer(aPlayer : Player) {
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Player",
                                                        inManagedObjectContext:managedContext)
        
        let player = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: managedContext)
        
        //3
        player.setValue(aPlayer.playerNumber, forKey: "playerNumber")
        player.setValue(aPlayer.firstName, forKey: "firstName")
        player.setValue(aPlayer.lastName, forKey: "lastName")
        player.setValue(aPlayer.phoneNumber, forKey: "phoneNumber")
        player.setValue(aPlayer.age, forKey: "age")
        player.setValue(aPlayer.email, forKey: "email")
        player.setValue(aPlayer.address, forKey: "address")
        player.setValue(aPlayer.height, forKey: "height")
        player.setValue(aPlayer.weight, forKey: "weight")
        player.setValue(aPlayer.birthdate, forKey: "birthdate")
        
        //4
        do {
            try managedContext.save()
            //5
            pStore.append(aPlayer)
            playersCoreData.append(player)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    func updatePlayer (index : Int, player : Player) {
        removePlayer(index)
        addPlayer(player)
    }
    
    func getPlayerImage(index : Int) -> UIImage {
        
        let pNum : String = getPlayer(index).playerNumber
        let fileName : String = pNum + ".png"
        
        var pic : UIImage = UIImage(named: "blankPlayer.png")!
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let getImagePath = paths.stringByAppendingPathComponent(fileName)
        
        if UIImage(contentsOfFile: getImagePath) != nil{
            pic = UIImage(contentsOfFile: getImagePath)!
        }
        
        print(getImagePath)
        return pic
    }
    
    func savePicture(image : UIImage, index : Int) {
        let pNum : String = getPlayer(index).playerNumber
        let fileName : String = pNum + ".png"
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let getImagePath = paths.stringByAppendingPathComponent(fileName)
        UIImageJPEGRepresentation(image,1.0)!.writeToFile(getImagePath, atomically: true)
        
    }
    
    func checkPNumExists(pNum : String) -> Bool {
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        let fetchReq = NSFetchRequest(entityName: "Player")
                
        fetchReq.predicate = NSPredicate(format: "playerNumber == %@", pNum)
        
        do {
            let fetchPlayerNum = try moc.executeFetchRequest(fetchReq) as! [NSManagedObject]
            
            if fetchPlayerNum.count < 1 {
                return false
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        
        return true
    }
    
}




