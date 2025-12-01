//
//  UploadDocViewController.swift
//  TouchBase
//
//  Created by Umesh on 06/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices
import SVProgressHUD
class UploadDocViewController: UIViewController,UITextFieldDelegate , webServiceDelegate , uploadDocDelegate ,UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIActionSheetDelegate , smsQuesDelegate,UIDocumentPickerDelegate{
   
    var objprotocolForDocumentListing:protocolForDocumentListing?=nil
    
    
    @objc func  methodforPopViewController()
    {
        self.objprotocolForDocumentListing?.functionForDocumentListing(StringValue: "calling from added document successfully")
        //self.window=nil
        UserDefaults.standard.setValue("no", forKey: "session_IsComingFromDownloadedvieworUploadDocumnetScreen")
        
        let alert = UIAlertController(title: "Document", message: "Added successfully.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
            
            self.navigationController?.popViewController(animated: true)
        }));
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    var customView:SimpleCustomView!
    @IBOutlet var buttonOpacity: UIButton!
    @IBOutlet var scrollviewMain: UIScrollView!
    
    var SMSCountStr : String!
    
    @IBOutlet var buttonViewOnly: UIButton!
    @IBOutlet var buttonDownloadable: UIButton!
    var varIsViewOnlyorDownloadable:String!=""
    
    var varGetPublishSelectDate:String!="0"
    var varGetPublishSelectTime:String!="0"
    var varGetExpireSelectDate:String!="0"
    var varGetExpireSelectTime:String!="0"
    var varWhichClicked:String!="0"
    
    var varSubGrouporMember:Int!=0
    
    // @IBOutlet var SMSCountLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var playIconImage: UIImageView!
    var appDelegate = AppDelegate()
    var countGroups = Int()
    var count = Int()
    var commonIDString : String!
    var groupProfileID : String!
    var groupID = String()
    var imageCondition = Bool()
    var videoCondition = Bool()
    var PDFCondition = Bool()
    var chosenImage = UIImage()
    var PDFLinkDrpBx : String = ""
    var PDFLinkURL : URL?
    var PDFTypeFromDrpBx : String = ""
    var docTypeStr : String = "0"
    var isSubGrpAdmin : String = "0"
    @IBOutlet weak var buttonAddPublish: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet var PDFNameLabel: UILabel!
    @IBOutlet var imagePreview: UIImageView!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var memberTypeButton: UIButton!
    @IBOutlet var groupTypeButton: UIButton!
    @IBOutlet var allTypeButton: UIButton!
    @IBOutlet var selectFileButton: UIButton!
    
    @IBOutlet var AddedCountLabel: UILabel!
    @IBOutlet var titleTextField: UITextField!
    
    let bounds = UIScreen.main.bounds
    var imagePicker = UIImagePickerController()
    var downloadTask: URLSessionDownloadTask!
    var backgroundSession: URLSession!
    var videoURL : URL!
    var window: UIWindow?
    let screenSize: CGRect = UIScreen.main.bounds
    var allSMSFlag:NSString!
    var nonSmartSMSFlag:NSString!
    //  @IBOutlet var allMemSMSButton: UIButton!
    // @IBOutlet var nonSmartSMSButton: UIButton!
    //Get value from Xib
    
    var varGetCellDateSelected:String! = ""
    var currentdateForPSDMatch:String! = ""
    var isCalledFRom:String! = ""
    
    @IBOutlet var buttonPublishSelectDate: UIButton!
    @IBOutlet var buttonPublishSelectTime: UIButton!
    
    
    
    @IBOutlet var buttonExpireSelectDate: UIButton!
    
    
    @IBOutlet var buttonExpireSelectTime: UIButton!
    
    //----
    var varGetPSD:String!=""
    var varGetPST:String!=""
    var varGetESD:String!=""
    var varGetEST:String!=""
    
    
    @objc func NotificationIdentifierForGettingValue(_ notification: Notification)
    {
        self.customView.removeFromSuperview()
        let userInfo = notification.userInfo!
        let index = userInfo.index(userInfo.startIndex, offsetBy: 0) // index 1
        print(userInfo.keys[index])
        var dictValue:NSDictionary = NSDictionary()
        dictValue = userInfo as NSDictionary
        print(dictValue.value(forKey: "varUserFullNameFB") as! String)
        //  textfieldShowDateTime.text  = dictValue.valueForKey("varUserFullNameFB") as? String
        buttonOpacity.isHidden=true
        if(varWhichClicked=="PSD")
        {
            varGetPublishSelectDate=dictValue.value(forKey: "varUserFullNameFB") as! String
            buttonPublishSelectDate.setTitle(dictValue.value(forKey: "varUserFullNameFB") as! String,  for: UIControl.State.normal)
            varGetPSD=dictValue.value(forKey: "varUserFullNameFB") as! String//+":00"+" +0000"
            print(varGetPSD)
            
            functionForCurrentDate()
            var varGetDateStatus=commonClassFunction().functionForCompareDatewithTime(currentdateForPSDMatch, stringSecondDate: varGetPSD)
            if(varGetDateStatus=="Descending")
            {
                
                let alert = UIAlertController(title: "Document", message: "Please make the Publish Date & Time greater than the current date & Time", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                self.present(alert, animated: true , completion: nil)
                textFieldSelectPublishDateAndTime()
                SVProgressHUD.dismiss()
                buttonAddPublish.isEnabled=true
            }
                
                /*------------------------------------Need to implement---------------------------------------------*/
                
            else if((buttonPublishSelectDate.titleLabel?.text! != "  Select Date & Time  ") && (buttonPublishSelectDate.titleLabel?.text! != "  Select Date & Time  "))
            {
                print(varGetPSD)
                print(varGetESD)
                var varGetDatePublishISLessThanExp = commonClassFunction().functionForCompareDatewithTime(varGetESD, stringSecondDate: varGetPSD)
                if(varGetDatePublishISLessThanExp=="Ascending")
                {
                    
                    let alert = UIAlertController(title: "Document", message: "Please make the Publish Date & Time less than Expiry Date & Time", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                    self.present(alert, animated: true , completion: nil)
                    textFieldSelectPublishDateAndTime()
                    SVProgressHUD.dismiss()
                    buttonAddPublish.isEnabled=true
                }
                else
                {
                    buttonOpacity.isHidden = true
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
                        
                        let alert = UIAlertController(title: "Document", message: "Please make the Publish Date & Time less than Expiry Date & Time", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                        self.present(alert, animated: true , completion: nil)
                        textFieldSelectPublishDateAndTime()
                        SVProgressHUD.dismiss()
                        buttonAddPublish.isEnabled=true
                    }
                    else
                    {
                        
                    }
                }
                
                
                buttonOpacity.isHidden = true
            }
        }
        else  if(varWhichClicked=="ESD")
        {
            varGetExpireSelectDate=dictValue.value(forKey: "varUserFullNameFB") as! String
            buttonExpireSelectDate.setTitle(dictValue.value(forKey: "varUserFullNameFB") as! String,  for: UIControl.State.normal)
            varGetESD=dictValue.value(forKey: "varUserFullNameFB") as! String//+":00"+" +0000"
            
            var varGetDateStatus=commonClassFunction().functionForCompareDatewithTime(varGetPSD, stringSecondDate: varGetESD)
            if(varGetDateStatus=="Descending")
            {
                
                let alert = UIAlertController(title: "Document", message: "Please make the Expiry Date & Time greater than the Publish Date & Time", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                self.present(alert, animated: true , completion: nil)
                textFieldSelectExpiryDateAndTime()
                SVProgressHUD.dismiss()
                buttonAddPublish.isEnabled=true
            }
            else if(varGetDateStatus=="Same")
            {
                
                
                let alert = UIAlertController(title: "Document", message: "Please make the Expiry Date & Time greater than the Publish Date & Time", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                self.present(alert, animated: true , completion: nil)
                
                // self.view.makeToast("Please make the Expiry Date & Time greater than the Publish Date & Time", duration: 2, position: CSToastPositionCenter)
                buttonAddPublish.isEnabled=true
                SVProgressHUD.dismiss()
                textFieldSelectExpiryDateAndTime()
            }
            else
            {
                buttonOpacity.isHidden = true
            }
            
        }
        
    }
    //Remove View
    @objc func NotificationIdentifierForGettingValueForPickerCloseWithpoutValueSelect(_ notification: Notification)
    {
        self.customView.removeFromSuperview()
        buttonOpacity.isHidden=true
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        varSubGrouporMember=0
        UserDefaults.standard.setValue("yes", forKey: "session_IsComingFromDownloadedvieworUploadDocumnetScreen")
        UserDefaults.standard.set("no", forKey: "session_IsComingFromPop")
        
        createNavigationBar()
        titleTextField.text=""
        buttonOpacity.isHidden=true
        
        NotificationCenter.default.addObserver(self, selector: #selector(NotificationIdentifierForGettingValue(_:)), name:NSNotification.Name(rawValue: "NotificationIdentifierForGettingValue"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NotificationIdentifierForGettingValueForPickerCloseWithpoutValueSelect(_:)), name:NSNotification.Name(rawValue: "NotificationIdentifierForGettingValueForPickerCloseWithpoutValueSelect"), object: nil)
        
        var frame = self.view.frame
        frame.origin.y = 64 //The height of status bar + navigation bar
        self.scrollviewMain.frame = frame
        //self.edgesForExtendedLayout = []
        
        commonIDString = ""
        activityIndicator.stopAnimating()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        titleTextField.delegate = self
        allTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        UserDefaults.standard.set("", forKey: "profID")
        print("Nothing here")
        UserDefaults.standard.set("", forKey: "groupsID")
        print("Nothing here")
        
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = true
        
        //SMSCountLabel.text = String(format:"Balanced sms count : %@",SMSCountStr)
        
        //--scrollview height
        var sizeOfContent: CGFloat = 0
        let lLast: UIView = scrollviewMain.subviews.last!
        let wd: CGFloat = lLast.frame.origin.y
        let ht: CGFloat = lLast.frame.size.height
        sizeOfContent = wd + ht
        scrollviewMain.contentSize = CGSize(width: scrollviewMain.frame.size.width, height: 750)
        
        
        //1.
        buttonPublishSelectDate.backgroundColor = UIColor.clear
        buttonPublishSelectDate.layer.cornerRadius = 1
        buttonPublishSelectDate.layer.borderWidth = 1
        buttonPublishSelectDate.layer.borderColor = UIColor.black.cgColor
        
        //2.
        buttonPublishSelectTime.backgroundColor = UIColor.clear
        buttonPublishSelectTime.layer.cornerRadius = 1
        buttonPublishSelectTime.layer.borderWidth = 1
        buttonPublishSelectTime.layer.borderColor = UIColor.black.cgColor
        
        //3.
        buttonExpireSelectDate.backgroundColor = UIColor.clear
        buttonExpireSelectDate.layer.cornerRadius = 1
        buttonExpireSelectDate.layer.borderWidth = 1
        buttonExpireSelectDate.layer.borderColor = UIColor.black.cgColor
        
        
        //4.
        buttonExpireSelectTime.backgroundColor = UIColor.clear
        buttonExpireSelectTime.layer.cornerRadius = 1
        buttonExpireSelectTime.layer.borderWidth = 1
        buttonExpireSelectTime.layer.borderColor = UIColor.black.cgColor
        
        
        //5.
        
        //        selectFileButton.setImage(UIImage(named:"addevent.png"), forState: .Normal)
        //        selectFileButton.frame = CGRectMake(selectFileButton.frame.origin.x, selectFileButton.frame.origin.y, selectFileButton.frame.size.width, selectFileButton.frame.height)
        //
        //
        //        imagePrsdfseview.frame = CGRectMake(imagePsdfreview.frame.origin.x, imagePresdfview.frame.origin.y, imagePsdfreview.frame.size.width, imagePrevisdfew.frame.height)
//        Image("select_img.png")
        self.imagePreview.image = UIImage(named: "select_img.png")
        // self.imagePreview.image = UIImage(named: "add_image.png")
        self.selectFileButton.setBackgroundImage(UIImage(named: "select_img.png"), for: .normal)
        
//        Image("add_image.png")

    }
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
    
    //
    //    @IBAction func allMemBtnClick(){
    //        if allMemSMSButton.currentImage!.isEqual(UIImage(named: "CHECK_BLUE_ROW"))  {
    //            allSMSFlag="0"
    //           // nonSmartSMSFlag="0"
    //            allMemSMSButton.setImage(UIImage(named:"UN_CHECK_BLUE_ROW"), forState: .Normal)
    //            //self.delegates?.changeValueofSelectionAll!("0")
    //        }else {
    //            nonSmartSMSButton.setImage(UIImage(named:"UN_CHECK_BLUE_ROW"), forState: .Normal)
    //            allMemSMSButton.setImage( UIImage(named:"CHECK_BLUE_ROW"), forState: .Normal)
    //            //self.delegates?.changeValueofSelectionAll!("1")
    //            allSMSFlag="1"
    //            nonSmartSMSFlag="0"
    //        }
    ////        allSMSFlag="1"
    ////        nonSmartSMSFlag="0"
    ////        allMemSMSButton.setImage(UIImage(named: "CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
    ////        nonSmartSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
    //    }
    //    @IBAction func noSmartMemBtnClick(){
    //        if nonSmartSMSButton.currentImage!.isEqual(UIImage(named: "CHECK_BLUE_ROW")) {
    //            nonSmartSMSButton.setImage(UIImage(named:"UN_CHECK_BLUE_ROW"), forState: .Normal)
    //            nonSmartSMSFlag="0"
    //            //allMemSMSButton.setImage( UIImage(named:"CHECK_BLUE_ROW"), forState: .Normal)
    //            //self.delegates?.changeValueofSelectionnonSmartSMSButton!("0")
    //        }else  {
    //            nonSmartSMSButton.setImage( UIImage(named:"CHECK_BLUE_ROW"), forState: .Normal)
    //            allMemSMSButton.setImage(UIImage(named:"UN_CHECK_BLUE_ROW"), forState: .Normal)
    //            //self.delegates?.changeValueofSelectionnonSmartSMSButton!("1")
    //            allSMSFlag="0"
    //            nonSmartSMSFlag="1"
    //        }
    //    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let tabledata = UserDefaults.standard.array(forKey: "profID")
        {
            
            print(tabledata)
            print(tabledata.count)
            
            let array = tabledata as NSArray
            
            count = array.count
            commonIDString = array.componentsJoined(by: ",")
            print(commonIDString)
            
            AddedCountLabel.isHidden = false
            editButton.isHidden = false//false
            if count == 1
            {
                AddedCountLabel.text = String(format:"You have added %d member",count)
            }
            else
            {
                AddedCountLabel.text = String(format:"You have added %d members",count)
            }
            ////radio_btn_Check
            //radio_btn_Uncheck
            memberTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            groupTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            allTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            varSubGrouporMember=2
            
            UserDefaults.standard.set("", forKey: "groupsID")
            
            print("This  value should be 2:-------->>")
            print(varSubGrouporMember)
            UserDefaults.standard.set("", forKey: "groupsID")
            
        }
        else if let tabledata = UserDefaults.standard.array(forKey: "groupsID")
        {
            UserDefaults.standard.set("", forKey: "profID")
            
            // NSUserDefaults.standardUserDefaults().setObject("", forKey: "groupsID")
            print(tabledata)
            print(tabledata.count)
            
            let array = tabledata as NSArray
            
            countGroups = array.count
            commonIDString = array.componentsJoined(by: ",")
            print(commonIDString)
            
            AddedCountLabel.isHidden = false
            editButton.isHidden = false//false
            
            if countGroups == 1
            {
                AddedCountLabel.text = String(format:"You have added %d group",countGroups)
            }
            else
            {
                AddedCountLabel.text = String(format:"You have added %d groups",countGroups)
            }
            groupTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            memberTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            allTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            varSubGrouporMember=1
            print("This  value should be 1:-------->>")
            print(varSubGrouporMember)
            UserDefaults.standard.set("", forKey: "profID")
        }
        else
        {
            
            //            allTypeButton.setImage(UIImage(named: "rbtn_select.png"), forState: UIControl.State.Normal)
            //            groupTypeButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
            //            memberTypeButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
            //            AddedCountLabel.hidden = true
            //            editButton.hidden = true
            //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "profID")
            //            print("Nothing here")
            //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "groupsID")
            //            print("Nothing here")
        }
        
        
        
        print("This is value:-------->>")
        print(varSubGrouporMember)
        
        /*¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬*/
        /*---------------------------------------------------------------------------------------------------------------------*/
        if(commonIDString=="")
        {
            
            
            
            allTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            groupTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            memberTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            
            
            
            
            
            commonIDString=""
            
            // UserDefaults.standard.set("", forKey: "profID")
            // UserDefaults.standard.set("", forKey: "groupsID")
            
        }
        else
        {
            // UserDefaults.standard.set("", forKey: "profID")
            // UserDefaults.standard.set("", forKey: "groupsID")
            
        }
        /*-----------------------------------------------------------------------------------------------------------*/
        let varGetValue:String! =  UserDefaults.standard.value(forKey: "session_IsComingFromPop") as! String
        if(varGetValue=="yes")
        {
            
        }
        else
        {
            
            // if((cell.addPeaopleCountLabel.text)? = nil)
            // {
            var varGetNewLabelValue:String?=AddedCountLabel.text
            
            print(varGetNewLabelValue)
            let string=AddedCountLabel.text
            if(varGetNewLabelValue!.characters.count<=0)
            {
                allTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                groupTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                memberTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                
                
                varSubGrouporMember=0
                docTypeStr="0"
            }
            else  if string!.range(of: "groups") != nil
            {
                allTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                groupTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                memberTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                
                varSubGrouporMember=1
                docTypeStr="1"
            }
            else  if string!.range(of: "members") != nil
            {
                allTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                groupTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                memberTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                
                varSubGrouporMember=2
                docTypeStr="2"
            }
            //}
        }
        /*-----------------------------------------------------------------------------------------------------------*/
        
        /*------------------------------------------------------------------------------------------------------------------------*/
        
        /*––––––––––––––––––––––––––––––––––––––-----------------------------------------------------------------------------------*/
        
        
        
    }
    
    @IBAction func AllRSVPAction(_ sender: AnyObject)
    {
        UserDefaults.standard.set("", forKey: "profID")
        print("Nothing here")
        UserDefaults.standard.set("", forKey: "groupsID")
        AddedCountLabel.isHidden = true
        editButton.isHidden = true
        UserDefaults.standard.set("", forKey: "profID")
        print("Nothing here")
        UserDefaults.standard.set("", forKey: "groupsID")
        print("Nothing here")
        
        commonIDString=""
        
        AddedCountLabel.text=""
        allTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        groupTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        memberTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
    }
    @IBAction func GroupRSVPAction(_ sender: AnyObject)
    {
        
        UserDefaults.standard.set("", forKey: "profID")
        
        groupTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        memberTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        allTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        
        let SubGroupController = self.storyboard?.instantiateViewController(withIdentifier: "sub_group1") as! SubGroupListController
        SubGroupController.groupIDX = groupID
        SubGroupController.isCalledFrom = "add"
        print(varSubGrouporMember)
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
        else
        {
            SubGroupController.groupIdsArray=NSMutableArray()
            
        }
        self.navigationController?.pushViewController(SubGroupController, animated: true)
        
    }
    @IBAction func MemberRSVPAction(_ sender: AnyObject)
    {
        UserDefaults.standard.set("", forKey: "groupsID")
        
        memberTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        groupTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        allTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        
        let MembersController = self.storyboard?.instantiateViewController(withIdentifier: "edit_directory") as! EditDirectoryController
        MembersController.isCalledFRom  = "add1"
        MembersController.groupIDX = groupID
        
        print(varSubGrouporMember)
        if(varSubGrouporMember==0 || varSubGrouporMember==2)
        {
            if(commonIDString == "")
            {
                MembersController.profileIdsArray=NSMutableArray()
            }
            else
            {
                let pointsArr = commonIDString.components(separatedBy: ",")
                print("commonstr \(commonIDString)")
                MembersController.profileIdsArray=NSMutableArray(array: pointsArr).mutableCopy() as! NSMutableArray
            }
        }
        else
        {
            MembersController.profileIdsArray=NSMutableArray()
            
        }
        self.navigationController?.pushViewController(MembersController, animated: true)
        
    }
    
    @IBAction func EditButtonAction(_ sender: AnyObject) {
        
        
        
        
        var tabledataa = UserDefaults.standard.array(forKey: "profID")
        var tabledatabbb = UserDefaults.standard.array(forKey: "groupsID")
        print(tabledataa)
        print(tabledatabbb)
        
        if let tabledata = UserDefaults.standard.array(forKey: "profID")
        {
            UserDefaults.standard.set("", forKey: "groupsID")
            
            memberTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            groupTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            allTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            
            let MembersController = self.storyboard?.instantiateViewController(withIdentifier: "edit_directory") as! EditDirectoryController
            MembersController.isCalledFRom  = "add1"
            MembersController.groupIDX = groupID
            
            print(varSubGrouporMember)
            if(varSubGrouporMember==0 || varSubGrouporMember==2)
            {
                if(commonIDString == "")
                {
                    MembersController.profileIdsArray=NSMutableArray()
                }
                else
                {
                    let pointsArr = commonIDString.components(separatedBy: ",")
                    print("commonstr \(commonIDString)")
                    MembersController.profileIdsArray=NSMutableArray(array: pointsArr).mutableCopy() as! NSMutableArray
                }
            }
            else
            {
                MembersController.profileIdsArray=NSMutableArray()
                
            }
            self.navigationController?.pushViewController(MembersController, animated: true)
        }
        else if let tabledata = UserDefaults.standard.array(forKey: "groupsID")
        {
            UserDefaults.standard.set("", forKey: "profID")
            
            groupTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            memberTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            allTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            
            let SubGroupController = self.storyboard?.instantiateViewController(withIdentifier: "sub_group1") as! SubGroupListController
            SubGroupController.groupIDX = groupID
            SubGroupController.isCalledFrom = "add"
            print(varSubGrouporMember)
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
            else
            {
                SubGroupController.groupIdsArray=NSMutableArray()
                
            }
            self.navigationController?.pushViewController(SubGroupController, animated: true)
        }
        else
        {
            
            //            allTypeButton.setImage(UIImage(named: "rbtn_select.png"), forState: UIControl.State.Normal)
            //            groupTypeButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
            //            memberTypeButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
            //            AddedCountLabel.hidden = true
            //            editButton.hidden = true
            //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "profID")
            //            print("Nothing here")
            //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "groupsID")
            //            print("Nothing here")
        }
        
        
        
        print("This is value:-------->>")
        print(varSubGrouporMember)
        
        /*¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬*/
        /*---------------------------------------------------------------------------------------------------------------------*/
        if(commonIDString=="")
        {
            
            
            
            allTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            groupTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            memberTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            
            
            
            
            
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
            
            // if((cell.addPeaopleCountLabel.text)? = nil)
            // {
            var varGetNewLabelValue:String?=AddedCountLabel.text
            
            print(varGetNewLabelValue)
            let string=AddedCountLabel.text
            if(varGetNewLabelValue!.characters.count<=0)
            {
                allTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                groupTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                memberTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                
                
                varSubGrouporMember=0
                docTypeStr="0"
            }
            else  if string!.range(of: "groups") != nil
            {
                allTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                groupTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                memberTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                
                varSubGrouporMember=1
                docTypeStr="1"
            }
            else  if string!.range(of: "members") != nil
            {
                allTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                groupTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                memberTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                
                varSubGrouporMember=2
                docTypeStr="2"
            }
            //}
        }
        /*-----------------------------------------------------------------------------------------------------------*/
        
        /*------------------------------------------------------------------------------------------------------------------------*/
        
        /*––––––––––––––––––––––––––––––––––––––-----------------------------------------------------------------------------------*/
        
        
        
        
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
    
    @IBAction func buttonCancelClickEvent(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func UploadDocAction(_ sender: AnyObject)
    {
        DispatchQueue.global(qos:.background).async
            {
                SVProgressHUD.show()
                DispatchQueue.main.async
                    {
                        SVProgressHUD.show()
                }
        }
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
             self.method()
        })
    }
    
    var ifBuittonClicked:Int=0
    
func method()
{
 buttonAddPublish.isEnabled=false
 if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
 {
    if(titleTextField.text == "")
    {
        self.view!.makeToast("Please enter a Document Title", duration: 2, position: CSToastPositionCenter)
        SVProgressHUD.dismiss()
        buttonAddPublish.isEnabled=true
        titleTextField.becomeFirstResponder()
    }
    else if(varIsViewOnlyorDownloadable=="")
    {
        self.view!.makeToast("Please select Access Type", duration: 2, position: CSToastPositionCenter)
        SVProgressHUD.dismiss()
        buttonAddPublish.isEnabled=true
    }
       else  if(varGetPSD=="")
        {
            self.view!.makeToast("Please select Publish Date", duration: 2, position: CSToastPositionCenter)
            SVProgressHUD.dismiss()
         buttonAddPublish.isEnabled=true
         
     }
     else if(varGetESD=="")
     {
         self.view!.makeToast("Please select Expiry Date", duration: 2, position: CSToastPositionCenter)
        SVProgressHUD.dismiss()
        buttonAddPublish.isEnabled=true
        
    }
    else if(varIsViewOnlyorDownloadable != "" && varGetPSD != "" && varGetESD != "" )
    {
             let letPublishDatenTime:String!=varGetPSD //+" "+varGetPST+" +0000"
             let letExpireDatenTime:String!=varGetESD //+" "+varGetEST+" +0000"
             var varGetDateStatus=commonClassFunction().functionForCompareDatewithTime(letPublishDatenTime, stringSecondDate: letExpireDatenTime)
        
            if(varGetDateStatus=="Descending")
            {
                self.view.makeToast("Publish date can not be greater than from Expiry date" , duration: 3, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
                buttonAddPublish.isEnabled=true
            }
            else if(varGetDateStatus=="Same")
            {
                self.view.makeToast("Publish date and time can not be same as Expiry date and time", duration: 3, position: CSToastPositionCenter)
            SVProgressHUD.dismiss()
            buttonAddPublish.isEnabled=true
        }
       else if(varGetDateStatus=="Ascending")
        {
        if videoCondition == true
        {
          let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
          wsm.delegate=self
    
          do {
            if(ifBuittonClicked==0)
            {
                ifBuittonClicked=1
                let videoData = try Data(contentsOf: videoURL!, options: NSData.ReadingOptions())
                wsm.uploadToServer(usingDocuments: videoData, andFileName: "doc.mov", moduleName: "documentsafe")
                videoCondition = false
                // self.imagePreview.contentMode = .scaleAspectFit //DPK
                imagePreview.isHidden = false
                imageCondition = false
            }
          }
          catch
          {
              print(error)
          }
        }
        else if imageCondition == true
        {
            if(ifBuittonClicked==0)
            {
                ifBuittonClicked=1
                let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
                wsm.delegate=self
                let imageData: Data = chosenImage.pngData()!
                wsm.uploadToServer(usingDocuments: imageData, andFileName: "doc.png", moduleName: "documentsafe")
            }
        }
            
        else if PDFCondition == true
        {
            let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
            wsm.delegate=self
             
             print("Uploading file path is : \(self.PDFLinkDrpBx)")
             let pdfUrl = self.PDFLinkURL! //URL(string: self.PDFLinkDrpBx)
            print("PDF URL \(PDFTypeFromDrpBx)")
            do {
                if(ifBuittonClicked==0)
                {
                 ifBuittonClicked=1
                 let pdfData = try Data(contentsOf: pdfUrl)
                 wsm.uploadToServer(usingDocuments: pdfData, andFileName: pdfUrl.lastPathComponent, moduleName: "documentsafe")
                     PDFCondition = false
                    }
                } catch {
                    print(error)
                }
        }
        else   if(ifBuittonClicked==0)
           {
               self.view!.makeToast("Select a Document to Share!", duration: 2, position: CSToastPositionCenter)
               SVProgressHUD.dismiss()
               buttonAddPublish.isEnabled=true
           }
       }
    }
}
else
 {
 SVProgressHUD.dismiss()
 self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
 buttonAddPublish.isEnabled=true
 SVProgressHUD.dismiss()
}
}

@objc func OpenBrowser()
 {
     let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text", "com.apple.iwork.pages.pages", "public.data"], in: .import)
     documentPicker.delegate = self
     present(documentPicker, animated: true, completion: nil)
 }

func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
    let newString=url.pathExtension
    self.imagePreview.isHidden = false
    print("Path of document file : \(url)")
    self.PDFLinkDrpBx = url.description
    self.PDFLinkURL = url
    self.PDFTypeFromDrpBx=newString
    
    if(PDFTypeFromDrpBx.contains(".pdf") || PDFTypeFromDrpBx.contains(".PDF") || PDFTypeFromDrpBx.contains("pdf") )
    {
    self.imagePreview.translatesAutoresizingMaskIntoConstraints = true
        self.imagePreview.backgroundColor = UIColor.white
        self.imagePreview.layer.masksToBounds = true
        self.imagePreview.clipsToBounds = true;
        self.imagePreview.image = UIImage(named: "selectedPDF.png")
        self.isImageorOtherDoc=1
        self.playIconImage.isHidden = true
        self.PDFNameLabel.text = String(format:"%@",url.lastPathComponent)
    }
    else if(newString.contains(".txt"))
    {
        self.imagePreview.isHidden = false
        self.imagePreview.translatesAutoresizingMaskIntoConstraints = true
        self.imagePreview.backgroundColor = UIColor.white
        self.imagePreview.layer.masksToBounds = true
        self.imagePreview.clipsToBounds = true;
        self.imagePreview.image = UIImage(named: "selectedPDF.png")
        self.isImageorOtherDoc=1
        self.playIconImage.isHidden = true
        self.PDFNameLabel.text = String(format:"%@",url.lastPathComponent)
    }
    else{
        self.imagePreview.isHidden = false
        self.imagePreview.translatesAutoresizingMaskIntoConstraints = true
        self.imagePreview.backgroundColor = UIColor.white
        self.imagePreview.layer.masksToBounds = true
        self.imagePreview.clipsToBounds = true;
        self.imagePreview.image = UIImage(named: "document.png")
        self.isImageorOtherDoc=1
        self.playIconImage.isHidden = true
        self.PDFNameLabel.text = String(format:"%@",url.lastPathComponent)
    }
    self.imageCondition = false
    self.PDFCondition = true
}

@IBAction func SelectDocumentAction(_ sender: AnyObject)
    {
        self.selectFileButton.setBackgroundImage(UIImage(named: ""), for: .normal)
  if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
  {
    if(isImageorOtherDoc==0)
    {
   
   let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
   
   // 2
   let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
       (alert: UIAlertAction!) -> Void in
       print("File Deleted")
   })
   
   let DropAction = UIAlertAction(title: "Dropbox", style: .default, handler: {
       (alert: UIAlertAction!) -> Void in
       
       Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.DropboxAction), userInfo: nil, repeats: false)
   })
   
   let DocAction = UIAlertAction(title: "Document", style: .default, handler: {
       (alert: UIAlertAction!) -> Void in
       
       Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.OpenBrowser), userInfo: nil, repeats: false)
   })

   
   
   let ImageAction = UIAlertAction(title: "Image", style: .default, handler: {
       (alert: UIAlertAction!) -> Void in
       
       //shows the photo library
       self.imagePicker = UIImagePickerController()
       self.imagePicker.allowsEditing = false
       self.imagePicker.sourceType = .photoLibrary
       self.imagePicker.delegate = self
       // if #available(iOS 8.0, *) {
       self.imagePicker.modalPresentationStyle = .popover
       // } else {
       // Fallback on earlier versions
       // }
       self.present(self.imagePicker, animated: true, completion: nil)
   })
   let VideoAction = UIAlertAction(title: "Video", style: .default, handler: {
       (alert: UIAlertAction!) -> Void in
       
       self.imagePicker = UIImagePickerController()
       self.imagePicker.allowsEditing = true
       self.imagePicker.sourceType = .photoLibrary
       self.imagePicker.delegate = self
       self.imagePicker.mediaTypes = [kUTTypeMovie as NSString as String]
       // if #available(iOS 8.0, *) {
       self.imagePicker.modalPresentationStyle = .popover
       // } else {
       // Fallback on earlier versions
       // }
       
       self.present(self.imagePicker, animated: true, completion: nil)
   })
   
   // 4
   optionMenu.addAction(CancelAction)
//   optionMenu.addAction(DropAction)
   if let systemVersion = (UIDevice.current.systemVersion
    as? NSString)?.integerValue
   {
       if systemVersion >= 11
       {
           optionMenu.addAction(DocAction)
       }
   }
   optionMenu.addAction(ImageAction)
   optionMenu.addAction(VideoAction)
   
   //optionMenu.addAction(cancelAction)
   
   // 5
   self.present(optionMenu, animated: true, completion: nil)
  }
  else if(isImageorOtherDoc==1)
{
 //---------
 let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
 
 // 2
 let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
     (alert: UIAlertAction!) -> Void in
     print("File Deleted")
 })
 let DocAction = UIAlertAction(title: "Document", style: .default, handler: {
     (alert: UIAlertAction!) -> Void in
     
     Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(UploadDocViewController.OpenBrowser), userInfo: nil, repeats: false)
 })
 let ImageAction = UIAlertAction(title: "Image", style: .default, handler: {
     (alert: UIAlertAction!) -> Void in
     
     //shows the photo library
     self.imagePicker = UIImagePickerController()
     self.imagePicker.allowsEditing = false
     self.imagePicker.sourceType = .photoLibrary
     self.imagePicker.delegate = self
     // if #available(iOS 8.0, *) {
     self.imagePicker.modalPresentationStyle = .popover
     // } else {
     // Fallback on earlier versions
     // }
     self.present(self.imagePicker, animated: true, completion: nil)
 })
 let VideoAction = UIAlertAction(title: "Video", style: .default, handler: {
     (alert: UIAlertAction!) -> Void in
     
     self.imagePicker = UIImagePickerController()
     self.imagePicker.allowsEditing = true
     self.imagePicker.sourceType = .photoLibrary
     self.imagePicker.delegate = self
     self.imagePicker.mediaTypes = [kUTTypeMovie as NSString as String]
     // if #available(iOS 8.0, *) {
     self.imagePicker.modalPresentationStyle = .popover
     // } else {
     // Fallback on earlier versions
     // }
     
     self.present(self.imagePicker, animated: true, completion: nil)
 })
 
 
 //------jghjhgjhgjhjhjhgjvzxcvzxzxcvzcxvzxcvzcxvcvf
 let RemoveAction = UIAlertAction(title: "Remove", style: .default, handler: {
     (alert: UIAlertAction!) -> Void in
     
     
     
     print("removed image")
     self.isImageorOtherDoc=0
     self.imagePreview.image = UIImage(named: "select_img.png")
     self.playIconImage.image = UIImage(named: "select_img.png")
     // self.selectFileButton.setBackgroundImage(UIImage(named: "add_image.png"), forState: .Normal)
     
     self.PDFNameLabel.text=""
     
//     self.selectFileButton.setImage(UIImage(named: "select_img.png"), for: .normal)
     
     self.varIsViewOnlyorDownloadable=""
     
 })
 //----xcvcxvczxvzxcvzxcvzxcvzzxcvxzcvzxcvxcvzxcvzx
 
 
 
 // 4
 optionMenu.addAction(CancelAction)
 if let systemVersion = (UIDevice.current.systemVersion
  as? NSString)?.integerValue
 {
     if systemVersion >= 11
     {
         optionMenu.addAction(DocAction)
     }
 }
 optionMenu.addAction(ImageAction)
 optionMenu.addAction(VideoAction)
 optionMenu.addAction(RemoveAction)
 
 //optionMenu.addAction(cancelAction)
 
 // 5
 self.present(optionMenu, animated: true, completion: nil)
            }
            else
            {
                SVProgressHUD.dismiss()
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                buttonAddPublish.isEnabled=true
            }
            //--------
        }
    }
    
    
    @objc func DropboxAction()
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            OpenDropBox()
        }
        else
        {
            SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            buttonAddPublish.isEnabled=true
        }
    }
    
    
    
    
    //////////----------------
    
    func OpenDropBox()
    {
        
 if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
 imagePreview.isHidden = true
 
 //     /*
 
 // DBChooser.default().open(for: DBChooserLinkTypeDirect, from: self, completion: { (results: [AnyObject]!) -> Void in
 DBChooser.default().open(for: DBChooserLinkTypeDirect, from: self, completion: { reasults in
     if let data = reasults as! [DBChooserResult]!
     {
    //var data = results as! [DBChooserResult]
    print(data[0].link.description)
    self.PDFLinkDrpBx = data[0].link.description
        self.PDFLinkURL = URL(string: self.PDFLinkDrpBx)
    let fullNameArr = self.PDFLinkDrpBx.characters.split{$0 == "."}.map(String.init)

    print(fullNameArr[0]) // First
    print(fullNameArr[1]) // Last)
    print(fullNameArr[2]) // First
    print(fullNameArr[3]) // Last)
    
    self.PDFTypeFromDrpBx = String(format:".%@",fullNameArr[3])
    
    if self.PDFTypeFromDrpBx == ".pdf" || self.PDFTypeFromDrpBx == ".PDF"
    {
        self.imagePreview.isHidden = false
        //self.imagePreview.contentMode = .scaleAspectFit //DPK
    self.imagePreview.translatesAutoresizingMaskIntoConstraints = true
        self.imagePreview.backgroundColor = UIColor.white
        self.imagePreview.layer.masksToBounds = true
        self.imagePreview.clipsToBounds = true;
        self.imagePreview.image = UIImage(named: "selectedPDF.png")
        self.isImageorOtherDoc=1
        self.playIconImage.isHidden = true
        
        let urlSlices = self.PDFLinkDrpBx.characters.split{$0 == "/"}.map(String.init)
        
        print(urlSlices[0]) // First
        print(urlSlices[1]) // Last)
        print(urlSlices[2]) // First
        print(urlSlices[3]) // Last)
        print(urlSlices[4]) // First
        print(urlSlices[5]) // Last)
        let aString = urlSlices[5]
        let newString = aString.replacingOccurrences(of: "%20", with: "", options: .literal, range: nil)
        self.PDFNameLabel.text = String(format:"%@",newString)
    }
    else if self.PDFTypeFromDrpBx == ".txt"
    {
        self.imagePreview.isHidden = false
        self.imagePreview.translatesAutoresizingMaskIntoConstraints = true
        self.imagePreview.backgroundColor = UIColor.white
        self.imagePreview.layer.masksToBounds = true
        self.imagePreview.clipsToBounds = true;
        self.imagePreview.image = UIImage(named: "selectedPDF.png")
        self.isImageorOtherDoc=1
        self.playIconImage.isHidden = true
        
        let urlSlices = self.PDFLinkDrpBx.characters.split{$0 == "/"}.map(String.init)
        
        print(urlSlices[0]) // First
        print(urlSlices[1]) // Last)
        print(urlSlices[2]) // First
        print(urlSlices[3]) // Last)
        print(urlSlices[4]) // First
        print(urlSlices[5]) // Last)
        
        let aString = urlSlices[5]
        let newString = aString.replacingOccurrences(of: "%20", with: "", options: .literal, range: nil)
        
        
        
        self.PDFNameLabel.text = String(format:"%@",newString)
        // self.PDFNameLabel.text = String(format:"%@",urlSlices[5])
    }
        
        
    else
    {
        self.imagePreview.isHidden = false
        self.imagePreview.translatesAutoresizingMaskIntoConstraints = true
        self.imagePreview.backgroundColor = UIColor.white
        self.imagePreview.layer.masksToBounds = true
        self.imagePreview.clipsToBounds = true;
        self.imagePreview.image = UIImage(named: "document.png")
        self.isImageorOtherDoc=1
        self.playIconImage.isHidden = true
        
        let urlSlices = self.PDFLinkDrpBx.characters.split{$0 == "/"}.map(String.init)
        
        print(urlSlices[0]) // First
        print(urlSlices[1]) // Last)
        print(urlSlices[2]) // First
        print(urlSlices[3]) // Last)
        print(urlSlices[4]) // First
        print(urlSlices[5]) // Last)
        
        let aString = urlSlices[5]
        let newString = aString.replacingOccurrences(of: "%20", with: "", options: .literal, range: nil)
        
        var replaced = newString.replacingOccurrences(of: "%20", with: "")
        replaced = replaced.replacingOccurrences(of: "%28", with: "(")
        replaced = replaced.replacingOccurrences(of: "%29", with: ")")
        
        self.PDFNameLabel.text = String(format:"%@",replaced)
        // self.PDFNameLabel.text = String(format:"%@",urlSlices[5])
    }
    self.imageCondition = false
    self.PDFCondition = true
                }
                else
                {
                    
                }
                
                //            let url = NSURL(string: String(format:"%@",data[0].link.description))!
                //            self.downloadTask = self.backgroundSession.downloadTaskWithURL(url)
                //            self.downloadTask.resume()
                
                //self.fileInDocumentsDirectory("file.pdf")
                //print(self.fileInDocumentsDirectory("file.pdf"))
            })
            //    */
        }
        else
        {
            SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            buttonAddPublish.isEnabled=true
        }
        
        /////rajendra jat code here for programming herer ererre
        
        ////rajednra jat code hrere fro profgramming here errre
    }
    
    var isImageorOtherDoc:Int=0
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
            
            if mediaType == kUTTypeMovie {
                
                
                videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
                
                
                
                
                
                let MyUrl = URL(fileURLWithPath: videoURL.path)
                print(MyUrl)
                let fileAttributes = try! FileManager.default.attributesOfItem(atPath: MyUrl.path)
                let fileSizeNumber = fileAttributes[FileAttributeKey.size] as! NSNumber
                let fileSizee = fileSizeNumber.int64Value
                var sizeMB = Double(fileSizee / 1024)
                sizeMB = Double(sizeMB / 1024)
                print(sizeMB)
                print(String(format: "%.2f", sizeMB) + " MB")
                
                if(sizeMB>20.0)
                {
                    self.view.makeToast("Video size can not be more than 20 MB", duration: 3, position: CSToastPositionCenter)
                }
                else
                {
                    
                    self.playIconImage.image = UIImage(named: "video-icon.png")
                    
                    
                    imagePreview.isHidden = true
                    print(videoURL)
                    let videoPath = videoURL.path
                    print(videoPath as String)
                    
                    videoCondition = true
                    
                    imagePreview.isHidden = false
                    // imagePreview.translatesAutoresizingMaskIntoConstraints = true
                    // imagePreview.backgroundColor = UIColor.white
                    // self.imagePreview.contentMode = .scaleAspectFit //DPK
                    // imagePreview.layer.masksToBounds = true
                    // imagePreview.clipsToBounds = true;
                    
                    let fileURL = URL(fileURLWithPath: videoURL.path)
                    let asset = AVAsset(url: fileURL)
                    let assetImgGenerate = AVAssetImageGenerator(asset: asset)
                    assetImgGenerate.appliesPreferredTrackTransform = true
                    let time = CMTimeMake(value: asset.duration.value / 3, timescale: asset.duration.timescale)
                    if let cgImage = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil) {
                        imagePreview.image = UIImage(cgImage: cgImage)
                        isImageorOtherDoc=1
                        playIconImage.isHidden = false
                    }
                    imageCondition = true
                }
                //1. video size
                //            let filePath = videoURL.path
                //            var fileSize : UInt64 = 0
                //
                //            do {
                //                let attr : NSDictionary? = try NSFileManager.defaultManager().attributesOfItemAtPath(videoURL.path!)
                //
                //                if let _attr = attr {
                //                    fileSize = _attr.fileSize();
                //                    print(fileSize)
                //                }
                //            } catch {
                //                print("Error: \(error)")
                //            }
                
                //2. video size
                
                
                
                //            do{
                //                let fileAttributes = try! NSFileManager.defaultManager().attributesOfItemAtPath(videoURL.path!)
                //                print(fileAttributes)
                //                let fileSize = fileAttributes[NSFileSize]
                //                print(fileSize)
                //            }
                //            catch let err as NSError{
                //                //error handling
                //            }
            }
            else
            {
                videoCondition = false
                imagePreview.isHidden = false
                imagePreview.translatesAutoresizingMaskIntoConstraints = true
                imagePreview.layer.masksToBounds = true
                
                //    self.imagePreview.contentMode = .scaleAspectFit //---------------------DPK
                imagePreview.clipsToBounds = true;
                //var chosenImage:UIImage! //2
                if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                    chosenImage = possibleImage
                } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    chosenImage = possibleImage
                }
                
                imagePreview.image = chosenImage
                isImageorOtherDoc=1
                playIconImage.isHidden = true
                imageCondition = true
                //chosenImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)! //2
                //selectFileButton.setBackgroundImage(chosenImage, forState: .Normal)
            }
            
            self.PDFNameLabel.text=""
            dismiss(animated: true, completion: nil) //5
        }
        else
        {
            SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            buttonAddPublish.isEnabled=true
        }
        
    }
    
