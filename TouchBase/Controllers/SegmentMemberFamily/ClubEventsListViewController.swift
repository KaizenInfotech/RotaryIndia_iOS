//
//  ClubEventsListViewController.swift
//  TouchBase
//
//  Created by rajendra on 01/08/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


class ClubEventsListViewController: UIViewController,UITextFieldDelegate , UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var NoRecordLabel: UILabel!
    @IBOutlet weak var tableClubEventListShow: UITableView!
    var muDictionary:NSMutableDictionary = NSMutableDictionary()
    var muarrayEventsDetailSendToNextScreen:NSMutableArray=NSMutableArray()
    
    
    var varGroupID:String!=""
    var varGetSearchText:String! = ""
    let searchTextField = UITextField()
    var mainArray : NSMutableArray!
    var muarrayFindAClubEventList:NSMutableArray=NSMutableArray()
    var filtermuarrayFindAClubEventList:NSMutableArray=NSMutableArray()
    var filterIndex = 0
    var titleArray = [String]()
    var projectDateArray = [String]()
    var filtertitleArray:NSMutableArray=NSMutableArray()
    var filterProjectDateArray = [String]()
    var isFiltered = false
    
    var descArr = [String]()
    var latArr = [String]()
    var longArr = [String]()
    var venueArr = [String]()
    var pic = [String]()
    
    
    
    //-----------------------------------------------------------------
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
                let mainEventDesc = eventDesc.replacingOccurrences(of: "'", with: "")
                let eventDateTime = (arrdata.value(forKey: "eventDateTime") as AnyObject).object(at: i) as! String
                let goingCount = (arrdata.value(forKey: "goingCount") as AnyObject).object(at: i)
                let maybeCount = (arrdata.value(forKey: "maybeCount") as AnyObject).object(at: i)
                let notgoingCount = (arrdata.value(forKey: "notgoingCount") as AnyObject).object(at: i)
                let venue = (arrdata.value(forKey: "venue") as AnyObject).object(at: i) as! String
                let myResponse = (arrdata.value(forKey: "myResponse") as AnyObject).object(at: i)
                let filterType = (arrdata.value(forKey: "filterType") as AnyObject).object(at: i)
                let grpID = (arrdata.value(forKey: "grpID") as AnyObject).object(at: i)
                let grpAdminId = (arrdata.value(forKey: "grpAdminId") as AnyObject).object(at: i)
                let isRead = (arrdata.value(forKey: "isRead") as AnyObject).object(at: i)
                let venueLat = (arrdata.value(forKey: "venueLat") as AnyObject).object(at: i) as! String
                let venueLon = (arrdata.value(forKey: "venueLon") as AnyObject).object(at: i) as! String
                
                print(eventID,eventImg,eventTitle,grpID)
                
                
                let insertSQL = "INSERT INTO Club_Events_Details (masterUID , eventID, eventImg,eventTitle,eventDesc,eventDateTime,goingCount,maybeCount,notgoingCount,venue,myResponse,filterType,grpID,grpAdminId,isRead,venueLat,venueLon) VALUES ('\(mainMemberID!)', '\(eventID)', '\(eventImg)', '\(eventTitle)', '\(mainEventDesc)', '\(eventDateTime)', '\(goingCount)', '\(maybeCount)','\(notgoingCount)','\(venue)','\(myResponse)','\(filterType)','\(grpID)','\(grpAdminId)','\(isRead)','\(venueLat)','\(venueLon)')"
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
    
    func functionForGetEventDetails()
    {
        
//        varGroupID = UserDefaults.standard.value(forKey: "GrpID") as! String

        var ClubID12:String! = ""
        ClubID12 = UserDefaults.standard.value(forKey: "GrpID") as? String
      print(ClubID12)

        
        print("this is Communication segment screen !!!!!")
        let completeURL = baseUrl+row_GetDistricCommunicationtEventList
        let parameterst = [
            "grpID": ClubID12
        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: { [self](response: AnyObject) -> Void in
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
                if((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "status") as! String == "0" && (dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "message") as! String == "success")
                {
                    
                    var subdicttt=(dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result") as! NSDictionary
                    
//
//                    NSArray *response = [responseObject objectForKey:@"Table"];
//                    if (response.count == 0) {
//                        // Continue loading more data:
//                        [self loadLatLong];
//                        return;
//                    }
                    var arrr = subdicttt.object(forKey: "Table") as! NSArray
                    
                    
                    muarrayFindAClubEventList.removeAllObjects()
                    self.titleArray.removeAll()
                    self.projectDateArray.removeAll()
                    if arrr.count > 0{
                        mainArray = NSMutableArray(array: arrr)
                        muarrayFindAClubEventList = NSMutableArray(array: arrr)
                        filtermuarrayFindAClubEventList = NSMutableArray(array: arrr)
                        print(muarrayFindAClubEventList)
                        for i in 0 ..< muarrayFindAClubEventList.count {
                            self.titleArray.append((muarrayFindAClubEventList.object(at: i) as AnyObject).value(forKey: "eventTitle") as! String)
                            self.projectDateArray.append((muarrayFindAClubEventList.object(at: i) as AnyObject).value(forKey: "eventDateTime") as! String)
                            self.descArr.append((muarrayFindAClubEventList.object(at: i) as AnyObject).value(forKey: "eventDesc") as! String)
                            self.latArr.append((muarrayFindAClubEventList.object(at: i) as AnyObject).value(forKey: "venueLat") as! String)
                            self.longArr.append((muarrayFindAClubEventList.object(at: i) as AnyObject).value(forKey: "venueLon") as! String)
                            self.venueArr.append((muarrayFindAClubEventList.object(at: i) as AnyObject).value(forKey: "venue") as! String)
                            self.pic.append((muarrayFindAClubEventList.object(at: i) as AnyObject).value(forKey: "eventImg") as? String ?? "")
                            
                        }
                        
                        
                        
                        var mainDict = (subdicttt.object(forKey: "Table")! as AnyObject).object(at: 0) as NSDictionary
                        
                        let varEventID=(mainDict.value(forKey: "eventID")! as AnyObject)
                        let varEventImg=(mainDict.value(forKey: "eventImg")! as AnyObject) as! String
                        let varEventTitle=(mainDict.value(forKey: "eventTitle")! as AnyObject) as! String
                        let varEventDesc=(mainDict.value(forKey: "eventDesc")! as AnyObject) as! String
                        let varEventDateTime=(mainDict.value(forKey: "eventDateTime")! as AnyObject) as! String
                        let varGoingCount=(mainDict.value(forKey: "goingCount")! as AnyObject)
                        let varMaybeCount=(mainDict.value(forKey: "maybeCount")! as AnyObject)
                        let varNotgoingCount=(mainDict.value(forKey: "notgoingCount")! as AnyObject)
                        let varVenue=(mainDict.value(forKey: "venue")! as AnyObject) as! String
                        let varMyResponse=(mainDict.value(forKey: "myResponse")! as AnyObject)
                        let varFilterType=(mainDict.value(forKey: "filterType")! as AnyObject)
                        let varGrpID=(mainDict.value(forKey: "grpID")! as AnyObject)
                        let varGrpAdminId=(mainDict.value(forKey: "grpAdminId")! as AnyObject)
                        let varIsRead=(mainDict.value(forKey: "isRead")! as AnyObject)
                        let varVenueLat=(mainDict.value(forKey: "venueLat")! as AnyObject) as! String
                        let varVenueLon=(mainDict.value(forKey: "venueLon")! as AnyObject) as! String
                        self.EventCountNotification.add(varIsRead)
                        print("titleArray123--\(titleArray)")
                        print("projectDateArray123--\(projectDateArray)")
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
                                              self.muarrayEventsDetailSendToNextScreen2.add(self.muDictionaryForEventDetails)
                      //                    }
                                          self.DeleteDataInlocal()
                                          self.SaveDataInlocal(self.muarrayEventsDetailSendToNextScreen2)
                                         // self.tableCommunicationList.reloadData()
//                                           self.fetchData()
                        if muarrayFindAClubEventList.count > 0 {
                            // checkRow = ""
                            NoRecordLabel.isHidden = true
//                            muarrayFindAClubEventList=mainArray
                            tableClubEventListShow.reloadData()
                        }else{
                            NoRecordLabel.isHidden = false
                            muarrayFindAClubEventList = NSMutableArray()
                            mainArray = NSMutableArray()
                            NoRecordLabel.text = "Record Not Found"
                           // muarrayFindAClubList=NSMutableArray()
                            //tableSearchAClubList.reloadData()
                        }
                    }
                    else{
                        print("Data not found")
                        NoRecordLabel.isHidden = false
                        NoRecordLabel.text = "Record Not Found"
                    }
                    
//                    for i in 0..<(mainDict.value(forKey: "grpID")! as AnyObject).count
//
////                    for i in 0..<((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "grpID")! as AnyObject)).count
//                 //change by shubhs
//
//                    {
  
                }
                else{
                    NoRecordLabel.isHidden = false
                    NoRecordLabel.text = (dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "message") as! String
                }
               // SVProgressHUD.dismiss()
            }
        })
    }
    
    var muDictionaryForEventDetails:NSMutableDictionary = NSMutableDictionary()
    var muarrayEventsDetailSendToNextScreen2:NSMutableArray=NSMutableArray()
    var EventCountNotification:NSMutableArray=NSMutableArray()
    var varEventCount:Int=0
    
  //  var muDictionaryForNewsLetterDetails:NSMutableDictionary=NSMutableDictionary()
   // var NewsLetterCountNotification:NSMutableArray=NSMutableArray()
   // var muarrayNewsLetterDetailSendToNextScreen:NSMutableArray=NSMutableArray()
    
    
    //-----------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mainArray=NSMutableArray()
        functionForGetEventDetails()
        varGroupID = UserDefaults.standard.value(forKey: "GrpID") as? String
        self.NoRecordLabel.isHidden=true
        createNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Navigation Bar Function
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Events"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ClubEventsListViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- SearchBar
    var searchController: UISearchController!
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        print("Hello")
        if searchText.count > 0 {
            filterData(searchText: varGetSearchText)
        } else if searchText.count <= 0 {
            isFiltered = false
            self.functionForGetEventDetails()
        }
        varGetSearchText = searchBar.text!
        
