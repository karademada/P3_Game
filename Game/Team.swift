//
//  Team.swift
//  Game
//
//  Created by Christophe Lazantsy on 25/02/2022.
//

import Foundation


class Team {
    var name: String?
    var teamCharacters: [Character] = []
    var description: String {
        var t:String=""
        for i in teamCharacters {
            t =  "\(i.currentChar?.name ?? ""), \(i.currentChar?.life ?? 0), \(i.currentChar?.weapon ?? 0), \(i.currentChar?.heal ?? 0)"
        }
        return t
    }
    
    init(name: String){
        self.name = name
        
    }
    
    func addCharacter(charType: CharacterType, name: String){
        let newCharacter = Character(type: charType, name: name)
        teamCharacters.append( newCharacter  )
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
}
