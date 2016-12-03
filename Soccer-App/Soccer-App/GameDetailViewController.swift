//
//  ViewController.swift
//  Soccer-App
//
//  Created by luis daniel fonseca on 11/26/16.
// varpyright © 2016 luis daniel fonseca. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    
    
    @IBOutlet var dateField: UITextField!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var addressField: UITextField!
    
    var dateformatter = NSDateFormatter()
    
    var game: Game!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       
        nameField.text = game.opponentName
        addressField.text = game.address
        
        
        dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateformatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let time = dateformatter.stringFromDate(game.gameDate)
        
         dateField.text = time
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        game.address = addressField.text ?? ""
        game.opponentName = nameField.text!
        
        //dateformatter.dateFormat = "MM/dd/yy h:mm a Z"
        
        //var a = dateformatter.dateFromString(dateField.text!)
        
        //game.gameDate = a!
        
    }
    
    
}


