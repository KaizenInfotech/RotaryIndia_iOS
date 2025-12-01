//
//  ServiceAddEditViewController.swift
//  TouchBase
//
//  Created by Umesh on 19/07/16.
//  Copyright © 2016 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import MapKit
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

class ServiceAddEditViewController: UIViewController ,webServiceDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,uploadDocDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,UIGestureRecognizerDelegate{
    
 //   @IBOutlet weak var textfieldWebsite: UITextField!
    
    @IBOutlet weak var textfieldWebsite: UITextField!
    
    //    func handleTap(sender: UITapGestureRecognizer? = nil) {
    //        // handling code
    //
    //        titleText.resignFirstResponder()
    //        descText.resignFirstResponder()
    //        contcntry1Text.resignFirstResponder()
    //        contactno1Text.resignFirstResponder()
    //        contcntry2Text.resignFirstResponder()
    //        contactno2Text.resignFirstResponder()
    //        faxText.resignFirstResponder()
    //        emailText.resignFirstResponder()
    //        addressText.resignFirstResponder()
    //        cityField.resignFirstResponder()
    //        stateField.resignFirstResponder()
    //        countryField.resignFirstResponder()
    //        keywordsText.resignFirstResponder()
    //
    //
    //
    //    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    @IBOutlet weak  var titleText : UITextField!
    @IBOutlet weak  var contcntry1Text : UITextField!
    @IBOutlet weak  var contactno1Text : UITextField!
    @IBOutlet weak  var contcntry2Text : UITextField!
    @IBOutlet weak  var contactno2Text : UITextField!
    @IBOutlet weak  var faxText : UITextField!
    @IBOutlet weak  var emailText : UITextField!
    @IBOutlet weak  var keywordsText : UITextField!
    @IBOutlet weak  var descText : UITextView!
    @IBOutlet weak  var addressText : UITextView!
    @IBOutlet weak  var mapBtn : UIButton!
    @IBOutlet weak  var serviceImg : UIImageView!
    @IBOutlet weak  var addBtn : UIButton!
    
    @IBOutlet var cityField: UITextField!
    @IBOutlet var stateField: UITextField!
    @IBOutlet var countryField: UITextField!
    let button = UIButton(type: UIButton.ButtonType.custom)
    
    @IBOutlet var zipField: UITextField!
    
    @IBOutlet var serviceDirectoryScrollView: UIScrollView!
    var grpId:NSString!
    var moduleIdPassString:NSString!
    
    var imgID:NSString!
    var userId:NSString!
    let bounds = UIScreen.main.bounds
    var picker: UIDatePicker = UIDatePicker()
    let toolBar = UIToolbar()
    var myview = UIView()
    let imagePicker = UIImagePickerController()
    var TypeIDEdit :NSString!
    var isCalledFRom:NSString!
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    var countryID : NSString?
    var countryID1 : NSString?
    var serviceId : NSString!
    var latt :  NSString!
    var lont :  NSString!
    
    
    var varCity:String!=""
    var varState:String!=""
    var varCountry:String!=""
    var varZip:String!=""
    
    /*--------------------------------------------------------------*/
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(textField==contactno1Text)
        {
            let varIsValidorNot:Bool =  contactno1Text.functionForTextFieldAcceptOnlyDigit(string)
            if(varIsValidorNot == true)
            {
                return true
            }
            else
            {
                return false
            }
        }
        if(textField==contactno2Text)
        {
            let varIsValidorNot:Bool =  contactno2Text.functionForTextFieldAcceptOnlyDigit(string)
            if(varIsValidorNot == true)
            {
                return true
            }
            else
            {
                return false
            }
        }
        if(textField==faxText)
        {
            let varIsValidorNot:Bool = faxText.functionForTextFieldAcceptOnlyDigit(string)
            if(varIsValidorNot == true)
            {
                return true
            }
            else
            {
                return false
            }
        }
        
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func   functionForMainTainScrollView(_ textField:UITextField)
    {
        /*
         UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations:
         {
         self.view.frame = CGRectMake(self.view.frame.origin.x, 0 , self.view.frame.width, self.view.frame.height)
         
         
         if(textField==self.titleText)
         {
         }
         else if(textField==self.contcntry1Text)
         {
         }
         else if(textField==self.contcntry2Text || textField==self.contactno2Text)
         {
         self.serviceDirectoryScrollView.contentOffset = CGPointMake(0,270);
         }
         else if(textField==self.faxText )
         {
         self.serviceDirectoryScrollView.contentOffset = CGPointMake(0,360);
         }
         else if(textField==self.emailText )
         {
         
         self.serviceDirectoryScrollView.contentOffset = CGPointMake(0,450);
         }
         else if(textField==self.cityField || textField==self.stateField)
         {
         self.serviceDirectoryScrollView.contentOffset = CGPointMake(0,680);
         }
         else if(textField==self.countryField || textField==self.zipField)
         {
         self.serviceDirectoryScrollView.contentOffset = CGPointMake(0,700);
         }
         else if(textField==self.keywordsText )
         {
         self.serviceDirectoryScrollView.contentOffset = CGPointMake(0,750);
         }
         
         }, completion: { finished in
         })
         */
    }
    // func textFieldShouldReturn(textField: UITextField) -> Bool
    /// {
    /*
     functionForMainTainScrollView(textField)
     
     UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations:
     {
     self.view.frame = CGRectMake(self.view.frame.origin.x, 0 , self.view.frame.width, self.view.frame.height)
     
     
     
     if(textField==self.titleText)
     {
     self.descText.becomeFirstResponder()
     }
     else if(textField==self.contcntry1Text)
     {
     self.contactno1Text.becomeFirstResponder()
     }
     else if(textField==self.contactno1Text)
     {
     self.contcntry2Text.becomeFirstResponder()
     }
     else if(textField==self.contcntry2Text )
     {
     self.contactno2Text.becomeFirstResponder()
     
     }
     else if(textField==self.contactno2Text )
     {
     self.faxText.becomeFirstResponder()
     }
     else if(textField==self.faxText)
     {
     self.emailText.becomeFirstResponder()
     
     }
     else if(textField==self.emailText)
     {
     self.addressText.becomeFirstResponder()
     }
     else if(textField==self.cityField )
     {
     self.stateField.becomeFirstResponder()
     }
     else if(textField==self.stateField )
     {
     self.countryField.becomeFirstResponder()
     }
     else if(textField==self.countryField )
     {
     self.zipField.becomeFirstResponder()
     }
     else if(textField==self.zipField )
     {
     self.keywordsText.becomeFirstResponder()
     }
     else if(textField==self.keywordsText)
     {
     self.serviceDirectoryScrollView.contentOffset = CGPointMake(0,-100);
     self.keywordsText.resignFirstResponder()
     }
     
     
     
     }, completion: { finished in
     })
     */
    // keywordsText.resignFirstResponder()
    
