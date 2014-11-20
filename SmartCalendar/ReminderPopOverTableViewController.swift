//
//  ReminderPopOverTableViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 11/19/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

class ReminderPopOverTableViewController: UITableViewController {
    
    @IBOutlet weak var note : UITextView?
    @IBOutlet weak var cellView : UITableViewCell?
    
    var datePicker : UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker(frame: cellView!.frame)
        datePicker?.date = NSDate()
        cellView?.addSubview(datePicker!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Action
    @IBAction func saveButton(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        let reminder = NSEntityDescription.insertNewObjectForEntityForName("Calendar", inManagedObjectContext: managedObjectContext!) as Calendar
        
        let currentCalendar = NSCalendar.currentCalendar()
        let flags : NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit | .MinuteCalendarUnit | .HourCalendarUnit
        
        if let date = datePicker?.date {
            let selectedDateComp = currentCalendar.components(flags, fromDate: date);
        
            let comp = NSDateComponents()
            comp.day = selectedDateComp.day
            comp.month = selectedDateComp.month
            comp.year = selectedDateComp.year
        
            reminder.reminderText = note!.text
            reminder.date = currentCalendar.dateFromComponents(comp)!
            reminder.time = "\(selectedDateComp.hour):\(selectedDateComp.minute)"
            managedObjectContext?.save(nil)
        }
        
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: {})
        
    }
    
}
