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
    
    var letterGrid: LetterGrid?
    var currentLetter: String = "A"
    
    override func onEnter() {
        super.onEnter()
        
        if let grid = scrollView.contentNode as? LetterGrid {
            letterGrid = grid
            print("grid found OK")
        }
        
//        scrollView.addObserver(self, forKeyPath: "scrollPosition", options: [.New], context: nil)
        scrollView.delegate = self
        //print("loaded")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "scrollPosition" {
            print("noticed scroll position change")
        }
    }
    
    func jumpToLetter(letter: String) {
        if let grid = letterGrid {
            let yPosition = grid.positionOfLetter(letter)
            let xPosition = scrollView.scrollPosition.x
            let newPosition = ccp(xPosition, yPosition)
            scrollView.setScrollPosition(newPosition, animated: true)
        }
    }

}

extension LetterSelector: CCScrollViewDelegate {

    func scrollViewDidEndDecelerating(scrollView: CCScrollView!) {
        let position = scrollView.scrollPosition.y
//        let letterHeight = 33.8 as CGFloat
        
        if let grid = letterGrid {
            let letter = grid.letterAtPosition(position)
            print("stopped moving at letter \(letter)")
            currentLetter = letter
//            jumpToLetter("A")
        }
//        print("stopped moving at \(Int(position.y/letterHeight))")
//        print("scroll view at y: \(position.y)")
    }
    
    
}