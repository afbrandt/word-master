//
//  MainScene.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/22/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import Foundation

class MainScene: CCNode {

    let fbMgr = FacebookHelper.sharedInstance
    
    override func onEnter() {
        super.onEnter()
        //let helper = MultiplayerMatchHelper.sharedInstance
        //helper.authenticationCheck()
        //let button = FBSDKLoginButton()
        
    }
    
    func startLogin() {
        fbMgr.tryLogin()
    }
    
}