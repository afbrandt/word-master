//
//  Gameplay.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/22/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import GameKit

class Gameplay: CCNode {

    var match: Match?
    
    //code connected elements
    var tableNode: CCTableView!
    var tableContainer: CCClippingNode!
    var tableStencil: CCNodeColor!
    
    override func onEnter() {
        super.onEnter()
        
//        let guess = Guess()
//        guess.match = match
//        guess.string = "Hello peeps"
//        guess.uploadGuess()
        tableContainer.stencil = tableStencil
        tableContainer.alphaThreshold = 0.0
        
        tableNode.dataSource = self
        userInteractionEnabled = true

    }
    
    func closeMatch() {
        CCDirector.sharedDirector().popScene()
    }
    
}
