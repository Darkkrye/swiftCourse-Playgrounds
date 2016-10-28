//: Playground - noun: a place where people can play

import UIKit

extension Int {
    
    func magic() -> Int {
        return self + 3
    }
}

extension String {
    
    static func helloWorld() -> String {
        return "Hello World !"
    }
    
    func concat(str: String) -> String {
        return self + str
    }
}

var a = 5
a.magic()
print(a)
a = a.magic()
print(a)

let b = 678.magic().magic().magic()

let c = String.helloWorld()
print(c.concat(str: " ESGI !"))






// EXERCICE 1
// Dans un fichier String+CamelCase.swift
extension String {
    
    func camelCase() -> String {
        
        let components = self.components(separatedBy: " ")
        var result = ""
        for (idx, component) in components.enumerated() {
            if idx != 0 {
                result += component.capitalized
            } else {
                result += component
            }
        }
        
        return result
    }
}

"hello world esgi".camelCase()


// EXERCICE 2
extension Int {
    func toRadians() -> Double {
        return Double(self) * .pi / 180
    }
}
let myInt = 75
print(myInt.toRadians())

// EXERCICE 3
extension Double {
    func toDegrees() -> Int {
        return Int(Double(self) * 180 / .pi)
    }
}
print(myInt.toRadians().toDegrees())