//
//  MainScene+Helper.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/24/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import Foundation

extension MainScene: FacebookHelperDelegate {
    
    func successfulLogin() {
    
    }
    
    func successfulRegistration() {
    
    }
    
    func failedLogin() {
    
    }
}

extension MainScene: ParseHelperDelegate {
    
    func retrievedMatchResults() {
        tableNode.reloadData()
    }
}

