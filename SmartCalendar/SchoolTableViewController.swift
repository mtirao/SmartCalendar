//
//  SchoolTableViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/22/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

class SchoolTableViewController: UITableViewController,  NSFetchedResultsControllerDelegate{
    
    @IBOutlet weak var editButton : UIBarButtonItem?
    
    lazy var schoolDetailViewController : DetailSchoolTableViewController? = {
        if let controllers = self.splitViewController?.viewControllers {
            let views = controllers as NSArray
            if let view = views.lastObject as? UINavigationController {
                return view.topViewController as? DetailSchoolTableViewController
            }
        }
        
        return nil
    }()
    
    lazy var fetchedResultController : NSFetchedResultsController = {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "School")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let resultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        resultController.delegate = self
        
        return resultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultController.performFetch(nil)
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("schoolCell", forIndexPath: indexPath) as UITableViewCell

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

    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let school = self.fetchedResultController.objectAtIndexPath(indexPath) as School
        
        if let schoolView = self.schoolDetailViewController {
            schoolView.context = self.fetchedResultController.managedObjectContext
            schoolView.school = school
            
            schoolView.nameField?.text = school.name
            schoolView.addressField?.text = school.address
            schoolView.cityField?.text = school.city
            schoolView.countryField?.text = school.country
            
            schoolView.saveButton?.enabled = true;
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
            NSLog("This should happen")
        }
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "schoolToCourseSegue" {
            let course = segue.destinationViewController as CourseTableViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            course.selectedSchool = self.fetchedResultController.objectAtIndexPath(indexPath!) as? School
            
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
        let school = NSEntityDescription.insertNewObjectForEntityForName(entity!, inManagedObjectContext: context) as School
        
        school.name = "UNNAMED"
        school.city = ""
        school.country = ""
        school.address = ""
        
    }
    
    // MARK: - Aux Methods
    func configureCell(cell: UITableViewCell, indexPath:NSIndexPath) {
        
        let school = self.fetchedResultController.objectAtIndexPath(indexPath) as School
        
        cell.textLabel?.text = school.name
        cell.detailTextLabel?.text = school.address
        
    }

}
