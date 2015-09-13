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
        didSet {
            if let user = fromUser{
                setObject(user, forKey: PARSE_FROM_USER_KEY)
            }
        }
    }
    
    var toUser: PFUser?{
        didSet {
            if let user = toUser{
                setObject(user, forKey: PARSE_TO_USER_KEY)
            }
        }
    }
    
    var fromUserWord: String? {
        didSet {
            if let word = fromUserWord {
                setObject(word, forKey: PARSE_FROM_USER_WORD_KEY)
            }
        }
    }
    
    var toUserWord: String? {
        didSet {
            if let word = toUserWord {
                setObject(word, forKey: PARSE_TO_USER_WORD_KEY)
            }
        }
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
