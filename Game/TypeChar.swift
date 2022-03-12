//
//  Type.swift
//  Game
//
//  Created by Christophe Lazantsy on 25/02/2022.
//

import Foundation

class TypeChar {
    var name:String?
    var life: Int?
    var weapon: Int?
    var heal: Int?
    init(name: String, life: Int, weapon: Int, heal: Int){
        self.name =  name
        self.life = life
        self.weapon = weapon
        self.heal = heal
    }
}
