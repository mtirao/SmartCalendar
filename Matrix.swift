//
//  Matrix.swift
//  SmartCalendar
//
//  Created by Marcos Tirao on 9/16/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

import UIKit

class Matrix: NSObject {
    
    let rows: Int, columns : Int
    var grid : [UIView?]
    
    init(rows : Int, columns : Int) {
        self.rows = rows
        self.columns = columns
        
        grid = Array(count: rows * columns, repeatedValue: nil)
        
    }
   
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> UIView? {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
