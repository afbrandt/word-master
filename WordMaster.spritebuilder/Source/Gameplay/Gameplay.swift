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
    
    var guesses: [Guess] = []
    
    //code connected elements
    var tableNode: CCTableView!
    var tableContainer: CCClippingNode!
    var tableStencil: CCNodeColor!
    
    var playerContainer: CCNode!
    var playerNameLabel: CCLabelTTF!
    var playerBoard: CCNode!
    var playerGuesses: CCLayoutBox!
    
    var opponentContainer: CCNode!
    var opponentNameLabel: CCLabelTTF!
    var opponentBoard: CCNode!
    var opponentGuesses: CCLayoutBox!
    
    override func onEnter() {
        super.onEnter()
        
        
        if let match = match {
            let me = PFUser.currentUser()
            let arr = match.guesses
            
            
            
            for guess in arr {
                
                let node = CCBReader.load("GuessNode") as! GuessNode
                let count = WordHelper.commonCharactersForGuess(guess, inMatch: match)
                
                node.guess = guess
                node.count = count
                
                if guess.owner!.objectId == PFUser.currentUser()?.objectId {
                    playerGuesses.addChild(node)
                    print("added guess to player")
                } else {
                    opponentGuesses.addChild(node)
                    print("added guess to opponent")
                }
            }
        }
        
//        let guess = Guess()
//        guess.match = match
//        guess.string = "Hello peeps"
//        guess.uploadGuess()
        tableContainer.stencil = tableStencil
        tableContainer.alphaThreshold = 0.0
        
//        tableNode.dataSource = self
        userInteractionEnabled = true

    }
    
    func closeMatch() {
        CCDirector.sharedDirector().popScene()
    }
    
    func promptGuess() {
        
        
        
        let guess = Guess()
        guess.match = match
        guess.string = "WUTAT"
        guess.uploadGuess()
    }
    
}
