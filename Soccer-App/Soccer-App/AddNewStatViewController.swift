import UIKit

class AddNewStatViewController: UIViewController {
    
    let store = StatStore.sharedInstance
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    @IBAction func saveNewgame(sender: AnyObject) {
        
        //store.saveGame(nameField.text!, address: addressField.text!, date: dateSelected)
        //self.navigationController?.popViewControllerAnimated(true)
    }
}


