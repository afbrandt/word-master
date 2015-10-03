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
    var blueParticle: CCParticleSystem!
    var greenParticle: CCParticleSystem!
    var purpleParticle: CCParticleSystem!
    var yellowParticle: CCParticleSystem!
    
    
    override func onEnter() {
        super.onEnter()
        
        if let guess = guess {
            guessLabel.string = guess.string!
            
            let countString = "\(count)"
            countLabel.string = countString
        }
        
    }
    
    func startRed() {
        redParticle.visible = true
        redParticle.resetSystem()
    }
    
    func startBlue() {
        blueParticle.visible = true
        blueParticle.resetSystem()
    }

    func startGreen() {
        greenParticle.visible = true
        greenParticle.resetSystem()
    }
    
    func startPurple() {
        purpleParticle.visible = true
        purpleParticle.resetSystem()
    }
    
    func startYellow() {
        yellowParticle.visible = true
        yellowParticle.resetSystem()
    }
}