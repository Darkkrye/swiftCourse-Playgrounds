//
//  Character.swift
//  TP2BattleCorrection
//
//  Created by Pierre on 15/11/2016.
//  Copyright © 2016 Pierre Boudon. All rights reserved.
//

import Foundation

open class Character: NSObject {
    
    public var name: String
    public var health: UInt
    public var hitChance: Int
    public var weapon: IWeapon
    
    init(n: String, h: UInt, w: IWeapon) {
        self.name = n
        self.health = h < 25000 ? 25000 : h
        self.hitChance = Int(arc4random_uniform(20)) + 50
        self.weapon = w
    }
    
    public func protect(attack: Double) {
        self.health -= UInt(attack * 0.45)
    }
    
    public func attack(c: Character) {
        if Int(arc4random_uniform(101)) > self.hitChance {
            c.protect(attack: self.weapon.damage() * 1.13)
        }
    }
    
    open override var description: String {
        return "[Character \(self.name) \(self.weapon) \(self.health) \(self.hitChance)]"
    }
}
