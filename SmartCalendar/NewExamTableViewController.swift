//
//  NewExamTableViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 10/15/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

class NewExamTableViewController: UITableViewController {

    var selectedSchedule : Schedule?
    var selectedDate : NSDate?
    
    @IBOutlet weak var note : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButton(sender: AnyObject) {
        
        if let schedule = selectedSchedule {
            let course = schedule.course
            
            if let term = termForDate(course) {
                let studentsSet = course.mutableSetValueForKey("students")
                let students = studentsSet.allObjects as [Student]
                
                let termScoreSet = term.mutableSetValueForKey("score")
                
                let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                let managedObjectContext = appDelegate.managedObjectContext
                
                if let context = managedObjectContext {
                    for s in students {
                        let score = NSEntityDescription.insertNewObjectForEntityForName("Score", inManagedObjectContext: context) as Score
                        
                        score.scoredescription = note!.text
                        score.number = NSNumber(bool: true)
                        score.score = ""
                        score.time = schedule.starttime
                        
                        if let date = selectedDate {
                            let formatter = NSDateFormatter()
                            formatter.dateStyle = NSDateFormatterStyle.ShortStyle
                            score.date = formatter.stringFromDate(date)
                        }else {
                            score.date = ""
                        }
                        
                        termScoreSet.addObject(score)
                        
                        let studentScoreSet = s.mutableSetValueForKey("score")
                        studentScoreSet.addObject(score)
                        context.save(nil)
                    }
                }
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func termForDate(course: Course) -> Term? {
        
        let termSet = course.mutableSetValueForKey("term")
        let term = termSet.allObjects as [Term]
        
        if term.count > 0 {
            return term[0]
        }else{
            return nil
        }
        
    }
    
}
