//
//  MultiplayerMatchHelper.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit
import GameKit

protocol MultiplayerMatchHelperDelegate {
    func willSignIn()
    func didSignIn()
    func failedToSignIn()
    func failedToSignInWithError(error: NSError)
}

class MultiplayerMatchHelper: NSObject, GKGameCenterControllerDelegate, GKLocalPlayerListener {

    let player = GKLocalPlayer.localPlayer()
    var delegate: MultiplayerMatchHelperDelegate?
    var callingViewController: UIViewController?

//    class var sharedInstance: MultiplayerMatchHelper {
//        struct Static {
//            static let instance: MultiplayerMatchHelper = MultiplayerMatchHelper()
//        }
//        return Static.instance
//    }
    
    required override init() {
        super.init()
        
    }
    
    func isGameCenterAvailable() -> Bool {
        return true
    }
    
    func authenticationCheck() {
        
        if !player.authenticated {
            authenticateLocalPlayer()
        } else {
            player.registerListener(self)
        }
    }
    
    private func authenticateLocalPlayer() {
        
        delegate?.willSignIn()
        
        player.authenticateHandler = {(viewController : UIViewController!, error : NSError!) -> Void in

            if (viewController != nil)
            {
               dispatch_async(dispatch_get_main_queue(), {
                   self.showAuthenticationDialogueWhenReasonable(presentingViewController: CCDirector.sharedDirector().parentViewController!, gameCenterController: viewController)
               })
            }

            else if (self.player.authenticated == true)
            {
               println("Player is Authenticated")
               self.player.registerListener(self)
               self.delegate?.didSignIn()
            }

            else
            {
               println("User Still Not Authenticated")
               self.delegate?.failedToSignIn()
            }

            if (error != nil)
            {
               println("Failed to sign in with error:\(error.localizedDescription).")
               self.delegate?.failedToSignInWithError(error)
               // Delegate can take necessary action. For example: present a UIAlertController with the error details.
            }
        }
        
    }
    
    func showAuthenticationDialogueWhenReasonable(#presentingViewController:UIViewController, gameCenterController:UIViewController)
    {
        presentingViewController.presentViewController(gameCenterController, animated: true, completion: nil)
    }
    
    //MARK: GKGameCenterControllerDelegate method
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: GKLocalPlayerListener
    
    
    
}
