//
//  Type.swift
//  Game
//
//  Created by Christophe Lazantsy on 25/02/2022.
//

import Foundation

class TypeChar {
    var life: Int?
    var weapon: Int?
    var heal: Int?
    init(life: Int, weapon: Int, heal: Int){
        self.life = life
        self.weapon = weapon
        self.heal = heal
    }
}
