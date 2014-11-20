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
    let marginX = 10
    let marginY = 10
    
    override func drawRect(rect: CGRect) {
        if let score = selectedScore {
            processGrades()
            drawAxis()

        }
    }
    
    func drawAxis() {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x:marginX, y:marginY))
        path.addLineToPoint(CGPoint(x:marginX, y:Int(self.frame.size.height) - marginY))
        path.addLineToPoint(CGPoint(x:Int(self.frame.size.width) - marginX, y:Int(self.frame.size.height) - marginY))
        path.stroke()
    
    }
    
    func processGrades() {
        if let score = selectedScore {
            let student = score.student
            let studentScore = student.mutableArrayValueForKey("score")
            var grades = [String: Int]()
            
            for sscore in studentScore {
                let s = sscore as Score
                if let grade = grades[s.date] {
                    grades[s.date] = grade + s.score.toInt()!
                }else {
                    grades[s.date] = 0 + s.score.toInt()!
                }
            }
            
        }
        
    }
    
}
