//
//  NearMeNewViewController.swift
//  TouchBase
//
//  Created by deepak on 19/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SVProgressHUD
class NearMeNewViewController: UIViewController , UITextFieldDelegate ,CLLocationManagerDelegate,UIPickerViewDelegate,UIPickerViewDataSource
{
    @IBOutlet weak var buttonSelectingKMORMiless: UIButton!
    var appDelegate : AppDelegate = AppDelegate()
    var muarrayFindAClubList:NSMutableArray=NSMutableArray()

    @IBOutlet weak var lblUnderLine2: UILabel!
    @IBOutlet weak var lblUnderLine3: UILabel!
    @IBOutlet weak var lblUnderLine1: UILabel!
    @IBOutlet weak var lblButtonTopLine: UILabel!
    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
    var muarrayRange:NSMutableArray=NSMutableArray()
    var muarrayMeetingDay:NSMutableArray=NSMutableArray()
    var muarrayMeetingTime:NSMutableArray=NSMutableArray()
    var muarrayMeetingTimeMinute:NSMutableArray=NSMutableArray()
    var muarrayMeetingTimeAMPM:NSMutableArray=NSMutableArray()
    
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var viewRange: UIView!
    @IBOutlet weak var pickerviewRange: UIPickerView!
    @IBOutlet weak var viewMeetingDay: UIView!
    @IBOutlet weak var pickerviewMeetingDay: UIPickerView!
    @IBOutlet weak var viewMeetingTime: UIView!
    @IBOutlet weak var pickerMeetingTime: UIPickerView!
    @IBOutlet weak var buttonOpacity: UIButton!
    @IBOutlet weak var textfieldRange: UITextField!
    @IBOutlet weak var textfieldMeetingDay: UITextField!
    @IBOutlet weak var textfieldMeetingTime: UITextField!
    @IBOutlet weak var buttonMiles: UIButton!
    @IBOutlet weak var buttonKiloMeters: UIButton!
    
    var varGetRange:String=""
    var varGetNewDay:String=""
    var varGetHour:String=""
    var varGetMinute:String=""
    var varGetAMPM:String=""
    
