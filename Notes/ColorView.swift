//
//  ColorView.swift
//  Notes
//
//  Created by Kavita Shah on 4/22/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class ColorView: UIView {
    
    var referenceVC: NoteEditViewController!
    @IBOutlet weak var colorPicker: HSBColorPicker!
    
    func createPicker() {
        colorPicker.delegate = referenceVC
    }

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ColorView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
}
