//
//  iWeapon.swift
//  TP2BattleCorrection
//
//  Created by Pierre on 15/11/2016.
//  Copyright © 2016 Pierre Boudon. All rights reserved.
//

import Foundation

public protocol IWeapon: NSObjectProtocol {
    var weight: Double { get set }
    var height: Double { get set }
    var width: Double { get set }
    var name: String { get set }
    var price: Double { get set }
    
    func duration() -> Double
    func damage() -> Double
    func bonus() -> Double
}
