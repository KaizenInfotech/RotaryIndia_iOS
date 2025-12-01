//
//  MobileLoginController.swift
//  TouchBase
//
//  Created by Kaizan on 25/11/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

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


class MobileLoginController: UIViewController , UITextFieldDelegate , UIAlertViewDelegate , webServiceDelegate , UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet weak var buttonSelectCountry: UIButton!
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var viewForPicker: UIView!
    @IBOutlet weak var pickerSelectCountry: UIPickerView!
    @IBOutlet var mobileNumberField: UITextField!
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    let bounds = UIScreen.main.bounds
    var mainArray = NSArray()
    var varIsSelectCountry:Int=0
    @IBOutlet var loaderImageView: UIImageView!
    var objCalendarInfo : CalendarInfo = CalendarInfo()
    var varUserType:String! = ""
    @IBOutlet weak var buttonDonOnPicker: UIButton!
    @IBOutlet var continueButton: UIButton!
    //var appDelegate : AppDelegate!
     var appDelegate : AppDelegate = AppDelegate()
    var varGetCountryCode:String!=""
    @IBOutlet weak var everyRotarianLbl: UILabel!
    
    @IBOutlet weak var framilyMemLbl: UILabel!
    // var appDelegate : AppDelegate!
    func functionbForClearAllUserDefaults()
    {
        
        //
        // appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
      if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            URLCache.shared.removeAllCachedResponses()
            URLCache.shared.diskCapacity = 0
            URLCache.shared.memoryCapacity = 0
            
            
            URLCache.shared.removeAllCachedResponses()
            if let cookies = HTTPCookieStorage.shared.cookies
            {
                for cookie in cookies {
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                }
            }
            
        }
        else
        {
            
        }
        
        
        
        
        //
        
        
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            print(key)
            defaults.removeObject(forKey: key)
            // defaults.removeObject(forKey: key)
        }
        
