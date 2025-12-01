//
//  AddMemberToGroupController.swift
//  TouchBase
//
//  Created by Kaizan on 30/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//
import SVProgressHUD
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


class AddMemberToGroupController: UIViewController , UITextFieldDelegate , UIScrollViewDelegate , webServiceDelegate , uploadDocDelegate{
    
    let bounds = UIScreen.main.bounds
    
    var appDelegate = AppDelegate()
    
    
    @IBOutlet var memberNameField: UITextField!
    @IBOutlet var mobileNumberField: UITextField!
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var memberEmailField: UITextField!
    
    @IBOutlet var myScrollView: UIScrollView!
    
    @IBOutlet weak var buttonSave: UIButton!
    
    
//    var NameString : String = ""
//    var NumberString : String = ""
//    
//    var NameArray = NSArray()
//    var NumberArray = NSArray()
//    
    var GroupID : String = ""
    var countryID : String = ""
//    var GroupImage : String = ""
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //   self.view.userInteractionEnabled = true
        
        let defaults = UserDefaults.standard
        let country =  defaults.object(forKey: "countryName")
        let code    =  defaults.object(forKey: "countryCode")
        countryID = (defaults.value(forKey: "countryId") as! String?)!
        print(country)
        print(code)
        
        if let country =  defaults.object(forKey: "countryName")
        {
            countryLabel.text = country as? String
            codeLabel.text = code as? String
        }
        else
        {
            countryLabel.text = "India"
            codeLabel.text = "+91"
            let defaults = UserDefaults.standard
            defaults.set("1", forKey: "countryId")
            defaults.synchronize()
            
            countryID = "1"
            
        }
    }

    
    let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "

    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        buttonSave.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonSave.backgroundColor=UIColor.white //(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        let lbel = UILabel()
        lbel.frame = CGRect(x: 0, y: self.buttonSave.frame.size.height-52, width: self.view.frame.size.width, height: 1)
        lbel.backgroundColor =  UIColor.lightGray
        buttonSave.addSubview(lbel)
        self.addDoneButtonOnKeyboard()
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let defaults = UserDefaults.standard
         defaults.setValue(nil, forKey: "countryName")
          defaults.setValue(nil, forKey: "countryCode")
        
       // myScrollView.directionalLockEnabled = true
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Add Member"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AddMemberToGroupController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked()
    {
        if(memberNameField.text!.characters.count > 0 || mobileNumberField.text?.characters.count > 0){
            let alertController = UIAlertController(title: "", message:
                "Your changes are not saved, are you sure you want to go back?", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default,handler:  {(alert :UIAlertAction!) in
                let defaults = UserDefaults.standard
                defaults.set("", forKey: "countryName")
                defaults.set("", forKey: "countryCode")
                defaults.set("", forKey: "countryId")
                defaults.set("", forKey: "countryIDFamily")
                self.navigationController?.popViewController(animated: true)
            }))
            //  print("YOU PRESSED OK \(sender.view!.tag)")
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }else{
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func SelectCountryAction(_ sender: AnyObject)
    {
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "country_code") as UIViewController, animated: true)
    }
    

    @IBAction func SaveDataAction(_ sender: AnyObject)
    {
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
      

        
        
        
        //let isValid = isValidEmail(memberEmailField.text!)
        
        if memberNameField.text == ""
        {
          
            
            
            self.view.makeToast("Please enter a Name.", duration: 2, position: CSToastPositionCenter)

        }
        else if countryLabel.text == ""
        {
          
            self.view.makeToast("Please select country", duration: 2, position: CSToastPositionCenter)

        }
        else if mobileNumberField.text == ""
        {
            
            self.view.makeToast("Please enter a Mobile Number", duration: 2, position: CSToastPositionCenter)

        }
        else if memberEmailField.text != ""
        {
            if isValidEmail(memberEmailField.text!)
            {
                
                alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                
                print("Validate EmailID")
                //-----
                let memberUID = UserDefaults.standard.string(forKey: "masterUID")
                print(memberUID)
                let wsm : WebserviceClass = WebserviceClass()
                wsm.delegates=self
                wsm.getAddMembersToGroup(mobileNumberField.text!, userName: memberNameField.text!, groupId: GroupID, masterID: memberUID!, countryId: countryID, memberEmail: memberEmailField.text!)
            }
            else
            {
            
                self.view.makeToast("Please enter Valid Email Id", duration: 2, position: CSToastPositionCenter)

                
            }
        }
            
            
            
            
//       else if(self.phoneNumberValidation(mobileNumberField.text!) == false)
//        {
//            let Alert: UIAlertView = UIAlertView()
//            Alert.delegate = self
//            Alert.title = "Rotary India"
//            Alert.message = "Please enter a valid Mobile Number"
//            Alert.addButtonWithTitle("Ok")
//            Alert.show()
//        }
//        else if(isValid == false)
//        {
//            
//                let Alert: UIAlertView = UIAlertView()
//                Alert.delegate = self
//                Alert.title = "Rotary India"
//                Alert.message = "Please enter a valid Email Address."
//                Alert.addButtonWithTitle("okay")
//                Alert.show()
//            
//            
//        }
        else
        {
            
          
            alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            
            
         
            
            let memberUID = UserDefaults.standard.string(forKey: "masterUID")
            print(memberUID)
            let wsm : WebserviceClass = WebserviceClass()
            wsm.delegates=self
            wsm.getAddMembersToGroup(mobileNumberField.text!, userName: memberNameField.text!, groupId: GroupID, masterID: memberUID!, countryId: countryID, memberEmail: memberEmailField.text!)
            
            
           // wsm.createNsArrayDicTOAddSingleMember(, andNumber: , andGroupID: "6", andMasterUID: memberUID, andCountryId: countryID, andMemberEmail: memberEmailField.text!)
            
           // wsm.
            
            //wsm.createNsArrayDic11(NameArray as [AnyObject], andNumberArray: NumberArray as [AnyObject], andGroupID: GroupID, andMasterUID: memberUID)
        }
        
        
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            
        }
        

    }
    
    var alertController = UIAlertController()
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        //let width = bounds.size.width
        //if(width <= 320.0)
        //{
        
