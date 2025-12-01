//
//  AnyClubViewController.swift
//  SJSegmentedScrollViewDemo
//
//  Created by deepak on 18/05/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
class AnyClubNewViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource
{
    var appDelegate : AppDelegate = AppDelegate()
    var varGetCountry:String=""
    var varGetCountryID:String=""
    var varGetCountryCode:String=""
    var varGetDay:String=""
    var varGetDayID:String=""
//    var grpID:String!=""
    var muarrayFindAClubList:NSMutableArray=NSMutableArray()
    var varAuthorizationToken:String! = ""
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    var muarrayForResult:NSArray=NSArray()
    
var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
    
    @IBOutlet weak var lblButtonTopLine: UILabel!
    @IBOutlet weak var viewMeetingDay: UIView!
    @IBOutlet weak var pickerviewMeetingDay: UIPickerView!
    @IBOutlet weak var textfieldKeyword: UITextField!
    @IBOutlet weak var textfieldCountry: UITextField!
    @IBOutlet weak var textfieldStates: UITextField!
    @IBOutlet weak var textfieldDistrict: UITextField!
    @IBOutlet weak var textfieldSelectMeetingDay: UITextField!
    @IBOutlet weak var buttonOpacity: UIButton!
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var pickerCountry: UIPickerView!
    @IBOutlet weak var butonMeetingDay: UIButton!
    @IBOutlet weak var buttonSearch: UIButton!
    
    var muarraySelectCountry:NSMutableArray=NSMutableArray()
    var muarrayMeeting:NSMutableArray=NSMutableArray()
    var objCalendarInfo : CalendarInfo = CalendarInfo()
    
