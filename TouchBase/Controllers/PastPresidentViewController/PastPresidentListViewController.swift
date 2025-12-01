//
//  PastPresidentListViewController.swift
//  TouchBase
//
//  Created by rajendra on 20/05/17.
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



class PastPresidentListViewController: UIViewController , UITextFieldDelegate, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var tablePastPresidentListShow: UITableView!
    @IBOutlet weak var lblNoResultShow: UILabel!
    var muarrayPastPresidentList:NSMutableArray = NSMutableArray()
    
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    //MARK:- local Variable
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
    var varGetSearchText:String! = ""
    var varLastUpdateDateForAddPhoto:String! = ""
    var moduleId:String! = ""
    var moduleName:String! = ""
    var onlineMemName = [String]()
    var onlineYear = [String]()
    var onlinePic = [String]()
    var filteredMem = [String]()
    var filteredPic = [String]()
    var filteredYear = [String]()
    var filterIndex = 0
    var isfilter = false
    var secCount = 0
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        lblNoResultShow.isHidden = true
        createNavigationBar()
        muarrayPastPresidentList = NSMutableArray()
        mainArray = NSMutableArray()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            print(moduleId)
            print(grpID)
            getPastPresidentList(grpID, searchText: "");
            //self.tablePastPresidentListShow.reloadData()
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            mainArray = NSMutableArray()
            fetchData()
            self.tablePastPresidentListShow.reloadData()
        }
        //mainArray = NSMutableArray()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  override  func viewWillAppear(_ animated: Bool) {
    
       // mainArray = NSMutableArray()
    }
    //MARK:- Navigation bar setting
   func createNavigationBar()
   {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white// (red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(PastPresidentListViewController.backClicked), for: UIControl.Event.touchUpInside)
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
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton=true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        print("searchText \(searchBar.text!)")
        varGetSearchText = searchBar.text!
        
       mainArray.removeAllObjects()
//        SearchFromMemberNameAndYear(varGetSearchText)
        if ((varGetSearchText.characters.count) > 0) {
            self.searchAnnouncemt(searchString: varGetSearchText)
        } else if ((searchTextField.text?.characters.count) == 0) {
            isfilter = false
            tablePastPresidentListShow.reloadData()
        }
        
//        if(varGetSearchText == "")
//        {
//            mainArray = NSMutableArray()
//            fetchData()
//            self.tablePastPresidentListShow.reloadData()
//        }
//        else
//        {
//            let  predicate = NSPredicate(format: "MemberName contains[c] %@ ",varGetSearchText)
//            print(predicate)
//            mainArray =  copymainArray.filteredArrayUsingPredicate(predicate) as! NSMutableArray
//            self.tablePastPresidentListShow.reloadData()
//        }
        searchBar.resignFirstResponder()
    }
    
    func searchAnnouncemt(searchString: String?) {
            filteredMem.removeAll()
            filteredPic.removeAll()
            filteredYear.removeAll()
            let searchString = searchString?.lowercased() ?? ""
            
            let filteredMember = self.onlineMemName.filter { $0.lowercased().contains(searchString) }
            
            filteredMem.append(contentsOf:filteredMember)
            for memberfilter in filteredMem {
                if let index = self.onlineMemName.firstIndex(where: { $0 == memberfilter }) {
                    filteredPic.append(self.onlinePic[index])
                    filteredYear.append(self.onlineYear[index])
                    filterIndex = index
                }
            }
        if(filteredMem.count>0)
        {
            isfilter = true
            self.lblNoResultShow.isHidden = true
            self.tablePastPresidentListShow.reloadData()
        }
        else
        {
            isfilter = true
            self.lblNoResultShow.isHidden = false
            self.tablePastPresidentListShow.reloadData()
        }
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
        
        if(varGetSearchText == "")
        {
            mainArray = NSMutableArray()
            fetchData()
          self.tablePastPresidentListShow.reloadData()
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
    //MARK:- Server Calling
    func getPastPresidentList(_ groupId:NSString,searchText:NSString)
    {
      //  loaderViewMethod()
        var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        var updatedOn =  String ()
        let defaults = UserDefaults.standard
        let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
        //updatedOn = "1970-01-01 00:00:00"
        str = (defaults.value(forKey: Updatedefault) as? String ?? "")
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
        SVProgressHUD.show()
        let completeURL:String! = baseUrl+row_GetPastPresidentList
        let parameterst = [
            "groupId" : groupId,
            "searchText" : searchText,
            "updateOn" : "1970-1-1 0:0:0",
            // "updatedOn" : "1970-1-1 0:0:0",
        ] as [String : Any]
        
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
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
            if((dd.object(forKey: "TBPastPresidentListResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                if (((dd.object(forKey: "TBPastPresidentListResult")! as AnyObject).object(forKey: "updatedOn")) != nil)
                {
                    UserDefaults.standard.set((dd.object(forKey: "TBPastPresidentListResult")! as AnyObject).object(forKey: "updatedOn") as! String, forKey: Updatedefault)
                    
                    print(UserDefaults.standard.set((dd.object(forKey: "TBPastPresidentListResult")! as AnyObject).object(forKey: "updatedOn") as! String, forKey: Updatedefault))
                }
                
                self.varLastUpdateDateForAddPhoto = ((response.object(forKey: "TBPastPresidentListResult")! as AnyObject).object(forKey: "updatedOn")) as! String
                print(self.varLastUpdateDateForAddPhoto)
                let arrarrNewGroupList = (((dd.object(forKey: "TBPastPresidentListResult")! as AnyObject).object(forKey: "TBPastPresidentList")! as AnyObject).object(forKey: "newRecords")) as! NSArray
                let arrDeleteGroupList = (((dd.object(forKey: "TBPastPresidentListResult")! as AnyObject).object(forKey: "TBPastPresidentList")! as AnyObject).object(forKey: "deletedRecords")) as! String
                let arrUpdateGroupList = (((dd.object(forKey: "TBPastPresidentListResult")! as AnyObject).object(forKey: "TBPastPresidentList")! as AnyObject).object(forKey: "updatedRecords")) as! NSArray
                self.onlinePic.removeAll()
                self.onlineMemName.removeAll()
                self.onlineYear.removeAll()
                for i in 0 ..< arrarrNewGroupList.count {
                    self.secCount = arrarrNewGroupList.count
                    var pics = (((((dd.value(forKey: "TBPastPresidentListResult")! as AnyObject).value(forKey: "TBPastPresidentList")! as AnyObject).value(forKey: "newRecords")! as AnyObject).value(forKey: "PhotoPath")! as AnyObject).object(at: i))
                    print("pics:: \(pics)")
                    self.onlinePic.append(pics as! String)
                    print("onlinePic:: \(self.onlinePic)")
                    var naam = (((((dd.value(forKey: "TBPastPresidentListResult")! as AnyObject).value(forKey: "TBPastPresidentList")! as AnyObject).value(forKey: "newRecords")! as AnyObject).value(forKey: "MemberName")! as AnyObject).object(at: i))
                    print("naam:: \(naam)")
                    self.onlineMemName.append(naam as! String)
                    print("onlineMemName:: \(self.onlineMemName)")
                    var yeaar = (((((dd.value(forKey: "TBPastPresidentListResult")! as AnyObject).value(forKey: "TBPastPresidentList")! as AnyObject).value(forKey: "newRecords")! as AnyObject).value(forKey: "TenureYear")! as AnyObject).object(at: i))
                    print("TenureYear:: \(yeaar)")
                    self.onlineYear.append(yeaar as! String)
                    print("onlineYear:: \(self.onlineYear)")
                }
               
                print("uuuuuuuuuuuupate--------->",arrUpdateGroupList.count)
                if(arrDeleteGroupList.characters.count > 0){
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
            }
            else{
                
                self.window = nil
//                if(dd.objectForKey("TBServiceDirectoryResult")!.objectForKey("status") as! String == "2"){
//                let alert=UIAlertController(title: "Rotary India", message:dd.objectForKey("message") as! String, preferredStyle: UIAlertController.Style.alert);
//                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Default, handler: {(action:UIAlertAction) in
//                    self.appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                    self.appDelegate.setMobileViewAsRoot()
//                }));
//                self.presentViewController(alert, animated: true, completion: nil);
            }
            self.window = nil
      SVProgressHUD.dismiss()
            }
        })
        /*----------------------------------------------------------------------------------------------------------------------------*/
        
        
        
        
        
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
            let querySQL = "SELECT IsLastUpdateDate FROM Past_President_List_Details where groupId = '\(grpID!)' and moduleId=\(moduleId!)"
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
    
    //MARK:- Table Methods
    
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isfilter {
            return filteredMem.count
        } else {
            return secCount
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tablePastPresidentListShow.dequeueReusableCell(withIdentifier: "customPastPresidentCell", for: indexPath) as! customPastPresidentCell
        cell.imagePastPresidentProfilePic.layer.borderWidth = 1.0
        cell.imagePastPresidentProfilePic.layer.masksToBounds = false
        cell.imagePastPresidentProfilePic.layer.borderColor = UIColor.lightGray.cgColor//(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        cell.imagePastPresidentProfilePic.layer.cornerRadius = cell.imagePastPresidentProfilePic.frame.size.width/2
        cell.imagePastPresidentProfilePic.clipsToBounds = true
        cell.imagePastPresidentProfilePic.clipsToBounds = true
        
        if isfilter {
            if filteredPic[indexPath.row] == ""
            {
                cell.imagePastPresidentProfilePic.image = UIImage(named: "profile_pic")
            }
            else
            {
                if let checkedUrl = URL(string: filteredPic[indexPath.row]) {
                    var varGetImage:String! = filteredPic[indexPath.row]
                    let ImageProfilePic:String = varGetImage.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    cell.imagePastPresidentProfilePic.sd_setImage(with: checkedUrl)
                 }
            }
            cell.imagePastPresidentProfilePic.layer.borderColor = UIColor.lightGray.cgColor
            cell.lblPastPresidentMemberName.text   =  filteredMem[indexPath.row]
            cell.lblYear.text = filteredYear[indexPath.row]
        } else {
            self.lblNoResultShow.isHidden = true
            if onlinePic[indexPath.row] == ""
            {
                cell.imagePastPresidentProfilePic.image = UIImage(named: "profile_pic")
            }
            else
            {
                if let checkedUrl = URL(string: onlinePic[indexPath.row]) {
                    var varGetImage:String! = onlinePic[indexPath.row]
                    let ImageProfilePic:String = varGetImage.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    cell.imagePastPresidentProfilePic.sd_setImage(with: checkedUrl)
                 }
            }
            cell.imagePastPresidentProfilePic.layer.borderColor = UIColor.lightGray.cgColor
            cell.lblPastPresidentMemberName.text   =  onlineMemName[indexPath.row]
            cell.lblYear.text = onlineYear[indexPath.row]
        }
        return cell
        
    }

    func SearchFromMemberNameAndYear(_ MemberName:String)
    {
        
          //  loaderClass.loaderViewMethod()
            checkRow = ""
            var databasePath : String
            let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documents.appendingPathComponent("NewTouchbase.db")
            // open database
            databasePath = fileURL.path
            print(fileURL)
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
                let querySQL = "SELECT * FROM Past_President_List_Details where MemberName like '%\(MemberName)%' or TenureYear like '%\(MemberName)%' and groupId = '\(grpID!)' and moduleId='\(moduleId!)'"
                print(querySQL)
                let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
                
                //masterUID , groupId, moduleId, PastPresidentId , MemberName,PhotoPath,TenureYear,IsLastUpdateDate
                while results?.next() == true
                {
                    print((results?.string(forColumn: "PastPresidentId"))! as String)
                    let dd = NSMutableDictionary ()
                    dd.setValue((results?.string(forColumn: "groupId"))! as String, forKey:"groupId")
                    dd.setValue((results?.string(forColumn: "moduleId"))! as String, forKey:"moduleId")
                    dd.setValue((results?.string(forColumn: "PastPresidentId"))! as String, forKey:"PastPresidentId")
                    dd.setValue((results?.string(forColumn: "MemberName"))! as String, forKey:"MemberName")
                    dd.setValue((results?.string(forColumn: "PhotoPath"))! as String, forKey:"PhotoPath")
                    dd.setValue((results?.string(forColumn: "TenureYear"))! as String, forKey:"TenureYear")
                    print(dd)
                    mainArray.add(dd)
                }
                self.loaderClass.window = nil
                self.tablePastPresidentListShow.reloadData()
                if mainArray.count > 0 {
                    checkRow = ""
                    lblNoResultShow.isHidden = true
                    copymainArray=mainArray
                    tablePastPresidentListShow.reloadData()
                }else{
                    checkRow = "1"
                    lblNoResultShow.isHidden = false
                    //mainArray = NSMutableArray()
                    copymainArray=NSArray()
                    //directoryTableView.reloadData()
                }
            }
            
        }
  
    
    
    
    func fetchData ()
    {
       // loaderClass.loaderViewMethod()
        checkRow = ""
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        print(fileURL)
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
            let querySQL = "SELECT * FROM Past_President_List_Details where groupId = '\(grpID!)' and moduleId='\(moduleId!)'  order by TenureYear DESC,memberName ASC"
                print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
            
            //masterUID , groupId, moduleId, PastPresidentId , MemberName,PhotoPath,TenureYear,IsLastUpdateDate
            while results?.next() == true
            {
                print((results?.string(forColumn: "PastPresidentId"))! as String)
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "groupId"))! as String, forKey:"groupId")
                dd.setValue((results?.string(forColumn: "moduleId"))! as String, forKey:"moduleId")
                dd.setValue((results?.string(forColumn: "PastPresidentId"))! as String, forKey:"PastPresidentId")
                dd.setValue((results?.string(forColumn: "MemberName"))! as String, forKey:"MemberName")
                dd.setValue((results?.string(forColumn: "PhotoPath"))! as String, forKey:"PhotoPath")
                dd.setValue((results?.string(forColumn: "TenureYear"))! as String, forKey:"TenureYear")
                print(dd)
                mainArray.add(dd)
            }
            self.loaderClass.window = nil
            self.tablePastPresidentListShow.reloadData()
            if mainArray.count > 0 {
                checkRow = ""
              lblNoResultShow.isHidden = true
                copymainArray=mainArray
                tablePastPresidentListShow.reloadData()
            }else{
                checkRow = "1"
              lblNoResultShow.isHidden = false
                //mainArray = NSMutableArray()
                copymainArray=NSArray()
                //directoryTableView.reloadData()
            }
        }
     
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
                let insertSQL = "INSERT INTO Past_President_List_Details (masterUID , groupId, moduleId, PastPresidentId , MemberName,PhotoPath,TenureYear,IsLastUpdateDate) VALUES ('\(mainMemberID!)', '\(grpID!)', '\(moduleId!)', '\(dict.object(forKey: "PastPresidentId") as! String )', '\(dict.object(forKey: "MemberName") as! String)', '\(dict.object(forKey: "PhotoPath") as! String)','\(dict.object(forKey: "TenureYear") as! String)','"+varLastUpdateDateForAddPhoto+"')"
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
                var insertSQL = ""
                //masterUID , groupId, moduleId, PastPresidentId , MemberName,PhotoPath,TenureYear,IsLastUpdateDate
                insertSQL = "UPDATE Past_President_List_Details SET  masterUID ='\(mainMemberID!)',groupId ='\(grpID!)' , moduleId ='\(moduleId!)', PastPresidentId ='\(dict.object(forKey: "PastPresidentId") as! String )' , MemberName = '\(dict.object(forKey: "MemberName") as! String)',PhotoPath ='\(dict.object(forKey: "PhotoPath") as! String)',TenureYear ='\(dict.object(forKey: "TenureYear") as! String)'  WHERE PastPresidentId = '\(dict.object(forKey: "PastPresidentId") as! String)' "
                print(insertSQL)
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("success Update")
                    print(databasePath);
                }
            }
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
    }
    //Delete
    func DeleteDataInlocal (_ arrdata:String){
        var databasePath : String
        print(arrdata);
        var varGetValuePastPresidentId=arrdata.components(separatedBy: ",")

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
            for i in 0 ..< varGetValuePastPresidentId.count {
                //let  dict = arrdata[i] as! NSDictionary
                let insertSQL = "DELETE FROM Past_President_List_Details WHERE PastPresidentId = '\(varGetValuePastPresidentId[i])'"
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

    /*-------------------------Local Data Save / Update/ Delete----------------End----------*/

}
