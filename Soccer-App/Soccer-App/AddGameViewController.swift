import UIKit

class AddGameViewController: UIViewController {
    
    @IBOutlet var addressField: UITextField!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var dateField: UIDatePicker!
    
    
    let games = GamesDatabase.sharedInstance
    var dateSelected = NSDate()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func datePickerAction(sender: AnyObject) {
        dateSelected = dateField.date
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        var game = Game(opponentName: nameField.text!, address: addressField.text!, gameDate: dateSelected)
        
        games.addGame(game)
        
    }
    
    
}


