//
//  AddEBulletineController.swift
//  TouchBase
//
//  Created by Kaizan on 22/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices
import Alamofire
import MBProgressHUD
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
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}




extension Foundation.Date {
    func isGreaterThanDate(_ dateToCompare: Foundation.Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(_ dateToCompare: Foundation.Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
}

class CustomUITextField: UITextField{
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        /*code for by Rajendra Jat
         if action == #selector(NSObject.paste(_:)) {
         return true
         }
         */
        return super.canPerformAction(action, withSender: sender)
    }
}

class AddEBulletineController: UIViewController , UITableViewDataSource, UITableViewDelegate , UITextFieldDelegate , webServiceDelegate , uploadDocDelegate ,UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIActionSheetDelegate,URLSessionDownloadDelegate, UIDocumentInteractionControllerDelegate,smsQuesDelegate,UIDocumentPickerDelegate{
    let bounds = UIScreen.main.bounds
    
    var objprotocolForEBulletinListingCallingApi:protocolForEBulletinListingCallingApi!=nil
    
    @IBOutlet weak var buttonAddAction: UIButton!
    
    
    
    
   // let loaderClass  = WebserviceClass()
    
    var isSubGrpAdmin : String = "0"
    var selectRecipientTypeEditMode:String! = ""
    var imagePicker = UIImagePickerController()
    var varSubGrouporMember:Int!=0
    var downloadTask: URLSessionDownloadTask!
    var backgroundSession: Foundation.URLSession!
    var moduleName:String! = ""
    var SMSCountStr : String!
    var annTypeStr:NSString!
    var videoURL : URL!
    @IBOutlet var addEBulletineTableView: UITableView!
    var myview = UIView()
    var countGroups = Int()
    var count = Int()
    var commonIDString : String!
    var groupProfileID  : String!
    var NameOfPDF : String = ""
    var uploadStatus : String = ""
    var uploadID : String = ""
    
    var cellArray : NSMutableArray!
    var groupID = String()
    var picker: UIDatePicker = UIDatePicker()
    let toolBar = UIToolbar()
    var imageCondition = Bool()
    var videoCondition = Bool()
    var chosenImage = UIImage()
    
    var getFinanceYear = ""
    
    // var PublishDate = NSDate()
    //./// var ExpiryDate = NSDate()
    
    //    var PublishDate : Foundation.Date? = nil
    //    var ExpiryDate : Foundation.Date? = nil
    
    var PublishDate = Foundation.Date()
    var ExpiryDate = Foundation.Date()
    
    var appDelegate : AppDelegate!
    var PDFCondition = Bool()
    var PDFLinkDrpBx : String = ""
    var PDFTypeFromDrpBx : String = ""
    var ebullTypeStr = String()
    var allSMSFlag:NSString!
    var nonSmartSMSFlag:NSString!
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        functionForAllGroupMemberSetting()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        picker.setStyle()
        picker.date.formattedNewsLetter
//        getClubDetails()
        varSubGrouporMember=0
        buttonOpacity.isHidden=true
        
        print("SMS--------COUNT\(SMSCountStr)")
        // print(PublishDate)
        // print(ExpiryDate)
        
        //PublishDate=nil
        //ExpiryDate=nil
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
                                
