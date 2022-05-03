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
    var name:String
    var currentChar: TypeChar?
    var type: CharacterType
    var isAttack = false
    var isHeal = false
    
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
}

class Warrior: TypeChar {
    init(){
        super.init(
            life: 100,
            weapon: 100,
            heal: 0
        )
    }
}

class Magnus: TypeChar {
    init(){
        super.init(
            life: 200,
            weapon: 50,
            heal: 10
        )
    }
}

class Colossus: TypeChar {
    init(){
        super.init(
            life: 200,
            weapon: 50,
            heal: 0
        )
    }
    
}

class Dawrf: TypeChar {
    init(){
        super.init(
            life: 50,
            weapon: 50,
            heal: 0
        )
    }
    
}
