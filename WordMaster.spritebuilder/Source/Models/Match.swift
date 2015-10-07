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
        set { self[PARSE_FROM_USER_KEY] = newValue }
        get { return self[PARSE_FROM_USER_KEY] as! PFUser? }
    }
    
    var toUser: PFUser? {
        set { self[PARSE_TO_USER_KEY] = newValue }
        get { return self[PARSE_TO_USER_KEY] as! PFUser? }
    }
    
    var fromUserWord: String? {
        set { self[PARSE_FROM_USER_WORD_KEY] = newValue }
        get { return self[PARSE_FROM_USER_WORD_KEY] as! String? }
    }
    
    var toUserWord: String? {
        set { self[PARSE_TO_USER_WORD_KEY] = newValue}
        get { return self[PARSE_TO_USER_WORD_KEY] as! String? }
    }
    
    var isReady: Bool {
        set { self[PARSE_MATCH_ISREADY_KEY] = newValue}
        get { return self[PARSE_MATCH_ISREADY_KEY] as! Bool }
    }
    
    var isFinished: Bool {
        set { self[PARSE_MATCH_ISFINISHED_KEY] = newValue}
        get { return self[PARSE_MATCH_ISFINISHED_KEY] as! Bool }
    }
    
    var lastGuess: Guess? {
        set { self[PARSE_MATCH_LASTGUESS_KEY] = newValue}
        get { return self[PARSE_MATCH_LASTGUESS_KEY] as! Guess? }
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
                print("error saving: \(error.description)")
            }
            
            UIApplication.sharedApplication().endBackgroundTask(self.matchUploadTask!)
            
            if success {
                //created match successfully
                print("saved match OK")
            }
            
        }
    }
    
    func fetchGuesses() {
        ParseHelper.fetchGuessesForMatch(self)  //trailing closure
        { (result: [AnyObject]?, error: NSError?) -> Void in
            if let guesses = result as? [Guess] {
                self.guesses = guesses
                print("retrieved guesses")
            }
        }
    }
    
    static func getDefaultsMatch() -> Match {
        let match = Match()
        let defaults = NSUserDefaults.standardUserDefaults()
        match.fromUser = PFUser.currentUser()
        
        if let dict = defaults.dictionaryForKey(MATCH_OFFLINE_KEY) {
            match.fromUserWord = dict[PARSE_FROM_USER_WORD_KEY] as? String
            match.toUserWord = dict[PARSE_TO_USER_WORD_KEY] as? String
            
            let guesses = Guess.getDefaultsGuesses()
            match.guesses = guesses
        }
        
        return match
    }
    
    static func setDefaultsMatch(match: Match) {
        let defaults = NSUserDefaults.standardUserDefaults()
        var dict: [String: AnyObject] = [:]
        
        dict[PARSE_FROM_USER_WORD_KEY] = match.fromUserWord
        dict[PARSE_TO_USER_WORD_KEY] = match.toUserWord
        
        defaults.setObject(dict, forKey: MATCH_OFFLINE_KEY)
        defaults.synchronize()
    }
}
