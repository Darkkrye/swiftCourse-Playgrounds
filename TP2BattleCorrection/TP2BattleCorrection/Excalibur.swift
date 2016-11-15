//
//  Excalibur.swift
//  TP2BattleCorrection
//
//  Created by Pierre on 15/11/2016.
//  Copyright © 2016 Pierre Boudon. All rights reserved.
//

import Cocoa

open class Excalibur: Sword {
    
    public override var legendary: Bool {
        return true
    }
    
    init(w: Double, h: Double, wi: Double, p: Double, y: Int) {
        super.init(w: w, h: h, wi: wi, n: "Excalibur", p: p, y: y)
    }
    
    public override func bonus() -> Double {
        return super.bonus() * 1.3
    }
}
