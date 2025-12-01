//
//  FinddArotarianViewController.swift
//  TouchBase
//
//  Created by deepak on 20/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import MBProgressHUD

class FinddArotarianViewController: UIViewController , UITextFieldDelegate
{
    var appDelegate : AppDelegate = AppDelegate()
    
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    
    
    @IBOutlet weak var lblTextShow: UILabel!
    
    
    
    @IBOutlet weak var buttonSearch: UIButton!
    
    var muarrayGetRotairanDetails:NSArray=NSArray()
    @IBOutlet weak var buttonOpacity: UIButton!
    var moduleName:String! = ""
    var varGroupId:String! = ""
    var varModuleId:String! = ""
    var isAdmin:String! = ""
    var muarrayFindARotarianList:NSMutableArray=NSMutableArray()
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var textfieldClassificationKeyword: UITextField!
    @IBOutlet weak var textfieldCityClub: UITextField!
    @IBOutlet weak var textfieldDistrictNumber: UITextField!
    
    @IBOutlet weak var textfieldMobilenumber: UITextField!
    
    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
    var loadingNotification:MBProgressHUD = MBProgressHUD()
    
    func showMBProgress(str:String)
    {
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.color = .clear
        loadingNotification.dimBackground=true
        loadingNotification.activityIndicatorColor = .gray
        //loadingNotification.labelText=str

        loadingNotification.show(true)
    }

    func hideMBProgress()
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        buttonSearch.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        functionForSetLeftNavigation()
        textfieldName.autocorrectionType = .no
        textfieldClassificationKeyword.autocorrectionType = .no
        textfieldCityClub.autocorrectionType = .no
        textfieldDistrictNumber.autocorrectionType = .no
        textfieldMobilenumber.autocorrectionType = .no
        buttonOpacity.isHidden=true
        lblTextShow.textColor = UIColor.lightGray
        textfieldName.delegate = self
        textfieldClassificationKeyword.delegate = self
        textfieldCityClub.delegate = self
        textfieldDistrictNumber.delegate = self
        //textfieldName.functionForSetTextFieldBottomBorder()
       // textfieldClassificationKeyword.functionForSetTextFieldBottomBorder()
        //textfieldCityClub.functionForSetTextFieldBottomBorder()
        //textfieldDistrictNumber.functionForSetTextFieldBottomBorder()
        //textfieldMobilenumber.functionForSetTextFieldBottomBorder()
        
        
        // self.edgesForExtendedLayout = []
    }
    
//    func addDoneButtonOnKeyboard()
//    {
//        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
//        doneToolbar.barStyle = UIBarStyle.default
//
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(MobileLoginController.doneButtonAction))
//
//        var items: [UIBarButtonItem]? = [UIBarButtonItem]()
//        items?.append(flexSpace)
//        items?.append(done)
//
//
//        doneToolbar.setItems(items, animated: true)
//        doneToolbar.sizeToFit()
//        textfieldDistrictNumber.inputAccessoryView=doneToolbar
//    }
    func doneButtonAction()
    {
        textfieldDistrictNumber.resignFirstResponder()
        textfieldMobilenumber.resignFirstResponder()
    }
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
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
        self.navigationController?.navigationBar.barTintColor = UIColor.white // (red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(FinddArotarianViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- keyboard
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
    }
