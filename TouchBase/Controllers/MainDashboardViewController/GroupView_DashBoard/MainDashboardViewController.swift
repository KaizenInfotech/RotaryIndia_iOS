//  MainDashboardViewController.swift
//  TouchBase
//
//  Created by Umesh on 17/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//
import SVProgressHUD
import MessageUI
import UIKit
import Alamofire
import SJSegmentedScrollView
import SDWebImage
import SVProgressHUD
class MainDashboardViewController:  UIViewController,webServiceDelegate,MFMailComposeViewControllerDelegate , UIPickerViewDelegate , UIPickerViewDataSource ,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    //  self.loaderClass.window = nil
    
    
    //MARK:- Variables
    var varGetId:String!=""
    let loaderClass  = WebserviceClass()
    var muarrayIsConatinCountOrNot:NSMutableArray=NSMutableArray()
    var varGetCount:String!=""
    var arrarrNewGroupList :NSArray!
    var arrDeleteGroupList :NSArray!
    var moduleId:String! = ""
    var grpName:NSString!
    var replicaOf = String()
    var menuTitles  = ["DIRECTORY","E-BULLETINE","ANNOUNCEMENT","EVENTS","BDAYS & ANNIV.","GROUP varTORY","GROUP DOCUMENTS","COMMITTEE","MEETING","MY PROFILE","GALLERY","TICKETS","SETTINGS"];
    var menuTitlesImg  = ["directory","ebulletin","announcement","events","celebration","info","document","committee","meeting","info","gallery","meeting","info"];
    var grpDetail:GroupResult!
    var grpDetailPrevious = NSDictionary()
    var muarrayNotificationCount:NSArray=NSMutableArray()
    
    var listSyncOnline: Resultus?

    
    var allmoduleCAtArry:NSMutableArray!
    var mymoduleCAtArry:NSArray!
    var myGroupListResult:NSArray!
    fileprivate let cellIdentifier = "collectionCell"
    var appDelegate : AppDelegate!
    var window : UIWindow!
    var tap = UITapGestureRecognizer()
    var dropDown_flag = Bool()
    let dropDownView = UIView()
    var refresher:UIRefreshControl!
    var refreshControl: UIRefreshControl!
    var modulNameForClubHistory:String! = ""
    var varGetGroupId:String!=""  // Rajendra
    var isGroupAdmin:String!=""
    var isGroupProfileID:String!=""
    var isCategory:String! = ""
    var mainArraySettingForPicker = NSArray()
    var varGetPickerSelectValue:String! = ""
    var varISPopVisisbleorNot:Int!=0
    
    
    var groupUniqueName:String!=""
    
    var titleRIZone = ""
    
    
    //MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var pickerSelectSettingMyProfileAboutPicker: UIPickerView!
    @IBOutlet weak var buttonDonOnPicker: UIButton!
    @IBOutlet weak var viewForSettingPicker: UIView!

    //MARK:- ViewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue("no", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
        UserDefaults.standard.setValue("no", forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile") //Rajendra
        funcForRemoveZipFileFromDocumentDirectory()
        dropDownView.ThreeDView()
        self.collectionView.alwaysBounceVertical = true;
        //---pulll to refresh
//        refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
////        refreshControl.addTarget(self, action: #selector(RootDashViewController.refresh(_:)), for: UIControl.Event.valueChanged)
//        refreshControl.addTarget(self, action: #selector(MainDashboardViewController.refresh(_:)), for: UIControl.Event.valueChanged)
//        collectionView.addSubview(refreshControl) // not required when using UITableViewController
        //---
        
        //Navigation more functionality ------DPK
        varGetPickerSelectValue = "My Profile"
        viewForSettingPicker.isHidden = true
        buttonOpticity.isHidden = true
        buttonDonOnPicker.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        //mainArraySettingForPicker = ["My Profile" , "Settings" , "My Club"]
        mainArraySettingForPicker = ["My Profile" ,  "My Club"]
        self.navigationController?.isNavigationBarHidden = false
    }
    @objc func refresh(_ sender:AnyObject) {
        self.refreshControl?.endRefreshing()
//        fetchData()
        self.refreshControl?.endRefreshing()
        self.refreshControl?.isHidden=true
    }
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool)
    {
        collectionView.isUserInteractionEnabled=true
        UserDefaults.standard.set("nothing", forKey: "session_LinkValue")
        UserDefaults.standard.set("no", forKey: "thisiscomingfromdetaileventdelete")
        SVProgressHUD.dismiss()
        
        let getvalue = UserDefaults.standard.string(forKey: "session_IsComingFromProfileDynamicBackagainandagain")
         let varGetValueForUpdateProfile:String!=UserDefaults.standard.value(forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")as? String
        if(getvalue=="yes")
        {
            UserDefaults.standard.setValue("no", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
            var alertController = UIAlertController()
            self.functionForGetZipFilePath()
            alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                alertController.dismiss(animated: true, completion: nil)
            })
        }
        if(varGetValueForUpdateProfile=="yes")
        {
             UserDefaults.standard.setValue("no", forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")
            var alertController = UIAlertController()
                       self.functionForGetZipFilePath()
                       alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
                       self.present(alertController, animated: true, completion: nil)
                       
                       DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                           alertController.dismiss(animated: true, completion: nil)
           })
        }

        self.refreshControl?.endRefreshing()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        createNavigationBar()
        allmoduleCAtArry=[]
        mymoduleCAtArry=[]
        if(isGroupAdmin == "Yes" || isGroupAdmin == "yes")
        {
            fetchData()
        }
        else
        {
            functionForGetAssistanceDetails()
            fetchData()
        }
        //code by Rajendra
    }

    //MARK:- Functions
    func funcForRemoveZipFileFromDocumentDirectory()
    {
        /////////////////////////------------------------------------
        let dirst = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as? [String]
        print(dirst)
        if dirst != nil
        {
            let dirt = dirst![0]
            do {
                let fileList = try FileManager.default.contentsOfDirectory(atPath: dirt)
                print(fileList)
                for i in 00 ..< fileList.count
                {
                    let file:String = "ABC"
                    let varValue=fileList[i]
                    print(varValue)
                    if(varValue.hasSuffix(".zip"))
                    {
                        var varGetFilePAth:String=""
                        varGetFilePAth=fileList[i]
                        print(varGetFilePAth)
                        //here need to unwip file
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                        let zipPath:String =  documentsPath+"/"+varGetFilePAth
                        print(zipPath)
                        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first
                        {
                            let fileManager = FileManager.default
                            try fileManager.removeItem(atPath: zipPath)
                        }
                    }
                        
                    else
                    {
                        if(varValue=="NewMembers")
                        {
                            var varGetFilePAth:String=""
                            varGetFilePAth=fileList[i]
                            print(varGetFilePAth)
                            //here need to unwip file
                            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                            let zipPath:String =  documentsPath+"/"+varGetFilePAth
                            print(zipPath)
                            if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first
                            {
                                let fileManager = FileManager.default
                                try fileManager.removeItem(atPath: zipPath)
                                
                            }
                        }
                        //self.view.makeToast("Error occuring, While fetching data", duration: 3, position: CSToastPositionCenter)
                    }
                }
            }
            catch
            {
            }
        }
    }

    func functionForGetAssistanceDetails()
    {
        let mobileNum = UserDefaults.standard.value(forKey: "session_Mobile_Number") as! String
        let completeURL = baseUrl+"Group/GetAssistanceGov"
        let parameterst = [
            "mobileNo": mobileNum //"9082347692",
        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            var dictResponseData:NSDictionary=NSDictionary()
            dictResponseData = response as! NSDictionary
             print(dictResponseData)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
                
                let status = (dictResponseData.value(forKey: "TBClubHistoryResult") as! NSDictionary).value(forKey: "status") as! String
                print(status)
                if(status=="0")
                {
                    UserDefaults.standard.setValue("ShowMonthlyReportModule", forKey: "ShowHideMonthlyReportModule")
                    print(UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule"))
                }
                else
                {
                    
                    UserDefaults.standard.setValue("HideMonthlyReportModule", forKey: "ShowHideMonthlyReportModule")
                    print(UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule"))
                }
                //fetchData()
                SVProgressHUD.dismiss()
            }
           
        })
    }
    
    func fetchData()
    {
        allmoduleCAtArry=[]
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            //print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            //print("Error: \(contactDB.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            
            let querySQL = "SELECT distinct * FROM MODULE_DATA_MASTER where groupId = '\(self.varGetId)' order  by moduleOrderNo asc"
            print("Main Dashboard querySQL \(querySQL)")
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            allmoduleCAtArry=NSMutableArray()
            let muarrayTemp:NSMutableArray=NSMutableArray()
            let isGroupAdmin = UserDefaults.standard.object(forKey: "isAdmin") as! String
            var modulenamescheck:String!=""
            while results?.next() == true {
                print((results?.string(forColumn: "groupId"))! as String)
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "groupId"))! as String, forKey:"groupId")
                dd.setValue((results?.string(forColumn: "groupModuleId"))! as String, forKey:"groupModuleId")
                dd.setValue((results?.string(forColumn: "image"))! as String, forKey:"image")
                //dd.setValue((results?.stringForColumn("masterProfileID"))! as String, forKey:"masterProfileID")
                dd.setValue((results?.string(forColumn: "moduleId"))! as String, forKey:"moduleId")
                dd.setValue((results?.string(forColumn: "moduleName"))! as String, forKey:"moduleName")
                dd.setValue((results?.string(forColumn: "moduleStaticRef"))! as String, forKey:"moduleStaticRef")
                dd.setValue((results?.string(forColumn: "moduleOrderNo"))! as String, forKey:"moduleOrderNo")
                dd.setValue((results?.string(forColumn: "notificationCount"))! as String, forKey:"notificationCount")
                
                print("<<<<<<<<<<-----This is group admin or not ----->>>>>>>>>>>>>")
                print(isGroupAdmin)
                print((results?.string(forColumn: "moduleName"))! as String)
                
                let modulename:String! = (results?.string(forColumn: "moduleName"))! as String
                if(isGroupAdmin=="No" && modulename == "Attendance")
                {
                    
                }
                else
                {
                    if((results?.string(forColumn: "moduleName"))! as String=="Sub groups")
                    {
                    }
                    else if((results?.string(forColumn: "moduleName"))! as String=="Club Monthly Report" || (results?.string(forColumn: "moduleName"))! as String=="Category" || (results?.string(forColumn: "moduleName"))! as String=="TRF Contribution")
                    {
                        if(isCategory=="1")
                        {
                        }
                        else
                        {
                            if(isGroupAdmin=="Yes")
                            {
                                print("modulenamescheck \(modulenamescheck)")
                                if(modulename != modulenamescheck)
                                {
                                    allmoduleCAtArry.add(dd)
                                }
                            }
                            else
                            {
                                if(UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! Any == nil)
                                {
                                    print("aaaaaaaaaaaaaaaaaaaaaaaa")
                                }
                                else
                                {
                                   if let GetAssistanceGover:String = UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as? String
                                   {
                                    //print("Club Monthly Report":-----")
                                    if (( GetAssistanceGover == "HideMonthlyReportModule"))
                                    {
                                        print("889898989898989898989898989898989898989898",UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! String)
                                    }
                                    else
                                    {
                                        print("modulenamescheck11: \(modulenamescheck)")
                                        if(modulename != modulenamescheck)
                                        {
                                            allmoduleCAtArry.add(dd)
                                        }
                                        print("111111111111111111111111111111111111111",UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! String)
                                    }
                                }
                            }
                         }
                      }
                    }
                    else
                    {
                        print("modulenamescheck 22 :\(modulenamescheck ?? "")")
                        var getAdmin:String!=(results?.string(forColumn: "moduleName")) as! String
                       if((results?.string(forColumn: "moduleName"))! as String=="Admin" && isGroupAdmin=="Yes" && isCategory=="1")
                        {
                                allmoduleCAtArry.add(dd)
                        }
                       else if(modulename != modulenamescheck)
                        {
                            if(getAdmin == "Admin")
                            {
                                
                            }
                            else
                            {
                                 print("modulenamescheck 33 :\(modulenamescheck)")
                                if(modulename != modulenamescheck)
                                {
                                 allmoduleCAtArry.add(dd)
                                }
                            }
                        }
                    }
                     print("modulenamescheck 44 :\(modulenamescheck)")
                    if(modulename != modulenamescheck)
                    {
//                        self.allmoduleCAtArry.removeAllObjects()
                        muarrayTemp.add((results?.string(forColumn: "groupId"))! as String)
                        collectionView.reloadData()
                    }
                }
                modulenamescheck = (results?.string(forColumn: "moduleName"))! as String
            }
            print(muarrayIsConatinCountOrNot)
            print(muarrayTemp)
        }
        print("All module list \(allmoduleCAtArry)")
    }
    
    
    func createNavigationBar()
    {
        let str : String?
        str = groupUniqueName
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = str ?? ""
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(MainDashboardViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let editB = UIButton(type: UIButton.ButtonType.custom)
        editB.frame = CGRect(x: 50, y: 0, width: 30, height: 40)
        editB.setImage(UIImage(named:"profile"),  for: UIControl.State.normal)
        editB.addTarget(self, action: #selector(MainDashboardViewController.DropDownAction), for: UIControl.Event.touchUpInside)
        let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
        
        let buttons : NSArray = [edit]
        if(self.isCategory=="2")
        {
            
        }
        else
        {
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
        
        
        if(self.isGroupAdmin != "No"){
            //dropDownView.frame = CGRectMake(self.view.frame.size.width-150, 64, 150, 207) //--------DPK
            dropDownView.frame = CGRect(x: self.view.frame.size.width-150, y: 64, width: 150, height: 160)
        }else{
            dropDownView.frame = CGRect(x: self.view.frame.size.width-150, y: 64, width: 150, height: 160)
        }
        dropDownView.isHidden = true
        dropDownView.backgroundColor = UIColor.white//UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0)
        //  self.view.addSubview(dropDownView)
        UIApplication.shared.keyWindow?.addSubview(dropDownView)
        // window.addSubview(dropDownView)
        dropDown_flag = false
        
        let button1 = UIButton()
        button1.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        button1.setTitleColor(UIColor.black,  for: UIControl.State.normal)
        //button1.backgroundColor = UIColor.whiteColor()
        button1.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button1.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button1.addTarget(self, action: #selector(MainDashboardViewController.ProfileViewAction), for: .touchUpInside)
        button1.setTitle("My Profile",  for: UIControl.State.normal)
        button1.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 15)
        dropDownView.addSubview(button1)
        
        let button2 = UIButton()
        button2.frame = CGRect(x: 0, y: 55, width: 150, height: 50)
        button2.addTarget(self, action: #selector(MainDashboardViewController.SettingsAction), for: .touchUpInside)
        button2.setTitle("Settings",  for: UIControl.State.normal)
        button2.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button2.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button2.setTitleColor(UIColor.black,  for: UIControl.State.normal)
        button2.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 15)
        dropDownView.addSubview(button2)
        
        let button3 = UIButton()
        button3.frame = CGRect(x: 0, y: 106, width: 150, height: 50)
        button3.addTarget(self, action: #selector(MainDashboardViewController.ExitGroupAction), for: .touchUpInside)
        button3.setTitle("My Club",  for: UIControl.State.normal)
        button3.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button3.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button3.setTitleColor(UIColor.black,  for: UIControl.State.normal)
        button3.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 15)
        dropDownView.addSubview(button3)
        if(isGroupAdmin != "No"){
            let button5 = UIButton()
            let mainDashboardButton = UIButton()
            button5.frame = CGRect(x: 0, y: 157, width: 150, height: 50)
            button5.addTarget(self, action: #selector(MainDashboardViewController.DeleteGroupAction), for: .touchUpInside)
            button5.setTitle("Delete Entity",  for: UIControl.State.normal)
            button5.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            button5.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
            button5.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
            button5.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 15)
        }
    }
    override func viewDidDisappear(_ animated: Bool)
    {
        dropDownView.removeFromSuperview()
    }
    
     @objc func backClicked()
    {
        dropDownView.isHidden = true
        //window = nil
        dropDownView.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @objc func DeleteGroupAction()
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if dropDown_flag == false
            {
                if dropDownView.isHidden == false
                {
                    dropDown_flag = true
                }
                else
                {
                    dropDown_flag = false
                }
                dropDownView.removeFromSuperview()
            }
            else
            {
                if dropDownView.isHidden == false
                {
                    dropDown_flag = false
                }
                else
                {
                    dropDown_flag = true
                }
                dropDownView.removeFromSuperview()
            }
            let alert=UIAlertController(title: "Confirm", message:"Are you sure, you want to delete this entity?", preferredStyle: UIAlertController.Style.alert);
            
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil));
            //event handler with closure
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
                let wsm : WebserviceClass = WebserviceClass.sharedInstance
                wsm.delegates=self
                wsm.deleteAnEntity(self.isGroupProfileID, groupId: self.varGetId as! NSString)
            }));
            UserDefaults.standard.setValue("yes", forKey: "session_IsEntityExitInModuleScreen")
            
            self.present(alert, animated: true, completion: nil);
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            
            SVProgressHUD.dismiss()
        }
    }
    func deleteEntityDelegateFunction(_ dltPhoto : TBDeleteEntityResult){
        if(dltPhoto.status == "0"){
            self.navigationController?.popViewController(animated: true);
        }else{
            let alert=UIAlertController(title: "Failed", message:"Try again?", preferredStyle: UIAlertController.Style.alert);
            
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil));
            //event handler with closure
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
                let wsm : WebserviceClass = WebserviceClass.sharedInstance
                wsm.delegates=self
                wsm.deleteAnEntity(self.isGroupProfileID, groupId: self.varGetId as! NSString)
            }));
        }
    }
    
    @objc func ExitGroupAction()
    {
        if dropDown_flag == false
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = true
            }
            else
            {
                dropDown_flag = false
            }
            dropDownView.removeFromSuperview()
        }
        else
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = false
            }
            else
            {
                dropDown_flag = true
            }
            dropDownView.removeFromSuperview()
        }
        /*
         if(grpDetailPrevious.objectForKey("isGrpAdmin") as! String  == "No"){
         let alert=UIAlertController(title: "Confirm", message:"Are you sure, you want to remove your self from this entity?", preferredStyle: UIAlertController.Style.Alert);
         
         alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.Cancel, handler: nil));
         //event handler with closure
         alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.Default, handler: {(action:UIAlertAction) in
         let wsm : WebserviceClass = WebserviceClass.sharedInstance
         wsm.delegates=self
         wsm.ExitGroupUser(self.grpDetailPrevious["grpProfileid"] as! String, groupId: self.grpDetailPrevious["grpId"] as! String)
         }));
         NSUserDefaults.standardUserDefaults().setValue("yes", forKey: "session_IsEntityExitInModuleScreen")
         self.presentViewController(alert, animated: true, completion: nil);
         }else{
         
         let alert: UIAlertView = UIAlertView()
         alert.delegate = self
         alert.title = "Rotary India"
         alert.message = String(format:"You are the %@'s Admin, you cannot delete yourself.",grpDetailPrevious.objectForKey("grpName") as! String )
         alert.addButtonWithTitle("Ok")
         alert.show()
         
         }*/
        
        let objModuleClubInfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "ModuleClubInfoViewController") as! ModuleClubInfoViewController
        objModuleClubInfoViewController.grpID = self.varGetId
        self.navigationController?.pushViewController(objModuleClubInfoViewController, animated: true)
    }
    
    func ExitGroupDelegateFunction(_ extGrp : TBRemoveSelfResult)
    {
        print(extGrp.status)
        print(extGrp.message)
        if(extGrp.status == "0")
        {
            //code by Rajendra Jat delete entry from table
            CommonSqliteClass().functionForDeleteEntityandGroup()
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            let alert=UIAlertController(title: "Failed", message:"Failed to DELETE, please Try Again!", preferredStyle: UIAlertController.Style.alert);
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil));
            //event handler with closure
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
                let wsm : WebserviceClass = WebserviceClass.sharedInstance
                wsm.delegates=self
                wsm.ExitGroupUser(self.isGroupProfileID, groupId: self.varGetId)
            }));
            self.present(alert, animated: true, completion: nil);
        }
    }
    @objc func SettingsAction()
    {
        if dropDown_flag == false
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = true
            }
            else
            {
                dropDown_flag = false
            }
            dropDownView.removeFromSuperview()
        }
        else
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = false
            }
            else
            {
                dropDown_flag = true
            }
            dropDownView.removeFromSuperview()
        }
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ModuleSettingViewController") as! ModuleSettingViewController
        secondViewController.grpID=self.varGetId
        secondViewController.grpProfileID=self.isGroupProfileID
        secondViewController.moduleId =  moduleId
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc func ProfileViewAction()
    {
        if dropDown_flag == false
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = true
            }
            else
            {
                dropDown_flag = false
            }
            dropDownView.removeFromSuperview()
        }
        else
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = false
            }
            else
            {
                dropDown_flag = true
            }
            dropDownView.removeFromSuperview()
        }
        
        UserDefaults.standard.set("no", forKey: "picadded")
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
        
        profVC.userGroupID =  self.varGetId as NSString  //nameTitles[indexPath.row]
        profVC.userProfileID =  self.isGroupProfileID as NSString  //mobileTitles[indexPath.row]
        profVC.isAdmin = isGroupAdmin as NSString
        profVC.isCalled = "list"
        profVC.mainUSerPRofileID = self.isGroupProfileID as NSString
        // profVC.isAdmin = "No"
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        // profVC.mainUSerPRofileID = mainMemberID
        self.navigationController?.pushViewController(profVC, animated: true)
    }
    
    @objc func DropDownAction()
    {
        if(varISPopVisisbleorNot==0)
        {
            buttonOpticity.isHidden = false
            viewForSettingPicker.isHidden = false
            pickerSelectSettingMyProfileAboutPicker.reloadAllComponents()
            varISPopVisisbleorNot=1
        }
        else  if(varISPopVisisbleorNot==1)
        {
            buttonOpticity.isHidden = true
            viewForSettingPicker.isHidden = true
            varISPopVisisbleorNot=0
        }
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        window = nil
        
        if dropDown_flag == false
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = true
            }
            else
            {
                dropDown_flag = false
            }
            dropDownView.isHidden = true
            dropDownView.removeFromSuperview()
        }
        else
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = false
            }
            else
            {
                dropDown_flag = true
            }
            dropDownView.isHidden = true
            dropDownView.removeFromSuperview()
        }
    }
    func dismissView()
    {
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let onlineData = listSyncOnline?.moduleList?.newModuleList
        let clubData = listSyncOnline?.groupList?.newGroupList
        let filterModuleData = onlineData?.filter {$0.groupID == varGetId}
        
        if (isGroupAdmin == "Yes") {
            return filterModuleData?.count ?? 0
        } else {
            var nonAdminModule = filterModuleData?.filter {$0.moduleID != "51"}
            return nonAdminModule?.count ?? 0
        }
  }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.layer.borderColor = UIColor.white.cgColor
        
        let onlineData = listSyncOnline?.moduleList?.newModuleList
        let clubData = listSyncOnline?.groupList?.newGroupList
        print("onlineData--\(onlineData)")
        print("varGetId--\(varGetId)")
        print("groupID--\(onlineData?[indexPath.row].groupID)")
        var filterModuleData = onlineData?.filter {$0.groupID == varGetId}
       
            if (isGroupAdmin == "Yes") {
                cell.grpName.text=filterModuleData?[indexPath.row].moduleName
                if let checkedUrl = URL(string: filterModuleData?[indexPath.row].image ?? "")
                {
                    cell.moduleIcon.sd_setImage(with: checkedUrl, placeholderImage: UIImage(named: "Asset10"))
                }
            } else {
                let nonAdminModule = filterModuleData?.filter {$0.moduleID != "51"}
                 cell.grpName.text=nonAdminModule?[indexPath.row].moduleName
                 if let checkedUrl = URL(string: nonAdminModule?[indexPath.row].image ?? "")
                 {
                     cell.moduleIcon.sd_setImage(with: checkedUrl, placeholderImage: UIImage(named: "Asset10"))
                 }
            }
        
        
        cell.moduleStaticRef=filterModuleData?[indexPath.row].moduleStaticRef as? NSString
        cell.moduleId=filterModuleData?[indexPath.row].moduleID as? NSString

            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSpacing = CGFloat(0) //Define the space between each cell
        let leftRightMargin = CGFloat(0) //If defined in Interface Builder for "Section Insets"
        let numColumns = CGFloat(3) //The total number of columns you want
        
        let totalCellSpace = cellSpacing * (numColumns - 1)
        let screenWidth = UIScreen.main.bounds.width
        let width = ((screenWidth - leftRightMargin - totalCellSpace) / numColumns)
        let height = CGFloat(150) //whatever height you want
        return CGSize(width:width-7, height:height);
    }
    
    
    var varGetValueModuleID:String=""
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("network status \(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus())")
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            collectionView.isUserInteractionEnabled=false
        }
        else
        {
            self.navigationController?.view.makeToast("No internet available.")
        }
        
        let clubDistrictData = listSyncOnline?.groupList?.newGroupList
        let onlineModuleData = listSyncOnline?.moduleList?.newModuleList?.filter {$0.groupID == varGetId }
        let nonAdminModule = onlineModuleData?.filter {$0.moduleID != "51"}
        
        if let dict = (isGroupAdmin == "Yes") ? onlineModuleData?[indexPath.row] : nonAdminModule?[indexPath.row]
            {
                if let moduleID=dict.moduleID
                {
                    varGetValueModuleID = moduleID
                }
                print(dict)
                print("varGetValueModuleID \(varGetValueModuleID)")
                if(varGetValueModuleID.count>0)
                {
                    collectionView.isUserInteractionEnabled=true
                }
                print("grpDetailPrevious : \(grpDetailPrevious)")
                // let cell : CustomCollectionViewCell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
                
                UserDefaults.standard.setValue(dict.groupID, forKey: "session_GetGroupId")
                UserDefaults.standard.setValue(dict.moduleID, forKey: "session_GetModuleId")
                
                print("dict.groupID----\(dict.groupID)")
                print("----\(dict.moduleID)")
                
                if(varGetValueModuleID as String == "1")
                {
                    if(isCategory=="2")
                    {
                        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DistrictDirectoryOnlineViewController") as! DistrictDirectoryOnlineViewController
                        secondViewController.groupID = dict.groupID
                        secondViewController.isAdminss = self.isGroupAdmin
                        self.navigationController?.pushViewController(secondViewController, animated: true)
                    }
                    else
                    {
                        //CLUB DIRECTORY
                        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "directory") as! DirectoryViewController
                        //                let isGroupAdmin = UserDefaults.standard.object(forKey: "isAdmin") as! String
                        print(isGroupAdmin)
                        secondViewController.grpID = varGetId as NSString
                        secondViewController.isAdmin = self.isGroupAdmin
                        secondViewController.userID = isGroupProfileID
                        secondViewController.moduleId = moduleId as NSString
                        secondViewController.moduleName = dict.moduleName
                        print(isCategory)
                        secondViewController.isCategory=isCategory
                        secondViewController.groupUniqueName=groupUniqueName
                        
                        
                        //groupUniqueName
                        
                        self.navigationController?.pushViewController(secondViewController, animated: true)
                        let qualityOfServiceClass = DispatchQoS.QoSClass.background
                        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
                        backgroundQueue.async(execute: {
                            //print("This is run on the background queue")
                            DispatchQueue.main.async(execute: { () -> Void in
                                // self.navigationController?.pushViewController(secondViewController, animated: true)
                            })
                        })
                    }
                }
                
                else if(varGetValueModuleID as String == "2")
                {   //EVENTS
                    print(isCategory)
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "events") as! EventsListController
                    secondViewController.grpDetailPrevious = dict //send dict
                    secondViewController.memberProfileId=isGroupProfileID
                    secondViewController.isAdmin=isGroupAdmin as? NSString
                    secondViewController.moduleName = dict.moduleName
                    secondViewController.isAdmin = isGroupAdmin as? NSString
                    secondViewController.isCategory=isCategory
                    secondViewController.grpName=groupUniqueName
                    secondViewController.moduleGRPID = dict.groupID ?? ""
                    secondViewController.titleRIZone = self.titleRIZone
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                }
                else if(varGetValueModuleID as String == "3")
                { //ANNOUNCEMENTS
                    
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "announcement") as! AnnouncementListController
                    secondViewController.moduleId = varGetValueModuleID as NSString
                    secondViewController.grpDetailPrevious=grpDetailPrevious ////send dict
                    secondViewController.memberProfileId=isGroupProfileID
                    secondViewController.isAdmin=isGroupAdmin as? NSString
                    secondViewController.moduleName = dict.moduleName
                    secondViewController.isCategory=isCategory
                    secondViewController.grpName=groupUniqueName
                    secondViewController.varGetID = dict.groupID ?? ""
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                }
                else if(varGetValueModuleID as String == "4")
                { //E_BULLETINS
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ebulletine") as! EBulletinListingController
                    secondViewController.grpDetailPrevious = grpDetailPrevious //send dict
                    secondViewController.isAdmin=isGroupAdmin as? NSString
                    secondViewController.memberProfileId=isGroupProfileID
                    secondViewController.moduleName = dict.moduleName
                    secondViewController.isAdmin = isGroupAdmin as? NSString
                    secondViewController.stringProfileId = isGroupProfileID
                    secondViewController.varGetID = dict.groupID ?? ""
                    
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                }
                else if(varGetValueModuleID as String == "5")
                { //SUB_GROUPS
//                    if(grpDetailPrevious["isGrpAdmin"] as! String == "No")
//                    {
//                        
//                    }
//                    else
//                    {
//                        let SubGroupController = self.storyboard?.instantiateViewController(withIdentifier: "sub_group1") as! SubGroupListController
//                        SubGroupController.isCalledFrom="list"
//                        SubGroupController.groupIDX = dict["groupId"] as! String
//                        SubGroupController.isAdmin=grpDetailPrevious["isGrpAdmin"] as! String as NSString
//                        SubGroupController.moduleName = dict.object(forKey: "moduleName") as? String
//                        //var moduleName:String! = ""
//                        self.navigationController?.pushViewController(SubGroupController, animated: true)
//                    }
                }
                else if(varGetValueModuleID as String == "6")
                {//CELEBRATIONS
                    var getProfileId = isGroupProfileID
                    var getGroupId = dict.groupID
                    print(getProfileId)
                    print(getGroupId)
                    UserDefaults.standard.setValue(getProfileId, forKey: "user_auth_token_profileId")
                    UserDefaults.standard.setValue(getGroupId, forKey: "user_auth_token_groupId")
                    
                    if(isCategory=="2" )
                    {
                        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                        {
                            //  loaderClass.loaderViewMethod()
                            if #available(iOS 13.0, *) {
                                //  loaderClass.loaderViewMethod()
                                let objCelebrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
                                objCelebrationViewController.varType="B"
                                objCelebrationViewController.stringProfileId = isGroupProfileID
                                objCelebrationViewController.stringGroupID = dict.groupID
                                //stringGroupID
                                objCelebrationViewController.isAdmin = isGroupAdmin
                                objCelebrationViewController.isCategory=isCategory
                                objCelebrationViewController.grpName=groupUniqueName
                                objCelebrationViewController.isBirthdayorAnniv="birthday"
                                /*-----------------------------------------------------------------------------------------*/
                                Util.copyFile("Calendar.sqlite")
                                
                                
                                //letGetLastUpdateDate
                                
                                var varPassDay=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).day)
                                var  varPassMonth=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).month)
                                var  varPassYear=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).year)
                                //moduleId
                                var varIsFirstTimeExecute=UserDefaults.standard.value(forKey: "session_IsFirstTimeCalendarSlot")
                                var varSelectedDate:String=""
                                var varUpdateOns:String=""
                                print(varIsFirstTimeExecute)
                                //----------------------------------
                                var letGetLastUpdateDate = ModelManager.getInstance().functionForGetLastUpdateDateFromMonthTable(varPassMonth, stringYear: varPassYear,GroupID:dict.groupID ?? "")
                                //----------------------
                                if(varIsFirstTimeExecute==nil)
                                {
                                    varSelectedDate=varPassYear+"-"+varPassMonth+"-"+"01"
                                    varUpdateOns="1970/01/01 00:00:00"
                                }
                                else
                                {
                                    var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                                    let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
                                    varUpdateOns=letGetLastUpdateDate
                                    print(varUpdateOns)
                                    varSelectedDate=varPassYear+"-"+varPassMonth+"-"+"01"
                                    //print("••••••••••••••••••••••••••••••••••")
//                                    print((UserDefaults.standard.value(forKey: Updatedefault) as? String))
                                }
                                
                                if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                                {
                                    UserDefaults.standard.setValue("1", forKey: "session_IsFirstTimeCalendarSlot")
                                    objCelebrationViewController.moduleName = dict.moduleName
                                    self.loaderClass.window = nil
                                    self.navigationController?.pushViewController(objCelebrationViewController, animated: true)
                                }
                                else
                                {
                                    var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                                    let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
                                    var varGetLastUpdateValueDate = UserDefaults.standard.value(forKey: Updatedefault) as! String
                                    UserDefaults.standard.setValue("1", forKey: "session_IsFirstTimeCalendarSlot")
                                    objCelebrationViewController.moduleName = dict.moduleName
                                    self.loaderClass.window = nil
                                    self.navigationController?.pushViewController(objCelebrationViewController, animated: true)
                                }
                            } else {
                                // Fallback on earlier versions
                            }
                            
                        }
                        else
                        {
                            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                            SVProgressHUD.dismiss()
                        }
                    }
                    else
                    {
                        if #available(iOS 13.0, *) {
                            let objCelebrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
                            
                            objCelebrationViewController.varType="B"
                            objCelebrationViewController.isBirthdayorAnniv="birthday"
                            objCelebrationViewController.stringProfileId = isGroupProfileID
                            objCelebrationViewController.stringGroupID = dict.groupID
                            
                            objCelebrationViewController.isAdmin = isGroupAdmin
                            objCelebrationViewController.isCategory=isCategory
                            objCelebrationViewController.grpName=groupUniqueName
                            /*-----------------------------------------------------------------------------------------*/
                            Util.copyFile("Calendar.sqlite")
                            var varPassDay=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).day)
                            var  varPassMonth=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).month)
                            var  varPassYear=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).year)
                            //moduleId
                            var varIsFirstTimeExecute=UserDefaults.standard.value(forKey: "session_IsFirstTimeCalendarSlot")
                            var varSelectedDate:String=""
                            var varUpdateOns:String=""
                            print(varIsFirstTimeExecute)
                            //----------------------------------
                            var letGetLastUpdateDate = ModelManager.getInstance().functionForGetLastUpdateDateFromMonthTable(varPassMonth, stringYear: varPassYear,GroupID:dict.groupID ?? "")
                            //----------------------
                            if(varIsFirstTimeExecute==nil)
                            {
                                varSelectedDate=varPassYear+"-"+varPassMonth+"-"+"01"
                                varUpdateOns="1970/01/01 00:00:00"
                            }
                            else
                            {
                                var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                                let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
                                varUpdateOns=letGetLastUpdateDate
                                print(varUpdateOns)
                                varSelectedDate=varPassYear+"-"+varPassMonth+"-"+"01"
                                //print("••••••••••••••••••••••••••••••••••")
                                print((UserDefaults.standard.value(forKey: Updatedefault) as? String))
                            }
                            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                            {
                                var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                                //                                let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
                                UserDefaults.standard.setValue("1", forKey: "session_IsFirstTimeCalendarSlot")
                                objCelebrationViewController.moduleName = dict.moduleName
                                self.loaderClass.window = nil
                                self.navigationController?.pushViewController(objCelebrationViewController, animated: true)
                            }
                        } else {
                            // Fallback on earlier versions
                        }
                        
                        
                    }
                }
                else if(varGetValueModuleID as String == "7")
                {//MEETINGS
                    appDelegate.showAlsertView()
                }
                else if(varGetValueModuleID as String == "8")
                {
                    //ACTIVITIES
                    collectionView.isUserInteractionEnabled=true
                    print(self.isCategory)
                    let objShowCaseAlbumListViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseAlbumListVC") as! ShowCaseAlbumListVC
                    objShowCaseAlbumListViewController.getGroupId = dict.groupID
                    objShowCaseAlbumListViewController.GetIsAdmin=isGroupAdmin
                    objShowCaseAlbumListViewController.GetUserProfileID = isGroupProfileID
                    objShowCaseAlbumListViewController.getModuleID = dict.moduleID
                    objShowCaseAlbumListViewController.GetModuleName = dict.moduleName
                    objShowCaseAlbumListViewController.GetIsCategoryFromClubOrDistrict = self.isCategory
                    objShowCaseAlbumListViewController.strClubeorRot=dict.moduleName
                    objShowCaseAlbumListViewController.avenueShareType = "0"
                      objShowCaseAlbumListViewController.avenueTitle = "Add Club Service"
                    objShowCaseAlbumListViewController.addFloatBtn = "Add Meeting"
                    objShowCaseAlbumListViewController.delFloatBtn = "Delete Meeting"
                    objShowCaseAlbumListViewController.titleRIZone = self.titleRIZone
                    self.navigationController?.pushViewController(objShowCaseAlbumListViewController, animated: true)
                }
                else if(varGetValueModuleID as String == "52")
                {
                    //ACTIVITIES
                    collectionView.isUserInteractionEnabled=true
                    print(self.isCategory)
                    let objShowCaseAlbumListViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseAlbumListVC") as! ShowCaseAlbumListVC
                    objShowCaseAlbumListViewController.getGroupId = dict.groupID
                    objShowCaseAlbumListViewController.GetIsAdmin=isGroupAdmin
                    objShowCaseAlbumListViewController.GetUserProfileID = isGroupProfileID
                    objShowCaseAlbumListViewController.getModuleID = dict.moduleID
                    objShowCaseAlbumListViewController.GetModuleName = dict.moduleName
                    objShowCaseAlbumListViewController.GetIsCategoryFromClubOrDistrict = self.isCategory
                    objShowCaseAlbumListViewController.strClubeorRot=dict.moduleName
                    objShowCaseAlbumListViewController.avenueShareType = "1"
                    objShowCaseAlbumListViewController.avenueTitle = "Add Community Service"
                    objShowCaseAlbumListViewController.addFloatBtn = "Add Project"
                    objShowCaseAlbumListViewController.delFloatBtn = "Delete Project"
                    objShowCaseAlbumListViewController.titleRIZone = self.titleRIZone
                    self.navigationController?.pushViewController(objShowCaseAlbumListViewController, animated: true)
                }
                else if(varGetValueModuleID as String == "79")
                {
                    //ACTIVITIES
                    collectionView.isUserInteractionEnabled=true
                    print(self.isCategory)
                    let objShowCaseAlbumListViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseAlbumListVC") as! ShowCaseAlbumListVC
                    objShowCaseAlbumListViewController.getGroupId = dict.groupID
                    objShowCaseAlbumListViewController.GetIsAdmin=isGroupAdmin
                    objShowCaseAlbumListViewController.GetUserProfileID = isGroupProfileID
                    objShowCaseAlbumListViewController.getModuleID = dict.moduleID
                    objShowCaseAlbumListViewController.GetModuleName = dict.moduleName
                    objShowCaseAlbumListViewController.GetIsCategoryFromClubOrDistrict = self.isCategory
                    objShowCaseAlbumListViewController.strClubeorRot=dict.moduleName
                    objShowCaseAlbumListViewController.avenueShareType = "2"
                    objShowCaseAlbumListViewController.avenueTitle = "Add Vocational Service"
                    objShowCaseAlbumListViewController.addFloatBtn = "Add Project"
                    objShowCaseAlbumListViewController.delFloatBtn = "Delete Project"
                    objShowCaseAlbumListViewController.titleRIZone = self.titleRIZone
                    self.navigationController?.pushViewController(objShowCaseAlbumListViewController, animated: true)
                }
                else if(varGetValueModuleID as String == "80")
                {
                    //INTERNATIONAL
                    collectionView.isUserInteractionEnabled=true
                    print(self.isCategory)
                    let objShowCaseAlbumListViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseAlbumListVC") as! ShowCaseAlbumListVC
                    objShowCaseAlbumListViewController.getGroupId = dict.groupID
                    objShowCaseAlbumListViewController.GetIsAdmin=isGroupAdmin
                    objShowCaseAlbumListViewController.GetUserProfileID = isGroupProfileID
                    objShowCaseAlbumListViewController.getModuleID = dict.moduleID
                    objShowCaseAlbumListViewController.GetModuleName = dict.moduleName
                    objShowCaseAlbumListViewController.GetIsCategoryFromClubOrDistrict = self.isCategory
                    objShowCaseAlbumListViewController.strClubeorRot=dict.moduleName
                    objShowCaseAlbumListViewController.avenueShareType = "3"
                    objShowCaseAlbumListViewController.avenueTitle = "Add International Service"
                    objShowCaseAlbumListViewController.addFloatBtn = "Add Project"
                    objShowCaseAlbumListViewController.delFloatBtn = "Delete Project"
                    objShowCaseAlbumListViewController.titleRIZone = self.titleRIZone
                    self.navigationController?.pushViewController(objShowCaseAlbumListViewController, animated: true)
                } else if(varGetValueModuleID as String == "81")
                {
                    //NEWGENERATION
                    collectionView.isUserInteractionEnabled=true
                    print(self.isCategory)
                    let objShowCaseAlbumListViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseAlbumListVC") as! ShowCaseAlbumListVC
                    objShowCaseAlbumListViewController.getGroupId = dict.groupID
                    objShowCaseAlbumListViewController.GetIsAdmin=isGroupAdmin
                    objShowCaseAlbumListViewController.GetUserProfileID = isGroupProfileID
                    objShowCaseAlbumListViewController.getModuleID = dict.moduleID
                    objShowCaseAlbumListViewController.GetModuleName = dict.moduleName
                    objShowCaseAlbumListViewController.GetIsCategoryFromClubOrDistrict = self.isCategory
                    objShowCaseAlbumListViewController.strClubeorRot=dict.moduleName
                    objShowCaseAlbumListViewController.avenueShareType = "4"
                    objShowCaseAlbumListViewController.avenueTitle = "Add New Generation Service"
                    objShowCaseAlbumListViewController.addFloatBtn = "Add Project"
                    objShowCaseAlbumListViewController.delFloatBtn = "Delete Project"
                    objShowCaseAlbumListViewController.titleRIZone = self.titleRIZone
                    self.navigationController?.pushViewController(objShowCaseAlbumListViewController, animated: true)
                } else if(varGetValueModuleID as String == "1729") {
                    
                }
                else if(varGetValueModuleID as String == "82")
                {
                    //PUBLICINITIATIVE
                    collectionView.isUserInteractionEnabled=true
                    print(self.isCategory)
                    let objShowCaseAlbumListViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseAlbumListVC") as! ShowCaseAlbumListVC
                    objShowCaseAlbumListViewController.getGroupId = dict.groupID
                    objShowCaseAlbumListViewController.GetIsAdmin=isGroupAdmin
                    objShowCaseAlbumListViewController.GetUserProfileID = isGroupProfileID
                    objShowCaseAlbumListViewController.getModuleID = dict.moduleID
                    objShowCaseAlbumListViewController.GetModuleName = dict.moduleName
                    objShowCaseAlbumListViewController.GetIsCategoryFromClubOrDistrict = self.isCategory
                    objShowCaseAlbumListViewController.strClubeorRot=dict.moduleName
                    objShowCaseAlbumListViewController.avenueShareType = "5"
                      objShowCaseAlbumListViewController.avenueTitle = "Add Public Image Initiative Service"
                    objShowCaseAlbumListViewController.addFloatBtn = "Add Project"
                    objShowCaseAlbumListViewController.delFloatBtn = "Delete Project"
                    objShowCaseAlbumListViewController.titleRIZone = self.titleRIZone
                    self.navigationController?.pushViewController(objShowCaseAlbumListViewController, animated: true)
                }
                else if(varGetValueModuleID as String == "9")
                { //DOCUMENTS
                    let DocListController = self.storyboard?.instantiateViewController(withIdentifier: "docmVC") as! DocumentListViewControlller
                    DocListController.groupIDX = dict.groupID ?? ""
                    DocListController.grpPRofileID = isGroupProfileID as? NSString
                    DocListController.isCalled = "list"
                    DocListController.isAdmin=isGroupAdmin
                    DocListController.isCategory = isCategory
                    //var moduleName:String! = ""
                    DocListController.moduleName = dict.moduleName
                    
                    self.navigationController?.pushViewController(DocListController, animated: true)
                }
                else if(varGetValueModuleID as String == "10")
                { //INFO
                    let profVC = self.storyboard!.instantiateViewController(withIdentifier: "profNewInfo_view") as! ProfileInfoController
                    
                    print(dict)
                    profVC.isAdmin=isGroupAdmin as? NSString
                    profVC.groupIDX =  dict.groupID ?? ""
                    profVC.moduleID =  dict.moduleID as? NSString
                    if(isGroupAdmin == "Yes")
                    {
                        UserDefaults.standard.set("Yes", forKey: "isAdmin")
                    }
                    else
                    {
                        UserDefaults.standard.set("No", forKey: "isAdmin")
                    }
                    
                    profVC.userGroupID = dict.groupID as? NSString
                    profVC.userProfileID = isGroupProfileID as? NSString
                    profVC.isCalled = "list"
                    profVC.varNavigationTitle=dict.moduleName
                    profVC.moduleName = dict.moduleName
                    //var moduleName:String! = ""
                    self.navigationController?.pushViewController(profVC, animated: true)
                }
                else if(varGetValueModuleID as String == "11")
                { //CHAT
                    appDelegate.showAlsertView()
                    //            let albumControllerObject = self.storyboard?.instantiateViewControllerWithIdentifier("album") as! CreateAlbumViewController
                    //            albumControllerObject.grpID = dict["groupId"] as! String
                    //            albumControllerObject.userID = grpDetailPrevious["grpProfileid"] as! String
                    //            self.navigationController?.pushViewController(albumControllerObject, animated: true)
                }
                else if(varGetValueModuleID as String == "12")
                { //TASK
                    appDelegate.showAlsertView()
                }
                else if(varGetValueModuleID as String == "13")
                {
                }
                else if(varGetValueModuleID as String == "14")
                {//TICKETING
                    appDelegate.showAlsertView()
                }else if(varGetValueModuleID as String == "15")
                { //SERVICE_DIRECTORY
                    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                    {
                        var varIsFirstTimeExecute=UserDefaults.standard.value(forKey: "session_IsFirstTime")
                        var varSelectedDate:String=""
                        var varUpdateOns:String=""
                        
                        let completeURL = baseUrl+touchBase_GetServiceDirectoryCategories
                        let parameterst = [
                            "groupId" : dict.groupID,
                            "moduleId" : dict.moduleID
                        ]
                        print(parameterst)
                        print(completeURL)
                        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                            print(response)
                            var varGetValueServerError = response.object(forKey: "serverError")as? String
                            if(varGetValueServerError == "Error")
                            {
                                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                                self.loaderClass.window = nil
                                SVProgressHUD.dismiss()
                            }
                            else
                            {
                                let varStatus = response.value(forKey: "status") as! String
                                print(varStatus)
                                if(varStatus == "0")
                                {
                                    if(((response.value(forKey: "ServiceCategoriesResult")! as AnyObject).value(forKey: "ID")! as AnyObject).count>0)
                                    {
                                        let objCategoryServiceDirectoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "CategoryServiceDirectoryViewController") as! CategoryServiceDirectoryViewController
                                        objCategoryServiceDirectoryViewController.grpID = dict.groupID as? NSString
                                        objCategoryServiceDirectoryViewController.isAdmin = self.isGroupAdmin as? NSString
                                        objCategoryServiceDirectoryViewController.userID = self.isGroupProfileID as? NSString
                                        objCategoryServiceDirectoryViewController.moduleIdStr = dict.moduleID as? NSString
                                        self.loaderClass.window = nil
                                        objCategoryServiceDirectoryViewController.moduleName = dict.moduleName
                                        //var moduleName:String! = ""
                                        self.navigationController?.pushViewController(objCategoryServiceDirectoryViewController, animated: true)
                                    }
                                    else
                                    {
                                        let objCategoryServiceDirectoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "servicelist") as! ServiceDirectoryListViewController
                                        objCategoryServiceDirectoryViewController.grpID = dict.groupID as? NSString
                                        objCategoryServiceDirectoryViewController.isAdmin = self.isGroupAdmin as? NSString
                                        objCategoryServiceDirectoryViewController.userID = self.isGroupProfileID as? NSString
                                        objCategoryServiceDirectoryViewController.moduleIdStr = dict.moduleID as? NSString
                                        objCategoryServiceDirectoryViewController.letGetCategoryId = "0"
                                        objCategoryServiceDirectoryViewController.isCategory = self.isCategory
                                        self.loaderClass.window = nil
                                        objCategoryServiceDirectoryViewController.moduleName = dict.moduleName
                                        self.navigationController?.pushViewController(objCategoryServiceDirectoryViewController, animated: true)
                                    }
                                    self.loaderClass.window = nil
                                }
                                else
                                {
                                    self.loaderClass.window = nil
                                }
                            }
                            SVProgressHUD.dismiss()
                        })
                    }
                    //}
                    else
                    {
                        let objCategoryServiceDirectoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "servicelist") as! ServiceDirectoryListViewController
                        self.loaderClass.window = nil
                        objCategoryServiceDirectoryViewController.grpID = dict.groupID as? NSString //---------------DPK
                        objCategoryServiceDirectoryViewController.isAdmin = "no"
                        objCategoryServiceDirectoryViewController.userID = isGroupProfileID as? NSString
                        objCategoryServiceDirectoryViewController.moduleIdStr = dict.moduleID as? NSString
                        objCategoryServiceDirectoryViewController.letGetCategoryId = "0"
                        self.loaderClass.window = nil
                        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                        SVProgressHUD.dismiss()
                        
                        self.loaderClass.window = nil
                        objCategoryServiceDirectoryViewController.moduleName = dict.moduleName
                        self.navigationController?.pushViewController(objCategoryServiceDirectoryViewController, animated: true)
                    }
                }
                else if(varGetValueModuleID as String == "16")
                {//FEEDBACK
                    
                    let objFeedbackViewController = self.storyboard?.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
                    objFeedbackViewController.moduleName = dict.moduleName
                    objFeedbackViewController.profileID = isGroupProfileID
                    self.navigationController?.pushViewController(objFeedbackViewController, animated: true)
                    
                }
                else if(varGetValueModuleID as String == "17")
                {//ATTENDANCE
                    let objAttendanceViewController = self.storyboard?.instantiateViewController(withIdentifier: "AttendanceViewController") as! AttendanceViewController
                    let letGetProfileId = isGroupProfileID
                    let letModuleId =  dict.moduleID
                    
                    objAttendanceViewController.varGrpProfileID=letGetProfileId
                    objAttendanceViewController.isAdminAttendance=isGroupAdmin
                    objAttendanceViewController.grpIDAttendance = dict.groupID
                    objAttendanceViewController.varModuleIdAttendance = dict.moduleID
                    objAttendanceViewController.moduleNameAttendance = dict.moduleName
                    self.navigationController?.pushViewController(objAttendanceViewController, animated: true)
                    
                }
                else if(varGetValueModuleID as String == "18")
                {
                    //IMPROVEMENT
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "announcement") as! AnnouncementListController
                    secondViewController.moduleId = dict.moduleID as? NSString
                    secondViewController.grpDetailPrevious=grpDetailPrevious ////send dict
                    secondViewController.isAdmin=isGroupAdmin as? NSString
                    secondViewController.moduleName = dict.moduleName
                    secondViewController.isCategory=isCategory
                    secondViewController.grpName=groupUniqueName
                    secondViewController.varGetID = dict.groupID ?? ""
                    print("secondViewController.varGetID---\(secondViewController.varGetID)")
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                }
                else if(varGetValueModuleID as String == "19")
                { //FAQ
                    let profVC = self.storyboard!.instantiateViewController(withIdentifier: "profNewInfo_view") as! ProfileInfoController
                    profVC.groupIDX =  dict.groupID ?? ""
                    
                    if(isGroupAdmin == "Yes")
                    {
                        UserDefaults.standard.set("Yes", forKey: "isAdmin")
                    }
                    else
                    {
                        UserDefaults.standard.set("No", forKey: "isAdmin")
                    }
                    profVC.userGroupID = dict.groupID as? NSString
                    profVC.userProfileID = isGroupProfileID as? NSString
                    profVC.isCalled = "list"
                    
                    //var moduleName:String! = ""
                    profVC.moduleName = dict.moduleName
                    
                    self.navigationController?.pushViewController(profVC, animated: true)
                }
                else if(varGetValueModuleID as String == "20"){  //VVIP
                }
                else if(varGetValueModuleID as String == "21")
                { //PROGRAM_SCHEDULE
                }
                else if(varGetValueModuleID as String == "22")
                { //EXTERNAL_LINK
                    let externalViewController = self.storyboard?.instantiateViewController(withIdentifier: "Travel") as! LinkViewController
                    externalViewController.grpID = dict.groupID as? NSString
                    externalViewController.isAdmin=isGroupAdmin as? NSString
                    externalViewController.moduleId = dict.moduleID as? NSString
                    externalViewController.moduleName = dict.moduleName
                    externalViewController.moduleName = dict.moduleName
                    self.navigationController?.pushViewController(externalViewController, animated: true)
                }
                else if (varGetValueModuleID as String == "26")
                {//BOD
                    let BodVC = self.storyboard?.instantiateViewController(withIdentifier: "BoardOfDirectorsViewController") as! BoardOfDirectorsViewController
                    BodVC.grpID = dict.groupID as? NSString
                    BodVC.isAdmin=isGroupAdmin
                    BodVC.moduleId = dict.moduleID
                    BodVC.moduleName = dict.moduleName
                    BodVC.moduleName = dict.moduleName
                    
                    BodVC.isCategory = self.isCategory
                    self.navigationController?.pushViewController(BodVC, animated: true)
                }
                
                
                else if (varGetValueModuleID as String == "27")  //Find A Rotarian------DPk
                {
                    var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                    let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
                    var varGetLastUpdateValueDate = UserDefaults.standard.value(forKey: Updatedefault) as! String
                    let objFinddArotarianViewController = self.storyboard?.instantiateViewController(withIdentifier: "FinddArotarianViewController") as! FinddArotarianViewController
                    objFinddArotarianViewController.varGroupId = dict.groupID
                    objFinddArotarianViewController.isAdmin=isGroupAdmin
                    objFinddArotarianViewController.varModuleId = dict.moduleID
                    
                    objFinddArotarianViewController.moduleName = dict.moduleName
                    self.navigationController?.pushViewController(objFinddArotarianViewController, animated: true)
                }
                else if (varGetValueModuleID as String == "28")  //Web Link List------DPk
                {//WEBLINKS
                    let objWebLinkListViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebLinkListViewController") as! WebLinkListViewController
                    objWebLinkListViewController.varGroupId = dict.groupID
                    objWebLinkListViewController.varModuleId = dict.moduleID
                    objWebLinkListViewController.moduleName = dict.moduleName
                    self.navigationController?.pushViewController(objWebLinkListViewController, animated: true)
                }
                
                else if (varGetValueModuleID as String == "29") // Past President------DPk
                
                {//PAST PRESIDENT
                    let objPastPresidentListViewController = self.storyboard?.instantiateViewController(withIdentifier: "PastPresidentListViewController") as! PastPresidentListViewController
                    objPastPresidentListViewController.grpID = dict.groupID as? NSString
                    objPastPresidentListViewController.isAdmin=isGroupAdmin as? NSString
                    objPastPresidentListViewController.moduleId = dict.moduleID
                    objPastPresidentListViewController.moduleName = dict.moduleName
                    self.navigationController?.pushViewController(objPastPresidentListViewController, animated: true)
                }
                
                else if (varGetValueModuleID as String == "30") // Any Club And near me
                {
                    UserDefaults.standard.setValue("Find a Club", forKey: "Session_ModuleNameForNavigationHeading_FindAClubOrClubs")
                    
                    if let storyboard = self.storyboard {
                        let AnyClubNewViewController = storyboard.instantiateViewController(withIdentifier: "AnyClubNewViewController")
                        AnyClubNewViewController.title = "Any Club"
                        let NearMeNewViewController = storyboard.instantiateViewController(withIdentifier: "NearMeNewViewController")
                        NearMeNewViewController.title = "Near Me"
                        let segmentController = SJSegmentedViewController()
                        //segmentController.headerViewController = headerViewController
                        segmentController.segmentControllers = [AnyClubNewViewController,NearMeNewViewController]
                        segmentController.isFrom = true
                        navigationController?.pushViewController(segmentController, animated: true)
                    }
                }
                
                else if (varGetValueModuleID as String == "31")  //Club History-------DPk
                {
                    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                    {
                        let groupID = dict.groupID ?? ""
                        modulNameForClubHistory = dict.moduleName
                        getRotaryLibraryListDetails(groupID)
                    }
                    else
                    {
                        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                        
                        SVProgressHUD.dismiss()
                    }
                }
                
                else if (varGetValueModuleID as String == "32")  //Rotary Library-------DPk
                {
                    let objRotaryLibraryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryLibraryViewController") as! RotaryLibraryViewController
                    objRotaryLibraryViewController.varGroupId = dict.groupID
                    objRotaryLibraryViewController.varModuleId = dict.moduleID
                    objRotaryLibraryViewController.moduleName = dict.moduleName
                    self.navigationController?.pushViewController(objRotaryLibraryViewController, animated: true)
                }
                
                
                else if (varGetValueModuleID as String == "33")  //Rotary Library-------DPk
                {//DISTRICT COMMITIEE
                    let objDistrictCommiteListViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewDistrictCommitteeViewController") as! NewDistrictCommitteeViewController
                    objDistrictCommiteListViewController.getGroupID = dict.groupID
                    objDistrictCommiteListViewController.getModuleID = dict.moduleID
                    objDistrictCommiteListViewController.getModuleName = dict.moduleName
                    // objDistrictCommiteListViewController.isCategory=self.isCategory
                    self.navigationController?.pushViewController(objDistrictCommiteListViewController, animated: true)
                }
                else if (varGetValueModuleID as String == "35")  //Rotary Library-------DPk
                {
                    let objDistrictClubMemberListViewController = self.storyboard?.instantiateViewController(withIdentifier: "DistrictClubMemberListViewController") as! DistrictClubMemberListViewController
                    objDistrictClubMemberListViewController.varGroupId = dict.groupID
                    objDistrictClubMemberListViewController.varModuleId = dict.moduleID
                    objDistrictClubMemberListViewController.moduleName = dict.moduleName
           
                    
                    // var grpProfileid:String!=dict["grpProfileid"] as! String
                    UserDefaults.standard.set(dict.groupID, forKey: "groupId_Session")
                    UserDefaults.standard.set("No", forKey: "isGrpAdmin_Session")
                    UserDefaults.standard.set(isGroupProfileID, forKey: "grpProfileid_Session")
                    UserDefaults.standard.set(dict.moduleID, forKey: "moduleId_Session")
                    UserDefaults.standard.set(dict.moduleName, forKey: "moduleName_Session")
                    UserDefaults.standard.set(self.isCategory, forKey: "isCategory_Session")
                    /*this is dummy code by Rajendra jat on 24 April 2019 end*/
                    self.navigationController?.pushViewController(objDistrictClubMemberListViewController, animated: true)
                }
                else if (varGetValueModuleID as String == "38")  //Rotary Library-------DPk
                {
                    print("This is monthly report")
                    let objMonthlyReportListingViewController = self.storyboard?.instantiateViewController(withIdentifier: "MonthlyReportListingViewController") as! MonthlyReportListingViewController
                    
                    objMonthlyReportListingViewController.isAdminMonthReport=isGroupAdmin
                    objMonthlyReportListingViewController.grpIDMonthReport = dict.groupID
                    objMonthlyReportListingViewController.varModuleIdMonthReport = dict.moduleID
                    objMonthlyReportListingViewController.moduleNameMonthReport = dict.moduleName
                    
                    objMonthlyReportListingViewController.profileId=isGroupProfileID
                    self.navigationController?.pushViewController(objMonthlyReportListingViewController, animated: true)
                    
                }  else if (varGetValueModuleID as String == "85") {
                    let webScreen = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
                    if let profId = isGroupProfileID, let mob = UserDefaults.standard.value(forKey: "session_Mobile_Number")as? String {
                        webScreen.url = "https://webmarketplace.rotaryindia.org/Purchase?ID=\(profId)&Type=Mob"
                        print("webScreen.varOpenUrl:: \(webScreen.url)")
                        webScreen.moduleName = dict.moduleName ?? ""
                        webScreen.varFromCalling = "Edit Profile"
                        self.navigationController?.pushViewController(webScreen, animated: true)
                    }
                }
                else if (dict.linkURL != "")//(varGetValueModuleID as String == "85")  //Rotary Library-------DPk
                {
                    let webScreen = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
                    if let profId = isGroupProfileID, let mob = UserDefaults.standard.value(forKey: "session_Mobile_Number")as? String {
                        webScreen.url = dict.linkURL ?? ""
                        print("webScreen.varOpenUrl:: \(webScreen.url)")
                        webScreen.moduleName = dict.moduleName ?? ""
                        webScreen.varFromCalling = "Edit Profile"
                        self.navigationController?.pushViewController(webScreen, animated: true)
                    }
                }
                else if (varGetValueModuleID as String == "39")  //Monthly Report
                {
                    print("This is monthly report")
                    let objMonthlyReportListingViewController = self.storyboard?.instantiateViewController(withIdentifier: "MonthlyReportListingViewController") as! MonthlyReportListingViewController
                    
                    objMonthlyReportListingViewController.isAdminMonthReport = isGroupAdmin
                    objMonthlyReportListingViewController.grpIDMonthReport = dict.groupID
                    objMonthlyReportListingViewController.varModuleIdMonthReport = dict.moduleID
                    objMonthlyReportListingViewController.moduleNameMonthReport = dict.moduleName
                    objMonthlyReportListingViewController.profileId=isGroupProfileID
                    
                    self.navigationController?.pushViewController(objMonthlyReportListingViewController, animated: true)
                    
                }
                else if (varGetValueModuleID as String == "45")  //Rotary Library-------DPk
                {
                    let objDistrictClubMemberListViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeaderBoardViewController") as! LeaderBoardViewController
                    objDistrictClubMemberListViewController.varGroupID = dict.groupID
                    objDistrictClubMemberListViewController.varProfileID = isGroupProfileID
                    objDistrictClubMemberListViewController.varModuleName = dict.moduleName
                    self.navigationController?.pushViewController(objDistrictClubMemberListViewController, animated: true)
                }
                if(varGetValueModuleID as String == "51")
                {
                    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                    {
                        collectionView.isUserInteractionEnabled=false
                    }
                    
                    let completeURL = baseUrl+"Group/getAdminSubModules"
                    var parameterst = ["":""]
                    parameterst =  ["Fk_groupID": String(dict.groupID ?? ""),
                                    "fk_ProfileID": isGroupProfileID
                    ]
                    print(parameterst)
                    print(completeURL)
                    ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                        //=> Handle server response
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
                            var varGetValueServerError = response.object(forKey: "serverError")as? String
                            if(varGetValueServerError == "Error")
                            {
                                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                                SVProgressHUD.dismiss()
                            }
                            
                            else
                            {
                                if((dd.object(forKey: "AdminSubmodulesResult")! as AnyObject).object(forKey: "status") as! String == "0")
                                    
                                {
                                    
                                    print((dd.object(forKey: "AdminSubmodulesResult")! as AnyObject).object(forKey: "list"))
                                    
                                    var myNewName = NSMutableArray()
                                    
                                    var getListjsonResult: NSArray=NSArray()
                                    
                                    getListjsonResult=(dd.object(forKey: "AdminSubmodulesResult")! as AnyObject).object(forKey: "list") as! NSArray
                                    
                                    self.allmoduleCAtArry = NSMutableArray(array:getListjsonResult)
                                    
                                    
                                    
                                    let objAdminModuleListingViewController = self.storyboard?.instantiateViewController(withIdentifier: "AdminModuleListingViewController") as! AdminModuleListingViewController
                                    
                                    objAdminModuleListingViewController.allmoduleCAtArry = NSMutableArray(array:getListjsonResult)
                                    
                                    objAdminModuleListingViewController.isCategory=self.isCategory
                                    
                                    
                                    
                                    objAdminModuleListingViewController.varGroupID = dict.groupID
                                    
                                    objAdminModuleListingViewController.groupUniqueName = self.groupUniqueName
                                    
                                    objAdminModuleListingViewController.isAdmin = self.isGroupAdmin
                                    
                                    objAdminModuleListingViewController.userID  = self.isGroupProfileID
                                    
                                    objAdminModuleListingViewController.moduleId  = (dict.moduleID as? NSString) as! String
                                    
                                    objAdminModuleListingViewController.moduleName = dict.moduleName
                                    
                                    objAdminModuleListingViewController.grpDetailPrevious = self.grpDetailPrevious
                                    
                                    objAdminModuleListingViewController.moduleName = dict.moduleName
                                    
                                    objAdminModuleListingViewController.grpName = self.groupUniqueName
                                    
                                    
                                    
                                    self.navigationController?.pushViewController(objAdminModuleListingViewController, animated: true)
                                    
                                    // self.collectionView.reloadData()
                                    
                                }
                            }
                        }
                    })
                    ////------------------------------------
                }
            }
    }

    //MARK:- backup of didselect collection view
