//
//  Note.swift
//  Notes
//
//  Created by Ronak Shah on 4/19/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

///Object used to store the data of each note, contains content of the note and the note's title
class Note: NSObject, NSCoding {
    
    // MARK: Variables

    var title: String?
    var content: UITextField?
    
    // MARK: Data Management Protocols
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(content, forKey: "Content")
    }
    
    required init?(coder: NSCoder) {
        content = coder.decodeObjectForKey("Content") as? UITextField
    }

}