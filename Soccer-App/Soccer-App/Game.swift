import UIKit

class Game: NSObject{
    
    var opponentName:String
    var address: String
    var gameDate: NSDate
    
    init(opponentName: String, address: String, gameDate: NSDate) {
        self.opponentName = opponentName
        self.address = address
        self.gameDate = gameDate
        
        super.init()
    }
}