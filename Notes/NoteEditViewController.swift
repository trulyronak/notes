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
    
    //fr = noteContentView
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newNote == true {
            newNote = false //for my own clarification
        }
        else{
            noteTitleField.text = currentNote?.title
            noteContentField.attributedText = currentNote?.content?.attributedText
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NoteEditViewController.keyboardAppeared(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        noteContentField.delegate = self
        noteContentField.keyboardType = .Default
        noteContentField.reloadInputViews()
        self.navigationItem.backBarButtonItem?.title = "Notes"
        
        //add 3d touch
        let forceTouchNo3d = UILongPressGestureRecognizer(target: self.noteContentField, action: #selector(NoteEditViewController.handleLongTouch(_:)))
        //self.noteContentField.addGestureRecognizer(forceTouchNo3d)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        noteContentField.keyboardType = .Default
        noteContentField.reloadInputViews()
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
        openEditView()
    }
    
    func openEditView() {
        self.view.endEditing(true)
        let editView = EditView.instanceFromNib() as! EditView
        editView.frame = CGRectMake(0, 500, editView.frame.size.width, editView.frame.size.height)// set new position exactly
        editView.refrenceVC = self
        self.view.addSubview(editView)
        let range = noteContentField.selectedRange
        noteContentField.selectedRange = range
        noteContentField.selectable = true
    }
    
    //for fontsview
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UIFont.familyNames().count + 1
    }
    
    func scrollToFont(picker: UIPickerView) {
        let range = noteContentField.selectedRange
        if range.length == 0 {return}
        let selectedText = noteContentField.attributedText.attributedSubstringFromRange(range)
        let attributes = selectedText.attributesAtIndex(0, effectiveRange: nil)
        let font = attributes[NSFontAttributeName] as! UIFont
        var row = UIFont.familyNames().indexOf(font.familyName)
        if row == nil {
            row = 0
        }
        else {
            row!++
        }
        picker.selectRow(row!, inComponent: 0, animated: false)
    }
    //returns the font
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        
        if row != 0 {
            pickerLabel.textColor = UIColor.blackColor()
            pickerLabel.text = UIFont.familyNames()[row - 1]
            // pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
            pickerLabel.font = UIFont(name: UIFont.familyNames()[row - 1], size: 15) // In this use your custom font
            pickerLabel.textAlignment = .Center
        }
        else {
            pickerLabel.textColor = UIColor.blackColor()
            pickerLabel.text = "System Standard"
            pickerLabel.textAlignment = .Center
            
        }
        return pickerLabel
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let range: NSRange = noteContentField.selectedRange
        if row == 0 {
            let font = UIFont.systemFontOfSize(16) //will change it to selected size
            noteContentField.setFont(font, range: range)
        }
        else  {
            let font = UIFont(name: UIFont.familyNames()[row - 1], size: 16) //will change it to selected size
            noteContentField.setFont(font!, range: range)
        }
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
    
    //3d
    func handleLongTouch(sender: UILongPressGestureRecognizer) {
        openEditView()
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
