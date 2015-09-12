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
    
    let manager = PFFacebookUtils.facebookLoginManager()
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
                if user.isNew {
                    println("successful new user")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        delegate?.successfulRegistration()
                    })
                } else {
                    println("successful login")
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
    
    //get current user's details
    func getCurrentUserInfo() {
        let request = FBSDKGraphRequest(graphPath: "/me", parameters: nil)
        
        request.startWithCompletionHandler { (connection: FBSDKGraphRequestConnection?, result: AnyObject?, error: NSError?) -> Void in
            if error == nil {
                if let dict = result as? NSDictionary {
                    println("user info - facebook graph request OK")
                    
                }
            }
        }
    }
    
    //gets current user's friends who installed the app
    func getCurrentUserFriends() {
        
        let request = FBSDKGraphRequest(graphPath: "/me/friends", parameters: nil)
        
        request.startWithCompletionHandler { (connection: FBSDKGraphRequestConnection?, result: AnyObject?, error: NSError?) -> Void in
            if error == nil {
                if let dict = result as? NSDictionary {
                    println("user friends - facebook graph request OK")
                    
                }
            }
        }
    }
   
}
