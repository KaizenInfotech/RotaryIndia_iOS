//
//  SearchAnyClubNearMeClubViewController.swift
//  TouchBase
//
//  Created by deepak on 20/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
//import Kingfisher
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

class SearchAnyClubNearMeClubViewController: UIViewController,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource
{
    var flag:String="0"
    @IBOutlet weak var tableSearchAClubList: UITableView!
    /*---------------------------------------------------------------------------------------------------*/
    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
    var mainArray : NSMutableArray!
    /*---------------------------------------------------------------------------------------------------*/
    @IBOutlet weak var buttonOpacity: UIButton!
    
    @IBOutlet weak var viewDay: UIView!
    @IBOutlet weak var pickerDay: UIPickerView!
   
    @IBOutlet weak var NoRecordLabel: UILabel!
    var searchButton = UIButton()
    var appDelegate : AppDelegate = AppDelegate()
    var varGetSearchTextValue:String!=""
    var moduleName:String!
    var grpID: NSString!
    var muarrayMeetingDay:NSMutableArray=NSMutableArray()
    var muarrayFindAClubList:NSMutableArray=NSMutableArray()
    var muarrayForAddressInfo:NSMutableArray=NSMutableArray()
    var varAuthorizationToken:String! = ""
    /*--------------------------------------------------searchBar----------------------------------------------*/
    //MARK:- SearchBar
    var searchController: UISearchController!
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton=true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        print("searchText \(searchBar.text ?? "")")
        varGetSearchTextValue = searchBar.text!
         muarrayFindAClubList.removeAllObjects()
        fetchDataFORClubName(varGetSearchTextValue)
        searchBar.resignFirstResponder()
    }
    func updateSearchResults(for searchController: UISearchController)
    {
        let varGetText=searchController.searchBar.text
        if(varGetText?.count<=0 && varGetText != "")
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
        
        searchButton.setTitle("All",  for: UIControl.State.normal)
        mainArray = NSMutableArray()
        fetchData()
        self.tableSearchAClubList.reloadData()
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        searchBar.text=nil
    }
    /*--------------------------------------------------searchBar-----------------------------------------------*/

    override func viewDidLoad()
    {
        super.viewDidLoad()
            NoRecordLabel.isHidden = true
            mainArray = NSMutableArray()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
             muarrayFindAClubList=NSMutableArray()
             fetchDataFORClubName(searchButton.titleLabel?.text ?? "")
//            getBoardOfDirectorList(grpID!, searchText: "")
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            mainArray = NSMutableArray()
            fetchData()
        }
//            fetchData()
       
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        functionForSetLeftNavigation()
        buttonOpacity.isHidden=true
        viewDay.isHidden=true
        muarrayMeetingDay=NSMutableArray()
        muarrayMeetingDay.add("All")
        muarrayMeetingDay.add("Monday")
        muarrayMeetingDay.add("Tuesday")
        muarrayMeetingDay.add("Wednesday")
        muarrayMeetingDay.add("Thursday")
        muarrayMeetingDay.add("Friday")
        muarrayMeetingDay.add("Saturday")
        muarrayMeetingDay.add("Sunday")
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //MARK:- navigation
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Find a club"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(SearchFindArotarianViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        //---
//        let trashB = UIButton(type: UIButton.ButtonType.custom)
//        trashB.frame = CGRectMake(0, 0, 50, 50)
//        trashB.setImage(UIImage(named:"downArrowCalendar"), forState: UIControl.State.Normal)
//        trashB.addTarget(self, action: #selector(SearchAnyClubNearMeClubViewController.buttonAllClickEvent), forControlEvents: UIControlEvents.TouchUpInside)
//        let trash: UIBarButtonItem = UIBarButtonItem(customView: trashB)
//        self.navigationItem.rightBarButtonItem = trash
//
        
        let attributess = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributess
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title="Find a Club"
        let titleDictt: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDictt as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        //self.navigationController?.navigationBar.ti = UIColor.whiteColor()
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.buttonAllClickEvent))
        add.tintColor = UIColor.black
        //self.navigationItem.rightBarButtonItem = add
         searchButton = UIButton(type: UIButton.ButtonType.custom)
        searchButton.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        searchButton.titleLabel!.textAlignment = .right

        searchButton.titleLabel!.font =  UIFont(name: "Roboto-Regular", size: 14)
       // searchButton.setTitleColor.(red: 119/255.0, green: 211/255.0, blue: 241/255.0, alpha: 1.0)
        
    searchButton.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        //searchButton.titleLabel?.tintColor=UIColor(red: 119/255.0, green: 211/255.0, blue: 241/255.0, alpha: 1.0)

        //searchButton.setImage(UIImage(named:"search_btn"), forState: UIControl.State.Normal)
        searchButton.setTitle("All",  for: UIControl.State.normal)
        //searchButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        searchButton.addTarget(self, action: #selector(SearchAnyClubNearMeClubViewController.buttonAllClickEvent), for: UIControl.Event.touchUpInside)
        let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
        //let buttons : NSArray = [search, setting] //14 mar
        let buttonss : NSArray = [search]
        
        
