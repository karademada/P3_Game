//
//  File.swift
//  Game
//
//  Created by Christophe Lazantsy on 25/02/2022.
//

import Foundation

class Player {
    var team: Team?
    var playerName: String
    var description: String {
        guard let team = team?.description else {
            return "team is Null"
        }
        return team.description
    }
    
    init(playerName: String){
        self.playerName = playerName
    }
    
    
    
    func chooseCharacter(type: CharacterType, name: String) -> Character {
        
        return Character(type: .warrior, name: name)
    }
    
    func attack(name: String) {
        
    }
    
    func heal(name: String) {
        
    }
}
