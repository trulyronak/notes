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
    var content: UITextView?
    var uuid: String
    var editDate: NSDate?
    
    // MARK: Constructors
    
    init(title: String, content: String) {
        self.title = title
        self.content = UITextView()
        self.content?.text = content
        self.uuid = NSUUID().UUIDString
        self.editDate = NSDate()
    }
    
    // MARK: Data Management Protocols
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(content, forKey: "Content")
        coder.encodeObject(title, forKey: "Title")
        coder.encodeObject(uuid, forKey: "UUID")
        coder.encodeObject(editDate, forKey: "EditDate")
    }
    
    required init?(coder: NSCoder) {
        content = coder.decodeObjectForKey("Content") as? UITextView
        title = coder.decodeObjectForKey("Title") as? String
        uuid = coder.decodeObjectForKey("UUID") as! String
        editDate = coder.decodeObjectForKey("EditDate") as? NSDate
    }
    
    // MARK: Accessor Methods
    
    func lastEditDate() -> String {
        // TODO: Add Real Code
        let date = "Last Edited: " + editDate!.weekdayName + " at " + editDate!.toShortTimeString()
        return date
    }

}