//
//  Score.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/13/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import Foundation
import CoreData

class Score: NSManagedObject {

    @NSManaged var date: String
    @NSManaged var number: NSNumber
    @NSManaged var score: String
    @NSManaged var scoredescription: String
    @NSManaged var time: String
    @NSManaged var student: Student
    @NSManaged var term: Term

}
