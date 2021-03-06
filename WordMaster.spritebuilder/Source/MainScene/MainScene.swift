//
//  MainScene.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/22/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import Foundation

let MATCH_BUILT = "Built a match!"
let MATCH_OFFLINE_KEY = "Penta Single Player"
let MATCH_HAS_ACTIVE_OFFLINE_KEY = "Active Single Player"
let WORD_BUILT = "Built a word!"

class MainScene: CCNode, MainScrollDelegate {

    let fbMgr = FacebookHelper.sharedInstance
    let parseMgr = ParseHelper.sharedInstance
    var mainScroll: MainScroll!
    
    var matches: [Match] = []
    var pendingMatch: Match?
    
    //code connected elements
    var facebookButton: CCButton!
    var tableNode: CCTableView!
    
    var tableContainer: CCClippingNode!
    var tableStencil: CCNodeColor!
    var textInputField: CCTextField!
    
    var scrollContainer: CCScrollView!
    var loadingContainer: CCNode!
    
    func didLoadFromCCB() {
//        mainScroll = CCBReader.load("MainScroll") as? MainScroll
//        scroll.contentNode = mainScroll
    }
    
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
        
//        tableStencil.
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("soloMatch"), name: MATCH_OFFLINE_KEY, object: nil)
        
        if let node = scrollContainer.contentNode as? MainScroll {
            mainScroll = node
            mainScroll.delegate = self
        }
        
        resizeScroll()
    }
    
    override func onExit() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        super.onExit()
    }
    
    func resizeScroll() {
//        if let node = scrollContainer.contentNode as? MainScroll {
        let height = mainScroll.scrollContainer.contentSizeInPoints.height
        if height < scrollContainer.contentSizeInPoints.height {
            scrollContainer.contentSizeInPoints.height = height
        } else {
            scrollContainer.verticalScrollEnabled = true
        }
//        }
    }
    
    func startLogin() {
        fbMgr.tryLoginViaParse()
    }
    
    func soloMatch() {
        print("start solo play")
        
        //need to check if match exists
        let match = Match.getDefaultsMatch()
        pushMatch(match, isSolo: true)
    }
    
    func continueMatch(button: CCButton) {
        print("enter an existing match")
        
        if let index = Int(button.name) {
        
            let match = matches[index]
            if match.isReady {
                pushMatch(match, isSolo: false)
            } else {
                promptWordInputForMatch(match)
            }
        }
    }
    
    func pushMatch(match: Match, isSolo: Bool) {
        let gameplay = CCBReader.load("Gameplay") as! Gameplay
        let scene = CCScene()
        //let index = Int(tableNode.selectedRow)
        gameplay.match = match
        gameplay.isSoloMatch = isSolo
        NSNotificationCenter.defaultCenter().removeObserver(self)
        scene.addChild(gameplay)
        NSNotificationCenter.defaultCenter().removeObserver(self)
//        CCDirector.sharedDirector().replaceScene(scene)
        CCDirector.sharedDirector().pushScene(scene)
    }
    
    func buildMatch() {
        print("create a new match")
        //target user
        ParseHelper.fetchRandomUsers
        { (result: [AnyObject]?, error: NSError?) -> Void in
            if let error = error {
                print("something bad happened: \(error.description)")
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
                print("random user fetch came back with an unexpected result")
            }
        }
    }
    
    func buildWord(message: NSNotification) {
        
        if let match = message.object as? Match {
            promptWordInputForMatch(match)
        }
        
    }
    
    func promptWordInputForMatch(match: Match) {
        //insertWord("hello", toMatch: match)
        pendingMatch = match
        animationManager.runAnimationsForSequenceNamed("PresentDialog")
    }
    
    func userSubmitWord() {
        var isInvalid = false
        if let string = textInputField.string {
            if WordHelper.isWordValid(string) {
                animationManager.runAnimationsForSequenceNamed("HideDialog")
                insertWord(string, toMatch: pendingMatch!)
            } else {
                isInvalid = true
            }
        } else {
            isInvalid = true
        }
        
        if isInvalid {
            //alert user to retry
        }
    }
    
    func insertWord(word: String, toMatch match: Match) {
        if let _ = match.fromUserWord {
            //is an existing match, need opponent word
            match.toUserWord = word
            match.isReady = true
            match.saveMatch()
            //start game, transition to gameplay
            pushMatch(match, isSolo: false)
        } else {
            //newly created match, need match creator's word
            match.fromUserWord = word
            match.uploadMatch()
            //show new match in table
        }
        
    }
    
    func refreshMatches() {
        ParseHelper.fetchMatchesForUser(PFUser.currentUser()!, includeFinished: false)
        { (result: [AnyObject]?, error: NSError?) -> Void in
            if let matches = result as? [Match] {
                self.matches = matches
                self.tableNode.reloadData()
            }
        }
    }
    
    func didFinishPreparingContent() {
        loadingContainer.cascadeOpacityEnabled = true
        
        let fade = CCActionFadeOut(duration: 0.5)
        let remove = CCActionRemove()
        let action =  CCActionSequence(array: [fade, remove])
        
        loadingContainer.runAction(action)
    }
    
}


