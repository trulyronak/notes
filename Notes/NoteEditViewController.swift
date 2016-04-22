//
//  NoteEditViewController.swift
//  Notes
//
//  Created by Ronak Shah on 4/20/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class NoteEditViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var noteTitleField: UITextField!
    @IBOutlet weak var noteContentField: UITextView!
    var newNote: Bool?
    
    var currentNote: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newNote == true {
            //notebook.addNote(currentNote!)
            newNote = false
        }
        else{
            noteTitleField.text = currentNote?.title
            noteContentField = currentNote?.content
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textViewDidChange(textView: UITextView) {
        updateNote()
    }
    
    @IBAction func textFieldDidChange(sender: UITextField) {
        updateNote()
    }
    
    func updateNote() {
        if let _ = currentNote {}
            
        else {
            self.currentNote = Note(title: "", content: "") //avoid reiterating below code
            notebook.addNote(self.currentNote!)
        }
        
        currentNote?.content = noteContentField
        currentNote?.title = noteTitleField.text
        notebook.updateNote(currentNote!)
    }
    
    @IBAction func editText(sender: UIBarButtonItem) {
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
