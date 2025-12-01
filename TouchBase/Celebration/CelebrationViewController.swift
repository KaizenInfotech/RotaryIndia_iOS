//
//  CelebrationViewController.swift
//  TouchBase
//
//  Created by Umesh on 14/03/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import MessageUI
import Foundation
import MessageUI
//import SVProgressHUD

@available(iOS 13.0, *)
class CelebrationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
   
    var iscalledFromNoti:String!=""
    var IsMonthorBAEviewAppear:Bool=true
    var searchButton = UIButton()
    var dropDownButton = UIButton()
    var grpName:String!=""
    var varForEventOPen:Int=0
    var search = UIBarButtonItem()
    var appDelegate : AppDelegate = AppDelegate()
    
    var varIsFirstOrDoneButton:String! = ""
    var tableEventTabRowHeight:CGFloat=90.0
    var tableAnniversaryTabRowHeight:CGFloat=90.0
    var tableBirthdayRowHeight:CGFloat=90.0
    var tableBAERowHeight:CGFloat=90.0
    var varNextMonthFirstDate:String!=""
    
    var isBirthdayTabFirstTime:Bool=true
    var isAnniversaryTabFirstTime:Bool=true
    var isEventTabFirstTime:Bool=true
    
    @IBOutlet weak var lblNoEventBdayAnni: UILabel!
    @IBOutlet weak var viewDatePicker: UIView!
    
    @IBOutlet weak var lblAnniversary: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblBday: UILabel!
    @IBAction func buttonDatePickClickEvent(_ sender: AnyObject) {
        
        labelNoBAEfoundinMonthView.isHidden=true
        varIsFirstOrDoneButton = "Done"
        
        lblNoEventBdayAnni.isHidden=true
        viewDatePicker.isHidden=true
        buttonOpacity.isHidden=true
        
        setDateAndTimeFull()
        muarrayGetDataFromDayWiseOrMonthWise.removeAllObjects()
        muarrayHoldDateWiseData=NSMutableArray()
        tableviewEventAnnivBirthDay.reloadData()
        
        
        datepickerFilter.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = Foundation.DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let selectedDate = dateFormatter.string(from: datepickerFilter.date)
        dateTimeDisplay=selectedDate
        labelMonthYear.text = selectedDate
    }
    
    @IBOutlet weak var loadinglabelfortab: UILabel!
    @IBOutlet weak var loadinglabelformonth: UILabel!
    
    var grpDetailPrevious = NSDictionary()
    @IBOutlet weak var datepickerFilter: UIDatePicker!
    var  dateTimeDisplay:String = ""
    @IBOutlet weak var buttonOpacity: UIButton!
    var currentdate: String = ""
    let timeFormatter = Foundation.DateFormatter()
    let DateFormatter = Foundation.DateFormatter()
    @IBOutlet weak var viewEventNew: UIView!
    var muarrayEventAnnivBirth:NSMutableArray=NSMutableArray()
    let loaderClass  = WebserviceClass()
    var muarrayGetDataFromDayWiseOrMonthWise:NSMutableArray=NSMutableArray()
    var  stringProfileId:String!=""
    var isCategory:String!=""
    var isAdmin:String!=""
    var isfromBanner:String!=""
    var  stringGroupID:String!=""
    var muarrayListData:NSMutableArray=NSMutableArray()
    let reuseIdentifiers = "cell"
    var prototypeCells:CelebreationEventAnnivBirthdayTableViewCell=CelebreationEventAnnivBirthdayTableViewCell()
    var varPassDay:String!=""
    var varPassMonth:String!=""
    var varPassYear:String!=""
    @IBOutlet var tableviewEventAnnivBirthDay: UITableView!
    var moduleName:String! = ""
    var varISTodayDateandSelectedIndexSame:Int=0
    var varLastSelectedIndex:Int=0
    var muarrayIsSelected:NSMutableArray=NSMutableArray()
    var prototypeCell:CelebreationCollectionViewCell=CelebreationCollectionViewCell()
    let reuseIdentifier = "Cell"
    @IBOutlet var viewDays: UIView!
    @IBOutlet var collectionviewCelebreation: UICollectionView!
    var marrCalendarData : NSMutableArray!
    var objCalendarInfo : CalendarInfo = CalendarInfo()
    @IBOutlet var viewMonth: UIView!
    @IBOutlet var labelMonthYear: UILabel!
    // var appDelegate : AppDelegate!
    //MARK:- Button click event
    var varGetLastMonth:Int=0
    var varGetLastYear:Int=0
    
    
    
    var varType:String!=""
    
    @IBAction func butonFilterClickEvent(_ sender: AnyObject)
    {
        /* Later enhancement
        buttonOpacity.isHidden=false
        viewDatePicker.isHidden=false
        */
    }
    
    @IBAction func buttonOpacityClickEvent(_ sender: AnyObject)
    {
        viewDatePicker.isHidden=true
        buttonOpacity.isHidden=true
        viewBirthAnnivPopupss.isHidden=true
          buttonOpacity.isHidden=true
    }
    @IBAction func buttonPreviousClickEvent(_ sender: AnyObject)
    {
        //SVProgressHUD.show()
         countValue=1
        buttonOpacity.isHidden=true
        viewDatePicker.isHidden=true
        muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
        muarrayHoldDateWiseData=NSMutableArray()
        tableviewEventAnnivBirthDay.reloadData()
        // ////print(varGetLastMonth)
        
        if(varGetLastMonth==1)
        {
            varGetLastMonth=12
            varGetLastYear=varGetLastYear-1
        }
        else
        {
            varGetLastMonth=varGetLastMonth-1
        }
        varPassMonth = commonClassFunction().functionForMonthWordWise(String(varGetLastMonth))
        
        
        
        
        //--------
        UserDefaults.standard.setValue("1", forKey: "session_IsFirstTimeCalendarSlot")
        functionForSynchronousPreviousMonthDataWithServerData(String(varGetLastMonth), stringYear: String(varGetLastYear))
        
        
        
        ////print(varPassMonth)
        ////print(varGetLastMonth)
        ////print(varGetLastYear)
        
        var TodatDate:Int=01
        
        let getTodayMonthYear = String(varGetLastYear)+"-"+String(varGetLastMonth)+"-"+String(TodatDate)
        ////print(getTodayMonthYear)
        //5
        functionforGetSelectedDateDetail(getTodayMonthYear)

        ////print(varGetLastMonth)
        ////print(self.varPassMonth)
        ////print(varPassMonth)
        ////print("011"+varPassMonth+", "+String(varGetLastYear))
        
        
        
    }
    @IBAction func buttonNextClickEvent(_ sender: AnyObject)
    {
        //SVProgressHUD.show()
         countValue=1
        buttonOpacity.isHidden=true
        viewDatePicker.isHidden=true
        muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
        muarrayHoldDateWiseData=NSMutableArray()
        tableviewEventAnnivBirthDay.reloadData()
        
        
        //////print(varGetLastMonth)
        if(varGetLastMonth==12)
        {
            varGetLastMonth=1
            varGetLastYear=varGetLastYear+1
        }
        else
        {
            varGetLastMonth=varGetLastMonth+1
        }
        varPassMonth = commonClassFunction().functionForMonthWordWise(String(varGetLastMonth))
        //--------
       // self.loaderClass.window = nil
        self.buttonOpacity.isHidden=true
        UserDefaults.standard.setValue("1", forKey: "session_IsFirstTimeCalendarSlot")
        
        //  labelMonthYear.text = "01 "+varPassMonth+" "+varPassYear
        
        labelMonthYear.text = "01 "+varPassMonth+" "+String(varGetLastYear)
        varGetCurrentDay="01"
        
       // loaderClass.loaderViewMethod()
        functionForSynchronousNextMonthDataWithServerData(stringMonth:String(varGetLastMonth), stringYear: String(varGetLastYear))
        
        muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
        tableviewEventAnnivBirthDay.reloadData()
        
        
        
        ////print(varPassMonth)
        ////print(varGetLastMonth)
        ////print(varGetLastYear)
        
        var TodatDate:Int=01
        
        
        
        
        let getTodayMonthYear = String(varGetLastYear)+"-"+String(varGetLastMonth)+"-"+String(TodatDate)
        ////print(getTodayMonthYear)
        functionforGetSelectedDateDetail(getTodayMonthYear)
        
        
       
        
        
    }
    func functionForSynchronousDataWithServerData()
    {
        ////print("this is first value of this calendar")
        
        
        // loaderClass.loaderViewMethod()
        self.buttonOpacity.isHidden=false
       // var varPassDay=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).day)
      //  var  varPassMonth=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).month)
       // var  varPassYear=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).year)
       
        
        let date = Date()
        let calendar = Calendar.current
        
        var varPassYear = calendar.component(.year, from: date)
        var varPassMonth = calendar.component(.month, from: date)
        var varPassDay = calendar.component(.day, from: date)
        
        
        //moduleId
        var varIsFirstTimeExecute=UserDefaults.standard.value(forKey: "session_IsFirstTimeCalendarSlot")
        var varSelectedDate:String=""
        var varUpdateOns:String=""
        ////print(varIsFirstTimeExecute!)
        
        ////print(varPassMonth)
        ////print(varPassYear)
        
        ////print(Int(String(varPassMonth))!)
        ////print(Int(String(varPassYear))!)
        varGetLastMonth = Int(String(varPassMonth))!
        varGetLastYear = Int(String(varPassYear))!
        var   varGetPassMonth = commonClassFunction().functionForMonthWordWise(String(varPassMonth))
        //  labelMonthYear.text = "01 "+varGetPassMonth+" "+varPassYear
        
        
        labelMonthYear.text = String(varPassDay)+" "+varGetPassMonth+" "+String(varPassYear)
        varGetCurrentDay=String(varPassDay)
        
        
        var letGetLastUpdateDate = ModelManager.getInstance().functionForGetLastUpdateDateFromMonthTable(String(varPassMonth), stringYear: String(varPassYear),GroupID:self.stringGroupID as! String)
        if(varIsFirstTimeExecute==nil)
        {
            varSelectedDate=String(varPassYear)+"-"+String(varPassMonth)+"-"+"01"
            /* ... Commented by harshada on 21-01-2020 12 pm need to uncomment after testing...*/
            //varUpdateOns="1970/01/01 00:00:00"
            varUpdateOns="2019/01/01 00:00:00"
        }
        else
        {
            // let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            
           // let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
            // varUpdateOns=letGetLastUpdateDate
         
            
            // varUpdateOns="1970/01/01 00:00:00"
            varUpdateOns="2019/01/01 00:00:00"
            
            ////print(varUpdateOns)
            
            varSelectedDate=String(varPassYear)+"-"+String(varPassMonth)+"-"+"01"
            // ////print("••••••••••••••••••••••••••••••••••")
            // ////print((NSUserDefaults.standardUserDefaults().valueForKey(Updatedefault) as! String?)!)
        }
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            let completeURL = baseUrl+touchBase_GetMonthEventList
            
            var parameterst:NSDictionary=NSDictionary()
            if(isCategory=="1")
            {
                ////print("Club----------------------------Category",isCategory)
                parameterst = [
                    k_API_profileId : stringProfileId,
                    k_API_groupIds : stringGroupID as! String,
                    k_API_selectedDate : varSelectedDate,
                    k_API_updatedOns:varUpdateOns,
                    "groupCategory":isCategory]
            }
            else if(isCategory=="2")
            {
                ////print("District----------------------------Category",isCategory)
                parameterst = [
                    k_API_profileId : stringProfileId ,
                    k_API_groupIds : stringGroupID as! String,
                    k_API_selectedDate : varSelectedDate,
                    k_API_updatedOns:varUpdateOns,
                    "groupCategory":isCategory]
            }
            
            //            let parameterst = [
            //                k_API_profileId : stringProfileId as! String,
            //                k_API_groupIds : stringGroupID as! String,
            //                k_API_selectedDate : varSelectedDate,
            //                k_API_updatedOns:varUpdateOns
            //            ]
            ////print(varUpdateOns)
        
           print("completeURL -6- on \(Date()):   \(completeURL)")
           print("parameterst -6- on \(Date()) : \(parameterst)")
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
                print("Response of -6- on \(Date()): \(response)")
                var varGetValueServerError = response.object(forKey: "serverError")as? String
                if(varGetValueServerError == "Error")
                {
                    self.view.makeToast("Could not connect to server, please try again.", duration: 4, position: CSToastPositionCenter)
                    //SVProgressHUD.dismiss()
                }
                else
                {
                    //print("Calender date response 1111:: \(response)")
   let arrayNew=((response.value(forKey: "TBEventListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newEvents")as! NSArray
   let arrayUpdateEvents=((response.value(forKey: "TBEventListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "updatedEvents")as! NSArray
   let arraydeletedEvents=((response.value(forKey: "TBEventListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "deletedEvents")as! NSArray
   //////print(arrayNew)
   // ////print(arrayUpdateEvents)
   // ////print(arraydeletedEvents)
   //-----
   var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
   let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
   var varGetLastUpdateValueDate = UserDefaults.standard.value(forKey: Updatedefault) as! String
   ModelManager().functionForAddUpdateDeleteNewEvent(arrayNew, arrayUpdate: arrayUpdateEvents, arrayDelete: arraydeletedEvents,stringLastUpdateDate:varGetLastUpdateValueDate, stringMonth: String(varPassMonth), stringYear: String(varPassYear),GroupID:self.stringGroupID as! String)
   
   /*----------------------------For Curent Date Data Show------DPK----------------*/
   self.muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
   self.muarrayGetDataFromDayWiseOrMonthWise=ModelManager.getInstance().functionForGetEventBirthdayAnnivversaryData(String(varPassDay), stringMonth: String(varPassMonth), stringYear: String(varPassYear))
   print(self.muarrayHoldDateWiseData)
   self.tableviewEventAnnivBirthDay.reloadData()
   
   
   
  // self.loaderClass.window=nil
   self.buttonOpacity.isHidden=true
   
                }
            })
        }
        else
        {
           // self.loaderClass.window=nil
            self.buttonOpacity.isHidden=true
        }
    }
    //this code is being written for month view detail for today`s date data fetching
    func functionForGetTodaysDetail()
    {
        let getTodayMonthYear = commonClassFunction().functionForGetTodatDayMonthYear()
        ////print(getTodayMonthYear)
        functionforGetSelectedDateDetail(getTodayMonthYear)
    }
    
    func functionForDelayCall()
    {
        var varGetValue =  UserDefaults.standard.value(forKey: "IsComingFromProfileScreen")as! String
        
        if(varGetValue=="yes")
        {
            UserDefaults.standard.setValue("no", forKey: "IsComingFromProfileScreen")
        }
        else
        {
            //comment by harshada on 21 feb 2020
            //functionForSynchronousDataWithServerData()
            muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
            muarrayGetDataFromDayWiseOrMonthWise=ModelManager.getInstance().functionForGetEventBirthdayAnnivversaryData(varPassDay, stringMonth: varPassMonth, stringYear: varPassYear)
                tableviewEventAnnivBirthDay.reloadData()
        }
        
        //comment by rajendra on 28 june 2018

        let m:String! = varPassMonth!
        let y = varPassYear!
        ////print(m! , y)
        functionForSynchronousNextMonthDataWithServerData(stringMonth:varPassMonth!, stringYear: varPassYear!)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
//        self.edgesForExtendedLayout = []
        //SVProgressHUD.show()
        // tableviewBirthAnniv.hidden=true
        //isBirthdayorAnniv="birthday"
        datepickerFilter.setStyle()
        lblBday.isHidden=true
        lblAnniversary.isHidden=true
        lblEvent.isHidden=true
        buttonOpacityPopup.isHidden=true
        viewBirthAnnivPopupss.isHidden=true
        buttonOpacity.isHidden=true
        viewDatePicker.isHidden=true
        viewBirthAnnivEvent.isHidden=false
        loadinglabelfortab.isHidden=false
        viewMonth.isHidden=true

        lblNoEventBdayAnni.textAlignment = .center
        buttonCancelPopup.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonCancelPopup.backgroundColor = UIColor.clear
        buttonCancelPopup.layer.cornerRadius = 5
        buttonCancelPopup.layer.borderWidth = 1
        buttonCancelPopup.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        
        self.viewBirthAnnivPopupss.layer.cornerRadius = 2.0;
        self.viewBirthAnnivPopupss.layer.masksToBounds = true
        var lineView3 = UIView(frame: CGRect(x: 0, y: 0, width: buttonSend.frame.size.width, height: 1))
        lineView3.backgroundColor=UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        buttonSend.addSubview(lineView3)

        varIsFirstOrDoneButton = "First"
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        UserDefaults.standard.setValue("no", forKey: "IsComingFromProfileScreen")
        
        

        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = (screenSize.width)
        let screenHeight = (screenSize.height)
        if(screenWidth==320)
        {
        }
        else
        {
            let margin: CGFloat = 7
            let cellsPerRow = 7
            
            guard let flowLayout = collectionviewCelebreation?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            flowLayout.minimumInteritemSpacing = margin
            flowLayout.minimumLineSpacing = margin
            flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
            flowLayout.estimatedItemSize = flowLayout.itemSize // CGSize(width: 50, height: 50)
        }
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        varPassDay=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).day)
        varPassMonth=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).month)
        varPassYear=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).year)

        let date = Date()
        let calendar = Calendar.current
        
        var Yearssss = calendar.component(.year, from: date)
        var Monthsss = calendar.component(.month, from: date)
        var dayyyss = calendar.component(.day, from: date)

        varPassDay = (String(dayyyss))
        varPassMonth = (String(Monthsss))
        varPassYear = (String(Yearssss))
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        marrCalendarData = NSMutableArray()
        //--------------------------------------------Util.copyFile("Calendar.sqlite")
        //--code by Rajendra Jat call web api
        /*--------------*/
        self.marrCalendarData = ModelManager.getInstance().getAllStudentData(varPassMonth, stringYear: varPassYear,groupID:self.stringGroupID as! String)
         
        print( self.marrCalendarData)
        self.muarrayIsSelected=NSMutableArray()
        for i in 00..<self.marrCalendarData.count
        {
            self.muarrayIsSelected.add("0")
        }
        print(self.muarrayIsSelected)
        self.collectionviewCelebreation.reloadData()
        collectionviewCelebreation?.collectionViewLayout.invalidateLayout()

        UserDefaults.standard.setValue("1", forKey: "session_IsFirstTimeCalendarSlot")

        muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
        self.buttonOpacity.isHidden=true
        
        functionForSetLeftNavigation()
        self.edgesForExtendedLayout = []

         var varGetValue =  UserDefaults.standard.value(forKey: "IsComingFromProfileScreen")as! String
         
         if(varGetValue=="yes")
         {
          UserDefaults.standard.setValue("no", forKey: "IsComingFromProfileScreen")
         }
         else
         {
            //6
      //   functionForSynchronousDataWithServerData()
           muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
            muarrayGetDataFromDayWiseOrMonthWise=ModelManager.getInstance().functionForGetEventBirthdayAnnivversaryData(varPassDay, stringMonth: varPassMonth, stringYear: varPassYear)
           tableviewEventAnnivBirthDay.reloadData()
         }
        //7
       // functionForSynchronousNextMonthDataWithServerData(stringMonth: varPassMonth, stringYear: varPassYear)

//        self.edgesForExtendedLayout=[]
        NotificationCenter.default.addObserver(self, selector: #selector(AddEventsController.AllRSVPBAction), name: NSNotification.Name(rawValue: "AllRSVP"), object: nil)
    
        
        
        let getTodayMonthYear = commonClassFunction().functionForGetTodatDayMonthYear()
        
        if(varType=="A")
        {
            viewBirthDay.isHidden=true
            viewAnniversary.isHidden=true
            viewEvent.isHidden=true
            
            var lineView = UIView(frame: CGRect(x: 0, y: 37, width: buttonAnniversary.frame.size.width, height: 2))
            lineView.backgroundColor=UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
            buttonAnniversary.addSubview(lineView)
            
            buttonBirthDay.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
            buttonAnniversary.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
            buttonEvent.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
           self.functionForAnnivNew()
        }
        else if(varType=="B")
        {
            
            viewBirthDay.isHidden=true
            viewAnniversary.isHidden=true
            viewEvent.isHidden=true

            let lineView = UIView(frame: CGRect(x: 0, y: 37, width: buttonBirthDay.frame.size.width, height: 2))
            lineView.backgroundColor=UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
            buttonBirthDay.addSubview(lineView)
            
            buttonBirthDay.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
            buttonAnniversary.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
            buttonEvent.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
            //2
            functionForGettingCalendarMonthWiseData(getTodayMonthYear)

        }
        else if(varType=="E")
        {
            
            varForEventOPen = 1
            viewBirthDay.isHidden=true
            viewAnniversary.isHidden=true
            viewEvent.isHidden=true
            
            var lineView = UIView(frame: CGRect(x: 0, y: 37, width: buttonEvent.frame.size.width, height: 2))
            lineView.backgroundColor=UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
            buttonEvent.addSubview(lineView)
            
            buttonBirthDay.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
            buttonAnniversary.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
            buttonEvent.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
            self.functionForAEventNewEvent()
        }
        else
        {
            viewBirthDay.isHidden=false
            viewAnniversary.isHidden=true
            viewEvent.isHidden=true
            var lineView = UIView(frame: CGRect(x: 0, y: 37, width: buttonBirthDay.frame.size.width, height: 2))
            lineView.backgroundColor=UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
            buttonBirthDay.addSubview(lineView)
            buttonBirthDay.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
            buttonAnniversary.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
            buttonEvent.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        }
        //5
        //functionForGetTodaysDetail()
    }
//    override var prefersStatusBarHidden: Bool{
//        return UIStatusBarStyle.default
//    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        setNeedsStatusBarAppearanceUpdate()
//    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
//        if #available(iOS 13.0, *) {
//
//        } else {
//            // Fallback on earlier versions
//        };
       