//    func animateViewMoving (_ up:Bool, moveValue :CGFloat)
//    {
//        let movementDuration:TimeInterval = 0.3
//        let movement:CGFloat = ( up ? -moveValue : moveValue)
//        UIView.beginAnimations( "animateView", context: nil)
//        UIView.setAnimationBeginsFromCurrentState(true)
//        UIView.setAnimationDuration(movementDuration )
//        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
//        UIView.commitAnimations()
//    }
    //MARK:- Button Click Event
    @IBAction func buttonSearchClickEvent(_ sender: AnyObject)
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if(textfieldName.text! == "" && textfieldClassificationKeyword.text! == "" && textfieldCityClub.text! == "" && textfieldDistrictNumber.text! == "" && textfieldMobilenumber.text! == "")
            {
                self.view.makeToast("Please Fill Atleast One Search Criteria", duration: 3, position:CSToastPositionCenter)
                
            }

            else
            {
                functionForSearchFindAclub()
            }
        }
        else
        
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)

        }

        
        
        
    }
    
    @IBAction func buttonOpacityClickEvent(_ sender: AnyObject)
    {
        buttonOpacity.isHidden=true
    }
    
    
    /*--------------------------------------------------------------------------------------------------------*/
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
    
    //MARK:- Calling web api
    func functionForSearchFindAclub()
    {
        //  loaderViewMethod()
        let varGetName:String=textfieldName.text!
        let varGetClassificationKeyword:String=textfieldClassificationKeyword.text!
        let varGetCityClub:String=textfieldCityClub.text!
        let varGetDistrictNumber:String=textfieldDistrictNumber.text!
        let varGetMobileNumber:String=textfieldMobilenumber.text!
        //deepak please change parameter value and url should be dynamic  by rajendra jat code
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            let completeURL = baseUrl+touchBase_FindRotarianGetRotarianList
            let parameterst = [
                "name" : varGetName,
                "classification" : varGetClassificationKeyword,
                "club" : varGetCityClub,
                "district_number": varGetDistrictNumber,
                "memberMobile":varGetMobileNumber
            ]
            print(parameterst)
            print(completeURL)
            self.showMBProgress(str: "")
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
                let dd = response as! NSDictionary
                var varGetValueServerError = response.object(forKey: "serverError")as? String
                if(varGetValueServerError == "Error")
                {
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                    self.hideMBProgress()
                }
                else
                {
                if((dd.object(forKey: "TBGetRotarianResult")! as AnyObject).object(forKey: "status") as! String == "0")
                {
                    self.muarrayFindARotarianList=NSMutableArray()
                        self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                        
                    self.muarrayGetRotairanDetails = (dd.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "RotarianResult") as! NSArray

                    if(self.muarrayGetRotairanDetails.count>0)
                    {
                    self.DeleteDataInlocal()
                    self.SaveDataInlocal(self.muarrayGetRotairanDetails)
                    }
                    
                    
                    if(self.muarrayGetRotairanDetails.count>0)
                    {
                        
                        let objSearchFindArotarianViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchFindArotarianViewController") as! SearchFindArotarianViewController
                        
                        objSearchFindArotarianViewController.varGroupId = self.varGroupId
                        objSearchFindArotarianViewController.isAdmin = self.isAdmin
                        objSearchFindArotarianViewController.varModuleId = self.varModuleId
                        objSearchFindArotarianViewController.moduleName = self.moduleName
                        //objSearchFindArotarianViewController.muarrayFindARotarianList = self.muarrayFindARotarianList
                        
                        self.navigationController?.pushViewController(objSearchFindArotarianViewController, animated: true)
                        self.window = nil
                        
                        self.textfieldName.text! = ""
                        self.textfieldCityClub.text! = ""
                        self.textfieldDistrictNumber.text! = ""
                        self.textfieldClassificationKeyword.text! = ""
                        
                    }
                    else
                    {
                        self.view.makeToast("No Results", duration: 3, position:CSToastPositionCenter)
                    }
                    
                    self.window = nil
                }
                else
                {
                    self.window = nil
                    
                }
                    self.window = nil
                    self.hideMBProgress()
                }
            })
        }
        else
        {
           self.window = nil
        }
    }
    
    
    
    //MARK:- Local Data Store
    /*____________________________________________*/
    func SaveDataInlocalTable (_ varmasterUID:String,varclubName:String,vardesignation:String,varmemberMobile:String,varmemberName:String,varpic:String,varprofileID:String){
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
            let moduleID = UserDefaults.standard.string(forKey: "session_GetModuleId")
            let GroupID = UserDefaults.standard.string(forKey: "session_GetGroupId")
           // for i in 0 ..< arrdata.count {
            
                let insertSQL = "INSERT INTO Find_A_Rotarian_List (masterUID , GroupId, moduleId, clubName , designation,memberMobile,memberName,pic,profileID) VALUES ('\(varmasterUID)', '\(GroupID!)', '\(moduleID!)', '\(varclubName)', '\(vardesignation)', '\(varmemberMobile)', '\(varmemberName)', '\(varpic)', '\(varprofileID)')"
               // print(insertSQL)
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("success saved")
                    //print(databasePath);
                }
          //  }
            
        }
            
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        contactDB?.close()
    }

    /*---------------Save / Delete / update / fetch -------------------DPK----------------------------*/
    //Save Data
    func SaveDataInlocal (_ arrdata:NSArray){
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
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            var moduleID = UserDefaults.standard.string(forKey: "session_GetModuleId")
            var GroupID = UserDefaults.standard.string(forKey: "session_GetGroupId")
            for i in 0 ..< arrdata.count {
                var varclubName = (arrdata.object(at: i) as AnyObject).value(forKey: "clubName") as! String
                var vardesignation = (arrdata.object(at: i) as AnyObject).value(forKey: "designation") as! String
                var varmasterUID = (arrdata.object(at: i) as AnyObject).value(forKey: "masterUID") as? String
                var varmemberMobile = (arrdata.object(at: i) as AnyObject).value(forKey: "memberMobile") as! String
                var varpic = (arrdata.object(at: i) as AnyObject).value(forKey: "pic") as! String
                var varprofileID = (arrdata.object(at: i) as AnyObject).value(forKey: "profileID") as! String
                var varmemberName = (arrdata.object(at: i) as AnyObject).value(forKey: "memberName") as! String
                
                if(varmasterUID  == nil)
                {
                    varmasterUID = ""
                }
                if(varclubName as? String  == nil)
                {
                    varclubName = ""
                }
                if(vardesignation as? String == nil)
                {
                    vardesignation = ""
                }
                if(varpic  as? String == nil)
                {
                    varpic = ""
                }
                if(varprofileID as? String == nil)
                {
                    varprofileID = ""
                }
                if(varmemberMobile as? String == nil)
                {
                    varmemberMobile = ""
                }
                if(varmemberName as? String == nil)
                {
                    varmemberName = ""
                }
                else
                {
                }
                
                
                if(moduleID == nil)
                {
                    moduleID = ""
                }
                else
                {
                }
                
                
                if(GroupID  == nil)
                {
                    GroupID = ""
                }
                else
                {
                }
                
                
                

                
                
                print(varmasterUID)
                print(GroupID)
                print(moduleID)
                print(varclubName)
                print(vardesignation)
                print(varmemberMobile)
                print(varmemberName)
                print(varpic)
                print(varprofileID)
                
                
                let insertSQL = "INSERT INTO Find_A_Rotarian_List (masterUID,GroupId,moduleId,clubName,designation,memberMobile,memberName,pic,profileID) VALUES ('\(varmasterUID)', '\(GroupID!)', '\(moduleID!)', '\(varclubName)', '\(vardesignation)', '\(varmemberMobile)', '\(varmemberName)', '\(varpic)', '\(varprofileID)')"
                print(insertSQL)
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("success saved")
                    //print(databasePath);
                }
            }
            
        }
            
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        contactDB?.close()
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
            let insertSQL = "DELETE FROM Find_A_Rotarian_List" // WHERE profileID = '\(dict.objectForKey("serviceDirId") as! String)'
           // print(insertSQL)
            let result = contactDB?.executeStatements(insertSQL)
            if (result == nil) {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            } else {
                print("success saved")
               // print(databasePath);
            }
            // }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        contactDB?.close()
    }
    
//    func doneButtonAction() {
//        self.view.endEditing(true)
//    }
    
    
     
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first
        {
            self.textfieldDistrictNumber.resignFirstResponder()
            self.textfieldName.resignFirstResponder()
            self.textfieldCityClub.resignFirstResponder()
        }
        super.touchesBegan(touches, with:event)
    }
    
    
    
    //keyword
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textfieldName.resignFirstResponder()
        textfieldClassificationKeyword.resignFirstResponder()
        textfieldCityClub.resignFirstResponder()
        textfieldDistrictNumber.resignFirstResponder()
        textfieldMobilenumber.resignFirstResponder()
        return true
    }
}
