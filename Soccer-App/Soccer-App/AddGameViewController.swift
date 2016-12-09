import UIKit

class AddGameViewController: UIViewController {
    
     let store = GameDatabase.sharedInstance
    
    @IBOutlet var addressField: UITextField!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var dateField: UIDatePicker!
    
    
    var dateSelected = NSDate()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func datePickerAction(sender: AnyObject) {
        dateSelected = dateField.date
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    @IBAction func saveNewgame(sender: AnyObject) {
        
       store.saveGame(nameField.text!, address: addressField.text!, date: dateSelected)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    

}


