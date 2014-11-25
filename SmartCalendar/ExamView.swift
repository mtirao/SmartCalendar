//
//  ExamView.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 10/27/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit

class ExamView: UIView {
    
    var selectedScore : Score?
    let marginX = 15
    let marginY = 15
    
    override func drawRect(rect: CGRect) {
        if let score = selectedScore {
            let grades = processGrades()
            draw(grades)
            
        }
    }
    
    func draw(grades: [String: Int]) {
        let path = UIBezierPath()
        let xCoeffcient = Int(self.frame.width) / (grades.count + 1)
        let yCoeffcient = Int(self.frame.height) / 11
        
        let attrs = [NSForegroundColorAttributeName : Misc.foregroundColor2(),
            NSFontAttributeName : UIFont.boldSystemFontOfSize(13.0)]
        
        var xPos = xCoeffcient
        for (date, score) in grades {
            let text = date as NSString
            let size = text.sizeWithAttributes(attrs)
            text.drawAtPoint(CGPoint(x: xPos - Int(size.width / 2), y: Int(self.frame.size.height) - marginY), withAttributes: attrs)
            xPos = xPos + xCoeffcient
        }
        
        var yPos = Int(self.frame.size.height) - marginY - 13
        for index in 0...10 {
            let text = "\(index)"
            let size = text.sizeWithAttributes(attrs)
            text.drawAtPoint(CGPoint(x: 0, y:yPos), withAttributes: attrs)
            yPos -= yCoeffcient
        }
        
        path.moveToPoint(CGPoint(x:marginX, y:marginY))
        path.addLineToPoint(CGPoint(x:marginX, y:Int(self.frame.size.height) - marginY))
        path.addLineToPoint(CGPoint(x:Int(self.frame.size.width) - marginX, y:Int(self.frame.size.height) - marginY))
        Misc.foregroundColor().setStroke()
        path.stroke()
        
        let line = UIBezierPath()
        line.moveToPoint(CGPoint(x:marginX, y:Int(self.frame.size.height) - marginY))
        Misc.foregroundColor2().setStroke()
        
        xPos = xCoeffcient
        for (date, score) in grades {
            let y = Int(self.frame.size.height) - marginY - 13 - (score * yCoeffcient)
            line.addLineToPoint(CGPoint(x: xPos+2, y: y + 2))
            let bullet = UIBezierPath(ovalInRect: CGRect(x: xPos, y: y, width: 5, height: 5))
            Misc.controlColor().setFill()
            xPos += xCoeffcient
            bullet.fill()
        }
        line.stroke()
    
    }
    
    func processGrades() -> [String: Int] {
        var grades = [String: Int]()
        
        if let score = selectedScore {
            let student = score.student
            let studentScore = student.mutableSetValueForKey("score")
            
            for sscore in studentScore {
                let s = sscore as Score
                let scoreInt = s.score.toInt()
                
                if let gradeInt = scoreInt {
                    if let grade = grades[s.date] {
                        grades[s.date] = grade + gradeInt
                    }else {
                        grades[s.date] = gradeInt
                    }
                }
            }
        }
        
        return grades
        
    }
    
}
