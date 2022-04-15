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
    var name:String
    var currentChar: TypeChar?
    var type: CharacterType
    
    init(type: CharacterType, name: String){
        self.name = name
        self.type = type
        
        switch type {
        case .warrior:
            currentChar = Warrior()
        case .magnus:
            currentChar = Magnus()
        case .colossus:
            currentChar = Colossus()
        case .dwarf:
            currentChar = Dawrf()
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
    init(){
        super.init(
            life: 100,
            weapon: 10,
            heal: 0
        )
    }
}

class Magnus: TypeChar {
    init(){
        super.init(
            life: 200,
            weapon: 1,
            heal: 10
        )
    }
}

class Colossus: TypeChar {
    init(){
        super.init(
            life: 200,
            weapon: 2,
            heal: 0
        )
    }

}

class Dawrf: TypeChar {
    init(){
        super.init(
            life: 50,
            weapon: 20,
            heal: 0
        )
    }

}