    var grpID:String!=""
    
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(AnyClubNewViewController.doneButtonAction))
        
        var items: [UIBarButtonItem]? = [UIBarButtonItem]()
        items?.append(flexSpace)
        items?.append(done)
        
        
        doneToolbar.setItems(items, animated: true)
        doneToolbar.sizeToFit()
        textfieldDistrict.inputAccessoryView=doneToolbar
    }
    @objc func doneButtonAction()
    {
        textfieldDistrict.resignFirstResponder()
    }

    
    //MARK:- keyboard
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if(textField==textfieldKeyword)
        {
            animateViewMoving(true, moveValue: 0)
        }
        else if(textField==textfieldCountry)
        {
            animateViewMoving(true, moveValue: 0)
        }
            
        else if(textField==textfieldStates)
        {
            animateViewMoving(true, moveValue: 0)
        }
        else if (textField==textfieldDistrict)
        {
            animateViewMoving(true, moveValue: 100)
        }
        else
        {
            animateViewMoving(true, moveValue: 100)
        }
        
        /*
         if(textField==textField)
         {
         animateViewMoving(true, moveValue: 0)
         }
         else
         {
         animateViewMoving(true, moveValue: 100)
         }
         */
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        
        if(textField==textfieldKeyword)
        {
            animateViewMoving(true, moveValue: 0)
        }
        else if(textField==textfieldCountry)
        {
            animateViewMoving(true, moveValue: 0)
        }
            
        else if(textField==textfieldStates)
        {
            animateViewMoving(true, moveValue: 0)
        }
        else if (textField==textfieldDistrict)
        {
            animateViewMoving(true, moveValue: -100)
        }
        else
        {
            animateViewMoving(true, moveValue: 100)
        }
        
        /*
         if(textField==textField)
         {
         animateViewMoving(false, moveValue: 0)
         }
         else
         {
         animateViewMoving(false, moveValue: 100)
         }
         
         */
    }
    func animateViewMoving (_ up:Bool, moveValue :CGFloat)
    {
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }

    
    
    //MARK:- Button Click Event
    @IBAction func buttonSelectDayClickEvent(_ sender: AnyObject)
    {
        textfieldKeyword.resignFirstResponder()
        textfieldStates.resignFirstResponder()
        textfieldDistrict.resignFirstResponder()
        textfieldSelectMeetingDay.text=varGetDay
        buttonOpacity.isHidden=true
        viewCountry.isHidden=true
        viewMeetingDay.isHidden=true
    }
    @IBAction func buttonMeetingClickEvent(_ sender: AnyObject)
    {
        textfieldSelectMeetingDay.resignFirstResponder()
        textfieldKeyword.resignFirstResponder()
        textfieldStates.resignFirstResponder()
        textfieldDistrict.resignFirstResponder()
        buttonOpacity.isHidden=false
        viewMeetingDay.isHidden=false
        pickerviewMeetingDay.reloadAllComponents()
    }
    
    
    @IBOutlet weak var buttonSearchLater: UIButton!
    
    
    @IBAction func buttonSearchClickEvent(_ sender: AnyObject)
    {
        buttonSearchLater.isUserInteractionEnabled=false
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if(textfieldStates.text! == "" && textfieldCountry.text! == "" && textfieldKeyword.text! == "" && textfieldDistrict.text! == "" && textfieldSelectMeetingDay.text! == "")
            {
                self.view.makeToast("Please Fill Atleast One Search Criteria", duration: 3, position:CSToastPositionCenter)
                 buttonSearchLater.isUserInteractionEnabled=true
            }
            else
            {
                functionForSearchFindAclubTestPurpose()
            }
        }
        else
        {
             SVProgressHUD.dismiss()
             self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
       // functionForSearch()
    }
    @IBAction func buttonSelectCountryClickEvent(_ sender: AnyObject)
    {
        if(varGetCountry.count>0)
        {
        }
        else
        {
            varGetCountry="India"
            varGetCountryID="1"
            varGetCountryCode="+91"
        }
        textfieldSelectMeetingDay.resignFirstResponder()
        textfieldKeyword.resignFirstResponder()
        textfieldStates.resignFirstResponder()
        textfieldDistrict.resignFirstResponder()
        viewCountry.isHidden=true
        viewMeetingDay.isHidden=true
        buttonOpacity.isHidden=true
        textfieldCountry.text=varGetCountry
        pickerCountry.reloadAllComponents()
    }
    @IBAction func buttonOpacityClickEvent(_ sender: AnyObject)
    {
        textfieldSelectMeetingDay.resignFirstResponder()
        textfieldKeyword.resignFirstResponder()
        textfieldStates.resignFirstResponder()
        textfieldDistrict.resignFirstResponder()
        viewCountry.isHidden=true
        viewMeetingDay.isHidden=true
        buttonOpacity.isHidden=true
        buttonOpacity.isHidden=true
    }
    @IBAction func buttonSelectCountryPickCountry(_ sender: AnyObject)
    {   textfieldSelectMeetingDay.resignFirstResponder()
        textfieldKeyword.resignFirstResponder()
        textfieldStates.resignFirstResponder()
        textfieldDistrict.resignFirstResponder()
        viewCountry.isHidden=false
        buttonOpacity.isHidden=false
        
        pickerviewMeetingDay.reloadAllComponents()
    }
    //MARK:- ViewDid Load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        addDoneButtonOnKeyboard()
            varGetDay = "All"
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
        buttonSearch.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        textfieldSelectMeetingDay.isHidden = false
        lblButtonTopLine.isHidden = true
        //lblButtonTopLine.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        let lbel = UILabel()
        lbel.frame = CGRect(x: 0, y: self.buttonSearch.frame.size.height-52, width: self.view.frame.size.width, height: 1)
        lbel.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        buttonSearch.addSubview(lbel)
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        textfieldKeyword.delegate = self
        textfieldDistrict.delegate = self
        textfieldStates.delegate = self
        textfieldSelectMeetingDay.delegate = self
        textfieldCountry.delegate = self
        
        textfieldKeyword.functionForSetTextFieldBottomBorder()
        textfieldCountry.functionForSetTextFieldBottomBorder()
        textfieldStates.functionForSetTextFieldBottomBorder()
        textfieldDistrict.functionForSetTextFieldBottomBorder()
        textfieldSelectMeetingDay.functionForSetTextFieldBottomBorder()
        
        viewCountry.isHidden=true
        viewMeetingDay.isHidden=true
        buttonOpacity.isHidden=true
        
        //43
        textfieldSelectMeetingDay.text=varGetDay
        muarrayMeeting=NSMutableArray()
        muarrayMeeting.add("All")
        muarrayMeeting.add("Monday")
        muarrayMeeting.add("Tuesday")
        muarrayMeeting.add("Wednesday")
        muarrayMeeting.add("Thursday")
        muarrayMeeting.add("Friday")
        muarrayMeeting.add("Saturday")
        muarrayMeeting.add("Sunday")
        pickerCountry.tag=1
        pickerviewMeetingDay.tag=2
  
        
    }
    func functionForViewDidload()
    {
        //1.
        let imageView = UIImageView(image: UIImage(named: "down_arrowew_blue"))
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: 40, height: 40)
        textfieldCountry.rightViewMode = UITextField.ViewMode.always
        textfieldCountry.rightView = imageView
        //2.
        let imageVieww = UIImageView(image: UIImage(named: "down_arrowew_blue"))
        imageVieww.frame = CGRect(x: 0.0, y: 0.0, width: 40, height: 40)
        textfieldSelectMeetingDay.rightViewMode = UITextField.ViewMode.always
        textfieldSelectMeetingDay.rightView = imageVieww
        
    }
    
