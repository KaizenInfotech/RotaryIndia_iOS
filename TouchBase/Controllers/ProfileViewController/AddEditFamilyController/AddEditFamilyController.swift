//
//  AddEditFamilyController.swift
//  TouchBase
//
//  Created by Kaizan on 29/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
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

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


class AddEditFamilyController: UIViewController , UITextFieldDelegate , webServiceDelegate , uploadDocDelegate , UIPickerViewDelegate {
    
    let bounds = UIScreen.main.bounds
    var myview = UIView()
    var appDelegate = AppDelegate()
    var picker = UIDatePicker()
    var pickerView: UIPickerView = UIPickerView()
    @IBOutlet var myScrollView: UIScrollView!
    @IBOutlet var memberNameField: UITextField!
    @IBOutlet var mobileNumberField: UITextField!
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var memberEmailField: UITextField!
   let toolBar = UIToolbar()
    var GroupID : String = ""
    var countryID : String = ""
    var profileId : String = ""
    var pickBloodGroupArray = NSArray()
    var pickRelationArray = NSArray()
    var isEditOrNewAdd : String = ""    
    var isEditMemberName : String = ""
    var isEditMobile : String = ""
    var isEditEmail : String = ""
    var isEditBloodgrp : String = ""
    var isEditRelation : String = ""
    var isEditBirthday : String = ""
    
    @IBOutlet var relationButton: UIButton!
    
    @IBOutlet var birthdayButton: UIButton!
    
    @IBOutlet var bloodGroupButton: UIButton!
    @IBOutlet var codeLblButton: UIButton!
    
///*   
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
       
        let defaults = UserDefaults.standard
        let country =  defaults.object(forKey: "countryName")
        let code    =  defaults.object(forKey: "countryCode") as? String
        countryID = defaults.object(forKey: "countryId") as! String
        print(country)
        print(code)
        
