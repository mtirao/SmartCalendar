//
//  DetailScoreTableViewController.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 10/26/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

class DetailScoreTableViewController: UIViewController {

    var selectedScore : Score?
    var fetchedResultController : NSFetchedResultsController?
    
    @IBOutlet weak var examDescription : UILabel?
    @IBOutlet weak var scoreField : UITextField?
    @IBOutlet weak var scoreDetailField : UILabel?
    @IBOutlet weak var examView : ExamView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        if let score = selectedScore {
            examDescription?.text = "\(score.scoredescription)"
            scoreField?.text = "\(score.score)"
            
            scoreDetailField?.text = scoreDetailField!.text! + "\(score.student.lastname), \(score.student.name)"
            examView?.selectedScore = score
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        if let score = selectedScore {
            
            if let scoreInt = scoreField!.text!.toInt() {
                score.score = scoreField!.text!
            }else {
                let alert: UIAlertController = UIAlertController(title: "Error", message: "Only numbers are accepted. Assuming default.", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:
                    {(s1 : UIAlertAction!) -> Void in NSLog("Ok Button")})
                alert.addAction(okAction)
                alert.presentViewController(alert, animated: true, completion: {})
                score.score = "0"
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func deleteButton(sender: AnyObject) {
        if let context = fetchedResultController?.managedObjectContext {
            context.deleteObject(selectedScore!)
            self.navigationController?.popToRootViewControllerAnimated(true);
        }
    }
}
