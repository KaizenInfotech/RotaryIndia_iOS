//
//  SearchFindArotarianViewController.swift
//  TouchBase
//
//  Created by deepak on 20/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
//import Kingfisher
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

class SearchFindArotarianViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate
{
    var moduleName:String!
    var muarrayFindARotarianList:NSMutableArray=NSMutableArray()
    var muarrayMainFindARotarianList:NSMutableArray=NSMutableArray()

    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()

    var isAdmin:String! = ""
    var varGroupId:String! = ""
    var varModuleId:String! = ""
    var appDelegate : AppDelegate = AppDelegate()

    @IBOutlet weak var tableFindARotarianList: UITableView!
    @IBOutlet weak var lblNoResult: UILabel!

    //Search
    
    var varGetSearchText:String! = ""
    var mainArray : NSMutableArray!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print("This is module id by rajendra jat")
        print(varModuleId)
        
        
        
        functionForSetLeftNavigation()
        mainArray = NSMutableArray()
        fetchData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- navigation
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(SearchFindArotarianViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
        muarrayFindARotarianList.removeAllObjects()
        self.navigationController?.popViewController(animated: true)
    }

    /*********************************************************************************/
    //MARK:- SearchBar
    var searchController: UISearchController!
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        muarrayFindARotarianList.removeAllObjects()
        muarrayFindARotarianList=NSMutableArray()
        print("Hello")
        print("searchText \(searchBar.text!)")
        varGetSearchText = searchBar.text!
        if searchText.count>0{
        fetchDataFORClubName(varGetSearchText)
        }
        else
        {
         fetchData()
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton=true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        print("searchText \(searchBar.text!)")
        varGetSearchText = searchBar.text!
        muarrayFindARotarianList.removeAllObjects()
        muarrayFindARotarianList=NSMutableArray()
        fetchDataFORClubName(varGetSearchText)
        searchBar.resignFirstResponder()
    }
    func updateSearchResultsForSearchController(_ searchController: UISearchController)
    {
        let varGetText=searchController.searchBar.text
        if(varGetText?.characters.count<=0 && varGetText != "")
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
        mainArray = NSMutableArray()
        fetchData()
        self.tableFindARotarianList.reloadData()
    }
    /*********************************************************************************/
    
    
    
    
    
    
    //MARK:- Table Method
    /*--------------------------------tableForAddRepeatDateAndTimeInAnnounce methods--------------Start-------------*/
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayFindARotarianList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : SearchFindARotarianTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SearchFindARotarianTableViewCell
        if(muarrayFindARotarianList.count>0)
        {
            commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
            commonClassHoldDataAccessibleVariable = muarrayFindARotarianList.object(at: indexPath.row) as! CommonAccessibleHoldVariable
            let trimmedString = commonClassHoldDataAccessibleVariable.varmemberName?.trimmingCharacters(in: CharacterSet.whitespaces)
            cell.labelName.text=trimmedString
            let designation = commonClassHoldDataAccessibleVariable.vardesignation
            if(designation == "")
            {
                //cell.labelDescription.text="NA"
            }
            else
            {
             cell.labelDescription.text=designation
            }
            cell.lblClubName.text=commonClassHoldDataAccessibleVariable.varclubName
            let varBodMemberPic = commonClassHoldDataAccessibleVariable.varpic
           //var varBodMemberPic = "http://web.touchbase.in/Documents/MemberProfile/02032017080352AM.png"
            if(varBodMemberPic == "")
            {
                cell.imageUser.image = UIImage(named: "profile_pic.png")
                cell.imageUser.layer.borderWidth = 1.0
                cell.imageUser.layer.masksToBounds = false
                cell.imageUser.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
                cell.imageUser.layer.cornerRadius = cell.imageUser.frame.size.width/2
                cell.imageUser.clipsToBounds = true
            }
            else
            {
                /*------------------------------Code by --------------------DPK--------------------------- */
//                if let checkedUrl = NSURL(string: varBodMemberPic as! String) {
//                    KingfisherManager.sharedManager.retrieveImageWithURL(checkedUrl, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
//                        cell.imageUser.image = image
                        cell.imageUser.layer.borderWidth = 1.0
                        cell.imageUser.layer.masksToBounds = false
                        cell.imageUser.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
                        cell.imageUser.layer.cornerRadius = cell.imageUser.frame.size.width/2
                        cell.imageUser.clipsToBounds = true
                        
                        
                        let ImageProfilePic:String = varBodMemberPic!.replacingOccurrences(of: " ", with: "%20")
                        let checkedUrl = URL(string: ImageProfilePic)
                        cell.imageUser.sd_setImage(with: checkedUrl)
                   // })
                    /*-----------------Code by --------------------DPK--------------------------- */
                    
                //}
            }
        }
        cell.buttonMain.addTarget(self, action: #selector(SearchFindArotarianViewController.buttonMainClickedEvent(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonMain.tag=indexPath.row;
        return cell as SearchFindARotarianTableViewCell
    }
    
    /*-------------------------------------------function for remove cell row-------------------Start---------*/
    @objc func buttonMainClickedEvent(_ sender:UIButton)
    {
        print("click on table")
        print(commonClassHoldDataAccessibleVariable.varprofileID)
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
        commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
        commonClassHoldDataAccessibleVariable = muarrayFindARotarianList.object(at: sender.tag) as! CommonAccessibleHoldVariable
        let objCommonHoldDataVariable = self.storyboard!.instantiateViewController(withIdentifier: "RotarianProfileBusinessDetailsViewController") as! RotarianProfileBusinessDetailsViewController
           objCommonHoldDataVariable.varMemberProfileID =  commonClassHoldDataAccessibleVariable.varprofileID
            //objCommonHoldDataVariable.grpID = varGroupId
            
            //print("groupdfghfhfghfghftghfg",varGroupId)

            
        self.navigationController?.pushViewController(objCommonHoldDataVariable, animated: true)
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
    }
    
