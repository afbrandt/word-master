//
//  FacebookHelper.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/23/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit
import Parse

protocol FacebookHelperDelegate {
    func successfulLogin()
    func successfulRegistration()
    func failedLogin()
}

class FacebookHelper: NSObject {
    
    let manager = FBSDKLoginManager()
    var delegate: FacebookHelperDelegate?
    
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
    
    func tryLoginViaParse() {
        let permissions = ["email", "friend_list"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions)
        { (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                println("successful login")
                if user.isNew {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        delegate?.successfulRegistration()
                    })
                } else {
                   dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        delegate?.successfulLogin()
                    })
                }
            } else {
                println("failed login")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    delegate?.failedLogin()
                })
            }
        }
        
    }
   
}
