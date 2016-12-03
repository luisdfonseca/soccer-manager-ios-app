import UIKit

class AddGameViewController: UIViewController {
    
    @IBOutlet var addressField: UITextField!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var dateField: UITextField!
    
    let games = GamesDatabase.sharedInstance
    var game = Game(opponentName: "", address: "")
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        game.address  = addressField.text!
        game.opponentName = nameField.text!
        
        games.addGame(game)
        
    }
    
    
}


