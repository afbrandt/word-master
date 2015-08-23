//
//  ParseHelper.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/23/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import Parse

class ParseHelper: NSObject {

    class var sharedInstance: ParseHelper {
        struct Static {
            static let instance: ParseHelper = ParseHelper()
        }
        return Static.instance
    }
   
    func test() {
        
        let obj = PFObject(className: "TestObject")
        obj["foo"] = "bar"
        obj.saveInBackground()
        
    }
   
}