                                  if mainMemberID == "Yes"
                                  {
                                      self.isSubGrpAdmin = "1"
                                  }
                                  else
                                  {
                                      self.isSubGrpAdmin = "0"
                                  }
        
        
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        UserDefaults.standard.set("no", forKey: "session_IsComingFromPop")
        
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
        commonIDString=""
        NotificationCenter.default.addObserver(self, selector: #selector(self.AllRSVPBActionE), name: NSNotification.Name(rawValue: "AllRSVPbull"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.subGroupRSVPBActionE), name: NSNotification.Name(rawValue: "subGroupRSVPbull"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.MembersRSVPBActionE), name: NSNotification.Name(rawValue: "MembersRSVPbull"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.EditEvenBActionE), name: NSNotification.Name(rawValue: "EditEventbull"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.UploadPDFActionE), name: NSNotification.Name(rawValue: "UploadPDF"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.DeletePDFActionE), name: NSNotification.Name(rawValue: "DeletePDF"), object: nil)
        ebullTypeStr="0"
        cellArray=[]
        createCEll()
        
        imagePicker.delegate = self
        imageCondition = false
        
        removeFile()
        fileExistance()
        
        let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
        backgroundSession = Foundation.URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        
    }
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title=moduleName
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AddEBulletineController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
     @objc func backClicked()
    {
        let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
        if(cell.bullTitleField.text!.characters.count > 0){
            let alertController = UIAlertController(title: "", message:
                "Your changes are not saved, are you sure you want to go back?", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default,handler:  {(alert :UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
            //  print("YOU PRESSED OK \(sender.view!.tag)")
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    var loadingNotification:MBProgressHUD = MBProgressHUD()
    func showMBProgress(str:String)
    {
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.color = .clear
        loadingNotification.activityIndicatorColor = .gray
        //loadingNotification.labelText=str
        loadingNotification.show(true)
    }
    
    func hideMBProgress()
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    }

    
    @objc func AllRSVPBActionE()
    {
        let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
        cell.allEbullButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        cell.subGroupBullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        cell.membersBullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        cell.editBullButton.isHidden = true
        cell.addPeaopleCountLabel.isHidden = true
        UserDefaults.standard.set("", forKey: "profID")
        
        
        print("Nothing here")
        UserDefaults.standard.set("", forKey: "groupsID")
        print("Nothing here")
        addEBulletineTableView.reloadData()
        
        print("ALLANN")
        varSubGrouporMember=0
        commonIDString = ""
        cell.addPeaopleCountLabel.text=""
    }
    
    @objc func subGroupRSVPBActionE()
    {
        print("Groups")
        UserDefaults.standard.set("", forKey: "groupsID")
        UserDefaults.standard.set("", forKey: "profID")
        let SubGroupController = self.storyboard?.instantiateViewController(withIdentifier: "sub_group1") as! SubGroupListController
        SubGroupController.groupIDX = groupID
        SubGroupController.isCalledFrom="add"
        
        if(varSubGrouporMember==0 || varSubGrouporMember==1)
        {
            if(commonIDString == ""){
                SubGroupController.groupIdsArray=NSMutableArray()
            }
            else
            {
                let pointsArr = commonIDString.components(separatedBy: ",")
                print("commonstr \(commonIDString)")
                
                
                SubGroupController.groupIdsArray=NSMutableArray(array: pointsArr).mutableCopy() as! NSMutableArray
            }
        }
        else{
            SubGroupController.groupIdsArray=NSMutableArray()
        }
        self.navigationController?.pushViewController(SubGroupController, animated: true)
    }
    
    @objc func MembersRSVPBActionE()
    {
        print("membersEBull")
        UserDefaults.standard.set("", forKey: "groupsID")
        UserDefaults.standard.set("", forKey: "profID")
        let MembersController = self.storyboard?.instantiateViewController(withIdentifier: "edit_directory") as! EditDirectoryController
        MembersController.groupIDX = groupID
        MembersController.isCalledFRom = "add1"
        if(varSubGrouporMember==0 || varSubGrouporMember==2)
        {
            if(commonIDString == "")
            {
                MembersController.profileIdsArray=NSMutableArray()
                MembersController.isCalledFRom="add"
            }
            else
            {
                let pointsArr = commonIDString.components(separatedBy: ",")
                print("commonstr \(commonIDString)")
                MembersController.profileIdsArray=NSMutableArray(array: pointsArr).mutableCopy() as! NSMutableArray
                MembersController.isCalledFRom="edit"
            }
        }
        else
        {
            MembersController.profileIdsArray=NSMutableArray()
            MembersController.isCalledFRom="add"
        }
        self.navigationController?.pushViewController(MembersController, animated: true)
    }
    
    
    
    
    func functionForAllGroupMemberSetting()
    {
        let defaults = UserDefaults.standard
        let tabledata =  defaults.array(forKey: "profID")
        // var tabledata1 = NSUserDefaults.standardUserDefaults().arrayForKey("groupsID")
        if tabledata?.count > 0
        {
            
            // NSUserDefaults.standardUserDefaults().setObject("", forKey: "profID")
            print(tabledata)
            print(tabledata!.count)
            //PDFCondition = false
            // PDFLinkDrpBx  = ""
            //PDFTypeFromDrpBx  = ""
            let array = tabledata! as NSArray
            
            count = array.count
            
            commonIDString = array.componentsJoined(by: ",")
            print(commonIDString)
            
            //  let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
            
            cell.addPeaopleCountLabel.isHidden = false
            cell.editBullButton.isHidden = true//false
            
            if count == 1
            {
                cell.addPeaopleCountLabel.text = String(format:"You have added %d member",count)
            }
            else
            {
                cell.addPeaopleCountLabel.text = String(format:"You have added %d members",count)
            }
            ebullTypeStr = "2"
            cell.membersBullButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            cell.subGroupBullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            cell.allEbullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            varSubGrouporMember=2
        }
        else if let tabledata = UserDefaults.standard.array(forKey: "groupsID")
        {
            
            //  NSUserDefaults.standardUserDefaults().setObject("", forKey: "groupsID")
            print(tabledata)
            print(tabledata.count)
            
            let array = tabledata as NSArray
            
            countGroups = array.count
            
            commonIDString = array.componentsJoined(by: ",")
            print(commonIDString)
            
            
            let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
            
            cell.addPeaopleCountLabel.isHidden = false
            cell.editBullButton.isHidden = true//false
            
            if countGroups == 1
            {
                cell.addPeaopleCountLabel.text = String(format:"You have added %d group",countGroups)
            }
            else
            {
                cell.addPeaopleCountLabel.text = String(format:"You have added %d groups",countGroups)
            }
            ebullTypeStr = "1"
            cell.subGroupBullButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            cell.membersBullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            cell.allEbullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            varSubGrouporMember=1
        }
        /*---------------------------------------------------------------------------------------------------------------------*/
        if(commonIDString=="")
        {
            let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
            cell.allEbullButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            cell.subGroupBullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            cell.membersBullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            
            commonIDString=""
            cell.addPeaopleCountLabel.isHidden = true
            cell.editBullButton.isHidden = true
            UserDefaults.standard.set("", forKey: "profID")
            UserDefaults.standard.set("", forKey: "groupsID")
            cell.addPeaopleCountLabel.text=""
        }
        else
        {
            let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
            //            cell.allEventsButton.setImage(UIImage(named: "rbtn_select.png"), forState: UIControl.State.Normal)
            //            cell.subGroupEventButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
            //            cell.membersEventsButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
            //
            // commonIDString=""
            cell.addPeaopleCountLabel.isHidden = false
            cell.editBullButton.isHidden = false
            UserDefaults.standard.set("", forKey: "profID")
            UserDefaults.standard.set("", forKey: "groupsID")
            
        }
        /*-----------------------------------------------------------------------------------------------------------*/
        let varGetValue:String! =  UserDefaults.standard.value(forKey: "session_IsComingFromPop") as! String
        if(varGetValue=="yes")
        {
            
        }
        else
        {
            let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
            // if((cell.addPeaopleCountLabel.text)? = nil)
            // {
            var varGetNewLabelValue:String?=cell.addPeaopleCountLabel.text
            
            print(varGetNewLabelValue)
            let string = cell.addPeaopleCountLabel.text
            if(varGetNewLabelValue!.characters.count<=0)
            {
                cell.allEbullButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                cell.subGroupBullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                cell.membersBullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                selectRecipientTypeEditMode = "All"
                varSubGrouporMember=0
                ebullTypeStr="0"
            }
            else  if string!.range(of: "groups") != nil
            {
                cell.allEbullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                cell.subGroupBullButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                cell.membersBullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                selectRecipientTypeEditMode = "Group"
                varSubGrouporMember=1
                ebullTypeStr="1"
            }
            else  if string!.range(of: "members") != nil
            {
                cell.allEbullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                cell.subGroupBullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                cell.membersBullButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                selectRecipientTypeEditMode = "Member"
                varSubGrouporMember=2
                ebullTypeStr="2"
            }
            //}
        }
        /*-----------------------------------------------------------------------------------------------------------*/
        ////radio_btn_Check
        //radio_btn_Uncheck
        /*------------------------------------------------------------------------------------------------------------------------*/
        
    }
    @objc func EditEvenBActionE()
    {
        
        if(selectRecipientTypeEditMode == "Group")
        {
            subGroupRSVPBActionE()
        }
        else if (selectRecipientTypeEditMode == "Member")
        {
            MembersRSVPBActionE()
        }
        else
        {
        }
        functionForAllGroupMemberSetting()
        print("EditEventANN")
    }
    
    func changeValueofSelectionAll(_ val:NSString){
        let cell = cellArray.object(at: 2) as! SmsQuestionCell
        
        if(self.SMSCountStr == "0" || self.SMSCountStr == "")
        {
            allSMSFlag="0"
            nonSmartSMSFlag="0"
            
            cell.allMemSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
            cell.nonSmartSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
             SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Rotary India", message: "Balance whatsapp count is 0. Please recharge", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else
        {
            if(val == "0"){
                allSMSFlag="0"
                // nonSmartSMSFlag="0"
                // cell.allMemSMSButton.setImage(UIImage(named: "CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
                // cell.nonSmartSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
            }else{
                allSMSFlag="1"
                nonSmartSMSFlag="0"
                //cell.allMemSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
                //cell.nonSmartSMSButton.setImage(UIImage(named: "CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
            }
        }
    }
    func changeValueofSelectionnonSmartSMSButton(_ val:NSString){
        let cell = cellArray.object(at: 2) as! SmsQuestionCell
        if(self.SMSCountStr == "0" || self.SMSCountStr == "")
        {
            allSMSFlag="0"
            nonSmartSMSFlag="0"
            
            cell.allMemSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
            cell.nonSmartSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
             SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Rotary India", message: "Balance whatsapp count is 0. Please recharge", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else
        {
            if(val == "0"){
                nonSmartSMSFlag="0"
                // nonSmartSMSFlag="0"
                // cell.allMemSMSButton.setImage(UIImage(named: "CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
                // cell.nonSmartSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
            }else{
                nonSmartSMSFlag="1"
                allSMSFlag="0"
                // nonSmartSMSFlag="1"
                //cell.allMemSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
                //cell.nonSmartSMSButton.setImage(UIImage(named: "CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    /*
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
     {
     
     cellView = addEBulletineTableView.dequeueReusableCellWithIdentifier("EBulletineHeaderCell")!
     return cellView
     
     }
     func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
     {
     return 414.0
     }
     */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (indexPath.row == 0)
        {
            return 288.0
        }else if(indexPath.row == 1){
            
            return 100
        }
        else
        {
            return 98.0
        }
    }
    
    
    func createCEll(){
        //my code
        /// for var index = 0; index <= 3; index += 1 {
        
        for index in 0..<4{
            
            
            if (index == 0)
            {
                let cell = addEBulletineTableView.dequeueReusableCell(withIdentifier: "EBulletineHeaderCell") as! EBulletineHeaderCell
                
                //    cell.uploadPDFicon.hidden = true
                //    cell.uploadPDFnam.hidden = true
                   cell.deletePDFButton.isHidden = true
                cell.bullRedirectLinkField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                
                cellArray.add(cell)
            }
            else if(index == 2){
                var cellHeader2 = addEBulletineTableView.dequeueReusableCell(withIdentifier: "smscell") as! SmsQuestionCell
                if(cellHeader2 == nil){
                    //var objects: NSArray?;
                    cellHeader2 =  Bundle.main.loadNibNamed("smscell", owner: self, options: nil)![0] as! SmsQuestionCell
                }
                allSMSFlag="0"
                nonSmartSMSFlag = "0"
                cellHeader2.delegates=self
                cellHeader2.allMemSMSButton.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                cellHeader2.nonSmartSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                cellHeader2.SMSCountLabel.text = String(format:"Balance Whatsapp : %@",SMSCountStr)
                cellArray.add(cellHeader2)
            }
            else if(index == 1)
            {
                let cell = addEBulletineTableView.dequeueReusableCell(withIdentifier: "schedule") as! ScheduleCell
                
                cell.dateButton.addTarget(self, action: #selector(self.DateTimeShowActions(_:)), for: UIControl.Event.touchUpInside)
                cell.dateButton.tag = index
                cell.timeButton.addTarget(self, action: #selector(self.DateTimeShowActions(_:)), for: UIControl.Event.touchUpInside)
                cell.timeButton.tag = index
                
                if index == 1
                {
                    cell.dateTimeTitleLabel.text = "Publish date & time"
                }
                    /*
                else  if index == 3
                {
                    cell.dateTimeTitleLabel.text = "Expiry date & time"
                }
                */
                
                
                cellArray.add(cell)
            }
            
            
        }
    }
    //  //for whatsapp count
    func getClubDetails()
    {
        //loaderViewMethod()
        let completeURL:String! = baseUrl+row_ClubInfoDetails
        var parameterst:NSDictionary=NSDictionary()
        parameterst = ["grpID":self.groupID as Any]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable : Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
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
            if((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let MeetingPlace =    ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "MeetingPlace") as! String
                let smsCount = ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "SMSCount") as! String
                self.SMSCountStr = smsCount
//                self.createCEll()

//                if self.isCalledFRom=="add"
//                {
////                self.MeetingPlace = MeetingPlace
////                let cell : HeaderCelll = self.self.cellArray.object(at: 0) as! HeaderCelll
//
////                cell.eventVenueTextView.text! = self.MeetingPlace
//                self.SMSCountStr = smsCount
////                let cell1 : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
////                    self.balancedWhatsappLbl.text="Balance WhatsApp : "+self.SMSCountStr
////                self.addEventTableView.reloadData()
//               // self.window = nil
//              }
//                if self.isCalledFRom=="Edit"
//                {
////                    let cell1 : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
//                    self.SMSCountStr = smsCount
//                    print(self.SMSCountStr)
//                    self.balancedWhatsappLbl.text="Balance WhatsApp : "+self.SMSCountStr
////                    self.addEventTableView.reloadData()
//                }
            }
            else
            {
                //self.window = nil
            }
            SVProgressHUD.dismiss()
            }
        })
    }

   @objc func textFieldDidChange(_ textField: UITextField)
    {
        imageCondition = false
        let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
        if textField.text?.characters.count > 0
        {
            cell.uploadPDFButton.isEnabled = false
        }
        else
        {
            cell.uploadPDFButton.isEnabled = true
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        return cellArray.object(at: indexPath.row) as! UITableViewCell
    }
    
    @objc func DateTimeShowActions(_ sender:UIButton)
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            myview.isHidden=true
            myview = UIView(frame: CGRect(x: 0,y: 100, width: self.view.frame.size.width, height: 80));
            myview.backgroundColor=UIColor.white;
            self.view.addSubview(myview);
            
            //if(isCalledFRom == "add"){
            
            //  }
            picker = UIDatePicker(frame: CGRect(x: 0, y: 42 , width: self.view.frame.size.width, height: 80))
//            picker.setStyle()
            picker.date.formattedNewsLetter
            picker.backgroundColor = .white
            picker.tag = sender.tag
            picker.addTarget(self, action: #selector(AddEBulletineController.dateValueChanged(_:)), for: UIControl.Event.valueChanged)
            
            //        let currentDate = NSDate()  //5 -  get the current date
            //        picker.minimumDate = currentDate  //6- set the current date/time as a minimum
            //        picker.date = currentDate
            let cell = cellArray.object(at: sender.tag) as! ScheduleCell
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
            let strDate = dateFormatter.string(from: picker.date)
            
            if picker.tag == 2
            {
                PublishDate = picker.date
            }
            else if picker.tag == 3
            {
                ExpiryDate = picker.date
            }
            else{}
            
            let strSplit = strDate.characters.split(separator: " ")
            let Date = String(strSplit.first!)
            let time = String(strSplit.last!)
            
            print(Date)
            print(time)
            
            cell.dateButton.setTitle(Date,  for: UIControl.State.normal)
            cell.timeButton.setTitle(time,  for: UIControl.State.normal)
            
            toolBar.frame = CGRect(x: 0, y: 0 , width: view.frame.width, height: 50)
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(AddEBulletineController.donePicker))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            toolBar.setItems([spaceButton,doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            myview.addSubview(toolBar)
            myview.addSubview(picker)
        }
        else
        {
        self.buttonOpacity.isHidden=true
        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        SVProgressHUD.dismiss()
       //
            
             //buttonAddAction.isEnabled=true
            
            
        }
        
    }
    
    @objc func donePicker()
    {
        myview.removeFromSuperview()
        myview.isHidden=true
    }
    
    @objc func dateValueChanged(_ sender:UIDatePicker)
    {
        
        let cell = cellArray.object(at: sender.tag) as! ScheduleCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        let strDate = dateFormatter.string(from: sender.date)
        
        if sender.tag == 2
        {
            PublishDate = sender.date
        }
        else if sender.tag == 3
        {
            ExpiryDate = sender.date
        }
        else{}
        let strSplit = strDate.characters.split(separator: " ")
        let Date = String(strSplit.first!)
        let time = String(strSplit.last!)
        
        print(Date)
        print(time)
        
        cell.dateButton.setTitle(Date,  for: UIControl.State.normal)
        cell.timeButton.setTitle(time,  for: UIControl.State.normal)
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        donePicker()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        textField.resignFirstResponder()
        return true
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
//
//    }
    @IBAction func AddEBulletineAction(_ sender: AnyObject)
    {
            self.UploadAddEbulletinFunction()
    }
    var ifButtonExist:Int=0
    
    func UploadAddEbulletinFunction()
        {
            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
            {
                let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
                let cell1 = cellArray.object(at: 1) as! ScheduleCell
                let cell2 = cellArray.object(at: 1) as! ScheduleCell
                
                // var ebullTypeStr = String!()
                
                if cell.allEbullButton.currentImage!.isEqual(UIImage(named: "radio_btn_Check"))
                {
                    ebullTypeStr = "0"
                    
                    print("ALL Announcement")
                }
                else if cell.subGroupBullButton.currentImage!.isEqual(UIImage(named: "radio_btn_Check"))
                {
                    ebullTypeStr = "1"
                    print("subGroup Announcemnt")
                }
                else if cell.membersBullButton.currentImage!.isEqual(UIImage(named: "radio_btn_Check"))
                {
                    ebullTypeStr = "2"
                    print("members Announcement")
                }
                else
                {
                    
                }
                
                if PDFCondition == true
                {
                    if(cell.bullTitleField.text! == ""){
                        self.view.makeToast("Please enter title", duration: 2, position: CSToastPositionCenter)
                       //
                          self.buttonOpacity.isHidden=true
                        SVProgressHUD.dismiss()
                         //buttonAddAction.isEnabled=true
                        
                    }
                    else
                    {
                        if PDFTypeFromDrpBx == ".pdf" || PDFTypeFromDrpBx == ".PDF"
                        {
                            //--------------------------start-------------------13 dec
    
     
     
     let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
     
     let cell1 = cellArray.object(at: 1) as! ScheduleCell
     
     let cell2 = cellArray.object(at: 1) as! ScheduleCell
     
     // var ebullTypeStr = String()
     
     if cell.allEbullButton.currentImage!.isEqual(UIImage(named: "check_radio"))
     {
         ebullTypeStr = "0"
         print("ALL Announcement")
     }
     else if cell.subGroupBullButton.currentImage!.isEqual(UIImage(named: "check_radio"))
     {
         ebullTypeStr = "1"
         print("subGroup Announcemnt")
     }
     else if cell.membersBullButton.currentImage!.isEqual(UIImage(named: "check_radio"))
     {
         ebullTypeStr = "2"
         print("members Announcement")
     }
     else
     {
         
     }
     if(cell.bullRedirectLinkField.text! != ""){
         let prefixes = ["http://www.", "https://www.","www."]
         for prefix in prefixes
         {
             if ((prefix.range(of: cell.bullRedirectLinkField.text!, options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil)) != nil){
                 SVProgressHUD.dismiss()
                 self.buttonOpacity.isHidden=true
                 self.view.makeToast("Please enter valid url", duration: 2, position: CSToastPositionCenter)
                 //
                                        //buttonAddAction.isEnabled=true
             }
         }
     }
     
     if(uploadStatus == "0")
     {
         
         
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
         
         let strDate = dateFormatter.string(from: PublishDate)
         let strDate1 = dateFormatter.string(from: ExpiryDate)
         
         if(cell.bullTitleField.text! == "")
         {
             SVProgressHUD.dismiss()
             self.buttonOpacity.isHidden=true
             self.view.makeToast("Please enter the Title", duration: 2, position: CSToastPositionCenter)
             //
             //buttonAddAction.isEnabled=true
         }
         else if(cell1.dateButton.titleLabel?.text == "     Select Date")
             
         {//     Select Date
             SVProgressHUD.dismiss()
             self.buttonOpacity.isHidden=true
             self.view.makeToast("Please enter a Publish Date & Time", duration: 2, position: CSToastPositionCenter)
             //
             //buttonAddAction.isEnabled=true
         }
         else if(cell2.dateButton.titleLabel?.text == "Select Date"){
             SVProgressHUD.dismiss()
             self.buttonOpacity.isHidden=true
             self.view.makeToast("Please enter an Expiry Date & Time", duration: 2, position: CSToastPositionCenter)
             //
             //buttonAddAction.isEnabled=true
         }
         else if (ExpiryDate.isLessThanDate(PublishDate))
         {
             SVProgressHUD.dismiss()
             self.buttonOpacity.isHidden=true
             self.view.makeToast("Please make the Expiry Date & Time greater than the Publish Date & Time", duration: 2, position: CSToastPositionCenter)
             
             //buttonAddAction.isEnabled=true
         }
         else if (strDate == strDate1)
         {
             SVProgressHUD.dismiss()
             self.buttonOpacity.isHidden=true
             self.view.makeToast("Publish Date & Time should not be same as Expiry Date & Time", duration: 2, position: CSToastPositionCenter)
        //
        //buttonAddAction.isEnabled=true
    }
    else
    {
        
        /*-- code by rajendra jat 22222222-- */
      
        
        if(ifButtonExist==0)
        {
            
            DispatchQueue.global(qos:.background).async
                {
                    SVProgressHUD.show()
                    DispatchQueue.main.async
                        {
                            self.buttonOpacity.isHidden=false
                            print("Processing.....3")
                            SVProgressHUD.show()
                    }
            }
            ifButtonExist=1
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            SVProgressHUD.show()
            
            
            
            
            print("222222222222222222222222222222222222222222222222222222222222222")
            wsm.addEBulletineResult("0", ebulletinType: self.ebullTypeStr, ebulletinTitle: cell.bullTitleField.text!, ebulletinlink:"" , ebulletinfileid: self.uploadfileID, memID: self.groupProfileID, grpID: self.groupID, inputIDs: self.commonIDString, publishDate: String(format:"%@ %@",(cell1.dateButton.titleLabel?.text)!,(cell1.timeButton.titleLabel?.text)!), expiryDate: String(format:"%@ %@",(cell2.dateButton.titleLabel?.text)!,(cell2.timeButton.titleLabel?.text)!),sendSMSAll: self.self.allSMSFlag,isSubGrpAdmin:isSubGrpAdmin as NSString)
            
            
            let cell = self.cellArray.object(at: 0) as! EBulletineHeaderCell
            cell.uploadPDFicon.isHidden = true
            cell.uploadPDFnam.isHidden = true
            cell.deletePDFButton.isHidden = true
            cell.bullRedirectLinkField.isUserInteractionEnabled = true
            self.uploadStatus = "1"
            print("Delete PDF")
            
//            self.removeFile()
            
            self.fileExistance()
        }
        
        
    }
   }
   else
   {
       if(cell1.dateButton.titleLabel?.text == "     Select Date")
           
       {//     Select Date
           SVProgressHUD.dismiss()
           self.buttonOpacity.isHidden=true
           self.view.makeToast("Please enter a Publish Date & Time", duration: 2, position: CSToastPositionCenter)
           //
           //buttonAddAction.isEnabled=true
       }
     else  if(ifButtonExist==0)
       {
           
           DispatchQueue.global(qos:.background).async
               {
                   SVProgressHUD.show()
                   DispatchQueue.main.async
                       {
                           print("Processing....1")
                           self.buttonOpacity.isHidden=false
                           SVProgressHUD.show()
                   }
           }
           
           ifButtonExist=1
           let wsm : WebserviceClass = WebserviceClass.sharedInstance
           wsm.delegates=self
           
           SVProgressHUD.show()
           print("333333333333333333333333333333333333333333333333")
         wsm.addEBulletineResult("0", ebulletinType: ebullTypeStr, ebulletinTitle: cell.bullTitleField.text!, ebulletinlink:"", ebulletinfileid: self.uploadfileID, memID: groupProfileID, grpID: groupID, inputIDs: commonIDString, publishDate: String(format:"%@ %@",(cell1.dateButton.titleLabel?.text)!,(cell1.timeButton.titleLabel?.text)!), expiryDate: String(format:"%@ %@",(cell2.dateButton.titleLabel?.text)!,(cell2.timeButton.titleLabel?.text)!),sendSMSAll: allSMSFlag,isSubGrpAdmin:isSubGrpAdmin as NSString)
       }
   }
   //--------------------------end--------------------13 dec
   
    //                        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
    //                        wsm.delegate=self
    //                        let pdfUrl =  URL(string: self.PDFLinkDrpBx)
    //
    //                        do {
    //                           // loaderViewMethod()
    //                           // let pdfData = try Data(contentsOf: pdfUrl! , options: NSData.ReadingOptions())
    //                            print("PDFTypeFromDrpBx \(PDFTypeFromDrpBx)")
    //                            self.functionForUploadPDf(datas:self.PDFLinkDrpBx, FileName:String(format:"%@%@",cell.bullTitleField.text!,PDFTypeFromDrpBx))
    //
    //                        } catch
    //                        {
    //                            print(error)
    //                        }
                        }
                        else
         {
             self.view.makeToast("only PDF file is allowed", duration: 2, position: CSToastPositionCenter)
            SVProgressHUD.dismiss()
         }
         PDFCondition = false
     }
 }
 else
 {
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
     
     let strDate = dateFormatter.string(from: PublishDate)
     let strDate1 = dateFormatter.string(from: ExpiryDate)
     
     if(cell.bullTitleField.text! == ""){
          SVProgressHUD.dismiss()
         self.view.makeToast("Please enter title", duration: 2, position: CSToastPositionCenter)
           self.buttonOpacity.isHidden=true
         //
          //buttonAddAction.isEnabled=true
         
         
     }else if(cell1.dateButton.titleLabel?.text == "     Select Date"){
           self.buttonOpacity.isHidden=true
          SVProgressHUD.dismiss()
         self.view.makeToast("Please enter a Publish Date & Time", duration: 2, position: CSToastPositionCenter)
     }
     else{
         
         
         var varGetURL:String!=cell.bullRedirectLinkField.text!
         var varGetLink:String!=cell.uploadPDFnam.text!
         
         print(varGetURL)
         print(varGetLink)
         if (varGetURL == "" && varGetLink == "")
         {
              SVProgressHUD.dismiss()
             self.view.makeToast("Please enter either a link or upload pdf file", duration: 2, position: CSToastPositionCenter)
             //
             //buttonAddAction.isEnabled=true
             self.buttonOpacity.isHidden=true
         }
         else if(verifyUrl(cell.bullRedirectLinkField.text!) == false && cell.uploadPDFnam.text == "")
         {
              SVProgressHUD.dismiss()
             self.view.makeToast("Please enter valid url", duration: 2, position: CSToastPositionCenter)
            //
               self.buttonOpacity.isHidden=true
             //buttonAddAction.isEnabled=true

             
         }
             
             //                else if(verifyUrl(cell.bullRedirectLinkField.text!) == false){
             //                    self.view.makeToast("Please enter valid url", duration: 2, position: CSToastPositionCenter)
             //                }
             
         else
         {
            // self.alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
          //   self.present(self.alertController, animated: true, completion: nil)
             
             
            //
             //
               // loaderViewMethod()
             
              SVProgressHUD.show()
             //loaderClass.loaderViewMethod()
             if(ifButtonExist==0)
             {
                 print("11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111")
                 SVProgressHUD.show()
                 ifButtonExist=1
                 uploadfileurl=cell.bullRedirectLinkField.text!
                 
//                if !uploadfileurl.hasPrefix("http:") {
//                    uploadfileurl = "http:\(uploadfileurl)"  // or  "http:"+ imageURLString
//                }
//
                
//                var imageURLString = uploadfileurl
//
//                if !imageURLString!.hasPrefix("https:") {
//                  let str = "https://\(imageURLString)"  // or  "http:"+ imageURLString
//                    uploadfileurl = String(str)
//                    print(uploadfileurl as Any)
//                }
             let wsm : WebserviceClass = WebserviceClass.sharedInstance
             wsm.delegates=self
                 wsm.addEBulletineResult("0", ebulletinType: ebullTypeStr, ebulletinTitle: cell.bullTitleField.text!, ebulletinlink:uploadfileurl, ebulletinfileid: self.uploadfileID, memID: groupProfileID, grpID: groupID, inputIDs: commonIDString, publishDate: String(format:"%@ %@",(cell1.dateButton.titleLabel?.text)!,(cell1.timeButton.titleLabel?.text)!), expiryDate: String(format:"%@ %@",(cell2.dateButton.titleLabel?.text)!,(cell2.timeButton.titleLabel?.text)!),sendSMSAll: allSMSFlag,isSubGrpAdmin:isSubGrpAdmin as NSString)
            
             }
             // self.navigationController?.popViewControllerAnimated(true)
         }
         
         
     }
 }
            }
            else
            {
                 SVProgressHUD.dismiss()
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
              //
             SVProgressHUD.dismiss()
            }
        }
    
    func UploadAddEbulletinFunctionBackup()
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
            let cell1 = cellArray.object(at: 2) as! ScheduleCell
            let cell2 = cellArray.object(at: 3) as! ScheduleCell
            
            // var ebullTypeStr = String!()
            
            if cell.allEbullButton.currentImage!.isEqual(UIImage(named: "radio_btn_Check"))
            {
                ebullTypeStr = "0"
                
                print("ALL Announcement")
            }
            else if cell.subGroupBullButton.currentImage!.isEqual(UIImage(named: "radio_btn_Check"))
            {
                ebullTypeStr = "1"
                print("subGroup Announcemnt")
            }
            else if cell.membersBullButton.currentImage!.isEqual(UIImage(named: "radio_btn_Check"))
            {
                ebullTypeStr = "2"
                print("members Announcement")
            }
            else
            {
                
            }
            
            if PDFCondition == true
            {
                if(cell.bullTitleField.text! == ""){
                    self.view.makeToast("Please enter title", duration: 2, position: CSToastPositionCenter)
                   //
                      self.buttonOpacity.isHidden=true
                    SVProgressHUD.dismiss()
                     //buttonAddAction.isEnabled=true
                    
                }
                else
                {
                    if PDFTypeFromDrpBx == ".pdf" || PDFTypeFromDrpBx == ".PDF"
                    {
                        //--------------------------start-------------------13 dec
                       
                        
                        
                        let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
                        
                        let cell1 = cellArray.object(at: 2) as! ScheduleCell
                        
                        let cell2 = cellArray.object(at: 3) as! ScheduleCell
                        
                        // var ebullTypeStr = String()
                        
                        if cell.allEbullButton.currentImage!.isEqual(UIImage(named: "check_radio"))
                        {
                            ebullTypeStr = "0"
                            print("ALL Announcement")
                        }
                        else if cell.subGroupBullButton.currentImage!.isEqual(UIImage(named: "check_radio"))
                        {
                            ebullTypeStr = "1"
                            print("subGroup Announcemnt")
                        }
                        else if cell.membersBullButton.currentImage!.isEqual(UIImage(named: "check_radio"))
                        {
                            ebullTypeStr = "2"
                            print("members Announcement")
                        }
                        else
                        {
                            
                        }
                        if(cell.bullRedirectLinkField.text! != ""){
                            let prefixes = ["http://www.", "https://www.","www."]
                            for prefix in prefixes
                            {
                                if ((prefix.range(of: cell.bullRedirectLinkField.text!, options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil)) != nil){
                                    SVProgressHUD.dismiss()
                                    self.buttonOpacity.isHidden=true
                                    self.view.makeToast("Please enter valid url", duration: 2, position: CSToastPositionCenter)
                                    //
                                    //buttonAddAction.isEnabled=true
                                }
                            }
                        }
                        
                        if(uploadStatus == "0")
                        {
                            
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
                            
                            let strDate = dateFormatter.string(from: PublishDate)
                            let strDate1 = dateFormatter.string(from: ExpiryDate)
                            
                            if(cell.bullTitleField.text! == "")
                            {
                                SVProgressHUD.dismiss()
                                self.buttonOpacity.isHidden=true
                                self.view.makeToast("Please enter the Title", duration: 2, position: CSToastPositionCenter)
                                //
                                //buttonAddAction.isEnabled=true
                            }
                            else if(cell1.dateButton.titleLabel?.text == "     Select Date")
                                
                            {//     Select Date
                                SVProgressHUD.dismiss()
                                self.buttonOpacity.isHidden=true
                                self.view.makeToast("Please enter a Publish Date & Time", duration: 2, position: CSToastPositionCenter)
                                //
                                //buttonAddAction.isEnabled=true
                            }
                            else if(cell2.dateButton.titleLabel?.text == "Select Date"){
                                SVProgressHUD.dismiss()
                                self.buttonOpacity.isHidden=true
                                self.view.makeToast("Please enter an Expiry Date & Time", duration: 2, position: CSToastPositionCenter)
                                //
                                //buttonAddAction.isEnabled=true
                            }
                            else if (ExpiryDate.isLessThanDate(PublishDate))
                            {
                                SVProgressHUD.dismiss()
                                self.buttonOpacity.isHidden=true
                                self.view.makeToast("Please make the Expiry Date & Time greater than the Publish Date & Time", duration: 2, position: CSToastPositionCenter)
                                
                                //buttonAddAction.isEnabled=true
                            }
                            else if (strDate == strDate1)
                            {
                                SVProgressHUD.dismiss()
                                self.buttonOpacity.isHidden=true
                                self.view.makeToast("Publish Date & Time should not be same as Expiry Date & Time", duration: 2, position: CSToastPositionCenter)
                                //
                                //buttonAddAction.isEnabled=true
                            }
                            else
                            {
                                
                                /*-- code by rajendra jat 22222222-- */
                              
                                
                                if(ifButtonExist==0)
                                {
                                    
                                    DispatchQueue.global(qos:.background).async
                                        {
                                            SVProgressHUD.show()
                                            DispatchQueue.main.async
                                                {
                                                    self.buttonOpacity.isHidden=false
                                                    print("Processing.....3")
                                                    SVProgressHUD.show()
                                            }
                                    }
                                    ifButtonExist=1
                                    let wsm : WebserviceClass = WebserviceClass.sharedInstance
                                    wsm.delegates=self
                                    SVProgressHUD.show()
                                    print("222222222222222222222222222222222222222222222222222222222222222")
                                    
//                                    if !uploadfileurl.hasPrefix("http:") {
//                                        uploadfileurl = "http:\(uploadfileurl)"  // or  "http:"+ imageURLString
//                                    }
                                    
                                    
                                    
                                    
                                    wsm.addEBulletineResult("0", ebulletinType: self.ebullTypeStr, ebulletinTitle: cell.bullTitleField.text!, ebulletinlink: uploadfileurl, ebulletinfileid: "", memID: self.groupProfileID, grpID: self.groupID, inputIDs: self.commonIDString, publishDate: String(format:"%@ %@",(cell1.dateButton.titleLabel?.text)!,(cell1.timeButton.titleLabel?.text)!), expiryDate: String(format:"%@ %@",(cell2.dateButton.titleLabel?.text)!,(cell2.timeButton.titleLabel?.text)!),sendSMSAll: self.self.allSMSFlag,isSubGrpAdmin:isSubGrpAdmin as NSString)
                                    
                                    
                                    let cell = self.cellArray.object(at: 0) as! EBulletineHeaderCell
                                    cell.uploadPDFicon.isHidden = true
                                    cell.uploadPDFnam.isHidden = true
                                    cell.deletePDFButton.isHidden = true
                                    cell.bullRedirectLinkField.isUserInteractionEnabled = true
                                    self.uploadStatus = "1"
                                    print("Delete PDF")
                                    
                                    self.removeFile()
                                    
                                    self.fileExistance()
                                }
                                
                                
                            }
                            
                            
                        }
                        else
                        {
                            if(cell1.dateButton.titleLabel?.text == "     Select Date")
                                
                            {//     Select Date
                                SVProgressHUD.dismiss()
                                self.buttonOpacity.isHidden=true
                                self.view.makeToast("Please enter a Publish Date & Time", duration: 2, position: CSToastPositionCenter)
                                //
                                //buttonAddAction.isEnabled=true
                            }
                          else  if(ifButtonExist==0)
                            {
                                
                                DispatchQueue.global(qos:.background).async
                                    {
                                        SVProgressHUD.show()
                                        DispatchQueue.main.async
                                            {
                                                print("Processing....1")
                                                self.buttonOpacity.isHidden=false
                                                SVProgressHUD.show()
                                        }
                                }
                                
                                ifButtonExist=1
                                let wsm : WebserviceClass = WebserviceClass.sharedInstance
                                wsm.delegates=self
                                
//                            if !uploadfileurl.hasPrefix("http:") {
//                                uploadfileurl = "http:\(uploadfileurl)"  // or  "http:"+ imageURLString
//                            }
//
                            
                            
                            
                            
                                SVProgressHUD.show()
                                print("333333333333333333333333333333333333333333333333")
                              wsm.addEBulletineResult("0", ebulletinType: ebullTypeStr, ebulletinTitle: cell.bullTitleField.text!, ebulletinlink: uploadfileurl, ebulletinfileid: "", memID: groupProfileID, grpID: groupID, inputIDs: commonIDString, publishDate: String(format:"%@ %@",(cell1.dateButton.titleLabel?.text)!,(cell1.timeButton.titleLabel?.text)!), expiryDate: String(format:"%@ %@",(cell2.dateButton.titleLabel?.text)!,(cell2.timeButton.titleLabel?.text)!),sendSMSAll: allSMSFlag,isSubGrpAdmin: isSubGrpAdmin as NSString)
                            }
                        }
                        //--------------------------end--------------------13 dec
                        
//                        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
//                        wsm.delegate=self
//                        let pdfUrl =  URL(string: self.PDFLinkDrpBx)
//
//                        do {
//                           // loaderViewMethod()
//                           // let pdfData = try Data(contentsOf: pdfUrl! , options: NSData.ReadingOptions())
//                            print("PDFTypeFromDrpBx \(PDFTypeFromDrpBx)")
//                            self.functionForUploadPDf(datas:self.PDFLinkDrpBx, FileName:String(format:"%@%@",cell.bullTitleField.text!,PDFTypeFromDrpBx))
//
//                        } catch
//                        {
//                            print(error)
//                        }
                    }
                    else
                    {
                        self.view.makeToast("only PDF file is allowed", duration: 2, position: CSToastPositionCenter)
                       SVProgressHUD.dismiss()
                    }
                    PDFCondition = false
                }
            }
            else
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
                
                let strDate = dateFormatter.string(from: PublishDate)
                let strDate1 = dateFormatter.string(from: ExpiryDate)
                
                if(cell.bullTitleField.text! == ""){
                     SVProgressHUD.dismiss()
                    self.view.makeToast("Please enter title", duration: 2, position: CSToastPositionCenter)
                      self.buttonOpacity.isHidden=true
                    //
                     //buttonAddAction.isEnabled=true
                    
                    
                }else if(cell1.dateButton.titleLabel?.text == "     Select Date"){
                      self.buttonOpacity.isHidden=true
                     SVProgressHUD.dismiss()
                    self.view.makeToast("Please enter a Publish Date & Time", duration: 2, position: CSToastPositionCenter)
                    
                   //
                    //buttonAddAction.isEnabled=true

                    
                }
                /*
                else if(cell2.dateButton.titleLabel?.text == "Select Date"){
                     SVProgressHUD.dismiss()
                    self.view.makeToast("Please enter expiry date", duration: 2, position: CSToastPositionCenter)
                   //
                    //buttonAddAction.isEnabled=true
  self.buttonOpacity.isHidden=true
                }
                else if (ExpiryDate.isLessThanDate(PublishDate))
                {
                     SVProgressHUD.dismiss()
                    self.view.makeToast("Publish date should be less than Expiry date", duration: 2, position: CSToastPositionCenter)
                    //buttonAddAction.isEnabled=true
  self.buttonOpacity.isHidden=true
                   //
                    
                }
                    
                    
                else if (strDate == strDate1)
                {
                      self.buttonOpacity.isHidden=true
                     SVProgressHUD.dismiss()
                    self.view.makeToast("Publish date and Expiry date should not be same", duration: 2, position: CSToastPositionCenter)
                    //buttonAddAction.isEnabled=true
                     //
                }
                   */
                else{
                    
                    
                    var varGetURL:String!=cell.bullRedirectLinkField.text!
                    var varGetLink:String!=cell.uploadPDFnam.text!
                    
                    print(varGetURL)
                    print(varGetLink)
                    
                    
                    
                    
                    
                    //                if cell.bullRedirectLinkField.text == ""
                    //                {
                    //
                    //                    self.view.makeToast("Please enter either a link or upload pdf file", duration: 2, position: CSToastPositionCenter)
                    //
                    //                }
                    if (varGetURL == "" && varGetLink == "")
                    {
                         SVProgressHUD.dismiss()
                        self.view.makeToast("Please enter either a link or upload pdf file", duration: 2, position: CSToastPositionCenter)
                        //
                        //buttonAddAction.isEnabled=true
  self.buttonOpacity.isHidden=true
                    }
                    else if(verifyUrl(cell.bullRedirectLinkField.text!) == false && cell.uploadPDFnam.text == "")
                    {
                         SVProgressHUD.dismiss()
                        self.view.makeToast("Please enter valid url", duration: 2, position: CSToastPositionCenter)
                       //
                          self.buttonOpacity.isHidden=true
                        //buttonAddAction.isEnabled=true

                        
                    }
                        
                        //                else if(verifyUrl(cell.bullRedirectLinkField.text!) == false){
                        //                    self.view.makeToast("Please enter valid url", duration: 2, position: CSToastPositionCenter)
                        //                }
                        
                    else
                    {
                       // self.alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
                     //   self.present(self.alertController, animated: true, completion: nil)
                        
                        
                       //
                        //
                          // loaderViewMethod()
                        
                         SVProgressHUD.show()
                        //loaderClass.loaderViewMethod()
                        if(ifButtonExist==0)
                        {
                            print("11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111")
                            SVProgressHUD.show()
                            ifButtonExist=1
                            uploadfileurl=cell.bullRedirectLinkField.text!
                            
//                            if !uploadfileurl.hasPrefix("http:") {
//                                uploadfileurl = "http:\(uploadfileurl)"  // or  "http:"+ imageURLString
//                            }
//
                            
                            
                        let wsm : WebserviceClass = WebserviceClass.sharedInstance
                        wsm.delegates=self
                            wsm.addEBulletineResult("0", ebulletinType: ebullTypeStr, ebulletinTitle: cell.bullTitleField.text!, ebulletinlink: uploadfileurl, ebulletinfileid: "", memID: groupProfileID, grpID: groupID, inputIDs: commonIDString, publishDate: String(format:"%@ %@",(cell1.dateButton.titleLabel?.text)!,(cell1.timeButton.titleLabel?.text)!), expiryDate: String(format:"%@ %@",(cell2.dateButton.titleLabel?.text)!,(cell2.timeButton.titleLabel?.text)!),sendSMSAll: allSMSFlag,isSubGrpAdmin:isSubGrpAdmin as NSString)
                       
                        }
                        // self.navigationController?.popViewControllerAnimated(true)
                    }
                    
                    
                }
            }
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
          //
         SVProgressHUD.dismiss()
        }
    }

    var alertController = UIAlertController()

    //MARK:- PDF Upload By DPK 25-07-2018
    
    func functionForUploadPDf(datas:String,FileName:String)
    {
         self.uploadStatus = "0"
        functionAfterPDFCALL(datas: datas, FileName: FileName)
    }

    //After Pdf upload referance
    func functionAfterPDFCALL(datas:String,FileName:String)
    {
        DispatchQueue.global(qos:.background).async
            {
                SVProgressHUD.show()
                DispatchQueue.main.async
                    {
                        self.buttonOpacity.isHidden=false
                        print("Processing.....2")
                        SVProgressHUD.show()
                }
        }
        let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
        let cell1 = cellArray.object(at: 2) as! ScheduleCell
        let cell2 = cellArray.object(at: 3) as! ScheduleCell
        // var ebullTypeStr = String()
        if cell.allEbullButton.currentImage!.isEqual(UIImage(named: "check_radio"))
        {
            ebullTypeStr = "0"
            print("ALL Announcement")
        }
        else if cell.subGroupBullButton.currentImage!.isEqual(UIImage(named: "check_radio"))
        {
            ebullTypeStr = "1"
            print("subGroup Announcemnt")
        }
        else if cell.membersBullButton.currentImage!.isEqual(UIImage(named: "check_radio"))
        {
            ebullTypeStr = "2"
            print("members Announcement")
        }
        else
        {
            
        }
        if(cell.bullRedirectLinkField.text! != ""){
            let prefixes = ["http://www.", "https://www.","www."]
            for prefix in prefixes
            {
                if ((prefix.range(of: cell.bullRedirectLinkField.text!, options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil)) != nil){
                     SVProgressHUD.dismiss()
                    self.buttonOpacity.isHidden=true
                    self.view.makeToast("Please enter valid url", duration: 2, position: CSToastPositionCenter)
                 //
                    //buttonAddAction.isEnabled=true
                }
            }
        }
        
        if(uploadStatus == "0")
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
            
            let strDate = dateFormatter.string(from: PublishDate)
            let strDate1 = dateFormatter.string(from: ExpiryDate)
            
            if(cell.bullTitleField.text! == "")
            {
                 SVProgressHUD.dismiss()
                self.buttonOpacity.isHidden=true
                self.view.makeToast("Please enter the Title", duration: 2, position: CSToastPositionCenter)
               //
                 //buttonAddAction.isEnabled=true
            }
            else if(cell1.dateButton.titleLabel?.text == "     Select Date")
                
            {
                 SVProgressHUD.dismiss()
                  self.buttonOpacity.isHidden=true
                self.view.makeToast("Please enter a Publish Date & Time", duration: 2, position: CSToastPositionCenter)
              //
                 //buttonAddAction.isEnabled=true
            }
            else if(cell2.dateButton.titleLabel?.text == "Select Date"){
                 SVProgressHUD.dismiss()
                  self.buttonOpacity.isHidden=true
                self.view.makeToast("Please enter an Expiry Date & Time", duration: 2, position: CSToastPositionCenter)
                //
                 //buttonAddAction.isEnabled=true
            }
            else if (ExpiryDate.isLessThanDate(PublishDate))
            {
                 SVProgressHUD.dismiss()
                  self.buttonOpacity.isHidden=true
                self.view.makeToast("Please make the Expiry Date & Time greater than the Publish Date & Time", duration: 2, position: CSToastPositionCenter)
                
                 //buttonAddAction.isEnabled=true
            }
            else if (strDate == strDate1)
            {
                 SVProgressHUD.dismiss()
                  self.buttonOpacity.isHidden=true
                self.view.makeToast("Publish Date & Time should not be same as Expiry Date & Time", duration: 2, position: CSToastPositionCenter)
               //
                 //buttonAddAction.isEnabled=true
            }
            else
            {

                /*-- code by rajendra jat 22222222-- */
                
//                if !uploadfileurl.hasPrefix("http:") {
//                    uploadfileurl = "http:\(uploadfileurl)"  // or  "http:"+ imageURLString
//                }
//
                
                
                
                if(ifButtonExist==0)
                {
                    ifButtonExist=1
                let wsm : WebserviceClass = WebserviceClass.sharedInstance
                wsm.delegates=self
                 SVProgressHUD.show()
                     print("222222222222222222222222222222222222222222222222222222222222222")
                    wsm.addEBulletineResult("0", ebulletinType: self.ebullTypeStr, ebulletinTitle: cell.bullTitleField.text!, ebulletinlink: uploadfileurl, ebulletinfileid: "", memID: self.groupProfileID, grpID: self.groupID, inputIDs: self.commonIDString, publishDate: String(format:"%@ %@",(cell1.dateButton.titleLabel?.text)!,(cell1.timeButton.titleLabel?.text)!), expiryDate: String(format:"%@ %@",(cell2.dateButton.titleLabel?.text)!,(cell2.timeButton.titleLabel?.text)!),sendSMSAll: self.self.allSMSFlag,isSubGrpAdmin:isSubGrpAdmin as NSString)
                
                
                let cell = self.cellArray.object(at: 0) as! EBulletineHeaderCell
                cell.uploadPDFicon.isHidden = true
                cell.uploadPDFnam.isHidden = true
                cell.deletePDFButton.isHidden = true
                cell.bullRedirectLinkField.isUserInteractionEnabled = true
                self.uploadStatus = "1"
                print("Delete PDF")
                
                self.removeFile()
                
                self.fileExistance()
                }
                
                
            }
            
            
        }
        else
        {
            if(ifButtonExist==0)
            {
                ifButtonExist=1
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            
//                if !uploadfileurl.hasPrefix("http:") {
//                    uploadfileurl = "http:\(uploadfileurl)"  // or  "http:"+ imageURLString
//                }
                
                
                
                
             SVProgressHUD.show()
             print("333333333333333333333333333333333333333333333333")
                wsm.addEBulletineResult("0", ebulletinType: ebullTypeStr, ebulletinTitle: cell.bullTitleField.text!, ebulletinlink: uploadfileurl, ebulletinfileid: "", memID: groupProfileID, grpID: groupID, inputIDs: commonIDString, publishDate: String(format:"%@ %@",(cell1.dateButton.titleLabel?.text)!,(cell1.timeButton.titleLabel?.text)!), expiryDate: String(format:"%@ %@",(cell2.dateButton.titleLabel?.text)!,(cell2.timeButton.titleLabel?.text)!),sendSMSAll: allSMSFlag,isSubGrpAdmin:isSubGrpAdmin as NSString)
            }
        }
        
    }
    
//    var urlComponents = URLComponents(string: "//www.testhost.com/pathToImage/testimage.png")!
//    if urlComponents.scheme == nil { urlComponents.scheme = "http" }
//    let imageURLString = urlComponents.url!.absoluteString
//
//
//
    
   
    func verifyUrl (_ urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
          
            var imageURLString = urlString

            if !imageURLString.hasPrefix("https:") {
               imageURLString = "https://\(imageURLString)"  // or  "http:"+ imageURLString
                print(imageURLString)
                if let url = URL(string: imageURLString) {
                    // check if your application can open the NSURL instance
                    return UIApplication.shared.canOpenURL(url)
                }
            }
            else{
            if let url = URL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url)
            }
            }
        }
        return false
    }
    
    //////////------- Add Ebulletine Delegate --------///////////
    
    
    @IBOutlet weak var buttonOpacity: UIButton!
    func addBulletineDelegateFunction(_ addEbulletine : TBAddEbulletinResult)
    {
       
        SVProgressHUD.dismiss()
       //
         //buttonAddAction.isEnabled=true
        //buttonAddAction.isEnabled=true
        alertController.dismiss(animated: true, completion: nil)

       // self.loaderClass.window=nil
        buttonOpacity.isHidden=true
        print(addEbulletine.status)
        print(addEbulletine.message)
        if(addEbulletine.status == "0")
        {
            
            let alert = UIAlertController(title: "Newsletter", message: "Added successfully.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler:  {(alert :UIAlertAction!) in
               
                self.objprotocolForEBulletinListingCallingApi.functionForEBulletinListingCallingApi(stringFromWhereITCalling: "from added newsletter")
                
                self.navigationController?.popViewController(animated: true)
            }))
            //alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Cancel, handler:nil))
            self.present(alert, animated: true, completion: nil)
            
            // self.navigationController?.popViewControllerAnimated(true)
            //self.view.makeToast("Please enter valid url", duration: 2, position: CSToastPositionCenter)
            
        }
        else
        {
            
        }
         ifButtonExist=0
    }
    
    
  
