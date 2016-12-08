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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.isEqual(nameField){
            
        } else if textField.isEqual(notesField){
            animateViewMoving(true, moveValue: 200)
        }else{
            animateViewMoving(true, moveValue: 100)
        }
       
    }
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.isEqual(nameField){
            
        } else if textField.isEqual(notesField){
            animateViewMoving(false, moveValue: 200)
        }else{
            animateViewMoving(false, moveValue: 100)
        }
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:NSTimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
}


