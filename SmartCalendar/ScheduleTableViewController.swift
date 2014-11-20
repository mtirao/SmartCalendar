//
//  ScheduleTableViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/29/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

class ScheduleTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var selectedCourse : Course?

    
    lazy var fetchedResultController : NSFetchedResultsController = {
        return NSFetchedResultsController()
    }()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if let course = self.selectedCourse {
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let managedObjectContext = appDelegate.managedObjectContext
            
            let fetchRequest = NSFetchRequest(entityName: "Schedule")
            fetchRequest.predicate = NSPredicate(format: "course == %@", course)
            let sortDescriptor = NSSortDescriptor(key: "starttime", ascending: true)
            
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
            
            fetchedResultController.delegate = self
            
            fetchedResultController.performFetch(nil)
        }else {
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let managedObjectContext = appDelegate.managedObjectContext
            
            let fetchRequest = NSFetchRequest(entityName: "Schedule")
            let sortDescriptor = NSSortDescriptor(key: "starttime", ascending: true)
            
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
            
            fetchedResultController.delegate = self
            
            fetchedResultController.performFetch(nil)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if let sections = fetchedResultController.sections {
            return sections.count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultController.sections![section].numberOfObjects
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath) as UITableViewCell
        
        self.configureCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        if type == NSFetchedResultsChangeType.Insert {
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: UITableViewRowAnimation.Fade)
        }else if type == NSFetchedResultsChangeType.Delete {
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: UITableViewRowAnimation.Fade)
        }
        
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case NSFetchedResultsChangeType.Insert:
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Delete:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Update:
            self.configureCell(self.tableView.cellForRowAtIndexPath(indexPath!)!, indexPath: indexPath!)
        case NSFetchedResultsChangeType.Move:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        default:
            NSLog("This should not happen")
        }
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "scheduleToDetailSegue" {
            let detail = segue.destinationViewController as DetailScheduleTableViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            detail.selectedSchedule = self.fetchedResultController.objectAtIndexPath(indexPath!) as? Schedule
            
        }
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if let course = selectedCourse {
            return true;
        }else {
            return false;
        }
        
    }
    
    // MARK: - Action
    @IBAction func editButton(sender: AnyObject) {
        
        if self.tableView.editing {
            let button = sender as UIBarButtonItem;
            button.title = "Edit"
            self.tableView .setEditing(false, animated: true)
        }else {
            let button = sender as UIBarButtonItem;
            button.title = "Done"
            self.tableView .setEditing(true, animated: true)
        }
        
    }
    
    @IBAction func addButton(sender: AnyObject) {
        
        let context = self.fetchedResultController.managedObjectContext
        let entity : String? = self.fetchedResultController.fetchRequest.entity?.name
        
        let schedule = NSEntityDescription.insertNewObjectForEntityForName(entity!, inManagedObjectContext: context) as Schedule
        
        schedule.classroom = ""
        schedule.note = ""
        schedule.starttime = "12:00"
        schedule.endtime = "12:00"
        schedule.weekday = "Mon"
        schedule.course = selectedCourse!
        
        let mutableSet = selectedCourse?.mutableSetValueForKey("schedule")
        mutableSet?.addObject(schedule)
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    // MARK: - Aux Methods
    func configureCell(cell: UITableViewCell, indexPath:NSIndexPath) {
        
        let schedule = self.fetchedResultController.objectAtIndexPath(indexPath) as Schedule
        
        cell.textLabel?.text = "\(schedule.weekday) \(schedule.starttime) - \(schedule.endtime) "
        
    }

}
