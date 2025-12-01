//
//  ServiceDirectoryListViewController.swift
//  TouchBase
//
//  Created by Umesh on 18/07/16.
//  Copyright © 2016 Parag. All rights reserved.
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
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ServiceDirectoryListViewController: UIViewController , webServiceDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet var NoRecordLabel: UILabel!
    @IBOutlet var directoryTableView: UITableView!
     let loaderClass  = WebserviceClass()
    var appDelegate : AppDelegate = AppDelegate()
    var mainArray : NSMutableArray!
    var copymainArray:NSArray!
    let bounds = UIScreen.main.bounds
    let searchTextField = UITextField()
    var grpID: NSString!
    var isAdmin:NSString!
    var checkRow: NSString!
    var varGetCellDateSelected:String! = ""
    var searchingNameArray : NSMutableArray!
    var searchingkeywordArray :NSMutableArray!
    var searchingMobileNoArray : NSMutableArray!
    var str = String()
    var isCategory:String!=""
    
    var updatedOn =  String ()

    // var moduleId = NSString!
    var userID:NSString!
    var moduleIdStr:NSString!
    var letGetCategoryId:String!=""
   var moduleName:String! = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        functionForCurrentDate()
       //  loaderClass.loaderViewMethod()
        searchTextField.autocorrectionType = .no
        searchingNameArray = []
        searchingkeywordArray = []
        searchingMobileNoArray = []
        mainArray = NSMutableArray()
        NoRecordLabel.isHidden=true
          createNavigationBar()

        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
      
        self.createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
       
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            print(moduleIdStr)
            getServiceDirList(grpID, searchText: "",moduleId:moduleIdStr);
            self.directoryTableView.reloadData()
    
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            mainArray = NSMutableArray()
            fetchData()
            self.directoryTableView.reloadData()
             SVProgressHUD.dismiss()
        }
    }
    
      override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(DirectoryViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DirectoryViewController.AddEventAction))
        add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        //let mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("isAdmin")//isAdmin
        if isAdmin == "Yes" || isAdmin == "yes"
        {
//            if(isCategory=="2")
//            {
//            print("IsAdmin But Come From District.............")
//            }
//            else
//            {
             self.navigationItem.rightBarButtonItem = add
           // }
            
        }
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func AddEventAction()
    {
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        
        print("..width..\(width)")
        print("..height..\(height)")
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "addservice") as! ServiceAddEditViewController
        profVC.grpId =  grpID as String as String as NSString
        profVC.moduleIdPassString = moduleIdStr
        profVC.userId = userID as String as String as NSString
        profVC.isCalledFRom = "list"
        profVC.serviceId = "0"
        
        UserDefaults.standard.setValue("", forKey: "session_City")
        UserDefaults.standard.setValue("", forKey: "session_State")
        UserDefaults.standard.setValue("", forKey: "session_Country")
        UserDefaults.standard.setValue("", forKey: "session_Zip")
        

        self.navigationController?.pushViewController(profVC, animated: true)
        
    }

    
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return mainArray.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width+5, height: 60)
        headerView.backgroundColor = UIColor.white
        
        
        let headerImageView = UIImageView()
        headerImageView.frame = CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: 60)
        headerImageView.image = UIImage(named: "heder2")
        headerView.addSubview(headerImageView)
        
        let textImageView = UIImageView()
        textImageView.frame = CGRect(x: 30, y: 10, width: self.view.frame.size.width-60, height: 35)
        textImageView.image = UIImage(named: "textfield")
        textImageView.isUserInteractionEnabled = true
        headerImageView.addSubview(textImageView)
        
        
        searchTextField.frame = CGRect(x: 35, y: 12, width: self.view.frame.size.width-60, height: 35)
        searchTextField.placeholder = "Search"
        searchTextField.textColor = UIColor.black
        searchTextField.font = UIFont(name: "Roboto-Regular", size: 18)
        searchTextField.backgroundColor = UIColor.clear
        searchTextField.isUserInteractionEnabled = true
        searchTextField.borderStyle = UITextField.BorderStyle.none
        searchTextField.delegate=self
        searchTextField.addTarget(self, action: #selector(DirectoryViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
        
        
        searchTextField.autocorrectionType = .no
        
        searchTextField.autocorrectionType = .no
        searchTextField.autocapitalizationType = .none
        searchTextField.spellCheckingType = .no
        searchTextField.returnKeyType = .search
        
        
        headerView.addSubview(searchTextField)
        
        headerView.bringSubviewToFront(searchTextField)
        
        
        return headerView
    }
    
    
    func clickSearch() {
        print("button click")
        
        //your code
        if(searchTextField.text!==""){
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
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            appDelegate = UIApplication.shared.delegate as! AppDelegate
             if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                self.getServiceDirList(grpID, searchText: "",moduleId:moduleIdStr);
                //self.getListOfSerach(mainMemberID!, grpID: grpID, searchText: searchTextField.text!, page: "")
            }else{
                mainArray=[]
                let predicate = NSPredicate(format: "memberName contains[c] %@", searchTextField.text!)
                mainArray =  copymainArray.filtered(using: predicate) as! NSMutableArray
                print(mainArray)
                if (mainArray.count==0) {
                    
                    
                    
                    
                    NoRecordLabel.isHidden = false
                    directoryTableView.reloadData()
                    searchTextField.resignFirstResponder()
                }
                else{
                    
                    NoRecordLabel.isHidden = true
                    directoryTableView.reloadData()
                    searchTextField.resignFirstResponder()
                }
            }
            
        }
        
        
        
        if(searchTextField.text! == "")
        {
          NoRecordLabel.isHidden = true
        }
        else
        {
            
        }
        searchTextField.resignFirstResponder()
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if(searchTextField.text?.characters.count > 0 || searchTextField.text! == ""){
            
            clickSearch()
//        let mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("masterUID")
//        
//            
//        
//        let wsm : WebserviceClass = WebserviceClass.sharedInstance
//        wsm.delegates=self
//        
//        let trimmed = textField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
//        wsm.getDirectoryListGroupsOFUSer(mainMemberID!, grpID: grpID, searchText: trimmed, page: "")
        }
        searchTextField.resignFirstResponder()
        return true
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = directoryTableView.dequeueReusableCell(withIdentifier: "dirCell", for: indexPath) as! DirectoryCell
        let directoryList = mainArray.object(at: indexPath.row) as! NSDictionary
        if directoryList.object(forKey: "image") as! String == ""
        {
            cell.profilePic.image = UIImage(named: "profile_pic")
            cell.profilePic.layer.cornerRadius = 35
            cell.profilePic.clipsToBounds = true
        }
        else
        {
            /*------------------------------Code by --------------------DPK--------------------------- */
            if let checkedUrl = URL(string: directoryList.object(forKey: "image") as! String) {
                /*
                KingfisherManager.sharedManager.retrieveImageWithURL(checkedUrl, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                    print(image)
                    
                    cell.profilePic.layer.cornerRadius = 35
                    cell.profilePic.clipsToBounds = true
                    cell.profilePic.image = image
                })
                */
                
                var varGetImage:String!=directoryList.object(forKey: "image") as! String
                let ImageProfilePic:String = varGetImage.replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                cell.profilePic.sd_setImage(with: checkedUrl)
                
                

                
               /*------------------------------Code by --------------------DPK--------------------------- */

            }
        }
        cell.profilePic.layer.borderColor = UIColor.lightGray.cgColor
        cell.nameLabel.text   =  directoryList.object(forKey: "memberName") as? String  //nameTitles[indexPath.row]
        cell.mobileLabel.text =  directoryList.object(forKey: "csvKeywords") as? String
        
       // csvKeywords = Mobile;
        
        
        cell.groupsLabel.text =  ""
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        tableView.deselectRow(at: indexPath, animated: true)
//        NSUserDefaults.standardUserDefaults().setObject("no", forKey: "picadded")
        let directoryList = mainArray.object(at: indexPath.row) as! NSDictionary
        print(directoryList)
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "servicedet") as! ServiceDetailViewController
        profVC.grpID =  directoryList.object(forKey: "groupId") as! String as NSString  //nameTitles[indexPath.row]
        profVC.serviceId =  directoryList.object(forKey: "serviceDirId") as! String as NSString   //mobileTitles[indexPath.row]
        profVC.userID = userID
        profVC.moduleId = moduleIdStr
        
       
        profVC.varCity=directoryList.object(forKey: "city") as? String
        profVC.varState=directoryList.object(forKey: "state") as? String
        profVC.varCountry=directoryList.object(forKey: "country") as? String
        profVC.varZip=directoryList.object(forKey: "zip") as? String
        print(directoryList.object(forKey: "website") as? String)
        
        profVC.varWebSite=directoryList.object(forKey: "website") as? String

    profVC.directoryList = directoryList
        
        /*---code by rajenda jat hold value for service directory edit mode city state country zip----------*/
        UserDefaults.standard.setValue(directoryList.object(forKey: "city") as? String, forKey: "session_City")
        UserDefaults.standard.setValue(directoryList.object(forKey: "state") as? String, forKey: "session_State")
        UserDefaults.standard.setValue(directoryList.object(forKey: "country") as? String, forKey: "session_Country")
        UserDefaults.standard.setValue(directoryList.object(forKey: "zip") as? String, forKey: "session_Zip")
        
        
        
