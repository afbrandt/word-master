//
//  Match.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/23/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import UIKit

class Match: PFObject, PFSubclassing {

    //opponent FB image
    @NSManaged var imageFile: PFFile?
    
    var fromUser: PFUser?
    var toUser: PFUser?
    
    var fromUserWord: String?
    var toUserWord: String?
    
    var isCurrentUsersTurn: Bool = false
    
    var attempts: Int = 0
    
    var guesses: [Guess] = []
    
    static func parseClassName() -> String {
        return "Match"
    }
}
