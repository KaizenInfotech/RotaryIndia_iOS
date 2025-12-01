//
//  RotaryLibraryViewController.swift
//  TouchBase
//
//  Created by rajendra on 24/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//
import SVProgressHUD
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


class RotaryLibraryViewController: UIViewController ,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate{

    
    var searchingNameArray : NSMutableArray!
    var searchingkeywordArray :NSMutableArray!
    var searchingMobileNoArray : NSMutableArray!
    var str = String()
    var varGetSearchText:String! = ""
    
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    
    let loaderClass  = WebserviceClass()
    var appDelegate : AppDelegate = AppDelegate()
    var mainArray : NSMutableArray!
    var muarrayRotaryLibList:NSMutableArray = NSMutableArray()
    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
    var varGroupId:String! = ""
    var varModuleId:String! = ""
    var moduleName:String! = ""
    
    @IBOutlet weak var lblNoresultShow: UILabel!
    @IBOutlet weak var tableRotaryLibraryList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
        lblNoresultShow.isHidden = true
        mainArray = NSMutableArray()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if(varModuleId=="101" && moduleName == "About Developer" && varGroupId == "11111")
            {
             //About Developer
                
                getInfoModuleForAboutDevFaqHelpDesk()
            }
            else if(varModuleId=="102" && moduleName == "FAQ's" && varGroupId == "11111")
            {
              //FAQ's
                getInfoModuleForAboutDevFaqHelpDesk()
            }
            else
            {
              getRotaryLibraryListDetails()
            }
            
            
            
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            mainArray = NSMutableArray()
            fetchData()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- SearchBar
    
    var searchController: UISearchController!
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
        
