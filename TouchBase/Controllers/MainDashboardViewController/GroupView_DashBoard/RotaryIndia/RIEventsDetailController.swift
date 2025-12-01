//
//  EventsDetailController.swift
//  TouchBase
//
//  Created by Kaizan on 17/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
import EventKit

class RIEventsDetailController: UIViewController , UITableViewDataSource,UITableViewDelegate , webServiceDelegate,eventImgDelegate ,eventdetcellDelegate,protocolNameBackImage,protocolForEventsListingCallingApi{
    
    //MARK:- All IBOutlet Declaration
    
    @IBOutlet weak var buttonOpacityWhenShare: UIButton!
    @IBOutlet weak var viewShareEvent: UIView!
    @IBOutlet weak var tableviewShareEventDetailShare: UITableView!
    @IBOutlet var EventsDetailTableView: UITableView!
    @IBOutlet weak var buttonProgrssBar: UIButton!
    @IBOutlet var QuestionViewOptions: UIView!
    @IBOutlet var QuestionViewWritten: UIView!
    @IBOutlet weak var buttonNo: UIButton!
    @IBOutlet weak var buttonMayBe: UIButton!
    @IBOutlet weak var buttonYes: UIButton!
    @IBOutlet weak var buttonAddToCalendar: UIButton!
    @IBOutlet var QuestionContainerVC: UIView!
    @IBOutlet var QuestionViewContainer: UIView!
    @IBOutlet var optionQuestionLabel: UILabel!
    @IBOutlet var yesOptionButton: UIButton!
    @IBOutlet var noOptionButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var div1ImageView: UIImageView!
    @IBOutlet var div2ImageView: UIImageView!
    @IBOutlet var QuestionLabel: UILabel!
    @IBOutlet var AnswerTextField: UITextField!
    @IBOutlet var closeButton1: UIButton!
    @IBOutlet var div1ImgView: UIImageView!
    @IBOutlet var submitBtn: UIButton!

    //MARK:- Variable Declaration
    var grpName:String!=""
    var isSharebuttonClick:Bool=false
    var FileNameToDelete:String=""
    var memberProfileId:String=""
    var ticksnew:String!=""
    var objprotocolForEventsListingCallingApi:protocolForEventsListingCallingApi?=nil
    var longLink:NSURL?
    var shortLink:NSURL?
    var varRSVPCheckOnOff:String!=""
    let bounds = UIScreen.main.bounds
    var grpDetail:GroupList!
    var eventDetail : EventList!
    var isCalled:NSString!
    var varIsRSVPEnableorDisable:Int=0
    var eventID:NSString!
    var profileId:String!=""
    var grpId:NSString!
    var grpIdForCheckDifference:NSString!
    var grpDetailPrevious = NSDictionary ()
    var moduleName:String! = ""
    var isCategory:String! = ""
    var varType:String!=""
    var ExpiredStr = String()
    var isAdmin:String!=""
    var SMSCountStr : String!
    var eventFilterCheck:String? = ""
    var mainArray = NSArray()
    var joiningStatus :String = ""
    var optionANS : String = ""
    var questionID : String = ""
    let boundss = UIScreen.main.bounds
    var appDelegate : AppDelegate!
    override var prefersStatusBarHidden: Bool {
        return false
    }
    var muarrayShare:NSMutableArray=NSMutableArray()
    var cellShare:EventsDetailShareTableViewCell = EventsDetailShareTableViewCell()
    var TotalCount:Int!=0
    var YesCount:Int!=0
    var NoCount:Int!=0
    var MaybeCount:Int!=0
    var getText:String!=""
    var imageScreenShot:String!=""
    var TitleNew:String!=""
    var Description:String!=""
    var Venue:String!=""
    var eventDateTime:String!=""
    var reglink:String!=""
    var webUrl:String!=""
    var varRowHeight:CGFloat!=0.0


    //MARK:- All IBAction Declaration
    @IBAction func buttonOpacityWhenShareClickEvent(_ sender: Any) {
    }
    
