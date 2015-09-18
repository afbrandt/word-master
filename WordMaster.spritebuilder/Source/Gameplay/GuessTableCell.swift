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
    var guessLabel: CCLabelTTF!
    
    override func onEnter() {
        
        super.onEnter()
        
        if let guess = guess {
            guessLabel.string = guess.string!
        }
    
    }

}