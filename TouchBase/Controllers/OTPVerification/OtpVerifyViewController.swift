//
//  OtpVerifyViewController.swift
//  TouchBase
//
//  Created by Umesh on 25/11/15.
//  Copyright © 2015 Parag. All rights reserved.
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


class OtpVerifyViewController: UIViewController , UITextFieldDelegate , webServiceDelegate, XMLParserDelegate {
    
    @IBOutlet var resendOTPButton: UIButton!
    
    @IBOutlet weak var buttonContinue: UIButton!
    let bounds = UIScreen.main.bounds
    var count = 59
    var timer = Timer()
    @IBOutlet var OTPField1: UITextField!
    @IBOutlet var OTPField2: UITextField!
    @IBOutlet var OTPField3: UITextField!
    @IBOutlet var OTPField4: UITextField!
    @IBOutlet var CountDownTimerLable: UILabel!
    
    
    //MARK:- New variables
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    var description11 = NSMutableString()
    var varLink = NSMutableString()

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        
        OTPField1.text! = ""
        OTPField2.text! = ""
        OTPField3.text! = ""
        OTPField4.text! = ""
        OTPField1.becomeFirstResponder()
    }
    func functionForTruncateXMLData()
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
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            //1.
            let insertSQL = "DELETE FROM NewsUpdate_Table"
            print(insertSQL)
            let result = contactDB?.executeStatements(insertSQL)
            if result == nil
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success delete NewsUpdate_Table from OTP verify Controller")
            }
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
    }
    func beginParsingBlog()
    {
        let todoEndpoint: String = "https://blog.rotary.org/feed/"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            // do stuff with response, data & error here
            print(error as Any)
            print(response as Any)
            if data == nil {
                print("dataTaskWithRequest error: \(error)")
                print("777777777777777777777777777777777777777777777777777777777777777777777777777777")
                return
            }
            else
            {
                self.varWhichRssFeedRun = "Blogs"
                self.posts = []
                // parser = NSXMLParser(contentsOfURL:(NSURL(string:"https://blog.rotary.org/feed/"))!)!
                self.parser = XMLParser(contentsOf:(URL(string:"https://blog.rotary.org/feed/"))!)!
                
                self.parser.delegate = self
                self.parser.parse()
                print("ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg")
            }
        })
        task.resume()
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
            description11 = NSMutableString()
            description11 = ""
            varLink = NSMutableString()
            varLink = ""
            
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (elementName as NSString).isEqual(to: "item") {
            if !title1.isEqual(nil) {
                // print("TITLE-------------------------->",title1)
                elements.setObject(title1, forKey: "title" as NSCopying)
                //print("TITLE-------------------123123",stringArrayTitle)
            }
            if !date.isEqual(nil) {
                // print("DATE-------------------------->",date)
                elements.setObject(date, forKey: "date" as NSCopying)
            }
            if !description11.isEqual(nil) {
                // print("DESC-------------------------->",description11)
                elements.setObject(description11, forKey: "description" as NSCopying)
            }
            if !varLink.isEqual(nil) {
                //print("DESC-------------------------->",varLink)
                elements.setObject(varLink, forKey: "link" as NSCopying)
            }
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
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            if (contactDB?.open())!
            {
                
                let  insertSQL = "INSERT INTO NewsUpdate_Table (newsUpdateTitle , newsUpdateDescription,newsUpdateDate,link,isFeedFirstOrSecond) VALUES ( '\(title1)', '\(description11)', '\(date)','\(varLink)','\("Second")')"
               print("5.NewsUpdate Insert Query::\(insertSQL)")
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    print("success saved")
                    print(databasePath);
                }
            }
            else
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            
            posts.add(elements)
        }
        else
        {
            
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String!)
    {
        if element.isEqual(to: "title") {
            title1.append(string)
        }
        else if element.isEqual(to: "pubDate") {
            date.append(string)
        }
        else if element.isEqual(to: "description") {
            description11.append(string)
        }
        else if element.isEqual(to: "link") {
            varLink.append(string)
        }
        
    }
    
    var varWhichRssFeedRun:String! = ""
    var parser = XMLParser()
   // var posts = NSMutableArray()
     var posts = NSMutableArray()
    
       var isReachable:Bool!
    func functionForViewDidLoad()
    {
        let date = Foundation.Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        
        let year:String! =  String(describing: components.year)
        let month:String! = String(describing: components.month)
        let day:String! = String(describing: components.day)
        
        print(year)
        print(month)
        print(day)
        
        var varAddDayMonthYear:String! = ""
        
        
        varAddDayMonthYear=day+month+year
        print(varAddDayMonthYear)
        var varGetRSSFEEDValueDay=UserDefaults.standard.value(forKey: "session_GetFeedValue")
        
        print(varGetRSSFEEDValueDay)
       if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            if(varGetRSSFEEDValueDay == nil)
            {
                functionForTruncateXMLData()
                UserDefaults.standard.setValue(varAddDayMonthYear, forKey: "session_GetFeedValue")
                beginParsingBlog()
                print("11111111111111111111111111111111111111")
            }
            else if(varAddDayMonthYear == (varGetRSSFEEDValueDay)as! String)
            {
                functionForTruncateXMLData()
                print("222222222222222222222222222222222222222222222222222222222222")
                UserDefaults.standard.setValue(nil, forKey: "session_GetFeedValue")
                beginParsingBlog()
                //NSUserDefaults.standardUserDefaults().setValue(varAddDayMonthYear, forKey: "session_GetFeedValue")
            }
            else
            {
                functionForTruncateXMLData()
                UserDefaults.standard.setValue(varAddDayMonthYear, forKey: "session_GetFeedValue")
                beginParsingBlog()
                print("333333333333333333333333333333333333333333333333333333")
            }
        }

    }
     var appDelegate : AppDelegate!
    func functionbForClearAllUserDefaults()
    {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        functionForViewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.setHidesBackButton(false, animated: false)
        self.view.backgroundColor = UIColor.white
        let lbel = UILabel()
        lbel.frame = CGRect(x: 0, y: self.buttonContinue.frame.size.height-46, width: self.buttonContinue.frame.size.width, height: 1)
        lbel.backgroundColor =  UIColor.gray
        buttonContinue.addSubview(lbel)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(OtpVerifyViewController.update), userInfo: nil, repeats: true)
        timer.fire()
        self.createNavigationBar()
        addDoneButtonOnKeyboard()
        
      
        OTPField1.addTarget(self, action: #selector(OtpVerifyViewController.textFieldDidChange1(_:)), for: UIControl.Event.editingChanged)
        OTPField2.addTarget(self, action: #selector(OtpVerifyViewController.textFieldDidChange2(_:)), for: UIControl.Event.editingChanged)
        OTPField3.addTarget(self, action: #selector(OtpVerifyViewController.textFieldDidChange3(_:)), for: UIControl.Event.editingChanged)
        OTPField4.addTarget(self, action: #selector(OtpVerifyViewController.textFieldDidChange4(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func update() {
        if(count > -01)
        {
            
            resendOTPButton.isEnabled = false
            resendOTPButton.backgroundColor = UIColor(red: (184/255.0), green: (184/255.0), blue: (184/255.0), alpha: 1.0)
            if count < 10
            {
                count=count-1
                CountDownTimerLable.text = String(format:"You will receive the code within the next 00:0%d seconds(s)",count)
            }
            else
            {
                count=count-1
                CountDownTimerLable.text = String(format:"You will receive the code within the next 00:%d seconds(s)",count)
            }
        }
        else
        {
            OTPField1.resignFirstResponder()
            OTPField2.resignFirstResponder()
            OTPField3.resignFirstResponder()
            OTPField4.resignFirstResponder()
            resendOTPButton.isEnabled = true
           resendOTPButton.backgroundColor = UIColor(red: (76/255.0), green: (175/255.0), blue: (80/255.0), alpha: 1.0)
            timer.invalidate()
        }
    }
    
    func createNavigationBar(){
        //self.navigationItem.setHidesBackButton(false, animated: false)
        
        self.title="Got Your Code?"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 0.0)
        
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(OtpVerifyViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    var alertController = UIAlertController()

    @IBAction func NextButtonAction(_ sender: AnyObject)
    {
        print(OTPField1.text)
        
        if(OTPField1.text?.characters.count == 0) && (OTPField2.text?.characters.count == 0) && (OTPField3.text?.characters.count == 0) && (OTPField4.text?.characters.count == 0)
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Rotary India"
            alertView.message = "Please enter OTP"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
        else
        {
            let defaults = UserDefaults.standard
            let str = defaults.value(forKey: "OTP") as! String?
            
            
            print(str)
            
            if str == OTPField1.text! + OTPField2.text! + OTPField3.text! + OTPField4.text!
            {
                // alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
                 //self.present(alertController, animated: true, completion: nil)
                let LoginType = UserDefaults.standard.value(forKey: "session_Login_Type") as! String

                let defaults = UserDefaults.standard
                let mobile = defaults.value(forKey: "mobileNo") as! String
                let countryCode = defaults.value(forKey: "countryCode") as! String
                //let defaults = NSUserDefaults.standardUserDefaults()
                let str = defaults.value(forKey: "countryId") as! String?
                let wsm : WebserviceClass = WebserviceClass.sharedInstance
                wsm.delegates=self
                wsm.OTPverify(mobile, deviceTokenStr: "", countryCode: str! , loginType:LoginType)  // Need To implement for Family
            }
            else
            {
                //

                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Rotary India"
                alertView.message = "Please enter a VALID Verification Code"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                
                OTPField1.text! = ""
                OTPField2.text! = ""
                OTPField3.text! = ""
                OTPField4.text! = ""
                OTPField1.becomeFirstResponder()
            }
            
        }
        
    }
    
    func OTPverifyDelegateFunction(_ loginRes: LoginResult){
        
        
         //functionbForClearAllUserDefaults()
        print(loginRes.status)
        print(loginRes.message)
        let defaults = UserDefaults.standard
        defaults.set(loginRes.masterUID, forKey: "masterUID")
        defaults.synchronize()
        
        
        
        alertController.dismiss(animated: true, completion: nil)

        if(loginRes.status == "0")
        {
            //code by rajendra jat
            /*
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(loginRes.masterUID, forKey: "masterUID")
            defaults.synchronize()
            */
            
            
            
          
            let defaults1 = UserDefaults.standard
            defaults1.set("1", forKey: "completeReg")
            defaults1.synchronize()
            
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "otp_success") as UIViewController, animated: true) //
        }
        else
        {
            
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    @objc func textFieldDidChange1(_ textField: UITextField)
    {
        if textField.text?.characters.count > 0
        {
            OTPField2.becomeFirstResponder()
        }
    }
    
    @objc func textFieldDidChange2(_ textField: UITextField)
    {
        if textField.text?.characters.count > 0
        {
            OTPField3.becomeFirstResponder()
        }
    }
    
    @objc func textFieldDidChange3(_ textField: UITextField)
    {
        if textField.text?.characters.count > 0
        {
            OTPField4.becomeFirstResponder()
        }
    }
    
    @objc func textFieldDidChange4(_ textField: UITextField)
    {
        if textField.text?.characters.count > 0
        {
            self.NextButtonAction(self)
            textField.resignFirstResponder()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        if (range.length + range.location > (textField.text?.characters.count)! )
        {
            return false;
        }
        
        let newLength = (textField.text?.characters.count)! + (string.characters.count) - range.length
        return newLength <= 1
    }
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
        
        if textField == OTPField1
        {
            if textField.text?.characters.count > 0
            {
                OTPField1.text! = ""
                OTPField2.text! = ""
                OTPField3.text! = ""
                OTPField4.text! = ""
                OTPField1.becomeFirstResponder()
                
            }
            
        }
        else if textField == OTPField2
        {
            if textField.text?.characters.count > 0
            {
                OTPField1.text! = ""
                OTPField2.text! = ""
                OTPField3.text! = ""
                OTPField4.text! = ""
                OTPField1.becomeFirstResponder()
                
            }
        }
        else if textField == OTPField3
        {
            if textField.text?.characters.count > 0
            {
                OTPField1.text! = ""
                OTPField2.text! = ""
                OTPField3.text! = ""
                OTPField4.text! = ""
                OTPField1.becomeFirstResponder()
                
            }
        }
        else if textField == OTPField4
        {
            if textField.text?.characters.count > 0
            {
                OTPField1.text! = ""
                OTPField2.text! = ""
                OTPField3.text! = ""
                OTPField4.text! = ""
                OTPField1.becomeFirstResponder()
                
            }
            
        }
        else
        {
            OTPField1.becomeFirstResponder()
            OTPField1.text! = ""
            OTPField2.text! = ""
            OTPField3.text! = ""
            OTPField4.text! = ""
        }
        
    }
    
    
    @IBAction func ResendOTPAction(_ sender: AnyObject)
    {
        count = 59
        //timer = NSTimer()
        //timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(OtpVerifyViewController.update), userInfo: nil, repeats: true)
        timer.fire()
        let LoginType = UserDefaults.standard.value(forKey: "session_Login_Type") as! String
        let defaults = UserDefaults.standard
        let mobileNumberStr = defaults.value(forKey: "mobileNo") as! String?
        
        // let defaults = NSUserDefaults.standardUserDefaults()
        if let str = defaults.value(forKey: "countryId") as! String?{
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            wsm.signinTapped(mobileNumberStr!,countryCode: str , loginType: LoginType)
        }
    }
    
    func LoginDelegateFunction(_ loginRes: LoginResult){
        print(loginRes.status)
        print(loginRes.message)
        print(loginRes.otp)
        
        if(loginRes.status == "0")
        {
            
            let defaults = UserDefaults.standard
            defaults.set(loginRes.otp, forKey: "OTP")
            defaults.synchronize()
            
            //            let alertView:UIAlertView = UIAlertView()
            //            alertView.title = "Rotary India"
            //            alertView.message = String(format:"OTP - %@",loginRes.otp)
            //            alertView.delegate = self
            //            alertView.addButtonWithTitle("OK")
            //            alertView.show()
            
            
            OTPField1.text! = ""
            OTPField2.text! = ""
            OTPField3.text! = ""
            OTPField4.text! = ""
            OTPField1.becomeFirstResponder()
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(OtpVerifyViewController.update), userInfo: nil, repeats: true)
            timer.fire()
            
            OTPField1.addTarget(self, action: #selector(OtpVerifyViewController.textFieldDidChange1(_:)), for: UIControl.Event.editingChanged)
            OTPField2.addTarget(self, action: #selector(OtpVerifyViewController.textFieldDidChange2(_:)), for: UIControl.Event.editingChanged)
            OTPField3.addTarget(self, action: #selector(OtpVerifyViewController.textFieldDidChange3(_:)), for: UIControl.Event.editingChanged)
            OTPField4.addTarget(self, action: #selector(OtpVerifyViewController.textFieldDidChange4(_:)), for: UIControl.Event.editingChanged)
            
        }
        else
        {
            
        }
        
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(OtpVerifyViewController.doneButtonAction))
        
        var items: [UIBarButtonItem]? = [UIBarButtonItem]()
        items?.append(flexSpace)
        items?.append(done)
        
        
        doneToolbar.setItems(items, animated: true)
        doneToolbar.sizeToFit()
        OTPField1.inputAccessoryView=doneToolbar
        OTPField2.inputAccessoryView=doneToolbar
        OTPField3.inputAccessoryView=doneToolbar
        OTPField4.inputAccessoryView=doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        OTPField1.resignFirstResponder()
        OTPField2.resignFirstResponder()
        OTPField3.resignFirstResponder()
        OTPField4.resignFirstResponder()
    }
    
    
    
    /*        let width = bounds.size.width
     if(width <= 320.0)
     {
     UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations:
     {
     
     // self.view.frame = CGRectMake(self.view.frame.origin.x, -130 , self.view.frame.width, self.view.frame.height)
     
     }, completion: { finished in
     
     })
     }
     else
     {
     }  */
    // }
    
    //    func textFieldShouldReturn(textField: UITextField) -> Bool
    //    {
    //        let width = bounds.size.width
    //        if(width <= 320.0)
    //        {
    //            UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations:
    //                {
    //
    //                  //  self.view.frame = CGRectMake(self.view.frame.origin.x, 0 , self.view.frame.width, self.view.frame.height)
    //
    //
    //
    //                }, completion: { finished in
    //
    //            })
    //
    //        }
    //        else
    //        {
    //        }
    //
    //        textField.resignFirstResponder()
    //        return true
    //    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
