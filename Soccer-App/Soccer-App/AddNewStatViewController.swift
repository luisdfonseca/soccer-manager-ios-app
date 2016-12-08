import UIKit

class AddNewStatViewController: UIViewController {
    
    let store = StatStore.sharedInstance
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var goalsField: UITextField!
    @IBOutlet weak var oGoalsField: UITextField!
    @IBOutlet weak var shotsField: UITextField!
    @IBOutlet weak var oShotsField: UITextField!
    @IBOutlet weak var cardsField: UITextField!
    @IBOutlet weak var oCardsField: UITextField!
    @IBOutlet weak var foulsField: UITextField!
    @IBOutlet weak var oFoulsField: UITextField!
    @IBOutlet weak var notesField: UITextField!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    @IBAction func saveStat(sender: AnyObject) {
        
        store.saveStat(Int(goalsField.text!)!, oGoals: Int(oGoalsField.text!)!, fouls: Int(foulsField.text!)!, oFouls: Int(oFoulsField.text!)!, shots: Int(shotsField.text!)!, oShots: Int(oShotsField.text!)!, cards: Int(cardsField.text!)!, oCards: Int(oCardsField.text!)!, name: nameField.text!, notes: notesField.text!)
        
        //store.saveGame(nameField.text!, address: addressField.text!, date: dateSelected)
        self.navigationController?.popViewControllerAnimated(true)
    }
}


