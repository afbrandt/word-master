//
//  ParseHelper.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/23/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import Parse

protocol ParseHelperDelegate {
    func retrievedMatchResults(matches: [Match])
}

let PARSE_MATCH_CLASS = "Match"
let PARSE_GUESS_CLASS = "Guess"

let PARSE_FROM_USER_KEY = "fromUser"
let PARSE_TO_USER_KEY = "toUser"

let PARSE_FROM_USER_WORD_KEY = "fromUserWord"
let PARSE_TO_USER_WORD_KEY = "toUserWord"

let PARSE_GUESS_MATCH_KEY = "match"

let PARSE_OWNER_GUESS_KEY = "owner"
let PARSE_STRING_GUESS_KEY = "string"

class ParseHelper: NSObject {
    
    var delegate: ParseHelperDelegate?

    class var sharedInstance: ParseHelper {
        struct Static {
            static let instance: ParseHelper = ParseHelper()
        }
        return Static.instance
    }
   
//    func test() {
//        
//        let obj = PFObject(className: "TestObject")
//        obj["foo"] = "bar"
//        obj.saveInBackground()
//        
//    }

    func getMatchesForUser(user: PFUser) {
        let fromUserQuery = PFQuery(className: PARSE_MATCH_CLASS)
        fromUserQuery.whereKey(PARSE_FROM_USER_KEY, equalTo: user)
        
        let toUserQuery = PFQuery(className: PARSE_MATCH_CLASS)
        toUserQuery.whereKey(PARSE_TO_USER_KEY, equalTo: user)
        
        let mainQuery = PFQuery.orQueryWithSubqueries([fromUserQuery, toUserQuery])
        
        //return mainQuery.findObjects() as! [Match]
        mainQuery.findObjectsInBackgroundWithBlock { (result: [AnyObject]?, error: NSError?) -> Void in
            if let matches = result as? [Match] {
                self.delegate?.retrievedMatchResults(matches)
            }
        }
    }
    
    func getGuessesForMatch(match: Match) {
        
        let matchQuery = PFQuery(className: PARSE_GUESS_CLASS)
        
        matchQuery.whereKey(PARSE_GUESS_MATCH_KEY, equalTo: match)
        
        matchQuery.findObjectsInBackgroundWithBlock { (result: [AnyObject]?, error: NSError?) -> Void in
            if let guesses = result as? [Guess] {
                //self.delegate?.retrievedMatchResults(matches)
                println("retrieved guesses")
            }
        }
    }
    
    static func fetchMatchesForUser(user: PFUser, completionBlock: PFArrayResultBlock) {
        let fromUserQuery = PFQuery(className: PARSE_MATCH_CLASS)
        fromUserQuery.whereKey(PARSE_FROM_USER_KEY, equalTo: user)
        
        let toUserQuery = PFQuery(className: PARSE_MATCH_CLASS)
        toUserQuery.whereKey(PARSE_TO_USER_KEY, equalTo: user)
        
        let mainQuery = PFQuery.orQueryWithSubqueries([fromUserQuery, toUserQuery])
        
        mainQuery.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    static func fetchGuessesForMatch(match: Match, completionBlock: PFArrayResultBlock) {
        let query = PFQuery(className: PARSE_GUESS_CLASS)
        
        query.whereKey(PARSE_GUESS_MATCH_KEY, equalTo: match)
        //query.includeKey(PARSE_STRING_GUESS_KEY)
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
   
}
