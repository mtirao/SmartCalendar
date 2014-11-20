//
//  Color.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/13/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import Foundation
import CoreData

class Color: NSManagedObject {

    @NSManaged var blue: NSNumber
    @NSManaged var green: NSNumber
    @NSManaged var imagename: String
    @NSManaged var red: NSNumber
    @NSManaged var school: School

}
