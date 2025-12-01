//
//  WebLinkListViewController.swift
//  TouchBase
//
//  Created by rajendra on 23/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class WebLinkListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableWebLinkListShow: UITableView!
    var muarrayWebLinkList:NSMutableArray = NSMutableArray()
    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()

    @IBOutlet weak var lblNoResultShow: UILabel!
    var varGroupId:String! = ""
    var varModuleId:String! = ""
    var moduleName:String! = ""
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    let loaderClass  = WebserviceClass()
    var appDelegate : AppDelegate = AppDelegate()
    var mainArray : NSMutableArray!

    override func viewDidLoad() {
        super.viewDidLoad()
         mainArray = NSMutableArray()
        lblNoResultShow.isHidden = true
        createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            getWebLinkList(varGroupId as! NSString, searchText: "")
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            mainArray = NSMutableArray()
            fetchData()
             SVProgressHUD.dismiss()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        buttonleft.addTarget(self, action: #selector(WebLinkListViewController.backClicked), for: UIControl.Event.touchUpInside)
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
        return muarrayWebLinkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableWebLinkListShow.dequeueReusableCell(withIdentifier: "CustomWebLinkCell", for: indexPath) as! CustomWebLinkCell
        cell.lblUnderLine.backgroundColor =  UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0)

        var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
        objCommonHoldDataVariable = muarrayWebLinkList.object(at: indexPath.row) as! CommonAccessibleHoldVariable
        
        let varGetWebLinkTitle=objCommonHoldDataVariable.varGetWebLinkTitle
        let varGetWebLinkDescription=objCommonHoldDataVariable.varGetWebLinkDescription
        cell.lblLinkTitle.text = varGetWebLinkTitle
       // cell.lblWebLinkDescription.text = varGetWebLinkDescription
        
    
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
       // appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
       //  if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
       // {
            tableView.deselectRow(at: indexPath, animated: true)
            //        NSUserDefaults.standardUserDefaults().setObject("no", forKey: "picadded")
            var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
            objCommonHoldDataVariable = muarrayWebLinkList.object(at: indexPath.row) as! CommonAccessibleHoldVariable;
            let profVC = self.storyboard!.instantiateViewController(withIdentifier: "WebLinkWebViewViewController") as! WebLinkWebViewViewController
            //profVC.varGroupID =  objCommonHoldDataVariable.varGetWebLinkGroupID  //nameTitles[indexPath.row]
           // profVC.varGetWebLinkID =  objCommonHoldDataVariable.varGetWebLinkID  //mobileTitles[indexPath.row]
            profVC.URLstr = objCommonHoldDataVariable.varGetWebLinkUrl
            profVC.varTitle = objCommonHoldDataVariable.varGetWebLinkTitle
            profVC.varWebViewDescription = objCommonHoldDataVariable.varGetWebLinkDescription
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
    //MARK:- Server Calling
    func getWebLinkList(_ groupId:NSString,searchText:NSString)
    {
       // loaderViewMethod()
        let completeURL:String! = baseUrl+row_GetWebLinkList
        let parameterst = ["GroupId" : groupId, "searchText" : searchText,]
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
            if((dd.object(forKey: "TBGetWebLinkListResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                for i in 0..<(((response.value(forKey: "TBGetWebLinkListResult")! as AnyObject).value(forKey: "WebLinkListResult")! as AnyObject).value(forKey: "WeblinkId")! as AnyObject).count
            {
            self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                print((((response.value(forKey: "TBGetWebLinkListResult")! as AnyObject).value(forKey: "WebLinkListResult")! as AnyObject).value(forKey: "WeblinkId")! as AnyObject).object(at: i))
                    
                let varGetWeblinkId=((((dd.value(forKey: "TBGetWebLinkListResult")! as AnyObject).value(forKey: "WebLinkListResult")! as AnyObject).value(forKey: "WeblinkId")! as AnyObject).object(at: i))
                let varGetWeblinkGroupID=((((dd.value(forKey: "TBGetWebLinkListResult")! as AnyObject).value(forKey: "WebLinkListResult")! as AnyObject).value(forKey: "GroupId")! as AnyObject).object(at: i))
                let varWeblinkTitle=(((dd.value(forKey: "TBGetWebLinkListResult")! as AnyObject).value(forKey: "WebLinkListResult")! as AnyObject).value(forKey: "Title")! as AnyObject).object(at: i)
                let varGetWeblinkDescription=((((dd.value(forKey: "TBGetWebLinkListResult")! as AnyObject).value(forKey: "WebLinkListResult")! as AnyObject).value(forKey: "fullDesc")! as AnyObject).object(at: i))
                let varGetWeblinkUrl=((((dd.value(forKey: "TBGetWebLinkListResult")! as AnyObject).value(forKey: "WebLinkListResult")! as AnyObject).value(forKey: "LinkUrl")! as AnyObject).object(at: i))
                    
                    //WeblinkId , GroupId , Title , Description , LinkUrl
                    var varGetWebLinkTitle:String! = ""
                    var varGetWebLinkUrl:String! = ""
                    var varGetWebLinkDescription:String! = ""
                    var varGetWebLinkID:String! = ""
                    
                    self.commonClassHoldDataAccessibleVariable.varGetWebLinkTitle = varWeblinkTitle as! String;
                    self.commonClassHoldDataAccessibleVariable.varGetWebLinkUrl = varGetWeblinkUrl as! String;
                    self.commonClassHoldDataAccessibleVariable.varGetWebLinkDescription = varGetWeblinkDescription as! String;
                    self.commonClassHoldDataAccessibleVariable.varGetWebLinkID = varGetWeblinkId as! String;
                   self.commonClassHoldDataAccessibleVariable.varGetWebLinkGroupID = varGetWeblinkGroupID as! String;
                    self.muarrayWebLinkList.add(self.commonClassHoldDataAccessibleVariable)
                    self.tableWebLinkListShow .reloadData();
                }
                
                
                
                self.appDelegate = UIApplication.shared.delegate as! AppDelegate
               if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                    self.DeleteDataInlocal()
                    if(self.muarrayWebLinkList.count>0)
                    {
                        self.lblNoResultShow.isHidden = true
                        self.SaveDataInlocal(self.muarrayWebLinkList)
                    }
                    else
                    {
                        self.lblNoResultShow.isHidden = false
                        self.window = nil
                    }
                }
                else
                {
                    self.mainArray = NSMutableArray()
                    self.fetchData()
                    self.tableWebLinkListShow.reloadData()
                    self.window = nil
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
//
    //MARK:- Local Data
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
            for i in 0 ..< arrdata.count {
                
                
                var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
                objCommonHoldDataVariable = arrdata.object(at: i) as! CommonAccessibleHoldVariable;
                let varGetWebLinkTitle=objCommonHoldDataVariable.varGetWebLinkTitle
                let varGetWebLinkUrl=objCommonHoldDataVariable.varGetWebLinkUrl
                let varGetWebLinkDescription=objCommonHoldDataVariable.varGetWebLinkDescription
                let varGetWebLinkID=objCommonHoldDataVariable.varGetWebLinkID
                let varGetWebLinkGroupID=objCommonHoldDataVariable.varGetWebLinkGroupID
                //WeblinkId , GroupId , Title , Description , LinkUrl
                let insertSQL = "INSERT INTO WebLink_Details (masterUID,GroupId,moduleId,WeblinkId,Title,Description,LinkUrl) VALUES ('\(mainMemberID!)','\(varGetWebLinkGroupID!)','\(varModuleId)','\(varGetWebLinkID!)','\(varGetWebLinkTitle!)','\(varGetWebLinkDescription!)','\(varGetWebLinkUrl!)')"
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
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            let querySQL = "SELECT * FROM WebLink_Details where groupId = '\(varGroupId)' and moduleId='\(varModuleId)'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {
                ////WeblinkId , GroupId , Title , Description , LinkUrl
                print((results?.string(forColumn: "title"))! as String)
                // let dd = NSMutableDictionary ()
                self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
          
                
                let varGetWebLinkTitle:String!=(results?.string(forColumn: "Title"))! as String
                let varGetWebLinkUrl:String!=(results?.string(forColumn: "LinkUrl"))! as String
                let varGetWebLinkDescription:String!=(results?.string(forColumn: "Description"))! as String
                let varGetWebLinkID:String!=(results?.string(forColumn: "WeblinkId"))! as String
                let varGetWebLinkGroupID:String!=(results?.string(forColumn: "GroupId"))! as String
                print(varGetWebLinkTitle)
                print(varGetWebLinkUrl)
                print(varGetWebLinkDescription)
                print(varGetWebLinkID)
                print(varGetWebLinkGroupID)
                
                
                self.commonClassHoldDataAccessibleVariable.varGetWebLinkTitle = varGetWebLinkTitle as String;
                self.commonClassHoldDataAccessibleVariable.varGetWebLinkUrl = varGetWebLinkUrl as String;
                self.commonClassHoldDataAccessibleVariable.varGetWebLinkDescription = varGetWebLinkDescription as String;
                self.commonClassHoldDataAccessibleVariable.varGetWebLinkID = varGetWebLinkID as String;
                self.commonClassHoldDataAccessibleVariable.varGetWebLinkGroupID = varGetWebLinkGroupID as String;
               
                self.mainArray.add(self.commonClassHoldDataAccessibleVariable)
                //print(dd)
                //mainArray.addObject(dd)
            }
            self.loaderClass.window = nil
            self.tableWebLinkListShow.reloadData()
            if mainArray.count > 0 {
                //  checkRow = ""
                 lblNoResultShow.isHidden = true
                muarrayWebLinkList=mainArray
                tableWebLinkListShow.reloadData()
            }else{
                //checkRow = "1"
                 lblNoResultShow.isHidden = false
                mainArray = NSMutableArray()
                muarrayWebLinkList=NSMutableArray()
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
            let insertSQL = "DELETE FROM WebLink_Details" // WHERE profileID = '\(dict.objectForKey("serviceDirId") as! String)'
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
    
    
    
    
    
    
    /*-------------------------Local Data Save / Update/ Delete----------------End----------*/

}
