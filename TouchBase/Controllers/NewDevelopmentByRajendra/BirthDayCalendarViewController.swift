//
//  BirthDayCalendarViewController.swift
//  TouchBase
//
//  Created by deepak on 09/02/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class BirthDayCalendarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    //MARK:- IB
    @IBOutlet weak var tableviewBirthday: UITableView!
    @IBOutlet weak var viewCalendar: UIView!
    //MARK:- variable
    var  stringProfileId:String!=""
    var isAdmin:String!=""
    var  stringGroupID:String!=""
    var isCategory:String!=""
    var moduleName:String!=""
    var isYearorCalendarView:Bool=true
    var arrayResponse=NSArray()
    var setViewCurrentStatus:Bool=false// not hidden
    var IsExistingUpcomingBirthday:Int!=0
    // var rowSize:CGFloat=0.0
    var lastDateValueForMAtching:String!=""
    var muarrayHoldData:NSMutableArray=NSMutableArray()
    var varGetEventDate:String!=""
    //MARK:- view didload and view will appear and navigation setting
    //MARK:- Naviagation Setting
    override func viewDidAppear(_ animated: Bool)
    {
        tableviewBirthday.delegate = self
        tableviewBirthday.dataSource = self
        tableviewBirthday.setNeedsLayout()
        tableviewBirthday.reloadData()
        print("151151515151515151515151",self.tableviewBirthday.frame.origin.y)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        createNavigationBar()
        viewCalendar.isHidden=true
//        self.edgesForExtendedLayout=[]
        NotificationCenter.default.addObserver(self, selector: #selector(AddEventsController.AllRSVPBAction), name: NSNotification.Name(rawValue: "AllRSVP"), object: nil)
        
        
        ///
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        print("Screen width = \(screenWidth), screen height = \(screenHeight)")
        if(screenWidth==320)
        {
            //5s
            self.viewCalendar.frame = CGRect(x: 0, y: 65, width: self.viewCalendar.frame.width, height: self.viewCalendar.frame.height + 105.0)
        }
        else if(screenWidth==375)
        {
            self.viewCalendar.frame = CGRect(x: 0, y: 65, width: self.viewCalendar.frame.width, height: self.viewCalendar.frame.height + 105.0)
            
        }
        else if(screenWidth==414)
        {
            self.viewCalendar.frame = CGRect(x: 0, y: 65, width: self.viewCalendar.frame.width, height: self.viewCalendar.frame.height + 105.0)
            
        }
        functionForGettingCalendarMonthWiseData()
    }
    func AllRSVPBAction()
    {
        print("ALL")
        
        let window = UIApplication.shared.keyWindow!
        window.addSubview(viewCalendar);
        if(setViewCurrentStatus==false)
        {
            viewCalendar.isHidden=false
            setViewCurrentStatus=true
        }
        else if(setViewCurrentStatus==true)
        {
            viewCalendar.isHidden=true
            setViewCurrentStatus=false
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title="Roster On Wheels"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        //self.navigationController?.navigationBar.ti = UIColor.whiteColor()
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(NewCalendarViewController.buttonGoToBackClicked))
        add.tintColor = UIColor.white
        let searchButton = UIButton(type: UIButton.ButtonType.custom)
        searchButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        searchButton.setImage(UIImage(named:"search_blue"),  for: UIControl.State.normal)
        searchButton.addTarget(self, action: #selector(NewCalendarViewController.buttonRightFirst), for: UIControl.Event.touchUpInside)
        let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
        //let buttons : NSArray = [search, setting] //14 mar
        let buttonss : NSArray = [search]
        let settingButton = UIButton(type: UIButton.ButtonType.custom)
        settingButton.frame = CGRect(x: 0, y: 0, width: 30, height: 45)
        settingButton.setImage(UIImage(named:"overflow_btn_blue"),  for: UIControl.State.normal)
        settingButton.addTarget(self, action: #selector(NewCalendarViewController.buttonRightSecond), for: UIControl.Event.touchUpInside)
        let setting: UIBarButtonItem = UIBarButtonItem(customView: settingButton)
        let buttons : NSArray = [search, setting] //14 mar
        //let buttons : NSArray = [setting]
        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
    }
    //pop view controller
    func buttonGoToBackClicked()
    {
        print("®®®®®®®®®®®®®®®®®®®®Pop view controller clicked®®®®®®®®®®®®®®®®®®®®®®®®®")
        self.navigationController?.popViewController(animated: true)
    }
    func buttonRightFirst()
    {
        print("®®®®®®®®®®®®®®®®®®®®Right First clicked®®®®®®®®®®®®®®®®®®®®®®®®®")
    }
    func buttonRightSecond()
    {
        print("®®®®®®®®®®®®®®®®®®®®Right Second clicked®®®®®®®®®®®®®®®®®®®®®®®®®")
    }
    //MARK:- Button click event
    
    
    @IBAction func buttonClickEvent(_ sender: AnyObject) {
        print("®®®®®®®®®®®®®®®®®®®®Hello clicked !®®®®®®®®®®®®®®®®®®®®®®®®®")
        
    }
    
    //MARK:- Segue
    //MARK:- extension
    //MARK:- functions
    //MARK:- textfield delegate
    /*--------------------------------tableForAddRepeatDateAndTimeInAnnounce methods--------------Start-------------*/
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        //return 100.0
        //return rowSize
        if(varGetEventDate=="repeating")
        {
            return 47.0
        }
        else
        {
            return 88.0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayHoldData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let prototypeCell : NewCalendarTableViewCell! = tableviewBirthday.dequeueReusableCell(withIdentifier: "tableCell") as! NewCalendarTableViewCell
        if(muarrayHoldData.count>0)
        {
            // prototypeCell.configureCellServicesProviderList(arrayResponse.objectAtIndex(indexPath.row) as! NSDictionary)
            prototypeCell.configureCellServicesProviderList((arrayResponse.object(at: indexPath.row) as! NSDictionary), indexpath: indexPath.row)
            
            prototypeCell.labelDate.isHidden=false
            prototypeCell.labelPersonName.isHidden=false
            // print((muarrayHoldData.objectAtIndex(indexPath.row)as! NSDictionary))
            prototypeCell.labelDate.text=(muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "eventDate")as? String
            prototypeCell.labelPersonName.text=(muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "title")as? String
            
            
            
            varGetEventDate=(muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "compareDate")as! String
            if(varGetEventDate=="repeating")
            {
                prototypeCell.labelDate.isHidden=true
                prototypeCell.viewAll.frame = CGRect(x: 5, y: -42, width: prototypeCell.viewAll.frame.size.width, height: prototypeCell.viewAll.frame.size.height)
            }
            else
            {
                prototypeCell.viewAll.frame = CGRect(x: 5, y: 0, width: prototypeCell.viewAll.frame.size.width, height: prototypeCell.viewAll.frame.size.height)
                if(indexPath.row==0)
                {
                    //here condition is that for Todays Birthday
                    let getTodatDate = commonClassFunction().functionForGetTodatDate()
                    let varGetEventDateRepeat:String!=(muarrayHoldData.object(at: indexPath.row)as! NSDictionary).object(forKey: "compareDate")as! String
                    //                    if(varGetEventDateRepeat==getTodatDate)
                    //                    {
                    //                        prototypeCell.labelDate.text="Today's Birthdday"
                    //                    }
                }
                else
                {
                    //                    let varGetEventDateRepeat:String!=(muarrayHoldData.objectAtIndex(indexPath.row-1)as! NSDictionary).objectForKey("compareDate")as! String
                    //                   if(varGetEventDateRepeat=="repeating")
                    //                    {
                    ////                        prototypeCell.viewAll.frame = CGRectMake(5, 0, prototypeCell.viewAll.frame.size.width, prototypeCell.viewAll.frame.size.height)
                    //                   }
                }
            }
            
            
            //1.
            prototypeCell.buttonCall.addTarget(self, action: #selector(BirthDayCalendarViewController.buttonCallClickedEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCell.buttonCall.tag=indexPath.row;
            //2.
            prototypeCell.buttonSMS.addTarget(self, action: #selector(BirthDayCalendarViewController.buttonSMSClickedEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCell.buttonSMS.tag=indexPath.row;
            //3.
            prototypeCell.buttoEmail.addTarget(self, action: #selector(BirthDayCalendarViewController.buttonEmailClickedEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCell.buttoEmail.tag=indexPath.row;
            
        }
        return prototypeCell as NewCalendarTableViewCell
    }
    @objc func buttonCallClickedEvent(_ sender:UIButton)
    {
        // ContactNumber
        
        let  ContactNumber=(muarrayHoldData.object(at: sender.tag)as! NSDictionary).object(forKey: "ContactNumber")as! String
        
        print(ContactNumber)
        print("Call click !!!!!!!")
        //need to call
        if let url = URL(string: "tel://\(ContactNumber)"), UIApplication.shared.canOpenURL(url)
        {
//            UIApplication.shared.openURL(url)
            
               if UIApplication.shared.canOpenURL(url) {
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
    @objc func buttonSMSClickedEvent(_ sender:UIButton)
    {
        print("SMS click !!!!!!!")
    }
    @objc func buttonEmailClickedEvent(_ sender:UIButton)
    {
        print("Email click !!!!!!!")
    }
    //MARK:-Call web api
    func functionForGettingCalendarMonthWiseData()
    {
        let getProfileId =  UserDefaults.standard.value(forKey: "user_auth_token_profileId")
        let getGroupId =  UserDefaults.standard.value(forKey: "user_auth_token_groupId")
        print(getProfileId)
        print(getProfileId)
        
        
        let getTodayMonthYear = commonClassFunction().functionForGetTodatDayMonthYear()
        print(getTodayMonthYear)
        
        
        
        let completeURL = baseUrl+rowCelebreationBirthDayAnniversaryEvent
        var parameterst:NSDictionary=NSDictionary()
        isCategory="1"
        if(isCategory=="1")
        {
            parameterst =
                [
                    "profileId" : getProfileId!,
                    "groupId" : getGroupId!,
                    "SelectedDate":getTodayMonthYear,
                    "Type" :"B"
            ]
        }
        else if(isCategory=="2")
        {
            parameterst =
                [
                    "profileId" : getProfileId!,
                    "groupId" : getGroupId!,
                    "SelectedDate":getTodayMonthYear,
                    "Type" :"B"
            ]
        }
        print(parameterst)
        print(completeURL)
        
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print(response)
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
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            let responseDict = response.value(forKey: "TBEventListTypeResult")as! NSDictionary
            let letGetMessage = (responseDict.value(forKey: "message"))as! String
            let letGetStatus = (responseDict.value(forKey: "status"))as! String
            print(letGetMessage)
            print(letGetStatus)
            
            if(letGetStatus == "0" && letGetMessage == "success")
            {
                self.arrayResponse = (responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Events")as! NSArray
                
                for i in 00..<self.arrayResponse.count
                {
                    let eventDate = (self.arrayResponse.object(at: i) as! NSDictionary).value(forKey: "eventDate")as? String
                    let title =  (self.arrayResponse.object(at: i) as! NSDictionary).value(forKey: "title")as? String
                    let ContactNumber =  (self.arrayResponse.object(at: i) as! NSDictionary).value(forKey: "ContactNumber")as? String
                    
                    
                    let varGetEventDate:String!=eventDate
                    var arrayString=varGetEventDate.components(separatedBy: " ")
                    var arrayString2=arrayString[0].components(separatedBy: "-")
                    let varGetFinalString:String!=arrayString2[1]+arrayString2[2]
                    
                    //get month in character by extension
                    let getMonthInCharacter = commonClassFunction().functionForMonthWordWise(String(arrayString2[1]))
                    
                    print(varGetFinalString)
                    print(title)
                    print(eventDate)
                    
                    if(i==0)
                    {
                        self.lastDateValueForMAtching=""
                        self.lastDateValueForMAtching=varGetFinalString
                        
                        let getTodatDate = commonClassFunction().functionForGetTodatDate()
                        
                        print(getTodatDate)
                        print(varGetFinalString)
                        
                        if("0215"==varGetFinalString)
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
                    if(self.lastDateValueForMAtching=="Today's Birthdays" || self.lastDateValueForMAtching=="Upcoming Birthdays")
                    {
                        muDict.setValue(self.lastDateValueForMAtching+" "+arrayString2[2]+" "+getMonthInCharacter, forKey: "eventDate")
                    }
                    else
                    {
                        muDict.setValue(arrayString2[2]+" "+getMonthInCharacter, forKey: "eventDate")
                    }
                    muDict.setValue(title, forKey: "title")
                    muDict.setValue(self.lastDateValueForMAtching, forKey: "compareDate")
                    muDict.setValue(ContactNumber, forKey: "ContactNumber")
                    
                    self.muarrayHoldData.add(muDict)
                    self.lastDateValueForMAtching=varGetFinalString
                }
                self.tableviewBirthday.reloadData()
                self.tableviewBirthday.setNeedsLayout()
            }
            else
            {
                
            }
            SVProgressHUD.dismiss()
            }
        })
    }
}
