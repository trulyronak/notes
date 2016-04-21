//
//  Notebook.swift
//  Notes
//
//  Created by Ronak Shah on 4/20/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import Foundation

class Notebook: NSObject, NSCoding {
    // MARK: Variables
    var notes: NSMutableArray
    
    // MARK: Data Management Protocols
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(notes, forKey: "Notes")
    }
    
    required init?(coder: NSCoder) {
        notes = coder.decodeObjectForKey("Notes") as? NSMutableArray
    }
}