//        UserDefaults.standard.setValue("0", forKey: "Session_SelectedIndexValue")
        UserDefaults.standard.setValue("no", forKey: "session_IsComingFromDownloadedvieworUploadDocumnetScreen")
        
        let varGetValue = UserDefaults.standard.string(forKey: "session_MaintainNewAddingModuleWhenFirstTimeAppInstalled")
        print(varGetValue)
        
        
        if(varGetValue == nil )
        {
            UserDefaults.standard.setValue("Yes", forKey: "session_MaintainNewAddingModuleWhenFirstTimeAppInstalled")
            var asd=""
            var asds=""
            var asssdfd=""
            let aasd=3+4
            print(aasd)
        }
        else
        {
            UserDefaults.standard.setValue("no", forKey: "session_MaintainNewAddingModuleWhenFirstTimeAppInstalled")
            var asd=""
            var asds=""
            var asssdfd=""
            let aasd=9+4
            print(aasd)
        }
        
        UserDefaults.standard.setValue("", forKey: "session_IsComingFromPop")
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        Util.copyFile("Calendar.sqlite")
        mainArray=NSMutableArray()
        mainArray = ModelManager.getInstance().functionForSelectCountry()
        //   self.view.userInteractionEnabled = true
        
        let defaults = UserDefaults.standard
        let country =  defaults.object(forKey: "countryName")
        let code    =  defaults.object(forKey: "countryCode")
        // let str = defaults.valueForKey("countryId") as! String?
        print(country)
        print(code)
       // self.mobileNumberField.leftView = codeLabel
        //self.mobileNumberField.leftViewMode = .always
    }
    
    override func viewDidLoad()
    {
      super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        let lbel = UILabel()
        lbel.frame = CGRect(x: 0, y: self.continueButton.frame.size.height-52, width: self.view.frame.size.width, height: 1)
        lbel.backgroundColor =  UIColor.gray
        continueButton.addSubview(lbel)
        continueButton.titleLabel?.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        buttonSelectCountry.setButtonBottomBorderForLogin()
        //mobileNumberField.functionForSetTextFieldBottomBorderForLogin()
        buttonOpticity.isHidden = true
        pickerSelectCountry.delegate = self
        viewForPicker.isHidden = true
        pickerSelectCountry.isHidden = false
        rotaryIndiaRewampRIZoneAPI()
      //  appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

//       if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
//            let wsm : WebserviceClass = WebserviceClass.sharedInstance
//            wsm.delegates = self
//            wsm.getCountryAndCategories()
//            
//        }
//        else
//        {
//            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
// SVProgressHUD.dismiss()
        
        
  //  }
     
        
        functionbForClearAllUserDefaults()
    self.navigationController?.setNavigationBarHidden(false, animated: false)
        //self.navigationController?.navigationBar.hidden = true
        self.addDoneButtonOnKeyboard()
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        //continueButton.enabled = false  // DPK comment
        let defaults = UserDefaults.standard
        defaults.set("1", forKey: "countryId")
        defaults.synchronize()
        
        //    let url = NSBundle.mainBundle().URLForResource("hourglas-75", withExtension: "gif")
        //    self.loaderImageView.image = UIImage.animatedImageWithAnimatedGIFData(NSData(contentsOfURL: url!)!)
        //    self.loaderImageView.hidden = true
        
        //    self.view.userInteractionEnabled = false
        
        // NSURL *url = [[NSBundle mainBundle] URLForResource:@"hourglas-75" withExtension:@"gif"];
        //   self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        //  self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        Util.copyFile("Calendar.sqlite")
        mainArray=NSMutableArray()
        mainArray = ModelManager.getInstance().functionForSelectCountry()
        //   self.view.userInteractionEnabled = true
        
        let defaultst = UserDefaults.standard
        let country =  defaultst.object(forKey: "countryName")
        let code    =  defaultst.object(forKey: "countryCode")
        // let str = defaults.valueForKey("countryId") as! String?
        print(country)
        print(code)
        
        if let country =  defaultst.object(forKey: "countryName")
        {
            countryLabel.text = country as? String
            codeLabel.text = code as? String
            
        }
        else
        {
            
            countryLabel.text = "India"
            codeLabel.text = "+91"
            let defaultst = UserDefaults.standard
            defaultst.set("1", forKey: "countryId")
            defaultst.synchronize()
            
        }
    
    }
    
    func rotaryIndiaRewampRIZoneAPI() {
            
            let completeURL = baseUrl + rIImgText
            
            let parameterst = [:] as [String:Any]
            
            print("RI parameterst:: \(parameterst)")
            print("RI completeURL:: \(completeURL)")
            
            //------------------------------------------------------
            Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    
                    
                         if let value = response.result.value {
                             do {
                                 // Attempt to decode the JSON data
                                 let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                                 let decoder = JSONDecoder()
                                 let decodedData = try decoder.decode(RIImgText.self, from: jsonData)
                                 self.everyRotarianLbl.text = "Every Rotarian and their family members will be able to use \(decodedData.registrationResult.result.table[0].applicationNameText)."
                                 self.framilyMemLbl.text = "Family members can access \(decodedData.registrationResult.result.table[0].applicationNameText) once their credentials are registered."
                                 // Access the properties of the decoded data
                                 print("RI Decoded Data:--- \(decodedData)")
                                 // Access individual properties like decodedData.propertyName
                             } catch {
                                 print("Error decoding JSON: \(error)")
                             }
                         }
                case .failure(_): break
                }
            }
    }
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="LOG IN"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Medium", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.systemBlue]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func SelectCountryAction(_ sender: AnyObject)
    {
        buttonOpticity.isHidden=false
        viewForPicker.isHidden=false
        mobileNumberField.resignFirstResponder()
        pickerSelectCountry.reloadAllComponents()
    }
    @IBAction func ProceedNextAction(_ sender: AnyObject)
    {
//        if(mobileNumberField.text! == "9988776655"){
//            let varGetSegmentIndex = UserDefaults.standard.object(forKey: "Session_SelectedIndexValue") as! String
//            let defaults = UserDefaults.standard
//            defaults.set("7777", forKey: "OTP")
//            defaults.set(mobileNumberField.text, forKey: "mobileNo")
//            defaults.set("+91", forKey: "countryCode")
//            defaults.synchronize()
//
//            varGetCountryCode = "+91"
//            varUserType = varGetSegmentIndex
//            print(mobileNumberField.text!)
//            print(varGetCountryCode)
//            print(varUserType)
//            UserDefaults.standard.setValue(mobileNumberField.text!, forKey: "session_Mobile_Number")
//            UserDefaults.standard.setValue(varGetCountryCode, forKey: "session_Country_Code")
//            UserDefaults.standard.setValue(varUserType, forKey: "session_Login_Type")
//            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "otp_verify") as UIViewController, animated: true)
//
//        }else{
            if mobileNumberField.text == ""
            {
                self.view.makeToast("Please enter mobile number.", duration: 2, position: CSToastPositionCenter)
            }
            else if(self.phoneNumberValidation(mobileNumberField.text!) == false)
            {
             self.view.makeToast("Please enter a valid mobile number.", duration: 2, position: CSToastPositionCenter)

            }
            else if (countryLabel.text == "")
            {
                self.view.makeToast("Please select country.", duration: 2, position: CSToastPositionCenter)
            }
            else
            {
                self.showAlert()
            }
//        }
    }
    
    func showAlert()
    {
        var varGetSegmentIndex = ""
        let varNotGetSegmentIndex = UserDefaults.standard.object(forKey: "Session_NotSelectedIndexValue") as? String
        
        if varNotGetSegmentIndex == "IndexSelected" {
            varGetSegmentIndex = UserDefaults.standard.object(forKey: "Session_SelectedIndexValue") as! String
        } else {
            varGetSegmentIndex = "0"
        }
        
        print(varGetSegmentIndex)
        
        if(varGetSegmentIndex == "0")
        {
            varUserType = "0"
            print("Member----------------------->",varUserType)
        }
        else if (varGetSegmentIndex == "1")
        {
            varUserType = "1"
            print("Family----------------------->",varUserType)
        }
        else
        {
        }
        appDelegate = UIApplication.shared.delegate as! AppDelegate
       if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
             {
        
        
            let createAccountAlert: UIAlertView = UIAlertView()
            createAccountAlert.delegate = self
            createAccountAlert.tag = 1
            createAccountAlert.title = String(format:"%@ %@",codeLabel.text!,mobileNumberField.text!)
            createAccountAlert.message = String(format:"One Time Password will be sent to this number")
            createAccountAlert.addButton(withTitle: "Edit")
            createAccountAlert.addButton(withTitle: "Confirm")
            createAccountAlert.show()
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        
        // SVProgressHUD.dismiss()
        }
//        let createAccountAlert: UIAlertView = UIAlertView()
//        createAccountAlert.delegate = self
//        createAccountAlert.tag = 1
//        createAccountAlert.title = String(format:"%@ %@",codeLabel.text!,mobileNumberField.text!)
//        createAccountAlert.message = String(format:"An SMS code will be sent to this number")
//        createAccountAlert.addButtonWithTitle("Edit")
//        createAccountAlert.addButtonWithTitle("Confirm")
//        createAccountAlert.show()
    }
    
    func alertView(_ View: UIAlertView, clickedButtonAt buttonIndex: Int)
    {
        if(View.tag == 1)
        {
            switch buttonIndex{
                
            case 1:
                
                
                let defaults = UserDefaults.standard
                defaults.set(mobileNumberField.text, forKey: "mobile")
                defaults.synchronize()
                
                if let str = defaults.value(forKey: "countryId") as! String?{
                  print("heelloooo team")
              print(mobileNumberField.text)
                    
                    SVProgressHUD.show()
                    
                    alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
                    self.present(alertController, animated: true, completion: nil)
                    varGetCountryCode=str
                    
                    let wsm : WebserviceClass = WebserviceClass.sharedInstance
                    wsm.delegates=self
                    wsm.signinTapped(mobileNumberField.text!,countryCode: str, loginType:varUserType)
                
                }
                
                break;
            case 0:
                
                mobileNumberField.becomeFirstResponder()
                
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
    
    var alertController = UIAlertController()
    func LoginDelegateFunction(_ loginRes: LoginResult){
        print(loginRes.status)
        print(loginRes.message)
        print(loginRes.otp)
       // self.navigationController?.view.makeToast("Coming in login delegate method")
        if(loginRes.status == "0" && loginRes.otp != "0")
        {
           // self.navigationController?.view.makeToast("Coming in if condition of login delegate method")
            let defaults = UserDefaults.standard
            defaults.set(loginRes.otp, forKey: "OTP")
            defaults.set(mobileNumberField.text, forKey: "mobileNo")
            defaults.set(codeLabel.text, forKey: "countryCode")
            defaults.synchronize()
            print(mobileNumberField.text!)
            print(varGetCountryCode)
            print(varUserType)
            UserDefaults.standard.setValue(mobileNumberField.text!, forKey: "session_Mobile_Number")
            UserDefaults.standard.setValue(varGetCountryCode, forKey: "session_Country_Code")
            UserDefaults.standard.setValue(varUserType, forKey: "session_Login_Type")
            //alertController.dismiss(animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                self.alertController.dismiss(animated: true, completion: nil)
                self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "otp_verify") as UIViewController, animated: true)
            })
            
        }
        else
        {
           // alertController.dismiss(animated: true, completion: nil)
            //self.navigationController?.view.makeToast("Coming in else condition of login delegate method")
            
           // alertController.dismiss(animated: true, completion: nil)
          let memberRegi = self.storyboard?.instantiateViewController(withIdentifier: "RotaryRegisterViewController") as! RotaryRegisterViewController
            memberRegi.varNotRegisteredMobileNumber = mobileNumberField.text!
            memberRegi.varNotRegisteredCode=codeLabel.text!
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                self.alertController.dismiss(animated: true, completion: nil)
                self.navigationController?.pushViewController(memberRegi, animated: true)
            })

            
           // self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("MemberRegistrationViewController") as UIViewController, animated: true)
         print("Open Registration Form")
            
        }
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        /*
        let width = bounds.size.width
        if(width <= 320.0)
        {
            UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations:
                {
                    self.view.frame = CGRectMake(self.view.frame.origin.x, -150 , self.view.frame.width, self.view.frame.height)
                }, completion: { finished in
            })
        }
        else
        {
        }
        */
    }
    
    
    func phoneNumberValidation(_ value: String) -> Bool {
        
        if let numRange = value.rangeOfCharacter(from: NSCharacterSet.letters) {
            return false
        } else {
            return true
        }
        
        /*
        if (value.characters.count) > 4
        {
            let charcter  = CharacterSet(charactersIn: "0123456789").inverted
            var filtered:NSString!
            let inputString:NSArray = value.components(separatedBy: charcter) as NSArray
            filtered = inputString.componentsJoined(by: "") as NSString
          //myy code
            return true
            // return  value == filtered
        }
        else
        {
            return false
        }
        */
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        if (range.length + range.location > (textField.text?.characters.count)! )
        {
            return false;
        }

        print(String(format:"Mobile Character Length - %d",(textField.text?.characters.count)!))
        
        if textField.text?.characters.count > 2
        {
            continueButton.titleLabel?.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)

            continueButton.backgroundColor = UIColor.white  //UIColor(red: (76/255.0), green: (175/255.0), blue: (80/255.0), alpha: 1.0)
           // continueButton.enabled = true
        }
        else
        {
            continueButton.titleLabel?.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
            continueButton.backgroundColor = UIColor.white   //darkGrayColor()
            //continueButton.enabled = false
        }
        
        let newLength = (textField.text?.characters.count)! + (string.characters.count) - range.length
        return newLength <= 20
    }
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(MobileLoginController.doneButtonAction))
        
        var items: [UIBarButtonItem]? = [UIBarButtonItem]()
        items?.append(flexSpace)
        items?.append(done)
        
        
        doneToolbar.setItems(items, animated: true)
        doneToolbar.sizeToFit()
        mobileNumberField.inputAccessoryView=doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        /*
        let width = bounds.size.width
        if(width <= 320.0)
        {
            UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations:
                {
                    
                    self.view.frame = CGRectMake(self.view.frame.origin.x, 0 , self.view.frame.width, self.view.frame.height)
                    
                    
                    
                }, completion: { finished in
                    
            })
            
        }
        else
        {
        }
        */
        mobileNumberField.resignFirstResponder()
    }
    
    
    
    
    func countryAndCatListDelegateFunction(_ countryCat : TBCountryResult)
    {
        print(countryCat.status)
        
        if countryCat.status == "0"
        {
            mainArray = countryCat.countryLists as NSArray
            
            print(mainArray)
            pickerSelectCountry.reloadAllComponents()
        }
        else
        {
            
        }
    }
    
    
    @IBAction func buttonOpacityClickEvent(_ sender: AnyObject)
    {
        buttonOpticity.isHidden=true
        viewForPicker.isHidden=true
    }
    
    @IBAction func buttonDoneOnPickerClickEvent(_ sender: AnyObject) {
        

        buttonOpticity.isHidden = true
        viewForPicker.isHidden = true
        //pickerSelectCountry.hidden = true
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mainArray.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
       // var countryList = GrpCountryList()
       // var varGetCountry:String = mainArray.objectAtIndex(row) as! String
        
      //  return varGetCountry
        
        
        objCalendarInfo = mainArray.object(at: row) as! CalendarInfo
        return objCalendarInfo.stringCountryMasterName
        
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
       // var varGetCountry:String = mainArray.objectAtIndex(row) as! String
        //let countryName =   varGetCountry
       // varIsSelectCountry = (row)
      //  countryLabel.text = countryName
       // buttonSelectCountry.setTitle(countryName as String, forState: .Normal)
       // buttonSelectCountry.setTitleColor(UIColor.blackColor(), forState: .Normal)
       
    
        objCalendarInfo  = CalendarInfo()
        objCalendarInfo = mainArray.object(at: row) as! CalendarInfo
        let stringCountryMasterId =   objCalendarInfo.stringCountryMasterId
        let stringCountryMasterCode =   objCalendarInfo.stringCountryMasterCode
        let stringCountryMasterName =   objCalendarInfo.stringCountryMasterName
        
        
        countryLabel.text=stringCountryMasterName
        codeLabel.text! = stringCountryMasterCode
        
        print(stringCountryMasterCode)
        print(stringCountryMasterId)
        
        
        
        let defaults = UserDefaults.standard
        defaults.set(stringCountryMasterId, forKey: "countryId")
        defaults.synchronize()
        
    }
    
    
    
}
