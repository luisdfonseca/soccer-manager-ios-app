//  PROGRAMMER:     Michael Juarez, Luis Daniel Fonseca
//  PANTHERID:      1316430
//  CLASS:          COP 465501 TR 5:00
//  INSTRUCTOR:     Steve Luis  ECS 282
//  ASSIGNMENT:     Final Project
//  DUE:            Thursday 12/08/16
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
    
    //These arrays run parrellel.  This approach can be improved, just didn't want to break code after fully understanding I didn't need parralel arrays.  It was easier to pass array data to other view controllers, versus passing NSManagedObjects
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
        
        //Fill the pStore[Player] array with data from the CoreData array
        for i in 0..<playersCoreData.count {

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
    
    //Not sure if this is needed, kept it in case I break something
    func getpStore() -> [Player] {
        return pStore
    }
    
    //Save Picture is only used if I'm updating the contact, should be false if I'm truly deleting a contact
    func removePlayer(index:Int, savePicture: Bool?) {
        
        //Assign the player number to pNum
        let pNum = pStore[index].playerNumber
        
        
        let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Player")
        fetchRequest.predicate = NSPredicate(format: "playerNumber == %@", pNum)
        
        do {
            
            let results = try managedContext.executeFetchRequest(fetchRequest)
            managedContext.deleteObject(results[0] as! NSManagedObject)
            
            //Save the picture if i'm only updating an existing contact
            if savePicture != true {
                deletePlayerPhoto(pStore[index].playerNumber)
            }
            
            playersCoreData.removeAtIndex(index)
            pStore.removeAtIndex(index)
            
            print(pStore.count)
            print(playersCoreData.count)
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func removePlayerWhenUpdating(index:Int) {
        
    }
    
    func getCount() -> Int {
        return pStore.count
    }
    
    func getPlayer(index : Int) -> Player {
        return pStore[index]
    }
    
    func addPlayer(aPlayer : Player) {
        //14
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
            pStore.append(aPlayer)
            playersCoreData.append(player)
            
            try managedContext.save()
            //5
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    //Remove and add player from lists
    func updatePlayer (index : Int, player : Player) {
        let oldPlayer = pStore[index]
        let oldPlayerNumber = oldPlayer.playerNumber
        let newPlayerNumber = player.playerNumber
        
        if oldPlayerNumber != newPlayerNumber {
            updatePicturePath(oldPlayerNumber, newPNum: newPlayerNumber)
        }
        
        removePlayer(index, savePicture: true)
        addPlayer(player)
    }
    
    func savePicture(image : UIImage, player : Player ) {
        let pNum : String = player.playerNumber
        let fileName : String = pNum + ".png"
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let getImagePath = paths.stringByAppendingPathComponent(fileName)
        UIImageJPEGRepresentation(image,1.0)!.writeToFile(getImagePath, atomically: true)
        
    }
    
    private func updatePicturePath(oldPNum : String, newPNum : String) {

        let oldFileName : String = oldPNum + ".png"
        let newFileName : String = newPNum + ".png"
        
        do {
            let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            let documentDirectory = NSURL(fileURLWithPath: path)
            let originPath = documentDirectory.URLByAppendingPathComponent(oldFileName)
            let destinationPath = documentDirectory.URLByAppendingPathComponent(newFileName)
            try NSFileManager.defaultManager().moveItemAtURL(originPath, toURL: destinationPath)
        } catch let error as NSError {
            print(error)
        }
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
    
    func getPlayerImage(index : Int) -> UIImage {
        
        let pNum : String = getPlayer(index).playerNumber
        let fileName : String = pNum + ".png"
        
        var pic : UIImage = UIImage(named: "blankPlayer.png")!
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let getImagePath = paths.stringByAppendingPathComponent(fileName)
        
        if UIImage(contentsOfFile: getImagePath) != nil{
            pic = UIImage(contentsOfFile: getImagePath)!
        }
        
        return pic
    }
    
    private func deletePlayerPhoto(pNum : String) {
        let filename = pNum + ".png"
        
        do {
            
            
            let pathF = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: pathF)
            let filePath = url.URLByAppendingPathComponent(filename).path
            
            if NSFileManager.defaultManager().fileExistsAtPath(filePath!) {
                let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
                let documentDirectory = NSURL(fileURLWithPath: path)
                let filepath = documentDirectory.URLByAppendingPathComponent(filename)
                try NSFileManager.defaultManager().removeItemAtURL(filepath)
                print("deleting pic successful")
            }
            else{
                print("File Doesn't Exist")
            }
            
        } catch let error as NSError {
            print(error)
        }
    }
    
}