    var varIsMilesorKilometer:String=""
    
    
    
    
    
    
    /////////
    var locationManager = CLLocationManager()
    var letLatitude:Double? = nil
    var letLongitude:Double? = nil
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfieldMeetingDay.resignFirstResponder()
        textfieldMeetingTime.resignFirstResponder()
        textfieldRange.resignFirstResponder()
        return true
    }
    
    //MARK:- Button click Event
    //1.
    @IBAction func buttonSelectRangeClickEvent(_ sender: AnyObject)
    {
        buttonOpacity.isHidden=false
        viewRange.isHidden=false
        viewMeetingDay.isHidden=true
        viewMeetingTime.isHidden=true
        pickerviewRange.reloadAllComponents()
    }
    @IBAction func buttonSelectMeetingDayClickEvent(_ sender: AnyObject)
    {
        buttonOpacity.isHidden=false
        viewRange.isHidden=true
        viewMeetingDay.isHidden=false
        viewMeetingTime.isHidden=true
        pickerviewMeetingDay.reloadAllComponents()
    }
    @IBAction func buttonSelectMeetingTimeClickEvent(_ sender: AnyObject)
    {
        buttonOpacity.isHidden=false
        viewRange.isHidden=true
        viewMeetingDay.isHidden=true
        viewMeetingTime.isHidden=false
        pickerviewMeetingDay.reloadAllComponents()
    }
    
    @IBOutlet weak var buttonSearchLater: UIButton!
    @IBAction func butonSearchClickEvent(_ sender: AnyObject)
    {
//       // functionForSearchFindAclub()
//        self.buttonSearchLater.isUserInteractionEnabled=false
//
//
//        if(String(describing: letLatitude) == "")
//        {
//            self.view.makeToast("Unable To Get Your Current Location. Please Try Again.", duration: 2, position:CSToastPositionCenter)
//            self.buttonSearchLater.isUserInteractionEnabled=true
//
//        }
//        else
//        {
//           // SVProgressHUD.show()
//        //  functionForSearchFindAclubTestPurpose1()
//
//
//            DispatchQueue.global(qos: .background).async {
//                 SVProgressHUD.show()
//                // Do some background work
//                DispatchQueue.main.async {
//                    SVProgressHUD.show()
//                    self.functionForSearchFindAclubTestPurpose1()
//                    // Update the UI to indicate the work has been completed
//                }
//            }
//
//        }
        
        if CLLocationManager.locationServicesEnabled() {
               // Check the authorization status
               switch CLLocationManager.authorizationStatus() {
               case .authorizedWhenInUse, .authorizedAlways:
                   // Location permission granted, proceed with your logic
                   if letLatitude == 0.0 {
                       // User denied location permission
                       self.view.makeToast("Unable To Get Your Current Location. Please Try Again.", duration: 2, position: CSToastPositionCenter)
                   } else {
                       // Location permission granted, proceed with your logic
                       DispatchQueue.global(qos: .background).async {
                           SVProgressHUD.show()
                           // Do some background work
                           DispatchQueue.main.async {
                               SVProgressHUD.show()
                               self.functionForSearchFindAclubTestPurpose1()
                               // Update the UI to indicate the work has been completed
                           }
                       }
                   }
               case .denied, .restricted:
                   // User denied or restricted location permission
                   self.view.makeToast("Location services are not enabled. Please enable them in your device settings.", duration: 2, position: CSToastPositionCenter)
               case .notDetermined:
                   // Authorization status not determined yet
                   locationManager.requestWhenInUseAuthorization()
               @unknown default:
                   break
               }

           } else {
               // Location services are not enabled
               self.view.makeToast("Location services are not enabled. Please enable them in your device settings.", duration: 2, position: CSToastPositionCenter)
           }
        
//        self.buttonSearchLater.isUserInteractionEnabled = false
//
//           if CLLocationManager.locationServicesEnabled() {
//               locationManager.requestWhenInUseAuthorization()
//           } else {
//               // Show a toast message or any other alert to inform the user
//               self.view.makeToast("Location services are not enabled. Please enable them in your device settings.", duration: 2, position: CSToastPositionCenter)
//               self.buttonSearchLater.isUserInteractionEnabled = false
//               return
//           }
//
//        if letLatitude == 0.0 {
//               // User denied location permission
//               self.view.makeToast("Unable To Get Your Current Location. Please Try Again.", duration: 2, position: CSToastPositionCenter)
//               self.buttonSearchLater.isUserInteractionEnabled = false
//           } else {
//               // Location permission granted, proceed with your logic
//               DispatchQueue.global(qos: .background).async {
//                   SVProgressHUD.show()
//                   // Do some background work
//                   DispatchQueue.main.async {
//                       SVProgressHUD.show()
//                       self.functionForSearchFindAclubTestPurpose1()
//                       // Update the UI to indicate the work has been completed
//                   }
//               }
//           }
        
       // functionForSearchFindAclubTestPurpose()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
            case .denied, .restricted:
                self.view.makeToast("Unable To Get Your Current Location. Please Try Again.", duration: 2, position:CSToastPositionCenter)
            case .notDetermined:
                // Handle not determined status
                break
            default:
                break
            }
        }
    
    @IBAction func buttonOpacityClickEvent(_ sender: AnyObject)
    {
        buttonOpacity.isHidden=true
        viewRange.isHidden=true
        viewMeetingDay.isHidden=true
        viewMeetingTime.isHidden=true
    }
    @IBAction func buttonMeetingTimeDoneClickEvent(_ sender: AnyObject)
    {
        buttonOpacity.isHidden=true
        viewRange.isHidden=true
        viewMeetingDay.isHidden=true
        viewMeetingTime.isHidden=true
    }
    @IBAction func buttonRangeDoneClickEvent(_ sender: AnyObject)
    {
        buttonOpacity.isHidden=true
        viewRange.isHidden=true
        viewMeetingDay.isHidden=true
        viewMeetingTime.isHidden=true
    }
    @IBAction func buttonMeetingDayDoneClickEvent(_ sender: AnyObject)
    {
        buttonOpacity.isHidden=true
        viewRange.isHidden=true
        viewMeetingDay.isHidden=true
        viewMeetingTime.isHidden=true
    }
    @IBAction func buttonMilesClickEvent(_ sender: AnyObject)
    {
       
            buttonMiles.setImage(UIImage(named: "radio_btn_Check.png"),  for: UIControl.State.normal)
            buttonKiloMeters.setImage(UIImage(named: "radio_btn_Uncheck.png"),  for: UIControl.State.normal)
        varIsMilesorKilometer="Miles"
            
       
    }
    @IBAction func buttonKiloMetersClickEvent(_ sender: AnyObject)
    {
        buttonMiles.setImage(UIImage(named: "radio_btn_Uncheck.png"),  for: UIControl.State.normal)
        buttonKiloMeters.setImage(UIImage(named: "radio_btn_Check.png"),  for: UIControl.State.normal)
        varIsMilesorKilometer="Kilometers"
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // functionForSetLatnLongOnMap()
        SVProgressHUD.dismiss()
        self.buttonSearchLater.isUserInteractionEnabled=true

    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        //buttonSelectingKMORMiless
        
        
        buttonSelectingKMORMiless.layer.cornerRadius = 1
        buttonSelectingKMORMiless.layer.borderWidth = 1
        
        
        buttonSelectingKMORMiless.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor

        
        
        //////
        //gps
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        lblButtonTopLine.isHidden = true
        lblUnderLine1.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        lblUnderLine2.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        lblUnderLine3.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        buttonSearch.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        //lblButtonTopLine.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        let lbel = UILabel()
        lbel.frame = CGRect(x: 0, y: self.buttonSearch.frame.size.height-52, width: self.view.frame.size.width, height: 1)
        lbel.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        buttonSearch.addSubview(lbel)
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        viewRange.isHidden=true
        viewMeetingDay.isHidden=true
        viewMeetingTime.isHidden=true
        buttonOpacity.isHidden=true
        
        varGetRange="10"
        varGetNewDay="Any"
//        varGetHour="1"
//        varGetMinute="5"
//        varGetAMPM="AM"
//
//        textfieldRange.text=varGetRange
//        textfieldMeetingDay.text=varGetNewDay
//        textfieldMeetingTime.text=varGetHour+"-"+varGetMinute+"-"+varGetAMPM
        
        textfieldRange.text! = "10"
        textfieldMeetingTime.text! = "All"
        textfieldMeetingDay.text! = "Any"
        textfieldRange.delegate = self
        textfieldMeetingDay.delegate = self
        textfieldMeetingTime.delegate = self
       /*-----------------------------------------------------------------------------------------------*/
//        let buttonHeight = buttonSearch.frame.origin.y+1
//        let lbel = UILabel()
//        lbel.frame = CGRectMake(0, buttonHeight, self.buttonSearch.frame.size.width, 1)
//        lbel.backgroundColor =  UIColor.grayColor()
//        buttonSearch.addSubview(lbel)
        /*-----------------------------------------------------------------------------------------------*/
        functionForViewDidLoad()
    }
    func functionForViewDidLoad()
    {
        
        //varIsMilesorKilometer="Miles"
        varIsMilesorKilometer="Kilometers"

        //lblButtonTopLine.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        
        //1.
        let imageView = UIImageView(image: UIImage(named: "down_arrowew_blue"))
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: 50, height: 50)
        textfieldRange.rightViewMode = UITextField.ViewMode.always
        textfieldRange.rightView = imageView
        //2.
        let imageVieww2 = UIImageView(image: UIImage(named: "down_arrowew_blue"))
        imageVieww2.frame = CGRect(x: 0.0, y: 0.0, width: 40, height: 40)
        textfieldMeetingDay.rightViewMode = UITextField.ViewMode.always
        textfieldMeetingDay.rightView = imageVieww2
        //3.
        let imageVieww3 = UIImageView(image: UIImage(named: "down_arrowew_blue"))
        imageVieww3.frame = CGRect(x: 0.0, y: 0.0, width: 40, height: 40)
        textfieldMeetingTime.rightViewMode = UITextField.ViewMode.always
        textfieldMeetingTime.rightView = imageVieww3
        
        
        
        muarrayRange=NSMutableArray()
        muarrayMeetingDay=NSMutableArray()
        muarrayMeetingTime=NSMutableArray()
        //1.
        for i in 00..<201
        {
            muarrayRange.add(String(i+1))
        }
        //2.
        muarrayMeetingDay.add("Any")
        muarrayMeetingDay.add("Monday")
        muarrayMeetingDay.add("Tuesday")
        muarrayMeetingDay.add("Wednesday")
        muarrayMeetingDay.add("Thursday")
        muarrayMeetingDay.add("Friday")
        muarrayMeetingDay.add("Saturday")
        muarrayMeetingDay.add("Sunday")
        //3.
        
        //0- All, 1- Sunrise, 2- noon ,3- sunset
        muarrayMeetingTime.add("All")
        muarrayMeetingTime.add("Sunrise")
        muarrayMeetingTime.add("noon")
        muarrayMeetingTime.add("sunset")
       
        
