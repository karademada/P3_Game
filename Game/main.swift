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
    let labelInfos = ["start":"Game is start", "fight":"Fight is start","over":"Game is over", "team":"Compose team", "player":"Choose player team"]
    
    init(start: Bool) {
        // Init all players
        // ask to create a team and then choose 3 characters
        // display informations
        // start game
        self.isGame = start
        self.players.append(Player(playerName: "Christophe"))
        self.players.append(Player(playerName: "Stephane"))
        
        
        self.players.forEach{ player in
            print("ENTER A NAME FOR THE TEAM")
            if let teamName = readLine() {
                player.team = Team(name: teamName)
                print("A team name \(teamName) is created ")
            }
            guard let _ = player.team else {
                return
            }
            
            
            // do until 3 characters are set
            //while team1.teamCharacters.count < 4 {
            
            func getName()-> String{
                print("SET NAME FOR CHARACTER TYPE")
                
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
            
            func addCharacterIfNotExist(choice: String, name: String, currentTeam: Team)-> Bool {
                switch choice {
                case "1": return  currentTeam.checkInputCharAreValid(charType: CharacterType.warrior, name: name)
                case "2": return currentTeam.checkInputCharAreValid(charType: CharacterType.magnus, name: name)
                case "3": return currentTeam.checkInputCharAreValid(charType: CharacterType.colossus, name: name)
                case "4": return currentTeam.checkInputCharAreValid(charType: CharacterType.dwarf, name: name)
                default: return false
                }
            }
            
            
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
                    1. warrior
                    2. magnus
                    3. colossus
                    4. dwarf
                    """)
                    
                    print("CHOOSE TYPE IN THE LIST")
                    
                    if let choice = readLine() {
                        
                        let nameChar = getName()
                        
                        let isExist = addCharacterIfNotExist(choice: choice, name: nameChar, currentTeam: currentTeam)
                        
                        if(isExist){
                            print("Character name and type allready in the list")
                        } else {
                            switch choice {
                            case "1":  currentTeam.addCharacter(charType: CharacterType.warrior, name: nameChar)
                            case "2": currentTeam.addCharacter(charType: CharacterType.magnus, name: nameChar)
                            case "3": currentTeam.addCharacter(charType: CharacterType.colossus, name: nameChar)
                            case "4": currentTeam.addCharacter(charType: CharacterType.dwarf, name: nameChar)
                            default:
                                print("Character not exist")
                            }
                        }
                    }
                } // end choice
            }
        }
        playerTeamCharacters()
        
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
            print("\(lists) in his team ")
        }
    }
    
    func chooseCharacterMyTeam()->Character{
        var myCharPlay: Character?
        var charFound:Bool = true
        
        print("\(players[0].playerName) is got ")
        let currentTeam = players[0].team! as Team
        
        currentTeam.teamCharacters.enumerated().forEach{(index, Character) in
            print("\(index). \(Character.name)")
        }
        print("CHOOSE TYPE IN THE LIST")
        while (charFound){
            if let choice = readLine() {
                if let choiceInt = Int(choice),
                   choiceInt < currentTeam.teamCharacters.count {
                    myCharPlay = currentTeam.teamCharacters[choiceInt]
                    charFound = false
                } else {
                    print("value non correct")
                    
                }
            }
        }
        
        guard let myChar = myCharPlay else {
            return  currentTeam.teamCharacters[0]
        }
        return myChar
        
    }
    
    func enemyCharacterMyTeam()->Character{
        var myCharPlay: Character?
        var charFound:Bool = true
        
        print("\(players[1].playerName) is got ")
        let currentTeam = players[1].team! as Team
        
        currentTeam.teamCharacters.enumerated().forEach{(index, Character) in
            print("\(index). \(Character.name)")
        }
        print("CHOOSE TYPE IN THE LIST")
        while (charFound){
            if let choice = readLine() {
                if let choiceInt = Int(choice),
                   choiceInt < currentTeam.teamCharacters.count {
                    myCharPlay = currentTeam.teamCharacters[choiceInt]
                    charFound = false
                } else {
                    print("value non correct")
                    
                }
            }
        }
        
        guard let myChar = myCharPlay else {
            return  currentTeam.teamCharacters[0]
        }
        return myChar
        
    }
    
    func round(player: Player){
        print("round")
    }
    
    func listAction(charPlayer: Character, heal: Int){
        
        if heal == 10 {
            print("name : \(charPlayer.name) type : \(charPlayer.type) can Heal")
            print("""
            Choose to heal or attack
            1. heal
            2. attack
            """)
            print("CHOOSE AN ACTION IN THE LIST")
            if let charAction = readLine(){
                if let charActionInt = Int(charAction),
                   charActionInt > 0 || charActionInt < 3 {
                    print(charActionInt)
                    if(charActionInt == 1 ) {
                        charPlayer.isHeal = true
                    }
                    else if(charActionInt == 2){
                        charPlayer.isAttack = true
                    } else {
                        print("Action Don't exist")
                    }
                }
            }
        } else {
            print("name : \(charPlayer.name) type : \(charPlayer.type) can't Heal, SO attack!")
            charPlayer.isAttack = true
        }
        print("charPlayer isAttack \(charPlayer.isAttack)")
        print("charPlayer isHeal \(charPlayer.isHeal)")

    }
    
    func startFigth(){
        print(labelInfos["fight"]!)
        var myCharPlay: Character?
        var enemiCharPlay:Character?
        
        
        //while currentCharPlay != nil {
        // Game running
        
        print("is game ----------")
        
        // choose my character
        print("CHOOSE MY CHARACTER FOR THE GAME")
        
        myCharPlay = chooseCharacterMyTeam()
        
        guard let cP = myCharPlay else {
            return
        }
        print(cP.name)
        print(cP.type)
        guard let cC = cP.currentChar else {
            return
        }
        print(cC)
        print(cC.heal)
        guard let cCHeal = cC.heal else {
            return
        }
        print( cCHeal)
        
        listAction(charPlayer: cP, heal: cCHeal)
        
        // choose enemy character
        print("CHOOSE ENEMY CHARACTER FOR THE GAME")
        
        enemiCharPlay = enemyCharacterMyTeam()
        
        guard let cP1 = enemiCharPlay else {
            return
        }
        print(cP1.name)
        print(cP1.type)
        guard let cC1 = cP1.currentChar else {
            return
        }
        print(cC1)
        print(cC1.heal)
        guard let cCHeal1 = cC1.heal else {
            return
        }
        print( cCHeal1)
        
        listAction(charPlayer: cP1, heal: cCHeal1)
        
        
        print(labelInfos["over"])
    }
    
    
    func displayInfo(message: String){
        print(message)
    }
    
    func getPlayer(index: Int) -> Player {
        return players[index]
    }
}

var myGame = Game(start: true)
myGame.startFigth()

