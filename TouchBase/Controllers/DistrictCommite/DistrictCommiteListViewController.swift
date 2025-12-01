//
//  DistrictCommiteListViewController.swift
//  TouchBase
//
//  Created by rajendra on 21/07/17.
//  Copyright © 2017 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
//import  Kingfisher
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


class DistrictCommiteListViewController: UIViewController, UITextFieldDelegate , UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate {
    
    var muarrayHold:NSMutableArray=NSMutableArray()
    
    @IBOutlet weak var tableDistrictCommiteeMemberList: UITableView!
    @IBOutlet weak var NoRecordLabel: UILabel!
    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
    var varGetCount:String!=""
    let loaderClass  = WebserviceClass()
    var appDelegate : AppDelegate = AppDelegate()
    var mainArray : NSMutableArray!
    var copymainArray:NSArray!
    let bounds = UIScreen.main.bounds
    let searchTextField = UITextField()
    var grpID: String!=""
    var isAdmin:String! = ""
    var checkRow: NSString!
    var varGetCellDateSelected:String! = ""
    var searchingNameArray : NSMutableArray!
    var searchingkeywordArray :NSMutableArray!
    var searchingMobileNoArray : NSMutableArray!
    var str = String()
    var varGetSearchText:String! = ""
    //MARK:- Array Declration
    var muarrayBodList:NSMutableArray = NSMutableArray()
    var updatedOn =  String ()
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    // var moduleId = NSString!
    var isCategory:String!=""
    var userID:NSString!
    var moduleId:String! = ""
    var letGetCategoryId:String!=""
    var moduleName:String! = ""
    
