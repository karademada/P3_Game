//
//  File.swift
//  Game
//
//  Created by Christophe Lazantsy on 25/02/2022.
//

import Foundation

class Player {
    var team: Team?
    let playerName: String
    var description: String {
        guard let team = team?.description else {
            return "team is Null"
        }
        return team.description
    }
    
    init(playerName: String){
        self.playerName = playerName
    }
    
    func printTeamMember(){
        
        guard let team = self.team else {
            return
        }
        guard let teamName = team.name else {
            return
        }
        print("Team \(teamName) is composed of")
        team.teamCharacters.enumerated().forEach{(index, character) in
            guard let chLife = character.currentChar?.life else {
                return
            }
            
            guard let chWeapon = character.currentChar?.weapon else {
                return
            }
           
            if(character.type == .magnus){
                guard let chHeal = character.currentChar?.heal else {
                    return
                }
                print("\(index). \(character.name)  life : \(chLife) weapon : \(chWeapon) heal : \(chHeal) ")

            }else{
                print("\(index). \(character.name)  life : \(chLife) weapon : \(chWeapon) ")

            }
        }
    }
    
    func printStats(){
        guard let currentTeam = self.team else {
            return
        }
        
        guard let teamName = currentTeam.name else {
            return
        }
        print("Team \(teamName) is composed of")
        currentTeam.teamCharacters.enumerated().forEach{(index, Character) in
            guard let chLife = Character.currentChar?.life else {
                return
            }
            print("\(index). name \(Character.name)  life : \(chLife) ")
        }
    }
    
    func chooseCharacterMyTeam()->Character{
        var myCharPlay: Character?
        var charFound:Bool = true
        
        print("\(self.playerName) team's is on the battlefield")
        let currentTeam = self.team!
        
        printTeamMember()
        
        print("CHOOSE TYPE IN THE LIST")
        while (charFound){
            if let choice = readLine() {
                if let choiceInt = Int(choice),
                   choiceInt < currentTeam.teamCharacters.count && currentTeam.teamCharacters[choiceInt].currentChar?.life ?? 0 > 0{
                    myCharPlay = currentTeam.teamCharacters[choiceInt]
                    charFound = false
                } else {
                    print("Value non correct or he is allready DEAD !!!")
                }
            }
        }
        
        guard let myChar = myCharPlay else {
            return  currentTeam.teamCharacters[0]
        }
        print("YOU CHOOSE \(myChar.name)")
        return myChar
    }
    
}
