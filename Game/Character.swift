//
//  Character.swift
//  Game
//
//  Created by Christophe Lazantsy on 25/02/2022.
//

import Foundation


enum CharacterType{
    case warrior
    case magnus
    case colossus
    case dwarf
}


class Character {
//    var type: CharacterType
    var name=""
    var currentChar: TypeChar?
    
    init(type: CharacterType, name: String){
        switch type {
        case .warrior:
            currentChar = Warrior(name: name)
        case .magnus:
            currentChar = Magnus(name: name)
        case .colossus:
            currentChar = Colossus(name: name)
        case .dwarf:
            currentChar = Dawrf(name: name)
        }
    }
    
    func setName(name: String){
        self.name = name
    }
    
    func attack(){
        
    }
    
    func heal(){
        
    }
}

class Warrior: TypeChar {
    init(name: String){
        super.init(
            name: name,
            life: 100,
            weapon: 10,
            heal: 0
        )
    }
}

class Magnus: TypeChar {
    init(name: String){
        super.init(
            name: name,
            life: 200,
            weapon: 1,
            heal: 10
        )
    }
}

class Colossus: TypeChar {
    init(name: String){
        super.init(
            name: name,
            life: 200,
            weapon: 2,
            heal: 0
        )
    }

}

class Dawrf: TypeChar {
    init(name: String){
        super.init(
            name: name,
            life: 50,
            weapon: 20,
            heal: 0
        )
    }

}