    var filtered:[String] = []
    var searchActive : Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.NoRecordLabel.isHidden=true
        tableDistrictCommiteeMemberList.dataSource=self
        tableDistrictCommiteeMemberList.delegate=self
        createNavigationBar()
        functionForTextFieldLableButtonViewTableScrollViewSetting()
        mainArray = NSMutableArray()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            print(moduleId)
            //functionForGetDataFromServer()
             getBoardOfDirectorList(grpID as! NSString, searchText: "")
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            mainArray = NSMutableArray()
             SVProgressHUD.dismiss()
            //   fetchData()
        }
        
    }
    
    /*------------------------------------Search Bar------------------------------------*/
    //MARK:- SearchBar
    var searchController: UISearchController!
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        print("Hello")
        varGetSearchText = searchBar.text!
        mainArray = NSMutableArray()
        SearchFromMemberNameAndYear(varGetSearchText)
        self.tableDistrictCommiteeMemberList.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton=true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        print("searchText \(searchBar.text!)")
        varGetSearchText = searchBar.text!
        muarrayBodList.removeAllObjects()
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
        self.tableDistrictCommiteeMemberList.reloadData()
    }
    /*------------------------------------Search Bar------------------------------------*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func functionForTextFieldLableButtonViewTableScrollViewSetting()
    {
        muarrayBodList = NSMutableArray()
        searchTextField.autocorrectionType = .no
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if(varGetSearchText.characters.count > 0 || varGetSearchText == ""){
            clickSearch()
        }
        textField.resignFirstResponder()
        return true
    }
    func clickSearch()
    {
        print(muarrayBodList)
    }
    
    //MARK:- Function
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(BoardOfDirectorsViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DirectoryViewController.AddEventAction))
        add.tintColor = UIColor.white
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Server Calling
    func getBoardOfDirectorList(_ groupId:NSString,searchText:NSString)
    {
        //loaderViewMethod()
        let completeURL:String! = baseUrl+row_GetDistrictCommiteList
        let parameterst = ["grpId" : groupId, "searchText" : searchText]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            print(response)
            print(response)
            let dd = response as! NSDictionary
            print("dd \(dd)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            if((dd.object(forKey: "TBGetBODResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                for i in 0..<(((response.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "DistrictCommitteeResult")! as AnyObject).value(forKey: "memberName")! as AnyObject).count
                {
                    self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                    print((((response.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "DistrictCommitteeResult")! as AnyObject).value(forKey: "memberName")! as AnyObject).object(at: i))
                    let varBodMemberMasterUID=((((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "DistrictCommitteeResult")! as AnyObject).value(forKey: "masterUID")! as AnyObject).object(at: i))
                    let varBodMemberGroupID=((((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "DistrictCommitteeResult")! as AnyObject).value(forKey: "grpID")! as AnyObject).object(at: i))
                    let varBodMemberProfileId=(((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "DistrictCommitteeResult")! as AnyObject).value(forKey: "profileID")! as AnyObject).object(at: i)
                    let varBodMemberName=((((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "DistrictCommitteeResult")! as AnyObject).value(forKey: "memberName")! as AnyObject).object(at: i))
                    let varBodMemberMobile=((((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "DistrictCommitteeResult")! as AnyObject).value(forKey: "membermobile")! as AnyObject).object(at: i))
                    let varBodMemberDesignation=(((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "DistrictCommitteeResult")! as AnyObject).value(forKey: "MemberDesignation")! as AnyObject).object(at: i)
                    let varBodMemberClubName=(((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "DistrictCommitteeResult")! as AnyObject).value(forKey: "clubName")! as AnyObject).object(at: i)
                    let varBodMemberPic=(((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "DistrictCommitteeResult")! as AnyObject).value(forKey: "pic")! as AnyObject).object(at: i)
                    
                    self.commonClassHoldDataAccessibleVariable.varBodMemberMasterUID = varBodMemberMasterUID as! String;
                    self.commonClassHoldDataAccessibleVariable.varBodMemberName = varBodMemberName as! String;
                    self.commonClassHoldDataAccessibleVariable.varBodMemberGroupID = varBodMemberGroupID as! String;
                    self.commonClassHoldDataAccessibleVariable.varBodMemberProfileId = varBodMemberProfileId as! String;
                    self.commonClassHoldDataAccessibleVariable.varBodMemberMobile = varBodMemberMobile as! String;
                    self.commonClassHoldDataAccessibleVariable.varBodMemberDesignation = varBodMemberDesignation as! String;
                    self.commonClassHoldDataAccessibleVariable.varBodMemberClubName=varBodMemberClubName as! String;
                    self.commonClassHoldDataAccessibleVariable.varBodMemberPic = varBodMemberPic as! String;
                    
                    
                    self.muarrayBodList.add(self.commonClassHoldDataAccessibleVariable)
                    //[self.tableDistrictCommiteeMemberList .reloadData()];
                }
                
                self.appDelegate = UIApplication.shared.delegate as! AppDelegate
              if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                    self.DeleteDataInlocal()
                    if(self.muarrayBodList.count>0)
                    {
                        self.varGetCount=String(self.muarrayBodList.count)
                        self.NoRecordLabel.isHidden = true
                        self.SaveDataInlocal(self.muarrayBodList)
                        self.mainArray = NSMutableArray()
                        self.fetchData()
                    }
                    else
                    {
                        self.NoRecordLabel.isHidden = false
                        self.window = nil
                    }
                }
                else
                {
                    self.mainArray = NSMutableArray()
                    self.fetchData()
                    self.tableDistrictCommiteeMemberList.reloadData()
                }
                
            }
            else
            {
                self.NoRecordLabel.isHidden = false
                self.window = nil
            }
            self.window = nil
            SVProgressHUD.dismiss()
            }
        })
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        
        if scrollView == tableDistrictCommiteeMemberList
        {
            
            self.view.makeToast("Total members "+varGetCount, duration: 2, position: CATransitionSubtype.fromBottom)
        }
        
    }

    
    //MARK:- Table Methods
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayBodList.count
    }
    @objc func buttonPicBigViewClickEvent(_ sender:UIButton)
    {
        
        
      //  let  directoryList = mainArray[sender.tag] as! NSDictionary
     //   let isUpperImageAvailable = directoryList.objectForKey("profilePic") as? String
        
        
        
        
        var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
        objCommonHoldDataVariable = muarrayBodList.object(at: sender.tag) as! CommonAccessibleHoldVariable;
     
        var isUpperImageAvailable=objCommonHoldDataVariable.varBodMemberPic
 
    
            isUpperImageAvailable = isUpperImageAvailable?.replacingOccurrences(of: " ", with: "%20")

        print(isUpperImageAvailable)
        print("Clicked !!")
        if(isUpperImageAvailable!.characters.count>10)
        {
            print(isUpperImageAvailable)
            print("available")
            let objImageFullViewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ImageFullViewViewController") as! ImageFullViewViewController
            objImageFullViewViewController.varGetImageUrl=isUpperImageAvailable
            self.navigationController?.pushViewController(objImageFullViewViewController, animated: true)
        }
        else
        {
            print("User image is not available !!")
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableDistrictCommiteeMemberList.dequeueReusableCell(withIdentifier: "DistrictCommiteTableViewCell", for: indexPath) as! DistrictCommiteTableViewCell
        
//        cell.imageBodProfilePic.layer.borderWidth = 1.0
//        cell.imageBodProfilePic.layer.masksToBounds = false
//        cell.imageBodProfilePic.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).CGColor
//        cell.imageBodProfilePic.layer.cornerRadius = cell.imageBodProfilePic.frame.size.width/2
        cell.imageBodProfilePic.clipsToBounds = true
        
        print("working here 13-03-2018---------")
       // print(muarrayHold)
//        var geCategoryType = muarrayBodList.objectAtIndex(indexPath.row).valueForKey("CategoryType")as! String
//        if(geCategoryType=="notcategory")
//        {
//            
//        }
//        else if(geCategoryType=="category")
//        {
//            
//        }
        var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
        objCommonHoldDataVariable = muarrayBodList.object(at: indexPath.row) as! CommonAccessibleHoldVariable;
        let varBodMemberName=objCommonHoldDataVariable.varBodMemberName
        let varBodMemberDesignation=objCommonHoldDataVariable.varBodMemberClubName+" - "+objCommonHoldDataVariable.varBodMemberDesignation
        let varBodMemberPic=objCommonHoldDataVariable.varBodMemberPic
        cell.lblBodMemberName.text = varBodMemberName
        cell.lblDesignation.text = varBodMemberDesignation
        if(varBodMemberPic == "")
        {
            cell.imageBodProfilePic.image = UIImage(named: "profile_pic")
        }
        else
        {
            let ImageProfilePic:String = varBodMemberPic!.replacingOccurrences(of: " ", with: "%20")
            let checkedUrl = URL(string: ImageProfilePic)
            cell.imageBodProfilePic.sd_setImage(with: checkedUrl)
        }
         cell.buttonPicBigView.tag=indexPath.row
        cell.buttonPicBigView.isHidden=false
        cell.buttonPicBigView.addTarget(self, action: #selector(DistrictCommiteListViewController.buttonPicBigViewClickEvent(_:)), for: UIControl.Event.touchUpInside)
        
        
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            
            if(isCategory=="2")
            {
                tableView.deselectRow(at: indexPath, animated: true)
                var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
                objCommonHoldDataVariable = muarrayBodList.object(at: indexPath.row) as! CommonAccessibleHoldVariable;
                let objProfileDynamicNewViewController = self.storyboard!.instantiateViewController(withIdentifier: "DistrictDirectoryDetailsVC") as! DistrictDirectoryDetailsVC
                let grpID =  objCommonHoldDataVariable.varBodMemberGroupID
                let profileId = objCommonHoldDataVariable.varBodMemberProfileId
                let ProfileImage = objCommonHoldDataVariable.varBodMemberPic
                let userNames = objCommonHoldDataVariable.varBodMemberName
                
                objProfileDynamicNewViewController.userProfile = ProfileImage
                objProfileDynamicNewViewController.selectedMemberProfileID=profileId
                objProfileDynamicNewViewController.groupID=grpID
                objProfileDynamicNewViewController.userName=userNames
                objProfileDynamicNewViewController.designationShowFromDistrictCommitee=objCommonHoldDataVariable.varBodMemberClubName+" - "+objCommonHoldDataVariable.varBodMemberDesignation
                objProfileDynamicNewViewController.callFromDistrictCommitee = "callFromDistrictCommitee"
                self.navigationController?.pushViewController(objProfileDynamicNewViewController, animated: true)
                
            }
                
            else
            {
                
                var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
                objCommonHoldDataVariable = muarrayBodList.object(at: indexPath.row) as! CommonAccessibleHoldVariable;
                let objProfileDynamicNewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
                let grpID =  objCommonHoldDataVariable.varBodMemberGroupID
                let profileId = objCommonHoldDataVariable.varBodMemberProfileId
                let masterId = objCommonHoldDataVariable.varBodMemberMasterUID
                
                objProfileDynamicNewViewController.masterId=masterId
                objProfileDynamicNewViewController.profileId=profileId
                objProfileDynamicNewViewController.grpID=grpID
                objProfileDynamicNewViewController.isAdmin = isAdmin
                objProfileDynamicNewViewController.NormalMemberOrAdmin="BOD"
                objProfileDynamicNewViewController.ClubNameFotShowProfile=objCommonHoldDataVariable.varBodMemberClubName+" - "+objCommonHoldDataVariable.varBodMemberDesignation
                objProfileDynamicNewViewController.FromDistrictOrBOD = "FromDistrictOrBOD"
                objProfileDynamicNewViewController.FromDistrictHideFamilyDetails = "FromDistrictHideFamilyDetails"
                objProfileDynamicNewViewController.isCategory=self.isCategory
                
                self.navigationController?.pushViewController(objProfileDynamicNewViewController, animated: true)
                
            }
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
    }
    
    
    
    
    /*----------------------------------------------------------------------------DPK----------------------------*/
    //MARK:- Loader Method