        if (code == "")
        {
            if codeLabel.text == ""
            {
                codeLblButton.setTitle("Code",  for: UIControl.State.normal)
            }
            let defaults = UserDefaults.standard
            defaults.set("1", forKey: "countryId")
            defaults.synchronize()
            
            countryID = ""
        }
        else
        {
             codeLblButton.setTitle("",  for: UIControl.State.normal)
            codeLabel.text = code!
            print(code)
            
            defaults.set("", forKey: "countryName")
            defaults.set("", forKey: "countryCode")
            defaults.set("", forKey: "countryId")
            defaults.synchronize()
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.setStyle()
        self.addDoneButtonOnKeyboard()
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        myScrollView.isDirectionalLockEnabled = true
        
        pickBloodGroupArray = ["A+ Ve","A- Ve","B+ Ve","B- Ve","AB+ Ve","AB- Ve","O+ Ve","O- Ve"]
        pickRelationArray = ["Father","Mother","Sister","Spouse","Brother","Friend","Son","Daughter","Son-in-law","Daughter-in-law"]
        memberNameField.text = isEditMemberName
        memberEmailField.text = isEditEmail
        
        let defaults = UserDefaults.standard
        
        if isEditMobile.characters.count > 1
        {
            let fullNameArr = isEditMobile.characters.split{$0 == " "}.map(String.init)
            
            defaults.set(fullNameArr[0], forKey: "countryIDFamily")
            defaults.synchronize()
            
            let country:String! =  defaults.object(forKey: "countryIDFamily") as! String
            codeLabel.text = "+"+country as? String
                
            print(codeLabel.text)
            mobileNumberField.text = String(format:"%@",fullNameArr[1])  // Last
            print(mobileNumberField.text)
            if codeLabel.text == ""
            {
                 codeLblButton.setTitle("Code",  for: UIControl.State.normal)
            }else{
                 codeLblButton.setTitle("",  for: UIControl.State.normal)
            }
        }
        else
        {
            let country =  defaults.object(forKey: "countryIDFamily")
            codeLabel.text = country as? String
            if codeLabel.text == ""
            {
                codeLblButton.setTitle("Code",  for: UIControl.State.normal)
            }else{
                codeLblButton.setTitle("",  for: UIControl.State.normal)
            }
            
            mobileNumberField.text =  ""
        }
        
        
        print(codeLabel.text)
        print(mobileNumberField.text)
        
        
        if isEditOrNewAdd == "0"
        {
            
        }
        else
        {
            bloodGroupButton.setTitle(isEditBloodgrp,  for: UIControl.State.normal)
            bloodGroupButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
            
            relationButton.setTitle(isEditRelation,  for: UIControl.State.normal)
            relationButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
            
            birthdayButton.setTitle(isEditBirthday,  for: UIControl.State.normal)
            birthdayButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
            
            
            print(isEditBirthday)
            print(isEditBirthday)

        }
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Add Family"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AddEditFamilyController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked()
    {
        let defaults = UserDefaults.standard
        defaults.set("", forKey: "countryName")
        defaults.set("", forKey: "countryCode")
        defaults.set("", forKey: "countryId")
        defaults.set("", forKey: "countryIDFamily")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
        else if scrollView.contentOffset.x<0{
            scrollView.contentOffset.x = 0
        }
    }
    
    
 ///*
    @IBAction func SelectCountryAction(_ sender: AnyObject)
    {
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "country_code") as UIViewController, animated: true)
    }
    
    
    @IBAction func SaveDataAction(_ sender: AnyObject)
    {
        let isValid = isValidEmail(memberEmailField.text!)
        
        var relation  = String()
        var bGroop  = String()
        var birthDate  = String()
        
        if  let a = relationButton.titleLabel!.text
        {
            print(a)
            relation = a
        }
        else
        {
            relation = ""
        }
        
        
        if  let a = bloodGroupButton.titleLabel!.text
        {
            print(a)
            bGroop = a
            bGroop = a.replacingOccurrences(of: "+",
                                                                                               with: "%2B",
                                                                                               options: .caseInsensitive,
                                                                                               range: nil)
        }
        else
        {
            bGroop = ""
        }
      
        if  let a = birthdayButton.titleLabel!.text
        {
            print(a)
            
            if isEditBirthday == ""
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "yyyy-MM-dd"
                let datstr = dateFormatter.date(from: a)
                birthDate = dateFormatter1.string(from: datstr!)
            }
            else
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "yyyy-MM-dd"
                let datstr = dateFormatter.date(from: a)
                birthDate = dateFormatter1.string(from: datstr!)
            }
            
            
        }
        else
        {
            birthDate = ""
        }
        
        if memberNameField.text?.characters.count == 0
        {
            
            let Alert: UIAlertView = UIAlertView()
            Alert.delegate = self
            Alert.title = "Rotary India"
            Alert.message = "Please enter a name"
            Alert.addButton(withTitle: "okay")
            Alert.show()
            
        }
        else if memberEmailField.text?.characters.count > 0 && isValid == false
        {
            
                let Alert: UIAlertView = UIAlertView()
                Alert.delegate = self
                Alert.title = "Rotary India"
                Alert.message = "Please enter a valid Email Address"
                Alert.addButton(withTitle: "okay")
                Alert.show()
                
           
        }
        
        else if mobileNumberField.text?.characters.count > 0 && codeLabel.text?.characters.count <= 0
        {
            
            let Alert: UIAlertView = UIAlertView()
            Alert.delegate = self
            Alert.title = "Rotary India"
            Alert.message = "Please select country code."
            Alert.addButton(withTitle: "okay")
            Alert.show()
            
        }else if relation.characters.count == 0
        {
            
            let Alert: UIAlertView = UIAlertView()
            Alert.delegate = self
            Alert.title = "Rotary India"
            Alert.message = "Please specify the Relation."
            Alert.addButton(withTitle: "okay")
            Alert.show()
            
        }

        else
        {
            let memberUID = UserDefaults.standard.string(forKey: "masterUID")
            print(memberUID)
            let wsm : WebserviceClass = WebserviceClass()
            wsm.delegates = self           // 0 - Add , 1 - Edit
            
            print(birthDate)
            
            
            
            if(mobileNumberField.text! != "" && codeLabel.text! != ""){
                let mobileStr = String(format:"%@ %@",codeLabel.text!,mobileNumberField.text!)
                wsm.getAddFamilyMembersToProfile(isEditOrNewAdd, memberName: memberNameField.text!, relationship: relation, dOB: birthDate, anniversary: "", contactNo: mobileStr, particulars: "", bloodGroup: bGroop, profileId: profileId , emailID:memberEmailField.text!)
            }else{
                wsm.getAddFamilyMembersToProfile(isEditOrNewAdd, memberName: memberNameField.text!, relationship: relation, dOB: birthDate, anniversary: "", contactNo: "", particulars: "", bloodGroup: bGroop, profileId: profileId , emailID:memberEmailField.text!)
            }
            
        }
    }
    
    
    func getAddFamilyMembersSuccss(_ updateFamilyDetail : UpdateFamilyResult)
    {
        print(updateFamilyDetail.status)
        print(updateFamilyDetail.message)
        
        if updateFamilyDetail.status == "0"
        {
            let defaults = UserDefaults.standard
            defaults.set("", forKey: "countryName")
            defaults.set("", forKey: "countryCode")
            defaults.set("", forKey: "countryId")
            defaults.set("", forKey: "countryIDFamily")
           // let country =  defaults.objectForKey("countryIDFamily")
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
        
        if textField == memberEmailField
        {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: -150 , width: self.view.frame.width, height: self.view.frame.height)
                    
                    
                }, completion: { finished in
                    
            })
            
        }
        
    }
    
    
    func phoneNumberValidation(_ value: String) -> Bool {
        /*
        if (value.characters.count) > 4
        {
            let charcter  = CharacterSet(charactersIn: "0123456789").inverted
            var filtered:NSString!
            let inputString:NSArray = value.components(separatedBy: charcter) as NSArray
            filtered = inputString.componentsJoined(by: "") as NSString
           
            return true
            //my code
            // return  value == filtered
        }
        else
        {
            return false
        }
        */
        if let numRange = value.rangeOfCharacter(from: NSCharacterSet.letters) {
            return false
        } else {
            return true
        }
    }
    
    func isValidEmail(_ testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == mobileNumberField
        {

             return true
        }
        else
        {
            return true
        }
        
    }
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(AddEditFamilyController.doneButtonAction))
        
        var items: [UIBarButtonItem]? = [UIBarButtonItem]()
        items?.append(flexSpace)
        items?.append(done)
        
        
        doneToolbar.setItems(items, animated: true)
        doneToolbar.sizeToFit()
        mobileNumberField.inputAccessoryView=doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
                
                
                
            }, completion: { finished in
                
        })
        
        mobileNumberField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
                
                
                
            }, completion: { finished in
                
        })
        
        
        memberNameField.resignFirstResponder()
        memberEmailField.resignFirstResponder()
        mobileNumberField.resignFirstResponder()
        
        return true
    }
    
    
    //    @IBAction func AddMembersAction(sender: AnyObject)
    //    {
    //        self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("contact_list") as UIViewController, animated: true)
    //    }
    //
    //    @IBAction func EditMembersAction(sender: AnyObject)
    //    {
    //        self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("contact_list") as UIViewController, animated: true)
    //    }
    
    //    @IBAction func NextButtonAction(sender: AnyObject)
    //    {
    //        NSUserDefaults.standardUserDefaults().setObject("", forKey: "contactNameForGroup")
    //        NSUserDefaults.standardUserDefaults().setObject("", forKey: "contactNumberForGroup")
    //        NSUserDefaults.standardUserDefaults().setObject("", forKey: "EditcontactNameForGroup")
    //        NSUserDefaults.standardUserDefaults().setObject("", forKey: "EditcontactNumberForGroup")
    //        self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("rootDash") as UIViewController, animated: true)
    //        //self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("modules") as UIViewController, animated: true) //
    //
    //        let memberUID = NSUserDefaults.standardUserDefaults().stringForKey("MasterUID")
    //        print(memberUID)
    //        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
    //        wsm.delegate=self
    //        wsm.createNsArrayDic(NameArray as [AnyObject], andNumberArray: NumberArray as [AnyObject], andGroupID: GroupID, andMasterUID: memberUID)
    //
    //    }
    
    
