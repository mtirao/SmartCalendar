//
//  School.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/13/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import Foundation
import CoreData

class School: NSManagedObject {

    @NSManaged var address: String
    @NSManaged var city: String
    @NSManaged var country: String
    @NSManaged var name: String
    @NSManaged var color: Color
    @NSManaged var course: NSSet

}
