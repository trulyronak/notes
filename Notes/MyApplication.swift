//
//  MyApplication.swift
//  Notes
//
//  Created by Ronak Shah on 5/1/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

@objc(MyApplication) class MyApplication: UIApplication {
    
    override func sendEvent(event: UIEvent) {
        //
        // Ignore .Motion and .RemoteControl event
        // simply everything else then .Touches
        //
        if event.type != .Touches {
            super.sendEvent(event)
            return
        }
        
        //
        // .Touches only
        //
        
        let currVC = UIApplication.sharedApplication().keyWindow!.visibleViewController
        
            if currVC!.isKindOfClass(NoteEditViewController) {
                let editVC = currVC as! NoteEditViewController
                editVC.touchesMoved(event.allTouches()!, withEvent: event)
            }
        
       
        
       
        super.sendEvent(event)
    }
    
}