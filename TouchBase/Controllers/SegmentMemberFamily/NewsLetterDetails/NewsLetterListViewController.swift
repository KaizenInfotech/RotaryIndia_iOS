//
//  NewsLetterListViewController.swift
//  TouchBase
//
//  Created by rajendra on 01/08/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
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


class NewsLetterListViewController: UIViewController,UITextFieldDelegate , UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var labelNoRecords: UILabel!
    @IBOutlet weak var tableNewsLetterListShow: UITableView!
    var muDictionary:NSMutableDictionary = NSMutableDictionary()
    var muarrayEventsDetailSendToNextScreen:NSMutableArray=NSMutableArray()
    
    
    var varGroupID:String!=""
    var varGetSearchText:String! = ""
    let searchTextField = UITextField()
    var mainArray : NSMutableArray!
    var muarrayFindAClubEventList:NSMutableArray=NSMutableArray()
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.labelNoRecords.isHidden=true
        createNavigationBar()
        mainArray=NSMutableArray()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Navigation Bar Function
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Newletter"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(NewsLetterListViewController.backClicked), for: UIControl.Event.touchUpInside)
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
        varGetSearchText = searchBar.text!
        SearchFromMemberNameAndYear(varGetSearchText)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton=true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        print("searchText \(searchBar.text!)")
        varGetSearchText = searchBar.text!
        // muarrayFindAClubEventList.removeAllObjects()
        SearchFromMemberNameAndYear(varGetSearchText)
        searchBar.resignFirstResponder()
    }
    func updateSearchResults(for searchController: UISearchController)
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
        self.tableNewsLetterListShow.reloadData()
    }
    
    
    //MARK:- Table Methods
    /*--------------------------------tableForAddRepeatDateAndTimeInAnnounce methods--------------Start-------------*/
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayFindAClubEventList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell : NewsLetterListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "NewsLetterListTableViewCell") as! NewsLetterListTableViewCell
        if(muarrayFindAClubEventList.count>0)
        {
            print(muarrayFindAClubEventList)
            
            cell.labelNewsLetterTitle.text! = (muarrayFindAClubEventList.object(at: indexPath.row) as AnyObject).value(forKey: "ebulletinTitle")! as AnyObject as! String
            
            cell.labelDateAndTime.text! = (muarrayFindAClubEventList.object(at: indexPath.row) as AnyObject).value(forKey: "publishDateTime")! as AnyObject as! String
         
        }
        cell.buttonMain.addTarget(self, action: #selector(NewsLetterListViewController.buttonMainClickedEvent(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonMain.tag=indexPath.row;
        return cell as NewsLetterListTableViewCell
    }
    /*-------------------------------------------function for select cell row-------------------Start---------*/
    @objc func buttonMainClickedEvent(_ sender:UIButton)
    {
        
        let varUrlLink = (muarrayFindAClubEventList.object(at: sender.tag) as AnyObject).value(forKey: "ebulletinlink") as! String
        
        let objClubEventDetailsShowViewController = self.storyboard!.instantiateViewController(withIdentifier: "ebdetail") as! EbulletinDetailViewController
        objClubEventDetailsShowViewController.urlLink=varUrlLink
        objClubEventDetailsShowViewController.isCalled = "Clubs"
        
        var dictTemporaryDictionary:NSDictionary=(muarrayFindAClubEventList.object(at: sender.tag) as AnyObject) as! NSDictionary
        
        objClubEventDetailsShowViewController.bulletinID = dictTemporaryDictionary.value(forKey: "ebulletinID") as! String as NSString
        objClubEventDetailsShowViewController.moduleName = "Newsletters"
        
        // objClubEventDetailsShowViewController.muarrayFindAClubEventList=muarrayFindAClubEventList
        // urlLink
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
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            let querySQL = "SELECT * FROM Club_NewsLetter_Details where  grpID = '\(varGroupID!)'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {
                
                let ebulletinID:String!=(results?.string(forColumn: "ebulletinID"))!
                let ebulletinTitle:String!=(results?.string(forColumn: "ebulletinTitle"))!
                let ebulletinlink:String!=(results?.string(forColumn: "ebulletinlink"))!
                let ebulletinType:String!=(results?.string(forColumn: "ebulletinType"))!
                let filterType:String!=(results?.string(forColumn: "filterType"))!
                let createDateTime:String!=(results?.string(forColumn: "createDateTime"))!
                let publishDateTime:String!=(results?.string(forColumn: "publishDateTime"))!
                let expiryDateTime:String!=(results?.string(forColumn: "expiryDateTime"))!
                let isAdmin:String!=(results?.string(forColumn: "isAdmin"))!
                let isRead:String!=(results?.string(forColumn: "isRead"))!
                let grpID:String!=(results?.string(forColumn: "grpID"))!
               
                self.muDictionary = ["ebulletinID": ebulletinID,
                                     "ebulletinTitle": ebulletinTitle,
                                     "ebulletinlink": ebulletinlink,
                                     "ebulletinType": ebulletinType,
                                     "filterType": filterType,
                                     "createDateTime": createDateTime,
                                     "publishDateTime": publishDateTime,
                                     "expiryDateTime": expiryDateTime,
                                     "isAdmin": isAdmin,
                                     "isRead": isRead,
                                     "grpID":grpID
                ]
                self.mainArray.add(self.muDictionary)
            }
            //self.loaderClass.window = nil
            // self.tableBodListShow.reloadData()
            
            print("this is array count:-----")
            print(mainArray.count)
            
            if mainArray.count > 0 {
                // checkRow = ""
                labelNoRecords.isHidden = true
                muarrayFindAClubEventList=mainArray
                tableNewsLetterListShow.reloadData()
            }else{
                labelNoRecords.isHidden = false
                mainArray = NSMutableArray()
                // muarrayFindAClubList=NSMutableArray()
                //tableSearchAClubList.reloadData()
            }
        }
        
    }
    
    func SearchFromMemberNameAndYear(_ MemberName:String)
    {
        mainArray = NSMutableArray()
        muDictionary=NSMutableDictionary()
        //loaderClass.loaderViewMethod()
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
        if (contactDB?.open())! {
            let querySQL = "SELECT * FROM Club_NewsLetter_Details where ebulletinTitle like '%\(MemberName)%' or publishDateTime like '%\(MemberName)%' and grpID = '\(varGroupID)'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {
                let ebulletinID:String!=(results?.string(forColumn: "ebulletinID"))!
                let ebulletinTitle:String!=(results?.string(forColumn: "ebulletinTitle"))!
                let ebulletinlink:String!=(results?.string(forColumn: "ebulletinlink"))!
                let ebulletinType:String!=(results?.string(forColumn: "ebulletinType"))!
                let filterType:String!=(results?.string(forColumn: "filterType"))!
                let createDateTime:String!=(results?.string(forColumn: "createDateTime"))!
                let publishDateTime:String!=(results?.string(forColumn: "publishDateTime"))!
                let expiryDateTime:String!=(results?.string(forColumn: "expiryDateTime"))!
                let isAdmin:String!=(results?.string(forColumn: "isAdmin"))!
                let isRead:String!=(results?.string(forColumn: "isRead"))!
                let grpID:String!=(results?.string(forColumn: "grpID"))!
                
                
                print(ebulletinID,ebulletinTitle,ebulletinlink)
                
                if(ebulletinID == "")
                {
                }
                else
                {
                    self.muDictionary = ["ebulletinID": ebulletinID,
                                         "ebulletinTitle": ebulletinTitle,
                                         "ebulletinlink": ebulletinlink,
                                         "ebulletinType": ebulletinType,
                                         "filterType": filterType,
                                         "createDateTime": createDateTime,
                                         "publishDateTime": publishDateTime,
                                         "expiryDateTime": expiryDateTime,
                                         "isAdmin": isAdmin,
                                         "isRead": isRead , "grpID":grpID]
                    
                    self.mainArray.add(self.muDictionary)
                }
                
            }
            // self.loaderClass.window = nil
            
            
            print("this is array count:----- 222")
            print(mainArray.count)
            
            self.tableNewsLetterListShow.reloadData()
            if mainArray.count > 0 {
                // checkRow = ""
                labelNoRecords.isHidden = true
                muarrayFindAClubEventList=mainArray
                tableNewsLetterListShow.reloadData()
            }else{
                //checkRow = "1"
                labelNoRecords.isHidden = false
                mainArray = NSMutableArray()
                muarrayFindAClubEventList=NSMutableArray()
                //directoryTableView.reloadData()
            }
        }
        
    }
}
