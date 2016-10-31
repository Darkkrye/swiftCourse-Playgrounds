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
    
    func toString() -> String
}

class Gun: NSObject, IWeapon {
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
    
    func toString() -> String {
        return "[Gun - Name: \(self.name) - Height: \(self.height) - Width: \(self.width) - Weight: \(self.weight) - Price: \(self.price) - Bullets: \(self.bullets)]"
    }
}

class ClassicGun: Gun {
    
    init() {
        super.init(name: "Classic Gun", height: 5, width: 6, weight: 10, price: 100, bullets: 5)
    }
    
    override init(name: String, height: Double, width: Double, weight: Double, price: Double, bullets: Int) {
        super.init(name: name, height: height, width: width, weight: weight, price: price, bullets: bullets)
    }
    
    override func bonus() -> Double {
        return super.bonus() * 1.30
    }
    
    override func toString() -> String {
        return "[Classic Gun - Name: \(self.name) - Height: \(self.height) - Width: \(self.width) - Weight: \(self.weight) - Price: \(self.price) - Bullets: \(self.bullets)]"
    }
}

class Sword: NSObject, IWeapon {
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
    
    func toString() -> String {
        return "[Sword - Name: \(self.name) - Height: \(self.height) - Width: \(self.width) - Weight: \(self.weight) - Price: \(self.price) - isLegendary: \(self.isLegendary) - Year: \(self.year)]"
    }
}

class Excalibur: Sword {
    
    init(name: String, height: Double, width: Double, weight: Double, price: Double, year: Int) {
        super.init(name: name, height: height, width: width, weight: weight, price: price, legendary: true, year: year)
    }
    
    override func bonus() -> Double {
        return super.bonus() * 1.30
    }
    
    override func toString() -> String {
        return "[Excalibur - Name: \(self.name) - Height: \(self.height) - Width: \(self.width) - Weight: \(self.weight) - Price: \(self.price) - isLegendary: \(self.isLegendary) - Year: \(self.year)]"
    }
}

class Character: NSObject {
    var name: String
    var health: Double
    var hitChance: Double
    var weapon: IWeapon
    
    var currentBullets = 0
    
    init(name: String, weapon: IWeapon) {
        self.name = name
        self.health = 25000
        self.hitChance = Double(Int(arc4random_uniform(70 - 50)) + 50)
        self.weapon = weapon
        
        if let weapon: Gun = self.weapon as? Gun {
            self.currentBullets = weapon.bullets
        }
    }
    
    func protect(attackValue: Double) {
        self.health -= attackValue / 1.55
    }
    
    func attack(c: Character) {
        let dam = (self.weapon.damage() * 1.13)
        let chance = Double(arc4random_uniform(100))
        
        if chance < self.hitChance {
            
            if let _: Gun = self.weapon as? Gun {
                if self.currentBullets > 0 {
                    self.currentBullets -= 1
                    c.protect(attackValue: dam)
                } else {
                    // Use gun grip
                    c.protect(attackValue: dam / 1.5)
                }
            } else {
                c.protect(attackValue: dam)
            }
            
            //c.protect(attackValue: dam)
        }
    }
    
    func isDead() -> Bool {
        return self.health < 1
    }
    
    override var description: String {
        if let _: Gun = self.weapon as? Gun {
            return "[Name: \(self.name) - Remaining health: \(round(1000 * self.health)/1000) - Remaining Bullets: \(self.currentBullets) - Weapon: \(self.weapon.toString())]"
        } else {
            return "[Name: \(self.name) - Remaining health: \(round(1000 * self.health)/1000) - Weapon: \(self.weapon.toString())]"
        }
    }
}

class Battle {
    var characters: [Character]
    var winner: Character?
    var deadPeople: [Character] = [Character]()
    
    init(characters: [Character]) {
        self.characters = characters
    }
    
    func fight() {
        if self.characters.count < 1 {
            print("You cannot start a battle with no character. Please set at least 2 characters.")
            return
        }
        
        var idx = 1
        
        while idx < self.characters.count {
            // Select fighter
            let fighter = self.getRandom(differentFrom: nil)
            // Select defender
            let defender = self.getRandom(differentFrom: fighter)
            
            fighter.attack(c: defender)
            if defender.isDead() {
                deadPeople.append(defender)
                print("    \(defender.name) is Dead")
                idx += 1
            }
        }
        
        for character in self.characters {
            if !self.deadPeople.contains(character) {
                self.saveWinner(w: character)
                break
            }
        }
    }
    
