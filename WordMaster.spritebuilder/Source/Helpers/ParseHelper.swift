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

let PARSE_FROM_USER_KEY = "fromUser"
let PARSE_TO_USER_KEY = "toUser"

let PARSE_FROM_USER_WORD_KEY = "fromUserWord"
let PARSE_TO_USER_WORD_KEY = "toUserWord"

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
    
    
    
   
}
