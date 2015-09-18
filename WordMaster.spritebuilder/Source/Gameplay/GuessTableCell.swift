//
//  GuessTableCell.swift
//  WordMaster
//
//  Created by Andrew Brandt on 9/17/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import Foundation

class GuessTableCell: CCTableViewCell {

    var guess: Guess?
    
    //code connected elements
    var fromUserLabel: CCLabelTTF!
    var fromUserBubble: CCSprite!
    
    var toUserLabel: CCLabelTTF!
    var toUserBubble: CCSprite!
    
    override func onEnter() {
        
        super.onEnter()
        
        if let guess = guess {
            if guess.owner!.objectId == PFUser.currentUser()?.objectId {
                fromUserLabel.string = guess.string!
                toUserBubble.visible = false
            } else {
                toUserLabel.string = guess.string!
                fromUserBubble.visible = false
            }
        }
    
    }

}