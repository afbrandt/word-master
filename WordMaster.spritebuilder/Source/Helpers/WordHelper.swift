//
//  WordHelper.swift
//  WordMaster
//
//  Created by Andrew Brandt on 9/17/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import Foundation

class WordHelper {
    
    static func isWordValid(word: String) -> Bool {
        
        //validate length of string
        //load plist, or make web request?
        //verify word exists
        
        if word.characters.count != 5 {
            return false
        }
        
        let bundle = NSBundle.mainBundle()
        if let path = bundle.pathForResource("dict", ofType: "plist"), let array = NSArray(contentsOfFile: path) {
            if !array.containsObject(word.lowercaseString) {
                return false
            }
        }
        
        return true
        
    }
    
    static func commonCharactersForWord(guess: String, inMatchString match: String) -> Int {
        
        let result = match.characters.map { (char) -> String in
            var out = ""
            if guess.characters.contains(char) {
                out = String(char)
            }
            return out
        }
        
        return result.count
        
    }
    
    static func randomWord() -> String {
        let bundle = NSBundle.mainBundle()
        var string = "PENTA"
        if let path = bundle.pathForResource("dict", ofType: "plist"), let array = NSArray(contentsOfFile: path) {
            let count = Float(array.count)
            let index = Int(CCRANDOM_0_1()*count)
            string = array[index] as! String
        }
        return string.uppercaseString
    }
    
}