//        if textField == mobileNumberField || textField == memberEmailField
//        {
//            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
//                {
//
//                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: -150 , width: self.view.frame.width, height: self.view.frame.height)
//
//
//                }, completion: { finished in
//
//            })
//
//        }
                   // }
       // else
       // {
       // }
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
            //myy code
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
        if testStr == ""
        {
            return true
        }
        else
        {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: testStr)
        }
        
    }

    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
//    {
//        if textField == mobileNumberField
//        {
//            if (range.length + range.location > (textField.text?.characters.count)! )
//            {
//                return false;
//            }
//            
//            print(String(format:"Mobile Character Length - %d",(textField.text?.characters.count)!))
//            
//            let newLength = (textField.text?.characters.count)! + (string.characters.count) - range.length
//            return newLength <= 10
//        }
//        else
//        {
//            return true
//        }
//        
//    }
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(AddMemberToGroupController.doneButtonAction))
        
        var items: [UIBarButtonItem]? = [UIBarButtonItem]()
        items?.append(flexSpace)
        items?.append(done)
        
        
        doneToolbar.setItems(items, animated: true)
        doneToolbar.sizeToFit()
        mobileNumberField.inputAccessoryView=doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        //let width = bounds.size.width
        //if(width <= 320.0)
       // {
//            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
//                {
//
//                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
//
//
//
//                }, completion: { finished in
//
//            })
        
       // }
       // else
       // {
       // }
        
        mobileNumberField.resignFirstResponder()
    }
   
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField==memberNameField)
        {
            let aSet = CharacterSet(charactersIn:ACCEPTABLE_CHARACTERS).inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        
        return true
    }
    
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
//            {
//                
//                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
//                
//                
//                
//            }, completion: { finished in
//                
//        })
//        
        
        
        
        
        
        memberNameField.resignFirstResponder()
        memberEmailField.resignFirstResponder()
        mobileNumberField.resignFirstResponder()
        
        return true
    }
    
    
//    func getAddMembersSuccss(addMembers : TBAddMemberGroupResult)
//    {
//        print(addMembers.status)
//        print(addMembers.message)
//        
//        if addMembers.status == "0"
//        {
//            let defaults = NSUserDefaults.standardUserDefaults()
//            defaults.setObject("", forKey: "countryName")
//            defaults.setObject("", forKey: "countryCode")
//            defaults.setObject("", forKey: "countryId")
//            defaults.setObject("", forKey: "countryIDFamily")
//            self.navigationController?.popViewControllerAnimated(true)
//        }
//        else
//        {
//            let Alert: UIAlertView = UIAlertView()
//            Alert.delegate = self
//            Alert.title = "Rotary India"
//            Alert.message = "Adding Member Failed please Contact Administrator"
//            Alert.addButtonWithTitle("Ok")
//            Alert.show()
//        }
//        
//    }
    

    func getAddMembersSuccss(_ addMembers : TBAddMemberGroupResult)
    {
        
        
        
        
     
        
        
        alertController.dismiss(animated: true, completion: nil)

        
        print(addMembers.status)
        print(addMembers.message)

        if addMembers.status == "0"
        {
            let defaults = UserDefaults.standard
            defaults.set("", forKey: "countryName")
            defaults.set("", forKey: "countryCode")
            defaults.set("", forKey: "countryId")
            defaults.set("", forKey: "countryIDFamily")
            self.navigationController?.popViewController(animated: true)
        }
        if addMembers.status == "2"
        {
            
            
            
            
            let Alert: UIAlertView = UIAlertView()
            Alert.delegate = self
            Alert.title = "Rotary India"
            Alert.message = "Member already exists" //"Adding Member Failed please Contact Administrator" //DPK
            Alert.addButton(withTitle: "Ok")
            Alert.show()
        }
        else
        {
            alertController.dismiss(animated: true, completion: nil)

            let alert = UIAlertController(title: "Member", message: "Added successfully.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }));
            self.present(alert, animated: true, completion: nil)
        }
        
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
    
    
    
}