//    func collectionViewBackup(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
//        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//        {
//            collectionView.isUserInteractionEnabled=false
//        }
//        print(indexPath.row)
//        var dict :NSDictionary!
//        dict = allmoduleCAtArry[indexPath.row] as! NSDictionary
//        print(dict)
//        self.fetchDataFromReplica(dict["moduleId"] as! String)
//        print(replicaOf)
//        if(replicaOf.characters.count>0)
//        {
//            collectionView.isUserInteractionEnabled=true
//        }
//        //  replicaOf="8"
//        print(grpDetailPrevious)
//        let cell : CustomCollectionViewCell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
//        
//        UserDefaults.standard.setValue(dict["groupId"] as! String, forKey: "session_GetGroupId")
//        UserDefaults.standard.setValue(dict["moduleId"] as! String, forKey: "session_GetModuleId")
//        print("This is value for id new value:--------")
//        print("replicaOf")
//        print(replicaOf)
//        print("ModuleID:=: \(dict["moduleId"] as! String)")
//        
//        varGetValueModuleID = dict["moduleId"] as! String
//        if(replicaOf as String == "1")
//        {
// if(isCategory=="2")
// {
//     let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DistrictDirectoryOnlineViewController") as! DistrictDirectoryOnlineViewController
//     
//     secondViewController.groupID = dict["groupId"] as! String
//     self.navigationController?.pushViewController(secondViewController, animated: true)
// }
// else
// {
//     //DIRECTORY
//   let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "directory") as! DirectoryViewController
//   let isGroupAdmin = UserDefaults.standard.object(forKey: "isAdmin") as! String
//   print(isGroupAdmin)
//     print("dict[groupId] as! String as NSString \(dict["groupId"] as! String as NSString)")
//   secondViewController.grpID = dict["groupId"] as! String as NSString
//   secondViewController.isAdmin = grpDetailPrevious["isGrpAdmin"] as! String
//   secondViewController.userID = (grpDetailPrevious["grpProfileid"] as! String as NSString) as String!
//   
//   secondViewController.moduleId = dict["moduleId"] as! String as NSString
//   secondViewController.moduleName = dict.object(forKey: "moduleName") as? String
//   print(isCategory)
//   secondViewController.isCategory=isCategory
//   secondViewController.groupUniqueName=groupUniqueName
//   
//   
//   //groupUniqueName
//   
//   self.navigationController?.pushViewController(secondViewController, animated: true)
//   let qualityOfServiceClass = DispatchQoS.QoSClass.background
//   let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
//   backgroundQueue.async(execute: {
//       //print("This is run on the background queue")
//       DispatchQueue.main.async(execute: { () -> Void in
//           // self.navigationController?.pushViewController(secondViewController, animated: true)
//       })
//   })
//            }
//        }
//            
//        else if(replicaOf as String == "2")
//        { //EVENTS
//            print(dict.object(forKey: "myCategory") as? String)
//            print(isCategory)
//            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "events") as! EventsListController
//            secondViewController.grpDetailPrevious = grpDetailPrevious //send dict
//            secondViewController.isAdmin=grpDetailPrevious["isGrpAdmin"] as! String as NSString
//            secondViewController.moduleName = dict.object(forKey: "moduleName") as? String
//            secondViewController.isAdmin = isGroupAdmin as! NSString
//            secondViewController.isCategory=isCategory
//            secondViewController.grpName=grpDetailPrevious["grpName"] as! String
//            self.navigationController?.pushViewController(secondViewController, animated: true)
//            
//        }
//        else if(replicaOf as String == "3")
//        { //ANNOUNCEMENTS
//            
//            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "announcement") as! AnnouncementListController
//            secondViewController.moduleId = dict["moduleId"] as! String as NSString
//            secondViewController.grpDetailPrevious=grpDetailPrevious ////send dict
//            secondViewController.isAdmin=grpDetailPrevious["isGrpAdmin"] as! String as NSString
//            secondViewController.moduleName = dict.object(forKey: "moduleName") as? String
//            secondViewController.isAdmin = isGroupAdmin as! NSString
//            secondViewController.isCategory=isCategory
//            secondViewController.grpName=grpDetailPrevious["grpName"] as! String
//            
//            self.navigationController?.pushViewController(secondViewController, animated: true)
//        }
//        else if(replicaOf as String == "4")
//        { //E_BULLETINS
//            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ebulletine") as! EBulletinListingController
//            secondViewController.grpDetailPrevious = grpDetailPrevious //send dict
//            secondViewController.isAdmin=grpDetailPrevious["isGrpAdmin"] as! String as NSString
//            secondViewController.moduleName = dict.object(forKey: "moduleName") as? String
//            secondViewController.isAdmin = isGroupAdmin as! NSString
//            secondViewController.stringProfileId = grpDetailPrevious["grpProfileid"] as! String
//            
//            self.navigationController?.pushViewController(secondViewController, animated: true)
//        }
//        else if(replicaOf as String == "5")
//        { //SUB_GROUPS
//            if(grpDetailPrevious["isGrpAdmin"] as! String == "No")
//            {
//                
//            }
//            else
//            {
//                let SubGroupController = self.storyboard?.instantiateViewController(withIdentifier: "sub_group1") as! SubGroupListController
//                SubGroupController.isCalledFrom="list"
//                SubGroupController.groupIDX = dict["groupId"] as! String
//                SubGroupController.isAdmin=grpDetailPrevious["isGrpAdmin"] as! String as NSString
//                SubGroupController.moduleName = dict.object(forKey: "moduleName") as? String
//                //var moduleName:String! = ""
//                self.navigationController?.pushViewController(SubGroupController, animated: true)
//            }
//        }
//        else if(replicaOf as String == "6")
//        {//CELEBRATIONS
//            var getProfileId = grpDetailPrevious["grpProfileid"] as! String
//            var getGroupId = dict["groupId"] as! String
//            print(getProfileId)
//            print(getGroupId)
//            UserDefaults.standard.setValue(getProfileId, forKey: "user_auth_token_profileId")
//            UserDefaults.standard.setValue(getGroupId, forKey: "user_auth_token_groupId")
//            
//            if(isCategory=="2" )
//            {
//                if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//                {
//                    //  loaderClass.loaderViewMethod()
//                    if #available(iOS 13.0, *) {
//                        //  loaderClass.loaderViewMethod()
//                        let objCelebrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
//                        
//                        objCelebrationViewController.stringProfileId = grpDetailPrevious["grpProfileid"] as! String
//                        objCelebrationViewController.stringGroupID = dict["groupId"] as! String
//                        //stringGroupID
//                        objCelebrationViewController.isAdmin = grpDetailPrevious["isGrpAdmin"] as! String
//                        objCelebrationViewController.isCategory=isCategory
//                        objCelebrationViewController.grpName=grpDetailPrevious["grpName"] as! String
//                        objCelebrationViewController.isBirthdayorAnniv="birthday"
//                        /*-----------------------------------------------------------------------------------------*/
//                        Util.copyFile("Calendar.sqlite")
//                        
//                        
//                        //letGetLastUpdateDate
//                        
//                        var varPassDay=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).day)
//                        var  varPassMonth=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).month)
//                        var  varPassYear=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).year)
//                        //moduleId
//                        var varIsFirstTimeExecute=UserDefaults.standard.value(forKey: "session_IsFirstTimeCalendarSlot")
//                        var varSelectedDate:String=""
//                        var varUpdateOns:String=""
//                        print(varIsFirstTimeExecute)
//                        //----------------------------------
//                        var letGetLastUpdateDate = ModelManager.getInstance().functionForGetLastUpdateDateFromMonthTable(varPassMonth, stringYear: varPassYear,GroupID:dict["groupId"] as! String)
//                        //----------------------
//                        if(varIsFirstTimeExecute==nil)
//                        {
//                            varSelectedDate=varPassYear+"-"+varPassMonth+"-"+"01"
//                            varUpdateOns="1970/01/01 00:00:00"
//                        }
//                        else
//                        {
//                            var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//                            let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
//                            varUpdateOns=letGetLastUpdateDate
//                            print(varUpdateOns)
//                            varSelectedDate=varPassYear+"-"+varPassMonth+"-"+"01"
//                            //print("••••••••••••••••••••••••••••••••••")
//                            print((UserDefaults.standard.value(forKey: Updatedefault) as! String?)!)
//                            
//                        }
//                        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//                        {
//                            UserDefaults.standard.setValue("1", forKey: "session_IsFirstTimeCalendarSlot")
//                            objCelebrationViewController.moduleName = dict.object(forKey: "moduleName") as? String
//                            self.loaderClass.window = nil
//                            self.navigationController?.pushViewController(objCelebrationViewController, animated: true)
//                        }
//                        else
//                        {
//                            var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//                            let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
//                            var varGetLastUpdateValueDate = UserDefaults.standard.value(forKey: Updatedefault) as! String
//                            UserDefaults.standard.setValue("1", forKey: "session_IsFirstTimeCalendarSlot")
//                            objCelebrationViewController.moduleName = dict.object(forKey: "moduleName") as? String
//                            self.loaderClass.window = nil
//                            self.navigationController?.pushViewController(objCelebrationViewController, animated: true)
//                        }
//                    } else {
//                        // Fallback on earlier versions
//                    }
//                    
//                   
//                }
//                else
//                {
//                    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
//                    SVProgressHUD.dismiss()
//                }
//            }
//            else
//            {
//                if #available(iOS 13.0, *) {
//                    let objCelebrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
//                    objCelebrationViewController.isBirthdayorAnniv="birthday"
//                    objCelebrationViewController.stringProfileId = grpDetailPrevious["grpProfileid"] as! String
//                    objCelebrationViewController.stringGroupID = dict["groupId"] as! String
//                    
//                    objCelebrationViewController.isAdmin = grpDetailPrevious["isGrpAdmin"] as! String
//                    objCelebrationViewController.isCategory=isCategory
//                    objCelebrationViewController.grpName=grpDetailPrevious["grpName"] as! String
//                    /*-----------------------------------------------------------------------------------------*/
//                    Util.copyFile("Calendar.sqlite")
//                    var varPassDay=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).day)
//                    var  varPassMonth=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).month)
//                    var  varPassYear=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).year)
//                    //moduleId
//                    var varIsFirstTimeExecute=UserDefaults.standard.value(forKey: "session_IsFirstTimeCalendarSlot")
//                    var varSelectedDate:String=""
//                    var varUpdateOns:String=""
//                    print(varIsFirstTimeExecute)
//                    //----------------------------------
//                    var letGetLastUpdateDate = ModelManager.getInstance().functionForGetLastUpdateDateFromMonthTable(varPassMonth, stringYear: varPassYear,GroupID:dict["groupId"] as! String)
//                    //----------------------
//                    if(varIsFirstTimeExecute==nil)
//                    {
//                        varSelectedDate=varPassYear+"-"+varPassMonth+"-"+"01"
//                        varUpdateOns="1970/01/01 00:00:00"
//                    }
//                    else
//                    {
//                        var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//                        let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
//                        varUpdateOns=letGetLastUpdateDate
//                        print(varUpdateOns)
//                        varSelectedDate=varPassYear+"-"+varPassMonth+"-"+"01"
//                        //print("••••••••••••••••••••••••••••••••••")
//                        print((UserDefaults.standard.value(forKey: Updatedefault) as! String?)!)
//                    }
//                    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//                    {
//                        var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//                        //                                let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
//                        UserDefaults.standard.setValue("1", forKey: "session_IsFirstTimeCalendarSlot")
//                        objCelebrationViewController.moduleName = dict.object(forKey: "moduleName") as? String
//                        self.loaderClass.window = nil
//                        self.navigationController?.pushViewController(objCelebrationViewController, animated: true)
//                    }
//                } else {
//                    // Fallback on earlier versions
//                }
//               
//            }
//        }
//        else if(replicaOf as String == "7")
//        {//MEETINGS
//            appDelegate.showAlsertView()
//        }
//        else if(replicaOf as String == "8")
//        {
//            print("here gallry opening code")
//            collectionView.isUserInteractionEnabled=true
//            print(self.isCategory)
//            let objShowCaseAlbumListViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseAlbumListVC") as! ShowCaseAlbumListVC
//            objShowCaseAlbumListViewController.getGroupId = dict["groupId"] as! String
//            objShowCaseAlbumListViewController.GetIsAdmin=grpDetailPrevious["isGrpAdmin"] as! String
//            objShowCaseAlbumListViewController.GetUserProfileID = grpDetailPrevious["grpProfileid"] as! String
//            objShowCaseAlbumListViewController.getModuleID = dict["moduleId"] as! String
//            objShowCaseAlbumListViewController.GetModuleName = dict.object(forKey: "moduleName") as? String
//            objShowCaseAlbumListViewController.GetIsCategoryFromClubOrDistrict = self.isCategory
//            print(dict["groupId"] as! String)
//            print(grpDetailPrevious["isGrpAdmin"] as! String)
//            print(grpDetailPrevious["grpProfileid"] as! String)
//            print(dict["moduleId"] as! String)
//            print(dict.object(forKey: "moduleName") as? String)
//            print(self.isCategory)
//            
//            self.navigationController?.pushViewController(objShowCaseAlbumListViewController, animated: true)
//            
//        }
//        else if(replicaOf as String == "9")
//        { //DOCUMENTS
//            let DocListController = self.storyboard?.instantiateViewController(withIdentifier: "docmVC") as! DocumentListViewControlller
//            DocListController.groupIDX = dict["groupId"] as! String
//            DocListController.grpPRofileID = grpDetailPrevious["grpProfileid"] as! String as NSString
//            DocListController.isCalled = "list"
//            DocListController.isAdmin=grpDetailPrevious["isGrpAdmin"] as! String
//            DocListController.isAdmin=grpDetailPrevious["isGrpAdmin"] as! String
//            //var moduleName:String! = ""
//            DocListController.moduleName = dict.object(forKey: "moduleName") as? String
//            
//            self.navigationController?.pushViewController(DocListController, animated: true)
//        }
//        else if(replicaOf as String == "10")
//        { //INFO
//            let profVC = self.storyboard!.instantiateViewController(withIdentifier: "profNewInfo_view") as! ProfileInfoController
//            
//            print(dict)
//            
//            profVC.isAdmin=grpDetailPrevious["isGrpAdmin"] as! String as NSString
//            profVC.groupIDX =  dict["groupId"] as! String
//            profVC.moduleID =  dict["moduleId"] as! String as NSString
//            if(grpDetailPrevious.object(forKey: "isGrpAdmin") as! String == "Yes")
//            {
//                UserDefaults.standard.set("Yes", forKey: "isAdmin")
//            }
//            else
//            {
//                UserDefaults.standard.set("No", forKey: "isAdmin")
//            }
//            
//            profVC.userGroupID = dict["groupId"] as! String as NSString
//            profVC.userProfileID = grpDetailPrevious["grpProfileid"] as! String as NSString
//            profVC.isCalled = "list"
//            profVC.varNavigationTitle=dict["moduleName"] as! String
//            profVC.moduleName = dict.object(forKey: "moduleName") as? String
//            //var moduleName:String! = ""
//            self.navigationController?.pushViewController(profVC, animated: true)
//        }
//        else if(replicaOf as String == "11")
//        { //CHAT
//            appDelegate.showAlsertView()
//            //            let albumControllerObject = self.storyboard?.instantiateViewControllerWithIdentifier("album") as! CreateAlbumViewController
//            //            albumControllerObject.grpID = dict["groupId"] as! String
//            //            albumControllerObject.userID = grpDetailPrevious["grpProfileid"] as! String
//            //            self.navigationController?.pushViewController(albumControllerObject, animated: true)
//        }
//        else if(replicaOf as String == "12")
//        { //TASK
//            appDelegate.showAlsertView()
//        }
//        else if(replicaOf as String == "13")
//        {
//        }
//        else if(replicaOf as String == "14")
//        {//TICKETING
//            appDelegate.showAlsertView()
//        }else if(replicaOf as String == "15")
//        { //SERVICE_DIRECTORY
//            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//            {
//                var varIsFirstTimeExecute=UserDefaults.standard.value(forKey: "session_IsFirstTime")
//                var varSelectedDate:String=""
//                var varUpdateOns:String=""
//                
//                let completeURL = baseUrl+touchBase_GetServiceDirectoryCategories
//                let parameterst = [
//                    "groupId" : dict["groupId"] as! String,
//                    "moduleId" : dict["moduleId"] as! String
//                ]
//                print(parameterst)
//                print(completeURL)
//                ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
//                    print(response)
//                    var varGetValueServerError = response.object(forKey: "serverError")as? String
//                    if(varGetValueServerError == "Error")
//                    {
//                        self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
//                        self.loaderClass.window = nil
//                        SVProgressHUD.dismiss()
//                    }
//                    else
//                    {
//                        let varStatus = response.value(forKey: "status") as! String
//                        print(varStatus)
//                        if(varStatus == "0")
//                        {
//                            if(((response.value(forKey: "ServiceCategoriesResult")! as AnyObject).value(forKey: "ID")! as AnyObject).count>0)
//                            {
//                                let objCategoryServiceDirectoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "CategoryServiceDirectoryViewController") as! CategoryServiceDirectoryViewController
//                                objCategoryServiceDirectoryViewController.grpID = dict["groupId"] as! String as NSString
//                                objCategoryServiceDirectoryViewController.isAdmin = self.grpDetailPrevious["isGrpAdmin"] as! String as NSString
//                                objCategoryServiceDirectoryViewController.userID = self.grpDetailPrevious["grpProfileid"] as! String as NSString
//                                objCategoryServiceDirectoryViewController.moduleIdStr = dict["moduleId"] as! String as NSString
//                                self.loaderClass.window = nil
//                                objCategoryServiceDirectoryViewController.moduleName = dict.object(forKey: "moduleName") as? String
//                                //var moduleName:String! = ""
//                                self.navigationController?.pushViewController(objCategoryServiceDirectoryViewController, animated: true)
//                                
//                            }
//                            else
//                            {
//                                let objCategoryServiceDirectoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "servicelist") as! ServiceDirectoryListViewController
//                                print(dict["groupId"] as! String)
//                                objCategoryServiceDirectoryViewController.grpID = dict["groupId"] as! String as NSString
//                                objCategoryServiceDirectoryViewController.isAdmin = self.grpDetailPrevious["isGrpAdmin"] as! String as NSString
//                                objCategoryServiceDirectoryViewController.userID = self.grpDetailPrevious["grpProfileid"] as! String as NSString
//                                objCategoryServiceDirectoryViewController.moduleIdStr = dict["moduleId"] as! String as NSString
//                                objCategoryServiceDirectoryViewController.letGetCategoryId = "0"
//                                objCategoryServiceDirectoryViewController.isCategory = self.isCategory
//                                
//                                self.loaderClass.window = nil
//                                objCategoryServiceDirectoryViewController.moduleName = dict.object(forKey: "moduleName") as? String
//                                
//                                self.navigationController?.pushViewController(objCategoryServiceDirectoryViewController, animated: true)
//                                
//                            }
//                            self.loaderClass.window = nil
//                        }
//                        else
//                        {
//                            self.loaderClass.window = nil
//                        }
//                    }
//                    SVProgressHUD.dismiss()
//                })
//            }
//                //}
//            else
//            {
//                let objCategoryServiceDirectoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "servicelist") as! ServiceDirectoryListViewController
//                self.loaderClass.window = nil
//                objCategoryServiceDirectoryViewController.grpID = dict["groupId"] as! String as NSString //---------------DPK
//                objCategoryServiceDirectoryViewController.isAdmin = "no"
//                objCategoryServiceDirectoryViewController.userID = self.grpDetailPrevious["grpProfileid"] as! String as NSString
//                objCategoryServiceDirectoryViewController.moduleIdStr = dict["moduleId"] as! String as NSString
//                objCategoryServiceDirectoryViewController.letGetCategoryId = "0"
//                self.loaderClass.window = nil
//                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
//                SVProgressHUD.dismiss()
//                
//                self.loaderClass.window = nil
//                objCategoryServiceDirectoryViewController.moduleName = dict.object(forKey: "moduleName") as? String
//                self.navigationController?.pushViewController(objCategoryServiceDirectoryViewController, animated: true)
//            }
//        }
//        else if(replicaOf as String == "16")
//        {
//            
//            let objFeedbackViewController = self.storyboard?.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
//            objFeedbackViewController.moduleName = dict.object(forKey: "moduleName") as? String
//            objFeedbackViewController.profileID = self.grpDetailPrevious["grpProfileid"] as! String
//            self.navigationController?.pushViewController(objFeedbackViewController, animated: true)
//            
//        }
//        else if(replicaOf as String == "17")
//        {
//            let objAttendanceViewController = self.storyboard?.instantiateViewController(withIdentifier: "AttendanceViewController") as! AttendanceViewController
//            let letGetProfileId = grpDetailPrevious["grpProfileid"] as! String
//            let letModuleId =  dict["moduleId"] as! String
//            
//            objAttendanceViewController.varGrpProfileID=letGetProfileId
//            objAttendanceViewController.isAdminAttendance=grpDetailPrevious["isGrpAdmin"] as! String
//            objAttendanceViewController.grpIDAttendance = dict["groupId"] as! String
//            objAttendanceViewController.varModuleIdAttendance = dict["moduleId"] as! String
//            objAttendanceViewController.moduleNameAttendance = dict.object(forKey: "moduleName") as? String
//            self.navigationController?.pushViewController(objAttendanceViewController, animated: true)
//            
//        }
//        else if(replicaOf as String == "18")
//        {
//            //IMPROVEMENT
//            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "announcement") as! AnnouncementListController
//            secondViewController.moduleId = dict["moduleId"] as! String as NSString
//            secondViewController.grpDetailPrevious=grpDetailPrevious ////send dict
//            secondViewController.isAdmin=grpDetailPrevious["isGrpAdmin"] as! String as NSString
//            secondViewController.moduleName = dict.object(forKey: "moduleName") as? String
//            secondViewController.isCategory=isCategory
//            secondViewController.grpName=grpDetailPrevious["grpName"] as! String
//            
//            
//            self.navigationController?.pushViewController(secondViewController, animated: true)
//        }
//        else if(replicaOf as String == "19")
//        { //FAQ
//            let profVC = self.storyboard!.instantiateViewController(withIdentifier: "profNewInfo_view") as! ProfileInfoController
//            profVC.groupIDX =  dict["groupId"] as! String
//            
//            if(grpDetailPrevious.object(forKey: "isGrpAdmin") as! String == "Yes")
//            {
//                UserDefaults.standard.set("Yes", forKey: "isAdmin")
//            }
//            else
//            {
//                UserDefaults.standard.set("No", forKey: "isAdmin")
//            }
//            profVC.userGroupID = dict["groupId"] as! String as NSString
//            profVC.userProfileID = grpDetailPrevious["grpProfileid"] as! String as NSString
//            profVC.isCalled = "list"
//            
//            //var moduleName:String! = ""
//            profVC.moduleName = dict.object(forKey: "moduleName") as? String
//            
//            self.navigationController?.pushViewController(profVC, animated: true)
//        }
//        else if(replicaOf as String == "20"){  //VVIP
//        }
//        else if(replicaOf as String == "21")
//        { //PROGRAM_SCHEDULE
//        }
//        else if(replicaOf as String == "22")
//        { //EXTERNAL_LINK
//            let externalViewController = self.storyboard?.instantiateViewController(withIdentifier: "Travel") as! LinkViewController
//            externalViewController.grpID = dict["groupId"] as! String as NSString
//            externalViewController.isAdmin=grpDetailPrevious["isGrpAdmin"] as! String as NSString
//            externalViewController.moduleId = dict["moduleId"] as! String as NSString
//            externalViewController.moduleName = dict["moduleName"] as! String
//            externalViewController.moduleName = dict.object(forKey: "moduleName") as? String
//            
//            self.navigationController?.pushViewController(externalViewController, animated: true)
//        }
//        else if (replicaOf as String == "26")
//        {
//            let BodVC = self.storyboard?.instantiateViewController(withIdentifier: "BoardOfDirectorsViewController") as! BoardOfDirectorsViewController
//            BodVC.grpID = dict["groupId"] as! String as NSString
//            BodVC.isAdmin=grpDetailPrevious["isGrpAdmin"] as! String
//            BodVC.moduleId = dict["moduleId"] as! String
//            BodVC.moduleName = dict["moduleName"] as! String
//            BodVC.moduleName = dict.object(forKey: "moduleName") as? String
//            
//            BodVC.isCategory = self.isCategory
//            self.navigationController?.pushViewController(BodVC, animated: true)
//        }
//        else if (replicaOf as String == "30") // Any Club And near me
//        {
//            UserDefaults.standard.setValue("Find a Club", forKey: "Session_ModuleNameForNavigationHeading_FindAClubOrClubs")
//            
//            if let storyboard = self.storyboard {
//                let AnyClubNewViewController = storyboard.instantiateViewController(withIdentifier: "AnyClubNewViewController")
//                AnyClubNewViewController.title = "Any Club"
//                let NearMeNewViewController = storyboard.instantiateViewController(withIdentifier: "NearMeNewViewController")
//                NearMeNewViewController.title = "Near Me"
//                let segmentController = SJSegmentedViewController()
//                //segmentController.headerViewController = headerViewController
//                segmentController.segmentControllers = [AnyClubNewViewController,NearMeNewViewController]
//                navigationController?.pushViewController(segmentController, animated: true)
//            }
//        }
//        else if (replicaOf as String == "29") // Past President------DPk
//            
//        {
//            let objPastPresidentListViewController = self.storyboard?.instantiateViewController(withIdentifier: "PastPresidentListViewController") as! PastPresidentListViewController
//            objPastPresidentListViewController.grpID = dict["groupId"] as! String as NSString
//            objPastPresidentListViewController.isAdmin=grpDetailPrevious["isGrpAdmin"] as! String as NSString
//            objPastPresidentListViewController.moduleId = dict["moduleId"] as! String
//            objPastPresidentListViewController.moduleName = dict["moduleName"] as! String
//            objPastPresidentListViewController.moduleName = dict.object(forKey: "moduleName") as? String
//            self.navigationController?.pushViewController(objPastPresidentListViewController, animated: true)
//        }
//        else if (replicaOf as String == "27")  //Find A Rotarian------DPk
//        {
//            var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//            let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
//            var varGetLastUpdateValueDate = UserDefaults.standard.value(forKey: Updatedefault) as! String
//            let objFinddArotarianViewController = self.storyboard?.instantiateViewController(withIdentifier: "FinddArotarianViewController") as! FinddArotarianViewController
//            objFinddArotarianViewController.varGroupId = dict["groupId"] as! String
//            objFinddArotarianViewController.isAdmin=grpDetailPrevious["isGrpAdmin"] as! String
//            objFinddArotarianViewController.varModuleId = dict["moduleId"] as! String
//            
//            objFinddArotarianViewController.moduleName = dict.object(forKey: "moduleName") as? String
//            self.navigationController?.pushViewController(objFinddArotarianViewController, animated: true)
//        }
//        else if (replicaOf as String == "28")  //Web Link List------DPk
//        {
//            let objWebLinkListViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebLinkListViewController") as! WebLinkListViewController
//            objWebLinkListViewController.varGroupId = dict["groupId"] as! String
//            objWebLinkListViewController.varModuleId = dict["moduleId"] as! String
//            objWebLinkListViewController.moduleName = dict.object(forKey: "moduleName") as? String
//            self.navigationController?.pushViewController(objWebLinkListViewController, animated: true)
//        }
//            
//        else if (replicaOf as String == "32")  //Rotary Library-------DPk
//        {
//            let objRotaryLibraryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryLibraryViewController") as! RotaryLibraryViewController
//            objRotaryLibraryViewController.varGroupId = dict["groupId"] as! String
//            objRotaryLibraryViewController.varModuleId = dict["moduleId"] as! String
//            objRotaryLibraryViewController.moduleName = dict.object(forKey: "moduleName") as? String
//            self.navigationController?.pushViewController(objRotaryLibraryViewController, animated: true)
//        }
//            
//        else if (replicaOf as String == "31")  //Club History-------DPk
//        {
//            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//            {
//                let groupID = dict["groupId"] as! String
//                modulNameForClubHistory = dict.object(forKey: "moduleName") as? String
//                getRotaryLibraryListDetails(groupID)
//            }
//            else
//            {
//                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
//                
//                SVProgressHUD.dismiss()
//            }
//        }
//        else if (replicaOf as String == "33")  //Rotary Library-------DPk
//        {
//            let objDistrictCommiteListViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewDistrictCommitteeViewController") as! NewDistrictCommitteeViewController
//            objDistrictCommiteListViewController.getGroupID = dict["groupId"] as! String
//            objDistrictCommiteListViewController.getModuleID = dict["moduleId"] as! String
//            objDistrictCommiteListViewController.getModuleName = dict.object(forKey: "moduleName") as? String
//            // objDistrictCommiteListViewController.isCategory=self.isCategory
//            self.navigationController?.pushViewController(objDistrictCommiteListViewController, animated: true)
//        }
//        else if (replicaOf as String == "35")  //Rotary Library-------DPk
//        {
//            let objDistrictClubMemberListViewController = self.storyboard?.instantiateViewController(withIdentifier: "DistrictClubMemberListViewController") as! DistrictClubMemberListViewController
//            objDistrictClubMemberListViewController.varGroupId = dict["groupId"] as! String
//            objDistrictClubMemberListViewController.varModuleId = dict["moduleId"] as! String
//            objDistrictClubMemberListViewController.moduleName = dict.object(forKey: "moduleName") as? String
//            
//            /*this is dummy code by Rajendra jat on 24 April 2019 start */
//            print(self.isCategory)
//            print(dict["groupId"] as! String)
//            print(grpDetailPrevious["isGrpAdmin"] as! String)
//            print(grpDetailPrevious["grpProfileid"] as! String)
//            print(dict["moduleId"] as! String)
//            print(dict.object(forKey: "moduleName") as? String)
//            print(self.isCategory)
//            
//            // var grpProfileid:String!=dict["grpProfileid"] as! String
//            UserDefaults.standard.set(dict["groupId"] as! String, forKey: "groupId_Session")
//            UserDefaults.standard.set("No", forKey: "isGrpAdmin_Session")
//            UserDefaults.standard.set(grpDetailPrevious["grpProfileid"] as! String, forKey: "grpProfileid_Session")
//            UserDefaults.standard.set(dict["moduleId"] as! String, forKey: "moduleId_Session")
//            UserDefaults.standard.set(dict["moduleName"] as! String, forKey: "moduleName_Session")
//            UserDefaults.standard.set(self.isCategory, forKey: "isCategory_Session")
//            /*this is dummy code by Rajendra jat on 24 April 2019 end*/
//            self.navigationController?.pushViewController(objDistrictClubMemberListViewController, animated: true)
//        }
//        else if (replicaOf as String == "38")  //Rotary Library-------DPk
//        {
//            print("This is monthly report")
//            let objMonthlyReportListingViewController = self.storyboard?.instantiateViewController(withIdentifier: "MonthlyReportListingViewController") as! MonthlyReportListingViewController
//            
//            objMonthlyReportListingViewController.isAdminMonthReport=grpDetailPrevious["isGrpAdmin"] as! String
//            objMonthlyReportListingViewController.grpIDMonthReport = dict["groupId"] as! String
//            objMonthlyReportListingViewController.varModuleIdMonthReport = dict["moduleId"] as! String
//            objMonthlyReportListingViewController.moduleNameMonthReport = dict.object(forKey: "moduleName") as? String
//            
//            objMonthlyReportListingViewController.profileId=self.grpDetailPrevious["grpProfileid"] as! String
//            print("Thi sis profile id by monthly report ")
//            print(self.grpDetailPrevious["grpProfileid"] as! String)
//            self.navigationController?.pushViewController(objMonthlyReportListingViewController, animated: true)
//            
//        }
//        else if (replicaOf as String == "39")  //Monthly Report
//        {
//            print("This is monthly report")
//            let objMonthlyReportListingViewController = self.storyboard?.instantiateViewController(withIdentifier: "MonthlyReportListingViewController") as! MonthlyReportListingViewController
//            
//            objMonthlyReportListingViewController.isAdminMonthReport=grpDetailPrevious["isGrpAdmin"] as! String
//            objMonthlyReportListingViewController.grpIDMonthReport = dict["groupId"] as! String
//            objMonthlyReportListingViewController.varModuleIdMonthReport = dict["moduleId"] as! String
//            objMonthlyReportListingViewController.moduleNameMonthReport = dict.object(forKey: "moduleName") as? String
//            objMonthlyReportListingViewController.profileId=self.grpDetailPrevious["grpProfileid"] as! String
//            
//            print("Thi2222 sis profile id by monthly report ")
//            print(self.grpDetailPrevious["grpProfileid"] as! String)
//            
//            self.navigationController?.pushViewController(objMonthlyReportListingViewController, animated: true)
//            
//        }
//        else if (replicaOf as String == "45")  //Rotary Library-------DPk
//        {
//            let objDistrictClubMemberListViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeaderBoardViewController") as! LeaderBoardViewController
//            objDistrictClubMemberListViewController.varGroupID = dict["groupId"] as! String
//            objDistrictClubMemberListViewController.varProfileID = self.grpDetailPrevious["grpProfileid"] as! String
//            objDistrictClubMemberListViewController.varModuleName = dict.object(forKey: "moduleName") as? String
//            self.navigationController?.pushViewController(objDistrictClubMemberListViewController, animated: true)
//        }
//        if(replicaOf as String == "51")
//        {
//            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//            {
//                collectionView.isUserInteractionEnabled=false
//            }
//            
//            let completeURL = baseUrl+"Group/getAdminSubModules"
//            var parameterst = ["":""]
//            parameterst =  ["Fk_groupID": dict["groupId"] as! String,
//                            "fk_ProfileID": self.grpDetailPrevious["grpProfileid"] as! String
//            ]
//            print(parameterst)
//            print(completeURL)
//            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
//                //=> Handle server response
//                let dd = response as! NSDictionary
//                print("dd \(dd)")
//                var varGetValueServerError = response.object(forKey: "serverError")as? String
//                if(varGetValueServerError == "Error")
//                {
//                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
//                    SVProgressHUD.dismiss()
//                }
//                else
//                {
//                    var varGetValueServerError = response.object(forKey: "serverError")as? String
//                    if(varGetValueServerError == "Error")
//                    {
//                        self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
//                        SVProgressHUD.dismiss()
//                    }
//                        
//                    else
//                    {
//                        if((dd.object(forKey: "AdminSubmodulesResult")! as AnyObject).object(forKey: "status") as! String == "0")
//                            
//                        {
//                            
//                            print((dd.object(forKey: "AdminSubmodulesResult")! as AnyObject).object(forKey: "list"))
//                            
//                            var myNewName = NSMutableArray()
//                            
//                            var getListjsonResult: NSArray=NSArray()
//                            
//                            getListjsonResult=(dd.object(forKey: "AdminSubmodulesResult")! as AnyObject).object(forKey: "list") as! NSArray
//                            
//                            self.allmoduleCAtArry = NSMutableArray(array:getListjsonResult)
//                            
//                            
//                            
//                            let objAdminModuleListingViewController = self.storyboard?.instantiateViewController(withIdentifier: "AdminModuleListingViewController") as! AdminModuleListingViewController
//                            
//                            objAdminModuleListingViewController.allmoduleCAtArry = NSMutableArray(array:getListjsonResult)
//                            
//                            objAdminModuleListingViewController.isCategory=self.isCategory
//                            
//                            
//                            
//                            objAdminModuleListingViewController.varGroupID = dict["groupId"] as! String
//                            
//                            objAdminModuleListingViewController.groupUniqueName = self.groupUniqueName
//                            
//                            objAdminModuleListingViewController.isAdmin = self.grpDetailPrevious["isGrpAdmin"] as! String
//                            
//                            objAdminModuleListingViewController.userID  = (self.grpDetailPrevious["grpProfileid"] as! String as NSString) as String!
//                            
//                            objAdminModuleListingViewController.moduleId  = (dict["moduleId"] as! String as NSString) as String!
//                            
//                            objAdminModuleListingViewController.moduleName = dict.object(forKey: "moduleName") as? String
//                            
//                            
//                            
//                            
//                            
//                            objAdminModuleListingViewController.grpDetailPrevious = self.grpDetailPrevious
//                            
//                            objAdminModuleListingViewController.moduleName = dict.object(forKey: "moduleName") as? String
//                            
//                            objAdminModuleListingViewController.grpName = self.grpDetailPrevious["grpName"] as! String
//                            
//                            
//                            
//                            self.navigationController?.pushViewController(objAdminModuleListingViewController, animated: true)
//                            
//                            
//                            
//                            // self.collectionView.reloadData()
//                            
//                        }
//                    }
//                }
//            })
//            ////------------------------------------
//        }
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchDataFromReplica (_ moduleId : String)
    {
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            //print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            //print("Error: \(contactDB.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            let querySQL = "SELECT replicaOf FROM ReplicaInfo where moduleId = '\(moduleId)'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
            while results?.next() == true
            {
                print((results?.string(forColumn: "replicaOf"))! as String)
                replicaOf = (results?.string(forColumn: "replicaOf"))! as String
            }
        }
    }
    /*««««««««««««««««-----call web api for sending mail--------------»»»»»»»»»»»»»»»»*/
    func functionForGetEmailIdForFeedBack(_ stringGroupId:String,stringModuleId:String)
    {
        let completeURL = baseUrl+touchBase_GetfeedbackEmailId
        let parameterst = [
            k_API_grpIDFeedBack :stringGroupId ,
            k_API_moduleIDFeedBack :stringModuleId
        ]
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
                // self.loaderClass.window = nil
                print(response)
                let letGetMessage=(response.value(forKey: "GrpEmailResult")! as AnyObject).value(forKey: "message") as! String
                let letGetStatus=(response.value(forKey: "GrpEmailResult")! as AnyObject).value(forKey: "status") as! String
                if(letGetMessage=="success" && letGetStatus=="0")
                {
                    let letGetEmailId=(response.value(forKey: "GrpEmailResult")! as AnyObject).value(forKey: "email") as! String
                    let emailTitle = "Feedback"
                    let messageBody = ""
                    let toRecipents = [letGetEmailId]
                    let mc: MFMailComposeViewController = MFMailComposeViewController()
                    mc.mailComposeDelegate = self
                    mc.setSubject(emailTitle)
                    mc.setMessageBody(messageBody, isHTML: false)
                    mc.setToRecipients(toRecipents)
                    self.present(mc, animated: true, completion: nil)
                }
            }
            SVProgressHUD.dismiss()
        })
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            //print("")
            self.view!.makeToast("Mail cancelled", duration: 2, position: CSToastPositionCenter)
            
        case MFMailComposeResult.saved.rawValue:
            self.view!.makeToast("Mail saved", duration: 2, position: CSToastPositionCenter)
            
        case MFMailComposeResult.sent.rawValue:
            self.view!.makeToast("Mail sent", duration: 2, position: CSToastPositionCenter)
        case MFMailComposeResult.failed.rawValue: break
            //print("Mail sent failure: %@", [error!.localizedDescription])
            
            