//    func loaderViewMethod()
//    {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        if let window = window {
//            window.backgroundColor = UIColor.clear
//            window.rootViewController = UIViewController()
//            window.makeKeyAndVisible()
//        }
//        let Loadingview = UIView()
//        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
//        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
//        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")
//        let gifView = UIImageView()
//        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
//        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
//        gifView.backgroundColor = UIColor.clear
//        //                gifView.contentMode = .Center
//        Loadingview.addSubview(gifView)
//        window?.addSubview(Loadingview)
//        
//    }
    
    
    //MARK:- Local Data Store
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
            var ProrityValue:Int = 0
            for i in 0 ..< arrdata.count
            {
                var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
                objCommonHoldDataVariable = arrdata.object(at: i) as! CommonAccessibleHoldVariable;
                let varBodMemberName=objCommonHoldDataVariable.varBodMemberName
                let varBodMemberDesignation=objCommonHoldDataVariable.varBodMemberDesignation
                let varBodMemberPic=objCommonHoldDataVariable.varBodMemberPic
                let varBodMemberProfileId = objCommonHoldDataVariable.varBodMemberProfileId
                let varBodMemberMobile = objCommonHoldDataVariable.varBodMemberMobile
                let varGroupID = objCommonHoldDataVariable.varBodMemberGroupID
                let varBodMemberClubName = objCommonHoldDataVariable.varBodMemberClubName
                //let  dict = arrdata[i] as! NSDictionary
                //masterUID, groupId , moduleId , profileID , MemberDesignation , memberName , pic , membermobile From Board_Of_Directors_List
                
                //                if (varBodMemberDesignation == "President")
                //                {
                //                    ProrityValue = 1
                //                }
                //                else if (varBodMemberDesignation == "Secretary")
                //                {
                //                    ProrityValue = 2
                //                }
                //                else if (varBodMemberDesignation == "Treasurer")
                //                {
                //                    ProrityValue = 3
                //                }
                //                else if (varBodMemberDesignation == "Chairman")
                //                {
                //                    ProrityValue = 4
                //                }
                //                else
                //                {
                //                    ProrityValue = 5
                //                }
                ProrityValue=1
                
                
                let insertSQL = "INSERT INTO District_Commitee_List (masterUID , groupId, moduleId, profileID , MemberDesignation,memberName,pic,membermobile,clubName,sortingBYDesignation) VALUES ('\(mainMemberID!)', '\(varGroupID!)', '\(moduleId)', '\(varBodMemberProfileId!)', '\(varBodMemberDesignation!)', '\(varBodMemberName)', '\(varBodMemberPic)', '\(varBodMemberMobile!)','\(varBodMemberClubName!)','\(ProrityValue)')"
                //print(insertSQL)
                
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
    
    //Fetch Data
    func fetchData()
    {
      //  loaderClass.loaderViewMethod()
        checkRow = ""
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        else
        {
               // self.Cre@objc atetablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //masterUID, groupId , moduleId , profileID , MemberDesignation , memberName , pic , membermobile From Board_Of_Directors_List
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            //  let querySQL = "SELECT * FROM Board_Of_Directors_List where groupId = '\(grpID)' and moduleId='\(moduleId)'  order by sortingBYDesignation asc"
            let querySQL = "SELECT * FROM District_Commitee_List where groupId = '\(grpID)' and moduleId='\(moduleId)'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {
                print((results?.string(forColumn: "profileID"))! as String)
                // let dd = NSMutableDictionary ()
                self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                let varBodMemberGroupID:String! =   (results?.string(forColumn: "groupId"))
                //print(varBodMemberGroupID)
                let varBodMemberMasterUID:String!=(results?.string(forColumn: "moduleId"))! as String
                let varBodMemberProfileId:String!=(results?.string(forColumn: "profileID"))! as String
                let varBodMemberDesignation:String!=(results?.string(forColumn: "MemberDesignation"))! as String
                let varBodMemberName:String!=(results?.string(forColumn: "memberName"))! as String
                let varBodMemberPic:String!=(results?.string(forColumn: "pic"))! as String
                let varBodMemberMobile:String!=(results?.string(forColumn: "membermobile"))! as String
                let varBodMemberClubName:String!=(results?.string(forColumn: "clubName"))! as String
                
                self.commonClassHoldDataAccessibleVariable.varBodMemberMasterUID = varBodMemberMasterUID
                self.commonClassHoldDataAccessibleVariable.varBodMemberName = varBodMemberName
                self.commonClassHoldDataAccessibleVariable.varBodMemberGroupID = varBodMemberGroupID
                self.commonClassHoldDataAccessibleVariable.varBodMemberProfileId = varBodMemberProfileId
                self.commonClassHoldDataAccessibleVariable.varBodMemberMobile = varBodMemberMobile
                self.commonClassHoldDataAccessibleVariable.varBodMemberDesignation = varBodMemberDesignation
                self.commonClassHoldDataAccessibleVariable.varBodMemberPic = varBodMemberPic
                self.commonClassHoldDataAccessibleVariable.varBodMemberClubName = varBodMemberClubName
                self.mainArray.add(self.commonClassHoldDataAccessibleVariable)
                print(self.mainArray)
                //mainArray.addObject(dd)
            }
            self.loaderClass.window = nil
            self.tableDistrictCommiteeMemberList.reloadData()
            if mainArray.count > 0 {
                checkRow = ""
                NoRecordLabel.isHidden = true
                muarrayBodList=mainArray
                tableDistrictCommiteeMemberList.reloadData()
            }else{
                checkRow = "1"
                NoRecordLabel.isHidden = false
                mainArray = NSMutableArray()
                muarrayBodList=NSMutableArray()
                //directoryTableView.reloadData()
            }
        }
        
    }
    
    
    func SearchFromMemberNameAndYear(_ MemberName:String)
    {
        //loaderClass.loaderViewMethod()
        checkRow = ""
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
            let querySQL = "SELECT * FROM District_Commitee_List where clubName like '%\(MemberName)%' or MemberDesignation like '%\(MemberName)%' or memberName like '%\(MemberName)%' and groupId = '\(grpID)' and moduleId='\(moduleId)'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {
                print((results?.string(forColumn: "profileID"))! as String)
                // let dd = NSMutableDictionary ()
                self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                let varBodMemberGroupID:String! =   (results?.string(forColumn: "groupId"))
                // print(varBodMemberGroupID)
                let varBodMemberMasterUID:String!=(results?.string(forColumn: "moduleId"))! as String
                let varBodMemberProfileId:String!=(results?.string(forColumn: "profileID"))! as String
                let varBodMemberDesignation:String!=(results?.string(forColumn: "MemberDesignation"))! as String
                let varBodMemberName:String!=(results?.string(forColumn: "memberName"))! as String
                let varBodMemberPic:String!=(results?.string(forColumn: "pic"))! as String
                let varBodMemberMobile:String!=(results?.string(forColumn: "membermobile"))! as String
                let varBodMemberClubName:String!=(results?.string(forColumn: "clubName"))! as String
                
                
                self.commonClassHoldDataAccessibleVariable.varBodMemberMasterUID = varBodMemberMasterUID
                self.commonClassHoldDataAccessibleVariable.varBodMemberName = varBodMemberName
                self.commonClassHoldDataAccessibleVariable.varBodMemberGroupID = varBodMemberGroupID
                self.commonClassHoldDataAccessibleVariable.varBodMemberProfileId = varBodMemberProfileId
                self.commonClassHoldDataAccessibleVariable.varBodMemberMobile = varBodMemberMobile
                self.commonClassHoldDataAccessibleVariable.varBodMemberDesignation = varBodMemberDesignation
                self.commonClassHoldDataAccessibleVariable.varBodMemberPic = varBodMemberPic
                self.commonClassHoldDataAccessibleVariable.varBodMemberClubName = varBodMemberClubName
                self.mainArray.add(self.commonClassHoldDataAccessibleVariable)
                //print(dd)
                //mainArray.addObject(dd)
            }
            self.loaderClass.window = nil
            self.tableDistrictCommiteeMemberList.reloadData()
            if mainArray.count > 0 {
                checkRow = ""
                NoRecordLabel.isHidden = true
                muarrayBodList=mainArray
                tableDistrictCommiteeMemberList.reloadData()
            }else{
                checkRow = "1"
                NoRecordLabel.isHidden = false
                mainArray = NSMutableArray()
                muarrayBodList=NSMutableArray()
                //directoryTableView.reloadData()
            }
        }
        
    }
    //DeleteData
    func DeleteDataInlocal ()
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
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            //for i in 0 ..< arrdata.count {
            // let  dict = arrdata[i] as! NSDictionary
            let insertSQL = "DELETE FROM District_Commitee_List" // WHERE profileID = '\(dict.objectForKey("serviceDirId") as! String)'
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
    
    
    //code for District committe without category member or category member
    func functionForGetDataFromServer()
    {
        
        
        let completeURL = baseUrl+touchBase_fetchDistrictCommittee
        let parameterst: [String: AnyObject] = [
        
             "groupId": grpID as AnyObject,
             "moduleId":moduleId as AnyObject
 
//            "groupId": "2765",
//            "moduleId":"15"
        ]
        
        print(completeURL)
        print(parameterst)
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
            if((response.object(forKey: "TBGetServiceCategoriesDataList")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                
                
                
                print((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "Category"))
                print((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "DirectoryData"))
                
                
                
                
                
               // print((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "Category"))
                //print((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "DirectoryData"))
                
                var muDict:NSMutableDictionary=NSMutableDictionary()
                //1111111............................
                for i in 00..<((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "DirectoryData")! as AnyObject).count
                {
                    
                    var dictTemporaryDictionary:NSDictionary=((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "DirectoryData")! as AnyObject).object(at: i)
                    
                    let address = dictTemporaryDictionary.value(forKey: "address")
                    let addressCountry = dictTemporaryDictionary.value(forKey: "addressCountry")
                    let categoryId = dictTemporaryDictionary.value(forKey: "categoryId")
                    
                    
                    
                    
                    let city = dictTemporaryDictionary.value(forKey: "city")
                    let contactNo = dictTemporaryDictionary.value(forKey: "contactNo")
                    
                    
                    let contactNo2 = dictTemporaryDictionary.value(forKey: "TotalCount")
                    let countryCode1 = dictTemporaryDictionary.value(forKey: "countryCode1")
                    let countryCode2 = dictTemporaryDictionary.value(forKey: "countryCode2")
                    let countryId1 = dictTemporaryDictionary.value(forKey: "countryId1")
                    let countryId2 = dictTemporaryDictionary.value(forKey: "countryId2")
                    let descriptn = dictTemporaryDictionary.value(forKey: "descriptn")
                    
                    
                    let email = dictTemporaryDictionary.value(forKey: "email")
                    let groupId = dictTemporaryDictionary.value(forKey: "groupId")
                    let image = dictTemporaryDictionary.value(forKey: "image")
                    let isdeleted = dictTemporaryDictionary.value(forKey: "isdeleted")
                    let keywords = dictTemporaryDictionary.value(forKey: "keywords")
                    let latitude = dictTemporaryDictionary.value(forKey: "latitude")
                    let longitude = dictTemporaryDictionary.value(forKey: "longitude")
                    let memberName = dictTemporaryDictionary.value(forKey: "memberName")
                    
                    let moduleId = dictTemporaryDictionary.value(forKey: "moduleId")
                    let pax_no = dictTemporaryDictionary.value(forKey: "pax_no")
                    let serviceDirId = dictTemporaryDictionary.value(forKey: "serviceDirId")
                    let state = dictTemporaryDictionary.value(forKey: "state")
                    let website = dictTemporaryDictionary.value(forKey: "website")
                    let zipCode = dictTemporaryDictionary.value(forKey: "zipCode")
                    
                    
                    muDict=NSMutableDictionary()
                    muDict.setValue(address, forKey: "address")
                    muDict.setValue(addressCountry, forKey: "addressCountry")
                    muDict.setValue(categoryId, forKey: "categoryId")
                    muDict.setValue(city, forKey: "city")
                    muDict.setValue(contactNo, forKey: "contactNo")
                    muDict.setValue(contactNo2, forKey: "contactNo2")
                    muDict.setValue(countryCode1, forKey: "countryCode1")
                    muDict.setValue(countryCode2, forKey: "countryCode2")
                    muDict.setValue(countryId1, forKey: "countryId1")
                    muDict.setValue(countryId2, forKey: "countryId2")
                    muDict.setValue(descriptn, forKey: "descriptn")
                    muDict.setValue(email, forKey: "email")
                    muDict.setValue(groupId, forKey: "groupId")
                    muDict.setValue(image, forKey: "image")
                    muDict.setValue(isdeleted, forKey: "isdeleted")
                    muDict.setValue(keywords, forKey: "keywords")
                    muDict.setValue(latitude, forKey: "latitude")
                    muDict.setValue(longitude, forKey: "longitude")
                    muDict.setValue(memberName, forKey: "memberName")
                    muDict.setValue(moduleId, forKey: "moduleId")
                    muDict.setValue(pax_no, forKey: "pax_no")
                    muDict.setValue(serviceDirId, forKey: "serviceDirId")
                    muDict.setValue(state, forKey: "state")
                    muDict.setValue(website, forKey: "website")
                    muDict.setValue(zipCode, forKey: "zipCode")
                    muDict.setValue("", forKey: "CategoryName")
                    muDict.setValue("", forKey: "ID")
                    muDict.setValue("", forKey: "TotalCount")
                    muDict.setValue("notcategory", forKey: "CategoryType")
                    
                    print(muDict)
                    
                    self.muarrayHold.add(muDict)
                    print(self.muarrayHold)
                    
                }
                //2222222..............
                for i in 00..<((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "Category")! as AnyObject).count
                {
                    
                    var dictTemporaryDictionary:NSDictionary=((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "Category")! as AnyObject).object(at: i)
                    let CategoryName = dictTemporaryDictionary.value(forKey: "CategoryName")
                    
                    var dictTemporaryDictionary2:NSDictionary=((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "Category")! as AnyObject).object(at: i)
                    let ID = dictTemporaryDictionary2.value(forKey: "ID")
                    
                    var dictTemporaryDictionary3:NSDictionary=((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "Category")! as AnyObject).object(at: i)
                    
                    let TotalCount = dictTemporaryDictionary3.value(forKey: "TotalCount")
                    
                    print(CategoryName)
                    print(ID)
                    print(TotalCount)
                    
                    muDict=NSMutableDictionary()
                    muDict.setValue("", forKey: "address")
                    muDict.setValue("", forKey: "addressCountry")
                    muDict.setValue("", forKey: "categoryId")
                    muDict.setValue("", forKey: "city")
                    muDict.setValue("", forKey: "contactNo")
                    muDict.setValue("", forKey: "contactNo2")
                    muDict.setValue("", forKey: "countryCode1")
                    muDict.setValue("", forKey: "countryCode2")
                    muDict.setValue("", forKey: "countryId1")
                    muDict.setValue("", forKey: "countryId2")
                    muDict.setValue("", forKey: "descriptn")
                    muDict.setValue("", forKey: "email")
                    muDict.setValue("", forKey: "groupId")
                    muDict.setValue("", forKey: "image")
                    muDict.setValue("", forKey: "isdeleted")
                    muDict.setValue("", forKey: "keywords")
                    muDict.setValue("", forKey: "latitude")
                    muDict.setValue("", forKey: "longitude")
                    muDict.setValue("", forKey: "memberName")
                    muDict.setValue("", forKey: "moduleId")
                    muDict.setValue("", forKey: "pax_no")
                    muDict.setValue("", forKey: "serviceDirId")
                    muDict.setValue("", forKey: "state")
                    muDict.setValue("", forKey: "website")
                    muDict.setValue("", forKey: "zipCode")
                    muDict.setValue(CategoryName, forKey: "CategoryName")
                    muDict.setValue(ID, forKey: "ID")
                    muDict.setValue(TotalCount, forKey: "TotalCount")
                    muDict.setValue("category", forKey: "CategoryType")
                    
                    self.muarrayHold.add(muDict)
                    print(self.muarrayHold)
                    
                }
                
                print(self.muarrayHold)
                
                print(self.arrayResponse)
                print(self.arrayResponse.count)
                
                print(self.arrayResponse2)
                print(self.arrayResponse2.count)
                self.tableDistrictCommiteeMemberList.reloadData()
            }
            SVProgressHUD.dismiss()
            }
        })
    }
    
    var arrayResponse=NSArray()
    var arrayResponse2=NSArray()
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
