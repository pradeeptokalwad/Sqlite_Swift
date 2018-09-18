//
//  DateExtensions.swift
//  Snapwork_Assignment
//
//  Created by webwerks on 9/17/18.
//  Copyright © 2018 Pradeep. All rights reserved.
//

import Foundation

extension Date {
    
    func currentYear() -> Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }
    
    func currentMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let strMonth = dateFormatter.string(from: self)
        return strMonth
    }
    
    func monthList() -> [String] {
        let dateFormatter = DateFormatter()
        return dateFormatter.shortMonthSymbols
    }
    
    func yearList() -> [String] {
        var years:[String] = [String]()
        let year = currentYear()
        for i in stride(from: 5, to: 0, by: -1) {
            years.append("\(year-i)")
        }
        years.append("\(year)")
        for i in 1...5 {
            years.append("\(year+i)")
        }
        return years
    }
    
    func dateFromMonthAndYear(year:Int, month:Int, day:Int = 1) -> Date {
        let c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = 1
        let date:Date = (NSCalendar(identifier: NSCalendar.Identifier.gregorian)?.date(from: c as DateComponents))!
        return date
    }
    
    func stringFromDateWithMonthAndYear(year:Int, month:Int, day:Int = 1) -> String {
        let c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        let date:Date = (NSCalendar(identifier: NSCalendar.Identifier.gregorian)?.date(from: c as DateComponents))!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let strMonth = dateFormatter.string(from: date)
        return strMonth
    }
}
