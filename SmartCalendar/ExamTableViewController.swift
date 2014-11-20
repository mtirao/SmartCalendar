//
//  ExamViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/29/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit

class ExamTableViewController: StudentTableViewController {
    
    
    lazy var examDetailViewController : DetailExamTableViewController? = {
        if let controllers = self.splitViewController?.viewControllers {
            let views = controllers as NSArray
            if let view = views.lastObject as? UINavigationController {
                return view.topViewController as? DetailExamTableViewController
            }
        }
        
        return nil
    }()
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let student = self.fetchedResultController.objectAtIndexPath(indexPath) as Student
        
        if let detailView = self.examDetailViewController {
            detailView.selectedStudent = student
            detailView.loadExams()
        }
        
    }

}
