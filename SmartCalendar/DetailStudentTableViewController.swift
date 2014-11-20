//
//  DetailStudentTableViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/26/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

class DetailStudentTableViewController: UITableViewController {

    @IBOutlet weak var nameField : UITextField?
    @IBOutlet weak var lastNameField : UITextField?
    @IBOutlet weak var emailField : UITextField?
    
    @IBOutlet weak var saveButton : UIBarButtonItem?
    
    var context : NSManagedObjectContext?
    var student : Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        self.saveButton?.enabled = false;
        
        if let currentStudent = student {
            currentStudent.name = nameField!.text
            currentStudent.lastname = lastNameField!.text
            currentStudent.email = emailField!.text
        }
        
        context?.save(nil)
        
    }

}