//        muarrayMeetingTime.addObject("1")
//        muarrayMeetingTime.addObject("2")
//        muarrayMeetingTime.addObject("3")
//        muarrayMeetingTime.addObject("4")
//        muarrayMeetingTime.addObject("5")
//        muarrayMeetingTime.addObject("6")
//        muarrayMeetingTime.addObject("7")
//        muarrayMeetingTime.addObject("8")
//        muarrayMeetingTime.addObject("9")
//        muarrayMeetingTime.addObject("10")
//        muarrayMeetingTime.addObject("11")
//        muarrayMeetingTime.addObject("12")
//
//        muarrayMeetingTimeMinute.addObject("5")
//        muarrayMeetingTimeMinute.addObject("10")
//        muarrayMeetingTimeMinute.addObject("15")
//        muarrayMeetingTimeMinute.addObject("20")
//        muarrayMeetingTimeMinute.addObject("25")
//        muarrayMeetingTimeMinute.addObject("30")
//        muarrayMeetingTimeMinute.addObject("35")
//        muarrayMeetingTimeMinute.addObject("40")
//        muarrayMeetingTimeMinute.addObject("45")
//        muarrayMeetingTimeMinute.addObject("50")
//        muarrayMeetingTimeMinute.addObject("55")
        
   //     muarrayMeetingTimeAMPM.addObject("AM")
   //     muarrayMeetingTimeAMPM.addObject("PM")
        
        pickerviewRange.tag=1
        pickerviewMeetingDay.tag=2
        pickerMeetingTime.tag=3
        
        buttonMiles.setImage(UIImage(named: "radio_btn_Uncheck.png"),  for: UIControl.State.normal)
        buttonKiloMeters.setImage(UIImage(named: "radio_btn_Check.png"),  for: UIControl.State.normal)
        varIsMilesorKilometer="Kilometers"
    }
    /*-------------------------picker view ------------------------*/
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
        let varGetTag = pickerView.tag
        print("Tag")
        print(varGetTag)
        if(pickerView.tag==1)
        {
            return muarrayRange.count;
        }
        else if(pickerView.tag==2)
        {
            return muarrayMeetingDay.count;
        }
        else if(pickerView.tag==3)
        {
            if component == 0
            {
                return muarrayMeetingTime.count;
            }
//            else if component == 1
//            {
//                return muarrayMeetingTimeMinute.count;
//            }
//            else if component == 2
//            {
//                return muarrayMeetingTimeAMPM.count;
//            }
            return muarrayMeetingTime.count;
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        //objCalendarInfo  = CalendarInfo()
        if(pickerView.tag==1)
        {
            let vraGetRangeValue:String = muarrayRange.object(at: row) as! String
            return vraGetRangeValue
        }
        else  if(pickerView.tag==2)
        {
            let vraGetDayValue:String = muarrayMeetingDay.object(at: row) as! String
            return vraGetDayValue
        }
        if(pickerView.tag==3)
        {
            if component == 0
            {
                let varGetTimeValue:String = muarrayMeetingTime.object(at: row) as! String
                return varGetTimeValue
            }
//            else if component == 1
//            {
//                var varGetTimeMinuteValue:String = muarrayMeetingTimeMinute.objectAtIndex(row) as! String
//                return varGetTimeMinuteValue
//            }
//            else if component == 2
//            {
//                var varGetTimeAMPMValue:String = muarrayMeetingTimeAMPM.objectAtIndex(row) as! String
//                return varGetTimeAMPMValue
//            }
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView.tag==1)
        {
            let varGetRangeValue:String = muarrayRange.object(at: row) as! String
            varGetRange=varGetRangeValue
            textfieldRange.text=varGetRangeValue
            print("Range:-"+varGetRangeValue)
            
        }
        else  if(pickerView.tag==2)
        {
            let varGetMeetingDayValue:String = muarrayMeetingDay.object(at: row) as! String
            varGetNewDay=varGetMeetingDayValue
            textfieldMeetingDay.text="\(varGetMeetingDayValue)"
            print("Day:-"+varGetMeetingDayValue)
        }
        else  if(pickerView.tag==3)
        {
            
            if component == 0
            {
                let varGetTimeValue:String = muarrayMeetingTime.object(at: row) as! String
                print("Time:-"+varGetTimeValue)
                varGetHour=varGetTimeValue
               // var varTimeMinuteAMPm = varGetHour+"-"+varGetMinute+"-"+varGetAMPM
                textfieldMeetingTime.text=varGetTimeValue
                print(varGetTimeValue)
            }
//            else if component == 1
//            {
//                var varGetTimeMinuteValue:String = muarrayMeetingTimeMinute.objectAtIndex(row) as! String
//                print("Minute:-"+varGetTimeMinuteValue)
//                varGetMinute=varGetTimeMinuteValue
//                var varTimeMinuteAMPm = varGetHour+"-"+varGetMinute+"-"+varGetAMPM
//                textfieldMeetingTime.text=varTimeMinuteAMPm
//                print(varGetTimeMinuteValue)
//            }
//            else if component == 2
//            {
//                var varGetTimeAMPMValue:String = muarrayMeetingTimeAMPM.objectAtIndex(row) as! String
//                print("AMPM:-"+varGetTimeAMPMValue)
//                varGetAMPM=varGetTimeAMPMValue
//                var varTimeMinuteAMPm = varGetHour+"-"+varGetMinute+"-"+varGetAMPM
//                textfieldMeetingTime.text=varTimeMinuteAMPm
//                print(varGetTimeAMPMValue)
//            }
        }
    }
    /*-------------------------Picker view---------------------------*/
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    /*--------------------------------------------------------------------------------------------------------*/
    //MARK:- Loader Method
    func loaderViewMethod()
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.backgroundColor = UIColor.clear
            window.rootViewController = UIViewController()
            window.makeKeyAndVisible()
        }
        let Loadingview = UIView()
        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")
        let gifView = UIImageView()
        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
        gifView.backgroundColor = UIColor.clear
        //                gifView.contentMode = .Center
        Loadingview.addSubview(gifView)
        window?.addSubview(Loadingview)
        
    }
    
    
    
    //---calling web api
    func functionForSearchFindAclub()
    {
        /*
         var varGetRange:String=""
         var varGetNewDay:String=""
         var varGetHour:String=""
         var varGetMinute:String=""
         var varGetAMPM:String=""
         */
        //range value
        var varGetRamgeMilesOrKilometers:String=varIsMilesorKilometer

        textfieldRange.text=varGetRange
        textfieldMeetingDay.text=varGetNewDay
        textfieldMeetingTime.text=varGetHour+"-"+varGetMinute+"-"+varGetAMPM
        
        
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
               SVProgressHUD.dismiss()
                }
            })
        }
        else
        {
            
        }
    }
    /*This is temporary web api need to change when will be provided by nandu tehn cooment this and uncomment up codeand comment below code*/
