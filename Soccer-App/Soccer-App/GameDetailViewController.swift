//
//  ViewController.swift
//  Soccer-App
//
//  Created by luis daniel fonseca on 11/26/16.
// varpyright © 2016 luis daniel fonseca. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    let store = GameDatabase.sharedInstance
    
    @IBOutlet var dateField: UITextField!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var addressField: UITextField!
    
    var dateformatter = NSDateFormatter()
    
    var game: Game!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        dateField.userInteractionEnabled = false
        nameField.userInteractionEnabled = false
        addressField.userInteractionEnabled = false
       
        nameField.text = game.name
        addressField.text = game.address
        
        dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateformatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        
        let time = dateformatter.stringFromDate(game.date)
        
         dateField.text = time
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        game.address = addressField.text ?? ""
        game.name = nameField.text!
        
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        
        let g = game
        
        if navigationItem.rightBarButtonItem!.title == "Edit"{
            navigationItem.rightBarButtonItem!.title = "Save"
            
            textFieldUserInteraction(true)
        }else{
            navigationItem.rightBarButtonItem!.title = "Edit"
            
            let date = dateformatter.dateFromString(dateField.text!)
            
            if !(nameField.text == game.name) || !(addressField.text == game.address) || !(date == game.date){
                
                store.editGame(nameField.text!, address: addressField.text!, date: date!, g: g)
                
                textFieldUserInteraction(false)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        navigationItem.rightBarButtonItem?.title = "Edit"
    }
    
    func textFieldUserInteraction(b: Bool){
        dateField.userInteractionEnabled = b
        nameField.userInteractionEnabled = b
        addressField.userInteractionEnabled = b
    }
    
}


