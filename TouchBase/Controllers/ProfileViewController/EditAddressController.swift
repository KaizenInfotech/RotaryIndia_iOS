//
//  EditAddressController.swift
//  TouchBase
//
//  Created by Kaizan on 02/04/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class EditAddressController: UIViewController , UITextFieldDelegate , webServiceDelegate  , UIPickerViewDelegate , UIScrollViewDelegate{
    
    let bounds = UIScreen.main.bounds
    var myview = UIView()
    var appDelegate = AppDelegate()
    var pickerView: UIPickerView = UIPickerView()
    @IBOutlet var myScrollView: UIScrollView!
    
    @IBOutlet var memberAddress: UITextField!
    @IBOutlet var memberCity: UITextField!
    @IBOutlet var memberState: UITextField!
    @IBOutlet var memberPincode: UITextField!
    
    var addrDetail : Address?
    var memberDetail : MemberListDetail = MemberListDetail()
    
    let toolBar = UIToolbar()
    var GroupID : String = ""
    var addressID : String = ""
    var profileId : String = ""
    var isEditOrNewAdd : String = ""
    
    var addresstypeSTR : String = ""
    var countryStr : String = ""
    var phoneStr : String = ""
    var faxStr : String = ""
    var varIsSelectCountry:Int=0
//    var isEditBirthday : String = ""
    
    var pickerCountry : NSArray = NSArray()
    @IBOutlet var selectCountryButton: UIButton!
    
     ///*
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    //*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        selectCountryButton.setTitle("",  for: UIControl.State.normal)
        
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        myScrollView.isDirectionalLockEnabled = true
        pickerCountry = NSArray()
        
        if addrDetail == nil
        {
            addressID = "0"
        }
        else
        {
            memberAddress.text = addrDetail!.address
            memberCity.text = addrDetail!.city
            memberState.text = addrDetail!.state
            memberPincode.text = addrDetail!.pincode
            
            addressID = (addrDetail?.addressID)!
            selectCountryButton.setTitle(addrDetail?.country,  for: UIControl.State.normal)// = (addrDetail?.country)!
            phoneStr = (addrDetail?.phoneNo)!
            faxStr = (addrDetail?.fax)!
            
            print(addrDetail?.country)
            let varGet=addrDetail!.country.isEmpty
            print(varGet)
            if(varGet==true)
            {
                varIsSelectCountry=0
 
            }
            else
            {
            varIsSelectCountry=1
            }
            
            selectCountryButton.setTitle(addrDetail!.country,  for: UIControl.State.normal)
            selectCountryButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
        }
        
        
        
