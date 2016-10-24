//: Playground - noun: a place where people can play

import UIKit

// EXERCICE 1

class Document: NSObject {
    var num: UUID
    var title: String
    
    init(num: UUID, title: String) {
        self.num = num
        self.title = title
    }
    
    override var description: String {
        return "Num: \(self.num.uuidString) - Title: \(self.title)"
    }
}

class Book: Document {
    var author: String
    var pageNumber: Int
    
    init(num: UUID, title: String, author: String, pageNumber: Int) {
        self.author = author
        self.pageNumber = pageNumber
        
        super.init(num: num, title: title)
    }
    
    override var description: String {
        return super.description + ", Author: \(self.author) - Page Number: \(self.pageNumber)"
    }
}

class Dictionary: Document {
    var language: String
    
    init(num: UUID, title: String, language: String) {
        self.language = language
        
        super.init(num: num, title: title)
    }
    
    override var description: String {
        return super.description + ", Language: \(self.language)"
    }
}





// Bibliothèque
var library : [Document] = [Document]()

// Livres
let livre1 = Book(num: UUID(), title: "Mon livre 1", author: "Moi", pageNumber: 50)
let livre2 = Book(num: UUID(), title: "Mon livre 2", author: "Encore moi", pageNumber: 750)

// Dictionnaires
let dict1 = Dictionary(num: UUID(), title: "Le Petit Robert", language: "Français")
let dict2 = Dictionary(num: UUID(), title: "Larousse", language: "Français")

// Ajout
library.append(livre1)
library.append(livre2)

library.append(dict1)
library.append(dict2)

if let docA: Book = library[0] as? Book {
    print(docA)
}

if let docB: Dictionary = library[3] as? Dictionary {
    print(library[3])
}


// EXERCICE 2
class Pokemon: NSObject {
    var name: String
    var hp: Double
    var atk: Double
    
    init(name: String, hp: Double, atk: Double) {
        self.name = name
        self.hp = hp
        self.atk = atk
    }
    
    func isDead() -> Bool {
        return self.hp <= 0 ? true : false
    }
    
    func hit(p: Pokemon) {
        self.hit(p: p, efficiency: 1)
    }
    
    func hit(p: Pokemon, efficiency: Double?) {
        
        if let eff = efficiency {
            p.hp -= eff * self.atk
        } else {
            p.hp -= self.atk
        }
    }
    
    override var description: String {
        return "[Pokemon: \(self.name) - Remaining HP: \(self.hp) - Damage Point: \(self.atk)]"
    }
}

class FireP: Pokemon {
    
    override func hit(p: Pokemon) {
        if p is GrassP {
            super.hit(p: p, efficiency: 2)
        } else if p is WaterP {
            super.hit(p: p, efficiency: 0.5)
        } else {
            super.hit(p: p, efficiency: nil)
        }
    }
    
}

class WaterP: Pokemon {
    
    override func hit(p: Pokemon) {
        if p is FireP {
            super.hit(p: p, efficiency: 2)
        } else if p is GrassP {
            super.hit(p: p, efficiency: 0.5)
        } else {
            super.hit(p: p, efficiency: nil)
        }
    }
    
}

class GrassP: Pokemon {
    
    override func hit(p: Pokemon) {
        if p is WaterP {
            super.hit(p: p, efficiency: 2)
        } else if p is FireP {
            super.hit(p: p, efficiency: 0.5)
        } else {
            super.hit(p: p, efficiency: nil)
        }
    }
}

let pokemon1 = FireP(name: "Nom1", hp: 50, atk: 10)
let pokemon2 = GrassP(name: "Nom2", hp: 50, atk: 10)
let pokemon3 = FireP(name: "Nom3", hp: 50, atk: 10)

pokemon1.hit(p: pokemon2)
pokemon2.hit(p: pokemon1)
pokemon1.hit(p: pokemon3)

print(pokemon1)
print(pokemon2)
print(pokemon3)







// FIGHT
let p1 = FireP(name: "Dracaufeu", hp: 150, atk: 35)
let p2 = GrassP(name: "Florizarre", hp: 150, atk: 30)
let p3 = WaterP(name: "Tortank", hp: 150, atk: 33)
let p4 = FireP(name: "Ouisticram", hp: 45, atk: 10)

let equipe1: [Pokemon] = [p1, p2]
let equipe2: [Pokemon] = [p3, p4]

var game = true
var perdant: [Pokemon] = [Pokemon]()
while game {
    
    for i in 0...equipe1.count-1 {
        equipe1[i].hit(p: equipe2[i])
    }
    
    if equipe2[0].isDead() && equipe2[1].isDead() {
        perdant = equipe2
    } else if equipe1[0].isDead() && equipe1[1].isDead() {
        perdant = equipe1
    }
    
    for j in 0...equipe2.count-1 {
        equipe2[j].hit(p: equipe1[j])
    }
    
    if equipe2[0].isDead() && equipe2[1].isDead() {
        perdant = equipe2
        game = false
    } else if equipe1[0].isDead() && equipe1[1].isDead() {
        perdant = equipe1
        game = false
    }
    
}

print(perdant)