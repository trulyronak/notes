//
//  NoteEditViewController.swift
//  Notes
//
//  Created by Ronak Shah on 4/20/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class NoteEditViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, HSBColorPickerDelegate {
    
    @IBOutlet weak var noteTitleField: UITextField!
    @IBOutlet weak var noteContentField: UITextView!
    var newNote: Bool?
    
    var currentNote: Note?
    
    var currentFont: UIFont!
    var currentColor: UIColor!
    
    //fr = noteContentView
    override func viewDidLoad() {
        super.viewDidLoad()
        addToolBar(noteContentField)
        if newNote == true {
            newNote = false //for my own clarification
        }
        else{
            noteTitleField.text = currentNote?.title
            noteContentField.attributedText = currentNote?.content?.attributedText
        }
        currentFont = UIFont.systemFontOfSize(16)
        currentColor = UIColor.blackColor()
        
        noteContentField.delegate = self
        noteContentField.keyboardType = .Default
        noteContentField.reloadInputViews()
        self.navigationItem.backBarButtonItem?.title = "Notes"
        
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
        removeEditingViews()
    }
    
    @IBAction func editText(sender: UIBarButtonItem) {
        openEditView()
    }
    
    func removeEditingViews() {
        for view in self.view.subviews {
            if view.isKindOfClass(EditView) || view.isKindOfClass(FontsView) || view.isKindOfClass(ColorView){
                view.removeFromSuperview()
            }
        }
    }
    func openEditView() {
        removeEditingViews()
        self.view.endEditing(true)
        let editView = EditView.instanceFromNib() as! EditView
        editView.frame = CGRectMake(0, self.view.frame.height - editView.frame.height
            , editView.frame.size.width, editView.frame.size.height)// set new position exactly
        editView.refrenceVC = self
        self.view.addSubview(editView)
        let range = noteContentField.selectedRange
        noteContentField.selectedRange = range
        noteContentField.selectable = true
        view.addConstraint(NSLayoutConstraint(item: editView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: editView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0))
    }
    
    //for fontsview
    
    func getFontSize() -> String{
        let range = noteContentField.selectedRange
        if range.length == 0 {return "/"}
        let selectedText = noteContentField.attributedText.attributedSubstringFromRange(range)
        let attributes = selectedText.attributesAtIndex(0, effectiveRange: nil)
        let font = attributes[NSFontAttributeName] as! UIFont
        noteContentField.selectedRange = range
        return "\(Int(font.pointSize))"
    }
    
    func changeFont(increasing: Bool) {
        let range = noteContentField.selectedRange
        if range.length == 0 {return}
        let selectedText: NSAttributedString = noteContentField.attributedText.attributedSubstringFromRange(range)
        print(selectedText.string)
        let attributes = selectedText.attributesAtIndex(0, effectiveRange: nil)
        var font = attributes[NSFontAttributeName] as! UIFont
        
        if increasing {
            font = font.fontWithSize(font.pointSize + 1)
            noteContentField.setFont(font, range: range)
        }
        else {
            font = font.fontWithSize(font.pointSize - 1)
            noteContentField.setFont(font, range: range)
        }
        noteContentField.selectedRange = range

    }
    
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
        if range.length == 0 {return}
        let selectedText = noteContentField.attributedText.attributedSubstringFromRange(range)
        let attributes = selectedText.attributesAtIndex(0, effectiveRange: nil)
        let textFont = attributes[NSFontAttributeName] as! UIFont

        if row == 0 {
            let font = UIFont.systemFontOfSize(textFont.pointSize) //will change it to selected size
            noteContentField.setFont(font, range: range)
        }
        else  {
            let font = UIFont(name: UIFont.familyNames()[row - 1], size: textFont.pointSize) //will change it to selected size
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
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first where traitCollection.forceTouchCapability == .Available {
            if touch.force > 1 {
                openEditView()
            }
        }
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
