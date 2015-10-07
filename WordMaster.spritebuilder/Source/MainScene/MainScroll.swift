//
//  MainScroll.swift
//  WordMaster
//
//  Created by Andrew Brandt on 10/2/15.
//  Copyright © 2015 Dory Studios. All rights reserved.
//

import Foundation

protocol MainScrollDelegate {
//    optional func quickStartButtonPressed()
//    optional func socialButtonPressed()
    func didFinishPreparingContent()
}

let FACEBOOK_SIGNUP = "Request Facebook"
let FACEBOOK_INVITE = "Request Invites"

let PENTA_REFRESH_MATCHES = "Loaded matches"
let PENTA_REFRESH_SOLO = "Loaded solo"

enum PentaSocialState {
    case Anonymous, Facebook
}

enum PentaSoloPlayState {
    case Inactive, PlayerTurn, ComputerTurn
}

class MainScroll: CCNode {

    var socialState: PentaSocialState = .Anonymous
    var activeMatches: [Match] = []
    var pendingMatches: [Match] = []
    var matches: [Match] = []
    
    var announceRefresh: Bool = true
    
    //code connected
    var socialButton: CCButton!
    var quickStartButton: CCButton!
    
    var pendingContainer: CCNode!
    var activeContainer: CCNode!
    var callContainer: CCNode!
    var scrollContainer: CCLayoutBox!
    
    var delegate: MainScrollDelegate?

    func didLoadFromCCB() {
        
//        NSNotificationCenter.defaultCenter().postNotificationName(MAIN_READY, object: nil)
        let notifier = NSNotificationCenter.defaultCenter()
        
        notifier.addObserver(self, selector: Selector("buildMatches"), name: PENTA_REFRESH_MATCHES, object: nil)
        
        refreshMatches()
        
    }
    
    override func onEnter() {
        super.onEnter()
        
        resizeContainers()
        configureSocial()
    }
    
    func resizeContainers() {
        if let size = parent?.contentSizeInPoints {
            print("adjusting content size")
            //contentSizeInPoints = size
            pendingContainer.contentSizeInPoints.width = size.width
            activeContainer.contentSizeInPoints.width = size.width
            callContainer.contentSizeInPoints.width = size.width
        }
    }

    func social() {
        print("pressed the social button")
        
        switch socialState {
            case .Anonymous:
                NSNotificationCenter.defaultCenter().postNotificationName(FACEBOOK_SIGNUP, object: nil)
            case .Facebook:
                NSNotificationCenter.defaultCenter().postNotificationName(FACEBOOK_INVITE, object: nil)
        }
        
        
    }
    
    func configureSocial() {
        //check socialState and change socialButton to match
    }
    
    func quickStart() {
        print("pressed the quickstart button")
        NSNotificationCenter.defaultCenter().postNotificationName(MATCH_OFFLINE_KEY, object: nil)
    }
    
    func refreshMatches() {
        ParseHelper.fetchMatchesForUser(PFUser.currentUser()!, includeFinished: false)
        { (result: [AnyObject]?, error: NSError?) -> Void in
            if let matches = result as? [Match] {
                //self.matches = matches
                for match in matches {
                    let guess = match.lastGuess!
                    if guess.owner!.objectId == PFUser.currentUser()?.objectId {
                        self.pendingMatches.append(match)
                    } else {
                        self.activeMatches.append(match)
                    }
                }
            }
            let notifier = NSNotificationCenter.defaultCenter()
            notifier.postNotificationName(PENTA_REFRESH_MATCHES, object: nil)
//            if self.announceRefresh {
//                NSNotificationCenter.defaultCenter().postNotificationName(MAIN_READY, object: nil)
//                self.announceRefresh = false
//            }
        }
    }
    
    func refreshSolo() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasSoloMatch = defaults.boolForKey(MATCH_HAS_ACTIVE_OFFLINE_KEY)

        if hasSoloMatch {
            //get match from defaults, deserialize it
            let match = Match.getDefaultsMatch()
            self.activeMatches.insert(match, atIndex: 0)
        }
    }
    
    func buildMatches() {
        refreshSolo()
        
        delegate?.didFinishPreparingContent()
        print("well nothing broke yet...")
        
    }

}