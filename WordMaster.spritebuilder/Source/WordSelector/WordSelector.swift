//
//  WordSelector.swift
//  WordMaster
//
//  Created by Andrew Brandt on 9/20/15.
//  Copyright © 2015 Dory Studios. All rights reserved.
//

import Foundation

class WordSelector: CCNode {

    var letter1: LetterSelector!
    var letter2: LetterSelector!
    var letter3: LetterSelector!
    var letter4: LetterSelector!
    var letter5: LetterSelector!
    
    var clippingNode: CCClippingNode!
    var clippingStencil: CCNodeColor!
    var wordSubmitButton: CCButton!
    
    override func onEnter() {
        super.onEnter()
        
        clippingNode.stencil = clippingStencil
        clippingNode.alphaThreshold = 0.0
        
    }
    
    func buildWord() {
        let word = "\(letter1.currentLetter)\(letter2.currentLetter)\(letter3.currentLetter)\(letter4.currentLetter)\(letter5.currentLetter)"
        print("built word: \(word)")
        let valid = WordHelper.isWordValid(word)
        if valid {
            NSNotificationCenter.defaultCenter().postNotificationName(WORD_BUILT, object: word)
        } else {
            //tell user to pick another word
        }
    }

}