    @IBAction func CancelEBulletineAction(_ sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func UploadPDFActionE()
    {
        //print("Upload PDF")
        
        //print("Opening Gallary")
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
            
            // 2
            let deleteAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                print("File Deleted")
            })
            
            let saveAction = UIAlertAction(title: "Dropbox", style: .default, handler:
            {
                (alert: UIAlertAction!) -> Void in
                let cell = self.cellArray.object(at: 0) as! EBulletineHeaderCell
                
                if cell.bullTitleField.text == ""
                {
                     SVProgressHUD.dismiss()
                      self.buttonOpacity.isHidden=true
                    self.view.makeToast("Please enter Title", duration: 2, position: CSToastPositionCenter)
                }
                else
                {
                    
                    Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.DropboxAction), userInfo: nil, repeats: false)
                    
                    //self.OpenDropBox()   // 31-08-2017
                }
            })
            
            
            let docAction = UIAlertAction(title: "Document", style: .default, handler:
            {
                (alert: UIAlertAction!) -> Void in
                let cell = self.cellArray.object(at: 0) as! EBulletineHeaderCell
                
                if cell.bullTitleField.text == ""
                {
                     SVProgressHUD.dismiss()
                      self.buttonOpacity.isHidden=true
                    self.view.makeToast("Please enter Title", duration: 2, position: CSToastPositionCenter)
                }
                else
                {
                    
                    Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.OpenBrowser), userInfo: nil, repeats: false)
                }
            })
            // 4
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(saveAction)
            if let systemVersion = (UIDevice.current.systemVersion
             as? NSString)?.integerValue
            {
                if systemVersion >= 11
                {
                    optionMenu.addAction(docAction)
                }
            }
           
             // 5
            self.present(optionMenu, animated: true, completion: nil)
        }
        else
        {
              self.buttonOpacity.isHidden=true
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
     //
             //buttonAddAction.isEnabled=true
             SVProgressHUD.dismiss()
            
        }
        
    }
    
    @objc func DeletePDFActionE()
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            let cell2 = cellArray.object(at: 0) as! EBulletineHeaderCell

            //rajendra jat code 5nov 1.18pm
            cell2.bullRedirectLinkField.text=""
            cell2.uploadPDFnam.text=""
            
          
            
            let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
            cell.uploadPDFicon.isHidden = true
            cell.uploadPDFnam.isHidden = true
            cell.deletePDFButton.isHidden = true
            cell.bullRedirectLinkField.isUserInteractionEnabled = true
            uploadStatus = "1"
            print("Delete PDF")
            PDFCondition = false
            removeFile()
            
            fileExistance()
        }
        else
        {
              self.buttonOpacity.isHidden=true
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
     //
             SVProgressHUD.dismiss()
          //buttonAddAction.isEnabled=true
        }
        
        
    }
    @objc func DropboxAction()
    {
        self.OpenDropBox()
    }
    //////////----------------
    
    func OpenDropBox()
    {
    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
    DBChooser.default().open(for: DBChooserLinkTypeDirect, from: self, completion: { reasults in
        if reasults != nil{
        if ((reasults?.count) != 0) {
       for case let result as DBChooserResult in reasults! {
       self.PDFLinkDrpBx = result.link.description
       if(self.PDFLinkDrpBx.contains(".pdf") || self.PDFLinkDrpBx.contains(".PDF"))
    {
    let urlSlices = self.PDFLinkDrpBx.characters.split{$0 == "/"}.map(String.init)
    self.NameOfPDF = String(format:"%@",urlSlices[5])
    let imageUrlString = self.PDFLinkDrpBx
    let imageUrl = URL(string: imageUrlString)!
    print("Image URL:: \(imageUrl)")
    var imageData:Data=Data()
        do{
         imageData = try Data(contentsOf: imageUrl)
    }
    catch let error
    {
        print("Error while uploading pdf \(error)")
        SVProgressHUD.dismiss()
        return
    }
     //let image = UIImage(data: imageData)
    let imageSize: Int = imageData.count
    print("size of image in KB: %f ", Double(imageSize) / 1024.0)
    var getdocSize:Double=Double(imageSize) / 1024.0
    getdocSize=getdocSize/1024.0
    print(getdocSize)
    if(getdocSize>10.0)
    {
        self.view.makeToast("File size can not be more than 10 MB", duration: 5, position: CSToastPositionBottom)
        SVProgressHUD.dismiss()
    }
    else{
        SVProgressHUD.show()
     let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
        wsm.delegate=self
        
     wsm.uploadToServer(usingDocuments: imageData, andFileName: self.NameOfPDF, moduleName: "ebulletin")
        }
    }
    else
    {
    self.view.makeToast("Only Pdf files can be shared", duration: 2, position: CSToastPositionCenter)
        SVProgressHUD.dismiss()
    }
    }
    }
    }
   else {
      print("no results")
    }
    })
  }
 else
 {
  self.buttonOpacity.isHidden=true
  SVProgressHUD.dismiss()
  self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
     SVProgressHUD.dismiss()
}
}
    
    func getUploadDocSucceeded(_ response: LoadImageResult!) {
        DispatchQueue.main.async
        {
        SVProgressHUD.dismiss()
        let cell = self.cellArray.object(at: 0) as! EBulletineHeaderCell
        cell.uploadPDFicon.isHidden = false
        cell.uploadPDFnam.isHidden = false
        cell.deletePDFButton.isHidden = false
        self.uploadfileID=response.imageID
        let test = self.NameOfPDF
        var replaced = test.replacingOccurrences(of: "%20", with: "")
        replaced = replaced.replacingOccurrences(of: "%28", with: "(")
        replaced = replaced.replacingOccurrences(of: "%29", with: ")")
        cell.uploadPDFnam.text = replaced
        cell.bullRedirectLinkField.isUserInteractionEnabled = false
        self.addEBulletineTableView.reloadData()
        self.PDFTypeFromDrpBx = ".pdf"
        if self.PDFTypeFromDrpBx == ".pdf" || self.PDFTypeFromDrpBx == ".PDF"
        {
         self.view.makeToast("File is attached successfully", duration: 2, position: CSToastPositionCenter)
         self.PDFCondition = true
            
//         let url = URL(string: String(format:"%@",result.link.description))!
//         print("ebulettin================================",url)
//         self.uploadfileurl=String(describing: url)
//         self.downloadTask = self.backgroundSession.downloadTask(with: url)
//         self.downloadTask.resume()
            
         SVProgressHUD.dismiss()
        }
        else
        {
            print("This is different file.")
        }
        }
    }
    
