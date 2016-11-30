import UIKit

class Game: NSObject{
    
    var opponentName:String
    var address: String
    let gameDate: NSDate
    
    init(opponentName: String, address: String) {
        self.opponentName = opponentName
        self.address = address
        self.gameDate = NSDate()
        
        super.init()
    }
}