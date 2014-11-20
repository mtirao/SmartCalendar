//
//  MonthViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/14/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit

class MonthViewController: UIViewController, CalendarDelegate {

    let nameOfMonth : [String] = ["JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAYO", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"]
    let dayOfWeek : [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let currentCalendar = NSCalendar.currentCalendar()
    let flags : NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit | .WeekdayCalendarUnit
    
    var month : NSInteger = 0
    var year : NSInteger = 0
    var date = NSDate()
    var calendar : Matrix?
    
    lazy var popover : UIPopoverController = {
        let storyboard = UIStoryboard(name: "ExamPopOver", bundle: nil)
        let mainView : UINavigationController = storyboard.instantiateViewControllerWithIdentifier("examPopover") as UINavigationController
        
        let pop = UIPopoverController(contentViewController: mainView)
        
        return pop
    }()
    
    @IBOutlet weak var monthLabel : UILabel?
    @IBOutlet weak var yearLabel : UILabel?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        calendar = Matrix(rows: 5, columns: 7)
        
        let w : Int = Int(self.view.frame.size.width / 7)
        let h : Int = Int((self.view.frame.size.height - 160) / 5)
        
        for(var i=0; i<5; i++) {
            for(var j=0; j<7; j++) {
                let x : Int = j * Int(w)
                let y : Int = i * Int(h) + 60
                let tile = DayTileView(frame: CGRect(x: x, y: y, width: w, height: h))
                tile.delegate = self
                tile.backgroundColor = UIColor.whiteColor()
                tile.day = ""
                tile.current = false
                self.view.addSubview(tile)
                calendar![i,j] = tile
            }
        }
        
        self.drawCalendar()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func processMouseDown(tile: DayTileView) {
        let content = popover.contentViewController as UINavigationController
        let view = content.topViewController as NewExamCourseTableViewController
        
        if let day = tile.day?.toInt() {
            
            var comp = NSDateComponents()
            comp.day = day
            comp.month = month
            comp.year = year
            
            let date = currentCalendar.dateFromComponents(comp)
            let weekDay = (currentCalendar.component(.WeekdayCalendarUnit, fromDate: date!)) - 1
            view.selectedWeekday = dayOfWeek[weekDay]
            view.selectedDate = date
            popover.presentPopoverFromRect(tile.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    func drawCalendar() {
        
        let comp = currentCalendar.components(flags, fromDate: self.firstDateOfCurrentMonth())
        self.month = comp.month
        self.year = comp.year
        let weekday : NSInteger = comp.weekday
        
        
        self.monthLabel!.text = self.nameOfMonth[month - 1]
        self.yearLabel!.text = "\(comp.year)"

        
        var isFirstRow = true
        var day = 1
        
        for var i=0; i<5; i++ {
            var ini = 0
            if isFirstRow {
                ini = weekday - 1
                isFirstRow = false
            }

            for var j=ini; j<7; j++ {
                comp.day = day
                let date1 = currentCalendar.dateFromComponents(comp)
                let month1 = currentCalendar .component(.MonthCalendarUnit, fromDate: date1!)
                if month1 == month {
                    let d = calendar![i, j] as DayTileView
                    d.day = "\(day)"
                    d.current = isCurrentDateForMonth(self.month, aDay: day, aYear: self.year)
                }
                day++
            }
        }
        
    }
    
    func firstDateOfCurrentMonth() -> NSDate {
        
        var comp : NSDateComponents = currentCalendar.components(flags, fromDate: self.date)
        comp.day = 1
        
        return currentCalendar.dateFromComponents(comp)!
        
    }
    
    func isCurrentDateForMonth(aMonth:NSInteger, aDay : NSInteger, aYear : NSInteger) -> Bool{
        var comp : NSDateComponents = currentCalendar.components(flags, fromDate: self.date)
        
        return (aDay == comp.day) && (aMonth == comp.month) && (aYear == comp.year)
    }

       
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "newExamSegue" {
            let detail = segue.destinationViewController as UINavigationController
            detail.navigationBar.tintColor = Misc.controlColor()
        }
        
        if segue.identifier == "dayViewSegue" {
            let detail = segue.destinationViewController as UINavigationController
            detail.navigationBar.tintColor = Misc.foregroundColor()
        }
        
    }


}