//    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[String : Any])
//    {
//        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//        {
//
//            let mediaType = info[UIImagePickerControllerMediaType] as! NSString
//
//            if mediaType == kUTTypeMovie {
//
//
//                videoURL = info[UIImagePickerControllerMediaURL] as! URL
//
//
//
//
//
//                let MyUrl = URL(fileURLWithPath: videoURL.path)
//                print(MyUrl)
//                let fileAttributes = try! FileManager.default.attributesOfItem(atPath: MyUrl.path)
//                let fileSizeNumber = fileAttributes[FileAttributeKey.size] as! NSNumber
//                let fileSizee = fileSizeNumber.int64Value
//                var sizeMB = Double(fileSizee / 1024)
//                sizeMB = Double(sizeMB / 1024)
//                print(sizeMB)
//                print(String(format: "%.2f", sizeMB) + " MB")
//
//                if(sizeMB>20.0)
//                {
//                    self.view.makeToast("Video size can not be more than 20 MB", duration: 3, position: CSToastPositionCenter)
//                }
//                else
//                {
//
//                    self.playIconImage.image = UIImage(named: "video-icon.png")
//
//
//                    imagePreview.isHidden = true
//                    print(videoURL)
//                    let videoPath = videoURL.path
//                    print(videoPath as String)
//
//                    videoCondition = true
//
//                    imagePreview.isHidden = false
//                    // imagePreview.translatesAutoresizingMaskIntoConstraints = true
//                    // imagePreview.backgroundColor = UIColor.white
//                    // self.imagePreview.contentMode = .scaleAspectFit //DPK
//                    // imagePreview.layer.masksToBounds = true
//                    // imagePreview.clipsToBounds = true;
//
//                    let fileURL = URL(fileURLWithPath: videoURL.path)
//                    let asset = AVAsset(url: fileURL)
//                    let assetImgGenerate = AVAssetImageGenerator(asset: asset)
//                    assetImgGenerate.appliesPreferredTrackTransform = true
//                    let time = CMTimeMake(asset.duration.value / 3, asset.duration.timescale)
//                    if let cgImage = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil) {
//                        imagePreview.image = UIImage(cgImage: cgImage)
//                        isImageorOtherDoc=1
//                        playIconImage.isHidden = false
//                    }
//                    imageCondition = true
//                }
//                //1. video size
//                //            let filePath = videoURL.path
//                //            var fileSize : UInt64 = 0
//                //
//                //            do {
//                //                let attr : NSDictionary? = try NSFileManager.defaultManager().attributesOfItemAtPath(videoURL.path!)
//                //
//                //                if let _attr = attr {
//                //                    fileSize = _attr.fileSize();
//                //                    print(fileSize)
//                //                }
//                //            } catch {
//                //                print("Error: \(error)")
//                //            }
//
//                //2. video size
//
//
//
//                //            do{
//                //                let fileAttributes = try! NSFileManager.defaultManager().attributesOfItemAtPath(videoURL.path!)
//                //                print(fileAttributes)
//                //                let fileSize = fileAttributes[NSFileSize]
//                //                print(fileSize)
//                //            }
//                //            catch let err as NSError{
//                //                //error handling
//                //            }
//            }
//            else
//            {
//                videoCondition = false
//                imagePreview.isHidden = false
//                imagePreview.translatesAutoresizingMaskIntoConstraints = true
//                imagePreview.layer.masksToBounds = true
//
//                //    self.imagePreview.contentMode = .scaleAspectFit //---------------------DPK
//                imagePreview.clipsToBounds = true;
//                //var chosenImage:UIImage! //2
//                if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
//                    chosenImage = possibleImage
//                } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
//                    chosenImage = possibleImage
//                }
//
//                imagePreview.image = chosenImage
//                isImageorOtherDoc=1
//                playIconImage.isHidden = true
//                imageCondition = true
//                //chosenImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)! //2
//                //selectFileButton.setBackgroundImage(chosenImage, forState: .Normal)
//            }
//
//            self.PDFNameLabel.text=""
//            dismiss(animated: true, completion: nil) //5
//        }
//        else
//        {
//            SVProgressHUD.dismiss()
//            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
//            buttonAddPublish.isEnabled=true
//        }
//
//    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        if let tabledata = UserDefaults.standard.array(forKey: "profID")
        {
            
            print(tabledata)
            print(tabledata.count)
            
            let array = tabledata as NSArray
            
            count = array.count
            commonIDString = array.componentsJoined(by: ",")
            print(commonIDString)
            
            AddedCountLabel.isHidden = false
            editButton.isHidden = true//false
            if count == 1
            {
                AddedCountLabel.text = String(format:"You have added %d member",count)
            }
            else
            {
                AddedCountLabel.text = String(format:"You have added %d members",count)
            }
            ////radio_btn_Check
            //radio_btn_Uncheck
            memberTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            groupTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            allTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            varSubGrouporMember=2
            
            UserDefaults.standard.set("", forKey: "groupsID")
            
            print("This  value should be 2:-------->>")
            print(varSubGrouporMember)
            
        }
        else if let tabledata = UserDefaults.standard.array(forKey: "groupsID")
        {
            
            // NSUserDefaults.standardUserDefaults().setObject("", forKey: "groupsID")
            print(tabledata)
            print(tabledata.count)
            
            let array = tabledata as NSArray
            
            countGroups = array.count
            commonIDString = array.componentsJoined(by: ",")
            print(commonIDString)
            
            AddedCountLabel.isHidden = false
            editButton.isHidden = false
            
            if countGroups == 1
            {
                AddedCountLabel.text = String(format:"You have added %d group",countGroups)
            }
            else
            {
                AddedCountLabel.text = String(format:"You have added %d groups",countGroups)
            }
            groupTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            memberTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            allTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            varSubGrouporMember=1
            print("This  value should be 1:-------->>")
            print(varSubGrouporMember)
            UserDefaults.standard.set("", forKey: "profID")
        }
        else
        {
            
            //            allTypeButton.setImage(UIImage(named: "rbtn_select.png"), forState: UIControl.State.Normal)
            //            groupTypeButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
            //            memberTypeButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
            //            AddedCountLabel.hidden = true
            //            editButton.hidden = true
            //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "profID")
            //            print("Nothing here")
            //            NSUserDefaults.standardUserDefaults().setObject("", forKey: "groupsID")
            //            print("Nothing here")
        }
        
        
        
        print("This is value:-------->>")
        print(varSubGrouporMember)
        
        /*¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬*/
        /*---------------------------------------------------------------------------------------------------------------------*/
        if(commonIDString=="")
        {
            
            
            
            allTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
            groupTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            memberTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
            
            
            
            
            
            commonIDString=""
            
            //UserDefaults.standard.set("", forKey: "profID")
            // UserDefaults.standard.set("", forKey: "groupsID")
            
        }
        else
        {
            // UserDefaults.standard.set("", forKey: "profID")
            // UserDefaults.standard.set("", forKey: "groupsID")
            
        }
        /*-----------------------------------------------------------------------------------------------------------*/
        let varGetValue:String! =  UserDefaults.standard.value(forKey: "session_IsComingFromPop") as! String
        if(varGetValue=="yes")
        {
            
        }
        else
        {
            
            // if((cell.addPeaopleCountLabel.text)? = nil)
            // {
            var varGetNewLabelValue:String?=AddedCountLabel.text
            
            print(varGetNewLabelValue)
            let string=AddedCountLabel.text
            if(varGetNewLabelValue!.characters.count<=0)
            {
                allTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                groupTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                memberTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                
                
                varSubGrouporMember=0
                docTypeStr="0"
            }
            else  if string!.range(of: "groups") != nil
            {
                allTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                groupTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                memberTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                
                varSubGrouporMember=1
                docTypeStr="1"
            }
            else  if string!.range(of: "members") != nil
            {
                allTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                groupTypeButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
                memberTypeButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
                
                varSubGrouporMember=2
                docTypeStr="2"
            }
            //}
        }
        /*-----------------------------------------------------------------------------------------------------------*/
        
        /*------------------------------------------------------------------------------------------------------------------------*/
        
        /*––––––––––––––––––––––––––––––––––––––-----------------------------------------------------------------------------------*/
        
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    func getUploadDocSucceeded(_ response: LoadImageResult) {
        
        ifBuittonClicked=0
        
        print(response)
        // print(response.status)
        // print(response.message)
        
        if allTypeButton.currentImage!.isEqual(UIImage(named: "radio_btn_Check"))
        {
            docTypeStr = "0"
            print("ALL Documents")
        }
        else if groupTypeButton.currentImage!.isEqual(UIImage(named: "radio_btn_Check"))
        {
            docTypeStr = "1"
            print("Group Documents")
        }
        else if memberTypeButton.currentImage!.isEqual(UIImage(named: "radio_btn_Check"))
        {
            docTypeStr="2"
            print("members Documents")
        }
        else
        {
            
        }
        
        if(response.status == "0")
        {
            let defaults = UserDefaults.standard
            let uid = defaults.string(forKey: "masterUID")
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            
            //wsm.loaderViewMethod()
            
            //            print(docTypeStr)
            //            print(titleTextField.text)
            //            print(uid)
            //            print(groupID)
            //            print(commonIDString)
            //            print(response.ImageID)
            //
            //need to add publish date and time
            // var varGetPSD:String!=""
            // var varGetPST:String!=""
            // var varGetESD:String!=""
            //var varGetEST:String!=""
            //need to add expire date and time
            
            let PDate = buttonPublishSelectDate.titleLabel?.text!
            let EDate = buttonExpireSelectDate.titleLabel?.text!
            let myDate = PDate
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
            let date = dateFormatter.date(from: myDate!)!
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let letPublishDatenTime = dateFormatter.string(from: date)
            print(letPublishDatenTime)
            
            let myDate1 = EDate
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyy-MM-dd hh:mm a"
            let date1 = dateFormatter1.date(from: myDate1!)!
            dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm"
            let letExpireDatenTime = dateFormatter1.string(from: date1)
            print(letExpireDatenTime)
            
            
            //  let letPublishDatenTime=varGetPSD+" "+varGetPST
            //let letExpireDatenTime=varGetESD+" "+varGetEST
            
            
            print(varIsViewOnlyorDownloadable)
            print(response.imageID)
            print(letPublishDatenTime)
            print(letExpireDatenTime)
            
            
            
            let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
            //wsm.uploadDocument("0", docType: docTypeStr, docTitle: titleTextField.text!, memID: uid!, grpID: groupID, inputIDs: commonIDString, documentFileId: response.ImageID,docAccessType: varIsViewOnlyorDownloadable,publishDate: letPublishDatenTime,expiryDate: letExpireDatenTime)
            if mainMemberID == "Yes"
            {
                isSubGrpAdmin = "1"
            }
            else
            {
                isSubGrpAdmin = "0"
            }

            
            
            if(ifBuittonClicked==0)
            {
                SVProgressHUD.show()
                wsm.uploadDocument("0", docType: docTypeStr, docTitle: titleTextField.text!, memID: uid!, grpID: groupID, inputIDs: commonIDString, documentFileId: response.imageID, docAccessType: varIsViewOnlyorDownloadable, publishDate: letPublishDatenTime, expiryDate: letExpireDatenTime,isSubGrpAdmin: isSubGrpAdmin)
            }
            
        }
        else
        {
            
        }
    }
    
    
    
    func UploadDocumentDelegateFunction(_ uploadDoc : TBAddDocumentResult)
    {
        SVProgressHUD.dismiss()
        print(uploadDoc.status)
        print(uploadDoc.message)
        ifBuittonClicked=0
        activityIndicator.stopAnimating()
        
        //self.window=nil
        
        //self.view.makeToast("Document added succefxcvssfully.", duration: 2, position: CSToastPositionCenter)
        
        
        
        if uploadDoc.status == "0"
        {
            view.superview?.bringSubviewToFront( view)
            
            //self.window=nil
            // view.makeToast("Document added succexcvssfully.", duration: 2, position: CSToastPositionCenter)
            
            
            //code by Rajendra Jat need to update notification count start
            CommonSqliteClass().functionForUpdateGroupMasterandModuleDataMasterTable("+")
            
            self.objprotocolForDocumentListing?.functionForDocumentListing(StringValue: "calling from added document successfully")

            var timer = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(self.methodforPopViewController), userInfo: nil, repeats: false)
            
            
        }
        else
        {
            //self.window=nil
            self.view.makeToast("File upload failed, Please Try Again!", duration: 2, position: CSToastPositionCenter)
            SVProgressHUD.dismiss()
            
        }
        
        
        
    }
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*«««««««««««««∆∆∆∆∆∆∆∆∆∆∆∆»»»»»»»»»»*/
    @IBAction func buttonViewOnlyClickEvent(_ sender: AnyObject)
    {
        buttonViewOnly.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
        buttonDownloadable.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
        varIsViewOnlyorDownloadable="0"
    }
    @IBAction func buttonDownloadableClickEvent(_ sender: AnyObject)
    {
        buttonViewOnly.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
        buttonDownloadable.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
        varIsViewOnlyorDownloadable="1"
    }
    /*«««««««««««««∆∆∆∆∆∆∆∆∆∆∆∆»»»»»»»»»»*/
    
    func textFieldSelectPublishDateAndTime()
    {
        buttonOpacity.isHidden = false
        self.customView =  SimpleCustomView(frame: CGRect(x: 0,y: 0, width: 320, height: 568))
        customView.center = view.center;
        self.view.addSubview(self.customView!)
        self.customView.lblTitleText = "DateAndTime";
        varWhichClicked="PSD"
    }
    @IBAction func buttonSelectDatePublishClickEvent(_ sender: AnyObject)
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            
            
            titleTextField.resignFirstResponder()
            textFieldSelectPublishDateAndTime()
            //        buttonOpacity.hidden=false
            //
            //        //self.view.alpha=1
            //        self.customView =  SimpleCustomView(frame: CGRectMake(0,0, 320, 568))
            //        customView.center = view.center;
            //        self.view.addSubview(self.customView!)
            //        self.customView.lblTitleText = "Date";
            //        varWhichClicked="PSD"
        }
        else
        {
            SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            buttonAddPublish.isEnabled=true
        }
    }
    @IBAction func buttonSelectTimePublishClickEvent(_ sender: AnyObject)
    {
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            
            
            titleTextField.resignFirstResponder()
            
            buttonOpacity.isHidden=false
            
            //self.view.alpha=1
            self.customView =  SimpleCustomView(frame: CGRect(x: 0,y: 0, width: 320, height: 568))
            customView.center = view.center;
            self.view.addSubview(self.customView!);
            self.customView.lblTitleText = "Time";
            varWhichClicked="PST"
        }
        else
        {
            
            SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            buttonAddPublish.isEnabled=true
        }
        
        
    }
    @IBAction func buttonSelectDateExpireClickEvent(_ sender: AnyObject)
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            titleTextField.resignFirstResponder()
            textFieldSelectExpiryDateAndTime()
            //        buttonOpacity.hidden=false
            //
            //        //self.view.alpha=1
            //        self.customView =  SimpleCustomView(frame: CGRectMake(0,0, 320, 568))
            //        customView.center = view.center;
            //        self.view.addSubview(self.customView!)
            //        self.view.bringSubviewToFront(self.customView)
            //        self.customView.lblTitleText = "Date";
            //        varWhichClicked="ESD"
        }
        else
        {
            
            SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            buttonAddPublish.isEnabled=true
        }
        
        
    }
    
    func textFieldSelectExpiryDateAndTime()
    {
        buttonOpacity.isHidden = false
        self.customView =  SimpleCustomView(frame: CGRect(x: 0,y: 0, width: 320, height: 568))
        customView.center = view.center;
        self.view.addSubview(self.customView!)
        self.view.bringSubviewToFront( self.customView)
        self.customView.lblTitleText = "DateAndTime";
        varWhichClicked="ESD"
    }
    @IBAction func buttonSelectTimeExpireClickEvent(_ sender: AnyObject)
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            titleTextField.resignFirstResponder()
            
            buttonOpacity.isHidden=false
            //self.view.alpha=1
            self.customView =  SimpleCustomView(frame: CGRect(x: 0,y: 0, width: 320, height: 568))
            customView.center = view.center;
            self.view.addSubview(self.customView!);
            self.customView.lblTitleText = "Time";
            varWhichClicked="EST"
        }
        else
        {
            SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            buttonAddPublish.isEnabled=true
        }
        
        
    }
    /*---------------------------------------------------------------------*/
    func createNavigationBar(){
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        
        self.title="Documents"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AddContactsToGroupController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
}