//        profVC.isAdmin = isAdmin
//        profVC.mainUSerPRofileID = userID
//        profVC.isCalled = "list"
        self.navigationController?.pushViewController(profVC, animated: true)
        
    }
    func textFieldDidChange(_ textField: UITextField) {
        //your code
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
        
        
        if(textField.text!==""){
            mainArray=copymainArray .mutableCopy() as! NSMutableArray
            if(mainArray.count == 0) {
                //directoryTableView.hidden = true;
            }
            else {
                               // memberTableView.hidden = false;
                
            }
            searchTextField.text=""
            
           // searchTextField.resignFirstResponder()
            directoryTableView.reloadData()
        }
        else
        {
            mainArray=NSMutableArray()
            
            /*----------------------*/
            //1
            let commentAttribute = "comment"
            //2
            let searchString = "comment: 55"
            //3
            let commentPredicate = NSPredicate(format: "%K CONTAINS[cd] %@", commentAttribute, searchString)
            /*-----------------------*/
            
           let  predicate = NSPredicate(format: "memberName contains[c] %@ ",searchTextField.text!)
          mainArray =  copymainArray.filtered(using: predicate) as! NSMutableArray
    
          
            print(copymainArray)
            print(mainArray)
            //
            
            var muArrayTemp:NSMutableArray=NSMutableArray()
            let  predicatecsvKeywords = NSPredicate(format: "csvKeywords contains[c] %@ ",searchTextField.text!)
            muArrayTemp =  copymainArray.filtered(using: predicatecsvKeywords) as! NSMutableArray
            print(muArrayTemp)
            if(mainArray.count>0)
            {
                if(muArrayTemp.count>0)
                {
                    /*
                print(mainArray)
                mainArray=copymainArray.filteredArrayUsingPredicate(predicatecsvKeywords) as! NSMutableArray
                print(mainArray=mainArray+copymainArray.filteredArrayUsingPredicate(predicatecsvKeywords) as! NSMutableArray)
                    mainArray=mainArray+copymainArray.filteredArrayUsingPredicate(predicatecsvKeywords) as! NSMutableArray
                    
                    
                    let array = mainArray
                    let unique = Array(Set(arrayLiteral: array))
                    print(unique)
                    
                    */
                }
            }
            else
            {
                mainArray=muArrayTemp
            }
            
            
            if (mainArray.count==0) {
                
                NoRecordLabel.isHidden = false
                directoryTableView.reloadData()
                //searchTextField.resignFirstResponder()
            }
            else{
                
                NoRecordLabel.isHidden = true
                directoryTableView.reloadData()
            }
        }
        }
        else
        {
            //self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            self.loaderClass.window = nil
            //buttonTitle.hidden=true
             SVProgressHUD.dismiss()
        }
    }
    