//    func getDicArrayAddSingleMemberSucceeded(responce : NSMutableArray)
//    {
//        print(responce)
//        
//        let wsm : WebserviceClass = WebserviceClass.sharedInstance
//        wsm.delegates = self
//        wsm.getAddMembersToGroup(responce)
//    }
//    
//    
//    func getAddMembersSuccss(addMembers : TBAddMemberGroupResult)
//    {
//        print(addMembers.status)
//        print(addMembers.message)
//    }
 //   */
    
    
    @IBAction func BirthDateSelectAction(_ sender: AnyObject)
    {
        myview = UIView(frame: CGRect(x: 0,y: self.view.frame.height-300, width: self.view.frame.size.width, height: 300));
        myview.backgroundColor=UIColor.white;
        self.view.addSubview(myview);
        
        
        picker = UIDatePicker(frame: CGRect(x: 0, y: myview.frame.size.height-250 , width: myview.frame.width, height: 250))
        picker.setStyle()
        picker.backgroundColor = .white
        picker.tag = sender.tag
        picker.datePickerMode = UIDatePicker.Mode.date
        picker.addTarget(self, action: #selector(AddEditFamilyController.dateValueChanged(_:)), for: UIControl.Event.valueChanged)
        
//        let dateFormatter = NSDateFormatter()
//        let theDateFormat = NSDateFormatterStyle.ShortStyle //5
//        dateFormatter.dateStyle = theDateFormat//8
////        dateFormatter.dateFormat = "dd-MM-yyyy"
////        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
//        //let strDate = dateFormatter.stringFromDate(picker.date)
//        
//        
//        //   dateTimeDisplay.text = dateFormatter.stringFromDate(datePicker.date) + " " + timeFormatter.stringFromDate(timePicker.date)
//        let strSplit = strDate.characters.split(" ")
//        let Date = String(strSplit.first!)
//        
//        print(Date)
        
        
        
        
        //    cell.dateButton.setTitle(Date, forState: UIControl.State.Normal)
        //    cell.timeButton.setTitle(time, forState: UIControl.State.Normal)
        
        toolBar.frame = CGRect(x: 0, y: 0 , width: view.frame.width, height: 50)
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(AddEditFamilyController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        myview.addSubview(toolBar)
        myview.addSubview(picker)
        
        
        let todaysDate:Foundation.Date = Foundation.Date()
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let DateInFormat:String = dateFormatter.string(from: todaysDate)
        print(DateInFormat)

        
        birthdayButton.setTitle(DateInFormat,  for: UIControl.State.normal)
        birthdayButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
        isEditBirthday = ""
        method()
        
    }
    
    
    @objc  func donePicker()
    {
        myview.removeFromSuperview()
        
    }
    
    @objc func dateValueChanged(_ sender:UIDatePicker)
    {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: sender.date)
        
        
        let strSplit = strDate.characters.split(separator: " ")
        let Date = String(strSplit.first!)
        
        print(Date)
        
        birthdayButton.setTitle(Date,  for: UIControl.State.normal)
        birthdayButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
        isEditBirthday = ""
        
        
    }

    @IBAction func BloodGroupSelectAction(_ sender: AnyObject)
    {
        
        myview = UIView(frame: CGRect(x: 0,y: self.view.frame.height-300, width: self.view.frame.size.width, height: 300));
        myview.backgroundColor=UIColor.white;
        self.view.addSubview(myview);

        pickerView = UIPickerView(frame: CGRect(x: 0, y: myview.frame.size.height-250 , width: myview.frame.width, height: 250))
        pickerView.backgroundColor = .white
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
      //  pickerView.dataSource = self
        
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(AddEditFamilyController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        pickerView.tag = 0
        myview.addSubview(toolBar)
        myview.addSubview(pickerView)
        
        bloodGroupButton.setTitle("A+ Ve",  for: UIControl.State.normal)
        bloodGroupButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
        
        method()
    }
    
    
    @IBAction func RelationSelectAction(_ sender: AnyObject)
    {
        myview = UIView(frame: CGRect(x: 0,y: self.view.frame.height-300, width: self.view.frame.size.width, height: 300));
        myview.backgroundColor=UIColor.white;
        self.view.addSubview(myview);
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: myview.frame.size.height-250 , width: myview.frame.width, height: 250))
        pickerView.backgroundColor = .white
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
      //  pickerView.dataSource = self
        
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(AddEditFamilyController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        pickerView.tag = 1
        myview.addSubview(toolBar)
        myview.addSubview(pickerView)
        
        
        relationButton.setTitle("Father",  for: UIControl.State.normal)
        relationButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
        
        method()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView.tag == 0
        {
            return pickBloodGroupArray.count;
        }
        else
        {
            return pickRelationArray.count;
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView.tag == 0
        {
            return pickBloodGroupArray[row] as? String
        }
        else
        {
            return pickRelationArray[row] as? String
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView.tag == 0
        {
            let bloodgrp = String(format:"%@",pickBloodGroupArray[row] as! String)
            bloodGroupButton.setTitle(bloodgrp,  for: UIControl.State.normal)
            bloodGroupButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
            
            
        }
        else
        {
            let relation = String(format:"%@",pickRelationArray[row] as! String)
            relationButton.setTitle(relation,  for: UIControl.State.normal)
            relationButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
            
        }
    }

    func method()
    {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
            }, completion: { finished in
        })
        
        memberNameField.resignFirstResponder()
        memberEmailField.resignFirstResponder()
        mobileNumberField.resignFirstResponder()
    }

}


