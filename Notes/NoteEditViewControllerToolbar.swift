//
//  GeneralExtensions.swift
//  Notes
//
//  Created by Ronak Shah on 7/28/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit


//for uitool bar
extension NoteEditViewController: UITextViewDelegate{
    
    
    func addToolBar(textField: UITextView){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 62/255, green: 154/255, blue: 245/255, alpha: 1)
        
        let fontSize:CGFloat = 20.0
        
        let colorPaletteButton = UIBarButtonItem(image: UIImage(named: "colorPalette"), style: .Plain, target: self, action: #selector(NoteEditViewController.openColorView))
        
        let boldButton = UIBarButtonItem(title: "B", style: .Plain, target: self, action: #selector(NoteEditViewController.applyBoldTextransform))
        var attributes: [String: AnyObject] = [NSFontAttributeName: UIFont.boldSystemFontOfSize(fontSize)]
        boldButton.setTitleTextAttributes(attributes, forState: .Normal)
        
        let italicButton = UIBarButtonItem(title: "I ", style: .Plain, target: self, action: #selector(NoteEditViewController.applyItalicTextransform))
        attributes = [NSFontAttributeName: UIFont.italicSystemFontOfSize(fontSize)]
        italicButton.setTitleTextAttributes(attributes, forState: .Normal)
        italicButton.width = italicButton.width + 4
        
        let underlineButton = UIBarButtonItem(title: "U", style: .Plain, target: self, action: #selector(NoteEditViewController.applyUnderlineTextransform))
        attributes = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleThick.rawValue]
        underlineButton.setTitleTextAttributes(attributes, forState: .Normal)
        
        let fontButton = UIBarButtonItem(title: "Apple", style: .Plain, target: self, action: #selector(NoteEditViewController.applyFontTextTransform))
        attributes = [NSFontAttributeName: UIFont.systemFontOfSize(fontSize)]
        fontButton.setTitleTextAttributes(attributes, forState: .Normal)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let smallSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        smallSpace.width = 10
        
        toolBar.setItems([colorPaletteButton, spaceButton, boldButton, smallSpace, italicButton, smallSpace,underlineButton, spaceButton, fontButton], animated: false)
        toolBar.userInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    
    func applyFontTextTransform(sender: UIBarButtonItem) {
        changeToFontView()
    }
    func applyBoldTextransform(sender: UIBarButtonItem) {
        if (bold) {
            sender.tintColor = UIColor.blackColor()
        }
        else {
            sender.tintColor = UIColor(red: 62/255, green: 154/255, blue: 245/255, alpha: 1)
        }
        bold = !bold
    }
    
    func applyItalicTextransform(sender: UIBarButtonItem) {
        if (italic) {
            sender.tintColor = UIColor.blackColor()
        }
        else {
            sender.tintColor = UIColor(red: 62/255, green: 154/255, blue: 245/255, alpha: 1)
        }
        italic = !italic
    }
    
    func applyUnderlineTextransform(sender: UIBarButtonItem) {
        if (underline) {
            sender.tintColor = UIColor.blackColor()
        }
        else {
            sender.tintColor = UIColor(red: 62/255, green: 154/255, blue: 245/255, alpha: 1)
        }
        underline = !underline
    }
    func openColorView(sender: UIBarButtonItem) {
        changeToColorView()
    }
    func donePressed(){
        view.endEditing(true)
    }
    func cancelPressed(){
        view.endEditing(true) // or do something
    }
    
    
    func changeToFontView() {
        let fontView = FontsView.instanceFromNib() as! FontsView
        fontView.frame = CGRectMake(-100, 500, 600, 200)
        print(fontView.frame.height)
        fontView.refrenceVC = self
        fontView.createPicker()
        self.scrollToFont(fontView.fontsPicker)
        self.view.addSubview(fontView)
        
        self.view.addConstraint(NSLayoutConstraint(item: fontView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: fontView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: 0))
        fontView.updateLabel()
    }
    
    func changeToColorView() {
        let editView = EditView.instanceFromNib() as! EditView
        editView.frame = CGRectMake(0, self.view.frame.height - editView.frame.height
            , editView.frame.size.width, editView.frame.size.height)
        
        
        let colorView = ColorView.instanceFromNib() as! ColorView
        colorView.referenceVC = self
        colorView.createPicker()
        colorView.frame = editView.frame
        self.view.addSubview(colorView)
        
        self.view.addConstraint(NSLayoutConstraint(item: colorView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: colorView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: 0))
    }
}