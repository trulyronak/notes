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
        
        /*
        var topConstraint = NSLayoutConstraint(item: self.fontButton, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0)
        var bottomContraint = NSLayoutConstraint(item: self.fontButton, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        var constraints = [topConstraint, bottomContraint]
        fontButton.addConstraints(constraints)
        
        topConstraint = NSLayoutConstraint(item: self.colorButton, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0)
        bottomContraint = NSLayoutConstraint(item: self.colorButton, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        constraints = [topConstraint, bottomContraint]
        colorButton.addConstraints(constraints)
        
        fontButton.titleLabel?.textAlignment = .Center
        colorButton.titleLabel?.textAlignment = .Center
        
        fontButton.frame = CGRectMake(0, 0, self.frame.width, self.frame.height/2)
        colorButton.frame = CGRectMake(0, self.frame.height/2, self.frame.width, self.frame.height/2)
        */
        

        
        
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
