//
//  Sword.swift
//  TP2BattleCorrection
//
//  Created by Pierre on 15/11/2016.
//  Copyright © 2016 Pierre Boudon. All rights reserved.
//

import Foundation

open class Sword: NSObject, IWeapon {
    
    public var weight: Double
    public var height: Double
    public var width: Double
    public var name: String
    public var price: Double
    
    public var legendary: Bool {
        return false
    }
    public var year: Int
    
    init(w: Double, h: Double, wi: Double, n: String, p: Double, y: Int) {
        self.weight = w
        self.height = h
        self.width = wi
        self.name = n
        self.price = p
        self.year = y
        
        super.init()
    }
    
    public func duration() -> Double {
        if self.price != 0 {
            return (self.weight / Double(self.year)) / self.price
        }
        return 0
    }
    
    public func damage() -> Double {
        if self.year != 0 {
            var r = (self.weight * self.height * self.width + self.bonus()) / Double(self.year)
            if !self.legendary || self.year < 10 {
                r *= 0.9
            }
            return r
        }
        return 0
    }
    
    public func bonus() -> Double {
        if self.legendary && self.year > 0 {
            return self.weight / Double(self.year)
        }
        return 0
    }
    
    open override var description: String {
        return "[Sword \(self.name) \(self.price) \(self.legendary)]"
    }
}