    //Fetch Data
    func fetchData()
    {
        lblNoResult.isHidden=true
        mainArray = NSMutableArray()
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
        //masterUID ,GroupId , moduleId ,clubName , designation  , memberMobile ,memberName , pic ,,profileID  , Find_A_Rotarian_List
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            //let querySQL = "SELECT * FROM Find_A_Rotarian_List where  moduleId='\(moduleID!)'"  06-04-2018 Comment by DPK and crashing Stop
            let querySQL = "SELECT * FROM Find_A_Rotarian_List"   // Replace by DPK

            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {
                //print((results?.stringForColumn("profileID"))! as String)
                // let dd = NSMutableDictionary ()
                self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
               // let varBodMemberGroupID:String! =   (results?.stringForColumn("GroupId"))
               // print(varBodMemberGroupID)
                let varmasterUID:String!=(results?.string(forColumn: "masterUID"))! as String
                let varclubName:String!=(results?.string(forColumn: "clubName"))! as String
                let vardesignation:String!=(results?.string(forColumn: "designation"))! as String
                let varmemberMobile:String!=(results?.string(forColumn: "memberMobile"))! as String
                let varmemberName:String!=(results?.string(forColumn: "memberName"))! as String
                let varpic:String!=(results?.string(forColumn: "pic"))! as String
                let varprofileID:String!=(results?.string(forColumn: "profileID"))! as String
               
                self.commonClassHoldDataAccessibleVariable.varclubName = varclubName as String;
                self.commonClassHoldDataAccessibleVariable.vardesignation = vardesignation as String;
                self.commonClassHoldDataAccessibleVariable.varmasterUID = varmasterUID as? String;
                self.commonClassHoldDataAccessibleVariable.varmemberMobile = varmemberMobile as String;
                self.commonClassHoldDataAccessibleVariable.varmemberName = varmemberName as String;
                self.commonClassHoldDataAccessibleVariable.varpic = varpic as String;
                self.commonClassHoldDataAccessibleVariable.varprofileID = varprofileID as String;
                self.mainArray.add(self.commonClassHoldDataAccessibleVariable)
            }
            //self.loaderClass.window = nil
            // self.tableBodListShow.reloadData()
            if mainArray.count > 0 {
                // checkRow = ""
                lblNoResult.isHidden = true
                muarrayFindARotarianList=mainArray
                tableFindARotarianList.reloadData()
            }else{
                //NoRecordLabel.hidden = false
                lblNoResult.isHidden = false
                 self.view.makeToast("No Results", duration: 2, position: CSToastPositionCenter)
                mainArray = NSMutableArray()
                muarrayFindARotarianList=NSMutableArray()
                tableFindARotarianList.reloadData()
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
            
            print(varClubName)
            print(moduleID)
            //        var moduleID = UserDefaults.standard.string(forKey: "session_GetModuleId")
            
            print(UserDefaults.standard.string(forKey: "session_GetModuleId"))
            var modID = ""
            if let moddID = moduleID {
                modID = moddID
            }
                
                let querySQL = "SELECT * FROM Find_A_Rotarian_List where clubName like '%\(varClubName)%' or memberName like '%\(varClubName)%' or designation like '%\(varClubName)%' and moduleId='\(modID)'"
                print(querySQL)
                let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
                while results?.next() == true
                {
                    print((results?.string(forColumn: "profileID"))! as String)
                    // let dd = NSMutableDictionary ()
                    self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                    let varmasterUID:String!=(results?.string(forColumn: "masterUID"))! as String
                    let varclubName:String!=(results?.string(forColumn: "clubName"))! as String
                    let vardesignation:String!=(results?.string(forColumn: "designation"))! as String
                    let varmemberMobile:String!=(results?.string(forColumn: "memberMobile"))! as String
                    let varmemberName:String!=(results?.string(forColumn: "memberName"))! as String
                    let varpic:String!=(results?.string(forColumn: "pic"))! as String
                    let varprofileID:String!=(results?.string(forColumn: "profileID"))! as String
                    
                    self.commonClassHoldDataAccessibleVariable.varclubName = varclubName as String;
                    self.commonClassHoldDataAccessibleVariable.vardesignation = vardesignation as String;
                    self.commonClassHoldDataAccessibleVariable.varmasterUID = varmasterUID as? String;
                    self.commonClassHoldDataAccessibleVariable.varmemberMobile = varmemberMobile as String;
                    self.commonClassHoldDataAccessibleVariable.varmemberName = varmemberName as String;
                    self.commonClassHoldDataAccessibleVariable.varpic = varpic as String;
                    self.commonClassHoldDataAccessibleVariable.varprofileID = varprofileID as String;
                    self.mainArray.add(self.commonClassHoldDataAccessibleVariable)
                    
                }
                if mainArray.count > 0 {
                    lblNoResult.isHidden = true
                    muarrayFindARotarianList=mainArray
                    tableFindARotarianList.reloadData()
                }
                else
                {
                    lblNoResult.isHidden = false
                    mainArray = NSMutableArray()
                    muarrayFindARotarianList=NSMutableArray()
                    tableFindARotarianList.reloadData()
                }
        }
    }
 
}
//SearchFindArotarianViewController









