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
        didSet {
            if let user = owner {
                setObject(user, forKey: PARSE_OWNER_GUESS_KEY)
            }
        }
    }
    
    var match: Match? {
        didSet {
            if let match = match {
                setObject(match, forKey: PARSE_GUESS_MATCH_KEY)
            }
        }
    }
    var string: String? {
        didSet {
            if let string = string {
                setObject(string, forKey: PARSE_STRING_GUESS_KEY)
            }
        }
    }

    var postUploadTask: UIBackgroundTaskIdentifier?
    
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
            
            postUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.postUploadTask!)
            })
            
            saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in

                if let error = error {
                    //something bad happened
                }
                
                UIApplication.sharedApplication().endBackgroundTask(self.postUploadTask!)
                
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
