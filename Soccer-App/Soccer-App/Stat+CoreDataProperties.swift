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

    @NSManaged var goals: String?
    @NSManaged var oGoals: String?
    @NSManaged var shots: String?
    @NSManaged var oShots: String?
    @NSManaged var cards: String?
    @NSManaged var oCards: String?
    @NSManaged var fouls: String?
    @NSManaged var oFouls: String?
    @NSManaged var name: String?
    @NSManaged var notes: String?

}
