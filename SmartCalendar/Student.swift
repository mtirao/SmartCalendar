//
//  Student.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/13/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import Foundation
import CoreData

class Student: NSManagedObject {

    @NSManaged var email: String
    @NSManaged var lastname: String
    @NSManaged var name: String
    @NSManaged var course: Course
    @NSManaged var score: NSSet

}
