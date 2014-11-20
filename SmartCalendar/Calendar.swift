//
//  Calendar.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/13/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import Foundation
import CoreData

class Calendar: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var reminderText: String
    @NSManaged var time: String

}
