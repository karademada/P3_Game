//
//  Game.swift
//  Game
//
//  Created by Christophe Lazantsy on 06/05/2022.
//

import Foundation

class Game {
    var players = [Player]()
    var roundCount = 0
    
    let labelInfos = ["start":"Game is start", "fight":"Fight is start","over":"Game is over", "team":"Compose team", "player":"Choose player team"]
    
    init(start: Bool) {
        // Init all players
        // ask to create a team and then choose 3 characters
        // display informations
        // start game
        
        var nbrCharacter = 2
        
        while nbrCharacter > 0 {
            print("|ADD \(nbrCharacter) PLAYER\( nbrCharacter > 1 ? "S": "")| -> CHOOSE A NAME")
            if let name = readLine(){
                self.players.append(Player(playerName: name))
                print("Player name is \(name) \r\n")
                nbrCharacter -= 1
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
            chooseType(player: player)
        }
        playerTeamCharacters()
    }
    
    func addCharacterIfNotExist(choice: Int, name: String, currentTeam: Team)-> Bool {
        switch choice {
        case 1: return  currentTeam.checkInputCharAreValid(charType: CharacterType.warrior, name: name)
        case 2: return currentTeam.checkInputCharAreValid(charType: CharacterType.magnus, name: name)
        case 3: return currentTeam.checkInputCharAreValid(charType: CharacterType.colossus, name: name)
        case 4: return currentTeam.checkInputCharAreValid(charType: CharacterType.dwarf, name: name)
        default: return false
        }
    }
    
    func getName()-> String{
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
    
    func chooseType(player: Player){
        for _ in 1..<4 {
            var currentTeam: Team
            guard  let curTeam: Team = player.team else {
                return
            }
            currentTeam = curTeam as Team
            
            while currentTeam.teamCharacters.count < 3 {
                let count = 3 - currentTeam.teamCharacters.count
                print("""
                CHOOSE \(count) CHARACTERS FOR PLAYER \(player.playerName)
                1. warrior life: 100, weapon: 100, heal: 0
                2. magnus life: 200, weapon: 50, heal: 10
                3. colossus life: 200, weapon: 50, heal: 0
                4. dwarf life: 50, weapon: 50, heal: 0
                """)
                
                print("CHOOSE TYPE IN THE LIST")
                
                if let choice = readLine(){
                    if let choiceInt = Int(choice),
                       choiceInt > 0 || choiceInt < 5{
                        
                        let nameChar = getName()
                        
                        let isExist = addCharacterIfNotExist(choice: choiceInt, name: nameChar, currentTeam: currentTeam)
                        
                        if(isExist){
                            print("Character name and type allready in the list")
                        } else {
                            switch choiceInt {
                            case 1:  currentTeam.addCharacter(charType: CharacterType.warrior, name: nameChar)
                            case 2: currentTeam.addCharacter(charType: CharacterType.magnus, name: nameChar)
                            case 3: currentTeam.addCharacter(charType: CharacterType.colossus, name: nameChar)
                            case 4: currentTeam.addCharacter(charType: CharacterType.dwarf, name: nameChar)
                            default:
                                print("Character not exist")
                            }
                        }
                    } else {
                        print("Choose an Integer in the range 1 to 4 ")
                    }
                }
            } // end choice
        }
    }
    
    func playerTeamCharacters(){
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
        
        guard let cP = myCharPlay else {
            return
        }
        
        guard let cC = cP.currentChar else {
            return
        }
        
        enemyCharPlay = enemy.chooseCharacterMyTeam()
        
        guard let eP = enemyCharPlay else {
            return
        }
        
        
        listAction(player: player, charPlayer: cP,enemyChar: eP, heal: cC.heal)
        roundCount+=1
    }
    
    func listAction(player:Player, charPlayer: Character, enemyChar:Character, heal: Int){
        
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
                        healPeople(player: player, charPlayer )
                    }
                    else if(charActionInt == 2){
                        isAttacking(player: charPlayer, enemy: enemyChar)
                    } else {
                        print("Action Don't exist")
                    }
                }
            }
        } else {
            print("name : \(charPlayer.name) type : \(charPlayer.type) can't Heal, SO attack!")
            //charPlayer.isAttack = true
            isAttacking(player: charPlayer, enemy: enemyChar)
        }
        
    }
    
    func healPeople(player:Player, _ myCharPlay: Character? ){
        
        print("CHOOSE WHO YOU WANT HEAL")
        let homieToHeal: Character  = player.chooseCharacterMyTeam()
        guard var homieCharLife = homieToHeal.currentChar?.life else {
            return
        }
        
        guard let myCharHeal = myCharPlay?.currentChar?.heal else {
            return
        }
        print("\(homieToHeal.name) before heal : \(myCharHeal)")
        print("\(homieToHeal.name) life before heal : \(homieCharLife)")
        
        homieCharLife += myCharHeal
        
        print("\(homieToHeal.name) life after heal : \(homieCharLife)")
        homieToHeal.currentChar?.life = homieCharLife
    }
    
    func isAttacking(player: Character , enemy: Character){
        
        guard let myCharWeapon = player.currentChar?.weapon else {
            return
        }
        
        guard var enemyCharLife = enemy.currentChar?.life else {
            return
        }
        
        enemyCharLife -= myCharWeapon
        print("My enemy live after attack :", enemyCharLife)
        enemy.currentChar?.life = enemyCharLife
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
