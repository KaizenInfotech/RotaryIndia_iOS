//
//  AddAnnounceController.swift
//  TouchBase
//
//  Created by Kaizan on 22/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//
//
//import UIKit
//
//class AddAnnounceController:
//
//AddAnnounceScrennNewViewController

//
//  AddAnnounceScrennNewViewController.swift
//  AnnounceScreenDemo
//
//  Created by kaizen on 14/03/2017.
//  Copyright © 2017 kaizen. All rights reserved.
//

import UIKit
import Alamofire
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


class AddAnnounceController: UIViewController , UIScrollViewDelegate , UITableViewDelegate , UITableViewDataSource  , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIActionSheetDelegate , UIPopoverControllerDelegate , UITextFieldDelegate , webServiceDelegate , UITextViewDelegate ,UIGestureRecognizerDelegate {
    
    var objprotocolForAnnouncementListingCallingApi:protocolForAnnouncementListingCallingApi!=nil
    
    
    
    var varCustomViewReloadOrNot:String! = ""
    
    var appDelegate : AppDelegate = AppDelegate()
    //Block-1
    @IBOutlet weak var buttonAllAnnounce: UIButton!
    @IBOutlet weak var buttonSubGroupAnnounce: UIButton!
    @IBOutlet weak var buttonMembersAnnounce: UIButton!
    @IBOutlet weak var labelYouHaveAddedGroupsAndMember: UILabel!
    @IBOutlet weak var buttonEditAllGroupMember: UIButton!
    //Block-2
    @IBOutlet weak var imageAnnouncement: UIImageView!
    //Block-3
    @IBOutlet weak var textfieldTitle: UITextField!
    //Block-4
    @IBOutlet weak var textViewDescription: UITextView!
    //Block-5
    @IBOutlet weak var labelBalanceSmsCount: UILabel!
    @IBOutlet weak var buttonAllMemberCheckUncheck: UIButton!
    @IBOutlet weak var buttonNonSmartPhoneUsersCheckUncheck: UIButton!
    //Block-6
    @IBOutlet weak var buttonSelectPublishDate: UIButton!
    @IBOutlet weak var buttonSelectPublishTime: UIButton!
    //Block-7
    @IBOutlet weak var buttonSelectExpireDate: UIButton!
    @IBOutlet weak var buttonSelectExpireTime: UIButton!
    //Block-8
    @IBOutlet weak var lblNoSMSUser: UILabel!
    @IBOutlet weak var lblDescCount: UILabel!
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var buttonYesInViewPopUp: UIButton!
    @IBOutlet weak var buttonNoInViewPopUp: UIButton!
    var isSubGrpAdmin : String = "0"
    var checkRemainder:Int!=0
    //Block-9
    @IBOutlet weak var labelRepeatDateAndTime: UILabel!
    @IBOutlet weak var buttonAddDateAndTimeMore: UIButton!
    @IBOutlet weak var buttonSwitchOnOff: UISwitch!
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonOpticity: UIButton!
    
    @IBOutlet weak var tableForAddRepeatDateAndTimeInAnnounce: UITableView!
    
    @IBOutlet weak var lblHeadingNonSmartUser: UILabel!
    @IBOutlet weak var lblHeadingAllMember: UILabel!
    @IBOutlet weak var lblHeadingSendSmsTo: UILabel!
    @IBOutlet weak var lblHeadingRecipientType: UILabel!
    @IBOutlet weak var lblHeadingImage: UILabel!
    
    @IBOutlet weak var lblHeadingReminder: UILabel!
    @IBOutlet weak var lblHeadingExpireDate: UILabel!
    @IBOutlet weak var lblHeadingPublishDate: UILabel!
    @IBOutlet weak var lblHeadingDescription: UILabel!
    @IBOutlet weak var lblHeadingTitle: UILabel!
    //Array Declration
    @IBOutlet weak var labelPlaceHolder: UILabel!
    var muarrayForIncreseDateTimeCell:NSMutableArray = NSMutableArray()
    var muarrayForAddSelectedDateAndTimeInCell:NSMutableArray = NSMutableArray()
    var muarrayForAddSelectedOnlyTimeInCell:NSMutableArray = NSMutableArray()
    var muarrayForPDTEDT :NSMutableArray = NSMutableArray()
    //Local Declration
    var announceIDForEdited :String = ""
    var AnnouncementRepeatDates:String=""
    var SwitchOnOff:String = ""
    var AllMemberCheckUnCheck :String = ""
    var AllNonSmartPhoneCheckUncheck:String = ""
    var customView:SimpleCustomView!
    var varGetPublishSelectDate:String!="0"
    var varGetPublishSelectTime:String!="0"
    var varGetExpireSelectDate:String!="0"
    var varGetExpireSelectTime:String!="0"
    var varWhichClicked:String!="0"
    var varGetPSD:String!=""
    var varGetPST:String!=""
    var varGetESD:String!=""
    var varGetEST:String!=""
    var currentdateForPSDMatch :String = ""
    var varGetCellDateSelected:String!=""
    var varGetCellTimeSelected:String!=""
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    //Click on Sub Group and use
    var val:String = ""
    var isCategory:String=""
    var allSMSFlag:NSString!
    var nonSmartSMSFlag:NSString!
    var groupIdsArray:NSMutableArray!
    var varSubGrouporMember:Int!=0
    var TypeIDEdit:String = ""
    var groupID :String = ""
    var groupProfileID :String = ""
    var count = Int()
    var countGroups = Int()
    var SMSCountStr : String!
    var commonIDString : String = ""
    var cellArray : NSMutableArray!
    var ImsgId:String = ""
    var annTypeStr:NSString!
    var isCalledFRom:NSString!
    var announcUpdate:String = ""
    var moduleId:NSString!
    var annDetail:AnnounceList!
    var origenalHeightOfScrollView :CGFloat = 0.0
    var textFieldForSelectDateAndTimeTag = UITextField()
    var indexPath : Int = Int()
    var imageUploadOrNot:String = ""
    var DateFormatIsCorrect:String = ""
    var picker:UIImagePickerController?=UIImagePickerController()
    var popover:UIPopoverController?=nil
    var isFromAddUpdateAnnButton:Bool=false
    
    var selectRecipientTypeEditMode:String = ""
    
    var uilabel :UILabel = UILabel()
    //MARK:- ViewDidLoad Method
    
    //    func addDoneButtonOnKeyboard()
    //    {
    //        var doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0,width:self.view.frame.size.width, height:50))
    //        doneToolbar.barStyle = UIBarStyle.default
    //
    //        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    //        var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: Selector("doneButtonAction"))
    //
    //        var items = NSMutableArray()
    //        items.add(flexSpace)
    //        items.add(done)
    //
    //        doneToolbar.items = items as! [UIBarButtonItem]
    //        doneToolbar.sizeToFit()
    //
    //        self.textViewDescription.inputAccessoryView = doneToolbar
    //        self.textfieldTitle.inputAccessoryView = doneToolbar
    //
    //    }
    
    //    func doneButtonAction()
    //    {
    //        self.textViewDescription.resignFirstResponder()
    //        self.textfieldTitle.resignFirstResponder()
    //    }
    
    @IBOutlet weak var textfieldLink: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkRemainder = 0
        lblHeadingSendSmsTo.isHidden=true
        textfieldLink.placeholder="Enter Link"
        print(SMSCountStr)
        // self.addDoneButtonOnKeyboard()
        getClubDetails()
        //        labelBalanceSmsCount.text="Balance Whatsapp : "+SMSCountStr
        varCustomViewReloadOrNot = "Not"
        viewPopUp.isHidden = true
        self.createNavigationBar()
        buttonEditAllGroupMember.isHidden = true
        functionForButtonLabelTextFieldScrollViewTableSetting()
        //Block-6,7 Notification For Select Date And Time Load Xib file------------------------------------
        NotificationCenter.default.addObserver(self, selector: #selector(AddAnnounceController.NotificationIdentifierForGettingValueForPickerCloseWithpoutValueSelect(_:)), name:NSNotification.Name(rawValue: "NotificationIdentifierForGettingValueForPickerCloseWithpoutValueSelect"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddAnnounceController.NotificationIdentifierForGettingValue(_:)), name:NSNotification.Name(rawValue: "NotificationIdentifierForGettingValue"), object: nil)
    }
    
