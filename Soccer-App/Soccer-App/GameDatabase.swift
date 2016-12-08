//
//  GamesDatabase.swift
//  Soccer-App
//
//  Created by luis Fonseca on 11/30/16.
//  Copyright © 2016 luis daniel fonseca. All rights reserved.
//

import UIKit
import CoreData

final class GameDatabase {
    
    static let sharedInstance = GameDatabase()
    
    var games = [Game]()

    init() {
       // fillGameView()
    }
    
    func fillGameView(){
        saveGame("Doral United", address: "doral park", date: NSDate())
        saveGame("Doral ", address: "park", date: NSDate())
        
    }
    
    func fetchAllGames(){
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
    }
    

    func saveGame(name: String, address: String, date: NSDate)
    {
        let appDelegate    = UIApplication.sharedApplication().delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
       
        let game = NSEntityDescription.insertNewObjectForEntityForName("Game", inManagedObjectContext: managedContext) as! Game

        
        game.setValue(name, forKey: "name")
        game.setValue(address, forKey: "address")
        game.setValue(date, forKey: "date")
        
        do
        {
            try managedContext.save()
        }
        catch
        {
            print("There is some error.")
        }
        
        games.append(game)
        sortGames()
    }
    
    
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
    }
    
}