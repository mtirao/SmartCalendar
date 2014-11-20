//
//  DayViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 11/10/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

class ReminderDetailViewController: UIViewController, NSFetchedResultsControllerDelegate {

    let nameOfMonth : [String] = ["JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAYO", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"]
    let dayOfWeek : [String] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    let currentCalendar = NSCalendar.currentCalendar()
    let flags : NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit | .WeekdayCalendarUnit
    
    
    var fetchedScore : NSFetchedResultsController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        
        /*let comp = currentCalendar.components(flags, fromDate: NSDate())
        let view : DayView = self.view as DayView
        
        view.navigationHeight = Int(self.navigationController!.navigationBar.frame.size.height)
        view.day = String(comp.day)
        
        let day : String = dayOfWeek[comp.weekday - 1] + ", "
        let month : String = nameOfMonth[comp.month - 1] + " " + String(comp.day)
        let year : String = ", \(comp.year)"
        
        let today = currentCalendar.dateFromComponents(comp)
        
        let fetchedReminder = reminderForDate(today!)
        
        view.fetchedReminder = fetchedReminder
        
        
        
        self.navigationItem.title = day + month + year*/
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func reminderForDate(date: NSDate) -> [Calendar]? {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Calendar")
        let predicate = NSPredicate(format: "date >= %@", date )
        fetchRequest.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as? [Calendar]
    }
    
    func examsForDate(date: NSDate) -> [Score]? {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        let fetchRequestCalendar = NSFetchRequest(entityName: "Score")
        fetchRequestCalendar.predicate = NSPredicate(format: "date == %@", formatter.stringFromDate(date) )
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequestCalendar.sortDescriptors = [sortDescriptor]
        let result = managedObjectContext?.executeFetchRequest(fetchRequestCalendar, error: nil)
        
        return result as? [Score]
    }
 
}
