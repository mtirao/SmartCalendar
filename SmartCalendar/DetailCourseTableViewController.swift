//
//  DetailCourseTableViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/25/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

class DetailCourseTableViewController: UITableViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var nameField : UITextField?
    @IBOutlet weak var scheduleLabel : UILabel?
    @IBOutlet weak var termLabel : UILabel?
    @IBOutlet weak var nameLabel : UILabel?
    
    
    @IBOutlet weak var saveButton : UIBarButtonItem?
    
    var context : NSManagedObjectContext?
    var course : Course?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        termLabel?.textColor = UIColor.lightGrayColor()
        nameLabel?.textColor = UIColor.lightGrayColor()
        scheduleLabel?.textColor = UIColor.lightGrayColor()
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        self.saveButton?.enabled = false;
        
        if let c = course {
            c.name = nameField!.text!
        }
        
        termLabel?.textColor = UIColor.lightGrayColor()
        nameLabel?.textColor = UIColor.lightGrayColor()
        scheduleLabel?.textColor = UIColor.lightGrayColor()
        
        context?.save(nil)
        nameField?.text = ""
        nameField?.enabled = false
        
        course = nil

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "scheduleSegue"  {
            let navigation = segue.destinationViewController as UINavigationController
            let schedule = navigation.topViewController as ScheduleTableViewController
            schedule.selectedCourse = course
        }
        
        if segue.identifier == "termSegue"  {
            let navigation = segue.destinationViewController as UINavigationController
            let term = navigation.topViewController as TermTableViewController
            term.selectedCourse = course
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if let c = course {
            return true
        }else {
            return false
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if (textField.text == "UNNAMED") {
            textField.text = ""
        }
    }

}
