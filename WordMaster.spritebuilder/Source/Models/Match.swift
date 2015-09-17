//
//  Match.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/23/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import UIKit

class Match: PFObject, PFSubclassing {

    //opponent FB image
    @NSManaged var imageFile: PFFile?
    
    var fromUser: PFUser? {
        set { self["fromUser"] = newValue}
        get { return self["fromUser"] as! PFUser?}
    }
    
    var toUser: PFUser? {
        set { self["toUser"] = newValue}
        get { return self["toUser"] as! PFUser?}
    }
    
    var fromUserWord: String? {
        set { self["fromUserWord"] = newValue}
        get { return self["fromUserWord"] as! String?}
    }
    
    var toUserWord: String? {
        set { self["toUserWord"] = newValue}
        get { return self["toUserWord"] as! String?}
    }
    
    var isReady: Bool {
        set { self["isReady"] = newValue}
        get { return self["isReady"] as! Bool}
    }
    
    var isCurrentUsersTurn: Bool = false
    
    var attempts: Int = 0
    
    var guesses: [Guess] = []
    
    var matchUploadTask: UIBackgroundTaskIdentifier?
    
    static func parseClassName() -> String {
        return "Match"
    }
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        
        dispatch_once(&onceToken) { () -> Void in
            super.registerSubclass()
        }
    }
    
    func uploadMatch() {
        fromUser = PFUser.currentUser()
        isReady = false
        
        saveMatch()
    }
    
    func saveMatch() {
        matchUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.matchUploadTask!)
        })
        
        saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in

            if let error = error {
                //something bad happened
            }
            
            UIApplication.sharedApplication().endBackgroundTask(self.matchUploadTask!)
            
            if success {
                //created match successfully
                println("created match OK")
            }
            
        }
    }
    
    func fetchGuesses() {
        ParseHelper.fetchGuessesForMatch(self)  //trailing closure
        { (result: [AnyObject]?, error: NSError?) -> Void in
            if let guesses = result as? [Guess] {
                self.guesses = guesses
                println("retrieved guesses")
            }
        }
    }
}
