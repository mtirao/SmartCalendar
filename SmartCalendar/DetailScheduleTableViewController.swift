//
//  DetailScheduleTableViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 10/8/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit

class DetailScheduleTableViewController: UITableViewController {

    @IBOutlet weak var startTime : UITextField?
    @IBOutlet weak var endTime : UITextField?
    
    @IBOutlet weak var monCell : UITableViewCell?
    @IBOutlet weak var tueCell : UITableViewCell?
    @IBOutlet weak var wedCell : UITableViewCell?
    @IBOutlet weak var thuCell : UITableViewCell?
    @IBOutlet weak var friCell : UITableViewCell?
    @IBOutlet weak var satCell : UITableViewCell?
    
    
    var selectedSchedule : Schedule?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        startTime?.text = selectedSchedule?.starttime
        endTime?.text = selectedSchedule?.endtime
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        if let schedule = selectedSchedule {
            schedule.weekday = selectedDay()
            if let start = startTime {
                schedule.starttime = start.text
            }
            if let end = endTime {
                schedule.endtime = end.text
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        deselectAllDays()
        let row = indexPath.row
        
        switch row {
        case 0:
            selectDay("Mon")
        case 1:
            selectDay("Tue")
        case 2:
            selectDay("Wed")
        case 3:
            selectDay("Thu")
        case 4:
            selectDay("Fri")
        case 7:
            selectDay("Sat")
        default:
            selectDay("Mon")
        }
    }
    
    func deselectAllDays() {
        monCell?.accessoryType = UITableViewCellAccessoryType.None
        tueCell?.accessoryType = UITableViewCellAccessoryType.None
        wedCell?.accessoryType = UITableViewCellAccessoryType.None
        thuCell?.accessoryType = UITableViewCellAccessoryType.None
        friCell?.accessoryType = UITableViewCellAccessoryType.None
        satCell?.accessoryType = UITableViewCellAccessoryType.None
    }
    
    func selectDay(day: String) {
        
        if day == "Mon" {
            monCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        if day == "Tue" {
            tueCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        if day == "Wed" {
            wedCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        if day == "Thu" {
            thuCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        if day == "Fri" {
            friCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        if day == "Sat" {
            satCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
    
    }
    
    func selectedDay() -> String {
        
        if monCell?.accessoryType == UITableViewCellAccessoryType.Checkmark {
            return "Mon"
        }else if tueCell?.accessoryType == UITableViewCellAccessoryType.Checkmark {
            return "Tue"
        }else if wedCell?.accessoryType == UITableViewCellAccessoryType.Checkmark {
            return "Wed"
        }else if thuCell?.accessoryType == UITableViewCellAccessoryType.Checkmark {
            return "Thu"
        }else if friCell?.accessoryType == UITableViewCellAccessoryType.Checkmark {
            return "Fri"
        }else if satCell?.accessoryType == UITableViewCellAccessoryType.Checkmark {
            return "Sat"
        }else {
            return "Mon"
        }
        
    }
    
    
    
}
