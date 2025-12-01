//
//  EventDetailNotiViewController.swift
//  TouchBase
//
//  Created by rajendra on 05/04/19.
//  Copyright © 2019 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
import EventKit

class EventDetailNotiViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var isCategory:String! = ""
    var grpName:String!=""
    var ticksnew:String!=""
    var FileNameToDelete:String=""
    /*
     eventDate = "2019-04-13 15:15:00";
     eventDesc = "Testing Event";
     eventImg = "";
     eventTitle = "Testing Event";
     goingCount = 0;
     groupid-grpID = 2765;
     maybeCount = 0;
     profileid-memID = 279705;
     notgoingCount = 0;
     reglink = "www.google.com";
     rsvpEnable = 0;
     eventid-tyID = 5297;
     type = Event;
     venue = "Kaizen Infotech Solutions Pvt Ltd.\n1st Floor, Building A,\nGala Industrial Estate,\nDindayal Upadhyay Marg\nMulund (W)  400 080 India ";
     */
    
    
    
    /*
     --yes
     http://rotaryindiaapi.rosteronwheels.com/api/Event/AnsweringEvent
     ["grpId": "2765", "answerByme": "sgsgsgsgsg", "eventId": "5297", "profileID": "279705", "questionId": "1513", "joiningStatus": "yes"]
     --no
     http://rotaryindiaapi.rosteronwheels.com/api/Event/AnsweringEvent
     ["grpId": "2765", "answerByme": "", "eventId": "5297", "profileID": "279705", "questionId": "", "joiningStatus": "no"]
     --maybe
     http://rotaryindiaapi.rosteronwheels.com/api/Event/AnsweringEvent
     ["grpId": "2765", "answerByme": "", "eventId": "5297", "profileID": "279705", "questionId": "", "joiningStatus": "maybe"]
     
     
     var questionID:String!=""
     var questionText:String!=""
     var questionType:String!=""
     
     
     
     */
    
    @IBOutlet weak var buttonOptionCancel: UIButton!
    
    
    @IBAction func buttonViewOptionclickEvent(_ sender: Any) {
        viewOption.isHidden=true
        buttonOpacity.isHidden=true
    }
    @IBOutlet weak var viewOption: UIView!
    
    @IBOutlet weak var labelOption: UILabel!
    @IBAction func buttonOptionOneClickEvent(_ sender: Any) {
        print("buttonOptionOne")
        
        ////
        let completeURL = baseUrl+"Event/AnsweringEvent"
        var parameterst = ["":""]
        var joiningStatus:String!=""
        var questionIdTemp:String!=""
        var thisisYesAnswer:String=""
        questionIdTemp=questionID
        thisisYesAnswer=option1
        joiningStatus="yes"
        
        parameterst =   [
            "grpId": grpID,
            "answerByme": thisisYesAnswer,
            "eventId": tyID ,
            "profileID": memID,
            "questionId": questionIdTemp,
            "joiningStatus": joiningStatus
        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("dd \(dd)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
                SVProgressHUD.dismiss()
                self.isYesNoMaybe=1
                self.buttonOpacity.isHidden=true
                self.viewOption.isHidden=true
                  if let EventJoinResult = dd.object(forKey: "EventJoinResult") as? NSDictionary
                              {
              let status = EventJoinResult.object(forKey: "status") as! String
              if status == "0"{
              let goingCount = EventJoinResult.object(forKey: "goingCount")as! String
              let notgoingCount:String! = EventJoinResult.object(forKey: "notgoingCount")as? String
              let maybeCount:String! = EventJoinResult.object(forKey: "maybeCount")as? String
              let myResponsqeq:String! = EventJoinResult.object(forKey: "myResponse")as? String
              
              self.textviewAnswer.resignFirstResponder()
              self.yesCountServerResponse=goingCount
              self.NoCountServerResponse=notgoingCount
              self.MaybeCountServerResponse=maybeCount
              self.myResponseServerResponse=myResponsqeq
              
              UIView.transition(with: self.tableviewEventDetailNoti, duration: 1.0, options: .transitionCrossDissolve, animations: {self.tableviewEventDetailNoti.reloadData()
                  self.tableviewEventDetailNotiShare.reloadData()
              }, completion: nil)
          }
          }
          }
        })
    }
    
    @IBOutlet weak var buttonOptionOne: UIButton!
    
    
    @IBOutlet weak var buttonOptionTwo: UIButton!
    
    @IBAction func buttonOptionTwoClickEvent(_ sender: Any) {
        print("buttonOptionOne")
        
   //  isYesNoMaybe=1
        
        ////
        let completeURL = baseUrl+"Event/AnsweringEvent"
        var parameterst = ["":""]
        var joiningStatus:String!=""
        var questionIdTemp:String!=""
        var thisisYesAnswer:String=""
        questionIdTemp=questionID
        
        thisisYesAnswer=option2
        joiningStatus="yes"
       
        parameterst =   [
            "grpId": grpID,
            "answerByme": thisisYesAnswer,
            "eventId": tyID ,
            "profileID": memID,
            "questionId": questionIdTemp,
            "joiningStatus": joiningStatus
        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("dd \(dd)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
                SVProgressHUD.dismiss()
                self.isYesNoMaybe=1
                self.buttonOpacity.isHidden=true
                self.viewOption.isHidden=true
                  if let EventJoinResult = dd.object(forKey: "EventJoinResult") as? NSDictionary
                              {
                   let status = EventJoinResult.object(forKey: "status") as! String
                   if status == "0"{
                   let goingCount = EventJoinResult.object(forKey: "goingCount")as! String
                   let notgoingCount:String! = EventJoinResult.object(forKey: "notgoingCount")as? String
                   let maybeCount:String! = EventJoinResult.object(forKey: "maybeCount")as? String
                   let myResponsqeq:String! = EventJoinResult.object(forKey: "myResponse")as? String
                   
                   self.textviewAnswer.resignFirstResponder()
                   self.yesCountServerResponse=goingCount
                   self.NoCountServerResponse=notgoingCount
                   self.MaybeCountServerResponse=maybeCount
                   self.myResponseServerResponse=myResponsqeq
                   
                   UIView.transition(with: self.tableviewEventDetailNoti, duration: 1.0, options: .transitionCrossDissolve, animations: {self.tableviewEventDetailNoti.reloadData()
                       self.tableviewEventDetailNotiShare.reloadData()
                   }, completion: nil)
               }
               }
            }
        })
    }
    
    func functionForYesNoMaybeResult(isYesNoMaybe:Int)
    {
        let completeURL = baseUrl+"Event/AnsweringEvent"
        var parameterst = ["":""]
        var joiningStatus:String!=""
        var questionIdTemp:String!=""
        var thisisYesAnswer:String=""
        questionIdTemp=questionID
        thisisYesAnswer=textviewAnswer.text
        if(isYesNoMaybe==1)
        {
            if(questionID.characters.count>0)
            {
                joiningStatus="yes"
                questionIdTemp=questionID
                thisisYesAnswer=textviewAnswer.text
            }
            else{
                joiningStatus="yes"
            }
        }
        else  if(isYesNoMaybe==2)
        {
            joiningStatus="no"
            questionIdTemp=""
            thisisYesAnswer=""
        }
        else  if(isYesNoMaybe==3)
        {
            joiningStatus="maybe"
            questionIdTemp=""
            thisisYesAnswer=""
        }
        
        parameterst =   [
            "grpId": grpID,
            "answerByme": thisisYesAnswer,
            "eventId": tyID ,
            "profileID": memID,
            "questionId": questionIdTemp,
            "joiningStatus": joiningStatus
        ]
        
        
        
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("dd \(dd)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
                SVProgressHUD.dismiss()
                if let EventJoinResult = dd.object(forKey: "EventJoinResult") as? NSDictionary
                {
                    let status = EventJoinResult.object(forKey: "status") as! String
                    if status == "0"{
                    let goingCount = EventJoinResult.object(forKey: "goingCount")as! String
                    let notgoingCount:String! = EventJoinResult.object(forKey: "notgoingCount")as? String
                    let maybeCount:String! = EventJoinResult.object(forKey: "maybeCount")as? String
                    let myResponsqeq:String! = EventJoinResult.object(forKey: "myResponse")as? String
                    
                    self.textviewAnswer.resignFirstResponder()
                    self.yesCountServerResponse=goingCount
                    self.NoCountServerResponse=notgoingCount
                    self.MaybeCountServerResponse=maybeCount
                    self.myResponseServerResponse=myResponsqeq
                    
                    UIView.transition(with: self.tableviewEventDetailNoti, duration: 1.0, options: .transitionCrossDissolve, animations: {self.tableviewEventDetailNoti.reloadData()
                        self.tableviewEventDetailNotiShare.reloadData()
                    }, completion: nil)
                }
                }
                
            }
        })
    }
    
    var yesCountServerResponse:String!=""
    var NoCountServerResponse:String!=""
    var MaybeCountServerResponse:String!=""
    var totalCountServerResponse:String!=""
    var myResponseServerResponse:String!=""
    
    @IBOutlet weak var buttonOpacity: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var viewYesQuestion: UIView!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var textviewAnswer: UITextView!
    @IBAction func buttonCancelclickEvent(_ sender: Any) {
        viewYesQuestion.isHidden=true
        buttonOpacity.isHidden=true
    }
    
    @objc func buttonbuttonImageViewViewEventClickEvent(_ sender:UIButton)
    {
        let objImageFullViewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ImageFullViewViewController") as! ImageFullViewViewController
        objImageFullViewViewController.varGetImageUrl=muarrayHoldInfo.object(at: 0) as! String
        self.navigationController?.pushViewController(objImageFullViewViewController, animated: true)
    }
    
    /*
     http://rotaryindiaapi.rosteronwheels.com/api/Event/AnsweringEvent
     ["grpId": "2765", "answerByme": "", "eventId": "5297", "profileID": "279705", "questionId": "", "joiningStatus": "yes"]
     
     
     
     http://rotaryindiaapi.rosteronwheels.com/api/Event/AnsweringEvent
     ["grpId": "2765", "answerByme": "", "eventId": "5297", "profileID": "279705", "questionId": "", "joiningStatus": "yes"]
     
     
     
     http://rotaryindiaapi.rosteronwheels.com/api/Event/AnsweringEvent
     ["grpId": "2765", "answerByme": "", "eventId": "5297", "profileID": "279705", "questionId": "", "joiningStatus": "maybe"]
     */
    @IBOutlet weak var viewYesNoMaybe: UIView!
    @IBAction func buttonYesClickEvent(_ sender: Any)
    {
        
        /*
        if(questionID.characters.count>0)
        {
            print("buttonYesClickEvent")
            buttonOpacity.isHidden=false
            viewYesQuestion.isHidden=false
            textviewAnswer.becomeFirstResponder()
            let indexPath = IndexPath(row: muarrayHoldInfo.count - 1, section: 0)
            self.tableviewEventDetailNoti.scrollToRow(at: indexPath, at: .bottom, animated: true)
            
        }else{
            print("This is yues button clicked !!!!!")
            viewYesQuestion.isHidden=true
            buttonOpacity.isHidden=true
            
            isYesNoMaybe=1
            functionForYesNoMaybeResult(isYesNoMaybe: isYesNoMaybe)
        }
        */
        
        if(isQuesEnable=="0")
        {
            print("This is yues button clicked !!!!!")
            viewYesQuestion.isHidden=true
            buttonOpacity.isHidden=true
            
            isYesNoMaybe=1
            functionForYesNoMaybeResult(isYesNoMaybe: isYesNoMaybe)
        }
        else if(isQuesEnable=="1")
        {
            print("buttonYesClickEvent")
            buttonOpacity.isHidden=false
            viewYesQuestion.isHidden=false
            textviewAnswer.becomeFirstResponder()
            let indexPath = IndexPath(row: muarrayHoldInfo.count - 1, section: 0)
            self.tableviewEventDetailNoti.scrollToRow(at: indexPath, at: .bottom, animated: true)
            self.tableviewEventDetailNotiShare.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        else if(isQuesEnable=="2")
        {
            print("buttonYesClickEvent")
            buttonOpacity.isHidden=false
            viewOption.isHidden=false
            
            buttonOptionOne.setTitle(option1, for: .normal)
            buttonOptionTwo.setTitle(option2, for: .normal)
            
            let indexPath = IndexPath(row: muarrayHoldInfo.count - 1, section: 0)
            self.tableviewEventDetailNoti.scrollToRow(at: indexPath, at: .bottom, animated: true)
            self.tableviewEventDetailNotiShare.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        print(option1)
        print(option2)
        labelOption.text=questionText

        
        
    }
    @IBAction func buttonSubmitClickEvent(_ sender: Any)
    {
        print("This is yues button clicked !!!!!")
        viewYesQuestion.isHidden=true
        buttonOpacity.isHidden=true
        
        isYesNoMaybe=1
        // UIView.transition(with: tableviewEventDetailNoti, duration: 1.0, options: .transitionCrossDissolve, animations: {self.tableviewEventDetailNoti.reloadData()}, completion: nil)
        functionForYesNoMaybeResult(isYesNoMaybe: isYesNoMaybe)
    }
    @IBAction func buttonNoClickEvent(_ sender: Any)
    {
        print("buttonNoClickEvent")
        isYesNoMaybe=2
        //UIView.transition(with: tableviewEventDetailNoti, duration: 1.0, options: .transitionCrossDissolve, animations: {self.tableviewEventDetailNoti.reloadData()}, completion: nil)
        
        functionForYesNoMaybeResult(isYesNoMaybe: isYesNoMaybe)
    }
    @IBAction func buttonMayBeClickEvent(_ sender: Any)
    {
        print("buttonMayBeClickEvent")
        isYesNoMaybe=3
        
        // UIView.transition(with: tableviewEventDetailNoti, duration: 1.0, options: .transitionCrossDissolve, animations: {self.tableviewEventDetailNoti.reloadData()}, completion: nil)
        functionForYesNoMaybeResult(isYesNoMaybe: isYesNoMaybe)
        
    }
    
    
    
    
    var isYesNoMaybe:Int=0
    @IBOutlet weak var tableviewEventDetailNoti: UITableView!
    @IBOutlet weak var tableviewEventDetailNotiShare: UITableView!
    func createNavigationBar()
    {
        
        // NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LinkViewController.methodOfReceivedNotification(_:)), name:"NotificationIdentifier", object: nil)
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "Event"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(DirectoryViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        //    let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(DirectoryViewController.AddEventAction))
        //    add.tintColor = UIColor.whiteColor()
        self.view.addSubview(buttonleft)
        //self.view.addSubview(leftButton)
        //self.view.addSubview()
        
        //changed by harshada on 30 May 2019 6:05 PM
        
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        shareButton.addTarget(self, action: #selector(self.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        let shareButtonAdd: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
        
        if let systemVersion = (UIDevice.current.systemVersion
         as? NSString)?.integerValue
        {
         if systemVersion < 13
         {
            self.navigationItem.rightBarButtonItem=shareButtonAdd
         }
        }
    }
    
@objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
        if((self.presentingViewController) != nil){
            self.dismiss(animated: false, completion: nil)
            print("done")
        }
    }
    
    
    /*
     eventDate = "2019-04-13 15:15:00";
     eventDesc = "Testing Event";
     eventImg = "";
     eventTitle = "Testing Event";
     goingCount = 0;
     groupid-grpID = 2765;
     maybeCount = 0;
     profileid-memID = 279705;
     notgoingCount = 0;
     reglink = "www.google.com";
     rsvpEnable = 0;
     eventid-tyID = 5297;
     type = Event;
     venue = "Kaizen Infotech Solutions Pvt Ltd.\n1st Floor, Building A,\nGala Industrial Estate,\nDindayal Upadhyay Marg\nMulund (W)  400 080 India ";
     */
    
    var eventDate:String!=""
    var eventDesc:String!=""
    var eventImg:String!=""
    var eventTitle:String!=""
    var goingCount:String!=""
    var grpID:String!=""
    var maybeCount:String!=""
    var memID:String!=""
    var notgoingCount:String!=""
    var reglink:String!=""
    var rsvpEnable:String!=""
    var tyID:String!=""
    var type:String!=""
    var venue:String!=""
    
    var questionID:String!=""
    var questionText:String!=""
    var questionType:String!=""
    
    var myResponse:String!=""
    
    var isQuesEnable:String!=""
    var option1:String!=""
    var option2:String!=""
    
    
    
    
    
    // var totalCountServerResponse:String=""
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.dismiss()
        SVProgressHUD.dismiss()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewOption.isHidden=true

        //buttonOptionCancel.backgroundColor = .clear
        // buttonOptionCancel.layer.cornerRadius = 5
        // buttonOptionCancel.layer.borderWidth = 1
        // buttonOptionCancel.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0) as! CGColor 
        //--        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        //need to check my response which is coming from server notification
        if(myResponse=="yes")
        {
            isYesNoMaybe=1
        }
        else if(myResponse=="no")
        {
            isYesNoMaybe=2
        }
        else  if(myResponse=="maybe")
        {
            isYesNoMaybe=3
        }
        else  if(myResponse=="")
        {
            isYesNoMaybe=0
        }
        
        //----
        //dashBoardController.goingCount = notifyDict["goingCount"] as! String
        //dashBoardController.notgoingCount = notifyDict["notgoingCount"] as! String
        //dashBoardController.maybeCount = notifyDict["maybeCount"] as! String
        //dashBoardController.totalCount = notifyDict["totalCount"] as! String
        
        yesCountServerResponse=goingCount
        NoCountServerResponse=notgoingCount
        MaybeCountServerResponse=maybeCount
        print(totalCountServerResponse)
        //totalCountServerResponse=totalCountServerResponse
        myResponseServerResponse=myResponse
        
        var lineView = UIView(frame: CGRect(x:0, y:0, width:buttonCancel.frame.size.width, height:1))
        lineView.backgroundColor=UIColor.lightGray
        buttonCancel.addSubview(lineView)
        
        
        var lineView2 = UIView(frame: CGRect(x:0, y:0, width:buttonSubmit.frame.size.width, height:1))
        lineView2.backgroundColor=UIColor.lightGray
        buttonSubmit.addSubview(lineView2)
        
        
        
        
        var lineView3 = UIView(frame: CGRect(x:0, y:0, width:buttonOptionOne.frame.size.width, height:1))
        lineView3.backgroundColor=UIColor.lightGray
        buttonOptionOne.addSubview(lineView3)
        
        var lineView4 = UIView(frame: CGRect(x:0, y:0, width:buttonOptionTwo.frame.size.width, height:1))
        lineView4.backgroundColor=UIColor.lightGray
        buttonOptionTwo.addSubview(lineView4)
        
       // self.viewOption.layer.cornerRadius = 5.0;
        //self.viewOption.layer.masksToBounds = true
        
        
        
        viewYesQuestion.isHidden=true
        textviewAnswer.text=""
        buttonOpacity.isHidden=true
        // tableviewEventDetailNoti.separatorStyle = .none
        self.viewYesQuestion.layer.cornerRadius = 5.0;
        self.viewYesQuestion.layer.masksToBounds = true
        
        self.view.backgroundColor=UIColor.lightGray
        
        createNavigationBar()
        labelQuestion.text=questionText
        
        muarrayHoldInfo.add(eventImg)
        muarrayHoldInfo.add(eventTitle)
        muarrayHoldInfo.add(eventDesc)
        muarrayHoldInfo.add(venue)
        var sDate:String=""
        if let date=eventDate{
            let df:DateFormatter=DateFormatter()
            df.dateFormat="yyyy-MM-dd HH:mm:ss"
            let sDte=df.date(from: date)
            let dfs:DateFormatter=DateFormatter()
            dfs.dateFormat="dd MMM yyyy hh:mm a"
            if let ddate = sDte {
                sDate=dfs.string(from: ddate)
            }
        }
        
        muarrayHoldInfo.add(sDate)
        muarrayHoldInfo.add(reglink)
        muarrayHoldInfo.add(rsvpEnable)

        tableviewEventDetailNoti.reloadData()
        tableviewEventDetailNotiShare.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Start of add to calendar function
    /*
    //add below lines in viewDid load method
    self.buttonAddToCalendar.layer.borderColor=UIColor.white.cgColor
    self.buttonAddToCalendar.layer.borderWidth=1.0

    
    @IBOutlet weak var buttonAddToCalendar: UIButton!

    
    
    @IBAction func addTocalenderClickEvent(_ sender: Any) {
           addEventToCalendarss()
       }
    
    @objc func addEventToCalendarss()
    {
        var eventsDetails = EventsDetail()
        eventsDetails = mainArray.object(at: 0) as!  EventsDetail
        let fromDate:Date=convertToDate(dateString: eventsDetails.eventDate)
        let toDate:Date=convertToDate(dateString: eventsDetails.expiryDate)
        //2019-08-16 17:07:00
        self.addEventToCalendar(title: eventsDetails.eventTitle, description: eventsDetails.eventDesc, startDate: fromDate, endDate: toDate)
    }

    func showMsg(msg:String)
    {
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Rotary India"
        alertView.message = msg
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
    }

    
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
       
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.showMsg(msg: "Event added to Calendar.")
        })

        
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    return
                }
                
                completion?(true, nil)
                
            } else {
                completion?(false, error as NSError?)
            }
        })
        
    }
    */

    //MARK:- End of calender function
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayHoldInfo.count
    }
        var varRowHeight:CGFloat!=0.0
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        //        if(indexPath.row==0)
        //        {
        //           return 333.0
        //        }
        //        else
        //        {
        //        return varRowHeight
        //        }
        return varRowHeight
    }
    
    var muarrayHoldInfo:NSMutableArray=NSMutableArray()
    
    /*
     @IBOutlet weak var labelYesNoMaybe: UILabel!
     @IBOutlet weak var labelResponse: UILabel!
     */
    
    var cell:EventDetailNotiiTableViewCell = EventDetailNotiiTableViewCell()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //B6B6B6
        if tableView==tableviewEventDetailNoti
        {
        cell =  tableviewEventDetailNoti.dequeueReusableCell(withIdentifier: "Cell") as! EventDetailNotiiTableViewCell
        
        cell.viewImage.isHidden=true
        cell.viewTitleLinkDate.isHidden=true
        cell.viewVenue.isHidden=true
        cell.viewDescription.isHidden=true
        cell.viewBottomBar.isHidden=true
        
        
        
        if(indexPath.row==0)
        {
            let varGetImage = muarrayHoldInfo.object(at: 0)
            print("************************************",varGetImage)
            
            if muarrayHoldInfo.object(at: 0) as! String == ""
            {
                cell.imageMain.image = UIImage(named: "profile_pic")
                varRowHeight=0.0
            }
            else
            {
                let varGetImageUrl:String=muarrayHoldInfo.object(at: 0) as! String
                print(varGetImageUrl)
                let url = URL(string: varGetImage as! String)
                let ImageProfilePic:String = (varGetImage as AnyObject).replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                cell.imageMain.sd_setImage(with: checkedUrl)
                varRowHeight=252.0
                cell.viewImage.isHidden=false
                cell.buttonImageFullView.addTarget(self, action: #selector(EventDetailNotiViewController.buttonbuttonImageViewViewEventClickEvent(_:)), for: UIControl.Event.touchUpInside)
                
            }
        }
        else  if(indexPath.row==1)
        {
            cell.labelTitleDate.text=muarrayHoldInfo.object(at: 1)as! String
            cell.labelLink.isHidden=true
            cell.buttonLink.isHidden=true
            varRowHeight=43.0
            cell.labelTitleDate.isHidden=false
            cell.viewTitleLinkDate.isHidden=false
            let title:String=muarrayHoldInfo.object(at: 1)as! String
            print("Notification title is : \(title) and count is: \(title.count)")
            if (title.count) > 35
            {
                  varRowHeight=83.0
            cell.viewTitleLinkDate.frame=CGRect(x: cell.viewTitleLinkDate.frame.origin.x, y: cell.viewTitleLinkDate.frame.origin.y, width: cell.viewTitleLinkDate.frame.width, height: 83.0)
            
            cell.labelTitleDate.frame=CGRect(x: cell.labelTitleDate.frame.origin.x, y: cell.labelTitleDate.frame.origin.y, width: cell.labelTitleDate.frame.width, height: 83.0)
            }
        }
        else  if(indexPath.row==2)
        {
            cell.textviewDescription.text=muarrayHoldInfo.object(at: 2)as! String
            var varGetDesc=muarrayHoldInfo.object(at: 2)  as! String
            cell.textviewDescription.text=varGetDesc
            let fixedWidth = cell.textviewDescription.frame.size.width
            cell.textviewDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = cell.textviewDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = cell.textviewDescription.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            cell.textviewDescription.frame = newFrame;
            varRowHeight=newSize.height+5
            cell.viewDescription.isHidden=false
        }
        else  if(indexPath.row==3)
        {
            cell.textviewVenue.text=muarrayHoldInfo.object(at: 3)as! String
            var varGetDesc=muarrayHoldInfo.object(at: 3)  as! String
            cell.textviewVenue.text=varGetDesc
            let fixedWidth = cell.textviewVenue.frame.size.width
            cell.textviewVenue.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = cell.textviewVenue.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = cell.textviewVenue.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            cell.textviewVenue.frame = newFrame;
            varRowHeight=newSize.height+10
            // cell.viewVenue.isHidden=false
            // cell.buttonLocation.isHidden=false
            // cell.textviewVenue.isHidden=false
            //cell.viewDescription.isHidden=false
            cell.viewVenue.isHidden=false
            cell.viewVenue.backgroundColor=UIColor.white
            cell.buttonLocation.addTarget(self, action: #selector(EventDetailNotiViewController.buttonbuttonLocationViewEventClickEvent(_:)), for: UIControl.Event.touchUpInside)
        }
        else  if(indexPath.row==4)
        {
            cell.labelTitleDate.text=muarrayHoldInfo.object(at: 4)as! String
            cell.labelLink.isHidden=true
            cell.buttonLink.isHidden=true
            cell.labelTitleDate.isHidden=false
            varRowHeight=43.0
            cell.viewTitleLinkDate.isHidden=false
            cell.viewTitleLinkDate.frame=CGRect(x: cell.viewTitleLinkDate.frame.origin.x, y: cell.viewTitleLinkDate.frame.origin.y, width: cell.viewTitleLinkDate.frame.width, height: 43.0)
            cell.viewTitleLinkDate.backgroundColor=UIColor.white
            cell.labelTitleDate.frame=CGRect(x: cell.labelTitleDate.frame.origin.x, y: cell.labelTitleDate.frame.origin.y, width: cell.labelTitleDate.frame.width, height: 35.0)
            cell.labelTitleDate.textColor=UIColor(red: 182/255.0, green: 182/255.0, blue: 182/255.0, alpha: 1.0)

        }
        else  if(indexPath.row==5)
        {
            
            var getLink:String!=muarrayHoldInfo.object(at: 5)as! String
            if(getLink.characters.count>2)
            {
                cell.labelTitleDate.text=muarrayHoldInfo.object(at: 5)as! String
                cell.labelLink.isHidden=false
                cell.buttonLink.isHidden=false
                cell.labelTitleDate.isHidden=true
                varRowHeight=50.0
                
                cell.buttonLink.setTitle(muarrayHoldInfo.object(at: 5)as! String, for: .normal)
                cell.viewTitleLinkDate.isHidden=false
                cell.buttonLink.addTarget(self, action: #selector(EventDetailNotiViewController.buttonLinkViewEventClickEvent(_:)), for: UIControl.Event.touchUpInside)
                cell.viewTitleLinkDate.backgroundColor=UIColor.white
            }
            else
            {
                varRowHeight=0.0
            }
        }
        else  if(indexPath.row==6)
        {
            var getIsRSPVEnable:String!=muarrayHoldInfo.object(at: 6)as! String
            if(getIsRSPVEnable=="1")
            {
                cell.viewBottomBar.isHidden=false
                varRowHeight=200.0
                viewYesNoMaybe.isHidden=false
                if(isYesNoMaybe==1){
                    cell.labelYesNoMaybe.text="YES, You have accepted the invite to this event."
                    cell.labelYesNoMaybe.textColor=UIColor.green
                    cell.labelResponse.text="Total Response: | Yes: "+(yesCountServerResponse)+" | No: "+String(NoCountServerResponse)+" | Maybe: "+String(MaybeCountServerResponse)
                    
                }
                else if(isYesNoMaybe==2){
                    cell.labelYesNoMaybe.text="No, You have declined the invite to this event."
                    cell.labelYesNoMaybe.textColor=UIColor.red
                    cell.labelResponse.text="Total Response: | Yes: "+(yesCountServerResponse)+" | No: "+String(NoCountServerResponse)+" | Maybe: "+String(MaybeCountServerResponse)
                    
                }
                else if(isYesNoMaybe==3){
                    cell.labelYesNoMaybe.text="You have not confirmed attendence."
                    cell.labelYesNoMaybe.textColor=UIColor.darkGray
                    cell.labelResponse.text="Total Response: | Yes: "+(yesCountServerResponse)+" | No: "+String(NoCountServerResponse)+" | Maybe: "+String(MaybeCountServerResponse)
                    
                }
                else if(isYesNoMaybe==0){
                    cell.labelYesNoMaybe.text="You have not responded to this invite."
                    cell.labelYesNoMaybe.textColor=UIColor.lightGray
                    cell.labelResponse.text="Total Response: | Yes: "+String(0)+" | No: "+String(0)+" | Maybe: "+String(0)
                }
                
                /*
                 
                 var NoCountServerResponse:String!=""
                 var MaybeCountServerResponse:String!=""
                 
                 yesCountServerResponse=goingCount
                 NoCountServerResponse=notgoingCount
                 MaybeCountServerResponse=maybeCount
                 myResponseServerResponse=myResponse
                 */
                
                
                
            }
            else
            {
                varRowHeight=0
                viewYesNoMaybe.isHidden=true
            }
        }
        return cell
    }
        
        else if tableView==tableviewEventDetailNotiShare
        {
            cell =  tableviewEventDetailNotiShare.dequeueReusableCell(withIdentifier: "CellShare") as! EventDetailNotiiTableViewCell
            
            /*--------*/
            /*
             
             //1.
             @IBOutlet weak var viewImage: UIView!
             @IBOutlet weak var imageMain: UIImageView!
             //2.
             @IBOutlet weak var viewTitleLinkDate: UIView!
             @IBOutlet weak var labelLink: UILabel!
             @IBOutlet weak var buttonLink: UIButton!
             @IBOutlet weak var labelTitleDate: UILabel!
             //3.
             @IBOutlet weak var viewVenue: UIView!
             @IBOutlet weak var buttonLocation: UIButton!
             @IBOutlet weak var textviewVenue: UITextView!
             //4.
             @IBOutlet weak var viewDescription: UIView!
             @IBOutlet weak var textviewDescription: UITextView!
             //5.
             @IBOutlet weak var viewBottomBar: UIView!
             */
            /*--------*/
            cell.viewImage.isHidden=true
            cell.viewTitleLinkDate.isHidden=true
            cell.viewVenue.isHidden=true
            cell.viewDescription.isHidden=true
            cell.viewBottomBar.isHidden=true
            
            
            
            if(indexPath.row==0)
            {
                let varGetImage = muarrayHoldInfo.object(at: 0)
                print("************************************",varGetImage)
                
                if muarrayHoldInfo.object(at: 0) as! String == ""
                {
                    cell.imageMain.image = UIImage(named: "profile_pic")
                    varRowHeight=0.0
                }
                else
                {
                    let varGetImageUrl:String=muarrayHoldInfo.object(at: 0) as! String
                    print(varGetImageUrl)
                    let url = URL(string: varGetImage as! String)
                    let ImageProfilePic:String = (varGetImage as AnyObject).replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    cell.imageMain.sd_setImage(with: checkedUrl)
                    varRowHeight=252.0
                    cell.viewImage.isHidden=false
                    cell.buttonImageFullView.addTarget(self, action: #selector(EventDetailNotiViewController.buttonbuttonImageViewViewEventClickEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                }
            }
            else  if(indexPath.row==1)
            {
                cell.labelTitleDate.text=muarrayHoldInfo.object(at: 1)as! String
                cell.labelLink.isHidden=true
                cell.buttonLink.isHidden=true
                varRowHeight=43.0
                cell.labelTitleDate.isHidden=false
                cell.viewTitleLinkDate.isHidden=false
                let title:String=muarrayHoldInfo.object(at: 1)as! String
                print("Notification title is : \(title) and count is: \(title.count)")
                if (title.count) > 35
                {
                    varRowHeight=83.0
                    cell.viewTitleLinkDate.frame=CGRect(x: cell.viewTitleLinkDate.frame.origin.x, y: cell.viewTitleLinkDate.frame.origin.y, width: cell.viewTitleLinkDate.frame.width, height: 83.0)
                    
                    cell.labelTitleDate.frame=CGRect(x: cell.labelTitleDate.frame.origin.x, y: cell.labelTitleDate.frame.origin.y, width: cell.labelTitleDate.frame.width, height: 83.0)
                }
            }
            else  if(indexPath.row==2)
            {
                cell.textviewDescription.text=muarrayHoldInfo.object(at: 2)as! String
                var varGetDesc=muarrayHoldInfo.object(at: 2)  as! String
                cell.textviewDescription.text=varGetDesc
                let fixedWidth = cell.textviewDescription.frame.size.width
                cell.textviewDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                let newSize = cell.textviewDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                var newFrame = cell.textviewDescription.frame
                newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
                cell.textviewDescription.frame = newFrame;
                varRowHeight=newSize.height+5
                cell.viewDescription.isHidden=false
            }
            else  if(indexPath.row==3)
            {
                cell.textviewVenue.text=muarrayHoldInfo.object(at: 3)as! String
                var varGetDesc=muarrayHoldInfo.object(at: 3)  as! String
                cell.textviewVenue.text=varGetDesc
                let fixedWidth = cell.textviewVenue.frame.size.width
                cell.textviewVenue.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                let newSize = cell.textviewVenue.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                var newFrame = cell.textviewVenue.frame
                newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
                cell.textviewVenue.frame = newFrame;
                varRowHeight=newSize.height+10
                // cell.viewVenue.isHidden=false
                // cell.buttonLocation.isHidden=false
                // cell.textviewVenue.isHidden=false
                //cell.viewDescription.isHidden=false
                cell.viewVenue.isHidden=false
                cell.viewVenue.backgroundColor=UIColor.white
                
                
                cell.buttonLocation.addTarget(self, action: #selector(EventDetailNotiViewController.buttonbuttonLocationViewEventClickEvent(_:)), for: UIControl.Event.touchUpInside)
                
                
                
            }
            else  if(indexPath.row==4)
            {
                cell.labelTitleDate.text=muarrayHoldInfo.object(at: 4)as! String
                cell.labelLink.isHidden=true
                cell.buttonLink.isHidden=true
                cell.labelTitleDate.isHidden=false
                varRowHeight=43.0
                cell.viewTitleLinkDate.isHidden=false
                cell.viewTitleLinkDate.frame=CGRect(x: cell.viewTitleLinkDate.frame.origin.x, y: cell.viewTitleLinkDate.frame.origin.y, width: cell.viewTitleLinkDate.frame.width, height: 43.0)
                cell.viewTitleLinkDate.backgroundColor=UIColor.white
                cell.labelTitleDate.frame=CGRect(x: cell.labelTitleDate.frame.origin.x, y: cell.labelTitleDate.frame.origin.y, width: cell.labelTitleDate.frame.width, height: 35.0)
                cell.labelTitleDate.textColor=UIColor(red: 182/255.0, green: 182/255.0, blue: 182/255.0, alpha: 1.0)
            }
            else  if(indexPath.row==5)
            {
                
                var getLink:String!=muarrayHoldInfo.object(at: 5)as! String
                if(getLink.characters.count>2)
                {
                    cell.labelTitleDate.text=muarrayHoldInfo.object(at: 5)as! String
                    cell.labelLink.isHidden=false
                    cell.buttonLink.isHidden=false
                    cell.labelTitleDate.isHidden=true
                    varRowHeight=50.0
                    
                    cell.buttonLink.setTitle(muarrayHoldInfo.object(at: 5)as! String, for: .normal)
                    cell.viewTitleLinkDate.isHidden=false
                    cell.buttonLink.addTarget(self, action: #selector(EventDetailNotiViewController.buttonLinkViewEventClickEvent(_:)), for: UIControl.Event.touchUpInside)
                    cell.viewTitleLinkDate.backgroundColor=UIColor.white
                }
                else
                {
                    varRowHeight=0.0
                }
            }
            else  if(indexPath.row==6)
            {
                var getIsRSPVEnable:String!=muarrayHoldInfo.object(at: 6)as! String
                if(getIsRSPVEnable=="1")
                {
                    cell.viewBottomBar.isHidden=false
                    varRowHeight=200.0
                    viewYesNoMaybe.isHidden=false
                    if(isYesNoMaybe==1){
                        cell.labelYesNoMaybe.text="YES, You have accepted the invite to this event."
                        cell.labelYesNoMaybe.textColor=UIColor.green
                        cell.labelResponse.text="Total Response: | Yes: "+(yesCountServerResponse)+" | No: "+String(NoCountServerResponse)+" | Maybe: "+String(MaybeCountServerResponse)
                        
                    }
                    else if(isYesNoMaybe==2){
                        cell.labelYesNoMaybe.text="No, You have declined the invite to this event."
                        cell.labelYesNoMaybe.textColor=UIColor.red
                        cell.labelResponse.text="Total Response: | Yes: "+(yesCountServerResponse)+" | No: "+String(NoCountServerResponse)+" | Maybe: "+String(MaybeCountServerResponse)
                        
                    }
                    else if(isYesNoMaybe==3){
                        cell.labelYesNoMaybe.text="You have not confirmed attendence."
                        cell.labelYesNoMaybe.textColor=UIColor.darkGray
                        cell.labelResponse.text="Total Response: | Yes: "+(yesCountServerResponse)+" | No: "+String(NoCountServerResponse)+" | Maybe: "+String(MaybeCountServerResponse)
                        
                    }
                    else if(isYesNoMaybe==0){
                        cell.labelYesNoMaybe.text="You have not responded to this invite."
                        cell.labelYesNoMaybe.textColor=UIColor.lightGray
                        cell.labelResponse.text="Total Response: | Yes: "+String(0)+" | No: "+String(0)+" | Maybe: "+String(0)
                    }
                    
                    /*
                     
                     var NoCountServerResponse:String!=""
                     var MaybeCountServerResponse:String!=""
                     
                     yesCountServerResponse=goingCount
                     NoCountServerResponse=notgoingCount
                     MaybeCountServerResponse=maybeCount
                     myResponseServerResponse=myResponse
                     */
                    
                    
                    
                }
                else
                {
                    varRowHeight=0
                    viewYesNoMaybe.isHidden=true
                }
            }
            cell.viewBottomBar.isHidden=true
            return cell
        }
        return UITableViewCell()
    }
    var getResponseCount:Int!=5
    @objc func buttonbuttonLocationViewEventClickEvent(_ sender:UIButton)
    {
        print("button location click event !!!!!!")
        let address = muarrayHoldInfo.object(at: 3)as! String
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("This is Error:------>")
                self.view.makeToast("Address is not valid", duration: 3, position: CSToastPositionCenter)
                if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
                {
//                    UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\("InvaidAddress"),\("InvaidAddress")&directionsmode=driving")!)
                    
                    if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://?saddr=&daddr=\("InvaidAddress"),\("InvaidAddress")&directionsmode=driving")!) {
                        UIApplication.shared.open(URL(string:"comgooglemaps://?saddr=&daddr=\("InvaidAddress"),\("InvaidAddress")&directionsmode=driving")!, options: [:]) { success in
                                if success {
                                    print("The URL was successfully opened.")
                                } else {
                                    print("Failed to open the URL.")
                                }
                            }
                        }
                }
                else
                {}
            }
            else
            {
                if let placemark = placemarks?.first {
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
                    {
                        // UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\(coordinates.latitude),\(coordinates.longitude)&directionsmode=driving")!)
                        //Working in Swift new versions.
//                        UIApplication.shared.openURL(NSURL(string:
//                            "comgooglemaps://?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))&directionsmode=driving")! as URL)
                        
                        if UIApplication.shared.canOpenURL(NSURL(string:
                                                                    "comgooglemaps://?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))&directionsmode=driving")! as URL) {
                            UIApplication.shared.open(NSURL(string:
                                                                "comgooglemaps://?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))&directionsmode=driving")! as URL, options: [:]) { success in
                                    if success {
                                        print("The URL was successfully opened.")
                                    } else {
                                        print("Failed to open the URL.")
                                    }
                                }
                            }
                        
                    }
                    else
                    {
                        let directionsURL = "http://maps.apple.com/?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))"
                        guard let url = URL(string: directionsURL) else {
                            return
                        }
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
//                            UIApplication.shared.openURL(url)
                            
                            if UIApplication.shared.canOpenURL(url as URL) {
                                UIApplication.shared.open(url as URL, options: [:]) { success in
                                        if success {
                                            print("The URL was successfully opened.")
                                        } else {
                                            print("Failed to open the URL.")
                                        }
                                    }
                                }
                        }
                        NSLog("Can't use comgooglemaps://");
                    }
                    
                }
            }
        })
    }
    
    @objc func buttonLinkViewEventClickEvent(_ sender:UIButton)
    {
        print("button buttonLinkViewEventClickEvent click event !!!!!!")
        
        SVProgressHUD.show()
        /*
        let objWebSiteOpenUrlViewController = self.storyboard!.instantiateViewController(withIdentifier: "webViewCommonViewController") as! webViewCommonViewController
        objWebSiteOpenUrlViewController.URLstr=muarrayHoldInfo.object(at: 5)as! String
        self.navigationController?.pushViewController(objWebSiteOpenUrlViewController, animated: true)
        */
        var stringUrl:String!=""
        stringUrl=muarrayHoldInfo.object(at: 5)as! String
        if(stringUrl.contains("http"))
        {
            
        }
        else
        {
            stringUrl="http://"+stringUrl
        }
        let url = URL (string: (stringUrl));
        print(url)
        
        let requestObj = URLRequest(url: url!);
        print("http://-----------------------")
        
        if let url = NSURL(string: stringUrl){
//            UIApplication.shared.openURL(url as URL)
            
            if UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL, options: [:]) { success in
                        if success {
                            print("The URL was successfully opened.")
                        } else {
                            print("Failed to open the URL.")
                        }
                    }
                }
        }
    }
    
    //MARK:- Extra PDF methods by Harshada
    func getCurrentDate() -> String
    {
        let date=Date()
        let formatter=DateFormatter()
        formatter.dateFormat="ddMMyyyyHHmmss"
        return formatter.string(from: date)
    }
    
    
    
    @objc func shareButtonClickEvent()
    {
        var headerImage:UIImage=UIImage()
        var footerImage:UIImage=UIImage()
        if(isCategory=="1")
        {
            headerImage=UIImage(named:"ClubHeader")!
            footerImage=UIImage(named: "common_footer.jpg")!
        }  
        else if(isCategory=="2")
        {
            headerImage=UIImage(named:"DistHeader")!
            footerImage=UIImage(named: "common_footer.jpg")!
        }
        else
        {
            headerImage=UIImage(named:"rt_header.jpg")!
            footerImage=UIImage(named: "rt_footer.png")!
        }
        
        let topView:UIView = UIView()
        topView.frame = CGRect(x: 0, y: 0, width: tableviewEventDetailNotiShare.contentSize.width, height: 95.0)
        topView.backgroundColor = UIColor.clear
        let headerImgView:UIImageView=UIImageView()
        headerImgView.frame = CGRect(x: 0, y: 0, width: tableviewEventDetailNotiShare.contentSize.width, height: 95.0)
        headerImgView.image=headerImage
        topView.addSubview(headerImgView)
        
        let headerLabel:UILabel=UILabel()
        headerLabel.frame=CGRect(x: 0, y: 60, width: tableviewEventDetailNotiShare.contentSize.width, height: 35.0)
        headerLabel.backgroundColor=UIColor.clear
        if grpName.contains("Rotary India")
        {
           headerLabel.text=""
        }
        else
        {
        headerLabel.text=grpName!
        }
        headerLabel.font=UIFont(name: "Roboto-Regular", size: 18)
        headerLabel.textColor=UIColor.white
        headerLabel.textAlignment=NSTextAlignment.center
        topView.addSubview(headerLabel)
        topView.bringSubviewToFront( headerLabel)
        
        tableviewEventDetailNotiShare.tableHeaderView = topView
        
        let bottomView:UIView = UIView()
        bottomView.frame = CGRect(x: 0, y: 0, width: tableviewEventDetailNotiShare.contentSize.width, height: 45.0)
        bottomView.backgroundColor = UIColor.clear
        
        let footerImgView:UIImageView=UIImageView()
        footerImgView.frame = CGRect(x: 0, y: 0, width: tableviewEventDetailNotiShare.contentSize.width, height: 45.0)
        footerImgView.image=footerImage
        bottomView.addSubview(footerImgView)
        tableviewEventDetailNotiShare.tableFooterView = bottomView
        sharePDFTo(url:createPDFDataFromTableView(tableView: tableviewEventDetailNotiShare))
    }
    
    func sharePDFTo(url:NSURL)
    {
        // let url = createPDFDataFromTableView(tableView: tableviewEventDetailNoti)
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView=self.view
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                 self.removePDFFiles()
                return
            }
             self.removePDFFiles()
        }
        self.present(activityViewController, animated: true, completion: nil)
    }

    
    func removePDFFiles()
    {
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            for fileURL in fileURLs {
                
                let filName:String=fileURL.lastPathComponent
                let extensionL:String=fileURL.pathExtension
                if extensionL == "pdf" && filName.contains("\(FileNameToDelete)") {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
        } catch  { //print(error)
            
        }
    }
    
    func createPDFDataFromTableView(tableView: UITableView) -> NSURL {
        let priorBounds = tableView.bounds
        let fittedSize = tableView.sizeThatFits(CGSize(width:priorBounds.size.width, height:tableView.contentSize.height))
        tableView.bounds = CGRect(x:0, y:0, width:fittedSize.width, height:fittedSize.height)
        let pdfPageBounds = CGRect(x:0, y:0, width:tableView.frame.width, height:self.tableviewEventDetailNotiShare.contentSize.height)
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds,nil)
        var pageOriginY: CGFloat = 0
        while pageOriginY < fittedSize.height {
            UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
            UIGraphicsGetCurrentContext()!.saveGState()
            UIGraphicsGetCurrentContext()!.translateBy(x: 0, y: -pageOriginY)
            tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
            UIGraphicsGetCurrentContext()!.restoreGState()
            pageOriginY += pdfPageBounds.size.height
            print(pageOriginY)
        }
        UIGraphicsEndPDFContext()
        tableView.bounds = priorBounds
        
        //try saving in doc dir to confirm:
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        self.ticksnew = getCurrentDate()
        var title:String=""
        if let tit=muarrayHoldInfo.object(at: 1)as? String
        {
            title=tit
        }
        var dateTime:String=""
        if let datTime=muarrayHoldInfo.object(at: 4)as? String
        {
            dateTime=datTime
        }
        //        let fileName:String!="ROW_Event_\(self.ticksnew!).pdf"
        let fileName:String!="\(title)_\(dateTime).pdf"
        FileNameToDelete=fileName
        
        let path = dir?.appendingPathComponent(fileName!)
        
        do {
            try pdfData.write(to: path!, options: NSData.WritingOptions.atomic)
        } catch {
            print("error catched")
        }
        return path! as NSURL
    }

}
