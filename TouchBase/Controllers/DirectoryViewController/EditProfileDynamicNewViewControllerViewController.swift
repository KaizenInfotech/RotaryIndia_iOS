 
 
 
 //
 //  EditProfileDynamicNewViewControllerViewController.swift
 //  TouchBase
 //
 //  Created by deepak on 01/06/17.
 //  Copyright © 2017 Parag. All rights reserved.
 //
 
 import UIKit
 import SVProgressHUD
 class EditProfileDynamicNewViewControllerViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate
 {
    var appDelegate : AppDelegate = AppDelegate()
    
    
    @IBAction func buttonRelationShipClickEvent(_ sender: AnyObject)
    {
        buttonOpacity.isHidden=true
        viewRelationShip.isHidden=true
        muarrayRelationsship_FamilyDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varGetRelationShipText)
        tbaleviewEditDetail.reloadData()
        
        //        buttonOpacity.hidden=true
        //        viewRelationShip.hidden=true
        //        let oldLastCellIndexPath = NSIndexPath(forRow: muarrayCity_AddressDetail_Table.count-Int(varSelectedTableRowIndex), inSection: 0)
        //        self.tbaleviewEditDetail.scrollToRowAtIndexPath(oldLastCellIndexPath, atScrollPosition: .Bottom, animated: false)
        //
        //        // Animate on the next pass through the runloop.
        //        dispatch_async(dispatch_get_main_queue(), {
        //            self.scrollToBottom(true,intSend: Int(self.varSelectedTableRowIndex))
        //        })
        //
        
        
        
    }
    func scrollToBottom(_ animated:Bool,intSend:Int) {
        let indexPath = IndexPath(row: self.muarrayCity_AddressDetail_Table.count-intSend, section: 0)
        
        print(indexPath)
        print(muarrayCity_AddressDetail_Table.count)
        self.tbaleviewEditDetail.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: animated)
        
        
        
        
        
    }
    
    @IBOutlet weak var buttonUpdate: UIButton!
    
    
    @IBOutlet weak var viewRelationShip: UIView!
    @IBOutlet weak var pickerViewRelationShip: UIPickerView!
    
    
    
    var currentdate: String = ""
    let timeFormatter = Foundation.DateFormatter()
    let DateFormatter = Foundation.DateFormatter()
    var  dateTimeDisplay:String = ""
    
    @IBOutlet weak var viewDOB: UIView!
    @IBOutlet weak var pickerDOB: UIDatePicker!
    
    
    var varRowHeightAddressDetail:CGFloat!=0.0
    
    var varISCountryCodeorCountryText:String!=""
    
    
    @IBOutlet weak var viewBloodGruoup: UIView!
    var muarrayBloodGroup:NSMutableArray=NSMutableArray()
    @IBOutlet weak var pickerBloodGroup: UIPickerView!
    var varGetCountry:String=""
    var varGetCountryID:String=""
    var varGetCountryCode:String=""
    
    
    var varGetIsCountryNameNew:String=""
    
    
    
    
    
    
    var varBloodGroup:String=""
    var varSelectedTableRowIndex:Int!=0
    var varSelectedTableRowTextFieldTag:Int!=0
    
    var varGetRelationShipText:String!=""
    
    
    var varSelectedTableRowIndexGet_Text:String!=""
    var objCalendarInfo : CalendarInfo = CalendarInfo()
    var varCountryCode:String!=""
    @IBOutlet weak var buttonOpacity: UIButton!
    var muarraySelectCountry:NSMutableArray=NSMutableArray()
    
    
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var pickerCountry: UIPickerView!
    
    
    //MARK:- public variable
    var profileId:String!=""
    var grpID:String!=""
    
    //personal
    var muarrayPersonalBusinessMemberDetails_FieldID_Table:NSMutableArray=NSMutableArray()
    var muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table:NSMutableArray=NSMutableArray()
    
    
    var muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table:NSMutableArray=NSMutableArray()

    
    
    var muarrayPersonalBusinessMemberDetails_Key_Table:NSMutableArray=NSMutableArray()
    var muarrayPersonalBusinessMemberDetails_Value_Table:NSMutableArray=NSMutableArray()
    var muarrayPersoanlBusinessorAddressorFamilyDetailorOther:NSMutableArray=NSMutableArray()
   
    
    
    
    
    //address
    var muarrayAddressType_AddressDetail_Table:NSMutableArray=NSMutableArray()
    var muarrayAddress_AddressDetail_Table:NSMutableArray=NSMutableArray()
    var muarrayCity_AddressDetail_Table:NSMutableArray=NSMutableArray()
    var muarrayState_AddressDetail_Table:NSMutableArray=NSMutableArray()
    var muarrayCountry_AddressDetail_Table:NSMutableArray=NSMutableArray()
    var muarrayPincode_AddressDetail_Table:NSMutableArray=NSMutableArray()
    var muarrayAddressID_AddressDetail_Table:NSMutableArray=NSMutableArray()
    
    
    
    //Family Detail
    
    var muarrayFamilyId_FamilyDetail_Table:NSMutableArray=NSMutableArray()
    var muarrayName_FamilyDetail_Table:NSMutableArray=NSMutableArray()
    var muarrayEmailID_FamilyDetail_Table:NSMutableArray=NSMutableArray()
    var muarrayCountryId_FamilyDetail_Table:NSMutableArray=NSMutableArray()
    var muarrayContactNumber_FamilyDetail_Table:NSMutableArray=NSMutableArray()
    var muarrayRelationsship_FamilyDetail_Table:NSMutableArray=NSMutableArray()
    var muarrayDOB_FamilyDetail_Table:NSMutableArray=NSMutableArray()
    var muarrayBloodGroup_FamilyDetail_Table:NSMutableArray=NSMutableArray()
    
    var muarrayRelationShip:NSMutableArray=NSMutableArray()
    
    //        pickRelationArray = ["Father","Mother","Sister","Spouse","Brother","Friend","Son","Daughter","Son-in-law","Daughter-in-law"]
    
    
    var varGetCountryId_FamilyDetail:String!=""
    
    var varGetIsBloodGroupPersoanlOrFamilyDetail:String!=""
    
    
    var varGetISDOBPersonalOrFamilyMember:String!=""
    
    
    
    
    //get total count for get add add new family member
    var varArrayCountAndMinusForAddingFamilyMember:Int!=0
    
    
    
    @IBOutlet weak var tbaleviewEditDetail: UITableView!
    var cell:EditProfileDynamicNewViewControllerViewControllerTableViewCell=EditProfileDynamicNewViewControllerViewControllerTableViewCell()
    var muarrayKey:NSMutableArray=NSMutableArray()
    var muarrayValue:NSMutableArray=NSMutableArray()
    
    @IBAction func buttonOpacityClickEvent(_ sender: AnyObject)
    {
        viewCountry.isHidden=true
        buttonOpacity.isHidden=true
        viewBloodGruoup.isHidden=true
        viewDOB.isHidden=true
        viewRelationShip.isHidden=true
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        Util.copyFile("Calendar.sqlite")
        muarraySelectCountry=NSMutableArray()
        muarraySelectCountry = ModelManager.getInstance().functionForSelectCountry()
        print(muarraySelectCountry.count)
        
    }
    @IBAction func buttonSelectCountryClickEvent(_ sender: AnyObject)
    {
        viewCountry.isHidden=true
        buttonOpacity.isHidden=true
        
        
        
        
        
        
        if(varISCountryCodeorCountryText=="countrytext")
        {
            let stringCountryMasterId =   objCalendarInfo.stringCountryMasterId
            let stringCountryMasterCode =   objCalendarInfo.stringCountryMasterCode
            let stringCountryMasterName =   objCalendarInfo.stringCountryMasterName
            
            print(stringCountryMasterId)
            print(stringCountryMasterCode)

            print(stringCountryMasterName)

            
            muarrayCountry_AddressDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: stringCountryMasterName)
            // tbaleviewEditDetail.reloadData()
            
            
            let indexPath = IndexPath(row: varSelectedTableRowIndex, section: 0)
            // tbaleviewEditDetail.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
            
            // NSIndexPath(forRow: varSelectedTableRowIndex, inSection: 0)
            
            
            //tbaleviewEditDetail.beginUpdates()
            
            // tbaleviewEditDetail.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .[indexPath])
            
            //tbaleviewEditDetail.endUpdates()
            DispatchQueue.main.async(execute: { () -> Void in
                self.tbaleviewEditDetail.reloadData()
            })
            
            
            tbaleviewEditDetail.beginUpdates()
            tbaleviewEditDetail.reloadRows(at: [indexPath], with: .none)
            tbaleviewEditDetail.endUpdates()
            
            //reloadRows(at: [indexPath], with: [])
            //s(at: pMessagesTableView.indexPathsForVisibleRows!, with: .none)
            //tbaleviewEditDetail.reloadData()
            
            
        }
        else if(varISCountryCodeorCountryText=="countrycodefamilydetail")
        {
            
            let stringCountryMasterId =   objCalendarInfo.stringCountryMasterId
            //            let stringCountryMasterCode =   objCalendarInfo.stringCountryMasterCode
            //            let stringCountryMasterName =   objCalendarInfo.stringCountryMasterName
            //
            
            muarrayCountryId_FamilyDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varGetCountryId_FamilyDetail)
            tbaleviewEditDetail.reloadData()
            
            
            print("Hello........")
            
        }
        
        
    }
    
    
    //    func reloadRowsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation)
    //    {
    //       var sddsf=""
    //    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        pickerDOB.setStyle()
        // dispatch_async(dispatch_get_main_queue(), {self.scrollToBottom(false)})
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        buttonUpdate.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonUpdate.backgroundColor=UIColor.white //(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        let lbel = UILabel()
        lbel.frame = CGRect(x: 0, y: self.buttonUpdate.frame.size.height-52, width: self.view.frame.size.width, height: 1)
        lbel.backgroundColor =  UIColor.lightGray
        buttonUpdate.addSubview(lbel)
        
        //-----
        muarrayAddressType_AddressDetail_Table=NSMutableArray()
        muarrayAddress_AddressDetail_Table=NSMutableArray()
        muarrayCity_AddressDetail_Table=NSMutableArray()
        muarrayState_AddressDetail_Table=NSMutableArray()
        muarrayCountry_AddressDetail_Table=NSMutableArray()
        muarrayPincode_AddressDetail_Table=NSMutableArray()
        muarrayAddressID_AddressDetail_Table=NSMutableArray()
        //--
        muarrayName_FamilyDetail_Table=NSMutableArray()
        muarrayFamilyId_FamilyDetail_Table=NSMutableArray()
        
        
        
        muarrayEmailID_FamilyDetail_Table=NSMutableArray()
        muarrayCountryId_FamilyDetail_Table=NSMutableArray()
        muarrayContactNumber_FamilyDetail_Table=NSMutableArray()
        muarrayRelationsship_FamilyDetail_Table=NSMutableArray()
        muarrayDOB_FamilyDetail_Table=NSMutableArray()
        muarrayBloodGroup_FamilyDetail_Table=NSMutableArray()
        
        
        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table=NSMutableArray()
        
        
        
        viewRelationShip.isHidden=true
        
        
        
        
        
        
        
        pickerCountry.tag=1
        pickerBloodGroup.tag=2
        pickerDOB.tag=3
        muarrayBloodGroup=NSMutableArray()
        viewDOB.isHidden=true
        
        
        
        muarrayBloodGroup.add("O +")
        muarrayBloodGroup.add("O -")
        muarrayBloodGroup.add("A +")
        muarrayBloodGroup.add("B +")
        muarrayBloodGroup.add("B -")
        muarrayBloodGroup.add("A -")
        muarrayBloodGroup.add("AB +")
        muarrayBloodGroup.add("AB -")
        
        
        
        muarrayRelationShip=NSMutableArray()
        muarrayRelationShip.add("Father")
        muarrayRelationShip.add("Mother")
        muarrayRelationShip.add("Sister")
        muarrayRelationShip.add("Spouse")
        muarrayRelationShip.add("Brother")
        muarrayRelationShip.add("Friend")
        muarrayRelationShip.add("Son")
        muarrayRelationShip.add("Daughter")
        muarrayRelationShip.add("Son-in-law")
        muarrayRelationShip.add("Daughter-in-law")
        
        
        
        
        
        viewCountry.isHidden=true
        buttonOpacity.isHidden=true
        viewBloodGruoup.isHidden=true
        
        varCountryCode=""
        
        muarrayPersonalBusinessMemberDetails_FieldID_Table=NSMutableArray()
        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table=NSMutableArray()
        
        
        muarrayPersonalBusinessMemberDetails_Key_Table=NSMutableArray()
        muarrayPersonalBusinessMemberDetails_Value_Table=NSMutableArray()
        muarrayPersoanlBusinessorAddressorFamilyDetailorOther=NSMutableArray()
        functionForFetchOtherDetailsFromPersonalBusinessTables()
        createNavigationBar()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EditProfileDynamicNewViewControllerViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        tbaleviewEditDetail.addGestureRecognizer(tapGesture)
        
        
    }
    @IBAction func buttonSelectBloodGroupClickEvent(_ sender: AnyObject)
    {
        viewBloodGruoup.isHidden=true
        buttonOpacity.isHidden=true
        //        muarrayPersonalBusinessMemberDetails_Value_Table.replaceObjectAtIndex(varSelectedTableRowIndex, withObject: varBloodGroup)
        //
        //        tbaleviewEditDetail.reloadData()
        
        
        if(varGetIsBloodGroupPersoanlOrFamilyDetail=="personal")
        {
            // varBloodGroup = muarrayBloodGroup.objectAtIndex(row) as! String
            muarrayPersonalBusinessMemberDetails_Value_Table.replaceObject(at: varSelectedTableRowIndex, with: varBloodGroup)
            tbaleviewEditDetail.reloadData()
        }
        else if(varGetIsBloodGroupPersoanlOrFamilyDetail=="family")
        {
            // varBloodGroup = muarrayBloodGroup.objectAtIndex(row) as! String
            muarrayBloodGroup_FamilyDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varBloodGroup)
            tbaleviewEditDetail.reloadData()
            
            //  let indexPath = NSIndexPath(forRow: varSelectedTableRowIndex, inSection: 0)
            
            
            //tbaleviewEditDetail.beginUpdates()
            // tbaleviewEditDetail.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            // tbaleviewEditDetail.endUpdates()
            
            
            //  self.tbaleviewEditDetail.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
            
            
            
            
            // tableView.IndexPathsForVisibleRows, UITableViewRowAnimation.Automatic
        }
        
        
        
        
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Profile Edit"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(EditProfileDynamicNewViewControllerViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        
        //        let settingButton = UIButton(type: UIButton.ButtonType.custom)
        //        settingButton.frame = CGRectMake(0, 0, 100, 30)
        //        settingButton.addTarget(self, action: #selector(EditProfileDynamicNewViewControllerViewController.buttonUpdateClicked), forControlEvents: UIControlEvents.TouchUpInside)
        //        settingButton.titleLabel?.font = UIFont.boldSystemFontOfSize(22)
        //        settingButton.setTitle("Update", forState: .Normal)
        //       // settingButton.backgroundColor=UIColor.lightGrayColor()
        //        let setting: UIBarButtonItem = UIBarButtonItem(customView: settingButton)
        //        //let buttons : NSArray = [search, setting] //14 mar
        //        let buttons : NSArray = [setting]
        //        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        
        
        
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // return muarrayPersonalBusinessMemberDetails_Key_Table.count
        
        return muarrayBloodGroup_FamilyDetail_Table.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var iSpersonalbusiness:String! =  muarrayPersoanlBusinessorAddressorFamilyDetailorOther.object(at: indexPath.row)as! String
        // if(iSpersonalbusiness=="personalbusiness")
        //{
        return varRowHeightAddressDetail//Choose your custom row height
        //        }
        //        else  if(iSpersonalbusiness=="addressNew")
        //        {
        //            return 100.0;//Choose your custom row height
        //        }
        return 100
    }
    
    @IBAction func buttonSelectCountryID_FamilyAddressClicked(_ sender: AnyObject)
    {
        varSelectedTableRowIndex=sender.tag
        
        print(sender.tag)
        buttonOpacity.isHidden=false
        viewCountry.isHidden=false
        varISCountryCodeorCountryText="countrycodefamilydetail"
        cell.textFieldValue.resignFirstResponder()
        cell.textFieldCountryCode.resignFirstResponder()
        
        viewCountry.isHidden=false
        buttonOpacity.isHidden=false
        print(sender.tag)
        pickerBloodGroup.reloadAllComponents()
        hideKeyboard()
        
    }
    @IBAction func buttonSelectRealtionShip_FamilyAddressClicked(_ sender: AnyObject)
    {
        print(sender.tag)
        varSelectedTableRowIndex=sender.tag
        viewRelationShip.isHidden=false
        buttonOpacity.isHidden=false
    }
    @IBAction func buttonDOB_FamilyAddressClicked(_ sender: AnyObject)
    {
        varGetISDOBPersonalOrFamilyMember="familymember"
        print(sender.tag)
        hideKeyboard()
        viewDOB.isHidden=false
        buttonOpacity.isHidden=false
        varSelectedTableRowIndex=sender.tag
        
        
    }
    //buttonddNewFamilyMemebr_FamilyAddressClicked
    
    
    
    
    
    @IBAction func buttonBloodGroup_FamilyAddressClicked(_ sender: AnyObject)
    {
        varGetIsBloodGroupPersoanlOrFamilyDetail="family"
        
        print(sender.tag)
        hideKeyboard()
        viewBloodGruoup.isHidden=false
        buttonOpacity.isHidden=false
        varSelectedTableRowIndex=sender.tag
        
        
    }
    
    /*
     
     buttonOpacity.hidden=true
     viewDOB.hidden=true
     setDateAndTimeFull()
     */
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! EditProfileDynamicNewViewControllerViewControllerTableViewCell
        if(muarrayBloodGroup_FamilyDetail_Table.count>0)
        {
            let iSpersonalbusiness:String! =  muarrayPersoanlBusinessorAddressorFamilyDetailorOther.object(at: indexPath.row)as! String
            
            print(indexPath.row)
            print(iSpersonalbusiness)
            
            //1.
            //1..
            cell.buttonSelectCountry.addTarget(self, action: #selector(EditProfileDynamicNewViewControllerViewController.buttonSelectCountryClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonSelectCountry.tag=indexPath.row;
            //2.
            cell.buttonBloodGroup.addTarget(self, action: #selector(EditProfileDynamicNewViewControllerViewController.buttonBloodGroupClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonBloodGroup.tag=indexPath.row;
            //3.
            cell.buttonDOB.addTarget(self, action: #selector(EditProfileDynamicNewViewControllerViewController.buttonDOBClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonDOB.tag=indexPath.row;
            //4.
            cell.buttonAddressCountry.addTarget(self, action: #selector(EditProfileDynamicNewViewControllerViewController.buttonAddressCountryClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonAddressCountry.tag=indexPath.row;
            
            //5.
            cell.buttonSelectCountryID_FamilyAddress.addTarget(self, action: #selector(EditProfileDynamicNewViewControllerViewController.buttonSelectCountryID_FamilyAddressClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonSelectCountryID_FamilyAddress.tag=indexPath.row;
            //6.
            cell.buttonRelationship_FamilyAddress.addTarget(self, action: #selector(EditProfileDynamicNewViewControllerViewController.buttonSelectRealtionShip_FamilyAddressClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonRelationship_FamilyAddress.tag=indexPath.row;
            //7.
            cell.buttonDOB_FamilyAddress.addTarget(self, action: #selector(EditProfileDynamicNewViewControllerViewController.buttonDOB_FamilyAddressClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonDOB_FamilyAddress.tag=indexPath.row;
            //8.
            cell.buttonBloodGroup_FamilyAddress.addTarget(self, action: #selector(EditProfileDynamicNewViewControllerViewController.buttonBloodGroup_FamilyAddressClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonBloodGroup_FamilyAddress.tag=indexPath.row;
            //9.
            //buttonAddNewFamilyMemebr_FamilyDetail
            
            cell.buttonAddNewFamilyMemebr_FamilyDetail.addTarget(self, action: #selector(EditProfileDynamicNewViewControllerViewController.buttonddNewFamilyMemebr_FamilyAddressClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonAddNewFamilyMemebr_FamilyDetail.tag=indexPath.row;
            
            
            
            
            
            
            
            cell.viewFamilyMemberDetails.isHidden=true
            if(iSpersonalbusiness=="familydetail")
            {
                cell.viewFamilyMemberDetails.isHidden=false
                
                cell.viewFamilyMemberDetails.backgroundColor=UIColor.white
                
                
                muarrayFamilyId_FamilyDetail_Table.object(at: indexPath.row) as! String
                muarrayName_FamilyDetail_Table.object(at: indexPath.row) as! String
                muarrayEmailID_FamilyDetail_Table.object(at: indexPath.row) as! String
                muarrayCountryId_FamilyDetail_Table.object(at: indexPath.row) as! String
                muarrayContactNumber_FamilyDetail_Table.object(at: indexPath.row) as! String
                muarrayRelationsship_FamilyDetail_Table.object(at: indexPath.row) as! String
                muarrayDOB_FamilyDetail_Table.object(at: indexPath.row) as! String
                muarrayBloodGroup_FamilyDetail_Table.object(at: indexPath.row) as! String
                
                print(muarrayName_FamilyDetail_Table.object(at: indexPath.row) as! String)
                
                
                cell.textFieldName_FamilyDetail.text=muarrayName_FamilyDetail_Table.object(at: indexPath.row) as! String
                cell.textFieldEmailId_FamilyDetail.text=muarrayEmailID_FamilyDetail_Table.object(at: indexPath.row) as! String
                cell.textfieldCountryId_FamilyDetail.text=muarrayCountryId_FamilyDetail_Table.object(at: indexPath.row) as! String
                cell.textfieldMobileNumber_FamilyDetail.text=muarrayContactNumber_FamilyDetail_Table.object(at: indexPath.row) as! String
                cell.textfieldRelationship_FamilyDetail.text=muarrayRelationsship_FamilyDetail_Table.object(at: indexPath.row) as! String
                cell.textfieldDOB_FamilyDetail.text=muarrayDOB_FamilyDetail_Table.object(at: indexPath.row) as! String
                cell.textFieldBloodGroup_FamilyDetail.text=muarrayBloodGroup_FamilyDetail_Table.object(at: indexPath.row) as! String
                
                //1.
                let imageView = UIImageView(image: UIImage(named: "downArrowCalendar"))
                imageView.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
                cell.textfieldCountryId_FamilyDetail.rightViewMode = UITextField.ViewMode.always
                cell.textfieldCountryId_FamilyDetail.rightView = imageView
                //2.
                let imageView2 = UIImageView(image: UIImage(named: "downArrowCalendar"))
                imageView2.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
                cell.textfieldRelationship_FamilyDetail.rightViewMode = UITextField.ViewMode.always
                cell.textfieldRelationship_FamilyDetail.rightView = imageView2
                //3.
                let imageView3 = UIImageView(image: UIImage(named: "downArrowCalendar"))
                imageView3.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
                cell.textfieldDOB_FamilyDetail.rightViewMode = UITextField.ViewMode.always
                cell.textfieldDOB_FamilyDetail.rightView = imageView3
                //4.
                let imageView4 = UIImageView(image: UIImage(named: "downArrowCalendar"))
                imageView4.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
                cell.textFieldBloodGroup_FamilyDetail.rightViewMode = UITextField.ViewMode.always
                cell.textFieldBloodGroup_FamilyDetail.rightView = imageView4
                
                
                
                
                
                
                if(indexPath.row==varArrayCountAndMinusForAddingFamilyMember)
                {
                    cell.buttonAddNewFamilyMemebr_FamilyDetail.isHidden=false
                    varRowHeightAddressDetail=510.0
                }
                else
                {
                    cell.buttonAddNewFamilyMemebr_FamilyDetail.isHidden=true
                    varRowHeightAddressDetail=430.0
                }
            }
                
                
            else  if(iSpersonalbusiness=="personalbusiness")
            {
                cell.viewAddressDetail.isHidden=true
                varRowHeightAddressDetail=100.0
            }
            else
            {
                //cell.labelKey.hidden=true
                //cell.textFieldValue.hidden=true
                
                
                cell.viewAddressDetail.isHidden=false
                var varGetAddress = muarrayAddress_AddressDetail_Table.object(at: indexPath.row) as! String
                if(varGetAddress.characters.count>0)
                {
                    cell.labelPlaceHolder.isHidden=true
                }
                else
                {
                    cell.labelPlaceHolder.isHidden=false
                    
                }
                
                cell.textviewAddress.text=muarrayAddress_AddressDetail_Table.object(at: indexPath.row) as! String
                
                
                //for address underline
                //var attributedStringss:NSAttributedString=NSAttributedString()
                // attributedStringss=functionForSetColorInString(muarrayAddressType_AddressDetail_Table.objectAtIndex(indexPath.row) as! String)
                cell.labelAddressType.text=muarrayAddressType_AddressDetail_Table.object(at: indexPath.row) as! String
                
                
                
                
                
                cell.textfieldCity.text=muarrayCity_AddressDetail_Table.object(at: indexPath.row) as! String
                cell.textfieldPincode.text=muarrayPincode_AddressDetail_Table.object(at: indexPath.row) as! String
                cell.textfieldState.text=muarrayState_AddressDetail_Table.object(at: indexPath.row) as! String
                cell.textfieldCountry.text=muarrayCountry_AddressDetail_Table.object(at: indexPath.row) as! String
                cell.labelPlaceHolder.isHidden=true
                
                let imageView = UIImageView(image: UIImage(named: "downArrowCalendar"))
                imageView.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
                cell.textfieldAddressCountryDownArrow.rightViewMode = UITextField.ViewMode.always
                cell.textfieldAddressCountryDownArrow.rightView = imageView
                varRowHeightAddressDetail=280.0
                cell.viewAddressDetail.backgroundColor=UIColor.white
            }
            
            let varGetKey:String!=muarrayPersonalBusinessMemberDetails_Key_Table.object(at: indexPath.row) as! String
            let varGetValue:String!=muarrayPersonalBusinessMemberDetails_Value_Table.object(at: indexPath.row) as! String
            
            cell.labelKey.text=varGetKey
            cell.textFieldValue.text=varGetValue
            cell.textFieldCountryCode.isHidden=true
            cell.buttonSelectCountry.isHidden=true
            cell.buttonBloodGroup.isHidden=true
            cell.buttonDOB.isHidden=true
            cell.buttonDisableNameEmailMobile.isHidden=true
            cell.textfieldDownArrow.isHidden=true
            cell.textFieldValue.frame = CGRect(x: 7.0 ,y: 38.0,  width: cell.labelKey.frame.width+40,  height: cell.textFieldValue.frame.height)
            if(varGetKey=="Secondary Mobile Number")
            {
                cell.textFieldCountryCode.isHidden=false
                cell.buttonSelectCountry.isHidden=false
                cell.textFieldValue.frame = CGRect(x: 100.0, y: 38.0,  width: cell.labelKey.frame.width-55,  height: cell.textFieldValue.frame.height)
                cell.textFieldCountryCode.text=varGetCountryCode
                let imageView = UIImageView(image: UIImage(named: "downArrowCalendar"))
                imageView.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
                cell.textFieldCountryCode.rightViewMode = UITextField.ViewMode.always
                cell.textFieldCountryCode.rightView = imageView
                cell.textFieldValue.keyboardType = .numberPad
            }
            if(varGetKey=="Name" || varGetKey=="Mobile Number" || varGetKey=="Email ID" || varGetKey=="Salary" || varGetKey=="Student Roll No")
            {
                
                print(varGetKey)
                cell.textFieldValue.borderStyle = .line
                cell.buttonDisableNameEmailMobile.isHidden=false
            }
            if(varGetKey=="Blood Group")
            {
                cell.buttonBloodGroup.isHidden=false
                cell.textfieldDownArrow.isHidden=false
                cell.textfieldDownArrow.frame = CGRect(x: 7.0, y: 38.0,  width: cell.labelKey.frame.width+40,  height: cell.textfieldDownArrow.frame.height)
                
                let imageView = UIImageView(image: UIImage(named: "downArrowCalendar"))
                imageView.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
                cell.textfieldDownArrow.rightViewMode = UITextField.ViewMode.always
                cell.textfieldDownArrow.rightView = imageView
            }
            if(varGetKey=="Date of Birth" ||  varGetKey=="Date of Anniversary")
            {
                cell.buttonDOB.isHidden=false
                let imageView = UIImageView(image: UIImage(named: "downArrowCalendar"))
                imageView.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
                cell.textfieldDownArrow.rightViewMode = UITextField.ViewMode.always
                cell.textfieldDownArrow.rightView = imageView
                cell.textfieldDownArrow.isHidden=false
                cell.textfieldDownArrow.frame = CGRect(x: 7.0, y: 38.0,  width: cell.labelKey.frame.width+40,  height: cell.textfieldDownArrow.frame.height)
            }
            return cell
            
            print(indexPath.row)
            print(iSpersonalbusiness)
            
            
        }
        return cell
    }
    @IBAction func buttonAddressCountryClicked(_ sender: AnyObject)
    {
        varSelectedTableRowIndex=sender.tag
        
        varISCountryCodeorCountryText="countrytext"
        cell.textFieldValue.resignFirstResponder()
        cell.textFieldCountryCode.resignFirstResponder()
        
        viewCountry.isHidden=false
        buttonOpacity.isHidden=false
        print(sender.tag)
        hideKeyboard()
    }
    @IBAction func buttonDOBClicked(_ sender: AnyObject)
    {
        //varGetIsBloodGroupPersoanlOrFamilyDetail="personal"
        
        varGetISDOBPersonalOrFamilyMember="personal"
        
        
        hideKeyboard()
        viewDOB.isHidden=false
        buttonOpacity.isHidden=false
        varSelectedTableRowIndex=sender.tag
    }
    @IBAction func buttonBloodGroupClicked(_ sender: AnyObject)
    {
        varGetIsBloodGroupPersoanlOrFamilyDetail="personal"
        
        hideKeyboard()
        viewBloodGruoup.isHidden=false
        buttonOpacity.isHidden=false
        varSelectedTableRowIndex=sender.tag
        
    }
    @IBAction func buttonSelectCountryClicked(_ sender: AnyObject)
    {
        varISCountryCodeorCountryText="countrycode"
        cell.textFieldValue.resignFirstResponder()
        cell.textFieldCountryCode.resignFirstResponder()
        
        viewCountry.isHidden=false
        buttonOpacity.isHidden=false
        print(sender.tag)
        pickerBloodGroup.reloadAllComponents()
        hideKeyboard()
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        /*
         var pointInTable:CGPoint = textField.superview!.convertPoint(textField.frame.origin, toView:tbaleviewEditDetail)
         var contentOffset:CGPoint = tbaleviewEditDetail.contentOffset
         contentOffset.y  = pointInTable.y+100
         if let accessoryView = textField.inputAccessoryView {
         contentOffset.y = 100
         }
         tbaleviewEditDetail.contentOffset = contentOffset
         */
        
        
        print(textField.tag)
        varSelectedTableRowTextFieldTag=textField.tag
        
        let pointInTable = textField.convert(textField.bounds.origin, to: tbaleviewEditDetail)
        let indexPath = tbaleviewEditDetail.indexPathForRow(at: pointInTable)?.row
        print(indexPath)
        print(indexPath)
        print(indexPath)
        
        varSelectedTableRowIndex=Int(indexPath!)
        
        
        
        
        if(varSelectedTableRowTextFieldTag==111)
        {
            print(muarrayPersonalBusinessMemberDetails_Value_Table.object(at: varSelectedTableRowIndex))
            varSelectedTableRowIndexGet_Text=muarrayCity_AddressDetail_Table.object(at: varSelectedTableRowIndex) as! String
            
        }
        else   if(varSelectedTableRowTextFieldTag==222)
        {
            print(muarrayPersonalBusinessMemberDetails_Value_Table.object(at: varSelectedTableRowIndex))
            varSelectedTableRowIndexGet_Text=muarrayPincode_AddressDetail_Table.object(at: varSelectedTableRowIndex) as! String
            
        }
        else   if(varSelectedTableRowTextFieldTag==333)
        {
            print(muarrayPersonalBusinessMemberDetails_Value_Table.object(at: varSelectedTableRowIndex))
            varSelectedTableRowIndexGet_Text=muarrayState_AddressDetail_Table.object(at: varSelectedTableRowIndex) as! String
        }
        else   if(varSelectedTableRowTextFieldTag==444)
        {
            print(muarrayName_FamilyDetail_Table.object(at: varSelectedTableRowIndex))
            varSelectedTableRowIndexGet_Text=muarrayName_FamilyDetail_Table.object(at: varSelectedTableRowIndex) as! String
        }
        else   if(varSelectedTableRowTextFieldTag==555)
        {
            print(muarrayEmailID_FamilyDetail_Table.object(at: varSelectedTableRowIndex))
            varSelectedTableRowIndexGet_Text=muarrayEmailID_FamilyDetail_Table.object(at: varSelectedTableRowIndex) as! String
        }
        else   if(varSelectedTableRowTextFieldTag==666)
        {
            print(muarrayPersonalBusinessMemberDetails_Value_Table.object(at: varSelectedTableRowIndex))
            varSelectedTableRowIndexGet_Text=muarrayContactNumber_FamilyDetail_Table.object(at: varSelectedTableRowIndex) as! String
        }
        else
        {
            print(muarrayPersonalBusinessMemberDetails_Value_Table.object(at: varSelectedTableRowIndex))
            varSelectedTableRowIndexGet_Text=muarrayPersonalBusinessMemberDetails_Value_Table.object(at: varSelectedTableRowIndex) as! String
            
        }
        
        /*
         muarrayName_FamilyDetail_Table
         muarrayEmailID_FamilyDetail_Table
         muarrayContactNumber_FamilyDetail_Table
         */
        
        
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        //currentTextField = textField
        
        print(textField.tag)
        
        
        cell.textFieldValue.resignFirstResponder()
        cell.textFieldCountryCode.resignFirstResponder()
        
        
        // let pointInTable = sender.convertPoint(sender.bounds.origin, toView: tableviewLoadSubServices)
        // let indexPath = tableviewLoadSubServices.indexPathForRowAtPoint(pointInTable)?.row
        let pointInTable = textField.convert(textField.bounds.origin, to: tbaleviewEditDetail)
        let indexPath = tbaleviewEditDetail.indexPathForRow(at: pointInTable)?.row
        print(indexPath)
        print(indexPath)
        print(indexPath)
        
    }
    
    func textViewDidChange(_ textView: UITextView)
    { //Handle the text changes here
        print(textView.text); //the textView parameter is the textView where text was changed
        
        
        //        let pointInTable = textView.convertPoint(textView.bounds.origin, toView: tbaleviewEditDetail)
        //        let indexPath = tbaleviewEditDetail.indexPathForRowAtPoint(pointInTable)?.row
        //        print(indexPath)
        //        print(indexPath)
        //        print(indexPath)
        //        muarrayAddress_AddressDetail_Table.replaceObjectAtIndex(varSelectedTableRowIndex, withObject: varSelectedTableRowIndexGet_Text)
        //
        
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        let  char = text.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        
        if(text == "\n")
        {
            textView.resignFirstResponder()
            cell.textviewAddress.resignFirstResponder()
            return false
        }
            
        else  if (isBackSpace == -92)
        {
            print(varSelectedTableRowIndexGet_Text)
            print(varSelectedTableRowIndexGet_Text.characters.count)
            
            if(varSelectedTableRowIndexGet_Text.characters.count>0)
            {
                
                
                let varGetStringAfterRemove = varSelectedTableRowIndexGet_Text.substring(to: varSelectedTableRowIndexGet_Text.index(before: varSelectedTableRowIndexGet_Text.endIndex))
                print(varGetStringAfterRemove)
                varSelectedTableRowIndexGet_Text=varGetStringAfterRemove
                
                muarrayAddress_AddressDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varSelectedTableRowIndexGet_Text)
            }
            
        }
        else
        {
            let pointInTable = textView.convert(textView.bounds.origin, to: tbaleviewEditDetail)
            let indexPath = tbaleviewEditDetail.indexPathForRow(at: pointInTable)?.row
            print(indexPath)
            print(indexPath)
            print(indexPath)
            varSelectedTableRowIndexGet_Text=varSelectedTableRowIndexGet_Text+text
            muarrayAddress_AddressDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varSelectedTableRowIndexGet_Text)
            
        }
        
        
        
        return true
    }
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        let pointInTable = textView.convert(textView.bounds.origin, to: tbaleviewEditDetail)
        let indexPath = tbaleviewEditDetail.indexPathForRow(at: pointInTable)?.row
        print(indexPath)
        print(indexPath)
        print(indexPath)
        
        varSelectedTableRowIndex=Int(indexPath!)
        
        print(muarrayPersonalBusinessMemberDetails_Value_Table.object(at: varSelectedTableRowIndex))
        varSelectedTableRowIndexGet_Text=muarrayAddress_AddressDetail_Table.object(at: varSelectedTableRowIndex) as! String
        
        
        
    }
    
    func textField(_ textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool
    {
        //var textGetTextValue:String = cell.textFieldValue.text! as String
        
        //print(textGetTextValue)
        print("This is new value from the textfield for new !!!1")
        print(textField.tag)
        
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92)
        {
            print("Backspace was pressed")
            
            
            if(varSelectedTableRowTextFieldTag==111)
            {
                print(string)
                print(varSelectedTableRowIndexGet_Text)
                //  varSelectedTableRowIndexGet_Text=varSelectedTableRowIndexGet_Text+string
                let varGetStringAfterRemove = varSelectedTableRowIndexGet_Text.substring(to: varSelectedTableRowIndexGet_Text.index(before: varSelectedTableRowIndexGet_Text.endIndex))
                print(varGetStringAfterRemove)
                varSelectedTableRowIndexGet_Text=varGetStringAfterRemove
                muarrayCity_AddressDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varGetStringAfterRemove)
                
            }
            else   if(varSelectedTableRowTextFieldTag==222)
            {
                // varSelectedTableRowIndexGet_Text=varSelectedTableRowIndexGet_Text+string
                
                let varGetStringAfterRemove = varSelectedTableRowIndexGet_Text.substring(to: varSelectedTableRowIndexGet_Text.index(before: varSelectedTableRowIndexGet_Text.endIndex))
                varSelectedTableRowIndexGet_Text=varGetStringAfterRemove
                muarrayPincode_AddressDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varGetStringAfterRemove)
            }
            else   if(varSelectedTableRowTextFieldTag==333)
            {
                //varSelectedTableRowIndexGet_Text=varSelectedTableRowIndexGet_Text+string
                let varGetStringAfterRemove = varSelectedTableRowIndexGet_Text.substring(to: varSelectedTableRowIndexGet_Text.index(before: varSelectedTableRowIndexGet_Text.endIndex))
                varSelectedTableRowIndexGet_Text=varGetStringAfterRemove
                muarrayState_AddressDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varGetStringAfterRemove)
            }
                
                ////
            else   if(varSelectedTableRowTextFieldTag==444)
            {
                
                let varGetStringAfterRemove = varSelectedTableRowIndexGet_Text.substring(to: varSelectedTableRowIndexGet_Text.index(before: varSelectedTableRowIndexGet_Text.endIndex))
                varSelectedTableRowIndexGet_Text=varGetStringAfterRemove
                muarrayName_FamilyDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varGetStringAfterRemove)
                
                
            }
            else   if(varSelectedTableRowTextFieldTag==555)
            {
                
                let varGetStringAfterRemove = varSelectedTableRowIndexGet_Text.substring(to: varSelectedTableRowIndexGet_Text.index(before: varSelectedTableRowIndexGet_Text.endIndex))
                varSelectedTableRowIndexGet_Text=varGetStringAfterRemove
                muarrayEmailID_FamilyDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varGetStringAfterRemove)
                
                
                
                
            }
            else   if(varSelectedTableRowTextFieldTag==666)
            {
                
                
                let varGetStringAfterRemove = varSelectedTableRowIndexGet_Text.substring(to: varSelectedTableRowIndexGet_Text.index(before: varSelectedTableRowIndexGet_Text.endIndex))
                varSelectedTableRowIndexGet_Text=varGetStringAfterRemove
                muarrayContactNumber_FamilyDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varGetStringAfterRemove)
                
                
                
            }
                //////
                
                
                
                
                
            else
            {
                print(string)
                print(varSelectedTableRowIndex)
                //varSelectedTableRowIndexGet_Text=varSelectedTableRowIndexGet_Text+string
                let varGetStringAfterRemove = varSelectedTableRowIndexGet_Text.substring(to: varSelectedTableRowIndexGet_Text.index(before: varSelectedTableRowIndexGet_Text.endIndex))
                varSelectedTableRowIndexGet_Text=varGetStringAfterRemove
                muarrayPersonalBusinessMemberDetails_Value_Table.replaceObject(at: varSelectedTableRowIndex, with: varSelectedTableRowIndexGet_Text)
                print("Data:-"+varSelectedTableRowIndexGet_Text)
            }
            
        }
        else
        {
            print("Backspace was not  pressed")
            
            
            if(varSelectedTableRowTextFieldTag==111)
            {
                varSelectedTableRowIndexGet_Text=varSelectedTableRowIndexGet_Text+string
                muarrayCity_AddressDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varSelectedTableRowIndexGet_Text)
                
            }
            else   if(varSelectedTableRowTextFieldTag==222)
            {
                varSelectedTableRowIndexGet_Text=varSelectedTableRowIndexGet_Text+string
                muarrayPincode_AddressDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varSelectedTableRowIndexGet_Text)
            }
            else   if(varSelectedTableRowTextFieldTag==333)
            {
                varSelectedTableRowIndexGet_Text=varSelectedTableRowIndexGet_Text+string
                muarrayState_AddressDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varSelectedTableRowIndexGet_Text)
            }
            else   if(varSelectedTableRowTextFieldTag==444)
            {
                varSelectedTableRowIndexGet_Text=varSelectedTableRowIndexGet_Text+string
                muarrayName_FamilyDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varSelectedTableRowIndexGet_Text)
            }
            else   if(varSelectedTableRowTextFieldTag==555)
            {
                varSelectedTableRowIndexGet_Text=varSelectedTableRowIndexGet_Text+string
                muarrayEmailID_FamilyDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varSelectedTableRowIndexGet_Text)
            }
            else   if(varSelectedTableRowTextFieldTag==666)
            {
                varSelectedTableRowIndexGet_Text=varSelectedTableRowIndexGet_Text+string
                muarrayContactNumber_FamilyDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: varSelectedTableRowIndexGet_Text)
            }
            else
            {
                print(string)
                print(varSelectedTableRowIndex)
                varSelectedTableRowIndexGet_Text=varSelectedTableRowIndexGet_Text+string
                muarrayPersonalBusinessMemberDetails_Value_Table.replaceObject(at: varSelectedTableRowIndex, with: varSelectedTableRowIndexGet_Text)
                print("Data:-"+varSelectedTableRowIndexGet_Text)
            }
            
        }
        
        
        
        
        
        
        //tbaleviewEditDetail.reloadData()
        
        
        return true
    }
    
    
    //    func indexPathForCellContainingView(view: UIView, inTableView tableView:UITableView) -> NSIndexPath?
    //    {
    //        let viewCenterRelativeToTableview = tbaleviewEditDetail.convertPoint(CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds)), fromView:view)
    //
    //        print(viewCenterRelativeToTableview)
    //
    //        return tbaleviewEditDetail.indexPathForRowAtPoint(viewCenterRelativeToTableview)
    //
    //    }
    
    
    @objc func hideKeyboard() {
        cell.textFieldValue.resignFirstResponder()
        cell.textFieldCountryCode.resignFirstResponder()
        tbaleviewEditDetail.endEditing(true)
    }
    //--------------------------------
    //---select country
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        if(pickerView.tag==1)
        {
            return 1
        }
        if(pickerView.tag==2)
        {
            return 1
            
        }
        if(pickerView.tag==3)
        {
            return 1
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if(pickerView.tag==1)
        {
            return muarraySelectCountry.count;
        }
        if(pickerView.tag==2)
        {
            return muarrayBloodGroup.count;
        }
        if(pickerView.tag==3)
        {
            return muarrayRelationShip.count
        }
        return 0
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        if(pickerView.tag==1)
        {
            objCalendarInfo = muarraySelectCountry.object(at: row) as! CalendarInfo
            return objCalendarInfo.stringCountryMasterName
        }
        if(pickerView.tag==2)
        {
            let vraGetDayValue:String = muarrayBloodGroup.object(at: row) as! String
            return vraGetDayValue
        }
        if(pickerView.tag==3)
        {
            let vraGetDayValue:String = muarrayRelationShip.object(at: row) as! String
            return vraGetDayValue
            
            
            // viewRelationShip.hidden=false
            // buttonOpacity.hidden=false
        }
        return "0"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView.tag==1)
        {
            objCalendarInfo  = CalendarInfo()
            objCalendarInfo = muarraySelectCountry.object(at: row) as! CalendarInfo
            if(varISCountryCodeorCountryText=="countrycode")
            {
                let stringCountryMasterId =   objCalendarInfo.stringCountryMasterId
                let stringCountryMasterCode =   objCalendarInfo.stringCountryMasterCode
                let stringCountryMasterName =   objCalendarInfo.stringCountryMasterName
                
                varGetCountry=stringCountryMasterName
                varGetCountryID=stringCountryMasterId
                varGetCountryCode=stringCountryMasterCode
                
                print(stringCountryMasterId)
                print(stringCountryMasterCode)
                print(stringCountryMasterName)
                tbaleviewEditDetail.reloadData()
                
            }
            else if(varISCountryCodeorCountryText=="countrytext")
            {
                let stringCountryMasterId =   objCalendarInfo.stringCountryMasterId
                let stringCountryMasterCode =   objCalendarInfo.stringCountryMasterCode
                let stringCountryMasterName =   objCalendarInfo.stringCountryMasterName
                muarrayCountry_AddressDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: stringCountryMasterName)
                //tbaleviewEditDetail.reloadData()
            }
            else if(varISCountryCodeorCountryText=="countrycodefamilydetail")
            {
                //varISCountryCodeorCountryText countrycodefamilydetail
                
                
                //let stringCountryMasterId =   objCalendarInfo.stringCountryMasterId
                let stringCountryMasterCode =   objCalendarInfo.stringCountryMasterCode
                // let stringCountryMasterName =   objCalendarInfo.stringCountryMasterName
                
                //                varGetCountry=stringCountryMasterName
                //                varGetCountryID=stringCountryMasterId
                //                varGetCountryCode=stringCountryMasterCode
                //
                //                print(stringCountryMasterId)
                //                print(stringCountryMasterCode)
                //                print(stringCountryMasterName)
                //
                
                varGetCountryId_FamilyDetail=stringCountryMasterCode
            }
            
        }
        if(pickerView.tag==2)
        {
            if(varGetIsBloodGroupPersoanlOrFamilyDetail=="personal")
            {
                varBloodGroup = muarrayBloodGroup.object(at: row) as! String
                //muarrayPersonalBusinessMemberDetails_Value_Table.replaceObjectAtIndex(varSelectedTableRowIndex, withObject: varBloodGroup)
                //  tbaleviewEditDetail.reloadData()
            }
            else if(varGetIsBloodGroupPersoanlOrFamilyDetail=="family")
            {
                varBloodGroup = muarrayBloodGroup.object(at: row) as! String
                //muarrayPersonalBusinessMemberDetails_Value_Table.replaceObjectAtIndex(varSelectedTableRowIndex, withObject: varBloodGroup)
                //tbaleviewEditDetail.reloadData()
                //varGetRelationShipText
            }
            
            
        }
        if(pickerView.tag==3)
        {
            
            
            varGetRelationShipText = muarrayRelationShip.object(at: row) as! String
            // viewRelationShip.hidden=false
            // buttonOpacity.hidden=false
        }
    }
    
    //-------------------------------------
    
    @IBAction func buttonDOBClickEvent(_ sender: AnyObject)
    {
        buttonOpacity.isHidden=true
        viewDOB.isHidden=true
        setDateAndTimeFull()
    }
    
    
    
    func setDateAndTimeFull()
    {
        
        
        
        // muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
        //tableviewEventAnnivBirthDay.reloadData()
        pickerDOB.datePickerMode = UIDatePicker.Mode.date
        // dateTimePickerController.locale = NSLocale(localeIdentifier: "en_GB")
        // dateTimePickerController.minuteInterval = 15
        let date = Foundation.Date()
        // let currentDate: NSDate = NSDate()
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        currentdate = formatter.string(from: date)
        //full date and time show
        DateFormatter.dateStyle = Foundation.DateFormatter.Style.short
        dateTimeDisplay = DateFormatter.string(from: pickerDOB.date) + " " + timeFormatter.string(from: pickerDOB.date)
        print(dateTimeDisplay)
        print(currentdate)
        
        
        
        pickerDOB.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = Foundation.DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let selectedDate = dateFormatter.string(from: pickerDOB.date)
        dateTimeDisplay=selectedDate
        print(selectedDate)
        if(varGetISDOBPersonalOrFamilyMember=="personal")
        {
            muarrayPersonalBusinessMemberDetails_Value_Table.replaceObject(at: varSelectedTableRowIndex, with: selectedDate)
        }
        else if(varGetISDOBPersonalOrFamilyMember=="familymember")
        {
            muarrayDOB_FamilyDetail_Table.replaceObject(at: varSelectedTableRowIndex, with: selectedDate)
            
        }
        
        tbaleviewEditDetail.reloadData()
        buttonOpacity.isHidden=true
        viewDOB.isHidden=true
    }
    /*««««««««««««««««««««««««««««««««-----fetch personal detail---------------------------------------------------------»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»*/
    //MARK:- get user personal info from table:-PersonalBusinessMemberDetails
    
    func functionForAddDummyDataInArray()
    {
        muarrayAddressType_AddressDetail_Table.add("no")
        muarrayAddress_AddressDetail_Table.add("no")
        muarrayCity_AddressDetail_Table.add("no")
        muarrayState_AddressDetail_Table.add("no")
        muarrayCountry_AddressDetail_Table.add("no")
        muarrayPincode_AddressDetail_Table.add("no")
        muarrayAddressID_AddressDetail_Table.add("no")
        
        
        muarrayName_FamilyDetail_Table.add("no")
        muarrayFamilyId_FamilyDetail_Table.add("no")
        muarrayEmailID_FamilyDetail_Table.add("no")
        muarrayCountryId_FamilyDetail_Table.add("no")
        muarrayContactNumber_FamilyDetail_Table.add("no")
        muarrayRelationsship_FamilyDetail_Table.add("no")
        muarrayDOB_FamilyDetail_Table.add("no")
        muarrayBloodGroup_FamilyDetail_Table.add("no")
        
        
        print(muarrayPincode_AddressDetail_Table.count)
        print(muarrayPersonalBusinessMemberDetails_Key_Table.count)
        print(muarrayBloodGroup_FamilyDetail_Table.count)
        
        
    }
    
    func functionForFetchOtherDetailsFromPersonalBusinessTables()
    {
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        if (contactDB?.open())!
        {
            let querySQLPersonalBusinessMemberDetails = "SELECT uniquekey,value,fieldId,PersonalORBusiness from PersonalBusinessMemberDetails where  profileId="+profileId+" and isVisible='y'"
            print(querySQLPersonalBusinessMemberDetails)
            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
            //1.
            while resultsPersonalBusinessMemberDetails?.next() == true
            {
                let letGetUniqueKey:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "uniquekey")
                let letGetValue:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "value")
                let letGetFieldID:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "fieldId")
                let letGetPersonalORBusiness:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "PersonalORBusiness")
                
                let letGetValues = letGetValue.trimmingCharacters(in: CharacterSet.whitespaces)
                
                
                if(letGetUniqueKey=="member_name")
                {
                    if(letGetValues.characters.count>0)
                    {
                        muarrayPersonalBusinessMemberDetails_Key_Table.add("Name")
                        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("personalbusiness")
                        muarrayPersonalBusinessMemberDetails_FieldID_Table.add(letGetFieldID)
                        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add(letGetPersonalORBusiness)
                        
                        muarrayPersonalBusinessMemberDetails_Value_Table.add(letGetValues)
                        
                        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add(letGetUniqueKey)
                        functionForAddDummyDataInArray()
                    }
                }
                else if(letGetUniqueKey=="member_mobile_no")
                {
                    if(letGetValues.characters.count>0)
                    {
                        muarrayPersonalBusinessMemberDetails_Key_Table.add("Mobile Number")
                        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("personalbusiness")
                        muarrayPersonalBusinessMemberDetails_FieldID_Table.add(letGetFieldID)
                        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add(letGetPersonalORBusiness)
                        
                        muarrayPersonalBusinessMemberDetails_Value_Table.add(letGetValues)
                        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add(letGetUniqueKey)

                        functionForAddDummyDataInArray()
                        
                    }
                }
                else if(letGetUniqueKey=="secondry_mobile_no")
                {
                
                    if(letGetValues.characters.count>0)
                    {
                        muarrayPersonalBusinessMemberDetails_Key_Table.add("Secondary Mobile Number")
                        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("personalbusiness")
                        muarrayPersonalBusinessMemberDetails_FieldID_Table.add(letGetFieldID)
                        
                        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add(letGetPersonalORBusiness)
                        
                        
                        muarrayPersonalBusinessMemberDetails_Value_Table.add(letGetValues)
                        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add(letGetUniqueKey)

                        
                        functionForAddDummyDataInArray()
                        
                    }
                }
                else if(letGetUniqueKey=="member_email_id")
                {
                    if(letGetValues.characters.count>0)
                    {
                        muarrayPersonalBusinessMemberDetails_Key_Table.add("Email ID")
                        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("personalbusiness")
                        muarrayPersonalBusinessMemberDetails_FieldID_Table.add(letGetFieldID)
                        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add(letGetPersonalORBusiness)
                        
                        
                        
                        muarrayPersonalBusinessMemberDetails_Value_Table.add(letGetValues)
                        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add(letGetUniqueKey)

                        functionForAddDummyDataInArray()
                    }
                }
                else if(letGetUniqueKey=="member_date_of_birth")
                {
                    if(letGetValues.characters.count>0)
                    {
                        muarrayPersonalBusinessMemberDetails_Key_Table.add("Date of Birth")
                        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("personalbusiness")
                        
                        if(letGetValues.characters.count>2 )
                        {
                            
                            let inputFormatter = Foundation.DateFormatter()
                            inputFormatter.dateFormat = "dd/MM/yyyy"
                            let showDate = inputFormatter.date(from: letGetPersonalORBusiness)
                            inputFormatter.dateFormat = "dd MMM"
                            let resultString = inputFormatter.string(from: showDate!)
                            print(resultString)
                            muarrayPersonalBusinessMemberDetails_FieldID_Table.add(letGetFieldID)
                            
                            muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add(resultString)
                            
                            
                            
                        }
                        
                        
                        muarrayPersonalBusinessMemberDetails_Value_Table.add(letGetValues)
                        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add(letGetUniqueKey)

                        functionForAddDummyDataInArray()
                    }
                }
                else if(letGetUniqueKey=="member_date_of_wedding")
                {
                    if(letGetValues.characters.count>0)
                    {
                        muarrayPersonalBusinessMemberDetails_Key_Table.add("Date of Anniversary")
                        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("personalbusiness")
                        muarrayPersonalBusinessMemberDetails_FieldID_Table.add(letGetFieldID)
                        
                        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add(letGetPersonalORBusiness)
                        
                        
                        
                        muarrayPersonalBusinessMemberDetails_Value_Table.add(letGetValues)
                        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add(letGetUniqueKey)

                        functionForAddDummyDataInArray()
                    }
                }
                else if(letGetUniqueKey=="blood_Group")
                {
                    if(letGetValues.characters.count>0)
                    {
                        muarrayPersonalBusinessMemberDetails_Key_Table.add("Blood Group")
                        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("personalbusiness")
                        muarrayPersonalBusinessMemberDetails_FieldID_Table.add(letGetFieldID)
                        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add(letGetPersonalORBusiness)
                        
                        
                        
                        
                        muarrayPersonalBusinessMemberDetails_Value_Table.add(letGetValues)
                        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add(letGetUniqueKey)

                        functionForAddDummyDataInArray()
                        
                    }
                }
                else if(letGetUniqueKey=="Passport Number")
                {
                    if(letGetValues.characters.count>0)
                    {
                        muarrayPersonalBusinessMemberDetails_Key_Table.add("Passport Number")
                        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("personalbusiness")
                        muarrayPersonalBusinessMemberDetails_FieldID_Table.add(letGetFieldID)
                        
                        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add(letGetPersonalORBusiness)
                        
                        
                        
                        muarrayPersonalBusinessMemberDetails_Value_Table.add(letGetValues)
                        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add(letGetUniqueKey)

                        functionForAddDummyDataInArray()
                        
                        
                    }
                }
                else if(letGetUniqueKey=="BranchName")
                {
                    if(letGetValues.characters.count>0)
                    {
                        muarrayPersonalBusinessMemberDetails_Key_Table.add("Branch Name")
                        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("personalbusiness")
                        muarrayPersonalBusinessMemberDetails_FieldID_Table.add(letGetFieldID)
                        
                        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add(letGetPersonalORBusiness)
                        
                        
                        
                        muarrayPersonalBusinessMemberDetails_Value_Table.add(letGetValues)
                        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add(letGetUniqueKey)

                        functionForAddDummyDataInArray()
                        
                    }
                }
                else if(letGetUniqueKey=="Salary")
                {
                    if(letGetValues.characters.count>0)
                    {
                        muarrayPersonalBusinessMemberDetails_Key_Table.add("Salary")
                        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("personalbusiness")
                        muarrayPersonalBusinessMemberDetails_FieldID_Table.add(letGetFieldID)
                        
                        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add(letGetPersonalORBusiness)
                        
                        
                        
                        
                        muarrayPersonalBusinessMemberDetails_Value_Table.add(letGetValues)
                        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add(letGetUniqueKey)

                        functionForAddDummyDataInArray()
                        
                    }
                }
                else if(letGetUniqueKey=="Student Roll No")
                {
                    if(letGetValues.characters.count>0)
                    {
                        muarrayPersonalBusinessMemberDetails_Key_Table.add("Student Roll No")
                        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("personalbusiness")
                        muarrayPersonalBusinessMemberDetails_FieldID_Table.add(letGetFieldID)
                        
                        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add(letGetPersonalORBusiness)
                        
                        
                        
                        muarrayPersonalBusinessMemberDetails_Value_Table.add(letGetValues)
                        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add(letGetUniqueKey)

                        functionForAddDummyDataInArray()
                        
                        
                    }
                }
                else if(letGetUniqueKey=="member_buss_email")
                {
                    if(letGetValues.characters.count>0)
                    {
                        muarrayPersonalBusinessMemberDetails_Key_Table.add("Business Email ID")
                        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("personalbusiness")
                        muarrayPersonalBusinessMemberDetails_FieldID_Table.add(letGetFieldID)
                        
                        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add(letGetPersonalORBusiness)
                        
                        
                        
                        muarrayPersonalBusinessMemberDetails_Value_Table.add(letGetValues)
                        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add(letGetUniqueKey)

                        
                        functionForAddDummyDataInArray()
                    }
                }
                else if(letGetUniqueKey=="designation")
                {
                    if(letGetValues.characters.count>0)
                    {
                        muarrayPersonalBusinessMemberDetails_Key_Table.add("Designation")
                        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("personalbusiness")
                        muarrayPersonalBusinessMemberDetails_FieldID_Table.add(letGetFieldID)
                        
                        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add(letGetPersonalORBusiness)
                        
                        
                        
                        muarrayPersonalBusinessMemberDetails_Value_Table.add(letGetValues)
                        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add(letGetUniqueKey)

                        functionForAddDummyDataInArray()
                        
                    }
                }
                else if(letGetUniqueKey=="BusinessName")
                {
                    if(letGetValues.characters.count>0)
                    {
                        muarrayPersonalBusinessMemberDetails_Key_Table.add("Business Name")
                        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("personalbusiness")
                        muarrayPersonalBusinessMemberDetails_FieldID_Table.add(letGetFieldID)
                        
                        
                        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add(letGetPersonalORBusiness)
                        
                        
                        muarrayPersonalBusinessMemberDetails_Value_Table.add(letGetValues)
                        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add(letGetUniqueKey)

                        functionForAddDummyDataInArray()
                    }
                }
                /**Dummy data insert in mutable array*/
                
                
                
                
            }
        }
        // tbaleviewEditDetail.reloadData()
        print(muarrayPincode_AddressDetail_Table.count)
        print(muarrayPersonalBusinessMemberDetails_Key_Table.count)
        print(muarrayBloodGroup_FamilyDetail_Table.count)
        
        functionForFetchBusinessandPersonalAddressDetailAddressDetailTables()
        print(muarrayPincode_AddressDetail_Table.count)
        print(muarrayPersonalBusinessMemberDetails_Key_Table.count)
        print(muarrayBloodGroup_FamilyDetail_Table.count)
        
    }
    
    func functionForAddDummyDataInArraySecond()
    {
        muarrayPersonalBusinessMemberDetails_Key_Table.add("no")
        muarrayPersonalBusinessMemberDetails_Value_Table.add("no")
        muarrayPersonalBusinessMemberDetails_FieldID_Table.add("no")
        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add("no")
        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add("no")
        
        
        
        
        
        
        
        
        muarrayFamilyId_FamilyDetail_Table.add("no")
        muarrayName_FamilyDetail_Table.add("no")
        muarrayEmailID_FamilyDetail_Table.add("no")
        muarrayCountryId_FamilyDetail_Table.add("no")
        muarrayContactNumber_FamilyDetail_Table.add("no")
        muarrayRelationsship_FamilyDetail_Table.add("no")
        muarrayDOB_FamilyDetail_Table.add("no")
        muarrayBloodGroup_FamilyDetail_Table.add("no")
        
        
    }
    
    
    
    /*««««««««««««««««««««««««««««««««-------fetch address detail -------------------------------------------------------»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»*/
    func functionForFetchBusinessandPersonalAddressDetailAddressDetailTables()
    {
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        if (contactDB?.open())!
        {
            let querySQLPersonalBusinessMemberDetails = "select addressID,addressType,address,city,state,country,pincode from AddressDetails where  profileId="+profileId+" and isBusinessAddrVisible='y' and isResidanceAddrVisible='y'"
            
            
            print(querySQLPersonalBusinessMemberDetails)
            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
            //1.
            while resultsPersonalBusinessMemberDetails?.next() == true
            {
                let addressType:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "addressType")
                let address:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "address")
                let city:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "city")
                let state:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "state")
                let country:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "country")
                let pincode:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "pincode")
                
                let addressID:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "addressID")
                
                
                muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("address")
                muarrayAddressType_AddressDetail_Table.add(addressType)
                muarrayAddress_AddressDetail_Table.add(address)
                muarrayCity_AddressDetail_Table.add(city)
                muarrayState_AddressDetail_Table.add(state)
                muarrayCountry_AddressDetail_Table.add(country)
                muarrayPincode_AddressDetail_Table.add(pincode)
                
                muarrayAddressID_AddressDetail_Table.add(addressID)
                
                
                
                functionForAddDummyDataInArraySecond()
                //muarrayPersonalBusinessMemberDetails_Key_Table.addObject("no")
                //  muarrayPersonalBusinessMemberDetails_Value_Table.addObject("no")
            }
        }
        print(muarrayPincode_AddressDetail_Table.count)
        print(muarrayPersonalBusinessMemberDetails_Key_Table.count)
        print(muarrayBloodGroup_FamilyDetail_Table.count)
        
        functionForFetchFamilyDetailTables()
        
    }
    
    
    func functionForAddDummyDataInArrayThird()
    {
        muarrayPersonalBusinessMemberDetails_Key_Table.add("no")
        muarrayPersonalBusinessMemberDetails_Value_Table.add("no")
        muarrayPersonalBusinessMemberDetails_FieldID_Table.add("no")
       
        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add("no")
        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add("no")

        
        
        
        muarrayAddressType_AddressDetail_Table.add("no")
        muarrayAddress_AddressDetail_Table.add("no")
        muarrayCity_AddressDetail_Table.add("no")
        muarrayState_AddressDetail_Table.add("no")
        muarrayCountry_AddressDetail_Table.add("no")
        muarrayPincode_AddressDetail_Table.add("no")
        muarrayAddressID_AddressDetail_Table.add("no")
        
        
    }
    
    
    
    
    
    /*««««««««««««««««««««««««««««««««-------fetch address detail -------------------------------------------------------»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»*/
    func functionForFetchFamilyDetailTables()
    {
        
        print(muarrayPincode_AddressDetail_Table.count)
        print(muarrayPersonalBusinessMemberDetails_Key_Table.count)
        print(muarrayBloodGroup_FamilyDetail_Table.count)
        
        
        
        
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        if (contactDB?.open())!
        {
            
            
            
            let querySQLPersonalBusinessMemberDetails="select familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,bloodGroup from FamilyMemberDetail where  profileId="+profileId+" and isVisible='y'"
            
            
            print(querySQLPersonalBusinessMemberDetails)
            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
            //1.
            while resultsPersonalBusinessMemberDetails?.next() == true
            {
                let familyMemberId:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "familyMemberId")
                let memberName:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "memberName")
                let relationship:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "relationship")
                let dob:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "dob")
                let emailID:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "emailID")
                let anniversary:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "anniversary")
                let contactNo:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "contactNo")
                let bloodGroup:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "bloodGroup")
                
                
                //muarrayCountryId_FamilyDetail_Table
                
                
                muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("familydetail")
                muarrayFamilyId_FamilyDetail_Table.add(familyMemberId)
                muarrayName_FamilyDetail_Table.add(memberName)
                muarrayEmailID_FamilyDetail_Table.add(emailID)
                
                //contactNo
                if(contactNo.hasPrefix("+"))
                {
                    var varGeteprateDate=contactNo.components(separatedBy: " ")
                    print(contactNo)
                    print(varGeteprateDate[0])
                    print(varGeteprateDate[1])
                    
                    
                    
                    let  varGetCountryId=(varGeteprateDate[0])
                    let  varGetCotactNumber=(varGeteprateDate[1])
                    muarrayCountryId_FamilyDetail_Table.add(varGetCountryId)
                    muarrayContactNumber_FamilyDetail_Table.add(varGetCotactNumber)
                }
                else
                {
                    muarrayCountryId_FamilyDetail_Table.add("")
                    
                    muarrayContactNumber_FamilyDetail_Table.add(contactNo)
                }
                
                
                
                muarrayRelationsship_FamilyDetail_Table.add(relationship)
                muarrayDOB_FamilyDetail_Table.add(dob)
                muarrayBloodGroup_FamilyDetail_Table.add(bloodGroup)
                
                
                
                
                
                
                
                functionForAddDummyDataInArrayThird()
                //muarrayPersonalBusinessMemberDetails_Key_Table.addObject("no")
                //  muarrayPersonalBusinessMemberDetails_Value_Table.addObject("no")
            }
        }
        
        print(muarrayPincode_AddressDetail_Table.count)
        print(muarrayPersonalBusinessMemberDetails_Key_Table.count)
        print(muarrayBloodGroup_FamilyDetail_Table.count)
        varArrayCountAndMinusForAddingFamilyMember=(muarrayBloodGroup_FamilyDetail_Table.count)-1
        tbaleviewEditDetail.reloadData()
        /*
         print(muarrayPincode_AddressDetail_Table.count)
         print(muarrayPersonalBusinessMemberDetails_Key_Table.count)
         tbaleviewEditDetail.reloadData()
         */
    }
    
    
    
    
    
    
    /*---underline address label---*/
    func functionForSetColorInString(_ stringValue:String)->NSAttributedString
    {
        let text = "I agree with TERMS and CONDITION"
        let linkTextWithColor = "CONDITION"
        
        let range = (text as NSString).range(of: linkTextWithColor)
        
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        var attributedStringss:NSAttributedString=NSAttributedString()
        let htmlStringss = "  <font size=\"10\"><span style=\"font-family: Roboto-Bold;\"><font color=\"#000000\"><u>"+stringValue+"</u></font> </span> </font>"
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
           let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
            
            // labelIAgreeWith.attributedText=attributedStringss;
        } catch _ {
            print("Cannot create attributed String")
        }
        print(attributedStringss)
        return attributedStringss
    }
    //----------------------------------------------------------------
    
    
    
    @IBAction func buttonddNewFamilyMemebr_FamilyAddressClicked(_ sender: AnyObject)
    {
        
        muarrayPersonalBusinessMemberDetails_Key_Table.add("0")
        muarrayPersonalBusinessMemberDetails_Value_Table.add("0")
        muarrayPersonalBusinessMemberDetails_FieldID_Table.add("0")
        muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.add("no")
        muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.add("no")

        
        
        muarrayAddressType_AddressDetail_Table.add("0")
        muarrayAddress_AddressDetail_Table.add("0")
        muarrayCity_AddressDetail_Table.add("0")
        muarrayState_AddressDetail_Table.add("0")
        muarrayCountry_AddressDetail_Table.add("0")
        muarrayPincode_AddressDetail_Table.add("0")
        muarrayAddressID_AddressDetail_Table.add("0")
        
        
        
        
        muarrayFamilyId_FamilyDetail_Table.add("")
        muarrayName_FamilyDetail_Table.add("")
        muarrayEmailID_FamilyDetail_Table.add("")
        muarrayCountryId_FamilyDetail_Table.add("")
        muarrayContactNumber_FamilyDetail_Table.add("")
        muarrayRelationsship_FamilyDetail_Table.add("")
        muarrayDOB_FamilyDetail_Table.add("")
        muarrayBloodGroup_FamilyDetail_Table.add("")
        
        
        muarrayPersoanlBusinessorAddressorFamilyDetailorOther.add("familydetail")
        
        
        varArrayCountAndMinusForAddingFamilyMember=(muarrayBloodGroup_FamilyDetail_Table.count)-1
        
        
        tbaleviewEditDetail.reloadData()
        
        // To get the animation working as expected, we need to 'reset' the table
        // view's current offset. Otherwise it gets confused when it starts the animation.
        let oldLastCellIndexPath = IndexPath(row: muarrayCity_AddressDetail_Table.count-2, section: 0)
        self.tbaleviewEditDetail.scrollToRow(at: oldLastCellIndexPath, at: .bottom, animated: false)
        
        // Animate on the next pass through the runloop.
        DispatchQueue.main.async(execute: {
            self.scrollToBottom(true,intSend: 1)
        })
        
        
        
        
        
        // tbaleviewEditDetail.reloadData()
        
        
        
        
        // let bottomOffset = CGPoint(x: 0, y: tbaleviewEditDetail.contentSize.height - tbaleviewEditDetail.bounds.size.height)
        //tbaleviewEditDetail.setContentOffset(bottomOffset, animated: true)
        
        
        
        
        /* success code
         tbaleviewEditDetail.reloadData()
         dispatch_async(dispatch_get_main_queue(), { () -> Void in
         let indexPath = NSIndexPath(forRow: self.muarrayBloodGroup_FamilyDetail_Table.count-1, inSection: 0)
         self.tbaleviewEditDetail.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
         
         })
         */
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //tbaleviewEditDetail.reloadData()
        
        
        //  DispatchQueue.global(qos: .background).async {
        // let indexPath = IndexPath(row: self.varArrayCountAndMinusForAddingFamilyMember.count-1, section: 0)
        //  self.tbaleviewEditDetail.scrollToRow(at: indexPath, at: .bottom, animated: true)
        // }
        
        
        
        
        
        
        //
        //        // First figure out how many sections there are
        //        let lastSectionIndex = self.tbaleviewEditDetail!.numberOfSections - 1
        //
        //        // Then grab the number of rows in the last section
        //        let lastRowIndex = self.tbaleviewEditDetail!.numberOfRowsInSection(lastSectionIndex) - 1
        //
        //        // Now just construct the index path
        //        let pathToLastRow = NSIndexPath(forRow: lastRowIndex, inSection: lastSectionIndex)
        //
        //        // Make the last row visible
        //        self.tbaleviewEditDetail?.scrollToRowAtIndexPath(pathToLastRow, atScrollPosition: UITableViewScrollPosition.None, animated: true)
        //
        //
        
        
        // self.tbaleviewEditDetail.contentOffset = CGPointMake(0, 0 - self.tbaleviewEditDetail.contentInset.bottom);
        
        //tbaleviewEditDetail.setContentOffset(CGPointZero, animated:true)
        // self.tbaleviewEditDetail.contentOffset = CGPointMake(0, 0 - self.tbaleviewEditDetail.contentInset.bottom)
        
        
        print("Add new member:--------------------------------------------------------")
    }
    
    // willDisplay
    //      func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    //    {
    //        let lastRowIndex = tbaleviewEditDetail.numberOfRowsInSection(0)
    //        if indexPath.row == lastRowIndex - 1
    //        {
    //            fetchNewDataFromServer()
    //        }
    //    } // data fetcher function
    //    func fetchNewDataFromServer()
    //    {
    //
    //            tbaleviewEditDetail.beginUpdates() // for loop //
    //            tbaleviewEditDetail.endUpdates()
    //
    //    }
    //
    //|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||/
    @IBAction func buttonUpdateClickEvent(_ sender: AnyObject)
    {
        functionForGettingDataFromArray()
    }
    func functionForGettingDataFromArray()
    {
        //----get value from array
        //1.personalBusiness table
        //
        //        var dict = [String: AnyObject]()
        //        print(dict)
        //        dict=["FirstName":"first","LastName":"last","Phone":"phone"]
        //        print(dict)
        //
        //        dict["Language"] = ["langage1", "langage2"]
        //        print(dict)
        //
        //        if var languages = dict["Language"] as? [String]
        //        {
        //            languages.append("langage3")
        //            dict["Language"] = languages
        //        }
        //
        //
        //        print(dict)
        //        print(dict)
        //
        //
        //
        var dictAddArray = [String: String]()
        var muarraybusinessMemberDetails:NSMutableArray=NSMutableArray()
        var muarraybusinessDynamicFields:NSMutableArray=NSMutableArray()
        var muarrayPersonalMemberDetails:NSMutableArray=NSMutableArray()
        var dictPersonalInfoArray = [String: AnyObject]()
        for i in 00..<muarrayPersoanlBusinessorAddressorFamilyDetailorOther.count
        {
            let varCheckFornoWordForExitLoop=muarrayPersonalBusinessMemberDetails_Key_Table.object(at: i)
            if(varCheckFornoWordForExitLoop as! String=="no")
            {
                break
            }
            else
            {
                var varGetKey=muarrayPersonalBusinessMemberDetails_Key_Table.object(at: i) as! String
                var varGetValue=muarrayPersonalBusinessMemberDetails_Value_Table.object(at: i) as! String
                var varGetFieldId=muarrayPersonalBusinessMemberDetails_FieldID_Table.object(at: i) as! String
               
                var varGetOriginalUnique_Key_Column_Name=muarrayPersonalBusinessMemberDetails_UniqueKeyName_Table.object(at: i) as! String
                
                var varGetISPersonalORBusiness=muarrayPersonalBusinessMemberDetails_PersonalORBusiness_Table.object(at: i) as! String
                
                //business
                if(varGetFieldId=="0" && varGetISPersonalORBusiness=="Business")
                {
                    
                    //member_buss_email designation  BusinessName
                    
                    
                    /*
                     "uniquekey" : "Business Email ID"
                     },
                     {
                     "value" : "Tester",
                     "fieldID" : "0",
                     "uniquekey" : "Designation"
                     },
                     {
                     "value" : "Gala complex, Mulund West",
                     "fieldID" : "0",
                     "uniquekey" : "Business Name"
                     */
                    
                    //"uniquekey": "member_buss_email"
               
                   // "uniquekey": "BusinessName"
               
                   // "uniquekey": "designation"
                    
                    if(varGetKey=="Business Email ID")
                    {
                       varGetKey="member_buss_email"
                    }
                    else  if(varGetKey=="Designation")
                    {
                       varGetKey="designation"
                    }
                    if(varGetKey=="Business Name")
                    {
                       varGetKey="BusinessName"
                    }
                    
                    
                    
                    
                    dictAddArray=["value":varGetValue,"fieldID":varGetFieldId,"uniquekey":varGetKey]
                    muarraybusinessMemberDetails.add(dictAddArray)
                }
                    //dynamic field
                else if(varGetFieldId != "0" && varGetISPersonalORBusiness != "Business")
                {
                    if(varGetKey=="Passport Number")
                    {
                       varGetKey="Passport Number"
                    }
                    else  if(varGetKey=="Branch Name")
                    {
                       varGetKey="BranchName"
                    }
                    else  if(varGetKey=="Salary")
                    {
                       varGetKey="Salary"
                    }
                    else  if(varGetKey=="Student Roll No")
                    {
                      varGetKey="Student Roll No"
                    }
                    
                    
                    
                    dictAddArray=["value":varGetValue,"fieldID":varGetFieldId,"uniquekey":varGetKey]
                    muarraybusinessDynamicFields.add(dictAddArray)
                }
                    //personal
                else if(varGetFieldId == "0" && varGetISPersonalORBusiness == "personal")
                {
                    dictAddArray=["value":varGetValue,"fieldID":varGetFieldId,"uniquekey":varGetKey]
                    muarrayPersonalMemberDetails.add(dictAddArray)
                }
                
                /*
                 
                 "bloodGroup": "AB +ve",
                 "memberName": "Anirudh Acharya",
                 "memberDOB": "1991/02/22",
                 "memberDOA": "2017/04/23",
                 "secondaryMobileNo": "+91 8585252566",
                 "profilePic": "",
                 "memberEmail": "anirudh.a@kaizeninfotech.com"
                 
                 */
                
                
                
            }
        }
        print(muarraybusinessMemberDetails)
        print(muarraybusinessDynamicFields)
        print(muarrayPersonalMemberDetails)
        
        
        //here need to extract value for personal details
        for i in 00..<muarrayPersonalMemberDetails.count
        {
            var letGetKeyOne=((muarrayPersonalMemberDetails.object(at: i) as AnyObject).object(forKey: "uniquekey"))as! String
            var letGetValueOne=((muarrayPersonalMemberDetails.object(at: i) as AnyObject).object(forKey: "value"))as! String
            
            /*
             "bloodGroup": "AB +ve",
             "memberName": "Anirudh Acharya",
             "memberDOB": "1991/02/22",
             "memberDOA": "2017/04/23",
             "secondaryMobileNo": "+91 8585252566",
             "profilePic": "",
             "memberEmail": "anirudh.a@kaizeninfotech.com"
             
             "Email ID" : "reva@gmail.com",
             "Mobile Number" : "+91 8828389618",
             "Name" : "Reva Pundkar",
             "Date of Birth" : "22\/01\/2010",
             "Blood Group" : "- Select -"
             
             */
            if(letGetKeyOne=="Email ID")
            {
                letGetKeyOne="memberEmail"
            }
            else if(letGetKeyOne=="Mobile Number")
            {
                letGetKeyOne="secondaryMobileNo"
            }
            else if(letGetKeyOne=="Name")
            {
                letGetKeyOne="memberName"
            }
            else if(letGetKeyOne=="Date of Birth")
            {
                letGetKeyOne="memberDOB"
                if(letGetValueOne.characters.count>0)
                {
                    if(letGetValueOne.characters.count>0)
                    {
                    var varGetValue=letGetValueOne.components(separatedBy: "/")
                        letGetValueOne=varGetValue[2]+"/"+varGetValue[1]+"/"+varGetValue[0]
                    }
                    
                }
            }
            else if(letGetKeyOne=="Blood Group")
            {
                letGetKeyOne="bloodGroup"
            }
            
            
            
            
            
            dictPersonalInfoArray.updateValue(letGetValueOne as AnyObject, forKey: letGetKeyOne)
        }
        
        print(muarraybusinessMemberDetails)
        print(muarraybusinessDynamicFields)
        print(dictPersonalInfoArray)
        
        
        
        
        
        
        //2.address table WWWWWWWWWWOOOOOOORRRRRKKKKKKKKKKKIIIIIIIIIIGGGGGGGGGGGGGGGGGGGGG
        var muarrayAddressDetails:NSMutableArray=NSMutableArray()
        var dictaddressArray = [String: AnyObject]()
        for j in 00..<muarrayAddressID_AddressDetail_Table.count
        {
            let varCheckFornoWordForExitLoop=muarrayAddressID_AddressDetail_Table.object(at: j)
            if(varCheckFornoWordForExitLoop as! String=="no")
            {
                //break
            }
            else
            {
                var  addressType=(muarrayAddressType_AddressDetail_Table.object(at: j))
                var address=(muarrayAddress_AddressDetail_Table.object(at: j))
                var city=(muarrayCity_AddressDetail_Table.object(at: j))
                var state=(muarrayState_AddressDetail_Table.object(at: j))
               
                var country=(muarrayCountry_AddressDetail_Table.object(at: j))
                //code by Rajendra Jat here need to get country id
                country=functionForSelectCountry(country as! String)
                
                print(country)
                
                var pincode=(muarrayPincode_AddressDetail_Table.object(at: j))
                var addressID=(muarrayAddressID_AddressDetail_Table.object(at: j))
                
                var fax="123456789"
                var phoneNo="9876543210"
                var profileIds=profileId
                
                
                dictaddressArray=["address":address as AnyObject,"addressID":addressID as AnyObject,"addressType":addressType as AnyObject,"city":city as AnyObject,"country":country as AnyObject,"fax":fax as AnyObject,"phoneNo":phoneNo as AnyObject,"pincode":pincode as AnyObject,"profileID":profileIds as AnyObject,"state":state as AnyObject]
                muarrayAddressDetails.add(dictaddressArray)
            }
        }
        //3.family detail table
        
        var muarrayFamilyDetails:NSMutableArray=NSMutableArray()
        var dictFamilyDetailrray = [String: AnyObject]()
        for j in 00..<muarrayFamilyId_FamilyDetail_Table.count
        {
            let varCheckFornoWordForExitLoop=muarrayFamilyId_FamilyDetail_Table.object(at: j)
            if(varCheckFornoWordForExitLoop as! String=="no")
            {
                //break
            }
            else
            {
                var familyMemberId=(muarrayFamilyId_FamilyDetail_Table.object(at: j))
                var memberName=(muarrayName_FamilyDetail_Table.object(at: j))
                var emailID=(muarrayEmailID_FamilyDetail_Table.object(at: j))
                // print(muarrayCountryId_FamilyDetail_Table.objectAtIndex(j))
                // print(muarrayContactNumber_FamilyDetail_Table.objectAtIndex(j))
                
                var contactNo=((muarrayCountryId_FamilyDetail_Table.object(at: j)) as! String)+" "+((muarrayContactNumber_FamilyDetail_Table.object(at: j)) as! String)
                
                
                var relationship=(muarrayRelationsship_FamilyDetail_Table.object(at: j))
                var memberDOB=(muarrayDOB_FamilyDetail_Table.object(at: j))as! String
                if(memberDOB != "")
                {
                    var varGetValue=memberDOB.components(separatedBy: "/")
                    memberDOB=varGetValue[2]+"/"+varGetValue[1]+"/"+varGetValue[0]
                    
                }
                
                
                
                var bloodGroup=(muarrayBloodGroup_FamilyDetail_Table.object(at: j))
                var memberDOA="2000/01/01"
                var particulars="particulars comment"
                var profileIds=profileId
                
                
                
                
                
                dictFamilyDetailrray=["familyMemberId":familyMemberId as AnyObject,"memberName":memberName as AnyObject,"emailID":emailID as AnyObject,"contactNo":contactNo as AnyObject,"relationship":relationship as AnyObject,"memberDOB":memberDOB as AnyObject,"bloodGroup":bloodGroup as AnyObject,"memberDOA":memberDOA as AnyObject,"particulars":particulars as AnyObject,"profileId":profileId as AnyObject]
                muarrayFamilyDetails.add(dictFamilyDetailrray)
                
            }
        }
        
        /*«««««««««««««««««««««««««««««««««««««««««««««««code by Rajendra Jat for call web api*»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»*/
        
        ///code by Rajendra Jat get today current date time
      var varGetCurrentDateTime =  functionForGetTodayDateTime()
        
        
        let completeURL = baseUrl+touchBase_GetUpdateProfileDetails
        let parameterst = [
            "dynamicFields" : muarraybusinessDynamicFields,
            "businessMemberDetails" : muarraybusinessMemberDetails,
            "personalMemberDetails": dictPersonalInfoArray,
            "grpID": grpID,
            "updatedOn": varGetCurrentDateTime,
            "profileID": profileId,
            "addressDetails":muarrayAddressDetails,
            "familyMemberDetail":muarrayFamilyDetails,
            "deletedFamilyMemberIds": "552,548",
        ] as [String : Any]
        
        print(parameterst)
        print(completeURL)
        
        
        let bytes = try! JSONSerialization.data(withJSONObject: parameterst, options: JSONSerialization.WritingOptions.prettyPrinted)
        var jsonObj = try! JSONSerialization.jsonObject(with: bytes, options: .mutableLeaves)
        if let str = String(data: bytes, encoding: String.Encoding.utf8)
        {
            print(str)
        }
        else
        {
            print("not a valid UTF-8 sequence")
        }
        
        
        
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: parameterst, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString) // <-- here is ur string
            
        } catch let myJSONError {
            print(myJSONError)
        }
        
        
        
        print(bytes)
        print(jsonObj)
        
        
        
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
          
            
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
                print(response)
                let dd = response as! NSDictionary
                print("dd \(dd)")
                
                if(dd.object(forKey: "status") as! String == "0")
                {
                    self.view.makeToast("Profile updated successfully.", duration: 3, position: CSToastPositionCenter)
 
                     //let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                    //self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)

                    
                }
                else
                {
                    self.view.makeToast("Something went wrong, while updaing profile", duration: 3, position: CSToastPositionCenter)
                    SVProgressHUD.dismiss()
                }
            }
            })
            SVProgressHUD.dismiss()
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 3, position: CSToastPositionCenter)
           SVProgressHUD.dismiss()
        }
        /*«««««««««««««««««««««««««««««««««««««««««««««««««««code by Rajendra Jat for call web api*»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»*/
    }
    func functionForSelectCountry(_ stringCountryName:String)->String
    {
        var letGetLastUpdateDate:String!=""
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("select country_code from country_master where country_master_name='"+stringCountryName+"'", withArgumentsIn: nil)
        
        print("select country_code from country_master where country_master_name='"+stringCountryName+"'")
        
        
        
        var stringGetcountryId:String!=""
        if (resultSet != nil)
        {
            while resultSet.next()
            {
                stringGetcountryId = resultSet.string(forColumn: "country_code")
                
            }
        }
        sharedInstance.database!.close()
        print(stringGetcountryId)
        return stringGetcountryId
    }
    func functionForGetTodayDateTime()->String
    {
        let date = Foundation.Date()
        print(date)
        // "Jul 23, 2014, 11:01 AM" <-- looks local without seconds. But:
        
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        let defaultTimeZoneStr = formatter.string(from: date)
        print(defaultTimeZoneStr)
        
        var varGetProperDateTime=defaultTimeZoneStr.components(separatedBy: " ")
        
        
        // "2014-07-23 11:01:35 -0700" <-- same date, local, but with seconds
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let utcTimeZoneStr = formatter.string(from: date)
       
        print(utcTimeZoneStr)
        
        print(varGetProperDateTime[0]+" "+varGetProperDateTime[1])
        
        
        return varGetProperDateTime[0]+" "+varGetProperDateTime[1]
        // "2014-07-23 18:01:41 +0000" <-- same date, now in UTC
     //   The date output varies, but the date is constant. This is exactly what you're saying. There's no such thing as a local NSDate.
        
       // As for how to get microseconds out, you can use this (put it at the bottom of the same playground):
        
//        let seconds = date.timeIntervalSince1970
//        let microseconds = Int(seconds * 1000) % 1000 // chops off seconds
//         print(seconds)
//        print(microseconds)
    }
    
    
    
 }
 
 
