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
    
    var facebookButton: CCButton!
    var tableNode: CCTableView!
    
    let CELL_HEIGHT: Float = 60.0
    
    override func onEnter() {
        super.onEnter()
        //let helper = MultiplayerMatchHelper.sharedInstance
        //helper.authenticationCheck()
        //let button = FBSDKLoginButton()
        //parseMgr.test()
        tableNode.dataSource = self
        
        if let user = PFUser.currentUser() {
            if PFFacebookUtils.isLinkedWithUser(user) {
                //happy path is here
                facebookButton.visible = false
            } else {
                //user invalidated session in FB
            }
        } else {
            //new user path is here
        }
        
    }
    
    func startLogin() {
        fbMgr.tryLoginViaParse()
    }
    
}

extension MainScene: CCTableViewDataSource {

    func tableView(tableView: CCTableView!, heightForRowAtIndex index: UInt) -> Float {
        return CELL_HEIGHT
    }
    
    func tableViewNumberOfRows(tableView: CCTableView!) -> UInt {
        return 3
    }
    
    func tableView(tableView: CCTableView!, nodeForRowAtIndex index: UInt) -> CCTableViewCell! {
        let cell = CCTableViewCell()
        
        let label = CCLabelTTF(string: "Hello", fontName: "ArialMT", fontSize: 24.0)
        label.anchorPoint = ccp(0,0)
        cell.addChild(label)
        
        println("created cell")
        cell.color = CCColor.whiteColor()
        
        return cell
    }

}
