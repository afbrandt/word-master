//
//  Guess.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/23/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import UIKit

let PENTA_SOLO_GUESSES = "Solo Play Guesses"

class Guess: PFObject, PFSubclassing {

    var owner: PFUser? {
        set { self[PARSE_OWNER_GUESS_KEY] = newValue }
        get { return self[PARSE_OWNER_GUESS_KEY] as! PFUser? }
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
    var count: Int = 0
    
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
    
        if match != nil {
        
            owner = PFUser.currentUser()
            
            guessUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.guessUploadTask!)
            })
            
            saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in

                if let error = error {
                    //something bad happened
                    print("error: \(error.description)")
                }
                
                UIApplication.sharedApplication().endBackgroundTask(self.guessUploadTask!)
                
                if success {
                    //created match successfully
                    print("created guess OK")
                }
                
            }
        } else {
            
            //upload guess without match? NO, bad!
            
        }
    
    }
    
    func checkGuess() -> Bool {
        if let string = string, let match = match, let fromUser = match.fromUser, let toUser = match.toUser {
            var checkString: String!
            if fromUser.madeGuess(self) {
//                let count = WordHelper.commonCharactersForWord(string, inMatchString: match.toUserWord!)
                checkString = match.toUserWord!
            } else if toUser.madeGuess(self) {
                checkString = match.fromUserWord!
            } else  {
                return false
            }
            let common = WordHelper.commonCharactersForWord(string, inMatchString: checkString)
            count = common
        }
        
        return true
    }
    
    static func getDefaultsGuesses() -> [Guess] {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let arr = defaults.arrayForKey(PENTA_SOLO_GUESSES) as? [String] ?? []
        var guesses: [Guess] = []
        
        for word in arr {
            let guess = Guess()
            guess.owner = PFUser.currentUser()
            guess.string = word
            guesses.append(guess)
        }
        
        return guesses
        
    }
    
    static func setDefaultsGuesses(guesses: [Guess]) {
        let defaults = NSUserDefaults.standardUserDefaults()
        var arr: [String] = []
        
        for guess in guesses {
            let word = guess.string!
            arr.append(word)
        }
        
        defaults.setObject(arr, forKey: PENTA_SOLO_GUESSES)
        defaults.synchronize()
    }
}

extension PFUser {

    func madeGuess(guess: Guess) -> Bool {
        
        if objectId == guess.owner?.objectId {
            return true
        }
        return false
    }

}
