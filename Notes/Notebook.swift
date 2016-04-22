//
//  Notebook.swift
//  Notes
//
//  Created by Ronak Shah on 4/20/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import Foundation

var notebook = Notebook()

class Notebook: NSObject, NSCoding {
    // MARK: Variables
    var notes: NSMutableArray
    
    // MARK: Constructors
    
    override init() {
        notes = NSMutableArray()
    }
    
    
    // MARK: Data Management Protocols
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(notes, forKey: "Notes")
    }
    
    required init?(coder: NSCoder) {
        notes = coder.decodeObjectForKey("Notes") as! NSMutableArray
    }

    // MARK: Accessor Methods
    
    func addNote(note: Note) {
        
        notes.addObject(note)
        sortArray()
    }
    
    func sortArray() {
        //now we implement quicksort to sort array by date
        //TODO: Write quicksort method
    }
    func getNote(index: Int) -> Note {
        let note = notes.objectAtIndex(index) as! Note
        return note
    }
    
    func removeNote(index: Int) {
        notes.removeObjectAtIndex(index)
    }
    
    func updateNote(note: Note) {
        //written for efficiency
        note.editDate = NSDate()
        //notes.removeObjectAtIndex(note.index)
        var index = 0
        for item in notes {
            let n = item as! Note
            if note.uuid == n.uuid {
                break
            }
            index++
        }
        notes.replaceObjectAtIndex(index, withObject: note)
    }
    func size() -> Int {
        return notes.count
    }
}