//
//  LetterGrid.swift
//  WordMaster
//
//  Created by Andrew Brandt on 9/24/15.
//  Copyright © 2015 Dory Studios. All rights reserved.
//

import Foundation

class LetterGrid: CCNode {

    var letterBox: CCLayoutBox!
    
    var letters: [CCLabelTTF] = []
    
    override func onEnter() {
        super.onEnter()
        
        for entity in letterBox.children.reverse() {
            if let label = entity as? CCLabelTTF {
                letters.append(label)
            }
        }
    }
    
    func letterAtPosition(pos: CGFloat) -> String {
        let height = letterBox.contentSize.height/26.0
        let index = Int(pos/height)
        var label: CCLabelTTF
        if index > 0 && index < letters.count {
            label = letters[index]
        } else {
            label = letters[0]
        }
        return label.string
    }
    
    func positionOfLetter(letter: String) -> CGFloat {
        var position: CGFloat = 0.0
        for label in letters {
            if label.string == letter {
                position = label.position.y
                //return position
            }
        }
        let height = letterBox.contentSize.height/26.0
        return height - position
    }

}