//    func textFieldDidBeginEditing(textField: UITextField)
//    {
//        if(textField==textfieldKeyword)
//        {
//            animateViewMoving(true, moveValue: 0)
//        }
//        else
//        {
//            animateViewMoving(true, moveValue: 100)
//        }
//    }
//    func textFieldDidEndEditing(textField: UITextField)
//    {
//        if(textField==textfieldKeyword)
//        {
//            animateViewMoving(false, moveValue: 0)
//        }
//        else
//        {
//            animateViewMoving(false, moveValue: 100)
//        }
//    }
    
    
    
    /*--------------------------------------------------------------------------------------------------------*/
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
    
//    func animateViewMoving (up:Bool, moveValue :CGFloat){
//        var movementDuration:NSTimeInterval = 0.3
//        var movement:CGFloat = ( up ? -moveValue : moveValue)
//        UIView.beginAnimations( "animateView", context: nil)
//        UIView.setAnimationBeginsFromCurrentState(true)
//        UIView.setAnimationDuration(movementDuration )
//        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
//        UIView.commitAnimations()
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //delegate method
        textfieldSelectMeetingDay.resignFirstResponder()
        textfieldKeyword.resignFirstResponder()
        textfieldStates.resignFirstResponder()
        textfieldDistrict.resignFirstResponder()
        return true
    }
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            textfieldSelectMeetingDay.resignFirstResponder()
            textfieldKeyword.resignFirstResponder()
            textfieldStates.resignFirstResponder()
            textfieldDistrict.resignFirstResponder()
            // do something with your currentPoint
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            // do something with your currentPoint
            textfieldSelectMeetingDay.resignFirstResponder()
            textfieldKeyword.resignFirstResponder()
            textfieldStates.resignFirstResponder()
            textfieldDistrict.resignFirstResponder()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            // do something with your currentPoint
            textfieldSelectMeetingDay.resignFirstResponder()
            textfieldKeyword.resignFirstResponder()
            textfieldStates.resignFirstResponder()
            textfieldDistrict.resignFirstResponder()
        }
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.buttonSearchLater.isUserInteractionEnabled=true
        varGetCountry = ""
        Util.copyFile("Calendar.sqlite")
        muarraySelectCountry=NSMutableArray()
        muarraySelectCountry = ModelManager.getInstance().functionForSelectCountry()