//        if isEditOrNewAdd == "0"
//        {
//            
//        }
//        else
//        {
//            
//        }
        
        
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates = self
        wsm.getCountryAndCategories()
        
    }
    
    func countryAndCatListDelegateFunction(_ countryCat : TBCountryResult)
    {
        print(countryCat.status)
        
        pickerCountry = countryCat.countryLists as NSArray
        
    }

    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Address"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(EditAddressController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked()
    {
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
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(EditAddressController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        pickerView.tag = 1
        myview.addSubview(toolBar)
        myview.addSubview(pickerView)
        
        
        selectCountryButton.setTitle("India",  for: UIControl.State.normal)
        selectCountryButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
        varIsSelectCountry=1
        method()
        
    }
    
    
    @IBAction func SaveDataAction(_ sender: AnyObject)
    {
 /*
        if(self.phoneNumberValidation(mobileNumberField.text!) == false)
        {
            let Alert: UIAlertView = UIAlertView()
            Alert.delegate = self
            Alert.title = "Rotary India"
            Alert.message = "Please enter a valid mobile number."
            Alert.addButtonWithTitle("okay")
            Alert.show()
        }
        else if(isValid == false)
        {
            let Alert: UIAlertView = UIAlertView()
            Alert.delegate = self
            Alert.title = "Rotary India"
            Alert.message = "Please enter a valid Email Address."
            Alert.addButtonWithTitle("okay")
            Alert.show()
        }
        else
        {
   
 */
        
        
            let memberUID = UserDefaults.standard.string(forKey: "masterUID")
            print(memberUID)
            let wsm : WebserviceClass = WebserviceClass()
            wsm.delegates = self           // 0 - Add , 1 - Edit
        
        //1.
        var varGetaddressID:String!=addressID
        print(varGetaddressID)
        //2.
        var varGetaddresstypeSTR:String!=addresstypeSTR
        print(varGetaddresstypeSTR)
        //3.
        var varGetaddress:String!=memberAddress.text
        print(varGetaddress)
        //4.
        var varGetCity:String!=memberCity.text
        print(varGetCity)
        //5.
        var varGetState:String!=memberState.text
        print(varGetState)
        //6.
        var varGetCountry:String!=""
        if(varIsSelectCountry==0)
        {
            varGetCountry=""
        }
        else
        {
       varGetCountry=(selectCountryButton.titleLabel?.text)!
        print(varGetCountry)
        }
        //7.
        var varGetPinCode:String!=memberPincode.text
        print(varGetPinCode)
        //8.
        var varGetPhoneNo:String!=phoneStr
        print(varGetPhoneNo)
        //9.
        var varGetFax:String!=faxStr
        print(varGetFax)
        //10.
        var varGetprofileIdString:String!=profileId
        print(varGetprofileIdString)
        //11.
        var varGetGroupId:String!=GroupID
        print(varGetGroupId)
        
            wsm.getAddAddressToProfile(addressID, addressType: addresstypeSTR, address: memberAddress.text!, city: memberCity.text!, state: memberState.text!, country: varGetCountry , pincode: memberPincode.text!, phoneNo: phoneStr, fax: faxStr, profileID: profileId, groupID: GroupID)
            
        
            // wsm.createNsArrayDicTOAddSingleMember(memberNameField.text!, andNumber: mobileNumberField.text!, andGroupID: "1", andMasterUID: memberUID, andCountryId: countryID, andMemberEmail: memberEmailField.text!)
            
            //wsm.createNsArrayDic11(NameArray as [AnyObject], andNumberArray: NumberArray as [AnyObject], andGroupID: GroupID, andMasterUID: memberUID)
        //}
    }
    
    
    func getAddUpdateAddressSuccss(_ updateAddressProfile:UpdateAddressResult)
    {
        print(updateAddressProfile.status)
        print(updateAddressProfile.message)
        
        if updateAddressProfile.status == "0"
        {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        //let width = bounds.size.width
        //if(width <= 320.0)
        //{
        
        if textField == memberPincode
        {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: -150 , width: self.view.frame.width, height: self.view.frame.height)
                    
                    
                }, completion: { finished in
                    
            })
            
        }
        // }
        // else
        // {
        // }
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
                
                
                
            }, completion: { finished in
                
        })
        
        
        memberPincode.resignFirstResponder()
        memberAddress.resignFirstResponder()
        memberCity.resignFirstResponder()
        memberState.resignFirstResponder()
        memberPincode.resignFirstResponder()
        
        return true
    }
    
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                                                 replacementString string: String) -> Bool {
        
        if textField == memberPincode
        {
            // Create an `NSCharacterSet` set which includes everything *but* the digits
            let inverseSet = CharacterSet(charactersIn:"0123456789").inverted
            
            // At every character in this "inverseSet" contained in the string,
            // split the string up into components which exclude the characters
            // in this inverse set
            let components = string.components(separatedBy: inverseSet)
            
            // Rejoin these components
            let filtered = components.joined(separator: "")  // use join("", components) if you are using Swift 1.2
            
            // If the original string is equal to the filtered string, i.e. if no
            // inverse characters were present to be eliminated, the input is valid
            // and the statement returns true; else it returns false
            return string == filtered
        }
        else
        {
            return true
        }
        
    }
    
    @objc func donePicker()
    {
        myview.removeFromSuperview()
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerCountry.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        var countryList = GrpCountryList()
        countryList = pickerCountry.object(at: row) as! GrpCountryList
        
        return countryList.countryName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        var countryList = GrpCountryList()
        countryList = pickerCountry.object(at: row) as! GrpCountryList
        selectCountryButton.setTitle(countryList.countryName as String,  for: UIControl.State.normal)
        selectCountryButton.titleLabel?.textAlignment = .left
       // varIsSelectCountry=1
        selectCountryButton.setTitleColor(UIColor.black,  for: UIControl.State.normal)
        
    }
    
    func method()
    {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
            }, completion: { finished in
        })
        
        memberPincode.resignFirstResponder()
        memberAddress.resignFirstResponder()
        memberCity.resignFirstResponder()
        memberState.resignFirstResponder()
        memberPincode.resignFirstResponder()
    }
    
}

