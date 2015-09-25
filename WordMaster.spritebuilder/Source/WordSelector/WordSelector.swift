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
    
    override func onEnter() {
        super.onEnter()
        
        clippingNode.stencil = clippingStencil
        clippingNode.alphaThreshold = 0.0
        
    }

}