//        print(muarraySelectCountry.count)
        functionForViewDidload()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Picker Methods
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
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        let varGetTag = pickerView.tag
        print("Tag")
        
        print(varGetTag)
        if(pickerView.tag==1)
            
        {
            return muarraySelectCountry.count;
        }
        
        if(pickerView.tag==2)
            
        {
            return muarrayMeeting.count;
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        //objCalendarInfo  = CalendarInfo()
        if(pickerView.tag==1)
        {
            objCalendarInfo = muarraySelectCountry.object(at: row) as! CalendarInfo
            return objCalendarInfo.stringCountryMasterName
        }
        if(pickerView.tag==2)
        {
            let vraGetDayValue:String = muarrayMeeting.object(at: row) as! String
            return vraGetDayValue
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView.tag==1)
        {
            objCalendarInfo  = CalendarInfo()
            objCalendarInfo = muarraySelectCountry.object(at: row) as! CalendarInfo
            let stringCountryMasterId =   objCalendarInfo.stringCountryMasterId
            let stringCountryMasterCode =   objCalendarInfo.stringCountryMasterCode
            let stringCountryMasterName =   objCalendarInfo.stringCountryMasterName
            
            varGetCountry=stringCountryMasterName
            varGetCountryID=stringCountryMasterId
            varGetCountryCode=stringCountryMasterCode
            
//            print(stringCountryMasterId)
//            print(stringCountryMasterCode)
//            print(stringCountryMasterName)
        }
        if(pickerView.tag==2)
        {
             varGetDay = muarrayMeeting.object(at: row) as! String
           
            
            
        }
    }
    //---calling web api
    func functionForSearch()
    {
       // loaderViewMethod()
        
        var varPassDay=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).day)
        var  varPassMonth=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).month)
        var  varPassYear=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).year)
        //moduleId
        var varIsFirstTimeExecute=UserDefaults.standard.value(forKey: "session_IsFirstTimeCalendarSlot")
        var varSelectedDate:String=""
        var varUpdateOns:String=""
