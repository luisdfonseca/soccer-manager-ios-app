//
//  ViewController.swift
//  Soccer-App
//
//  Created by luis daniel fonseca on 11/26/16.
// varpyright © 2016 luis daniel fonseca. All rights reserved.
//

import UIKit

class StatDetailViewController: UIViewController {
    
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
    
    
    var stat: Stat!
    var indexPath: Int!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = stat.name
        goalsField.text = stat.goals?.stringValue
         oGoalsField.text = stat.oGoals?.stringValue
         shotsField.text = stat.shots?.stringValue
         oShotsField.text = stat.oShots?.stringValue
        cardsField.text = stat.cards?.stringValue
         oCardsField.text = stat.oCards?.stringValue
         foulsField.text = stat.fouls?.stringValue
         oFoulsField.text = stat.oFouls?.stringValue
         notesField.text = stat.notes
      
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        stat.name = nameField.text ?? ""
         stat.goals = Int(goalsField.text!)
         stat.oGoals = Int(oGoalsField.text!)
         stat.shots = Int(shotsField.text!)
        stat.oShots =  Int(oShotsField.text!)
        stat.cards = Int(cardsField.text!)
         stat.oCards = Int(oCardsField.text!)
        stat.fouls = Int(foulsField.text!)
        stat.oFouls =  Int(oFoulsField.text!)
         stat.notes = notesField.text!
    }
    
    @IBAction func deleteButtonPressed(sender: AnyObject) {
        store.removeStat(indexPath)
         self.navigationController?.popViewControllerAnimated(true)
        
    }
    
}
