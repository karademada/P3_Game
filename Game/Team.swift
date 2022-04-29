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
            t =  "\(i.name), \(i.currentChar?.life ?? 0), \(i.currentChar?.weapon ?? 0), \(i.currentChar?.heal ?? 0)"
        }
        return t
    }
    
    init(name: String){
        self.name = name
        
    }
    
    func addCharacter(charType: CharacterType, name: String){
        let newCharacter = Character(type: charType, name: name)        
        teamCharacters.append( newCharacter )
    }
    
    func checkInputCharAreValid(charType: CharacterType, name: String)-> Bool {
        for teamChar in teamCharacters {
            return teamChar.name == name || teamChar.type == charType
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
        print("total  \(total )")
        print("total > 0 \(total > 0)")
        return total > 0 
    }
}
