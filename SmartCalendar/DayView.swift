//
//  DayView.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 11/10/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit

class DayView: UIView {
    
    var day : NSString?
    var navigationHeight = 0
    
    var fetchedReminder : [Calendar]?
    
    override func drawRect(rect: CGRect) {
        
        var noEvent = true;
        let dateFormartter = NSDateFormatter()
        dateFormartter.dateStyle = .ShortStyle
        
        let widthHalf = Int(frame.width / 2)
        
        let frameHeight = 80
        let frameWidth = frame.width / 3
        
        navigationHeight = navigationHeight + 25
        
        if let reminders = fetchedReminder {
            let reminderFontAttrs = [NSForegroundColorAttributeName : Misc.foregroundColor(),
                NSFontAttributeName : UIFont.systemFontOfSize(20)]
            
            for var i=0; i < reminders.count; i++ {
                noEvent = false
                
                let text = reminders[i].reminderText
                let date = dateFormartter.stringFromDate(reminders[i].date)
                
                let origin = CGPoint( x: 5.0, y: CGFloat(navigationHeight + ((frameHeight+20) * i)))
                let size = CGSize(width: CGFloat(frameWidth), height: CGFloat(frameHeight))
                
                let rect = CGRect(origin: origin, size: size)
                let box = UIBezierPath(roundedRect: rect, cornerRadius: 20.0)
                box.lineWidth = 1.5
                box.stroke()
                
                NSLog("\(text) \(date)")
            }
        }
        
        if noEvent {
            let dayFontAttrs = [NSForegroundColorAttributeName : Misc.foregroundColor(),
                NSFontAttributeName : UIFont.systemFontOfSize(50)]
            let text = "NO EVENT FOR TODAY"
            let size = text.sizeWithAttributes(dayFontAttrs)
        
            let pos = CGPoint(x: Int(frame.width / 2) - Int(size.width / 2), y: Int(frame.height / 2) - Int(size.height / 2))
            text.drawAtPoint(pos, withAttributes: dayFontAttrs)
        }
    }

}