//        let imageView = UIImageView(image: UIImage(named: "down_arrowew_blue.png"))
//        imageView.frame = CGRectMake(0.0, 0.0, 90, 90)
//
//
        
        
        
        
        
        
        let settingButton = UIButton(type: UIButton.ButtonType.custom)
        settingButton.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        settingButton.setBackgroundImage(UIImage(named:"down_arrowew_blue.png"),  for: UIControl.State.normal)
        settingButton.addTarget(self, action: #selector(SearchAnyClubNearMeClubViewController.buttonAllClickEvent), for: UIControl.Event.touchUpInside)
        let setting: UIBarButtonItem = UIBarButtonItem(customView: settingButton)
        //let buttons : NSArray = [search, setting] //14 mar
        let buttons : NSArray = [setting,search]
        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
  
    }
    @IBAction func buttonOpacityClickEvent(_ sender: AnyObject)
    {
        viewDay.isHidden=true
        buttonOpacity.isHidden=true
    }
    @objc func buttonAllClickEvent()
    {
        buttonOpacity.isHidden=false
        viewDay.isHidden=false
        //self.navigationController?.//popViewControllerAnimated(true)
      print("All")
    }
    @IBAction func buttonDayDoneClickEvent(_ sender: AnyObject)
    {
        var varGetValue = searchButton.titleLabel?.text!
        if(varGetValue == "All")
        {
            mainArray = NSMutableArray()
            fetchData()
        }
        else
        {
            if varGetValue as! String == "Monday"{
                varGetValue = "Mon"
            }else if varGetValue as! String == "Tuesday"{
                varGetValue = "Tues"
            }else if varGetValue as! String == "Wednesday"{
                varGetValue = "Wed"
            }else if varGetValue as! String == "Thursday"{
                varGetValue = "Thurs"
            }else if varGetValue as! String == "Friday"{
                varGetValue = "Fri"
            }else if varGetValue as! String == "Saturday"{
                varGetValue = "Sat"
            }else if varGetValue as! String == "Sunday"{
                varGetValue = "Sun"
            }
            
            muarrayFindAClubList.removeAllObjects()
            fetchDataFORClubName(varGetValue!)
            
        }
       
        buttonOpacity.isHidden=true
        viewDay.isHidden=true
    }
    override func viewWillAppear(_ animated: Bool) {
      
    }
    
     @objc func backClicked()
    {
        self.muarrayFindAClubList = NSMutableArray()
        self.muarrayFindAClubList.removeAllObjects()
        self.navigationController?.popViewController(animated: true)
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
        let cell : SearchAnyClubNearMeClubCell! = tableSearchAClubList.dequeueReusableCell(withIdentifier: "Cell") as? SearchAnyClubNearMeClubCell
        if(muarrayFindAClubList.count>0)
        {
            print("click on SearchAnyClubNearMe")
             SVProgressHUD.dismiss()
//            var varMemberName = (muarrayFindAClubList.object(at: indexPath.row) as AnyObject).value(forKey: "varGrpID")as? String
//            print("your id: \(varMemberName ?? "")")
            commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
            commonClassHoldDataAccessibleVariable = muarrayFindAClubList.object(at: indexPath.row) as! CommonAccessibleHoldVariable
            cell.labelLocation.text=commonClassHoldDataAccessibleVariable.varClubName
            cell.labelDayRime.text=commonClassHoldDataAccessibleVariable.varCharterDate
            UserDefaults.standard.set(commonClassHoldDataAccessibleVariable.varCharterDate, forKey: "varCharterDate")
            UserDefaults.standard.set(commonClassHoldDataAccessibleVariable.Website, forKey: "Website")
//            UserDefaults.standard.set(commonClassHoldDataAccessibleVariable., forKey: "varCharterDate")
            if flag=="1"{
            if let distance:String = commonClassHoldDataAccessibleVariable.varDistance{
       print("Distance------------------------------------------------",distance)
            if(distance != "")
            {
            cell.lblDistance.isHidden=false
            cell.lblDistance.text = distance+"KM"
            }
            else
            {
             cell.lblDistance.isHidden=true
            }
            }
            else{
                cell.lblDistance.isHidden=true
                }
            
            cell.lblDistance.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
            }
            else
            {
                cell.lblDistance.isHidden=true
            }
            
        }
        cell.buttonMain.addTarget(self, action: #selector(buttonMainClickedEvent(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonMain.tag=indexPath.row;
        return cell as SearchAnyClubNearMeClubCell
    }
    
    
    /*-------------------------------------------function for remove cell row-------------------Start---------*/
    @objc func buttonMainClickedEvent(_ sender:UIButton)
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
             commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
             commonClassHoldDataAccessibleVariable = muarrayFindAClubList.object(at: sender.tag) as! CommonAccessibleHoldVariable
             let ClubID = commonClassHoldDataAccessibleVariable.varClubId ?? ""
             let ClubType = commonClassHoldDataAccessibleVariable.varClubType ?? ""
             let Website = commonClassHoldDataAccessibleVariable.Website ?? ""
             let varDistrictID = commonClassHoldDataAccessibleVariable.varDistrictID ?? ""
             let varClubName = commonClassHoldDataAccessibleVariable.varClubName ?? ""
             let varGrpID = commonClassHoldDataAccessibleVariable.varGetGrpID ?? ""
             
             print("your group id: \(varGrpID)")
//             print(varGrpID!)
//             print(ClubID!)

             UserDefaults.standard.setValue(varGrpID, forKey: "GrpID")
             UserDefaults.standard.setValue(Website, forKey: "Session_Website")
             UserDefaults.standard.setValue(self.varAuthorizationToken ?? "", forKey: "Session_AutorizationToken")
             UserDefaults.standard.setValue(ClubID, forKey: "Session_Club_ID")
             UserDefaults.standard.setValue(ClubType, forKey: "Session_Club_TYPE")
             UserDefaults.standard.setValue(varDistrictID, forKey: "Session_District_ID")
             UserDefaults.standard.setValue(varClubName, forKey: "Session_ClubName")
             UserDefaults.standard.setValue("Clubs", forKey: "Session_ModuleNameForNavigationHeading_FindAClubOrClubs")
             UserDefaults.standard.setValue(ClubID, forKey: "NewClubId")
             if let storyboard = self.storyboard {

                 let InfoSegmentFindAClubViewController = storyboard.instantiateViewController(withIdentifier: "InfoSegmentFindAClubViewController")
                 InfoSegmentFindAClubViewController.title = "Info"
                 let MemberSegmentViewController = storyboard.instantiateViewController(withIdentifier: "MemberSegmentViewController")
                 MemberSegmentViewController.title = "Member"
                 let CommunicationSegmentViewController = storyboard.instantiateViewController(withIdentifier: "ClubEventsListViewController")
                 CommunicationSegmentViewController.title = "Events"
                 let ClubGallerySegmentListViewController = storyboard.instantiateViewController(withIdentifier: "ClubGallerySegmentListViewController")
                 ClubGallerySegmentListViewController.title = "Activity"

                
                 let segmentController = SJSegmentedViewController()
                 segmentController.segmentControllers = [InfoSegmentFindAClubViewController,MemberSegmentViewController,CommunicationSegmentViewController,ClubGallerySegmentListViewController]
                 segmentController.isFrom = true

                 navigationController?.pushViewController(segmentController, animated: true)
             }

         }
        else {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
    }
    ////
    //---select country
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
      
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        
        return muarrayMeetingDay.count;
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        
        let varGetValue:String = muarrayMeetingDay.object(at: row)as! String
        return varGetValue
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        var varGetValue  = muarrayMeetingDay.object(at: row)
        print(varGetValue)
        searchButton.titleLabel?.lineBreakMode = NSLineBreakMode.byTruncatingTail
        searchButton.setTitle(varGetValue as! String,  for: UIControl.State.normal)
        
        if varGetValue as! String == "Monday"{
            varGetValue = "Mon"
        }else if varGetValue as! String == "Tuesday"{
            varGetValue = "Tues"
        }else if varGetValue as! String == "Wednesday"{
            varGetValue = "Wed"
        }else if varGetValue as! String == "Thursday"{
            varGetValue = "Thurs"
        }else if varGetValue as! String == "Friday"{
            varGetValue = "Fri"
        }else if varGetValue as! String == "Saturday"{
            varGetValue = "Sat"
        }else if varGetValue as! String == "Sunday"{
            varGetValue = "Sun"
        }
     
