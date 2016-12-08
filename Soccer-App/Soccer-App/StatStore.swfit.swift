//
//  GamesDatabase.swift
//  Soccer-App
//
//  Created by luis Fonseca on 11/30/16.
//  Copyright © 2016 luis daniel fonseca. All rights reserved.
//

import UIKit
import CoreData

final class StatStore {
    
    static let sharedInstance = StatStore()
    
    var stats = [Stat]()
    
    init() {
        fillStatView()
    }
    
    func fillStatView(){
        
        saveStat("Prueba", oGoals: "Prueba", fouls: "Prueba", oFouls: "Prueba", shots: "Prueba", oShots: "Prueba", cards: "Prueba",
                 oCards: "Prueba", name: "Doral", notes: "good game" )
    }
    
    
    
    /*func fetchAllGames(){
     let appDelegate    = UIApplication.sharedApplication().delegate as! AppDelegate
     let managedContext = appDelegate.managedObjectContext
     let fetchRequest   = NSFetchRequest(entityName: "Game")
     
     do
     {
     let fetchedResult = try managedContext.executeFetchRequest(fetchRequest) as? [Game]
     
     if let results = fetchedResult
     {
     games = results
     }
     else
     {
     print("Could not fetch result")
     }
     }
     catch
     {
     print("There is some error.")
     }
     sortGames()
     }*/
    
    
    func saveStat(goals: String, oGoals: String, fouls: String, oFouls: String, shots: String, oShots: String,
                  cards: String, oCards: String, name: String, notes: String)
    {
        let appDelegate    = UIApplication.sharedApplication().delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let stat = NSEntityDescription.insertNewObjectForEntityForName("Stat", inManagedObjectContext: managedContext) as! Stat
        
        stat.setValue(goals, forKey: "goals")
        stat.setValue(oGoals, forKey: "oGoals")
        stat.setValue(fouls, forKey: "fouls")
        stat.setValue(oFouls, forKey: "oFouls")
        stat.setValue(shots, forKey: "shots")
        stat.setValue(oShots, forKey: "oShots")
        stat.setValue(cards, forKey: "cards")
        stat.setValue(oCards, forKey: "oCards")
        stat.setValue(name, forKey: "name")
        stat.setValue(notes, forKey: "notes")
        
        
        do
        {
            try managedContext.save()
        }
        catch
        {
            print("There is some error.")
        }
        stats.append(stat)
        
    }
    
    /*
     func removeGame(atIndex: Int){
     let appDelegate    = UIApplication.sharedApplication().delegate as! AppDelegate
     let managedContext = appDelegate.managedObjectContext
     let objectToRemove = games[atIndex] as Game
     
     managedContext.deleteObject(objectToRemove)
     
     do
     {
     try managedContext.save()
     }
     catch
     {
     print("There is some error while updating CoreData.")
     }
     
     games.removeAtIndex(atIndex)
     sortGames()
     }
     
     func sortGames() {
     games.sortInPlace({$0.date.compare($1.date) == .OrderedAscending })
     }*/
    
}
