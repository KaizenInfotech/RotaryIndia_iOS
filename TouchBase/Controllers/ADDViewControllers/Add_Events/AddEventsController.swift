


//
//  AddEventsController.swift
//  TouchBase
//
//  Created by Kaizan on 21/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

//AddEventsController










import UIKit
import MapKit
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


class AddEventsController: UIViewController , UITableViewDataSource, UITableViewDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIActionSheetDelegate , UIPickerViewDelegate , UITextFieldDelegate, UITextViewDelegate , webServiceDelegate,repeatnotyDelegate,repeatTurnOnDelegate,uploadDocDelegate,selectMultipleDelegate,smsQuesDelegate,addQueDelegate{
    
    var link:String!=""
    
    var objprotocolForEventsListingCallingApi:protocolForEventsListingCallingApi?=nil
    
    
    
    
    
    var titleRIZone = ""
    
    var varSubGrouporMember:Int!=0
    var MainAddQueBGView = UIView()
    var ImageBGQue = UIImageView()
    var AddQuestionView: UIView!
    var radio2Button = UIButton()
    var radio1Button = UIButton()
    var picker: UIDatePicker = UIDatePicker()
    let toolBar = UIToolbar()
    var myview = UIView()
    var varIsExistAnyQuestion:Int!=0
    var varIsRSVPEnableorDisable:Int=0
    var varISClicked:Int!=0
    var isFromAddUpdateEventButton:Bool=false
    var rsvpString:String!=""
    var selectRecipientTypeEditMode:String = ""
    /// cell.editEventButton.hidden = false
    
    var checkRemainder:Int!=0
    var editOrNot = Bool()
    var appDelegate : AppDelegate = AppDelegate()
    ///////////////////////
    var varNewIndex:CGFloat=0
    
    var addQueTextView = UITextView()
    var ans1TextField = UITextField()
    var ans2TextField = UITextField()
    var moduleName:String! = ""
    var isCategory:String! = ""
    ///////////////////////
    
    var lastCellIndex:Int=7
    var DeleteImageComeFromEdit:String!=""
    
    var SMSCountStr : String! = ""
    
    var titleArraySchedule = ["","Event Date and Time","Publish Date and Time","Expiry Date and Time"]
    
    var cellArray : NSMutableArray!
    var cell : HeaderCelll! = nil
    var cellSchedule : ScheduleCell! = nil
    var cellHeader2 : HeaderCell2! = nil
    
    let limitLength = 250
    
    //var groupID = String() // Deepak comment
    var groupID:String!=""
    var groupProfileID = String()
    var isSubGrpAdmin : String = "0"
    var commonIDString : String = ""
    var count = Int()
    var countGroups = Int()
    
    let bounds = UIScreen.main.bounds
    
    @IBOutlet var addEventTableView: UITableView!
    
    @IBOutlet weak var lblDescCount: UILabel!
    let imagePicker = UIImagePickerController()
    
    var headerCell2OBJ : HeaderCell2 = HeaderCell2()
    
    var cellView : UIView = UIView()
    var questionType : String! = ""
    var selectedImg:UIImageView!
    var ImsgId:NSString!
    var venueLat:NSString!
    var venueLon:NSString!
    var annTypeStr:NSString!
    var window: UIWindow?
    let screenSize: CGRect = UIScreen.main.bounds
    var isCalledFrom:NSString!
    var eventsDetails = EventsDetail()
    // var appDelegate : AppDelegate!
    var TypeIDEdit :NSString!
    var allSMSFlag:NSString!
    var nonSmartSMSFlag:NSString!
    var displayOnBannerFlag:String!=""
    @IBOutlet var addEventBtn: UIButton!
    var option1Btn: UIButton!
    var option2Btn: UIButton!
    
    var type1option1Btn: UIButton!
    var type1option2Btn: UIButton!
    
    
    
    @IBOutlet var viewForSelectionAnswer12: UIView!
    var MeetingPlace:String! = ""
    
    //MARK:- Server Calling
    func getClubDetails(_ GroupId:NSString)
    {
        //loaderViewMethod()
        let completeURL:String! = baseUrl+row_ClubInfoDetails
        let parameterst = ["grpID":GroupId]
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
            if((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let MeetingPlace =    ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "MeetingPlace") as! String
                let smsCount = ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "SMSCount") as! String
                self.SMSCountStr = smsCount
                if self.isCalledFrom=="add"
                {
                self.MeetingPlace = MeetingPlace
                let cell : HeaderCelll = self.self.cellArray.object(at: 0) as! HeaderCelll
                
                cell.eventVenueTextView.text! = self.MeetingPlace
                self.SMSCountStr = smsCount
                let cell1 : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
                cell1.SMSCountLabel.text="Balance WhatsApp : "+self.SMSCountStr
                self.addEventTableView.reloadData()
               // self.window = nil
              }
                if self.isCalledFrom=="edit"
                {
                    let cell1 : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
                    cell1.SMSCountLabel.text="Balance WhatsApp : "+self.SMSCountStr
                    self.addEventTableView.reloadData()
                }
                
                let cell1 : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
                cell1.SMSCountLabel.text="Balance WhatsApp : "+self.SMSCountStr
                self.addEventTableView.reloadData()
//                let smsCount = ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "SMSCount") as! String
//                let cell1 : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
//                cell1.SMSCountLabel.text="Balance WhatsApp : "+self.SMSCountStr
                self.addEventTableView.reloadData()
            }
            else
            {
                //self.window = nil
            }
            SVProgressHUD.dismiss()
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        functionForAllGroupMemberSetting()
        
