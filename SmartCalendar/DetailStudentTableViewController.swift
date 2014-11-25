//
//  DetailStudentTableViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/26/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

class DetailStudentTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField : UITextField?
    @IBOutlet weak var lastNameField : UITextField?
    @IBOutlet weak var emailField : UITextField?
    
    @IBOutlet weak var nameLabel : UILabel?
    @IBOutlet weak var lastNameLabel : UILabel?
    @IBOutlet weak var emailLabel : UILabel?

    
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
            
            nameField!.text = ""
            lastNameField!.text = ""
            emailField!.text = ""
            
            nameField!.enabled = false
            lastNameField!.enabled = false
            emailField!.enabled = false
            
            nameLabel!.textColor = UIColor.lightGrayColor()
            lastNameLabel!.textColor = UIColor.lightGrayColor()
            emailLabel!.textColor = UIColor.lightGrayColor()
        }
        
        context?.save(nil)
    }
    
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if (textField.text == "UNNAMED") ||
           (textField.text == "SOMENAME@SOMEDOMAIN") {
            textField.text = ""
        }
    }
    

}
