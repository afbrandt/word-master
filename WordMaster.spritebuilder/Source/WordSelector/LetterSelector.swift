//
//  LetterSelector.swift
//  WordMaster
//
//  Created by Andrew Brandt on 9/20/15.
//  Copyright © 2015 Dory Studios. All rights reserved.
//

import Foundation

class LetterSelector: CCNode {

    var scrollView: CCScrollView!
    
    var letters: CCNode?
    
    override func onEnter() {
        super.onEnter()
        
        scrollView.delegate = self
        //print("loaded")
    }

}

extension LetterSelector: CCScrollViewDelegate {

    func scrollViewDidEndDecelerating(scrollView: CCScrollView!) {
        let position = scrollView.scrollPosition
        let letterHeight = 33.8 as CGFloat
        print("stopped moving at \(Int(position.y/letterHeight))")
//        print("scroll view at y: \(position.y)")
    }
    
}