//
//  Game.swift
//  Game
//
//  Created by Christophe Lazantsy on 06/05/2022.
//

import Foundation
import Chalk // @mxcl ~> 0.3

class Game {
    static let numberMaxOfCharacter: Int = 3
    static  var listNames = [String]()
    var players = [Player]()
    var roundCount = 0
    
    let labelInfos = ["start":"## Game is start ##", "fight":"## Fight is start ##","over":"## Game is over ##", "team":"## Compose team ##", "player":"## Choose player team ##"]
    
    init() {
        print(labelInfos["start"]!)

        // Init all players
        // ask to create a team and then choose 3 characters
        // display informations
        // start game
        print(labelInfos["team"]!)
        
        for nbrCharacter in (1...2).reversed(){
            print("|ADD \(nbrCharacter) PLAYER\( nbrCharacter > 1 ? "S": "")| -> CHOOSE A NAME")
            if let name = readLine(){
                self.players.append(Player(playerName: name))
                print("Player name is \(name) \r\n")
            }
        }
        
        
        self.players.forEach {player in
            print("ENTER A NAME FOR THE TEAM OF \(player.playerName) \r\n")
            
            if let teamName = readLine() {
                player.team = Team(name: teamName)
                print("A team name \(teamName) was created \r\n")
            }
            guard let _ = player.team else {
                return
            }
            chooseCharacterToPlay(player: player)
        }
        printCharactersInTeam()
    }
    
    
    func chooseCharacterToPlay(player: Player){
        
        for _ in 1..<4 {
            guard  let currentTeam: Team = player.team else {
                return
            }
            
            while currentTeam.teamCharacters.count < Game.numberMaxOfCharacter {
                let count = Game.numberMaxOfCharacter - currentTeam.teamCharacters.count
                print("""
                CHOOSE \(count) CHARACTERS FOR PLAYER \(player.playerName)
                1. warrior life: 100, weapon: 100, heal: 0
                2. magnus life: 200, weapon: 50, heal: 10
                3. colossus life: 200, weapon: 50, heal: 0
                """)
                
                print("CHOOSE TYPE IN THE LIST")
                
                if let choice = readLine(){
                    if let choiceInt = Int(choice),
                       choiceInt > 0 || choiceInt < 4{
                        let nameChar = Character.getNameInput()

                        if(currentTeam.teamCharacters.count > 0){
                                                        
                            if(Team.checkInputCharAreValid(name: nameChar)){
                                print("Character name allready in the list")
                            } else {
                                switch choiceInt {
                                case 1:  currentTeam.addCharacter(charType: CharacterType.warrior, name: nameChar)
                                case 2: currentTeam.addCharacter(charType: CharacterType.magnus, name: nameChar)
                                case 3: currentTeam.addCharacter(charType: CharacterType.colossus, name: nameChar)
                                default:
                                    print("Character not exist")
                                }
                            }
                        } else {
                            // Firstime add a Character
                            currentTeam.addCharacter(charType: CharacterType.warrior, name: nameChar)
                        }
                    } else {
                        print("Choose an Integer in the range 1 to 4 ")
                    }
                }
            } // end choice
        }
    }
    
    func printCharactersInTeam(){
        players.forEach{player in
            print("Player \(player.playerName) is got ")
            var currentTeam: Team
            guard  let curTeam: Team = player.team else {
                return
            }
            currentTeam = curTeam as Team
            var lists = ""
            currentTeam.teamCharacters.forEach{Character in
                lists += "\(Character.name) | "
            }
            print("\(lists) in his team \r\n")
        }
    }
    
    func round(player: Player, enemy: Player){
        var myCharPlay: Character?
        var enemyCharPlay: Character?
        
        // choose my character
        print("CHOOSE YOUR CHARACTER FOR THE GAME")
        
        myCharPlay = player.chooseCharacterMyTeam()
        
        guard let characterPlayer = myCharPlay else {
            return
        }
        
        guard let characterCurrent = characterPlayer.currentChar else {
            return
        }
        
        
        if(characterPlayer.isHeal  ){
            listAction(player: player, charPlayer: characterPlayer,enemyChar: nil, heal: characterCurrent.heal)
        } else {
            enemyCharPlay = enemy.chooseCharacterMyTeam()
            
            guard let enemyPlay = enemyCharPlay else {
                return
            }
            listAction(player: player, charPlayer: characterPlayer,enemyChar: enemyPlay, heal: characterCurrent.heal)
            
        }
        
        roundCount+=1
    }
    
    func listAction(player:Player, charPlayer: Character, enemyChar:Character?, heal: Int){
        
        if heal == 10 {
            print("name : \(charPlayer.name) type : \(charPlayer.type) can Heal")
            print("""
            CHOOSE TO heal OR attack
            1. heal
            2. attack
            """)
            print("CHOOSE AN ACTION IN THE LIST")
            if let charAction = readLine(){
                if let charActionInt = Int(charAction),
                   charActionInt > 0 || charActionInt < 3 {
                    print(charActionInt)
                    if(charActionInt == 1 ) {
                        charPlayer.healPeople(player: player )
                    }
                    else if(charActionInt == 2){
                        guard let enemyCharExist = enemyChar else {
                            return
                        }
                        enemyCharExist.isAttacking(player: charPlayer)
                    } else {
                        print("Action Don't exist")
                    }
                }
            }
        } else {
            print("name : \(charPlayer.name) type : \(charPlayer.type) can't Heal, SO attack!")
            //charPlayer.isAttack = true
            guard let enemyCharExist = enemyChar else {
                return
            }
            enemyCharExist.isAttacking(player: charPlayer)
        }
        
    }
    
    
    func checkAllDead()->Bool{
        guard let isdeadOne = players[0].team?.isAllDead() else {
            return false
        }
        
        guard let isdeadTwo = players[1].team?.isAllDead() else {
            return false
        }
        
        return isdeadOne || isdeadTwo
    }
    
    func startFigth(){
        print(labelInfos["fight"]!)
        
        while(!checkAllDead()){
            
            if(roundCount.isMultiple(of: 2)){
                print("Round \(roundCount) Current Player is \(players[0].playerName) \r\n")
                round(player: players[0],enemy: players[1])
            }  else {
                print("Round \(roundCount) Current Player is \(players[1].playerName) \r\n")
                round(player: players[1], enemy:players[0])
            }
        }
        
        print("Round \(roundCount) \r\n")
        players.forEach { player in
            player.printStats()
            guard let life = player.team?.teamTotalLife else {
                return
            }
            print("Team life's \(life)")
            
            if(life <= 0){
                print(" \(player.playerName) is Loose \r\n")
            }else {
                print(" \(player.playerName) is the Winner \r\n")
            }
        }
        print(labelInfos["over"]!)
    }
}
