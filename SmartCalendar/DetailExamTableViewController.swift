//
//  DetailExamTableViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/29/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

class DetailExamTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var selectedStudent : Student?
    var somethingChange = false
    
    @IBOutlet weak var saveBarButton : UIBarButtonItem?
        
    lazy var fetchedResultController : NSFetchedResultsController = {
        return NSFetchedResultsController()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        if somethingChange {
            self.saveBarButton?.enabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let section = self.fetchedResultController.sections![section] as? NSFetchedResultsSectionInfo{
            
            let label = UILabel()
            label.frame = CGRectMake(20, 6, tableView.bounds.size.width, 20)
            label.backgroundColor = UIColor.whiteColor()
            label.textColor = Misc.controlColor()
            label.text = "TERM STARTING IN: " + section.name
            label.font = UIFont.boldSystemFontOfSize(16)
            
            let view = UIView(frame: CGRectMake(0,0, tableView.bounds.size.width, 20))
            view.addSubview(label)
            
            return view
            
        }
        
        return nil
        
    }
    
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("examCell", forIndexPath: indexPath) as UITableViewCell
        
        self.configureCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "examToScoreSegue" {
            let score = segue.destinationViewController as DetailScoreTableViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            score.selectedScore = self.fetchedResultController.objectAtIndexPath(indexPath!) as? Score
            score.fetchedResultController = self.fetchedResultController
        }
        
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        
        self.fetchedResultController.managedObjectContext.save(nil)
        self.saveBarButton?.enabled = false
    }
    
    
    // MARK: - Aux Methods
    func configureCell(cell: UITableViewCell, indexPath:NSIndexPath) {
        
        let score = self.fetchedResultController.objectAtIndexPath(indexPath) as Score
        
        cell.textLabel?.text = "\(score.scoredescription) - \(score.date)"
        cell.detailTextLabel?.text = "Grade \(score.score)"
        
    }
    
    func loadExams() {
        if let student = self.selectedStudent {
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let managedObjectContext = appDelegate.managedObjectContext
            
            let fetchRequest = NSFetchRequest(entityName: "Score")
            let predicate = NSPredicate(format: "student == %@", student)
            let sortDescriptor = NSSortDescriptor(key: "term.startdate", ascending: true)
            fetchRequest.predicate = predicate
            fetchRequest.returnsDistinctResults = true
            
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: "term.startdate", cacheName: nil)
            
            fetchedResultController.delegate = self
            
            fetchedResultController.performFetch(nil)
            
            self.tableView.reloadData()
            
            self.saveBarButton?.enabled = true;
        }else {
            
        }

    }
}
