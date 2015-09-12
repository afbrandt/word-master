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
    
    override func onEnter() {
        super.onEnter()
        
    }
    
    func closeMatch() {
        CCDirector.sharedDirector().popScene()
    }
    
}
