//
//  DetailSchoolTableViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/22/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

class DetailSchoolTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField : UITextField?
    @IBOutlet weak var addressField : UITextField?
    @IBOutlet weak var cityField : UITextField?
    @IBOutlet weak var countryField : UITextField?
    
    @IBOutlet weak var nameLabel : UILabel?
    @IBOutlet weak var addressLabel : UILabel?
    @IBOutlet weak var cityLabel : UILabel?
    @IBOutlet weak var countryLabel : UILabel?
    
    @IBOutlet weak var saveButton : UIBarButtonItem?
    
    var context : NSManagedObjectContext?
    var school : School?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveButton?.enabled = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func saveButton(sender: AnyObject) {
        self.saveButton?.enabled = false;
        
        if let s = school {
            s.name = nameField!.text!
            s.address = addressField!.text!
            s.city = cityField!.text!
            s.country = countryField!.text!
            
            addressField!.text = ""
            nameField!.text = ""
            cityField!.text = ""
            countryField!.text = ""
            
            nameField!.enabled = false
            addressField!.enabled = false
            cityField!.enabled = false
            countryField!.enabled = false
            
            nameLabel?.textColor = UIColor.lightGrayColor()
            addressLabel?.textColor = UIColor.lightGrayColor()
            cityLabel?.textColor = UIColor.lightGrayColor()
            countryLabel?.textColor = UIColor.lightGrayColor()
            
        }
        
        context?.save(nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if (textField.text == "UNNAMED") {
                textField.text = ""
        }
    }
}
