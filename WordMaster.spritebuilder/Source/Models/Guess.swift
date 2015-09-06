//
//  Guess.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/23/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import UIKit

class Guess: PFObject, PFSubclassing {

    var owner: PFUser?
    var string: String?

    static func parseClassName() -> String {
        return "Guess"
    }
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        
        dispatch_once(&onceToken) { () -> Void in
            super.registerSubclass()
        }
    }
}
