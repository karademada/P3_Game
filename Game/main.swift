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



var myGame = Game(start: true)
myGame.startFigth()

