//
//  Stat.swift
//  Soccer-App
//
//  Created by luis Fonseca on 12/8/16.
//  Copyright © 2016 luis daniel fonseca. All rights reserved.
//

import Foundation
import CoreData


class Stat: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        // Give the properties their initial values
        goals = ""
        oGoals = ""
        shots = ""
        oShots = ""
        cards = ""
        oCards = ""
        fouls = ""
        oFouls = ""
        name = ""
        notes = ""
    }


}