    {
       print("Hello")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton=true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        print("searchText \(searchBar.text!)")
        varGetSearchText = searchBar.text!
        muarrayRotaryLibList.removeAllObjects()
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
        self.tableRotaryLibraryList.reloadData()
    }
    

    
    
   
    /*-------------------------------Navigation bar Setting --------------------------------Start----------------*/
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title=moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(RotaryLibraryViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Table Methods
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayRotaryLibList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableRotaryLibraryList.dequeueReusableCell(withIdentifier: "customRotaryLibCell", for: indexPath) as! customRotaryLibCell
        cell.lblUnderLine.backgroundColor =  UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        
        var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
        objCommonHoldDataVariable = muarrayRotaryLibList.object(at: indexPath.row) as! CommonAccessibleHoldVariable
        let varRotaryLibraryTitle=objCommonHoldDataVariable.varRotaryLibraryTitle
        cell.lblLinkTitle.text = varRotaryLibraryTitle
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
       // appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
       //  if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        //{
            tableView.deselectRow(at: indexPath, animated: true)
            //        NSUserDefaults.standardUserDefaults().setObject("no", forKey: "picadded")
            var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
            objCommonHoldDataVariable = muarrayRotaryLibList.object(at: indexPath.row) as! CommonAccessibleHoldVariable;
            let profVC = self.storyboard!.instantiateViewController(withIdentifier: "RotaryLibraryWevViewViewController") as! RotaryLibraryWevViewViewController
            profVC.varTitle = objCommonHoldDataVariable.varRotaryLibraryTitle
            profVC.varRotaryLibraryDescription = objCommonHoldDataVariable.varRotaryLibraryDescription
            profVC.moduleName = moduleName
            
            self.navigationController?.pushViewController(profVC, animated: true)
//        }
//        else
//        {
//            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
//        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        
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
    func getRotaryLibraryListDetails()
    {
      //  loaderViewMethod()
        let completeURL:String! = baseUrl+row_GetRotaryLibraryDetails
        //let parameterst = []
       // print(parameterst)
        print(completeURL)
        SVProgressHUD.show()
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: ["":""], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
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
            if((dd.object(forKey: "TBGetRotaryLibraryResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                self.muarrayRotaryLibList=NSMutableArray()
                for i in 0..<(((response.value(forKey: "TBGetRotaryLibraryResult")! as AnyObject).value(forKey: "RotaryLibraryListResult")! as AnyObject).value(forKey: "title")! as AnyObject).count
                {
                self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                    print((((response.value(forKey: "TBGetRotaryLibraryResult")! as AnyObject).value(forKey: "RotaryLibraryListResult")! as AnyObject).value(forKey: "title")! as AnyObject).object(at: i))
                    let varRotaryLibTitle=(((dd.value(forKey: "TBGetRotaryLibraryResult")! as AnyObject).value(forKey: "RotaryLibraryListResult")! as AnyObject).value(forKey: "title")! as AnyObject).object(at: i)
                    let varRotaryLibDescription=((((dd.value(forKey: "TBGetRotaryLibraryResult")! as AnyObject).value(forKey: "RotaryLibraryListResult")! as AnyObject).value(forKey: "description")! as AnyObject).object(at: i))
              
                    self.commonClassHoldDataAccessibleVariable.varRotaryLibraryTitle = varRotaryLibTitle as! String;
                    self.commonClassHoldDataAccessibleVariable.varRotaryLibraryDescription = varRotaryLibDescription as! String;
                    self.muarrayRotaryLibList.add(self.commonClassHoldDataAccessibleVariable)
                    [self.tableRotaryLibraryList .reloadData()];
                }
                
                
                self.appDelegate = UIApplication.shared.delegate as! AppDelegate
              if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                    self.DeleteDataInlocal()
                    if(self.muarrayRotaryLibList.count>0)
                    {
                        self.lblNoresultShow.isHidden = true
                        self.SaveDataInlocal(self.muarrayRotaryLibList)
                    }
                    else
                    {
                        self.lblNoresultShow.isHidden = false
                    }
                }
                else
                {
                    self.mainArray = NSMutableArray()
                    self.fetchData()
                    self.tableRotaryLibraryList.reloadData()
                }
                self.window = nil
            }
            else
            {
                self.window = nil
            }
            
            self.window = nil
            SVProgressHUD.dismiss()
            }
        })
    }

    //MARK:- Server Calling Static Parameter
    func getInfoModuleForAboutDevFaqHelpDesk()
    {
        /*
         {
         "grpID":"31210",
         "moduleID":"10",
         "SearchText":""
         }*/
      //  loaderViewMethod()
        let completeURL:String! = baseUrl+"Group/GetEntityInfo"
        //baseUrl+row_GetRotaryLibraryDetails
        let parameterst = ["moduleID":varModuleId, "SearchText" : "", "grpID":varGroupId]
        print(parameterst)
        print(completeURL)
        SVProgressHUD.show()
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
            if((dd.object(forKey: "TBEntityInfoResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                for i in 0..<(((response.value(forKey: "TBEntityInfoResult")! as AnyObject).value(forKey: "EntityInfoResult")! as AnyObject).value(forKey: "enname")! as AnyObject).count
                {
   self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
   print((((response.value(forKey: "TBEntityInfoResult")! as AnyObject).value(forKey: "EntityInfoResult")! as AnyObject).value(forKey: "enname")! as AnyObject).object(at: i))
   let varRotaryLibTitle=(((dd.value(forKey: "TBEntityInfoResult")! as AnyObject).value(forKey: "EntityInfoResult")! as AnyObject).value(forKey: "enname")! as AnyObject).object(at: i)
   let varRotaryLibDescription=((((dd.value(forKey: "TBEntityInfoResult")! as AnyObject).value(forKey: "EntityInfoResult")! as AnyObject).value(forKey: "descptn")! as AnyObject).object(at: i))
   
   self.commonClassHoldDataAccessibleVariable.varRotaryLibraryTitle = varRotaryLibTitle as! String;
   self.commonClassHoldDataAccessibleVariable.varRotaryLibraryDescription = varRotaryLibDescription as! String;
   self.muarrayRotaryLibList.add(self.commonClassHoldDataAccessibleVariable)
   self.tableRotaryLibraryList .reloadData();
                    
}

self.appDelegate = UIApplication.shared.delegate as! AppDelegate

    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
    
    
    self.DeleteDataInlocal()
    if(self.muarrayRotaryLibList.count>0)
    {
        self.lblNoresultShow.isHidden = true
        self.SaveDataInlocal(self.muarrayRotaryLibList)
    }
    else
    {
        self.lblNoresultShow.isHidden = false
    }
}
else
{
    self.mainArray = NSMutableArray()
    self.fetchData()
    self.tableRotaryLibraryList.reloadData()
}

self.window = nil

            }
            else
            {
                self.window = nil
            }
            
            self.window = nil
            SVProgressHUD.dismiss()
            }
        })
    }
    
    
    //MARK:- LOCAL DATA SETTING
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
            
            var insertSQL :String!=""
            for i in 0 ..< arrdata.count {
                

                var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
                objCommonHoldDataVariable = arrdata.object(at: i) as! CommonAccessibleHoldVariable;
                let varRotaryLibraryTitle=objCommonHoldDataVariable.varRotaryLibraryTitle
                let varRotaryLibraryDescription=objCommonHoldDataVariable.varRotaryLibraryDescription
                
               let varRotaryLibraryTitles  = (varRotaryLibraryTitle as! NSString).replacingOccurrences(of: "'", with: "`")
                let varRotaryLibraryDescriptions  = (varRotaryLibraryDescription as! NSString).replacingOccurrences(of: "'", with: "`")
                
                if(moduleName=="Rotary Library")
                {
                    
                    insertSQL = "INSERT INTO Rotary_Library_Details (masterUID,groupId,moduleId,title,description) VALUES ('\(mainMemberID!)','2765','32','\(varRotaryLibraryTitles)','\(varRotaryLibraryDescriptions)')"
                }
                else if (moduleName=="About Developer" || moduleName=="FAQ's")
                {
                    insertSQL = "INSERT INTO Rotary_Library_Details (masterUID,groupId,moduleId,title,description) VALUES ('\(mainMemberID!)','\(varGroupId!)','\(varModuleId!)','\(varRotaryLibraryTitle!)','\(varRotaryLibraryDescriptions)')"
                }
                print(insertSQL)
                
                let result = contactDB?.executeStatements(insertSQL)
                
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else
                {
                    print("success saved")
                    print(databasePath);
                }
            }
            
            
            self.mainArray = NSMutableArray()
            self.fetchData()
            
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
    }
    
    //Fetch Data
    func fetchData()
    {
      //  loaderClass.loaderViewMethod()
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
            
            var querySQL :String!=""
            
            if(moduleName=="Rotary Library")
            {
                querySQL = "SELECT * FROM Rotary_Library_Details where groupId = '2765' and moduleId='32'"
            }
            else if (moduleName=="About Developer" || moduleName=="FAQ's")

            {
             querySQL = "SELECT * FROM Rotary_Library_Details where groupId = '\(varGroupId!)' and moduleId='\(varModuleId!)'"
            }
            
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {
                print((results?.string(forColumn: "title"))! as String)
                // let dd = NSMutableDictionary ()
                self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
//                let varBodMemberGroupID:String! =   (results?.stringForColumn("groupId"))
//                print(varBodMemberGroupID)
//                let varBodMemberMasterUID:String!=(results?.stringForColumn("moduleId"))! as String
//                let varBodMemberProfileId:String!=(results?.stringForColumn("profileID"))! as String
                let varRotaryLibTitle:String!=(results?.string(forColumn: "title"))! as String
                let varRotaryLibDescription:String!=(results?.string(forColumn: "description"))! as String
                print(varRotaryLibTitle)
                print(varRotaryLibDescription)
                self.commonClassHoldDataAccessibleVariable.varRotaryLibraryTitle = varRotaryLibTitle
                self.commonClassHoldDataAccessibleVariable.varRotaryLibraryDescription = varRotaryLibDescription
                self.mainArray.add(self.commonClassHoldDataAccessibleVariable)
                //print(dd)
                //mainArray.addObject(dd)
            }
            self.loaderClass.window = nil
            self.tableRotaryLibraryList.reloadData()
            if mainArray.count > 0 {
              //  checkRow = ""
                self.lblNoresultShow.isHidden = true
                muarrayRotaryLibList=mainArray
                tableRotaryLibraryList.reloadData()
            }else{
                //checkRow = "1"
                self.lblNoresultShow.isHidden = false
                mainArray = NSMutableArray()
                muarrayRotaryLibList=NSMutableArray()
                //directoryTableView.reloadData()
            }
        }
        
    }
    
    
    func SearchFromMemberNameAndYear(_ RotaryLibTitle:String)
    {
        //loaderClass.loaderViewMethod()
        //checkRow = ""
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
            
            var querySQL:String!=""
            if(moduleName=="Rotary Library")
            {
               querySQL = "SELECT * FROM Rotary_Library_Details where title like '%\(RotaryLibTitle)%'  and groupId = '2765' and moduleId='32'"
            }
            else if (moduleName=="About Developer" || moduleName=="FAQ's")
            {
              querySQL = "SELECT * FROM Rotary_Library_Details where title like '%\(RotaryLibTitle)%'  and groupId = '\(varGroupId)' and moduleId='\(varModuleId)'"
            }
          
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {
                print((results?.string(forColumn: "title"))! as String)
                // let dd = NSMutableDictionary ()
                self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                //let varBodMemberGroupID:String! =   (results?.stringForColumn("groupId"))
                //print(varBodMemberGroupID)
                //let varBodMemberMasterUID:String!=(results?.stringForColumn("moduleId"))! as String
                let varRotaryLibTitle:String!=(results?.string(forColumn: "title"))! as String
                let varRotaryLibDescription:String!=(results?.string(forColumn: "description"))! as String
                self.commonClassHoldDataAccessibleVariable.varRotaryLibraryTitle = varRotaryLibTitle
                self.commonClassHoldDataAccessibleVariable.varRotaryLibraryDescription = varRotaryLibDescription
                self.mainArray.add(self.commonClassHoldDataAccessibleVariable)
                //print(dd)
                //mainArray.addObject(dd)
            }
            self.loaderClass.window = nil
            self.tableRotaryLibraryList.reloadData()
            if mainArray.count > 0 {
                //checkRow = ""
                 self.lblNoresultShow.isHidden = true
                muarrayRotaryLibList=mainArray
                tableRotaryLibraryList.reloadData()
            }else{
                //checkRow = "1"
                 self.lblNoresultShow.isHidden = false
                mainArray = NSMutableArray()
                muarrayRotaryLibList=NSMutableArray()
                //directoryTableView.reloadData()
            }
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
            let insertSQL = "DELETE FROM Rotary_Library_Details" // WHERE profileID = '\(dict.objectForKey("serviceDirId") as! String)'
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

    
    
    
    
    //MARK:- Local Data
    /*-------------------------Local Data Save / Update/ Delete----------------End----------*/
    
}
