//
//  DataManager.swift
//  Notes
//
//  Created by Ronak Shah on 4/22/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import Foundation

class DataManager {
    
    static func saveArray(array: NSMutableArray, key:String) {
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(array)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: key)
    }
    
    static func getArray(key:String) -> NSMutableArray{
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(key) as? NSData {
            let array = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! NSMutableArray
            return array
        }
        else {
            return NSMutableArray()
        }
        
    }

}