//        SearchFromMemberNameAndYear(varGetSearchText)
//        fetchData()
        NoRecordLabel.isHidden = true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton=true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        isFiltered = false
        print("searchText \(searchBar.text!)")
        varGetSearchText = searchBar.text!
//        muarrayFindAClubEventList.removeAllObjects()
//        SearchFromMemberNameAndYear(varGetSearchText)
//        fetchData()
        searchBar.resignFirstResponder()
    }
    func updateSearchResults(for searchController: UISearchController)
    {
        let varGetText=searchController.searchBar.text
        if(varGetText?.count<=0 && varGetText != "")
        {
            searchController.searchBar.placeholder="Search"
            varGetSearchText = ""
        }
        else if searchController.searchBar.text != nil
        {
            searchController.searchBar.placeholder="Search"
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        varGetSearchText = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        searchBar.text=nil
        isFiltered = false
        self.functionForGetEventDetails()
//        muarrayFindAClubEventList = NSMutableArray()
//        if mainArray.count > 0 {
//            // checkRow = ""
//            NoRecordLabel.isHidden = true
////            muarrayFindAClubEventList=mainArray
//            tableClubEventListShow.reloadData()
//        }else{
//            NoRecordLabel.isHidden = false
//            mainArray = NSMutableArray()
//           // muarrayFindAClubList=NSMutableArray()
//            //tableSearchAClubList.reloadData()
//        }
////        fetchData()
        self.tableClubEventListShow.reloadData()
    }
    

    //MARK:- Table Methods
    /*--------------------------------tableForAddRepeatDateAndTimeInAnnounce methods--------------Start-------------*/
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isFiltered {
            return filtertitleArray.count
        } else {
            return muarrayFindAClubEventList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let EventTitle:String=(muarrayFindAClubEventList.object(at: indexPath.row) as AnyObject).value(forKey: "eventTitle") as! String
//        if EventTitle.count>35
//        {
          return 100.0
//        }
//       return 80.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell : ClubEventsDetailsTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "ClubEventsDetailsTableViewCell") as? ClubEventsDetailsTableViewCell
       
            if isFiltered {
                if(filtertitleArray.count>0) {
                                    cell.lblEventName.text! = filtertitleArray[indexPath.row] as! String
                                    cell.lblEventDateTime.text! = filterProjectDateArray[indexPath.row]
                }
            } else {
                if(muarrayFindAClubEventList.count>0)
                {
                    cell.lblEventName.text! = (muarrayFindAClubEventList.object(at: indexPath.row) as AnyObject).value(forKey: "eventTitle") as! String
                    cell.lblEventDateTime.text!=(muarrayFindAClubEventList.object(at: indexPath.row) as AnyObject).value(forKey: "eventDateTime") as! String
                }
            }
            
            
//            let EventTitle:String=(muarrayFindAClubEventList.object(at: indexPath.row) as AnyObject).value(forKey: "eventTitle") as! String
            
//            if EventTitle.count>35
//            {--
//                cell.lblEventName.frame=CGRect(x: cell.lblEventName.frame.origin.x, y: cell.lblEventName.frame.origin.y, width: cell.lblEventName.frame.width, height: cell.lblEventName.frame.height*2)
//
//                cell.lblEventDateTime.frame=CGRect(x: cell.lblEventDateTime.frame.origin.x, y: cell.lblEventDateTime.frame.origin.y+(cell.lblEventName.frame.height/2), width: cell.lblEventDateTime.frame.width, height: cell.lblEventDateTime.frame.height)
//            }
            
            
//        }
        cell.buttonMain.addTarget(self, action: #selector(ClubEventsListViewController.buttonMainClickedEvent(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonMain.tag=indexPath.row;
        return cell as ClubEventsDetailsTableViewCell
    }
    /*-------------------------------------------function for remove cell row-------------------Start---------*/
    @objc func buttonMainClickedEvent(_ sender:UIButton)
    {
        let objClubEventDetailsShowViewController = self.storyboard!.instantiateViewController(withIdentifier: "ClubEventDetailsShowViewController") as! ClubEventDetailsShowViewController
        
        objClubEventDetailsShowViewController.senderTag=sender.tag
        if isFiltered {
            objClubEventDetailsShowViewController.isfiltered = self.isFiltered
            objClubEventDetailsShowViewController.titles = titleArray[filterIndex]
            objClubEventDetailsShowViewController.desc = descArr[filterIndex]
            objClubEventDetailsShowViewController.lat = latArr[filterIndex]
            objClubEventDetailsShowViewController.long = longArr[filterIndex]
            objClubEventDetailsShowViewController.eventdate = projectDateArray[filterIndex]
            objClubEventDetailsShowViewController.venue = venueArr[filterIndex]
            objClubEventDetailsShowViewController.img = pic[filterIndex]

        } else {
            objClubEventDetailsShowViewController.muarrayFindAClubEventList=muarrayFindAClubEventList
        }
        
        self.navigationController?.pushViewController(objClubEventDetailsShowViewController, animated: true)
    }
    
   
    
    //MARK:-Fetch Data
    func fetchData()
    {

        var moduleID = UserDefaults.standard.string(forKey: "session_GetModuleId")
        var GroupID = UserDefaults.standard.string(forKey: "session_GetGroupId")
        var databasePath : String
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
        //masterUID ,GroupId , moduleId ,District , CharterDate , ClubName , ClubType ,ClubId , Website , Find_A_Club_List
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            let querySQL = "SELECT * FROM Club_Events_Details where  grpID='\(varGroupID!)'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {

                let eventID:String!=(results?.string(forColumn: "eventID"))!
                let eventImg:String!=(results?.string(forColumn: "eventImg"))!
                let eventTitle:String!=(results?.string(forColumn: "eventTitle"))!
                let eventDesc:String!=(results?.string(forColumn: "eventDesc"))!
                let eventDateTime:String!=(results?.string(forColumn: "eventDateTime"))!
                let goingCount:String!=(results?.string(forColumn: "goingCount"))!
                let maybeCount:String!=(results?.string(forColumn: "maybeCount"))!
                let notgoingCount:String!=(results?.string(forColumn: "notgoingCount"))!
                let venue:String!=(results?.string(forColumn: "venue"))!
                let myResponse:String!=(results?.string(forColumn: "myResponse"))!
                let filterType:String!=(results?.string(forColumn: "filterType"))!
                let grpID:String!=(results?.string(forColumn: "grpID"))!
                let grpAdminId:String!=(results?.string(forColumn: "grpAdminId"))!
                let isRead:String!=(results?.string(forColumn: "isRead"))!
                let venueLat:String!=(results?.string(forColumn: "venueLat"))!
                let venueLon:String!=(results?.string(forColumn: "venueLon"))!

                self.muDictionary = ["eventID": eventID,
                                     "eventImg": eventImg,
                                     "eventTitle": eventTitle,
                                     "eventDesc": eventDesc,
                                     "eventDateTime": eventDateTime,
                                     "goingCount": goingCount,
                                     "maybeCount": maybeCount,
                                     "notgoingCount": notgoingCount,
                                     "venue": venue,
                                     "myResponse": myResponse,
                                     "filterType": filterType,
                                     "grpID": grpID,
                                     "grpAdminId": grpAdminId,
                                     "isRead": isRead,
                                     "venueLat": venueLat,
                                     "venueLon": venueLon]



                self.mainArray.add(self.muDictionary)
            }
            //self.loaderClass.window = nil
            // self.tableBodListShow.reloadData()
            if mainArray.count > 0 {
                // checkRow = ""
                NoRecordLabel.isHidden = true
                muarrayFindAClubEventList=mainArray
                tableClubEventListShow.reloadData()
            }else{
                NoRecordLabel.isHidden = false
                mainArray = NSMutableArray()
               // muarrayFindAClubList=NSMutableArray()
                //tableSearchAClubList.reloadData()
            }
        }

    }
    
    
    func SearchFromMemberNameAndYear(_ MemberName:String)
    {
//         mainArray = NSMutableArray()
         muDictionary=NSMutableDictionary()
         muarrayFindAClubEventList = NSMutableArray()

        var moduleID = UserDefaults.standard.string(forKey: "session_GetModuleId")
        var GroupID = UserDefaults.standard.string(forKey: "session_GetGroupId")
        var databasePath : String
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
            let querySQL = "SELECT * FROM Club_Events_Details where eventTitle like '%\(MemberName)%' or eventDesc like '%\(MemberName)%' and grpID = '\(varGroupID!)'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {
                let eventID:String!=(results?.string(forColumn: "eventID"))!
                let eventImg:String!=(results?.string(forColumn: "eventImg"))!
                let eventTitle:String!=(results?.string(forColumn: "eventTitle"))!
                let eventDesc:String!=(results?.string(forColumn: "eventDesc"))!
                let eventDateTime:String!=(results?.string(forColumn: "eventDateTime"))!
                let goingCount:String!=(results?.string(forColumn: "goingCount"))!
                let maybeCount:String!=(results?.string(forColumn: "maybeCount"))!
                let notgoingCount:String!=(results?.string(forColumn: "notgoingCount"))!
                let venue:String!=(results?.string(forColumn: "venue"))!
                let myResponse:String!=(results?.string(forColumn: "myResponse"))!
                let filterType:String!=(results?.string(forColumn: "filterType"))!
                let grpID:String!=(results?.string(forColumn: "grpID"))!
                let grpAdminId:String!=(results?.string(forColumn: "grpAdminId"))!
                let isRead:String!=(results?.string(forColumn: "isRead"))!
                let venueLat:String!=(results?.string(forColumn: "venueLat"))!
                let venueLon:String!=(results?.string(forColumn: "venueLon"))!
                
                print(eventID,eventDesc,eventDesc)
                
                if(eventID == "")
                {
                }
                else
                {
            self.muDictionary = ["eventID": eventID,
                                         "eventImg": eventImg,
                                         "eventTitle": eventTitle,
                                         "eventDesc": eventDesc,
                                         "eventDateTime": eventDateTime,
                                         "goingCount": goingCount,
                                         "maybeCount": maybeCount,
                                         "notgoingCount": notgoingCount,
                                         "venue": venue,
                                         "myResponse": myResponse,
                                         "filterType": filterType,
                                         "grpID": grpID,
                                         "grpAdminId": grpAdminId,
                                         "isRead": isRead,
                                         "venueLat": venueLat,
                                         "venueLon": venueLon]
                    
                    self.mainArray.add(self.muDictionary)
                }
                
            }
            muarrayFindAClubEventList = NSMutableArray()
            var arrrrr:NSMutableArray=NSMutableArray()
