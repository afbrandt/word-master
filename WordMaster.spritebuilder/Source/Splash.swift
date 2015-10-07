//
//  Splash.swift
//  WordMaster
//
//  Created by Andrew Brandt on 10/2/15.
//  Copyright © 2015 Dory Studios. All rights reserved.
//

import Foundation

let MAIN_READY = "Penta Is A GO!"

class Splash: CCNode {

    var next: MainScene?

    override func onEnter() {
    
        super.onEnter()
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("showMain"), name: MAIN_READY, object: nil)
        
        next = CCBReader.load("MainScene") as? MainScene
    }
    
    override func onExit() {
        super.onExit()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //hacky way to do this, need to implement callback or notification when main scene is ready
    override func update(dt: CCTime) {
        if next != nil {
            showMain()
        }
    }
    
    func showMain() {
        let scene = CCScene()
        let transition = CCTransition(crossFadeWithDuration: 0.3)
        scene.addChild(next!)
        CCDirector.sharedDirector().replaceScene(scene, withTransition: transition)
    }
    

}