//
//  Person.swift
//  MyFirstSwiftProject
//
//  Created by Pierre on 24/10/2016.
//  Copyright © 2016 Pierre Boudon. All rights reserved.
//

import Cocoa

class Person: NSObject {
    var lastname: String
    var firstname: String
    var age: Int?
    
    convenience init(lastname: String, firstname: String) {
        self.init(lastname: lastname, firstname: firstname, age: nil)
    }
    
    init(lastname: String, firstname: String, age: Int?) {
        self.lastname = lastname
        self.firstname = firstname
        self.age = age
    }
    
    override var description: String {
        var desc = "[Person " + self.lastname + ", " + self.firstname
        if self.age != nil {
            // desc += ", " + String(self.age!)
            desc += ", \(self.age!)"
        }
        desc += "]"
        return desc
    }
    
    func isOld() -> Bool {
        if let age = self.age {
            return age > 50 ? true : false
        }
        return false
    }
}
