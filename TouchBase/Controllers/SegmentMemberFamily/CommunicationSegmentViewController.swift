//
//  CommunicationSegmentViewController.swift
//  TouchBase
//
//  Created by rajendra on 26/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class CommunicationSegmentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableCommunicationList: UITableView!
    var muarrayCommunicationList:NSMutableArray=NSMutableArray()
    var muarrayEventDetails:NSMutableArray=NSMutableArray()
    
    var muDictionaryForEventDetails:NSMutableDictionary = NSMutableDictionary()
    var muarrayEventsDetailSendToNextScreen:NSMutableArray=NSMutableArray()
    var EventCountNotification:NSMutableArray=NSMutableArray()
    
    var muDictionaryForNewsLetterDetails:NSMutableDictionary=NSMutableDictionary()
    var NewsLetterCountNotification:NSMutableArray=NSMutableArray()
    var muarrayNewsLetterDetailSendToNextScreen:NSMutableArray=NSMutableArray()
    
    
    var varNewCount:Int=0
    var varEventCount:Int=0
    
    
    
    var varGroupID:String!=""
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("-------------CommunicationSegmentViewController")
        varGroupID = UserDefaults.standard.value(forKey: "GrpID") as! String
        muarrayCommunicationList = ["Newsletters","Events"]
        functionForGetNewsLetterDetails()
        functionForGetEventDetails()
        tableCommunicationList.reloadData()
        
        
        print(muarrayEventsDetailSendToNextScreen.count)
        print(self.muarrayEventsDetailSendToNextScreen)
       // print(varlabelValues)
        //let varGroupID = muarrayEventsDetailSendToNextScreen.valueForKey("grpID").objectAtIndex(indexPath.row) as! String
        //print(varGroupID)
        //let objClubEventsListVzxcviewController = self.storyboard!.instantiateViewController(withIdentifier: "zxcv") as! ClubEventsListViewConzxcvtroller
       // objClubEventsListViewCzxcvontroller.varGroupID=varGroupID
       // self.navigationController?.pushViewController(objClubEventsxcvzListViewController, animated: true)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    //row_GetDistricCommunicationtEventList
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- Server Calling
    //Event Details
    func functionForGetEventDetails()
    {
        
        
        print("this is Communication segment screen !!!!!")
        let completeURL = baseUrl+row_GetDistricCommunicationtEventList
        let parameterst = [
            "grpID": varGroupID
        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            
            print(response)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            var dictResponseData:NSDictionary=NSDictionary()
            dictResponseData = response as! NSDictionary
            print(dictResponseData)
            if((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                for i in 0..<(((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "grpID")! as AnyObject).count
                {
                    
                    /*"eventID": "12",
                     "eventImg": "http://www.rosteronwheels.com/Documents/Event/Group2765/thumb/06062017033639PM.png",
                     "eventTitle": "purple purl",
                     "eventDesc": "Cross to red",
                     "eventDateTime": "12 Jun 2017 03:37 PM",
                     "goingCount": "0",
                     "maybeCount": "0",
                     "notgoingCount": "0",
                     "venue": "Jaipur",
                     "myResponse": "0",
                     "filterType": "3",
                     "grpID": "2765",
                     "grpAdminId": "51272",
                     "isRead": "0",
                     "venueLat": "26.8969949",
                     "venueLon": "75.8104871"
                     */
                    
                    let varEventID=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "eventID")! as AnyObject).object(at: i)) as! String
                    let varEventImg=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "eventImg")! as AnyObject).object(at: i)) as! String
                    let varEventTitle=(((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "eventTitle")! as AnyObject).object(at: i) as! String
                    let varEventDesc=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "eventDesc")! as AnyObject).object(at: i)) as! String
                    let varEventDateTime=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "eventDateTime")! as AnyObject).object(at: i)) as! String
                    let varGoingCount=(((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "goingCount")! as AnyObject).object(at: i) as! String
                    let varMaybeCount=(((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "maybeCount")! as AnyObject).object(at: i) as! String
                    let varNotgoingCount=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "notgoingCount")! as AnyObject).object(at: i)) as! String
                    let varVenue=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "venue")! as AnyObject).object(at: i)) as! String
                    let varMyResponse=(((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "myResponse")! as AnyObject).object(at: i) as! String
                    let varFilterType=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "filterType")! as AnyObject).object(at: i)) as! String
                    let varGrpID=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "grpID")! as AnyObject).object(at: i)) as! String
                    let varGrpAdminId=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "grpAdminId")! as AnyObject).object(at: i)) as! String
                    let varIsRead=(((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "isRead")! as AnyObject).object(at: i) as! String
                    let varVenueLat=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "venueLat")! as AnyObject).object(at: i)) as! String
                    let varVenueLon=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "venueLon")! as AnyObject).object(at: i)) as! String
                    
                    self.EventCountNotification.add(varIsRead)
                    print("55555555555555555555555555555555555555555",self.EventCountNotification.count)
                    self.varEventCount=self.EventCountNotification.count
                    
                    self.muDictionaryForEventDetails = ["eventID": varEventID,
                        "eventImg": varEventImg,
                        "eventTitle": varEventTitle,
                        "eventDesc": varEventDesc,
                        "eventDateTime": varEventDateTime,
                        "goingCount": varGoingCount,
                        "maybeCount": varMaybeCount,
                        "notgoingCount": varNotgoingCount,
                        "venue": varVenue,
                        "myResponse": varMyResponse,
                        "filterType": varFilterType,
                        "grpID": varGrpID,
                        "grpAdminId": varGrpAdminId,
                        "isRead": varIsRead,
                        "venueLat": varVenueLat,
                        "venueLon": varVenueLon]
                    
                    
                    
                    self.muarrayEventsDetailSendToNextScreen.add(self.muDictionaryForEventDetails)
                }
                self.DeleteDataInlocal()
                self.SaveDataInlocal(self.muarrayEventsDetailSendToNextScreen)
                self.tableCommunicationList.reloadData()
            }
            SVProgressHUD.dismiss()
        }
        })
    }
    
    //NewsLetters Details
    func functionForGetNewsLetterDetails()
    {
        let completeURL = baseUrl+row_GetDistrictCommunicationNewsLetterList
        let parameterst = [
            "grpID": varGroupID
        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            
            print(response)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            var dictResponseData:NSDictionary=NSDictionary()
            dictResponseData = response as! NSDictionary
            print(dictResponseData)
            if((dictResponseData.object(forKey: "TBPublicNewsletterList")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                for i in 0..<(((dictResponseData.value(forKey: "TBPublicNewsletterList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "ebulletinID")! as AnyObject).count
                {
                    
                    /*"ebulletinID": "88",
                     "ebulletinTitle": "News",
                     "ebulletinlink": "www.bestcollegereviews.org/top/online-colleges",
                     "ebulletinType": "Link",
                     "filterType": "0",
                     "createDateTime": "19 Jul 2017 03:17 PM",
                     "publishDateTime": "19 Jul 2017 03:40 PM",
                     "expiryDateTime": "20 Jul 2017 03:17 PM",
                     "isAdmin": "No",
                     "isRead": "0"
                     
                     */
                    
                    let ebulletinID=((((dictResponseData.value(forKey: "TBPublicNewsletterList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "ebulletinID")! as AnyObject).object(at: i)) as! String
                    let ebulletinTitle=((((dictResponseData.value(forKey: "TBPublicNewsletterList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "ebulletinTitle")! as AnyObject).object(at: i)) as! String
                    let ebulletinlink=(((dictResponseData.value(forKey: "TBPublicNewsletterList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "ebulletinlink")! as AnyObject).object(at: i) as! String
                    let ebulletinType=(((dictResponseData.value(forKey: "TBPublicNewsletterList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "ebulletinType")! as AnyObject).object(at: i) as! String
                    let filterType=((((dictResponseData.value(forKey: "TBPublicNewsletterList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "filterType")! as AnyObject).object(at: i)) as! String
                    let createDateTime=((((dictResponseData.value(forKey: "TBPublicNewsletterList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "createDateTime")! as AnyObject).object(at: i)) as! String
                    let publishDateTime=(((dictResponseData.value(forKey: "TBPublicNewsletterList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "publishDateTime")! as AnyObject).object(at: i) as! String
                    let expiryDateTime=(((dictResponseData.value(forKey: "TBPublicNewsletterList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "expiryDateTime")! as AnyObject).object(at: i) as! String
                    let isAdmin=(((dictResponseData.value(forKey: "TBPublicNewsletterList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "isAdmin")! as AnyObject).object(at: i) as! String
                    let isRead=((((dictResponseData.value(forKey: "TBPublicNewsletterList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "isRead")! as AnyObject).object(at: i)) as! String
                    
                    
                    self.NewsLetterCountNotification.add(ebulletinID)
                    print("66666666666666666666666666666666",self.NewsLetterCountNotification.count)
                    
                    self.varNewCount = self.NewsLetterCountNotification.count
                    
                    self.muDictionaryForNewsLetterDetails = ["ebulletinID": ebulletinID,
                        "ebulletinTitle": ebulletinTitle,
                        "ebulletinlink": ebulletinlink,
                        "ebulletinType": ebulletinType,
                        "filterType": filterType,
                        "createDateTime": createDateTime,
                        "publishDateTime": publishDateTime,
                        "expiryDateTime": expiryDateTime,
                        "isAdmin": isAdmin,
                        "isRead": isRead]
                    
                    self.muarrayNewsLetterDetailSendToNextScreen.add(self.muDictionaryForNewsLetterDetails)
                }
                self.DeleteDataInlocalNewsLetter()
                self.SaveDataInlocalNewsLetter(self.muarrayNewsLetterDetailSendToNextScreen)
                self.tableCommunicationList.reloadData()
            }
            SVProgressHUD.dismiss()
        }
        })
    }
    
    
    
    
    
    //MARK:- Table Method
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayCommunicationList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell : CommunicationSegmentTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CommunicationSegmentTableViewCell") as! CommunicationSegmentTableViewCell
        
        if(muarrayCommunicationList.count>0)
        {
            SVProgressHUD.dismiss()
        cell.labelValue.text = muarrayCommunicationList.object(at: indexPath.row) as! String
        if(cell.labelValue.text! == "Newsletters")
        {
            if(self.NewsLetterCountNotification.count>0)
            {
                //cell.buttonNotificationCount.titleLabel?.text! = String(varEventCount)
                cell.buttonNotificationCount.setTitle(String(varNewCount),  for: UIControl.State.normal)
            }
            else
            {
                cell.buttonNotificationCount.setTitle("0",  for: UIControl.State.normal)
            }
            
        }
        else if(cell.labelValue.text! == "Events")
        {
            if(self.EventCountNotification.count>0)
            {
                cell.buttonNotificationCount.setTitle(String(varEventCount),  for: UIControl.State.normal)
            //cell.buttonNotificationCount.titleLabel?.text! = String(varEventCount)
            }
            else
            {
             cell.buttonNotificationCount.setTitle("0",  for: UIControl.State.normal)
            }
        }
        }
        return cell as CommunicationSegmentTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let varlabelValues = muarrayCommunicationList.object(at: indexPath.row) as! String
        
        if(indexPath.row == 0)
        {
            print(muarrayEventsDetailSendToNextScreen.count)
            print(self.muarrayEventsDetailSendToNextScreen)
            print(varlabelValues)
            //let varGroupID = muarrayEventsDetailSendToNextScreen.valueForKey("grpID").objectAtIndex(indexPath.row) as! String
            //print(varGroupID)
            let objNewsLetterListViewController = self.storyboard!.instantiateViewController(withIdentifier: "NewsLetterListViewController") as! NewsLetterListViewController
            objNewsLetterListViewController.varGroupID=varGroupID
            self.navigationController?.pushViewController(objNewsLetterListViewController, animated: true)
        }
        
        if(indexPath.row == 1)
        {
            print(muarrayEventsDetailSendToNextScreen.count)
            print(self.muarrayEventsDetailSendToNextScreen)
            print(varlabelValues)
            //let varGroupID = muarrayEventsDetailSendToNextScreen.valueForKey("grpID").objectAtIndex(indexPath.row) as! String
            //print(varGroupID)
            let objClubEventsListViewController = self.storyboard!.instantiateViewController(withIdentifier: "ClubEventsListViewController") as! ClubEventsListViewController
            objClubEventsListViewController.varGroupID=varGroupID
            self.navigationController?.pushViewController(objClubEventsListViewController, animated: true)
        }
        else
        {
        }
        
    }
    
    //eventID, eventImg,eventTitle,eventDesc,eventDateTime,goingCount,maybeCount,notgoingCount,venue,myResponse,filterType,grpID,grpAdminId,isRead,venueLat,venueLon
    
    /*---------------Save / Delete / update / fetch -------------------DPK----------------------------*/
    //Save Data
    func SaveDataInlocal (_ arrdata:NSMutableArray){
        var databasePath : String
        print(arrdata);
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            
            for i in 0 ..< arrdata.count {
                
                
                let eventID = (arrdata.value(forKey: "eventID") as AnyObject).object(at: i) as? String
                let eventImg = (arrdata.value(forKey: "eventImg") as AnyObject).object(at: i) as! String
                let eventTitle = (arrdata.value(forKey: "eventTitle") as AnyObject).object(at: i) as! String
                let eventDesc = (arrdata.value(forKey: "eventDesc") as AnyObject).object(at: i) as! String
                let eventDateTime = (arrdata.value(forKey: "eventDateTime") as AnyObject).object(at: i) as! String
                let goingCount = (arrdata.value(forKey: "goingCount") as AnyObject).object(at: i) as! String
                let maybeCount = (arrdata.value(forKey: "maybeCount") as AnyObject).object(at: i) as! String
                let notgoingCount = (arrdata.value(forKey: "notgoingCount") as AnyObject).object(at: i) as! String
                let venue = (arrdata.value(forKey: "venue") as AnyObject).object(at: i) as! String
                let myResponse = (arrdata.value(forKey: "myResponse") as AnyObject).object(at: i) as! String
                let filterType = (arrdata.value(forKey: "filterType") as AnyObject).object(at: i) as! String
                let grpID = (arrdata.value(forKey: "grpID") as AnyObject).object(at: i) as! String
                let grpAdminId = (arrdata.value(forKey: "grpAdminId") as AnyObject).object(at: i) as! String
                let isRead = (arrdata.value(forKey: "isRead") as AnyObject).object(at: i) as! String
                let venueLat = (arrdata.value(forKey: "venueLat") as AnyObject).object(at: i) as! String
                let venueLon = (arrdata.value(forKey: "venueLon") as AnyObject).object(at: i) as! String
                
                print(eventID,eventImg,eventTitle,grpID)
                
                
                let insertSQL = "INSERT INTO Club_Events_Details (masterUID , eventID, eventImg,eventTitle,eventDesc,eventDateTime,goingCount,maybeCount,notgoingCount,venue,myResponse,filterType,grpID,grpAdminId,isRead,venueLat,venueLon) VALUES ('\(mainMemberID!)', '\(eventID)', '\(eventImg)', '\(eventTitle)', '\(eventDesc)', '\(eventDateTime)', '\(goingCount)', '\(maybeCount)','\(notgoingCount)','\(venue)','\(myResponse)','\(filterType)','\(grpID)','\(grpAdminId)','\(isRead)','\(venueLat)','\(venueLon)')"
                print(insertSQL)
                
                let result = contactDB?.executeStatements(insertSQL)
                
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("success saved")
                    print(databasePath);
                }
            }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
    }
    
    //DeleteData
    func DeleteDataInlocal()
    {
        var databasePath : String
        //  print(arrdata);
        
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            //for i in 0 ..< arrdata.count {
            // let  dict = arrdata[i] as! NSDictionary
            let insertSQL = "DELETE FROM Club_Events_Details" // WHERE profileID = '\(dict.objectForKey("serviceDirId") as! String)'
            print(insertSQL)
            let result = contactDB?.executeStatements(insertSQL)
            if (result == nil) {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            } else {
                print("success saved")
                print(databasePath);
            }
            // }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
    }
    
    
    /****************************************************************************************/
    
    //NewsLetter Save Data
    func SaveDataInlocalNewsLetter(_ arrdata:NSMutableArray){
        var databasePath : String
        print(arrdata);
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            
            for i in 0 ..< arrdata.count {
                
                let ebulletinID = (arrdata.value(forKey: "ebulletinID") as AnyObject).object(at: i) as! String
                let ebulletinTitle = (arrdata.value(forKey: "ebulletinTitle") as AnyObject).object(at: i) as! String
                let ebulletinlink = (arrdata.value(forKey: "ebulletinlink") as AnyObject).object(at: i) as! String
                let ebulletinType = (arrdata.value(forKey: "ebulletinType") as AnyObject).object(at: i) as! String
                let filterType = (arrdata.value(forKey: "filterType") as AnyObject).object(at: i) as! String
                let createDateTime = (arrdata.value(forKey: "createDateTime") as AnyObject).object(at: i) as! String
                let publishDateTime = (arrdata.value(forKey: "publishDateTime") as AnyObject).object(at: i) as! String
                let expiryDateTime = (arrdata.value(forKey: "expiryDateTime") as AnyObject).object(at: i) as! String
                let isAdmin = (arrdata.value(forKey: "isAdmin") as AnyObject).object(at: i) as! String
                let isRead = (arrdata.value(forKey: "isRead") as AnyObject).object(at: i) as! String
                print(ebulletinID,ebulletinTitle,ebulletinType)
                let insertSQL = "INSERT INTO Club_NewsLetter_Details (masterUID , ebulletinID, ebulletinTitle,ebulletinlink,ebulletinType,filterType,createDateTime,publishDateTime,expiryDateTime,isAdmin,isRead,grpID) VALUES ('\(mainMemberID!)', '\(ebulletinID)', '\(ebulletinTitle)', '\(ebulletinlink)', '\(ebulletinType)', '\(filterType)', '\(createDateTime)', '\(publishDateTime)','\(expiryDateTime)','\(isAdmin)','\(isRead)','\(varGroupID!)')"
                print(insertSQL)
                
                
                let result = contactDB?.executeStatements(insertSQL)
                
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("success saved")
                    print(databasePath);
                }
            }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
    }
    
    //DeleteData
    func DeleteDataInlocalNewsLetter()
    {
        var databasePath : String
        //  print(arrdata);
        
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            //for i in 0 ..< arrdata.count {
            // let  dict = arrdata[i] as! NSDictionary
            let insertSQL = "DELETE FROM Club_NewsLetter_Details" // WHERE profileID = '\(dict.objectForKey("serviceDirId") as! String)'
            print(insertSQL)
            let result = contactDB?.executeStatements(insertSQL)
            if (result == nil) {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            } else {
                print("success saved")
                print(databasePath);
            }
            // }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
    }
    
}
