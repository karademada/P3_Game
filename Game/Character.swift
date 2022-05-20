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
                isHeal = true
        case .colossus:
            currentChar = Colossus()
        }
    }
    
    func setName(name: String){
        self.name = name
    }
    
    static func getNameInput()-> String{
        print("SET NAME FOR CHARACTER TYPE \r\n")
        
        var nameChar:String?
        while nameChar?.count ?? 0 < 3 {
            guard let name = readLine() else {
                return ""
            }
            nameChar = name
            if let nameCharB = nameChar,
               nameCharB.count < 3 {
                print("name must longer than 3 ")
            }
        }
        guard let nameCh = nameChar else {
            return ""
        }
        return nameCh
    }
    
    func healPeople(player:Player){
        
        print("CHOOSE WHO YOU WANT HEAL ?")
        let homieToHeal: Character  = player.chooseCharacterMyTeam()
        guard var homieCharLife = homieToHeal.currentChar?.life else {
            return
        }
        
        guard let myCharHeal = self.currentChar?.heal else {
            return
        }
        print("\(self.name) can heal : \(myCharHeal)")
        print("\(homieToHeal.name) life before getting heal : \(homieCharLife)")
        
        homieCharLife += myCharHeal
        
        print("\(homieToHeal.name) life after healing : \(homieCharLife)")
        homieToHeal.currentChar?.life = homieCharLife
    }
    
    func isAttacking(player: Character){
        
        guard let myCharWeapon = player.currentChar?.weapon else {
            return
        }
        
        guard var enemyCharLife = self.currentChar?.life else {
            return
        }
        
        
        print("\(player.name) will destroy : \(myCharWeapon) life point")
        print("\(self.name) life before getting attack : \(enemyCharLife)")
        
        enemyCharLife -= myCharWeapon
        print("\(self.name)  live after attack :", enemyCharLife)
        self.currentChar?.life = enemyCharLife
    }
}
