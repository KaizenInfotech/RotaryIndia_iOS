//
//  ModuleSettingViewController.swift
//  TouchBase
//
//  Created by rajendra on 24/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class ModuleSettingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var appDelegate : AppDelegate = AppDelegate()
    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
    @IBOutlet weak var tableModuleSetting: UITableView!
    
   
    @IBOutlet weak var lblPhoneNumberInMyClubs: UILabel!
    
    @IBOutlet weak var lblPhoneNumberInAllClubs: UILabel!
    
    @IBOutlet weak var lblEmailAddressInMyClubs: UILabel!
    
    @IBOutlet weak var lblEmailAddressInAllClubs: UILabel!
    
    
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    var grpID:String! = ""
    var grpProfileID:String! = ""
    var moduleId:String!=""
    var moduleName:String!=""
    
    @IBOutlet weak var buttonSwitchForMyClubInDPN: UISwitch!
    @IBOutlet weak var buttonSwitchForAllClubInDPN: UISwitch!
    @IBOutlet weak var buttonSwitchForMyClubDEA: UISwitch!
    @IBOutlet weak var buttonSwitchForAllClubDEA: UISwitch!
    
    var muarrayForModuleSetting:NSMutableArray = NSMutableArray()
    var muarrayForModuleID:NSMutableArray = NSMutableArray()
    var muarrayForModuleName:NSMutableArray = NSMutableArray()
    var muarrayForModuleValue:NSMutableArray = NSMutableArray()
    
    
    var varMyClubDPN:String! = ""
    var varAllClubDPN:String! = ""
    var varMyClubDEA:String! = ""
    var varAllClubDEA:String! = ""
    
    var varSettingChangeORNot:String! = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        createNavigationBar()
        varSettingChangeORNot = ""
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            getSettingDetails(grpID as! NSString, GroupProfileId: grpProfileID as! NSString)
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Function
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        if(moduleName=="")
        {
         self.title = "Settings"
        }
        else
        {
        self.title = moduleName
        }
        
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ModuleSettingViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
       
    }
    
     @objc func backClicked()
    {
        if(varSettingChangeORNot == "Yes")
        {
        let alert = UIAlertController(title: "Settings", message: " Updated successfully.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
        }));
        self.present(alert, animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
  
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSwitchForMyClubInDPN(_ sender: AnyObject)
    {
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if (self.buttonSwitchForMyClubInDPN.isOn == true)
            {
                print("SwitchON")
                lblPhoneNumberInMyClubs.textColor = UIColor.darkGray
                self.UpdateSetting(self.grpID as! NSString, ModuleId: "", GroupProfileId: grpProfileID as! NSString, UpdatedValue: "", showMobileSeflfClub: "1", showMobileOutsideClub: self.varAllClubDPN as! NSString, showEmailSeflfClub: self.varMyClubDEA as! NSString, showEmailOutsideClub: self.varAllClubDEA as! NSString)
                self.varMyClubDPN = "1"
            }
            else
            {
                lblPhoneNumberInMyClubs.textColor = UIColor.lightGray
                print("SwitchOFF")
                self.UpdateSetting(self.grpID as! NSString, ModuleId: "", GroupProfileId: grpProfileID as! NSString, UpdatedValue: "", showMobileSeflfClub: "0", showMobileOutsideClub: self.varAllClubDPN as! NSString, showEmailSeflfClub: self.varMyClubDEA as! NSString, showEmailOutsideClub: self.varAllClubDEA as! NSString)
                self.varMyClubDPN = "0"
            }

        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
            }

    @IBAction func buttonSwitchForAllClubInDPN(_ sender: AnyObject)
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if (self.buttonSwitchForAllClubInDPN.isOn == true)
            {
                lblPhoneNumberInAllClubs.textColor = UIColor.darkGray
        print("SwitchON")
         self.UpdateSetting(self.grpID as! NSString, ModuleId: moduleId as! NSString, GroupProfileId: grpProfileID as! NSString, UpdatedValue: "", showMobileSeflfClub: self.varMyClubDPN as! NSString, showMobileOutsideClub: "1", showEmailSeflfClub: self.varMyClubDEA as! NSString, showEmailOutsideClub: self.varAllClubDEA as! NSString)
        self.varAllClubDPN = "1"
            }
            else
            {
                lblPhoneNumberInAllClubs.textColor = UIColor.lightGray
        print("SwitchOFF")
        self.UpdateSetting(self.grpID as! NSString, ModuleId: moduleId as! NSString, GroupProfileId: grpProfileID as! NSString, UpdatedValue: "", showMobileSeflfClub: self.varMyClubDPN as! NSString, showMobileOutsideClub: "0", showEmailSeflfClub: self.varMyClubDEA as! NSString, showEmailOutsideClub: self.varAllClubDEA as! NSString)
        self.varAllClubDPN = "0"
            }
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
    }
    
    @IBAction func buttonSwitchForMyClubDEA(_ sender: AnyObject)
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
  
        if (self.buttonSwitchForMyClubDEA.isOn == true)
        {
            lblEmailAddressInMyClubs.textColor = UIColor.darkGray
            print("SwitchON")
            
          self.UpdateSetting(self.grpID as! NSString, ModuleId: moduleId as! NSString, GroupProfileId: grpProfileID as! NSString, UpdatedValue: "", showMobileSeflfClub: self.varMyClubDPN as! NSString, showMobileOutsideClub: self.varAllClubDPN as! NSString, showEmailSeflfClub: "1", showEmailOutsideClub: self.varAllClubDEA as! NSString)
            self.varMyClubDEA = "1"
        }
        else
        {
            lblEmailAddressInMyClubs.textColor = UIColor.lightGray
            print("SwitchOFF")
            self.UpdateSetting(self.grpID as! NSString, ModuleId: moduleId as! NSString, GroupProfileId: grpProfileID as! NSString, UpdatedValue: "", showMobileSeflfClub: self.varMyClubDPN as! NSString, showMobileOutsideClub: self.varAllClubDPN as! NSString, showEmailSeflfClub: "0", showEmailOutsideClub: self.varAllClubDEA as! NSString)
        self.varMyClubDEA = "0"
        }
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
    }
    @IBAction func buttonSwitchForAllClubDEA(_ sender: AnyObject)
    {
        
    appDelegate = UIApplication.shared.delegate as! AppDelegate
     if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
    {
        if (self.buttonSwitchForAllClubDEA.isOn == true)
        {
            lblEmailAddressInAllClubs.textColor = UIColor.darkGray
            print("SwitchON")
            self.UpdateSetting(self.grpID as! NSString, ModuleId: moduleId as! NSString, GroupProfileId: grpProfileID as! NSString, UpdatedValue: "", showMobileSeflfClub: "1", showMobileOutsideClub: self.varAllClubDPN as! NSString, showEmailSeflfClub: self.varMyClubDEA as! NSString, showEmailOutsideClub: "1")
            self.varAllClubDEA = "1"
        }
        else
        {
            lblEmailAddressInAllClubs.textColor = UIColor.lightGray
            print("SwitchOFF")
            self.UpdateSetting(self.grpID as! NSString, ModuleId: moduleId as! NSString, GroupProfileId: grpProfileID as! NSString, UpdatedValue: "", showMobileSeflfClub: self.varMyClubDPN as! NSString, showMobileOutsideClub: self.varAllClubDPN as! NSString, showEmailSeflfClub: self.varMyClubDEA as! NSString, showEmailOutsideClub: "0")
            self.varAllClubDEA = "0"
        }
    }
    else
    {
         SVProgressHUD.dismiss()
    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
    }
    }



    //MARK:- Server Calling
    func getSettingDetails(_ GroupId:NSString,GroupProfileId:NSString)
    {
      //  loaderViewMethod()
        let completeURL:String! = baseUrl+row_GetSettingDetails
        let parameterst = ["GroupId":GroupId,"GroupProfileId":GroupProfileId]
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
            if((dd.object(forKey: "TBGroupSettingResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let isMobileSelf =    (dd.object(forKey: "TBGroupSettingResult")! as AnyObject).object(forKey: "isMobileSelf") as! String
                let isMobileOther =   (dd.object(forKey: "TBGroupSettingResult")! as AnyObject).object(forKey: "isMobileOther") as! String
                let isEmailSelf =     (dd.object(forKey: "TBGroupSettingResult")! as AnyObject).object(forKey: "isEmailSelf") as! String
                let isEmailOther =    (dd.object(forKey: "TBGroupSettingResult")! as AnyObject).object(forKey: "isEmailOther") as! String
               
                if(isMobileSelf == "1")
                {
                  self.buttonSwitchForMyClubInDPN.isOn = true
                    self.varMyClubDPN = "1"
                }
                else
                {
                   self.buttonSwitchForMyClubInDPN.isOn = false
                    self.varMyClubDPN = "0"
                }
                if(isMobileOther == "1")
                {
                   self.buttonSwitchForAllClubInDPN.isOn = true
                    self.varAllClubDPN = "1"
                }
                else
                {
                   self.buttonSwitchForAllClubInDPN.isOn = false
                    self.varAllClubDPN = "0"
                }
                if(isEmailSelf == "1")
                {
                   self.buttonSwitchForMyClubDEA.isOn = true
                    self.varMyClubDEA = "1"
                }
                else
                {
                  self.buttonSwitchForMyClubDEA.isOn = false
                self.varMyClubDEA = "0"
                }
                if(isEmailOther == "1")
                {
                   self.buttonSwitchForAllClubDEA.isOn = true
                    self.varAllClubDEA = "1"
                }
                else
                {
                   self.buttonSwitchForAllClubDEA.isOn = false
                    self.varAllClubDEA = "0"
                }
                 print(isMobileSelf)
                 print(isMobileOther)
                 print(isEmailSelf)
                 print(isEmailOther)
              
                for i in 0..<(((dd.object(forKey: "TBGroupSettingResult")! as AnyObject).object(forKey: "GRpSettingResult")! as AnyObject).count)
                {
                    self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                    
                    
                    
                     var dictTemporaryDictionary:NSDictionary=((dd.object(forKey: "TBGroupSettingResult")! as AnyObject).object(forKey: "GRpSettingResult")! as AnyObject).object(at: i)
                    
                    
                    let varGetSettingModuleID = (dictTemporaryDictionary.object(forKey: "GRpSettingDetails")! as AnyObject).object(forKey: "moduleId")
                    print(varGetSettingModuleID!)
                    let varGetModValue = (dictTemporaryDictionary.object(forKey: "GRpSettingDetails")! as AnyObject).object(forKey: "modVal")
                    print(varGetModValue!)
                    let varGetModName = (dictTemporaryDictionary.object(forKey: "GRpSettingDetails")! as AnyObject).object(forKey: "modName")
                    print(varGetModName!)
                    self.commonClassHoldDataAccessibleVariable.varGetSettingModuleID = varGetSettingModuleID as! String;
                    self.commonClassHoldDataAccessibleVariable.varGetModValue = varGetModValue as! String;
                    self.commonClassHoldDataAccessibleVariable.varGetModName = varGetModName as! String;
                    self.muarrayForModuleSetting.add(self.commonClassHoldDataAccessibleVariable)
                    
                    self.muarrayForModuleID.add(varGetSettingModuleID as! String)
                    self.muarrayForModuleName.add(varGetModName as! String)
                    self.muarrayForModuleValue.add(varGetModValue as! String)
                    
                    [self.tableModuleSetting .reloadData()];
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
    
    
    
    
   ///Setting/GroupSetting
    func UpdateSetting(_ GroupId:NSString,ModuleId:NSString,GroupProfileId:NSString,UpdatedValue:NSString,showMobileSeflfClub:NSString,showMobileOutsideClub:NSString,showEmailSeflfClub:NSString,showEmailOutsideClub:NSString)
    {
       // loaderViewMethod()
        let completeURL:String! = baseUrl+row_UpdateSetting
        let parameterst = ["GroupId":GroupId,"ModuleId":ModuleId,"GroupProfileId":GroupProfileId,"UpdatedValue":UpdatedValue, "showMobileSeflfClub":showMobileSeflfClub,"showMobileOutsideClub":showMobileOutsideClub,"showEmailSeflfClub":showEmailSeflfClub,"showEmailOutsideClub":showEmailOutsideClub]
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
            if((dd.object(forKey: "TBGroupSettingResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
//                self.muarrayForModuleSetting.removeAllObjects()
//                self.getSettingDetails(self.grpID, GroupProfileId: self.grpProfileID)
//                self.tableModuleSetting.reloadData()
                self.varSettingChangeORNot = "Yes"
              print("success")
                
            }
            else
            {
               print("Failed") 
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

    
    //MARK:- Table Methods
    //MARK:- Table Methods
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayForModuleSetting.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableModuleSetting.dequeueReusableCell(withIdentifier: "customModuleSettingCell", for: indexPath) as! customModuleSettingCell
        
        
        let varModValue = muarrayForModuleValue.object(at: indexPath.row)
        let moduleName = muarrayForModuleName.object(at: indexPath.row)
        let moduleID = muarrayForModuleID.object(at: indexPath.row)
        
//        var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
//        objCommonHoldDataVariable = muarrayForModuleSetting.objectAtIndex(indexPath.row) as! CommonAccessibleHoldVariable;
//        let varGetModName=objCommonHoldDataVariable.varGetModName
//        let varGetModValue=objCommonHoldDataVariable.varGetModValue
//        let varGetSettingModuleID=objCommonHoldDataVariable.varGetSettingModuleID
         cell.lableModuleName.text! = moduleName as! String
        if(varModValue as! String=="1")
        {
          cell.buttonSwitchOnOff.isOn = true
          print("ON")
             cell.lableModuleName.textColor = UIColor.darkGray
            
        }
        else
        {
          cell.buttonSwitchOnOff.isOn = false
            print("Off")
            cell.lableModuleName.textColor = UIColor.lightGray

        }
        cell.buttonSwitchOnOff.addTarget(self, action: #selector(ModuleSettingViewController.buttonMainClickedEvent(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonSwitchOnOff.tag=indexPath.row;
        
     
        return cell
    }
   
    
    /*-------------------------------------------function for remove cell row-------------------Start---------*/
    @objc func buttonMainClickedEvent(_ sender:UIButton)
    {
        print(sender.tag)
//        commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
//        commonClassHoldDataAccessibleVariable = muarrayForModuleSetting.objectAtIndex(sender.tag) as! CommonAccessibleHoldVariable
//        let varGetModName=commonClassHoldDataAccessibleVariable.varGetModName
//        var varGetModValue=commonClassHoldDataAccessibleVariable.varGetModValue
//        let varGetSettingModuleID=commonClassHoldDataAccessibleVariable.varGetSettingModuleID
//        
        
        var varModValue = muarrayForModuleValue.object(at: sender.tag) as! String
        let moduleName = muarrayForModuleName.object(at: sender.tag)
        let moduleID = muarrayForModuleID.object(at: sender.tag) as! String
        
        print("55555555555555555",varModValue)
        if(varModValue == "1")
        {
            varModValue = "0"
            print("66666666666666666",varModValue)
        }
        else
        {
          varModValue = "1"
            print("777777777777777777",varModValue)
        }
        
        muarrayForModuleValue.replaceObject(at: sender.tag, with: varModValue)
        self.tableModuleSetting.reloadData()
        self.UpdateSetting(self.grpID as! NSString, ModuleId: moduleID as NSString, GroupProfileId: grpProfileID as! NSString, UpdatedValue: varModValue as NSString, showMobileSeflfClub: self.varMyClubDPN as! NSString, showMobileOutsideClub: self.varAllClubDPN as! NSString, showEmailSeflfClub: self.varMyClubDEA as! NSString, showEmailOutsideClub: self.varAllClubDEA as! NSString)
        
        
    
        
    }

    
    
}
