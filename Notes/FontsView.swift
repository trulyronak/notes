//
//  FontsView.swift
//  Notes
//
//  Created by Kavita Shah on 4/22/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class FontsView: UIView{
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    @IBOutlet weak var fontsPicker: UIPickerView!
    var refrenceVC: NoteEditViewController!
    
    @IBOutlet weak var fontSizeLabel: UILabel!
    func createPicker() {
        fontsPicker.dataSource = refrenceVC
        fontsPicker.delegate = refrenceVC
    }
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "FontsView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    @IBAction func lowerFont(sender: UIButton) {
        refrenceVC.changeFont(false)
        updateLabel()
        refrenceVC.updateNote()
    }
    
    @IBAction func increaseFont(sender: UIButton) {
        refrenceVC.changeFont(true)
        updateLabel()
        refrenceVC.updateNote()
    }
    
    func updateLabel() {
        fontSizeLabel.text = refrenceVC.getFontSize()
    }
}