//        searchButton.titleLabel?.lineBreakMode = NSLineBreakMode.byTruncatingTail
//        searchButton.setTitle(varGetValue as! String,  for: UIControl.State.normal)
//
        
       
    }

  
    /*
     var varGetClubType:String!=""
     var varGetClubId:String!=""
     
     var getValidUrl="https://apiuat.rotary.org:8443/v1.1/clubs/"+varGetClubType+"/"+varGetClubId+"/addresses"
     
     */
    //Fetch Data
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
           // let querySQL = "SELECT * FROM Find_A_Club_List where  moduleId='\(moduleID!)'"
            //deep
            let querySQL = "SELECT * FROM Find_A_Club_List where  moduleId='\("30")'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {
                //print((results?.stringForColumn("ClubId"))! as String)
                // let dd = NSMutableDictionary ()
                self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                let varBodMemberGroupID:String! =   (results?.string(forColumn: "GroupId"))
               // print(varBodMemberGroupID)
                let varBodMemberMasterUID:String!=(results?.string(forColumn: "moduleId"))
                let varDistrictID:String!=(results?.string(forColumn: "District"))
                let varCharterDate:String!=(results?.string(forColumn: "CharterDate"))
                let varClubName:String!=(results?.string(forColumn: "ClubName"))
                let varClubType:String!=(results?.string(forColumn: "ClubType"))
                let varClubId:String!=(results?.string(forColumn: "ClubId"))
                let Website:String!=(results?.string(forColumn: "Website"))
                var distance:String=""

                print(varClubId)
                if let distance1=(results?.string(forColumn: "distance"))
                {
                    distance=distance1
                }

                if let distances = distance as? String
                {
                    if distances != ""{
                        if let fDistsnce = Float(distances){
                            distance=String(format: "%.2f", fDistsnce)
                        }
                    }
                }

                self.commonClassHoldDataAccessibleVariable.varDistrictID = varDistrictID as String;
                self.commonClassHoldDataAccessibleVariable.varCharterDate = varCharterDate as String;
                self.commonClassHoldDataAccessibleVariable.varClubName = varClubName as String;
                self.commonClassHoldDataAccessibleVariable.varClubType = varClubType as String;
                self.commonClassHoldDataAccessibleVariable.varClubId = String(varClubId)
                self.commonClassHoldDataAccessibleVariable.Website = Website as String
                self.commonClassHoldDataAccessibleVariable.varGetGrpID = varBodMemberGroupID as String
                self.commonClassHoldDataAccessibleVariable.varDistance = distance as String
                self.mainArray.add(self.commonClassHoldDataAccessibleVariable)
                print(self.mainArray.add(self.commonClassHoldDataAccessibleVariable))
            // print(dd)
            // mainArray.addObject(dd)
            }
            //self.loaderClass.window = nil
            // self.tableBodListShow.reloadData()
            if mainArray.count > 0 {
               // checkRow = ""
                 NoRecordLabel.isHidden = true
                muarrayFindAClubList=mainArray
                tableSearchAClubList.reloadData()
            }else{
                 NoRecordLabel.isHidden = false
                mainArray = NSMutableArray()
                muarrayFindAClubList=NSMutableArray()
                tableSearchAClubList.reloadData()
            }
        }
        
        
        contactDB?.close()
        
    }

    
    func fetchDataFORClubName(_ varClubName:String)
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
    //masterUID, groupId , moduleId , profileID , MemberDesignation , memberName , pic , membermobile From Board_Of_Directors_List
    let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
    if (contactDB?.open())!
    
    {
     // let querySQL = "SELECT * FROM Find_A_Club_List where ClubName like '%\(varClubName)%' or CharterDate like '%\(varClubName)%' and moduleId='\(moduleID!)'"
        
        //deep
        let querySQL = "SELECT * FROM Find_A_Club_List where ClubName like '%\(varClubName)%' or CharterDate like '%\(varClubName)%' and moduleId='\("30")'"

        
        
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
//            let address:String!=(results?.string(forColumn: "address"))! as String
            print("your website\(Website)")
            var distance:String=""
print(varClubId)
            if let distance1=(results?.string(forColumn: "distance"))
            {
                distance=distance1
            }

            if let distances = distance as? String
            {
                if distances != ""{
                    if let fDistsnce = Float(distances){
                        distance=String(format: "%.2f", fDistsnce)
                    }
                }
            }

            self.commonClassHoldDataAccessibleVariable.varDistrictID = varDistrictID;
            self.commonClassHoldDataAccessibleVariable.varCharterDate = varCharterDate;
            self.commonClassHoldDataAccessibleVariable.varClubName = varClubName;
            self.commonClassHoldDataAccessibleVariable.varClubType = varClubType;
            self.commonClassHoldDataAccessibleVariable.varClubId = String(varClubId)
            self.commonClassHoldDataAccessibleVariable.Website = Website
            self.commonClassHoldDataAccessibleVariable.varGetGrpID = varBodMemberGroupID as String
            self.commonClassHoldDataAccessibleVariable.varDistance=distance
            self.mainArray.add(self.commonClassHoldDataAccessibleVariable)
        }
        
        if mainArray.count > 0 {
            // checkRow = ""
             NoRecordLabel.isHidden = true
            muarrayFindAClubList=mainArray
            tableSearchAClubList.reloadData()
        }else{
             NoRecordLabel.isHidden = false
            mainArray = NSMutableArray()
            muarrayFindAClubList=NSMutableArray()
            tableSearchAClubList.reloadData()
        }
        }
        
        
        contactDB?.close()
    }
    
    
    
    
    
    
    
    
    
    

}
