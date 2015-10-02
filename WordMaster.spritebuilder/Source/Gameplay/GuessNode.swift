//
//  GuessNode.swift
//  WordMaster
//
//  Created by Andrew Brandt on 9/29/15.
//  Copyright © 2015 Dory Studios. All rights reserved.
//

import Foundation

class GuessNode: CCNode {

    var guess: Guess?
    var count: Int = -1
    
    var guessLabel: CCLabelTTF!
    var countLabel: CCLabelTTF!
    var countImage: CCSprite!
    
    var redParticle: CCParticleSystem!
    
    override func onEnter() {
        super.onEnter()
        
        if let guess = guess {
            guessLabel.string = guess.string!
            
            let countString = "\(count)"
            countLabel.string = countString
        }
        
    }
    
    func startRed() {
        redParticle.resetSystem()
    }
    
    

}