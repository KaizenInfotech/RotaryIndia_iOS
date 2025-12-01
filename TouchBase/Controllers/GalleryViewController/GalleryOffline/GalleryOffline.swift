//
//  GalleryOffline.swift
//  TouchBase
//
//  Created by Umesh on 19/01/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class GalleryOffline: NSObject
{
    //1.--Gallery «««««««««-----ALBUM------»»»»»»» insert
    func functionForSaveDataInlocalGalleryAlbum (_ arrdata:NSArray)
    {
        var databasePath : String
        print(arrdata);
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
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        if (contactDB?.open())!
        {
            for i in 0 ..< arrdata.count-1
            {
                let  dict = arrdata[i] as! NSDictionary
                let insertSQL = "INSERT INTO ReplicaInfo (masterUID,albumId,title,description,image,groupId,isAdmin,moduleId) VALUES ('\(dict.value(forKey: "masterUID")as! String)', '\(dict.object(forKey: "albumId") as! Int)', '\(dict.object(forKey: "title") as! String)', '\(dict.object(forKey: "description") as! String)', '\(dict.object(forKey: "image") as! String)', '\(dict.object(forKey: "groupId") as! Int)''\(dict.object(forKey: "isAdmin") as! String)','\(dict.object(forKey: "moduleId") as! String)')"
               
                print(insertSQL)
                print(dict)
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    print("success saved replicaoof")
                    print(databasePath);
                }
            }
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
    }
     /*2.«««««««««««««««------»»»»»»»»»»»»»»*/
}
