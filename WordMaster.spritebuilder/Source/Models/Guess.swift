//
//  Guess.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/23/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import UIKit

class Guess: PFObject, PFSubclassing {

    var owner: PFUser? {
        set { self[PARSE_OWNER_GUESS_KEY] = newValue }
        get { return self[PARSE_OWNER_GUESS_KEY] as! PFUser?}
    }
    
    var match: Match? {
        set { self[PARSE_GUESS_MATCH_KEY] = newValue }
        get { return self[PARSE_GUESS_MATCH_KEY] as! Match? }
    }
    
    var string: String? {
        set { self[PARSE_STRING_GUESS_KEY] = newValue }
        get { return self[PARSE_STRING_GUESS_KEY] as! String? }
    }

    var guessUploadTask: UIBackgroundTaskIdentifier?
    
    static func parseClassName() -> String {
        return "Guess"
    }
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        
        dispatch_once(&onceToken) { () -> Void in
            super.registerSubclass()
        }
    }
    
    func uploadGuess() {
    
        if let match = match {
        
            owner = PFUser.currentUser()
            
            guessUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.guessUploadTask!)
            })
            
            saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in

                if let error = error {
                    //something bad happened
                }
                
                UIApplication.sharedApplication().endBackgroundTask(self.guessUploadTask!)
                
                if success {
                    //created match successfully
                    println("created guess OK")
                }
                
            }
        } else {
            
            //upload guess without match? NO, bad!
            
        }
    
    }
}
