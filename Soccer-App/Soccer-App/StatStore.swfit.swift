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
    let gameStore = GameDatabase.sharedInstance
    
    var stats = [Stat]()
    
    var gamesWon = Int()
    var gamesLost = Int()
    var gamesDraw = Int()
    var goalsScored = Double()
    var shots = Double()
    var goalsReceived = Double()

    
    init() {
        fillStatView()
    }
    
    func fillStatView(){
        
        saveStat(2, oGoals: 2, fouls: 2, oFouls: 2, shots: 2, oShots: 2, cards: 2,
                 oCards: 2, name: "Doral", notes: "good game" )
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
    
    
    func saveStat(goals: Int, oGoals: Int, fouls: Int, oFouls: Int, shots: Int, oShots: Int,
                  cards: Int, oCards: Int, name: String, notes: String)
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
    
    func getGamesPlayed() -> Int {
        return stats.count
    }
    
    func updateData() {
        gamesWon = 0
        gamesDraw = 0
        gamesLost = 0
        
        goalsScored = 0
        goalsReceived = 0
        shots = 0
        
        for stat in stats{
            if Int(stat.goals!) > Int(stat.oGoals!) {
                gamesWon += 1
            } else if Int(stat.goals!) < Int(stat.oGoals!) {
                gamesLost += 1
            }else{
                gamesDraw += 1
            }
            
            goalsScored += Double(stat.goals!)
            shots += Double(stat.shots!)
            goalsReceived += Double(stat.oGoals!)
            
        }
    }
    
    func getGamesWon() -> String {
        return String(gamesWon)
    }
    
    func getGamesLost() -> String {
            return String(gamesLost)
    }
    
    func getGamesDraw() -> String {
        return String(gamesDraw)
    }
    
    func getAverageGoalsScored()-> String {
        return String(goalsScored/Double(stats.count))
    }
    
    func getAverageShots()-> String {
        return String(shots/Double(stats.count))
    }
    
    func getAverageGoalsRecieved()-> String {
        return String(goalsReceived/Double(stats.count))
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