//        if #available(iOS 13.0, *) {
//            let navBarAppearance = UINavigationBarAppearance()
//            navBarAppearance.configureWithOpaqueBackground()
//            navBarAppearance.backgroundColor = UIColor.white
//
//            UINavigationBar.appearance().standardAppearance = navBarAppearance
//        } else {
//            // Fallback on earlier versions
//        }
//        let navBarAppearance = UINavigationBarAppearance()
//          navBarAppearance.configureWithOpaqueBackground()
//          navBarAppearance.backgroundColor = UIColor.white
//
//          UINavigationBar.appearance().standardAppearance = navBarAppearance
    if let getValuesnew:String=UserDefaults.standard.string(forKey: "thisiscomingfromdetaileventdelete"){
     if(getValuesnew=="yes")
       {
        self.navigationController?.popViewController(animated: true)
       }
    }
    }
    
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor=UIColor.white// (red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
         self.navigationController?.navigationBar.backgroundColor=UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        searchButton = UIButton(type: UIButton.ButtonType.custom)
        searchButton.frame = CGRect(x: 0, y: 0, width: 90, height: 30)
        
        
        
        
        searchButton.setImage(UIImage(named:"down_arrow"),  for: UIControl.State.normal)
        searchButton.imageView?.contentMode = .scaleAspectFit
        searchButton.titleEdgeInsets = UIEdgeInsets(top: 0,left: -20,bottom: 0,right:34)
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 0,left: 60,bottom: 0,right:0)
        
        //11111
        let   varGetPassMonthsNew = commonClassFunction().functionForMonthWordWiseNEwdate(self.varPassMonth)
        searchButton.setTitle("Month",  for: UIControl.State.normal)
        
        
        searchButton.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        searchButton.backgroundColor = UIColor.clear
        searchButton.layer.cornerRadius = 5
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        
        searchButton.addTarget(self, action: #selector(RefreshDataClickEvent), for: UIControl.Event.touchUpInside)
        let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
        let buttonss : NSArray = [search]
        dropDownButton = UIButton(type: UIButton.ButtonType.custom)
        dropDownButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        dropDownButton.addTarget(self, action: #selector(RefreshDataClickEvent), for: UIControl.Event.touchUpInside)
        let setting: UIBarButtonItem = UIBarButtonItem(customView: dropDownButton)
        let buttons : NSArray = [search]
        if(iscalledFromNoti=="notify")
        {
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
        else
        {
        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
        
        //  /Volumes/Rajendra/Development/Development/Projects and Backups/Projects/ROW/23Feb2018ROW/TouchBase/Images_Icons_Fonts_New/Other/up.png
    }
    var isExist:Int!=0
    @objc func RefreshDataClickEvent()
    {
        //SVProgressHUD.show()
        
        viewBirthAnnivPopupss.isHidden=true
        buttonOpacity.isHidden=true
        buttonOpacityPopup.isHidden=true

        if(IsMonthorBAEviewAppear==true)
        {
            //For month view
            loadinglabelfortab.isHidden=true
            if(isExist == 0)
            {
                //loaderClass.loaderViewMethod()
                functionForDelayCall()
                isExist=1
            }
            
            viewMonth.isHidden=false
            viewBirthAnnivEvent.isHidden=true
            IsMonthorBAEviewAppear=false
            searchButton = UIButton(type: UIButton.ButtonType.custom)
            searchButton.frame = CGRect(x: 0, y: 0, width: 90, height: 30)
            // searchButton.setImage(UIImage(named:"Delete_blue"), forState: UIControl.State.Normal)
            searchButton.setImage(UIImage(named:"down_arrow"),  for: UIControl.State.normal)
            searchButton.imageView?.contentMode = .scaleAspectFit
            searchButton.titleEdgeInsets = UIEdgeInsets(top: 0,left: -20,bottom: 0,right:34)
            searchButton.imageEdgeInsets = UIEdgeInsets(top: 0,left: 60,bottom: 0,right:0)
            
            
            ////print(varPassMonth)
            //2......
            let   varGetPassMonthsNew = commonClassFunction().functionForMonthWordWiseNEwdate(self.varPassMonth)
            searchButton.setTitle("Day",  for: UIControl.State.normal)
            
            searchButton.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
            searchButton.backgroundColor = UIColor.clear
            searchButton.layer.cornerRadius = 5
            searchButton.layer.borderWidth = 1
            searchButton.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
            
            searchButton.addTarget(self, action: #selector(CelebrationViewController.RefreshDataClickEvent), for: UIControl.Event.touchUpInside)
            let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
            let buttonss : NSArray = [search]
            dropDownButton = UIButton(type: UIButton.ButtonType.custom)
            dropDownButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            dropDownButton.addTarget(self, action: #selector(CelebrationViewController.RefreshDataClickEvent), for: UIControl.Event.touchUpInside)
            let setting: UIBarButtonItem = UIBarButtonItem(customView: dropDownButton)
            //let buttons : NSArray = [search, setting] //14 mar
            let buttons : NSArray = [search]
            if(iscalledFromNoti=="notify")
            {
             self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            }
            else
            {
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            }
            functionForGetTodaysDetail()
        }
        else  if(IsMonthorBAEviewAppear==false)
        {
            //For tab bview
            viewMonth.isHidden=true
            loadinglabelformonth.isHidden=true
            viewBirthAnnivEvent.isHidden=false
            
            IsMonthorBAEviewAppear=true
            
            searchButton = UIButton(type: UIButton.ButtonType.custom)
            searchButton.frame = CGRect(x: 0, y: 0, width: 90, height: 30)
            //    searchButton.setImage(UIImage(named:"Delete_blue"), forState: UIControl.State.Normal)
            searchButton.setImage(UIImage(named:"down_arrow"),  for: UIControl.State.normal)
            searchButton.imageView?.contentMode = .scaleAspectFit
            searchButton.titleEdgeInsets = UIEdgeInsets(top: 0,left: -20,bottom: 0,right:34)
            searchButton.imageEdgeInsets = UIEdgeInsets(top: 0,left: 60,bottom: 0,right:0)
            //3.....
            let   varGetPassMonthsNew = commonClassFunction().functionForMonthWordWiseNEwdate(self.varPassMonth)
            searchButton.setTitle("Month",  for: UIControl.State.normal)
            searchButton.tintColor=UIColor.blue
            searchButton.backgroundColor = UIColor.clear
            searchButton.layer.cornerRadius = 5
            searchButton.layer.borderWidth = 1
            searchButton.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
            searchButton.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
            searchButton.addTarget(self, action: #selector(CelebrationViewController.RefreshDataClickEvent), for: UIControl.Event.touchUpInside)
            let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
            let buttonss : NSArray = [search]
            dropDownButton = UIButton(type: UIButton.ButtonType.custom)
            dropDownButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            dropDownButton.addTarget(self, action: #selector(CelebrationViewController.RefreshDataClickEvent), for: UIControl.Event.touchUpInside)
            let setting: UIBarButtonItem = UIBarButtonItem(customView: dropDownButton)
            //let buttons : NSArray = [search, setting] //14 mar
            let buttons : NSArray = [search]
            if(iscalledFromNoti=="notify")
            {
                self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]

            }
            else
            {
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            }
        }
    }
     @objc func backClicked()
    {
        viewBirthAnnivPopupss.isHidden=true
        self.navigationController?.popViewController(animated: true)
        if((self.presentingViewController) != nil){
            self.dismiss(animated: false, completion: nil)
            ////print("done")
        }
    }
    //MARK:- collection view
    //MARK:- collection delegate AS Grid
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
//        let cellSize = CGSize(width: (collectionView.bounds.width - (3 * 5))/3, height: 120)
        return CGSize(width:((collectionviewCelebreation.frame.size.width/7)-10), height:40);
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if(marrCalendarData.count>0)
        {
            return marrCalendarData.count
        }
        return 0
    }
    var countValue:Int=0

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        prototypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CelebreationCollectionViewCell
        if(marrCalendarData.count>0)
        {
            
            objCalendarInfo=marrCalendarData.object(at: indexPath.row) as! CalendarInfo
            if objCalendarInfo.Day=="1"
            {
            print("Day 1 is available in calendar and view is visible")
            }
            //var varGetDayValue=objCalendarInfo.Day
            //1. if day coming 0(zero)then need to hide those value
            prototypeCell.viewCurveCircle.isHidden=true
            prototypeCell.viewCurveCircle.backgroundColor=UIColor.clear
            prototypeCell.labelate.textColor=UIColor.black
            if(objCalendarInfo.Day=="0")
            {
                prototypeCell.viewMain.isHidden=true
            }
            else
            {
                prototypeCell.viewMain.isHidden=false
                prototypeCell.labelate.text=objCalendarInfo.Day
                prototypeCell.buttonMain.addTarget(self, action: #selector(CelebrationViewController.buttonMainClickEvent(_:)), for: UIControl.Event.touchUpInside)
                prototypeCell.buttonMain.tag=indexPath.row
                //2. set today date
                if(objCalendarInfo.IsThisTodayDate != "0")
                {
                    if(varISTodayDateandSelectedIndexSame != indexPath.row)
                    {
                        prototypeCell.labelate.textColor=UIColor.white
                        prototypeCell.viewCurveCircle.isHidden=false
                       prototypeCell.viewCurveCircle.backgroundColor=UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
                    }
                    else
                    {
                        prototypeCell.viewCurveCircle.isHidden=false
                      prototypeCell.viewCurveCircle.backgroundColor=UIColor(red: 0/255.0, green: 154/255.0, blue: 259/255.0, alpha: 1.0)
                       // prototypeCell.viewCurveCircle.backgroundColor=UIColor.green

                    }
                }
                else
                {
                    if(muarrayIsSelected.object(at: indexPath.row)as! String != "0")
                    {
                        prototypeCell.viewCurveCircle.isHidden=false
                       //11111
                     prototypeCell.viewCurveCircle.backgroundColor=UIColor(red: 247/255.0, green: 148/255.0, blue: 91/255.0, alpha: 1.0)
                       // prototypeCell.viewCurveCircle.backgroundColor=UIColor.red

                        
                    }
                    else
                    {
                        prototypeCell.viewCurveCircle.backgroundColor=UIColor.clear
                    }
                }
                //4.set for is selected
                if(objCalendarInfo.IsThisTodayDate != "0")
                {
                    prototypeCell.labelate.textColor=UIColor.white
                }
                
                
                //notification count dot value known
                ////print(muarrayDotValuesInCollectionNext)
                //print("objCalendarInfo.Day::\(objCalendarInfo.Day)")
                //print("Is muarrayDotValuesInCollectionNext contains day::\(muarrayDotValuesInCollectionNext.contains(objCalendarInfo.Day))")
                if(muarrayDotValuesInCollectionNext.contains(objCalendarInfo.Day))
                {
                    prototypeCell.buttonNotification.isHidden=false
                }
                else
                {
                    prototypeCell.buttonNotification.isHidden=true
                }
            }
            if(countValue==0)
            {
            }
            else
            {
                if(objCalendarInfo.Day=="1")
                {
                    //prototypeCell.viewCurveCircle.backgroundColor=UIColor.blue
                    prototypeCell.viewCurveCircle.backgroundColor=UIColor( red: 247/255.0, green: 148/255.0, blue: 91/255.0, alpha: 1.0)
                    
                    prototypeCell.viewCurveCircle.isHidden=false
                }
            }
        }
        return prototypeCell
    }
    
    //Need to Implement
    
    var varGetCurrentDay:String!=""
    
  @objc  func eventBaday(_ indexPath:Int)
    {
        objCalendarInfo=CalendarInfo()
        objCalendarInfo=marrCalendarData.object(at: indexPath) as! CalendarInfo
        var letGetDay = objCalendarInfo.Day
        let letGetMonth = objCalendarInfo.Month
        let letGetYear = objCalendarInfo.Year

        
        //self.loaderClass.window=nil
        self.buttonOpacity.isHidden=true
        
        var getYMDformat:String!=letGetYear+"-"+letGetMonth+"-"+letGetDay
        
        ////print(getYMDformat)
        
        labelMonthYear.text=getYMDformat
        varGetCurrentDay=letGetDay
        
        varPassMonth = commonClassFunction().functionForMonthWordWiseNEwdate(String(varGetLastMonth))
        //--------
        //self.loaderClass.window = nil
        self.buttonOpacity.isHidden=true
        //  NSUserDefaults.standardUserDefaults().setValue("1", forKey: "session_IsFirstTimeCalendarSlot")
        
        
        if(letGetDay=="1" || letGetDay=="01")
        {
            letGetDay="01"
            
        }
        else if(letGetDay=="2" || letGetDay=="02")
        {
            letGetDay="02"
            
        }
        else if(letGetDay=="3" || letGetDay=="03")
        {
            letGetDay="03"
            
        }
        else if(letGetDay=="4" || letGetDay=="04")
        {
            letGetDay="04"
            
        }
        else if(letGetDay=="5" || letGetDay=="05")
        {
            letGetDay="05"
            
        }
        else if(letGetDay=="6" || letGetDay=="06")
        {
            letGetDay="06"
            
        }
        else if(letGetDay=="7" || letGetDay=="07")
        {
            letGetDay="07"
            
        }
        else if(letGetDay=="8" || letGetDay=="08")
        {
            letGetDay="08"
            
        }
        else if(letGetDay=="9" || letGetDay=="09")
        {
            letGetDay="09"
        }
        labelMonthYear.text = letGetDay+" "+varPassMonth+" "+letGetYear //DPK add letgetyear 28-05-2018
        varGetCurrentDay=letGetDay
        //print("(getYMDformat) ::: \(getYMDformat)")
        functionforGetSelectedDateDetail(getYMDformat)
    }
    var isReloadFirstTime:Int!=0
   @objc func buttonMainClickEvent(_ sender:UIButton)
    {
        //SVProgressHUD.show()
        countValue=0
        muarrayIsSelected=NSMutableArray()
        for i in 00..<marrCalendarData.count
        {
            muarrayIsSelected.add("0")
        }
        isReloadFirstTime=1
        muarrayIsSelected.replaceObject(at: sender.tag, with: "1")
        collectionviewCelebreation.reloadData()
        collectionviewCelebreation?.collectionViewLayout.invalidateLayout()
        varISTodayDateandSelectedIndexSame=sender.tag
        varISTodayDateandSelectedIndexSame=sender.tag
        eventBaday(sender.tag)
        
    }
    
    
    
    
    
    
    
    //table view delegate
    //MARK:- Tableview Delegate As List
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    /*
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
         {
             if(tableView==self.tableviewEventAnnivBirthDay)
             {
                 let varGetValueBAE:String!=(muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "typeCheck")as? String
                 let titleText:String=(muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "title")as! String
                 
                 
                 var height:CGFloat=93.0
                 
                 if(varGetValueBAE=="repeat")
                 {
                     height = 95.0;//Choose your custom row height
                 }
                 else
                 {
                     height = 120.0;//Choose your custom row height
                 }
                
                 if titleText.count<=35
                 {
                     height=height-30
                 }
                 else if titleText.count > 35 && titleText.count <= 45
                 {
                     height=height-20
                 }
                 
                 return height
                 //return tableBAERowHeight
             }
             else  if(tableView==self.tableviewBirthday)
             {
                 let titleText:String=((muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String)!
                 var height:CGFloat=100.0
                 
                 if(varGetEventDate=="repeating")
                 {
                     height = 90.0
                 }
                 else
                 {
                     height = 120.0
                 }
                 
                 if titleText.count<=35
                 {
                     height=height-30
                 }
                 else if titleText.count > 35 && titleText.count<=45
                 {
                     height=height-20
                 }
                 return height

                 
            //     return tableBirthdayRowHeight
             }
                 
                 //
             else  if(tableView==self.tableviewAnnivNew)
             {
                 
                 let titleText:String=((muarrayHoldDataNew.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String)!
                 var height:CGFloat=100.0
                 if(varGetEventDate=="repeating")
                 {
                     height = 90.0
                 }
                 else
                 {
                     height = 120.0
                 }
                 
                 if titleText.count<=35
                 {
                     height=height-30
                 }
                 else if titleText.count > 35 && titleText.count<=45
                 {
                     height=height-20
                 }
                 return height

              //   return tableAnniversaryTabRowHeight
             }
             else  if(tableView==self.tableviewEventEventEvent)
             {
                 let titleText:String=((muarrayHoldDataNewEvent.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String)!
                 var height:CGFloat=120.0
     //            if(varGetEventDate=="repeating")
     //            {
     //                height=90.0
     //            }
     //            else
     //            {
     //                height=120.0
     //            }
     //
     //            if titleText.count<=35
     //            {
     //                //height=height-30
     //            }
     //            else if titleText.count > 35 && titleText.count<=45
     //            {
     //               // height=height-20
     //            }
                 return height
             //    return tableEventTabRowHeight
             }
             else  if(tableView==self.tableviewBirthAnniv)
             {
                 return 60.0
             }
             //tableviewBirthAnniv
             return 0
         }
     */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(tableView==self.tableviewEventAnnivBirthDay)
        {
            let varGetValueBAE:String!=(muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "typeCheck")as? String
            let titleText:String=(muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "title")as! String
            
            
            var height:CGFloat=93.0
            
            if(varGetValueBAE=="repeat")
            {
                height = 95.0;//Choose your custom row height
            }
            else
            {
                height = 120.0;//Choose your custom row height
            }

            if titleText.count<=35
            {
                height=height-30
            }
            else if titleText.count > 35 && titleText.count <= 45
            {
                height=height-20
            }
            
            return height
            //return tableBAERowHeight
        }
        else  if(tableView==self.tableviewBirthday)
        {
            var height:CGFloat=100.0
            if (muarrayHoldData != nil && muarrayHoldData.count > 0){
            let titleText:String=((muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String)!
                if(varGetEventDate=="repeating")
            {
                height = 90.0
            }
            else
            {
                height = 120.0
            }
            
            if titleText.count<=35
            {
                height=height-30
            }
            else if titleText.count > 35 && titleText.count<=45
            {
                height=height-20
            }
            }
            print("Height for birthday table \(height)")
            return height

            
       //     return tableBirthdayRowHeight
        }
        else  if(tableView==self.tableviewAnnivNew)
        {
            
            let titleText:String=((muarrayHoldDataNew.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String)!
            var height:CGFloat=100.0
            if(varGetEventDate=="repeating")
            {
                height = 90.0
            }
            else
            {
                height = 120.0
            }
            
            if titleText.count<=35
            {
                height=height-30
            }
            else if titleText.count > 35 && titleText.count<=45
            {
                height=height-20
            }
            return height

         //   return tableAnniversaryTabRowHeight
        }
        else  if(tableView==self.tableviewEventEventEvent)
        {
            let titleText:String=((muarrayHoldDataNewEvent.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String)!
            var height:CGFloat=120.0
            if(varGetEventDate=="repeating")
            {
                height=90.0
            }
            else
            {
                height=120.0
            }
            
            if titleText.count<=35
            {
                height=height-30
            }
            else if titleText.count > 35 && titleText.count<=45
            {
                height=height-20
            }
            return height
        //    return tableEventTabRowHeight
        }
        else  if(tableView==self.tableviewBirthAnniv)
        {
            return 60.0
        }
        //tableviewBirthAnniv
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(tableView==self.tableviewEventAnnivBirthDay)
        {
            return muarrayHoldDateWiseData.count
        }
        else  if(tableView==self.tableviewBirthday)
        {
            return muarrayHoldData.count
        }
        else  if(tableView==self.tableviewAnnivNew)
        {
            return muarrayHoldDataNew.count
        }
        else  if(tableView==self.tableviewEventEventEvent)
        {
            return muarrayHoldDataNewEvent.count
        }
            
        else  if(tableView==self.tableviewBirthAnniv)
        {
            return getCountTableviewBirthAnniv
        }
        return 0;
    }

    @objc func buttonCalendarViewWhatsAppClickEvent(_ sender:UIButton)
    {
        getCountTableviewBirthAnniv=0
        muarrayBAPopup=NSMutableArray()
        getCountTableviewBirthAnniv = ((muarrayHoldDateWiseData.object(at: sender.tag) as AnyObject).value(forKey: "muarrayMobileNoContact")! as AnyObject).count
        muarrayBAPopup=(muarrayHoldDateWiseData.object(at: sender.tag) as AnyObject).value(forKey: "muarrayMobileNoContact")! as! NSMutableArray
        IsEmailSMSCall = "whatsapp"
        buttonSend.isHidden=true
        isBirthdayorAnniv="anniv"
        //muarrayHoldDataNew=muarrayBAPopup
        if(muarrayBAPopup.count>0)
        {
            buttonOpacity.isHidden=false
            tableviewBirthAnniv.reloadData()
            viewBirthAnnivPopupss.isHidden=false
            let window = UIApplication.shared.keyWindow!
            window.addSubview(viewBirthAnnivPopupss);
        }
        tableviewBirthAnniv.reloadData()
    }
    
    
    @objc func buttonCalendarViewCallClickEvent(_ sender:UIButton)
    {
        getCountTableviewBirthAnniv=0
        muarrayBAPopup=NSMutableArray()
        getCountTableviewBirthAnniv = ((muarrayHoldDateWiseData.object(at: sender.tag) as AnyObject).value(forKey: "muarrayMobileNoContact")! as AnyObject).count
        muarrayBAPopup=(muarrayHoldDateWiseData.object(at: sender.tag) as AnyObject).value(forKey: "muarrayMobileNoContact")! as! NSMutableArray
        IsEmailSMSCall = "Call"
        buttonSend.isHidden=true
        isBirthdayorAnniv="anniv"
//        muarrayHoldDataNew=muarrayBAPopup
        
        IsEmailSMSCall = "Call"
        if(muarrayBAPopup.count>0)
        {
            buttonOpacity.isHidden=false
            tableviewBirthAnniv.reloadData()
            viewBirthAnnivPopupss.isHidden=false
            
            let window = UIApplication.shared.keyWindow!
            window.addSubview(viewBirthAnnivPopupss);
            
            
        }
        tableviewBirthAnniv.reloadData()

       
    }
    @objc func buttonCalendarViewSMSClickEvent(_ sender:UIButton)
    {
        /*-----------------------------------------------------------*/
        buttonSend.isHidden=false
        ////print("SMS click !!!!!!!",sender.tag)
        IsEmailSMSCall = "Message"
    
        ////print("if sms click !!!!!!! by ")
       
        
        getCountTableviewBirthAnniv=0
        muarrayBAPopup=NSMutableArray()

        
        getCountTableviewBirthAnniv = ((muarrayHoldDateWiseData.object(at: sender.tag) as AnyObject).value(forKey: "muarrayMobileNoContact")! as AnyObject).count
        muarrayBAPopup=(muarrayHoldDateWiseData.object(at: sender.tag) as AnyObject).value(forKey: "muarrayMobileNoContact")! as! NSMutableArray
        
        
        muarrayBACheckUncheckPopup=NSMutableArray()
        //muarrayHoldData=muarrayBAPopup
        for i in 00..<muarrayBAPopup.count
        {
            muarrayBACheckUncheckPopup.add("0")
        }
        buttonOpacity.isHidden=false
        tableviewBirthAnniv.reloadData()
        viewBirthAnnivPopupss.isHidden=false
        let window = UIApplication.shared.keyWindow!
        window.addSubview(viewBirthAnnivPopupss);
        /*-----------------------------------------------------------*/
        ////print(muarrayBAPopup)
    }
    
 @objc  func buttonCalendarViewEmailClickEvent(_ sender:UIButton)
    {
        if(varForEventOPen == 1)
        {
            varForEventOPen = 0
        }
        else
        {
            getCountTableviewBirthAnniv=0
            muarrayBAPopup=NSMutableArray()
            buttonSend.isHidden=false
            IsEmailSMSCall = "email"
            ////print("if email click !!!!!!!2222")
            getCountTableviewBirthAnniv = ((muarrayHoldDateWiseData.object(at: sender.tag) as AnyObject).value(forKey: "muarrayEmail")! as AnyObject).count
            muarrayBAPopup=(muarrayHoldDateWiseData.object(at: sender.tag) as AnyObject).value(forKey: "muarrayEmail")! as! NSMutableArray
            muarrayBACheckUncheckPopup=NSMutableArray()
            
            ////print(muarrayBAPopup)
            ////print(getCountTableviewBirthAnniv)
             //muarrayHoldData=muarrayBAPopup
            for i in 00..<muarrayBAPopup.count
            {
                muarrayBACheckUncheckPopup.add("0")
            }
            if(muarrayBAPopup.count>0)
            {
                viewBirthAnnivPopupss.isHidden=false
                let window = UIApplication.shared.keyWindow!
                window.addSubview(viewBirthAnnivPopupss);
                buttonOpacity.isHidden=false
                tableviewBirthAnniv.reloadData()
            }
            else
            {
              //  self.view.makeToast("No Email available 11", duration: 2, position: CSToastPositionCenter)
            }
            //------
            
            
            

            
        }
    }

    func isValidEmail(_ testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
   @objc  func buttonCalendarViewEventClickEvent(_ sender:UIButton)
    {
        
        varForEventOPen = 1
        ////print(sender.tag)
        ////print("calendar view event")
        
        /*--------------DPK--------------------27-03-2018-----------*/

        var getMemberID:String!=""

      
        
        ////print(muarrayHoldDateWiseData)
        getMemberID=(muarrayHoldDateWiseData.object(at: sender.tag) as AnyObject).value(forKey: "MemberID")as? String
        ////print(getMemberID)

    
        let fullName    = getMemberID
        let fullNameArr = fullName?.components(separatedBy: "E")
        
      
        getMemberID = fullNameArr![1]
        ////print(getMemberID)
        
        

        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)

   
        {
            if(isCategory=="2")
            {
                ////print(muarrayHoldDateWiseData.object(at: sender.tag))
                ////print(muarrayHoldDateWiseData)
                
                /*
                 let objClubEventDetailsShowViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DistrictEventDetailsShowViewController") as! DistrictEventDetailsShowViewController
                 objClubEventDetailsShowViewController.eventID = getMemberID
                 self.navigationController?.pushViewController(objClubEventDetailsShowViewController, animated: true)
                 */
                UserDefaults.standard.set(self.isAdmin, forKey: "isAdmin")
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "eventDetail") as! EventsDetailController
                //print("EventsDetailController Clling in 5")
                //secondViewController.grpDetailPrevious = grpDetailPrevious
                secondViewController.profileId = stringProfileId
                //secondViewController.grpId = stringGroupID as! NSString
                secondViewController.grpId = (muarrayHoldDateWiseData.object(at: sender.tag)as! NSDictionary).object(forKey: "GroupIdNew")as? String as! NSString
                secondViewController.eventID = getMemberID as! NSString
                secondViewController.isCalled = "fromcelebreation"
                secondViewController.varIsRSVPEnableorDisable=0
                secondViewController.isAdmin = self.isAdmin
                secondViewController.isCategory=self.isCategory
                secondViewController.varType = self.varType
                secondViewController.grpName=self.grpName
                secondViewController.grpIdForCheckDifference=stringGroupID as! NSString
                //secondViewController.SMSCountStr = SMSCountStr
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }
            else
            {
                UserDefaults.standard.set(self.isAdmin, forKey: "isAdmin")
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "eventDetail") as! EventsDetailController
                //print("EventsDetailController Clling in 6")
                //secondViewController.grpDetailPrevious = grpDetailPrevious
                secondViewController.profileId = stringProfileId
                secondViewController.grpId = stringGroupID as! NSString
                secondViewController.eventID = getMemberID as! NSString
                ////print(getMemberID)
                secondViewController.isAdmin = self.isAdmin
                secondViewController.grpName=self.grpName
                secondViewController.isCalled = "fromcelebreation"
                secondViewController.varIsRSVPEnableorDisable=0
                secondViewController.isCategory=self.isCategory
                secondViewController.varType = self.varType
                //secondViewController.SMSCountStr = SMSCountStr
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }
        }
        else
        {
            self.view.makeToast("Could not connect to server.", duration: 2, position: CSToastPositionCenter)
            //SVProgressHUD.dismiss()
        }
    }
    /*-this code for when user dragging tableview more-*/
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if scrollView == tableviewBirthday
        {
            ////print("Birthday dragging........")
        }
        else  if scrollView == tableviewAnnivNew
        {
            ////print("Anniversary dragging........")
        }
        else  if scrollView == tableviewEventEventEvent
        {
            ////print("Event dragging........")
        }
    }
    /*
     tableviewEventEventEvent tableviewAnnivNew tableviewBirthday
     */
    
    
    var IsBirthAnnivEventAlreadyExist:String!=""
    
    //    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
    //    {
    //        searchBar.resignFirstResponder()
    //        if scrollView == directoryTableView
    //        {
    //            buttonUp.hidden=false
    //            buttonDown.hidden=false
    //            //////print(varGetCount)
    //            //self.lastKnowContentOfsset = scrollView.contentOffset.y
    //            // ////print("lastKnowContentOfsset: ", scrollView.contentOffset.y)
    //            self.view.makeToast("Total members "+varGetCount, duration: 2, position: kCATransitionFromBottom)
    //            var helloWorldTimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("functionForHideTopandDownButton"), userInfo: nil, repeats: false)
    //        }
    //
    //    }
    
    
    
    //MARK:- Cellfor row of tableview backup on 24 march 2020
    
    /*
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
         if(tableView==self.tableviewEventAnnivBirthDay)
         {
             ////print("algo 1")
             // muarrayGetDataFromDayWiseOrMonthWise
             
             prototypeCells  = tableView.dequeueReusableCell(withIdentifier: reuseIdentifiers) as! CelebreationEventAnnivBirthdayTableViewCell
             tableBAERowHeight=prototypeCells.frame.height
             if(muarrayHoldDateWiseData.count>0)
             {
                 prototypeCells.labelLine.isHidden=false
                  ////print("algo 2")
                 if(indexPath.row==0)
                 {
                     prototypeCells.labelLine.isHidden=true
                 }
                 ////print(muarrayHoldDateWiseData)
                 ////print((muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "type"))
                 ////print((muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "EmailId"))
                 
                 prototypeCells.viewAlls.frame = CGRect(x: 5, y: 0, width: prototypeCells.viewAlls.frame.size.width, height: prototypeCells.viewAlls.frame.size.height)
                 
                 var getType:String!=(muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "type")as! String
                 if(getType=="Birthday" || getType=="Anniversary")
                 {
                     varForEventOPen = 0
                     if(getType=="Birthday")
                     {
                         prototypeCells.buttonImageBAE.setBackgroundImage(UIImage(named: "calEE"),  for: UIControl.State.normal)
                     }
                     else  if(getType=="Anniversary")
                     {
                         prototypeCells.buttonImageBAE.setBackgroundImage(UIImage(named: "ann"),  for: UIControl.State.normal)
                     }
                     
                     prototypeCells.buttonCall.isHidden=false
                     prototypeCells.buttonSMS.isHidden=false
                     prototypeCells.buttonEmail.isHidden=false
                     prototypeCells.buttonWhatsApp.isHidden=false

                     
                     
                     
                     prototypeCells.buttonEventNext.isHidden=true
                     prototypeCells.buttonEventNewEventss.isHidden=true
                  
                     
                     
                     var varGetValueBAE:String!=(muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "typeCheck")as! String
                     
                     if(varGetValueBAE=="repeat")
                     {
                         prototypeCells.viewAlls.frame = CGRect(x: 5, y: -32, width: prototypeCells.viewAlls.frame.size.width, height: prototypeCells.viewAlls.frame.size.height)
                         tableBAERowHeight=tableBAERowHeight-32.0
                     }
                     let isValid = isValidEmail((muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "EmailId") as! String)
                     ////print(isValid)
                     ////print("This is value for Birthday anniv Emails")
                     ////print(muarrayHoldDateWiseData)
                     ////print("end statement")
                     
                     
                     /*
                      muarrayEmail =         (
                      {
                      Email
                      */
                     ////print("this is index path")
                     ////print(muarrayHoldDateWiseData)
                     ////print(indexPath.row)
                     var muarrayTemp:NSMutableArray = (((muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "muarrayEmail")as AnyObject))as! NSMutableArray

                     ////print(muarrayTemp.count)
                     ////print(muarrayTemp)

                    
                     //var varGetValue:String! = (((muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "muarrayEmail")as AnyObject).object(at: 0)as AnyObject).value(forKey: "Email") as! String
                     
                    // ////print(varGetValue)
                     
                    // if(varGetValue.characters.count>0)
                  if(muarrayTemp.count>0)
                     {
                         prototypeCells.buttonEmail.setImage(UIImage(named: "mail_blue"),  for: UIControl.State.normal)
                     }
                     else
                     {
                          prototypeCells.buttonEmail.setImage(UIImage(named: "sermail.png"),  for: UIControl.State.normal)
                     }
                     
                     
                     /*
                     if((muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "EmailId") as! String == "" && isValid==false)
                     {
                         prototypeCells.buttonEmail.setImage(UIImage(named: "sermail.png"),  for: UIControl.State.normal)
                     }
                     else if (isValid==true && (muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "EmailId") as! String != "")
                     {
                         prototypeCells.buttonEmail.setImage(UIImage(named: "mail_blue"),  for: UIControl.State.normal)
                     }
                     */
                 }
                 else if(getType=="Event")
                 {
                     var varGetValueBAE:String!=(muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "typeCheck")as! String
                     prototypeCells.buttonImageBAE.setBackgroundImage(UIImage(named: "eventssss"),  for: UIControl.State.normal)
                     
                     self.varForEventOPen = 1
                     if(varGetValueBAE=="repeat")
                     {
                         prototypeCells.viewAlls.frame = CGRect(x: 5, y: -32, width: prototypeCells.viewAlls.frame.size.width, height: prototypeCells.viewAlls.frame.size.height)
                         
                     }
                     
                     
                     prototypeCells.buttonWhatsApp.isHidden=true

                     
                     
                     prototypeCells.buttonCall.isHidden=true
                     prototypeCells.buttonSMS.isHidden=true
                     prototypeCells.buttonEmail.isHidden=true
                     prototypeCells.buttonEventNext.isHidden=false
                     prototypeCells.buttonEventNewEventss.isHidden=false
                     
                     
                     
                     prototypeCells.buttonEventNext.addTarget(self, action: #selector(buttonCalendarViewEventClickEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                     
                     
                     prototypeCells.buttonEventNext.tag=indexPath.row
                 }
                 
                 
                 prototypeCells.buttonWhatsApp.addTarget(self, action: #selector(buttonCalendarViewWhatsAppClickEvent(_:)), for: UIControl.Event.touchUpInside)
                 prototypeCells.buttonWhatsApp.tag=indexPath.row
                 
                 
                 
                 prototypeCells.buttonCall.addTarget(self, action: #selector(buttonCalendarViewCallClickEvent(_:)), for: UIControl.Event.touchUpInside)
                 prototypeCells.buttonCall.tag=indexPath.row
                 
                 
                 
                 
                 prototypeCells.buttonSMS.addTarget(self, action: #selector(buttonCalendarViewSMSClickEvent(_:)), for: UIControl.Event.touchUpInside)
                 prototypeCells.buttonSMS.tag=indexPath.row
                 
                 
                 
                 
                 prototypeCells.buttonEmail.addTarget(self, action: #selector(buttonCalendarViewEmailClickEvent(_:)), for: UIControl.Event.touchUpInside)
                 prototypeCells.buttonEmail.tag=indexPath.row

                 prototypeCells.labelTitle.text=(muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "title")as! String
                 
                 let titleText:String=(muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "title")as! String
                 
                 if titleText.count<=35
                 {
                       prototypeCells.labelTitle.frame=CGRect(x: prototypeCells.labelTitle.frame.origin.x, y: prototypeCells.labelTitle.frame.origin.y, width: prototypeCells.labelTitle.frame.width, height: 37.0)
                     tableBAERowHeight=tableBAERowHeight-30.0
                 }
                 else if titleText.count > 35 && titleText.count <= 45
                 {
                     prototypeCells.labelTitle.frame=CGRect(x: prototypeCells.labelTitle.frame.origin.x, y: prototypeCells.labelTitle.frame.origin.y, width: prototypeCells.labelTitle.frame.width, height: 45.0)
                     tableBAERowHeight=tableBAERowHeight-20.0
                 }
                 else
                 {
                     prototypeCells.labelTitle.frame=CGRect(x: prototypeCells.labelTitle.frame.origin.x, y: prototypeCells.labelTitle.frame.origin.y, width: prototypeCells.labelTitle.frame.width, height: 57.0)
                     
                 }
                 
                 
                 // prototypeCells.labelDate.text = objCalendarInfo.stringDateMonth
                 let lblTypeBAE = (muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "typeCheck")as! String
                 
                 if(lblTypeBAE=="Birthday")
                 {
                     prototypeCells.labelType.text = "Birthdays"
                 }
                 if(lblTypeBAE=="Anniversary")
                 {
                     prototypeCells.labelType.text = "Anniversaries"
                     //Anniversaries
                 }
                 if(lblTypeBAE=="Event")
                 {
                     prototypeCells.labelType.text = "Events"
                 }
                 ////print("2222222222222222222222222222",lblTypeBAE)
                 //prototypeCells.labelType.text = lblTypeBAE+"'s"
                 // prototypeCells.lableTime.text=objCalendarInfo.stringTime
                 
                 prototypeCells.buttonMainClickEvent.addTarget(self, action: #selector(CelebrationViewController.buttonMainEventBirthAnnivClickEvent(_:)), for: UIControl.Event.touchUpInside)
                 prototypeCells.buttonMainClickEvent.tag=indexPath.row
             }
         }
             //muarrayHoldDateWiseData
             
             
             
         else if(tableView==self.tableviewBirthday)
         {
             let prototypeCell : NewCalendarTableViewCell! = tableviewBirthday.dequeueReusableCell(withIdentifier: "tableCell") as! NewCalendarTableViewCell
             tableBirthdayRowHeight=prototypeCell.frame.height
             
             if(muarrayHoldData.count>0)
             {
                 // prototypeCell.configureCellServicesProviderList(arrayResponse.objectAtIndex(indexPath.row) as! NSDictionary)
                 prototypeCell.configureCellServicesProviderList((arrayResponse.object(at: indexPath.row) as! NSDictionary), indexpath: indexPath.row)
                 
                 prototypeCell.labelDate.isHidden=false
                 prototypeCell.labelPersonName.isHidden=false
                 // ////print((muarrayHoldData.objectAtIndex(indexPath.row)as! NSDictionary))
                 ////print((muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "eventDate")as? String)
                 
                 prototypeCell.labelDate.numberOfLines=3
                 prototypeCell.labelDate.attributedText=(muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "eventDate")as? NSAttributedString
                 prototypeCell.labelPersonName.text=(muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String
                 let titleText:String=((muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String)!
                 if titleText.count<=35
                 {
                     prototypeCell.labelPersonName.frame=CGRect(x: prototypeCell.labelPersonName.frame.origin.x, y: prototypeCell.labelPersonName.frame.origin.y, width: prototypeCell.labelPersonName.frame.width, height: 37.0)
                     tableBirthdayRowHeight=tableBirthdayRowHeight-30.0
                 }
                 else if titleText.count > 35 && titleText.count <= 45
                 {
                     prototypeCell.labelPersonName.frame=CGRect(x: prototypeCell.labelPersonName.frame.origin.x, y: prototypeCell.labelPersonName.frame.origin.y, width: prototypeCell.labelPersonName.frame.width, height: 45.0)
                     tableBirthdayRowHeight=tableBirthdayRowHeight-20.0
                 }

                 
                 
                 varGetEventDate=(muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "compareDate")as! String
                 //print("Compare date for Birthday at index Path ::  \(indexPath.row): : : \(varGetEventDate!)")
                 if(varGetEventDate!=="repeating")
                 {
                     prototypeCell.labelDate.isHidden=true
                     prototypeCell.viewAll.frame = CGRect(x: 5, y: -50, width: prototypeCell.viewAll.frame.size.width, height: prototypeCell.viewAll.frame.size.height)
                     tableBirthdayRowHeight=tableBirthdayRowHeight-50.0
                 }
                 else
                 {
                     prototypeCell.viewAll.frame = CGRect(x: 5, y: 0, width: prototypeCell.viewAll.frame.size.width, height: prototypeCell.viewAll.frame.size.height)
                     if(indexPath.row==0)
                     {
                         //here condition is that for Todays Birthday
                         let getTodatDate = commonClassFunction().functionForGetTodatDate()
                         let varGetEventDateRepeat:String!=(muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "compareDate")as! String
                         
                     }
                     else
                     {
                         
                     }
                 }
                 
                 prototypeCell.buttonWhatsApp.addTarget(self, action: #selector(buttonWhatsApp2ClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                 prototypeCell.buttonWhatsApp.tag=indexPath.row;
                 //1.
                 prototypeCell.buttonCall.addTarget(self, action: #selector(buttonCallClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                 prototypeCell.buttonCall.tag=indexPath.row;
                 //2.
                 prototypeCell.buttonSMS.addTarget(self, action: #selector(buttonSMSClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                 prototypeCell.buttonSMS.tag=indexPath.row;
                 //3.
                 prototypeCell.buttoEmail.addTarget(self, action: #selector(buttonEmailClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                 prototypeCell.buttoEmail.tag=indexPath.row;
                 
                 /*here need to check email if not available then disable that button*/
                 //EmailId
                 let getUserEmailId:String!=(muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "EmailId")as? String
                 if(getUserEmailId.characters.count>3)
                 {
                     ////print("This is if in cell for row")
                 }
                 else
                 {
                     ////print("This is else in cell for row")
                     muarrayBAPopup=(muarrayHoldData.object(at: indexPath.row) as AnyObject).value(forKey: "arrayEmail")! as! NSMutableArray
                     ////print(muarrayBAPopup)
                     if(muarrayBAPopup.count>0)
                     {
                         
                         prototypeCell.buttoEmail.setBackgroundImage(UIImage(named: "mail_blue"),  for: UIControl.State.normal)
                         
                         
                         prototypeCell.buttoEmail.isEnabled=true
                     }
                     else
                     {
                         prototypeCell.buttoEmail.setBackgroundImage(UIImage(named: "sermail.png"),  for: UIControl.State.normal)
                         prototypeCell.buttoEmail.isEnabled=true
                         
                         //  prototypeCell.buttoEmail.enabled=false
                         
                         
                         
                     }
                 }
             }
             return prototypeCell as NewCalendarTableViewCell
         }
             
             
             ///////////////////-----------------------------
         else if(tableView==self.tableviewAnnivNew)
         {
             let prototypeCell : NewCalendarTableViewCell! = tableviewBirthday.dequeueReusableCell(withIdentifier: "tableCell") as! NewCalendarTableViewCell
             tableAnniversaryTabRowHeight=prototypeCell.frame.height
             if(muarrayHoldDataNew.count>0)
             {
                 // prototypeCell.configureCellServicesProviderList(arrayResponse.objectAtIndex(indexPath.row) as! NSDictionary)
                 prototypeCell.configureCellServicesProviderList((arrayResponseNew.object(at: indexPath.row) as! NSDictionary), indexpath: indexPath.row)
                 
                 prototypeCell.labelDate.isHidden=false
                 prototypeCell.labelPersonName.isHidden=false
                 // ////print((muarrayHoldData.objectAtIndex(indexPath.row)as! NSDictionary))
                 prototypeCell.labelDate.attributedText=(muarrayHoldDataNew.object(at: indexPath.row)as! NSDictionary).object(forKey: "eventDate")as? NSAttributedString
                 prototypeCell.labelPersonName.text=(muarrayHoldDataNew.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String
                 let titleText:String=((muarrayHoldDataNew.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String)!
                 if titleText.count<=35
                 {
                     prototypeCell.labelPersonName.frame=CGRect(x: prototypeCell.labelPersonName.frame.origin.x, y: prototypeCell.labelPersonName.frame.origin.y, width: prototypeCell.labelPersonName.frame.width, height: 37.0)
                     tableAnniversaryTabRowHeight=tableAnniversaryTabRowHeight-30.0
                 }
                 else if titleText.count > 35 && titleText.count <= 45
                 {
                     prototypeCell.labelPersonName.frame=CGRect(x: prototypeCell.labelPersonName.frame.origin.x, y: prototypeCell.labelPersonName.frame.origin.y, width: prototypeCell.labelPersonName.frame.width, height: 45.0)
                     tableAnniversaryTabRowHeight=tableAnniversaryTabRowHeight-20.0
                 }

                 
                 varGetEventDate=(muarrayHoldDataNew.object(at: indexPath.row)as! NSDictionary).object(forKey: "compareDate")as! String
                 if(varGetEventDate=="repeating")
                 {
                     prototypeCell.labelDate.isHidden=true
                     prototypeCell.viewAll.frame = CGRect(x: 5, y: -42, width: prototypeCell.viewAll.frame.size.width, height: prototypeCell.viewAll.frame.size.height)
                     tableAnniversaryTabRowHeight=tableAnniversaryTabRowHeight-42
                 }
                 else
                 {
                     prototypeCell.viewAll.frame = CGRect(x: 5, y: 0, width: prototypeCell.viewAll.frame.size.width, height: prototypeCell.viewAll.frame.size.height)
                     if(indexPath.row==0)
                     {
                         //here condition is that for Todays Birthday
                         let getTodatDate = commonClassFunction().functionForGetTodatDate()
                         let varGetEventDateRepeat:String!=(muarrayHoldDataNew.object(at: indexPath.row)as! NSDictionary).object(forKey: "compareDate")as! String
                         
                     }
                     else
                     {
                         
                     }
                 }
                 
                 
                 
                 prototypeCell.buttonWhatsApp.addTarget(self, action: #selector(CelebrationViewController.buttonWhastapp3ClickedEventAni(_:)), for: UIControl.Event.touchUpInside)
                 prototypeCell.buttonWhatsApp.tag=indexPath.row;
                 
                 
                 
                 
                 //1.
                 prototypeCell.buttonCall.addTarget(self, action: #selector(CelebrationViewController.buttonCallClickedEventAni(_:)), for: UIControl.Event.touchUpInside)
                 prototypeCell.buttonCall.tag=indexPath.row;
                 //2.
                 prototypeCell.buttonSMS.addTarget(self, action: #selector(CelebrationViewController.buttonSMSClickedEventAni(_:)), for: UIControl.Event.touchUpInside)
                 prototypeCell.buttonSMS.tag=indexPath.row;
                 //3.
                 prototypeCell.buttoEmail.addTarget(self, action: #selector(CelebrationViewController.buttonEmailClickedEventAni(_:)), for: UIControl.Event.touchUpInside)
                 prototypeCell.buttoEmail.tag=indexPath.row;
                 
                 /*here need to check email if not available then disable that button*/
                 //EmailId
                 let getUserEmailId:String!=(muarrayHoldDataNew.object(at: indexPath.row)as! NSDictionary).object(forKey: "EmailId")as? String
                 if(getUserEmailId.characters.count>3)
                 {
                     ////print("This is if in cell for row")
                 }
                 else
                 {
                     ////print("This is else in cell for row")
                     muarrayBAPopupNew=(muarrayHoldDataNew.object(at: indexPath.row) as AnyObject).value(forKey: "arrayEmail")! as! NSMutableArray
                     ////print(muarrayBAPopupNew)
                     if(muarrayBAPopupNew.count>0)
                     {
                         
                         prototypeCell.buttoEmail.setBackgroundImage(UIImage(named: "mail_blue"),  for: UIControl.State.normal)
                         
                         
                         prototypeCell.buttoEmail.isEnabled=true
                     }
                     else
                     {
                         prototypeCell.buttoEmail.setBackgroundImage(UIImage(named: "sermail.png"),  for: UIControl.State.normal)
                         // prototypeCell.buttoEmail.enabled=false
                         prototypeCell.buttoEmail.isEnabled=true
                         
                         
                     }
                 }
             }
             return prototypeCell as NewCalendarTableViewCell
         }
             
             /////////////////////////
         else if(tableView==self.tableviewEventEventEvent)
         {
             let prototypeCell : NewCalendarTableViewCell! = tableviewBirthday.dequeueReusableCell(withIdentifier: "tableCell") as! NewCalendarTableViewCell
             
             tableEventTabRowHeight=prototypeCell.frame.height
             if(muarrayHoldDataNewEvent.count>0)
             {
                 prototypeCell.buttonEventTapClickEvent.isHidden=false
                 prototypeCell.buttonEventArrows.isHidden=false
                 // prototypeCell.configureCellServicesProviderList(arrayResponse.objectAtIndex(indexPath.row) as! NSDictionary)
                 prototypeCell.configureCellServicesProviderList((arrayResponseNewEvent.object(at: indexPath.row) as! NSDictionary), indexpath: indexPath.row)
                 prototypeCell.buttonWhatsApp.isHidden=true
                 
                 prototypeCell.buttonCall.isHidden=true
                 prototypeCell.buttonSMS.isHidden=true
                 prototypeCell.buttoEmail.isHidden=true
                 //prototypeCell.buttonEventEvent.hidden=false
                 
                 //prototypeCell.buttoEmail.setBackgroundImage(UIImage(named: "calendar"),  for: UIControl.State.normal)
                 //buttonEventTapClickEvent
                 prototypeCell.labelDate.isHidden=false
                 prototypeCell.labelPersonName.isHidden=false
                 // ////print((muarrayHoldData.objectAtIndex(indexPath.row)as! NSDictionary))
                 prototypeCell.labelDate.attributedText=(muarrayHoldDataNewEvent.object(at: indexPath.row)as! NSDictionary).object(forKey: "eventDate")as? NSAttributedString
                 prototypeCell.labelPersonName.text=(muarrayHoldDataNewEvent.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String
                 
                 let titleText:String=((muarrayHoldDataNewEvent.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String)!
                 if titleText.count<=35
                 {
                    // prototypeCell.labelPersonName.frame=CGRect(x: prototypeCell.labelPersonName.frame.origin.x, y: prototypeCell.labelPersonName.frame.origin.y, width: prototypeCell.labelPersonName.frame.width, height: 37.0)
                     tableEventTabRowHeight=tableEventTabRowHeight-30.0
                 }
                 else if titleText.count > 35 && titleText.count <= 45
                 {
        //             prototypeCell.labelPersonName.frame=CGRect(x: prototypeCell.labelPersonName.frame.origin.x, y: prototypeCell.labelPersonName.frame.origin.y, width: prototypeCell.labelPersonName.frame.width, height: 45.0)
                     tableEventTabRowHeight=tableEventTabRowHeight-20.0
                 }

                 
                 varGetEventDate=(muarrayHoldDataNewEvent.object(at: indexPath.row)as! NSDictionary).object(forKey: "compareDate")as! String
                 
                 if(varGetEventDate=="repeating")
                 {
                     prototypeCell.labelDate.isHidden=true
                  //   prototypeCell.viewAll.frame = CGRect(x: 5, y: -45, width: prototypeCell.viewAll.frame.size.width, height: prototypeCell.viewAll.frame.size.height)
                     tableEventTabRowHeight=tableEventTabRowHeight-42.0
                 }
                 else
                 {
                     prototypeCell.viewAll.frame = CGRect(x: 5, y: 0, width: prototypeCell.viewAll.frame.size.width, height: prototypeCell.viewAll.frame.size.height+50)
                     if(indexPath.row==0)
                     {
                         //here condition is that for Todays Birthday
                         let getTodatDate = commonClassFunction().functionForGetTodatDate()
                         let varGetEventDateRepeat:String!=(muarrayHoldDataNewEvent.object(at: indexPath.row)as! NSDictionary).object(forKey: "compareDate")as! String
                     }
                     else
                     {
                         
                     }
                 }
                 //1.
                 prototypeCell.buttonEventTapClickEvent.addTarget(self, action: #selector(CelebrationViewController.functionForGoToEventDetailFromEventScreen(_:)), for: UIControl.Event.touchUpInside)
                 prototypeCell.buttonEventTapClickEvent.tag=indexPath.row;
                 
             }
             return prototypeCell as NewCalendarTableViewCell
         }
             //////////////////------------------------------
             
             
             
             
             
         else  if(tableView==self.tableviewBirthAnniv)
         {
             let prototypeCells : BirthAnnivPopupTableViewCell! = tableviewBirthAnniv.dequeueReusableCell(withIdentifier: "Cell") as! BirthAnnivPopupTableViewCell
             
             ////print("hello rajendra here")
             ////print(isBirthdayorAnniv)
             ////print(IsEmailSMSCall)
             ////print(muarrayHoldDataNew)
             ////print(muarrayHoldDataNew.count)
             if(isBirthdayorAnniv=="birthday")
             {
                 if(muarrayHoldData.count>0)
                 {
                     labelChangeEmailCallSMS.text=IsEmailSMSCall
                     if(IsEmailSMSCall == "Call")
                     {
                         //
                         ////print("algo 5")
                         ////print(muarrayBAPopup)
                         let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Mobile")as! String
                         let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                         prototypeCells.buttonCall.isHidden=false
                         prototypeCells.buttonSMS.isHidden=true
                         prototypeCells.buttonEmail.isHidden=true
                         
                         
                         prototypeCells.buttonCallMain.isHidden=false
                         prototypeCells.buttonSMSMain.isHidden=true
                         prototypeCells.buttonEmailMain.isHidden=true
                         prototypeCells.buttonWhatsApp.isHidden=true
                         
                         
                         
                         prototypeCells.labelEmailCallSMSPersonName.text=valleName
                         prototypeCells.labelEmailCallSMS.text=valleMobile
                         
                         
                     }
                         
                         //whatsapp code by rajendra jat on 20 dec 2018 2.58pm
                   else  if(IsEmailSMSCall == "whatsapp")
                     {
                         //
                         ////print("algo 5")
                         ////print(muarrayBAPopup)
                         let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Mobile")as! String
                         let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                         prototypeCells.buttonCall.isHidden=true
                         prototypeCells.buttonSMS.isHidden=true
                         prototypeCells.buttonEmail.isHidden=true
                            prototypeCells.buttonWhatsApp.isHidden=false
                         
                         prototypeCells.buttonCallMain.isHidden=true
                         prototypeCells.buttonSMSMain.isHidden=true
                         prototypeCells.buttonEmailMain.isHidden=true
                         
                         
                         
                         prototypeCells.labelEmailCallSMSPersonName.text=valleName
                         prototypeCells.labelEmailCallSMS.text=valleMobile
                         
                         
                     }
                     else if(IsEmailSMSCall == "Message")
                     {
                         labelChangeEmailCallSMS.text="Message"
                         let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Mobile")as! String
                         let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                         prototypeCells.buttonCall.isHidden=true
                         prototypeCells.buttonSMS.isHidden=false
                         prototypeCells.buttonEmail.isHidden=true
                         prototypeCells.buttonWhatsApp.isHidden=true
                         
                         
                         
                         prototypeCells.buttonCallMain.isHidden=true
                         prototypeCells.buttonSMSMain.isHidden=false
                         prototypeCells.buttonEmailMain.isHidden=true
                         
                         
                         prototypeCells.labelEmailCallSMSPersonName.text=valleName
                         prototypeCells.labelEmailCallSMS.text=valleMobile
                         
                         //check uncheck for sms
                         var getCheckUncheckStatus:String!=muarrayBACheckUncheckPopup.object(at: indexPath.row)as! String
                         if(getCheckUncheckStatus=="0")
                         {
                             prototypeCells.buttonSMS.setBackgroundImage(UIImage(named: "UncheckBlue"),  for: UIControl.State.normal)
                         }
                         else
                         {
                             prototypeCells.buttonSMS.setBackgroundImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                         }
                         
                         
                     }
                     else if(IsEmailSMSCall == "email")
                     {
                         labelChangeEmailCallSMS.text="Mail"
                         
                         let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Email")as! String
                         let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                         prototypeCells.buttonCall.isHidden=true
                         prototypeCells.buttonSMS.isHidden=true
                         prototypeCells.buttonEmail.isHidden=false
                         prototypeCells.buttonWhatsApp.isHidden=true
                         
                         
                         prototypeCells.buttonCallMain.isHidden=true
                         prototypeCells.buttonSMSMain.isHidden=true
                         prototypeCells.buttonEmailMain.isHidden=false
                         
                         
                         
                         
                         prototypeCells.labelEmailCallSMS.text=valleMobile
                         prototypeCells.labelEmailCallSMSPersonName.text=valleName
                         //check uncheck for email
                         var getCheckUncheckStatus:String!=muarrayBACheckUncheckPopup.object(at: indexPath.row)as! String
                         if(getCheckUncheckStatus=="0")
                         {
                             prototypeCells.buttonEmail.setBackgroundImage(UIImage(named: "UncheckBlue"),  for: UIControl.State.normal)
                         }
                         else
                         {
                             prototypeCells.buttonEmail.setBackgroundImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                         }
                         
                     }
                     
                     
                     prototypeCells.buttonWhatsApp.tag=indexPath.row
                 
                     
                     
                     prototypeCells.buttonWhatsApp.addTarget(self, action: #selector(CelebrationViewController.buttonWhatsAppPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                     
                     
                     prototypeCells.buttonCall.tag=indexPath.row
                     prototypeCells.buttonSMS.tag=indexPath.row
                     prototypeCells.buttonEmail.tag=indexPath.row
                     
                     
                     prototypeCells.buttonCall.addTarget(self, action: #selector(CelebrationViewController.buttonCallPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                     prototypeCells.buttonSMS.addTarget(self, action: #selector(CelebrationViewController.buttonSMSPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                     prototypeCells.buttonEmail.addTarget(self, action: #selector(CelebrationViewController.buttonEmailPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                     
                     
                     
                     prototypeCells.buttonCallMain.tag=indexPath.row
                     prototypeCells.buttonSMSMain.tag=indexPath.row
                     prototypeCells.buttonEmailMain.tag=indexPath.row
                     
                     
                     prototypeCells.buttonCallMain.addTarget(self, action: #selector(CelebrationViewController.buttonCallPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                     prototypeCells.buttonSMSMain.addTarget(self, action: #selector(CelebrationViewController.buttonSMSPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                     prototypeCells.buttonEmailMain.addTarget(self, action: #selector(CelebrationViewController.buttonEmailPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                 }
             }
             else   if(isBirthdayorAnniv=="anniv")
             {
                 if(muarrayHoldDataNew.count>0)
                 {
                     
                     labelChangeEmailCallSMS.text=IsEmailSMSCall
                     if(IsEmailSMSCall == "Call")
                     {
                         ////print("data value from server")
                         
                         
                         let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Mobile")as! String
                         let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                         prototypeCells.buttonCall.isHidden=false
                         prototypeCells.buttonSMS.isHidden=true
                         prototypeCells.buttonEmail.isHidden=true
                         
                         
                         prototypeCells.buttonCallMain.isHidden=false
                         prototypeCells.buttonSMSMain.isHidden=true
                         prototypeCells.buttonEmailMain.isHidden=true
                         
                         
                          prototypeCells.buttonWhatsApp.isHidden=true
                         prototypeCells.labelEmailCallSMSPersonName.text=valleName
                         prototypeCells.labelEmailCallSMS.text=valleMobile
                         
                         
                     }
                         
                         //whatsapp code by rajendra jat on 20 dec 2018 2.58pm
                     else  if(IsEmailSMSCall == "whatsapp")
                     {
                         //
                         ////print("algo 5")
                         ////print(muarrayBAPopup)
                         let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Mobile")as! String
                         let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                         prototypeCells.buttonCall.isHidden=true
                         prototypeCells.buttonSMS.isHidden=true
                         prototypeCells.buttonEmail.isHidden=true
                            prototypeCells.buttonWhatsApp.isHidden=false
                         
                         prototypeCells.buttonCallMain.isHidden=true
                         prototypeCells.buttonSMSMain.isHidden=true
                         prototypeCells.buttonEmailMain.isHidden=true
                         
                         
                         
                         prototypeCells.labelEmailCallSMSPersonName.text=valleName
                         prototypeCells.labelEmailCallSMS.text=valleMobile
                         
                         
                     }
                         
                         
                         
                         
                         
                         
                         
                     else if(IsEmailSMSCall == "Message")
                     {
                         let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Mobile")as! String
                         let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                         prototypeCells.buttonCall.isHidden=true
                         prototypeCells.buttonSMS.isHidden=false
                         prototypeCells.buttonEmail.isHidden=true
                         prototypeCells.buttonWhatsApp.isHidden=true

                         
                         
                         prototypeCells.buttonCallMain.isHidden=true
                         prototypeCells.buttonSMSMain.isHidden=false
                         prototypeCells.buttonEmailMain.isHidden=true
                         
                         
                         prototypeCells.labelEmailCallSMSPersonName.text=valleName
                         prototypeCells.labelEmailCallSMS.text=valleMobile
                         
                         //check uncheck for sms
                         var getCheckUncheckStatus:String!=muarrayBACheckUncheckPopup.object(at: indexPath.row)as! String
                         if(getCheckUncheckStatus=="0")
                         {
                             prototypeCells.buttonSMS.setBackgroundImage(UIImage(named: "UncheckBlue"),  for: UIControl.State.normal)
                         }
                         else
                         {
                             prototypeCells.buttonSMS.setBackgroundImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                         }
                         
                         
                     }
                     else if(IsEmailSMSCall == "email")
                     {
                         labelChangeEmailCallSMS.text="Mail"
                         let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Email")as! String
                         let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                         prototypeCells.buttonCall.isHidden=true
                         prototypeCells.buttonSMS.isHidden=true
                         prototypeCells.buttonEmail.isHidden=false
                          prototypeCells.buttonWhatsApp.isHidden=true
                         
                         prototypeCells.buttonCallMain.isHidden=true
                         prototypeCells.buttonSMSMain.isHidden=true
                         prototypeCells.buttonEmailMain.isHidden=false
                         
                         
                         
                         
                         prototypeCells.labelEmailCallSMS.text=valleMobile
                         prototypeCells.labelEmailCallSMSPersonName.text=valleName
                         //check uncheck for email
                         var getCheckUncheckStatus:String!=muarrayBACheckUncheckPopup.object(at: indexPath.row)as! String
                         if(getCheckUncheckStatus=="0")
                         {
                             prototypeCells.buttonEmail.setBackgroundImage(UIImage(named: "UncheckBlue"),  for: UIControl.State.normal)
                         }
                         else
                         {
                             prototypeCells.buttonEmail.setBackgroundImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                         }
                         
                     }
                     
                     
                     prototypeCells.buttonCall.tag=indexPath.row
                     prototypeCells.buttonSMS.tag=indexPath.row
                     prototypeCells.buttonEmail.tag=indexPath.row
                      prototypeCells.buttonWhatsApp.tag=indexPath.row
                     
                     
                     
                       prototypeCells.buttonWhatsApp.addTarget(self, action: #selector(CelebrationViewController.buttonWhatsAppPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                     
                     
                     prototypeCells.buttonCall.addTarget(self, action: #selector(CelebrationViewController.buttonCallPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                     prototypeCells.buttonSMS.addTarget(self, action: #selector(CelebrationViewController.buttonSMSPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                     prototypeCells.buttonEmail.addTarget(self, action: #selector(CelebrationViewController.buttonEmailPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                     
                     
                     
                     prototypeCells.buttonCallMain.tag=indexPath.row
                     prototypeCells.buttonSMSMain.tag=indexPath.row
                     prototypeCells.buttonEmailMain.tag=indexPath.row
                     
                     
                     prototypeCells.buttonCallMain.addTarget(self, action: #selector(CelebrationViewController.buttonCallPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                     prototypeCells.buttonSMSMain.addTarget(self, action: #selector(CelebrationViewController.buttonSMSPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                     prototypeCells.buttonEmailMain.addTarget(self, action: #selector(CelebrationViewController.buttonEmailPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                     
                 }
             }
             return prototypeCells
         }
         
         
         return prototypeCells
     }
     */
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if(tableView==self.tableviewEventAnnivBirthDay)
        {
            prototypeCells  = tableView.dequeueReusableCell(withIdentifier: reuseIdentifiers) as! CelebreationEventAnnivBirthdayTableViewCell
            tableBAERowHeight=prototypeCells.frame.height
            if(muarrayHoldDateWiseData.count>0)
            {
                prototypeCells.labelLine.isHidden=false
                 ////print("algo 2")
                if(indexPath.row==0)
                {
                    prototypeCells.labelLine.isHidden=true
                }
                prototypeCells.viewAlls.frame = CGRect(x: 5, y: 0, width: prototypeCells.viewAlls.frame.size.width, height: prototypeCells.viewAlls.frame.size.height)
                
                var getType:String!=(muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "type")as! String
                if(getType=="Birthday" || getType=="Anniversary")
                {
                    varForEventOPen = 0
                    if(getType=="Birthday")
                    {
                        prototypeCells.buttonImageBAE.setBackgroundImage(UIImage(named: "calEE"),  for: UIControl.State.normal)
                    }
                    else  if(getType=="Anniversary")
                    {
                        prototypeCells.buttonImageBAE.setBackgroundImage(UIImage(named: "ann"),  for: UIControl.State.normal)
                    }
                    prototypeCells.buttonCall.isHidden=false
                    prototypeCells.buttonSMS.isHidden=false
                    prototypeCells.buttonEmail.isHidden=false
                    prototypeCells.buttonWhatsApp.isHidden=false

                    prototypeCells.buttonEventNext.isHidden=true
                    prototypeCells.buttonEventNewEventss.isHidden=true
                    var varGetValueBAE:String!=(muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "typeCheck")as! String
                    
                    if(varGetValueBAE=="repeat")
                    {
                        prototypeCells.viewAlls.frame = CGRect(x: 5, y: -32, width: prototypeCells.viewAlls.frame.size.width, height: prototypeCells.viewAlls.frame.size.height)
                        tableBAERowHeight=tableBAERowHeight-32.0
                    }
                    let isValid = isValidEmail((muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "EmailId") as! String)
                    var muarrayTemp:NSMutableArray = (((muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "muarrayEmail")as AnyObject))as! NSMutableArray
                 if(muarrayTemp.count>0)
                    {
                        prototypeCells.buttonEmail.setImage(UIImage(named: "mail_blue"),  for: UIControl.State.normal)
                    }
                    else
                    {
                         prototypeCells.buttonEmail.setImage(UIImage(named: "sermail.png"),  for: UIControl.State.normal)
                    }
                }
                else if(getType=="Event")
                {
                    var varGetValueBAE:String!=(muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "typeCheck")as! String
                    prototypeCells.buttonImageBAE.setBackgroundImage(UIImage(named: "eventssss"),  for: UIControl.State.normal)
                    
                    self.varForEventOPen = 1
                    if(varGetValueBAE=="repeat")
                    {
                        prototypeCells.viewAlls.frame = CGRect(x: 5, y: -32, width: prototypeCells.viewAlls.frame.size.width, height: prototypeCells.viewAlls.frame.size.height)
                        
                    }
                    prototypeCells.buttonWhatsApp.isHidden=true
                    prototypeCells.buttonCall.isHidden=true
                    prototypeCells.buttonSMS.isHidden=true
                    prototypeCells.buttonEmail.isHidden=true
                    prototypeCells.buttonEventNext.isHidden=false
                    prototypeCells.buttonEventNewEventss.isHidden=false
                    prototypeCells.buttonEventNext.addTarget(self, action: #selector(buttonCalendarViewEventClickEvent(_:)), for: UIControl.Event.touchUpInside)
                    prototypeCells.buttonEventNext.tag=indexPath.row
                }
                prototypeCells.buttonWhatsApp.addTarget(self, action: #selector(buttonCalendarViewWhatsAppClickEvent(_:)), for: UIControl.Event.touchUpInside)
                prototypeCells.buttonWhatsApp.tag=indexPath.row
                
                
                
                prototypeCells.buttonCall.addTarget(self, action: #selector(buttonCalendarViewCallClickEvent(_:)), for: UIControl.Event.touchUpInside)
                prototypeCells.buttonCall.tag=indexPath.row
                
                
                
                
                prototypeCells.buttonSMS.addTarget(self, action: #selector(buttonCalendarViewSMSClickEvent(_:)), for: UIControl.Event.touchUpInside)
                prototypeCells.buttonSMS.tag=indexPath.row
                
                
                
                
                prototypeCells.buttonEmail.addTarget(self, action: #selector(buttonCalendarViewEmailClickEvent(_:)), for: UIControl.Event.touchUpInside)
                prototypeCells.buttonEmail.tag=indexPath.row

                prototypeCells.labelTitle.text=(muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "title")as! String
                
                let titleText:String=(muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "title")as! String
                
                if titleText.count<=35
                {
                      prototypeCells.labelTitle.frame=CGRect(x: prototypeCells.labelTitle.frame.origin.x, y: prototypeCells.labelTitle.frame.origin.y, width: prototypeCells.labelTitle.frame.width, height: 37.0)
                    tableBAERowHeight=tableBAERowHeight-30.0
                }
                else if titleText.count > 35 && titleText.count <= 45
                {
                    prototypeCells.labelTitle.frame=CGRect(x: prototypeCells.labelTitle.frame.origin.x, y: prototypeCells.labelTitle.frame.origin.y, width: prototypeCells.labelTitle.frame.width, height: 45.0)
                    tableBAERowHeight=tableBAERowHeight-20.0
                }
                else
                {
                    prototypeCells.labelTitle.frame=CGRect(x: prototypeCells.labelTitle.frame.origin.x, y: prototypeCells.labelTitle.frame.origin.y, width: prototypeCells.labelTitle.frame.width, height: 57.0)
                    
                }
                
                
                // prototypeCells.labelDate.text = objCalendarInfo.stringDateMonth
                let lblTypeBAE = (muarrayHoldDateWiseData.object(at: indexPath.row) as AnyObject).value(forKey: "typeCheck")as! String
                
                if(lblTypeBAE=="Birthday")
                {
                    prototypeCells.labelType.text = "Birthdays"
                }
                if(lblTypeBAE=="Anniversary")
                {
                    prototypeCells.labelType.text = "Anniversaries"
                    //Anniversaries
                }
                if(lblTypeBAE=="Event")
                {
                    prototypeCells.labelType.text = "Events"
                }
                ////print("2222222222222222222222222222",lblTypeBAE)
                //prototypeCells.labelType.text = lblTypeBAE+"'s"
                // prototypeCells.lableTime.text=objCalendarInfo.stringTime
                
                prototypeCells.buttonMainClickEvent.addTarget(self, action: #selector(CelebrationViewController.buttonMainEventBirthAnnivClickEvent(_:)), for: UIControl.Event.touchUpInside)
                prototypeCells.buttonMainClickEvent.tag=indexPath.row
            }
        }
            //muarrayHoldDateWiseData
            
            
            
        else if(tableView==self.tableviewBirthday)
        {
            let prototypeCell : NewCalendarTableViewCell! = tableviewBirthday.dequeueReusableCell(withIdentifier: "tableCell") as! NewCalendarTableViewCell
            tableBirthdayRowHeight=prototypeCell.frame.height
            
            if(muarrayHoldData.count>0)
            {
                // prototypeCell.configureCellServicesProviderList(arrayResponse.objectAtIndex(indexPath.row) as! NSDictionary)
                prototypeCell.configureCellServicesProviderList((arrayResponse.object(at: indexPath.row) as! NSDictionary), indexpath: indexPath.row)
                
                prototypeCell.labelDate.isHidden=false
                prototypeCell.labelPersonName.isHidden=false
                // ////print((muarrayHoldData.objectAtIndex(indexPath.row)as! NSDictionary))
                ////print((muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "eventDate")as? String)
                
                prototypeCell.labelDate.numberOfLines=3
                prototypeCell.labelDate.attributedText=(muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "eventDate")as? NSAttributedString
                prototypeCell.labelPersonName.text=(muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String
                let titleText:String=((muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String)!
                if titleText.count<=35
                {
                    prototypeCell.labelPersonName.frame=CGRect(x: prototypeCell.labelPersonName.frame.origin.x, y: prototypeCell.labelPersonName.frame.origin.y, width: prototypeCell.labelPersonName.frame.width, height: 37.0)
                    tableBirthdayRowHeight=tableBirthdayRowHeight-30.0
                }
                else if titleText.count > 35 && titleText.count <= 45
                {
                    prototypeCell.labelPersonName.frame=CGRect(x: prototypeCell.labelPersonName.frame.origin.x, y: prototypeCell.labelPersonName.frame.origin.y, width: prototypeCell.labelPersonName.frame.width, height: 45.0)
                    tableBirthdayRowHeight=tableBirthdayRowHeight-20.0
                }

                
                
                varGetEventDate=(muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "compareDate")as! String
                //print("Compare date for Birthday at index Path ::  \(indexPath.row): : : \(varGetEventDate!)")
                if(varGetEventDate!=="repeating")
                {
                    prototypeCell.labelDate.isHidden=true
                    prototypeCell.viewAll.frame = CGRect(x: 0, y: -50, width: prototypeCell.viewAll.frame.size.width, height: prototypeCell.viewAll.frame.size.height)
                     tableBirthdayRowHeight=tableBirthdayRowHeight-50.0
                }
                else
                {
                    prototypeCell.labelDate.isHidden=false
                    tableBirthdayRowHeight=tableBirthdayRowHeight+50.0
                    prototypeCell.viewAll.frame = CGRect(x: 0, y: 0, width: prototypeCell.viewAll.frame.size.width, height: prototypeCell.viewAll.frame.size.height)
                   
                    if(indexPath.row==0)
                    {
                        //here condition is that for Todays Birthday
                        let getTodatDate = commonClassFunction().functionForGetTodatDate()
                        let varGetEventDateRepeat:String!=(muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "compareDate")as? String
                        
                    }
                    else
                    {
                        
                    }
                }
                
                prototypeCell.buttonWhatsApp.addTarget(self, action: #selector(buttonWhatsApp2ClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                prototypeCell.buttonWhatsApp.tag=indexPath.row;
                //1.
                prototypeCell.buttonCall.addTarget(self, action: #selector(buttonCallClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                prototypeCell.buttonCall.tag=indexPath.row;
                //2.
                prototypeCell.buttonSMS.addTarget(self, action: #selector(buttonSMSClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                prototypeCell.buttonSMS.tag=indexPath.row;
                //3.
                prototypeCell.buttoEmail.addTarget(self, action: #selector(buttonEmailClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                prototypeCell.buttoEmail.tag=indexPath.row;
                
                /*here need to check email if not available then disable that button*/
                //EmailId
                let getUserEmailId:String!=(muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "EmailId")as? String
                if(getUserEmailId.characters.count>3)
                {
                    ////print("This is if in cell for row")
                }
                else
                {
                    ////print("This is else in cell for row")
                    muarrayBAPopup=(muarrayHoldData.object(at: indexPath.row) as AnyObject).value(forKey: "arrayEmail")! as! NSMutableArray
                    ////print(muarrayBAPopup)
                    if(muarrayBAPopup.count>0)
                    {
                        
                        prototypeCell.buttoEmail.setBackgroundImage(UIImage(named: "mail_blue"),  for: UIControl.State.normal)
                        
                        
                        prototypeCell.buttoEmail.isEnabled=true
                    }
                    else
                    {
                        prototypeCell.buttoEmail.setBackgroundImage(UIImage(named: "sermail.png"),  for: UIControl.State.normal)
                        prototypeCell.buttoEmail.isEnabled=true
                        
                        //  prototypeCell.buttoEmail.enabled=false
                        
                        
                        
                    }
                }
            }
            return prototypeCell as NewCalendarTableViewCell
        }
            
            
            ///////////////////-----------------------------
        else if(tableView==self.tableviewAnnivNew)
        {
            let prototypeCell : NewCalendarTableViewCell! = tableviewBirthday.dequeueReusableCell(withIdentifier: "tableCell") as! NewCalendarTableViewCell
            tableAnniversaryTabRowHeight=prototypeCell.frame.height
            if(muarrayHoldDataNew.count>0)
            {
                // prototypeCell.configureCellServicesProviderList(arrayResponse.objectAtIndex(indexPath.row) as! NSDictionary)
                prototypeCell.configureCellServicesProviderList((arrayResponseNew.object(at: indexPath.row) as! NSDictionary), indexpath: indexPath.row)
                
                prototypeCell.labelDate.isHidden=false
                prototypeCell.labelPersonName.isHidden=false
                // ////print((muarrayHoldData.objectAtIndex(indexPath.row)as! NSDictionary))
                prototypeCell.labelDate.attributedText=(muarrayHoldDataNew.object(at: indexPath.row)as! NSDictionary).object(forKey: "eventDate")as? NSAttributedString
                prototypeCell.labelPersonName.text=(muarrayHoldDataNew.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String
                let titleText:String=((muarrayHoldDataNew.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String)!
                if titleText.count<=35
                {
                    prototypeCell.labelPersonName.frame=CGRect(x: prototypeCell.labelPersonName.frame.origin.x, y: prototypeCell.labelPersonName.frame.origin.y, width: prototypeCell.labelPersonName.frame.width, height: 37.0)
                    tableAnniversaryTabRowHeight=tableAnniversaryTabRowHeight-30.0
                }
                else if titleText.count > 35 && titleText.count <= 45
                {
                    prototypeCell.labelPersonName.frame=CGRect(x: prototypeCell.labelPersonName.frame.origin.x, y: prototypeCell.labelPersonName.frame.origin.y, width: prototypeCell.labelPersonName.frame.width, height: 45.0)
                    tableAnniversaryTabRowHeight=tableAnniversaryTabRowHeight-20.0
                }

                
                varGetEventDate=(muarrayHoldDataNew.object(at: indexPath.row)as! NSDictionary).object(forKey: "compareDate")as! String
                if(varGetEventDate=="repeating")
                {
                    prototypeCell.labelDate.isHidden=true
                    prototypeCell.viewAll.frame = CGRect(x: 0, y: -42, width: prototypeCell.viewAll.frame.size.width, height: prototypeCell.viewAll.frame.size.height)
                   
                    tableAnniversaryTabRowHeight=tableAnniversaryTabRowHeight-42
                }
                else
                {
                    prototypeCell.labelDate.isHidden=false
                    tableAnniversaryTabRowHeight=tableAnniversaryTabRowHeight+42
                    prototypeCell.viewAll.frame = CGRect(x: 0, y: 0, width: prototypeCell.viewAll.frame.size.width, height: prototypeCell.viewAll.frame.size.height)
                   
                    if(indexPath.row==0)
                    {
                        //here condition is that for Todays Birthday
                        let getTodatDate = commonClassFunction().functionForGetTodatDate()
                        let varGetEventDateRepeat:String!=(muarrayHoldDataNew.object(at: indexPath.row)as! NSDictionary).object(forKey: "compareDate")as! String
                        
                    }
                    else
                    {
                        
                    }
                }
                
                
                
                prototypeCell.buttonWhatsApp.addTarget(self, action: #selector(CelebrationViewController.buttonWhastapp3ClickedEventAni(_:)), for: UIControl.Event.touchUpInside)
                prototypeCell.buttonWhatsApp.tag=indexPath.row;
                
                
                
                
                //1.
                prototypeCell.buttonCall.addTarget(self, action: #selector(CelebrationViewController.buttonCallClickedEventAni(_:)), for: UIControl.Event.touchUpInside)
                prototypeCell.buttonCall.tag=indexPath.row;
                //2.
                prototypeCell.buttonSMS.addTarget(self, action: #selector(CelebrationViewController.buttonSMSClickedEventAni(_:)), for: UIControl.Event.touchUpInside)
                prototypeCell.buttonSMS.tag=indexPath.row;
                //3.
                prototypeCell.buttoEmail.addTarget(self, action: #selector(CelebrationViewController.buttonEmailClickedEventAni(_:)), for: UIControl.Event.touchUpInside)
                prototypeCell.buttoEmail.tag=indexPath.row;
                
                /*here need to check email if not available then disable that button*/
                //EmailId
                let getUserEmailId:String!=(muarrayHoldDataNew.object(at: indexPath.row)as! NSDictionary).object(forKey: "EmailId")as? String
                if(getUserEmailId.characters.count>3)
                {
                    ////print("This is if in cell for row")
                }
                else
                {
                    ////print("This is else in cell for row")
                    muarrayBAPopupNew=(muarrayHoldDataNew.object(at: indexPath.row) as AnyObject).value(forKey: "arrayEmail")! as! NSMutableArray
                    ////print(muarrayBAPopupNew)
                    if(muarrayBAPopupNew.count>0)
                    {
                        
                        prototypeCell.buttoEmail.setBackgroundImage(UIImage(named: "mail_blue"),  for: UIControl.State.normal)
                        
                        
                        prototypeCell.buttoEmail.isEnabled=true
                    }
                    else
                    {
                        prototypeCell.buttoEmail.setBackgroundImage(UIImage(named: "sermail.png"),  for: UIControl.State.normal)
                        // prototypeCell.buttoEmail.enabled=false
                        prototypeCell.buttoEmail.isEnabled=true
                        
                        
                    }
                }
            }
            return prototypeCell as NewCalendarTableViewCell
        }
            
            /////////////////////////
        else if(tableView==self.tableviewEventEventEvent)
        {
            let prototypeCell : NewCalendarTableViewCell! = tableviewBirthday.dequeueReusableCell(withIdentifier: "tableCell") as! NewCalendarTableViewCell
            prototypeCell.datLbl.isHidden = true
            tableEventTabRowHeight=prototypeCell.frame.height
            if(muarrayHoldDataNewEvent.count>0)
            {
                prototypeCell.buttonEventTapClickEvent.isHidden=false
                prototypeCell.buttonEventArrows.isHidden=false
                
                
                
                // prototypeCell.configureCellServicesProviderList(arrayResponse.objectAtIndex(indexPath.row) as! NSDictionary)
                prototypeCell.configureCellServicesProviderList((arrayResponseNewEvent.object(at: indexPath.row) as! NSDictionary), indexpath: indexPath.row)
                prototypeCell.buttonWhatsApp.isHidden=true
                
                prototypeCell.buttonCall.isHidden=true
                prototypeCell.buttonSMS.isHidden=true
                prototypeCell.buttoEmail.isHidden=true
                // prototypeCell.buttonEventEvent.hidden=false
                
                prototypeCell.buttoEmail.setBackgroundImage(UIImage(named: "calendar"), for: UIControl.State.normal)
                //buttonEventTapClickEvent
                prototypeCell.labelDate.isHidden=false
                prototypeCell.labelPersonName.isHidden=false
                // //print((muarrayHoldData.objectAtIndex(indexPath.row)as! NSDictionary))
                prototypeCell.labelDate.attributedText=(muarrayHoldDataNewEvent.object(at: indexPath.row)as! NSDictionary).object(forKey: "eventDate")as? NSAttributedString
                print("prototypeCell.labelDate--\(prototypeCell.labelDate)")
                print("labelDateIndex--\(indexPath.row)")
                prototypeCell.labelPersonName.text=(muarrayHoldDataNewEvent.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String
                
                let titleText:String=((muarrayHoldDataNewEvent.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String)!
                if titleText.count<=35
                {
                    prototypeCell.labelPersonName.frame=CGRect(x: prototypeCell.labelPersonName.frame.origin.x, y: prototypeCell.labelPersonName.frame.origin.y, width: prototypeCell.labelPersonName.frame.width, height: 37.0)
                    tableEventTabRowHeight=tableEventTabRowHeight-30.0
                }
                else if titleText.count > 35 && titleText.count <= 45
                {
                    prototypeCell.labelPersonName.frame=CGRect(x: prototypeCell.labelPersonName.frame.origin.x, y: prototypeCell.labelPersonName.frame.origin.y, width: prototypeCell.labelPersonName.frame.width, height: 45.0)
                    tableEventTabRowHeight=tableEventTabRowHeight-20.0
                }

                
                varGetEventDate=(muarrayHoldDataNewEvent.object(at: indexPath.row)as! NSDictionary).object(forKey: "compareDate")as! String
                print("varGetEventDate--\(varGetEventDate)")
                
                if(varGetEventDate=="Upcoming Events") {
                    prototypeCell.datLbl.isHidden = false
                    let upcomingDate = (muarrayHoldDataNewEvent.object(at: indexPath.row)as! NSDictionary).object(forKey: "eventDate")as? NSAttributedString
                    let eventDetails = upcomingDate?.string
                    
                    print("upcomingDate----\(upcomingDate)")
                    print("eventDetails----\(eventDetails)")
                    
                    let apiResponse: NSDictionary = ["eventDate": NSAttributedString(string: eventDetails ?? "")]
                           if let attributedEventDate = apiResponse.object(forKey: "eventDate") as? NSAttributedString {
                               let eventDeta = attributedEventDate.string
                               let trimmedEventDetails = eventDeta.trimmingCharacters(in: .whitespacesAndNewlines)
                               let components = trimmedEventDetails.components(separatedBy: "\n").filter { !$0.isEmpty }
                               if components.count == 2 {
                                   let eventTitle = components[0]
                                   let eventDate = components[1]
                                   prototypeCell.datLbl.text = eventDate
                               }
                           }
                    print("eventDetailsCHECK----\(prototypeCell.labelDate.text)")
                }
                
                if(varGetEventDate=="repeating")
                {
                    prototypeCell.labelDate.isHidden=true
                    prototypeCell.viewAll.frame = CGRect(x: 0, y: -45, width: prototypeCell.viewAll.frame.size.width, height: prototypeCell.viewAll.frame.size.height)
                   
                    tableEventTabRowHeight=tableEventTabRowHeight-42.0
                }
                else
                {
                    prototypeCell.labelDate.isHidden=false
                     tableEventTabRowHeight=tableEventTabRowHeight+42.0
                    prototypeCell.viewAll.frame = CGRect(x: 0, y: 0, width: prototypeCell.viewAll.frame.size.width, height: prototypeCell.viewAll.frame.size.height)
                   
                    
                    if(indexPath.row==0)
                    {
                        //here condition is that for Todays Birthday
                        let getTodatDate = commonClassFunction().functionForGetTodatDate()
                        let varGetEventDateRepeat:String!=(muarrayHoldDataNewEvent.object(at: indexPath.row)as! NSDictionary).object(forKey: "compareDate")as? String
                    }
                    else
                    {
                       
                    }
                }
                //1.
                prototypeCell.buttonEventTapClickEvent.addTarget(self, action: #selector(CelebrationViewController.functionForGoToEventDetailFromEventScreen(_:)), for: UIControl.Event.touchUpInside)
                prototypeCell.buttonEventTapClickEvent.tag=indexPath.row;
                
            }
            return prototypeCell as NewCalendarTableViewCell
        }
            //////////////////------------------------------
            
            
            
            
            
        else  if(tableView==self.tableviewBirthAnniv)
        {
            let prototypeCells : BirthAnnivPopupTableViewCell! = tableviewBirthAnniv.dequeueReusableCell(withIdentifier: "Cell") as! BirthAnnivPopupTableViewCell

            if(isBirthdayorAnniv=="birthday")
            {
                    labelChangeEmailCallSMS.text=IsEmailSMSCall
                    if(IsEmailSMSCall == "Call")
                    {
                        //
                        ////print("algo 5")
                        ////print(muarrayBAPopup)
                        let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Mobile")as! String
                        let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                        prototypeCells.buttonCall.isHidden=false
                        prototypeCells.buttonSMS.isHidden=true
                        prototypeCells.buttonEmail.isHidden=true
                        
                        
                        prototypeCells.buttonCallMain.isHidden=false
                        prototypeCells.buttonSMSMain.isHidden=true
                        prototypeCells.buttonEmailMain.isHidden=true
                        prototypeCells.buttonWhatsApp.isHidden=true
                        
                        
                        
                        prototypeCells.labelEmailCallSMSPersonName.text=valleName
                        prototypeCells.labelEmailCallSMS.text=valleMobile
                        
                        
                    }
                        
                        //whatsapp code by rajendra jat on 20 dec 2018 2.58pm
                  else  if(IsEmailSMSCall == "whatsapp")
                    {
                        //
                        ////print("algo 5")
                        ////print(muarrayBAPopup)
                        let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Mobile")as! String
                        let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                        prototypeCells.buttonCall.isHidden=true
                        prototypeCells.buttonSMS.isHidden=true
                        prototypeCells.buttonEmail.isHidden=true
                        prototypeCells.buttonWhatsApp.isHidden=false
                        prototypeCells.buttonCallMain.isHidden=true
                        prototypeCells.buttonSMSMain.isHidden=true
                        prototypeCells.buttonEmailMain.isHidden=true
                        prototypeCells.labelEmailCallSMSPersonName.text=valleName
                        prototypeCells.labelEmailCallSMS.text=valleMobile
                    }
                    else if(IsEmailSMSCall == "Message")
                    {
                        labelChangeEmailCallSMS.text="Message"
                        let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Mobile")as! String
                        let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                        prototypeCells.buttonCall.isHidden=true
                        prototypeCells.buttonSMS.isHidden=false
                        prototypeCells.buttonEmail.isHidden=true
                        prototypeCells.buttonWhatsApp.isHidden=true
                        prototypeCells.buttonCallMain.isHidden=true
                        prototypeCells.buttonSMSMain.isHidden=false
                        prototypeCells.buttonEmailMain.isHidden=true
                        prototypeCells.labelEmailCallSMSPersonName.text=valleName
                        prototypeCells.labelEmailCallSMS.text=valleMobile
                        
                        //check uncheck for sms
                        var getCheckUncheckStatus:String!=muarrayBACheckUncheckPopup.object(at: indexPath.row)as! String
                        if(getCheckUncheckStatus=="0")
                        {
                            prototypeCells.buttonSMS.setBackgroundImage(UIImage(named: "UncheckBlue"),  for: UIControl.State.normal)
                        }
                        else
                        {
                            prototypeCells.buttonSMS.setBackgroundImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                        }
                        
                        
                    }
                    else if(IsEmailSMSCall == "email")
                    {
                        labelChangeEmailCallSMS.text="Mail"
                        
                        let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Email")as! String
                        let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                        prototypeCells.buttonCall.isHidden=true
                        prototypeCells.buttonSMS.isHidden=true
                        prototypeCells.buttonEmail.isHidden=false
                        prototypeCells.buttonWhatsApp.isHidden=true
                        
                        
                        prototypeCells.buttonCallMain.isHidden=true
                        prototypeCells.buttonSMSMain.isHidden=true
                        prototypeCells.buttonEmailMain.isHidden=false
                        
                        
                        
                        
                        prototypeCells.labelEmailCallSMS.text=valleMobile
                        prototypeCells.labelEmailCallSMSPersonName.text=valleName
                        //check uncheck for email
                        var getCheckUncheckStatus:String!=muarrayBACheckUncheckPopup.object(at: indexPath.row)as! String
                        if(getCheckUncheckStatus=="0")
                        {
                            prototypeCells.buttonEmail.setBackgroundImage(UIImage(named: "UncheckBlue"),  for: UIControl.State.normal)
                        }
                        else
                        {
                            prototypeCells.buttonEmail.setBackgroundImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                        }
                        
                    }
                    
                    
                    prototypeCells.buttonWhatsApp.tag=indexPath.row
                
                    
                    
                    prototypeCells.buttonWhatsApp.addTarget(self, action: #selector(CelebrationViewController.buttonWhatsAppPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    
                    
                    prototypeCells.buttonCall.tag=indexPath.row
                    prototypeCells.buttonSMS.tag=indexPath.row
                    prototypeCells.buttonEmail.tag=indexPath.row
                    
                    
                    prototypeCells.buttonCall.addTarget(self, action: #selector(CelebrationViewController.buttonCallPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    prototypeCells.buttonSMS.addTarget(self, action: #selector(CelebrationViewController.buttonSMSPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    prototypeCells.buttonEmail.addTarget(self, action: #selector(CelebrationViewController.buttonEmailPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    
                    
                    
                    prototypeCells.buttonCallMain.tag=indexPath.row
                    prototypeCells.buttonSMSMain.tag=indexPath.row
                    prototypeCells.buttonEmailMain.tag=indexPath.row
                    
                    
                    prototypeCells.buttonCallMain.addTarget(self, action: #selector(CelebrationViewController.buttonCallPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    prototypeCells.buttonSMSMain.addTarget(self, action: #selector(CelebrationViewController.buttonSMSPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    prototypeCells.buttonEmailMain.addTarget(self, action: #selector(CelebrationViewController.buttonEmailPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
            }
            else   if(isBirthdayorAnniv=="anniv")
            {
                    labelChangeEmailCallSMS.text=IsEmailSMSCall
                    if(IsEmailSMSCall == "Call")
                    {
                        ////print("data value from server")
                        
                        
                        let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Mobile")as! String
                        let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                        prototypeCells.buttonCall.isHidden=false
                        prototypeCells.buttonSMS.isHidden=true
                        prototypeCells.buttonEmail.isHidden=true
                        
                        
                        prototypeCells.buttonCallMain.isHidden=false
                        prototypeCells.buttonSMSMain.isHidden=true
                        prototypeCells.buttonEmailMain.isHidden=true
                        
                        
                         prototypeCells.buttonWhatsApp.isHidden=true
                        prototypeCells.labelEmailCallSMSPersonName.text=valleName
                        prototypeCells.labelEmailCallSMS.text=valleMobile
                        
                        
                    }
                        
                        //whatsapp code by rajendra jat on 20 dec 2018 2.58pm
                    else  if(IsEmailSMSCall == "whatsapp")
                    {
                        let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Mobile")as! String
                        let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                        prototypeCells.buttonCall.isHidden=true
                        prototypeCells.buttonSMS.isHidden=true
                        prototypeCells.buttonEmail.isHidden=true
                        prototypeCells.buttonWhatsApp.isHidden=false
                        prototypeCells.buttonCallMain.isHidden=true
                        prototypeCells.buttonSMSMain.isHidden=true
                        prototypeCells.buttonEmailMain.isHidden=true
                        prototypeCells.labelEmailCallSMSPersonName.text=valleName
                        prototypeCells.labelEmailCallSMS.text=valleMobile
                    }

                    else if(IsEmailSMSCall == "Message")
                    {
                        let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Mobile")as! String
                        let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                        prototypeCells.buttonCall.isHidden=true
                        prototypeCells.buttonSMS.isHidden=false
                        prototypeCells.buttonEmail.isHidden=true
                        prototypeCells.buttonWhatsApp.isHidden=true

                        
                        
                        prototypeCells.buttonCallMain.isHidden=true
                        prototypeCells.buttonSMSMain.isHidden=false
                        prototypeCells.buttonEmailMain.isHidden=true
                        
                        
                        prototypeCells.labelEmailCallSMSPersonName.text=valleName
                        prototypeCells.labelEmailCallSMS.text=valleMobile
                        
                        //check uncheck for sms
                        var getCheckUncheckStatus:String!=muarrayBACheckUncheckPopup.object(at: indexPath.row)as! String
                        if(getCheckUncheckStatus=="0")
                        {
                            prototypeCells.buttonSMS.setBackgroundImage(UIImage(named: "UncheckBlue"),  for: UIControl.State.normal)
                        }
                        else
                        {
                            prototypeCells.buttonSMS.setBackgroundImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                        }
                        
                        
                    }
                    else if(IsEmailSMSCall == "email")
                    {
                        labelChangeEmailCallSMS.text="Mail"
                        let valleMobile = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Email")as! String
                        let valleName = (muarrayBAPopup.object(at: indexPath.row) as AnyObject).value(forKey: "Name")as! String
                        prototypeCells.buttonCall.isHidden=true
                        prototypeCells.buttonSMS.isHidden=true
                        prototypeCells.buttonEmail.isHidden=false
                         prototypeCells.buttonWhatsApp.isHidden=true
                        
                        prototypeCells.buttonCallMain.isHidden=true
                        prototypeCells.buttonSMSMain.isHidden=true
                        prototypeCells.buttonEmailMain.isHidden=false
                        
                        
                        
                        
                        prototypeCells.labelEmailCallSMS.text=valleMobile
                        prototypeCells.labelEmailCallSMSPersonName.text=valleName
                        //check uncheck for email
                        var getCheckUncheckStatus:String!=muarrayBACheckUncheckPopup.object(at: indexPath.row)as! String
                        if(getCheckUncheckStatus=="0")
                        {
                            prototypeCells.buttonEmail.setBackgroundImage(UIImage(named: "UncheckBlue"),  for: UIControl.State.normal)
                        }
                        else
                        {
                            prototypeCells.buttonEmail.setBackgroundImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                        }
                        
                    }
                    
                    
                    prototypeCells.buttonCall.tag=indexPath.row
                    prototypeCells.buttonSMS.tag=indexPath.row
                    prototypeCells.buttonEmail.tag=indexPath.row
                     prototypeCells.buttonWhatsApp.tag=indexPath.row
                    
                    
                    
                      prototypeCells.buttonWhatsApp.addTarget(self, action: #selector(CelebrationViewController.buttonWhatsAppPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    
                    
                    prototypeCells.buttonCall.addTarget(self, action: #selector(CelebrationViewController.buttonCallPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    prototypeCells.buttonSMS.addTarget(self, action: #selector(CelebrationViewController.buttonSMSPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    prototypeCells.buttonEmail.addTarget(self, action: #selector(CelebrationViewController.buttonEmailPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    
                    
                    
                    prototypeCells.buttonCallMain.tag=indexPath.row
                    prototypeCells.buttonSMSMain.tag=indexPath.row
                    prototypeCells.buttonEmailMain.tag=indexPath.row
                    
                    
                    prototypeCells.buttonCallMain.addTarget(self, action: #selector(CelebrationViewController.buttonCallPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    prototypeCells.buttonSMSMain.addTarget(self, action: #selector(CelebrationViewController.buttonSMSPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    prototypeCells.buttonEmailMain.addTarget(self, action: #selector(CelebrationViewController.buttonEmailPopupClickedEvent(_:)), for: UIControl.Event.touchUpInside)
            }
            return prototypeCells
        }
        
        
        return prototypeCells
    }
    
    
    
    
    
    
    
    //buttonEventClickedEventAni
    
    func buttonEventClickedEventAni(_ sender:UIButton)
    {
        ////print(sender.tag)
        UserDefaults.standard.set("no", forKey: "picadded")
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
        profVC.grpID = stringGroupID!
        profVC.profileId =  objCalendarInfo.stringTypeID
        profVC.NormalMemberOrAdmin = "comingfromcelebreationscreen"
        profVC.isCategory=self.isCategory
        
        //profVC.isAdmin = isAdmin
        //profVC.mainUSerPRofileID = stringProfileId
        //profVC.isCalled = "comingfromcelebreationscreen"
        self.navigationController?.pushViewController(profVC, animated: true)
    }
    
  @objc   func buttonWhatsAppPopupClickedEvent(_ sender:UIButton)
    {
        //DPK
        var ContactNumber:String!=""
        if(isBirthdayorAnniv=="anniv")
        {
            ContactNumber=(muarrayBAPopup.object(at: sender.tag) as AnyObject).value(forKey: "Mobile")as! String
        }
        else
        {
            ContactNumber=(muarrayBAPopup.object(at: sender.tag) as AnyObject).value(forKey: "Mobile")as! String
        }
        let string = ContactNumber.replacingOccurrences(of: "+", with: "")
        let newString = string.replacingOccurrences(of: " ", with: "")
        if(newString.characters.count>7)
        {
            var varGetValue=newString
            let urlWhats = "https://wa.me/\(varGetValue)"
            //let urlWhats = "https://api.whatsapp.com/send?phone=\(varGetValue)"
            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
               if let whatsappURL = URL(string: urlString) {
                    if UIApplication.shared.canOpenURL(whatsappURL) {
                        
                        print("Opening whatsapp url \(whatsappURL)")
//                        UIApplication.shared.openURL(whatsappURL)
                        UIApplication.shared.open(whatsappURL, options: [:]) { success in
                             if success {
                                 print("The URL was successfully opened.")
                             } else {
                                 print("Failed to open the URL.")
                             }
                         }
                    } else {
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Rotary India"
                        alertView.message = "WhatsApp is not installed"
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                    }
                }
            }
        }
    }

@objc   func buttonWhatsAppPopupClickedEventBaackup(_ sender:UIButton)
    {
        var ContactNumber:String!=""
        if(isBirthdayorAnniv=="anniv")
        {
            ContactNumber=(muarrayBAPopup.object(at: sender.tag) as AnyObject).value(forKey: "Mobile")as! String
        }
        else
        {
            ContactNumber=(muarrayBAPopup.object(at: sender.tag) as AnyObject).value(forKey: "Mobile")as! String
        }

        let string = ContactNumber.replacingOccurrences(of: "+", with: "")
        let newString = string.replacingOccurrences(of: " ", with: "")

        if(newString.characters.count>7)
        {
            var varGetValue=newString.components(separatedBy: " ")
            let urlWhats = "whatsapp://send?phone='\(varGetValue)'"
            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                if let whatsappURL = URL(string: urlString) {
                    if UIApplication.shared.canOpenURL(whatsappURL) {
//                        UIApplication.shared.openURL(whatsappURL)
                        UIApplication.shared.open(whatsappURL, options: [:]) { success in
                             if success {
                                 print("The URL was successfully opened.")
                             } else {
                                 print("Failed to open the URL.")
                             }
                         }
                    } else {
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Rotary India"
                        alertView.message = "WhatsApp is not installed"
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                    }
                }
            }
        }
        
        
        
        
    }
    
  
    
 @objc   func buttonCallPopupClickedEvent(_ sender:UIButton)
    {
        //DPK
        var ContactNumber:String!=""
        if(isBirthdayorAnniv=="anniv")
        {
            ContactNumber=(muarrayBAPopup.object(at: sender.tag) as AnyObject).value(forKey: "Mobile")as! String
            
        }
        else
        {
            ContactNumber=(muarrayBAPopup.object(at: sender.tag) as AnyObject).value(forKey: "Mobile")as! String
        }
        let newString = ContactNumber.replacingOccurrences(of: " ", with: "")
        if(newString.characters.count>7)
        {
            if let url = URL(string: "tel://\(newString)"), UIApplication.shared.canOpenURL(url)
            {
//                UIApplication.shared.openURL(url)
                UIApplication.shared.open(url, options: [:]) { success in
                     if success {
                         print("The URL was successfully opened.")
                     } else {
                         print("Failed to open the URL.")
                     }
                 }
            }
        }
    }
 @objc   func buttonSMSPopupClickedEvent(_ sender:UIButton)
    {
        let varGetValue:String!=muarrayBACheckUncheckPopup.object(at: sender.tag)as! String
        if(varGetValue=="0")
        {
            muarrayBACheckUncheckPopup.replaceObject(at: sender.tag, with: "1")
        }
        else   if(varGetValue=="1")
        {
            muarrayBACheckUncheckPopup.replaceObject(at: sender.tag, with: "0")
        }
        tableviewBirthAnniv.reloadData()
    }
    
   @objc func buttonEmailPopupClickedEvent(_ sender:UIButton)
    {
        let varGetValue:String!=muarrayBACheckUncheckPopup.object(at: sender.tag)as! String
        if(varGetValue=="0")
        {
            muarrayBACheckUncheckPopup.replaceObject(at: sender.tag, with: "1")
        }
        else   if(varGetValue=="1")
        {
            muarrayBACheckUncheckPopup.replaceObject(at: sender.tag, with: "0")
        }
        DispatchQueue.main.async {
            self.tableviewBirthAnniv.reloadData()
        }
        
    }
    //    func buttonCancelPopupClickEvent(sender:UIButton)
    //    {
    //        buttonOpacityPopup.hidden=true
    //    tableviewBirthAnniv.hidden=true
    //    }
    /*--------------------------------------------------------------------------------------------------------------------------------------------*/
   
  
    
    @objc func buttonWhatsApp2ClickedEvent(_ sender:UIButton)
    {
        buttonSend.isHidden=true
        let  ContactNumber=(muarrayHoldData.object(at: sender.tag)as! NSDictionary).object(forKey: "ContactNumber")as! String
        getCountTableviewBirthAnniv = ((muarrayHoldData.object(at: sender.tag) as AnyObject).value(forKey: "arrayMobile")! as AnyObject).count
        muarrayBAPopup=(muarrayHoldData.object(at: sender.tag) as AnyObject).value(forKey: "arrayMobile")! as! NSMutableArray
        IsEmailSMSCall = "whatsapp"
        buttonOpacityPopup.isHidden=false
        tableviewBirthAnniv.reloadData()
        viewBirthAnnivPopupss.isHidden=false
        let window = UIApplication.shared.keyWindow!
        window.addSubview(viewBirthAnnivPopupss);
    }
    
    
    @objc func buttonCallClickedEvent(_ sender:UIButton)
    {
        buttonSend.isHidden=true
        let  ContactNumber=(muarrayHoldData.object(at: sender.tag)as! NSDictionary).object(forKey: "ContactNumber")as! String
        getCountTableviewBirthAnniv = ((muarrayHoldData.object(at: sender.tag) as AnyObject).value(forKey: "arrayMobile")! as AnyObject).count

        muarrayBAPopup=(muarrayHoldData.object(at: sender.tag) as AnyObject).value(forKey: "arrayMobile")! as! NSMutableArray
        IsEmailSMSCall = "Call"
        buttonOpacityPopup.isHidden=false
        tableviewBirthAnniv.reloadData()
        viewBirthAnnivPopupss.isHidden=false
        let window = UIApplication.shared.keyWindow!
        window.addSubview(viewBirthAnnivPopupss);
    }
    
    @objc func buttonSMSClickedEvent(_ sender:UIButton)
    {
        buttonSend.isHidden=false
        ////print("SMS click !!!!!!!",sender.tag)
        IsEmailSMSCall = "Message"
        let  ContactNumber=(muarrayHoldData.object(at: sender.tag)as! NSDictionary).object(forKey: "ContactNumber")as! String
        ////print(ContactNumber)
        ////print("if sms click !!!!!!!")
        getCountTableviewBirthAnniv = ((muarrayHoldData.object(at: sender.tag) as AnyObject).value(forKey: "arrayMobile")! as AnyObject).count
        muarrayBAPopup=(muarrayHoldData.object(at: sender.tag) as AnyObject).value(forKey: "arrayMobile")! as! NSMutableArray
        muarrayBACheckUncheckPopup=NSMutableArray()
        for i in 00..<muarrayBAPopup.count
        {
            muarrayBACheckUncheckPopup.add("0")
        }
        buttonOpacityPopup.isHidden=false
        tableviewBirthAnniv.reloadData()
        viewBirthAnnivPopupss.isHidden=false
        let window = UIApplication.shared.keyWindow!
        window.addSubview(viewBirthAnnivPopupss);
        // }
        
        
        
    }
    @objc func buttonEmailClickedEvent(_ sender:UIButton)
    {
        
        
        buttonSend.isHidden=false
        IsEmailSMSCall = "email"
        let  ContactNumber=(muarrayHoldData.object(at: sender.tag)as! NSDictionary).object(forKey: "EmailId")as! String

        getCountTableviewBirthAnniv = ((muarrayHoldData.object(at: sender.tag) as AnyObject).value(forKey: "arrayEmail")! as AnyObject).count
        muarrayBAPopup=(muarrayHoldData.object(at: sender.tag) as AnyObject).value(forKey: "arrayEmail")! as! NSMutableArray
        muarrayBACheckUncheckPopup=NSMutableArray()
        for i in 00..<muarrayBAPopup.count
        {
            muarrayBACheckUncheckPopup.add("0")
        }
        if(muarrayBAPopup.count>0)
        {
            buttonOpacityPopup.isHidden=false
            tableviewBirthAnniv.reloadData()
            viewBirthAnnivPopupss.isHidden=false
            let window = UIApplication.shared.keyWindow!
            window.addSubview(viewBirthAnnivPopupss);
        }
        else
        {
        }
    }

    
  @objc  func buttonWhastapp3ClickedEventAni(_ sender:UIButton)
    {
        buttonSend.isHidden=true
        
        if(muarrayHoldDataNew.count>0)
        {
            let  ContactNumber=(muarrayHoldDataNew.object(at: sender.tag)as! NSDictionary).object(forKey: "ContactNumber")as! String
            getCountTableviewBirthAnniv = ((muarrayHoldDataNew.object(at: sender.tag) as AnyObject).value(forKey: "arrayMobile")! as AnyObject).count
            muarrayBAPopup=(muarrayHoldDataNew.object(at: sender.tag) as AnyObject).value(forKey: "arrayMobile")! as! NSMutableArray
            IsEmailSMSCall = "whatsapp"
            if(muarrayBAPopup.count>0)
            {
                buttonOpacityPopup.isHidden=false
                tableviewBirthAnniv.reloadData()
                viewBirthAnnivPopupss.isHidden=false
                let window = UIApplication.shared.keyWindow!
                window.addSubview(viewBirthAnnivPopupss);
            }
        }
    }
    
    
    
    
    @objc func buttonCallClickedEventAni(_ sender:UIButton)
    {
        buttonSend.isHidden=true
        
        if(muarrayHoldDataNew.count>0)
        {
            let  ContactNumber=(muarrayHoldDataNew.object(at: sender.tag)as! NSDictionary).object(forKey: "ContactNumber")as! String
            ////print(ContactNumber)
            ////print("if Call click !!!!!!!")
            getCountTableviewBirthAnniv = ((muarrayHoldDataNew.object(at: sender.tag) as AnyObject).value(forKey: "arrayMobile")! as AnyObject).count
            muarrayBAPopup=(muarrayHoldDataNew.object(at: sender.tag) as AnyObject).value(forKey: "arrayMobile")! as! NSMutableArray
            IsEmailSMSCall = "Call"
            if(muarrayBAPopup.count>0)
            {
                buttonOpacityPopup.isHidden=false
                tableviewBirthAnniv.reloadData()
                viewBirthAnnivPopupss.isHidden=false
                let window = UIApplication.shared.keyWindow!
                window.addSubview(viewBirthAnnivPopupss);
            }
        }
    }
    
    
    
    
     @objc func buttonSMSClickedEventAni(_ sender:UIButton)
    {
        buttonSend.isHidden=false
        
        ////print("SMS click !!!!!!!")
        IsEmailSMSCall = "Message"
        
        
        
        let  ContactNumber=(muarrayHoldDataNew.object(at: sender.tag)as! NSDictionary).object(forKey: "ContactNumber")as! String
        ////print(ContactNumber)
        //        if(ContactNumber.characters.count>7)
        //        {
        //            ////print("sms self person !!!!!!!")
        //            //need to call
        //
        //
        //
        //            var stringArray:[String]=[]
        //            stringArray.append(ContactNumber)
        //
        //            SMSAction(stringArray)
        //
        //
        //        }
        //        else
        //        {
        
        ////print("if sms click !!!!!!!")
        //////print((muarrayHoldDataNew.object(at: sender.tag) as AnyObject).value(forKey: "arrayMobile"))
       // ////print(((muarrayHoldDataNew.object(at: sender.tag) as AnyObject).value(forKey: "arrayMobile")! as AnyObject).count)
        getCountTableviewBirthAnniv = ((muarrayHoldDataNew.object(at: sender.tag) as AnyObject).value(forKey: "arrayMobile")! as AnyObject).count
        
        muarrayBAPopup=(muarrayHoldDataNew.object(at: sender.tag) as AnyObject).value(forKey: "arrayMobile")! as! NSMutableArray
        
        muarrayBACheckUncheckPopup=NSMutableArray()
        
        for i in 00..<muarrayBAPopup.count
        {
            muarrayBACheckUncheckPopup.add("0")
        }
        
        buttonOpacityPopup.isHidden=false
        
        
        tableviewBirthAnniv.reloadData()
        viewBirthAnnivPopupss.isHidden=false
        let window = UIApplication.shared.keyWindow!
        window.addSubview(viewBirthAnnivPopupss);
        // }
        
        
        
    }
   @objc func buttonEmailClickedEventAni(_ sender:UIButton)
    {
        buttonSend.isHidden=false
        ////print("555555555555555555555555555555555555555555",isBirthdayorAnniv)
        ////print("emailid click !!!!!!!")
        IsEmailSMSCall = "email"
        let  ContactNumber=(muarrayHoldDataNew.object(at: sender.tag)as! NSDictionary).object(forKey: "EmailId")as! String
        ////print(ContactNumber)
        ////print("if email click !!!!!!!111111")
        getCountTableviewBirthAnniv = (((muarrayHoldDataNew.object(at: sender.tag) as AnyObject).value(forKey: "arrayEmail") as AnyObject) as AnyObject).count
        muarrayBAPopup=(muarrayHoldDataNew.object(at: sender.tag) as AnyObject).value(forKey: "arrayEmail")! as! NSMutableArray
        muarrayBACheckUncheckPopup=NSMutableArray()
        
        for i in 00..<muarrayBAPopup.count
        {
            muarrayBACheckUncheckPopup.add("0")
        }
        if(muarrayBAPopup.count>0)
        {
            viewBirthAnnivPopupss.isHidden=false
            buttonOpacityPopup.isHidden=false
            
            
           // self.view.bringSubview(toFront: viewBirthAnnivPopupss)

           // viewBirthAnnivEvent.bringSubview(toFront: viewBirthAnnivPopupss)

            
            let window = UIApplication.shared.keyWindow!
            window.addSubview(viewBirthAnnivPopupss);
            //viewBirthAnnivPopupss.backgroundColor = UIColor.black
          
            
           // let window = UIApplication.shared.keyWindow!
          //  window.addSubview(viewBirthAnnivPopupss)
          
            
            
            
            tableviewBirthAnniv.reloadData()
        }
        else
        {
          //  self.view.makeToast("No Email available 33", duration: 2, position: CSToastPositionCenter)
        }
        
    }
    /*----------------------------------------------------------------------------------------------------*/
    @objc func functionForGoToEventDetailFromEventScreen(_ sender:UIButton)
    {
        muarrayHoldDataNewEvent.object(at: sender.tag)
        
        ////print(muarrayHoldDataNewEvent)
        
        
        let letmemberId=(muarrayHoldDataNewEvent.object(at: sender.tag)as! NSDictionary).object(forKey: "MemberID")as! String
        
        //let letmemberId=(muarrayHoldDataNewEvent.object(at: sender.tag)as! NSDictionary).object(forKey: "MemberID")as! String

        
        
        
       // ////print(muarrayHoldDataNewEvent)
      //  ////print(letmemberId)
        
        //varISTodayDateandSelectedIndexSame=sender.tag
        
        ////print("-----------")
        ////print(muarrayHoldDataNewEvent)

        //objCalendarInfo=CalendarInfo()
        // objCalendarInfo=muarrayGetDataFromDayWiseOrMonthWise.objectAtIndex(sender.tag) as! CalendarInfo
        // ////print(objCalendarInfo)
        // ////print(objCalendarInfo.stringTypeID)
        /*---------*/
        //1.
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
 {
     if(isCategory=="2")
     {
  //print(stringGroupID)
  var boom = letmemberId
  let getMemberID = String(boom.characters.dropFirst())
  var grpIdForCheckDifference:String!=""
  grpIdForCheckDifference=stringGroupID
 //stringGroupID = (muarrayHoldDataNewEvent.object(at: sender.tag)as! NSDictionary).object(forKey: "GroupIdNew")as? String
  
  UserDefaults.standard.set(self.isAdmin, forKey: "isAdmin")
  let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "eventDetail") as! EventsDetailController
  //secondViewController.grpDetailPrevious = grpDetailPrevious
  //print("EventsDetailController Clling in 1")
  secondViewController.profileId = stringProfileId
  secondViewController.grpId = (muarrayHoldDataNewEvent.object(at: sender.tag)as! NSDictionary).object(forKey: "GroupIdNew")as? String as! NSString
  secondViewController.grpIdForCheckDifference = stringGroupID as! NSString
  
  //grpIdForCheckDifference
  secondViewController.eventID = getMemberID as NSString
  secondViewController.isCalled = "fromcelebreation"
  secondViewController.varIsRSVPEnableorDisable=0
  secondViewController.isAdmin = self.isAdmin
  secondViewController.grpName=self.grpName
  secondViewController.isCategory=self.isCategory
  secondViewController.varType = self.varType
  secondViewController.SMSCountStr = ""
  
  //print("This is detail :----------")
  //print("stringGroupID:-------",stringGroupID)
  //print("main:-------",(muarrayHoldDataNewEvent.object(at: sender.tag)as! NSDictionary))
  //print(stringGroupID)
  self.navigationController?.pushViewController(secondViewController, animated: true)
 }
 else
 {
  //stringGroupID = (muarrayHoldDataNewEvent.object(at: sender.tag)as! NSDictionary).object(forKey: "GroupIdNew")as? String

  UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
  let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "eventDetail") as! EventsDetailController
  //print("EventsDetailController Clling in 2")
  ///----
  var grpIdForCheckDifference:String!=""//
 // grpIdForCheckDifference=stringGroupID
  //stringGroupID = (muarrayHoldDataNewEvent.object(at: sender.tag)as! NSDictionary).object(forKey: "GroupIdNew")as? String
  
 // ////print(grpIdForCheckDifference)
  ////print(stringGroupID)
  //--------
  
  
//  secondViewController.grpDetailPrevious = grpDetailPrevious
  secondViewController.profileId = stringProfileId
  secondViewController.grpId = stringGroupID as! NSString
  secondViewController.eventID = letmemberId as NSString
  secondViewController.isCalled = "fromcelebreation"
  secondViewController.varIsRSVPEnableorDisable=0
  secondViewController.varType = self.varType
  secondViewController.isCategory=self.isCategory
  secondViewController.grpName=self.grpName
  secondViewController.SMSCountStr = ""
  secondViewController.grpIdForCheckDifference = ""
  
  self.navigationController?.pushViewController(secondViewController, animated: true)
            }
        }
        else
        {
            self.view.makeToast("Could not connect to server.", duration: 2, position: CSToastPositionCenter)
           // SVProgressHUD.dismiss()
        }
    }

    @objc func buttonMainEventBirthAnnivClickEvent(_ sender:UIButton)
    {
        varISTodayDateandSelectedIndexSame=sender.tag
        objCalendarInfo=CalendarInfo()
        objCalendarInfo=muarrayGetDataFromDayWiseOrMonthWise.object(at: sender.tag) as! CalendarInfo
        ////print(objCalendarInfo)
        ////print(objCalendarInfo.stringTypeID)
        /*---------*/
        //1.
        if(objCalendarInfo.stringType=="Birthday" || objCalendarInfo.stringType=="Anniversary")
        {
    if(isCategory=="2")
     {
     if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                {
       let profVC = self.storyboard!.instantiateViewController(withIdentifier: "DistrictDirectoryDetailsVC") as! DistrictDirectoryDetailsVC
       // profVC.userName = objCalendarInfo.stringTitle
       profVC.groupID = stringGroupID!
       profVC.selectedMemberProfileID =  objCalendarInfo.stringTypeID
      self.navigationController?.pushViewController(profVC, animated: true)
   }
   else
   {
       self.view.makeToast("Could not connect to server.", duration: 2, position: CSToastPositionCenter)
        //SVProgressHUD.dismiss()
   }
  
  }
  else
  {
      UserDefaults.standard.set("no", forKey: "picadded")
      let profVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
      profVC.grpID = stringGroupID!
      profVC.profileId =  objCalendarInfo.stringTypeID
      profVC.NormalMemberOrAdmin = "comingfromcelebreationscreen"
      profVC.isCategory=self.isCategory
 
      //profVC.isAdmin = isAdmin
      //profVC.mainUSerPRofileID = stringProfileId
      //profVC.isCalled = "comingfromcelebreationscreen"
      self.navigationController?.pushViewController(profVC, animated: true)
            }
            //////print(stringGroupID!)
            // ////print(objCalendarInfo.stringTypeID)
            
        }
        else
        {
       
            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
            {
  if(isCategory=="2")
  {
      /*
       let objClubEventDetailsShowViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DistrictEventDetailsShowViewController") as! DistrictEventDetailsShowViewController
       objClubEventDetailsShowViewController.eventID = objCalendarInfo.stringTypeID
       self.navigationController?.pushViewController(objClubEventDetailsShowViewController, animated: true)
       */
      UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
      let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "eventDetail") as! EventsDetailController
      //print("EventsDetailController Clling in 3")
      //secondViewController.grpDetailPrevious = grpDetailPrevious
      secondViewController.profileId = stringProfileId
      secondViewController.grpId = stringGroupID as! NSString
      secondViewController.eventID = objCalendarInfo.stringTypeID as NSString
      secondViewController.isCalled = "fromcelebreation"
      secondViewController.varIsRSVPEnableorDisable=0
      secondViewController.isCategory=self.isCategory
      secondViewController.grpName=self.grpName
      secondViewController.grpIdForCheckDifference = self.stringGroupID as! NSString
      //secondViewController.SMSCountStr = SMSCountStr
      self.navigationController?.pushViewController(secondViewController, animated: true)
  }
  else
  {
      UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
      let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "eventDetail") as! EventsDetailController
          //print("EventsDetailController Clling in 4")
      //secondViewController.grpDetailPrevious = grpDetailPrevious
      secondViewController.profileId = stringProfileId
      secondViewController.grpId = stringGroupID as! NSString
      secondViewController.eventID = objCalendarInfo.stringTypeID as NSString
      secondViewController.isCalled = "fromcelebreation"
      secondViewController.varIsRSVPEnableorDisable=0
      secondViewController.grpName=self.grpName
      secondViewController.isCategory=self.isCategory
      //secondViewController.SMSCountStr = SMSCountStr
      self.navigationController?.pushViewController(secondViewController, animated: true)
  }
            }
            else
            {
                self.view.makeToast("Could not connect to server.", duration: 2, position: CSToastPositionCenter)
                 //SVProgressHUD.dismiss()
            }
        }
        //  profileId, grpID: grpId, eventID: eventID)
        /*
         getEventsDetail(groupProfileID:NSString,grpID:NSString,eventID:NSString)
         */
        
        /*--------*/
    }
    //delete album
    func buttonDetailClickEvent(_ sender:UIButton)
    {
        let dict:NSDictionary = (muarrayEventAnnivBirth.object(at: sender.tag) as! NSDictionary)
    }
    @IBAction func buttonNextMonthClickEvent(_ sender: AnyObject)
    {
        
    }
    /*----------------------------------------------------------*/
    //MARK:- SERVER CALLING
    var countsnew:Int=0
    func functionForSynchronousNextMonthDataWithServerData(stringMonth:String,stringYear:String)
    {
        
        
        ////print("12121212121212121")
        //loaderClass.loaderViewMethod()
        self.buttonOpacity.isHidden=false
   
        
        let date = Date()
        let calendar = Calendar.current
        
        //var varPassYear = calendar.component(.year, from: date)
        var varPassMonthssss = calendar.component(.month, from: date)
        var varPassDay = calendar.component(.day, from: date)
        
        ////print(varPassDay)
        ////print(String(varPassMonthssss),stringMonth)
        var  varPassMonth = stringMonth
        var  varPassYear = stringYear
        //moduleId
        var varIsFirstTimeExecute=UserDefaults.standard.value(forKey: "session_IsFirstTimeCalendarSlot")
        var varSelectedDate:String=""
        var varUpdateOns:String=""
        // ////print(varIsFirstTimeExecute)
        
       ////print(stringMonth)
      
        
        varGetLastMonth = Int(varPassMonth)!
        varGetLastYear = Int(varPassYear)!
        var   varGetPassMonth = commonClassFunction().functionForMonthWordWise(varPassMonth)
        if(countsnew==0)
        {
            
                labelMonthYear.text = String(varPassDay)+" "+varGetPassMonth+" "+varPassYear //Remove Comma
            varGetCurrentDay=String(varPassDay)
                countsnew=1
        }
       else
        {
           
                labelMonthYear.text = "01 "+varGetPassMonth+" "+varPassYear //Remove Comma
            varGetCurrentDay="01"
        }
        
        
        var letGetLastUpdateDate = ModelManager.getInstance().functionForGetLastUpdateDateFromMonthTable(varPassMonth, stringYear: varPassYear,GroupID:self.stringGroupID as! String)
        if(varIsFirstTimeExecute==nil)
        {
            varSelectedDate=varPassYear+"-"+varPassMonth+"-"+"01"
            //varUpdateOns="1970/01/01 00:00:00"
            varUpdateOns="2019/01/01 00:00:00"
        }
        else
        {
            var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
            //varUpdateOns=letGetLastUpdateDate
            //varUpdateOns="1970/01/01 00:00:00"
            varUpdateOns="2019/01/01 00:00:00"
            ////print(varUpdateOns)
            
            varSelectedDate=varPassYear+"-"+varPassMonth+"-"+"01"
            // ////print("••••••••••••••••••••••••••••••••••")
            // ////print((NSUserDefaults.standardUserDefaults().valueForKey(Updatedefault) as! String?)!)
            
        }
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            //
            ////print("this is first value of this calendar   222222222")

            varNextMonthFirstDate = varSelectedDate
            let completeURL = baseUrl+touchBase_GetMonthEventList
            var parameterst:NSDictionary=NSDictionary()
            if(isCategory=="1")
            {
                //////print("Club----------------------------Category",isCategory)
                parameterst = [
                    k_API_profileId : stringProfileId ,
                    k_API_groupIds : stringGroupID as! String,
                    k_API_selectedDate : varSelectedDate,
                    k_API_updatedOns:varUpdateOns,
                    "groupCategory":isCategory]
            }
            else if(isCategory=="2")
            {
                //////print("District----------------------------Category",isCategory)
                parameterst = [
                    k_API_profileId : stringProfileId,
                    k_API_groupIds : stringGroupID as! String,
                    k_API_selectedDate : varSelectedDate,
                    k_API_updatedOns:varUpdateOns,
                    "groupCategory":isCategory]
                
                
            }
            //            let parameterst = [
            //                k_API_profileId : stringProfileId as! String,
            //                k_API_groupIds : stringGroupID as! String,
            //                k_API_selectedDate : varSelectedDate,
            //                k_API_updatedOns:varUpdateOns
            //            ]
            ////print(varUpdateOns)
            ////print(parameterst)
            ////print(completeURL)
            
            print("completeURL -7- on \(Date()): \(completeURL)")
            print("parameter -7- on \(Date()): \(parameterst)")
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
                print("Response of -7- on \(Date())")
                ////print("get value here Next ")
                var varGetValueServerError = response.object(forKey: "serverError")as? String
                if(varGetValueServerError == "Error")
                {
                    //self.loaderClass.window=nil
                    self.view.makeToast("Could not connect to server, please try again.", duration: 2, position: CSToastPositionCenter)
                   // SVProgressHUD.dismiss()
                }
                else
                {
                    //self.loaderClass.window=nil
                    
                    //print("Calender date response :: \(response)")
                    let arrayNew=((response.value(forKey: "TBEventListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newEvents")as! NSArray
                    let arrayUpdateEvents=((response.value(forKey: "TBEventListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "updatedEvents")as! NSArray
                    let arraydeletedEvents=((response.value(forKey: "TBEventListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "deletedEvents")as! NSArray
                    // ////print(arrayNew)
                    //////print(arrayUpdateEvents)
                    //////print(arraydeletedEvents)
                    //-----
                    var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                    let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
                   // var varGetLastUpdateValueDate = UserDefaults.standard.value(forKey: Updatedefault) as! String

                    var muarrayTempDate:NSMutableArray=NSMutableArray()
                    for i in 00..<arrayNew.count
                    {
                        let mudict:NSDictionary=arrayNew.object(at: i)as! NSDictionary
                        let varGetEventDate=mudict.value(forKey: "eventDate")as! String

                        let fullName    = varGetEventDate
                        let fullNameArr = fullName.components(separatedBy: " ")
                        let name    = fullNameArr[0]
                        let fullNameArrnew = name.components(separatedBy: "-")
                        var value    = fullNameArrnew[2]
                        if(value=="1" || value == "01")
                        {
                            value="1"
                        }
                        else  if(value=="2" || value == "02")
                        {
                            value="2"
                        }
                        else if(value=="3" || value == "03")
                        {
                            value="3"
                        }
                        else if(value=="4" || value == "04")
                        {
                            value="4"
                        }
                        else if(value=="5" || value == "05")
                        {
                            value="5"
                        }
                        else if(value=="6" || value == "06")
                        {
                            value="6"
                        }
                        else if(value=="7" || value == "07")
                        {
                            value="7"
                        }
                            
                        else if(value=="8" || value == "08")
                        {
                            value="8"
                        }
                        else if(value=="9" || value == "09")
                        {
                            value="9"
                        }
                        ////print(value)
                        
                      muarrayTempDate.add(value)
                    }
                    for j in 00..<arrayUpdateEvents.count
                    {
                        let mudict:NSDictionary=arrayUpdateEvents.object(at: j)as! NSDictionary
                        let varGetEventDate=mudict.value(forKey: "eventDate")as! String
                        
                        
                        
                        let fullName    = varGetEventDate
                        let fullNameArr = fullName.components(separatedBy: " ")
                        let name    = fullNameArr[0]
                        let fullNameArrnew = name.components(separatedBy: "-")
                        var value    = fullNameArrnew[2]
                        ////print(value)
                        if(value=="1" || value == "01")
                        {
                          value="1"
                        }
                        else  if(value=="2" || value == "02")
                        {
                            value="2"
                        }
                       else if(value=="3" || value == "03")
                        {
                            value="3"
                        }
                        else if(value=="4" || value == "04")
                        {
                            value="4"
                        }
                        else if(value=="5" || value == "05")
                        {
                            value="5"
                        }
                        else if(value=="6" || value == "06")
                        {
                            value="6"
                        }
                        else if(value=="7" || value == "07")
                        {
                            value="7"
                        }
                        
                        else if(value=="8" || value == "08")
                        {
                            value="8"
                        }
                        else if(value=="9" || value == "09")
                        {
                            value="9"
                        }
                        ////print(value)
                        muarrayTempDate.add(value)
                    }
                    
                      self.muarrayDotValuesInCollectionNext=NSMutableArray()
                    self.muarrayDotValuesInCollectionNext=muarrayTempDate
                    //print("self.muarrayDotValuesInCollectionNext 11 :: 11 \(self.muarrayDotValuesInCollectionNext)")
                    
                    var varGetLastUpdateValueDate:String=""
                    if let varGetLastUpdateValueDateBack = UserDefaults.standard.value(forKey: Updatedefault) as? String
                    {
                        varGetLastUpdateValueDate=varGetLastUpdateValueDateBack
                    }

                    
                    ModelManager().functionForAddUpdateDeleteNewEvent(arrayNew, arrayUpdate: arrayUpdateEvents, arrayDelete: arraydeletedEvents,stringLastUpdateDate:varGetLastUpdateValueDate, stringMonth: varPassMonth, stringYear: varPassYear,GroupID:self.stringGroupID as! String)
                    
                    ///-----------------------
                    self.marrCalendarData = ModelManager.getInstance().getAllStudentData(String(self.varGetLastMonth), stringYear: String(self.varGetLastYear),groupID:self.stringGroupID as! String)
                    ////print(self.marrCalendarData.count)
                    
                    self.muarrayIsSelected=NSMutableArray()
                    for i in 00..<self.marrCalendarData.count
                    {
                        self.muarrayIsSelected.add("0")
                    }
                    self.collectionviewCelebreation.reloadData()
                    self.collectionviewCelebreation?.collectionViewLayout.invalidateLayout()
                    
                    
                    /*----------------------------For Curent Date Data Show------DPK----------------*/
                    //muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
                    self.muarrayGetDataFromDayWiseOrMonthWise=ModelManager.getInstance().functionForGetEventBirthdayAnnivversaryData(self.varPassDay, stringMonth: self.varPassMonth, stringYear: self.varPassYear)
                    print(self.muarrayHoldDateWiseData)
                    self.tableviewEventAnnivBirthDay.reloadData()
                    
                    
                    //self.loaderClass.window=nil
                    self.buttonOpacity.isHidden=true
                    
                    if(self.varIsFirstOrDoneButton == "Done")
                    {
                        self.muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
                        self.tableviewEventAnnivBirthDay.reloadData()
                        
                    }
                    
                }
            })
        }
        else
        {
            self.marrCalendarData = ModelManager.getInstance().getAllStudentData(String(self.varGetLastMonth), stringYear: String(self.varGetLastYear),groupID:self.stringGroupID as! String)
             ////print(self.marrCalendarData.count)
            
            self.muarrayIsSelected=NSMutableArray()
            for i in 00..<self.marrCalendarData.count
            {
                self.muarrayIsSelected.add("0")
            }
            self.collectionviewCelebreation.reloadData()
            self.collectionviewCelebreation?.collectionViewLayout.invalidateLayout()
           // self.loaderClass.window=nil
            self.buttonOpacity.isHidden=true
            //self.loaderClass.window=nil
        }
        
        self.varPassMonth=varPassMonth
        searchButton = UIButton(type: UIButton.ButtonType.custom)
        searchButton.frame = CGRect(x: 0, y: 0, width: 90, height: 30)
        // searchButton.setImage(UIImage(named:"Delete_blue"), forState: UIControl.State.Normal)
        searchButton.setImage(UIImage(named:"down_arrow"),  for: UIControl.State.normal)
        searchButton.imageView?.contentMode = .scaleAspectFit
        searchButton.titleEdgeInsets = UIEdgeInsets(top: 0,left: -20,bottom: 0,right:34)
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 0,left: 60,bottom: 0,right:0)
        
        //4....
        let   varGetPassMonthsNew = commonClassFunction().functionForMonthWordWiseNEwdate(self.varPassMonth)
        searchButton.setTitle("Month",  for: UIControl.State.normal)
        
        
        searchButton.backgroundColor = UIColor.clear
        searchButton.layer.cornerRadius = 5
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        
        
        searchButton.setImage(UIImage(named:"down_arrow"),  for: UIControl.State.normal)
        searchButton.imageView?.contentMode = .scaleAspectFit
        searchButton.titleEdgeInsets = UIEdgeInsets(top: 0,left: -20,bottom: 0,right:34)
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 0,left: 60,bottom: 0,right:0)
        
        
        searchButton.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        if(IsMonthorBAEviewAppear==true)
        {
            searchButton.setTitle("Month",  for: UIControl.State.normal)
            
        }
        else if(IsMonthorBAEviewAppear==false)
        {
            searchButton.setTitle("Day",  for: UIControl.State.normal)
        }
        
        // searchButton.imageView?.contentMode = .ScaleAspectFit
        //  searchButton.titleEdgeInsets = UIEdgeInsets(top: 0,left: -20,bottom: 0,right:34)
        //searchButton.imageEdgeInsets = UIEdgeInsets(top: 0,left: 60,bottom: 0,right:0)
        
        
        searchButton.addTarget(self, action: #selector(CelebrationViewController.RefreshDataClickEvent), for: UIControl.Event.touchUpInside)
        let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
        let buttonss : NSArray = [search]
        dropDownButton = UIButton(type: UIButton.ButtonType.custom)
        dropDownButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        dropDownButton.addTarget(self, action: #selector(CelebrationViewController.RefreshDataClickEvent), for: UIControl.Event.touchUpInside)
        let setting: UIBarButtonItem = UIBarButtonItem(customView: dropDownButton)
        //let buttons : NSArray = [search, setting] //14 mar
        let buttons : NSArray = [search]
       
        if(iscalledFromNoti=="notify")
        {
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]

        }
        else
        {
        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
        
    }
    var varNaviRightButtonClickCount:Int!=1
    
    var muarrayDotValuesInCollectionNext:NSMutableArray=NSMutableArray()
   // var muarrayDotValuesInCollectionPrevious:NSMutableArray=NSMutableArray()

    
    func functionForSynchronousPreviousMonthDataWithServerData(_ stringMonth:String,stringYear:String)
    {
        
        countValue=1
        ////print("::::::: ::::::: 131313131313 ::::::: :::::::")
       // loaderClass.loaderViewMethod()
        self.buttonOpacity.isHidden=false
        // var varPassDay=String(NSCalendar.currentCalendar().components([.Day , .Month , .Year], fromDate: NSDate()).day)
        
        var varPassDay=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).day) // 28-06-2018 DPK
        var varPassMonthssss=String(describing: (Calendar.current as NSCalendar).components([.day , .month , .year], from: Foundation.Date()).month) // 28-06-2018 DPK
        
        
        
        
        var  varPassMonth=stringMonth
        var  varPassYear=stringYear
        //moduleId
        var varIsFirstTimeExecute=UserDefaults.standard.value(forKey: "session_IsFirstTimeCalendarSlot")
        var varSelectedDate:String=""
        var varUpdateOns:String=""
        // ////print(varIsFirstTimeExecute)
        
        varGetLastMonth = Int(varPassMonth)!
        varGetLastYear = Int(varPassYear)!
        var   varGetPassMonth = commonClassFunction().functionForMonthWordWise(varPassMonth)
        //labelMonthYear.text = "01 "+varGetPassMonth+" "+varPassYear //Remove Comma
        
        
        if(varPassMonthssss==stringMonth) // 28-06-2018 DPK
        {
            labelMonthYear.text = varPassDay+" "+varGetPassMonth+" "+varPassYear //Remove Comma
            varGetCurrentDay=varPassDay
        }
        else
        {
            labelMonthYear.text = "01 "+varGetPassMonth+" "+varPassYear //Remove Comma
            varGetCurrentDay="01"
        }
        
        
        
        
        
        var letGetLastUpdateDate = ModelManager.getInstance().functionForGetLastUpdateDateFromMonthTable(varPassMonth, stringYear: varPassYear,GroupID:self.stringGroupID as! String)
        if(varIsFirstTimeExecute==nil)
        {
            varSelectedDate=varPassYear+"-"+varPassMonth+"-"+"01"
            //varUpdateOns="1970/01/01 00:00:00"
            varUpdateOns="2019/01/01 00:00:00"
        }
        else
        {
            var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
            //varUpdateOns=letGetLastUpdateDate
            //varUpdateOns="1970/01/01 00:00:00"
            varUpdateOns="2019/01/01 00:00:00"
            // ////print(varUpdateOns)
            
            varSelectedDate=varPassYear+"-"+varPassMonth+"-"+"01"
            //////print("••••••••••••••••••••••••••••••••••")
            //////print((NSUserDefaults.standardUserDefaults().valueForKey(Updatedefault) as! String?)!)
            
        }
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            ////print("this is first value of this calendar 555555555")

            let completeURL = baseUrl+touchBase_GetMonthEventList
            
            var parameterst:NSDictionary=NSDictionary()
            if(isCategory=="1")
            {
                ////print("Club----------------------------Category",isCategory)
                parameterst = [
                    k_API_profileId : stringProfileId,
                    k_API_groupIds : stringGroupID as! String,
                    k_API_selectedDate : varSelectedDate,
                    k_API_updatedOns:varUpdateOns,
                    "groupCategory":isCategory]
            }
            else if(isCategory=="2")
            {
                ////print("District----------------------------Category",isCategory)
                parameterst = [
                    k_API_profileId : stringProfileId ,
                    k_API_groupIds : stringGroupID as! String,
                    k_API_selectedDate : varSelectedDate,
                    k_API_updatedOns:varUpdateOns,
                    "groupCategory":isCategory]
                
                
            }
            
            
            
            
            //            let parameterst = [
            //                k_API_profileId : stringProfileId as! String,
            //                k_API_groupIds : stringGroupID as! String,
            //                k_API_selectedDate : varSelectedDate,
            //                k_API_updatedOns:varUpdateOns
            //            ]
            ////print(varUpdateOns)
            print("completeURL -1- on \(Date()) :: \(completeURL)")
            print("parameterst -1- on \(Date()) :: \(parameterst)")
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
        print("Response of -1- on \(Date())")
                ////print("get value here previous ")
                
                
                var varGetValueServerError = response.object(forKey: "serverError")as? String
                if(varGetValueServerError == "Error")
                {
                    self.view.makeToast("Could not connect to server.", duration: 2, position: CSToastPositionCenter)
                    //SVProgressHUD.dismiss()
                }
                else
                {
                    let arrayNew=((response.value(forKey: "TBEventListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newEvents")as! NSArray
                    let arrayUpdateEvents=((response.value(forKey: "TBEventListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "updatedEvents")as! NSArray
                    let arraydeletedEvents=((response.value(forKey: "TBEventListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "deletedEvents")as! NSArray

                    var muarrayTempDate:NSMutableArray=NSMutableArray()
                    for i in 00..<arrayNew.count
                    {
                        let mudict:NSDictionary=arrayNew.object(at: i)as! NSDictionary
                        let varGetEventDate=mudict.value(forKey: "eventDate")as! String
                        
                        
                        
                        let fullName    = varGetEventDate
                        let fullNameArr = fullName.components(separatedBy: " ")
                        let name    = fullNameArr[0]
                        let fullNameArrnew = name.components(separatedBy: "-")
                        var value    = fullNameArrnew[2]
                        
                        
                        
                        ////print(value)
                        
                        if(value=="1" || value == "01")
                        {
                            value="1"
                        }
                        else  if(value=="2" || value == "02")
                        {
                            value="2"
                        }
                        else if(value=="3" || value == "03")
                        {
                            value="3"
                        }
                        else if(value=="4" || value == "04")
                        {
                            value="4"
                        }
                        else if(value=="5" || value == "05")
                        {
                            value="5"
                        }
                        else if(value=="6" || value == "06")
                        {
                            value="6"
                        }
                        else if(value=="7" || value == "07")
                        {
                            value="7"
                        }
                            
                        else if(value=="8" || value == "08")
                        {
                            value="8"
                        }
                        else if(value=="9" || value == "09")
                        {
                            value="9"
                        }
                        ////print(value)
                        muarrayTempDate.add(value)
                        
                        
                        muarrayTempDate.add(value)
                    }
                    for j in 00..<arrayUpdateEvents.count
                    {
                        let mudict:NSDictionary=arrayUpdateEvents.object(at: j)as! NSDictionary
                        let varGetEventDate=mudict.value(forKey: "eventDate")as! String
                        
                        
                        
                        let fullName    = varGetEventDate
                        let fullNameArr = fullName.components(separatedBy: " ")
                        let name    = fullNameArr[0]
                        let fullNameArrnew = name.components(separatedBy: "-")
                        var value    = fullNameArrnew[2]
                        
                        ////print(value)
                        
                        if(value=="1" || value == "01")
                        {
                            value="1"
                        }
                        else  if(value=="2" || value == "02")
                        {
                            value="2"
                        }
                        else if(value=="3" || value == "03")
                        {
                            value="3"
                        }
                        else if(value=="4" || value == "04")
                        {
                            value="4"
                        }
                        else if(value=="5" || value == "05")
                        {
                            value="5"
                        }
                        else if(value=="6" || value == "06")
                        {
                            value="6"
                        }
                        else if(value=="7" || value == "07")
                        {
                            value="7"
                        }
                            
                        else if(value=="8" || value == "08")
                        {
                            value="8"
                        }
                        else if(value=="9" || value == "09")
                        {
                            value="9"
                        }
                        ////print(value)
                        muarrayTempDate.add(value)
                    }
                    
                    self.muarrayDotValuesInCollectionNext=NSMutableArray()
                    self.muarrayDotValuesInCollectionNext=muarrayTempDate
                    
                    //print("self.muarrayDotValuesInCollectionNext 22 :: 22 \(self.muarrayDotValuesInCollectionNext)")
                    
                    
                    
                    
                    
                    // ////print(arrayNew)
                    // ////print(arrayUpdateEvents)
                    //////print(arraydeletedEvents)
                    //-----
                    let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                    let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
                    var varGetLastUpdateValueDate = UserDefaults.standard.value(forKey: Updatedefault) as? String
                    ModelManager().functionForAddUpdateDeleteNewEvent(arrayNew, arrayUpdate: arrayUpdateEvents, arrayDelete: arraydeletedEvents,stringLastUpdateDate:varGetLastUpdateValueDate ?? "", stringMonth: varPassMonth, stringYear: varPassYear,GroupID:self.stringGroupID as! String)
                    ///-----------------------
                    self.marrCalendarData = ModelManager.getInstance().getAllStudentData(String(self.varGetLastMonth), stringYear: String(self.varGetLastYear),groupID:self.stringGroupID as? String ?? "")
                    //////print(self.marrCalendarData.count)
                    self.muarrayIsSelected=NSMutableArray()
                    for i in 00..<self.marrCalendarData.count
                    {
                        self.muarrayIsSelected.add("0")
                    }
                    self.collectionviewCelebreation.reloadData()
                    self.collectionviewCelebreation?.collectionViewLayout.invalidateLayout()
                    
                    /*----------------------------For Curent Date Data Show------DPK----------------*/
                    //muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
                    self.muarrayGetDataFromDayWiseOrMonthWise=ModelManager.getInstance().functionForGetEventBirthdayAnnivversaryData(self.varPassDay, stringMonth: self.varPassMonth, stringYear: self.varPassYear)
                    // ////print(muarrayGetDataFromDayWiseOrMonthWise)
                    self.tableviewEventAnnivBirthDay.reloadData()
                    
                   // self.loaderClass.window=nil
                    self.buttonOpacity.isHidden=true
                    
                }
            })
        }
        else
        {
            ///-----------------------
            self.marrCalendarData = ModelManager.getInstance().getAllStudentData(String(self.varGetLastMonth), stringYear: String(self.varGetLastYear),groupID:self.stringGroupID as! String)
            //////print(self.marrCalendarData.count)
            
            self.muarrayIsSelected=NSMutableArray()
            for i in 00..<self.marrCalendarData.count
            {
                self.muarrayIsSelected.add("0")
            }
            self.collectionviewCelebreation.reloadData()
            self.collectionviewCelebreation?.collectionViewLayout.invalidateLayout()
            //self.loaderClass.window=nil
            self.buttonOpacity.isHidden=true
        }
        self.varPassMonth=varPassMonth
        searchButton = UIButton(type: UIButton.ButtonType.custom)
        searchButton.frame = CGRect(x: 0, y: 0, width: 90, height: 30)
        // searchButton.setImage(UIImage(named:"Delete_blue"), forState: UIControl.State.Normal)
        searchButton.setImage(UIImage(named:"down_arrow"),  for: UIControl.State.normal)
        searchButton.imageView?.contentMode = .scaleAspectFit
        searchButton.titleEdgeInsets = UIEdgeInsets(top: 0,left: -20,bottom: 0,right:34)
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 0,left: 60,bottom: 0,right:0)
        
        //5.....
        let   varGetPassMonthsNew = commonClassFunction().functionForMonthWordWiseNEwdate(self.varPassMonth)
        //  searchButton.setTitle(varGetPassMonthw, forState: .Normal)
        searchButton.setTitle("Day",  for: UIControl.State.normal)
        
        
        searchButton.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        searchButton.backgroundColor = UIColor.clear
        searchButton.layer.cornerRadius = 5
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        searchButton.addTarget(self, action: #selector(CelebrationViewController.RefreshDataClickEvent), for: UIControl.Event.touchUpInside)
        let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
        let buttonss : NSArray = [search]
        dropDownButton = UIButton(type: UIButton.ButtonType.custom)
        dropDownButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        dropDownButton.addTarget(self, action: #selector(CelebrationViewController.RefreshDataClickEvent), for: UIControl.Event.touchUpInside)
        let setting: UIBarButtonItem = UIBarButtonItem(customView: dropDownButton)
        //let buttons : NSArray = [search, setting] //14 mar
        let buttons : NSArray = [search]
        if(iscalledFromNoti=="notify")
        {
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]

        }
        else
        {
        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
        
    }
    /*---Date time --------------------------------*/
    //Only Date
    func setDateAndTimeFull()
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            
            muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
            tableviewEventAnnivBirthDay.reloadData()
            datepickerFilter.datePickerMode = UIDatePicker.Mode.date
            // dateTimePickerController.locale = NSLocale(localeIdentifier: "en_GB")
            // dateTimePickerController.minuteInterval = 15
            let date = Foundation.Date()
            // let currentDate: NSDate = NSDate()
            let formatter = Foundation.DateFormatter()
            formatter.dateFormat = "dd/MM/yyy"
            currentdate = formatter.string(from: date)
            //full date and time show
            DateFormatter.dateStyle = Foundation.DateFormatter.Style.short
            dateTimeDisplay = DateFormatter.string(from: datepickerFilter.date) + " " + timeFormatter.string(from: datepickerFilter.date)
            // ////print(dateTimeDisplay)
            //////print(currentdate)
            
            
            
            datepickerFilter.datePickerMode = UIDatePicker.Mode.date
            let dateFormatter = Foundation.DateFormatter()
            dateFormatter.dateFormat = "MM-yyyy"
            let selectedDate = dateFormatter.string(from: datepickerFilter.date)
            dateTimeDisplay=selectedDate
            ////print(selectedDate)
            
            var varGeteprateDate=selectedDate.components(separatedBy: "-")
            
            varGetLastMonth=Int(String(varGeteprateDate[0]))!    // DPK 02-08-2018
            varGetLastYear=Int(varGeteprateDate[1])!
           // loaderClass.loaderViewMethod()
            
            functionForSynchronousNextMonthDataWithServerData(stringMonth:String(varGetLastMonth) , stringYear: String(varGetLastYear))
            muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
            tableviewEventAnnivBirthDay.reloadData()
            
            //////
            
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let selectedDate2 = dateFormatter.string(from: datepickerFilter.date)
            dateTimeDisplay=selectedDate2
            ////print(selectedDate2)
            
            
            
            let getTodayMonthYear = selectedDate2
            
            ////print(getTodayMonthYear)
            
            functionforGetSelectedDateDetail(getTodayMonthYear)
            
        }
        else
        {
            datepickerFilter.datePickerMode = UIDatePicker.Mode.date
            let dateFormatter = Foundation.DateFormatter()
            dateFormatter.dateFormat = "MM-yyyy"
            let selectedDate = dateFormatter.string(from: datepickerFilter.date)
            dateTimeDisplay=selectedDate
            ////print(selectedDate)
            var varGeteprateDate=selectedDate.components(separatedBy: "-")
            varGetLastMonth=Int(varGeteprateDate[0])!
            varGetLastYear=Int(varGeteprateDate[1])!
         
            //loaderClass.loaderViewMethod()
            functionForSynchronousNextMonthDataWithServerData(stringMonth:String(varGetLastMonth), stringYear: String(varGetLastYear))
            muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
            tableviewEventAnnivBirthDay.reloadData()
        }
        
    }
    //MARK:- Birthday Event Anniversary module
    @IBOutlet weak var viewBirthAnnivEvent: UIView!
    //MARK:- IB
    @IBOutlet weak var tableviewBirthday: UITableView!
    //MARK:- variable
    //var  stringProfileId:String!=""
    // var isAdmin:String!=""
    // var  stringGroupID:String!=""
    // var isCategory:String!=""
    //  var moduleName:String!=""
    var isYearorCalendarView:Bool=true
    var arrayResponse=NSArray()
    var setViewCurrentStatus:Bool=false// not hidden
    var IsExistingUpcomingBirthday:Int!=0
    // var rowSize:CGFloat=0.0
    var lastDateValueForMAtching:String!=""
    var muarrayHoldData:NSMutableArray=NSMutableArray()
    var varGetEventDate:String!=""
    var varGetEventDateNew:String!=""
    
    //MARK:- view didload and view will appear and navigation setting
    //MARK:- Naviagation Setting
    override func viewDidAppear(_ animated: Bool)
    {
        //tableviewBirthday.delegate = self
        //tableviewBirthday.dataSource = self
        //tableviewBirthday.setNeedsLayout()
    }
    
    //MARK:-Call web api
    func functionForGettingCalendarMonthWiseData(_ getTodayMonthYear:String)
    {
        let getProfileId =  UserDefaults.standard.value(forKey: "user_auth_token_profileId")
        let getGroupId =  UserDefaults.standard.value(forKey: "user_auth_token_groupId")

        let completeURL = baseUrl+rowCelebreationBirthDayAnniversaryEvent
        var parameterst:NSDictionary=NSDictionary()
        // isCategory="1"
        if(isCategory=="1")
        {
            if isfromBanner == "yes" {
                parameterst =
                    [
                        "profileId" : 0,
                        "groupId" : getGroupId!,
                        "SelectedDate":getTodayMonthYear,
                        "Type" : "B",
                        "groupCategory":"1"
                    ]
            }
            else{
                parameterst =
                    [
                        "profileId" : getProfileId!,
                        "groupId" : getGroupId!,
                        "SelectedDate":getTodayMonthYear,
                        "Type" : "B",
                        "groupCategory":"1"
                    ]
            }
          
        }
        else if(isCategory=="2")
        {
             ////print("OoOoOoOoOoOoOoOoOoOoOoooooooooooooooOoOoOoOoOoOoOoOoOoOoO")
            if isfromBanner == "yes" {
                parameterst =
                    [
                        "profileId" : 0,
                        "groupId" : getGroupId!,
                        "SelectedDate":getTodayMonthYear,
                        //"SelectedDate":"2018-02-01",
                        "Type" :"B",
                        "groupCategory":"2"
                ]
            }
            else{
                parameterst =
                    [
                        "profileId" : getProfileId!,
                        "groupId" : getGroupId!,
                        "SelectedDate":getTodayMonthYear,
                        //"SelectedDate":"2018-02-01",
                        "Type" :"B",
                        "groupCategory":"2"
                ]
            }
           
        }
        ////print("This is BirthDay of the User :--------")
        
        print("completeURL -2-  on \(Date()) :\(completeURL)")
        print("parameterst -2-  on \(Date()): \(parameterst)")

        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print("Response of -2- on \(response)")
            /*
             ContactNumber = "<null>";
             Description = "Deep ";
             EmailId = "<null>";
             EventTime = "02 : 02 PM";
             eventDate = "2018-02-14 14:40:00";
             title = Santo;
             */
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Could not connect to server, please try again.", duration: 2, position: CSToastPositionCenter)
                    //SVProgressHUD.dismiss()
                self.loadinglabelfortab.text="Could not connect to server."
            }
            else
            {
                let responseDict = response.value(forKey: "TBEventListTypeResult")as! NSDictionary
                let letGetMessage = (responseDict.value(forKey: "message"))as! String
                let letGetStatus = (responseDict.value(forKey: "status"))as! String
                ////print(letGetMessage)
                ////print(letGetStatus)
                
                if(letGetStatus == "0" && letGetMessage == "success")
                {
                    self.viewBirthDay.isHidden=false
                    self.isBirthdayTabFirstTime=false
                    self.arrayResponse = (responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Events")as! NSArray
                    
   for i in 00..<self.arrayResponse.count
   {
       let eventDate = (self.arrayResponse.object(at: i) as! NSDictionary).value(forKey: "eventDate")as? String
       let title =  (self.arrayResponse.object(at: i) as! NSDictionary).value(forKey: "title")as? String
       let ContactNumber =  (self.arrayResponse.object(at: i) as! NSDictionary).value(forKey: "ContactNumber")as? String
       let EmailId =  (self.arrayResponse.object(at: i) as! NSDictionary).value(forKey: "EmailId")as? String
       
       
       let varGetEventDate:String!=eventDate
       var arrayString=varGetEventDate.components(separatedBy: " ")
       var arrayString2=arrayString[0].components(separatedBy: "-")
       let varGetFinalString:String!=arrayString2[1]+arrayString2[2]
       
       //get month in character by extension
       let getMonthInCharacter = commonClassFunction().functionForMonthWordWise(String(arrayString2[1]))
       
       ////print(varGetFinalString)
       ////print(title)
       ////print(eventDate)
       
       if(i==0)
       {
           self.lastDateValueForMAtching=""
           self.lastDateValueForMAtching=varGetFinalString
           
           let getTodatDate = commonClassFunction().functionForGetTodatDate()
           
           ////print(getTodatDate)
           ////print(varGetFinalString)
           
           if(getTodatDate==varGetFinalString)
           {
               self.lastDateValueForMAtching="Today's Birthdays"
           }
           else
           {
               
               self.lastDateValueForMAtching="Upcoming Birthdays"
               self.IsExistingUpcomingBirthday=1
           }
       }
       else
       {
           if(self.lastDateValueForMAtching==varGetFinalString)
           {
               self.lastDateValueForMAtching="repeating"
           }
           else
           {
               if(self.IsExistingUpcomingBirthday==0)
               {
                   self.lastDateValueForMAtching="Upcoming Birthdays"
                   self.IsExistingUpcomingBirthday=1
               }
               else
               {
                   self.lastDateValueForMAtching=varGetFinalString
                   
               }
           }
       }
       
       let muDict:NSMutableDictionary=NSMutableDictionary()
       
       if(self.lastDateValueForMAtching=="Today's Birthdays")
       {
           let strColorChanges =  self.functionForSetColorrelationship(self.lastDateValueForMAtching, stringName:"")
           
           
           muDict.setValue(strColorChanges, forKey: "eventDate")
       }
       else if( self.lastDateValueForMAtching=="Upcoming Birthdays")
       {
           let strColorChanges =  self.functionForSetColorrelationship(self.lastDateValueForMAtching, stringName: "\n\n"+arrayString2[2]+" "+getMonthInCharacter)
           
           
           muDict.setValue(strColorChanges, forKey: "eventDate")
       }
       else
       {
           let strColorChanges =  self.functionForSetColorrelationship1("\n"+arrayString2[2]+" "+getMonthInCharacter, stringName: "")
           
           muDict.setValue(strColorChanges, forKey: "eventDate")
       }
       //code for here need to get email id and mobile array
       
       
       let ContactNumberr = (self.arrayResponse.object(at: i) as! NSDictionary).value(forKey: "ContactNumber")as? String
       let EmailIdd = (self.arrayResponse.object(at: i) as! NSDictionary).value(forKey: "EmailId")as? String
       
       
       
       
       
       
       //-----
       var muarrayEmail:NSMutableArray = NSMutableArray()
       var muarrayEmailMemberName:NSMutableArray = NSMutableArray()
       let EmailIds = (self.arrayResponse.object(at: i) as! NSDictionary).value(forKey: "EmailIds")as! NSArray
       var muDictEmailInfo:NSMutableDictionary=NSMutableDictionary()
       
       for i in 00..<EmailIds.count
       {
           muDictEmailInfo=NSMutableDictionary()
           
           let getEmailId = (EmailIds.object(at: i) as AnyObject).value(forKey: "EmailId")
           let getMemberName = (EmailIds.object(at: i) as AnyObject).value(forKey: "MemberName")
           muDictEmailInfo.setValue(getEmailId, forKey: "Email")
           muDictEmailInfo.setValue(getMemberName, forKey: "Name")
           muarrayEmail.add(muDictEmailInfo)
       }
       //-----
       let MobileNo = (self.arrayResponse.object(at: i) as! NSDictionary).value(forKey: "MobileNo")as! NSArray
       var muarrayMobileNoContact:NSMutableArray = NSMutableArray()
       var muarrayMobileNoMemberName:NSMutableArray = NSMutableArray()
       let muDictMobileNoInfo:NSMutableDictionary=NSMutableDictionary()
       
       for i in 00..<MobileNo.count
       {
           
           ////print(MobileNo)
           
           muDictEmailInfo=NSMutableDictionary()
           
           
           let getMobileNo = (MobileNo.object(at: i) as AnyObject).value(forKey: "MobileNo")
           let getMemberName = (MobileNo.object(at: i) as AnyObject).value(forKey: "MemberName")
           muDictEmailInfo.setValue(getMemberName, forKey: "Name")
           muDictEmailInfo.setValue(getMobileNo, forKey: "Mobile")
           muarrayMobileNoContact.add(muDictEmailInfo)
       }
       ////print(muarrayMobileNoContact)
       
       
       muDict.setValue(title, forKey: "title")
       muDict.setValue(self.lastDateValueForMAtching, forKey: "compareDate")
       muDict.setValue(ContactNumber, forKey: "ContactNumber")
       muDict.setValue(EmailId, forKey: "EmailId")
       muDict.setValue(muarrayEmail, forKey: "arrayEmail")
       //muDict.setValue(muarrayEmailMemberName, forKey: "arrayEmailMemberName")
       muDict.setValue(muarrayMobileNoContact, forKey: "arrayMobile")
       self.muarrayHoldData.add(muDict)
       self.lastDateValueForMAtching=varGetFinalString
   }
   ////print(self.muarrayHoldData)
   if(self.muarrayHoldData.count<=0)
   {
       self.lblAnniversary.isHidden=true
       self.lblEvent.isHidden=true
       self.lblBday.isHidden=false
       self.lblBday.text="No Birthdays"
   }
   else
   {
       self.lblBday.isHidden=true
       self.lblBday.text=""
       self.lblAnniversary.isHidden=true
       self.lblEvent.isHidden=true
   }
   print("Birthdaya Load")
   self.tableviewBirthday.reloadData()
   self.tableviewBirthday.setNeedsLayout()
  // self.functionForAnnivNew()
   self.loadinglabelfortab.isHidden=true
   //functionForAEsdfventNewEvent()
                }
                else
                {
                 if (letGetStatus == "1" && letGetMessage=="failed")
                 {
                    self.loadinglabelfortab.text="Failed to load birthdays."
                 }
                }
                
            }
        })
    }
    
    //
    
    
    @IBOutlet weak var viewBirthDay: UIView!
    @IBOutlet weak var viewAnniversary: UIView!
    @IBOutlet weak var viewEvent: UIView!
    
    
    
    @IBOutlet weak var buttonBirthDay: UIButton!
    @IBOutlet weak var buttonAnniversary: UIButton!
    @IBOutlet weak var buttonEvent: UIButton!
    
    @IBAction func buttonBirthDayClickEvent(_ sender: AnyObject)
    {
        isBirthdayorAnniv="birthday"
        viewBirthDay.isHidden=true
        viewAnniversary.isHidden=true
        viewEvent.isHidden=true

        let lineView = UIView(frame: CGRect(x: 0, y: 37, width: buttonBirthDay.frame.size.width, height: 2))
        lineView.backgroundColor=UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        buttonBirthDay.addSubview(lineView)

        let lineView2 = UIView(frame: CGRect(x: 0, y: 37, width: buttonAnniversary.frame.size.width, height: 2))
        lineView2.backgroundColor=UIColor.white
        buttonAnniversary.addSubview(lineView2)

        let lineView3 = UIView(frame: CGRect(x: 0, y: 37, width: buttonEvent.frame.size.width, height: 2))
        lineView3.backgroundColor=UIColor.white
        buttonEvent.addSubview(lineView3)
        buttonBirthDay.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonAnniversary.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        buttonEvent.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        
        if isBirthdayTabFirstTime
        {
            loadinglabelfortab.isHidden=false
            loadinglabelfortab.text="Loading... Please Wait"
            
            let getTodayMonthYear = commonClassFunction().functionForGetTodatDayMonthYear()

            //2
            functionForGettingCalendarMonthWiseData(getTodayMonthYear)
        }
        else{
            self.viewBirthDay.isHidden=false
            if(self.muarrayHoldData.count<=0)
            {
               // tableviewBirthday.isHidden=true
                self.lblAnniversary.isHidden=true
                self.lblEvent.isHidden=true
                self.lblBday.isHidden=false
                self.lblBday.text="No Birthdays"
            }
            else
            {
                //tableviewBirthday.isHidden=false
                self.lblBday.isHidden=true
                self.lblBday.text=""
                self.lblAnniversary.isHidden=true
                self.lblEvent.isHidden=true
            }
        }
        
        
        
        
        
        
    }
    @IBAction func buttonAnniversaryClickEvent(_ sender: AnyObject)
    {
        isBirthdayorAnniv="anniv"
        viewBirthDay.isHidden=true
        viewAnniversary.isHidden=true
        viewEvent.isHidden=true

        
        let lineView = UIView(frame: CGRect(x: 0, y: 37, width: buttonBirthDay.frame.size.width, height: 2))
        lineView.backgroundColor=UIColor.white
        buttonBirthDay.addSubview(lineView)
        
        
        
        let lineView2 = UIView(frame: CGRect(x: 0, y: 37, width: buttonAnniversary.frame.size.width, height: 2))
        lineView2.backgroundColor=UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        buttonAnniversary.addSubview(lineView2)
        
        
        
        let lineView3 = UIView(frame: CGRect(x: 0, y: 37, width: buttonEvent.frame.size.width, height: 2))
        lineView3.backgroundColor=UIColor.white
        buttonEvent.addSubview(lineView3)
        
        
        
        
        buttonBirthDay.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        buttonAnniversary.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonEvent.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        
        
        if isAnniversaryTabFirstTime
        {
            loadinglabelfortab.isHidden=false
            loadinglabelfortab.text="Loading... Please Wait"

            self.functionForAnnivNew()
        }
        else
        {
            viewAnniversary.isHidden=false
            if(self.muarrayHoldDataNew.count>0)
            {
                
                self.lblAnniversary.isHidden=true
                self.lblAnniversary.text=""
                self.lblBday.isHidden=true
                self.lblEvent.isHidden=true
            }
            else
            {
                self.lblAnniversary.isHidden=false
                self.lblAnniversary.text="No Anniversaries"
                self.lblBday.isHidden=true
                self.lblEvent.isHidden=true
            }
        
        }
        
        
        
        
        
    }
    @IBAction func buttonEventClickEvent(_ sender: AnyObject)
    {
        let lineView = UIView(frame: CGRect(x: 0, y: 37, width: buttonBirthDay.frame.size.width, height: 2))
        lineView.backgroundColor=UIColor.white
        buttonBirthDay.addSubview(lineView)
        
        viewBirthDay.isHidden=true
        viewAnniversary.isHidden=true
        viewEvent.isHidden=true

        
        
        let lineView2 = UIView(frame: CGRect(x: 0, y: 37, width: buttonAnniversary.frame.size.width, height: 2))
        lineView2.backgroundColor=UIColor.white
        buttonAnniversary.addSubview(lineView2)
        
        
        
        let lineView3 = UIView(frame: CGRect(x: 0, y: 37, width: buttonEvent.frame.size.width, height: 2))
        lineView3.backgroundColor=UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        buttonEvent.addSubview(lineView3)

        buttonBirthDay.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        buttonAnniversary.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        buttonEvent.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)

       if isEventTabFirstTime
       {
        loadinglabelfortab.isHidden=false
        loadinglabelfortab.text="Loading... Please Wait"

        self.functionForAEventNewEvent()
       }
        else
        
       {
        viewEvent.isHidden=false
        if(self.muarrayHoldDataNewEvent.count>0)
        {
            self.lblEvent.isHidden=true
            self.lblEvent.text=""
            self.lblAnniversary.isHidden=true
            self.lblEvent.isHidden=true
        }
        else
        {
            self.lblAnniversary.isHidden=true
            self.lblBday.isHidden=true
            self.lblEvent.isHidden=false
            self.lblEvent.text="No Events"
        }

        }


        
        
    }
    
    @IBOutlet weak var tableviewBirthAnniv: UITableView!
    var getCountTableviewBirthAnniv:Int!=0
    var muarrayBAPopup:NSMutableArray=NSMutableArray()
    var muarrayBAPopupNew:NSMutableArray=NSMutableArray()
    
    var muarrayBACheckUncheckPopup:NSMutableArray=NSMutableArray()
    
    
    
    
    var IsEmailSMSCall:String!=""
    
    
    @IBOutlet weak var buttonOpacityPopup: UIButton!
    
    
    @IBAction func buttonOpacityPopupClickEvent(_ sender: AnyObject) {
        buttonOpacityPopup.isHidden=true
        //  tableviewBirthAnniv.hidden=true
        
        viewBirthAnnivPopupss.isHidden=true
        
    }
    
    
    @IBOutlet weak var labelChangeEmailCallSMS: UILabel!
    
    @IBOutlet weak var viewBirthAnnivPopupss: UIView!
    
    
    @IBOutlet weak var buttonCancelPopup: UIButton!
    
    @IBAction func buttonCancelPopupClickEvent(_ sender: AnyObject)
    {
        ////print("button cancel clicked !!!!!")
        buttonOpacityPopup.isHidden=true
        //tableviewBirthAnniv.hidden=true
        viewBirthAnnivPopupss.isHidden=true
         buttonOpacity.isHidden=true
    }
    
    /*
     @IBOutlet weak var labelEmailCallSMSPersonName: UILabel!
     @IBOutlet weak var labelEmailCallSMS: UILabel!
     
     
     @IBOutlet weak var buttonCall: UIButton!
     @IBOutlet weak var buttonSMS: UIButton!
     @IBOutlet weak var buttonEmail: UIButton!
     
     
     @IBOutlet weak var buttonCallMain: UIButton!
     @IBOutlet weak var buttonSMSMain: UIButton!
     @IBOutlet weak var buttonEmailMain: UIButton!
     */
    
    
    
    @IBAction func buttonSendClickEvent(_ sender: AnyObject)
    {
        
        
        if(isBirthdayorAnniv=="anniv")
        {
            if(IsEmailSMSCall=="email")
            {
                ////print("Email Id !!!!!!!!!")
                var stringArray:[String]=[]
                var IsExist:Int!=0
                
                ////print("this is value data from 2 part ")
                ////print(muarrayBAPopup)
                
                for i in 00..<muarrayBAPopup.count
                {
                    let varGetValue:String!=muarrayBACheckUncheckPopup.object(at: i) as! String
                    ////print(varGetValue)
                    if(varGetValue=="1")
                    {
                        ////print(muarrayBAPopup.object(at: i))
                        
                        let getValue:String!=(muarrayBAPopup.value(forKey: "Email") as AnyObject).object(at: i) as! String
                        stringArray.append(getValue)
                        IsExist=1
                    }
                }
                if(IsExist==0)
                {
                    self.viewBirthAnnivPopupss.makeToast("Please select email id", duration: 3, position: CSToastPositionCenter)
                }
                else
                {
                    buttonOpacityPopup.isHidden=true
                    buttonOpacity.isHidden=true

                    viewBirthAnnivPopupss.isHidden=true
                    MailAction(stringArray)
                    //  self.viewBirthAnnivPopupss.makeToast("success", duration: 3, position: CSToastPositionCenter)
                }
                ////print(stringArray)
            }
            else if(IsEmailSMSCall=="Message")
            {
                ////print("sms !!!!!!!!!")
                
                ////print("Email Id !!!!!!!!!")
                var stringArray:[String]=[]
                var IsExist:Int!=0
                ////print(muarrayBAPopupNew)
                for i in 00..<muarrayBAPopup.count
                {
                    let varGetValue:String!=muarrayBACheckUncheckPopup.object(at: i) as! String
                    if(varGetValue=="1")
                    {
                        ////print(muarrayBAPopup.object(at: i))
                        
                        let getValue:String!=(muarrayBAPopup.value(forKey: "Mobile") as AnyObject).object(at: i) as! String
                        stringArray.append(getValue)
                        IsExist=1
                    }
                }
                if(IsExist==0)
                {
                    self.viewBirthAnnivPopupss.makeToast("Please select any number", duration: 3, position: CSToastPositionCenter)
                }
                else
                {
                    buttonOpacityPopup.isHidden=true
                    buttonOpacity.isHidden=true

                    viewBirthAnnivPopupss.isHidden=true
                    SMSAction(stringArray)
                    // self.viewBirthAnnivPopupss.makeToast("success", duration: 3, position: CSToastPositionCenter)
                }
                ////print(stringArray)
            }
            
        }
        else {
            
            
            if(IsEmailSMSCall=="email")
            {
                ////print("Email Id !!!!!!!!!")
                var stringArray:[String]=[]
                var IsExist:Int!=0
                
                ////print("this is value data from ")
                ////print(muarrayBAPopup)
                for i in 00..<muarrayBAPopup.count
                {
                    let varGetValue:String!=muarrayBACheckUncheckPopup.object(at: i) as! String
                    ////print(varGetValue)
                    if(varGetValue=="1")
                    {
                        ////print(muarrayBAPopup.object(at: i))
                        
                        let getValue:String!=(muarrayBAPopup.value(forKey: "Email") as AnyObject).object(at: i) as! String
                        stringArray.append(getValue)
                        IsExist=1
                    }
                }
                if(IsExist==0)
                {
                    self.viewBirthAnnivPopupss.makeToast("Please select email id", duration: 3, position: CSToastPositionCenter)
                }
                else
                {
                    buttonOpacityPopup.isHidden=true
                    buttonOpacity.isHidden=true

                    viewBirthAnnivPopupss.isHidden=true
                    MailAction(stringArray)
                    //  self.viewBirthAnnivPopupss.makeToast("success", duration: 3, position: CSToastPositionCenter)
                }
                ////print(stringArray)
            }
            else if(IsEmailSMSCall=="Message")
            {
                ////print("sms !!!!!!!!!")
                
                ////print("Email Id !!!!!!!!!")
                var stringArray:[String]=[]
                var IsExist:Int!=0
                for i in 00..<muarrayBAPopup.count
                {
                    let varGetValue:String!=muarrayBACheckUncheckPopup.object(at: i) as? String
                    if(varGetValue=="1")
                    {
                        ////print(muarrayBAPopup.object(at: i))
                        
                        let getValue:String!=(muarrayBAPopup.value(forKey: "Mobile") as AnyObject).object(at: i) as? String
                        stringArray.append(getValue)
                        IsExist=1
                    }
                }
                if(IsExist==0)
                {
                    self.viewBirthAnnivPopupss.makeToast("Please select any number", duration: 3, position: CSToastPositionCenter)
                }
                else
                {
                    buttonOpacityPopup.isHidden=true
                    buttonOpacity.isHidden=true

                    viewBirthAnnivPopupss.isHidden=true
                    SMSAction(stringArray)
                    // self.viewBirthAnnivPopupss.makeToast("success", duration: 3, position: CSToastPositionCenter)
                }
                ////print(stringArray)
            }
            
        }
    }
    
    @IBOutlet weak var buttonSend: UIButton!
    
    //sms
    
    func SMSAction(_ stringArray:[String])
    {
        ////print("SMS sent")
        let messageVC = MFMessageComposeViewController()
        messageVC.body = ""
        messageVC.recipients = stringArray // Optionally add some tel numbers
        messageVC.messageComposeDelegate = self
        // Open the SMS View controller
        present(messageVC, animated: true, completion: nil)
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        controller.dismiss(animated: true, completion: nil)
    }
    func MailAction(_ stringArray:[String])
    {
        
//        if MFMailComposeViewController.canSendMail() {
//              let mailComposer = MFMailComposeViewController()
//              mailComposer.mailComposeDelegate = self
//              mailComposer.setToRecipients(stringArray)
//              mailComposer.setSubject("")
//              mailComposer.setMessageBody("", isHTML: true)
//              present(mailComposer, animated: true)
//          } else {
//              print("Email is not set up on this device.")
//              // Optionally show an alert
//          }
        
        if MFMailComposeViewController.canSendMail()
        {
            ////print(stringArray)
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(stringArray)// gg@hing.co.in
            mail.setMessageBody("", isHTML: true)
            present(mail, animated: true, completion: nil)
        }
        else
        {
            if stringArray.count > 0 {
                sendEmailFallback(mail: stringArray[0])
            }
        }
    }
    
    func sendEmailFallback(mail: String) {
        let recipientEmail = mail // Replace with the recipient email address
        
        let emailURLString = "mailto:\(recipientEmail)"
        if let emailURL = URL(string: emailURLString) {
            if UIApplication.shared.canOpenURL(emailURL) {
                UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
            } else {
                // Provide an alert indicating that email sending is not available
                let alert = UIAlertController(title: "Error", message: "Email sending is not available on this device.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true, completion: nil)
    }
    /*------------rajendra jat code for anniversery*/
    
    
    @IBOutlet weak var tableviewAnnivNew: UITableView!
    
    var arrayResponseNew=NSArray()
    var lastDateValueForMAtchingNew:String!=""
    var IsExistingUpcomingBirthdayNew:Int!=0
    var muarrayHoldDataNew:NSMutableArray=NSMutableArray()
    
    
    
    var isBirthdayorAnniv:String!=""
    
    func functionForAnnivNew()
    {
        
        
        let getProfileId =  UserDefaults.standard.value(forKey: "user_auth_token_profileId")
        let getGroupId =  UserDefaults.standard.value(forKey: "user_auth_token_groupId")
        ////print(getProfileId)
        ////print(getProfileId)
        
        
        let getTodayMonthYear = commonClassFunction().functionForGetTodatDayMonthYear()
        ////print(getTodayMonthYear)
        
        
        
        let completeURL = baseUrl+rowCelebreationBirthDayAnniversaryEvent
        var parameterst:NSDictionary=NSDictionary()
        //isCategory="1"
        if(isCategory=="1")
        {
             ////print("------------------------------------------------888888888")
            
            if isfromBanner == "yes" {
                parameterst =
                    [
                        "profileId" : "0",
                        "groupId" : getGroupId!,
                        "SelectedDate":getTodayMonthYear,
                        //"SelectedDate":"2018-02-01",
                        "Type" :"A",
                        "groupCategory":"1"
                ]
            }
            else{
                parameterst =
                    [
                        "profileId" : getProfileId!,
                        "groupId" : getGroupId!,
                        "SelectedDate":getTodayMonthYear,
                        //"SelectedDate":"2018-02-01",
                        "Type" :"A",
                        "groupCategory":"1"
                ]
            }
           
        }
        else if(isCategory=="2")
        {
             ////print("))))))))))))))))))))))))))))))))))")
            if isfromBanner == "yes" {
                parameterst =
                    [
                        "profileId" : 0,
                        "groupId" : getGroupId!,
                        "SelectedDate":getTodayMonthYear,
                        //"SelectedDate":"2018-02-01",
                        "Type" :"A",
                        "groupCategory":"2"
                ]
            }
            else{
                parameterst =
                    [
                        "profileId" : getProfileId!,
                        "groupId" : getGroupId!,
                        "SelectedDate":getTodayMonthYear,
                        //"SelectedDate":"2018-02-01",
                        "Type" :"A",
                        "groupCategory":"2"
                ]
            }
          
        }
          ////print("This is Anniversary of the User :--------")
        print("completeURL -3- on \(Date()) :\(completeURL)")
        print("parameterst -3- on \(Date()): \(parameterst)")

        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
          print("Response of -3- on \(Date())")
            /*
             ContactNumber = "<null>";
             Description = "Deep ";
             EmailId = "<null>";
             EventTime = "02 : 02 PM";
             eventDate = "2018-02-14 14:40:00";
             title = Santo;
             */
            
            
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Could not connect to server.", duration: 2, position: CSToastPositionCenter)
                //SVProgressHUD.dismiss()
                self.loadinglabelfortab.text="Could not connect to server."
            }
            else
            {
                self.viewAnniversary.isHidden=false
                self.isAnniversaryTabFirstTime=false
                
                let responseDict = response.value(forKey: "TBEventListTypeResult")as! NSDictionary
                let letGetMessage = (responseDict.value(forKey: "message"))as! String
                let letGetStatus = (responseDict.value(forKey: "status"))as! String
                
                if(letGetStatus == "0" && letGetMessage == "success")
                {
                    self.arrayResponseNew = (responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Events")as! NSArray
                    
                    for i in 00..<self.arrayResponseNew.count
                    {
                        let eventDate = (self.arrayResponseNew.object(at: i) as! NSDictionary).value(forKey: "eventDate")as? String
                        let title =  (self.arrayResponseNew.object(at: i) as! NSDictionary).value(forKey: "title")as? String
                        let ContactNumber =  (self.arrayResponseNew.object(at: i) as! NSDictionary).value(forKey: "ContactNumber")as? String
                        let EmailId =  (self.arrayResponseNew.object(at: i) as! NSDictionary).value(forKey: "EmailId")as? String
                        
                        
                        let varGetEventDateNew:String!=eventDate
                        var arrayString=varGetEventDateNew.components(separatedBy: " ")
                        var arrayString2=arrayString[0].components(separatedBy: "-")
                        let varGetFinalString:String!=arrayString2[1]+arrayString2[2]
                        
                        //get month in character by extension
                        let getMonthInCharacter = commonClassFunction().functionForMonthWordWise(String(arrayString2[1]))
                        
                        ////print(varGetFinalString)
                        ////print(title)
                        ////print(eventDate)
                        
                        if(i==0)
                        {
                            self.lastDateValueForMAtchingNew=""
                            self.lastDateValueForMAtchingNew=varGetFinalString
                            
                            let getTodatDate = commonClassFunction().functionForGetTodatDate()
                            
                            ////print(getTodatDate)
                            ////print(varGetFinalString)
                            
                            if(getTodatDate==varGetFinalString)
                            {
                                //self.lastDateValueForMAtchingNew="Today's Anniversary" //23-05-2018 Comment by DPK
                                self.lastDateValueForMAtchingNew="Today's Anniversaries"
                            }
                            else
                            {
                                //self.lastDateValueForMAtchingNew="Upcoming Anniversary" //23-05-2018 Comment by DPK
                                self.lastDateValueForMAtchingNew="Upcoming Anniversaries"
                                self.IsExistingUpcomingBirthdayNew=1
                            }
                        }
                        else
                        {
                            if(self.lastDateValueForMAtchingNew==varGetFinalString)
                            {
                                self.lastDateValueForMAtchingNew="repeating"
                            }
                            else
                            {
                                if(self.IsExistingUpcomingBirthdayNew==0)
                                {
                                    self.lastDateValueForMAtchingNew="Upcoming Anniversaries"
                                    self.IsExistingUpcomingBirthdayNew=1
                                }
                                else
                                {
                                    self.lastDateValueForMAtchingNew=varGetFinalString
                                    
                                }
                            }
                        }
                        
                        let muDict:NSMutableDictionary=NSMutableDictionary()
                        
                        if(self.lastDateValueForMAtchingNew=="Today's Anniversaries" )
                        {
                            
                            
                            let strColorChanges =  self.functionForSetColorrelationship(self.lastDateValueForMAtchingNew, stringName: "")
                            
                            //muDict.setValue(self.lastDateValueForMAtchingNew+"\n"+arrayString2[2]+" "+getMonthInCharacter, forKey: "eventDate")
                            
                            muDict.setValue(strColorChanges, forKey: "eventDate")
                        }
                        else if(self.lastDateValueForMAtchingNew=="Upcoming Anniversaries")
                        {
                            
                            
                            let strColorChanges =  self.functionForSetColorrelationship(self.lastDateValueForMAtchingNew, stringName: "\n\n"+arrayString2[2]+" "+getMonthInCharacter)
                            
                            //muDict.setValue(self.lastDateValueForMAtchingNew+"\n"+arrayString2[2]+" "+getMonthInCharacter, forKey: "eventDate")
                            
                            muDict.setValue(strColorChanges, forKey: "eventDate")
                        }
                        else
                        {
                            let strColorChanges =  self.functionForSetColorrelationship1("\n"+arrayString2[2]+" "+getMonthInCharacter, stringName: "")
                            
                            muDict.setValue(strColorChanges, forKey: "eventDate")
                            
                            //muDict.setValue(arrayString2[2]+" "+getMonthInCharacter, forKey: "eventDate")
                        }
                        //code for here need to get email id and mobile array
                        
                        
                        let ContactNumberr = (self.arrayResponseNew.object(at: i) as! NSDictionary).value(forKey: "ContactNumber")as? String
                        let EmailIdd = (self.arrayResponseNew.object(at: i) as! NSDictionary).value(forKey: "EmailId")as? String
                        
                        
                        
                        
                        
                        
                        //-----
                        var muarrayEmail:NSMutableArray = NSMutableArray()
                        var muarrayEmailMemberName:NSMutableArray = NSMutableArray()
                        let EmailIds = (self.arrayResponseNew.object(at: i) as! NSDictionary).value(forKey: "EmailIds")as! NSArray
                        var muDictEmailInfo:NSMutableDictionary=NSMutableDictionary()
                        
                        for j in 00..<EmailIds.count
                        {
                            /*
                             EmailIds =                     (
                             {
                             EmailId = "madhavi.patil@kaizeninfotech.com";
                             MemberName = MADHAVI;
                             }j
                             */
                            
                            let getEmailId = (EmailIds.object(at: j) as AnyObject).value(forKey: "EmailId")
                            let getMemberName = (EmailIds.object(at: j) as AnyObject).value(forKey: "MemberName")
                            
                            
                            //muDictEmailInfo.setValue(getEmailId, forKey: "Email")
                            //muDictEmailInfo.setValue(getMemberName, forKey: "Name")
                            
                            muDictEmailInfo = ["Email":getEmailId!,"Name":getMemberName!]
                            
                            
                            muarrayEmail.add(muDictEmailInfo)
                            // muarrayEmailMemberName.addObject(getMemberName!)
                            
                            
                            
                            
                        }
                        //-----
                        let MobileNo = (self.arrayResponseNew.object(at: i) as! NSDictionary).value(forKey: "MobileNo")as! NSArray
                        let muarrayMobileNoContact:NSMutableArray = NSMutableArray()
                        var muarrayMobileNoMemberName:NSMutableArray = NSMutableArray()
                        var muDictMobileNoInfo:NSMutableDictionary=NSMutableDictionary()
                        
                        for i in 00..<MobileNo.count
                        {
                            /*
                             MobileNo =                     (
                             {
                             MemberName = "PRAVIN PAWAR";
                             MobileNo = 8978968968;
                             }
                             */
                            let getMobileNo = (MobileNo.object(at: i) as AnyObject).value(forKey: "MobileNo")
                            let getMemberName = (MobileNo.object(at: i) as AnyObject).value(forKey: "MemberName")
                            
                            //muDictMobileNoInfo.setValue(getMemberName, forKey: "Name")
                            //muDictMobileNoInfo.setValue(getMobileNo, forKey: "Mobile")
                            
                            muDictMobileNoInfo = ["Name":getMemberName!,"Mobile":getMobileNo!]
                            
                            ////print(muDictMobileNoInfo)
                            
                            muarrayMobileNoContact.add(muDictMobileNoInfo)
                            // muarrayMobileNoMemberName.addObject(getMemberName!)
                            
                            ////print(muarrayMobileNoContact)
                            
                            
                            
                            
                        }
                        
                        ////print(muarrayMobileNoContact)
                        
                        
                        muDict.setValue(title, forKey: "title")
                        muDict.setValue(self.lastDateValueForMAtchingNew, forKey: "compareDate")
                        muDict.setValue(ContactNumber, forKey: "ContactNumber")
                        muDict.setValue(EmailId, forKey: "EmailId")
                        muDict.setValue(muarrayEmail, forKey: "arrayEmail")
                        //muDict.setValue(muarrayEmailMemberName, forKey: "arrayEmailMemberName")
                        muDict.setValue(muarrayMobileNoContact, forKey: "arrayMobile")
                        // muDict.setValue(muarrayMobileNoMemberName, forKey: "arrayMobileMemberName")
                        
                        
                        
                        
                        
                        ////print("Count  EmailIds !!!!!!!")
                        ////print(EmailIds.count)
                        
                        ////print("Count  MobileNo !!!!!!!")
                        ////print(MobileNo.count)
                        
                        ////print(muarrayMobileNoContact)
                        self.muarrayHoldDataNew.add(muDict)
                        ////print(muDict)
                        ////print(self.muarrayHoldDataNew)
                        
                        self.lastDateValueForMAtchingNew=varGetFinalString
                    }
                    ////print(self.muarrayHoldDataNew)
                    
                    if(self.muarrayHoldDataNew.count<=0 )
                    {
                        
                        // self.lblBday.hidden=true
                        // self.lblEvent.hidden=true
                        self.lblAnniversary.isHidden=false
                        self.lblAnniversary.text="No Anniversaries"
                    }
                    else
                    {
                        
                        //  self.lblBday.hidden=true
                        // self.lblEvent.hidden=true
                        self.lblAnniversary.isHidden=true
                        self.lblAnniversary.text=""
                    }
                    self.tableviewAnnivNew.reloadData()
                    //self.loadinglabelfortab.isHidden=false
                    self.loadinglabelfortab.isHidden=true
                    // self.tableviewBirthday.setNeedsLayout()
                    //self.functionForAEventNewEvent()
                }
                else
                {
                    if (letGetStatus == "1" && letGetMessage=="failed")
                    {
                       self.loadinglabelfortab.text="Failed to load birthdays."
                    }
                }
                
            }
        })
    }
    /*----------------------------------------rajendra jat code for event--------------------------------------*/
    func functionForAEventNewEvent()
    {
        
        let getProfileId =  UserDefaults.standard.value(forKey: "user_auth_token_profileId")
        let getGroupId =  UserDefaults.standard.value(forKey: "user_auth_token_groupId")
        ////print(getProfileId)
        ////print(getProfileId)
        
        
        let getTodayMonthYear = commonClassFunction().functionForGetTodatDayMonthYear()
        ////print(getTodayMonthYear)
        
        
        
        let completeURL = baseUrl+rowCelebreationBirthDayAnniversaryEvent
        var parameterst:NSDictionary=NSDictionary()
        //isCategory="1"
        if(isCategory=="1")
        {
             ////print("............................................")
            
            if isfromBanner == "yes" {
                parameterst =
                    [
                        "profileId" : 0,
                        "groupId" : getGroupId!,
                        "SelectedDate":getTodayMonthYear,
                        //"SelectedDate":"2018-02-01",
                        "Type" :"E",
                        "groupCategory":"1"
                ]
            }
            
            else{
                parameterst =
                    [
                        "profileId" : getProfileId!,
                        "groupId" : getGroupId!,
                        "SelectedDate":getTodayMonthYear,
                        //"SelectedDate":"2018-02-01",
                        "Type" :"E",
                        "groupCategory":"1"
                ]
            }
          
        }
        else if(isCategory=="2")
        {
            ////print(".0.0.0.0.0.0.000000...........0.0.0.0.0.0.0.0.0.0")
            
            if isfromBanner == "yes" {
                parameterst =
                    [
                        "profileId" : 0,
                        "groupId" : getGroupId!,
                        "SelectedDate":getTodayMonthYear,
                        //"SelectedDate":"2018-02-01",
                        "Type" :"E",
                        "groupCategory":"2"
                ]
            }
            else{
                parameterst =
                    [
                        "profileId" : getProfileId!,
                        "groupId" : getGroupId!,
                        "SelectedDate":getTodayMonthYear,
                        //"SelectedDate":"2018-02-01",
                        "Type" :"E",
                        "groupCategory":"2"
                ]
            }
            
          
        }
        
        ////print("This is Event of the User :--------")
        print("completeURL -4- on \(Date()):\(completeURL)")
        print("parameterst -4- on \(Date()): \(parameterst)")
        
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print("Response of -4- on \(Date())")
            /*
             ContactNumber = "<null>";
             Description = "Deep ";
             EmailId = "<null>";
             EventTime = "02 : 02 PM";
             eventDate = "2018-02-14 14:40:00";
             title = Santo;
             */
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Could not connect to server.", duration: 2, position: CSToastPositionCenter)
               // SVProgressHUD.dismiss()
                self.loadinglabelfortab.text="Could not connect to server."
            }
            else
            {
                self.viewEvent.isHidden=false
                self.isEventTabFirstTime=false
                
                let responseDict = response.value(forKey: "TBEventListTypeResult")as! NSDictionary
                //print("Calender Event List :: \(responseDict)")
                let letGetMessage = (responseDict.value(forKey: "message"))as! String
                let letGetStatus = (responseDict.value(forKey: "status"))as! String
                ////print(letGetMessage)
                ////print(letGetStatus)
                
                if(letGetStatus == "0" && letGetMessage == "success")
                {
                    self.arrayResponseNewEvent = (responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Events")as! NSArray
                    
                    for i in 00..<self.arrayResponseNewEvent.count
                    {
                        let eventDate = (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "eventDate")as? String
                        let title =  (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "title")as? String
                        let ContactNumber =  (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "ContactNumber")as? String
                        let EmailId =  (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "EmailId")as? String
                        
                        
                        
                        let Description = (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "Description")as? String
                        let EmailIds = (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "EmailIds")as? String
                        let EventTime = (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "EventTime")as? String
                        let MemberID = (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "MemberID")as? String
                        let MobileNo = (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "MobileNo")as? String
                        let eventImg = (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "eventImg")as? String
                        let type = (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "type")as? String
                        let GroupIdNew = (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "GroupId")as? String

                        //print("GROUPID FROM GET EVENT \(GroupIdNew)")
                        
                        
                        
                        
                        
                        
                        let varGetEventDateNew:String!=eventDate
                        var arrayString=varGetEventDateNew.components(separatedBy: " ")
                        var arrayString2=arrayString[0].components(separatedBy: "-")
                        let varGetFinalString:String!=arrayString2[1]+arrayString2[2]
                        
                        
                        //get month in character by extension
                        let getMonthInCharacter = commonClassFunction().functionForMonthWordWise(String(arrayString2[1]))
                        
                        ////print(varGetFinalString)
                        ////print(title)
                        ////print(eventDate)
                        
                        if(i==0)
                        {
                            self.lastDateValueForMAtchingNewEvent=""
                            self.lastDateValueForMAtchingNewEvent=varGetFinalString
                            
                            let getTodatDate = commonClassFunction().functionForGetTodatDate()
                            
                            ////print(getTodatDate)
                            ////print(varGetFinalString)
                            
                            if(getTodatDate==varGetFinalString)
                            {
                                self.lastDateValueForMAtchingNewEvent="Today's Events"
                            }
                            else
                            {
                                self.lastDateValueForMAtchingNewEvent="Upcoming Events"
                                self.IsExistingUpcomingBirthdayNewEvent=1
                            }
                        }
                        else
                        {
                            if(self.lastDateValueForMAtchingNewEvent==varGetFinalString)
                            {
                                self.lastDateValueForMAtchingNewEvent="repeating"
                            }
                            else
                            {
                                if(self.IsExistingUpcomingBirthdayNewEvent==0)
                                {
                                    self.lastDateValueForMAtchingNewEvent="Upcoming Events"
                                    self.IsExistingUpcomingBirthdayNewEvent=1
                                }
                                else
                                {
                                    self.lastDateValueForMAtchingNewEvent=varGetFinalString
                                    
                                }
                            }
                        }
                        
                        let muDict:NSMutableDictionary=NSMutableDictionary()
                        if(self.lastDateValueForMAtchingNewEvent=="Today's Events" )
                        {
                            let strColorChanges =  self.functionForSetColorrelationship(self.lastDateValueForMAtchingNewEvent, stringName: "")
                            
                            muDict.setValue(strColorChanges, forKey: "eventDate")
                            
                            //muDict.setValue(self.lastDateValueForMAtchingNewEvent+"\n"+arrayString2[2]+" "+getMonthInCharacter, forKey: "eventDate")
                        }
                        else if( self.lastDateValueForMAtchingNewEvent=="Upcoming Events")
                        {
                            let strColorChanges =  self.functionForSetColorrelationship(self.lastDateValueForMAtchingNewEvent, stringName: "\n\n"+arrayString2[2]+" "+getMonthInCharacter)
                            
                            muDict.setValue(strColorChanges, forKey: "eventDate")
                            
                            //muDict.setValue(self.lastDateValueForMAtchingNewEvent+"\n"+arrayString2[2]+" "+getMonthInCharacter, forKey: "eventDate")
                        }
                        else
                        {
                            let strColorChanges =  self.functionForSetColorrelationship1("\n"+arrayString2[2]+" "+getMonthInCharacter, stringName: "")
                            
                            muDict.setValue(strColorChanges, forKey: "eventDate")
                            
                            //muDict.setValue(arrayString2[2]+" "+getMonthInCharacter, forKey: "eventDate")
                        }
                        //code for here need to get email id and mobile array
                        
                        muDict.setValue(title, forKey: "title")
                        muDict.setValue(self.lastDateValueForMAtchingNewEvent, forKey: "compareDate")
                        muDict.setValue(ContactNumber, forKey: "ContactNumber")
                        muDict.setValue(EmailId, forKey: "EmailId")
                        
                        muDict.setValue(Description, forKey: "Description")
                        muDict.setValue(EmailIds, forKey: "EmailIds")
                        muDict.setValue(EventTime, forKey: "EventTime")
                        muDict.setValue(MemberID, forKey: "MemberID")
                        muDict.setValue(MobileNo, forKey: "MobileNo")
                        muDict.setValue(eventImg, forKey: "eventImg")
                        muDict.setValue(type, forKey: "type")
                        muDict.setValue(GroupIdNew, forKey: "GroupIdNew")

                        self.muarrayHoldDataNewEvent.add(muDict)
                        self.lastDateValueForMAtchingNewEvent=varGetFinalString
                    }
                    
                    
                    if(self.muarrayHoldDataNewEvent.count<=0)
                    {
                        //  self.lblAnniversary.hidden=true
                        // self.lblBday.hidden=true
                        self.lblEvent.isHidden=false
                        self.lblEvent.text="No Events"
                    }
                    else
                    {
                        // self.lblBday.hidden=true
                        // self.lblAnniversary.hidden=true
                        
                        self.lblEvent.isHidden=true
                        self.lblEvent.text=""
                    }
                    //self.loaderClass.window = nil
                    self.tableviewEventEventEvent.reloadData()
                    // self.tableviewBirthday.setNeedsLayout()
                    self.loadinglabelfortab.isHidden=true
                }
                else
                {
                    if (letGetStatus == "1" && letGetMessage=="failed")
                    {
                       self.loadinglabelfortab.text="Failed to load birthdays."
                    }
                }
            }
        })
    }
    
    var arrayResponseNewEvent=NSArray()
    var lastDateValueForMAtchingNewEvent:String!=""
    var IsExistingUpcomingBirthdayNewEvent:Int!=0
    var muarrayHoldDataNewEvent:NSMutableArray=NSMutableArray()
    
    
    
    @IBOutlet weak var tableviewEventEventEvent: UITableView!
    
    /////////--------------------------------------code for get detail of a particular date on month view
    func functionforGetSelectedDateDetail(_ stringYMD:String!)
        
    {
        self.viewEventNew.isHidden=true
        self.loadinglabelformonth.isHidden=false
        self.loadinglabelformonth.text="Loading... Please Wait"
        self.labelNoBAEfoundinMonthView.isHidden=true
        muarrayHoldDateWiseData=NSMutableArray()
        let getProfileId =  UserDefaults.standard.value(forKey: "user_auth_token_profileId")
        let getGroupId =  UserDefaults.standard.value(forKey: "user_auth_token_groupId")
        let getTodayMonthYear = commonClassFunction().functionForGetTodatDayMonthYear()
        let completeURL = baseUrl+rowCelebreationDatewiseData
        var parameterst:NSDictionary=NSDictionary()
        //isCategory="1"
        if(isCategory=="1")
        {
            ////print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
         
            if isfromBanner == "yes" {
                parameterst =
                    [
//                        "profileId" : getProfileId!,
                        "groupId" : getGroupId!,
                        "SelectedDate":stringYMD,
                        //"SelectedDate":"2018-03-06",
                        "GroupCategory":"1",
                        "ProfileID":0
                ]
            }
            else{
                parameterst =
                    [
                        "profileId" : getProfileId!,
                        "groupId" : getGroupId!,
                        "SelectedDate":stringYMD,
                        //"SelectedDate":"2018-03-06",
                        "GroupCategory":"1"
//                        "ProfileID":0
                ]
            }
            
          
        }
        else if(isCategory=="2")
        {
             ////print("@@=========================@@@@@@")
            
            if isfromBanner == "yes" {
                parameterst =
                    [
                        //"profileId" : getProfileId!,
                        "groupId" : getGroupId!,
                        "SelectedDate":stringYMD,
                        //"SelectedDate":"2018-03-06",
                        "GroupCategory":"2",
                        "ProfileID":0
                        
                ]
            }
            
            else{
                parameterst =
                    [
                        //"profileId" : getProfileId!,
                        "groupId" : getGroupId!,
                        "SelectedDate":stringYMD,
                        //"SelectedDate":"2018-03-06",
                        "GroupCategory":"2",
                        "ProfileID":getProfileId!
                        
                ]
            }
           
        }
        print("parameters -5- on \(Date()) : \(parameterst)")
        print("completeURL -5- on \(Date()) : \(completeURL)")
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print("Response of -5- on \(Date())")
            ////print("this is dropdown valu for filter ")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Could not connect to server, please try again.", duration: 2, position: CSToastPositionCenter)
                //SVProgressHUD.dismiss()
                self.loadinglabelformonth.text="Could not connect to server."

            }
            else
            {
                let responseDict = response.value(forKey: "TBEventListDtlsResult")as! NSDictionary
                let letGetMessage = (responseDict.value(forKey: "message"))as! String
                let letGetStatus = (responseDict.value(forKey: "status"))as! String
                ////print(letGetMessage)
                ////print(letGetStatus)
                
                if(letGetStatus == "0" && letGetMessage == "success")
                {
                    self.arrayResponseNewEvent = (responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Events")as! NSArray
                   // print("DATE WISE EVENTS LIST \(self.arrayResponseNewEvent)")
                    var varGetType:String!=""
                    var varGetTypeForCheck:String!=""
                    
                    for i in 00..<self.arrayResponseNewEvent.count
                    {
   let ContactNumber = (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "ContactNumber")as? String
   let type =  (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "type")as! String
   
   if(varGetType=="")
   {
       ////print("11111")
       varGetType=type
       varGetTypeForCheck=type
   }
   else if(varGetType==type)
   {
       ////print("2222")
       varGetType=type
       varGetTypeForCheck="repeat"
   }
       // else if(varGetType !==type)
   else
   {
       ////print("333333")
       varGetType=type
       varGetTypeForCheck=type
   }
   
   ////print(varGetType)
   let title =  (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "title")as? String
   let eventImg =  (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "eventImg")as? String
   let eventDate =  (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "eventDate")as? String
   let MemberID =  (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "MemberID")as? String
   let EmailId =  (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "EmailId")as? String
   let EventTime =  (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "EventTime")as? String
   let Description =  (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "Description")as? String
   let MemberProfileId =  (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "MemberProfileId")as? String
   let GroupIdNew=(self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "GroupId") as? String
   
   
   //-----
   var muarrayEmail:NSMutableArray = NSMutableArray()
   var muarrayEmailMemberName:NSMutableArray = NSMutableArray()
   
   var muarrayMobileNoContact:NSMutableArray = NSMutableArray()
   
   
   ////print(type)
   ////print(title)
   if(type=="Event")
   {
       //Event as discussed with madhavi if no data then will come null from backend side
   }
   else
   {
       var EmailIds = (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "EmailIds") as! NSArray
       var muDictEmailInfo:NSMutableDictionary=NSMutableDictionary()
       ////print(EmailIds)
       
       for i in 00..<EmailIds.count
       {
           let getEmailId = (EmailIds.object(at: i) as AnyObject).value(forKey: "EmailId")
           let getMemberName = (EmailIds.object(at: i) as AnyObject).value(forKey: "MemberName")
           muDictEmailInfo=NSMutableDictionary()
           muDictEmailInfo.setValue(getEmailId, forKey: "Email")
           muDictEmailInfo.setValue(getMemberName, forKey: "Name")
           muarrayEmail.add(muDictEmailInfo)
       }
       ////print(muarrayEmail)
       
       //-----
       let MobileNo = (self.arrayResponseNewEvent.object(at: i) as! NSDictionary).value(forKey: "MobileNo")as! NSArray
       var muarrayMobileNoMemberName:NSMutableArray = NSMutableArray()
       let muDictMobileNoInfo:NSMutableDictionary=NSMutableDictionary()
       
       for i in 00..<MobileNo.count
       {
           let getMobileNo = (MobileNo.object(at: i) as AnyObject).value(forKey: "MobileNo")
           let getMemberName = (MobileNo.object(at: i) as AnyObject).value(forKey: "MemberName")
           muDictEmailInfo=NSMutableDictionary()
           muDictEmailInfo.setValue(getMemberName, forKey: "Name")
           muDictEmailInfo.setValue(getMobileNo, forKey: "Mobile")
           muarrayMobileNoContact.add(muDictEmailInfo)
       }
   }
   
   
   
   
   
   let muDict:NSMutableDictionary=NSMutableDictionary()
   
   muDict.setValue(ContactNumber, forKey: "ContactNumber")
   muDict.setValue(type, forKey: "type")
   muDict.setValue(varGetTypeForCheck, forKey: "typeCheck")
   
   muDict.setValue(title, forKey: "title")
   muDict.setValue(eventImg, forKey: "eventImg")
   muDict.setValue(eventDate, forKey: "eventDate")
   muDict.setValue(MemberID, forKey: "MemberID")
   muDict.setValue(EmailId, forKey: "EmailId")
   muDict.setValue(EventTime, forKey: "EventTime")
   muDict.setValue(Description, forKey: "Description")
   muDict.setValue(muarrayEmail, forKey: "muarrayEmail")
   muDict.setValue(muarrayMobileNoContact, forKey: "muarrayMobileNoContact")
   muDict.setValue(MemberProfileId, forKey: "MemberProfileId")
   muDict.setValue(GroupIdNew, forKey: "GroupIdNew")
   
   
   self.muarrayHoldDateWiseData.add(muDict)
    }
    self.tableviewEventAnnivBirthDay.reloadData()
    
    if(self.arrayResponseNewEvent.count>0)
    {
        self.labelNoBAEfoundinMonthView.isHidden=true
        self.labelNoBAEfoundinMonthView.text=""
    }
    else
    {
        self.labelNoBAEfoundinMonthView.isHidden=false
        self.labelNoBAEfoundinMonthView.text="No Birthday, Anniversary and Event"
                    }
                    self.viewEventNew.isHidden=false
                    self.loadinglabelformonth.isHidden=true
                }
                else
                {
                    self.viewEventNew.isHidden=true
                    self.loadinglabelformonth.isHidden=true
                }
            }
        })
    }
    
    var muarrayHoldDateWiseData:NSMutableArray=NSMutableArray()
    
    func functionForSetColorrelationship1(_ stringKey:String,stringName:String)->NSAttributedString
    {
        let text = "I agree with TERMS and CONDITION"
        let linkTextWithColor = "CONDITION"
        let range = (text as NSString).range(of: linkTextWithColor)
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        var attributedStringss:NSAttributedString=NSAttributedString()
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Medium;\"><font color=\"#000000\">"+stringKey+"</font> <font color=\"#000000\" >&nbsp;&nbsp;<br/>"+stringName+"<br/><br/></span></font> </font>"
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
        let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
        
        do {
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
         
        } catch _ {
            ////print("Cannot create attributed String")
        }
        ////print(attributedStringss)
        return attributedStringss
    }
    
    
    
    func functionForSetColorrelationship(_ stringKey:String,stringName:String)->NSAttributedString
    {
        let text = "I agree with TERMS and CONDITION"
        let linkTextWithColor = "CONDITION"
        let range = (text as NSString).range(of: linkTextWithColor)
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        var attributedStringss:NSAttributedString=NSAttributedString()
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Medium;\"><font color=\"#00aeef\">"+stringKey+"</font> <font color=\"#000000\" >&nbsp;&nbsp;<br/>"+stringName+"<br/><br/></span></font> </font>"
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
         let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
        } catch _ {
            ////print("Cannot create attributed String")
        }
        ////print(attributedStringss)
        return attributedStringss
    }
    
    @IBOutlet weak var labelNoBAEfoundinMonthView: UILabel!
}