    private func saveWinner(w: Character) {
        self.winner = w
        
        print("The Winner is \(self.winner!) \n")
    }
    
    private func getRandom(differentFrom c: Character?) -> Character {
        var char = self.characters[Int(arc4random_uniform(UInt32(self.characters.count)))]
        
        if let passedChar = c {
            while self.deadPeople.contains(char) || char.isEqual(passedChar) {
                char = self.characters[Int(arc4random_uniform(UInt32(self.characters.count)))]
            }
            
            return char
        } else {
            while deadPeople.contains(char) {
                char = self.characters[Int(arc4random_uniform(UInt32(self.characters.count)))]
            }
            
            return char
        }
    }
}

// Character preparation
let c1 = Character(name: "Hero 1", weapon: Excalibur(name: "Excalibur", height: 20, width: 20, weight: 20, price: 1000, year: 1))
let c2 = Character(name: "Hero 2", weapon: Sword(name: "Sword1", height: 10, width: 10, weight: 10, price: 50, legendary: false, year: 5))
let c3 = Character(name: "Hero 3", weapon: Gun(name: "Gun1", height: 5, width: 5, weight: 5, price: 100, bullets: 6))
let c4 = Character(name: "Hero 4", weapon: Gun(name: "Gun2", height: 7, width: 7, weight: 5.5, price: 500, bullets: 20))
let group1 = [c1, c2, c3, c4]

let c5 = Character(name: "Hero 5", weapon: ClassicGun())
let c6 = Character(name: "Hero 6", weapon: Sword(name: "Sword1", height: 10, width: 10, weight: 10, price: 50, legendary: true, year: 5))
let c7 = Character(name: "Hero 7", weapon: Gun(name: "Gun1", height: 5, width: 5, weight: 5, price: 100, bullets: 6))
let c8 = Character(name: "Hero 8", weapon: Gun(name: "Gun2", height: 4, width: 8, weight: 10, price: 500, bullets: 20))
let group2 = [c5, c6, c7, c8]

let c9 = Character(name: "Hero 9", weapon: Excalibur(name: "Excalibur", height: 25, width: 15, weight: 12, price: 1000, year: 3))
let c10 = Character(name: "Hero 10", weapon: Sword(name: "Sword1", height: 10, width: 10, weight: 10, price: 50, legendary: false, year: 5))
let c11 = Character(name: "Hero 11", weapon: ClassicGun())
let c12 = Character(name: "Hero 12", weapon: Gun(name: "Gun2", height: 7, width: 8, weight: 4, price: 500, bullets: 20))
let group3 = [c9, c10, c11, c12]

let c13 = Character(name: "Hero 13", weapon: Excalibur(name: "Excalibur", height: 30, width: 30, weight: 10, price: 10000, year: 2))
let c14 = Character(name: "Hero 14", weapon: Sword(name: "Sword1", height: 12, width: 15, weight: 20, price: 42, legendary: true, year: 5))
let c15 = Character(name: "Hero 15", weapon: Gun(name: "Gun1", height: 5, width: 5, weight: 5, price: 100, bullets: 6))
let c16 = Character(name: "Hero 16", weapon: Gun(name: "Gun2", height: 5, width: 7, weight: 6, price: 500, bullets: 20))
let group4 = [c13, c14, c15, c16]

let c17 = Character(name: "Hero 17", weapon: Excalibur(name: "Excalibur", height: 15, width: 15, weight: 15, price: 500, year: 1))
let c18 = Character(name: "Hero 18", weapon: Sword(name: "Sword1", height: 10, width: 10, weight: 10, price: 50, legendary: true, year: 5))
let group5 = [c17, c18]

// Tournament preparation
var tournament: [Battle] = [Battle]()

let battle1 = Battle(characters: group1)
let battle2 = Battle(characters: group2)
let battle3 = Battle(characters: group3)
let battle4 = Battle(characters: group4)
let battle5 = Battle(characters: group5)

tournament.append(battle1)
tournament.append(battle2)
tournament.append(battle3)
tournament.append(battle4)
tournament.append(battle5)

// Fights
battle1.fight()
battle2.fight()
battle3.fight()
battle4.fight()
battle5.fight()

// Final preparation
var winners = [Character]()
for battle in tournament {
    if let winner = battle.winner {
        winners.append(winner)
    }
}

// Final Battle
print(" ")
let finalBattle = Battle(characters: winners)
finalBattle.fight()