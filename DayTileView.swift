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
        
        let box = UIBezierPath(rect: rect)
        UIColor.grayColor().setStroke()
        box.stroke()
        
        if let text : NSString = day {
            let size = text.sizeWithAttributes(dayFontAttrs)
            if current! {
                text.drawAtPoint(CGPoint(x: self.frame.size.width-size.width - 5, y: 5), withAttributes: currentDayFontAttrs)
            }else {
                text.drawAtPoint(CGPoint(x: self.frame.size.width-size.width - 5, y: 5), withAttributes: dayFontAttrs)
            }
        }
        
    }

    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if let del = delegate {
            del.processMouseDown(self)
        }
        
    }

}
