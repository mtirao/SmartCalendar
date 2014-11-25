//
//  DayTileView.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/13/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit

class DayTileView: UIView {
    
    var day : String?
    var current : Bool?
    var lines : NSArray?
    var delegate: CalendarDelegate?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect){
        
        let dayFontAttrs = [NSForegroundColorAttributeName : Misc.foregroundColor(),
            NSFontAttributeName : UIFont.boldSystemFontOfSize(20.0)]
        
        let currentDayFontAttrs = [NSForegroundColorAttributeName : Misc.currentDayColor(),
            NSFontAttributeName : UIFont.boldSystemFontOfSize(20.0)]
        
        let reminderFontAttrs = [NSForegroundColorAttributeName : Misc.foregroundColor2(),
            NSFontAttributeName : UIFont.boldSystemFontOfSize(13.0)]
        
        let box = UIBezierPath(rect: rect)
        UIColor.grayColor().setStroke()
        box.stroke()
        
        var size : CGSize = CGSize(width: 0, height: 20)
        if let text : NSString = day {
            size = text.sizeWithAttributes(dayFontAttrs)
            if current! {
                text.drawAtPoint(CGPoint(x: self.frame.size.width-size.width - 5, y: 5), withAttributes: currentDayFontAttrs)
            }else {
                text.drawAtPoint(CGPoint(x: self.frame.size.width-size.width - 5, y: 5), withAttributes: dayFontAttrs)
            }
        }
        
        let reminder = lines as? [Calendar]
        
        if let r = reminder {
            for calendar in r {
                let text : NSString = calendar.reminderText
                text.drawAtPoint(CGPoint(x: 2, y: Int(size.height) + 2), withAttributes: reminderFontAttrs)
            }
            
        }
        
    }

    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if let del = delegate {
            del.processMouseDown(self)
        }
        
    }

}
