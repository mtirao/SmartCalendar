//
//  MainViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/14/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    enum ViewIdentifier {
        case kDayView
        case kWeekView
        case kMonthView
    }
    
    @IBOutlet weak var targetView : UIView?
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //changeViewController(.kMonthView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func changeViewController(whichViewTag : ViewIdentifier) {
        
        self.performSegueWithIdentifier("calendarView", sender: self)
    }

    

}
