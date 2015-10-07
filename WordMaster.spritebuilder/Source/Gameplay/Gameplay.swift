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
    var isSoloMatch: Bool = false
    
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
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("guess:"), name: WORD_BUILT, object: nil)
        
        if let match = match {
            let me = PFUser.currentUser()
            let arr = match.guesses
            
            
            
            for guess in arr {
                
                addGuess(guess)
//                let node = CCBReader.load("GuessNode") as! GuessNode
//                //let count = WordHelper.commonCharactersForGuess(guess.string, inMatch: match)
//                let count = 1
//                
//                node.guess = guess
//                node.count = count
//                
//                if guess.owner!.objectId == PFUser.currentUser()?.objectId {
//                    playerGuesses.addChild(node)
//                    print("added guess to player")
//                } else {
//                    opponentGuesses.addChild(node)
//                    print("added guess to opponent")
//                }
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
    
    override func onExit() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        Match.setDefaultsMatch(match!)
        Guess.setDefaultsGuesses(guesses)
        super.onExit()
    }
    
    func closeMatch() {
        CCDirector.sharedDirector().popScene()
    }
    
    func promptGuess() {
        
        animationManager.runAnimationsForSequenceNamed("ShowDialog")
        
        
    }
    
    func guess(message: NSNotification) {
        
        let string = message.object as! String
        let isValid = WordHelper.isWordValid(string)
        
        if isValid {
            
            let guess = Guess()
            guess.match = match
            guess.string = string
            guess.uploadGuess()
            addGuess(guess)
            
            
            if isSoloMatch {
                let word = WordHelper.randomWord()
                let guess = Guess()
                guess.match = match
                guess.string = word
                addGuess(guess)
            }
            
            animationManager.runAnimationsForSequenceNamed("HideDialog")
            
            print("user chose wisely...")
        } else {
            
        }
        
    }
    
    func addGuess(guess: Guess) {
        guesses.append(guess)
        let node = CCBReader.load("GuessNode") as! GuessNode

        guess.checkGuess()
        node.guess = guess
        
        if let player = PFUser.currentUser() {
            if player.madeGuess(guess) {
                playerGuesses.addChild(node)
            } else {
                opponentGuesses.addChild(node)
            }
        }
    }
    
}
