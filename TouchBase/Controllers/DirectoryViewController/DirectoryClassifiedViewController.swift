
//----------------------------------------------------------------------------------------------------------------------------------
//
//  DirectoryViewController.swift
//  TouchBase
//
//  Created by Kaizan on 16/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//
/*
 loaderClass.loaderViewMethod()
 self.loaderClass.window = nil
 */
import UIKit
import Alamofire
//import WPZipArchive
import SSZipArchive
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


class DirectoryClassifiedViewController: UIViewController,UITextFieldDelegate,webServiceDelegate,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate
{
    var NormalMemberOrAdmin:String!=""
    var moduleName:String! = ""
    var masterId:String! = ""
    var profileId:String! = ""
    var grpID:String! = ""
    var varAdminProfileID:String=""
    var isCategory:String!=""
    var varValueText:String=""
    
    var classification: String?
    var groupID: NSString?
    var classiMembers: ClassificationMember?

    
    
    var varGetZipFileUrl:String!=""
    var varGetSearchTextL:String!=""
    @IBOutlet weak var buttonOpacity: UIButton!
    
    @IBAction func buttonOpacityClickEvent(_ sender: AnyObject)
    {
        buttonOpacity.isHidden=true
    }
    
    @IBOutlet weak var directoryTableView: UITableView!
    
    
    @IBOutlet weak var mainview: UIView!
    
    var mainArraySettingForPicker = NSArray()
    var varGetPickerSelectValue:String! = ""
    var varISPopVisisbleorNot:Int!=0
    var varGetCount:String!=""
    
    internal typealias ActionButtonAction = (DirectoryViewController) -> Void
    internal var action: ActionButtonAction?
    
    var actionButton: ActionButton!
    let bounds = UIScreen.main.bounds
    let searchTextField = UITextField()
    let btnsearch = UIButton()
    let screenSize: CGRect = UIScreen.main.bounds
    var appDelegate : AppDelegate = AppDelegate()
    @IBOutlet var NoRecordLabel: UILabel!
    
    var mainArray : NSMutableArray!
    var copymainArray:NSArray!
   // var grpID: NSString!
    var isAdmin:NSString!
    var moduleId:NSString!
   // var moduleName:String! = ""
    var userID:NSString!
    let loaderClass  = WebserviceClass()
    ///ganesh
    fileprivate var floatButton: UIButton!
    
    //MARK:- SearchBar
    
    var searchController: UISearchController!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
        