//            userListingdata = NSMutableArray()
//             print(userListingdata)
             for dict in mainArray {
                let subDict = dict as! NSDictionary
                 print(subDict)
                 
                 if subDict.value(forKey: "eventTitle") as? String == MemberName {
                     muarrayFindAClubEventList.add(subDict)
                 }
//                 let str = subDict.value(forKey: "eventTitle") as! String
//
//                 let mainstr = str.lowercased()
//                 let nameStr = MemberName.lowercased()
////                 var nameList = str.filter({$0.lowercased().contains(varGetSearchText!.lowercased())})
//
////                 print("user name\(str)")
////                 print("search text\(varGetSearchText)")
//                 if mainstr .contains(nameStr){
//                     arrrrr.add(subDict)
//                 }
//
             }
            
//            muarrayFindAClubEventList = arrrrr
            print(muarrayFindAClubEventList)
            
            
           // self.loaderClass.window = nil
            self.tableClubEventListShow.reloadData()
            if muarrayFindAClubEventList.count > 0 {
               // checkRow = ""
                NoRecordLabel.isHidden = true
//                muarrayFindAClubEventList=mainArray
                tableClubEventListShow.reloadData()
            }else{
                //checkRow = "1"
                NoRecordLabel.isHidden = false
                mainArray = NSMutableArray()
                muarrayFindAClubEventList=NSMutableArray()
                //directoryTableView.reloadData()
            }
        }
        
    }
    
    func filterData(searchText: String?) {
        isFiltered = true
        filtertitleArray.removeAllObjects()
        filtermuarrayFindAClubEventList.removeAllObjects()
        if muarrayFindAClubEventList.count > 0 {
            let filteredArray = titleArray.filter { $0.localizedCaseInsensitiveContains(searchText ?? "") }
            print("filterArr123---\(filteredArray)")
            if let muarrayGridAlbumCollectionFiltereds = (filteredArray as NSArray).mutableCopy() as? NSMutableArray {
                filtertitleArray = muarrayGridAlbumCollectionFiltereds
                filterProjectDateArray.removeAll()
                for filteredTitle in filteredArray {
                    if let index = titleArray.firstIndex(where: { $0 == filteredTitle }) {
                            filterProjectDateArray.append(projectDateArray[index])
                        filterIndex = index
                        }
                }
            }
        }
        self.tableClubEventListShow.reloadData()
    }
}


