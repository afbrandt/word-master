//
//  MainScene+Table.swift
//  WordMaster
//
//  Created by Andrew Brandt on 8/24/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import Foundation

extension MainScene: CCTableViewDataSource {

    func tableView(tableView: CCTableView!, heightForRowAtIndex index: UInt) -> Float {
        return CELL_HEIGHT
    }
    
    func tableViewNumberOfRows(tableView: CCTableView!) -> UInt {
        return 3
    }
    
    func tableView(tableView: CCTableView!, nodeForRowAtIndex index: UInt) -> CCTableViewCell! {
        let cell = CCTableViewCell()
        
        let label = CCLabelTTF(string: "Hello", fontName: "ArialMT", fontSize: 24.0)
        label.anchorPoint = ccp(0,0)
        cell.addChild(label)
        
        println("created cell")
        cell.color = CCColor.whiteColor()
        
        return cell
    }

}