//            let letGetError=[error!.localizedDescription]as! String
//            self.view!.makeToast("Mail sent failure: "+letGetError, duration: 2, position: CSToastPositionCenter)
            
        default:
            break
        }
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }

    func getRotaryLibraryListDetails(_ GroupID:String)
    {
        // loaderClass.loaderViewMethod()
        let completeURL:String! = baseUrl+row_ClubHistory
        let parameterst = ["grpId":GroupID]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters:parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                self.loaderClass.window = nil
                SVProgressHUD.dismiss()
            }
            else
            {
                print(response)
                let dd = response as! NSDictionary
                //print("dd \(dd)")
                if((dd.object(forKey: "TBClubHistoryResult")! as AnyObject).object(forKey: "status") as! String == "0")
                {
                    let varGetTitleTestClub = ((dd.object(forKey: "TBClubHistoryResult")! as AnyObject).object(forKey: "clubHistory")! as AnyObject).object(forKey: "clubName") as! String
                    let varGetClubDescription = ((dd.object(forKey: "TBClubHistoryResult")! as AnyObject).object(forKey: "clubHistory")! as AnyObject).object(forKey: "description") as! String
                    let objRotaryLibraryWevViewViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryLibraryWevViewViewController") as! RotaryLibraryWevViewViewController
                    objRotaryLibraryWevViewViewController.varTitle = varGetTitleTestClub
                    objRotaryLibraryWevViewViewController.varRotaryLibraryDescription = varGetClubDescription
                    objRotaryLibraryWevViewViewController.moduleName = self.modulNameForClubHistory
                    self.navigationController?.pushViewController(objRotaryLibraryWevViewViewController, animated: true)
                    
                    self.loaderClass.window = nil
                }
                else
                {
                    self.loaderClass.window = nil
                }
                self.loaderClass.window = nil
            }
            SVProgressHUD.dismiss()
        })
    }
    
   

    @IBAction func buttonOpticityClickEvent(_ sender: AnyObject)
    {
        buttonOpticity.isHidden=true
        viewForSettingPicker.isHidden=true
    }

    @IBAction func buttonDoneClickeventOnPicker(_ sender: AnyObject)
    {
        if(varGetPickerSelectValue == "My Profile")
        {
            UserDefaults.standard.set("no", forKey: "picadded")
            let profVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
            profVC.varGetPickerSelectValue = "ClubProfile"
//            profVC.grpID =  self.grpDetailPrevious["grpId"] as! String  //nameTitles[indexPath.row]
//            print(profVC.grpID)
//            profVC.profileId =  self.grpDetailPrevious["grpProfileid"] as! String  //mobileTitles[indexPath.row]
//            print(profVC.profileId)
//            profVC.isAdmin = grpDetailPrevious["isGrpAdmin"] as! String
//            print( profVC.isAdmin)
//            profVC.NormalMemberOrAdmin = "ForSelf"
//            profVC.isCategory=isCategory
//            print( profVC.isCategory)
//            let varProfileID = UserDefaults.standard.value(forKey: "session_grpProfileid") as! String
//            print(varProfileID)
//            if(varProfileID==self.grpDetailPrevious["grpProfileid"] as! String)
//            {
//                if(grpDetailPrevious["isGrpAdmin"] as! String == "Yes")
//                {
//                    profVC.isAdmin = grpDetailPrevious["isGrpAdmin"] as! String
//                    profVC.NormalMemberOrAdmin="ForSelf"
//                    
//                }
//                else
//                {
//                    profVC.isAdmin="abcd"
//                    profVC.NormalMemberOrAdmin="ForSelf"
//                }
//            }
//            else
//            {
//                profVC.isAdmin=grpDetailPrevious["isGrpAdmin"] as! String
//                profVC.NormalMemberOrAdmin="ForSelf"
//            }
            // profVC.mainUSerPRofileID = mainMemberID
            self.navigationController?.pushViewController(profVC, animated: true)
        }
        else if (varGetPickerSelectValue == "Settings")
        {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ModuleSettingViewController") as! ModuleSettingViewController
            secondViewController.grpID=self.varGetId
            secondViewController.grpProfileID=self.isGroupProfileID
            secondViewController.moduleId =  moduleId
            self.navigationController?.pushViewController(secondViewController, animated: true)
            
        }
        else if (varGetPickerSelectValue == "My Club")
        {
            let objModuleClubInfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "ModuleClubInfoViewController") as! ModuleClubInfoViewController
            objModuleClubInfoViewController.grpID = self.varGetId
            self.navigationController?.pushViewController(objModuleClubInfoViewController, animated: true)
        }
        else
        {
            buttonOpticity.isHidden = true
            viewForSettingPicker.isHidden = true
        }
        buttonOpticity.isHidden = true
        viewForSettingPicker.isHidden = true
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mainArraySettingForPicker.count;
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        //let countryList = GrpCountryList()
        let varGetCountry:String = mainArraySettingForPicker.object(at: row) as! String
        return varGetCountry
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let varGetCountry:String = mainArraySettingForPicker.object(at: row) as! String
        varGetPickerSelectValue =   varGetCountry
        print(varGetPickerSelectValue)
    }

    func functionForGetZipFilePath()
    {
        var updatedOn =  String ()
        let defaults = UserDefaults.standard
        let UpdatedefaultNew = String(format: "updatedOnDirectory%@",varGetGroupId)
        var  testlet = defaults.value(forKey: UpdatedefaultNew) as! String?
        if let str = defaults.value(forKey: UpdatedefaultNew) as! String?
        {
            updatedOn = str
        }
        else
        {
            updatedOn = "1970-01-01 00:00:00"
        }
        if(updatedOn == "1970-01-01 00:00:00")
            
        {
            //  self.loaderClass.loaderViewMethod()
        }
        var  completeURL:String!=""
        if(isCategory=="2") //DPK
        {
            completeURL = baseUrl+touchBAse_GetDistrictListSync
        }
        else
        {
            completeURL = baseUrl+touchBase_GetMemberListSync
        }
        let parameterst = [
            k_API_DirectoryZipFile : varGetGroupId,
            k_API_updatedOn : updatedOn
        ]
        print(parameterst)
        print(completeURL)
        
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                // self.loaderClass.window = nil
                SVProgressHUD.dismiss()
            }
            else
            {
                let dd = response as! NSDictionary
                UserDefaults.standard.set(dd.object(forKey: "curDate")as! String, forKey: UpdatedefaultNew)
                if(dd.object(forKey: "status") as! String == "0" && dd.object(forKey: "zipFilePath") as! String != "")
                {
                }
                else
                {
                    if(dd.object(forKey: "status") as! String == "1")
                    {
                        self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                        SVProgressHUD.dismiss()
                    }
                    else
                    {
                        if(dd.object(forKey: "status") as! String == "2")
                        {
                        }
                        else
                        {
                            let UpdateMemberListjsonResult: NSDictionary = NSDictionary()
                            print("Response of GetMemberListSync after family member updation..")
                            print(dd)
                            let varGetNewMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")
                            let varGetUpdatedMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")
                            let varGetDeleteMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "DeletedMemberList") as! String
                            if(varGetDeleteMemberList.characters.count>0)
                            {
                                self.functionForDeleteMembers([varGetDeleteMemberList])
                            }
                            if((varGetNewMemberList! as AnyObject).count>0)
                            {
                                self.functionForNewMemberWhenDataComingNotZipFile(dd)
                            }
                            if((varGetUpdatedMemberList! as AnyObject).count>0)
                            {
                                self.functionForUpdateMemberWhenDataComingNotZipFile(dd)
                            }
                        }
                    }
                }
            }
            SVProgressHUD.dismiss()
        })
    }
    /*∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞*/
    func functionForNewMemberWhenDataComingNotZipFile(_ dd:NSDictionary)
    {
        var dictNewMemberListjsonResult:NSDictionary=NSDictionary()
        dictNewMemberListjsonResult=dd
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            
        }
        else
        {
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            
        }
        let moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
        let GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            ((dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).count
            
            // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.count)
            for i in 0 ..< ((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).count
            {
                
                let dictMain=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                
                let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
                
                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
                let memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
                let memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
                
                
                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
                let insertSQL = "INSERT INTO ProfileMaster (masterId,grpId,profileId,isAdmin,memberName,memberEmail,memberMobile,memberCountry,profilePic,familyPic,isPersonalDetVisible,isBussinessDetVisible,isFamilyDetVisible) VALUES('"+masterID+"','"+grpID+"','"+profileID+"','"+isAdmin+"','"+memberNames+"','"+memberEmail+"','"+memberMobile+"','"+memberCountry+"','"+profilePic+"','"+familyPic+"','"+isPersonalDetVisible+"','"+isBusinDetVisible+"','"+isFamilDetailVisible+"')"
                print("INSERTING NEW MEMBER")
                print(insertSQL)
                let result = contactDB?.executeStatements(insertSQL)
                print("Result after inserting new members \(result)")
                if (result == nil)
                {
                    
                }
                else
                {
                    
                    var dictTemporaryDictionary:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                    for j in 0 ..< (dictTemporaryDictionary.object(forKey: "personalMemberDetails")! as AnyObject).count
                        
                    {
                        var dictTemporaryDictionaryNew:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                        let dictChild=(dictTemporaryDictionaryNew.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
                        //print(dictChild)
                        let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                        let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                        let key=(dictChild as AnyObject).object(forKey: "key")as! String
                        let value=(dictChild as AnyObject).object(forKey: "value")as! String
                        let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                        let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                        let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                        let childSQLl = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','personal','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                        // print(childSQLl)
                        let result = contactDB?.executeStatements(childSQLl)
                        if (result == nil)
                        {
                            //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                        }
                        else
                        {
                        }
                    }
                    //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                    var dictTemporaryDictionary2:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                    
                    for j in 0 ..< (dictTemporaryDictionary2.object(forKey: "businessMemberDetails")! as AnyObject).count
                    {
                        var dictTemporaryDictionary3:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                        let dictChild=(dictTemporaryDictionary3.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
                        let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                        let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                        let key=(dictChild as AnyObject).object(forKey: "key")as! String
                        let value=(dictChild as AnyObject).object(forKey: "value")as! String
                        let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                        let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                        let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                        
                        let childSQLNewww = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','Business','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                        
                        //print(childSQLNewww)
                        let result = contactDB?.executeStatements(childSQLNewww)
                        if (result == nil)
                        {
                            //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                        }
                        else
                        {
                            
                        }
                    }
                    //3. familyMemberDetails
                    var dictTemporaryDictionary5:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                    
                    print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
                    print(((dictTemporaryDictionary5.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject))
                    print("################################################")
                    for k in 0 ..< ((dictTemporaryDictionary5.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                    {
                        
                        var dictTemporaryDictionary6:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                        
                        let dictChild=((dictTemporaryDictionary6.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)
                        var dictTemporaryDictionary8:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                        
                        let isVisible=(dictTemporaryDictionary8.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
                        let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
                        let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
                        let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
                        let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
                        let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
                        let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
                        let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
                        let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
                        let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
                                                
                        let familyMemberDetails = "INSERT INTO FamilyMemberDetail (profileId,isVisible,familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,particulars,bloodGroup,masterId) VALUES("+profileID+",'"+isVisible+"','"+familyMemberId+"','"+memberName+"','"+relationship+"','"+dob+"','"+emailID+"','"+anniversary+"','"+contactNo+"','"+particulars+"','"+bloodGroup+"','"+masterID+"')"
                        let result = contactDB?.executeStatements(familyMemberDetails)
                        if (result == nil)
                        {
                        }
                        else
                        {
                        }
                    }
                    //4.  AddressDetails
                    var dictTemporaryDictionary11:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                    
                    for l in 0 ..< ((dictTemporaryDictionary11.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
                    {
                        var dictTemporaryDictionary12:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                        let dictChild=((dictTemporaryDictionary12.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
                        
                        
                        var dictTemporaryDictionary13:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                        let isBusinessAddrVisible=(dictTemporaryDictionary13.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
                        
                        var dictTemporaryDictionary14:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                        let isResidanceAddrVisible=(dictTemporaryDictionary14.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
                        let address=(dictChild as AnyObject).object(forKey: "address")as! String
                        let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
                        let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
                        let city=(dictChild as AnyObject).object(forKey: "city")as! String
                        var country=(dictChild as AnyObject).object(forKey: "country")as! String
                        let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
                        let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
                        let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
                        //print(pincode)
                        
                        let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
                        
                        let state=(dictChild as AnyObject).object(forKey: "state")as! String
                        print("this is country from rajendra side 123123123")
                        print(country)
                        if(country.characters.count>2)
                        {
                            
                        }
                        else
                        {
                            country="India"
                        }
                        
                        let familyMemberDetails = "INSERT INTO AddressDetails (profileId,AddressprofileId,addressID,addressType,address,city,state,country,pincode,phoneNo,fax,isBusinessAddrVisible,isResidanceAddrVisible,masterId) VALUES("+profileID+",'"+AddressprofileId+"','"+addressID+"','"+addressType+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+phoneNo+"','"+fax+"','"+isBusinessAddrVisible+"','"+isResidanceAddrVisible+"','"+masterID+"')"
                        
                        let result = contactDB?.executeStatements(familyMemberDetails)
                        if (result == nil)
                        {
                            
                        }
                        else
                        {
                        }
                    }
                }
            }
        }
        else
        {
        }
        fetchData()
        contactDB?.close()
    }
    //MARK:- Zip file code foir Directory
    func functionForUpdateMemberWhenDataComingNotZipFile(_ dd:NSDictionary)
    {
       //var moduleID:String!=""
       // moduleID=varGetValueModuleID
       // print(moduleID)
        print(varGetValueModuleID)
        let GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        var dictNewMemberListjsonResult:NSDictionary=NSDictionary()
        dictNewMemberListjsonResult=dd
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            //print("error opening database")
        }
        else
        {
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
        }
        if (contactDB?.open())!
        {
            for i in 0 ..< ((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).count
            {
                let dictMain=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
                let memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
                let memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
                //familyPic
                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
                
                let insertSQLUpdate = "UPDATE ProfileMaster SET grpId='"+grpID+"' ,isAdmin='"+isAdmin+"',memberName='"+memberNames+"',memberEmail='"+memberEmail+"',memberMobile='"+memberMobile+"',memberCountry='"+memberCountry+"',profilePic='"+profilePic+"',familyPic='"+familyPic+"',isPersonalDetVisible='"+isPersonalDetVisible+"',isBussinessDetVisible='"+isBusinDetVisible+"',isFamilyDetVisible='"+isFamilDetailVisible+"' where masterId="+masterID+" and profileId='"+profileID+"'"
                print("Record \(i) Updating....")
                print("*************************")
                print("Updateing ProfileMaster Table")
                print(insertSQLUpdate)
                let result = contactDB?.executeStatements(insertSQLUpdate)
                if (result == nil)
                {
                    
                }

                let dictTemporaryDictionary17:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                for j in 0 ..< (dictTemporaryDictionary17.object(forKey: "personalMemberDetails")! as AnyObject).count
                {
                    let dictTemporaryDictionary21:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    
                    let dictChild=(dictTemporaryDictionary21.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
                    var value=(dictChild as AnyObject).object(forKey: "value")as! String
                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                    
                    value=(value as NSString).replacingOccurrences(of: "'", with: "`")
                    let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='personal' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and groupId='"+GroupID+"'"
                    print("Updateing PersonalBusinessMemberDetails Table")
                    print(childSQLUpdate)

                    let result = contactDB?.executeStatements(childSQLUpdate)
                    print("Update result of PersonalBusinessMemberDetails \(result?.description)")
                    print("Update result of PersonalBusinessMemberDetails 1 \(result)")
                    
                    if (result == nil)
                    {
                        //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                    }
                    else
                    {
                        
                    }
                }
                //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                let dictTemporaryDictionary19:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                
                for j in 0 ..< (dictTemporaryDictionary19.object(forKey: "businessMemberDetails")! as AnyObject).count
                {
                    
                    let dictTemporaryDictionary231:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    
                    let dictChild=(dictTemporaryDictionary231.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
                    
                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
                    let value=(dictChild as AnyObject).object(forKey: "value")as! String
                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                    let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='Business',masterId='"+masterID+"' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and groupId='"+GroupID+"' "
                    print("Updateing PersonalBusinessMemberDetails-Business Table")
                    print(childSQLUpdate)

                    let result = contactDB?.executeStatements(childSQLUpdate)
                    if (result == nil)
                    {
                    }
                    else
                    {
                        
                    }
                }
                //3. PersonalBusinessMemberDetails
                let dictTemporaryDictionarytre:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                
                let varGetCountFamilyMemberDetail:Int!=((dictTemporaryDictionarytre.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                
                if(varGetCountFamilyMemberDetail>0)
                {
                    let insertSQLDelete = "DELETE FROM  FamilyMemberDetail  where masterId="+masterID+""
                    let result = contactDB?.executeStatements(insertSQLDelete)
                    if (result == nil)
                    {
                        
                    }
                }
                let dictTemporaryDictionarynnneewww:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                
                for k in 0 ..< ((dictTemporaryDictionarynnneewww.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                {
                    
                    let dictTemporaryDictionarytttttt:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    
                    let dictChild=((dictTemporaryDictionarytttttt.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)
                    let dictTemporaryDictionaryttttttrde:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    let isVisible=(dictTemporaryDictionaryttttttrde.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
                    
                    let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
                    let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
                    let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
                    let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
                    let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
                    let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
                    let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
                    let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
                    let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
                    let familyMemberDetailsUpdate = "INSERT INTO FamilyMemberDetail (profileId,isVisible,familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,particulars,bloodGroup,masterId) VALUES("+profileID+",'"+isVisible+"','"+familyMemberId+"','"+memberName+"','"+relationship+"','"+dob+"','"+emailID+"','"+anniversary+"','"+contactNo+"','"+particulars+"','"+bloodGroup+"','"+masterID+"')"
                    print("Updateing FamilyMemberDetail Table")
                    print(familyMemberDetailsUpdate)
                    let resultinserts = contactDB?.executeStatements(familyMemberDetailsUpdate)
                    if (resultinserts == nil)
                    {
                        
                    }
                    else
                    {
                        
                    }
                }
                //4.  AddressDetails
                let dictTemporaryDictionarybbrreee:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                
                for l in 0 ..< ((dictTemporaryDictionarybbrreee.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
                {
                    let dictTemporaryDictionaryvgtr:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    
                    
                    let dictChild=((dictTemporaryDictionaryvgtr.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
                    
                    
                    let dictTemporaryDictionaryvgtrzxczx:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    let isBusinessAddrVisible=(dictTemporaryDictionaryvgtrzxczx.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
                    
                    let dictTemporaryDictionaryvgtrxcvxcv:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    let isResidanceAddrVisible=(dictTemporaryDictionaryvgtrxcvxcv.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
                    
                    let address=(dictChild as AnyObject).object(forKey: "address")as! String
                    let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
                    let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
                    let city=(dictChild as AnyObject).object(forKey: "city")as! String
                    var country=(dictChild as AnyObject).object(forKey: "country")as! String
                    let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
                    let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
                    let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
                    let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
                    let state=(dictChild as AnyObject).object(forKey: "state")as! String
                    
                    let insertSQLDelete = "DELETE FROM  AddressDetails  where addressID='"+addressID+"' "
                    let resultt = contactDB?.executeStatements(insertSQLDelete)
                    if (resultt == nil)
                    {
                        
                    }
                    print("this is country from rajendra side 9898989")
                    print(country)
                    if(country.characters.count>2)
                    {
                        
                    }
                    else
                    {
                        country="India"
                    }
                    // print(dictChild)
                    let familyMemberDetails = "INSERT INTO AddressDetails (profileId,AddressprofileId,addressID,addressType,address,city,state,country,pincode,phoneNo,fax,isBusinessAddrVisible,isResidanceAddrVisible,masterId) VALUES("+profileID+",'"+AddressprofileId+"','"+addressID+"','"+addressType+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+phoneNo+"','"+fax+"','"+isBusinessAddrVisible+"','"+isResidanceAddrVisible+"','"+masterID+"')"
                    
                    print("Updateing AddressDetails Table")
                    print(familyMemberDetails)

                    let result = contactDB?.executeStatements(familyMemberDetails)
                    if (result == nil)
                    {
                        
                    }
                    else
                    {
                    }
                }
                print("Record \(i) Update Successfully")
            }
            
            
            print("***********UPDATE MEMBER SUCCESSFULLY**************")
            
        }
        else
        {
            
        }
        contactDB?.close()
    }
    
    //MARK:- This method is use for testing purpose
    func functionForFetchOtherDetailsFromPersonalBusinessTables()
        {
            var databasePath : String
            let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documents.appendingPathComponent("NewTouchbase.db")
            // open database
            databasePath = fileURL.path
            let contactDB = FMDatabase(path: databasePath as String)
            
            if (contactDB?.open())!
            {
                let querySQLPersonalBusinessMemberDetails = "SELECT DISTINCT uniquekey,value,PersonalORBusiness from PersonalBusinessMemberDetails where  profileId='354379'"
                let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
                
                //1.
                while resultsPersonalBusinessMemberDetails?.next() == true
                {
                    var letGetKey:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "uniquekey")
                    
                    let letGetValue:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "value")
                    
                    let letGetPersonalORBusiness:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "PersonalORBusiness")
                    
                    let letGetValues = letGetValue.trimmingCharacters(in: CharacterSet.whitespaces)
                    print("*******REcord after update***********")
                    if(letGetKey=="member_name")
                        
                    {
                        print("Member name \(letGetValue)")
                    }
                        
                    else if(letGetKey=="member_mobile_no")
                    {
                        print("MEmber mobile no \(letGetValue)")
                    }
                        
                    else if(letGetKey=="secondry_mobile_no")
                    {
                     print("Value of secondary mobile no is \(letGetValue)")
                    }
                        
                    else if(letGetKey=="member_email_id")
                    {
                    print("Member email ID is \(letGetValue)")
                    }
                }
            }
    }
        
    
    //3. Delete member««««««««««««««««««««-----»»»»»»»»»»»»»»»»»»»»»
    func functionForDeleteMembers(_ muaarayDeleteMemberListjsonResult:[String])
    {
        // print(muaarayDeleteMemberListjsonResult)
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            //print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            //print("Error: \(contactDB.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            contactDB?.beginTransaction()
            print("-------------Deleted---Queries----------------")
            for i in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let insertSQLDelete = "DELETE FROM  ProfileMaster  where profileId in ("+muaarayDeleteMemberListjsonResult[i]+")"
                print(insertSQLDelete)
                let result = contactDB?.executeStatements(insertSQLDelete)
                if (result == nil)
                {
                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
            }
            //1......if master table entry inserted then need to data in PersonalBusinessMemberDetails
            for j in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let childSQLDelete = "DELETE FROM PersonalBusinessMemberDetails where profileId in ("+muaarayDeleteMemberListjsonResult[j]+") and PersonalORBusiness='personal'"
                  print(childSQLDelete)
                let result = contactDB?.executeStatements(childSQLDelete)
                if (result == nil)
                {
                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    
                }
            }
            //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
            for j in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let childSQLDelete = "DELETE FROM  PersonalBusinessMemberDetails where profileId in ("+muaarayDeleteMemberListjsonResult[j]+") and PersonalORBusiness='Business'"
                print(childSQLDelete)
                let result = contactDB?.executeStatements(childSQLDelete)
                if (result == nil)
                {
                }
                else
                {
                }
            }
            //3. PersonalBusinessMemberDetails
            for k in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let familyMemberDetailsDelete = "DELETE FROM  FamilyMemberDetail  where profileId in ("+muaarayDeleteMemberListjsonResult[k]+")"
                print(familyMemberDetailsDelete)
                let result = contactDB?.executeStatements(familyMemberDetailsDelete)
                if (result == nil)
                {
                }
                else
                {
                }
            }
            //4.  AddressDetails
            for l in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let addressDetailDelete = "DELETE FROM  AddressDetails  where profileId in ("+muaarayDeleteMemberListjsonResult[l]+")"
                print(addressDetailDelete)
                let result = contactDB?.executeStatements(addressDetailDelete)
                if (result == nil)
                {
                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                }
            }
        }
        else
        {
        }
        contactDB?.commit()
        contactDB?.close()
    }
}
