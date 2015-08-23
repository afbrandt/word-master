//
//  FacebookManager.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/23/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit

class FacebookHelper: NSObject {
    
    let manager = FBSDKLoginManager()
    
    class var sharedInstance: FacebookHelper {
        struct Static {
            static let instance: FacebookHelper = FacebookHelper()
        }
        return Static.instance
    }
    
    func tryLogin() {
        
        var permission = ["email", "friend_list"]
        
        manager.logInWithReadPermissions(permission, handler: { (result: FBSDKLoginManagerLoginResult!, error) -> Void in
            if error != nil {
                println("error logging in")
            } else if result.isCancelled {
                println("user cancelled login")
            } else {
                println("probably normal login")
            }
        })
        
    }
   
}
