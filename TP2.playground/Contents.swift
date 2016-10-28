//: Playground - noun: a place where people can play

import UIKit
import Foundation

protocol IWeapon {
    var name: String { get set }
    var height: Double { get set }
    var width: Double { get set }
    var weight: Double { get set }
    var price: Double { get set }
    
    func duration() -> Double
    func damage() -> Double
    func bonus() -> Double
}

class Gun: IWeapon {
    var name: String
    var height: Double
    var width: Double
    var weight: Double
    var price: Double
    
    var bullets: Int
    
    init(name: String, height: Double, width: Double, weight: Double, price: Double, bullets: Int) {
        self.name = name
        self.height = height
        self.width = width
        self.weight = weight
        self.price = price
        self.bullets = bullets
    }
    
    
    func duration() -> Double {
        return price / self.weight * damage()
    }
    
    func damage() -> Double {
        return self.weight * (self.height * self.width) + bonus()
    }
    
    func bonus() -> Double {
        return (Double(self.bullets) * self.weight) / self.weight.truncatingRemainder(dividingBy: Double(self.bullets))
    }
}

class Sword: IWeapon {
    var name: String
    var height: Double
    var width: Double
    var weight: Double
    var price: Double
    
    var isLegendary: Bool
    var year: Int
    
    init(name: String, height: Double, width: Double, weight: Double, price: Double, legendary: Bool, year: Int) {
        self.name = name
        self.height = height
        self.width = width
        self.weight = weight
        self.price = price
        
        self.isLegendary = legendary
        self.year = year
    }
    
    func duration() -> Double {
        return (self.weight * Double(self.year)) / self.price
    }
    
    func damage() -> Double {
        let damage: Double = ((self.weight * self.height * self.width) + bonus()) / Double(self.year)
        
        if !self.isLegendary || self.duration() < 10 {
            return damage / 1.10
        }
        
        return damage
    }
    
    func bonus() -> Double {
        if self.isLegendary {
            return self.weight / Double(self.year)
        } else {
            return 0
        }
    }
}

class Excalibur: Sword {
    
    init(name: String, height: Double, width: Double, weight: Double, price: Double, year: Int) {
        super.init(name: name, height: height, width: width, weight: weight, price: price, legendary: true, year: year)
    }
    
    override func bonus() -> Double {
        return super.bonus() * 1.30
    }
}

class Character {
    var name: String
    var health: Double
    var hitChance: Double
    var weapon: IWeapon
    
    init(name: String, weapon: IWeapon) {
        self.name = name
        self.health = 25000
        self.hitChance = Double(Int(arc4random_uniform(70 - 50)) + 50)
        self.weapon = weapon
    }
    
    func protect(attackValue: Int) {
        self.health -= Double(attackValue) / 1.55
    }
    
    func attack(c: Character) {
        let dam = (self.weapon.damage() * 1.13)
        let chance = Double(arc4random_uniform(100))
        
        if chance < self.hitChance {
            c.health -= dam
        }
    }
}

class Battle {
    static let sharedInstance : Battle = {
        let instance = Battle(characters: [])
        return instance
    }()
    
    var characters: [Character]
    
    init(characters: [Character]) {
        self.characters = characters
    }
    
    func fight() -> Int {
        if self.characters.count > 0 {
            return 1
        }
        return 0
    }
}

Battle.sharedInstance.characters =  /*[Character]()*/ [Character(name: "Test", weapon: Excalibur(name: "Test", height: 12, width: 12, weight: 12, price: 12, year: 12))]
Battle.sharedInstance.fight()