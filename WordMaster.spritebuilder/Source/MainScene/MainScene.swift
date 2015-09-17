//
//  MainScene.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/22/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import Foundation

let MATCH_BUILT = "Built a match!"

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
                
                //parseMgr.getMatchesForUser(user)
                refreshMatches()
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("buildWord:"), name: MATCH_BUILT, object: nil)
        
        
    }
    
    override func onExit() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        super.onExit()
    }
    
    func startLogin() {
        fbMgr.tryLoginViaParse()
    }
    
    func enterMatch(button: CCButton) {
        println("enter an existing match")
        
        if let index = button.name.toInt() {
        
            let gameplay = CCBReader.load("Gameplay") as! Gameplay
            let scene = CCScene()
            //let index = Int(tableNode.selectedRow)
            let match = matches[index]
            
            gameplay.match = match
            scene.addChild(gameplay)
            
    //        CCDirector.sharedDirector().replaceScene(scene)
            CCDirector.sharedDirector().pushScene(scene)
        }
    }
    
    func buildMatch() {
        println("create a new match")
        //target user
        ParseHelper.fetchRandomUsers
        { (var result: [AnyObject]?, error: NSError?) -> Void in
            if let error = error {
                println("something bad happened")
            }
            
            if let users = result as? [PFUser] {
                let count = users.count
                if count > 0 {
                    let match = Match()
                    let index = Int(arc4random()) % count
                    let user = users[index]
                    
                    match.toUser = user
                    //match.uploadMatch()
                    NSNotificationCenter.defaultCenter().postNotificationName(MATCH_BUILT, object: match)
                }
            } else {
                println("random user fetch came back with an unexpected result")
            }
        }
    }
    
    func buildWord(message: NSNotification) {
        
        if let match = message.object as? Match {
            promptWordInputForMatch(match)
        }
        
    }
    
    func promptWordInputForMatch(match: Match) {
        //TODO: gui deal that takes user input...
        insertWord("hello", toMatch: match)
    }
    
    func insertWord(word: String, toMatch match: Match) {
        if let existingWord = match.fromUserWord {
            //is an existing match, need opponent word
            match.toUserWord = word
            match.saveMatch()
            //start game, transition to gameplay
            
        } else {
            //newly created match, need match creator's word
            match.fromUserWord = word
            match.uploadMatch()
            //show new match in table
        }
        
    }
    
    func refreshMatches() {
        ParseHelper.fetchMatchesForUser(PFUser.currentUser()!)
        { (result: [AnyObject]?, error: NSError?) -> Void in
            if let matches = result as? [Match] {
                self.matches = matches
                self.tableNode.reloadData()
            }
        }
    }
    
}


