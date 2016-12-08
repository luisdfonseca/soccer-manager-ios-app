//
//  Stat+CoreDataProperties.swift
//  Soccer-App
//
//  Created by luis Fonseca on 12/8/16.
//  Copyright © 2016 luis daniel fonseca. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Stat {

    @NSManaged var goals: NSNumber?
    @NSManaged var oGoals: NSNumber?
    @NSManaged var shots: NSNumber?
    @NSManaged var oShots: NSNumber?
    @NSManaged var cards: NSNumber?
    @NSManaged var oCards: NSNumber?
    @NSManaged var fouls: NSNumber?
    @NSManaged var oFouls: NSNumber?
    @NSManaged var name: String?
    @NSManaged var notes: String?

}
