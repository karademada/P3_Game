//
//  main.swift
//  Game
//
//  Created by Christophe Lazantsy on 24/02/2022.
//

import Foundation

extension Array where Element == Player {
    var description:String {
        var datas:String=""
        self.forEach{ player in
            datas += player.description
        }
        return datas
    }
}

class Game {
    
    var isGame = false;
    var score = Int()
    var players = [Player]()
    let labelInfos = ["start":"Game is start", "over":"Game is over", "team":"Compose team", "player":"Choose player team"]
    
    init(start: Bool) {
        // Init all players
        // ask to create a team and then choose 3 characters
        // display informations
        // start game
        self.isGame = start
        self.players.append(Player(playerName: "Christophe"))
        self.players.append(Player(playerName: "Stephane"))
        
        
        self.players.forEach{ player in
            print("Enter a name for the team")
            if let teamName = readLine() {
                player.team = Team(name: teamName)
            }
            if let team1: Team = player.team {
                print("Create a team name for this player \(player.playerName) and then choose 3 characters")

                
                // do until 3 characters are set
                //while team1.teamCharacters.count < 4 {
                
                for _ in 1..<4 {
                    
                    print("Set name for the character type")
                    var nameChar:String?
                    
                    while nameChar?.count ?? 0 < 3 {
                        
                        if let name = readLine(){
                            nameChar = name
                        }
                        
                        if let nameCharB = nameChar,
                           nameCharB.count < 3 {
                            print("name must longer than 3 ")
                        }
                    }
                    print("""
                        Choose 3 characters for  this player \(self.players[0].playerName)
                        1. warrior
                        2. magnus
                        3. colossus
                        4. dwarf
                        """)
                    
                    if let nameVerif = nameChar {
                        print("Choose a type in the list")
                        if let choice = readLine() {
                            switch choice {
                            case "1":  self.players[0].team?.addCharacter(charType: CharacterType.warrior, name: nameVerif)
                            case "2": self.players[0].team?.addCharacter(charType: CharacterType.magnus, name: nameVerif)
                            case "3": self.players[0].team?.addCharacter(charType: CharacterType.colossus, name: nameVerif)
                            case "4": self.players[0].team?.addCharacter(charType: CharacterType.dwarf, name: nameVerif)
                            default:
                                print("Character not exist")
                            }
                        }
                    }
                }
                print(players.description )
            }
        }
    }
    
    
    func displayInfo(message: String){
        print(message)
    }
    
    func getPlayer(index: Int) -> Player {
        return players[index]
    }
}
//
//func readName() -> String? {
//    print("Entrez le nom du Personnage:")
//    if let name = readLine() {
//        print("Mon nom est \(name)")
//    }
//}
var myGame = Game(start: true)
//myGame.displayInfo(message: "Game is Start")
//print(myGame.getPlayer(index: 0).playerName)
//print(myGame.getPlayer(index: 1).playerName)