    //        memberNameField.resignFirstResponder()
    //        memberEmailField.resignFirstResponder()
    //        mobileNumberField.resignFirstResponder()
    
    //   return true
    // }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        //  functionForMainTainScrollView(textField)
        
        if(textField == contcntry1Text )
        {
            textField.resignFirstResponder()
            let defaults = UserDefaults.standard
            defaults.set("1", forKey: "contact")
            defaults.synchronize()
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "country_code") as UIViewController, animated: true)
            
        }
        else   if(textField == contcntry2Text )
        {
            textField.resignFirstResponder()
            let defaults = UserDefaults.standard
            defaults.set("2", forKey: "contact")
            defaults.synchronize()
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "country_code") as UIViewController, animated: true)
            
        }
        else if(textField==contactno1Text)
        {
            
        }
        
        
        
        
        
        
        
        
        
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            if(textView==descText)
            {
                //contcntry1Text.becomeFirstResponder()
            }
            else if(textView==addressText)
            {
               // cityField.becomeFirstResponder()
                // serviceDirectoryScrollView.contentOffset = CGPointMake(0,620);
                
            }
            return false
        }
        
        
        
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView){
        /*
         if(textView==descText)
         {
         serviceDirectoryScrollView.contentOffset = CGPointMake(0,100);
         }
         else  if(textView==addressText)
         {
         serviceDirectoryScrollView.contentOffset = CGPointMake(0,550);
         }
         */
        
        
    }
    
    // func textFieldShouldReturn(textField: UITextField) -> Bool {
    //
    //        print("TextField should return method called")
    //        textField.resignFirstResponder();
    //        return true;
    //    }
    
    // UITextField Delegates
    
    
    //    func textFieldDidEndEditing(textField: UITextField) {
    //
    //        print("TextField did end editing method called\(textField.text)")
    //    }
    //
    //    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    //
    //        print("TextField should begin editing method called")
    //        return true;
    //    }
    //
    //
    //
    //    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
    //        print("TextField should end editing method called")
    //        return true;
    //    }
    //
    //
    //
    //
    //    func textFieldShouldReturn(textField: UITextField) -> Bool {
    //
    //        print("TextField should return method called")
    //        textField.resignFirstResponder();
    //        return true;
    //    }
    /*----------------------------------------------------------------------*/
    
    
    
    
    
    var appDelegate : AppDelegate!
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Service Directory" as String
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AboutUsViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
  @objc  func functionForHideKeyboard()
    {
        
        titleText.resignFirstResponder()
        descText.resignFirstResponder()
        contcntry1Text.resignFirstResponder()
        contactno1Text.resignFirstResponder()
        contcntry2Text.resignFirstResponder()
        contactno2Text.resignFirstResponder()
        faxText.resignFirstResponder()
        emailText.resignFirstResponder()
        addressText.resignFirstResponder()
        cityField.resignFirstResponder()
        stateField.resignFirstResponder()
        countryField.resignFirstResponder()
        keywordsText.resignFirstResponder()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.setStyle()
        /*-----------------------------------*/
       //delete print(TypeIDEdit as? String)
       // print(grpId as? String)
        
        
        
        addDoneButtonOnKeyboard()
        UserDefaults.standard.set("1", forKey: "sessionISValue")

        
//        self.edgesForExtendedLayout = []
        serviceDirectoryScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(functionForHideKeyboard)))
        
        serviceDirectoryScrollView.delegate = self
                button.setTitle("Next",  for: UIControl.State.normal)
                button.setTitleColor(UIColor.black,  for: UIControl.State.normal)
                button.frame = CGRect(x: 0, y: 163, width: 106, height: 53)
                button.adjustsImageWhenHighlighted = false
                button.addTarget(self, action: "Done:", for: UIControl.Event.touchUpInside)
        
        
        
        titleText.delegate=self
        descText.delegate=self
        contcntry1Text.delegate=self
        contactno1Text.delegate=self
        contcntry2Text.delegate=self
        contactno2Text.delegate=self
        faxText.delegate=self
        emailText.delegate=self
        addressText.delegate=self
        cityField.delegate=self
        stateField.delegate=self
        countryField.delegate=self
        zipField.delegate=self
        keywordsText.delegate=self
        
        contactno1Text.returnKeyType = UIReturnKeyType.done
        
        
        