func OpenDropBoxBackup()
{
//* my code
 SVProgressHUD.dismiss()
if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
DBChooser.default().open(for: DBChooserLinkTypeDirect, from: self, completion: { reasults in
    print(reasults as Any)
    if ((reasults?.count) != 0) {
        for case let result as DBChooserResult in reasults! {
   print(result.link)
   self.PDFLinkDrpBx = result.link.description
   let MyUrl = NSURL(fileURLWithPath: String(describing: result.link!))
   print(MyUrl)
   print(MyUrl.path!)
   let replaced = MyUrl.path!.replacingOccurrences(of: "/http:/", with: "https://")
   print(replaced)
   print("this is url")
   print(self.PDFLinkDrpBx)
   print(replaced)
   print(self.PDFLinkDrpBx)
   print("This is value 1")
   
if(self.PDFLinkDrpBx.contains("pdf") || self.PDFLinkDrpBx.contains("PDF"))
{
print("This is value 22222222")
print("Link Description---------------==========---------",self.PDFLinkDrpBx)
let fullNameArr = self.PDFLinkDrpBx.characters.split{$0 == "."}.map(String.init)
print(fullNameArr)
let urlSlices = self.PDFLinkDrpBx.characters.split{$0 == "/"}.map(String.init)
print(urlSlices)
self.NameOfPDF = String(format:"%@",urlSlices[5])
let cell = self.cellArray.object(at: 0) as! EBulletineHeaderCell
cell.uploadPDFicon.isHidden = false
cell.uploadPDFnam.isHidden = false
cell.deletePDFButton.isHidden = false
if(self.PDFLinkDrpBx.contains(".pdf"))
{
 let test = self.NameOfPDF
 var replaced = test.replacingOccurrences(of: "%20", with: "")
 replaced = replaced.replacingOccurrences(of: "%28", with: "(")
 replaced = replaced.replacingOccurrences(of: "%29", with: ")")
 cell.uploadPDFnam.text = replaced
 cell.bullRedirectLinkField.isUserInteractionEnabled = false
 self.addEBulletineTableView.reloadData()
 self.PDFTypeFromDrpBx = ".pdf"
 print(self.PDFTypeFromDrpBx)
}

//self.PDFTypeFromDrpBx = String(format:".%@",fullNameArr[3])
if self.PDFTypeFromDrpBx == ".pdf" || self.PDFTypeFromDrpBx == ".PDF"
{
 self.view.makeToast("File is attached successfully", duration: 2, position: CSToastPositionCenter)
 self.PDFCondition = true
 let url = URL(string: String(format:"%@",result.link.description))!
 print("ebulettin================================",url)
 self.uploadfileurl=String(describing: url)
 self.downloadTask = self.backgroundSession.downloadTask(with: url)
 self.downloadTask.resume()
 SVProgressHUD.dismiss()
}
}
else
{
self.view.makeToast("Only Pdf files can be shared", duration: 2, position: CSToastPositionCenter)
        SVProgressHUD.dismiss()
}
}
} else {
 print("no results")
}
})
 
 }
 else
 {
 self.buttonOpacity.isHidden=true
 SVProgressHUD.dismiss()
 self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
      SVProgressHUD.dismiss()
      //buttonAddAction.isEnabled=true
 }
}
    
    @objc func OpenBrowser()
     {
         let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text", "com.apple.iwork.pages.pages", "public.data"], in: .import)
         documentPicker.delegate = self
         present(documentPicker, animated: true, completion: nil)
     }
    