//    func functionForSearchFindAclubTestPurpose()
//    {
//        loaderViewMethod()
//         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//        {
//            let completeURL = "
//                k_API_name : "",
//                k_API_classification : "",
//                k_API_club : "imphal manipur",
//                k_API_districtnumber: ""
//            ]
//            ServiceManager().webserviceWithRequestMethod(HTTPMethod.POST, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
//                //=> Handle server response
//                let dd = response as! NSDictionary
//                print("dd \(dd)")
//                if(dd.objectForKey("TBGetRotarianResult")!.objectForKey("status") as! String == "0")
//                {
//                    for i in 0..<response.valueForKey("TBGetRotarianResult")!.valueForKey("RotarianResult")!.valueForKey("masterUID")!.count
//                    {
//                        self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
//                        let varFindclubLocation=(dd.valueForKey("TBGetRotarianResult")!.valueForKey("RotarianResult")!.valueForKey("clubName")!.objectAtIndex(i))
//                        let varFindclubDayTime=(dd.valueForKey("TBGetRotarianResult")!.valueForKey("RotarianResult")!.valueForKey("designation")!.objectAtIndex(i))
//
//
//                        self.commonClassHoldDataAccessibleVariable.varFindclubLocation = varFindclubLocation as! String;
//                        self.commonClassHoldDataAccessibleVariable.varFindclubDayTime = varFindclubDayTime as! String;
//                        self.muarrayFindAClubList.addObject(self.commonClassHoldDataAccessibleVariable)
//                    }
//
//                    if(response.valueForKey("TBGetRotarianResult")!.valueForKey("RotarianResult")!.valueForKey("masterUID")!.count>0)
//                    {
//                        let objSearchAnyClubNearMeClubViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchAnyClubNearMeClubViewController") as! SearchAnyClubNearMeClubViewController
//                        objSearchAnyClubNearMeClubViewController.moduleName = ""
//                        objSearchAnyClubNearMeClubViewController.muarrayFindAClubList = self.muarrayFindAClubList
//                        self.navigationCovxzvzxvzntroller?.pushVzcxiewController(objSearchAnyClubNearMeClubViewController, animated: true)
//                         self.window = nil
//                    }
//                    else
//                    {
//                        self.view.makeToast("No Results", duration: 3, position:CSToastPositionCenter)
//                        self.window = nil
//
//                    }
//                    }
//                else
//                {
//                    self.window = nil
//
//                }
//            })
//        }
//        else
//        {
//             self.window = nil
//            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
//
//        }
//
//    }
    /*This is temporary web api need to change when will be provided by nandu tehn cooment this and uncomment up codeand comment below code*/
    
    
    
    
    
    
    
    
    
    
    
 //MARK:- SERVER CALLING
    func functionForSearchFindAclubTestPurpose1()
    {
        //0- All, 1- Sunrise, 2- noon ,3- sunset

        var varMeetingTime:String!=""
        var varMeetingDay:String!=""
        if(varGetHour=="All" || textfieldMeetingTime.text! == "All")
        {
            //as discussed with seema and suhas by rajendra here if All then send ""
         // varMeetingTime = "1"
              varMeetingTime = "All"
        }
        else if(varGetHour=="Sunrise" || textfieldMeetingTime.text! == "Sunrise")
        {
            varMeetingTime = "1"
        }
        else if(varGetHour=="noon" || textfieldMeetingTime.text! == "noon")
        {
            varMeetingTime = "2"
        }
        else if(varGetHour=="sunset" || textfieldMeetingTime.text! == "sunset")
        {
            varMeetingTime = "3"
        }
        
        if(textfieldMeetingDay.text! == "Any")
        {
           varMeetingDay = ""
        }
        else
        {
            varMeetingDay = textfieldMeetingDay.text!
            
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
        
        
        
        
        
        
        muarrayFindAClubList=NSMutableArray()
       // loaderViewMethod()
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            print(varMeetingDay)
             print("lat and long 111")
             print(letLatitude)
             print(letLongitude)
            print("lat and long222")
//            if(letLatitude != nil && letLongitude != nil)
//            {
            let completeURL = baseUrl+row_GetClubNearMe
             var parameterst:NSDictionary=NSDictionary()
            parameterst =
//             [
//                "distance":self.textfieldRange.text!,
//                "distanceUnit":self.varIsMilesorKilometer,
//                "meetingDay":varMeetingDay,
//                "meetingTime" : varMeetingTime ,
//                "currentLat":"31.3497999",
//                "currentLong":"75.606869"
//            ]
//
             [
                 "distance":self.textfieldRange.text!,
                 "distanceUnit":self.varIsMilesorKilometer,
                 "meetingDay":varMeetingDay,
                 "meetingTime" : varMeetingTime ,
                 "currentLat":String(letLatitude ?? 0.0),
                 "currentLong":String(letLongitude ?? 0.0)
             ]
             
            print(completeURL)
            print(parameterst)
             ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable : Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
                let dd = response as! NSDictionary
                print("dd \(dd)")
                
                var varGetValueServerError = response.object(forKey: "serverError")as? String
                if(varGetValueServerError == "Error")
                {
                     SVProgressHUD.dismiss()
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                }
                else
                {
                
                if((dd.object(forKey: "TBGetClubResult")! as AnyObject).object(forKey: "status") as! String == "0")
                {
                    for i in 0..<(((response.value(forKey: "TBGetClubResult")! as AnyObject).value(forKey: "ClubResult")! as AnyObject).value(forKey: "grpID")! as AnyObject).count
                    {
                        self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                        /*"grpID": "102",
                         "clubId": "56001",
                         "clubName": "Mulund Hill View, Mah. ",
                         "meetingDay": "Sunday",
                         "meetingTime": "10:00AM",
                         "distance": "1.421"*/
                        
                        let varGrpID=((((dd.value(forKey: "TBGetClubResult")! as AnyObject).value(forKey: "ClubResult")! as AnyObject).value(forKey: "grpID")! as AnyObject).object(at: i))
                        print(varGrpID)
                        let varClubId=((((dd.value(forKey: "TBGetClubResult")! as AnyObject).value(forKey: "ClubResult")! as AnyObject).value(forKey: "clubId")! as AnyObject).object(at: i))
                        let varClubName=((((dd.value(forKey: "TBGetClubResult")! as AnyObject).value(forKey: "ClubResult")! as AnyObject).value(forKey: "clubName")! as AnyObject).object(at: i))
                        
                        
                        var varMeetingDay=((((dd.value(forKey: "TBGetClubResult")! as AnyObject).value(forKey: "ClubResult")! as AnyObject).value(forKey: "meetingDay")! as AnyObject).object(at: i)) as? String
                        
                        if (varMeetingDay == nil || varMeetingDay == "<null>"){
                            varMeetingDay = ""
                        }
                        
                        
                        var varMeetingTime=((((dd.value(forKey: "TBGetClubResult")! as AnyObject).value(forKey: "ClubResult")! as AnyObject).value(forKey: "meetingTime")! as AnyObject).object(at: i)) as? String
                        if (varMeetingTime == nil || varMeetingTime == "<null>"){
                            varMeetingTime = ""
                        }
                        var varDistance=((((dd.value(forKey: "TBGetClubResult")! as AnyObject).value(forKey: "ClubResult")! as AnyObject).value(forKey: "distance")! as AnyObject).object(at: i)) as? String
                        if(varDistance == nil || varDistance == "<null>"  )
                        {
                            varDistance = ""
                        }
                      
                        
                        
                        self.commonClassHoldDataAccessibleVariable.varGetGrpID = varGrpID as! String;
                        self.commonClassHoldDataAccessibleVariable.varClubId = varClubId as! String;
                        self.commonClassHoldDataAccessibleVariable.varClubName = varClubName as! String;
                        self.commonClassHoldDataAccessibleVariable.varCharterDate = ((varMeetingDay as! String)+"  |  "+(varMeetingTime as! String))
                        self.commonClassHoldDataAccessibleVariable.varMeetingDay = varMeetingDay as! String;
                        self.commonClassHoldDataAccessibleVariable.varMeetingTime = varMeetingTime as! String;
                        self.commonClassHoldDataAccessibleVariable.varDistance = varDistance
                        self.muarrayFindAClubList.add(self.commonClassHoldDataAccessibleVariable)
                        print(self.muarrayFindAClubList)
                    }
                    
                    self.appDelegate = UIApplication.shared.delegate as! AppDelegate
                   if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                        self.DeleteDataInlocal()
                        if(self.muarrayFindAClubList.count>0)
                        {
                            self.SaveDataInlocal(self.muarrayFindAClubList)
                        }
                        else
                        {
                        }
                    }
                    else
                    {
                        
                    }

                    
                    if(self.muarrayFindAClubList.count>0)
                    {
                        
//                        self.window = nil
                       // self.textfieldRange.text! = "0"
                       // self.textfieldMeetingDay.text! = "Any"
                      //  self.textfieldMeetingTime.text! = "All"
                        
                        print(self.muarrayFindAClubList.count)
                        let objSearchAnyClubNearMeClubViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchAnyClubNearMeClubViewController") as! SearchAnyClubNearMeClubViewController
                        objSearchAnyClubNearMeClubViewController.moduleName = ""
                        objSearchAnyClubNearMeClubViewController.muarrayFindAClubList = self.muarrayFindAClubList
                        
                        objSearchAnyClubNearMeClubViewController.flag="1"
                        //objSearchAnyClubNearMeClubViewController.varAuthorizationToken = self.varAuthorizationToken
                        self.buttonSearchLater.isUserInteractionEnabled=true
                  SVProgressHUD.dismiss()
                        SVProgressHUD.dismiss()
                        self.navigationController?.pushViewController(objSearchAnyClubNearMeClubViewController, animated: true)
                        
                    }
                    else
                    {
                        self.window = nil
                        self.view.makeToast("No Results", duration: 2, position: CSToastPositionCenter)
                        self.buttonSearchLater.isUserInteractionEnabled=true
  SVProgressHUD.dismiss()
                    }
                    
                }
                else
                {
                    self.window = nil
                    self.buttonSearchLater.isUserInteractionEnabled=true
                      SVProgressHUD.dismiss()

                }
                }
                SVProgressHUD.dismiss()
            })
            self.window = nil
              //SVProgressHUD.dismiss()
