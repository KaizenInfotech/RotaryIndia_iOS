//
//  ProfileViewController.swift
//  TouchBase
//
//  Created by Kaizan on 17/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
import MessageUI
import SVProgressHUD
class ProfileViewController: UIViewController , UITableViewDataSource,UITableViewDelegate , webServiceDelegate , MFMailComposeViewControllerDelegate , MFMessageComposeViewControllerDelegate , addrscellDelegate , uploadDocDelegate , UIImagePickerControllerDelegate,
UINavigationControllerDelegate , UIActionSheetDelegate,familycellDelegate{
    
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    let bounds = UIScreen.main.bounds
    var userGroupID:NSString!
    var userProfileID:NSString!
    var mainArray = NSArray()
    var appDelegate : AppDelegate = AppDelegate()
    var varIsAddButtonHideonFamily:Int=0
    var isShowBusiness : String = ""
    var isShowFamily : String = ""
    var isShowPersonal : String = ""
   // var appDelegate : AppDelegate!
    
    var PhoneNumberSTR  : String = ""
    var EmailSTR  : String =  ""

    var imagePicker = UIImagePickerController()
    
    var titlesArray = NSArray()
    var personalDetailsArray : NSMutableArray!
    var businessDetailArray = NSArray()
    var AddressDetailArray = NSArray()
    
    var FamArray = NSArray()
    
    var PersonalButton = UIButton()
    var BussinessButton = UIButton()
    var FamilyButton = UIButton()
    var AddFamilyMemberButton = UIButton()
    
    var conditionString : String = ""
    var memberDetailRs:MemberListDetail!
    var chosenImage = UIImage()
    var isAdmin:NSString!
    var isDeleted:NSString!
    var mainUSerPRofileID:NSString!
    var isCalled:NSString!
    @IBOutlet var ProfileTableView: UITableView!
    var showadminProf:NSString?
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate

    }
    override func viewWillAppear(_ animated: Bool) {
        
        ProfileTableView.setContentOffset(CGPoint.zero, animated:true)
        self.ProfileTableView.contentOffset = CGPoint(x: 0, y: 0 - self.ProfileTableView.contentInset.top)
        
        super.viewWillAppear(true)
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
        let defaults = UserDefaults.standard
        let country =  defaults.object(forKey: "picadded") as? String
        print("picadded \(country)")
        if(country != "yes"){
            personalDetailsArray=NSMutableArray()
            ProfileTableView.estimatedRowHeight = 70.0
            ProfileTableView.rowHeight = UITableView.automaticDimension
            
            appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            mainArray = NSArray()
            self.imagePicker.delegate = self
            conditionString = "personal"
            
            FamArray = NSMutableArray()
            chosenImage = UIImage()
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=nil
            wsm.delegates=self
          
            
         
             if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
            {
                wsm.getMemberDetail(userProfileID, grpID: userGroupID)
                
                //  ProfileTableView.reloadData()
                ProfileTableView.tableFooterView = UIView(frame: CGRect.zero)
                PersonalButton.isEnabled = false
                
            }
            else
            {
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
          
             SVProgressHUD.dismiss()
            
            }
            

            
            
            
        }
       
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        if(showadminProf == "admin"){
            self.title="Admin"
        }else{
            self.title="Profile"
        }
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ProfileViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        let buttonlog = UIButton(type: UIButton.ButtonType.custom)
        buttonlog.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        buttonlog.titleLabel?.textAlignment = NSTextAlignment.right
        buttonlog.titleLabel?.font = UIFont(name: "Open Sans", size: 14)
        buttonlog.setImage(UIImage(named: "edit_Blue"),  for: UIControl.State.normal)
        buttonlog.addTarget(self, action: #selector(editClicked), for: UIControl.Event.touchUpInside)
        // let skipButton : UIBarButtonItem = UIBarButtonItem(customView: buttonlog)
        //self.navigationItem.rightBarButtonItem = skipButton
        let trashB = UIButton(type: UIButton.ButtonType.custom)
        trashB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        trashB.setImage(UIImage(named:"Delete_blue"),  for: UIControl.State.normal)
        trashB.addTarget(self, action: #selector(EventsDetailController.deleteEbullAction), for: UIControl.Event.touchUpInside)
        let trash: UIBarButtonItem = UIBarButtonItem(customView: trashB)
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if(isAdmin != "No"){
            // if(mainUSerPRofileID != memberDet.profileID){
            let buttons : NSArray = [trash]
            
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            //}
        }
    }
    func deleteEbullAction()
    {
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
       //my code
            var profileid:NSString!=memberDetailRs.profileID as! NSString
        
 
        
        
            print("userProfileID \(userProfileID)")
            if( mainUSerPRofileID != profileid){
                isDeleted="member"
                let alert=UIAlertController(title: "Confirm", message:"Are you sure, you want to delete this member?", preferredStyle: UIAlertController.Style.alert);
                
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil));
                //event handler with closure
                alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
                    let wsm : WebserviceClass = WebserviceClass.sharedInstance
                    wsm.delegates=nil
                    wsm.delegates=self
                    wsm.deleteDataWebservice(self.userProfileID as String, type: "Member", profileID:self.userProfileID as String)
                }));
                
                self.present(alert, animated: true, completion: nil);
                
            }else{
            
            let alert=UIAlertController(title: "", message:"You are the Admin, you cannot delete yourself.", preferredStyle: UIAlertController.Style.alert);
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil));
            //event handler with closure
            self.present(alert, animated: true, completion: nil);
        }
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
      
         SVProgressHUD.dismiss()
        }
    }
    
    func deleteSucc(_ docListing : DeleteResult){
        
        if docListing.status == "0"
        {
            if(isDeleted == "member"){
                self.navigationController?.popViewController(animated: true)
            }else{
                personalDetailsArray=NSMutableArray()
                mainArray = NSArray()
                FamArray = NSMutableArray()
                chosenImage = UIImage()
                businessDetailArray=NSMutableArray()
                AddressDetailArray=NSMutableArray()
                let wsm : WebserviceClass = WebserviceClass.sharedInstance
                wsm.delegates=nil
                wsm.delegates=self
                wsm.getMemberDetail(userProfileID, grpID: userGroupID)
            }
        }
        else
        {
            let alert=UIAlertController(title: "Rotary India", message:"Failed to DELETE, please Try Again", preferredStyle: UIAlertController.Style.alert);
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil));
            //event handler with closure
            self.present(alert, animated: true, completion: nil);
        }
        
        
    }
    
     @objc func backClicked(){
        if(isCalled == "notify"){
            // appDelegate.setRootView()
            UserDefaults.standard.set("no", forKey: "picadded")
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }else if(isCalled == "notify1"){
            //appDelegate.setRootView()
            UserDefaults.standard.set("no", forKey: "picadded")
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }
        else{
            UserDefaults.standard.set("no", forKey: "picadded")
            self.navigationController?.popViewController(animated: true)
        }
        
        if((self.presentingViewController) != nil){
            
            self.dismiss(animated: false, completion: nil)
            
            print("done")
            
        }
    }
    
    @objc func editClicked(){
        //self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("rootDash") as UIViewController, animated: true)
    }
    @objc func ADDPersonalAction(){
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            let defaults = UserDefaults.standard
            defaults.set("", forKey: "countryName")
            defaults.set("", forKey: "countryCode1")
            defaults.set("", forKey: "countryCode")
            defaults.set("", forKey: "countryId")
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "personalEdit") as! PersonalEditViewController
            secondViewController.personalDetailsArray=memberDetailRs.personalMemberDetails as NSArray
            secondViewController.profileId = userProfileID
            secondViewController.isCalledFrom = "Personal"
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
       
         SVProgressHUD.dismiss()
        
        }
        
       
    }
    @objc func ADDBusinessAction(){
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "personalEdit") as! PersonalEditViewController
        secondViewController.personalDetailsArray=memberDetailRs.businessMemberDetails as NSArray
        secondViewController.profileId = userProfileID
        secondViewController.isCalledFrom = "Business"
        let defaults = UserDefaults.standard
        defaults.set("", forKey: "countryName")
        defaults.set("", forKey: "countryCode1")
        defaults.set("", forKey: "countryCode")
        defaults.set("", forKey: "countryId")
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    func getDirectoryDetailDelegate(_ memberDetail : MemberListDetailResult)
    {
        // memberDetailRs = memberDetail.MemberDetails as NSArray
        
        mainArray = memberDetail.memberDetails as NSArray
        
        
        var memberDet = MemberListDetail()
        memberDet = mainArray.object(at: 0) as! MemberListDetail
        memberDetailRs = memberDet
        
        personalDetailsArray = NSMutableArray.init(array: memberDet.personalMemberDetails)
        businessDetailArray = memberDet.businessMemberDetails as NSArray
        
        isShowBusiness = memberDet.isBusinDetVisible
        isShowFamily   = memberDet.isFamilDetailVisible
        isShowPersonal = memberDet.isPersonalDetVisible
        AddressDetailArray = memberDet.addressDetails as NSArray
        /// ----- Family Array ////----
        
        FamArray = memberDet.familyMemberDetails as NSArray
        print("main user prof \(mainUSerPRofileID)  profileID \(memberDet.profileID)")
        if(isAdmin == "No"){
            
            //my code
            var profileid:NSString!=memberDet.profileID! as NSString
            
            
            if(mainUSerPRofileID != profileid){
                if(isShowPersonal != "yes" ){
                    AddressDetailArray = []
                    personalDetailsArray = []
                }
            }
        }else{
            isShowBusiness = "yes"
            isShowFamily   = "yes"
            isShowPersonal = "yes"
        }
        //my code
        var profileid:NSString!=memberDet.profileID! as NSString
        
        if(mainUSerPRofileID == profileid){
            //  let buttons : NSArray = [trash]
            
            self.navigationItem.rightBarButtonItems = nil
        }
        print(FamArray)
        print(FamArray.count)
        
        
        ProfileTableView.reloadData()
        
    }
    
    
    func withoutAddrsBtnClk()
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "edit_address") as! EditAddressController
        secondViewController.profileId = userProfileID as String
        secondViewController.isEditOrNewAdd = "0"
        secondViewController.GroupID = userGroupID as String
        if conditionString == "personal"
        {
            secondViewController.addresstypeSTR = "Residence"
        }
        else if conditionString == "business"
        {
            secondViewController.addresstypeSTR = "Business"
        }
        else{
            
        }
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func addrsBtnClk(_ addrDetail:Address)
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "edit_address") as! EditAddressController
        secondViewController.profileId = userProfileID as String
        secondViewController.isEditOrNewAdd = "0"
        secondViewController.addrDetail = addrDetail
        secondViewController.GroupID = userGroupID as String
        
        if conditionString == "personal"
        {
            secondViewController.addresstypeSTR = "Residence"
        }
        else if conditionString == "business"
        {
            secondViewController.addresstypeSTR = "Business"
        }
        else{
            
        }
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @IBAction func NextButtonAction(_ sender: AnyObject)
    {
        
        var alertController = UIAlertController()
        
        
        
        alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        
        
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "rootDashss") as UIViewController, animated: true) // group_detail  , directory , events
        
        alertController.dismiss(animated: true, completion: nil)
        
        
        
        
     
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0)
        {
            return 1
        }
        else
        {
            if conditionString == "family"
            {
                return FamArray.count
            }
            else
            {
                if conditionString == "personal"
                {
                    /*
                     if(AddressDetailArray.count > 0){
                     let predicate = NSPredicate(format: "addressType == %@", "Residence")
                     var menuTitles1 = AddressDetailArray.filteredArrayUsingPredicate(predicate)
                     var addr : Address!
                     addr = menuTitles1[0] as! Address
                     if(addr.addressType == "Residence"){
                     return personalDetailsArray.count+1
                     }else{
                     return personalDetailsArray.count+1
                     }
                     }else{*/
                    
                    if(isShowPersonal != "yes"){
                        return 0
                    }
                    return personalDetailsArray.count+1
                    // }
                    
                }
                else
                {
                    /* if(AddressDetailArray.count > 0){
                     let predicate = NSPredicate(format: "addressType == %@", "Business")
                     var menuTitles1 = AddressDetailArray.filteredArrayUsingPredicate(predicate)
                     var addr : Address!
                     addr = menuTitles1[0] as! Address
                     if(addr.addressType == "Business"){
                     return businessDetailArray.count+1
                     }else{
                     return businessDetailArray.count+1
                     }
                     }else{*/
                    return businessDetailArray.count+1
                    //  }
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
        if(section == 1)
        {
            let headerView = UIView()
            
            if conditionString == "family"
            {
                headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 84)
            }
            else
            {
                headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 84)
            }
            
            headerView.backgroundColor = UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0)
            
            //UIColor (red: 255.0/255.0, green: 215.0/255.0, blue: 60/255.0, alpha: 1.0).CGColor
            
            PersonalButton = UIButton()
            PersonalButton.frame = CGRect(x: 5, y: 0, width: 100, height: 40)
            PersonalButton.setTitle("Personal",  for: UIControl.State.normal)
            PersonalButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
            PersonalButton.titleLabel!.font = UIFont(name: "OpenSans-Semibold", size: 18)
            PersonalButton.addTarget(self, action: #selector(ProfileViewController.PersonalDetailsAction), for: UIControl.Event.touchUpInside)
            
            let backImageView = UIImageView()
            backImageView.frame = CGRect(x: 0, y: 45, width: ProfileTableView.frame.size.width, height: 40)
            backImageView.backgroundColor = UIColor.white
            headerView.addSubview(backImageView)
            
            AddFamilyMemberButton = UIButton()
            AddFamilyMemberButton.frame = CGRect(x: (ProfileTableView.frame.size.width-60), y: 48, width: 33, height: 33)
            AddFamilyMemberButton .setTitleColor(UIColor(red: 0, green: 122, blue: 255, alpha: 1.0),  for: UIControl.State.normal)
            
            if(isAdmin == "No"){
                
            }else{
                // if(isShowPersonal == "yes" ){
                AddFamilyMemberButton.setTitle("Edit",  for: UIControl.State.normal)
                AddFamilyMemberButton.setTitleColor(UIColor.blue,  for: UIControl.State.normal)
                //AddFamilyMemberButton.titleLabel!.font = UIFont(name: "Open Sans-semibold", size: 18)
                if conditionString == "personal"{
                    AddFamilyMemberButton.addTarget(self, action: #selector(ProfileViewController.ADDPersonalAction), for: UIControl.Event.touchUpInside)
                }else{
                    AddFamilyMemberButton.addTarget(self, action: #selector(ProfileViewController.ADDBusinessAction), for: UIControl.Event.touchUpInside)
                }
                headerView.addSubview(AddFamilyMemberButton)
                // }
            }
            
            headerView.addSubview(PersonalButton)
            
            if isShowBusiness == "yes"
            {
                BussinessButton = UIButton()
                BussinessButton.frame = CGRect(x: (ProfileTableView.frame.size.width/2)-50, y: 0, width: 100, height: 40)
                BussinessButton.isEnabled = true
                BussinessButton.setTitle("Business",  for: UIControl.State.normal)
                BussinessButton.setTitleColor(UIColor(red: 155.0/255.0, green: 159.0/255.0, blue: 166.0/255.0, alpha: 255.0/255.0),  for: UIControl.State.normal)
                BussinessButton.titleLabel!.font = UIFont(name: "OpenSans-Semibold", size: 18)
                BussinessButton.addTarget(self, action: #selector(ProfileViewController.BusinessDetailsAction), for: UIControl.Event.touchUpInside)
                headerView.addSubview(BussinessButton)
                
                
                
                if isShowFamily == "yes"
                {
                    FamilyButton = UIButton()
                    FamilyButton.frame = CGRect(x: (ProfileTableView.frame.size.width-105), y: 0, width: 100, height: 40)
                    FamilyButton.isEnabled = true
                    FamilyButton.setTitle("Family",  for: UIControl.State.normal)
                    FamilyButton.setTitleColor(UIColor(red: 155.0/255.0, green: 159.0/255.0, blue: 166.0/255.0, alpha: 255.0/255.0),  for: UIControl.State.normal)
                    FamilyButton.titleLabel!.font = UIFont(name: "OpenSans-Semibold", size: 18)
                    FamilyButton.addTarget(self, action: #selector(ProfileViewController.FamilyDetailsAction), for: UIControl.Event.touchUpInside)
                    headerView.addSubview(FamilyButton)
                    if conditionString == "family"
                    {
                        let backImageView = UIImageView()
                        backImageView.frame = CGRect(x: 0, y: 45, width: ProfileTableView.frame.size.width, height: 40)
                        backImageView.backgroundColor = UIColor.white
                        headerView.addSubview(backImageView)
                        if(isAdmin == "No")
                        {
                        }
                        else
                        {
                           /* if(varIsAddButtonHideonFamily==1)
                            {
                                
                            }
                            else
                            {
                                */
                                AddFamilyMemberButton = UIButton()
                                AddFamilyMemberButton.frame = CGRect(x: (ProfileTableView.frame.size.width-36), y: 48, width: 33, height: 33)
                                AddFamilyMemberButton.setImage(UIImage(named: "add_sign.png"),  for: UIControl.State.normal)
                                
                                //AddFamilyMemberButton.setTitleColor(UIColor.whiteColor(), forState: UIControl.State.Normal)
                                //AddFamilyMemberButton.titleLabel!.font = UIFont(name: "Open Sans-semibold", size: 18)
                                AddFamilyMemberButton.addTarget(self, action: #selector(ProfileViewController.ADDFamilyMemberAction), for: UIControl.Event.touchUpInside)
                                headerView.addSubview(AddFamilyMemberButton)
                            
                           /* }*/
                            
                        }
                        
                        
                    }
                    else
                    {
                    }
                }
                    
                else
                {
                    FamilyButton.isHidden = true
                }
                
            }
            else
            {
                BussinessButton.isHidden = true
                
                if isShowFamily == "yes"
                {
                    FamilyButton = UIButton()
                    FamilyButton.frame = CGRect(x: (ProfileTableView.frame.size.width/2)-50, y: 0, width: 100, height: 40)
                    FamilyButton.isEnabled = true
                    FamilyButton.setTitle("Family",  for: UIControl.State.normal)
                    FamilyButton.setTitleColor(UIColor(red: 155.0/255.0, green: 159.0/255.0, blue: 166.0/255.0, alpha: 255.0/255.0),  for: UIControl.State.normal)
                    FamilyButton.titleLabel!.font = UIFont(name: "OpenSans-Semibold", size: 18)
                    FamilyButton.addTarget(self, action: #selector(ProfileViewController.FamilyDetailsAction), for: UIControl.Event.touchUpInside)
                    headerView.addSubview(FamilyButton)
                    
                    
                    if conditionString == "family"
                    {
                        let backImageView = UIImageView()
                        backImageView.frame = CGRect(x: 0, y: 45, width: ProfileTableView.frame.size.width, height: 40)
                        backImageView.backgroundColor = UIColor.white
                        headerView.addSubview(backImageView)
                        
                        if(isAdmin == "No")
                        {
                        }
                        else
                        {
                            AddFamilyMemberButton = UIButton()
                            AddFamilyMemberButton.frame = CGRect(x: (ProfileTableView.frame.size.width-36), y: 48, width: 33, height: 33)
                            AddFamilyMemberButton.setImage(UIImage(named: "add_sign.png"),  for: UIControl.State.normal)
                            //AddFamilyMemberButton.setTitleColor(UIColor.whiteColor(), forState: UIControl.State.Normal)
                            //AddFamilyMemberButton.titleLabel!.font = UIFont(name: "Open Sans-semibold", size: 18)
                            AddFamilyMemberButton.addTarget(self, action: #selector(ProfileViewController.ADDFamilyMemberAction), for: UIControl.Event.touchUpInside)
                            headerView.addSubview(AddFamilyMemberButton)
                        }
                        
                        
                    }
                    else
                    {}
                }
                else
                {
                    FamilyButton.isHidden = true
                }
            }
            
            return headerView
        }
        else
        {
            return nil
        }
    }
    
    
    @objc func ADDFamilyMemberAction()
    {
        print("ADD Famil yMember Action")
        
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "add_edit_family") as! AddEditFamilyController
        secondViewController.profileId = userProfileID as String
        secondViewController.isEditOrNewAdd = "0"
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        
        //self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("add_edit_family") as UIViewController, animated: true)
        //add_edit_family add_member_group
        
    }
    
    @objc func PersonalDetailsAction()
    {
        if(isShowPersonal != "yes"){
            
            
        }else{
            print("Personal Details")
            
            conditionString = "personal"
            
            ProfileTableView.reloadSections(IndexSet(integer: 1), with: .none)
            ProfileTableView.tableFooterView = UIView(frame: CGRect.zero)
            
            PersonalButton.isEnabled = true
            BussinessButton.isEnabled = true
            FamilyButton.isEnabled = true     // true
            PersonalButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
            BussinessButton.setTitleColor(UIColor(red: 155.0/255.0, green: 159.0/255.0, blue: 166.0/255.0, alpha: 255.0/255.0),  for: UIControl.State.normal)
            FamilyButton.setTitleColor(UIColor(red: 155.0/255.0, green: 159.0/255.0, blue: 166.0/255.0, alpha: 255.0/255.0),  for: UIControl.State.normal)
        }
        
    }
    
    @objc func BusinessDetailsAction()
    {
        if(isShowBusiness != "yes"){
            
            
        }else{
            print("Business Details")
            
            conditionString = "business"
            
            ProfileTableView.tableFooterView = UIView(frame: CGRect.zero)
            
            ProfileTableView.reloadSections(IndexSet(integer: 1), with: .none)
            
            PersonalButton.isEnabled = true
            BussinessButton.isEnabled = true
            FamilyButton.isEnabled = true     // true
            BussinessButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
            PersonalButton.setTitleColor(UIColor(red: 155.0/255.0, green: 159.0/255.0, blue: 166.0/255.0, alpha: 255.0/255.0),  for: UIControl.State.normal)
            FamilyButton.setTitleColor(UIColor(red: 155.0/255.0, green: 159.0/255.0, blue: 166.0/255.0, alpha: 255.0/255.0),  for: UIControl.State.normal)
        }
        
    }
    
    @objc func FamilyDetailsAction()
    {
        if(isShowFamily != "yes"){
            
            
        }else{
            print("Family Details")
            
            conditionString = "family"
            
            /*
             let footerView = UIView(frame: CGRectMake(0, 0, ProfileTableView.frame.size.width, 240))
             footerView.backgroundColor = UIColor.whiteColor()
             
             let PhotoTitle = UILabel()
             PhotoTitle.frame = CGRectMake(15, 10, 150, 40)
             PhotoTitle.text = "Family Photo"
             PhotoTitle.textColor = UIColor.lightGrayColor()
             footerView.addSubview(PhotoTitle)
             
             let myCustomView = UIImageView()
             myCustomView.frame = CGRectMake((ProfileTableView.frame.size.width/2)-125, 70, 250, 150)
             let myImage: UIImage = UIImage(named: "profile_pic")!
             myCustomView.image = myImage
             footerView.addSubview(myCustomView)
             ProfileTableView.tableFooterView = footerView
             */
            
            ProfileTableView.reloadSections(IndexSet(integer: 1), with: .none)
            
            PersonalButton.isEnabled = true
            FamilyButton.isEnabled = true
            BussinessButton.isEnabled = true
            FamilyButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
            BussinessButton.setTitleColor(UIColor(red: 155.0/255.0, green: 159.0/255.0, blue: 166.0/255.0, alpha: 255.0/255.0),  for: UIControl.State.normal)
            PersonalButton.setTitleColor(UIColor(red: 155.0/255.0, green: 159.0/255.0, blue: 166.0/255.0, alpha: 255.0/255.0),  for: UIControl.State.normal)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 1)
        {
            if conditionString == "family"
            {
                return 80
            }
            else
            {
                return 80
            }
            
        }
        else
        {
            return 0
        }
    }
    
    
    //    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        //////// ---------- Profile Main Section /////-----------
        
        if(indexPath.section == 0)
        {
            let cell = ProfileTableView.dequeueReusableCell(withIdentifier: "profCell", for: indexPath) as! profileDPCell
            
            
            cell.indicator.startAnimating()
            if mainArray.count > 0
            {
                var memberDet = MemberListDetail()
                memberDet = mainArray.object(at: indexPath.row) as! MemberListDetail
               
               
                cell.ProfilePic.layer.cornerRadius = cell.ProfilePic.frame.height/2
                cell.ProfilePic.clipsToBounds = true
                print(memberDet.profilePic)
                
                if let checkedUrl = URL(string: memberDet.profilePic) {
                    //Working in swift new version 03-08-2018
                    cell.ProfilePic.sd_setImage(with: checkedUrl)
                    cell.indicator.stopAnimating()
//                    appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
//                        DispatchQueue.main.async { () -> Void in
//                            guard let data = data, error == nil else { return }
//                            print(response?.suggestedFilename ?? "")
//                            print("Download Finished")
//                            cell.ProfilePic.image =  self.imageWithGradient(UIImage(data: data))
//                            cell.indicator.stopAnimating()
//                            //  cell.activityLoader.stopAnimating()
//                        }
//                    }
                }
                else
                {
                    cell.indicator.stopAnimating()
                    //cell.ProfilePic.image =  imageWithGradient(UIImage(named: "profile_pic"))
                    cell.ProfilePic.image = UIImage(named: "profile_pic")
                    cell.ProfilePic.layer.cornerRadius = cell.ProfilePic.frame.height/2
                    cell.ProfilePic.clipsToBounds = true
                }
                
                if memberDet.profilePic == ""
                {
                    cell.indicator.stopAnimating()
                    cell.ProfilePic.image = UIImage(named: "profile_pic")
                    cell.ProfilePic.layer.cornerRadius = cell.ProfilePic.frame.height/2
                    cell.ProfilePic.clipsToBounds = true
                    //cell.ProfilePic.image =  imageWithGradient(UIImage(named: "profile_pic"))
                }
                
                if(isAdmin == "No"){
                    cell.profilePicEditButton.isHidden=true
                }else{
                    cell.profilePicEditButton.isHidden=false
                }
                
                cell.profCallButton.addTarget(self, action: #selector(ProfileViewController.PhoneCallAction), for: UIControl.Event.touchUpInside)
                cell.profSMSButton.addTarget(self, action: #selector(ProfileViewController.SMSAction), for: UIControl.Event.touchUpInside)
                cell.profMailButton.addTarget(self, action: #selector(ProfileViewController.MailAction), for: UIControl.Event.touchUpInside)
                
                PhoneNumberSTR  =  memberDet.memberMobile
                EmailSTR  =  memberDet.memberEmail
                
                if(isAdmin == "No"){
                    cell.profilePicEditButton.isHidden=true
                }else{
                    cell.profilePicEditButton.isHidden=false
                }
                cell.profilePicEditButton.addTarget(self, action: #selector(ProfileViewController.editProfilePicAction), for: .touchUpInside)
                
            }
            
            return cell
        }
        else
        {
            
            if conditionString == "family"
            {
                let cell = ProfileTableView.dequeueReusableCell(withIdentifier: "familyInfoCell", for: indexPath) as! FamilyInfoCell
                
                if FamArray.count > 0
                {
                    
                    var familyClass = FamilyMemberDetil()
                    familyClass = FamArray.object(at: indexPath.row) as! FamilyMemberDetil
                    
                    print(familyClass.contactNo)
                    
                    cell.relativeName.text = familyClass.memberName
                    cell.relationWithUser.text = familyClass.relationship
                    cell.emailLabel.text = familyClass.emailID
                    
                   // var varSplit=familyClass.dOB
                    //var varGetArray=varSplit.componentsSeparatedByString("/")
                   // var varGetDDMM=varGetArray[0]+"-"+varGetArray[1]
                   // let(varGetFormattedDate)=commonClassFunction().functionForDateMonthYearProper(familyClass.dOB, stringMidContainCharacter: "-",stringRightMonthWhichFormatAvailable:"Digit",stringWhichFormat: "ddmm",stringSeprateBy: " ")
                    
                    
                    
                    
                    
                    var varGetFormattedDate:String!=""
                    var varGetValue:String!=familyClass.dOB as! String
                    print(varGetValue)
                    print(familyClass.dOB)
                    
                  
                    
                    if(varGetValue.characters.count>0)
                    {
                        
                        print(familyClass.dOB)
                        
                        
                        varGetFormattedDate=commonClassFunction().functionForDateMonthYearProper(familyClass.dOB, stringMidContainCharacter: "/",stringRightMonthWhichFormatAvailable:"Digit",stringWhichFormat: "ddmm",stringSeprateBy: " ")
                        
                        
                    }
                varIsAddButtonHideonFamily=1
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                  print(varGetFormattedDate)

                    
                    var varGetValueMobileNo:Int=familyClass.contactNo.characters.count
                    cell.birthDayLabel.text = varGetFormattedDate
                    if(varGetValueMobileNo>0)
                    {
                    cell.mobileLabel.text = String(format:"+%@",familyClass.contactNo)
                    }
                    else
                    {
                        cell.mobileLabel.text=""
                    }
                    cell.bloodGroup.text = familyClass.bloodGroup
                    
                    
                    cell.BG.layer.shadowColor = UIColor.black.cgColor
                    cell.BG.layer.shadowOpacity = 0.4
                    cell.BG.layer.shadowOffset = CGSize.zero
                    cell.BG.layer.shadowRadius = 5
                    
                    cell.editButton.tag = indexPath.row
                    cell.editButton.addTarget(self, action: #selector(ProfileViewController.EditFamilyDetailAction(_:)), for: .touchUpInside)
                    cell.delegates=self
                    cell.deleteButton.tag = indexPath.row
                    cell.familymemID = familyClass.familyMemberId as! NSString
                    // cell.deleteButton.addTarget(self, action: #selector(ProfileViewController.DeleteFamilyDetailAction(_:)), forControlEvents: .TouchUpInside)
                    
                    if(isAdmin == "No")
                    {
                        cell.deleteButton.isHidden  =  true
                        cell.editButton.isHidden    =  true
                    }
                    else
                    {
                        
                    }
                    
                }
                
                return cell
            }
            else
            {
                let cell = ProfileTableView.dequeueReusableCell(withIdentifier: "profInfoCell", for: indexPath) as! profileInfoCell
                
                cell.delegates = self
                
                if mainArray.count > 0
                {
                    
                    if conditionString == "personal"
                    {
                        if(isShowPersonal == "yes" ){
                            if(indexPath.row >= personalDetailsArray.count){
                                if(AddressDetailArray.count>0){
                                    
                                    let predicate = NSPredicate(format: "addressType == %@", "Residence")
                                    var menuTitles1 = AddressDetailArray.filtered(using: predicate)
                                    var addr : Address!
                                    if(menuTitles1.count > 0){
                                        addr = menuTitles1[0] as! Address
                                        if(addr.addressType == "Residence"){
                                            cell.ProfileLabel.text = String(format: "%@ Address",addr.addressType)
                                            cell.ProfileDetailLabel.text = String(format: "%@ %@ %@ %@ %@",addr.address,addr.city,addr.state,addr.country,addr.pincode)
                                            print(cell.ProfileDetailLabel.text)
                                            if(isAdmin == "No"){
                                                cell.addrEditBtn.isHidden=true
                                            }else{
                                                cell.addrEditBtn.isHidden=false
                                            }
                                            cell.addrDetail=addr
                                            
                                            // }
                                        }
                                    }else{
                                        cell.ProfileLabel.text = String(format: "%@ Address","Residence")
                                        cell.ProfileDetailLabel.text = ""
                                        if(isAdmin == "No"){
                                            cell.addrEditBtn.isHidden=true
                                        }else{
                                            cell.addrEditBtn.isHidden=false
                                        }
                                        cell.addrDetail=nil
                                    }
                                }else{
                                    cell.ProfileLabel.text = String(format: "%@ Address","Residence")
                                    cell.ProfileDetailLabel.text = ""
                                    if(isAdmin == "No"){
                                        cell.addrEditBtn.isHidden=true
                                    }else{
                                        cell.addrEditBtn.isHidden=false
                                    }
                                    cell.addrDetail=nil
                                }
                            }
                            else
                            {
                                if personalDetailsArray.count > 0
                                {
                                    var personalClass = PersonalMemberDetil()
                                    personalClass = personalDetailsArray.object(at: indexPath.row) as! PersonalMemberDetil
                                    
                                   
                                    
                                    print(personalClass.key)
                                    print(personalClass.value)
                                    
                                    if(personalClass.key=="Date Of Birth" || personalClass.key=="Date Of Anniversary")
                                    {
                                        
                                        var varGetValue:String!=personalClass.value as! String
                                        
                                        if(varGetValue.characters.count>0 )
                                        {
                                         let(varGetFormattedDate)=commonClassFunction().functionForDateMonthYearProper(personalClass.value, stringMidContainCharacter: "/",stringRightMonthWhichFormatAvailable:"Digit",stringWhichFormat: "ddmm",stringSeprateBy: " ")
                                     
                                        
                                        cell.ProfileLabel.text = personalClass.key
                                        cell.ProfileDetailLabel.text = varGetFormattedDate
                                        cell.addrEditBtn.isHidden=true
                                        }
                                        else
                                        {
                                            cell.ProfileLabel.text = personalClass.key
                                            cell.ProfileDetailLabel.text = personalClass.value
                                            cell.addrEditBtn.isHidden=true
                                        }
                                    
                                    }
                                    else
                                    {
                                        cell.ProfileLabel.text = personalClass.key
                                        cell.addrEditBtn.isHidden=true
                                        if(personalClass.key=="Secondary Mobile No")
                                        {
                                            
                                            var varGetValue:String!=personalClass.value as! String
                                            //print(varGetValue)
                                           
                                            //if(!(varGetValue.isEmpty))
                                           //// {
                                                
                                               
                                                cell.ProfileDetailLabel.text = personalClass.value
                                                
                                                
                                                
                                           // }
                                        }
                                        
                                        else
                                        {
                                        cell.ProfileLabel.text = personalClass.key
                                        cell.ProfileDetailLabel.text = personalClass.value
                                        cell.addrEditBtn.isHidden=true
                                        }
                                        
                                    }
                                   
                                    /*
                                     
                                     "key": "Date Of Birth",
                                     "value": "01/01/1753",
                                     "colType": "Date"
                                     }
                                     },
                                     {
                                     "PersonalMemberDetil": {
                                     "uniquekey": "member_date_of_wedding",
                                     "key": "Date Of Anniversary"
                                     */
                                }
                                
                                
                            }
                        }
                        
                    }
                    else if conditionString == "business"
                    {
                        if(indexPath.row >= businessDetailArray.count){
                            if(AddressDetailArray.count>0){
                                // if   (AddressDetailArray.containsObject("Business")){
                                
                                let predicate = NSPredicate(format: "addressType == %@", "Business")
                                var menuTitles1 = AddressDetailArray.filtered(using: predicate)
                                var addr : Address!
                                if(menuTitles1.count > 0){
                                    addr = menuTitles1[0] as! Address
                                    if(addr.addressType == "Business"){
                                        cell.ProfileLabel.text = String(format: "%@ Address",addr.addressType)
                                        cell.ProfileDetailLabel.text = String(format: "%@ %@ %@ %@ %@",addr.address,addr.city,addr.state,addr.country,addr.pincode)
                                        if(isAdmin == "No"){
                                            cell.addrEditBtn.isHidden=true
                                        }else{
                                            cell.addrEditBtn.isHidden=false
                                        }
                                        cell.addrDetail=addr
                                        
                                        
                                        // }
                                    }
                                    
                                }else{
                                    cell.ProfileLabel.text = String(format: "%@ Address","Business")
                                    cell.ProfileDetailLabel.text = ""
                                    if(isAdmin == "No"){
                                        cell.addrEditBtn.isHidden=true
                                    }else{
                                        cell.addrEditBtn.isHidden=false
                                    }
                                    cell.addrDetail=nil
                                }
                            }else{
                                cell.ProfileLabel.text = String(format: "%@ Address","Business")
                                cell.ProfileDetailLabel.text = ""
                                if(isAdmin == "No"){
                                    cell.addrEditBtn.isHidden=true
                                }else{
                                    cell.addrEditBtn.isHidden=false
                                }
                                cell.addrDetail=nil
                            }
                        }
                        else
                        {
                            if businessDetailArray.count > 0
                            {
                                var businessClass = BusinessMemberDetail()
                                businessClass = businessDetailArray.object(at: indexPath.row) as! BusinessMemberDetail
                                
                                cell.ProfileLabel.text = businessClass.key
                                cell.ProfileDetailLabel.text = businessClass.value
                            }
                        }
                    }
                    
                    
                }
                return cell
                
            }
            
        }
    }
    
    
    
    
    
    @objc func EditFamilyDetailAction(_ sender: UIButton)
    {
        print(String(format:"Edit Family %d",sender.tag))
        
        var familyClass = FamilyMemberDetil()
        familyClass = FamArray.object(at: sender.tag) as! FamilyMemberDetil
        
        print(familyClass.contactNo)
        print(familyClass.dOB)
        
        
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "add_edit_family") as! AddEditFamilyController
        secondViewController.profileId = userProfileID as String
        secondViewController.isEditOrNewAdd = familyClass.familyMemberId
        secondViewController.isEditMemberName = familyClass.memberName
        secondViewController.isEditEmail = familyClass.emailID
        secondViewController.isEditMobile = familyClass.contactNo
        secondViewController.isEditRelation = familyClass.relationship
        secondViewController.isEditBirthday = familyClass.dOB
        secondViewController.isEditBloodgrp = familyClass.bloodGroup
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    func familyDeleteBtnClk(_ familymemID:NSString){
        isDeleted="family"
        let alert=UIAlertController(title: "Confirm", message:"Are you sure, you want to delete?", preferredStyle: UIAlertController.Style.alert);
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil));
        //event handler with closure
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
            
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=nil
            wsm.delegates=self
            wsm.deleteDataWebservice(familymemID as String, type: "FamilyMember", profileID: self.userProfileID as String)
        }));
        self.present(alert, animated: true, completion: nil);
        
    }
    
    
    func DeleteFamilyDetailAction(_ sender: UIButton)
    {
        print("Delete Family")
        
    }
    
    @objc func PhoneCallAction()
    {
        PhoneNumberSTR = PhoneNumberSTR.replacingOccurrences(of: " ", with: "")
        print("calling\(PhoneNumberSTR)")
//        let url = URL(string: "tel://\(PhoneNumberSTR)")
//        UIApplication.shared.openURL(url!)
        
        if let url = URL(string: "tel://\(PhoneNumberSTR)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Unable to make a call. Invalid phone number or URL.")
        }
        /*
        if PhoneNumberSTR.characters.count > 1
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Rotary India"
            alertView.message = String(format:"Do you want to make call with %@",PhoneNumberSTR)
            alertView.delegate = self
            alertView.tag = 1
            alertView.addButtonWithTitle("No")
            alertView.addButtonWithTitle("Yes")
            alertView.show()
            
        }
        */
    }
    
    
    func alertView(_ View: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(View.tag == 1)
        {
            switch buttonIndex{
                
            case 1:
                
//                let url = URL(string: "tel://\(PhoneNumberSTR)")
//                UIApplication.shared.openURL(url!)
                
                if let url = URL(string: "tel://\(PhoneNumberSTR)"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    print("Unable to make a call. Invalid phone number or URL.")
                }
                
                break;
            case 0:
                
                //mobileNumberField.becomeFirstResponder()
                
                break;
            default:
                NSLog("Default");
                break;
                
            }
        }
        else
        {
            
        }
    }
    
    @objc func SMSAction()
    {
        print("SMS sent")
        let messageVC = MFMessageComposeViewController()
        messageVC.body = ""
        messageVC.recipients = [PhoneNumberSTR] // Optionally add some tel numbers
        messageVC.messageComposeDelegate = self
        // Open the SMS View controller
        present(messageVC, animated: true, completion: nil)
    }
    
    @objc func MailAction()
    {
        print("Email Sent")
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([EmailSTR])      // gg@hing.co.in
            mail.setMessageBody("", isHTML: true)
            
            present(mail, animated: true, completion: nil)
        } else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Rotary India"
            alertView.message = "Please check whether you have logged in to your mail account."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()

        }
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        /*
        switch result.rawValue {
        case MessageComposeResultCancelled.rawValue :
            print("message canceled")
            
        case MessageComposeResultFailed.rawValue :
            print("message failed")
            
        case MessageComposeResultSent.rawValue :0
        print("message sent")
            
        default:
            break
        }
        */
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func imageWithGradient(_ img:UIImage!) -> UIImage{
        
        UIGraphicsBeginImageContext(img.size)
        let context = UIGraphicsGetCurrentContext()
        
        img.draw(at: CGPoint(x: 0, y: 0))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations:[CGFloat] = [0.65, 1.0]
        //1 = opaque
        //0 = transparent
        let bottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        let top = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        
      //  let gradient = CGGradient(colorsSpace: colorSpace, colors: [top, bottom], locations: locations)
        
        
        //let startPoint = CGPoint(x: img.size.width/2, y: 0)
       // let endPoint = CGPoint(x: img.size.width/2, y: img.size.height)
        
        
       // context!.drawLinearGradient(gradient!,start: startPoint,end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    
    @objc func editProfilePicAction()
    {
        if  memberDetailRs.profilePic == "" //chosenImage.size.width == 0
        {
            let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
            actionSheet.tag = 1
            actionSheet.show(in: self.view)
        }
        else
        {
            
            let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Remove photo","Change photo")
            actionSheet.tag = 0
            actionSheet.show(in: self.view)
        }
        
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int)
    {
        print("\(buttonIndex)")
        
        
        if actionSheet.tag == 0
        {
            switch (buttonIndex){
                
            case 0:
                print("Cancel")
                
                self.dismiss(animated: true, completion: nil)
                
            case 1:
                
                print(userProfileID)
                print(userGroupID)
                chosenImage = UIImage()
                
                let wsm : WebserviceClass = WebserviceClass.sharedInstance
                wsm.delegates=self
                wsm.DeletePhotoEdit(userProfileID as String, grpID: userGroupID as String, type: "Member",moduleId: "")//avinash
                
            case 2:
                
                let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
                actionSheet.tag = 1
                actionSheet.show(in: self.view)
                
            default:
                print("Default")
            }
        }
        else
        {
            switch (buttonIndex){
                
            case 0:
                print("Cancel")
                
                self.dismiss(animated: true, completion: nil)
                
            case 1:
                
                //shows the photo library
                self.imagePicker = UIImagePickerController()
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.delegate = self
               // if #available(iOS 8.0, *) {
                    self.imagePicker.modalPresentationStyle = .popover
                //} else {
                    // Fallback on earlier versions
               // }
                self.present(self.imagePicker, animated: true, completion: nil)
                
            case 2:
                   openCamera()
                //   /*
                //shows the photo library
//                self.imagePicker = UIImagePickerController()
//                self.imagePicker.allowsEditing = true
//                self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
//                self.imagePicker.cameraCaptureMode = .Photo
//                self.imagePicker.modalPresentationStyle = .FullScreen
//                self.imagePicker.delegate = self
//                
//                //if #available(iOS 8.0, *) {
//                    self.imagePicker.modalPresentationStyle = .Popover
//               // } else {
//                    // Fallback on earlier versions
//               // }
//                
//                self.presentViewController(self.imagePicker, animated: true, completion: nil)
                //   */
                
                //           imagePicker =  UIImagePickerController()
                //            imagePicker.delegate = self
                //            imagePicker.sourceType = .Camera
                
                //  presentViewController(imagePicker, animated: true, completion: nil)
                
                
            default:
                print("Default")
                
                
            }
        }
        
    }
    
    
    func DeletePhotoDelegateFunction(_ dltPhoto : DeleteResult)
    {
        print(dltPhoto.status)
        if(dltPhoto.status == "1" ){
            /*
            let alert = UIAlertController(title: "Rotary India", message: "Failed to Delete...", preferredStyle: UIAlertController.Style.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            */
            
            self.view.makeToast("Failed to Delete...", duration: 2, position: CSToastPositionCenter)

            
            
        }else{
        personalDetailsArray=NSMutableArray()
        mainArray = NSArray()
        FamArray = NSMutableArray()
        chosenImage = UIImage()
        businessDetailArray=NSMutableArray()
        AddressDetailArray=NSMutableArray()
        
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=nil
        wsm.delegates=self
        wsm.getMemberDetail(userProfileID, grpID: userGroupID)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = ProfileTableView.dequeueReusableCell(withIdentifier: "profCell", for:indexPath) as! profileDPCell
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            chosenImage = possibleImage //4= possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            chosenImage = possibleImage
        }
        
        cell.ProfilePic.contentMode = .scaleAspectFit //3
        cell.ProfilePic.translatesAutoresizingMaskIntoConstraints = true
        cell.ProfilePic.layer.masksToBounds = true
        cell.ProfilePic.clipsToBounds = true;
        
        
        let imageToDisplay = UIImage(cgImage: chosenImage.cgImage!, scale: chosenImage.scale, orientation: .up)
        
       // loaderViewMethod()
        
        var memberDet = MemberListDetail()
        memberDet = mainArray.object(at: 0) as! MemberListDetail
        
        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
        wsm.delegate=self
        let imageData: Data = chosenImage.pngData()!
        //  print("profileID \(imageData)")
        wsm.uploadProfilePic(toServer: imageData, andProfileID: memberDet.profileID, andGroupID: memberDet.grpID)
        UserDefaults.standard.set("yes", forKey: "picadded")
       // NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(ProfileViewController.callthis), userInfo: nil, repeats: false)
        dismiss(animated: true, completion: nil) //5
       // callthis()
    }
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true,completion: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
      //  NSUserDefaults.standardUserDefaults().setObject("no", forKey: "picadded")
    }
    
    func getUploadProfilePicSucceeded(_ response: UploadImageResult)
    {
        //print(response.status)
        window=nil
         UserDefaults.standard.set("no", forKey: "picadded")
        
        if response.status == "0"
        {
            /*
            let alert = UIAlertController(title: "Rotary India", message: "Profile Pic Changed..", preferredStyle: UIAlertController.Style.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            */
            self.view.makeToast("Profile Pic Changed..", duration: 2, position: CSToastPositionCenter)

            
            
            personalDetailsArray=NSMutableArray()
            mainArray = NSArray()
            FamArray = NSMutableArray()
            chosenImage = UIImage()
            businessDetailArray=NSMutableArray()
            AddressDetailArray=NSMutableArray()
            
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=nil
            wsm.delegates=self
            wsm.getMemberDetail(userProfileID, grpID: userGroupID)
        }
        else
        {
            /*
            let alert = UIAlertController(title: "Rotary India", message: "Update Profile Pic Failed..", preferredStyle: UIAlertController.Style.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            */
            
            self.view.makeToast("Update Profile Pic Failed..", duration: 2, position: CSToastPositionCenter)

            
        }
        
    }
    
    
//    func loaderViewMethod()
//    {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        if let window = window {
//            window.backgroundColor = UIColor.clear
//            window.rootViewController = UIViewController()
//            window.makeKeyAndVisible()
//        }
//
//        let Loadingview = UIView()
//        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
//        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
//
//
//        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")
//
//
//        let gifView = UIImageView()
//        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
//        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
//        gifView.backgroundColor = UIColor.clear
//        //                gifView.contentMode = .Center
//        Loadingview.addSubview(gifView)
//        window?.addSubview(Loadingview)
//        window?.bringSubview(toFront: Loadingview)
//    }
    
    
    
    func callthis(){
        
        //loaderViewMethod()
        
        var memberDet = MemberListDetail()
        memberDet = mainArray.object(at: 0) as! MemberListDetail
        
        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
        wsm.delegate=self
        let imageData: Data = chosenImage.pngData()!
      //  print("profileID \(imageData)")
        wsm.uploadProfilePic(toServer: imageData, andProfileID: memberDet.profileID, andGroupID: memberDet.grpID)
    }
    
    /*-----------------code by dpk -------------------*/
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraCaptureMode = .photo
            present(imagePicker, animated: true, completion: nil)
        }else{
            /*
            let alert = UIAlertController(title: "Camera Not Found", message: "Camera Not Found, this device has no Camera", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style:.Default, handler: nil)
            alert.addAction(ok)
            presentViewController(alert, animated: true, completion: nil)
            */
            
            self.view.makeToast("Camera Not Found, this device has no Camera", duration: 2, position: CSToastPositionCenter)

            
            
        }
    }
    /*-----------------code by dpk -------------------*/
    
    
}


