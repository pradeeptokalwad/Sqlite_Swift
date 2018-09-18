//
//  SQLiteOperations.swift
//  Snapwork_Assignment
//
//  Created by webwerks on 9/17/18.
//  Copyright © 2018 Pradeep. All rights reserved.
//

import Foundation
import SQLite3
typealias JSONDict = [String : Any]

class SQLiteOperations {
    
    static let shared = SQLiteOperations()
    
    internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
    internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

    var db: OpaquePointer?

    func openDB()-> Bool {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("event.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return false
        }
        return true
    }
    
    func saveEvent(title:String, eventDescr:String, eventDate:String, isUpdate:Bool = false) -> Bool {
        
        if openDB() {
            var stmt: OpaquePointer?

            let queryString =   isUpdate == true ? "UPDATE events SET event_title = ?, event_description = ? WHERE event_Date = ?" :"INSERT INTO events (event_title, event_description, event_Date) VALUES (?,?,?)"
            
            if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert: \(errmsg)")
                return false
            }
            
            if sqlite3_bind_text(stmt, 1, title, -1, SQLITE_TRANSIENT) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding title: \(errmsg)")
            }
            
            if sqlite3_bind_text(stmt, 2, eventDescr, -1, SQLITE_TRANSIENT) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding eventDate: \(errmsg)")
            }

            if sqlite3_bind_text(stmt, 3, eventDate, -1, SQLITE_TRANSIENT) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding eventDescr: \(errmsg)")
            }

            if sqlite3_step(stmt) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure inserting foo: \(errmsg)")
                return false

            }

            return true
        }
        return false

    }

    func fetchDataForDate(date:String) -> JSONDict? {
        
        var result:JSONDict?
        
        var stmt:OpaquePointer? = nil
        
        let strExec = "select event_title,event_description,event_Date from events where event_Date = '\(date)'"
        
        if openDB()
        {
            if (sqlite3_prepare_v2(db, strExec , -1, &stmt, nil) == SQLITE_OK)
            {
                while (sqlite3_step(stmt) == SQLITE_ROW)
                {
                    result = JSONDict()
                    result!["event_title"] = String(cString: sqlite3_column_text(stmt, 0))
                    result!["event_description"] = String(cString: sqlite3_column_text(stmt, 1))
                    result!["event_Date"] = String(cString: sqlite3_column_text(stmt, 2))
                    
                }
                sqlite3_finalize(stmt)
            }
            sqlite3_close(db)
        }
        return result
    }
}
