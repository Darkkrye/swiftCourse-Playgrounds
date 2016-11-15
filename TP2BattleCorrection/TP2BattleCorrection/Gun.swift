//
//  Gun.swift
//  TP2BattleCorrection
//
//  Created by Pierre on 15/11/2016.
//  Copyright © 2016 Pierre Boudon. All rights reserved.
//

import Foundation

open class Gun: NSObject, IWeapon {
    
    public var weight: Double
    public var height: Double
    public var width: Double
    public var name: String
    public var price: Double
    public var bullets: Int
    
    init(w: Double, h: Double, wi: Double, n: String, p: Double, b: Int) {
        self.weight = w
        self.height = h
        self.width = wi
        self.name = n
        self.price = p
        self.bullets = b
        
        super.init()
    }
    
    public func duration() -> Double {
        if self.weight != 0 {
            return (self.price / self.weight) * self.damage()
        }
        return 0
    }
    
    public func damage() -> Double {
        if self.height == 0 || self.width == 0 || self.weight == 0 {
            return 0
        }
        return self.weight / (self.height * self.width) + self.bonus()
    }
    
    public func bonus() -> Double {
        let res = Int(self.weight) % self.bullets
        if res != 0 {
            return (Double(self.bullets) * self.weight) / Double(res)
        }
        return 0
    }
    
    open override var description: String {
        return "[Gun \(self.name) \(self.price)]"
    }
}
