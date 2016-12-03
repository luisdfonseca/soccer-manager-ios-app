//
//  GamesDatabase.swift
//  Soccer-App
//
//  Created by luis Fonseca on 11/30/16.
//  Copyright © 2016 luis daniel fonseca. All rights reserved.
//

import UIKit

final class GamesDatabase {
    
    static let sharedInstance = GamesDatabase()
    
    var allGames = [Game]()
    
    init() {
        let gOne = Game(opponentName: "Doral United", address: "Doral, FL")
        let gTwo = Game(opponentName: "Doral United2", address: "Doral, FL")
        
        self.addGame(gOne)
        self.addGame(gTwo)
    }
    
    func addGame(newGame: Game){
        allGames.append(newGame)
    }
    
    func removeGame(g: Game){
        if let g = allGames.indexOf(g){
            allGames.removeAtIndex(g)
        }
    }
    
}