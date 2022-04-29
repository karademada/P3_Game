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
    
    func printTeamMember(team: Team){
        
        guard let teamName = team.name else {
            return
        }
        print("Team \(teamName) is composed of")
        team.teamCharacters.enumerated().forEach{(index, Character) in
            print("\(index). \(Character.name)")
        }
    }
    
    func chooseCharacterMyTeam()->Character{
        var myCharPlay: Character?
        var charFound:Bool = true
        
        print("\(self.playerName) team's")
        let currentTeam = self.team! as Team
        
        printTeamMember(team: currentTeam)
        
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
        return myChar
        
    }
    
    func attack(name: String) {
        
    }
    
    func heal(name: String) {
        
    }
}