//        print(varIsFirstTimeExecute)
        
        var varGetKeyword=textfieldKeyword.text
        var varGetCountry=textfieldCountry.text
        var varGetStates=textfieldStates.text
        var varGetDistrict=textfieldDistrict.text
        var varGetMeetingDay=textfieldSelectMeetingDay.text
        
        //deepak please change parameter value by rajendra jat code
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            let completeURL = baseUrl+touchBase_GetMonthEventList
            let parameterst = [
                k_API_profileId : "",
                k_API_groupIds : "",
                k_API_selectedDate : "",
                k_API_updatedOns: ""
            ]
          //  print(varUpdateOns)
         ///   print(parameterst)
          //  print(completeURL)
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
            //    print(response)
                var varGetValueServerError = response.object(forKey: "serverError")as? String
                if(varGetValueServerError == "Error")
                {
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                    SVProgressHUD.dismiss()
                }
                else
                {
                let arrayNew=((response.value(forKey: "TBEventListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newEvents")as! NSArray
                let arrayUpdateEvents=((response.value(forKey: "TBEventListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "updatedEvents")as! NSArray
                let arraydeletedEvents=((response.value(forKey: "TBEventListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "deletedEvents")as! NSArray
             //   print(arrayNew)
              //  print(arrayUpdateEvents)
             //   print(arraydeletedEvents)
                //-----
                var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
                var varGetLastUpdateValueDate = UserDefaults.standard.value(forKey: Updatedefault) as! String
               // ModelManager().functionForAddUpdateDeleteNewEvent(arrayNew, arrayUpdate: arrayUpdateEvents, arrayDelete: arraydeletedEvents,stringLastUpdateDate:varGetLastUpdateValueDate, stringMonth: varPassMonth, stringYear: varPassYear)
                self.window = nil
                SVProgressHUD.dismiss()
            }
            })
            
            
            self.window = nil
        }
        else
        {
           self.window = nil
        }
    }
    /*This is temporary web api need to change when will be provided by nandu tehn cooment this and uncomment up codeand comment below code*/
    
    
    
    //MARK:- SERVER CALLING
    func functionForSearchFindAclubTestPurpose()
    {
        muarrayFindAClubList=NSMutableArray()
       // loaderViewMethod()
        
        var varMeetingDay:String!=""
        
        if(textfieldSelectMeetingDay.text! == "All")
        {
            varMeetingDay = ""
        }
        else
        {
            varMeetingDay = textfieldSelectMeetingDay.text!
            

//
            if varMeetingDay == "Monday"{
                varMeetingDay = "Mon"
            }else if varMeetingDay == "Tuesday"{
                varMeetingDay = "Tue"
            }else if varMeetingDay == "Wednesday"{
                varMeetingDay = "Wed"
            }else if varMeetingDay == "Thursday"{
                varMeetingDay = "Thurs"
            }else if varMeetingDay == "Friday"{
                varMeetingDay = "Fri"
            }else if varMeetingDay == "Saturday"{
                varMeetingDay = "Sat"
            }else if varMeetingDay == "Sunday"{
                varMeetingDay = "Sun"
            }
         
            
            
            
            
        }
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            //changes by shubhs as per madhura said
            let completeURL = baseUrl+row_GetClubList
            var parameterst:NSDictionary=NSDictionary()
            parameterst = [
                "keyword" : textfieldKeyword.text!,
                "country" : varGetCountry,
                "stateProvinceCity" : textfieldStates.text!,
                "district": textfieldDistrict.text!,
                "meetingDay": varMeetingDay
            ]
            
           
            print("find club list\(completeURL)")
            print("\(parameterst)")
            SVProgressHUD.show()
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable : Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
                let dd = response as! NSDictionary
              //  print("dd \(dd)")
                var varGetValueServerError = response.object(forKey: "serverError")as? String
                if(varGetValueServerError == "Error")
                {
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                    SVProgressHUD.dismiss()
                }
                else
                {
                if((dd.object(forKey: "TBGetClubResult")! as AnyObject).object(forKey: "status") as! String == "0")
                {
                    self.muarrayForResult = ((dd.value(forKey: "TBGetClubResult")! as AnyObject).value(forKey: "ClubResult") as! AnyObject).value(forKey: "Table") as! NSArray
                    print("your total result : \(self.muarrayForResult)")
                    let newGroupId = self.muarrayForResult.value(forKey: "grpID")
                    print("newGroupId:\(newGroupId)")
                    self.appDelegate = UIApplication.shared.delegate as! AppDelegate
                    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                        self.DeleteDataInlocal()
//                        self.muarrayFindAClubList.addObjects(from: self.muarrayForResult as! [Any])
//                        self.CalleduserListingView(arraryy: self.muarrayFindAClubList)
                        if(self.muarrayForResult.count>0)
                        {
                            print("your count of muarrayfor result")
                            self.SaveDataInlocal(self.muarrayForResult)
                            
                        }
                        else
                        {
                        }
                    }
                    else
                    {
                    }
                    if(self.muarrayForResult.count>0)
                    {
                        self.textfieldKeyword.text! = ""
                        self.textfieldCountry.text! = ""
                        self.textfieldStates.text! = ""
                        self.textfieldDistrict.text! = ""
                        self.textfieldSelectMeetingDay.text! = ""
                    //    print(self.muarrayFindAClubList.count)
                        let objSearchAnyClubNearMeClubViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchAnyClubNearMeClubViewController") as! SearchAnyClubNearMeClubViewController
                            objSearchAnyClubNearMeClubViewController.moduleName = ""
                        objSearchAnyClubNearMeClubViewController.muarrayFindAClubList = self.muarrayFindAClubList
//                        var Data = self.muarrayFindAClubList.
                        
                        //objSearchAnyClubNearMeClubViewController.varAuthorizationToken = self.varAuthorizationToken
                        
                        self.navigationController?.pushViewController(objSearchAnyClubNearMeClubViewController, animated: true)
                        self.window = nil
                    }
                    else
                    {
                        self.window = nil
                        self.view.makeToast("No Results", duration: 2, position: CSToastPositionCenter)
                         self.buttonSearchLater.isUserInteractionEnabled=true
                    }
                }
                else
                {
              self.window = nil
                    self.buttonSearchLater.isUserInteractionEnabled=true

                }
                SVProgressHUD.dismiss()
                }
            })
        }
        else
        {
             SVProgressHUD.dismiss()
            self.window = nil
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
             self.buttonSearchLater.isUserInteractionEnabled=true
        }
    }
    
    
    //MARK:- Local Data Store
