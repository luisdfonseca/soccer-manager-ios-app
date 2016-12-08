import UIKit
import  CoreData

class Game: NSManagedObject{
    
    @NSManaged var name:String
    @NSManaged var address: String
    @NSManaged var date: NSDate
    
    override func awakeFromInsert(){
        super.awakeFromInsert()
        
        name = ""
        address = ""
        date = NSDate()
    }
}