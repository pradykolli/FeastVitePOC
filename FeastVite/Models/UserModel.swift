//
//  UserModel.swift
//  FeastVite
//
//  Created by Sai Sri Lakshmi on 17/06/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation
import SQLite3
struct UserModel {
    static let shared = UserModel()
    var id:Int64! = nil
    var email:String! = ""
    var password:String! = ""
    init(){}
    init(_ email:String, _ password:String) {
        self.id = -1
        self.email = email
        self.password = password
    }
    
    func createTableUser(){
        let db = DataBaseManager.shared.openDatabase()
        let createTableStr : String! = "CREATE TABLE IF NOT EXISTS User(Id INTEGER PRIMARY KEY NOT NULL, email CHAR(255), password String);"
        DataBaseManager.shared.createTable(db: db, createTableStr: createTableStr)
        DataBaseManager.shared.closeDatabase(db: db)
    }
    func insertRecord(){
        let db = DataBaseManager.shared.openDatabase()
        var statement:OpaquePointer! = nil
        let insertQuery:String! = "INSERT INTO User(email, password) values(?,?);"
        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK{
            
            // bind statements
//            sqlite3_bind_int(statement, 1, Int32(self.id))
            sqlite3_bind_text(statement, 1, self.email, -1, nil)
            sqlite3_bind_text(statement, 1, self.password, -1, nil)
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Successfully inserted record ")
            }else{
                print("Could not insert record ")
            }
        }else{
            print("Insert statement could not be prepared : \(insertQuery!)")
        }
        sqlite3_finalize(statement)
        DataBaseManager.shared.closeDatabase(db: db)
    }
    
    func fetchRecords(email:String){
        let db = DataBaseManager.shared.openDatabase()
        self.createTableUser()
        let fetchStatementStr = "SELECT * FROM User;"
        var fetchStatement : OpaquePointer?
        if sqlite3_prepare_v2(db, fetchStatementStr, -1, &fetchStatement, nil) == SQLITE_OK{
            while(sqlite3_step(fetchStatement) == SQLITE_ROW){
                var user = UserModel()
                user.id = Int64(sqlite3_column_int(fetchStatement, 0))
                user.email = String.init(cString: sqlite3_column_text(fetchStatement, 1))
                print(user.email)
            }
        }
        DataBaseManager.shared.closeDatabase(db: db)
    }
    
    
}