//
//    func CalleduserListingView(arraryy:NSArray){
//        print(arraryy)
//
//            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchAnyClubNearMeClubViewController") as! SearchAnyClubNearMeClubViewController
////        secondViewController.isFromGlobalSearch = "yes"
////        secondViewController.grpID = grpID as? NSString
////        secondViewController.isAdmin = isAdmin as NSString?
////        secondViewController.userID = userID as NSString?
////            secondViewController.moduleIdStr = moduleIdStr as! NSString
////            print(moduleIdStr)
//        for i in 0 ..< arraryy.count {
//            let newClubbed: Void = UserDefaults.standard.setValue(((arraryy.object(at: i) as AnyObject).value(forKey: "ClubId") as! String), forKey: "NewClubId")
//            print("ur Id:\(newClubbed)")
//        }
//            secondViewController.moduleName = "Members"
////            secondViewController.letGetCategoryId = letGetCategoryId as! String
////            print(letGetCategoryId)
////        secondViewController.searchlistArr = arraryy as! NSMutableArray
//        secondViewController.muarrayFindAClubList = arraryy as! NSMutableArray
//            print(secondViewController.muarrayFindAClubList)
//            self.navigationController?.pushViewController(secondViewController, animated: true)
//           // print(dict)
////        }
//    }
    /*---------------Save / Delete / update / fetch -------------------DPK----------------------------*/
    //Save Data
    func SaveDataInlocal (_ arrdata:NSArray){
        var databasePath : String
        // print(arrdata);
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        print("your array data\(arrdata)")
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            var moduleID = UserDefaults.standard.string(forKey: "session_GetModuleId")
            var GroupID = UserDefaults.standard.string(forKey: "session_GetGroupId")
            print("session group Id:\(GroupID ?? "")")
//            for ind in 0 ..< arrdata.count{
//                let varGetGrpIDs = ((arrdata.object(at: ind) as AnyObject).value(forKey: "grpID") as! AnyObject)
//                print("out of loop value :\(varGetGrpIDs)")
//            }
            for i in 0 ..< arrdata.count {
                var varGetGrpID:Int = 0
                var varClubId:String = ""
                var varClubName:String = ""
                var meetingDay:String = ""
                var meetingTime:String = ""
                var varDistance:String = ""
                var varCharterDate:String = ""
                var Website:String = ""
                var varDistrictID:String = ""
                var varClubType:String = ""

//                NewClubId
//                [[NSUserDefaults standardUserDefaults] setValue:[@(place.location.coordinate.longitude) stringValue]
                let newClubbed: Void = UserDefaults.standard.setValue(((arrdata.object(at: i) as AnyObject).value(forKey: "ClubId") as! String), forKey: "NewClubId")
                print("Ur club Id\(newClubbed)")
                var clubIddd = UserDefaults.standard.string(forKey: "NewClubId")
//                print(clubIddd)
//                varGetGrpID = (((arrdata.object(at: i) as AnyObject).value(forKey: "grpID") as? String) ?? "")
            if let varGetGrpIDs = ((arrdata.object(at: i) as AnyObject).value(forKey: "grpID") as? Int)
            {
                varGetGrpID = varGetGrpIDs
            }
             if let varClubIds = (arrdata.object(at: i) as AnyObject).value(forKey: "ClubId") as? String
             {
               varClubId = varClubIds
             }
                if let varClubNames = (arrdata.object(at: i) as AnyObject).value(forKey: "clubName") as? String
                {
                varClubName = varClubNames ////Working in swift new version
                }
                if let meetingDays = (arrdata.object(at: i) as AnyObject).value(forKey: "meetingDay") as? String
                {
                meetingDay = meetingDays
                }
                if let meetingTimes = (arrdata.object(at: i) as AnyObject).value(forKey: "meetingTime") as? String
                {
                meetingTime = meetingTimes
                }
                if let varDistances = (arrdata.object(at: i) as AnyObject).value(forKey: "distance") as? String
                {
                 varDistance = varDistances
                }
                
                
            if(varDistance == nil || varDistance == "")
                {
                    varDistance = ""
                }
                else
                {
                }
                varCharterDate = meetingDay+"  |  "+meetingTime
                Website = ""
                varDistrictID = ""
                varClubType = ""
                //let  dict = arrdata[i] as! NSDictionary
                //masterUID ,GroupId , moduleId ,District , CharterDate , ClubName , ClubType ,ClubId , Website , Find_A_Club_List
                /// let insertSQL = "INSERT INTO Find_A_Club_List (masterUID , GroupId, moduleId, District , CharterDate,ClubName,ClubType,ClubId,Website,distance) VALUES ('\(mainMemberID!)', '\(varGetGrpID)', '\(moduleID!)', '\(varDistrictID)', '\(varCharterDate)', '\(varClubName)', '\(varClubType)', '\(varClubId)', '\(Website)','\(varDistance)')"
                //deep
                
                //let insertSQL = "INSERT INTO Find_A_Club_List (masterUID , GroupId, moduleId, District , CharterDate,ClubName,ClubType,ClubId,Website,distance) VALUES ('\(mainMemberID!)', '\(varGetGrpID)', '\("30")', '\(varDistrictID)', '\(varCharterDate)', '\(varClubName)', '\(varClubType)', '\(varClubId)', '\(Website)','\(varDistance)')"
                //Working in swift new version
                let insertSQL = "INSERT INTO Find_A_Club_List (masterUID , GroupId, moduleId, District , CharterDate,ClubName,ClubType,ClubId,Website,distance) VALUES ('\(mainMemberID ?? "")', '\(varGetGrpID)', '\("30")', '\(varDistrictID)', '\(varCharterDate)', '\(varClubName)', '\(varClubType)', '\(varClubId)', '\(Website)','\(String(describing: varDistance))')"
                
                
                print(insertSQL)
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil) {
//                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
//                    print("success saved")
//                    print(databasePath);
                }
            }
        }
        else
        {
//            print("Error: \(contactDB?.lastErrorMessage())")
        }
        contactDB?.close()
    }
    //DeleteData
    func DeleteDataInlocal (){
        var databasePath : String
        //  print(arrdata);
        
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
//            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
//            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            //for i in 0 ..< arrdata.count {
            // let  dict = arrdata[i] as! NSDictionary
            let insertSQL = "DELETE FROM Find_A_Club_List" // WHERE profileID = '\(dict.objectForKey("serviceDirId") as! String)'
//            print(insertSQL)
            let result = contactDB?.executeStatements(insertSQL)
            if (result == nil) {
//                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            } else {
              //  print("success saved")
//                print(databasePath);
            }
            // }
            
        } else {
//            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        contactDB?.close()
        
    }
    
    /*This is temporary web api need to change when will be provided by nandu tehn cooment this and uncomment up codeand comment below code*/
}
