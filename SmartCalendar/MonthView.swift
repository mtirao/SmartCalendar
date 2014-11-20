//
//  MonthView.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/17/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit

class MonthView: UIView {

    
    override func drawRect(rect: CGRect) {
        let w : Int = Int(self.frame.size.width / 7)
        
        let dayFontAttrs = [NSForegroundColorAttributeName : Misc.foregroundColor2(),
            NSFontAttributeName : UIFont.boldSystemFontOfSize(16.0)]
        
        let dayOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"] as [NSString]
        
        var x = w;
        
        for text in dayOfWeek {
            let size = text.sizeWithAttributes(dayFontAttrs)
            let pos = CGPoint(x: x - Int(size.width) -  5, y: 40)
            text.drawAtPoint(pos, withAttributes: dayFontAttrs)
            x += w
        }
        
    }

}
