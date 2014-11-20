//
//  DetailTermTableViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 10/13/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit

class DetailTermTableViewController: UITableViewController {
    
    
    
    var selectedTerm : Term?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func setStartDateAction(sender: AnyObject, event:UIEvent) {
        let startDate = sender as UIDatePicker
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        selectedTerm?.startdate = formatter.stringFromDate(startDate.date)
    }
    
    @IBAction func setEndDateAction(sender: AnyObject, event:UIEvent) {
        let endDate = sender as UIDatePicker
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        selectedTerm?.enddate = formatter.stringFromDate(endDate.date)
    }
    
}
