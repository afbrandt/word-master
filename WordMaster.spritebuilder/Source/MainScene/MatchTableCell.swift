//
//  MatchTableCell
//  WordMaster
//
//  Created by Andrew Brandt on 8/22/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

class MatchTableCell: CCTableViewCell {
    
    var match: Match?
    
    //code connected elements
    var opponentName: CCLabelTTF!
    var opponentImage: CCSprite!
    var lastGuessLabel: CCLabelTTF!
    var playButton: CCButton!
    
    override func onEnter() {
        super.onEnter()
        
        configureCell()
        
//        opponentName.string = "Hello, cell!"
//        let background = CCNodeColor.nodeWithColor(CCColor.whiteColor(), width: 100.0, height: CELL_HEIGHT-10.0)
//        background.anchorPoint = ccp(0.5,0.5)
//        let deviceWidth = CCDirector.sharedDirector().viewSize().width
//        background.position = ccp(deviceWidth/2, CGFloat(CELL_HEIGHT)/2)
//        
//        addChild(background)
        
    }
    
    func configureCell() {
    
        if let match = match, let fromUser = match.fromUser, let toUser = match.toUser {
            
            //get opponent's name
            var opponentString = ""
            if PFUser.currentUser() == fromUser {
                //this user initiated the match
                opponentString = fromUser.username ?? "Anonymous"
            } else {
                //opponent initiated the match
                //opponentString = toUser.username ?? "Anonymous"
            }
            opponentName.string = opponentString
            
            //get last guess string
            var guessString = "Waiting for opponent!"
            if let guess = match.lastGuess, let owner = guess.owner, let string = guess.string {
                if PFUser.currentUser() == owner {
                    guessString = "You guessed \(string)"
                } else {
                    guessString = "They guessed \(string)"
                }
            }
            lastGuessLabel.string = guessString
            
        }
    
    }
    
}