func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
//        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
//        UIView.animateWithDuration(0.25, animations: {
//            cell.layer.transform = CATransform3DMakeScale(1,1,1)
//        })
    }
  
    func functionForCurrentDate()
    {
        let date = Foundation.Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-dd"
        let currentdate = formatter.string(from: date)
        varGetCellDateSelected = currentdate+" 0:0:0"
        print(varGetCellDateSelected)
    }

    
    
    func functionForGetLastUpdateDate()->String
    {
        var varGetLastUpdateDate:String!=""
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
            let querySQL = "SELECT IsLastUpdateDate FROM SERVICE_DIRECTORY_DATA_MASTER where groupId = '\(grpID)' and moduleId=\(moduleIdStr)"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,
                                                               withArgumentsIn: nil)
            
            while results?.next() == true
            {
               
               varGetLastUpdateDate = results?.string(forColumn: "IsLastUpdateDate")
             
                
            }
            
            
        }
  return varGetLastUpdateDate

    }
    
    func getServiceDirList(_ groupId:NSString,searchText:NSString,moduleId:NSString)
    {
        
        
     //categoryId
        /*------------------------------------------------------code by Rajendra Jat for testing purpose------------------------------*/
       // print(stringModuleId)
        //moduleId
        
        var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        var updatedOn =  String ()
        let defaults = UserDefaults.standard
        let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
        //updatedOn = "1970-01-01 00:00:00"
          str = (defaults.value(forKey: Updatedefault) as! String?)!
     
        
        
        
//        let defaults = NSUserDefaults.standardUserDefaults()
//        let Updatedefault = String(format: "updatedOnServiceDirectory%@",grpID)
//        print(Updatedefault)
//        
//         //str = (defaults.valueForKey(Updatedefault) as! String?)!
//       
//        if let str = defaults.valueForKey(Updatedefault) as! String?
//        {
//            print(str)
//            updatedOn = str
//        } /*else
//        {
//            updatedOn = "1970-1-1 0:0:0"
//        }
//        */
        var varGetLastUpdateDate = functionForGetLastUpdateDate()
        if(varGetLastUpdateDate.characters.count>0 && varGetLastUpdateDate != "")
        {
           updatedOn = varGetLastUpdateDate
        }
        else
        {
           updatedOn = "1970-1-1 0:0:0"
        }
        
        
        
            print(updatedOn)
        
        let completeURL:String! = baseUrl+touchBase_GetServiceDirectoryListSync
        let parameterst = [
            "groupId" : groupId,
            "searchText" : searchText,
            "updatedOn" : updatedOn,
           // "updatedOn" : "1970-1-1 0:0:0",
            "moduleId":moduleId
        ] as [String : Any]
        
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            
            
            print(response)
            print(response)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            let dd = response as! NSDictionary
            print("dd \(dd)")
            
            if((dd.object(forKey: "TBServiceDirectoryResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                if (((dd.object(forKey: "TBServiceDirectoryResult")! as AnyObject).object(forKey: "updatedOn")) != nil)
                {
                    UserDefaults.standard.set((dd.object(forKey: "TBServiceDirectoryResult")! as AnyObject).object(forKey: "updatedOn"), forKey: Updatedefault)
                }
                
                let arrarrNewGroupList = (((dd.object(forKey: "TBServiceDirectoryResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "newMembers")) as! NSArray
                
                let arrDeleteGroupList = (((dd.object(forKey: "TBServiceDirectoryResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "deletedMembers")) as! NSArray
                
                
                let arrUpdateGroupList = (((dd.object(forKey: "TBServiceDirectoryResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "updatedMembers")) as! NSArray
                
                  //self.DeleteDataInlocal(arrDeleteGroupList)
                //delete group data from local database
                if(arrDeleteGroupList.count > 0){
                    print("arrDeleteGroupList \(arrDeleteGroupList)")
                    self.DeleteDataInlocal(arrDeleteGroupList)
                    
                }
                if(arrUpdateGroupList.count > 0){
                    //self.fetchData()
                    print("arrDeleteGroupList \(arrUpdateGroupList)")
                    self.UpdateDataInlocal(arrUpdateGroupList)
                    
                }
                if(arrarrNewGroupList.count > 0){
                    print("arrNewGroupList \(arrarrNewGroupList)")
                    //save group data from local database
                    self.SaveDataInlocal(arrarrNewGroupList)
                    print(arrarrNewGroupList)
                    self.mainArray = NSMutableArray()
                    self.fetchData()
                }
                else
                {
                    let defaults = UserDefaults.standard
                    if let str = defaults.value(forKey: Updatedefault) as! String?
                    {
                        
                        print(str)
                        self.mainArray = NSMutableArray()
                        self.fetchData()
                    }else
                    {
                        
                    }
                }
                
                
            }else if((dd.object(forKey: "TBServiceDirectoryResult")! as AnyObject).object(forKey: "status") as! String == "2"){
                let alert=UIAlertController(title: "Rotary India", message:dd.object(forKey: "message") as! String, preferredStyle: UIAlertController.Style.alert);
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
                    self.appDelegate = UIApplication.shared.delegate as! AppDelegate
                    self.appDelegate.setMobileViewAsRoot()
                }));
                self.present(alert, animated: true, completion: nil);
            }
        }
            //=> Handle server response
          //  self.muarrayListData=CreateAlbumModel().saveServiceProviderListInfo(((response.valueForKey("TBAlbumsListResult")!.valueForKey("Result")!.valueForKey("newAlbums")! as! NSArray)))
     
            //add data in local if first time coming on this screen after install app
            // self.varGalleryOffline.functionForSaveDataInlocalGalleryAlbum(self.muarrayListData)
            SVProgressHUD.dismiss()
        })
        /*----------------------------------------------------------------------------------------------------------------------------*/
        
        
        
        
     
    }
    
    
    //Save Data
    func SaveDataInlocal (_ arrdata:NSArray){
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
                let  dict = arrdata[i] as! NSDictionary
                
                let varGetValue = (dict.object(forKey: "descriptn") as! String)
                let replacedDescription  = (varGetValue as NSString).replacingOccurrences(of: "'", with: "`")
                print("------------->Description ",replacedDescription)
               // var varGetAddress = (dict.objectForKey("address") as! String)
               // let replacedAddress  = (varGetAddress as NSString).stringByReplacingOccurrencesOfString("'", withString: "`")
                
                
                //   @"INSERT INTO EMPLOYEES (name, department, age) VALUES (\"%@\", \"%@\", \"%@\")",
                //\(dict.objectForKey("description") as! String)
                //\(dict.objectForKey("address") as! String)
                let insertSQL = "INSERT INTO SERVICE_DIRECTORY_DATA_MASTER (masterUID , groupId, memberName, image , contactNo,isdeleted,description,contactNo2,pax,email ,address ,long ,lat ,countryId1 ,countryId2 ,csvKeywords ,city ,state ,country ,zip ,moduleId,serviceDirId,categoryId,website,IsLastUpdateDate) VALUES ('\(mainMemberID!)', '\(grpID!)', '\(dict.object(forKey: "memberName") as! String)', '\(dict.object(forKey: "image") as! String )', '\(dict.object(forKey: "contactNo") as! String)', '\(dict.object(forKey: "isdeleted") as! String)', '"+replacedDescription+"', '\(dict.object(forKey: "contactNo2") as! String)', '\(dict.object(forKey: "pax_no") as! String)', '\(dict.object(forKey: "email") as! String)','\(dict.object(forKey: "address") as! String)','\(dict.object(forKey: "longitude") as! String)','\(dict.object(forKey: "latitude") as! String)','\(dict.object(forKey: "countryId1") as! String)','\(dict.object(forKey: "countryId2") as! String)','\(dict.object(forKey: "keywords") as! String)','\(dict.object(forKey: "city") as! String)','\(dict.object(forKey: "state") as! String)','\(dict.object(forKey: "addressCountry") as! String)','\(dict.object(forKey: "zipCode") as! String)','\(moduleIdStr!)','\(dict.object(forKey: "serviceDirId") as! String)','\(dict.object(forKey: "categoryId") as! String)','\(dict.object(forKey: "website") as! String)','"+str+"')"
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
    
    
    //Update Data
    func UpdateDataInlocal (_ arrdata:NSArray){
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
                let  dict = arrdata[i] as! NSDictionary
                
                
                
                let varGetValue = (dict.object(forKey: "descriptn") as! String)
                let replacedDescription  = (varGetValue as NSString).replacingOccurrences(of: "'", with: "`")
                
                print("------------->Description ",replacedDescription)
                
                var insertSQL = ""

                     insertSQL = "UPDATE SERVICE_DIRECTORY_DATA_MASTER SET  masterUID ='\(mainMemberID!)',groupId ='\(grpID!)' , memberName ='\(dict.object(forKey: "memberName") as! String)', image ='\(dict.object(forKey: "image") as! String )' , contactNo = '\(dict.object(forKey: "contactNo") as! String)',isdeleted ='\(dict.object(forKey: "isdeleted") as! String)', description = '"+replacedDescription+"' ,contactNo2 ='\(dict.object(forKey: "contactNo2") as! String)',pax ='\(dict.object(forKey: "pax_no") as! String)',email ='\(dict.object(forKey: "email") as! String)' ,address ='\(dict.object(forKey: "address") as! String)' ,long ='\(dict.object(forKey: "longitude") as! String)' ,lat ='\(dict.object(forKey: "latitude") as! String)',countryId1 ='\(dict.object(forKey: "countryId1") as! String)' ,countryId2 ='\(dict.object(forKey: "countryId2") as! String)' ,csvKeywords ='\(dict.object(forKey: "keywords") as! String)' ,city ='\(dict.object(forKey: "city") as! String)' ,state ='\(dict.object(forKey: "state") as! String)' ,country ='\(dict.object(forKey: "addressCountry") as! String)' ,zip ='\(dict.object(forKey: "zipCode") as! String)' ,moduleId ='\(moduleIdStr!)',serviceDirId = '\(dict.object(forKey: "serviceDirId") as! String)'  WHERE serviceDirId = '\(dict.object(forKey: "serviceDirId") as! String)' "
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
    
    func DeleteDataInlocal (_ arrdata:NSArray){
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
                let  dict = arrdata[i] as! NSDictionary
                let insertSQL = "DELETE FROM SERVICE_DIRECTORY_DATA_MASTER WHERE serviceDirId = '\(dict.object(forKey: "serviceDirId") as! String)'"
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
    

    /*
    func DeleteDataInlocal (arrdata:NSArray){
        var databasePath : String
        print(arrdata);
        
        let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        let fileURL = documents.URLByAppendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL!.path!
        var db: COpaquePointer = nil
        if sqlite3_open(fileURL!.path!, &db) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
        let mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("masterUID")
        if (contactDB?.open())! {
            //for i in 0 ..< arrdata.count {
               // let  dict = arrdata[i] as! NSDictionary
                let insertSQL = "DELETE FROM SERVICE_DIRECTORY_DATA_MASTER"
                print(insertSQL)
                
                let result = contactDB?.executeStatements(insertSQL)
                
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("success saved")
                    print(databasePath);
                }
            //}
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
    }
    */
    func fetchData ()
    {
        // loaderClass.loaderViewMethod()
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
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            let querySQL = "SELECT * FROM SERVICE_DIRECTORY_DATA_MASTER where groupId = '\(grpID)' and moduleId='\(moduleIdStr)' and categoryId='\(letGetCategoryId)'"
            
            
//             if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//            {
//                let querySQL = "SELECT * FROM SERVICE_DIRECTORY_DATA_MASTER where groupId = '\(grpID)' and moduleId='\(grpID)' and categoryId='\(letGetCategoryId)'"
//            }
//            else
//            {
//               let querySQL = "SELECT * FROM SERVICE_DIRECTORY_DATA_MASTER where groupId = '\(grpID)' and moduleId='\(grpID)' and categoryId='\(letGetCategoryId)'"
//            }
            
            
            
            
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,
                                                               withArgumentsIn: nil)
            
            while results?.next() == true
            {
                print((results?.string(forColumn: "serviceDirId"))! as String)
                let dd = NSMutableDictionary ()
                
                dd.setValue((results?.string(forColumn: "groupId"))! as String, forKey:"groupId")
                dd.setValue((results?.string(forColumn: "memberName"))! as String, forKey:"memberName")
                dd.setValue((results?.string(forColumn: "image"))! as String, forKey:"image")
                dd.setValue((results?.string(forColumn: "contactNo"))! as String, forKey:"contactNo")
                dd.setValue((results?.string(forColumn: "isdeleted"))! as String, forKey:"isdeleted")
                dd.setValue((results?.string(forColumn: "description"))! as String, forKey:"description")
                dd.setValue((results?.string(forColumn: "contactNo2"))! as String, forKey:"contactNo2")
                dd.setValue((results?.string(forColumn: "pax"))! as String, forKey:"pax")
                dd.setValue((results?.string(forColumn: "email"))! as String, forKey:"email")
                dd.setValue((results?.string(forColumn: "address"))! as String, forKey:"address")
                dd.setValue((results?.string(forColumn: "long"))! as String, forKey:"long")
                dd.setValue((results?.string(forColumn: "lat"))! as String, forKey:"lat")
                dd.setValue((results?.string(forColumn: "countryId1"))! as String, forKey:"countryId1")
                dd.setValue((results?.string(forColumn: "countryId2"))! as String, forKey:"countryId2")
                dd.setValue((results?.string(forColumn: "csvKeywords"))! as String, forKey:"csvKeywords")
                dd.setValue((results?.string(forColumn: "city"))! as String, forKey:"city")
                dd.setValue((results?.string(forColumn: "state"))! as String, forKey:"state")
                dd.setValue((results?.string(forColumn: "country"))! as String, forKey:"country")
                dd.setValue((results?.string(forColumn: "zip"))! as String, forKey:"zip")
                dd.setValue((results?.string(forColumn: "moduleId"))! as String, forKey:"moduleId")
                dd.setValue((results?.string(forColumn: "serviceDirId"))! as String, forKey:"serviceDirId")
                dd.setValue((results?.string(forColumn: "categoryId"))! as String, forKey:"categoryId")

                dd.setValue((results?.string(forColumn: "website"))! as String, forKey:"website")
                
                
                //let varCheckUrl =  ((results?.stringForColumn("image"))! as String)
               // verifyUrl(varCheckUrl)
                

                //website
                NoRecordLabel.isHidden=true
                
                print(dd)
                mainArray.add(dd)
                
            }
            
            
            self.loaderClass.window = nil
            self.directoryTableView.reloadData()
            
            
            
            
            
            if mainArray.count > 0 {
                checkRow = ""
                NoRecordLabel.isHidden = true
                copymainArray=mainArray
                directoryTableView.reloadData()
            }else{
                 checkRow = "1"
                NoRecordLabel.isHidden = false
                mainArray = NSMutableArray()
                copymainArray=NSArray()
                //directoryTableView.reloadData()
            }
        }
//        else
//        {
//            NoRecordLabel.hidden=false
//        }
    }
    

    func verifyUrl (_ urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = URL(string: urlString)
            {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url)
            }
           
        }
        return false
    }
    
    
}
 
