//
//  DataBaseManager.swift
//  FeastVite
//
//  Created by Sai Sri Lakshmi on 17/06/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation

import SQLite3

class DataBaseManager{
    static let shared = DataBaseManager()
    private var dbName = "FeastVite.db"
    private var fileUrl: URL!
    private init() {

        fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbName)
    
    }
    
    func openDatabase() -> OpaquePointer?{
        var db:OpaquePointer? = nil
        if sqlite3_open(self.fileUrl.path, &db) == SQLITE_OK{
            
            print("Connection Successful")
            return db
        }
        return nil
    }
    func createTable(db:OpaquePointer?, createTableStr: String!){
        var createTableStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableStr!, -1, &createTableStatement, nil) == SQLITE_OK{
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("Created Table")
            }
            else{
                print("table not created")
            }
        }
        else{
            print("Create table statement not prepared")
        }
    }
    func closeDatabase(db:OpaquePointer?){
        sqlite3_close(db)
        print("db connection closed")
    }
//    func insertRecord(db)
}