    func functionForButtonLabelTextFieldScrollViewTableSetting()
    {
        
        // 102, 102, 102
        
        lblHeadingRecipientType.textColor =     UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        lblHeadingImage.textColor =             UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        lblHeadingTitle.textColor =             UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        lblHeadingDescription.textColor =       UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        lblHeadingPublishDate.textColor =       UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        lblHeadingExpireDate.textColor =        UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        lblHeadingReminder.textColor =          UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        lblHeadingSendSmsTo.textColor =         UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        labelRepeatDateAndTime.textColor =      UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        labelBalanceSmsCount.textColor =        UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        lblHeadingAllMember.textColor =         UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        lblHeadingNonSmartUser.textColor =      UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        textfieldLink.functionTextFieldFullBorder()
        textfieldLink.attributedPlaceholder = NSAttributedString(string:"Enter Link",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        
        //MARK:- Picker setting
        picker!.delegate = self
        //MARK:-Textfield setting
        textfieldTitle.delegate = self
        textViewDescription.delegate = self
        textfieldTitle.functionTextFieldFullBorder()
        textViewDescription.functionTextViewFullBorder()
        //MARK:-Label Setting
        labelRepeatDateAndTime.isHidden = true
        //labelYouHaveAddedGroupsAndMember.text = ""
        /*----------------textViewDescription placeholder setting------------------------------------------*/
        textViewDescription.delegate = self
        textViewDescription.text = nil
        labelPlaceHolder.text = "Enter Description"
        labelPlaceHolder.textColor = UIColor.lightGray
        textViewDescription.addSubview(labelPlaceHolder)
        labelPlaceHolder.frame.origin = CGPoint(x: 5, y: textViewDescription.font!.pointSize / 2)
        labelPlaceHolder.textColor = UIColor(white: 0, alpha: 0.3)
        textfieldTitle.attributedPlaceholder = NSAttributedString(string:"Enter Title",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        
        //MARK:-button Setting
        //buttonEditAllGroupMember.hidden = true
        buttonOpticity.isHidden = true
        buttonAddDateAndTimeMore.isHidden = true
        /*---------------button Border setting-------------------------------------------------------------*/
        buttonSelectPublishDate.setButtonFullBorder()
        buttonSelectPublishTime.setButtonFullBorder()
        buttonSelectExpireDate.setButtonFullBorder()
        buttonSelectExpireTime.setButtonFullBorder()
        /*----------------button Border setting------------------------------------------------------------*/
        //MARK:- Switch Button setting
        SwitchOnOff = "ON"
        AllMemberCheckUnCheck = "Unchecked"
        AllNonSmartPhoneCheckUncheck = "AllNonSmartUserUnCheck"
        //MARK:-Image Setting
        ImsgId = ""
        imageUploadOrNot = "Not"
        imageAnnouncement.isUserInteractionEnabled = true
        let tapRecognizerfirst = UITapGestureRecognizer(target: self, action: #selector(imageTappedfirst(_:)))
        imageAnnouncement.addGestureRecognizer(tapRecognizerfirst)
        //view seting
        //scrollview setting
        myScrollView.delegate = self
        myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1040)
        origenalHeightOfScrollView = myScrollView.frame.size.height
        print("Scroll view Defoul Size------------", origenalHeightOfScrollView)
        //table setting
        tableForAddRepeatDateAndTimeInAnnounce.isHidden = true
        //navigation setting
        //MARK:- Date Setting
        /*----------------Date&Time setting------------------------------------------------------------*/
        
        //MARK:- Array Memory Allocation
        muarrayForIncreseDateTimeCell = NSMutableArray()
        //MARK:- initial null set variable value
        nonSmartSMSFlag = ""
        allSMSFlag = ""
        
        //MARK:- EDIT OR ADD MODE CHANGE
        /*----------------Change Button Title Run time For Edit and Add Mode------------------------------*/
        if(isCalledFRom == "list")
        {
            buttonAdd.setTitle("Update",  for: UIControl.State.normal)
            functionForGetAnnounceDetails()
            buttonEditAllGroupMember.isHidden = false
            //            buttonAllAnnounce.userInteractionEnabled = false
            //            buttonSubGroupAnnounce.userInteractionEnabled = false
            //            buttonMembersAnnounce.userInteractionEnabled = false
        }
        else
        {
            buttonAdd.setTitle("Add",  for: UIControl.State.normal)
            commonIDString=""
            // buttonEditAllGroupMember.hidden = true
        }
        
    }
    
    //MARK:- Placehoder in textview
    /*------------------------------placeholder --------------------------------------End----------------*/
    
    func textViewDidChange(_ textView: UITextView) {
        labelPlaceHolder.isHidden = !textView.text.isEmpty
        
        if textView==self.textViewDescription
        {
            self.lblDescCount.text=String(textView.text.count)
            if textView.text.count>2000
            {
                buttonAllMemberCheckUncheck.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                AllMemberCheckUnCheck = "Unchecked"
                val = "0"
                if(val == "0")
                {
                    allSMSFlag="0"
                }
            }
        }
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil)
    {
        textViewDescription.resignFirstResponder()
        textfieldTitle.resignFirstResponder()
        // handling code
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(textView==textViewDescription)
        {
            if text == "\n"  // Recognizes enter key in keyboard
            {
                textViewDescription.text! = textViewDescription.text! + "\n"
                // textViewDescription.resignFirstResponder()
                return false
            }
            return true
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == self.textViewDescription
        {
            if textView.text.count>2000
            {
                buttonAllMemberCheckUncheck.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                AllMemberCheckUnCheck = "Unchecked"
                val = "0"
                if(val == "0")
                {
                    allSMSFlag="0"
                }
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.textViewDescription
        {
            if textView.text.count>2000
            {
                buttonAllMemberCheckUncheck.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                AllMemberCheckUnCheck = "Unchecked"
                val = "0"
                if(val == "0")
                {
                    allSMSFlag="0"
                }
            }
        }
    }
    /*------------------------------placeholder--------------------------------------End----------------*/
    override func viewWillAppear(_ animated: Bool)
    {
        //radio_btn_Check
        //radio_btn_Uncheck
        
        let date = Foundation.Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let currentdate = formatter.string(from: date)
        varGetCellDateSelected = currentdate //+":00"+" +0000"
        currentdateForPSDMatch = varGetCellDateSelected
        print(varGetCellDateSelected)
        
        //labelYouHaveAddedGroupsAndMember.hidden = true
        buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        varSubGrouporMember=0
    }
    
    /*-------------------------------Navigation bar Setting --------------------------------Start----------------*/
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title="Announcement"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AddAnnounceController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func backClicked()
    {
        
        if(varCustomViewReloadOrNot == "Not")
        {
        }
        else
        {
            self.customView.removeFromSuperview()
        }
//        viewPopUp.isHidden = false
        let alertController = UIAlertController(title: "", message:
            "Your changes are not saved, are you sure you want to go back?", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default,handler:  {(alert :UIAlertAction!) in
//            self.addQueTextView.text = "Tap to add Question"
            self.navigationController?.popViewController(animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
//        buttonOpticity.isHidden = false
        //self.navigationController?.popxcvViewCxcvontrollerAnimated(true)
    }
    
    
    
    
    @IBAction func buttonYesInViewPopClickEvent(_ sender: AnyObject)
    {
        // NSUserDefaults.standardUserDefaults().setObject("", forKey: "profID")
        // NSUserDefaults.standardUserDefaults().setObject("", forKey: "groupsID")
        self.viewPopUp.isHidden = true
        self.buttonOpticity.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonNoInViewPopUpClickEvent(_ sender: AnyObject)
    {
        self.viewPopUp.isHidden = true
        self.buttonOpticity.isHidden = true
    }
    
    /*-------------------------------Navigation bar Setting ----------------------------------End--------------*/
    
    
    /*-------------------------------Image Picker Open On Image Tap & selection Process Setting ----------------Start----------------*/
    
    @objc func imageTappedfirst(_ gestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImageView = gestureRecognizer.view!
        //        let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo","Remove Photo")
        //        actionSheet.delegate = self
        //        actionSheet.tag = 1
        //        actionSheet.showInView(self.view)
        
        
        if isCalledFRom == "add"
        {
            let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library","Take a photo")
            actionSheet.tag = 0
            actionSheet.delegate = self
            actionSheet.show(in: self.view)
        }
        else
        {
            let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo","Remove Photo")
            actionSheet.delegate = self
            actionSheet.tag = 1
            actionSheet.show(in: self.view)
        }
        
        
    }
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int)
    {
        print("\(buttonIndex)")
        switch (buttonIndex){
        case 0:
            print("Cancel")
            self.dismiss(animated: true, completion: nil)
        case 1:
            //shows the photo library
            self.picker!.allowsEditing = false  //------------------DPK
            self.picker!.sourceType = .photoLibrary
            //if #available(iOS 8.0, *) {
            self.picker!.modalPresentationStyle = .popover
            self.present(self.picker!, animated: true, completion: nil)
        case 2:
            openCamera()
        default:
            
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            wsm.DeletePhotoEdit(TypeIDEdit as String, grpID: groupID, type: "Announcement",moduleId: "")
            print("Default")
        }
    }
    
    
    
    //MARK:- Delete Photo Delegate
    func DeletePhotoDelegateFunction(_ dltPhoto : DeleteResult)
    {
        if(dltPhoto.status == "0")
        {
            imageAnnouncement.image = UIImage(named: "addevent.png")
        }
        else
        {
            print("Not Delete")
        }
    }
    
    
    /*-------------------Open Camera--------------------code by dpk -----------------------------------------*/
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerController.SourceType.camera
            picker!.cameraCaptureMode = .photo
            present(picker!, animated: true, completion: nil)
        }else{
            
            /*
             let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .Alert)
             let ok = UIAlertAction(title: "OK", style:.Default, handler: nil)
             alert.addAction(ok)
             presentViewController(alert, animated: true, completion: nil)
             */
            self.view.makeToast("Camera Not Found, this device has no Camera", duration: 2, position: CSToastPositionCenter)
        }
    }
    /*--------------------Open Camera------------------code by dpk -----------------------------------------*/
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- Button Action
    /*-----------------------------------------------------------Button Actions-------------------------------------Start---------------------------*/
    @IBAction func buttonAllAnnounceClickEvent(_ sender: AnyObject)
    {
        UserDefaults.standard.set("", forKey: "profID")
        print("Nothing here")
        UserDefaults.standard.set("", forKey: "groupsID")
        labelYouHaveAddedGroupsAndMember.isHidden = true
        //editButton.hidden = true
        UserDefaults.standard.set("", forKey: "profID")
        print("Nothing here")
        UserDefaults.standard.set("", forKey: "groupsID")
        print("Nothing here")
        commonIDString=""
        labelYouHaveAddedGroupsAndMember.text=""
        buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        buttonEditAllGroupMember.isHidden = true
        varSubGrouporMember=0
    }
    
    func functionForButtonSubGroupClickEvent()
    {
        buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        print("Groups")
        UserDefaults.standard.set("", forKey: "profID")
        let SubGroupController = self.storyboard?.instantiateViewController(withIdentifier: "sub_group1") as! SubGroupListController
        SubGroupController.groupIDX = groupID
        SubGroupController.isCalledFrom="add"
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
        self.navigationController?.pushViewController(SubGroupController, animated: true)
        
    }
    @IBAction func buttonSubGroupAnnounceClickEvent(_ sender: AnyObject)
    {
        functionForButtonSubGroupClickEvent()
    }
    func functionForButtonMemberClickEvent()
    {//addAnnounce
        buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        print("membersANN")
        UserDefaults.standard.set("", forKey: "groupsID")
        let MembersController = self.storyboard?.instantiateViewController(withIdentifier: "edit_directory") as! EditDirectoryController
        MembersController.groupIDX = groupID
        print(isCalledFRom)
        MembersController.groupProfileID=self.groupProfileID
        
        if(varSubGrouporMember==0 || varSubGrouporMember==2)
        {
            if(commonIDString == "")
            {
                MembersController.profileIdsArray=NSMutableArray()
                MembersController.isCalledFRom="addAnnounce"
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
            MembersController.isCalledFRom="addAnnounce"
        }
        self.navigationController?.pushViewController(MembersController, animated: true)
    }
    
    @IBAction func buttonMembersAnnounceClickEvent(_ sender: AnyObject)
    {
        functionForButtonMemberClickEvent()
    }
    
    @IBAction func buttonAllMemberClickEvent(_ sender: AnyObject)
    {
        functionForButtonAllMemberSelectOrNot()
    }
    
    @IBAction func buttonNonSmartPhoneUsersClickEvent(_ sender: AnyObject)
    {
        functionForAllNonSmartPhoneUserSlectOrNot()
    }
    
    @IBAction func buttonOpticityClickEvent(_ sender: AnyObject)
    {
        // self.customView.removeFromSuperview()
        //  buttonOpticity.hidden = true
    }
    
    func textFieldSelectPublishDateAndTime()
    {
        varCustomViewReloadOrNot = "Yes"
        textfieldTitle.resignFirstResponder()
        textViewDescription.resignFirstResponder()
        buttonOpticity.isHidden = false
        self.customView =  SimpleCustomView(frame: CGRect(x: 0,y: 0, width: 320, height: 568))
        customView.center = view.center;
        self.view.addSubview(self.customView!)
        self.customView.lblTitleText = "DateAndTime";
        varWhichClicked="PSD"
    }
    
    func textFieldSelectExpiryDateAndTime()
    {
        varCustomViewReloadOrNot = "Yes"
        textfieldTitle.resignFirstResponder()
        textViewDescription.resignFirstResponder()
        buttonOpticity.isHidden = false
        self.customView =  SimpleCustomView(frame: CGRect(x: 0,y: 0, width: 320, height: 568))
        customView.center = view.center;
        self.view.addSubview(self.customView!)
        self.view.bringSubviewToFront(self.customView)
        self.customView.lblTitleText = "DateAndTime";
        varWhichClicked="ESD"
    }
    
    @IBAction func buttonSelectPublishDateClickEvent(_ sender: AnyObject) {
        varCustomViewReloadOrNot = "Yes"
        //self.view.alpha=1
        textfieldTitle.resignFirstResponder()
        textViewDescription.resignFirstResponder()
        textFieldSelectPublishDateAndTime()
        //        buttonOpticity.hidden = false
        //        self.customView =  SimpleCustomView(frame: CGRectMake(0,0, 320, 568))
        //        customView.center = view.center;
        //        self.view.addSubview(self.customView!)
        //        self.customView.lblTitleText = "DateAndTime";
        //        varWhichClicked="PSD"
    }
    
    @IBAction func buttonSelectPublishTimeClickEvent(_ sender: AnyObject) {
        //self.view.alpha=1
        varCustomViewReloadOrNot = "Yes"
        textfieldTitle.resignFirstResponder()
        textViewDescription.resignFirstResponder()
        buttonOpticity.isHidden = false
        self.customView =  SimpleCustomView(frame: CGRect(x: 0,y: 0, width: 320, height: 568))
        customView.center = view.center;
        self.view.addSubview(self.customView!);
        self.customView.lblTitleText = "Time";
        varWhichClicked="PST"
    }
    
    @IBAction func buttonSelectExpireDateClickEvent(_ sender: AnyObject) {
        varCustomViewReloadOrNot = "Yes"
        textfieldTitle.resignFirstResponder()
        textViewDescription.resignFirstResponder()
        if(buttonSelectPublishDate.titleLabel?.text! == "  Select Date and Time  ")
        {
            
            let alert = UIAlertController(title: "Announcement", message: "Please enter publish date first. ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
            self.present(alert, animated: true, completion: nil)
            
            //  self.view.makeToast("Please enter publish date first", duration: 2, position: CSToastPositionCenter)
            
        }
        else if(buttonSelectPublishDate.titleLabel?.text! != "  Select Date and Time  " && buttonSelectPublishDate.titleLabel?.text! != "")
        {
            textFieldSelectExpiryDateAndTime()
        }
        
        //self.view.alpha=1
        //        buttonOpticity.hidden = false
        //        self.customView =  SimpleCustomView(frame: CGRectMake(0,0, 320, 568))
        //        customView.center = view.center;
        //        self.view.addSubview(self.customView!)
        //        self.view.bringSubviewToFront(self.customView)
        //        self.customView.lblTitleText = "DateAndTime";
        //        varWhichClicked="ESD"
    }
    
    @IBAction func buttonSelectExpireTimeClickEvent(_ sender: AnyObject) {
        //self.view.alpha=1
        varCustomViewReloadOrNot = "Yes"
        textfieldTitle.resignFirstResponder()
        textViewDescription.resignFirstResponder()
        buttonOpticity.isHidden = false
        self.customView =  SimpleCustomView(frame: CGRect(x: 0,y: 0, width: 320, height: 568))
        customView.center = view.center;
        self.view.addSubview(self.customView!);
        self.customView.lblTitleText = "Time";
        varWhichClicked="EST"
    }
    @IBAction func buttonAddClickEvent(_ sender: AnyObject)
    {
        //        buttonAdd.isEnabled=false
        
        if buttonAllAnnounce.currentImage!.isEqual(UIImage(named: "radio_btn_Check"))
        {
            annTypeStr = "0"
            print("ALL Announcement")
            commonIDString=""
        }
        else if buttonSubGroupAnnounce.currentImage!.isEqual(UIImage(named: "radio_btn_Check"))
        {
            annTypeStr = "1"
            print("comittee Announcemnt")
        }
        else if buttonMembersAnnounce.currentImage!.isEqual(UIImage(named: "radio_btn_Check"))
        {
            annTypeStr = "2"
            print("members Announcement")
        }
        if(textfieldTitle.text! == "")
        {
            self.view.makeToast("Please enter the Title", duration: 2, position: CSToastPositionCenter)
            buttonAdd.isEnabled=true
        }
        else if(textViewDescription.text! == "")
        {
            self.view.makeToast("Please enter the Description", duration: 2, position: CSToastPositionCenter)
            buttonAdd.isEnabled=true
        }
        else if(buttonSelectPublishDate.titleLabel?.text == "  Select Date and Time  ")
        {
            self.view.makeToast("Please enter a Publish Date & Time", duration: 2, position: CSToastPositionCenter)
            buttonAdd.isEnabled=true
        }
        else if(buttonSelectExpireDate.titleLabel?.text == "  Select Date and Time  ")
        {
            self.view.makeToast("Please enter an Expiry Date & Time", duration: 2, position: CSToastPositionCenter)
            buttonAdd.isEnabled=true
        }
        
        if((textfieldTitle.text! != "")&&(textViewDescription.text! != "")&&(buttonSelectPublishDate.titleLabel?.text != "  Select Date and Time  ")&&(buttonSelectExpireDate.titleLabel?.text != "  Select Date and Time  "))
        {
            appDelegate = UIApplication.shared.delegate as! AppDelegate
            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
            {
                // isFromAddUpdateAnnButton=true
                if AllMemberCheckUnCheck == "Checked" && isCategory=="1"
                {
                    //getAnnounceSMSCountdetails()
                    AddUpdateAnnouncement()
                }
                else
                {
                    isFromAddUpdateAnnButton=false
                    AddUpdateAnnouncement()
                }
            }
            else
            {
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
                buttonAdd.isEnabled=true
            }
        }
        else
        {
            print("Check Your Validation")
        }
        //}
    }
    
    func AddUpdateAnnouncement()
    {
        if(isCalledFRom=="list")
        {
            functionForRepeatedDateAndTimeBindInStringArray()
            // functionForFetchingDataUpdateAnnounce()
            
            if(checkRemainder == 1){
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Announcement", message: "Please set the date and time for the reminder.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                functionForUpdateUSerAnnounceDetails()
                
            }
        }
        else
        {
            functionForRepeatedDateAndTimeBindInStringArray()
            // functionForFetchingDataAddAnnounce()
            if(checkRemainder == 1){
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Announcement", message: "Please set the date and time for the reminder.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                functionForSaveUSerProfileData()
            }
        }
    }
    
    //#MARK:- Send SMS Validation
    
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
    
    func getAnnounceSMSCountdetails()
    {
        let descCount:String=String(self.textViewDescription.text.count)
        
        let url:String=baseUrl+row_Getsmscountdetails;
        let parameters : [String : Any] = ["p_RecipientType":self.annTypeStr!,"p_InputIDs":self.commonIDString as NSString as NSString,"P_fk_Group_masterid":self.groupID as! NSString,"p_DescriptionCount":descCount,"p_Remindercount":self.getRemiderCount(),"p_TransType":"A","p_PublishDateFlag":self.getPublishDateFlag()]
        
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
        print("Announcement Sms Count List :: \(TBsmscountResult)")
        
        let smsResult = (TBsmscountResult.value(forKey: "TBsmscountResult") as AnyObject).value(forKey: "smsResult") as! String
        let smsperuser = (TBsmscountResult.value(forKey: "TBsmscountResult") as AnyObject).value(forKey: "smsperuser") as! NSNumber
        
        if smsperuser != nil
        {
            self.lblNoSMSUser.text="No of message per user : \(smsperuser)"
        }
        else{
            self.lblNoSMSUser.text=""
        }
        
        if smsResult.count>0
        {
            let alert1 = UIAlertController(title: "Rotary India", message: smsResult, preferredStyle: UIAlertController.Style.alert)
            alert1.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                
                self.buttonAllMemberCheckUncheck.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                self.AllMemberCheckUnCheck = "Unchecked"
                self.val = "0"
                
                if(self.val == "0")
                {
                    self.allSMSFlag="0"
                }
                else
                {
                    self.allSMSFlag="1"
                    self.nonSmartSMSFlag="0"
                }
            }));
            self.present(alert1, animated: true, completion: nil)
        }
        else
        {
            if isFromAddUpdateAnnButton
            {
                isFromAddUpdateAnnButton=false
                AddUpdateAnnouncement()
            }
        }
    }
    
    
    func getPublishDateFlag() -> String
    {
        
        var myDate = buttonSelectPublishDate.titleLabel?.text!
        if myDate=="  Select Date and Time  "
        {
            myDate = buttonSelectPublishDate.title( for: UIControl.State.normal)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let date = dateFormatter.date(from: myDate!)!
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStringPublish = dateFormatter.string(from: date)
        print("dateStringPublish:: \(dateStringPublish)")
        
        if dateStringPublish != nil && dateStringPublish != ""
        {
            if isDateIsNextToCurrentDate(dateInString: dateStringPublish)
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
    
    func getRemiderCount() -> String
    {
        var allrepeatDateTime : NSMutableArray = NSMutableArray()
        var repeatCount:Int=0
        for i in 00..<muarrayForIncreseDateTimeCell.count
        {
            let letGetValue=muarrayForIncreseDateTimeCell.object(at: i)as AnyObject
            // let letGetValueOfTime = muarrayForAddSelectedOnlyTimeInCell.objectAtIndex(i) as! AnyObject
            print(letGetValue)
            
            if(letGetValue as! String=="  Select Date and Time  ")
            {
                
            }
            else
            {
                let myDate = letGetValue
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
                let date = dateFormatter.date(from: myDate as! String)!
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateStringPublish = dateFormatter.string(from: date)
                print(dateStringPublish)
                print(letGetValue)
                // print(letGetValueOfTime)
                if(dateStringPublish == "0")
                {
                    print(dateStringPublish)
                    //  print(letGetValueOfTime)
                }
                else
                {
                    allrepeatDateTime.add(dateStringPublish)
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
    
    @IBAction func buttonCancelClickEvent(_ sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func buttonSwitchClickEvent(_ sender: AnyObject) {
        
        if buttonSwitchOnOff.isOn
        {
            print("Switch On")
            labelRepeatDateAndTime.isHidden = false
            buttonAddDateAndTimeMore.isHidden = false
            checkRemainder = 1
        }
        else
        {
            checkRemainder = 0
            print("Switch Off")
            labelRepeatDateAndTime.isHidden = true
            buttonAddDateAndTimeMore.isHidden = true
            muarrayForIncreseDateTimeCell.removeAllObjects()
            let oldFrame = self.tableForAddRepeatDateAndTimeInAnnounce.frame
            self.tableForAddRepeatDateAndTimeInAnnounce.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y, width: oldFrame.size.width, height: 50.0)
            tableForAddRepeatDateAndTimeInAnnounce.isHidden = true
            myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1040)
            // myScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, 1600)
            
            //let bottomOffset = CGPoint(x: 0, y: origenalHeightOfScrollView)
            //print(bottomOffset)
            // myScrollView.setContentOffset(bottomOffset, animated: true)
            print(origenalHeightOfScrollView)
            //tableForAddRepeatDateAndTimeInAnnounce.reloadData()
        }
    }
    
    @IBAction func buttonEditAllGroupMemberClickEvent(_ sender: AnyObject)
    {
        
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
    }
    @IBAction func buttonAddDateTimeMoreClickEvent(_ sender: AnyObject)
    {
        
        textfieldTitle.resignFirstResponder()
        textViewDescription.resignFirstResponder()
        tableForAddRepeatDateAndTimeInAnnounce.isHidden = false
        muarrayForIncreseDateTimeCell.add("  Select Date and Time  ")
        //muarrayForAddSelectedOnlyTimeInCell.addObject("Select Time")
        // muarrayForAddSelectedDateAndTimeInCell.addObject("  Select Date  ")
        
        print("Cell Count---------------->",muarrayForIncreseDateTimeCell.count)
        // print("Date Count-------------------->",muarrayForAddSelectedDateAndTimeInCell.count)
        // print("Time Count---------------------->",muarrayForAddSelectedOnlyTimeInCell.count)
        
        let oldFrame = self.tableForAddRepeatDateAndTimeInAnnounce.frame
        let newHeight = self.tableForAddRepeatDateAndTimeInAnnounce.frame.size.height+50
        self.tableForAddRepeatDateAndTimeInAnnounce.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y, width: oldFrame.size.width, height: newHeight)
        let newScrollHeight:CGFloat = 50.0*CGFloat(muarrayForIncreseDateTimeCell.count)
        myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1040+newScrollHeight)
        print(newScrollHeight)
        let bottomOffset = CGPoint(x: 0, y: myScrollView.contentSize.height - myScrollView.bounds.size.height)
        myScrollView.setContentOffset(bottomOffset, animated: true)
        tableForAddRepeatDateAndTimeInAnnounce.reloadData()
        
    }
    
    func functionForAllGroupMemberSetting()
    {
        let defaults = UserDefaults.standard
        let tabledata =  defaults.array(forKey: "profID")
        let tabledata1 = UserDefaults.standard.array(forKey: "groupsID")
        if tabledata?.count > 0
        {
            print(tabledata)
            print(tabledata!.count)
            let array = tabledata! as NSArray
            count = array.count
            commonIDString = array.componentsJoined(by: ",")
            print(commonIDString)
            labelYouHaveAddedGroupsAndMember.isHidden = false
            if count == 1
            {
                labelYouHaveAddedGroupsAndMember.text = "You have added "+String(count)+" members"
            }
            else
            {
                labelYouHaveAddedGroupsAndMember.text = "You have added "+String(count)+" members"
            }
            buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            varSubGrouporMember=2
            print("This  value should be-------->",varSubGrouporMember)
            UserDefaults.standard.set("", forKey: "groupsID")
        }
        else if tabledata1?.count > 0
        {
            print(tabledata1)
            print(tabledata1!.count)
            let array = tabledata1! as NSArray
            count = array.count
            commonIDString = array.componentsJoined(by: ",")
            print(commonIDString)
            labelYouHaveAddedGroupsAndMember.isHidden = false
            if count == 1
            {
                labelYouHaveAddedGroupsAndMember.text = "You have added "+String(count)+" groups"
            }
            else
            {
                labelYouHaveAddedGroupsAndMember.text = "You have added "+String(count)+" groups"
            }
            buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            varSubGrouporMember=1
            print("This  value should be-------->",varSubGrouporMember)
            UserDefaults.standard.set("", forKey: "groupsID")
        }
        else
        {
        }
        print("This is value:-------->>",varSubGrouporMember)
        /*----------------------------------------------------------------------------------*/
        if(commonIDString=="")
        {
            buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            commonIDString=""
            UserDefaults.standard.set("", forKey: "profID")
            UserDefaults.standard.set("", forKey: "groupsID")
        }
        else
        {
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
            var varGetNewLabelValue:String?=labelYouHaveAddedGroupsAndMember.text
            print(varGetNewLabelValue)
            let string = labelYouHaveAddedGroupsAndMember.text
            if(varGetNewLabelValue!.characters.count<=0)
            {
                buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                labelYouHaveAddedGroupsAndMember.text = ""
                buttonEditAllGroupMember.isHidden = true
                varSubGrouporMember=0
                annTypeStr="0"
                selectRecipientTypeEditMode = "All"
            }
            else  if string!.range(of: "groups") != nil
            {
                
                buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                labelYouHaveAddedGroupsAndMember.text = "You have added "+String(count)+" groups"
                selectRecipientTypeEditMode = "Group"
                buttonEditAllGroupMember.isHidden = false
                varSubGrouporMember=1
                annTypeStr="1"
            }
            else  if string!.range(of: "members") != nil
            {
                buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                labelYouHaveAddedGroupsAndMember.text = "You have added "+String(count)+" members"
                selectRecipientTypeEditMode = "Member"
                buttonEditAllGroupMember.isHidden = false
                
                varSubGrouporMember=2
                annTypeStr="2"
            }
        }
    }
    /*-----------------------------------------------------------Button Actions-------------------------------------End---------------------------*/
    //MARK:- ViewDidAppear
    override func viewDidAppear(_ animated: Bool)
    {
        self.buttonEditAllGroupMember.isHidden = true
        functionForAllGroupMemberSetting()
    }
    /*---------------------------All Member/Non-Smart Phone User Check Uncheck Setting-----------------Start-----------------*/
    
    func functionForButtonAllMemberSelectOrNot()
    {
        if(self.SMSCountStr == "0" || self.SMSCountStr == "")
        {
            let alert = UIAlertController(title: "Rotary India", message: "Balance whatsapp count is 0. Please recharge", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else
        {
            if(AllMemberCheckUnCheck == "Unchecked" )
            {
                //UN_CHECK_BLUE_ROW
                
                if self.textViewDescription.text.count<=0
                {
                    let alert = UIAlertController(title: "Rotary India", message: "Please enter description.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
                    alert.addAction(ok)
                    present(alert, animated: true, completion: nil)
                    self.textViewDescription.becomeFirstResponder()
                }
                //                else if self.textViewDescription.text.count>2000
                //                {
                //                    let alert = UIAlertController(title: "Rotary India", message: "Description cannot be more than 2000 characters for SMS.", preferredStyle: .alert)
                //                    let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
                //                    alert.addAction(ok)
                //                    present(alert, animated: true, completion: nil)
                //                }
                //                else if(buttonSelectPublishDate.titleLabel?.text == "  Select Date and Time  " && buttonSelectPublishDate.title( for: UIControl.State.normal)=="  Select Date and Time  ")
                //                {
                //                    print(buttonSelectPublishDate.titleLabel?.text)
                //                    let alert = UIAlertController(title: "Rotary India", message: "Please enter publish date.", preferredStyle: .alert)
                //                    let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
                //                    alert.addAction(ok)
                //                    present(alert, animated: true, completion: nil)
                //                }
                else
                {
                    buttonAllMemberCheckUncheck.setImage(UIImage(named: "switchOn"),  for: UIControl.State.normal)
                    buttonNonSmartPhoneUsersCheckUncheck.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                    AllMemberCheckUnCheck = "Checked"
                    AllNonSmartPhoneCheckUncheck = "AllNonSmartUserUnCheck"
                    val = "1"
                    if isCategory=="1"
                    {
                        //  self.getAnnounceSMSCountdetails()
                    }
                }
            }
            else if(AllMemberCheckUnCheck == "Checked")
            {
                buttonAllMemberCheckUncheck.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                AllMemberCheckUnCheck = "Unchecked"
                val = "0"
            }
            
            if(val == "0")
            {
                allSMSFlag="0"
            }
            else
            {
                allSMSFlag="1"
                nonSmartSMSFlag="0"
            }
        }
    }
    
    func functionForButtonAllMemberSelectOrNotBackup1()
    {
        if(self.SMSCountStr == "0" || self.SMSCountStr == "")
        {
            let alert = UIAlertController(title: "Rotary India", message: "Balance whatsapp count is 0. Please recharge", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else
        {
            if(AllMemberCheckUnCheck == "Unchecked" )
            {
                //UN_CHECK_BLUE_ROW
                buttonAllMemberCheckUncheck.setImage(UIImage(named: "switchOn"),  for: UIControl.State.normal)
                buttonNonSmartPhoneUsersCheckUncheck.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                AllMemberCheckUnCheck = "Checked"
                AllNonSmartPhoneCheckUncheck = "AllNonSmartUserUnCheck"
                val = "1"
            }
            else if(AllMemberCheckUnCheck == "Checked")
            {
                buttonAllMemberCheckUncheck.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                AllMemberCheckUnCheck = "Unchecked"
                val = "0"
            }
            
            if(val == "0")
            {
                allSMSFlag="0"
            }
            else
            {
                allSMSFlag="1"
                nonSmartSMSFlag="0"
            }
        }
        
    }
    
    
    func functionForAllNonSmartPhoneUserSlectOrNot()
    {
        if(self.SMSCountStr == "0" || self.SMSCountStr == "")
        {
            let alert = UIAlertController(title: "Rotary India", message: "Balance whatsapp count is 0. Please recharge", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else
        {
            if(AllNonSmartPhoneCheckUncheck == "AllNonSmartUserUnCheck" )
            {
                buttonNonSmartPhoneUsersCheckUncheck.setImage(UIImage(named: "switchOn"),  for: UIControl.State.normal)
                buttonAllMemberCheckUncheck.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                AllNonSmartPhoneCheckUncheck = "Checked"
                AllMemberCheckUnCheck = "Unchecked"
                val = "1"
            }
            else if(AllNonSmartPhoneCheckUncheck == "Checked")
            {
                buttonNonSmartPhoneUsersCheckUncheck.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                AllNonSmartPhoneCheckUncheck = "AllNonSmartUserUnCheck"
                val = "0"
            }
            if(val == "0")
            {
                nonSmartSMSFlag="0"
            }
            else
            {
                nonSmartSMSFlag="1"
                allSMSFlag="0"
            }
            
        }
    }
    /*---------------------------All Member/Non-Smart Phone User Check Uncheck Setting--------------------End-----------------*/
    
    /*---------------------------Repeated Date And Time------------------Start-----------------*/
    
    func functionForRepeatedDateAndTimeBindInStringArray()
    {
        for i in 00..<muarrayForIncreseDateTimeCell.count
        {
            let letGetValue=muarrayForIncreseDateTimeCell.object(at: i)as AnyObject
            // let letGetValueOfTime = muarrayForAddSelectedOnlyTimeInCell.objectAtIndex(i) as! AnyObject
            print(letGetValue)
            
            if(letGetValue as! String=="  Select Date and Time  " )
            {
                
            }
            else
            {
                let myDate = letGetValue
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
                let date = dateFormatter.date(from: myDate as! String)!
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                let dateStringPublish = dateFormatter.string(from: date)
                print(dateStringPublish)
                
                print(letGetValue)
                // print(letGetValueOfTime)
                if(dateStringPublish == "0")
                {
                    print(dateStringPublish)
                    //  print(letGetValueOfTime)
                }
                else
                {
                    if(i==0)
                    {
                        
                        AnnouncementRepeatDates=(dateStringPublish+":00")
                        print(AnnouncementRepeatDates)
                    }
                    else
                    {
                        AnnouncementRepeatDates=AnnouncementRepeatDates+","+(dateStringPublish+":00")
                        print(AnnouncementRepeatDates)
                    }
                }
            }
            print(AnnouncementRepeatDates)
        }
    }
    /*---------------------------Repeated Date And Time------------------End-----------------*/
    
    func functionForCurrentDate()
    {
        let date = Foundation.Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let currentdate = formatter.string(from: date)
        varGetCellDateSelected = currentdate //+":00"+" +0000"
        currentdateForPSDMatch = varGetCellDateSelected
        print(varGetCellDateSelected)
    }
    //Date And Time Picker Notification
    /*--------------------------------------------------------------------------------------------------------*/
    @objc func NotificationIdentifierForGettingValue(_ notification: Notification)
    {
        
        self.customView.removeFromSuperview()
        let userInfo = notification.userInfo!
        let index = userInfo.index(userInfo.startIndex, offsetBy: 0) // index 1
        print(userInfo.keys[index])
        var dictValue:NSDictionary = NSDictionary()
        dictValue = userInfo as NSDictionary
        print(dictValue.value(forKey: "varUserFullNameFB") as! String)
        if(varWhichClicked=="PSD")
        {
            varGetPublishSelectDate=dictValue.value(forKey: "varUserFullNameFB") as! String
            buttonSelectPublishDate.setTitle(dictValue.value(forKey: "varUserFullNameFB") as! String,  for: UIControl.State.normal)
            varGetPSD=dictValue.value(forKey: "varUserFullNameFB") as! String//+":00"+" +0000"
            print(varGetPSD)
            
            functionForCurrentDate()
            var varGetDateStatus=commonClassFunction().functionForCompareDatewithTime(currentdateForPSDMatch, stringSecondDate: varGetPSD)
            /*
             if(varGetDateStatus=="Descending")
             {
             
             let alert = UIAlertController(title: "Announcement", message: "Please make the Publish Date & Time greater than the current date & Time", preferredStyle: UIAlertController.Style.alert)
             alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
             self.presentViewController(alert, animated: true , completion: nil)
             textFieldSelectPublishDateAndTime()
             }
             */
            
            /*------------------------------------Need to implement---------------------------------------------*/
            
            //  else
            if((buttonSelectPublishDate.titleLabel?.text! != "  Select Date and Time  ") && (buttonSelectExpireDate.titleLabel?.text! != "  Select Date and Time  "))
            {
                print(varGetPSD)
                print(varGetESD)
                var varGetDatePublishISLessThanExp = commonClassFunction().functionForCompareDatewithTime(varGetESD, stringSecondDate: varGetPSD)
                if(varGetDatePublishISLessThanExp=="Ascending")
                {
                    
                    let alert = UIAlertController(title: "Announcement", message: "Please make the Publish Date & Time less than Expiry Date & Time", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true , completion: nil)
                    textFieldSelectPublishDateAndTime()
                }
                else
                {
                    buttonOpticity.isHidden = true
                }
            }
            /*--------------------------------------------------------------------------------------------------*/
            else
            {
                print(varGetPSD)
                print(varGetESD)
                if(isCalledFRom=="list")
                {
                    var varGetDateStatusToEditMode = commonClassFunction().functionForCompareDatewithTime(varGetESD, stringSecondDate: varGetPSD)
                    if(varGetDateStatusToEditMode=="Ascending")
                    {
                        
                        let alert = UIAlertController(title: "Announcement", message: "Please make the Publish Date & Time less than Expiry Date & Time", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                        self.present(alert, animated: true , completion: nil)
                        textFieldSelectPublishDateAndTime()
                    }
                    else
                    {
                        
                    }
                }
                
                
                buttonOpticity.isHidden = true
            }
        }
        else  if(varWhichClicked=="ESD")
        {
            varGetExpireSelectDate=dictValue.value(forKey: "varUserFullNameFB") as! String
            buttonSelectExpireDate.setTitle(dictValue.value(forKey: "varUserFullNameFB") as! String,  for: UIControl.State.normal)
            varGetESD=dictValue.value(forKey: "varUserFullNameFB") as! String//+":00"+" +0000"
            
            var varGetDateStatus=commonClassFunction().functionForCompareDatewithTime(varGetPSD, stringSecondDate: varGetESD)
            if(varGetDateStatus=="Descending")
            {
                let alert = UIAlertController(title: "Announcement", message: "Please make the Expiry Date & Time greater than the Publish Date & Time", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                self.present(alert, animated: true , completion: nil)
                textFieldSelectExpiryDateAndTime()
            }
            else if(varGetDateStatus=="Same")
            {
                let alert = UIAlertController(title: "Announcement", message: "Please make the Expiry Date & Time greater than the Publish Date & Time", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                self.present(alert, animated: true , completion: nil)
                
                // self.view.makeToast("Please make the Expiry Date & Time greater than the Publish Date & Time", duration: 2, position: CSToastPositionCenter)
                textFieldSelectExpiryDateAndTime()
            }
            else
            {
                buttonOpticity.isHidden = true
            }
        }
        if(varWhichClicked == "DateFromTable")
        {
            
            let selectedDate  = dictValue.value(forKey: "varUserFullNameFB") as! String
            print(selectedDate)
            muarrayForIncreseDateTimeCell.replaceObject(at: indexPath, with: selectedDate)
            buttonOpticity.isHidden = true
            varGetCellDateSelected = dictValue.value(forKey: "varUserFullNameFB") as! String//+":00"+" +0000"
            print(varGetCellDateSelected)
            
            if(varGetPSD != "")
            {
                var varGetDateStatus=commonClassFunction().functionForCompareDatewithTime(varGetPSD, stringSecondDate: varGetCellDateSelected)
                checkRemainder = 0
                if(varGetDateStatus=="Descending")
                {
                    
                    let alert = UIAlertController(title: "Announcement", message: "Reminder Date & Time should be greater than the Publish Date & Time", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true , completion: nil)
                    
                    //  self.view.makeToast("Reminder Date & Time should be greater than the Publish Date & Time", duration: 2, position: CSToastPositionCenter)
                    textFieldSelectDateClickEvent()
                }
                else if(varGetDateStatus=="Same")
                {
                    
                    let alert = UIAlertController(title: "Announcement", message: "Reminder Date & Time should be greater than the Publish Date & Time", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true , completion: nil)
                    
                    // self.view.makeToast("Reminder Date & Time should be greater than the Publish Date & Time", duration: 2, position: CSToastPositionCenter)
                    textFieldSelectDateClickEvent()
                }
                else
                {
                    if(varGetESD != "")
                    {
                        var varGetDateStatus=commonClassFunction().functionForCompareDatewithTime(varGetESD, stringSecondDate: varGetCellDateSelected)
                        if(varGetDateStatus=="Ascending")
                        {
                            
                            let alert = UIAlertController(title: "Announcement", message: "Reminder Date & Time should be less than Expiry Date & Time", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                            self.present(alert, animated: true , completion: nil)
                            
                            
                            // self.view.makeToast("Reminder Date & Time should be less than Expiry Date & Time", duration: 2, position: CSToastPositionCenter)
                            
                            
                            
                            textFieldSelectDateClickEvent()
                        }
                        else
                        {
                            
                        }
                    }
                }
            }
            tableForAddRepeatDateAndTimeInAnnounce.reloadData()
        }
        
    }
    //Remove View
    @objc func NotificationIdentifierForGettingValueForPickerCloseWithpoutValueSelect(_ notification: Notification)
    {
        self.customView.removeFromSuperview()
        // buttonOpticity.hidden=true
    }
    /*--------------------------------------------------------------------------------------------------------*/
    
    //MARK:- Image Picker Methods
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
        //let imageData:Data = UIImageJPEGRepresentation(img, compressionQuality)!
        let imageData:Data = img.jpegData(compressionQuality: compressionQuality)!
        let imageSize: Int = imageData.count
        print("size of image in KB: %f ", Double(imageSize) / 1024.0)
        UIGraphicsEndImageContext()
        return UIImage(data: imageData)!
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        var chosenImage:UIImage! //2
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            chosenImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chosenImage = possibleImage
        }
        self.imageAnnouncement.contentMode = .scaleAspectFit
        imageAnnouncement.image=chosenImage
        let varGetImage:UIImage =  self.compressImage(imageAnnouncement.image!)
        //let imageData: Data = UIImageJPEGRepresentation(varGetImage , 0.6)!
        let imageData: Data = varGetImage.jpegData(compressionQuality: 0.6)!
        let imageSize: Int = imageData.count
        print("size of image in KB: %f ", Double(imageSize) / 1024.0)
        
        functionForImageUpload()
        dismiss(animated: true, completion: nil) //5
    }
    
    /*--------------------------------------------------------------------------------------------------------
     
     func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[String : Any])
     {
     var chosenImage:UIImage! //2
     if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
     chosenImage = possibleImage
     } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
     chosenImage = possibleImage
     }
     self.imageAnnouncement.contentMode = .scaleAspectFit
     imageAnnouncement.image=chosenImage
     let varGetImage:UIImage =  self.compressImage(imageAnnouncement.image!)
     //let imageData: Data = UIImageJPEGRepresentation(varGetImage , 0.6)!
     let imageData: Data = varGetImage.jpegData(compressionQuality: 0.6)!
     let imageSize: Int = imageData.count
     print("size of image in KB: %f ", Double(imageSize) / 1024.0)
     
     functionForImageUpload()
     dismiss(animated: true, completion: nil) //5
     }*/
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func functionForImageUpload()
    {
        // loaderViewMethod()
        
        // let imageT = imageAnnouncement.image
        /*
         let imageT:UIImage =  self.compressImage(imageAnnouncement.image!)
         
         Alamofire.upload(.POST, URL, multipartFormData: {
         multipartFormData in
         if let imageData = UIImageJPEGRepresentation(imageT, 0.6) {
         multipartFormData.appendBodyPart(data: imageData, name: "image", fileName: "file.png", mimeType: "image/png")
         }
         for (key, value) in parameters {
         multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
         }
         
         }, encodingCompletion: {
         encodingResult in
         switch encodingResult {
         case .Success(let upload, _, _):
         print("s")
         var dictResponseData:NSDictionary = NSDictionary()
         upload.responseJSON
         {
         response in
         print(response.request)  // original URL request
         print(response.response) // URL response
         print(response.data)     // server data
         print(response.result)   // result of response serialization
         if let JSON = response.result.value
         {
         dictResponseData = JSON as! NSDictionary
         print("JSON: \(JSON)")
         print(dictResponseData)
         self.ImsgId = dictResponseData.valueForKey("LoadImageResult")!.valueForKey("ImageID") as! String
         self.window=nil;
         print(self.ImsgId)
         self.imageUploadOrNot = "UploadSuccess"
         }
         }
         case .Failure(let encodingError):
         print(encodingError)
         self.view.makeToast("Image Upload failed, Please try again!", duration: 2, position: CSToastPositionCenter)
         self.imageUploadOrNot = "Not"
         }
         })
         */
        /////--------------
        //   loaderViewMethod()
        //  SVProgressHUD.show()
        var parameters = [String:AnyObject]()
        parameters = ["name":"announcement" as AnyObject]
        let URL = baseUrl+touchBase_UploadImag
        
        
        // let imageT = imageAnnouncement.image
        let image:UIImage =  self.compressImage(imageAnnouncement.image!)
        //let imageData: NSData = UIImagePNGRepresentation(image) as! NSData
        let imageData = image.jpegData(compressionQuality: 0.19) //UIImageJPEGRepresentation(image, 0.19)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if let data = imageData{
                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
            }
        }, usingThreshold: UInt64.init(), to: URL, method: .post, headers: nil) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    
                    var dic :NSDictionary=NSDictionary()
                    dic = response.result.value as! NSDictionary
                    print("=========================-",dic)
                    var imdidddds = (dic.value(forKey: "LoadImageResult") as! NSDictionary).value(forKey: "ImageID") as! String
                    if(imdidddds != "")
                    {
                        self.ImsgId = imdidddds
                    }
                    //  self.window=nil;
                    if let err = response.error{
                        //  self.window=nil;
                        return
                    }
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                // self.window=nil;
            }
            SVProgressHUD.dismiss()
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
    
    //MARK:- TableView Delegate for Select Number
    /*--------------------------------tableForAddRepeatDateAndTimeInAnnounce methods--------------Start-------------*/
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayForIncreseDateTimeCell.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : CustomCellForAddAnnounce! = tableView.dequeueReusableCell(withIdentifier: "CustomCellForAddAnnounce") as! CustomCellForAddAnnounce
        if(muarrayForIncreseDateTimeCell.count>0)
        {
            
            print(muarrayForIncreseDateTimeCell)
            print(".......>")
            cell.textfieldRepeatSelectDate.text = muarrayForIncreseDateTimeCell.object(at: indexPath.row) as? String
            //            if(muarrayForAddSelectedOnlyTimeInCell.count>0)
            //            {
            //                cell.textfieldRepeatSelectTime.text = muarrayForAddSelectedOnlyTimeInCell.objectAtIndex(indexPath.row) as? String
            //            }
        }
        cell.textfieldRepeatSelectDate.delegate = self
        // cell.textfieldRepeatSelectTime.delegate = self
        cell.buttonRemoveSelectDateAndTimeFromTable.addTarget(self, action: #selector(buttonGetInfoClicked(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonRemoveSelectDateAndTimeFromTable.tag=indexPath.row;
        return cell as CustomCellForAddAnnounce
    }
    /*-------------------------------------------function for remove cell row-------------------Start---------*/
    @objc func buttonGetInfoClicked(_ sender:UIButton)
    {
        print("Hello")
        
        let vargetIndex:Int = sender.tag;
        print(vargetIndex)
        print(indexPath)
        tableForAddRepeatDateAndTimeInAnnounce.isHidden = false
        muarrayForIncreseDateTimeCell.removeObject(at: vargetIndex)
        // muarrayForAddSelectedDateAndTimeInCell.removeObjectAtIndex(vargetIndex)
        // muarrayForAddSelectedOnlyTimeInCell.removeObjectAtIndex(vargetIndex)
        print(muarrayForIncreseDateTimeCell.count)
        
        let oldFrame = self.tableForAddRepeatDateAndTimeInAnnounce.frame
        let newHeight = self.tableForAddRepeatDateAndTimeInAnnounce.frame.size.height-50
        self.tableForAddRepeatDateAndTimeInAnnounce.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y, width: oldFrame.size.width, height: newHeight)
        let newScrollHeight:CGFloat = 50.0*CGFloat(muarrayForIncreseDateTimeCell.count)
        //  myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1040+newScrollHeight-50)
        
        myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1045+newScrollHeight-30)
        
        
        
        print(newScrollHeight)
        let bottomOffset = CGPoint(x: 0, y: myScrollView.contentSize.height - myScrollView.bounds.size.height)
        myScrollView.setContentOffset(bottomOffset, animated: true)
        tableForAddRepeatDateAndTimeInAnnounce.reloadData()
    }
    /*-------------------------------------------function for remove cell row-------------------End---------*/
    
    //MARK:- Textfield Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textfieldTitle.resignFirstResponder()
        return true
    }
    func textViewShouldReturn(_ textView: UITextView) -> Bool
    {
        if(textView==textViewDescription)
        {
            textViewDescription.text! = textViewDescription.text! + "\n"
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if(textView == textViewDescription)
        {
            let descCription = textViewDescription.text!
            print(descCription)
            textViewDescription.text! = descCription
            
        }
        
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
        
        //
        //        if(textField==textfieldTitle)
        //        {
        //            animateViewMoving(true, moveValue: 50)
        //        }
        //        else
        //        {
        //            animateViewMoving(true, moveValue: 100)
        //        }
        
        
        if(textField == textfieldTitle)
        {
            textfieldTitle.becomeFirstResponder()
        }
        else
        {
            textfieldTitle.resignFirstResponder()
            textViewDescription.resignFirstResponder()
            
            let pointInTable = textField.convert(textField.bounds.origin, to: tableForAddRepeatDateAndTimeInAnnounce)
            indexPath = (tableForAddRepeatDateAndTimeInAnnounce.indexPathForRow(at: pointInTable)?.row)!
            print(indexPath)
            textFieldForSelectDateAndTimeTag = textField
            let varGetActivatedTextFieldDateTag =   textFieldForSelectDateAndTimeTag.tag
            print(varGetActivatedTextFieldDateTag)
            textField.resignFirstResponder()
            
            if(varGetActivatedTextFieldDateTag == 100)
            {
                if(buttonSelectPublishDate.titleLabel?.text! == "  Select Date and Time  ")
                {
                    
                    let alert = UIAlertController(title: "Announcement", message: "Please enter publish date, event date first. ", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    // self.view.makeToast("Please enter publish date, event date first", duration: 2, position: CSToastPositionCenter)
                    
                }
                else if((buttonSelectPublishDate.titleLabel?.text! != "  Select Date and Time  "))
                {
                    textFieldSelectDateClickEvent()
                }
            }
            else
            {
                if(buttonSelectExpireDate.titleLabel?.text! == "  Select Date and Time  ")
                {
                    
                    let alert = UIAlertController(title: "Announcement", message: "Please enter expiry date, event date first. ", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    //  self.view.makeToast("Please enter expiry date, event date first", duration: 2, position: CSToastPositionCenter)
                    
                    
                }
                else if((buttonSelectExpireDate.titleLabel?.text! != "  Select Date and Time  "))
                {
                    textFieldSelectDateClickEvent()
                }
            }
        }
    }
    /*-------------------------------------Picker On On Cell Date And Time Selection-----------------Start------------------*/
    func textFieldSelectDateClickEvent()
    {
        textfieldTitle.resignFirstResponder()
        textViewDescription.resignFirstResponder()
        print("Date Selected")
        buttonOpticity.isHidden = false
        self.customView =  SimpleCustomView(frame: CGRect(x: 0,y: 0, width: 320, height: 568))
        customView.center = view.center;
        self.view.addSubview(self.customView!)
        self.customView.lblTitleText = "DateAndTime";
        varWhichClicked="DateFromTable"
    }
    func textFieldSelectTimeClickEvent()
    {
        
        textfieldTitle.resignFirstResponder()
        textViewDescription.resignFirstResponder()
        print("Time Selected")
        buttonOpticity.isHidden = false
        self.customView =  SimpleCustomView(frame: CGRect(x: 0,y: 0, width: 320, height: 568))
        customView.center = view.center;
        self.view.addSubview(self.customView!)
        self.customView.lblTitleText = "Time";
        varWhichClicked="TimeFromTable"
    }
    /*-------------------------------------Picker On On Cell Date And Time Selection-----------------End------------------*/
    
    /*-----------------------------------------------Keyboard hide---------------------------------------------------------*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
        self.myScrollView.endEditing(true)
    }
    
    //MARK:- Server api calling
    /*-----------------------------------------------Add Announce Details---------------------------End----------------------*/
    //Announce Add
    func functionForSaveUSerProfileData()
    {
        // loaderViewMethod()
        SVProgressHUD.show()
        let PDate = buttonSelectPublishDate.titleLabel?.text!
        let EDate = buttonSelectExpireDate.titleLabel?.text!
        
        let myDate = PDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let date = dateFormatter.date(from: myDate!)!
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateStringPublish = dateFormatter.string(from: date)
        print(dateStringPublish)
        
        let myDate1 = EDate
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd hh:mm a"
        let date1 = dateFormatter1.date(from: myDate1!)!
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm"
        let dateStringExpiry = dateFormatter1.string(from: date1)
        print(dateStringExpiry)
        
        var urlStr = baseUrl+"Announcement/AddAnnouncement"
        // define parameters
        
        var link=textfieldLink.text!
        var linknew:String!=""
        if(link.hasPrefix("Optional("))
        {
            let result3 = String(link.dropFirst(10))
            linknew = String(result3.dropLast(2))
        }
        else
        {
            linknew=textfieldLink.text!
        }
        print("************************* Add Announcement Parameter key ***************************")
        let annType:String=annTypeStr as String
        let announTitle:String=textfieldTitle.text!
        let announceDEsc:String=textViewDescription.text!
        let memID:String=groupProfileID
        let grpID:String=groupID
        let inputIDs:String=commonIDString
        let announImg:String=ImsgId
        let publishDate:String=dateStringPublish
        let expiryDate:String=dateStringExpiry
        //        let sendSMSNonSmartPh:String=nonSmartSMSFlag as String
        let sendSMSAll:String=allSMSFlag as String
        let moduleIds:String=moduleId as String
        let AnnouncementRepeatDate:String=AnnouncementRepeatDates
        let reglink:String=linknew
        
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
        
        if mainMemberID == "Yes"
        {
            self.isSubGrpAdmin = "1"
        }
        else
        {
            self.isSubGrpAdmin = "0"
        }
        
        
        
        
        print(annType)
        print(announTitle)
        print(announceDEsc)
        print(memID)
        print(grpID)
        print(inputIDs)
        print(announImg)
        print(publishDate)
        print(expiryDate)
        //        print(sendSMSNonSmartPh)
        print(sendSMSAll)
        print(moduleIds)
        print(AnnouncementRepeatDate)
        print(reglink)
        
        print("******************************************************************************************")
        let parameters = ["isSubGrpAdmin": self.isSubGrpAdmin,"announID":"0", "annType": "\(annType)", "announTitle": "\(announTitle)", "announceDEsc": "\(announceDEsc)", "memID": "\(memID)", "grpID": "\(grpID)", "inputIDs": "\(inputIDs)", "announImg": "\(announImg)", "publishDate": "\(publishDate)", "expiryDate": "\(expiryDate)","sendSMSAll": "\(sendSMSAll)","moduleId": "\(moduleIds)","AnnouncementRepeatDates":"\(AnnouncementRepeatDate)","reglink":"\(reglink)" ] as [String : Any]
        // Begin upload
        
        
        print("This is paRAMETER")
        print(urlStr)
        print(parameters)
        
        
        Alamofire.request(urlStr, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
            if response.result.value != nil
            {
                print( response.result.value)
                var dictResponseData:NSDictionary=NSDictionary()
                dictResponseData = response.result.value as! NSDictionary
                print(dictResponseData)
                let message = (dictResponseData.value(forKey: "TBAddAnnouncementResult")! as AnyObject).value(forKey: "message") as! String
                
                
                if(message=="failed")
                {
                    print("Hello Filed")
                    self.buttonAdd.isEnabled=true
                    //  self.window=nil;
                    
                }
                else
                {
                    print("Hello Success")
                    
                    let alert = UIAlertController(title: "Announcement", message: "Added successfully.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                        // self.selectedImg=nil
                        // self.ImsgId=""
                        
                        self.objprotocolForAnnouncementListingCallingApi.functionForAnnouncementListingCallingApi(stringFromWhereITCalling: "coming from add announcement screen !!!!!1")
                        
                        UserDefaults.standard.set("", forKey: "profID")
                        UserDefaults.standard.set("", forKey: "groupsID")
                        self.navigationController?.popViewController(animated: true)
                    }));
                    self.present(alert, animated: true, completion: nil)
                    // self.window=nil;
                }
            }
            SVProgressHUD.dismiss()
        }
    }
    
    //Announce Update
    func functionForUpdateUSerAnnounceDetails()
    {
        SVProgressHUD.show()
        let PDate = buttonSelectPublishDate.titleLabel?.text!
        let EDate = buttonSelectExpireDate.titleLabel?.text!
        let myDate = PDate
        
        print(EDate)
        print(PDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let date = dateFormatter.date(from: myDate!)
        print(date)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        var dateStringPublish = ""
        if let dateOfAnn = date {
             dateStringPublish = dateFormatter.string(from: dateOfAnn)
            print(dateStringPublish)
        }
        
        let myDate1 = EDate
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd hh:mm a"
        let date1 = dateFormatter1.date(from: myDate1!)
        print(date1)
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm"
        var dateStringExpiry = ""
        if let dateOfAnn = date1 {
             dateStringExpiry = dateFormatter1.string(from: dateOfAnn)
            print(dateStringExpiry)
        }
            
            
            
            //loaderViewMethod()Announcement/AddAnnouncement
            var urlStr = baseUrl+"Announcement/AddAnnouncement"
            // define parameters
            var link=textfieldLink.text!
            var linknew:String!=""
            if(link.hasPrefix("Optional("))
            {
                let result3 = String(link.dropFirst(10))
                linknew = String(result3.dropLast(2))
            }
            else
            {
                linknew=textfieldLink.text!
            }
            
            print("******************* Announcement Update Parameter Keys ************************")
            let announceID:String=self.announceIDForEdited
            let annType:String=self.annTypeStr as String
            let announTitle:String=String(format:"%@",textfieldTitle.text!)
            let announceDEsc:String=textViewDescription.text!
            let memID:String=groupProfileID
            let grpID:String=groupID
            let inputIDs:String=commonIDString
            let announImg:String=ImsgId
            let publishDate:String=dateStringPublish+":00"
            let expiryDate:String=dateStringExpiry+":00"
            let sendSMSNonSmartPh:String=nonSmartSMSFlag as String
            let sendSMSAll:String=allSMSFlag as String
            let moduleIds:String=moduleId as String
            let AnnouncementRepeatDate:String=AnnouncementRepeatDates
            let reglink:String=linknew
            
            
            
            
            print(announceID)
            print(annType)
            print(announTitle)
            print(announceDEsc)
            print(memID)
            print(grpID)
            print(inputIDs)
            print(announImg)
            print(publishDate)
            print(expiryDate)
            print(sendSMSNonSmartPh)
            print(sendSMSAll)
            print(moduleIds)
            print(AnnouncementRepeatDate)
            print(reglink)
            
            print("**************************************************************************************")
            
            //        let parameters = ["announID":self.announceIDForEdited as String, "annType": self.annTypeStr as String, "announTitle": String(format:"%@",textfieldTitle.text!), "announceDEsc": textViewDescription.text!, "memID": groupProfileID, "grpID": groupID, "inputIDs": commonIDString, "announImg": ImsgId as String!, "publishDate":dateStringPublish+":00", "expiryDate": dateStringExpiry+":00","sendSMSNonSmartPh": nonSmartSMSFlag,"sendSMSAll": allSMSFlag,"moduleId": moduleId,"AnnouncementRepeatDates":AnnouncementRepeatDates,"reglink":linknew ] as [String : Any]
            
            let parameters = ["announID": "\(announceID)", "annType": "\(annType)", "announTitle":"\(announTitle)" , "announceDEsc": "\(announceDEsc)", "memID": "\(memID)", "grpID": "\(grpID)", "inputIDs": "\(inputIDs)", "announImg": "\(announImg)", "publishDate": "\(publishDate)", "expiryDate": "\(expiryDate)","sendSMSNonSmartPh": "\(sendSMSNonSmartPh)","sendSMSAll": "\(sendSMSAll)","moduleId": "\(moduleIds)","AnnouncementRepeatDates":"\(AnnouncementRepeatDate)","reglink":"\(reglink)"] as [String : Any]
            
            // Begin upload
            print(parameters)
            print("URL:::: \(urlStr)")
            Alamofire.request(urlStr, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                if response.result.value != nil
                {
                    print( response.result.value)
                    var dictResponseData:NSDictionary=NSDictionary()
                    dictResponseData = response.result.value as! NSDictionary
                    print(dictResponseData)
                    //  let message = dictResponseData.value(forKey: "TBAddAnnouncementResult")!.valueForKey("message") as! String
                    
                    let message = (dictResponseData.value(forKey: "TBAddAnnouncementResult")! as AnyObject).value(forKey: "message") as! String
                    
                    if(message=="failed")
                    {
                        print("Hello Filed")
                        // self.window=nil;
                    }
                    else
                    {
                        print("Hello Success")
                        
                        let alert = UIAlertController(title: "Announcement", message: "Updated successfully.", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                            // self.selectedImg=nil
                            //self.ImsgId=""
                            self.objprotocolForAnnouncementListingCallingApi.functionForAnnouncementListingCallingApi(stringFromWhereITCalling: "coming from add announcement screen !!!!!1222")
                            UserDefaults.standard.set("", forKey: "profID")
                            UserDefaults.standard.set("", forKey: "groupsID")
                            self.navigationController?.popViewController(animated: true)
                        }));
                        self.present(alert, animated: true, completion: nil)
                        // s//elf.window=nil;
                        
                    }
                }
                SVProgressHUD.dismiss()
            }
        }
        /*-----------------------------------------------Announce Data on Server---------------------------------------End-----*/
        /*--------------------------------------Web Api calling for Get announcement Details from server-----------Start-----*/
        
        func getClubDetails()
        {
            //loaderViewMethod()
            let completeURL:String! = baseUrl+row_ClubInfoDetails
            var parameterst:NSDictionary=NSDictionary()
            parameterst = ["grpID":groupID as Any]
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
                        self.labelBalanceSmsCount.text="Balance WhatsApp : "+self.SMSCountStr
                        if self.isCalledFRom=="add"
                        {
                            //                self.MeetingPlace = MeetingPlace
                            //                let cell : HeaderCelll = self.self.cellArray.object(at: 0) as! HeaderCelll
                            
                            //                cell.eventVenueTextView.text! = self.MeetingPlace
                            
                            //                let cell1 : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
                            self.labelBalanceSmsCount.text="Balance WhatsApp : "+self.SMSCountStr
                            //                self.addEventTableView.reloadData()
                            // self.window = nil
                        }
                        if self.isCalledFRom=="Edit"
                        {
                            //                    let cell1 : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
                            self.SMSCountStr = smsCount
                            print(self.SMSCountStr)
                            self.labelBalanceSmsCount.text="Balance WhatsApp : "+self.SMSCountStr
                            //                    self.addEventTableView.reloadData()
                        }
                    }
                    else
                    {
                        //self.window = nil
                    }
                    SVProgressHUD.dismiss()
                }
            })
        }
        
        func functionForGetAnnounceDetails()
        {
            // loaderViewMethod()
            let completeURL = baseUrl+"Announcement/GetAnnouncementDetails"
            let parameterst = [
                "memberProfileID": groupProfileID,
                "announID": TypeIDEdit,
                "grpID": groupID
            ]
            print(parameterst)
            print(completeURL)
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
                
                print(response)
                var varGetValueServerError = response.object(forKey: "serverError")as? String
                if(varGetValueServerError == "Error")
                {
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                    SVProgressHUD.dismiss()
                }
                else
                {
                    var dictResponseData:NSDictionary=NSDictionary()
                    var dictTemporaryDictionary:NSDictionary=NSDictionary()
                    dictResponseData = response as! NSDictionary
                    print(dictResponseData)
                    
                    
                    dictTemporaryDictionary = ((((dictResponseData.value(forKey: "TBAnnounceListResult") as! NSDictionary).value(forKey: "AnnounListResult") as! NSArray).object(at: 0) as AnyObject).value(forKey: "AnnounceList") as! NSDictionary)
                    
                    //var dictTemporaryDictionary:NSDictionary=((dictResponseData.value(forKey: "TBAnnounceListResult")! as AnyObject).value(forKey: "AnnounListResult")! as AnyObject).value(forKey: "AnnounceList") as! NSDictionary
                    
                    
                    
                    var link = dictTemporaryDictionary.value(forKey: "reglink")! as! String
                    
                    var linkId=link
                    var linkIdNew:String!=""
                    if(linkId.hasPrefix("Optional("))
                    {
                        let result3 = String(linkId.dropFirst(10))
                        linkIdNew = String(result3.dropLast(2))
                    }
                    else
                    {
                        linkIdNew=link
                    }
                    print("hello new")
                    print(linkIdNew)
                    
                    self.textfieldLink.text=linkIdNew
                    
                    let varGetAnnounceID = (dictTemporaryDictionary.value(forKey: "announID")!  as! String)
                    print(varGetAnnounceID)
                    self.announceIDForEdited = varGetAnnounceID
                    let varGetAnnounceImagePath = (dictTemporaryDictionary.value(forKey: "announImg")! as! String)
                    print(varGetAnnounceImagePath)
                    let varGetAnnounceTitleFromGetDetails = (dictTemporaryDictionary.value(forKey: "announTitle")! as! String)
                    print(varGetAnnounceTitleFromGetDetails)
                    let varGetSmsCountFromGetDetails = (dictTemporaryDictionary.value(forKey: "SMSCount") as? String)
                    print("varGetSmsCountFromGetDetails \(varGetSmsCountFromGetDetails)")
                    
                    if varGetSmsCountFromGetDetails != nil && varGetSmsCountFromGetDetails != ""
                    {
                        //                self.SMSCountStr=(dictTemporaryDictionary.value(forKey: "SMSCount")! as! String)
                    }
                    
                    let varGetAnnounceDescriptionFromGetDetails = (dictTemporaryDictionary.value(forKey: "announceDEsc")! as! String)
                    print(varGetAnnounceDescriptionFromGetDetails)
                    let varGetAnnounceTypeAllSubGroupMember = (dictTemporaryDictionary.value(forKey: "type")! as! String)
                    print(varGetAnnounceTypeAllSubGroupMember)
                    let varGetAnnounceProfileIdsForShowCount = (dictTemporaryDictionary.value(forKey: "profileIds")! as! String)
                    print(varGetAnnounceProfileIdsForShowCount)
                    let varGetAnnounceRepeatDateAndTime = (dictTemporaryDictionary.value(forKey: "repeatDateTime")! as! String)
                    print(varGetAnnounceRepeatDateAndTime)
                    let varGetAnnouncePublishDateAndTime = (dictTemporaryDictionary.value(forKey: "publishDateTime")! as! String)
                    print(varGetAnnouncePublishDateAndTime)
                    let varGetAnnounceExpiryDateAndTime = (dictTemporaryDictionary.value(forKey: "expiryDateTime")! as! String)
                    print(varGetAnnounceExpiryDateAndTime)
                    let varGetAnnounceSendSMSFlagForAllMemberCheckUnCheck = (dictTemporaryDictionary.value(forKey: "sendSMSAll")! as! String)
                    print(varGetAnnounceSendSMSFlagForAllMemberCheckUnCheck)
                    let varGetAnnounceSendSMSNonSmartPhoneUsersCheckUnCheck = (dictTemporaryDictionary.value(forKey: "sendSMSNonSmartPh")! as! String)
                    print(varGetAnnounceSendSMSNonSmartPhoneUsersCheckUnCheck)
                    
                    let varGetAnnounceUpdatePublishDate = (dictTemporaryDictionary.value(forKey: "publishDate")! as! String)
                    print(varGetAnnounceUpdatePublishDate)
                    /*---------------------------------loading Image Direct from url-------------------------*/
                    //            self.labelBalanceSmsCount.text="Balance Whatsapp : "+self.SMSCountStr
                    
                    if(varGetAnnounceImagePath == "")
                    {
                        self.imageAnnouncement.image = UIImage(named: "addevent")
                    }
                    else
                    {
                        //Alamofire.request(.GET, varGetAnnounceImagePath).response { (request, response, data, error) in self.imageAnnouncement.image = UIImage(data: data!, scale:1) }
                        let url = URL(string:varGetAnnounceImagePath)
                        if let data = try? Data(contentsOf: url!)
                        {
                            self.imageAnnouncement.image = UIImage(data: data)
                        }
                    }
                    //----------------------------------Publish And Expiry Date And Time---------------------------------
                    var varPublishDate:String = "" // varGetAnnouncePublishDateAndTime
                    let myDate = varGetAnnouncePublishDateAndTime
                    let dateFormatter = DateFormatter()
                    //"17 Apr 2017 12:59 PM";
                    
                    //                "publishDate":"2022-01-14 12:43:00","expiryDate":"2022-01-15 12:42:00"
                    
                    
                    
                    dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
                    print("This is date ")
                    print(myDate)
                    
                    varPublishDate = ""
                    var varvarPublishDate = (dictTemporaryDictionary.value(forKey: "publishDate")! as! String)
                    let datesssFormatter = DateFormatter()
                    datesssFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    if let date = datesssFormatter.date(from: varvarPublishDate) {
                        datesssFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
                        let formattedDate = datesssFormatter.string(from: date)
                        print(formattedDate) // This will print: 2024-04-06 17:26:00
                        varPublishDate = formattedDate
                    } else {
                        print("Failed to convert the string to date.")
                    }
                    //                if myDate != nil {
                    //                    let date = dateFormatter.date(from: myDate)
                    //                    print(myDate)
                    //                    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
                    //                    varPublishDate = dateFormatter.string(from: date!)
                    //                    print(varPublishDate)
                    //                }
                    
                    
                    var varExpiryDate:String = "" //= varGetAnnounceExpiryDateAndTime
                    var vvarExpiryDate = (dictTemporaryDictionary.value(forKey: "expiryDateTime")! as! String)
                    
                    let datessFormatter = DateFormatter()
                    datessFormatter.dateFormat = "dd MMM yyyy hh:mm a"
                    if let date = datessFormatter.date(from: vvarExpiryDate) {
                        datessFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
                        let formattedDate = datessFormatter.string(from: date)
                        print(formattedDate) // This will print: 2024-04-06 17:26:00
                        varExpiryDate = formattedDate
                    } else {
                        print("Failed to convert the string to date.")
                    }

                    
                    //            let myDate2 = varGetAnnounceExpiryDateAndTime
                    //                if myDate2 != nil {
                    //                    let dateFormatter2 = DateFormatter()
                    //                    //"17 Apr 2017 12:59 PM";
                    //                    dateFormatter2.dateFormat = "dd MMM yyyy hh:mm a"
                    //                    let date2 = dateFormatter2.date(from: myDate2)
                    //                    dateFormatter2.dateFormat = "yyyy-MM-dd hh:mm a"
                    //                    varExpiryDate = dateFormatter2.string(from: date2!)
                    //                    print(varExpiryDate)
                    //                }
                    
                    
                    print(varPublishDate)
                    print(varExpiryDate)
                    //----------------------------general information fill in fields---------------------------------
                    //self.annTypeStr = varGetAnnounceTypeAllSubGroupMember
                    self.textfieldTitle.text! = varGetAnnounceTitleFromGetDetails
                    self.textViewDescription.text! = varGetAnnounceDescriptionFromGetDetails
                    self.lblDescCount.text=String(varGetAnnounceDescriptionFromGetDetails.count)
                    self.labelPlaceHolder.isHidden = true
                    
                    self.buttonSelectPublishDate.setTitle(varPublishDate as String, for: .normal)
                    self.buttonSelectExpireDate.setTitle(varExpiryDate,  for: UIControl.State.normal)
                    
                    print(varExpiryDate)
                    self.varGetPSD = varPublishDate as String//+" +0000"
                    self.varGetESD = varExpiryDate as String//+" +0000"
                    print(self.varGetESD)
                    print(self.varGetPSD)
                    
                    
                    
                    /*-------------------------Get Profile Id and Count No. Of sub group & Members--------Start-----*/
                    let  varGetValueForGroupAndMemberCount=varGetAnnounceProfileIdsForShowCount.components(separatedBy: ",")
                    self.count = varGetValueForGroupAndMemberCount.count
                    /*-------------------------Get Profile Id and Count No. Of sub group & Members---------End-----*/
                    
                    /*------------------------All SubGroup Member Selection--------Code by Deepak-------------Start------*/
                    if(varGetAnnounceTypeAllSubGroupMember == "0")
                    {
                        self.buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                        self.buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                        self.buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                        self.labelYouHaveAddedGroupsAndMember.text = ""
                        self.buttonEditAllGroupMember.isHidden = true
                        self.varSubGrouporMember=0
                        self.annTypeStr="0"
                    }
                    else  if varGetAnnounceTypeAllSubGroupMember == "1"
                    {
                        self.buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                        self.buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                        self.buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                        self.labelYouHaveAddedGroupsAndMember.text = "You have added "+String(self.count)+" groups"
                        self.varSubGrouporMember=1
                        self.buttonEditAllGroupMember.isHidden = false
                        self.annTypeStr="1"
                    }
                    else  if varGetAnnounceTypeAllSubGroupMember == "2"
                    {
                        self.buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                        self.buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                        self.buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                        self.labelYouHaveAddedGroupsAndMember.text = "You have added "+String(self.count)+" members"
                        self.varSubGrouporMember=2
                        self.buttonEditAllGroupMember.isHidden = false
                        self.annTypeStr="2"
                        
                    }
                    else
                    {
                    }
                    /*-----------------All SubGroup Member Selection--------Code by Deepak----------End-----------*/
                    
                    /*---------------Date And Time set in Table--------------Code by Deepak----Start------------ */
                    if(varGetAnnounceRepeatDateAndTime != "")
                    {
                        let  myStringArr=varGetAnnounceRepeatDateAndTime.components(separatedBy: ",")
                        
                        print(myStringArr.count)
                        print(varGetAnnounceRepeatDateAndTime)
                        for index in 0 ..< myStringArr.count
                        {
                            let repeatDate:String = myStringArr[index]
                            let myDate = repeatDate
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let date = dateFormatter.date(from: myDate)!
                            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
                            let dateStringRepeateDate = dateFormatter.string(from: date)
                            print(dateStringRepeateDate)
                            self.muarrayForIncreseDateTimeCell.add(dateStringRepeateDate)
                            //self.muarrayForIncreseDateTimeCell.addObject(myStringArr[index])
                        }
                        
                        self.buttonSwitchOnOff.isOn = true   //by default switch on
                        self.labelRepeatDateAndTime.isHidden = false
                        self.buttonAddDateAndTimeMore.isHidden = false
                        let oldFrame = self.tableForAddRepeatDateAndTimeInAnnounce.frame
                        let newHeight = self.tableForAddRepeatDateAndTimeInAnnounce.frame.size.height+60
                        self.tableForAddRepeatDateAndTimeInAnnounce.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y, width: oldFrame.size.width, height: newHeight)
                        let newScrollHeight:CGFloat = 60.0*CGFloat(self.muarrayForIncreseDateTimeCell.count)
                        self.myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1040+newScrollHeight)
                        print(newScrollHeight)
                        //let bottomOffset = CGPoint(x: 0, y: self.myScrollView.contentSize.height - self.myScrollView.bounds.size.height)
                        //self.myScrollView.setContentOffset(bottomOffset, animated: true)
                        self.tableForAddRepeatDateAndTimeInAnnounce.isHidden = false
                        self.tableForAddRepeatDateAndTimeInAnnounce.reloadData()
                    }
                    else
                    {
                    }
                    
                    //---------------------------------All member Check/Uncheck----------------------------
                    if(varGetAnnounceSendSMSFlagForAllMemberCheckUnCheck == "1")
                    {
                        self.AllMemberCheckUnCheck = "Unchecked"
                        print("Calling ..... to  .... functionForButtonAllMemberSelectOrNot")
                        self.functionForButtonAllMemberSelectOrNot()
                    } else{            }
                    //---------------------------------Non-Smart Phone USer Check/Uncheck----------------------------
                    if(varGetAnnounceSendSMSNonSmartPhoneUsersCheckUnCheck == "1")
                    {
                        self.AllNonSmartPhoneCheckUncheck = "AllNonSmartUserUnCheck"
                        self.functionForAllNonSmartPhoneUserSlectOrNot()
                    }else{            }
                    
                    
                    SVProgressHUD.dismiss()
                }
                //  self.window=nil;
                /*------------------------Date And Time set in Table----------Code by Deepak-------End--------- */
            })
            
            
        }
        /*--------------------------------------Web Api calling for Get announcement Details from server-----------End-----*/
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        /*-------------------------------------------------------------------------*/
        
        
        //    func textViewDidBeginEditing(textView: UITextView)
        //    {
        //        if(textView==textViewDescription)
        //        {
        //            animateViewMoving(true, moveValue: 170)
        //        }
        //        else
        //        {
        //            animateViewMoving(true, moveValue: 100)
        //        }
        //
        //    }
        //
        //    func textViewDidEndEditing(textView: UITextView)
        //    {
        //        if(textView==textViewDescription)
        //        {
        //            animateViewMoving(true, moveValue: -170)
        //        }
        //        else
        //        {
        //            animateViewMoving(true, moveValue: 100)
        //        }
        //    }
        
        //    func textFieldDidBeginEditing(textField: UITextField)
        //    {
        //
        //        if(textField==textfieldTitle)
        //        {
        //            animateViewMoving(true, moveValue: 50)
        //        }
        //        else
        //        {
        //            animateViewMoving(true, moveValue: 100)
        //        }
        //
        //    }
        //    func textFieldDidEndEditing(textField: UITextField)
        //    {
        //        if(textField==textfieldTitle)
        //        {
        //            animateViewMoving(true, moveValue: -50)
        //        }
        //        else
        //        {
        //            animateViewMoving(true, moveValue: 100)
        //        }
        //    }
        //
        //
        //    func animateViewMoving (up:Bool, moveValue :CGFloat){
        //        var movementDuration:NSTimeInterval = 0.3
        //        var movement:CGFloat = ( up ? -moveValue : moveValue)
        //        UIView.beginAnimations( "animateView", context: nil)
        //        UIView.setAnimationBeginsFromCurrentState(true)
        //        UIView.setAnimationDuration(movementDuration )
        //        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        //        UIView.commitAnimations()
        //    }
        
        /*---------------------------------------------------------------------------------*/
}




