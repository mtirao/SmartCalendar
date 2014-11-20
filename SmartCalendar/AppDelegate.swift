//
//  AppDelegate.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/11/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if let tabBarController : UITabBarController = self.window?.rootViewController as? UITabBarController {
            let tabBar = tabBarController.tabBar
            if let tabBarItems = tabBar.items {
                let tabBarItemCalendar : UITabBarItem = tabBarItems[0] as UITabBarItem
                let tabBarItemSchool : UITabBarItem = tabBarItems[1] as UITabBarItem
                let tabBarItemCourse : UITabBarItem = tabBarItems[2] as UITabBarItem
                let tabBarItemStudents : UITabBarItem = tabBarItems[3] as UITabBarItem
                let tabBarItemGrades : UITabBarItem = tabBarItems[4] as UITabBarItem
                
                tabBarItemCalendar.selectedImage = UIImage(named: "calendar-selected24")?.imageWithRenderingMode(UIImageRenderingMode.Automatic)
                tabBarItemCalendar.image = UIImage(named: "calendar24")?.imageWithRenderingMode(UIImageRenderingMode.Automatic)
                tabBarItemCalendar.title = "Calendar"
                
                tabBarItemSchool.selectedImage = UIImage(named: "school-selected24")?.imageWithRenderingMode(UIImageRenderingMode.Automatic)
                tabBarItemSchool.image = UIImage(named: "school24")?.imageWithRenderingMode(UIImageRenderingMode.Automatic)
                tabBarItemSchool.title = "School"
                
                tabBarItemCourse.selectedImage = UIImage(named: "teacher-selected24")?.imageWithRenderingMode(UIImageRenderingMode.Automatic)
                tabBarItemCourse.image = UIImage(named: "teacher24")?.imageWithRenderingMode(UIImageRenderingMode.Automatic)
                tabBarItemCourse.title = "Course"
                
                tabBarItemStudents.selectedImage = UIImage(named: "graduate-selected24")?.imageWithRenderingMode(UIImageRenderingMode.Automatic)
                tabBarItemStudents.image = UIImage(named: "graduate24")?.imageWithRenderingMode(UIImageRenderingMode.Automatic )
                tabBarItemStudents.title = "Students"
                
                tabBarItemGrades.selectedImage = UIImage(named: "grades-selected24")?.imageWithRenderingMode(UIImageRenderingMode.Automatic)
                tabBarItemGrades.image = UIImage(named: "grades24")?.imageWithRenderingMode(UIImageRenderingMode.Automatic)
                tabBarItemGrades.title = "Grades"
                
            }
            
            
        }
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
         let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("SmartCalendar", withExtension: "mom")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SmartCalendar.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        
        let options = [NSMigratePersistentStoresAutomaticallyOption : NSNumber(bool: true),
            NSInferMappingModelAutomaticallyOption : NSNumber(bool:true), NSPersistentStoreUbiquitousContentNameKey : "SmartCalendarCloudStore"]
        
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain:"YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

}