//        }
//            else
//            {
//                SVProgressHUD.dismiss()
//                self.window = nil
//                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
//                self.buttonSearchLater.isUserInteractionEnabled=true
//            }
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
    /*---------------Save / Delete / update / fetch -------------------DPK----------------------------*/
    //Save Data
    func SaveDataInlocal (_ arrdata:NSMutableArray){
        var databasePath : String
        print(arrdata);
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
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            var moduleID = UserDefaults.standard.string(forKey: "session_GetModuleId")
            var GroupID = UserDefaults.standard.string(forKey: "session_GetGroupId")
            for i in 0 ..< arrdata.count {
                
                
                
                /*
                 self.commonClassHoldDataAccessibleVariable.varGetGrpID = varGrpID as! String;
                 self.commonClassHoldDataAccessibleVariable.varClubId = varClubId as! String;
                 self.commonClassHoldDataAccessibleVariable.varClubName = varClubName as! String;
                 self.commonClassHoldDataAccessibleVariable.varCharterDate = ((varMeetingDay as! String)+"  |  "+(varMeetingTime as! String))
                 self.commonClassHoldDataAccessibleVariable.varMeetingDay = varMeetingDay as! String;
                 self.commonClassHoldDataAccessibleVariable.varMeetingTime = varMeetingTime as! String;*/
                
                
                var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
                objCommonHoldDataVariable = arrdata.object(at: i) as! CommonAccessibleHoldVariable;
                let varDistrictID = objCommonHoldDataVariable.varDistrictID
                let varCharterDate = objCommonHoldDataVariable.varCharterDate
                print(varCharterDate)
                let varClubName =  objCommonHoldDataVariable.varClubName
                let varClubType =  objCommonHoldDataVariable.varClubType
                let varClubId =  objCommonHoldDataVariable.varClubId
                let Website =  objCommonHoldDataVariable.Website
                let varGetGrpID = objCommonHoldDataVariable.varGetGrpID
                let varDistance = objCommonHoldDataVariable.varDistance
                
                
                
                
                
                print(varGetGrpID)
                
                
                //let  dict = arrdata[i] as! NSDictionary
                //masterUID ,GroupId , moduleId ,District , CharterDate , ClubName , ClubType ,ClubId , Website , Find_A_Club_List
                
                //let insertSQL = "INSERT INTO Find_A_Club_List (masterUID , GroupId, moduleId, District , CharterDate,ClubName,ClubType,ClubId,Website,distance) VALUES ('\(mainMemberID!)', '\(varGetGrpID!)', '\(moduleID!)', '\(varDistrictID!)', '\(varCharterDate!)', '\(varClubName)', '\(varClubType)', '\(varClubId!)', '\(Website!)','\(varDistance!)')"
              
                //deep
               // let insertSQL = "INSERT INTO Find_A_Club_List (masterUID , GroupId, moduleId, District , CharterDate,ClubName,ClubType,ClubId,Website,distance) VALUES ('\(mainMemberID!)', '\(varGetGrpID!)', '\("30")', '\(varDistrictID!)', '\(varCharterDate!)', '\(varClubName)', '\(varClubType)', '\(varClubId!)', '\(Website!)','\(varDistance!)')"
                
                //Working in swift new version
                let insertSQL = "INSERT INTO Find_A_Club_List (masterUID , GroupId, moduleId, District , CharterDate,ClubName,ClubType,ClubId,Website,distance) VALUES ('\(mainMemberID!)', '\(varGetGrpID!)', '\("30")', '\(varDistrictID!)', '\(varCharterDate!)', '\(varClubName!)', '\(varClubType!)', '\(varClubId!)', '\(Website!)','\(varDistance!)')"
                
                
                print(insertSQL)
                
                let result = contactDB?.executeStatements(insertSQL)
                
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("success saved")
                    print(databasePath);
                }
            }
            
        }
            
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
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
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            //for i in 0 ..< arrdata.count {
            // let  dict = arrdata[i] as! NSDictionary
            let insertSQL = "DELETE FROM Find_A_Club_List" // WHERE profileID = '\(dict.objectForKey("serviceDirId") as! String)'
            print(insertSQL)
            let result = contactDB?.executeStatements(insertSQL)
            if (result == nil) {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            } else {
                print("success saved")
                print(databasePath);
            }
            // }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*88989898989898989898989898989898989898989898989898989898989898998989898989898989*/
    
    //MARK:-  3.GPS location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if let locValue = self.locationManager.location?.coordinate {
            self.letLatitude = locValue.latitude
            self.letLongitude = locValue.longitude
            print(self.letLatitude)
            print(self.letLongitude)
            
            
            if (error != nil)
            {
                return
            }
            if placemarks!.count > 0
            {
                let pm = placemarks![0]
                self.displayLocationInfo(pm)
            }
            else
            {
                // print("Problem with the data received from geocoder")
            }
        }
            //self.functionForSetLatnLongOnMap()
        })
    }
    func displayLocationInfo(_ placemark: CLPlacemark?)
    {
        if placemark != nil
        {
            locationManager.stopUpdatingLocation()
        }
    }
    
  
//    func functionForSetLatnLongOnMap()
//    {
//        let latDelta:CLLocationDegrees = 0.01
//        let longDelta:CLLocationDegrees = 0.01
//        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
//        let pointLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.letLatitude!,self.letLongitude!)
//        print(pointLocation)
//        let region:MKCoordinateRegion = MKCoordinateRegionMake(pointLocation, theSpan)
//    }
//
    
    
  
    
    /**********************************************************************************************/
}
