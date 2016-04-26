//
//  EditView.swift
//  Notes
//
//  Created by Kavita Shah on 4/22/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class EditView: UIView{
    
    @IBOutlet weak var fontButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    var refrenceVC: NoteEditViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.fontButton.center.x = self.center.x
        self.colorButton.center.x = self.center.x
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func changeFont(sender: UIButton) {
        let fontView = FontsView.instanceFromNib() as! FontsView
        fontView.frame = CGRectMake(-100, 500, 600, 200)
        print(fontView.frame.height)
        fontView.refrenceVC = refrenceVC
        fontView.createPicker()
        self.superview?.addSubview(fontView)
        self.removeFromSuperview()
    }
    
    @IBAction func changeColor(sender: UIButton) {
        let colorView = ColorView.instanceFromNib() as! ColorView
        colorView.referenceVC = refrenceVC
        colorView.createPicker()
        colorView.frame = self.frame
        self.superview?.addSubview(colorView)
        self.removeFromSuperview()
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "EditView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
}
