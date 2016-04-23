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
    var initializing: Bool = false
    // MARK: Constructors
    
    override init() {
        notes = NSMutableArray()
        initializing = true
    }
    
    
    // MARK: Data Management Protocols
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(notes, forKey: "Notes")
    }
    
    required init?(coder: NSCoder) {
        notes = coder.decodeObjectForKey("Notes") as! NSMutableArray
    }
    
    // MARK: Data Storage
    
    func refreshData() {
        if initializing {
            notes = DataManager.getArray("NotesData")
            initializing = false
        }
        else {
            DataManager.saveArray(notes, key: "NotesData")
        }
        
        //temp workaround, if I have time I will implement CoreData
        /*
         let defaults = NSUserDefaults.standardUserDefaults()
         if initializing {
         //if this is startup, we first check if data exists
         if let data = defaults.objectForKey("NotesData") as? NSMutableArray { //if data exists
         notes = (data.objectAtIndex(0) as! NSMutableArray).copy() as! NSMutableArray
         }
         else { //if data doesn't exists (first run)
         let wrapper = NSMutableArray()
         wrapper.addObject(notes)
         defaults.setObject(wrapper, forKey: "NotesData")
         defaults.synchronize()
         
         }
         initializing = false
         }
         else { //if this is not startup
         let wrapper = NSMutableArray()
         wrapper.addObject(notes)
         defaults.setObject(wrapper, forKey: "NotesData")
         defaults.synchronize()
         }
         */
    }
    
    
    // MARK: Accessor Methods
    
    func addNote(note: Note) {
        
        notes.addObject(note)
        sortArray()
        refreshData()
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
        refreshData()
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
        refreshData()
    }
    
    func size() -> Int {
        return notes.count
    }
}