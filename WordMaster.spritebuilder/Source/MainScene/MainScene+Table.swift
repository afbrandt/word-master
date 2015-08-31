//
//  MainScene+Table.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/24/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import Foundation

let CELL_HEIGHT: Float = 70.0

extension MainScene: CCTableViewDataSource {

    func tableView(tableView: CCTableView!, heightForRowAtIndex index: UInt) -> Float {
        return CELL_HEIGHT
    }
    
    func tableViewNumberOfRows(tableView: CCTableView!) -> UInt {
        //return UInt(matches.count)
        return 3
    }
    
    func tableView(tableView: CCTableView!, nodeForRowAtIndex index: UInt) -> CCTableViewCell! {
        //let cell = CCTableViewCell()
        
        //let cell = MatchTableCell()
        
        let cell = CCBReader.load("MatchTableCell") as! MatchTableCell
        
        cell.opponentName.string = "cell number \(index)"
        
        //cell.match = matches[Int(index)]
        
//        let label = CCLabelTTF(string: "Hello", fontName: "ArialMT", fontSize: 24.0)
//        label.anchorPoint = ccp(0,0)
//        cell.addChild(label)
        
        println("created cell")
//        cell.color = CCColor.whiteColor()
        
        return cell
    }

}