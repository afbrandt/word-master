//
//  MainScroll.swift
//  WordMaster
//
//  Created by Andrew Brandt on 10/2/15.
//  Copyright © 2015 Dory Studios. All rights reserved.
//

import Foundation

protocol MainScrollDelegate {
}

class MainScroll: CCNode {

    var socialButton: CCButton!
    var quickStartButton: CCButton!
    
    var pendingContainer: CCNode!
    var activeContainer: CCNode!
    var callContainer: CCNode!
    var scrollContainer: CCLayoutBox!
    
    var delegate: MainScrollDelegate?

    func didLoadFromCCB() {
        
        
        
    }
    
    override func onEnter() {
        super.onEnter()
        if let size = parent?.contentSizeInPoints {
            print("adjusting content size")
            //contentSizeInPoints = size
            pendingContainer.contentSizeInPoints.width = size.width
            activeContainer.contentSizeInPoints.width = size.width
            callContainer.contentSizeInPoints.width = size.width
        }
        
    }

    func social() {
        print("pressed the social button")
    }
    
    func quickStart() {
        print("pressed the quickstart button")
    }

}