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
    let parseMgr = ParseHelper.sharedInstance
    
    //code connected elements
    var facebookButton: CCButton!
    var tableNode: CCTableView!
    
    var tableContainer: CCClippingNode!
    var tableStencil: CCNodeColor!
    
    var matches: [Match] = []
    
    override func onEnter() {
        super.onEnter()
        //let helper = MultiplayerMatchHelper.sharedInstance
        //helper.authenticationCheck()
        //let button = FBSDKLoginButton()
        //parseMgr.test()
        fbMgr.delegate = self
        parseMgr.delegate = self
        
        tableNode.dataSource = self
        
        tableNode.block = { (Void) in
            //println("selected cell \(self.tableNode.selectedRow)")
            let index = Int(self.tableNode.selectedRow)
            let count = Int(self.matches.count)
            if index == count {
                self.buildMatch()
            }
        }
        
        tableContainer.stencil = tableStencil
        tableContainer.alphaThreshold = 0.0
        
        if let user = PFUser.currentUser() {
            if PFFacebookUtils.isLinkedWithUser(user) {
                //happy path is here
                
                facebookButton.visible = false
                
                parseMgr.getMatchesForUser(user)
                
                //tableNode.reloadData()
                
                //let match = Match()
        
                //match.fromUserWord = "Hello, world number \(matches.count)"
                
                //match.uploadMatch()
                
                fbMgr.getCurrentUserFriends()
                
            } else {
                //user invalidated session in FB
            }
        } else {
            //new user path is here
        }
        
        userInteractionEnabled = true
        
    }
    
    func startLogin() {
        fbMgr.tryLoginViaParse()
    }
    
    func enterMatch() {
        println("enter an existing match")
    }
    
    func buildMatch() {
        println("create a new match")
    }
    
}


