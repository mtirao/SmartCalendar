//
//  Schedule.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/13/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import Foundation
import CoreData

class Schedule: NSManagedObject {

    @NSManaged var classroom: String
    @NSManaged var endtime: String
    @NSManaged var note: String
    @NSManaged var starttime: String
    @NSManaged var weekday: String
    @NSManaged var course: Course

}
