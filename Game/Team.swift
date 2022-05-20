//
//  Team.swift
//  Game
//
//  Created by Christophe Lazantsy on 25/02/2022.
//

import Foundation


class Team {
    var name: String?
    var teamTotalLife = 0
    var teamCharacters: [Character] = []
    
    
    var description: String {
        var t:String=""
        for i in teamCharacters {
            t =  "\(i.name), \(i.currentChar?.life ?? 0), \(i.currentChar?.weapon ?? 0), \(i.currentChar?.heal ?? 0)"
        }
        return t
    }
    
    init(name: String){
        self.name = name
        
    }
    
    func addCharacter(charType: CharacterType, name: String){
        print("listNames before add \(Game.listNames)")
        if(!Team.checkInputCharAreValid(name: name)){
            let newCharacter = Character(type: charType, name: name)
            teamCharacters.append( newCharacter )
            Game.listNames.append(name)
        } else {
            print("Character name allready in the list")
        }
        
        
        
        print("listNames after add \(Game.listNames)")
    }
    
    static func checkInputCharAreValid(name: String)-> Bool {
        for nameChar in Game.listNames {
            print("nameChar : \(nameChar)")
            if(nameChar == name){
                return true
            }
        }
        
        return false
    }
    
    func getCharacter(name: String) -> Character{
        var currentChar: Character?
        for character in teamCharacters where character.name == name {
            if currentChar != nil {
                currentChar = character
            }
        }
        return currentChar!
    }
    
    
    func isAllDead()->Bool{
        var total = 0
        
        teamCharacters.enumerated().forEach{(index, character) in
            guard let life = character.currentChar?.life else {
                return
            }
            print("\(index). Player name \(character.name) life : \(life)")
            
            total += life
        }
        print("Team total life  \(total ) \r\n")
        teamTotalLife = total
        return total <= 0
    }
    
}