//        self.edgesForExtendedLayout = []
        functionForSetLeftNavigation()
        
        // var frame = self.view.frame
        // frame.origin.y = 64 //The height of status bar + navigation bar
        //print(moduleIdPassString as String)
        //print(moduleIdPassString)
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        serviceDirectoryScrollView.contentSize=CGSize(width: serviceDirectoryScrollView.frame.size.width, height: 1400)
        print("..width..\(width)")
        print("..height..\(height)")
        
        
        //createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        imgID = ""
        countryID = ""
        countryID1 = ""
        imagePicker.delegate = self
        if(isCalledFRom == "edit"){
            print(grpId)
            print(serviceId)
            self.title = "Update Service"
            addBtn.setTitle("Update",  for: UIControl.State.normal)
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            wsm.getDetailServiceDirList(grpId, serviceDirId: serviceId)
            
            
//            cityField.text=varCity
//            stateField.text=varState
//            countryField.text=varCountry
//            zipField.text=varZip

            cityField.text=UserDefaults.standard.value(forKey: "session_City") as? String
            stateField.text=UserDefaults.standard.value(forKey: "session_State") as? String
            countryField.text=UserDefaults.standard.value(forKey: "session_Country") as? String
            zipField.text=UserDefaults.standard.value(forKey: "session_Zip") as? String
            
            
            
            
            
            
            
            
            
            
        }else{
            self.title = "New Service"
            addBtn.setTitle("Add",  for: UIControl.State.normal)
        }
        latt = "0.00"
        lont = "0.00"
        
    }
    
    func isValidEmail(_ testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    @IBAction func AddMapServiceAction(_ sender: AnyObject){
        
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "servicemap") as! ServiceMapViewController
        profVC.vnLat = latt
        profVC.vnLon = lont
        profVC.locName = addressText.text! as NSString
        self.navigationController?.pushViewController(profVC, animated: true)
    }
    @IBAction func cancelServiceAction(_ sender: AnyObject){
        self.navigationController?.popViewController(animated: true)
    }
    func getdetServiceDirListDelegate(_ entityInfo : TBServiceDirectoryListResult){
        if (entityInfo.status == "0")
        {
            
            let mainArray = entityInfo.serviceDirListResult as NSArray
            var directoryList = ServiceDirList()
            directoryList = mainArray.object(at: 0) as! ServiceDirList
            
            titleText.text! = directoryList.serviceMemberName
            descText.text! = directoryList.serviceDescription
            faxText.text! = directoryList.servicePaxNo
            keywordsText.text! = directoryList.serviceKeywords
            addressText.text! = directoryList.serviceAddress
            latt = directoryList.serviceLatitude as! NSString
            lont = directoryList.serviceLongitude as! NSString
            emailText.text! = directoryList.serviceEmail
            countryID1 = directoryList.serviceCountry2 as! NSString
            countryID = directoryList.serviceCountry1 as! NSString
            if(directoryList.serviceMobile1.characters.count > 0){
                var myStringArr = directoryList.serviceMobile1.components(separatedBy: "-")
                contcntry1Text.text! = myStringArr[0]
                contactno1Text.text! = myStringArr[1]
            }
            if(directoryList.serviceMobile2.characters.count > 0){
                var myStringArr1 = directoryList.serviceMobile2.components(separatedBy: "-")
                contcntry2Text.text! = myStringArr1[0]
                contactno2Text.text! = myStringArr1[1]
            }
            if let checkedUrl = URL(string: directoryList.serviceThumbimage) {
                //Working in swift new version 03-08-2018
                self.serviceImg.sd_setImage(with: checkedUrl)
//                appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
//                    DispatchQueue.main.async { () -> Void in
//                        guard let data = data, error == nil else { return }
//                        print(response?.suggestedFilename ?? "")
//                        print("Download Finished")
//                        self.serviceImg.image = UIImage(data: data)
//                        //cell.indicator.stopAnimating()
//
//                    }
//                }
            }        }
    }
    func DoneTextView()
    {
        
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
                
                
            }, completion: { finished in
                
        })
        if(self.addressText.text.characters.count > 0){
            let geocoder: CLGeocoder = CLGeocoder()
            geocoder.geocodeAddressString(self.addressText.text!,completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                
                if((error) != nil){
                    print("Error", error)
                    self.lont = ""
                    self.latt = ""
                }
                
                if let placemark = placemarks?.first {
                    let topResult: CLPlacemark = (placemarks?[0])!
                    let placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    self.latt = String(coordinates.latitude) as NSString
                    self.lont = String(coordinates.longitude) as NSString
                    print(String(format:"venue : %@",self.latt))
                }
            } as! CLGeocodeCompletionHandler)
        }
        contactno1Text.resignFirstResponder()
        contactno2Text.resignFirstResponder()
        addressText.resignFirstResponder()
        descText.resignFirstResponder()
        // keywordsText.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func AddServiceAction(_ sender: AnyObject)
    {
        
        if(titleText.text?.characters.count == 0 )
        {
//            let alert: UIAlertView = UIAlertView()
//            alert.delegate = self
//            alert.title = ""
//            alert.message = String(format:"Please enter title.")
//            alert.addButtonWithTitle("Ok")
//            alert.show()
            
            self.view!.makeToast("Please enter title", duration: 2, position: CSToastPositionCenter)
            
            
            
        }
        else if(contcntry1Text.text?.characters.count > 0 && contactno1Text.text?.characters.count <= 0)
        {
            //|| [contcntry1Text.text?.characters.count > 0]
//            let alert: UIAlertView = UIAlertView()
//            alert.delegate = self
//            alert.title = ""
//            alert.message = String(format:"Please enter Contact Number1.")
//            alert.addButtonWithTitle("Ok")
//            alert.show()
            
            
            self.view!.makeToast("Please enter Contact Number1", duration: 2, position: CSToastPositionCenter)
            
            
        }
        else if(contactno1Text.text?.characters.count > 0 && contcntry1Text.text?.characters.count <= 0)
        {
            //|| [contcntry1Text.text?.characters.count > 0]
//            let alert: UIAlertView = UIAlertView()
//            alert.delegate = self
//            alert.title = ""
//            alert.message = String(format:"Please enter Country Code1.")
//            alert.addButtonWithTitle("Ok")
//            alert.show()
            
            self.view!.makeToast("Please enter Contact Code1", duration: 2, position: CSToastPositionCenter)
            
        }
        else if(contcntry2Text.text?.characters.count > 0 && contactno2Text.text?.characters.count <= 0 )
        {
            //|| [contcntry1Text.text?.characters.count > 0]
//            let alert: UIAlertView = UIAlertView()
//            alert.delegate = self
//            alert.title = ""
//            alert.message = String(format:"Please enter Contact Number2.")
//            alert.addButtonWithTitle("Ok")
//            alert.show()
            
            self.view!.makeToast("Please enter Contact Number2", duration: 2, position: CSToastPositionCenter)

            
        }
        else if(contactno2Text.text?.characters.count > 0 && contcntry2Text.text?.characters.count <= 0 )
        {
            //|| [contcntry1Text.text?.characters.count > 0]
//            let alert: UIAlertView = UIAlertView()
//            alert.delegate = self
//            alert.title = ""
//            alert.message = String(format:"Please enter Country Code2.")
//            alert.addButtonWithTitle("Ok")
//            alert.show()
            
            self.view!.makeToast("Please enter Country Code2", duration: 2, position: CSToastPositionCenter)
            

            
            
        }
        else if(emailText.text?.characters.count > 0)
        {
            let isValid = isValidEmail(emailText.text!)
            if(isValid == false)
            {
                /*
                let alert = UIAlertController(title: "", message: "Please enter a valid Email Address", preferredStyle: UIAlertController.Style.Alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
                self.presentViewController(alert, animated: true, completion: nil)
                */
                
                self.view.makeToast("Please enter a valid Email Address", duration: 2, position: CSToastPositionCenter)

            }
            else
            {
                var varGetValue:Bool=true
                if(textfieldWebsite.text?.characters.count > 0)
                {
                    
                     varGetValue = verifyUrl(textfieldWebsite.text) // true
                }
                if(varGetValue==true)
                {
                let wsm : WebserviceClass = WebserviceClass.sharedInstance
                wsm.delegates=self
                
                if(isCalledFRom == "edit"){
                    
                    appDelegate = UIApplication.shared.delegate as! AppDelegate
                     if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                    {
                        let description:String = descText.text!
                        let replacedDescription = (description as NSString).replacingOccurrences(of: "'", with: "`")
                        let address:String = addressText.text!
                        let replacedAddress = (address as NSString).replacingOccurrences(of: "'", with: "`")
                        
                        wsm.addeditServiceDirList(serviceId, groupId: grpId, memberName: titleText.text! as! NSString, description: replacedDescription as NSString, image: imgID, countryCode1: countryID!, mobileNo1: contactno1Text.text! as NSString, countryCode2: countryID1!, mobileNo2: contactno2Text.text! as NSString as NSString, paxNo: faxText.text! as NSString, email: emailText.text! as NSString, keywords: keywordsText.text! as NSString, address: replacedAddress as NSString, latitude: latt, longitude: lont, createdBy: userId,city: cityField.text! as NSString as NSString, state: stateField.text! as NSString,country:countryField.text! as NSString, zip_Code:zipField.text! as NSString,moduleId:moduleIdPassString,stringWebSite: textfieldWebsite.text! as NSString)
                   
                     
                     }
                    else
                    {
                      self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                         SVProgressHUD.dismiss()
                    }
                    
                }else
                {
                    
                    appDelegate = UIApplication.shared.delegate as! AppDelegate
                     if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                    {
                        let description:String = descText.text!
                        let replacedDescription = (description as NSString).replacingOccurrences(of: "'", with: "`")
                        let address:String = addressText.text!
                        let replacedAddress = (address as NSString).replacingOccurrences(of: "'", with: "`")
                        
                        wsm.addeditServiceDirList(serviceId, groupId: grpId, memberName: titleText.text! as! NSString, description: replacedDescription as NSString, image: imgID, countryCode1: countryID!, mobileNo1: contactno1Text.text! as NSString, countryCode2: countryID1!, mobileNo2: contactno2Text.text! as NSString as NSString, paxNo: faxText.text! as NSString as NSString, email: emailText.text! as NSString as NSString, keywords: keywordsText.text! as NSString as NSString, address: replacedAddress as NSString, latitude: latt, longitude: lont, createdBy: userId,city: cityField.text! as NSString, state: stateField.text! as NSString,country:countryField.text! as NSString, zip_Code:zipField.text! as NSString,moduleId:moduleIdPassString,stringWebSite: textfieldWebsite.text! as NSString)
                   
                     
                     
                     }
                    else
                    {
                        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                         SVProgressHUD.dismiss()
                    }
                }
                }
                else
                {
                    self.view.makeToast("Please enter valid web URL", duration: 2, position: CSToastPositionCenter)
                    

                }
                
            }
        }
         
        else
        {
            var varGetValue:Bool=true
            if(textfieldWebsite.text?.characters.count > 0)
            {
                
                varGetValue = verifyUrl(textfieldWebsite.text) // true
            }
            if(varGetValue==true)
            {
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            
            if(isCalledFRom == "edit")
            {
                appDelegate = UIApplication.shared.delegate as! AppDelegate
             
                 if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                {
                    let description:String = descText.text!
                    let replacedDescription = (description as NSString).replacingOccurrences(of: "'", with: "`")
                    let address:String = addressText.text!
                    let replacedAddress = (address as NSString).replacingOccurrences(of: "'", with: "`")
                    wsm.addeditServiceDirList(serviceId, groupId: grpId, memberName: titleText.text! as! NSString, description: replacedDescription as NSString, image: imgID, countryCode1: countryID!, mobileNo1: contactno1Text.text! as NSString, countryCode2: countryID1!, mobileNo2: contactno2Text.text! as NSString, paxNo: faxText.text! as NSString, email: emailText.text! as NSString, keywords: keywordsText.text! as NSString, address: replacedAddress as NSString, latitude: latt, longitude: lont, createdBy: userId,city: cityField.text! as NSString, state: stateField.text! as NSString,country:countryField.text! as NSString, zip_Code:zipField.text! as NSString,moduleId:moduleIdPassString,stringWebSite: textfieldWebsite.text! as NSString)
                    
                    
                    UserDefaults.standard.setValue(cityField.text!, forKey: "session_City")
                    UserDefaults.standard.setValue(stateField.text!, forKey: "session_State")
                    UserDefaults.standard.setValue(countryField.text!, forKey: "session_Country")
                    UserDefaults.standard.setValue(zipField.text!, forKey: "session_Zip")
                    
                    
                }
                else
                {
                    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                     SVProgressHUD.dismiss()
                }
            }
            else
            {
                appDelegate = UIApplication.shared.delegate as! AppDelegate
                 if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                {
                    let description:String = descText.text!
                    let replacedDescription = (description as NSString).replacingOccurrences(of: "'", with: "`")
                    let address:String = addressText.text!
                    let replacedAddress = (address as NSString).replacingOccurrences(of: "'", with: "`")
                    
                    wsm.addeditServiceDirList(serviceId, groupId: grpId, memberName: titleText.text! as! NSString, description: replacedDescription as NSString, image: imgID, countryCode1: countryID!, mobileNo1: contactno1Text.text! as NSString, countryCode2: countryID1!, mobileNo2: contactno2Text.text! as NSString, paxNo: faxText.text! as NSString, email: emailText.text! as NSString, keywords: keywordsText.text! as NSString, address: replacedAddress as NSString, latitude: latt, longitude: lont, createdBy: userId,city: cityField.text! as NSString, state: stateField.text! as NSString,country:countryField.text! as NSString, zip_Code:zipField.text! as NSString,moduleId:moduleIdPassString,stringWebSite: textfieldWebsite.text! as NSString)
               
                 
                 
                 }
                else
                {
                    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                     SVProgressHUD.dismiss()
                }
            }
            }
            else
            {
                self.view.makeToast("Please enter valid web URL", duration: 2, position: CSToastPositionCenter)
            }
        }
        
    }
    func verifyUrl (_ urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url  = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }

    func addServiceDirListDelegate(_ entityInfo : TBAddServiceResult)
    {
        print(entityInfo.message)
        if entityInfo.status == "1"
        {
            
        }
        else
        {
            if(isCalledFRom != "list"){
                let alert = UIAlertController(title: "Service", message: "Updated successfully.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                    // self.selectedImg=nil
                    self.imgID=""
                    
                    
                    UserDefaults.standard.set("", forKey: "profID")
                    UserDefaults.standard.set("", forKey: "groupsID")
                    
                    
                    UserDefaults.standard.setValue(self.cityField.text!, forKey: "session_City")
                    UserDefaults.standard.setValue(self.stateField.text!, forKey: "session_State")
                    UserDefaults.standard.setValue(self.countryField.text!, forKey: "session_Country")
                    UserDefaults.standard.setValue(self.zipField.text!, forKey: "session_Zip")
                    
                    print(self.cityField.text!)
                    print(self.stateField.text!)
                    print(self.countryField.text!)
                    print(self.zipField.text!)
                    
                    self.navigationController?.popViewController(animated: true)
                    
                    /*
                    let dashboardVC = self.navigationController?.viewControllers.filter { $0 is ServiceDirectoryListViewController }.first!
                    self.navigationController?.popToViewController(dashboardVC!, animated: true)
                    */
                    
                }));
                self.present(alert, animated: true, completion: nil)
                
                
            }
            else
            {
                let alert = UIAlertController(title: "Service", message: "Added successfully.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                    // self.selectedImg=nil
                    self.imgID=""
                    UserDefaults.standard.set("", forKey: "profID")
                    UserDefaults.standard.set("", forKey: "groupsID")
                    self.navigationController?.popViewController(animated: true)
                    
                }));
                self.present(alert, animated: true, completion: nil)
                
                
                
            }
            
            
        }
        
    }
    
    //    func updateSuccss(update : ServiceDirResult)
    //    {
    ////        print(update.status)
    ////        print(update.message)
    //
    //        if update.status == "0"
    //        {
    //            let defaults = NSUserDefaults.standardUserDefaults()
    //            defaults.setObject("", forKey: "memberName")
    //            defaults.setObject("", forKey: "countryCode")
    //            defaults.setObject("", forKey: "countryId")
    //            defaults.setObject("", forKey: "keyword")
    //            self.navigationController?.popViewControllerAnimated(true)
    //        }
    //        else
    //        {
    //            let Alert: UIAlertView = UIAlertView()
    //            Alert.delegate = self
    //            Alert.title = "Rotary India"
    //            Alert.message = "update  Failed please Contact Administrator"
    //            Alert.addButtonWithTitle("Ok")
    //            Alert.show()
    //        }
    //
    //    }
    //
    //
    
    
    
    
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style:  UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        
        var items: [UIBarButtonItem]? = [UIBarButtonItem]()
        items?.append(flexSpace)
        items?.append(done)
        
        
        doneToolbar.setItems(items, animated: true)
        doneToolbar.sizeToFit()
         contactno1Text.inputAccessoryView=doneToolbar
        contactno2Text.inputAccessoryView=doneToolbar
         faxText.inputAccessoryView=doneToolbar
  
    }
    
    @objc func doneButtonAction()
    {
        
 
                self.titleText.resignFirstResponder()
                self.descText.resignFirstResponder()
                self.contcntry1Text.resignFirstResponder()
                self.contactno1Text.resignFirstResponder()
                self.contcntry2Text.resignFirstResponder()
                self.contactno2Text.resignFirstResponder()
                self.faxText.resignFirstResponder()
                self.emailText.resignFirstResponder()
                self.addressText.resignFirstResponder()
                self.cityField.resignFirstResponder()
                self.stateField.resignFirstResponder()
                self.countryField.resignFirstResponder()
                self.keywordsText.resignFirstResponder()

                
       
        
    }
    
    //    func updateButton()
    //    {
    //        let updateToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0,0,self.view.frame.width,100))
    //        updateToolbar.barStyle = UIBarStyle.Default
    //
    //        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.FlexibleSpace, target: nil, action: nil)
    //
    //        let update: UIBarButtonItem = UIBarButtonItem(title: "Update", style: UIBarButtonItem.Style.Done, target: self, action: #selector(ServiceAddEditViewController.doneButtonAction))
    //       var items : [UIBarButtonItem]? = [UIBarButtonItem]()
    //        items?.append(flexSpace)
    //        items?.append(update)
    //        updateToolbar.setItems(items, animated: true)
    //        updateToolbar.sizeToFit()
    //    }
    //    func updateButtonAction()
    //    {
    //
    //        UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations:
    //            {
    //
    //                self.view.frame = CGRectMake(self.view.frame.origin.x, 0 , self.view.frame.width, self.view.frame.height)
    //
    //
    //
    //            }, completion: { finished in
    //
    //        })
    //
    //
    //    }
    //
    
    
    
    
    
    @IBAction func imgBtnClick(_ sender: AnyObject){
        OpenGallaryBAction()
    }
    func OpenGallaryBAction()
    {
        self.view.endEditing(true)
        if isCalledFRom != "list"
        {
            let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Remove photo","Change photo")
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
        
        if actionSheet.tag == 0
        {
            switch (buttonIndex)
            {
                
            case 0:
                print("Cancel")
                
                self.dismiss(animated: true, completion: nil)
                
            case 1:
                
                
                
                let wsm : WebserviceClass = WebserviceClass.sharedInstance
                wsm.delegates=self
                
               // print(TypeIDEdit)
               // print(grpId as String)
                
                //cod
                
                wsm.DeletePhotoEdit(serviceId as String, grpID: grpId as String, type: "ServiceDirectory",moduleId: "")//avinash
                
            case 2:
                
                let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
                actionSheet.delegate = self
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
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = .photoLibrary
                //if #available(iOS 8.0, *) {
                self.imagePicker.modalPresentationStyle = .popover
                // } else {
                //     // Fallback on earlier versions
                // }
                self.present(self.imagePicker, animated: true, completion: nil)
                
            case 2:
                 openCamera()
//                //shows the camera
//                self.imagePicker.allowsEditing = true
//                self.imagePicker.sourceType = .Camera
//                //   if #available(iOS 8.0, *) {
//                self.imagePicker.modalPresentationStyle = .Popover
//                //   } else {
//                // Fallback on earlier versions
//                //  }
//                self.presentViewController(self.imagePicker, animated: true, completion: nil)
            case 3:
                // let cell = cellArray.objectAtIndex(0) as! AnnounceHeaderCell
                serviceImg.image=UIImage(named: "addevent.png")
                imgID=""
            default:
                print("Default")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[String : Any])
    {
        //  let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        //  let cell = cellArray.objectAtIndex(0) as! AnnounceHeaderCell
        
        var chosenImage:UIImage! //2
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            chosenImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            chosenImage = possibleImage
        }
        
        /*----------------------------------------------*/
//        let imgData: Data = NSData(data: UIImageJPEGRepresentation((chosenImage), 1)!) as Data
        let imgData: Data = NSData(data: chosenImage.jpegData(compressionQuality: 1)!) as Data

        let imageSize: Int = imgData.count
        // let imagexSize: Int = imgData.length
        let vargetImageInKB:Float = Float(imageSize/1024)
        let vargetImageInMB:Float = Float(vargetImageInKB/1024)
        let varGetSplitArray = String(vargetImageInMB).components(separatedBy: ".")
        if(varGetSplitArray[0]>"0")
        {
            self.view!.makeToast("Image is too large, maximum size 1 MB", duration: 2, position: CSToastPositionCenter)
            
        }
        else
        {
         
            
            serviceImg.image=chosenImage
           // loaderViewMethod()
            let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
            wsm.delegate=self
//            let imageData: Data = UIImagePNGRepresentation(chosenImage)!
            let imageData: Data = chosenImage.pngData()!
            wsm.uploadToServer(usingImage: imageData, andFileName: "servicedirectory", moduleName: "servicedirectory")
            
            
        }
        
        /*-------------------------------------------------------------------------*/
        
        
        
        
        
        
        
        
        dismiss(animated: true, completion: nil) //5
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
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func getUploadImgSucceeded(_ response: LoadImageResult)
    {
        
        if response.status == "0"
        {
            imgID=response.imageID as! NSString;
            window=nil;
        }
        else
        {
            window=nil;
            /*
            let alert = UIAlertController(title: "Rotary India", message: "Image Upload failed, Please try Again!", preferredStyle: UIAlertController.Style.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Cancel, handler:nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            */
            
            self.view.makeToast("Image Upload failed, Please try again", duration: 2, position: CSToastPositionCenter)

            
        }
        
    }
    func DeletePhotoDelegateFunction(_ dltPhoto : DeleteResult)
    {
        print(dltPhoto.status)
        //let cell = cellArray.objectAtIndex(0) as! AnnounceHeaderCell
        serviceImg.image=UIImage(named: "addevent.png")
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let defaults = UserDefaults.standard
        let country =  defaults.object(forKey: "countryName")
        let code    =  defaults.object(forKey: "countryCode")
        let contact    =  defaults.object(forKey: "contact")
        var varGetValue:String! =   UserDefaults.standard.value(forKey: "sessionISValue") as! String
        if(varGetValue=="1")
        {
            print(country)
            print(code)
            if(contact as? String == "1"){
                if let country =  defaults.object(forKey: "countryName")
                {
                    contcntry1Text.text = code as? String
                    countryID = defaults.value(forKey: "countryId") as! NSString
                    let defaults = UserDefaults.standard
                    defaults.set("0", forKey: "contact")
                    defaults.synchronize()
                    // codeLabel.text = code as? String
                }
            }else if(contact as? String == "2"){
                contcntry2Text.text = code as? String
                countryID1 = defaults.value(forKey: "countryId") as! NSString 
                let defaults = UserDefaults.standard
                defaults.set("0", forKey: "contact")
                defaults.synchronize()
            }
                
            else
            {
                //            countryLabel.text = "India"
                //            codeLabel.text = "+91"
                //            let defaults = NSUserDefaults.standardUserDefaults()
                //            defaults.setObject("1", forKey: "countryId")
                //            defaults.synchronize()
                //
                //            countryID = "1"
                
            }
            
            if(self.addressText.text.characters.count > 0){
                
                
                
                if(defaults.object(forKey: "serviceLat") as? String==nil)
                {
                    
                }
                else
                {
                    latt = defaults.object(forKey: "serviceLat") as! String as NSString
                    lont = defaults.object(forKey: "serviceLon") as! String as NSString
                }
                
                /*--code by Rajendra Jat if latt and lont be empty*/
                // latt = "0.00"
                //  lont = "0.00"
                
                print("ven \(latt)")
                print("vent \(lont)")
            }
            UserDefaults.standard.set("0", forKey: "sessionISValue")

        }
        else
        {
            
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func updateServiceDirectoryListDelegate(_ entityInfo : TBServiceDirectoryResult){
        if (entityInfo.status == "0")
        {
            
            let mainArray = entityInfo.serviceDirectoryResult as NSArray
            var directoryList = ServiceDirList()
            directoryList = mainArray.object(at: 0) as! ServiceDirList
            
            titleText.text! = directoryList.serviceMemberName
            descText.text! = directoryList.serviceDescription
            faxText.text! = directoryList.servicePaxNo
            keywordsText.text! = directoryList.serviceKeywords
            addressText.text! = directoryList.serviceAddress
            latt = directoryList.serviceLatitude as! NSString
            lont = directoryList.serviceLongitude as! NSString
            emailText.text! = directoryList.serviceEmail
            countryID1 = directoryList.serviceCountry2 as! NSString
            countryID = directoryList.serviceCountry1 as! NSString
            if(directoryList.serviceMobile1.characters.count > 0){
                var myStringArr = directoryList.serviceMobile1.components(separatedBy: "-")
                contcntry1Text.text! = myStringArr[0]
                contactno1Text.text! = myStringArr[1]
            }
            if(directoryList.serviceMobile2.characters.count > 0){
                var myStringArr1 = directoryList.serviceMobile2.components(separatedBy: "-")
                contcntry2Text.text! = myStringArr1[0]
                contactno2Text.text! = myStringArr1[1]
            }
            if let checkedUrl = URL(string: directoryList.serviceThumbimage) {
                //Working in swift new version 03-08-2018
                self.serviceImg.sd_setImage(with: checkedUrl)
//                appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
//                    DispatchQueue.main.async { () -> Void in
//                        guard let data = data, error == nil else { return }
//                        print(response?.suggestedFilename ?? "")
//                        print("Download Finished")
//                        self.serviceImg.image = UIImage(data: data)
//                        //cell.indica
//
//
//
//                    }
//                }
                
            }
        }
        /*----------*/
        
        //--
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    //    func keyboardWillShow(note : NSNotification) -> Void{
    //
    //        dispatch_async(dispatch_get_main_queue()) { () -> Void in
    //
    //            self.button.hidden = false
    //            let keyBoardWindow = UIApplication.sharedApplication().windows.last
    //            self.button.frame = CGRectMake(0, (keyBoardWindow?.frame.size.height)!-53, 106, 53)
    //            keyBoardWindow?.addSubview(self.button)
    //            keyBoardWindow?.bringSubviewToFront(self.button)
    //
    //            UIView.animateWithDuration(((note.userInfo! as NSDictionary).objectForKey(UIKeyboardAnimationCurveUserInfoKey)?.doubleValue)!, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
    //
    //                self.view.frame = CGRectOffset(self.view.frame, 0, 0)
    //                }, completion: { (complete) -> Void in
    //                    print("Complete")
    //            })
    //        }
    //
    //    }
    //
    //    func Done(sender : UIButton){
    //
    //        dispatch_async(dispatch_get_main_queue()) { () -> Void in
    //
    //            self.contcntry2Text.becomeFirstResponder()
    //
    //        }
    //    }
    //
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
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style:.Default, handler: nil)
            alert.addAction(ok)
            presentViewController(alert, animated: true, completion: nil)
            */
            
            self.view.makeToast("Camera Not Found, this device has no Camera", duration: 2, position: CSToastPositionCenter)

        }
    }
    /*-----------------code by dpk -------------------*/
}
