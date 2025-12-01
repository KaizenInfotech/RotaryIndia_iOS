//
//  CommonSqlite.swift
//  TouchBase
//
//  Created by Umesh on 10/03/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import Foundation
class CommonSqliteClass
{
    //1.
    func functionForUpdateGroupMasterandModuleDataMasterTable(_ stringIncreaseorDecrease:String)
    {

        /*----------------------------------------------------------------------------------------------------*/
        let stringGroupId:String=UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        //var stringModuleId:String=UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        
        // open database
        databasePath = fileURL.path
        print("database path : \(databasePath)")
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
        }
        else
        {
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        if (contactDB?.open())!
        {
            /*-----------------------------------------*/
            let querySQL = "select notificationCount from  GROUPMASTER  WHERE grpId = \(stringGroupId)"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            var muarrayTemp:NSMutableArray=NSMutableArray()
            var varGetValues:String!=""
            while results?.next() == true
            {
            print(results?.string(forColumn: "notificationCount"))
             varGetValues=results?.string(forColumn: "notificationCount")
            }
            /*-----------------------------------------*/
            //if + then plus and - then minus
           /// print(varGetValues)
            var varValuesNew:Int=0
            if(stringIncreaseorDecrease=="+")
            {
                varValuesNew=(Int(varGetValues) ?? 0)+1
            }
            else
            {
                varValuesNew=(Int(varGetValues) ?? 0)-1
            }
            
            /*-----------------------------------------------------*/
            /*
            let insertSQL = "UPDATE  GROUPMASTER SET notificationCount='\(varValuesNew)' WHERE grpId = \(stringGroupId)  "
            var result = contactDB?.executeStatements(insertSQL)
            if (result != nil)
            {
                
                /*-----------------------------------------------------*/
                let querySQLa = "select notificationCount  from  MODULE_DATA_MASTER  WHERE groupId = \(stringGroupId) and moduleId = \(stringModuleId)"
                print(querySQLa)
                let resultsa:FMResultSet? = contactDB?.executeQuery(querySQLa,withArgumentsInArray: nil)
                var muarrayTempa:NSMutableArray=NSMutableArray()
                var varGetValuesa:String!=""
                while resultsa?.next() == true
                {
                    print(resultsa?.stringForColumn("notificationCount"))
                    varGetValuesa=resultsa?.stringForColumn("notificationCount")
                }
                /*-----------------------------------------------------*/
                //if + then plus and - then minus
                /// print(varGetValues)
                var varValuesNewa:Int=0
                if(stringIncreaseorDecrease=="+")
                {
                    varValuesNewa=Int(varGetValuesa)!+1
                }
                else
                {
                    varValuesNewa=Int(varGetValuesa)!-1
                }
                /*-----------------------------------------------------*/
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
                let insertSQL = "UPDATE  MODULE_DATA_MASTER SET notificationCount='\(varValuesNewa)' WHERE groupId = \(stringGroupId) and moduleId = \(stringModuleId) "
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            */
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
    }
    //2.
    func functionForDeleteEntityandGroup()
    {
        
        /*----------------------------------------------------------------------------------------------------*/
       
       
        let stringGroupId:String=UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
        }
        else
        {
            
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        if (contactDB?.open())!
        {
         /*
              groupId , moduleId
             */
        /*-----------------------------------------------------*/
            let insertSQL = "DELETE FROM  GROUPMASTER  WHERE grpId = \(stringGroupId)  "
            let result = contactDB?.executeStatements(insertSQL)
            if (result != nil)
            {
               print("Error")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
    }

}