    @IBAction func buttonShareClickEvent(_ sender: Any)
    {
        tableviewShareEventDetailShare.reloadData()
        viewShareEvent.isHidden=false
         DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.pdfDataWithTableView(tableView: self.tableviewShareEventDetailShare)
            let fileManager = FileManager.default
            if let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
                var fileURL = URL(string: "")
                var fullURL:String!=""
                fullURL="Event"+self.ticksnew+".pdf"
                fileURL = documentsURL.appendingPathComponent(fullURL)
                let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [fileURL!], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView=self.view
                self.present(activityViewController, animated: true, completion: nil)
            }
         })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.viewShareEvent.isHidden=true
          })
    }
    
    @IBAction func addTocalenderClickEvent(_ sender: Any) {
        addEventToCalendarss()
    }
    
    @IBAction func NextButtonAction(_ sender: AnyObject)
    {
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "events") as UIViewController, animated: true) // group_detail  , directory , events
    }

    
    @IBAction func GoingToEvent(_ sender: AnyObject)
    {
        joiningStatus = "yes"
        
        let eventsDetails:EventsDetail=mainArray.object(at: 0) as!  EventsDetail
        print("Going to Event details \(eventsDetails.option1)")
        if eventsDetails.isQuesEnable != "0"
        {
            if eventsDetails.questionType == "1"
            {
                
                QuestionViewWritten.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
                AnswerTextField.becomeFirstResponder()
                QuestionLabel.text = eventsDetails.questionText
                questionID = eventsDetails.questionId
                
                if(eventsDetails.questionText as! String == "Tap to add Question" || eventsDetails.questionText as! String == "")
                {
                    
                    joiningStatus = "yes"
                    optionANS = ""
                    questionID = ""
                    QuestionsWebService()
                }
                else
                {
                    AnswerTextField.text! = ""
                    self.view .addSubview(QuestionViewWritten)
                }
                
                let font1 = UIFont(name: "Roboto-Regular", size: 17.0)
                
                let height = heightForView(eventsDetails.questionText, font: QuestionLabel.font, width: 275.0)
                QuestionContainerVC.translatesAutoresizingMaskIntoConstraints = true
                QuestionContainerVC.frame=CGRect(x: (boundss.width-275)/2, y: (boundss.height-height)/2, width: 275, height: height+120)
                QuestionLabel.translatesAutoresizingMaskIntoConstraints = true
                QuestionLabel.frame=CGRect(x: 8, y: 25, width: 260, height: height)
                closeButton1.translatesAutoresizingMaskIntoConstraints = true
                closeButton1.frame=CGRect(x: 245, y: 5, width: 20, height: 23)
                div1ImgView.translatesAutoresizingMaskIntoConstraints = true
                div1ImgView.frame=CGRect(x: 0, y: (25+height+46), width: 275, height: 1)
                AnswerTextField.translatesAutoresizingMaskIntoConstraints = true
                AnswerTextField.frame=CGRect(x: 8, y: (25+height+3), width: 260, height: 40)
                submitBtn.translatesAutoresizingMaskIntoConstraints = true
                submitBtn.frame=CGRect(x: 0, y: (25+height+52), width: 260, height: 40)
                
            }
            else if eventsDetails.questionType == "2"
            {
                QuestionViewOptions.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
                self.view .addSubview(QuestionViewOptions)
                
                yesOptionButton.setTitle(eventsDetails.option1,  for: UIControl.State.normal)
                noOptionButton.setTitle(eventsDetails.option2,  for: UIControl.State.normal)
                questionID = eventsDetails.questionId
                optionQuestionLabel.text = String(format:"%@",eventsDetails.questionText)
                let font1 = UIFont(name: "Roboto-Regular", size: 17.0)
                
                let height = heightForView(eventsDetails.questionText, font: optionQuestionLabel.font, width: 260.0)
                //print(height)
                QuestionViewContainer.translatesAutoresizingMaskIntoConstraints = true
                QuestionViewContainer.frame=CGRect(x: (boundss.width-275)/2, y: (boundss.height-height)/2, width: 275, height: height+90)
                optionQuestionLabel.translatesAutoresizingMaskIntoConstraints = true
                optionQuestionLabel.frame=CGRect(x: 8, y: 25, width: 260, height: height)
                closeButton.translatesAutoresizingMaskIntoConstraints = true
                closeButton.frame=CGRect(x: 245, y: 5, width: 20, height: 23)
                div1ImageView.translatesAutoresizingMaskIntoConstraints = true
                div1ImageView.frame=CGRect(x: 0, y: (25+height), width: 275, height: 1)
                yesOptionButton.translatesAutoresizingMaskIntoConstraints = true
                yesOptionButton.frame=CGRect(x: 0, y: (25+height+10), width: 136, height: 40)
                noOptionButton.translatesAutoresizingMaskIntoConstraints = true
                noOptionButton.frame=CGRect(x: 137, y: (25+height+10), width: 105, height: 40)
                div2ImageView.translatesAutoresizingMaskIntoConstraints = true
                div2ImageView.frame=CGRect(x: 139, y: (25+height+15), width: 1, height: 35)
            }
            else{}
            
        }
        else
        {
            joiningStatus = "yes"
            optionANS = ""
            questionID = ""
            QuestionsWebService()
        }
    }
    
    
    @IBAction func NotGoingToEvent(_ sender: AnyObject)
    {
        //print("NNOOOOOOOOOO")
        joiningStatus = "no"
        optionANS = ""
        questionID = ""
        
        QuestionsWebService()
        
        
    }
    
    @IBAction func MayBeGoingToEvent(_ sender: AnyObject)
    {
        //print("MMMAAYYY BBEE")
        joiningStatus = "maybe"
        optionANS = ""
        questionID = ""
        QuestionsWebService()
    }
    
    @IBAction func YesOptionAction(_ sender: AnyObject)
    {
        optionANS = (yesOptionButton.titleLabel?.text)!
        //print(optionANS)
        QuestionsWebService()
        
    }
    
    @IBAction func NoOptionAction(_ sender: AnyObject)
    {
        optionANS = (noOptionButton.titleLabel?.text)!
        QuestionsWebService()
    }
    
    @IBAction func SubmitButtonAction(_ sender: AnyObject)
    {
        optionANS = AnswerTextField.text!
        QuestionsWebService()
    }
    
    @IBAction func CloseViewAction(_ sender: AnyObject)
    {
        closeKB()
        QuestionViewWritten.removeFromSuperview()
        QuestionViewOptions.removeFromSuperview()
    }

    @IBAction func buttoncLICK(_ sender: Any) {
        // //print(varWebSite)
        let objWebSiteOpenUrlViewController = self.storyboard!.instantiateViewController(withIdentifier: "EventDetailNotiViewController") as! EventDetailNotiViewController
        self.navigationController?.pushViewController(objWebSiteOpenUrlViewController, animated: true)
    }
    
    //MARK:- Normal Methods
    
    func shareButtonClickEventBackup()
    {
        buttonOpacityWhenShare.isHidden=false

        tableviewShareEventDetailShare.reloadData()
        viewShareEvent.isHidden=false
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            // Put your code which should be executed with a delay here
            //-------------
            //print("This is share button clicked from screen event details ")
            self.pdfDataWithTableView(tableView: self.tableviewShareEventDetailShare)
            let fileManager = FileManager.default
            if let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
                var fileURL = URL(string: "")
                
                var fullURL:String!=""
                fullURL="Event"+self.ticksnew+".pdf"
                //print("this is url value !!!!!")
                //print(fullURL)
                
                fileURL = documentsURL.appendingPathComponent(fullURL)
                
                //print("This is file url !!!!!")
                //print(fileURL)
                let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [fileURL!], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView=self.view
               
                //--
                activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                    if !completed {
                        // User canceled
                        //print("cancel clicked ")
                        return
                    }
                    // User completed activity
                     //print("other  clicked ")
                }
                //---
                
                
                
                self.present(activityViewController, animated: true, completion: nil)
            }
            //------------
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.viewShareEvent.isHidden=true
        })
        
        
        
    }
    
    func pdfDataWithTableView(tableView: UITableView) {
        let priorBounds = tableView.bounds
        let fittedSize = tableView.sizeThatFits(CGSize(width:priorBounds.size.width, height:tableView.contentSize.height))
        tableView.bounds = CGRect(x:0, y:0, width:fittedSize.width, height:fittedSize.height)
        let pdfPageBounds = CGRect(x:0, y:0, width:tableView.frame.width, height:self.view.frame.height)
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
            //print("this is height!!!!!!!")
            //print(pageOriginY)
        }
        UIGraphicsEndPDFContext()
        tableView.bounds = priorBounds
        var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        var fullURL:String!=""
        fullURL="Event"+self.ticksnew+".pdf"
        docURL = docURL.appendingPathComponent(fullURL)
        pdfData.write(to: docURL as URL, atomically: true)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        tableviewShareEventDetailShare.reloadData()
        print("is FileToRemove Available \(FileNameToDelete)")
    }
    
    
    
    func functionForEventsListingCallingApi(stringFromWhereITCalling: String) {
        
        createNavigationBar()
        buttonProgrssBar.isHidden=true
        SVProgressHUD.show()
        self.buttonYes.isHidden = true
        self.buttonNo.isHidden = true
        self.buttonMayBe.isHidden = true
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        EventsDetailTableView.estimatedRowHeight = 285.0
        tableviewShareEventDetailShare.estimatedRowHeight=285.0
        EventsDetailTableView.rowHeight = UITableView.automaticDimension
        tableviewShareEventDetailShare.rowHeight=UITableView.automaticDimension
        mainArray = NSArray()
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self  //grpDetail.masterProfileID
            wsm.getEventsDetail(groupProfileID: profileId, grpID: grpId, eventID: eventID)
    }


    func functionForBackImage(imageImageNew:UIImage)
    {
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageToShare = [ imageImageNew,"http://www.roster.com" ] as [Any]
        let image = imageImageNew.images
        let activityViewController = UIActivityViewController( activityItems: imageToShare, applicationActivities: nil )
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        /*---this is event id or more */
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileId = UserDefaults.standard.string(forKey: "masterUID")
        buttonOpacityWhenShare.isHidden=true
        viewShareEvent.isHidden=true
        isVisitedAddEventsScreen=0
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.view.backgroundColor = UIColor.white
        buttonProgrssBar.isHidden=true
        SVProgressHUD.show()
        self.buttonAddToCalendar.layer.borderColor=UIColor.white.cgColor
        self.buttonAddToCalendar.layer.borderWidth=1.0
        self.buttonYes.isHidden = true
        self.buttonNo.isHidden = true
        self.buttonMayBe.isHidden = true
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        EventsDetailTableView.estimatedRowHeight = 285.0
        tableviewShareEventDetailShare.estimatedRowHeight=285.0
        EventsDetailTableView.rowHeight = UITableView.automaticDimension
        tableviewShareEventDetailShare.rowHeight=UITableView.automaticDimension
        
        mainArray = NSArray()
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        wsm.getEventsDetail(groupProfileID: profileId, grpID: grpId, eventID: eventID)
        createNavigationBar()
    }

    func createNavigationBar(){
        self.title="Event"
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(EventsDetailController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        shareButton.addTarget(self, action: #selector(EventsDetailController.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        let shareButtonAdd: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
        self.navigationItem.rightBarButtonItem = shareButtonAdd
    }
    
    @objc func backClicked()
    {
       self.navigationController?.popViewController(animated: true)
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    func getEventsDetailsSuccess(eventsDetails : EventsListDetailResult)
    {
        var image:String!=""
        var Title:String!=""
        var Desc:String!=""
        var Venue:String!=""
        var EventDate:String!=""
        var Link:String!=""
        var TotalYesNoMaybe:String!=""
        var TotalYes:String!=""
        var TotalNo:String!=""
        var TotalMaybe:String!=""
        var yourYesNoMaybe:String!=""
        
        image=((((myTempDictForScreenShotDataHolding.value(forKey: "EventsListDetailResult") as AnyObject).value(forKey: "EventsDetailResult")as AnyObject).object(at: 0)as AnyObject).value(forKey: "EventsDetail")as AnyObject).value(forKey: "eventImg") as! String
        Title=((((myTempDictForScreenShotDataHolding.value(forKey: "EventsListDetailResult") as AnyObject).value(forKey: "EventsDetailResult")as AnyObject).object(at: 0)as AnyObject).value(forKey: "EventsDetail")as AnyObject).value(forKey: "eventTitle") as! String
        
        
        
        Desc=((((myTempDictForScreenShotDataHolding.value(forKey: "EventsListDetailResult") as AnyObject).value(forKey: "EventsDetailResult")as AnyObject).object(at: 0)as AnyObject).value(forKey: "EventsDetail")as AnyObject).value(forKey: "eventDesc") as! String
        Venue=((((myTempDictForScreenShotDataHolding.value(forKey: "EventsListDetailResult") as AnyObject).value(forKey: "EventsDetailResult")as AnyObject).object(at: 0)as AnyObject).value(forKey: "EventsDetail")as AnyObject).value(forKey: "venue") as! String
        EventDate=((((myTempDictForScreenShotDataHolding.value(forKey: "EventsListDetailResult") as AnyObject).value(forKey: "EventsDetailResult")as AnyObject).object(at: 0)as AnyObject).value(forKey: "EventsDetail")as AnyObject).value(forKey: "eventDateTime") as! String
        
        
        Link=((((myTempDictForScreenShotDataHolding.value(forKey: "EventsListDetailResult") as AnyObject).value(forKey: "EventsDetailResult")as AnyObject).object(at: 0)as AnyObject).value(forKey: "EventsDetail")as AnyObject).value(forKey: "reglink") as! String
        
        
        
        TotalYesNoMaybe=((((myTempDictForScreenShotDataHolding.value(forKey: "EventsListDetailResult") as AnyObject).value(forKey: "EventsDetailResult")as AnyObject).object(at: 0)as AnyObject).value(forKey: "EventsDetail")as AnyObject).value(forKey: "totalCount") as! String
        
        
        
        TotalYes=((((myTempDictForScreenShotDataHolding.value(forKey: "EventsListDetailResult") as AnyObject).value(forKey: "EventsDetailResult")as AnyObject).object(at: 0)as AnyObject).value(forKey: "EventsDetail")as AnyObject).value(forKey: "goingCount") as! String
        
        
        TotalNo=((((myTempDictForScreenShotDataHolding.value(forKey: "EventsListDetailResult") as AnyObject).value(forKey: "EventsDetailResult")as AnyObject).object(at: 0)as AnyObject).value(forKey: "EventsDetail")as AnyObject).value(forKey: "notgoingCount") as! String
        
        
        TotalMaybe=((((myTempDictForScreenShotDataHolding.value(forKey: "EventsListDetailResult") as AnyObject).value(forKey: "EventsDetailResult")as AnyObject).object(at: 0)as AnyObject).value(forKey: "EventsDetail")as AnyObject).value(forKey: "maybeCount") as! String
        
        yourYesNoMaybe=((((myTempDictForScreenShotDataHolding.value(forKey: "EventsListDetailResult") as AnyObject).value(forKey: "EventsDetailResult")as AnyObject).object(at: 0)as AnyObject).value(forKey: "EventsDetail")as AnyObject).value(forKey: "myResponse") as! String
        
        grpName=((((myTempDictForScreenShotDataHolding.value(forKey: "EventsListDetailResult") as AnyObject).value(forKey: "EventsDetailResult")as AnyObject).object(at: 0)as AnyObject).value(forKey: "EventsDetail")as AnyObject).value(forKey: "grpname") as! String
        
        muarrayShare.add(image)
        muarrayShare.add(Title)
        muarrayShare.add(Desc)
        muarrayShare.add(Venue)
        muarrayShare.add(eventDateTime)
        muarrayShare.add(Link)
        muarrayShare.add(TotalYesNoMaybe)
        muarrayShare.add(TotalYes)
        muarrayShare.add(TotalNo)
        muarrayShare.add(TotalMaybe)
        
        if(yourYesNoMaybe=="")
        {
            yourYesNoMaybe="YES, You have accepted the invite to this event"
        }
        else  if(yourYesNoMaybe=="")
        {
            yourYesNoMaybe="No, You have declined the invite to this event"
        }
        else  if(yourYesNoMaybe=="")
        {
            yourYesNoMaybe="You have not confirmed tattendence"
        }
        else
        {
            yourYesNoMaybe="You have not responded to this invite"
        }
        
        muarrayShare.add(yourYesNoMaybe)
        mainArray = eventsDetails.eventsDetailResult as NSArray
        
        print("Check Main Array:: \(mainArray)")
        
        for i in 0 ..< mainArray.count
        {
            let evtdetail:EventsDetail=mainArray.object(at: i) as!  EventsDetail
            print("Event Image::: \(evtdetail.eventImg)")
            print("Event option  \(evtdetail.option1)")
        }
        
        
        
        if(mainArray.count>0)   //DPK handled  27-03-2018
        {
            EventsDetailTableView.reloadData()
            tableviewShareEventDetailShare.reloadData()
            
            let letGetFilterTypeValue =    UserDefaults.standard.value(forKey: "session_GetFilterTypeValue")as! String
            if letGetFilterTypeValue == "3"
            {
                ExpiredStr = "Yes"
            }
            else
            {
                ExpiredStr = ""
            }
        }
        else
        {   /*--------------DPK--------------------27-03-2018-----------*/
            //print("Array is nillllllllllllllll")
            let alert = UIAlertController(title: "Rotary India", message: "No Result", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                
                self.objprotocolForEventsListingCallingApi?.functionForEventsListingCallingApi(stringFromWhereITCalling: "itCallingFrom-edit Evewnts screen 4")
                self.navigationController?.popViewController(animated: true)
            }));
            self.present(alert, animated: true, completion: nil)
            
            /*--------------DPK--------------------27-03-2018-----------*/
        }
        
        var eventsDetails = EventsDetail()
        eventsDetails = mainArray.object(at: 0) as!  EventsDetail
        isAdmin = eventsDetails.isAdmin
        self.createNavigationBar()
        eventsDetails = mainArray.object(at: 0) as!  EventsDetail
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // return 2
        
        if(tableView==EventsDetailTableView)
        {
            return 2
        }
        else if(tableView==tableviewShareEventDetailShare)
        {
            return 2
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(tableView==EventsDetailTableView)
        {
            return 1
        }
        else if(tableView==tableviewShareEventDetailShare)
        {
            return 1
        }
        return 1
    }
    

    @objc func buttonLinkClickEvent(_ sender:UIButton)
    {
        if(sender.titleLabel?.text == nil)
        {
            
        }
        else
        {
            var getValue = sender.titleLabel?.text
            if(getValue?.contains("<null>"))!
            {
                //print("if")
            }
            else
            {
                var stringUrl:String!=""
                stringUrl=webUrl
                //--
                if(stringUrl.contains("http"))
                {
                    
                }
                else
                {
                    stringUrl="http://"+stringUrl
                }
                let url = URL (string: (stringUrl));
                
                let requestObj = URLRequest(url: url!);
                
                if let url = NSURL(string: stringUrl){
//                    UIApplication.shared.openURL(url as URL)
                    
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
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(tableView==tableviewShareEventDetailShare)
        {
            return tableviewShareEventDetailShare.rowHeight
        }
        return EventsDetailTableView.rowHeight
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:EventDetailCell=EventDetailCell()
        if(tableView==EventsDetailTableView)
        {
            if(indexPath.section == 0)
            {
                // alertController.dismiss(animated: true, completion: nil)
                
                cell = EventsDetailTableView.dequeueReusableCell(withIdentifier: "eventDetCell", for: indexPath) as! EventDetailCell
                
                if mainArray.count > 0
                {
                    SVProgressHUD.dismiss()
                    buttonProgrssBar.isHidden=true
                    EventsDetailTableView.isHidden=false
                    var eventsDetails = EventsDetail()
                    eventsDetails = mainArray.object(at: indexPath.row) as!  EventsDetail
                    
                    cell.eventNameLabel.text =  eventsDetails.eventTitle //"erteiurs hkjfjkf jkqw rewiroio ds gfdfghdf  lshglewhre  ejlghejkhge  lwehrgjkewhrg k  erjhe"
                    
                    TitleNew=eventsDetails.eventTitle
                    
                    cell.eventDetailLabel.text =  eventsDetails.eventDesc
                    
                    Description=eventsDetails.eventDesc
                    
                    
                    //"youi are the most dash dash person inthe world u knw wht u this about me , I dnt cate about dat bcz I am the king powweeerrr, hahahahahahahah let do it buddy , because project X is not far from us , lets do it, \n\n\n erteiurs hkjfjkf jkqw rewiroio ds gfdfghdf  lshglewhre  ejlghejkhge  lwehrgjkewhrg k  erjhe"
                    cell.indicator.startAnimating()
                    if(eventsDetails.eventImg == ""){
                        cell.EventPic.translatesAutoresizingMaskIntoConstraints = true
                        cell.EventPic.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 0)
                        cell.indicator.stopAnimating()
                        cell.imgClkBtn.isHidden=true
                        
                    }else{
                        cell.EventPic.translatesAutoresizingMaskIntoConstraints = true
                        cell.EventPic.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 171)
                        cell.imgUrl=eventsDetails.eventImg as! NSString;
                        cell.imgClkBtn.isHidden=false
                        cell.delegates=self;
                    }
                    if let checkedUrl = URL(string: eventsDetails.eventImg ) {
                        
                        imageScreenShot=eventsDetails.eventImg
                        cell.EventPic.sd_setImage(with: checkedUrl)
                        print("Image url of club event from dist calender:: \(checkedUrl)")
                        cell.indicator.stopAnimating()
                    }
                }
                
                return cell
            }
            else
            {
                let cell = EventsDetailTableView.dequeueReusableCell(withIdentifier: "eventDescCell", for: indexPath) as! EventDesctiptCell
                
                if mainArray.count > 0
                {
                    var eventsDetails = EventsDetail()
                    eventsDetails = mainArray.object(at: indexPath.row) as!  EventsDetail
                    var getValue:String! =  UserDefaults.standard.value(forKey: "session_LinkValue") as! String
                    reglink=getValue
                    if(getValue=="nothing")
                    {
                        webUrl="nothing"
                        cell.labelLink.isHidden=true
                        cell.buttonLinkEvent.isHidden=true
                    }
                    else
                    {
                        cell.buttonLinkEvent.setTitle(getValue, for: .normal)
                        webUrl=getValue
                        cell.labelLink.isHidden=false
                        cell.buttonLinkEvent.isHidden=false
                        cell.labelLink.text="Link"
                    }

                    cell.buttonLinkEvent.addTarget(self, action: #selector(buttonLinkClickEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    cell.locImageView.image=UIImage(named: "location.png")
                    cell.dotImageView.image=UIImage(named: "dot.png")
                    
                    cell.eventAddressLabel.isUserInteractionEnabled=true
                    cell.eventAddressLabel.text =  eventsDetails.venue
                    Venue=eventsDetails.venue
                    cell.eventDateTimeLabel.text =  eventsDetails.eventDateTime
                    eventDateTime=eventsDetails.eventDateTime
                    
                    
                    cell.delegates=self
                    cell.venueLat=eventsDetails.venueLat as! NSString
                    cell.venueLon=eventsDetails.venueLon as! NSString
                    
                    
                    
                    if eventsDetails.myResponse == "yes"
                    {
                        if eventsDetails.goingCount == "1"
                        {
                            cell.eventAttendingLabel.text=""
                            cell.eventANSLabel.text = String(format:"YES, You have accepted the invite to this event.")
                            getText="YES, You have accepted the invite to this event."
                        }
                        else
                        {
                            cell.eventAttendingLabel.text=""
                            cell.eventANSLabel.text = String(format:"YES, You have accepted the invite to this event.")
                            getText="YES, You have accepted the invite to this event."

                        }
                        cell.eventANSLabel.textColor = UIColor(red: (76/255.0), green: (175/255.0), blue: (80/255.0), alpha: 1.0)
                        cell.dotImageView.image = UIImage(named: "dot.png")
                        cell.NOLabel.isHidden = true
                        cell.MayBELabel.isHidden = true
                        cell.NOdotImageView.isHidden = true
                        cell.MayBEdotImageView.isHidden = true
                        cell.eventAttendingLabel.isHidden = true
                        cell.eventANSLabel.isHidden = false
                        cell.dotImageView.isHidden = true
                        
                    }
                    else if eventsDetails.myResponse == "no"
                    {
                        cell.eventAttendingLabel.text=""
                        cell.dotImageView.image = UIImage(named: "dot_red.png")
                        cell.NOLabel.isHidden = true
                        cell.MayBELabel.isHidden = true
                        cell.NOdotImageView.isHidden = true
                        cell.MayBEdotImageView.isHidden = true
                        cell.eventAttendingLabel.isHidden = true
                        cell.eventANSLabel.isHidden = false
                        cell.dotImageView.isHidden = true
                        cell.eventANSLabel.text = "NO, You have declined the invite to this event."
                        getText="NO, You have declined the invite to this event."
                        cell.eventANSLabel.textColor = UIColor(red: (255/255.0), green: (76/255.0), blue: (77/255.0), alpha: 1.0)
                    }
                    else if eventsDetails.myResponse == "maybe"
                    {
                        cell.eventAttendingLabel.text=""
                        cell.eventANSLabel.text = "You have not confirmed attendence."
                        getText="You have not confirmed attendence."
                        cell.eventANSLabel.textColor = UIColor(red: (114/255.0), green: (114/255.0), blue: (114/255.0), alpha: 1.0)
                        cell.dotImageView.image = UIImage(named: "dot_gray.png")
                        cell.NOLabel.isHidden = true
                        cell.MayBELabel.isHidden = true
                        cell.NOdotImageView.isHidden = true
                        cell.MayBEdotImageView.isHidden = true
                        cell.eventAttendingLabel.isHidden = true
                        cell.eventANSLabel.isHidden = false
                        cell.dotImageView.isHidden = true
                    }
                    else
                    {
                        cell.eventAttendingLabel.text = "You have not responded to this invite."
                        cell.eventAttendingLabel.isHidden = false
                        
                        cell.NOdotImageView.isHidden = true
                        cell.NOLabel.isHidden = true
                        
                        cell.MayBEdotImageView.isHidden = true
                        cell.MayBELabel.isHidden = true
                        
                        cell.eventANSLabel.isHidden = true
                        cell.dotImageView.isHidden = true
                    }
                    var a:String! = (eventsDetails.goingCount) as String
                    var b:String! = (eventsDetails.notgoingCount) as String
                    var c:String! = (eventsDetails.maybeCount) as String
                    
                    
                    var varGetA:Int!=0
                    var varGetB:Int!=0
                    var varGetC:Int!=0
                   var eventgroupId:NSString!=eventsDetails.grpID! as NSString
                        if ((eventsDetails.rsvpEnable)as String == "0"  || (eventsDetails.filterType)as String == "3" || (self.grpId != eventgroupId))
                        {
                            self.buttonYes.isHidden = true
                            self.buttonNo.isHidden = true
                            self.buttonMayBe.isHidden = true
                            cell.eventAttendingLabel.isHidden=true
                            cell.eventGoingResponceLabel.isHidden=true
                            cell.img1.isHidden=true
                            cell.img2.isHidden=true
                            cell.eventANSLabel.isHidden=true //
                            
                        }
                        else
                        {
                            
                            var getIds:String!=""
                            getIds=eventsDetails.grpID
                            var getIds2:String!=""
                            getIds2=grpIdForCheckDifference as String!
                            if((getIds2 != getIds)  && isCategory=="2")
                            {
                                self.buttonYes.isHidden = true
                                self.buttonNo.isHidden = true
                                self.buttonMayBe.isHidden = true
                                
                                cell.eventAttendingLabel.isHidden=true
                                cell.eventGoingResponceLabel.isHidden=true
                                cell.img1.isHidden=true
                                cell.img2.isHidden=true
                            }
                            else
                            {
                                self.buttonYes.isHidden = false
                                self.buttonNo.isHidden = false
                                self.buttonMayBe.isHidden = false
                                
                                cell.eventAttendingLabel.isHidden=false
                                cell.eventGoingResponceLabel.isHidden=false
                                cell.img1.isHidden=false
                                cell.img2.isHidden=false
                            }
                        }
                        
                    
                    /////
                    //1.
                    if(a.characters.count<=0 || a==nil)
                    {
                        varGetA=0
                    }
                    else
                    {
                        varGetA=Int(a)
                    }
                    //2.
                    if(b.characters.count<=0 || b==nil)
                    {
                        varGetB=0
                    }
                    else
                    {
                        varGetB=Int(b)
                    }
                    //3.
                    if(c.characters.count<=0 || c==nil)
                    {
                        varGetC=0
                    }
                    else
                    {
                        varGetC=Int(c)
                    }
                    var d:Int=0
                    
                    d=varGetA+varGetB+varGetC
                    
                    
                    TotalCount=d
                    YesCount=varGetA
                    NoCount=varGetB
                    MaybeCount=varGetC
                    
                    
                    
                    cell.eventGoingResponceLabel.text = String(format:"Total Response: %d   |  Yes: %@  |  No:  %@  |  Maybe:  %@" ,d, String(varGetA) ,String(varGetB),String(varGetC))
                    if isSharebuttonClick
                    {
                        cell.eventGoingResponceLabel.isHidden=true
                        cell.eventANSLabel.isHidden=true
                        cell.eventAttendingLabel.isHidden=true
                        cell.img1.isHidden=true
                        cell.img2.isHidden=true
                    }
                }
                return cell
            }
        }
        else if(tableView==tableviewShareEventDetailShare)
        {
            if(indexPath.section == 0)
            {
                cell = tableviewShareEventDetailShare.dequeueReusableCell(withIdentifier: "eventDetCellShare", for: indexPath) as! EventDetailCell
                
                if mainArray.count > 0
                {
                    SVProgressHUD.dismiss()
                    buttonProgrssBar.isHidden=true
                    EventsDetailTableView.isHidden=false
                    var eventsDetails = EventsDetail()
                    eventsDetails = mainArray.object(at: indexPath.row) as!  EventsDetail
                    
                    cell.eventNameLabel.text =  eventsDetails.eventTitle //"erteiurs
                    TitleNew=eventsDetails.eventTitle
                    
                    cell.eventDetailLabel.text =  eventsDetails.eventDesc
                    
                    Description=eventsDetails.eventDesc
                    cell.indicator.startAnimating()
                    if(eventsDetails.eventImg == ""){
                        cell.EventPic.translatesAutoresizingMaskIntoConstraints = true
                        cell.EventPic.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 0)
                        cell.indicator.stopAnimating()
                        cell.imgClkBtn.isHidden=true
                        
                    }else{
                        cell.EventPic.translatesAutoresizingMaskIntoConstraints = true
                        cell.EventPic.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 171)
                        cell.imgUrl=eventsDetails.eventImg as! NSString;
                        cell.imgClkBtn.isHidden=false
                        cell.delegates=self;
                    }
                    if let checkedUrl = URL(string: eventsDetails.eventImg ) {
                        
                        imageScreenShot=eventsDetails.eventImg
                        cell.EventPic.sd_setImage(with: checkedUrl)
                        cell.indicator.stopAnimating()
                    }
                }
                
                return cell
            }
            else
            {
                let cell = tableviewShareEventDetailShare.dequeueReusableCell(withIdentifier: "eventDescCellShare", for: indexPath) as! EventDesctiptCell
                
                if mainArray.count > 0
                {
                    var eventsDetails = EventsDetail()
                    eventsDetails = mainArray.object(at: indexPath.row) as!  EventsDetail
                    var getValue:String! =  UserDefaults.standard.value(forKey: "session_LinkValue") as! String
                    reglink=getValue
                    if(getValue=="nothing")
                    {
                        webUrl="nothing"
                        cell.labelLink.isHidden=true
                        cell.buttonLinkEvent.isHidden=true
                        
                    }
                    else
                    {
                        cell.buttonLinkEvent.setTitle(getValue, for: .normal)
                        webUrl=getValue
                        cell.labelLink.isHidden=false
                        cell.buttonLinkEvent.isHidden=false
                        cell.labelLink.text="Link"
                    }
                    
                    
                    
                    cell.buttonLinkEvent.addTarget(self, action: #selector(buttonLinkClickEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    
                    
                    
                    cell.locImageView.image=UIImage(named: "location.png")
                    cell.dotImageView.image=UIImage(named: "dot.png")
                    
                    print("Before Height of Address LAbel:: \(cell.eventAddressLabel.frame.height)")
                    cell.eventAddressLabel.text =  eventsDetails.venue
                    cell.eventAddressLabel.frame = CGRect(x: cell.eventAddressLabel.frame.origin.x, y: cell.eventAddressLabel.frame.origin.y, width: cell.eventAddressLabel.frame.width, height: self.heightForView1(text: eventsDetails.venue, font: cell.eventAddressLabel.font, width: cell.eventAddressLabel.frame.width))
                    

                    Venue=eventsDetails.venue
                    print("After Height of Address LAbel:: \(cell.eventAddressLabel.frame.height)")
                    
                    print("**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**")
                    cell.eventDateTimeLabel.text =  eventsDetails.eventDateTime //"21st Dec 2015 | 1:30 pm"
                    
                    eventDateTime=eventsDetails.eventDateTime
                    
                    
                    cell.delegates=self
                    cell.venueLat=eventsDetails.venueLat as! NSString
                    cell.venueLon=eventsDetails.venueLon as! NSString
                    
                    
                    
                    if eventsDetails.myResponse == "yes"
                    {
                        if eventsDetails.goingCount == "1"
                        {
                            cell.eventAttendingLabel.text=""
                            cell.eventANSLabel.text = String(format:"YES, You have accepted the invite to this event.")
                            getText="YES, You have accepted the invite to this event."
                        }
                        else
                        {
                            cell.eventAttendingLabel.text=""
                            cell.eventANSLabel.text = String(format:"YES, You have accepted the invite to this event.")
                            getText="YES, You have accepted the invite to this event."
                        }
                        cell.eventANSLabel.textColor = UIColor(red: (76/255.0), green: (175/255.0), blue: (80/255.0), alpha: 1.0)
                        cell.dotImageView.image = UIImage(named: "dot.png")
                        cell.NOLabel.isHidden = true
                        cell.MayBELabel.isHidden = true
                        cell.NOdotImageView.isHidden = true
                        cell.MayBEdotImageView.isHidden = true
                        cell.eventAttendingLabel.isHidden = true
                        cell.eventANSLabel.isHidden = false
                        cell.dotImageView.isHidden = true
                        
                    }
                    else if eventsDetails.myResponse == "no"
                    {
                        cell.eventAttendingLabel.text=""
                        cell.dotImageView.image = UIImage(named: "dot_red.png")
                        cell.NOLabel.isHidden = true
                        cell.MayBELabel.isHidden = true
                        cell.NOdotImageView.isHidden = true
                        cell.MayBEdotImageView.isHidden = true
                        cell.eventAttendingLabel.isHidden = true
                        cell.eventANSLabel.isHidden = false
                        cell.dotImageView.isHidden = true
                        cell.eventANSLabel.text = "NO, You have declined the invite to this event."
                        getText="NO, You have declined the invite to this event."
                        cell.eventANSLabel.textColor = UIColor(red: (255/255.0), green: (76/255.0), blue: (77/255.0), alpha: 1.0)
                    }
                    else if eventsDetails.myResponse == "maybe"
                    {
                        cell.eventAttendingLabel.text=""
                        cell.eventANSLabel.text = "You have not confirmed attendence."
                        getText="You have not confirmed attendence."
                        cell.eventANSLabel.textColor = UIColor(red: (114/255.0), green: (114/255.0), blue: (114/255.0), alpha: 1.0)
                        cell.dotImageView.image = UIImage(named: "dot_gray.png")
                        cell.NOLabel.isHidden = true
                        cell.MayBELabel.isHidden = true
                        cell.NOdotImageView.isHidden = true
                        cell.MayBEdotImageView.isHidden = true
                        cell.eventAttendingLabel.isHidden = true
                        cell.eventANSLabel.isHidden = false
                        cell.dotImageView.isHidden = true
                    }
                    else
                    {
                        cell.eventAttendingLabel.text = "You have not responded to this invite."
                        cell.eventAttendingLabel.isHidden = false
                        
                        cell.NOdotImageView.isHidden = true
                        cell.NOLabel.isHidden = true
                        
                        cell.MayBEdotImageView.isHidden = true
                        cell.MayBELabel.isHidden = true
                        
                        cell.eventANSLabel.isHidden = true
                        cell.dotImageView.isHidden = true

                    }
                    var a:String! = (eventsDetails.goingCount) as String
                    var b:String! = (eventsDetails.notgoingCount) as String
                    var c:String! = (eventsDetails.maybeCount) as String
                    
                    
                    var varGetA:Int!=0
                    var varGetB:Int!=0
                    var varGetC:Int!=0

                        var eventgroupId:NSString!=eventsDetails.grpID! as NSString
                        
                        if ((eventsDetails.rsvpEnable)as String == "0"  || (eventsDetails.filterType)as String == "3" || (self.grpId != eventgroupId))
                        {
                            self.buttonYes.isHidden = true
                            self.buttonNo.isHidden = true
                            self.buttonMayBe.isHidden = true
                            cell.eventAttendingLabel.isHidden=true
                            cell.eventGoingResponceLabel.isHidden=true
                            cell.img1.isHidden=true
                            cell.img2.isHidden=true
                            cell.eventANSLabel.isHidden=true //
                            
                        }
                        else
                        {
                            
                            var getIds:String!=""
                            getIds=eventsDetails.grpID
                            var getIds2:String!=""
                            getIds2=grpIdForCheckDifference as String!
                            if((getIds2 != getIds)  && isCategory=="2")
                            {
                                self.buttonYes.isHidden = true
                                self.buttonNo.isHidden = true
                                self.buttonMayBe.isHidden = true
                                
                                cell.eventAttendingLabel.isHidden=true
                                cell.eventGoingResponceLabel.isHidden=true
                                cell.img1.isHidden=true
                                cell.img2.isHidden=true
                            }
                            else
                            {
                                self.buttonYes.isHidden = false
                                self.buttonNo.isHidden = false
                                self.buttonMayBe.isHidden = false
                                
                                cell.eventAttendingLabel.isHidden=false
                                cell.eventGoingResponceLabel.isHidden=false
                                cell.img1.isHidden=false
                                cell.img2.isHidden=false
                            }
                        }
                        
                    
                    //1.
                    if(a.characters.count<=0 || a==nil)
                    {
                        varGetA=0
                    }
                    else
                    {
                        varGetA=Int(a)
                    }
                    //2.
                    if(b.characters.count<=0 || b==nil)
                    {
                        varGetB=0
                    }
                    else
                    {
                        varGetB=Int(b)
                    }
                    //3.
                    if(c.characters.count<=0 || c==nil)
                    {
                        varGetC=0
                    }
                    else
                    {
                        varGetC=Int(c)
                    }
                    var d:Int=0
                    
                    d=varGetA+varGetB+varGetC
                    
                    
                    TotalCount=d
                    YesCount=varGetA
                    NoCount=varGetB
                    MaybeCount=varGetC
                    
                    
                    
                    cell.eventGoingResponceLabel.text = String(format:"Total Response: %d   |  Yes: %@  |  No:  %@  |  Maybe:  %@" ,d, String(varGetA) ,String(varGetB),String(varGetC))
                    if isSharebuttonClick
                    {
                        cell.eventGoingResponceLabel.isHidden=true
                        cell.eventANSLabel.isHidden=true
                        cell.eventAttendingLabel.isHidden=true
                        cell.img1.isHidden=true
                        cell.img2.isHidden=true
                    }
                }
                cell.NOLabel.isHidden = true
                cell.MayBELabel.isHidden = true
                cell.NOdotImageView.isHidden = true
                cell.MayBEdotImageView.isHidden = true
                cell.eventAttendingLabel.isHidden = true
                cell.eventANSLabel.isHidden = true
                cell.dotImageView.isHidden = true
                cell.img1.isHidden=true
                cell.img2.isHidden=true
                cell.eventGoingResponceLabel.isHidden=true

                return cell
            }
            // return cell
        }
        return cell
    }
    
    
    
    func mapBtnClkNew(sender:UITapGestureRecognizer){
        var eventsDetails = EventsDetail()
        eventsDetails = mainArray.object(at: 0) as!  EventsDetail

        
        let address = eventsDetails.venue as String
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                //print("This is Error:------>")
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
                        //Working in Swift new versions.
//                        UIApplication.shared.openURL(NSURL(string:
                          //  "comgooglemaps://?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))&directionsmode=driving")! as URL)
                        
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

                        NSLog("Can't use comgooglemaps://");
                    }
                }
            }
        })
    }
    
    func mapBtnClk(_ vnlt:NSString,vnlon:NSString,addr:NSString){
        let address = addr as String
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                //print("This is Error:------>")
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
                        //Working in Swift new versions.
//                        UIApplication.shared.openURL(NSURL(string:
//                            "comgooglemaps://?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))&directionsmode=driving")! as URL)
//                        
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

                        NSLog("Can't use comgooglemaps://");
                    }
                    
                }
            }
        })
    }
    
    func EventImgBtnClk(_ imgUrl:NSString){
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "fullImg") as! ImageFullViewController
        secondViewController.urlLink=imgUrl
        //secondViewController.eventDetail = grp
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    func QuestionsWebService()
    {
        closeKB()
        QuestionViewWritten.removeFromSuperview()
        QuestionViewOptions.removeFromSuperview()
        
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        wsm.getQuestionsAnswering(grpId, profileID:profileId, eventId: eventID, joiningStatus: joiningStatus as NSString, questionId: questionID as NSString, answerByme: optionANS as NSString)
    }
    
    
    func getQueAnsInfoDetailDelegate(queAns : EventJoinResult)
    {
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self

            wsm.getEventsDetail(groupProfileID: profileId, grpID: grpId, eventID: eventID)

        EventsDetailTableView.reloadData()
        tableviewShareEventDetailShare.reloadData()
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        closeKB()
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
    }
    
    func closeKB()
    {
    }
    
    func heightForView1(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()

        return label.frame.height
    }
    
    func heightForView(_ text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    //-----
    
        
    //MARK:- Extra PDF methods by harshada
    
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
    
    
    func getCurrentDate() -> String
    {
        let date=Date()
        let formatter=DateFormatter()
        formatter.dateFormat="ddMMyyyy_HHmmss"
        return formatter.string(from: date)
    }
    
    @objc func shareButtonClickEvent()
    {
        
        assignHeadFootToTableView()
        sharePDFTo(url:createPDFDataFromTableView(tableView: self.tableviewShareEventDetailShare))
    }
    
  func assignHeadFootToTableView()
  {
    var headerImage:UIImage=UIImage()
    var footerImage:UIImage=UIImage()
    headerImage=UIImage(named:"rt_header.jpg")!
    footerImage=UIImage(named: "rt_footer.png")!
    let topView:UIView = UIView()
    topView.frame = CGRect(x: 0, y: 0, width: tableviewShareEventDetailShare.contentSize.width, height: 95.0)
    topView.backgroundColor = UIColor.clear
    let headerImgView:UIImageView=UIImageView()
    headerImgView.frame = CGRect(x: 0, y: 0, width: tableviewShareEventDetailShare.contentSize.width, height: 95.0)
    headerImgView.image=headerImage
    topView.addSubview(headerImgView)
    
    let headerLabel:UILabel=UILabel()
    headerLabel.frame=CGRect(x: 0, y: 60, width: tableviewShareEventDetailShare.contentSize.width, height: 35.0)
    headerLabel.backgroundColor=UIColor.clear
    headerLabel.text=""
    headerLabel.font=UIFont(name: "Roboto-Regular", size: 18)
    headerLabel.textColor=UIColor.black
    headerLabel.textAlignment=NSTextAlignment.center
    topView.addSubview(headerLabel)
    topView.bringSubviewToFront( headerLabel)
    tableviewShareEventDetailShare.tableHeaderView = topView
    let bottomView:UIView = UIView()
    bottomView.frame = CGRect(x: 0, y: 0, width: tableviewShareEventDetailShare.contentSize.width, height: 45.0)
    bottomView.backgroundColor = UIColor.clear
    
    let footerImgView:UIImageView=UIImageView()
    footerImgView.frame = CGRect(x: 0, y: 0, width: tableviewShareEventDetailShare.contentSize.width, height: 45.0)
    footerImgView.image=footerImage
    bottomView.addSubview(footerImgView)
    tableviewShareEventDetailShare.tableFooterView = bottomView

    }
    
    func sharePDFTo(url:NSURL)
    {
        print(url)
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
    
    
    
    
    
    func createPDFDataFromTableView(tableView: UITableView) -> NSURL {
        let priorBounds = tableView.bounds
        let fittedSize = tableView.sizeThatFits(CGSize(width:priorBounds.size.width, height:tableView.contentSize.height))
        tableView.bounds = CGRect(x:0, y:0, width:fittedSize.width, height:fittedSize.height)
        let pdfPageBounds = CGRect(x:0, y:0, width:tableView.frame.width, height:tableView.contentSize.height)
        let pdfData = NSMutableData()
                //print("Height of tableview after header footer:\(tableView.contentSize.height)")
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds,nil)
        var pageOriginY: CGFloat = 0
        while pageOriginY < fittedSize.height {
            UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
            UIGraphicsGetCurrentContext()!.saveGState()
            UIGraphicsGetCurrentContext()!.translateBy(x: 0, y: -pageOriginY)
            tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
            UIGraphicsGetCurrentContext()!.restoreGState()
            pageOriginY += pdfPageBounds.size.height
            //print(pageOriginY)
        }
        UIGraphicsEndPDFContext()
        tableView.bounds = priorBounds
        
        //try saving in doc dir to confirm:
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        self.ticksnew = getCurrentDate()
        var title:String=""
        var dateTime:String=""
        var eventsDetails = EventsDetail()
        eventsDetails = mainArray.object(at: 0) as!  EventsDetail
        if let tit=eventsDetails.eventTitle as? String
        {
            title=tit
        }
        if let datTime=eventsDetails.eventDateTime
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
            //print("error catched")
        }
        return path! as NSURL
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
    /// Convert String to Date
    func convertToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        //2019-08-16 17:07:00
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let serverDate: Date = dateFormatter.date(from: dateString)! // according to date format your date string
        return serverDate
    }
}

