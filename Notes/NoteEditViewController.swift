//
//  NoteEditViewController.swift
//  Notes
//
//  Created by Ronak Shah on 4/20/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class NoteEditViewController: UIViewController, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, HSBColorPickerDelegate {
    
    @IBOutlet weak var noteTitleField: UITextField!
    @IBOutlet weak var noteContentField: UITextView!
    var newNote: Bool?
    //var font: UIFont = UIFont(descriptor: , size: <#T##CGFloat#>)
    var currentNote: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newNote == true {
            newNote = false //for my own clarification
        }
        else{
            noteTitleField.text = currentNote?.title
            noteContentField.attributedText = currentNote?.content?.attributedText
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardAppeared:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
    
    func application(application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: String) -> Bool {
        if extensionPointIdentifier == UIApplicationKeyboardExtensionPointIdentifier {
            return true
        }
        return true
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
    func keyboardAppeared(notification: NSNotification) {
        for view in self.view.subviews {
            if view.isKindOfClass(EditView) || view.isKindOfClass(FontsView) || view.isKindOfClass(ColorView){
                view.removeFromSuperview()
            }
        }
    }
    
    @IBAction func editText(sender: UIBarButtonItem) {
        let editView = EditView.instanceFromNib() as! EditView
        editView.frame = CGRectMake(0, 500, editView.frame.size.width, editView.frame.size.height)// set new position exactly
        editView.refrenceVC = self
        self.view.addSubview(editView)
        let range = noteContentField.selectedRange
        self.view.endEditing(true)
        noteContentField.selectedRange = range
        noteContentField.selectable = true
    }
    
    
    //for fontsview
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UIFont.familyNames().count
    }
    
    //returns the font
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.blackColor()
        pickerLabel.text = UIFont.familyNames()[row]
        // pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
        pickerLabel.font = UIFont(name: UIFont.familyNames()[row], size: 15) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let range: NSRange = noteContentField.selectedRange
        let font = UIFont(name: UIFont.familyNames()[row], size: 16) //will change it to selected size
        noteContentField.setFont(font!, range: range)
        
        self.noteContentField.selectedRange = range //fixing strange bug where selected range gets removed
        updateNote()
    }
    
    //for colorview
    func HSBColorColorPickerTouched(sender: HSBColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizerState!) {
        let range: NSRange = noteContentField.selectedRange
        noteContentField.setTextColor(color, range: range)
        self.noteContentField.selectedRange = range //fixing strange bug where selected range gets removed
        updateNote()
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