    {
        varGetSearchTextL = searchBar.text!
        mainArray.removeAllObjects()
        SearchFromMemberNameAndYear(varGetSearchTextL)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
        
    {
        
        searchBar.showsCancelButton=true
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        print("searchText \(searchBar.text)")
        varGetSearchTextL = searchBar.text!
        mainArray.removeAllObjects()
        SearchFromMemberNameAndYear(varGetSearchTextL)
        searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController)
        
    {
        let varGetText=searchController.searchBar.text
        if(varGetText?.characters.count<=0 && varGetText != "")
        {
            searchController.searchBar.placeholder="Enter Salon Name"
            varGetSearchTextL = ""
        }
            
        else if searchController.searchBar.text != nil  {
            searchController.searchBar.placeholder="Enter Salon Name"
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        varGetSearchTextL = ""
        searchBar.showsCancelButton = false
        mainArray = NSMutableArray()
        fetchData()
        self.directoryTableView.reloadData()
        searchBar.resignFirstResponder()
        searchBar.text=nil
    }
    
    
    func SearchFromMemberNameAndYear(_ stringSearchText:String)
    {
        
        
        var result1:String!=""
        if(grpID.hasPrefix("Optional("))
        {
            let result2 = String(grpID.dropFirst(9))    // "he"
            print(result2)
            result1 = String(result2.dropLast(1))   // "o"
            //  print("31313113133131131331313131311331133131313131",result4)
            grpID=result1
        }
        
        print(grpID)
        
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
            let querySQL = "SELECT distinct t1.memberName,t1.profilePic,t1.memberMobile,t1.masterId,t1.profileId,t1.isAdmin,t1.isPersonalDetVisible,t1.isBussinessDetVisible,t1.isFamilyDetVisible,t1.grpId,t2.uniquekey,t2.value   FROM ProfileMaster as t1 left join PersonalBusinessMemberDetails as t2 on t1.profileId=t2.profileId  where grpId ='\(GroupIdForSAearch!)'  and t2.uniquekey='designation' and t2.value ='"+varValueText+"' and memberName like '%"+stringSearchText+"%' order by t1.memberName asc"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            
            var varCounting:Int!=0
            
            while results?.next() == true {
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "memberName"))! as String, forKey:"memberName")
                dd.setValue((results?.string(forColumn: "memberMobile"))! as String, forKey:"memberMobile")
                dd.setValue((results?.string(forColumn: "masterId"))! as String, forKey:"masterId")
                dd.setValue((results?.string(forColumn: "profileId"))! as String, forKey:"profileId")
                dd.setValue((results?.string(forColumn: "isAdmin"))! as String, forKey:"isAdmin")
                dd.setValue((results?.string(forColumn: "isPersonalDetVisible"))! as String, forKey:"isPersonalDetVisible")
                dd.setValue((results?.string(forColumn: "isBussinessDetVisible"))! as String, forKey:"isBussinessDetVisible")
                dd.setValue((results?.string(forColumn: "isFamilyDetVisible"))! as String, forKey:"isFamilyDetVisible")
                dd.setValue((results?.string(forColumn: "grpId"))! as String, forKey:"grpId")
                dd.setValue((results?.string(forColumn: "profilePic"))! as String, forKey:"profilePic")
                mainArray.add(dd)
                varCounting=varCounting+1
                print(dd)
            }
            self.loaderClass.window = nil
            if mainArray.count > 0
            {
                NoRecordLabel.isHidden = true
                copymainArray=mainArray
                directoryTableView.reloadData()
            }
            else
            {
                NoRecordLabel.isHidden = false
                mainArray = NSMutableArray()
                copymainArray=NSArray()
                directoryTableView.reloadData()
            }
        }
    }

    
    /*--------------------------------------------------searchBar-----------------------------------------------*/
    
    
    
    
    
    
    
    
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "Directory"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(DirectoryViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func AddEventAction()
    {
        
        
        //       let profVC = self.storyboard!.instantiateViewControllerWithIdentifier("contact_list") as! AddContactsToGroupController
        //iphone  profVC.GroupID =  grpID as String
        //        self.navigationController?.pushViewController(profVC, animated: true)
        
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "add_member_group") as! AddMemberToGroupController
        profVC.GroupID =  grpID as String
        self.navigationController?.pushViewController(profVC, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.classiMembers?.memberListResult.result.count ?? 0
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //        let mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("masterUID")
        //        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        //        wsm.delegates=self
        //
        //        let trimmed = textField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        //        wsm.getDirectoryListGroupsOFUSer(mainMemberID!, grpID: grpID, searchText: trimmed, page: "")
        // clickSearch()
        //searchTextField.resignFirstResponder()
        return true
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if scrollView == directoryTableView
        {
            print(varGetCount)
            //self.lastKnowContentOfsset = scrollView.contentOffset.y
            print("lastKnowContentOfsset: ", scrollView.contentOffset.y)
//            self.view.makeToast("Total members "+varGetCount, duration: 2, position: CATransitionSubtype.fromBottom)
        }
        
    }
    
     func numberOfSections(in tableView: UITableView) -> Int
    {
        
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
     
            return 90
     
    }
    
    
    @objc func buttonPicBigViewClickEvent(_ sender:UIButton)
    {
        
        
      
        
        
        //
        let  directoryList = mainArray[sender.tag] as! NSDictionary
        
        
        

        let varGetImage = directoryList.object(forKey: "profilePic") as? String
        
        
     
            
            //let url = NSURL(string: varGetImage!)
            
        var  isUpperImageAvailable:String! = varGetImage!.replacingOccurrences(of: " ", with: "%20")
        
            

        ////
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
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
    
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! DirectoryClassifiedTableViewCell
//        let  directoryList = mainArray[indexPath.row] as! NSDictionary
        self.NoRecordLabel.isHidden = true
        
        
        
     
        self.loaderClass.window = nil
        
        cell.profilePic.isHidden=false
        cell.nameLabel.isHidden=false
        cell.mobileLabel.isHidden=false
        cell.buttonRotarian.isHidden=false
        
        
        
        /*
         if directoryList.objectForKey("pic") as! String == ""
         {
         cell.profilePic.image = UIImage(named: "profile_pic")
         }
         else
         {
         let varGetImageUrl:String=directoryList.objectForKey("pic") as! String
         print(varGetImageUrl)
         let url = NSURL(string: varGetImageUrl)
         KingfisherManager.sharedManager.retrieveImageWithURL(url!, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
         print(image)
         cell.profilePic.image = image
         })
         }
         */
        cell.profilePic.layer.borderColor = UIColor.lightGray.cgColor
        cell.nameLabel.text   =  self.classiMembers?.memberListResult.result[indexPath.row].memberName
        cell.mobileLabel.text =  self.classiMembers?.memberListResult.result[indexPath.row].clubName
        
        /////-----------
//        let varGetImage = directoryList.object(forKey: "profilePic") as? String
        
        
        
        if self.classiMembers?.memberListResult.result[indexPath.row].pic == ""
        {
            cell.profilePic.image = UIImage(named: "profile_pic")
        }
        else
        {
      
            //let url = NSURL(string: varGetImage!)
            
            let ImageProfilePic:String = self.classiMembers?.memberListResult.result[indexPath.row].pic.replacingOccurrences(of: " ", with: "%20") ?? ""
            let checkedUrl = URL(string: ImageProfilePic)
            cell.profilePic.sd_setImage(with: checkedUrl)
        }
        cell.buttonPicBigView.tag=indexPath.row;
        cell.buttonPicBigView.isHidden=false
        cell.buttonPicBigView.addTarget(self, action: #selector(DirectoryClassifiedViewController.buttonPicBigViewClickEvent(_:)), for: UIControl.Event.touchUpInside)
        
        
        
        cell.buttonRotarian.addTarget(self, action: #selector(DirectoryClassifiedViewController.buttonRotarianClicked(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonRotarian.tag=indexPath.row;
       cell.groupsLabel.text =  ""
        

        return cell
    }
    
    var groupUniqueName:String!=""
    @objc func buttonRotarianClicked(_ sender:UIButton)
    {
       let objProfileDynamicNewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
        objProfileDynamicNewViewController.profileId=self.classiMembers?.memberListResult.result[sender.tag].profileID
        objProfileDynamicNewViewController.grpID=self.classiMembers?.memberListResult.result[sender.tag].grpID
        objProfileDynamicNewViewController.varAdminProfileID="\(userID)"
        objProfileDynamicNewViewController.NormalMemberOrAdmin=NormalMemberOrAdmin
        objProfileDynamicNewViewController.varGetPickerSelectValue = "Classification"
        objProfileDynamicNewViewController.isCategory=self.isCategory
        objProfileDynamicNewViewController.groupUniqueName=groupUniqueName
        self.navigationController?.pushViewController(objProfileDynamicNewViewController, animated: true)
 
    }
    

    
  
    
   
    
    
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
//    {
//        let  directoryList = mainArray[indexPath.row] as! NSDictionary
//        
//        
//        let objProfileDynamicNewViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
//        
//        let masterId =  directoryList.objectForKey("masterId") as? String
//        let profileId = directoryList.objectForKey("profileId") as? String
//        objProfileDynamicNewViewController.masterId=masterId
//        objProfileDynamicNewViewController.profileId=profileId
//        objProfileDynamicNewViewController.grpID="\(grpID)"
//        objProfileDynamicNewViewController.varAdminProfileID="\(userID)"
//        
//        
//        
//        print(directoryList)
//        
//        self.navigationController?.pushViewController(objProfileDynamicNewViewController, animated: true)
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // if(appDelegate.isReachable == true)
        //{
        let  strValue = (self.searchTextField.text! as NSString).replacingCharacters(in: range, with: string) as NSString as String
        let strValues = strValue.trimmingCharacters(in: CharacterSet.whitespaces)as NSString
        
        print(strValue)
        print(strValues)
        print(searchTextField.text)
        
        return true
    }
    
    
    
    
    
    
    func textFieldDidChange(_ textField: UITextField) {
        //your code
        if(textField.text!==""){
            mainArray = copymainArray .mutableCopy() as! NSMutableArray
            if(mainArray.count == 0) {
                //directoryTableView.hidden = true;
            }
            else {
                
                // memberTableView.hidden = false;
                
            }
            searchTextField.text="";
            searchTextField.resignFirstResponder()
            directoryTableView.reloadData()
        }
        else
        {
            mainArray=[]
            
            let predicate = NSPredicate(format: "memberName contains[c] %@", searchTextField.text!)
            mainArray =  copymainArray.filtered(using: predicate) as! NSMutableArray
            print(mainArray)
            if (mainArray.count==0) {
                
                NoRecordLabel.isHidden = false
                directoryTableView.reloadData()
                searchTextField.resignFirstResponder()
                searchTextField.delegate = self
            }
            else{
                
                NoRecordLabel.isHidden = true
                directoryTableView.reloadData()
            }
        }
    }
    
    
    /*
    func loaderViewMethod()
    {
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        if let window = appDelegate.window {
            window.backgroundColor = UIColor.clear
            window.rootViewController = UIViewController()
            window.makeKeyAndVisible()
        }
        let Loadingview = UIView()
        
        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
        appDelegate.window?.addSubview(Loadingview)
        
        let url = Bundle.main.url(forResource: "tb_preloader8", withExtension: "gif")
        
        let gifView = UIImageView()
        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
        gifView.backgroundColor = UIColor.clear
        Loadingview.addSubview(gifView)
        
        
    }
    */
    
    var GroupIdForSAearch:String!=""
    func fetchData()
    {
        mainArray=NSMutableArray()
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
            var result1:String!=""
            if(grpID.hasPrefix("Optional("))
            {
                let result2 = String(grpID.dropFirst(9))    // "he"
                print(result2)
                result1 = String(result2.dropLast(1))   // "o"
                grpID=result1
            }
            
            let querySQL = "SELECT distinct t1.memberName,t1.profilePic,t1.memberMobile,t1.masterId,t1.profileId,t1.isAdmin,t1.isPersonalDetVisible,t1.isBussinessDetVisible,t1.isFamilyDetVisible,t1.grpId,t2.uniquekey,t2.value   FROM ProfileMaster as t1 left join PersonalBusinessMemberDetails as t2 on t1.profileId=t2.profileId  where grpId ='\(grpID!)'  and t2.uniquekey='designation' and t2.value ='"+varValueText+"' order by t1.memberName asc"
            GroupIdForSAearch=grpID!
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            var varCounting:Int!=0
            while results?.next() == true {
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "memberName"))! as String, forKey:"memberName")
                dd.setValue((results?.string(forColumn: "memberMobile"))! as String, forKey:"memberMobile")
                dd.setValue((results?.string(forColumn: "masterId"))! as String, forKey:"masterId")
                dd.setValue((results?.string(forColumn: "profileId"))! as String, forKey:"profileId")
                dd.setValue((results?.string(forColumn: "isAdmin"))! as String, forKey:"isAdmin")
                dd.setValue((results?.string(forColumn: "isPersonalDetVisible"))! as String, forKey:"isPersonalDetVisible")
                dd.setValue((results?.string(forColumn: "isBussinessDetVisible"))! as String, forKey:"isBussinessDetVisible")
                dd.setValue((results?.string(forColumn: "isFamilyDetVisible"))! as String, forKey:"isFamilyDetVisible")
                dd.setValue((results?.string(forColumn: "grpId"))! as String, forKey:"grpId")
                dd.setValue((results?.string(forColumn: "profilePic"))! as String, forKey:"profilePic")
                mainArray.add(dd)
                varCounting=varCounting+1
                print(dd)
            }
            self.loaderClass.window = nil
            if mainArray.count > 0
            {
                NoRecordLabel.isHidden = true
                copymainArray=mainArray
                directoryTableView.reloadData()
                directoryTableView.isHidden=false
            }
            else
            {
                NoRecordLabel.isHidden = false
                mainArray = NSMutableArray()
                copymainArray=NSArray()
                directoryTableView.reloadData()
            }

            var result4:String!=""

            if(grpID.hasPrefix("Optional("))
            {
                let result3 = String(grpID.dropFirst(9))    // "he"
                print(result3)
                result4 = String(result3.dropLast(1))   // "o"
                print("31313113133131131331313131311331133131313131",result4)
                
                grpID=result4
            }

            
            let Count = "SELECT count(*) as Count from ProfileMaster where grpId = '\(grpID!)'"
            print(Count)
            let resultss:FMResultSet? = contactDB?.executeQuery(Count,withArgumentsIn: nil)
            
            while resultss?.next() == true
            {
                varGetCount=resultss?.string(forColumn: "Count")
            }
            varGetCount=String(varCounting)
            print(varGetCount)
            directoryTableView.reloadData()
        }
    }
    override func viewDidLoad()
    {
        // funcForRemoveZipFileFromDocumentDirectory()
        super.viewDidLoad()
        
        self.loadClassiMemberList(id: self.groupID as String?, classi: self.classification)
        self.NoRecordLabel.isHidden = true
        
//        let screenSize: CGRect = UIScreen.mainScreen().bounds
//        let screenWidth = (screenSize.width)
//        let screenHeight = (screenSize.height)
//        
//        
//        
//        print(screenWidth)
//        self.mainview.frame = CGRectMake(0, 0, self.view.frame.size.width, screenHeight)
        varGetPickerSelectValue = "Rotarian"
        //Navigation more functionality ------DPK
        buttonOpacity.isHidden = true
        mainArraySettingForPicker = ["Rotarian" , "Classification" , "Family"]
        
       
        
        searchTextField.delegate = self
        NoRecordLabel.isHidden = true
//        self.edgesForExtendedLayout = []
        self.createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        buttonOpacity.isHidden=true
        directoryTableView.isHidden=false
        
        
        
        /////later by rajendra
        mainArray = NSMutableArray()
        copymainArray = NSArray()
        let tblView =  UIView(frame: CGRect.zero)
        directoryTableView.tableFooterView = tblView
        directoryTableView.tableFooterView!.isHidden = true
        fetchData()
    }
    
    func loadClassiMemberList(id: String?, classi: String?) {
            
            if let grpIdd = id, let classifi = classi {
                
                let completeURL = baseUrl + dirClassificationMemberList
                
                let parameterst = ["grpID":grpIdd,"classification":classifi]
                
                print("Club Online Directory parameterst:: \(parameterst)")
                print("Club Online Directory completeURL:: \(completeURL)")
                
                //------------------------------------------------------
                Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                    switch response.result {
                    case .success:
                        
                        
                             if let value = response.result.value {
                                 do {
                                     // Attempt to decode the JSON data
                                     let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                                     let decoder = JSONDecoder()
                                     let decodedData = try decoder.decode(ClassificationMember.self, from: jsonData)
                                     
                                     // Access the properties of the decoded data
                                     print("Decoded Data:--- \(decodedData)")
                                     self.classiMembers = decodedData
                                     SVProgressHUD.dismiss()
                                     self.directoryTableView.reloadData()
                                     // Access individual properties like decodedData.propertyName
                                 } catch {
                                     print("Error decoding JSON: \(error)")
                                 }
                             }
                    case .failure(_): break
                    }
                }
            }
        }

    
    
    override func viewWillAppear(_ animated: Bool)
    {
      
    
        
    }
    
    
}

// MARK: - ClassificationMember
struct ClassificationMember: Codable {
    let memberListResult: MemberListResultss

    enum CodingKeys: String, CodingKey {
        case memberListResult = "MemberListResult"
    }
}

// MARK: - MemberListResult
struct MemberListResultss: Codable {
    let status, message: String
    let result: [ClassiResult]

    enum CodingKeys: String, CodingKey {
        case status, message
        case result = "Result"
    }
}

// MARK: - Result
struct ClassiResult: Codable {
    let masterUID, grpID, profileID, memberName: String
    let pic: String
    let membermobile, clubName: String

    enum CodingKeys: String, CodingKey {
        case masterUID, grpID, profileID, memberName, pic, membermobile
        case clubName = "club_name"
    }
}


