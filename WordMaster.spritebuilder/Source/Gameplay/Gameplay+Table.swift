//
//  Gameplay+Table.swift
//  WordMaster
//
//  Created by Andrew Brandt on 9/17/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import Foundation

extension Gameplay: CCTableViewDataSource {

    func tableView(tableView: CCTableView!, heightForRowAtIndex index: UInt) -> Float {
        return CELL_HEIGHT
    }
    
    func tableViewNumberOfRows(tableView: CCTableView!) -> UInt {
        if let match = match {
            return UInt(match.guesses.count)
        } else {
            return 0
        }
    }
    
    func tableView(tableView: CCTableView!, nodeForRowAtIndex index: UInt) -> CCTableViewCell! {
        
        let cell = CCBReader.load("GuessTableCell") as! GuessTableCell
        
        cell.guess = match?.guesses[Int(index)]
        
        return cell
    }


}