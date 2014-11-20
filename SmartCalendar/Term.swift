//
//  Term.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/13/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import Foundation
import CoreData

class Term: NSManagedObject {

    @NSManaged var enddate: String
    @NSManaged var startdate: String
    @NSManaged var course: Course
    @NSManaged var score: NSSet

}
