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
    var playButton: CCButton!
    
    override func onEnter() {
        super.onEnter()
        
        if let match = match, let fromUser = match.fromUser, let toUser = match.toUser {
            var opponentString = ""
            if PFUser.currentUser() == fromUser {
                //this user initiated the match
                //opponentString = fromUser.username!
            } else {
                //opponent initiated the match
                //opponentString = toUser.username ?? "Anonymous"
            }
        }
        
        if let match = match {
            opponentName.string = match["fromUserWord"] as! String
        }
        
        
//        opponentName.string = "Hello, cell!"
//        let background = CCNodeColor.nodeWithColor(CCColor.whiteColor(), width: 100.0, height: CELL_HEIGHT-10.0)
//        background.anchorPoint = ccp(0.5,0.5)
//        let deviceWidth = CCDirector.sharedDirector().viewSize().width
//        background.position = ccp(deviceWidth/2, CGFloat(CELL_HEIGHT)/2)
//        
//        addChild(background)
        
    }
    
}
