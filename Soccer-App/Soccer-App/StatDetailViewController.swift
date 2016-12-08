//
//  ViewController.swift
//  Soccer-App
//
//  Created by luis daniel fonseca on 11/26/16.
// varpyright © 2016 luis daniel fonseca. All rights reserved.
//

import UIKit

class StatDetailViewController: UIViewController {
    
    
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = stat.name
        goalsField.text = stat.goals
         oGoalsField.text = stat.oGoals
         shotsField.text = stat.shots
         oShotsField.text = stat.oShots
        cardsField.text = stat.cards
         oCardsField.text = stat.oCards
         foulsField.text = stat.fouls
         oFoulsField.text = stat.oFouls
         notesField.text = stat.notes
      
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        stat.name = nameField.text ?? ""
         stat.goals = goalsField.text!
         stat.oGoals = oGoalsField.text!
         stat.shots = shotsField.text!
        stat.oShots =  oShotsField.text!
        stat.cards = cardsField.text!
         stat.oCards = oCardsField.text!
        stat.fouls = foulsField.text!
        stat.oFouls =  oFoulsField.text!
         stat.notes = notesField.text!
    }
    
    
}
