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
        
        var image = UIImage(named: "colorPalette")
        image = UIImage.scaleToSize(image!, size: CGSizeMake(44, 44))
        
        let colorPaletteButton = UIBarButtonItem(image: UIImage(named: "colorPalette"), style: .Plain, target: self, action: #selector(NoteEditViewController.openColorView))
        
        
        let boldButton = UIBarButtonItem(title: "B", style: .Plain, target: self, action: #selector(NoteEditViewController.applyBoldTextransform))
        

        let italicButton = UIBarButtonItem(title: "I", style: .Plain, target: self, action: #selector(NoteEditViewController.applyItalicTextransform))
        
        let underlineButton = UIBarButtonItem(title: "U", style: .Plain, target: self, action: #selector(NoteEditViewController.applyUnderlineTextransform))
        
        let fontButton = UIBarButtonItem(title: "Apple", style: .Plain, target: self, action: #selector(NoteEditViewController.applyFontTextTransform))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        
        toolBar.setItems([colorPaletteButton, spaceButton, boldButton, italicButton, underlineButton, spaceButton, fontButton], animated: false)
        toolBar.userInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    
    func applyFontTextTransform() {
        
    
    }
    func applyBoldTextransform() {
        
    }
    
    func applyItalicTextransform() {
        
    }
    
    func applyUnderlineTextransform() {
        
    }
    func openColorView() {
        
    }
    func donePressed(){
        view.endEditing(true)
    }
    func cancelPressed(){
        view.endEditing(true) // or do something
    }
}