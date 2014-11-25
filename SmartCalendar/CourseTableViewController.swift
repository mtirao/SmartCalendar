//
//  CourseTableViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/23/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

class CourseTableViewController: UITableViewController,  NSFetchedResultsControllerDelegate{
    
    var selectedSchool : School?
    
    lazy var courseDetailViewController : DetailCourseTableViewController? = {
        if let controllers = self.splitViewController?.viewControllers {
            let views = controllers as NSArray
            if let view = views.lastObject as? UINavigationController {
                return view.topViewController as? DetailCourseTableViewController
            }
        }
        
        return nil
    }()
    
    lazy var fetchedResultController : NSFetchedResultsController = {
        return NSFetchedResultsController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if let school = self.selectedSchool {
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let managedObjectContext = appDelegate.managedObjectContext
        
            let fetchRequest = NSFetchRequest(entityName: "Course")
            fetchRequest.predicate = NSPredicate(format: "school == %@", school)
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
            fetchRequest.sortDescriptors = [sortDescriptor]
        
            fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
            fetchedResultController.delegate = self
        
            fetchedResultController.performFetch(nil)
        }else {
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let managedObjectContext = appDelegate.managedObjectContext
            
            let fetchRequest = NSFetchRequest(entityName: "Course")
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("courseCell", forIndexPath: indexPath) as UITableViewCell
        
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
            let managedContext = self.fetchedResultController.managedObjectContext
            managedContext.deleteObject(self.fetchedResultController.objectAtIndexPath(indexPath) as Course)
        }
    }
    
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    
    //MARK - This should be defined to whatever is appropieate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let course = self.fetchedResultController.objectAtIndexPath(indexPath) as Course
        
        if let detailView = self.courseDetailViewController {
            detailView.context = self.fetchedResultController.managedObjectContext
            detailView.course = course
            
            
            detailView.nameField?.text = course.name
            
            detailView.nameLabel?.textColor = Misc.foregroundColor()
            detailView.scheduleLabel?.textColor = Misc.foregroundColor()
            detailView.termLabel?.textColor = Misc.foregroundColor()
            
            detailView.nameField?.enabled = true
            
            detailView.saveButton?.enabled = true            
        }
        
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
        
        if segue.identifier == "courseToStudentSegue" {
            let student = segue.destinationViewController as StudentTableViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            student.selectedCourse = self.fetchedResultController.objectAtIndexPath(indexPath!) as? Course
        }
        
        if segue.identifier == "courseToExamSegue" {
            let student = segue.destinationViewController as ExamTableViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            student.selectedCourse = self.fetchedResultController.objectAtIndexPath(indexPath!) as? Course
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
        let course = NSEntityDescription.insertNewObjectForEntityForName(entity!, inManagedObjectContext: context) as Course
        
        course.name = "UNNAMED"
        course.school = selectedSchool!
        
        let mutableSet = selectedSchool?.mutableSetValueForKey("course")
        mutableSet?.addObject(course)
    }
    
    // MARK: - Aux Methods
    func configureCell(cell: UITableViewCell, indexPath:NSIndexPath) {
        
        let course = self.fetchedResultController.objectAtIndexPath(indexPath) as Course
        
        cell.textLabel?.text = course.name
        cell.detailTextLabel?.text = course.school.name
        
    }

}