        //        let defaults = NSUserDefaults.standardUserDefaults()
        //        let country =  defaults.objectForKey("eventAddress") as! String
        //        if (country != "") {
        //            //eventAddress
        //            let cell = cellArray.objectAtIndex(0) as! HeaderCelll
        //            cell.eventVenueTextView.text = country
        //
        //            venueLat = NSUserDefaults.standardUserDefaults().valueForKey("eventLat") as! String
        //            venueLon = NSUserDefaults.standardUserDefaults().valueForKey("eventLon") as! String
        //
        //            defaults.setObject("", forKey: "eventAddress")
        //            defaults.setObject("", forKey: "eventLat")
        //            defaults.setObject("", forKey: "eventLon")
        //            defaults.synchronize()
        //        }
        //
        //
        //        let tabledata =  defaults.arrayForKey("profID")
        //        let tabledata1 = NSUserDefaults.standardUserDefaults().arrayForKey("groupsID")
        //        if tabledata?.count > 0
        //        {
        //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "groupsID")
        //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "profID")
        //            print(tabledata!)
        //            print(tabledata!.count)
        //
        //            let array = tabledata! as NSArray
        //
        //            count = array.count
        //
        //            commonIDString = array.componentsJoinedByString(",")
        //            print(commonIDString)
        //
        //            // let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        //            let cell = cellArray.objectAtIndex(0) as! HeaderCelll
        //
        //            cell.addPeaopleCountLabel.hidden = false
        //            cell.editEventButton.hidden = true//false
        //            ////radio_btn_Check
        //            //radio_btn_Uncheck
        //            cell.addPeaopleCountLabel.text = String(format:"You have added %d members",count)
        //            cell.membersEventsButton.setImage(UIImage(named: "radio_btn_Check"), forState: UIControl.State.Normal)
        //            cell.allEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"), forState: UIControl.State.Normal)
        //            cell.subGroupEventButton.setImage(UIImage(named: "radio_btn_Uncheck"), forState: UIControl.State.Normal)
        //            annTypeStr="2"
        //            varSubGrouporMember=2
        //
        //        }
        //        else if tabledata1?.count > 0
        //        {
        //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "profID")
        //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "groupsID")
        //            print(tabledata1!)
        //            print(tabledata1!.count)
        //
        //            let array = tabledata1! as NSArray
        //
        //            countGroups = array.count
        //
        //            commonIDString = array.componentsJoinedByString(",")
        //            print(commonIDString)
        //
        //
        //            let cell = cellArray.objectAtIndex(0) as! HeaderCelll
        //            cell.addPeaopleCountLabel.hidden = false
        //            cell.editEventButton.hidden = true//false
        //            cell.addPeaopleCountLabel.text = String(format:"You have added %d groups",countGroups)
        //            cell.subGroupEventButton.setImage(UIImage(named: "radio_btn_Check"), forState: UIControl.State.Normal)
        //            cell.allEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"), forState: UIControl.State.Normal)
        //            cell.membersEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"), forState: UIControl.State.Normal)
        //            annTypeStr="1"
        //            varSubGrouporMember=1
        //        }
        //        else
        //        {
        //            //             if(isCalledFrom == "add"){
        //            //            let cell = cellArray.objectAtIndex(0) as! HeaderCelll
        //            //            cell.allEventsButton.setImage(UIImage(named: "rbtn_select.png"), forState: UIControl.State.Normal)
        //            //            cell.subGroupEventButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
        //            //            cell.membersEventsButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
        //            //
        //            //
        //            //            cell.addPeaopleCountLabel.hidden = true
        //            //            cell.editEventButton.hidden = true
        //            //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "profID")
        //            //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "groupsID")
        //            //            //addEventTableView.reloadData()
        //            //            annTypeStr="0"
        //            //            }
        //        }
        //
        //        if(commonIDString=="")
        //        {
        //            let cell = cellArray.objectAtIndex(0) as! HeaderCelll
        //            cell.allEventsButton.setImage(UIImage(named: "radio_btn_Check"), forState: UIControl.State.Normal)
        //            cell.subGroupEventButton.setImage(UIImage(named: "radio_btn_Uncheck"), forState: UIControl.State.Normal)
        //            cell.membersEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"), forState: UIControl.State.Normal)
        //
        //            commonIDString=""
        //            cell.addPeaopleCountLabel.hidden = true
        //            cell.editEventButton.hidden = true
        //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "profID")
        //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "groupsID")
        //            cell.addPeaopleCountLabel.text=""
        //        }
        //        else
        //        {
        //            let cell = cellArray.objectAtIndex(0) as! HeaderCelll
        //            //            cell.allEventsButton.setImage(UIImage(named: "rbtn_select.png"), forState: UIControl.State.Normal)
        //            //            cell.subGroupEventButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
        //            //            cell.membersEventsButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
        //            //
        //            // commonIDString=""
        //            cell.addPeaopleCountLabel.hidden = false
        //            cell.editEventButton.hidden = false
        //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "profID")
        //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "groupsID")
        //
        //        }
        //
        //
        //        /*-----------------------------------------------------------------------------------------------------------*/
        //
        //        var varGetValue:String! =  NSUserDefaults.standardUserDefaults().valueForKey("session_IsComingFromPop") as! String
        //        if(varGetValue=="yes")
        //        {
        //
        //        }
        //        else
        //        {
        //            let cell = cellArray.objectAtIndex(0) as! HeaderCelll
        //            // if((cell.addPeaopleCountLabel.text)? = nil)
        //            // {
        //            var varGetNewLabelValue:String?=cell.addPeaopleCountLabel.text
        //
        //            print(varGetNewLabelValue)
        //
        //
        //
        //            var string = cell.addPeaopleCountLabel.text
        //
        //
        //
        //
        //
        //
        //            if(varGetNewLabelValue!.characters.count<=0)
        //            {
        //                cell.allEventsButton.setImage(UIImage(named: "radio_btn_Check"), forState: UIControl.State.Normal)
        //                cell.subGroupEventButton.setImage(UIImage(named: "radio_btn_Uncheck"), forState: UIControl.State.Normal)
        //                cell.membersEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"), forState: UIControl.State.Normal)
        //                varSubGrouporMember=0
        //                annTypeStr="0"
        //            }
        //            else  if string!.rangeOfString("groups") != nil
        //            {
        //                cell.allEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"), forState: UIControl.State.Normal)
        //                cell.subGroupEventButton.setImage(UIImage(named: "radio_btn_Check"), forState: UIControl.State.Normal)
        //                cell.membersEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"), forState: UIControl.State.Normal)
        //                varSubGrouporMember=1
        //                annTypeStr="1"
        //            }
        //            else  if string!.rangeOfString("members") != nil
        //            {
        //                cell.allEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"), forState: UIControl.State.Normal)
        //                cell.subGroupEventButton.setImage(UIImage(named: "radio_btn_Uncheck"), forState: UIControl.State.Normal)
        //                cell.membersEventsButton.setImage(UIImage(named: "radio_btn_Check"), forState: UIControl.State.Normal)
        //                varSubGrouporMember=2
        //                annTypeStr="2"
        //            }
        //            //}
        //        }
        //        /*-----------------------------------------------------------------------------------------------------------*/
        
    }
    
    func changeValueofSelection(_ val:NSString){
        if(val == "0"){
            let cell = cellArray.object(at: 0) as! HeaderCelll
            cell.allEventsButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            cell.subGroupEventButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            cell.membersEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            
            commonIDString=""
            cell.addPeaopleCountLabel.isHidden = true
            cell.editEventButton.isHidden = true
            UserDefaults.standard.set("", forKey: "profID")
            UserDefaults.standard.set("", forKey: "groupsID")
            //addEventTableView.reloadData()
            annTypeStr="0"
        }else if(val == "1")
        {
            // commonIDString=""
            annTypeStr="1"
        }
        else if(val == "2"){
            // commonIDString=""
            annTypeStr="2"
        }
    }
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        
        var items: [UIBarButtonItem]? = [UIBarButtonItem]()
        items?.append(flexSpace)
        items?.append(done)
        
        
        doneToolbar.setItems(items, animated: true)
        doneToolbar.sizeToFit()
        
        addQueTextView.autocorrectionType = .no
        ans1TextField.autocorrectionType = .no
        ans2TextField.autocorrectionType = .no
        
        addQueTextView.inputAccessoryView=doneToolbar
        ans1TextField.inputAccessoryView=doneToolbar
        ans2TextField.inputAccessoryView=doneToolbar
        
    }
    @objc func doneButtonAction()
    {
        addQueTextView.resignFirstResponder()
        ans1TextField.resignFirstResponder()
        ans2TextField.resignFirstResponder()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        displayOnBannerFlag = "1"
        addDoneButtonOnKeyboard()
        picker.setStyle()
        checkRemainder = 0
        if (isCalledFrom=="edit")
        {
            varIsRSVPEnableorDisable = Int(rsvpString)!
            print(varIsRSVPEnableorDisable , rsvpString)
        }

        varISClicked=0
        varNewIndex=50
        varSubGrouporMember=0
        
        UserDefaults.standard.set("no", forKey: "session_IsComingFromPop")
        
        cellArray=[]
        editOrNot = false
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
        addQueTextView.text = ""
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.AllRSVPBAction), name: NSNotification.Name(rawValue: "AllRSVP"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.SubGroupsRSVPBAction), name: NSNotification.Name(rawValue: "SubGroupRSVP"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.MembersRSVPBAction), name: NSNotification.Name(rawValue: "MembersRSVP"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.EditEvenBAction), name: NSNotification.Name(rawValue: "EditEvent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: "hideNotifyCellFunction", name: NSNotification.Name(rawValue: "hideNotifyCell"), object: nil)
        selectedImg=UIImageView()
        imagePicker.delegate = self
        ImsgId=""
        
        if(isCalledFrom == "add")
        {
            annTypeStr="0"
            addEventBtn.setTitle("Add",  for: UIControl.State.normal)
            cellArray=[]
            createCEll()
        }
        else
        {
            addEventBtn.setTitle("Update",  for: UIControl.State.normal)
            cellArray=[]
            createCEllWithData()
           
        }
        print("isCalledFrom---\(isCalledFrom)")
        if((isCalledFrom == "add" || isCalledFrom == "edit") && isCategory=="1")
        {
            getClubDetails(groupID as! NSString)
        }
        
        
        // Check the First RSVP value and on off switch in Case of Edit Events
        let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
        if(isCalledFrom=="edit" )
        {
            print("-----------------------*************",varIsRSVPEnableorDisable)
            if(varIsRSVPEnableorDisable==0)
            {
                cellAddQue!.questionSwitch.isOn=false
            }
            else
            {
                if(eventsDetails.questionId as String? != "")
                {
                    cellAddQue!.questionSwitch.isOn=true
                    cellAddQue!.questionSwitchNew.isOn=true
                }
                else
                {
                    cellAddQue!.questionSwitch.isOn=true
                    cellAddQue!.questionSwitchNew.isOn=false
                }
            }
        }
        addEventTableView.reloadData()
    }
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        if (isCalledFrom=="edit")
        {
            self.title="Events"
        }
        else
        {
            self.title=moduleName
        }
        
        
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue.png"),  for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AddEventsController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        // self.navigationController?.navigationBar.barTintColor = UIColor(red: 51/255.0, green: 153/255.0, blue: 255/255.0, alpha: 1.0)
        // let attributes = [NSFontAttributeName : UIFont(name: "Roboto-Regular", size: 17)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        // self.navigationController!.navigationBar.titleTextAttributes = attributes
    }
    
     @objc func backClicked()
    {
        let cell = cellArray.object(at: 0) as! HeaderCelll
        if(cell.eventTitleField.text!.characters.count > 0){
            let alertController = UIAlertController(title: "", message:
                "Your changes are not saved, are you sure you want to go back?", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default,handler:  {(alert :UIAlertAction!) in
                self.addQueTextView.text = "Tap to add Question"
                self.navigationController?.popViewController(animated: true)
            }))
            
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }else{
            addQueTextView.text = "Tap to add Question"
            self.navigationController?.popViewController(animated: true)
        }
    }
    
   
    func changeValueofSelectionAll(_ val:NSString){
        let cell = cellArray.object(at: 4) as! SmsQuestionCell
        let cellSchedule1 = cellArray.object(at: 2) as? ScheduleCell
        
        if(self.SMSCountStr == "0" || self.SMSCountStr == "")
        {
            allSMSFlag="0"
            nonSmartSMSFlag="0"
            
//            cell.allMemSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
            cell.whatsappRadioBtn.isOn = false
            cell.nonSmartSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
            
            let alert = UIAlertController(title: self.titleRIZone, message: "Balance WhatsApp count is 0. Please recharge", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else
        {
            if(val == "0"){
                allSMSFlag="0"
                displayOnBannerFlag="1"
                print("1111111111111111111111111111",displayOnBannerFlag)
                cell.whatsappRadioBtn.isOn = true
                // nonSmartSMSFlag="0"
                // cell.allMeçmSMSButton.setImage(UIImage(named: "CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
                // cell.nonSmartSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
            }else{
                let cellH : HeaderCelll = cellArray.object(at: 0) as! HeaderCelll
                print("Character length::\(cellH.eventDescTextView.text.count)")
                if cellH.eventDescTextView.text.count <= 0
                {
                    allSMSFlag="0"
                    displayOnBannerFlag="0"
                    let cells : SmsQuestionCell = cellArray.object(at: 4) as! SmsQuestionCell
//                    cells.allMemSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
                    cells.whatsappRadioBtn.isOn = false
                    //cells.nonSmartSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), for: UIControl.State.normal)
                    cellH.eventDescTextView.becomeFirstResponder()
                    
                    let alert = UIAlertController(title: "Rotary India", message: "Please enter description.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
                    alert.addAction(ok)
                    present(alert, animated: true, completion: nil)
                }
//                else if cell.eventDescTextView.text.count > 2000
//                {
//                    allSMSFlag="0"
//                    displayOnBannerFlag="0"
//                    let cells : SmsQuestionCell = cellArray.object(at: 4) as! SmsQuestionCell
//                    cells.allMemSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
//
//                    let alert = UIAlertController(title: "Rotary India", message: "Description cannot be more than 2000 characters for SMS.", preferredStyle: .alert)
//                    let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
//                    alert.addAction(ok)
//                    present(alert, animated: true, completion: nil)
//                }
//                else if(cellSchedule1!.dateButton.titleLabel?.text == "Select Date")
//                {
//                    allSMSFlag="0"
//                    displayOnBannerFlag="0"
//                    let cells : SmsQuestionCell = cellArray.object(at: 4) as! SmsQuestionCell
//                    cells.allMemSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
//
//                    let alert = UIAlertController(title: "Rotary India", message: "Please enter publish date.", preferredStyle: .alert)
//                    let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
//                    alert.addAction(ok)
//                    present(alert, animated: true, completion: nil)
//                }
                else
                {
                    cell.whatsappRadioBtn.isOn = false
                    displayOnBannerFlag="1"
                    allSMSFlag="1"
                    nonSmartSMSFlag="0"
                    //call api here only
                    if isCategory=="1"
                    {
                    //getSMSCountdetails()
                    }
                }
            }
        }
    }
    
    
    func changeValueofSelectionAllBackup1(_ val:NSString){
        let cell = cellArray.object(at: 4) as! SmsQuestionCell
        let cellSchedule1 = cellArray.object(at: 2) as? ScheduleCell
        
        if(self.SMSCountStr == "0" || self.SMSCountStr == "")
        {
            allSMSFlag="0"
            nonSmartSMSFlag="0"
           
//            cell.allMemSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
            cell.whatsappRadioBtn.isOn = false
            cell.nonSmartSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
            
            let alert = UIAlertController(title: "Rotary India", message: "Balance WhatsApp count is 0. Please recharge", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else
        {
        if(val == "0"){
            allSMSFlag="0"
            displayOnBannerFlag="1"
            print("1111111111111111111111111111",displayOnBannerFlag)
            // nonSmartSMSFlag="0"
            // cell.allMeçmSMSButton.setImage(UIImage(named: "CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
            // cell.nonSmartSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
        }else{
            let cell : HeaderCelll = cellArray.object(at: 0) as! HeaderCelll
            
                displayOnBannerFlag="1"
                allSMSFlag="1"
                nonSmartSMSFlag="0"
                //call api here only
          }
        }
    }
    
    func getPublishDateFlag() -> String
    {
     let cellSchedule1 = cellArray.object(at: 2) as? ScheduleCell
        let publishDate:String = String(format:"%@ %@",(cellSchedule1!.dateButton.titleLabel?.text)!,(cellSchedule1!.timeButton.titleLabel?.text)!)
        if publishDate != nil && publishDate != ""
        {
        if isDateIsNextToCurrentDate(dateInString: publishDate)
        {
            return "1"
        }
        else
        {
           return "0"
        }
        }
        return "NA"
    }
    
    func isDateIsNextToCurrentDate(dateInString : String) -> Bool
    {
        //"2019-07-09 12:54:00"
        //2019-07-11 12:00:00
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat="dd/MM/yyyy HH:mm"
        dateFormatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let dateInDate = dateFormatter.date(from:dateInString)!
        let currentDate = Date()
        if (dateInDate.compare(currentDate) == .orderedDescending )
        {
            // dateInDate is greater than current date.
            return true
        }
        // you can proceed.. date validation is correct.
        return false
    }
    
    func getRemiderCount() -> String
    {
        var allrepeatDateTime : NSMutableArray = NSMutableArray()
        var repeatCount:Int=0
        if(cellArray.count>7){
            for index in 8 ..< cellArray.count {
                let cellSchedule2 = cellArray.object(at: index) as! RepeatDateTimeCell
                var repeatDateTime : String!
                
                repeatDateTime=String(format:"%@ %@",(cellSchedule2.repeatDateButton.titleLabel?.text)!,(cellSchedule2.repeatTimeButton.titleLabel?.text)!)
                print("repeatDateTime in loop \(repeatDateTime)")
                if(repeatDateTime != "Select Date and Time")
                {
                    allrepeatDateTime.add(repeatDateTime)
                }
            }
        }
        
        if allrepeatDateTime.count>0
        {
            for i in 0 ..< allrepeatDateTime.count
            {
                print("allrepeatDateTime \(allrepeatDateTime[i])")
            if self.isDateIsNextToCurrentDate(dateInString: allrepeatDateTime.object(at: i) as! String)
               {
                //reminder date is greater than current date
                repeatCount=repeatCount+1
               }
                else
               {
                //reminder date is less than current date
               }
            }
        }
        return String(repeatCount)
    }

    func getSMSCountdetails()
    {
        let headerCell:HeaderCelll = cellArray.object(at: 0) as! HeaderCelll
        let descCount:String=String(headerCell.eventDescTextView.text!.count)
        
        let url:String=baseUrl+row_Getsmscountdetails;
        let parameters : [String : Any] = ["p_RecipientType":self.annTypeStr!,"p_InputIDs":self.commonIDString as NSString as NSString,"P_fk_Group_masterid":self.groupID as! NSString,"p_DescriptionCount":descCount,"p_Remindercount":self.getRemiderCount(),"p_TransType":"E","p_PublishDateFlag":self.getPublishDateFlag()]
        print("SMS COUNT PARAMETERS: \(parameters)")
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            wsm.getSMSCountDetailWebService(url: url, parameter: parameters)
        }
        else
        {
            
        }
    }
    
    func getSMSCountdetailsDelegateFunction(_ TBsmscountResult: NSDictionary) {
        print("GetSMS count listing:: \(TBsmscountResult)")
        let smsResult = (TBsmscountResult.value(forKey: "TBsmscountResult") as AnyObject).value(forKey: "smsResult") as! String
        let cells : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
        let smsperuser = (TBsmscountResult.value(forKey: "TBsmscountResult") as AnyObject).value(forKey: "smsperuser") as! NSNumber
        
        if smsperuser != nil
        {
            cells.lblNoMSGUser.text="No of message per user : \(smsperuser)"
        }
        else{
            cells.lblNoMSGUser.text=""
        }
        
        if smsResult.count>0
        {
            let alert1 = UIAlertController(title: "Rotary India", message: smsResult, preferredStyle: UIAlertController.Style.alert)
            alert1.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                self.allSMSFlag="0"
                self.displayOnBannerFlag="1"
//                cells.allMemSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
                cells.whatsappRadioBtn.isOn = false
            }));
            self.present(alert1, animated: true, completion: nil)
       }
       else
       {
        if isFromAddUpdateEventButton
        {
            self.AddUpdateEvent()
        }
       }
        
        isFromAddUpdateEventButton=false
    }
    
    
    func changeValueofSelectionnonSmartSMSButton(_ val:NSString){
        let cell = cellArray.object(at: 4) as! SmsQuestionCell
        
        
        if(self.SMSCountStr == "0" || self.SMSCountStr == "")
        {
            allSMSFlag="0"
            nonSmartSMSFlag="0"
            cell.whatsappRadioBtn.isOn = false
//            cell.allMemSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
            cell.nonSmartSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), for: UIControl.State.normal)
            let alert = UIAlertController(title: "Rotary India", message: "Balance WhatsApp count is 0. Please recharge", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else
        {
        
        if(val == "0"){
            nonSmartSMSFlag="0"
            // nonSmartSMSFlag="0"
            // cell.allMemxvc SMSButton.setImage(UIImage(named: "CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
            // cell.nonSmartSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
        }else{
            nonSmartSMSFlag="1"
            allSMSFlag="0"
            // nonSmartSMSFlag="1"
            //cell.alldfMemSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
            //cell.nonSmartSMSButton.setImage(UIImage(named: "CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
         }
      }
    }
     @objc func AllRSVPBAction()
    {
        print("ALL")
        commonIDString=""
    }
    
    @objc func SubGroupsRSVPBAction()
    {
        print("SubGroups")
        
        functionForButtonSubGroupClickEvent()
        
        //        let SubGroupController = self.storyboard?.instantiateViewControllerWithIdentifier("sub_group1") as! SubGroupListController
        //        SubGroupController.groupIDX = groupID
        //        SubGroupController.isCalledFrom="add"
        //        //        let pointsArr = commonIDString.componentsSeparatedByString(",")
        //        //        SubGroupController.groupIdsArray=NSMutableArray(array: pointsArr)
        //
        //
        //
        //        print(commonIDString)
        //        print(varSubGrouporMember)
        //
        //        if(varSubGrouporMember==0 || varSubGrouporMember==1)
        //        {
        //            if(commonIDString == "")
        //            {
        //                SubGroupController.groupIdsArray=NSMutableArray()
        //            }
        //            else
        //            {
        //                let pointsArr = commonIDString.componentsSeparatedByString(",")
        //                print("commonstr \(commonIDString)")
        //                SubGroupController.groupIdsArray=NSMutableArray(array: pointsArr).mutableCopy() as! NSMutableArray
        //            }
        //        }
        //        else
        //        {
        //            SubGroupController.groupIdsArray=NSMutableArray()
        //
        //        }
        //        SubGroupController.isCalledFrom=isCalledFrom
        //        self.navigationController?.pusdfshViewController(SubGroupController, animated: true)
        
        
        
        /*-----------------------------------------------------------*/
        
        /*----------------------------------------------------*/
        
        
    }
    
    @objc func MembersRSVPBAction()
    {
        print("members")
        functionForButtonMemberClickEvent()
        //        let MembersController = self.storyboard?.instantiateViewControllerWithIdentifier("edit_directory") as! EditDirectoryController
        //        MembersController.groupIDX = groupID
        //        //        let pointsArr = commonIDString.componentsSeparatedByString(",")
        //        //        MembersController.profileIdsArray=NSMutableArray(array: pointsArr)
        //
        //        print(commonIDString)
        //        print(varSubGrouporMember)
        //
        //        if(varSubGrouporMember==0 || varSubGrouporMember==2)
        //        {
        //            if(commonIDString == "")
        //            {
        //                MembersController.profileIdsArray=NSMutableArray()
        //                MembersController.isCalledFRom="add"
        //            }
        //
        //            else
        //            {
        //                let pointsArr = commonIDString.componentsSeparatedByString(",")
        //                print("commonstr \(commonIDString)")
        //                MembersController.profileIdsArray=NSMutableArray(array: pointsArr).mutableCopy() as! NSMutableArray
        //                MembersController.isCalledFRom="edit"
        //            }
        //        }
        //        else
        //        {
        //            MembersController.profileIdsArray=NSMutableArray()
        //            MembersController.isCalledFRom="add"
        //        }
        //
        //        self.navigationController?.psdfushViewController(MembersController, animated: true)
        //
        
    }

    /*------------------------------*/
    
    
    func functionForButtonMemberClickEvent()
    {
        print("members")
        
        let MembersController = self.storyboard?.instantiateViewController(withIdentifier: "edit_directory") as! EditDirectoryController
        MembersController.groupIDX = groupID
        
        
        //        let pointsArr = commonIDString.componentsSeparatedByString(",")
        //        MembersController.profileIdsArray=NSMutableArray(array: pointsArr)
        
        print(commonIDString)
        print(varSubGrouporMember)
        MembersController.groupProfileID=self.groupProfileID
        if(varSubGrouporMember==0 || varSubGrouporMember==2)
        {
            if(commonIDString == "")
            {
                MembersController.profileIdsArray=NSMutableArray()
                MembersController.isCalledFRom="addEvent"
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
            MembersController.isCalledFRom="addEvent"
        }
        
        self.navigationController?.pushViewController(MembersController, animated: true)
    }
    
    func functionForButtonSubGroupClickEvent()
    {
        print("SubGroups")
        
        let SubGroupController = self.storyboard?.instantiateViewController(withIdentifier: "sub_group1") as! SubGroupListController
        SubGroupController.groupIDX = groupID
        SubGroupController.isCalledFrom="add"
        //        let pointsArr = commonIDString.componentsSeparatedByString(",")
        //        SubGroupController.groupIdsArray=NSMutableArray(array: pointsArr)
        
        
        
        print(commonIDString)
        print(varSubGrouporMember)
        
        if(varSubGrouporMember==0 || varSubGrouporMember==1)
        {
            if(commonIDString == "")
            {
                SubGroupController.groupIdsArray=NSMutableArray()
            }
            else
            {
                let pointsArr = commonIDString.components(separatedBy: ",")
                print("commonstr \(commonIDString)")
                SubGroupController.groupIdsArray=NSMutableArray(array: pointsArr).mutableCopy() as! NSMutableArray
            }
        }
        else
        {
            SubGroupController.groupIdsArray=NSMutableArray()
            
        }
        SubGroupController.isCalledFrom=isCalledFrom
        self.navigationController?.pushViewController(SubGroupController, animated: true)
        
        
        
    }
    
    
    
    
    
    
    func functionForAllGroupMemberSetting(){
        
        
        let defaults = UserDefaults.standard
        let country =  defaults.object(forKey: "eventAddress") as! String
        if (country != "") {
            //eventAddress
            let cell = cellArray.object(at: 0) as! HeaderCelll
            cell.eventVenueTextView.text = country
            
            venueLat = UserDefaults.standard.value(forKey: "eventLat") as! String as NSString
            venueLon = UserDefaults.standard.value(forKey: "eventLon") as! String as NSString
            
            defaults.set("", forKey: "eventAddress")
            defaults.set("", forKey: "eventLat")
            defaults.set("", forKey: "eventLon")
            defaults.synchronize()
        }
        
        
        let tabledata =  defaults.array(forKey: "profID")
        let tabledata1 = UserDefaults.standard.array(forKey: "groupsID")
        if tabledata?.count > 0
        {
            UserDefaults.standard.set("", forKey: "groupsID")
            UserDefaults.standard.set("", forKey: "profID")
            print(tabledata!)
            print(tabledata!.count)
            
            let array = tabledata! as NSArray
            
            count = array.count
            
            commonIDString = array.componentsJoined(by: ",")
            print(commonIDString)
            
            // let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            let cell = cellArray.object(at: 0) as! HeaderCelll
            
            cell.addPeaopleCountLabel.isHidden = false
            cell.editEventButton.isHidden = true//false
            cell.addPeaopleCountLabel.text = String(format:"You have added %d members",count)
            cell.membersEventsButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            cell.allEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            cell.subGroupEventButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            annTypeStr="2"
            varSubGrouporMember=2
            
        }
        else if tabledata1?.count > 0
        {
            UserDefaults.standard.set("", forKey: "profID")
            UserDefaults.standard.set("", forKey: "groupsID")
            print(tabledata1!)
            print(tabledata1!.count)
            
            let array = tabledata1! as NSArray
            
            countGroups = array.count
            
            commonIDString = array.componentsJoined(by: ",")
            print(commonIDString)
            
            
            let cell = cellArray.object(at: 0) as! HeaderCelll
            cell.addPeaopleCountLabel.isHidden = false
            cell.editEventButton.isHidden = true//false
            cell.addPeaopleCountLabel.text = String(format:"You have added %d groups",countGroups)
            cell.subGroupEventButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            cell.allEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            cell.membersEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            annTypeStr="1"
            varSubGrouporMember=1
        }
        else
        {
            //             if(isCalledFrom == "add"){
            //            let cell = cellArray.objectAtIndex(0) as! HeaderCelll
            //            cell.allEventsButton.setImage(UIImage(named: "rbtn_select.png"), forState: UIControl.State.Normal)
            //            cell.subGroupEventButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
            //            cell.membersEventsButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
            //
            //
            //            cell.addPeaopleCountLabel.hidden = true
            //            cell.editEventButton.hidden = true
            //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "profID")
            //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "groupsID")
            //            //addEventTableView.reloadData()
            //            annTypeStr="0"
            //            }
        }
        
        if(commonIDString=="")
        {
            let cell = cellArray.object(at: 0) as! HeaderCelll
            cell.allEventsButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            cell.subGroupEventButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            cell.membersEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            
            commonIDString=""
            cell.addPeaopleCountLabel.isHidden = true
            cell.editEventButton.isHidden = true
            UserDefaults.standard.set("", forKey: "profID")
            UserDefaults.standard.set("", forKey: "groupsID")
            cell.addPeaopleCountLabel.text=""
        }
        else
        {
            let cell = cellArray.object(at: 0) as! HeaderCelll
            //            cell.allEventsButton.setImage(UIImage(named: "rbtn_select.png"), forState: UIControl.State.Normal)
            //            cell.subGroupEventButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
            //            cell.membersEventsButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
            //
            // commonIDString=""
            cell.addPeaopleCountLabel.isHidden = false
            cell.editEventButton.isHidden = false
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
            let cell = cellArray.object(at: 0) as! HeaderCelll
            // if((cell.addPeaopleCountLabel.text)? = nil)
            // {
            var varGetNewLabelValue:String?=cell.addPeaopleCountLabel.text
            
            print(varGetNewLabelValue)
            let string = cell.addPeaopleCountLabel.text

            if(varGetNewLabelValue!.characters.count<=0)
            {
                cell.allEventsButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                cell.subGroupEventButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                cell.membersEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                selectRecipientTypeEditMode = "All"
                varSubGrouporMember=0
                annTypeStr="0"
                cell.addPeaopleCountLabel.isHidden = true
                cell.editEventButton.isHidden = true
            }
            else  if string!.range(of: "groups") != nil
            {
                cell.allEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                cell.subGroupEventButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                cell.membersEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                selectRecipientTypeEditMode = "Group"
                varSubGrouporMember=1
                annTypeStr="1"
            }
            else  if string!.range(of: "members") != nil
            {
                cell.allEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                cell.subGroupEventButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                cell.membersEventsButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                selectRecipientTypeEditMode = "Member"
                varSubGrouporMember=2
                annTypeStr="2"
            }
            //}
        }
        /*-----------------------------------------------------------------------------------------------------------*/
        
    }
    
    
    
    /*--------------------------------------------*/
    @objc func EditEvenBAction()
    {
        print("EditEvent")
        
        if(selectRecipientTypeEditMode == "Group")
        {
            functionForButtonSubGroupClickEvent()
        }
        else if (selectRecipientTypeEditMode == "Member")
        {
            functionForButtonMemberClickEvent()
        }
        else
        {
            
        }
        functionForAllGroupMemberSetting()
        print("EditEvent")
        
        
    }
    
    @objc func OpenGallaryBAction()
    {
        
        self.view.endEditing(true)
        if isCalledFrom == "edit"
        {
            if( ImsgId != "" )
            {
                let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Remove photo","Change photo")
                actionSheet.tag = 0
                //actionSheet.delegate = self
                actionSheet.show(in: self.view)
            }
                
                
            else  if( eventsDetails.eventImg=="")
            {
                let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Add Photo")
                actionSheet.tag = 0
                //actionSheet.delegate = self
                actionSheet.show(in: self.view)
            }
            else if(DeleteImageComeFromEdit=="Delete")
            {
                let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Add Photo")
                actionSheet.tag = 0
                //actionSheet.delegate = self
                actionSheet.show(in: self.view)
            }
            else
            {
                let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Remove photo","Change photo")
                actionSheet.tag = 0
                //actionSheet.delegate = self
                actionSheet.show(in: self.view)
            }
            
            
        }
        else
        {
            if(ImsgId=="")
            {
                let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
                actionSheet.tag = 1
                actionSheet.show(in: self.view)
            }
            else
            {
                let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo","Remove Photo")
                actionSheet.tag = 1
                actionSheet.show(in: self.view)
            }
            
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
                
                if(isCalledFrom=="edit")
                { if( ImsgId != "")
                {
                    let wsm : WebserviceClass = WebserviceClass.sharedInstance
                    wsm.delegates=self
                    wsm.DeletePhotoEdit(TypeIDEdit as String, grpID: groupID, type: "Event",moduleId: "")//avinash
                }
                    
                    
                else  if( eventsDetails.eventImg=="")
                {
                    let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
                    actionSheet.tag = 1
                    actionSheet.show(in: self.view)
                }
                else if(DeleteImageComeFromEdit=="Delete")
                {
                    let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
                    actionSheet.tag = 1
                    actionSheet.show(in: self.view)
                }
                else
                {
                    let wsm : WebserviceClass = WebserviceClass.sharedInstance
                    wsm.delegates=self
                    wsm.DeletePhotoEdit(TypeIDEdit as String, grpID: groupID, type: "Event",moduleId: "")//avinash
                    }
                }
                else
                {
                    if(ImsgId=="")
                    {
                        let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
                        actionSheet.tag = 1
                        actionSheet.show(in: self.view)
                    }
                    else
                    {
                        let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo","Remove Photo")
                        actionSheet.tag = 1
                        actionSheet.show(in: self.view)
                    }
                }
                
                
                
            case 2:
                
                let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
                actionSheet.tag = 1
                actionSheet.show(in: self.view)
                
            default:
                print("Default")
                //Some code here..
                
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
                self.imagePicker.allowsEditing = true //dpk
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.modalPresentationStyle = .popover
                
                self.present(self.imagePicker, animated: true, completion: nil)
                
            case 2:
                openCamera()
                //shows the camera
                //                self.imagePicker.allowsEditing = true
                //                self.imagePicker.sourceType = .Camera
                //
                //                self.imagePicker.modalPresentationStyle = .Popover
                //
                //                self.presentViewController(self.imagePicker, animated: true, completion: nil)
                
            case 3:
                let cell = cellArray.object(at: 0) as! HeaderCelll
                cell.EventProfilePic.image = UIImage(named: "addevent.png")
                ImsgId = ""
                
            default:
                print("Default")
                //Some code here..
            }
        }
    }
    
    func DeletePhotoDelegateFunction(_ dltPhoto : DeleteResult)
    {
        DeleteImageComeFromEdit = "Delete"
        print(dltPhoto.status)
        if(dltPhoto.status=="0")
        {
            ImsgId=""
        }
        let cell = cellArray.object(at: 0) as! HeaderCelll
        cell.EventProfilePic.image = UIImage(named: "addevent.png")
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
    
    
    /*----------------------------------Code by DPk-----Image Compress------------------------------------------*/
    func compressImage (_ image: UIImage) -> UIImage {
        let actualHeight:CGFloat = image.size.height
        let actualWidth:CGFloat = image.size.width
        let imgRatio:CGFloat = actualWidth/actualHeight
        let maxWidth:CGFloat = 1024.0
        let resizedHeight:CGFloat = maxWidth/imgRatio
        let compressionQuality:CGFloat = 0.6
        let rect:CGRect = CGRect(x: 0, y: 0, width: maxWidth, height: resizedHeight)
        UIGraphicsBeginImageContext(rect.size)
        //image.drawInRect(CGRect)
        image.draw(in: rect)
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData:Data = img.jpegData(compressionQuality: compressionQuality)!
        let imageSize: Int = imageData.count
        print("size of image in KB: %f ", Double(imageSize) / 1024.0)
        UIGraphicsEndImageContext()
        return UIImage(data: imageData)!
    }
    /*---------------------Code by DPk------------------------------------------------------*/
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any])
    {
        
        let cell = cellArray.object(at: 0) as! HeaderCelll
        var chosenImage:UIImage! //2
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            chosenImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chosenImage = possibleImage
        }
        self.selectedImg.contentMode = .scaleAspectFit //-----------DPK
        selectedImg.image=chosenImage
        cell.EventProfilePic.image=selectedImg.image
        //loaderViewMethod()
        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
        wsm.delegate=self
        let varGetImage:UIImage =  self.compressImage(selectedImg.image!)
        let imageData: Data = varGetImage.jpegData(compressionQuality: 0.6)! //UIImageJPEGRepresentation(varGetImage, 0.6)!  //(varGetImage)!
        let imageSize: Int = imageData.count
        print("size of image in KB: %f ", Double(imageSize) / 1024.0)
        
        // let imageData: NSData = UIImagePNGRepresentation(selectedImg.image!)!
        wsm.uploadToServer(usingImage: imageData, andFileName: "event", moduleName: "event")
        //  cell.EventProfilePic.contentMode = .ScaleAspectFit
        dismiss(animated: true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func getUploadImgSucceeded(_ response: LoadImageResult)
    {
        
        if response.status == "0"
        {
            DeleteImageComeFromEdit=""
            ImsgId=response.imageID as! NSString;
           // window=nil;
        }
        else
        {
           // window=nil;
            /*
             let alert = UIAlertController(title: "TMC", message: "Image Upload failed, Please try Again!", preferredStyle: UIAlertController.Style.Alert)
             alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Cancel, handler:nil))
             self.presentViewController(alert, animated: true, completion: nil)
             */
            
            
            self.view.makeToast("Image Upload failed, Please try again!", duration: 2, position: CSToastPositionCenter)
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return cellArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(indexPath.row == 0)
        {
            return 635.0
        }
        if(indexPath.row >= 1 && indexPath.row <= 3)
        {
            return 98.0
        }
        if(indexPath.row == 4)
        {
            return 154.0
        }
        if(indexPath.row == 5)
        {
            return 0
        }
        if(indexPath.row == 6)
        {
            
            print("this is index six from user:----------")
            print(addQueTextView.text)
            if addQueTextView.text != "Tap to add Question"
            {
                // addEventTableView.rowHeight = UITableView.automaticDimension
                //  addEventTableView.estimatedRowHeight = 110
                return 110.0
            }
            else
            {
                return 0.0
            }
        }
        
        if(indexPath.row == 7)
        {
            return 109.0
        }
        
        if(indexPath.row > 7)
        {
            return 58.0
        }
        return 58.0
    }
    
    @objc func DateTimeShowAction(_ sender:UIButton)
    {
        
        
        let cell = cellArray.object(at: 0) as! HeaderCelll
        cell.eventVenueTextView.resignFirstResponder()
        cell.eventDescTextView.resignFirstResponder()
        cell.eventTitleField.resignFirstResponder()
        
        
        myview.removeFromSuperview()
        myview = UIView(frame: CGRect(x: 0,y: 100, width: self.view.frame.size.width, height: 280));
        myview.backgroundColor=UIColor.white;
        // myview.layer.cornerRadius = 10;
        // myview.layer.borderWidth=2;
        self.view.addSubview(myview);
        
        
        picker = UIDatePicker(frame: CGRect(x: 0, y: 42 , width: myview.frame.width, height: 236))
        picker.setStyle()
        picker.backgroundColor = .white
        picker.tag = sender.tag
        picker.addTarget(self, action: #selector(self.dateValueChanged(_:)), for: UIControl.Event.valueChanged)
        //        if(self.isCalledFrom == "add"){
        //        let currentDate = NSDate()  //5 -  get the current date
        //        picker.minimumDate = currentDate  //6- set the current date/time as a minimum
        //        picker.date = currentDate
        //        }
        
        //        picker.date = currentDate
        
        
        ///event code
//        let cell = cellArray.object(at: sender.tag) as! ScheduleCell
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
//        let strDate = dateFormatter.string(from: picker.date)
//
//        if picker.tag == 2
//        {
//            PublishDate = picker.date
//        }
//        else if picker.tag == 3
//        {
//            ExpiryDate = picker.date
//        }
//        else{}
//
//        let strSplit = strDate.characters.split(separator: " ")
//        let Date = String(strSplit.first!)
//        let time = String(strSplit.last!)
//
//        print(Date)
//        print(time)
//
//        cell.dateButton.setTitle(Date,  for: UIControl.State.normal)
//        cell.timeButton.setTitle(time,  for: UIControl.State.normal)
//
//
       
        let cellSchedule1 = cellArray.object(at: 2) as? ScheduleCell
        print(String(format:"Publish : %@ %@",(cellSchedule1!.dateButton.titleLabel?.text)!,(cellSchedule1!.timeButton.titleLabel?.text)!))
        let cellSchedule2 = cellArray.object(at: 3) as? ScheduleCell
        print(String(format:"Expiry : %@ %@",(cellSchedule2!.dateButton.titleLabel?.text)!,(cellSchedule2!.timeButton.titleLabel?.text)!))
        
        
        
        
        
        
//        if let str = eventsDetails.pubDate as String?
//        {
            if sender.tag == 3
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
                //dateFormatter.timeZone = NSTimeZone(name: "UTC")
                
//                let dateFormatter = DateFormatter()
//                       dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
                       let strDate = dateFormatter.string(from: picker.date)
                
                
                let strSplit = strDate.characters.split(separator: " ")
                       let Date = String(strSplit.first!)
                       let time = String(strSplit.last!)
//                let date = dateFormatter.date(from: eventsDetails.expiryDate)
//                picker.setDate(date!, animated: false)
                let cellSchedule2 = cellArray.object(at: 3) as? ScheduleCell
                
                print(Date)
                      print(time)
              //
                
                
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:00"
                //dateFormatter1.timeZone = NSTimeZone(name: "UTC")
                let datstr = dateFormatter1.date(from: strDate)
                cellSchedule2!.addedDate=(datstr as! NSDate) as Date!;
                
                
                
                
//                cellSchedule2!.addedDate=(strDate as! NSDate) as Date!;
                cellSchedule2!.dateButton.setTitle(Date,  for: UIControl.State.normal)
                cellSchedule2!.timeButton.setTitle(time,  for: UIControl.State.normal)
              //
                
                
                print(String(format:"Event : %@ %@",(cellSchedule2!.dateButton.titleLabel?.text)!,(cellSchedule2!.timeButton.titleLabel?.text)!))
                
            }
            else if sender.tag == 1
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
                //dateFormatter.timeZone = NSTimeZone(name: "UTC")
                
//                let dateFormatter = DateFormatter()
//                       dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
                       let strDate = dateFormatter.string(from: picker.date)
                
                let strSplit = strDate.characters.split(separator: " ")
                       let Date = String(strSplit.first!)
                       let time = String(strSplit.last!)
//                let date = dateFormatter.date(from: eventsDetails.expiryDate)
//                picker.setDate(date!, animated: false)
                let cellSchedule0 = cellArray.object(at: 1) as? ScheduleCell
                
                print(Date)
                      print(time)
              //
                
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:00"
                //dateFormatter1.timeZone = NSTimeZone(name: "UTC")
                let datstr = dateFormatter1.date(from: strDate)
                cellSchedule0!.addedDate=(datstr as! NSDate) as Date!;
                
                
                
//                cellSchedule0!.addedDate=(strDate as! NSDate) as Date!;
                cellSchedule0!.dateButton.setTitle(Date,  for: UIControl.State.normal)
                cellSchedule0!.timeButton.setTitle(time,  for: UIControl.State.normal)
              //
                
                
                print(String(format:"Event : %@ %@",(cellSchedule0!.dateButton.titleLabel?.text)!,(cellSchedule0!.timeButton.titleLabel?.text)!))
                
            }
            else if sender.tag == 2
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
                //dateFormatter.timeZone = NSTimeZone(name: "UTC")
                
//                let dateFormatter = DateFormatter()
//                       dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
                       let strDate = dateFormatter.string(from: picker.date)
                
                let strSplit = strDate.characters.split(separator: " ")
                       let Date = String(strSplit.first!)
                       let time = String(strSplit.last!)
//                let date = dateFormatter.date(from: eventsDetails.expiryDate)
//                picker.setDate(date!, animated: false)
                let cellSchedule1 = cellArray.object(at: 2) as? ScheduleCell
                
                print(Date)
                      print(time)
              //
                
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:00"
                //dateFormatter1.timeZone = NSTimeZone(name: "UTC")
                let datstr = dateFormatter1.date(from: strDate)
                cellSchedule1!.addedDate=(datstr as! NSDate) as Date!;
                
                
                
                
//                cellSchedule1!.addedDate=(strDate as! NSDate) as Date!;
                cellSchedule1!.dateButton.setTitle(Date,  for: UIControl.State.normal)
                cellSchedule1!.timeButton.setTitle(time,  for: UIControl.State.normal)
              //
                
                
                print(String(format:"Event : %@ %@",(cellSchedule1!.dateButton.titleLabel?.text)!,(cellSchedule1!.timeButton.titleLabel?.text)!))
                
            }
            else{
                
            }
//        }
//        else
//        {
//
//        }
        
        
        toolBar.frame = CGRect(x: 0, y: 0 , width: view.frame.width, height: 50)
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        // let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.Plain, target: self, action: #selector(AddEventsController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        myview.addSubview(toolBar)
        myview.addSubview(picker)
        
    }
    
    @objc func donePicker()
    {
        myview.removeFromSuperview()
        
    }
    
    @objc func dateValueChanged(_ sender:UIDatePicker)
    {
        
        let  cellSchedule = cellArray.object(at: sender.tag) as! ScheduleCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        let strDate = dateFormatter.string(from: sender.date)
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:00"
        //dateFormatter1.timeZone = NSTimeZone(name: "UTC")
        let datstr = dateFormatter1.date(from: strDate)
        cellSchedule.addedDate=(datstr as! NSDate) as Date!;
        let strSplit = strDate.characters.split(separator: " ")
        let Date = String(strSplit.first!)
        let time = String(strSplit.last!)
        print(String(format:"Date :::: %@",Date))
        print(String(format:"Time :::: %@",time))
        
        cellSchedule.dateButton.setTitle(Date,  for: UIControl.State.normal)
        cellSchedule.timeButton.setTitle(time,  for: UIControl.State.normal)
        
        
        
        
//        let cell = cellArray.object(at: sender.tag) as! ScheduleCell
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
//        let strDate = dateFormatter.string(from: sender.date)
//        
//        if sender.tag == 2
//        {
//            PublishDate = sender.date
//        }
//        else if sender.tag == 3
//        {
//            ExpiryDate = sender.date
//        }
//        else{}
//        let strSplit = strDate.characters.split(separator: " ")
//        let Date = String(strSplit.first!)
//        let time = String(strSplit.last!)
//        
//        print(Date)
//        print(time)
//        
//        cell.dateButton.setTitle(Date,  for: UIControl.State.normal)
//        cell.timeButton.setTitle(time,  for: UIControl.State.normal)
//        
//        
        
        
        
        
        
        
        
        
        //  addEventTableView.reloadData()
        
    }
    
    func createCEll(){
        
        for index in 0 ..< 8 {
            
            if(index==0){
                
                var  cell = self.addEventTableView.dequeueReusableCell(withIdentifier: "headerCell") as? HeaderCelll
                if(cell == nil){
                    //  var objects: NSArray?;
                    cell =  Bundle.main.loadNibNamed("headerCell", owner: self, options: nil)![0] as? HeaderCelll
                }
                cell?.eventDescTextView.delegate=self
                let singleTap = UITapGestureRecognizer(target: self, action:#selector(self.OpenGallaryBAction))
                singleTap.numberOfTapsRequired = 1
                cell!.EventProfilePic.isUserInteractionEnabled = true
                cell!.delegates=self
                cell!.EventProfilePic.addGestureRecognizer(singleTap)
                
                
                var getValue:String! =  UserDefaults.standard.value(forKey: "session_LinkValue") as! String
                
                if(getValue=="nothing")
                {
                  cell!.textfieldTitleLater.text=""
                }
                else
                {
                    cell!.textfieldTitleLater.text=getValue
                }
                
                
                
                
               
                
                cellArray.add(cell!)
            }
            else  if(index>=1 && index<=3){
                var cellSchedule = addEventTableView.dequeueReusableCell(withIdentifier: "schedule") as? ScheduleCell
                if(cellSchedule == nil){
                    //  var objects: NSArray?;
                    cellSchedule =  Bundle.main.loadNibNamed("schedule", owner: self, options: nil)![0] as? ScheduleCell
                }
                
                if cellSchedule?.dateButton.titleLabel?.text == "Select Date"
                {
                    
                }
                cellSchedule!.dateButton.addTarget(self, action: #selector(self.DateTimeShowAction(_:)), for: UIControl.Event.touchUpInside)
                cellSchedule!.dateButton.tag = index
                cellSchedule!.timeButton.addTarget(self, action: #selector(self.DateTimeShowAction(_:)), for: UIControl.Event.touchUpInside)
                cellSchedule!.timeButton.tag = index
                cellSchedule!.dateButton.setTitle("Select Date",  for: UIControl.State.normal)
                cellSchedule!.timeButton.setTitle("and Time",  for: UIControl.State.normal)
                cellSchedule!.dateTimeTitleLabel.text = titleArraySchedule[index]
                cellSchedule!.addedDate = nil
                cellArray.add(cellSchedule!)
            }
            else  if(index==4){
                
                var cellHeader2 = self.addEventTableView.dequeueReusableCell(withIdentifier: "smscell") as? SmsQuestionCell
                if(cellHeader2 == nil){
                    // var objects: NSArray?;
                    cellHeader2 =  Bundle.main.loadNibNamed("smscell", owner: self, options: nil)![0] as? SmsQuestionCell
                }
                allSMSFlag="0"
                nonSmartSMSFlag = "0"
                displayOnBannerFlag = "1"
                cellHeader2!.delegates=self
                
                
                
                
                // print(eventsDetails.displayonbanner)
                
                
                
                var varGetValueDisplayonBanner:String! = eventsDetails.displayonbanner
                
                // print(eventsDetails.displayonbanner)
                /*
                 if(eventsDetails.displayonbanner=="0")
                 {
                 cellHeader2!.btnDisplayOnBanner.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
                 displayOnBannerFlag="0"
                 }
                 else
                 {
                 */
                cellHeader2!.btnDisplayOnBanner.setImage(UIImage(named: "switchOn"),  for: UIControl.State.normal)
                displayOnBannerFlag="1"
                /* }*/
                
                // cellHeader2!.btnDisplayOnBanner.setImage(UIImage(named: "CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
//                cellHeader2!.allMemSMSButton.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                cellHeader2!.whatsappRadioBtn.isOn = false
                cellHeader2!.nonSmartSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                cellHeader2?.SMSCountLabel.text = String(format:"Balance WhatsApp : %@",SMSCountStr)
                cellArray.add(cellHeader2!)
            }
            else  if(index==5){
                
                var cellHeader2 = self.addEventTableView.dequeueReusableCell(withIdentifier: "addQueCell") as? AddQuestionCell
                if(cellHeader2 == nil){
                    // var objects: NSArray?;
                    cellHeader2 =  Bundle.main.loadNibNamed("addQueCell", owner: self, options: nil)![0] as? AddQuestionCell
                }
                cellHeader2!.delegates=self
                cellHeader2?.editQuestionButton.addTarget(self, action: #selector(self.EditQueAction(_:)), for: .touchUpInside)
                
                cellHeader2!.questionSwitch.isOn=false
                
                cellArray.add(cellHeader2!)
            }
            else if(index==6){
                var cellHeader2 = self.addEventTableView.dequeueReusableCell(withIdentifier: "queViewCell") as? QuestionViewCell
                if(cellHeader2 == nil){
                    
                    cellHeader2 =  Bundle.main.loadNibNamed("queViewCell", owner: self, options: nil)![0] as! QuestionViewCell
                }
                addQueTextView.text = "Tap to add Question"
                cellHeader2?.QuestionTitleLabel.text = ""
                cellHeader2?.Option1Label.text = ""
                cellHeader2?.Option2Label.text = ""
                cellArray.add(cellHeader2!)
            }
                
            else  if(index==7){
                
                var cellHeader2 = self.addEventTableView.dequeueReusableCell(withIdentifier: "headerCell2") as? HeaderCell2
                if(cellHeader2 == nil){
                    
                    cellHeader2 =  Bundle.main.loadNibNamed("headerCell2", owner: self, options: nil)![0] as? HeaderCell2
                }
                cellHeader2!.delegates=self
                cellHeader2!.addRepeatCellButton.addTarget(self, action: #selector(self.AddCellFunction), for: UIControl.Event.touchUpInside)
                cellArray.add(cellHeader2!)
            }
            
        }
        
        print("cell array count \(cellArray.count)");
    }
    func createCEllWithData(){
        commonIDString=eventsDetails.inputIds
        annTypeStr=eventsDetails.eventType as! NSString
        venueLat=eventsDetails.venueLat as! NSString
        venueLon=eventsDetails.venueLon as! NSString
        
        //myy code
        // for var index = 0; index <= 8; index += 1 {
        
        for index in 0 ..< 9{
            
            
            
            if(index==0){
                
                var  cell = self.addEventTableView.dequeueReusableCell(withIdentifier: "headerCell") as? HeaderCelll
                if(cell == nil){
                    
                    cell =  Bundle.main.loadNibNamed("headerCell", owner: self, options: nil)![0] as? HeaderCelll
                }
                cell?.eventDescTextView.delegate=self
                let singleTap = UITapGestureRecognizer(target: self, action:#selector(AddEventsController.OpenGallaryBAction))
                singleTap.numberOfTapsRequired = 1
                cell!.EventProfilePic.isUserInteractionEnabled = true
                cell!.delegates=self
                cell?.eventDescTextView.delegate=self
                cell!.EventProfilePic.addGestureRecognizer(singleTap)
                
                
                var getValue:String! =  UserDefaults.standard.value(forKey: "session_LinkValue") as! String
                
                if(getValue=="nothing")
                {
                    cell!.textfieldTitleLater.text=""
                }
                else
                {
                    cell!.textfieldTitleLater.text=getValue
                }
                
                
                
                
                if let checkedUrl = URL(string: eventsDetails.eventImg) {
                    
                    
                    //Working in swift new version 03-08-2018
                    cell!.EventProfilePic.sd_setImage(with: checkedUrl)
                    
                    
                    //                    appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                    //                        DispatchQueue.main.async { () -> Void in
                    //                            guard let data = data, error == nil else { return }
                    //                            print(response?.suggestedFilename ?? "")
                    //                            print("Download Finished")
                    //
                    //                            cell!.EventProfilePic.image = UIImage(data: data)
                    //
                    //                        }
                    //                    }
                }
                cell!.eventTitleField.text = eventsDetails.eventTitle
                cell!.eventDescTextView.text = eventsDetails.eventDesc
                cell?.lblDescCount.text=String(eventsDetails.eventDesc.count)
                cell!.eventVenueTextView.text = eventsDetails.venue
                // cell!.textfieldxcvxTitleLater.text = eventsDetails.LinkWebSite
                
                
                if(eventsDetails.eventType == "0" ){
                    cell!.addPeaopleCountLabel.text = ""
                    cell!.allEventsButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                    cell!.subGroupEventButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                    cell!.membersEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                }else if(eventsDetails.eventType == "1"){
                    let myStringArr = eventsDetails.inputIds.components(separatedBy: ",")
                    cell!.addPeaopleCountLabel.text = String(format:"You have added %d groups",myStringArr.count)
                    cell!.subGroupEventButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                    cell!.allEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                    cell!.membersEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                    
                }else if(eventsDetails.eventType == "2" ){
                    let myStringArr = eventsDetails.inputIds.components(separatedBy: ",")
                    cell!.addPeaopleCountLabel.text = String(format:"You have added %d members",myStringArr.count)
                    cell!.membersEventsButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                    cell!.allEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                    cell!.subGroupEventButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                }
                cell!.addPeaopleCountLabel.isHidden=false
                
                cellArray.add(cell!)
            }
            else  if(index>=1 && index<=3){
                var cellSchedule = addEventTableView.dequeueReusableCell(withIdentifier: "schedule") as? ScheduleCell
                if(cellSchedule == nil){
                    // var objects: NSArray?;
                    cellSchedule =  Bundle.main.loadNibNamed("schedule", owner: self, options: nil)![0] as? ScheduleCell
                }
                cellSchedule!.dateButton.addTarget(self, action: #selector(AddEventsController.DateTimeShowAction(_:)), for: UIControl.Event.touchUpInside)
                cellSchedule!.dateButton.tag = index
                cellSchedule!.timeButton.addTarget(self, action: #selector(AddEventsController.DateTimeShowAction(_:)), for: UIControl.Event.touchUpInside)
                cellSchedule!.timeButton.tag = index
                //                cellSchedule!.dateButton.setTitle("Select Date", forState: UIControl.State.Normal)
                
                //                cellSchedule!.timeButton.setTitle("Seldect Time", forState: UIControl.State.Normal)
                cellSchedule!.dateTimeTitleLabel.text = titleArraySchedule[index]
                if(index == 1){
                    var myStringArr = eventsDetails.eventDate.components(separatedBy: " ")
                    let pubdate = String(format: "%@",myStringArr[0])
                    cellSchedule!.dateButton.setTitle(pubdate,  for: UIControl.State.normal)
                    let pubtime = String(format:"%@",myStringArr[1])
                    cellSchedule!.timeButton.setTitle(pubtime,  for: UIControl.State.normal)
                    
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:00"
                    // dateFormatter1.timeZone = NSTimeZone(name: "UTC")
                    let datstr = dateFormatter1.date(from: eventsDetails.eventDate)
                    cellSchedule!.addedDate = (datstr as! NSDate) as Date!
                }
                if(index == 2){
                    var myStringArr = eventsDetails.pubDate.components(separatedBy: " ")
                    let pubdate = String(format: "%@",myStringArr[0])
                    cellSchedule!.dateButton.setTitle(pubdate,  for: UIControl.State.normal)
                    let pubtime = String(format:"%@",myStringArr[1])
                    cellSchedule!.timeButton.setTitle(pubtime,  for: UIControl.State.normal)
                    
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:00"
                    // dateFormatter1.timeZone = NSTimeZone(name: "UTC")
                    let datstr = dateFormatter1.date(from: eventsDetails.pubDate)
                    cellSchedule!.addedDate = (datstr as! NSDate) as Date!
                }
                if(index == 3){
                    var myStringArr = eventsDetails.expiryDate.components(separatedBy: " ")
                    let pubdate = String(format: "%@",myStringArr[0])
                    cellSchedule!.dateButton.setTitle(pubdate,  for: UIControl.State.normal)
                    let pubtime = String(format:"%@",myStringArr[1])
                    cellSchedule!.timeButton.setTitle(pubtime,  for: UIControl.State.normal)
                    
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:00"
                    //dateFormatter1.timeZone = NSTimeZone(name: "UTC")
                    let datstr = dateFormatter1.date(from: eventsDetails.expiryDate)
                    cellSchedule!.addedDate = (datstr as! NSDate) as Date!
                }
                cellArray.add(cellSchedule!)
            }
            else  if(index==4){
                
                var cellHeader2 = self.addEventTableView.dequeueReusableCell(withIdentifier: "smscell") as? SmsQuestionCell
                if(cellHeader2 == nil){
                    // var objects: NSArray?;
                    cellHeader2 =  Bundle.main.loadNibNamed("smscell", owner: self, options: nil)![0] as? SmsQuestionCell
                }
                
                
                
                
                // print(eventsDetails.displayonbanner)
                
                if(eventsDetails.displayonbanner=="0")
                {
                    cellHeader2!.btnDisplayOnBanner.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                    displayOnBannerFlag="0"
                }
                else
                {
                    cellHeader2!.btnDisplayOnBanner.setImage(UIImage(named: "switchOn"),  for: UIControl.State.normal)
                    displayOnBannerFlag="1"
                }
                var varGetValueDisplayonBanner:String! = eventsDetails.displayonbanner
                
                
                
                
//                cellHeader2!.allMemSMSButton.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                cellHeader2!.whatsappRadioBtn.isOn = false
                
                
                if(SMSCountStr==nil)
                {
                    SMSCountStr=""
                }
                
                cellHeader2?.SMSCountLabel.text = String(format:"Balance WhatsApp : %@",SMSCountStr)
                allSMSFlag=eventsDetails.sendSMSAll as! NSString
                nonSmartSMSFlag = eventsDetails.sendSMSNonSmartPh as! NSString
                cellHeader2!.delegates=self
                
                if(eventsDetails.sendSMSAll == "0"){
//                    cellHeader2!.allMemSMSButton.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                    cellHeader2!.whatsappRadioBtn.isOn = false
                }else{
//                    cellHeader2!.allMemSMSButton.setImage(UIImage(named: "switchOn"),  for: UIControl.State.normal)
                    cellHeader2!.whatsappRadioBtn.isOn = true
                }
                if(eventsDetails.sendSMSNonSmartPh == "0"){
                    cellHeader2!.nonSmartSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                }else{
                    cellHeader2!.nonSmartSMSButton.setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                }
                
                cellArray.add(cellHeader2!)
            }
            else  if(index==5){
                
                var cellHeader2 = self.addEventTableView.dequeueReusableCell(withIdentifier: "addQueCell") as? AddQuestionCell
                if(cellHeader2 == nil){
                    // var objects: NSArray?;
                    cellHeader2 =  Bundle.main.loadNibNamed("addQueCell", owner: self, options: nil)![0] as? AddQuestionCell
                }
                cellHeader2!.delegates=self
                cellHeader2!.editQuestionButton.addTarget(self, action: #selector(AddEventsController.EditQueAction(_:)), for: .touchUpInside)
                cellHeader2!.editQuestionButton.isHidden = false
                let str = eventsDetails.questionId as String?
                print(str)
                if str == ""
                {
                    cellHeader2!.questionSwitch.isOn=false
                    cellArray.add(cellHeader2!)
                    var cellHeader2 = self.addEventTableView.dequeueReusableCell(withIdentifier: "queViewCell") as? QuestionViewCell
                    if(cellHeader2 == nil){
                        //var objects: NSArray?;
                        cellHeader2 =  Bundle.main.loadNibNamed("queViewCell", owner: self, options: nil)![0] as? QuestionViewCell
                    }
                    addQueTextView.text = "Tap to add Question"
                    cellHeader2?.QuestionTitleLabel.text = addQueTextView.text
                    cellHeader2?.Option1Label.text = ans1TextField.text
                    cellHeader2?.Option2Label.text = ans2TextField.text
                    
                    cellArray.insert(cellHeader2!, at: 6)
                }
                else
                {
                    if(isCalledFrom=="edit" )
                    {
                        if(varIsRSVPEnableorDisable==0)
                        {
                            cellHeader2!.questionSwitch.isOn=false
                        }
                        else
                            
                        {
                            cellHeader2!.questionSwitch.isOn=true
                        }
                    }
                    else
                    {
                        varIsRSVPEnableorDisable=1
                    }
                    
                    cellArray.add(cellHeader2!)
                    var cellHeader2 = self.addEventTableView.dequeueReusableCell(withIdentifier: "queViewCell") as? QuestionViewCell
                    if(cellHeader2 == nil){
                        // var objects: NSArray?;
                        cellHeader2 =  Bundle.main.loadNibNamed("queViewCell", owner: self, options: nil)![0] as? QuestionViewCell
                    }
                    cellHeader2?.QuestionTitleLabel.text = eventsDetails.questionText
                    
                    print("Question Text:-"+eventsDetails.questionText)
                    
                    
                    
                    
                    ////////
                    varIsExistAnyQuestion=1
                    
                    varNewIndex=100
                    ////////
                    cellHeader2?.Option1Label.text = eventsDetails.option1
                    cellHeader2?.Option2Label.text = eventsDetails.option2
                    questionType = eventsDetails.questionType
                    cellArray.insert(cellHeader2!, at: 6)
                }
                
                
                
                //                if let str = eventsDetails.questionText as! String?{
                //
                //
                //                    if addQueTextView.text == ""
                //                    {
                //                        print(eventsDetails.questionText)
                //                        if let str = eventsDetails.questionText as! String?
                //                        {
                //                            if str == ""
                //                            {
                //                                cellHeader2!.questionSwitch.on=false
                //                                cellArray.addObject(cellHeader2!)
                //                            }
                //                            else
                //                            {
                //                                cellHeader2!.questionSwitch.on=true
                //                                cellArray.addObject(cellHeader2!)
                //
                //                                var cellHeader2 = self.addEventTableView.dequeueReusableCellWithIdentifier("queViewCell") as? QuestionViewCell
                //                                if(cellHeader2 == nil){
                //                                    var objects: NSArray?;
                //                                    cellHeader2 =  NSBundle.mainBundle().loadNibNamed("queViewCell", owner: self, options: nil)[0] as! QuestionViewCell
                //                                }
                //
                //                                cellHeader2?.QuestionTitleLabel.text = eventsDetails.questionText
                //                                cellHeader2?.Option1Label.text = eventsDetails.option1
                //                                cellHeader2?.Option2Label.text = eventsDetails.option2
                //                                cellArray.insertObject(cellHeader2!, atIndex: 6)
                //                            }
                //
                //                        }
                //                        else
                //                        {
                //
                //                        }
                //                    }
                //                    else
                //                    {
                //
                //                        var cellHeader2 = self.addEventTableView.dequeueReusableCellWithIdentifier("queViewCell") as? QuestionViewCell
                //                        if(cellHeader2 == nil){
                //                            var objects: NSArray?;
                //                            cellHeader2 =  NSBundle.mainBundle().loadNibNamed("queViewCell", owner: self, options: nil)[0] as! QuestionViewCell
                //                        }
                //
                //                        cellHeader2?.QuestionTitleLabel.text = addQueTextView.text
                //                        cellHeader2?.Option1Label.text = ans1TextField.text
                //                        cellHeader2?.Option2Label.text = ans2TextField.text
                //                        if editOrNot == true
                //                        {
                //
                //                        }
                //                        else
                //                        {
                //                            cellArray.insertObject(cellHeader2!, atIndex: 6)
                //                        }
                //
                //                    }
                //
                //
                //                }else{
                //                    cellHeader2!.questionSwitch.on=false
                //                    cellArray.addObject(cellHeader2!)
                //                }
                
                //                if eventsDetails.questionText.characters.count > 1
                //                {
                //                    cellHeader2?.questionSwitch.on = true
                //                }
                //                else
                //                {
                //
                //                }
            }
                
                // */
            else  if(index==7){
                
                var cellHeader2 = self.addEventTableView.dequeueReusableCell(withIdentifier: "headerCell2") as? HeaderCell2
                if(cellHeader2 == nil){
                    // var objects: NSArray?;
                    cellHeader2 =  Bundle.main.loadNibNamed("headerCell2", owner: self, options: nil)![0] as? HeaderCell2
                }
                cellHeader2!.delegates=self
                cellHeader2!.addRepeatCellButton.addTarget(self, action: #selector(AddEventsController.AddCellFunction), for: UIControl.Event.touchUpInside)
                if(eventsDetails.repeatDateTime != ""){
                    cellHeader2!.repeatSwitch.isOn=true
                    
                    
                    if(isCalledFrom=="edit" )
                    {
                        varIsRSVPEnableorDisable = Int(rsvpString)!
                    }
                    else
                    {
                        varIsRSVPEnableorDisable=1
                    }
                    
                    
                    
                    
                    cellHeader2!.repeateDateTImeLabel.isHidden = false
                    cellHeader2!.addRepeatCellButton.isHidden = false
                }else{
                    if(isCalledFrom=="edit" )
                    {
                        varIsRSVPEnableorDisable = Int(rsvpString)!
                    }
                    else
                    {
                        varIsRSVPEnableorDisable=0
                    }
                    
                    
                    
                    cellHeader2!.repeatSwitch.isOn=false
                    cellHeader2!.repeateDateTImeLabel.isHidden = true
                    cellHeader2!.addRepeatCellButton.isHidden = true
                }
                cellArray.add(cellHeader2!)
            }
                
            else if(index==8){
                if(eventsDetails.repeatDateTime != ""){
                    var myStringArr = eventsDetails.repeatDateTime.components(separatedBy: ",")
                    print(myStringArr)
                    for index in 0 ..< myStringArr.count {
                        let cellRepeat = addEventTableView.dequeueReusableCell(withIdentifier: "datetimeCell") as! RepeatDateTimeCell
                        cellRepeat.delegates=self
                        cellRepeat.objectVal=cellArray.count
                  //      cellRepeat.repeatDateButton.addTarget(self, action: #selector(AddEventsController.RepeatDateTimeShowAction(_:)), for: UIControl.Event.touchUpInside)
                        cellRepeat.repeatDateButton.tag = lastCellIndex+1
                   //     cellRepeat.repeatTimeButton.addTarget(self, action: #selector(AddEventsController.RepeatDateTimeShowAction(_:)), for: UIControl.Event.touchUpInside)
                        cellRepeat.repeatTimeButton.tag = lastCellIndex+1
                        var myStringArr1 = myStringArr[index].components(separatedBy: " ")
                        let pubdate = String(format: "%@",myStringArr1[0])
                        cellRepeat.repeatDateButton.setTitle(pubdate,  for: UIControl.State.normal)
                        let pubtime = String(format:"%@",myStringArr1[1])
                        cellRepeat.repeatTimeButton.setTitle(pubtime,  for: UIControl.State.normal)
                       // cellRepeat.deleteCellButton.setTitle(String(lastCellIndex+1),  for: UIControl.State.normal)
                        cellArray.add(cellRepeat)
                        lastCellIndex=lastCellIndex+1
                    }
                }
            }
        }
    }
    
    func reloadAfterDelete(){
        print("total cella rray cnt \(cellArray.count)")
        let copyCellArray=cellArray.mutableCopy()
        cellArray.removeAllObjects()
        for index in 0 ..< (copyCellArray as AnyObject).count {
            
            if(index==0){
                
                let  cell = (copyCellArray as AnyObject).object(at: index) as? HeaderCelll
                cell?.eventDescTextView.delegate=self
                let singleTap = UITapGestureRecognizer(target: self, action:#selector(AddEventsController.OpenGallaryBAction))
                singleTap.numberOfTapsRequired = 1
                cell!.EventProfilePic.isUserInteractionEnabled = true
                cell!.EventProfilePic.addGestureRecognizer(singleTap)
                cellArray.add(cell!)
            }
            else  if(index>=1 && index<=3){
                let cellSchedule = (copyCellArray as AnyObject).object(at: index) as? ScheduleCell
                
                cellSchedule!.dateButton.addTarget(self, action: #selector(AddEventsController.DateTimeShowAction(_:)), for: UIControl.Event.touchUpInside)
                cellSchedule!.dateButton.tag = index
                cellSchedule!.timeButton.addTarget(self, action: #selector(AddEventsController.DateTimeShowAction(_:)), for: UIControl.Event.touchUpInside)
                cellSchedule!.timeButton.tag = index
                
                cellSchedule!.dateTimeTitleLabel.text = titleArraySchedule[index]
                cellArray.add(cellSchedule!)
            }
            else  if(index==4){
                
                let cellHeader2 = (copyCellArray as AnyObject).object(at: index) as?  SmsQuestionCell
                
                cellHeader2!.delegates=self
                
                
                cellHeader2?.SMSCountLabel.text = String(format:"Balance WhatsApp : %@",SMSCountStr)
                cellArray.add(cellHeader2!)
                //
                // print(eventsDetails.displayonbanner)
                
                if(eventsDetails.displayonbanner=="0")
                {
                    cellHeader2!.btnDisplayOnBanner.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                    displayOnBannerFlag="0"
                }
                else
                {
                    cellHeader2!.btnDisplayOnBanner.setImage(UIImage(named: "switchOn"),  for: UIControl.State.normal)
                    displayOnBannerFlag="1"
                }
                
                
                
                
            }
                
            else  if(index==5)
            {
                let cellHeader2 = (copyCellArray as AnyObject).object(at: index) as? AddQuestionCell
                
                cellHeader2!.delegates=self
                cellHeader2!.editQuestionButton.addTarget(self, action: #selector(AddEventsController.EditQueAction(_:)), for: .touchUpInside)
                // cellHeader2!.editQuestionButton.hidden = false
                //cellHeader2!.questionSwitch.on=true
                cellArray.add(cellHeader2!)
            }
            else if(index == 6)
            {
                let cellHeader2 = (copyCellArray as AnyObject).object(at: index) as? QuestionViewCell
                //var str = eventsDetails.questionId as? String
                
                if addQueTextView.text?.characters.count != 0
                {
                    cellHeader2?.QuestionTitleLabel.text = addQueTextView.text
                    cellHeader2?.Option1Label.text = ans1TextField.text
                    cellHeader2?.Option2Label.text = ans2TextField.text
                    cellArray.insert(cellHeader2!, at: 6)
                }
                else
                {
                    
                    //  var cellHeader2 = copyCellArray.objectAtIndex(index) as? QuestionViewCell
                    print("Question Text:-"+eventsDetails.questionText)
                    
                    cellHeader2?.QuestionTitleLabel.text = eventsDetails.questionText
                    cellHeader2?.Option1Label.text = eventsDetails.option1
                    cellHeader2?.Option2Label.text = eventsDetails.option2
                    questionType = eventsDetails.questionType
                    cellArray.insert(cellHeader2!, at: 6)
                }
                
            }
            else  if(index==7){
                
                let cellHeader2 = (copyCellArray as AnyObject).object(at: index) as? HeaderCell2
                
                
                cellHeader2!.delegates=self
                cellHeader2!.addRepeatCellButton.addTarget(self, action: #selector(AddEventsController.AddCellFunction), for: UIControl.Event.touchUpInside)
                cellArray.add(cellHeader2!)
            }
                
            else{
                
                let   cellRepeat = (copyCellArray as AnyObject).object(at: index) as? RepeatDateTimeCell
                
                cellRepeat!.delegates=self
                cellRepeat!.objectVal=index
                cellRepeat!.repeatDateButton.addTarget(self, action: #selector(self.RepeatDateTimeShowAction(_:)), for: UIControl.Event.touchUpInside)
                cellRepeat!.repeatDateButton.tag = index
                cellRepeat!.repeatTimeButton.addTarget(self, action: #selector(self.RepeatDateTimeShowAction(_:)), for: UIControl.Event.touchUpInside)
                cellRepeat!.repeatTimeButton.tag = index
                cellArray.add(cellRepeat!)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row==cellArray.count-1
        {
            print("Is @ last row \(cellArray.count-1)")
        }
        return cellArray.object(at: indexPath.row) as! UITableViewCell
    }
    
    func myDelegateFunctionIshere(_ string:Int,myCell:RepeatDateTimeCell){
        let indexPath = self.addEventTableView.indexPath(for: myCell)
        let index=indexPath!.row
        
        addEventTableView.beginUpdates()
        addEventTableView.deleteRows(at: [ IndexPath(row: index, section: 0) ], with: .automatic)
        cellArray.removeObject(at: index)
        addEventTableView.endUpdates()
        addEventTableView.scrollToRow( at: IndexPath(row: cellArray.count-1, section: 0), at: .bottom, animated: true)
        print("After Deleting Cell Array Count \(cellArray.count)")
    }
    
    
    func myDelegateFunctionSelectDate(_ myCell: RepeatDateTimeCell) {
        let indexPath = self.addEventTableView.indexPath(for: myCell)
        let index=indexPath!.row
        
        let cell = cellArray.object(at: 0) as! HeaderCelll
        
        cell.eventVenueTextView.resignFirstResponder()
        cell.eventDescTextView.resignFirstResponder()
        cell.eventTitleField.resignFirstResponder()
        
        myview.removeFromSuperview()
        
        myview = UIView(frame: CGRect(x: 0,y: 100, width: self.view.frame.size.width, height: 280));
        myview.backgroundColor=UIColor.lightGray;
        self.view.addSubview(myview);
        
        
        picker = UIDatePicker(frame: CGRect(x: 0, y: 42, width: myview.frame.width, height: 236))
        picker.setStyle()
        picker.backgroundColor = .white
        picker.tag = index
        picker.addTarget(self, action: #selector(AddEventsController.RepeatDateValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        let strDate = dateFormatter.string(from: picker.date)
        
        let strSplit = strDate.characters.split(separator: " ")
        let Date = String(strSplit.first!)
        let time = String(strSplit.last!)
        
        print(Date)
        print(time)
        
        toolBar.frame = CGRect(x: 0, y: 0 , width: view.frame.width, height: 50)
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.darkGray
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.RepeatDonePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        myview.addSubview(toolBar)
        myview.addSubview(picker)
        
    }
    
    
     @objc func RepeatDateTimeShowAction(_ sender:UIButton)
    {
        let cell = cellArray.object(at: 0) as! HeaderCelll
        
        cell.eventVenueTextView.resignFirstResponder()
        cell.eventDescTextView.resignFirstResponder()
        cell.eventTitleField.resignFirstResponder()
        
        myview.removeFromSuperview()
        
        myview = UIView(frame: CGRect(x: 0,y: 100, width: self.view.frame.size.width, height: 280));
        myview.backgroundColor=UIColor.lightGray;
        self.view.addSubview(myview);
        
        
        picker = UIDatePicker(frame: CGRect(x: 0, y: 42, width: myview.frame.width, height: 236))
        picker.setStyle()
        picker.backgroundColor = .white
        picker.tag = sender.tag
        picker.addTarget(self, action: #selector(self.RepeatDateValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        let strDate = dateFormatter.string(from: picker.date)
        
        let strSplit = strDate.characters.split(separator: " ")
        let Date = String(strSplit.first!)
        let time = String(strSplit.last!)
        
        print(Date)
        print(time)
        
        toolBar.frame = CGRect(x: 0, y: 0 , width: view.frame.width, height: 50)
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.darkGray
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.RepeatDonePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        myview.addSubview(toolBar)
        myview.addSubview(picker)
        
    }
    
    @objc func RepeatDonePicker()
    {
        myview.removeFromSuperview()
    }
    
    @objc func RepeatDateValueChanged(_ sender:UIDatePicker)
    {
        
        let cellRepeat = cellArray.object(at: sender.tag) as! RepeatDateTimeCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        //  dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let strDate = dateFormatter.string(from: sender.date)
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:00"
        // dateFormatter1.timeZone = NSTimeZone(name: "UTC")
        let datstr = dateFormatter1.date(from: strDate)
        
        let cellSchedule1 = cellArray.object(at: 2) as? ScheduleCell
        let cellexpiry = cellArray.object(at: 3) as? ScheduleCell
        print("addedDate \(cellSchedule1!.addedDate)")
        
        if(cellSchedule1!.addedDate != nil){
            if(cellSchedule1!.addedDate .compare(datstr!) == .orderedDescending){
                 SVProgressHUD.dismiss()
                print("date1 is later than date2");
                let alert = UIAlertController(title: "Event", message: "Please make the Repeat notification Date & Time greater than the Publish Date & Time", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                self.present(alert, animated: true, completion: nil)
                print("date1 is before than date2");
                
            }
                
            else if(cellSchedule1!.addedDate .compare(datstr!) == .orderedSame){
                 SVProgressHUD.dismiss()
                print("date1 is same date2");
                let alert = UIAlertController(title: "Event", message: "Repeat notification Date & Time should not be same as Publish Date & Time", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                self.present(alert, animated: true, completion: nil)
            } else if(cellSchedule1!.addedDate .compare(datstr!) == .orderedAscending){
                print("date1 is before than date2");
                if(cellexpiry!.addedDate != nil){
                    if(cellexpiry!.addedDate .compare(datstr!) == .orderedDescending){
                         SVProgressHUD.dismiss()
                        let strSplit = strDate.characters.split(separator: " ")
                        let Date = String(strSplit.first!)
                        let time = String(strSplit.last!)
                        
                        print(Date)
                        print(time)
                        checkRemainder = 0
                        cellRepeat.repeatDateButton.setTitle(Date,  for: UIControl.State.normal)
                        cellRepeat.repeatTimeButton.setTitle(time,  for: UIControl.State.normal)
                    }else if(cellSchedule1!.addedDate .compare(datstr!) == .orderedSame){
                         SVProgressHUD.dismiss()
                        let alert = UIAlertController(title: "Event", message: "Repeat notification Date & Time should not be same as Expiry Date & Time", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                        self.present(alert, animated: true, completion: nil)
                    } else if(cellSchedule1!.addedDate .compare(datstr!) == .orderedAscending){
                         SVProgressHUD.dismiss()
                        let alert = UIAlertController(title: "Event", message: "Repeat notification Date & Time should not be greater than the Expiry Date & Time", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }else{
                     SVProgressHUD.dismiss()
                    let alert = UIAlertController(title: "Event", message: "Please enter Expiry date, event date first. ", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                
                
                
            }
        }else{
             SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Event", message: "Please enter publish date, event date first. ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        addEventTableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func NextButtonAction(_ sender: AnyObject)
    {
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "create_profile") as UIViewController, animated: true) //
    }
    
    @objc func AddCellFunction() { //DeleteCellFunction
        // let cellRepeat = addEventTableView.dequeueReusableCellWithIdentifier("datetimeCell") as! RepeatDateTimeCell
        //        var cellRepeat = self.addEventTableView.dequeueReusableCellWithIdentifier("datetimeCell") as? RepeatDateTimeCell
        //        if(cellRepeat == nil){
        //           //_ts: NSArray?;
        //            cellRepeat = RepeatDateTimeCell(style: .Default, reuseIdentifier: "datetimeCell")
        //              //  NSBundle.mainBundle().loadNibNamed("datetimeCell", owner: self, options: nil)[0] as! RepeatDateTimeCell
        //        }
        //        cellRepeat!.delegates=self
        //        print("tag assign %d \(cellArray.count)")
        //        cellRepeat!.objectVal=cellArray.count
        //        cellRepeat!.repeatDateButton.addTarget(self, action: #selector(AddEventsController.RepeatDateTimeShowAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        //        cellRepeat!.repeatDateButton.tag = cellArray.count
        //        cellRepeat!.repeatTimeButton.addTarget(self, action: #selector(AddEventsController.RepeatDateTimeShowAction(_:)), forControlEvents: UIControl.Event.TouchUpInside)
        //        cellRepeat!.repeatTimeButton.tag = cellArray.count
        //        cellRepeat!.repeatDateButton.setTitle("Selefct Date", forState: UIControl.State.Normal)
        //        cellRepeat!.repeatTimeButton.setTitle("Selfect Time", forState: UIControl.State.Normal)
        //        cellArray.addObject(cellRepeat!)
        //
        //        print("cell array cnt add \(cellArray.count)")
        //        addEventTableView.reloadData()
        ////        addEventTableView.beginUpdates()
        ////        addEventTableView.insertRowsAtIndexPaths([
        ////            NSIndexPath(forRow: cellArray.count-1, inSection: 0)
        ////            ], withRowAnimation: .Automatic)
        ////        addEventTableView.endUpdates()
        //
        //
        //        // Set the content size of your scroll view to be the content size of your
        //        // table view + whatever else you have in the scroll view.
        //        // For the purposes of this example, I'm assuming the table view is in there alone.
        //        //var a = cellArray.count*60
        //       //self.addEventTableView.contentSize = CGSizeMake(320, 2000);
        //        addEventTableView.scrollToRowAtIndexPath( NSIndexPath(forRow: cellArray.count-1, inSection: 0), atScrollPosition: .Bottom, animated: true)
        
        
        let cellRepeat = addEventTableView.dequeueReusableCell(withIdentifier: "datetimeCell") as! RepeatDateTimeCell
        cellRepeat.delegates=self
        
        cellRepeat.objectVal=cellArray.count
     //   cellRepeat.repeatDateButton.addTarget(self, action: #selector(AddEventsController.RepeatDateTimeShowAction(_:)), for: UIControl.Event.touchUpInside)
        cellRepeat.repeatDateButton.tag = lastCellIndex+1
    //    cellRepeat.repeatTimeButton.addTarget(self, action: #selector(AddEventsController.RepeatDateTimeShowAction(_:)), for: UIControl.Event.touchUpInside)
        cellRepeat.repeatTimeButton.tag = lastCellIndex+1
        cellRepeat.repeatDateButton.setTitle("Select Date",  for: UIControl.State.normal)
        cellRepeat.repeatTimeButton.setTitle(" and Time",  for: UIControl.State.normal)
        //  cellRepeat.deleteCellButton.setTitle(String(lastCellIndex+1),  for: UIControl.State.normal)
        cellArray.add(cellRepeat)
        lastCellIndex=lastCellIndex+1
        addEventTableView.beginUpdates()
        print("Inserting row at \(cellArray.count-1)")
         addEventTableView.insertRows(at: [ IndexPath(row: cellArray.count-1, section: 0) ], with: .none)
       
        addEventTableView.endUpdates()
        addEventTableView.scrollToRow( at: IndexPath(row: cellArray.count-1, section: 0), at: .bottom, animated: true)
        print("After Adding cell  Array Count \(cellArray.count)")
    }
    
    func repeatSwitchAction(_ string:Int){
        
        checkRemainder = string
        
        let indexPath = IndexPath(row: cellArray.count - 1, section: 0)
        self.addEventTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        print("This is count 1111:------>>>>>>>>>>>>")
        print(cellArray.count)
        if(string == 0){
            
            
            print("This is count 2222:------>>>>>>>>>>>>")
            print(cellArray.count)
            
            
            print("cell count \(cellArray.count)")
            if(cellArray.count>8){
                let a = cellArray.count-1
                print("This is value :----------")
                print(a)
                //myy code
                // for  index = a; index >= 8 ; index -= 1 {
               //for index in stride(from: a, to: index >= 8, by: -1){
               // for index in (1...4).reversed() {
               // }
                
                
                var varGetValue:Int=cellArray.count
                for i  in 00..<cellArray.count
                {
                   
                  
                    if(varGetValue==8)
                    {
                     break
                    }
                    else
                    {
                        cellArray.removeObject(at: cellArray.count-1)
                    }
                      varGetValue=varGetValue-1
                    
                    print(varGetValue)
                    
                }
                
                
//                var intvalue:Int=cellArray.count+8
//
//                for var i in (a..<cellArray.count+5).reversed()
//                {
//
//                    if(cellArray.count==8)
//                    {
//                        break
//                    }
//                   else
//                    {
//                        print(i)
//                        print(a)
//                        print(cellArray.count)
//                        cellArray.removeObject(at: i)
//                        print("cell count \(cellArray.count)  index \(index)")
//                    }
//                }
            addEventTableView.reloadData()
        }
        }
    }
    
    func AddUpdateEvent()
    {
        SVProgressHUD.show()
        //loaderViewMethod()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            
            if(varISClicked==1)
            {
                //  self.window = nil
            }
            else
            {
                
                //cell.chkBTn.currentImage!.isEqual(UIImage(named: "CHECK_BLUE_ROW"))
                let cell : HeaderCelll = cellArray.object(at: 0) as! HeaderCelll
                
                print(annTypeStr)
                
                print(String(format:"Title : %@",cell.eventTitleField.text!))
                print(String(format:"Description : %@",cell.eventDescTextView.text!))
                print(String(format:"venue : %@",cell.eventVenueTextView.text!))
                // print(String(format:"Link new rajendra : %@",cell.textfighfeldTitleLater.text!))
                //
                let cellSchedule0 = cellArray.object(at: 1) as? ScheduleCell
                print(String(format:"Event : %@ %@",(cellSchedule0!.dateButton.titleLabel?.text)!,(cellSchedule0!.timeButton.titleLabel?.text)!))
                let cellSchedule1 = cellArray.object(at: 2) as? ScheduleCell
                print(String(format:"Publish : %@ %@",(cellSchedule1!.dateButton.titleLabel?.text)!,(cellSchedule1!.timeButton.titleLabel?.text)!))
                let cellSchedule2 = cellArray.object(at: 3) as? ScheduleCell
                print(String(format:"Expiry : %@ %@",(cellSchedule2!.dateButton.titleLabel?.text)!,(cellSchedule2!.timeButton.titleLabel?.text)!))
                
                var questionStr : String! = ""
                var ansOption1 : String!  = ""
                var ansOption2 : String!  = ""
                
                let cellQuesView = cellArray.object(at: 6) as? QuestionViewCell
                if cellQuesView == nil
                {
                    
                }
                else
                {
                    print(String(format:"Question: %@",(cellQuesView?.QuestionTitleLabel.text)!))
                    
                    if cellQuesView?.QuestionTitleLabel.text == ""
                    {
                        questionType = "0"
                    }
                    else
                    {
                        if cellQuesView?.Option1Label.text == ""
                        {
                            questionType = "1"
                            questionStr = cellQuesView?.QuestionTitleLabel.text
                        }
                        else
                        {
                            questionType = "2"
                            questionStr = cellQuesView?.QuestionTitleLabel.text
                            ansOption1 = cellQuesView?.Option1Label.text
                            ansOption2 = cellQuesView?.Option2Label.text
                        }
                    }
                    print(questionStr)
                    print(ansOption1)
                    print(ansOption2)
                }
                var allrepeatDateTime : NSMutableArray!
                allrepeatDateTime=[]
                
                if(cellArray.count>7){
                    
                    for index in 8 ..< cellArray.count {
                        
                        let cellSchedule2 = cellArray.object(at: index) as! RepeatDateTimeCell
                        var repeatDateTime : String!
                        
                        repeatDateTime=String(format:"%@ %@",(cellSchedule2.repeatDateButton.titleLabel?.text)!,(cellSchedule2.repeatTimeButton.titleLabel?.text)!)
                        
                        if(repeatDateTime=="Select Date and Time")
                        {
                            
                        }
                        else
                        {
                            allrepeatDateTime.add(repeatDateTime)
                        }
                        
                        
                        // allrepeatDateTime.addObject(repeatDateTime)
                    }
                }
                let strprofileIDs = allrepeatDateTime.componentsJoined(by: ",")
                print(cellSchedule1!.addedDate)
//                print("cell 0 date"/(cellSchedule0!.addedDate)")
                print(cellSchedule0!.addedDate)
                if(cell.eventTitleField.text! == ""){
                    SVProgressHUD.dismiss()
                    let alert = UIAlertController(title: "Event", message: "Please enter the event “Title”", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    // self.window = nil
                    self.present(alert, animated: true, completion: nil)
                }else if(cell.eventDescTextView.text! == ""){
                    SVProgressHUD.dismiss()
                    //  self.window = nil
                    let alert = UIAlertController(title: "Event", message: "Please enter the event “Description”", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }else if(cell.eventVenueTextView.text! == ""){
                    SVProgressHUD.dismiss()
                    //  self.window = nil
                    let alert = UIAlertController(title: "Event", message: "Please enter event Venue", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }else if(cellSchedule0!.dateButton.titleLabel?.text == "Select Date"){
                    SVProgressHUD.dismiss()
                    //  self.window = nil
                    let alert = UIAlertController(title: "Event", message: "Please Enter an Event Date & Time", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }else if(cellSchedule1!.dateButton.titleLabel?.text == "Select Date"){
                    SVProgressHUD.dismiss()
                    //  self.window = nil
                    let alert = UIAlertController(title: "Event", message: "Please enter a Publish Date & Time", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }else if(cellSchedule2!.dateButton.titleLabel?.text == "Select Date"){
                    SVProgressHUD.dismiss()
                    //  self.window = nil
                    let alert = UIAlertController(title: "Event", message: "Please enter an Expiry Date & Time", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                }
                    
               
                else if(cellSchedule0!.addedDate .compare(cellSchedule1!.addedDate as Date) == .orderedAscending){
                    SVProgressHUD.dismiss()
                    // self.window = nil
                    print("date1 is before than date2");
                    let alert = UIAlertController(title: "Event", message: "Publish Date and Time Should be Less than Event Date and Time.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                }
                    
                    
                else if(cellSchedule0!.addedDate .compare(cellSchedule2!.addedDate as Date) == .orderedDescending){
                    SVProgressHUD.dismiss()
                    //  self.window = nil
                    print("date1 is before than date2");
                    let alert = UIAlertController(title: "Event", message: "Expiry Date and Time should be greater than Event Date and Time.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                }else  if(cellSchedule0!.addedDate .compare(cellSchedule2!.addedDate as Date) == .orderedSame){
                    // self.window = nil
                    SVProgressHUD.dismiss()
                    let alert = UIAlertController(title: "Event", message: "Expiry Date and Time should be greater than Event Date and Time.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else if(checkRemainder == 1){
                    SVProgressHUD.dismiss()
                    let alert = UIAlertController(title: "Event", message: "Please set the date and time for the reminder.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    //self.//loaderViewMethod()
                    varISClicked=1
                    
                    if(cell.eventVenueTextView.text!.characters.count > 0){
                        let geocoder: CLGeocoder = CLGeocoder()
                        self.addEventBtn.isEnabled=false
                        
                        //  geocoder.geocodeAddressString(cell.eventVenueTextView.text!, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                        
                        geocoder.geocodeAddressString(cell.eventVenueTextView.text!, completionHandler: {(placemarks: [CLPlacemark]?, error: Error?) -> Void in
                            //})
                            
                            //geocoder.geocodeAddressString(cell.eventVenueTextView.text!,completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                            
                            if((error) != nil){
                                print("Error", error)
                                self.venueLat = ""
                                self.venueLon = ""
                            }
                            
                            if let placemark = placemarks?.first {
                                let topResult: CLPlacemark = (placemarks?[0])!
                                let placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                                self.venueLat = String(coordinates.latitude) as NSString
                                self.venueLon = String(coordinates.longitude) as NSString
                                print(String(format:"venue : %@",self.venueLon))
                            }
                            
                            //  self.//loaderViewMethod()
                            let wsm : WebserviceClass = WebserviceClass.sharedInstance
                            wsm.delegates=self
                            
                            let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
                            //wsm.uploadDocument("0", docType: docTypeStr, docTitle: titleTextField.text!, memID: uid!, grpID: groupID, inputIDs: commonIDString, documentFileId: response.ImageID,docAccessType: varIsViewOnlyorDownloadable,publishDate: letPublishDatenTime,expiryDate: letExpireDatenTime)
                            if mainMemberID == "Yes"
                            {
                                self.isSubGrpAdmin = "1"
                            }
                            else
                            {
                                self.isSubGrpAdmin = "0"
                            }
                            
                            if(self.isCalledFrom == "add"){
                                
                                print("111 This is flag value add :--------")
                                print(self.allSMSFlag)
                                
                                wsm.addEventsResult(eventID: "0", questionEnable: self.questionType as! NSString, eventType: self.annTypeStr, membersIDs: self.commonIDString as NSString as NSString, eventImageID: self.ImsgId, evntTitle: cell.eventTitleField.text! as NSString, evntDesc: cell.eventDescTextView.text! as NSString as NSString, eventVenue: cell.eventVenueTextView.text! as NSString, venueLat: self.venueLat, venueLong: self.venueLon, evntDate: String(format:"%@ %@",(cellSchedule0!.dateButton.titleLabel?.text)!,(cellSchedule0!.timeButton.titleLabel?.text)!) as NSString, publishDate: String(format:"%@ %@",(cellSchedule1!.dateButton.titleLabel?.text)!,(cellSchedule1!.timeButton.titleLabel?.text)!) as NSString as NSString, expiryDate: String(format:"%@ %@",(cellSchedule2!.dateButton.titleLabel?.text)!,(cellSchedule2!.timeButton.titleLabel?.text)!) as NSString as NSString, notifyDate: "", userID: self.groupProfileID as NSString, grpID: self.groupID as! NSString, RepeatDateTime: strprofileIDs as NSString, questionType: self.questionType as! NSString, questionText: questionStr as! NSString, option1: ansOption1 as! NSString as! NSString, option2: ansOption2 as! NSString as! NSString,sendSMSNonSmartPh: self.nonSmartSMSFlag ,sendSMSAll: self.allSMSFlag,rsvpEnable:self.varIsRSVPEnableorDisable,displayOnBanners:"1",link:cell.textfieldTitleLater.text! as NSString,isSubGrpAdmin:self.isSubGrpAdmin)
                            }
                            else {
                                
                                if(self.questionType != ""){
                                    
                                    print("222 This is flag value edit :--------")
                                    print(self.allSMSFlag)
                                    
                                    wsm.addEventsResult(eventID:self.eventsDetails.eventID as! NSString as! NSString, questionEnable: self.questionType as! NSString, eventType: self.annTypeStr, membersIDs: self.commonIDString as NSString as NSString, eventImageID: self.ImsgId, evntTitle: cell.eventTitleField.text! as NSString, evntDesc: cell.eventDescTextView.text! as NSString, eventVenue: cell.eventVenueTextView.text! as NSString as NSString, venueLat: self.venueLat, venueLong: self.venueLon, evntDate: String(format:"%@ %@",(cellSchedule0!.dateButton.titleLabel?.text)!,(cellSchedule0!.timeButton.titleLabel?.text)!) as NSString as NSString, publishDate: String(format:"%@ %@",(cellSchedule1!.dateButton.titleLabel?.text)!,(cellSchedule1!.timeButton.titleLabel?.text)!) as NSString, expiryDate: String(format:"%@ %@",(cellSchedule2!.dateButton.titleLabel?.text)!,(cellSchedule2!.timeButton.titleLabel?.text)!) as NSString, notifyDate: "", userID: self.groupProfileID as NSString, grpID: self.groupID as! NSString as! NSString, RepeatDateTime: strprofileIDs as NSString, questionType: self.questionType as! NSString, questionText: questionStr as! NSString as! NSString, option1: ansOption1 as! NSString as! NSString, option2: ansOption2 as! NSString,sendSMSNonSmartPh: self.nonSmartSMSFlag ,sendSMSAll: self.allSMSFlag,rsvpEnable:self.varIsRSVPEnableorDisable,displayOnBanners:"1",link:cell.textfieldTitleLater.text! as NSString,isSubGrpAdmin:"0")
                                    
                                    
                                    
                                }
                                else
                                {
                                    print("333 This is flag value edit :--------")
                                    print(self.allSMSFlag)
                                    wsm.addEventsResult(eventID:self.eventsDetails.eventID as! NSString, questionEnable: self.eventsDetails.questionType as! NSString, eventType: self.annTypeStr, membersIDs: self.commonIDString as NSString as NSString, eventImageID: self.ImsgId, evntTitle: cell.eventTitleField.text! as NSString, evntDesc: cell.eventDescTextView.text! as NSString, eventVenue: cell.eventVenueTextView.text! as NSString, venueLat: self.venueLat, venueLong: self.venueLon, evntDate: String(format:"%@ %@",(cellSchedule0!.dateButton.titleLabel?.text)!,(cellSchedule0!.timeButton.titleLabel?.text)!) as NSString as NSString, publishDate: String(format:"%@ %@",(cellSchedule1!.dateButton.titleLabel?.text)!,(cellSchedule1!.timeButton.titleLabel?.text)!) as NSString, expiryDate: String(format:"%@ %@",(cellSchedule2!.dateButton.titleLabel?.text)!,(cellSchedule2!.timeButton.titleLabel?.text)!) as NSString, notifyDate: "", userID: self.groupProfileID as NSString, grpID: self.groupID as! NSString, RepeatDateTime: strprofileIDs as NSString as NSString, questionType: self.eventsDetails.questionType as! NSString, questionText: self.eventsDetails.questionText as! NSString, option1: self.eventsDetails.option1 as! NSString, option2: self.eventsDetails.option2 as! NSString,sendSMSNonSmartPh: self.nonSmartSMSFlag ,sendSMSAll: self.allSMSFlag,rsvpEnable:self.varIsRSVPEnableorDisable,displayOnBanners:"1",link:cell.textfieldTitleLater.text! as NSString,isSubGrpAdmin:self.isSubGrpAdmin)
                                }
                                
                                
                                //}
                            }
                            //  self.window = nil
                            } as! CLGeocodeCompletionHandler)
                    }else{
                        // self.//loaderViewMethod()
                        let wsm : WebserviceClass = WebserviceClass.sharedInstance
                        wsm.delegates=self
                        if(self.isCalledFrom == "add"){
                            
                            print("444 This is flag value edit :--------")
                            print(self.allSMSFlag)
                            
                            wsm.addEventsResult(eventID:"0", questionEnable: self.questionType as! NSString, eventType: self.annTypeStr, membersIDs: self.commonIDString as NSString, eventImageID: self.ImsgId, evntTitle: cell.eventTitleField.text! as NSString, evntDesc: cell.eventDescTextView.text! as NSString, eventVenue: cell.eventVenueTextView.text! as NSString, venueLat: self.venueLat, venueLong: self.venueLon, evntDate: String(format:"%@ %@",(cellSchedule0!.dateButton.titleLabel?.text)!,(cellSchedule0!.timeButton.titleLabel?.text)!) as NSString, publishDate: String(format:"%@ %@",(cellSchedule1!.dateButton.titleLabel?.text)!,(cellSchedule1!.timeButton.titleLabel?.text)!) as NSString as NSString, expiryDate: String(format:"%@ %@",(cellSchedule2!.dateButton.titleLabel?.text)!,(cellSchedule2!.timeButton.titleLabel?.text)!) as NSString as NSString, notifyDate: "", userID: self.groupProfileID as NSString, grpID: self.groupID as! NSString, RepeatDateTime: strprofileIDs as NSString, questionType: self.questionType as! NSString, questionText: questionStr as! NSString, option1: ansOption1 as! NSString, option2: ansOption2 as! NSString,sendSMSNonSmartPh: self.nonSmartSMSFlag ,sendSMSAll: self.allSMSFlag,rsvpEnable:varIsRSVPEnableorDisable,displayOnBanners: "1",link:cell.textfieldTitleLater.text! as NSString,isSubGrpAdmin:self.isSubGrpAdmin)
                            
                        }else{
                            if(self.questionType != ""){
                                
                                
                                print("555 This is flag value edit :--------")
                                print(self.allSMSFlag)
                                
                                wsm.addEventsResult(eventID:self.eventsDetails.eventID as! NSString as! NSString, questionEnable: self.questionType as! NSString, eventType: self.annTypeStr, membersIDs: self.commonIDString as NSString as NSString, eventImageID: self.ImsgId, evntTitle: cell.eventTitleField.text! as NSString as NSString, evntDesc: cell.eventDescTextView.text! as NSString as NSString, eventVenue: cell.eventVenueTextView.text! as NSString, venueLat: self.venueLat, venueLong: self.venueLon, evntDate: String(format:"%@ %@",(cellSchedule0!.dateButton.titleLabel?.text)!,(cellSchedule0!.timeButton.titleLabel?.text)!) as NSString as NSString, publishDate: String(format:"%@ %@",(cellSchedule1!.dateButton.titleLabel?.text)!,(cellSchedule1!.timeButton.titleLabel?.text)!) as NSString, expiryDate: String(format:"%@ %@",(cellSchedule2!.dateButton.titleLabel?.text)!,(cellSchedule2!.timeButton.titleLabel?.text)!) as NSString, notifyDate: "", userID: self.groupProfileID as NSString as NSString, grpID: self.groupID as! NSString, RepeatDateTime: strprofileIDs as NSString, questionType: self.questionType as! NSString as! NSString, questionText: questionStr as! NSString, option1: ansOption1 as! NSString as! NSString, option2: ansOption2 as! NSString,sendSMSNonSmartPh: self.nonSmartSMSFlag ,sendSMSAll: self.allSMSFlag,rsvpEnable:varIsRSVPEnableorDisable,displayOnBanners: "1",link:cell.textfieldTitleLater.text! as NSString,isSubGrpAdmin:self.isSubGrpAdmin)
                            }else{
                                
                                print("666 This is flag value edit :--------")
                                print(self.allSMSFlag)
                                
                                wsm.addEventsResult(eventID:self.eventsDetails.eventID as! NSString, questionEnable: self.eventsDetails.questionType as! NSString as! NSString, eventType: self.annTypeStr, membersIDs: self.commonIDString as NSString, eventImageID: self.ImsgId, evntTitle: cell.eventTitleField.text! as NSString, evntDesc: cell.eventDescTextView.text! as NSString, eventVenue: cell.eventVenueTextView.text! as NSString, venueLat: self.venueLat, venueLong: self.venueLon, evntDate: String(format:"%@ %@",(cellSchedule0!.dateButton.titleLabel?.text)!,(cellSchedule0!.timeButton.titleLabel?.text)!) as NSString, publishDate: String(format:"%@ %@",(cellSchedule1!.dateButton.titleLabel?.text)!,(cellSchedule1!.timeButton.titleLabel?.text)!) as NSString as NSString, expiryDate: String(format:"%@ %@",(cellSchedule2!.dateButton.titleLabel?.text)!,(cellSchedule2!.timeButton.titleLabel?.text)!) as NSString, notifyDate: "", userID: self.groupProfileID as NSString, grpID: self.groupID as! NSString, RepeatDateTime: strprofileIDs as NSString, questionType: self.eventsDetails.questionType as! NSString, questionText: self.eventsDetails.questionText as! NSString, option1: self.eventsDetails.option1 as! NSString, option2: self.eventsDetails.option2 as! NSString as! NSString,sendSMSNonSmartPh: self.nonSmartSMSFlag ,sendSMSAll: self.allSMSFlag,rsvpEnable:varIsRSVPEnableorDisable,displayOnBanners:"1",link:cell.textfieldTitleLater.text! as NSString,isSubGrpAdmin:self.isSubGrpAdmin)
                            }
                        }
                        //  self.window = nil
                        self.addEventBtn.isEnabled=true
                        
                    }
                    // self.window = nil
                    self.addEventBtn.isEnabled=true
                    //UserDefaults.standard.set("nothing", forKey: "session_LinkValue")
                }
                // self.window = nil
                self.addEventBtn.isEnabled=true
                
            }
        }
        else
        {
            //self.window = nil
            
            SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
    }
    
    
    @IBAction func AddEventAction(_ sender: AnyObject)
    {
        let cells:SmsQuestionCell =  cellArray.object(at: 4) as! SmsQuestionCell
        if isCategory=="1" && cells.allMemSMSButton.currentImage!.isEqual(UIImage(named: "switchOn"))
//        if isCategory=="1" && cells.allMemSMSButton.currentImage!.isEqual(UIImage(named: "switchOn"))
        
        {
           // self.isFromAddUpdateEventButton=true
           // self.getSMSCountdetails()
            isFromAddUpdateEventButton=false
            AddUpdateEvent()
        }
        else
        {
            isFromAddUpdateEventButton=false
            AddUpdateEvent()
        }
        
        
//        if (cells.allMemSMSButton.currentImage!.isEqual(UIImage(named: "switchOn")))
//        {
//        }
//        else
//        {
//        }
    }
    
    func  addEventDelegateFunction(addAnnoun : AddEventResult){
        
        print("This is server response :----")
        print(addAnnoun.status)
        print(addAnnoun.message)
        varISClicked=0
        self.addEventBtn.isEnabled=true
        if(addAnnoun.status == "1"){
            self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
            SVProgressHUD.dismiss()
            
        }
       else if(addAnnoun.status == "0"){
            
            ImsgId=""
            addQueTextView.text = "Tap to add Question"
          //  self.window = nil
            
            if(addEventBtn.titleLabel?.text == "Update")
            {
                let alert = UIAlertController(title: "Event", message: "Updated successfully.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                    
                    isVisitedAddEventsScreen=1
                    self.objprotocolForEventsListingCallingApi?.functionForEventsListingCallingApi(stringFromWhereITCalling: "itCallingFrom-Add Evewnts screen 55 ")
                    self.navigationController?.popViewController(animated: true)
                    
                }));
                self.present(alert, animated: true, completion: nil)
            }
            else
                
            {
                let alert = UIAlertController(title: "Event", message: "Added successfully.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                    //self.isVisitedAddEventsScreen=1
                    self.objprotocolForEventsListingCallingApi?.functionForEventsListingCallingApi(stringFromWhereITCalling: "itCallingFrom-Add Evewnts screen")
                    self.navigationController?.popViewController(animated: true)
                    
                }));
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        else
        {
          //  self.window = nil
        }
    }
    
    @IBAction func CancelEventAction(_ sender: AnyObject)
    {
        addQueTextView.text = "Tap to add Question"
        self.navigationController?.popViewController(animated: true)
    }
    
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        print("bound size \(self.bounds.size.height)");
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.bounds.size.width, height: self.bounds.size.height)
                
        }, completion: { finished in
            
        })
        
        if(textField.tag == 90 || textField.tag == 91){
            if(ans1TextField.text == ""){
                type1option1Btn.setImage(UIImage(named: "radiobutton"),  for: UIControl.State.normal)
            }
            if(ans2TextField.text == ""){
                type1option2Btn.setImage(UIImage(named: "radiobutton"),  for: UIControl.State.normal)
            }
        }
        return false
    }
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
        let cell = cellArray.object(at: 0) as! HeaderCelll
        //        cell.eventVenueTextView.resignFirstResponder()
        //        cell.eventDescTextView.resignFirstResponder()
        //        cell.eventTitleField.resignFirstResponder()
        if(textField == cell.eventTitleField)
        {
            myview.removeFromSuperview()
        }
        
        if addQueTextView.text == ""
        {
            addQueTextView.text = "Tap to add Question"
        }
        else
        {
            
        }
        
        // if(textField.tag == 90 || textField.tag == 91)
        // {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                //  self.view.frame = CGRectMake(self.view.frame.origin.x, -170 , self.bounds.size.width, self.bounds.size.height)
                
                
        }, completion: { finished in
            
        })
        
        if(textField.tag == 90){
            type1option1Btn.setImage(UIImage(named: "radiobuttonblue"),  for: UIControl.State.normal)
        }
        if(textField.tag == 91){
            type1option2Btn.setImage(UIImage(named: "radiobuttonblue"),  for: UIControl.State.normal)
        }
        // textField.resignFirstResponder()
        
        //}
    }
    
    
    
    
    //////////////////////////// ==============  Question View ================= ////////////////////////////////////
    
    //    func addQueDelegateActionNew(string:Int)
    //    {
    //
    //        if string == 0
    //        {
    //            print("Show Add Question")
    //
    //            OpenQueView()
    //
    //        }
    //        else
    //        {
    //
    //
    //
    //            let cellAddQue = cellArray.objectAtIndex(5) as? AddQuestionCell
    //            cellAddQue?.editQuestionButton.hidden = true
    //
    //            cellAddQue?.questionSwitch.on = false
    //            let cell=cellArray.objectAtIndex(6) as! QuestionViewCell
    //            cell.QuestionTitleLabel.text = ""
    //            cell.Option1Label.text=""
    //            cell.Option2Label.text=""
    //            addQueTextView.text = "Tap to add Question"
    //            addEventTableView.reloadData()
    //
    //            print("Close Add Question")
    //        }
    //
    //    }
    var eventFilterCheck:String! = ""
    
    func addQueDelegateAction(_ string:Int){
        print(string)
        //let top = IndexPath(row: NSNotFound , section: 0)

       // addEventTableView.scrollToRow(at: bott, at: .bottom, animated: true)

        
        
        let indexPath = IndexPath(row: cellArray.count - 1, section: 0)
        self.addEventTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        
        
        if(string==0)
        {
            print("This is 1")
            varIsRSVPEnableorDisable=1
            varNewIndex=100
            
            print("hello this is 1 and 2")
            
            print(eventsDetails.questionText as? String)

            if let str = eventsDetails.questionText as? String
            {
                print("hello this is 333 and 4")

                 let cellAddQue = cellArray.object(at: 6) as? QuestionViewCell
                addQueTextView.text = cellAddQue?.QuestionTitleLabel.text

                
                
                
                
                let cellHeader2 = cellArray.object(at: 6) as! QuestionViewCell
                
                
                cellHeader2.QuestionTitleLabel.text = eventsDetails.questionText
                cellHeader2.Option1Label.text = eventsDetails.option1
                cellHeader2.Option2Label.text = eventsDetails.option2
                addEventTableView.reloadData()
            }

            
            
            addEventTableView.reloadData()
        }
        else  if(string==1)
        {
            print("This is 2")
            let refreshAlert = UIAlertController(title: "Rotary India", message: "RSVP result will be reset to 0", preferredStyle: .alert)
            
           // refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
            print(self.eventsDetails.eventID)
                self.varIsRSVPEnableorDisable=0
                self.varNewIndex=50
            
            //code by rajendra jat new 29 oct 12.47pm
            //new case or new event add
            if(self.eventsDetails.eventID=="0" || self.eventsDetails.eventID == nil )
            {
                addQueTextView.text = "Tap to add Question"
                 let cellHeader2 = cellArray.object(at: 6) as! QuestionViewCell
                cellHeader2.QuestionTitleLabel.text = ""
                cellHeader2.Option1Label.text = ""
                cellHeader2.Option2Label.text = ""
                 let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
                cellAddQue?.questionSwitchNew.isOn=false
                 cellAddQue?.editQuestionButton.isHidden = true

               // addQueTextView.text=""
            }
            else
            {
                addQueTextView.text = "Tap to add Question"
            }
            
            
            
            
            
            //when update event
            
                self.addEventTableView.reloadData()
           // }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
                
                let cellAddQue = self.cellArray.object(at: 5) as? AddQuestionCell
                if(self.isCalledFrom=="edit" || self.isCalledFrom=="add")
                {
                    print("-----------------------*************",self.varIsRSVPEnableorDisable)
                    if(self.varIsRSVPEnableorDisable==0)
                    {
                        cellAddQue!.questionSwitch.isOn=false
                        
                    }
                    else
                    {
                        cellAddQue!.questionSwitch.isOn=true
                        cellAddQue!.questionSwitchNew.isOn=false
                    }
                }
                
                self.varIsRSVPEnableorDisable=1
                //self.varNewIndex=100
                self.addEventTableView.reloadData()
            }))
            
            
            if(eventFilterCheck=="Published" && self.isCalledFrom=="edit")
            {
                //comment by rajendra as discussed with Naren Sir
               // present(refreshAlert, animated: true, completion: nil)
            }
            else
                
            {
                
            }
            
            // presentViewController(refreshAlert, animated: true, completion: nil)
            
            
        }
            
        else  if(string==5)
        {
            print("Show Add Question")
            
            OpenQueView()
        }
        else  if(string==6)
        {
            let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
            cellAddQue?.editQuestionButton.isHidden = true
            
            //cellAddQue?.questionSwitch.on = false // When add Question disable or enble rsvp code comment by dpk
            let cell=cellArray.object(at: 6) as! QuestionViewCell
            cell.QuestionTitleLabel.text = ""
            cell.Option1Label.text=""
            cell.Option2Label.text=""
            addQueTextView.text = "Tap to add Question"
            addEventTableView.reloadData()
            
            print("Close Add Question")
        }
        
    }
    
    
    func OpenQueView()
    {
        questionType = ""
        MainAddQueBGView = UIView()
        MainAddQueBGView.frame = CGRect(x: 0,y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        MainAddQueBGView.backgroundColor = UIColor.clear
        self.view.addSubview(MainAddQueBGView)
        
        
        ImageBGQue = UIImageView()
        ImageBGQue.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        ImageBGQue.backgroundColor = UIColor.black
        ImageBGQue.isOpaque = true
        ImageBGQue.alpha = 0.65
        ImageBGQue.isUserInteractionEnabled = false
        MainAddQueBGView.addSubview(ImageBGQue)
        
        AddQuestionView = UIView()
        AddQuestionView.frame = CGRect(x: (self.view.frame.size.width)/2-145, y: (self.view.frame.size.height)/2-100, width: 290, height: 220)
        AddQuestionView.backgroundColor = UIColor.white
        MainAddQueBGView.addSubview(AddQuestionView)
        //76 175 80
        
        let title = UILabel()
        title.frame = CGRect(x: 59, y: 15, width: 190, height: 31)
        title.text = "Select a Question Type"
        AddQuestionView.addSubview(title)
        
        
        let closeButton = UIButton()
        closeButton.frame = CGRect(x: 252, y: 6, width: 30, height: 30)
        closeButton.addTarget(self, action: #selector(AddEventsController.closeMainQueView), for: .touchUpInside)
        closeButton.setImage(UIImage(named: "close"),  for: UIControl.State.normal)
        AddQuestionView.addSubview(closeButton)
        
        let border = UIImageView()
        border.frame = CGRect(x: 0, y: 73, width: 290, height: 1)
        border.backgroundColor = UIColor.lightGray
        AddQuestionView.addSubview(border)
        
        
        
        let Option1Button : UIButton = UIButton(frame: CGRect(x: 8, y: 74, width: 250, height: 41))
        Option1Button.backgroundColor = UIColor.clear
        Option1Button.setTitle("",  for: UIControl.State.normal)
        Option1Button.addTarget(self, action: #selector(self.radioButton1Action(_:)), for: UIControl.Event.touchUpInside)
        Option1Button.setTitleColor(UIColor.black,  for: UIControl.State.normal)
        AddQuestionView.addSubview(Option1Button)
        
        let Option1Label : UILabel = UILabel(frame: CGRect(x: 8, y: 74, width: 250, height: 41))
        Option1Label.backgroundColor = UIColor.clear
        Option1Label.text = "Radio Button(single select)"
        Option1Label.isUserInteractionEnabled = false
        Option1Label.textColor = UIColor.darkGray
        AddQuestionView.addSubview(Option1Label)
        
        
        option1Btn = UIButton(frame: CGRect(x: 252, y: 74, width: 41, height: 41))
        option1Btn.addTarget(self, action: #selector(AddEventsController.radioButton1Action(_:)), for: UIControl.Event.touchUpInside)
        option1Btn.setImage(UIImage(named: "radiobutton"),  for: UIControl.State.normal)
        option1Btn.tag = 1
        AddQuestionView.addSubview(option1Btn)
        
        let border1 = UIImageView()
        border1.frame = CGRect(x: 0, y: 115, width: 290, height: 1)
        border1.backgroundColor = UIColor.lightGray
        AddQuestionView.addSubview(border1)
        
        let Option2Button : UIButton = UIButton(frame: CGRect(x: 8, y: 116, width: 250, height: 41))
        Option2Button.backgroundColor = UIColor.clear
        Option2Button.setTitleColor(UIColor.black,  for: UIControl.State.normal)
        Option2Button.setTitle("",  for: UIControl.State.normal)
        Option2Button.addTarget(self, action: #selector(AddEventsController.radioButton2Action(_:)), for: UIControl.Event.touchUpInside)
        AddQuestionView.addSubview(Option2Button) // add to view as subview
        
        let Option2Label : UILabel = UILabel(frame: CGRect(x: 8, y: 116, width: 250, height: 41))
        Option2Label.backgroundColor = UIColor.clear
        Option2Label.text = "Open Ended"
        Option2Label.isUserInteractionEnabled = false
        Option2Label.textColor = UIColor.darkGray
        AddQuestionView.addSubview(Option2Label)
        
        option2Btn = UIButton(frame: CGRect(x: 252, y: 116, width: 41, height: 41))
        option2Btn.setImage(UIImage(named: "radiobutton"),  for: UIControl.State.normal)
        option2Btn.addTarget(self, action: #selector(AddEventsController.radioButton2Action(_:)), for: UIControl.Event.touchUpInside)
        option2Btn.tag = 2
        AddQuestionView.addSubview(option2Btn) // add to view as subview
        
        let border2 = UIImageView()
        border2.frame = CGRect(x: 0, y: 157, width: 290, height: 1)
        border2.backgroundColor = UIColor.lightGray
        AddQuestionView.addSubview(border2)
        
        let nextButton : UIButton = UIButton(frame: CGRect(x: 0, y: 158, width: 290, height: 60))
        nextButton.backgroundColor = UIColor.clear
        nextButton.setTitleColor(UIColor(red: 76/255.0, green: 175/255.0, blue: 80/255.0, alpha: 1.0),  for: UIControl.State.normal)
        nextButton.setTitle("Next",  for: UIControl.State.normal)
        nextButton.addTarget(self, action: #selector(self.nextButtonClk(_:)), for: UIControl.Event.touchUpInside)
        AddQuestionView.addSubview(nextButton)
    }
    
    @objc func nextButtonClk(_ sender : UIButton)
    {
        if(questionType != ""){
            if(questionType == "1"){
                
                MainAddQueBGView.removeFromSuperview()
                OpenEndedView()
                
            }else{
                
                MainAddQueBGView.removeFromSuperview()
                TapToAddQuestionView()
            }
        }else{
            /*
             let alert = UIAlertController(title: "", message: "Please select question type.", preferredStyle: UIAlertController.Style.Alert)
             alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Cancel, handler:nil))
             self.presentViewController(alert, animated: true, completion: nil)
             */
            
            self.view.makeToast("Please select question type", duration: 2, position: CSToastPositionCenter)
            
            
            
        }
    }
    
    
    @objc func radioButton1Action(_ sender : UIButton)
    {
        print("button 1 clicked")
        questionType = "2"
        option1Btn.setImage(UIImage(named: "radiobuttonblue"),  for: UIControl.State.normal)
        option2Btn.setImage(UIImage(named: "radiobutton"),  for: UIControl.State.normal)
        
    }
    
    @objc func radioButton2Action(_ sender : UIButton)
    {
        print("button 2 clicked")
        questionType = "1"
        option1Btn.setImage(UIImage(named: "radiobutton"),  for: UIControl.State.normal)
        option2Btn.setImage(UIImage(named: "radiobuttonblue"),  for: UIControl.State.normal)
    }
    
    @objc func closeMainQueView() // Cross Button Open Ended
    {
        MainAddQueBGView.removeFromSuperview()
        let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
        cellAddQue?.questionSwitchNew.isOn = false
        
        
        let cellHeader2 = cellArray.object(at: 6) as? QuestionViewCell
        if (cellHeader2?.QuestionTitleLabel.text != "" && cellHeader2?.Option1Label.text != "" && cellHeader2?.Option2Label.text != "")
        {
            let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
            cellAddQue?.questionSwitchNew.isOn=true
        }
        else
        {
            let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
            cellAddQue?.questionSwitchNew.isOn=false
        }
        
        
        
        
        /*
         if(isCalledFrom != "add"){
         if(eventsDetails.questionId == ""){
         let cellAddQue = cellArray.objectAtIndex(5) as? AddQuestionCell
         
         cellAddQue?.questionSwitchNew.on = false
         cellAddQue?.questionSwitch.on = false
         }
         }
         
         if(addQueTextView.text == "Tap to add Question")
         {
         let cellAddQue = cellArray.objectAtIndex(5) as? AddQuestionCell
         cellAddQue?.questionSwitchNew.on = false
         cellAddQue?.questionSwitch.on = false
         }
         varNewIndex=50
         
         */
        addEventTableView.reloadData()
    }
    
    
    func TapToAddQuestionView()
    {
        MainAddQueBGView = UIView()
        MainAddQueBGView.frame = CGRect(x: 0,y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        MainAddQueBGView.backgroundColor = UIColor.clear
        self.view.addSubview(MainAddQueBGView)
        
        ImageBGQue = UIImageView()
        ImageBGQue.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        ImageBGQue.backgroundColor = UIColor.gray
        ImageBGQue.isOpaque = true
        ImageBGQue.alpha = 0.65
        ImageBGQue.isUserInteractionEnabled = false
        MainAddQueBGView.addSubview(ImageBGQue)
        
        AddQuestionView = UIView()
        // AddQuestionView.frame = CGRectMake((self.view.frame.size.width)/2-137, (self.view.frame.size.height)/2-152, 274, 305)
        AddQuestionView.frame = CGRect(x: (self.view.frame.size.width)/2-137, y: (self.view.frame.size.height)/2-100, width: 274, height: 305)
        
        AddQuestionView.backgroundColor = UIColor.white
        MainAddQueBGView.addSubview(AddQuestionView)
        
        
        let closeButton = UIButton()
        closeButton.frame = CGRect(x: 241, y: 3, width: 30, height: 30)
        closeButton.addTarget(self, action: #selector(AddEventsController.closeMainQueView), for: .touchUpInside)
        closeButton.setImage(UIImage(named: "close"),  for: UIControl.State.normal)
        AddQuestionView.addSubview(closeButton)
        
        
        addQueTextView = UITextView()
        addQueTextView.frame = CGRect(x: 15, y: 33, width: 244, height: 104)
        addQueTextView.textAlignment = NSTextAlignment.center
        addQueTextView.textColor = UIColor.gray
        addQueTextView.backgroundColor = UIColor.clear
        addQueTextView.layer.borderWidth = 1
        addQueTextView.layer.cornerRadius = 5.0
        addQueTextView.tag = 999
        addQueTextView.delegate = self
        addQueTextView.text = "Tap to add Question"
        addQueTextView.font = UIFont(name: "Roboto-Regular", size: 18)
        AddQuestionView.addSubview(addQueTextView)
        
        let border2 = UIImageView()
        border2.frame = CGRect(x: 0, y: 153, width: 274, height: 1)
        border2.backgroundColor = UIColor.lightGray
        AddQuestionView.addSubview(border2)
        
        ans1TextField = UITextField()
        ans1TextField.frame = CGRect(x: 15, y: 154, width: 244, height: 35.0)
        ans1TextField.textAlignment = NSTextAlignment.left
        ans1TextField.textColor = UIColor.black
        //ans1TextField.borderStyle = UITextField.BorderStyle.Bezel
        ans1TextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        
        ans1TextField.autocorrectionType = .no
        ans1TextField.placeholder = "Tap to add Answer 1"
        ans1TextField.tag = 90
        ans1TextField.delegate = self
        ans1TextField.font = UIFont(name: "Roboto-Regular", size: 15.0)
        // ans1TextField.layer.cornerRadius = 5// change tag property
        // ans1TextField.layer.borderWidth = 0.4
        AddQuestionView.addSubview(ans1TextField)
        
        type1option1Btn = UIButton(frame: CGRect(x: 235, y: 154, width: 35.0, height: 35.0))
        type1option1Btn.setImage(UIImage(named: "radiobutton"),  for: UIControl.State.normal)
        type1option1Btn.addTarget(self, action: #selector(self.radioButton2Action(_:)), for: UIControl.Event.touchUpInside)
        type1option1Btn.tag = 2
        AddQuestionView.addSubview(type1option1Btn)

        let border = UIImageView()
        border.frame = CGRect(x: 0, y: 205, width: 274, height: 1)
        border.backgroundColor = UIColor.lightGray
        AddQuestionView.addSubview(border)
        
        ans2TextField = UITextField()
        ans2TextField.frame = CGRect(x: 15, y: 206, width: 244, height: 35.0)
        ans2TextField.textAlignment = NSTextAlignment.left
        ans2TextField.textColor = UIColor.black
        
        ans2TextField.autocorrectionType = .no
        
        ans2TextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        ans2TextField.placeholder = "Tap to add Answer 2"
        ans2TextField.tag = 91
        ans2TextField.delegate = self
        ans2TextField.font = UIFont(name: "Roboto-Regular", size: 15.0)
        AddQuestionView.addSubview(ans2TextField)
        
        
        type1option2Btn = UIButton(frame: CGRect(x: 235, y: 206, width: 35.0, height: 35.0))
        type1option2Btn.setImage(UIImage(named: "radiobutton"),  for: UIControl.State.normal)
        type1option2Btn.addTarget(self, action: #selector(AddEventsController.radioButton2Action(_:)), for: UIControl.Event.touchUpInside)
        type1option2Btn.tag = 2
        AddQuestionView.addSubview(type1option2Btn)
        
        let border1 = UIImageView()
        border1.frame = CGRect(x: 0, y: 250, width: 274, height: 1)
        border1.backgroundColor = UIColor.lightGray
        AddQuestionView.addSubview(border1)
        
        
        let DoneAddButton = UIButton()
        DoneAddButton.frame = CGRect(x: 36, y: 259, width: 90, height: 35)
        DoneAddButton.backgroundColor = UIColor(red: (38/255.0), green: (113/255.0), blue: (37/255.0), alpha: 1.0)
        DoneAddButton.addTarget(self, action: #selector(self.DoneButtonAction(_:)), for: .touchUpInside)
        DoneAddButton.layer.cornerRadius = 5.0
        DoneAddButton.setTitle("Add",  for: UIControl.State.normal)
        AddQuestionView.addSubview(DoneAddButton)
        
        
        let cancelButton = UIButton()
        cancelButton.frame = CGRect(x: 148, y: 259, width: 90, height: 35)
        cancelButton.backgroundColor = UIColor.lightGray
        cancelButton.addTarget(self, action: #selector(self.CancelButtonAction(_:)), for: .touchUpInside)
        cancelButton.layer.cornerRadius = 5.0
        cancelButton.setTitle("Back",  for: UIControl.State.normal)
        AddQuestionView.addSubview(cancelButton)
        
        
        questionType = "2"
    }
    
    
    @objc func DoneButtonAction(_ sender : UIButton)
    {
        print("button 1 clicked")
        
        if addQueTextView.text == "" || addQueTextView.text == "Tap to add Question"
        {
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.bounds.size.width, height: self.bounds.size.height)
                    
                    
                    
            }, completion: { finished in
                
            })
            /*
             let alert = UIAlertController(title: "TMC", message: "Please enter Question. ", preferredStyle: UIAlertController.Style.Alert)
             alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
             self.presentViewController(alert, animated: true, completion: nil)
             */
            
            self.view.makeToast("Please enter Question", duration: 2, position: CSToastPositionCenter)
            
            
        }
        else if(ans1TextField.text == "" || ans2TextField.text == ""){
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.bounds.size.width, height: self.bounds.size.height)
            }, completion: { finished in
                
            })
            /*
             let alert = UIAlertController(title: "TMC", message: "Please enter text for option. ", preferredStyle: UIAlertController.Style.Alert)
             alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
             self.presentViewController(alert, animated: true, completion: nil)
             */
            self.view.makeToast("Please enter text for option", duration: 2, position: CSToastPositionCenter)
            
            
            
        }
            
        else
        {
            let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
            
            cellAddQue?.editQuestionButton.isHidden = false
            
            MainAddQueBGView.removeFromSuperview()
            if addQueTextView.text == ""
            {
                if let str = eventsDetails.questionText as? String
                {
                    let cellHeader2 = cellArray.object(at: 6) as! QuestionViewCell
                    
                    
                    cellHeader2.QuestionTitleLabel.text = eventsDetails.questionText
                    cellHeader2.Option1Label.text = eventsDetails.option1
                    cellHeader2.Option2Label.text = eventsDetails.option2
                    addEventTableView.reloadData()
                }
                else
                {
                    
                }
            }
            else
            {
                
                let cellHeader2 = cellArray.object(at: 6) as! QuestionViewCell
                
                cellHeader2.QuestionTitleLabel.text = addQueTextView.text
                cellHeader2.Option1Label.text = ans1TextField.text
                cellHeader2.Option2Label.text = ans2TextField.text
                if editOrNot == true
                {
                }
                else
                {
                }
                addEventTableView.reloadData()
            }
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.bounds.size.width, height: self.bounds.size.height)
                    
                    
                    
            }, completion: { finished in
                
            })
        }
        
    }
    
    @objc func CancelButtonAction(_ sender : UIButton) //Radio button BackButton
    {
        print("button 2 clicked")
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 ,width: self.bounds.size.width, height: self.bounds.size.height)
                
                
                
        }, completion: { finished in
            
        })
        if(isCalledFrom != "add"){
            if(eventsDetails.questionId == ""){
                let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
                print("-----------------------*************",varIsRSVPEnableorDisable)
                if(varIsRSVPEnableorDisable==0)
                {
                    cellAddQue!.questionSwitch.isOn=false
                }
                else
                {
                    cellAddQue!.questionSwitch.isOn=true
                }
                
            }
        }
        if(addQueTextView.text == "Tap to add Question")
        {
            let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
            
            if(isCalledFrom=="edit" )
            {
                print("-----------------------*************",varIsRSVPEnableorDisable)
                if(varIsRSVPEnableorDisable==0)
                {
                    cellAddQue!.questionSwitch.isOn=false
                    
                }
                else
                {
                    cellAddQue!.questionSwitch.isOn=true
                    cellAddQue!.questionSwitchNew.isOn=false
                }
            }
            else
            {
                cellAddQue?.questionSwitchNew.isOn=false // When user select any question type and click back button we disable
                // cellAddQue?.questionSwitch.on = false
            }
            
            
        }
        else
        {
            let cellHeader2 = cellArray.object(at: 6) as? QuestionViewCell
            
            if (cellHeader2?.QuestionTitleLabel.text != "" && cellHeader2?.Option1Label.text != "" && cellHeader2?.Option2Label.text != "")
            {
                let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
                cellAddQue?.questionSwitchNew.isOn=true
            }
            else
            {
                let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
                cellAddQue?.questionSwitchNew.isOn=false
            }
            
            
        }
        MainAddQueBGView.removeFromSuperview()
        
        
        
        
        
        
    }
    
    
    
    func OpenEndedView()
    {
        MainAddQueBGView = UIView()
        MainAddQueBGView.frame = CGRect(x: 0,y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        MainAddQueBGView.backgroundColor = UIColor.clear
        self.view.addSubview(MainAddQueBGView)
        self.view.bringSubviewToFront( MainAddQueBGView)
        
        ImageBGQue = UIImageView()
        ImageBGQue.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        ImageBGQue.backgroundColor = UIColor.darkGray
        ImageBGQue.isOpaque = true
        ImageBGQue.alpha = 0.65
        ImageBGQue.isUserInteractionEnabled = false
        MainAddQueBGView.addSubview(ImageBGQue)
        
        AddQuestionView = UIView()
        AddQuestionView.frame = CGRect(x: (self.view.frame.size.width)/2-137, y: (self.view.frame.size.height)/2-152, width: 274, height: 305)
        AddQuestionView.backgroundColor = UIColor.white
        MainAddQueBGView.addSubview(AddQuestionView)
        
        
        let closeButton = UIButton()
        closeButton.frame = CGRect(x: 241, y: 3, width: 30, height: 30)
        closeButton.addTarget(self, action: #selector(AddEventsController.closeMainQueView), for: .touchUpInside)
        closeButton.setImage(UIImage(named: "close"),  for: UIControl.State.normal)
        AddQuestionView.addSubview(closeButton)
        
        
        addQueTextView = UITextView()
        addQueTextView.frame = CGRect(x: 15, y: 33, width: 244, height: 104)
        addQueTextView.textAlignment = NSTextAlignment.center
        addQueTextView.textColor = UIColor.darkGray
        addQueTextView.backgroundColor = UIColor.clear
        addQueTextView.layer.borderWidth = 1
        addQueTextView.layer.cornerRadius = 5.0
        //addQueTextView.layer.borderColor = UIColor.darkGrayColor()
        addQueTextView.tag = 999
        addQueTextView.delegate = self
        addQueTextView.text = "Tap to add Question"
        addQueTextView.font = UIFont(name: "Roboto-Regular", size: 18)
        AddQuestionView.addSubview(addQueTextView)
        
        
        let addAnsTextView = UITextView()
        addAnsTextView.frame = CGRect(x: 15, y: 148, width: 244, height: 91)
        addAnsTextView.textAlignment = NSTextAlignment.center
        addAnsTextView.textColor = UIColor.darkGray
        addAnsTextView.backgroundColor = UIColor.lightGray
        addAnsTextView.layer.borderWidth = 1
        addAnsTextView.layer.cornerRadius = 5.0
        addAnsTextView.tag = 99
        addAnsTextView.isEditable = false
        addAnsTextView.delegate = self
        
        addAnsTextView.text = "Recepient's respond here"
        addAnsTextView.font = UIFont(name: "Roboto-Regular", size: 18)
        AddQuestionView.addSubview(addAnsTextView)
        
        
        let DoneAddButton = UIButton()
        DoneAddButton.frame = CGRect(x: 36, y: 253, width: 90, height: 40)
        DoneAddButton.backgroundColor = UIColor(red: (38/255.0), green: (113/255.0), blue: (37/255.0), alpha: 1.0)
        DoneAddButton.addTarget(self, action: #selector(self.DoneOpenEndedAction(_:)), for: .touchUpInside)
        DoneAddButton.layer.cornerRadius = 5.0
        DoneAddButton.setTitle("Add",  for: UIControl.State.normal)
        AddQuestionView.addSubview(DoneAddButton)
        
        
        
        let cancelButton = UIButton()
        cancelButton.frame = CGRect(x: 148, y: 253, width: 90, height: 40)
        cancelButton.backgroundColor = UIColor.lightGray
        cancelButton.addTarget(self, action: #selector(AddEventsController.CancelOpenEndedAction(_:)), for: .touchUpInside)
        cancelButton.layer.cornerRadius = 5.0
        cancelButton.setTitle("Back",  for: UIControl.State.normal)
        AddQuestionView.addSubview(cancelButton)
        
        
        questionType = "1"
    }
    
    
   @objc  func DoneOpenEndedAction(_ sender : UIButton)
    {
        print("button 1 clicked")
        
        ans1TextField.text = ""
        ans2TextField.text = ""
        
        if addQueTextView.text == "" || addQueTextView.text == "Tap to add Question"
        {
            
            addQueTextView.text = "Tap to add Question"
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.bounds.size.width, height: self.bounds.size.height)
                    
                    
                    
            }, completion: { finished in
                
            })
            /*
             let alert = UIAlertController(title: "TMC", message: "Please enter Question.", preferredStyle: UIAlertController.Style.Alert)
             alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
             self.presentViewController(alert, animated: true, completion: nil)
             */
            
            self.view.makeToast("Please enter Question.", duration: 2, position: CSToastPositionCenter)
            
        }
            
        else
        {
            let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
            
            cellAddQue?.editQuestionButton.isHidden = false
            
            MainAddQueBGView.removeFromSuperview()
            
            
            if addQueTextView.text == ""
            {
                if let str = eventsDetails.questionText as String?
                {
                    let cellHeader2 = cellArray.object(at: 6) as! QuestionViewCell
                    
                    cellHeader2.QuestionTitleLabel.text = eventsDetails.questionText
                    cellHeader2.Option1Label.text = ""
                    cellHeader2.Option2Label.text = ""
                    
                }
                else
                {
                    
                }
            }
            else
            {
                
                let cellHeader2 = cellArray.object(at: 6) as! QuestionViewCell
                
                
                cellHeader2.QuestionTitleLabel.text = addQueTextView.text
                cellHeader2.Option1Label.text = ""//ans1TextField.text
                cellHeader2.Option2Label.text = ""//ans2TextField.text
                if editOrNot == true
                {
                    
                }
                else
                {
                    
                }
                
            }
            
            
            addEventTableView.reloadData()
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.bounds.size.width, height: self.bounds.size.height)
                    
                    
                    
            }, completion: { finished in
                
            })
        }
        
        
        
    }
    
   @objc  func CancelOpenEndedAction(_ sender : UIButton)   // Open ended Back Button
    {
        print("button 2 clicked")
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.bounds.size.width, height: self.bounds.size.height)
                
                
        }, completion: { finished in
            
        })
        if(isCalledFrom != "add"){
            if(eventsDetails.questionId == ""){
                let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
                // cellAddQue?.questionSwitch.on = false
                print("-----------------------*************",varIsRSVPEnableorDisable)
                if(varIsRSVPEnableorDisable==0)
                {
                    cellAddQue!.questionSwitch.isOn=false
                }
                else
                    
                {
                    cellAddQue!.questionSwitch.isOn=true
                }
                
            }
        }
        if(addQueTextView.text == "Tap to add Question")
        {
            let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
            
            if(isCalledFrom=="edit" )
            {
                print("-----------------------*************",varIsRSVPEnableorDisable)
                if(varIsRSVPEnableorDisable==0)
                {
                    cellAddQue!.questionSwitch.isOn=false
                    
                }
                else
                {
                    cellAddQue!.questionSwitch.isOn=true
                    cellAddQue!.questionSwitchNew.isOn=false
                }
            }
            else
            {
                //cellAddQue?.questionSwitch.on = false
                cellAddQue?.questionSwitchNew.isOn=false //// When user select any question type and click back button we disable
            }
            
            // cellAddQue?.questionSwitch.on = false
        }
        else
        {
            let cellHeader2 = cellArray.object(at: 6) as? QuestionViewCell
            
            if (cellHeader2?.QuestionTitleLabel.text != "" && cellHeader2?.Option1Label.text != "" && cellHeader2?.Option2Label.text != "")
            {
                let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
                cellAddQue?.questionSwitchNew.isOn=true
            }
            else
            {
                let cellAddQue = cellArray.object(at: 5) as? AddQuestionCell
                cellAddQue?.questionSwitchNew.isOn=false
            }
            
            
            
            
            
        }
        MainAddQueBGView.removeFromSuperview()
    }
    
    
    
    @objc func EditQueAction(_ sender : UIButton)
    {
        editOrNot = true
        
        let cellAddQue = cellArray.object(at: 6) as? QuestionViewCell
        if addQueTextView.text != "" || addQueTextView.text != "Tap to add Question"
        {
            
            if questionType == "2"
            {
                MainAddQueBGView.removeFromSuperview()
                TapToAddQuestionView()
                addQueTextView.text = cellAddQue?.QuestionTitleLabel.text
                ans1TextField.text = cellAddQue?.Option1Label.text
                ans2TextField.text = cellAddQue?.Option2Label.text
            }
            else if questionType == "1"
            {
                MainAddQueBGView.removeFromSuperview()
                OpenEndedView()
                
                addQueTextView.text = cellAddQue?.QuestionTitleLabel.text
            }
        }
    }
    
    
    //#MARK:- textview delegate methods.
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        print("sadadasdasdasdasdsadd")
        let cell =  cellArray.object(at: 0) as! HeaderCelll
        if textView==cell.eventDescTextView
        {
            print("eventDescTextView Enter in textViewShouldEndEditing")
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView){
        
        let cell =  cellArray.object(at: 0) as! HeaderCelll
        
        myview.removeFromSuperview()
        
        if textView == cell.eventDescTextView{
            print("eventDescTextView Enter in textViewDidBeginEditing")
            let cells:SmsQuestionCell =  cellArray.object(at: 4) as! SmsQuestionCell
            if textView.text.count>2000
            {
                allSMSFlag="0"
                displayOnBannerFlag="0"
//                cells.allMemSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
                cells.whatsappRadioBtn.isOn = false
            }
            else
            {
                
            }
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    // self.view.frame = CGRectMake(self.view.frame.origin.x, -170 , self.bounds.size.width, self.bounds.size.height)
            }, completion: { finished in
            })
        }
        if textView.tag == 99 || textView.tag == 999
        {
            let width = bounds.size.width
            if width > 320
            {
                
            }
            else
            {
                if textView.tag == 999
                {
                    
                }
                else{
                    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                        {
                            //  self.view.frame = CGRectMake(self.view.frame.origin.x, -140 , self.bounds.size.width, self.bounds.size.height)
                    }, completion: { finished in
                    })
                }
            }
        }
        
        
        if(textView.text == "" && textView.tag == 66){
            if(textView.tag==66){
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                    {
                        //
                        // self.view.frame = CGRectMake(self.view.frame.origin.x, -170 , self.bounds.size.width, self.bounds.size.height)
                        
                        
                }, completion: { finished in
                    
                })
                // textView.resignFirstResponder()
                //                let addEvent = self.storyboard?.instantiateViewControllerWithIdentifier("addrmap") as! GetAddresMapViewController
                //
                //                self.navigationController?.puvfshViewController(addEvent, animated: true)
            }else{
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                    {
                        
                        // self.view.frame = CGRectMake(self.view.frame.origin.x, -170 , self.bounds.size.width, self.bounds.size.height)
                        
                        
                }, completion: { finished in
                    
                })
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let cell =  cellArray.object(at: 0) as! HeaderCelll
        if textView==cell.eventDescTextView
        {
            print("eventDescTextView Enter in textViewShouldBeginEditing")
        }

        if(textView == addQueTextView){
            if(addQueTextView.text == "Tap to add Question")
            {
                addQueTextView.text = ""
            }
            else if (addQueTextView.text?.characters.count == 0)
            {
                addQueTextView.textColor = UIColor.black
                addQueTextView.text = "Tap to add Question"
            }
            else
            {
                
            }
        }
        
        return true;
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        let cell =  cellArray.object(at: 0) as! HeaderCelll
        if textView == cell.eventDescTextView
       {
        print("eventDescTextView Enter in textViewDidEndEditing")
        let cells:SmsQuestionCell =  self.cellArray.object(at: 4) as! SmsQuestionCell
        if textView.text.count>2000
        {
            allSMSFlag="0"
            displayOnBannerFlag="0"
//            cells.allMemSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
            cells.whatsappRadioBtn.isOn = false
        }
        else
        {
            
        }
        
       }
        
        if(textView == addQueTextView){
            if(addQueTextView.text == "Tap to add Question")
            {
                addQueTextView.textColor = UIColor.lightGray
            }
            else
            {
                addQueTextView.textColor = UIColor.black
                // addQueTextView.text = "Tap to add Question"
            }
            
            
            var varGetText=addQueTextView.text
            
            
            
            if(varGetText!=="" || (varGetText?.characters.count)!<=0)
            {
                addQueTextView.text="Tap to add Question"
                addQueTextView.textColor=UIColor.lightGray
            }
            else
            {
                
            }
            
            
        }
        
    }
    
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool
    {
        let cell =  cellArray.object(at: 0) as! HeaderCelll
        if textView==cell.eventDescTextView
        {
            print("eventDescTextView Enter in textViewShouldReturn")
        }

        if (addQueTextView.text?.characters.count == 0)
        {
            addQueTextView.textColor = UIColor.black
            addQueTextView.text = "Tap to add Question"
        }
        else
        {
            
        }
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 ,width: self.bounds.size.width, height: self.bounds.size.height)
                
                
                
        }, completion: { finished in
            
        })
        
        textView.resignFirstResponder()
        return true
    }
    
    var currentLine: Int = 1
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
        let cell =  cellArray.object(at: 0) as! HeaderCelll
        
        
        if(textView==cell.eventDescTextView)
        {
          print("eventDescTextView Enter in shouldChangeTextIn")
            
            // Add "1" when the user starts typing into the text field
            cell.lblDescCount.text=String(textView.text.count)
            var varGetText=addQueTextView.text
            if(varGetText!=="" || (varGetText?.characters.count)!<=0)
            {
                addQueTextView.text="Tap to add Question"
                addQueTextView.textColor=UIColor.lightGray
            }
            else
            {
                
            }
            
            
            return true
        }
        else if (textView == cell.eventVenueTextView)
        {
            
            // Add "1" when the user starts typing into the text field
            if  (textView.text.isEmpty && !text.isEmpty) {
                //textView.text = "\(currentLine). "
                cell.eventVenueTextView.text = textView.text
                currentLine += 1
            }
            else {
                if text.isEmpty {
                    if textView.text.characters.count >= 4 {
                        //let str = textView.text.substring(from:textView.text.index(textView.text.endIndex, offsetBy: -4))
                        
                        let str = textView.text.substring(from: textView.text.endIndex)
                        if str.hasPrefix("\n") {
                            textView.text = String(textView.text.characters.dropLast(3))
                            cell.eventVenueTextView.text = textView.text
                            currentLine -= 1
                        }
                    }
                    else if text.isEmpty && textView.text.characters.count == 3 {
                        textView.text = String(textView.text.characters.dropLast(3))
                        cell.eventVenueTextView.text = textView.text
                        currentLine = 1
                    }
                }
                else {
                    // let str = textView.text.substring(from:textView.text.index(textView.text.endIndex, offsetBy: -1))
                    let str = textView.text.substring(from: textView.text.endIndex)
                    if str == "\n" {
                        textView.text = "\(textView.text!)\(currentLine). "
                        
                        cell.eventVenueTextView.text = textView.text
                        currentLine += 1
                    }
                }
            }
            
            var varGetText=addQueTextView.text
            
            
            
            if(varGetText!=="" || (varGetText?.characters.count)!<=0)
            {
                addQueTextView.text="Tap to add Question"
                addQueTextView.textColor=UIColor.lightGray
            }
            else
            {
                
            }
            return true
        }
        
        
        if(addQueTextView.text == "Tap to add Question")
        {
            //addQueTextView.text = ""
            addQueTextView.textColor = UIColor.lightGray
        }
        else
        {
            //addQueTextView.text == "Tap to add Question"
            addQueTextView.textColor = UIColor.black
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
       
         let cell =  cellArray.object(at: 0) as! HeaderCelll
        if textView==cell.eventDescTextView
        {
            print("eventDescTextView Enter in shouldChangeTextIn")
            cell.lblDescCount.text=String(textView.text.count)
        let cells:SmsQuestionCell =  cellArray.object(at: 4) as! SmsQuestionCell
        if textView.text.count>2000
        {
            allSMSFlag="0"
//            displayOnBannerFlag="0"
//            cells.allMemSMSButton.setImage(UIImage(named: "switchOff"), for: UIControl.State.normal)
            cells.whatsappRadioBtn.isOn = false
        }
        else
        {
            
        }
    }
    }
    
    /*-----------------code by dpk -------------------*/
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraCaptureMode = .photo
            present(imagePicker, animated: true, completion: nil)
        }else{
            /*
             let alert = UIAlertController(title: "Camera Not Found", message: "Camera Not Found, this device has no Camera", preferredStyle: .Alert)
             let ok = UIAlertAction(title: "OK", style:.Default, handler: nil)
             alert.addAction(ok)
             presentViewController(alert, animated: true, completion: nil)*/
            
            self.view.makeToast("Camera Not Found, this device has no Camera", duration: 2, position: CSToastPositionCenter)
            
            
            
        }
    }
    /*-----------------code by dpk -------------------*/
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        resignFirstResponder()
    }
    
    //    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    //    {
    //
    //
    //
    //        self.view.endEditing(true)
    //        self.addEventTableView.endEditing(true)
    //
    //        let cell =  cellArray.objectAtIndex(0) as! HeaderCelll
    //                cell.eventDescTextView.resignFirstResponder()
    //                   cell.eventVenueTextView.resignFirstResponder()
    //
    ////        if let touch = touches.first
    ////        {
    ////            let cell =  cellArray.objectAtIndex(0) as! HeaderCelll
    ////            cell.eventDescTextView.resignFirstResponder()
    ////            cell.eventVenueTextView.resignFirstResponder()
    ////        }
    ////        super.touchesBegan(touches, withEvent:event)
    ////
    //
    //    }
    //
}



