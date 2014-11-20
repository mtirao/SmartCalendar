//
//  Course.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/13/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import Foundation
import CoreData

class Course: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var schedule: NSSet
    @NSManaged var school: School
    @NSManaged var students: NSSet
    @NSManaged var term: NSSet

}
