//
//  DistrictClubMemberListViewController.swift
//  TouchBase
//
//  Created by rajendra on 21/07/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
import SJSegmentedScrollView
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


class DistrictClubMemberListViewController: UIViewController,UISearchBarDelegate,UISearchControllerDelegate,UITableViewDataSource,UITableViewDelegate {
    
    var appDelegate : AppDelegate = AppDelegate()
    let loaderClass  = WebserviceClass()
    var varGroupId:String!=""
    var varModuleId:String!=""
    var moduleName:String!=""
    
    var varGetCountry:String=""
    var varGetCountryID:String=""
    var varGetCountryCode:String=""
    var varGetDay:String=""
    var varGetDayID:String=""
    var muarrayFindAClubList:NSMutableArray=NSMutableArray()
    var varAuthorizationToken:String! = ""
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    var mainArray : NSMutableArray!
    var varGetSearchTextValue:String!=""
    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
    
    @IBOutlet weak var tableDistrictClubMember: UITableView!
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        createNavigationBar()
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            functionForSearchFindAclubTestPurpose() // Server Calling Need to GroupID

        }
        else
        {
            self.window = nil
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Function
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Clubs"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(DistrictClubMemberListViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }

    /*--------------------------------------------------searchBar----------------------------------------------*/
    //MARK:- SearchBar
    var searchController: UISearchController!
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        print("11111")
        varGetSearchTextValue = searchBar.text!
        mainArray = NSMutableArray()
        fetchDataFORClubName(varGetSearchTextValue)
        self.tableDistrictClubMember.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        print("22222")
        searchBar.showsCancelButton=true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        print("333333")
        print("searchText \(searchBar.text)")
        varGetSearchTextValue = searchBar.text!
        muarrayFindAClubList.removeAllObjects()
        fetchDataFORClubName(varGetSearchTextValue)
        searchBar.resignFirstResponder()
    }
    func updateSearchResultsForSearchController(_ searchController: UISearchController)
    {
        print("4444444")
        let varGetText=searchController.searchBar.text
        if(varGetText?.characters.count<=0 && varGetText != "")
        {
            searchController.searchBar.placeholder="Search"
            varGetSearchTextValue = ""
        }
        else if searchController.searchBar.text != nil
        {
            searchController.searchBar.placeholder="Search"
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        print("55555555")
        mainArray = NSMutableArray()
        fetchData()
        self.tableDistrictClubMember.reloadData()
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        searchBar.text=nil
    }
    /*--------------------------------------------------searchBar-----------------------------------------------*/
    

    //MARK:- SERVER CALLING
    func functionForSearchFindAclubTestPurpose()
    {
           SVProgressHUD.show()
           muarrayFindAClubList=NSMutableArray()
       
        var parameterst:NSDictionary=NSDictionary()
            let completeURL = baseUrl+row_GetDistrictClubList
        parameterst = ["groupId":varGroupId,"search":""]
            print(completeURL)
            print(parameterst)
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
                let dd = response as! NSDictionary
                 print("dd \(dd)")
                SVProgressHUD.dismiss()
                var varGetValueServerError = response.object(forKey: "serverError")as? String
                if(varGetValueServerError == "Error")
                {
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                    SVProgressHUD.dismiss()
                }
                else
                {

                if((dd.object(forKey: "ClubListResult")! as AnyObject).object(forKey: "status") as! String == "0")
                {
                    for i in 0..<(((response.value(forKey: "ClubListResult")! as AnyObject).value(forKey: "Clubs")! as AnyObject).value(forKey: "grpID")! as AnyObject).count
                    {
                        self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                        /* "grpID": "122",
                         "clubId": "15484",
                         "clubName": "Ambarnath",
                         "meetingDay": "Wednesday",
                         "meetingTime": "08:30PM",
                         "distance": null
                         */
                        let varGrpID=((((dd.value(forKey: "ClubListResult")! as AnyObject).value(forKey: "Clubs")! as AnyObject).value(forKey: "grpID")! as AnyObject).object(at: i))
                        // print(varGrpID)
                        let varClubId=((((dd.value(forKey: "ClubListResult")! as AnyObject).value(forKey: "Clubs")! as AnyObject).value(forKey: "clubId")! as AnyObject).object(at: i))
                        let varClubName=((((dd.value(forKey: "ClubListResult")! as AnyObject).value(forKey: "Clubs")! as AnyObject).value(forKey: "clubName")! as AnyObject).object(at: i))
                        var varMeetingDay=((((dd.value(forKey: "ClubListResult")! as AnyObject).value(forKey: "Clubs")! as AnyObject).value(forKey: "meetingDay")! as AnyObject).object(at: i))as? String
                        var varMeetingTime=((((dd.value(forKey: "ClubListResult")! as AnyObject).value(forKey: "Clubs")! as AnyObject).value(forKey: "meetingTime")! as AnyObject).object(at: i))as? String
                        var varDistance=((((dd.value(forKey: "ClubListResult")! as AnyObject).value(forKey: "Clubs")! as AnyObject).value(forKey: "distance")! as AnyObject).object(at: i)) as? String
                        print(varMeetingDay)
                        print(varMeetingTime)
                        if(varDistance == nil)
                        {
                            varDistance = ""
                        }
                        else
                        {
                        }
                        self.commonClassHoldDataAccessibleVariable.varGetGrpID = varGrpID as! String;
                        self.commonClassHoldDataAccessibleVariable.varClubId = varClubId as! String;
                        self.commonClassHoldDataAccessibleVariable.varClubName = varClubName as! String;
                        if varMeetingTime != nil  {
                            self.commonClassHoldDataAccessibleVariable.varMeetingTime = varMeetingTime
                        }
                        
                        if varMeetingDay != nil  {
                            self.commonClassHoldDataAccessibleVariable.varMeetingDay = varMeetingDay as! String;
                        }
                        
                        if varMeetingTime != nil && varMeetingDay != nil {
                            self.commonClassHoldDataAccessibleVariable.varCharterDate = ((varMeetingDay as! String)+"  |  "+(varMeetingTime as! String))
                        }
                        
                       
                       
                        self.commonClassHoldDataAccessibleVariable.varDistance = varDistance
                        self.muarrayFindAClubList.add(self.commonClassHoldDataAccessibleVariable)
                    }
                    self.appDelegate = UIApplication.shared.delegate as! AppDelegate
                    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                        self.DeleteDataInlocal()
                        if(self.muarrayFindAClubList.count>0)
                        {
                            self.SaveDataInlocal(self.muarrayFindAClubList)
                            self.mainArray = NSMutableArray()
                            self.fetchData()
                        }
                        else
                        {
                         
                        }
                    }
                    else
                    {
                        
                    }
                }
                else
                {
                    
                }
        }
            })
       
    }
    //Save Data
    func SaveDataInlocal (_ arrdata:NSMutableArray)
    {
        var databasePath : String
        // print(arrdata);
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
            let moduleID = UserDefaults.standard.string(forKey: "session_GetModuleId")
            var GroupID = UserDefaults.standard.string(forKey: "session_GetGroupId")
            for i in 0 ..< arrdata.count
            {
                var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
                objCommonHoldDataVariable = arrdata.object(at: i) as! CommonAccessibleHoldVariable;
                let varDistrictID = objCommonHoldDataVariable.varDistrictID
                let varCharterDate = objCommonHoldDataVariable.varCharterDate
                // print(varCharterDate)
                let varClubName =  objCommonHoldDataVariable.varClubName
                let varClubType =  objCommonHoldDataVariable.varClubType
                let varClubId =  objCommonHoldDataVariable.varClubId
                let Website =  objCommonHoldDataVariable.Website
                let varGetGrpID = objCommonHoldDataVariable.varGetGrpID
                let varDistance = objCommonHoldDataVariable.varDistance
                // print(varGetGrpID)
                //let  dict = arrdata[i] as! NSDictionary
                //masterUID ,GroupId , moduleId ,District , CharterDate , ClubName , ClubType ,ClubId , Website , Find_A_Club_List
                //masterUID ,GroupId , moduleId ,District , CharterDate , ClubName , ClubType ,ClubId , Website , District_Club_List
                
                let insertSQL = "INSERT INTO District_Club_List (masterUID , GroupId, moduleId, District , CharterDate,ClubName,ClubType,ClubId,Website,distance) VALUES ('\(mainMemberID!)', '\(varGetGrpID!)', '\(moduleID!)', '\(varDistrictID!)', '\(varCharterDate!)', '\(varClubName!)', '\(varClubType!)', '\(varClubId!)', '\(Website!)','\(varDistance!)')"
                 print(insertSQL)
                
                let result = contactDB?.executeStatements(insertSQL)
                
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("success saved")
                    print(databasePath);
                }
            }
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
    }

    
    //DeleteData
    
    func DeleteDataInlocal (){
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
            let insertSQL = "DELETE FROM District_Club_List"
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
    
    /*--------------------------------tableForAddRepeatDateAndTimeInAnnounce methods--------------Start-------------*/
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayFindAClubList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell : DistrictClubTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "DistrictClubTableViewCell") as! DistrictClubTableViewCell
        if(muarrayFindAClubList.count>0)
        {
            commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
            commonClassHoldDataAccessibleVariable = muarrayFindAClubList.object(at: indexPath.row) as! CommonAccessibleHoldVariable
            cell.lblMemberName.text=commonClassHoldDataAccessibleVariable.varClubName
            cell.labelDayRime.text=commonClassHoldDataAccessibleVariable.varCharterDate
        }
        cell.buttonMain.addTarget(self, action: #selector(DistrictClubMemberListViewController.buttonMainClickedEvent(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonMain.tag=indexPath.row;
        return cell as DistrictClubTableViewCell
    }
    
    
    @objc func buttonMainClickedEvent(_ sender:UIButton)
    {
        commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
        commonClassHoldDataAccessibleVariable = muarrayFindAClubList.object(at: sender.tag) as! CommonAccessibleHoldVariable
        let ClubID = commonClassHoldDataAccessibleVariable.varClubId
        print(ClubID)
        let ClubType = commonClassHoldDataAccessibleVariable.varClubType
        let Website = commonClassHoldDataAccessibleVariable.Website
        let varDistrictID = commonClassHoldDataAccessibleVariable.varDistrictID
        let varClubName = commonClassHoldDataAccessibleVariable.varClubName
        let varGrpID = commonClassHoldDataAccessibleVariable.varGetGrpID! as String
        print(varGrpID)
        
        
        UserDefaults.standard.setValue(varGrpID, forKey: "GrpID")
        UserDefaults.standard.setValue(Website, forKey: "Session_Website")
        UserDefaults.standard.setValue(self.varAuthorizationToken, forKey: "Session_AutorizationToken")
        UserDefaults.standard.setValue(ClubID, forKey: "Session_Club_ID")
        UserDefaults.standard.setValue(ClubType, forKey: "Session_Club_TYPE")
        UserDefaults.standard.setValue(varDistrictID, forKey: "Session_District_ID")
        UserDefaults.standard.setValue(varClubName, forKey: "Session_ClubName")
        UserDefaults.standard.setValue("Clubs", forKey: "Session_ModuleNameForNavigationHeading_FindAClubOrClubs")
        
        
        if let storyboard = self.storyboard {
            
            if let infoSegmentVC = storyboard.instantiateViewController(withIdentifier: "InfoSegmentFindAClubViewController") as? InfoSegmentFindAClubViewController,
               let communicationSegmentVC = storyboard.instantiateViewController(withIdentifier: "ClubEventsListViewController") as? ClubEventsListViewController,
               let gallerySegmentVC = storyboard.instantiateViewController(withIdentifier: "ClubGallerySegmentListViewController") as? ClubGallerySegmentListViewController,
               let memberSegmentVC = storyboard.instantiateViewController(withIdentifier: "MemberSegmentViewController") as? MemberSegmentViewController {

                infoSegmentVC.infoFrom = "District Clubs"

                infoSegmentVC.title = "Info"
                communicationSegmentVC.title = "Events"
                memberSegmentVC.title = "Member"
                gallerySegmentVC.title = "Activity"

                let segmentController = SJSegmentedViewController()
                segmentController.segmentControllers = [infoSegmentVC, memberSegmentVC, communicationSegmentVC, gallerySegmentVC]
                segmentController.isFrom = true

                navigationController?.pushViewController(segmentController, animated: true)
            }
        }
    }

    func fetchData()
    {
        
        let moduleID = UserDefaults.standard.string(forKey: "session_GetModuleId")
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
            let querySQL = "SELECT * FROM District_Club_List where  moduleId='\(moduleID!)'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {
                print((results?.string(forColumn: "ClubId"))! as String)
                // let dd = NSMutableDictionary ()
                self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                let varBodMemberGroupID:String! =   (results?.string(forColumn: "GroupId"))
                print(varBodMemberGroupID)
                let varBodMemberMasterUID:String!=(results?.string(forColumn: "moduleId"))! as String
                let varDistrictID:String!=(results?.string(forColumn: "District"))! as String
                let varCharterDate:String!=(results?.string(forColumn: "CharterDate"))! as String
                let varClubName:String!=(results?.string(forColumn: "ClubName"))! as String
                let varClubType:String!=(results?.string(forColumn: "ClubType"))! as String
                let varClubId:String!=(results?.string(forColumn: "ClubId"))! as String
                let Website:String!=(results?.string(forColumn: "Website"))! as String
                let distance:String!=(results?.string(forColumn: "distance"))! as String
                
                
                self.commonClassHoldDataAccessibleVariable.varDistrictID = varDistrictID as String;
                self.commonClassHoldDataAccessibleVariable.varCharterDate = varCharterDate as String;
                self.commonClassHoldDataAccessibleVariable.varClubName = varClubName as String;
                self.commonClassHoldDataAccessibleVariable.varClubType = varClubType as String;
                self.commonClassHoldDataAccessibleVariable.varClubId = String(varClubId)
                self.commonClassHoldDataAccessibleVariable.Website = Website as String
                self.commonClassHoldDataAccessibleVariable.varGetGrpID = varBodMemberGroupID as String
                self.commonClassHoldDataAccessibleVariable.varDistance = distance as String
                
                
                self.mainArray.add(self.commonClassHoldDataAccessibleVariable)
                // print(dd)
                // mainArray.addObject(dd)
            }
            self.loaderClass.window = nil
            // self.tableBodListShow.reloadData()
            if mainArray.count > 0 {
                // checkRow = ""
                //NoRecordLabel.hidden = true
                muarrayFindAClubList=mainArray
                tableDistrictClubMember.reloadData()
            }else{
                //NoRecordLabel.hidden = false
                mainArray = NSMutableArray()
                muarrayFindAClubList=NSMutableArray()
                tableDistrictClubMember.reloadData()
            }
        }
        
    }
    
    func fetchDataFORClubName(_ varClubName:String)
    {
        
        let moduleID = UserDefaults.standard.string(forKey: "session_GetModuleId")
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
        //masterUID, groupId , moduleId , profileID , MemberDesignation , memberName , pic , membermobile From Board_Of_Directors_List
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
            
        {
            let querySQL = "SELECT * FROM District_Club_List where ClubName like '%\(varClubName)%' or CharterDate like '%\(varClubName)%' and moduleId='\(moduleID!)'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {
                print((results?.string(forColumn: "ClubId"))! as String)
                // let dd = NSMutableDictionary ()
                self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                let varBodMemberGroupID:String! =   (results?.string(forColumn: "GroupId"))
                print(varBodMemberGroupID)
                let varBodMemberMasterUID:String!=(results?.string(forColumn: "moduleId"))! as String
                let varDistrictID:String!=(results?.string(forColumn: "District"))! as String
                let varCharterDate:String!=(results?.string(forColumn: "CharterDate"))! as String
                let varClubName:String!=(results?.string(forColumn: "ClubName"))! as String
                let varClubType:String!=(results?.string(forColumn: "ClubType"))! as String
                let varClubId:String!=(results?.string(forColumn: "ClubId"))! as String
                let Website:String!=(results?.string(forColumn: "Website"))! as String
                
                
                self.commonClassHoldDataAccessibleVariable.varDistrictID = varDistrictID as! String;
                self.commonClassHoldDataAccessibleVariable.varCharterDate = varCharterDate as! String;
                self.commonClassHoldDataAccessibleVariable.varClubName = varClubName as! String;
                self.commonClassHoldDataAccessibleVariable.varClubType = varClubType as! String;
                self.commonClassHoldDataAccessibleVariable.varClubId = String(varClubId)
                self.commonClassHoldDataAccessibleVariable.Website = Website as! String
                self.commonClassHoldDataAccessibleVariable.varGetGrpID = varBodMemberGroupID as String
               
                self.mainArray.add(self.commonClassHoldDataAccessibleVariable)
                
            }
            if mainArray.count > 0 {
                // checkRow = ""
                //NoRecordLabel.hidden = true
                muarrayFindAClubList=mainArray
                tableDistrictClubMember.reloadData()
            }else{
                //NoRecordLabel.hidden = false
                mainArray = NSMutableArray()
                muarrayFindAClubList=NSMutableArray()
                tableDistrictClubMember.reloadData()
            }
        }
    }


}