func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
 self.PDFLinkDrpBx = url.description as String
 if (url.pathExtension=="PDF" || url.pathExtension == "pdf")
 {
    self.PDFTypeFromDrpBx = ".pdf"
    self.NameOfPDF=url.lastPathComponent
   let imageUrlString = self.PDFLinkDrpBx
   let imageUrl = URL(string: imageUrlString)!
   print("Image URL:: \(imageUrl)")
   var imageData:Data=Data()
       do{
        imageData = try Data(contentsOf: imageUrl)
   }
   catch let error
   {
       print("Error while uploading pdf \(error)")
       SVProgressHUD.dismiss()
       return
   }
    //let image = UIImage(data: imageData)
   let imageSize: Int = imageData.count
   print("size of image in KB: %f ", Double(imageSize) / 1024.0)
   var getdocSize:Double=Double(imageSize) / 1024.0
   getdocSize=getdocSize/1024.0
   print(getdocSize)
   if(getdocSize>10.0)
   {
       self.view.makeToast("File size can not be more than 10 MB", duration: 5, position: CSToastPositionBottom)
       SVProgressHUD.dismiss()
   }
   else{
    SVProgressHUD.show()
    let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
    wsm.delegate=self
    wsm.uploadToServer(usingDocuments: imageData, andFileName: self.NameOfPDF, moduleName: "ebulletin")
       }
 }
 else
 {
 self.view.makeToast("Only Pdf files can be shared", duration: 2, position: CSToastPositionCenter)
 SVProgressHUD.dismiss()
 }
}
else
{
 self.buttonOpacity.isHidden=true
 SVProgressHUD.dismiss()
 self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
      SVProgressHUD.dismiss()
        }
    }
    
    var uploadfileurl:String!=""
    var uploadfileID:String!=""
    func showFileWithPath(_ path: String){
        let isFileFound:Bool? = FileManager.default.fileExists(atPath: path)
        if isFileFound == true{
            let viewer = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
            viewer.delegate = self
            viewer.presentPreview(animated: true)
        }
    }

    // 1
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL){
        
        //  let cell = self.cellArray.objectAtIndex(0) as! EBulletineHeaderCell
        //  let nsmeStr = String(format:"/%@%@",cell.bullTitleField.text!,PDFTypeFromDrpBx)
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath + "/file.pdf")
        
        if fileManager.fileExists(atPath: destinationURLForFile.path){
            // showFileWithPath(destinationURLForFile.path!)
            
            self.fileExistance()
            
            print(destinationURLForFile.path)
        }
        else{
            do {
                try fileManager.moveItem(at: location, to: destinationURLForFile)
                // show file
                
                
                
                // showFileWithPath(destinationURLForFile.path!)
                
                
                self.fileExistance()
                
            }catch{
                print("An error occurred while moving file to destination url")
            }
        }
         SVProgressHUD.dismiss()
    }
    // 2
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64){
         SVProgressHUD.dismiss()
        // progressView.setProgress(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite), animated: true)
    }
    
    /*
    func urlSession(_ session: URLSession,  task: URLSessionTask, didCompleteWithError error: Error?){
        downloadTask = nil
        //progressView.setProgress(0.0, animated: true)
        if (error != nil) {
            // print(error?.description)
        }else{
            print("The task finished transferring data successfully")
            let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
            cell.uploadPDFicon.isHidden = false
            cell.uploadPDFnam.isHidden = false
            cell.deletePDFButton.isHidden = false
            
            var test = self.NameOfPDF
            
           // let replaced = test.stringByReplacingOccurrencesOfString("%20", withString: "", options: nil, range: nil)
            var replaced = test.replacingOccurrences(of: "%20", with: "")
            replaced = replaced.replacingOccurrences(of: "%28", with: "(")
            replaced = replaced.replacingOccurrences(of: "%29", with: ")")

            
            cell.uploadPDFnam.text = replaced
            cell.bullRedirectLinkField.isUserInteractionEnabled = false
            addEBulletineTableView.reloadData()
        }
        SVProgressHUD.dismiss()
    }
    */
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController{
        return self
    }
    
    
    
    func removeFile()
    {
        let fileManager = FileManager.default
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("file.pdf")
        let filePath:String = fileURL.path
        
        do
        {
            try fileManager.removeItem(atPath: filePath)
        }
        catch
        {
        }
         SVProgressHUD.dismiss()
    }
    
    func fileExistance() -> Bool
    {
        let fileManager = FileManager.default
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("file.pdf")
        let filePath:String = fileURL.path
        
        do
        {
            
            if  fileManager.fileExists(atPath: filePath)
            {
                print("FILE AVAILABLE");
                
                let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
                cell.uploadPDFicon.isHidden = false
                cell.uploadPDFnam.isHidden = false
                cell.deletePDFButton.isHidden = false
                
                var test = self.NameOfPDF
                
                //let replaced = test.stringByReplacingOccurrencesOfString("%20", withString: "", options: nil, range: nil)
                var replaced = test.replacingOccurrences(of: "%20", with: "")
                 replaced = replaced.replacingOccurrences(of: "%28", with: "(")
                replaced = replaced.replacingOccurrences(of: "%29", with: ")")

                
                
                cell.uploadPDFnam.text = replaced
                cell.bullRedirectLinkField.isUserInteractionEnabled = false
                addEBulletineTableView.reloadData()
                
            }
            else
            {
                let cell = cellArray.object(at: 0) as! EBulletineHeaderCell
                cell.uploadPDFicon.isHidden = false
                cell.deletePDFButton.isHidden = false
                addEBulletineTableView.reloadData()
                
                print("FILE NOT AVAILABLE");
            }
             SVProgressHUD.dismiss()
        }
        
        
        return true
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType == kUTTypeMovie {
            
            videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            print(videoURL)
            let videoPath = videoURL.path
            print(videoPath as String)
            
            videoCondition = true
            
        }
        else
        {
            chosenImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)! //2
        }
        imageCondition = true
        dismiss(animated: true, completion: nil) //5
    }
    
    
//    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[String : Any])
//    {
//
//        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
//
//        if mediaType == kUTTypeMovie {
//
//            videoURL = info[UIImagePickerControllerMediaURL] as! URL
//            print(videoURL)
//            let videoPath = videoURL.path
//            print(videoPath as String)
//
//            videoCondition = true
//
//        }
//        else
//        {
//            chosenImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)! //2
//        }
//        imageCondition = true
//        dismiss(animated: true, completion: nil) //5
//    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
}

extension Date {
    var formattedNewsLetter: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMM dd HH:mm:00"
        return  formatter.string(from: self as Date)
    }
    

}


