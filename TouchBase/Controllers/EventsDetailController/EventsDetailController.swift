//
//  EventsDetailController.swift
//  TouchBase
//
//  Created by Kaizan on 17/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//
extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 596_800) * 10_000_000)
    }
}
import UIKit
import SVProgressHUD
import Firebase
import EventKit
var isVisitedAddEventsScreen:Int=0
protocol  protocolNameBackImage{
    func functionForBackImage(imageImageNew:UIImage)
}

class EventsDetailController: UIViewController , UITableViewDataSource,UITableViewDelegate , webServiceDelegate,eventImgDelegate ,eventdetcellDelegate,protocolNameBackImage,protocolForEventsListingCallingApi{
    
    
    @IBOutlet weak var buttonOpacityWhenShare: UIButton!
    
    @IBAction func buttonOpacityWhenShareClickEvent(_ sender: Any) {
    }
    var grpName:String!=""
    var isSharebuttonClick:Bool=false
    var FileNameToDelete:String=""
    var memberProfileId:String=""
    var isfromNotificationList:String=""
    var titleRIZone = ""

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
        
        
        /*
         
         activityVC.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
         if !completed {
         // User canceled
         return
         }
         // User completed activity
         }
         
         self.present(activityVC, animated: true, completion: nil)
         */
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.viewShareEvent.isHidden=true
        })
        
        
        
        
        /*
        let objEventDetailScreenShotViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailScreenShotViewController") as! EventDetailScreenShotViewController
        
        objEventDetailScreenShotViewController.TotalCount=TotalCount
        objEventDetailScreenShotViewController.YesCount=YesCount
        objEventDetailScreenShotViewController.NoCount=NoCount
        objEventDetailScreenShotViewController.MaybeCount=MaybeCount
        objEventDetailScreenShotViewController.getText=getText
        objEventDetailScreenShotViewController.imageScreenShot=imageScreenShot
        objEventDetailScreenShotViewController.isCategory=isCategory
        
        objEventDetailScreenShotViewController.Titlenew=TitleNew
        objEventDetailScreenShotViewController.Description=Description
        objEventDetailScreenShotViewController.Venue=Venue
        objEventDetailScreenShotViewController.eventDateTime=eventDateTime
        objEventDetailScreenShotViewController.reglink=reglink
        
        objEventDetailScreenShotViewController.objProtocolBackImage=self
        
        
        self.navigationController?.pushViewController(objEventDetailScreenShotViewController, animated: true)
        //print("//print screen event clicked !!!!!!!!!")
        */
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
        //print(docURL)
        
       
        //print(ticksnew) // 636110903202288256

        var fullURL:String!=""
        fullURL="Event"+self.ticksnew+".pdf"
        //print("this is url value !!!!!")
        //print(fullURL)
        
        
        
        docURL = docURL.appendingPathComponent(fullURL)
        //print("This is url from pdf from events detail!!!!!")
        //print(docURL)
        pdfData.write(to: docURL as URL, atomically: true)
    }
    
    var ticksnew:String!=""
    
    @IBAction func buttonShareClickEvent(_ sender: Any)
    {
        
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
                self.present(activityViewController, animated: true, completion: nil)
            }
            //------------
         })
        
      
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.viewShareEvent.isHidden=true
          })
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        tableviewShareEventDetailShare.reloadData()
        print("is FileToRemove Available \(FileNameToDelete)")
    }
    
    @IBOutlet weak var viewShareEvent: UIView!
    @IBOutlet weak var tableviewShareEventDetailShare: UITableView!
    @IBOutlet var EventsDetailTableView: UITableView!
    
    
    func functionForEventsListingCallingApi(stringFromWhereITCalling: String) {
        
        createNavigationBar()
        buttonProgrssBar.isHidden=true
        //EventsDetailTableView.isHidden=true
        
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
        
        
        /*---------Unused Write By DPK for test events purpose
         //        if(isCalled == "fromcelebreation" && (varType=="A" || varType=="B" || varType=="E"))
         //        {
         //         wsm.getEventsDetail(profileId, grpID: "_New", eventID: eventID)
         //        }
         //       else
         */
        //print("this is event screen")
        //print(isCalled)
        if(isCalled == "fromcelebreation")
        {
            //print("111111")
            //print("this is event id :::::::::::")
            //print(eventID)
            wsm.getEventsDetail(groupProfileID: profileId, grpID: grpId, eventID: eventID)
        }
        else
        {
            if(isCalled == "notify"){
                //print("2222222")
                wsm.getEventsDetail(groupProfileID: profileId, grpID: grpId, eventID: eventID)
            } else if(isCalled == "notify1"){
                //print("333333")
                wsm.getEventsDetail(groupProfileID: profileId, grpID: grpId, eventID: eventID)
            }
            else{
                //print("4444444")
                wsm.getEventsDetail(groupProfileID: memberProfileId , grpID: grpDetailPrevious?.groupID as? NSString ?? "", eventID: eventDetail as NSString)
                
                
                
            }
        }
    }
    
    
    
    
    var objprotocolForEventsListingCallingApi:protocolForEventsListingCallingApi?=nil

    /*hittu dynamic linking or deep linking 15 jan 2019 start*/
    static let DYNAMIC_LINK_DOMAIN = "https://rosteronwheel.page.link/on1o"
    static let BundleID = "com.kaizen.row"
    static let CustomScheme = "dlscheme"
    static let FallbackURL =  NSURL(string: "https://itunes.apple.com/in/app/roster-on-wheels-a-rotary-app/id682238809?mt=8")
    static let MinimumAppVersion = "1.1"
    static let AppStoreID = "682238809"
    var picks:NSArray?
    static let PackageName = "com.SampleApp.row"
    static let MinimumVersion = 4.0
    var longLink:NSURL?
    var shortLink:NSURL?
    
    
    func BuildFDLink(){
        let linkString = "https://www.rosteronwheel.page.link" + "?" + "eventId" +
            "=" + eventDetail
        guard let link = URL(string: linkString as String) else { return }
        let components = DynamicLinkComponents(link: link, domainURIPrefix: EventsDetailController.DYNAMIC_LINK_DOMAIN)
        if (EventsDetailController.BundleID != "") {
            // iOS params
            let iOSParams = DynamicLinkIOSParameters(bundleID: EventsDetailController.BundleID)
            //iOSParams.fallbackURL = (ActivityInfoController.FallbackURL! as URL)
            iOSParams.minimumAppVersion = EventsDetailController.MinimumAppVersion
            iOSParams.customScheme = EventsDetailController.CustomScheme
            iOSParams.appStoreID = EventsDetailController.AppStoreID
            components!.iOSParameters = iOSParams
        }
        if (EventsDetailController.PackageName != "") {
            // Android params
            let androidParams = DynamicLinkAndroidParameters(packageName: EventsDetailController.PackageName)
            //  androidParams.fallbackURL = (ActivityInfoController.FallbackURL! as URL)
            //androidParams.minimumVersion = ActivityInfoController.MinimumVersion
            components!.androidParameters = androidParams
        }
        /*
         if let photosArray = self.info?.photos{
         if(photosArray.count>0){
         if let str = photosArray[0].string{
         let imagesUrl = URL(string:str)
         let socialParams = FIRDynamicLinkSocialMetaTagParameters()
         socialParams.title = info?.activity_title
         let Date = info?.getStartDate()
         let Time = info?.getStartTime()
         let address = info?.address
         let price = info?.price
         let desc = info?.activityDescription
         //let duraction = info?.duration
         //"Date of the activity" + "\n" +
         socialParams.descriptionText =  Date! + " at " + Time! + "\n" + address! + "\n" + "Price: " + price! + "AED" + "\n" + desc!
         socialParams.imageURL = imagesUrl
         components.socialMetaTagParameters = socialParams
         }
         }
         }
         */
        // OtherPlatform params
        //        let otherPlatformParams = DynamicLinkOtherPlatformParameters()
        //        otherPlatformParams.fallbackUrl = dictionary[.otherFallbackURL]?.text.flatMap(URL.init)
        //        components.otherPlatformParameters = otherPlatformParams
        longLink = (link as NSURL)
        //print(longLink?.absoluteString ?? "")
        // [START shortLinkOptions]
        let options = DynamicLinkComponentsOptions()
        options.pathLength = .unguessable
        components!.options = options
        // [END shortLinkOptions]
        // [START shortenLink]
        components?.shorten { (shortURL, warnings, error) in
            // Handle shortURL.
            if let error = error {
                //print(error.localizedDescription)
                return
            }
            self.shortLink = (shortURL! as NSURL)
            //print(self.shortLink?.absoluteString ?? "")
            // [START_EXCLUDE]
            // self.btnShare.alpha = 1.0
            // self.imgShare.alpha = 1.0
            //  //print("sharedUrl is \(String(describing: info?.event_url))")
            // [END_EXCLUDE]
        }
        // [END shortenLink]
    }
    
    
    /*hittu dynamic linking or deep linking 15 jan 2019 end*/
    
    
    func functionForBackImage(imageImageNew:UIImage)
    {
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        layer.render(in: UIGraphicsGetCurrentContext()!)
        /// let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        // UIGraphicsEndImageContext()
        // UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
        // set up activity view controller
        let imageToShare = [ imageImageNew,"http://www.roster.com" ] as [Any]
        // let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        
        
        let image = imageImageNew.images
        
        // let shareAll = [ image! , "http://www.roster.com"] as [Any]
        
        let activityViewController = UIActivityViewController( activityItems: imageToShare, applicationActivities: nil )
        
        
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        
        // let activityViewController = UIActivityViewController( activityItems: ["http://www.roster.com",imageToShare], applicationActivities: nil )
        
        
        
        /*---this is event id or more */
        
        // wsm.getEventsDetail(groupProfileID: grpDetailPrevious.object(forKey: "grpProfileid") as! String, grpID: grpDetailPrevious.object(forKey: "grpId") as! String as NSString, eventID: eventDetail.eventID as! NSString as! NSString)
        
        //print(grpDetailPrevious.object(forKey: "grpProfileid") as! String)
        //print(grpDetailPrevious.object(forKey: "grpId") as! String as NSString)
        //print( eventDetail.eventID as! NSString)
        
        
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var buttonProgrssBar: UIButton!
    
    @IBOutlet var backImageView: UIImageView!
    
    //    //////--------
    //    var selectedForce: CGFloat = 3
    //    var selectedDuration: CGFloat = 3
    //    var selectedDelay: CGFloat = 0
    //
    //    var selectedDamping: CGFloat = 0.7
    //    var selectedVelocity: CGFloat = 0.7
    //    var selectedScale: CGFloat = 1
    //    var selectedX: CGFloat = 0
    //    var selectedY: CGFloat = 0
    //    var selectedRotate: CGFloat = 0
    //
    
    @IBOutlet var QuestionViewOptions: UIView!
    @IBOutlet var QuestionViewContainer: UIView!
    @IBOutlet var optionQuestionLabel: UILabel!
    
    @IBOutlet var yesOptionButton: UIButton!
    
    @IBOutlet var noOptionButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var div1ImageView: UIImageView!
    @IBOutlet var div2ImageView: UIImageView!
    
    @IBOutlet var QuestionViewWritten: UIView!
    @IBOutlet var QuestionContainerVC: UIView!
    @IBOutlet var QuestionLabel: UILabel!
    @IBOutlet var AnswerTextField: UITextField!
    @IBOutlet var closeButton1: UIButton!
    @IBOutlet var div1ImgView: UIImageView!
    @IBOutlet var submitBtn: UIButton!
    
    
    
    var varRSVPCheckOnOff:String!=""
    @IBOutlet weak var buttonNo: UIButton!
    @IBOutlet weak var buttonMayBe: UIButton!
    @IBOutlet weak var buttonYes: UIButton!
    @IBOutlet weak var buttonAddToCalendar: UIButton!
    
    
    let bounds = UIScreen.main.bounds
    var grpDetail:GroupList!
    var eventDetail = ""
    var isCalled:NSString!
    var varIsRSVPEnableorDisable:Int=0
    var eventID:NSString!
    var profileId:String!=""
    var grpId:NSString!
    var grpIdForCheckDifference:NSString!
    var eventtID = ""

    var grpDetailPrevious:NewModuleList?
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("this is ticksnew !!!1")
        buttonOpacityWhenShare.isHidden=true
        viewShareEvent.isHidden=true
        
        isVisitedAddEventsScreen=0
        // BuildFDLink()
        //print(varIsRSVPEnableorDisable)
        // //print(eventDetail)
        
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.view.backgroundColor = UIColor.white
        
        //---
        
        
        buttonProgrssBar.isHidden=true
        //EventsDetailTableView.isHidden=true
        
        SVProgressHUD.show()
        //SVProgressHUD.touchesCancelled(false)
        
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
        wsm.delegates=self  //grpDetail.masterProfileID
        
        
        /*---------Unused Write By DPK for test events purpose
         //        if(isCalled == "fromcelebreation" && (varType=="A" || varType=="B" || varType=="E"))
         //        {
         //         wsm.getEventsDetail(profileId, grpID: "_New", eventID: eventID)
         //        }
         //       else
         */
        //print("this is event screen")
        //print(isCalled)
        if(isCalled == "fromcelebreation")
        {
            //print("111111")
            //print("this is event id :::::::::::")
            //print(eventID)
            wsm.getEventsDetail(groupProfileID: profileId, grpID: grpId, eventID: eventID)
            
        }
        else
        {
            print(grpDetailPrevious)
            
            if(isCalled == "notify"){
                //print("2222222")
                wsm.getEventsDetail(groupProfileID: profileId, grpID: grpId, eventID: eventID)
            } else if(isCalled == "notify1"){
                //print("333333")
                wsm.getEventsDetail(groupProfileID: profileId, grpID: grpId, eventID: eventID)
            }
            else if isfromNotificationList == "yes"{
//                grpDetailPrevious["tyID"] as! String
                
//                print(grpDetailPrevious.object(forKey: "memID") as! String as NSString as String)
                print(eventID)
                print(grpId)
                
                profileId = (grpDetailPrevious?.masterProfileID)
                
//                let grpIddd =  grpDetailPrevious["grpID"] as! String
//                let eventIdd = grpDetailPrevious["tyID"] as! String
                wsm.getEventsDetail(groupProfileID:grpDetailPrevious?.masterProfileID ?? "", grpID: grpId, eventID: eventID)
            }
            else{
                //print("4444444")
                // wsm.getEventsDetail(grpDetailPrevious.object(forKey: "grpProfileid") as! String as NSString, grpID: grpDetailPrevious.object(forKey: "grpId") as! String, eventID: eventDetail.eventID)
                //shubhs for notification
                wsm.getEventsDetail(groupProfileID: memberProfileId , grpID: grpDetailPrevious?.groupID as? NSString ?? "", eventID: eventDetail as NSString)
                
                
                
            }
        }
        //---
        createNavigationBar()
    }

    func createNavigationBar(){
        let adminID = UserDefaults.standard.string(forKey: "isAdmin")
        print("ADMIN RIGHTS---\(adminID)")
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        
        buttonleft.addTarget(self, action: #selector(EventsDetailController.backClicked), for: UIControl.Event.touchUpInside)
        
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        
        self.navigationItem.leftBarButtonItem = leftButton

        let trashB = UIButton(type: UIButton.ButtonType.custom)
        
        trashB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        trashB.setImage(UIImage(named:"Delete_blue"),  for: UIControl.State.normal)
        
        trashB.addTarget(self, action: #selector(EventsDetailController.deleteEbullAction), for: UIControl.Event.touchUpInside)
        
        let trash: UIBarButtonItem = UIBarButtonItem(customView: trashB)
        
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        
        shareButton.addTarget(self, action: #selector(EventsDetailController.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        
        let shareButtonAdd: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
        
        
        
        
        
        let editB = UIButton(type: UIButton.ButtonType.custom)
        
        editB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        editB.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
        
        editB.addTarget(self, action: #selector(EventsDetailController.editEbullAction), for: UIControl.Event.touchUpInside)
        
        let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
        
        
        let addEB = UIButton(type: UIButton.ButtonType.custom)
        
        addEB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        addEB.setImage(UIImage(named:"calendar1"),  for: UIControl.State.normal)
        
        addEB.addTarget(self, action: #selector(self.addEventToCalendarss), for: UIControl.Event.touchUpInside)
        
        let addevent: UIBarButtonItem = UIBarButtonItem(customView: addEB)

        if(ExpiredStr.characters.count > 0)
            
        {
            
            var buttons:NSArray=NSArray()//[shareButtonAdd,trash]
            
            
            
            self.title=moduleName
            
            let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
            
            self.navigationController?.navigationBar.barTintColor=UIColor.white
            
            
            
            let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
            
            if mainMemberID != "Yes"
                
            {
                
                //self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
                
                buttons=[shareButtonAdd,trash]
                
            }
                
            else
                
            {
                
                trashB.isHidden=true
                
                buttons=[shareButtonAdd]
                
            }
            
            
            
            if(ExpiredStr=="Yes")
                
            {
                
                trashB.isHidden=false
                
                buttons=[shareButtonAdd,trash]
                
                // self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
                
            }
            
            
            
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            
            
            
        }
            
        else
            
        {
            
            var buttons:NSArray=NSArray()//[shareButtonAdd,trash, edit]
            self.title="Events"
            
            let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
            
            self.navigationController?.navigationBar.barTintColor=UIColor.white
            
            if(isCalled == "fromcelebreation")
                
            {
                
                let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
                
                if mainMemberID == "yes"
                    
                {
                    
                    if(isCalled=="notify")
                        
                    {
                        
                    }
                        
                    else
                        
                    {
                        
                        buttons=[shareButtonAdd,trash, edit]
                        
                        // self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
                        
                    }
                    
                }
                
                if(isAdmin=="Yes" && isCategory=="2")
                    
                {
                    
                    if(isCalled=="notify")
                        
                    {
                        
                        print(isCalled)
                        
                    }
                        
                    else
                        
                    {
                        
                        buttons=[shareButtonAdd,trash, edit]
                        
                    }
                    
                }
                    
                else if(isAdmin=="No")
                {
                    trashB.isHidden=true
                    
                    editB.isHidden=true
                    
                    buttons=[shareButtonAdd]
                }
                
                if(varType=="E" && isCategory=="1")
                {
                    trashB.isHidden=true
                    editB.isHidden=true
                    buttons=[shareButtonAdd,trash,edit]
                }
                
                ///deep
                
                var eventsDetails = EventsDetail()
                
                /* comment by Rajendra on 10 Apr*/
                
                if(mainArray.count>0)
                {
                    eventsDetails = mainArray.object(at: 0) as!  EventsDetail
                    
                    print(eventsDetails.isAdmin)
                    
                    //eventsDetails
                    
                    var eventsDetailsNew:NSString!=eventsDetails.grpID as! NSString
                    
               //     print("grpId::: \(grpId):::::AND eventDetails:::\(eventsDetails.grpID)")
                    
                    var getIds:String!=""
                    getIds=eventsDetails.grpID
                    var getIds2:String!=""
                    getIds2=grpIdForCheckDifference as String!
                    print("grpId::: \(getIds2):::::AND eventDetails:::\(getIds) and main file grpID::::::::::\(self.grpId)")
                    
                    if((getIds2 != getIds)  && isCategory=="2")
                    {
                        trashB.isHidden=true
                        editB.isHidden=true
                        buttons=[shareButtonAdd]
                    }
                    else
                    {
                        print("\(mainMemberID)")
                        if mainMemberID=="yes"
                        {
                            trashB.isHidden=false
                            editB.isHidden=false
                            buttons=[shareButtonAdd,trash,edit]
                        }
                        else
                        {
                            trashB.isHidden=true
                            editB.isHidden=true
                            buttons=[shareButtonAdd]
                        }
                    }
                    
                    if(isCalled == "fromcelebreation" && (varType=="A" || varType=="B" || varType=="E"))
                    {
                    }
                    
                    ///
                    
                    if(isCalled == "fromcelebreation" && (varType=="A" || varType=="B" || varType=="E"))
                    {
                    }
                }
            }
                
            else
                
            {
                
                let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
                
                if mainMemberID == "Yes"
                    
                {
                    
                    if(isCalled=="notify")
                        
                    {
                        
                    }
                        
                    else
                        
                    {
                        
                        buttons=[shareButtonAdd,trash, edit]
                        
                        //self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
                        
                    }
                    
                }
                    
                else
                    
                {
                    
                    buttons=[shareButtonAdd]
                    
                }
                
                
                
                if(isCalled == "fromcelebreation")
                    
                {
                    
                    trashB.isHidden=true
                    
                    buttons=[shareButtonAdd,edit]
                    
                }
               if (isCalled=="notify")
                    
                {
                    
                    trashB.isHidden=true
                    
                    editB.isHidden=true
                    
                    buttons=[shareButtonAdd]
                    
                }
            }
            
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
    }
    
    /*
    func createNavigationBar(){

        if(ExpiredStr.characters.count > 0)
        {
            self.title=moduleName
            let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
            self.navigationController?.navigationBar.barTintColor=UIColor.white
            
             let buttonleft = UIButton(type: UIButton.ButtonType.custom)
            buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
            buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
            buttonleft.addTarget(self, action: #selector(EventsDetailController.backClicked), for: UIControl.Event.touchUpInside)
            
            let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
            self.navigationItem.leftBarButtonItem = leftButton
            
            let trashB = UIButton(type: UIButton.ButtonType.custom)
            trashB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            trashB.setImage(UIImage(named:"Delete_blue"),  for: UIControl.State.normal)
            trashB.addTarget(self, action: #selector(EventsDetailController.deleteEbullAction), for: UIControl.Event.touchUpInside)
            let trash: UIBarButtonItem = UIBarButtonItem(customView: trashB)
            
            let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
            
            let shareButton = UIButton(type: UIButton.ButtonType.custom)
            shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
            shareButton.addTarget(self, action: #selector(EventsDetailController.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
            let shareButtonAdd: UIBarButtonItem = UIBarButtonItem(customView: shareButton)

            //                        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]

            let buttons : NSArray = [shareButtonAdd,trash]
            
            
            if mainMemberID != "Yes"
            {
                
                //self.navigationItem.rightBarButtonItem = buttons as? [UIBarButtonItem]
                 self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            }
            else
            {
                trashB.isHidden=true
            }
            
            if(ExpiredStr=="Yes")
            {
                trashB.isHidden=false
              //  self.navigationItem.rightBarButtonItem = buttons as? [UIBarButtonItem]
                 self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            }
        }
        else
        {
            self.title="Events"
            let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
            self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
            
             let buttonleft = UIButton(type: UIButton.ButtonType.custom)
            buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
            
            buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
            
            buttonleft.addTarget(self, action: #selector(EventsDetailController.backClicked), for: UIControl.Event.touchUpInside)
            let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
            self.navigationItem.leftBarButtonItem = leftButton
            
            
            
            
            
            if(isCalled == "fromcelebreation")
            {
                let editB = UIButton(type: UIButton.ButtonType.custom)
                editB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                editB.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
                editB.addTarget(self, action: #selector(EventsDetailController.editEbullAction), for: UIControl.Event.touchUpInside)
                let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
                
                let trashB = UIButton(type: UIButton.ButtonType.custom)
                trashB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                trashB.setImage(UIImage(named:"Delete_blue"),  for: UIControl.State.normal)
                trashB.addTarget(self, action: #selector(EventsDetailController.deleteEbullAction), for: UIControl.Event.touchUpInside)
                let trash: UIBarButtonItem = UIBarButtonItem(customView: trashB)
                
                let shareButton = UIButton(type: UIButton.ButtonType.custom)
                shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
                shareButton.addTarget(self, action: #selector(EventsDetailController.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
                let shareButtonAdd: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
                
                
                
                let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
                if mainMemberID == "Yes"
                {
                    let buttons : NSArray = [shareButtonAdd,trash, edit]
                    if(isCalled=="notify")
                    {
                        
                    }
                    else
                    {
                        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
                    }
                }
                
                //print(isAdmin,isCategory)
                if(isAdmin=="Yes" && isCategory=="2")
                {
        //print("isAdminisAdminisAdminisAdminisAdminisAdminisAdminisAdmin",isAdmin,isCategory,isAdmin,isCategory,isAdmin,isCategory)
                    let buttons : NSArray = [shareButtonAdd,trash, edit]
                    if(isCalled=="notify")
                    {
                        //print(isCalled)
                    }
                    else
                    {
                        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
                    }
                }
                else if(isAdmin=="No" && isCategory=="2")
                {
                    trashB.isHidden=true
                    editB.isHidden=true
                }
                if(varType=="E" && isCategory=="1")
                {
                    trashB.isHidden=true
                    editB.isHidden=true
                }
                
                ///deep
                var eventsDetails = EventsDetail()
                /* comment by Rajendra on 10 Apr*/
                if(mainArray.count>0)
                {
                    eventsDetails = mainArray.object(at: 0) as!  EventsDetail
                    //print(eventsDetails.isAdmin)
                    //eventsDetails
                    
                    var eventsDetailsNew:NSString!=eventsDetails.grpID as! NSString
                    //print("grpId::: \(grpId):::::AND eventDetails:::\(eventsDetails.grpID)")
                    //print(mainArray)
                    
                    var getIds:String!=""
                    getIds=eventsDetails.grpID
                    
                    
                    var getIds2:String!=""

                    getIds2=grpIdForCheckDifference as String!
                    
                    print(grpId)
                    print(getIds2)
                    
                    
                    
                    
                    
                    if((grpId != grpIdForCheckDifference)  && isCategory=="2")
                    {
                        trashB.isHidden=true
                        editB.isHidden=true
                    }
                    else
                    {
                        trashB.isHidden=false
                        editB.isHidden=false
                    }
                    if(isCalled == "fromcelebreation" && (varType=="A" || varType=="B" || varType=="E"))
                    {
                    }
                    ///
                    if(isCalled == "fromcelebreation" && (varType=="A" || varType=="B" || varType=="E"))
                    {
                    }
                }
                
                ////print("2222222222222222222233333333333333333444444444444444")
            }
            else
            {
                
                ////print("11111111111111111111222222222222222222222233333333333333333333")
                let editB = UIButton(type: UIButton.ButtonType.custom)
                editB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                editB.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
                editB.addTarget(self, action: #selector(EventsDetailController.editEbullAction), for: UIControl.Event.touchUpInside)
                let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
                
                let trashB = UIButton(type: UIButton.ButtonType.custom)
                trashB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                trashB.setImage(UIImage(named:"Delete_blue"),  for: UIControl.State.normal)
                trashB.addTarget(self, action: #selector(EventsDetailController.deleteEbullAction), for: UIControl.Event.touchUpInside)
                let trash: UIBarButtonItem = UIBarButtonItem(customView: trashB)
                
                
                
                let shareButton = UIButton(type: UIButton.ButtonType.custom)
                shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
                shareButton.addTarget(self, action: #selector(EventsDetailController.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
                let shareButtonAdd: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
                
                
                
                
                let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
                if mainMemberID == "Yes"
                {
                    let buttons : NSArray = [shareButtonAdd,trash, edit]
                    if(isCalled=="notify")
                    {
                        
                    }
                    else
                    {
                        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
                    }
                }
                if(isCalled == "fromcelebreation")
                {
                    trashB.isHidden=true
                }
                
                if (isCalled=="notify")
                {
                    
                    trashB.isHidden=true
                    editB.isHidden=true
                    
                }
            }
        }
    }
    */
     @objc func backClicked()
    {
        if(isCalled == "notify"){
            // appDelegate.setRootView()
            //self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            
            ////print("One-------->")
            self.navigationController?.popViewController(animated: true) //DPK
            
        }else if(isCalled == "notify1"){
            //appDelegate.setRootView()
            ////print("Two-------->")
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }
        else{
            ////print("Three-------->")
            if(isVisitedAddEventsScreen==1)
            {
                self.objprotocolForEventsListingCallingApi?.functionForEventsListingCallingApi(stringFromWhereITCalling: "itCallingFrom-edit Evewnts screen while clicking !!!")
                self.navigationController?.popViewController(animated: true)
            }
            else
            {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        if((self.presentingViewController) != nil){
            self.dismiss(animated: false, completion: nil)
            ////print("done")
        }
    }
    

    @objc func editEbullAction()
    {
        UserDefaults.standard.set("", forKey: "eventAddress")
        let addEvent = self.storyboard?.instantiateViewController(withIdentifier: "add_event") as! AddEventsController
        
        addEvent.titleRIZone = self.titleRIZone
        
        //addEvent.groupID = grpDetailPrevious.objectForKey("grpId") as! String
        //addEvent.groupProfileID = grpDetailPrevious.objectForKey("grpProfileid") as! String
        addEvent.isCalledFrom="edit"
        //addEvent.isCalledFRom="edit"
        var eventsDetails = EventsDetail()
        eventsDetails = mainArray.object(at: 0) as!  EventsDetail
        addEvent.TypeIDEdit = eventsDetails.eventID! as NSString
        addEvent.eventsDetails=eventsDetails
        addEvent.SMSCountStr = SMSCountStr
        addEvent.varIsRSVPEnableorDisable=varIsRSVPEnableorDisable
        addEvent.rsvpString = eventsDetails.rsvpEnable as String
        
        addEvent.objprotocolForEventsListingCallingApi=self
        
        
        var getValue:String! =  UserDefaults.standard.value(forKey: "session_LinkValue") as! String
        
        if(getValue=="nothing")
        {
            addEvent.link = ""
            // cell.labelLink.isHidden=false
        }
        else
        {
            addEvent.link = getValue
            // cell.lab.isHidden=false
        }
        
        // UserDefaults.standard.set("nothing", forKey: "session_LinkValue")
        
        
        
        ////print(eventsDetails.memberprofileid! as NSString)
        //////print(String(profileId))
        
        if(eventsDetails.grpID=="")
        {
            
        }
        else
        {
            grpId = eventsDetails.grpID! as NSString
        }
        
        if(String(profileId) == "" || profileId == nil)
        {
            profileId = (eventsDetails.memberprofileid! as NSString) as String!
        }
        else
        {
            
        }
        
        //print(eventsDetails.grpID)
        
        if(varType=="E" || varType=="B" || varType=="A")
        {
            addEvent.groupID = eventsDetails.grpID
            addEvent.groupProfileID = eventsDetails.eventID
            
        }
        else
        {
            addEvent.groupID = String(grpId)
            addEvent.groupProfileID = String(profileId)
        }
        //        else
        //        {
        //            //print(grpDetailPrevious.objectForKey("grpId") as! String)
        //            //print(grpDetailPrevious.objectForKey("grpProfileid") as! String)
        //
        //            addEvent.groupID = grpDetailPrevious.objectForKey("grpId") as! String
        //            addEvent.groupProfileID = grpDetailPrevious.objectForKey("grpProfileid") as! String
        //        }
        
        addEvent.eventFilterCheck=eventFilterCheck
        addEvent.isCategory=self.isCategory
        //print(eventsDetails)
        //print(mainArray.object(at: 0))
        
        
        //print(eventsDetails.displayonbanner)
        
        self.navigationController?.pushViewController(addEvent, animated: true)
        
        //self.navigationController?.popVdsfiewControllerAnimated(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
  
    func createImage() -> UIImage{
        
        //  Converted to Swift 4 by Swiftify v4.2.28993 - https://objectivec2swift.com/
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 320, height: 1000), _: false, _: 0.0)
        var context = UIGraphicsGetCurrentContext()
        var previousFrame: CGRect = view.frame
        view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: 320, height: 1000)
        if let context = context {
            view.layer.render(in: context)
        }
        view.frame = previousFrame
        var image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        let imageData: Data = image!.pngData()!
        //print(imageData)
        // let imageUrlString = newString
        /// let imageUrl = URL(string: imageUrlString)!
        // let imageData = try! Data(contentsOf: imageUrl)
        //let image = UIImage(data: imageData)
        var imageSize: Int = imageData.count
        //print("size of image in KB: %f ", Double(imageSize) / 1024.0)
        var getdocSize:Double=Double(imageSize) / 1024.0
        getdocSize=getdocSize/1024.0
        //print(getdocSize)
        
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        return image!
    }
    //----------------------------------------
    
    //-----------------------------------------------------------
    
    
    open func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
        //1.
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = screenshotImage, shouldSave {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        
        
        UIImageWriteToSavedPhotosAlbum(screenshotImage!, nil, nil, nil)
        
        
        //2..
        let layer1 = UIApplication.shared.keyWindow!.layer
        let scale1 = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer1.frame.size, false, scale1);
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
        
        
        
        
        return screenshotImage
    }
    
    
    @IBAction func addTocalenderClickEvent(_ sender: Any) {
        addEventToCalendarss()
    }
    
    
    
    @objc func deleteEbullAction()
    {
        
        let alert=UIAlertController(title: "Confirm", message:"Are you sure, you want to delete?", preferredStyle: UIAlertController.Style.alert);
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil));
        //event handler with closure
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
            var eventsDetails = EventsDetail()
            eventsDetails = self.mainArray.object(at: 0) as!  EventsDetail
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=nil
            wsm.delegates=self
            
            
            //print("this is ROW value")
            // //print(self.grpDetailPrevious.object(forKey: "grpProfileid") as! String)
            
            
            //profileId
            //print(self.profileId)
            wsm.deleteDataWebservice(eventsDetails.eventID, type: "Event", profileID:  self.profileId as! String)
            
            //  wsm.deleteDataWebservice(eventsDetails.eventID, type: "Event", profileID:  self.grpDetailPrevious.object(forKey: "grpProfileid") as! String)
            
            
            
        }));
        self.present(alert, animated: true, completion: nil);
        
        
    }
    func deleteSucc(_ docListing : DeleteResult)
    {
      //  NotificationCenter.default.post(name: Notification.Name(rawValue: "functionForDeleteEventThenRefreshMainDashBoardSliderDetails"), object: nil)
        UserDefaults.standard.removeObject(forKey: "session_DateDifference")
        
        if docListing.status == "0"
        {
            if(isCalled == "notify"){
                // appDelegate.setRootView()
                self.navigationController?.dismiss(animated: true, completion: nil)
                
            }else if(isCalled == "notify1"){
                //appDelegate.setRootView()
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
            else {
                
                
                
                if(isCalled == "fromcelebreation")
                {
                    UserDefaults.standard.set("yes", forKey: "thisiscomingfromdetaileventdelete")
                    
                    let alert = UIAlertController(title: "Events", message: "Event Deleted Successfully", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                        
                        self.objprotocolForEventsListingCallingApi?.functionForEventsListingCallingApi(stringFromWhereITCalling: "itCallingFrom-edit Evewnts screen 2")
                        self.navigationController?.popViewController(animated: true)
                    }));
                    self.present(alert, animated: true, completion: nil)
                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                    // self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
                    
                    self.navigationController?.popViewController(animated: true)
                }
                else
                {
                    let alert = UIAlertController(title: "Events", message: "Event Deleted Successfully", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                        self.objprotocolForEventsListingCallingApi?.functionForEventsListingCallingApi(stringFromWhereITCalling: "itCallingFrom-edit Evewnts screen 3")
                        
                        self.navigationController?.popViewController(animated: true)
                    }));
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                
                
            }
        }
        else
        {
            /*alet alert = UIAlertController(title: "Rotary India", message: "Could not DELETE, please Try Again!", preferredStyle: UIAlertController.Style.Alert)
             alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Default, handler: nil))
             self.presentViewController(alert, animated: true, completion: nil)*/
            self.view.makeToast("Could not DELETE, please Try again!", duration: 2, position: CSToastPositionCenter)
            
        }
    }
    
    func skipClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func NextButtonAction(_ sender: AnyObject)
    {
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "events") as UIViewController, animated: true) // group_detail  , directory , events
    }
    
    ///////////// delegate
    var muarrayShare:NSMutableArray=NSMutableArray()
    func getEventsDetailsSuccess(eventsDetails : EventsListDetailResult)
    {
        //grpname
        //print(myTempDictForScreenShotDataHolding)
        
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
        
        //print(image)
        
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
        
        
        /*
         displayonbanner = 1;
         eventDate = "2019-05-10 17:40:00";
         eventDateTime = "10 May 2019 05:40 PM";
         eventDesc = Test;
         eventID = 5458;
         eventImg = "http://www.rosteronwheels.com/Documents/Event/Group2765/Lighthouse02052019053622PM.jpg";
         eventTitle = "Event notification on 2nd May 2019";
         eventType = 0;
         expiryDate = "2019-05-11 17:32:00";
         filterType = 1;
         goingCount = 1;
         grpAdminId = 151199;
         grpCategory = "<null>";
         grpID = 2765;
         grpname = "Rotary Club of Thane City View";
         inputIds = "";
         isAdmin = Yes;
         isQuesEnable = 2;
         maybeCount = 2;
         memberprofileid = 279705;
         myResponse = yes;
         notgoingCount = 0;
         option1 = No;
         option2 = Maybe;
         pubDate = "2019-05-02 17:55:00";
         questionId = 1617;
         questionText = Yes;
         questionType = 2;
         reglink = "https://forms.gle/czbDYGzarrgxEaiV7";
         repeatDateTime = "";
         rsvpEnable = 1;
         sendSMSAll = 0;
         sendSMSNonSmartPh = 0;
         totalCount = 3;
         venue = "Kaizen Infotech Solutions Pvt Ltd.\n1st Floor, Building A,\nGala Industrial Estate,\nDindayal Upadhyay Marg\nMulund (W)  400 080 India ";
         venueLat = "";
         venueLon = "venue_long";
         */
        
        
        
        
        
        mainArray = eventsDetails.eventsDetailResult as NSArray
        
        print("Check Main Array:: \(mainArray)")
        
        for i in 0 ..< mainArray.count
        {
            let evtdetail:EventsDetail=mainArray.object(at: i) as!  EventsDetail
            print("Event Image::: \(evtdetail.eventImg)")
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
        //print(eventsDetails.isAdmin)
        //print(eventsDetails.link)
        isAdmin = eventsDetails.isAdmin
        
        
        self.createNavigationBar()
        
        eventsDetails = mainArray.object(at: 0) as!  EventsDetail
        
        //print(eventsDetails.isAdmin)
        
        //eventsDetails
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
    
    var webUrl:String!=""
    
    
    //7208135060
   @objc func buttonLinkClickEvent(_ sender:UIButton)
    {
        /*
         //print("clicxked here for opening new web view!!!!")
         let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventAnnouncementwebViewViewController") as! EventAnnouncementwebViewViewController
         secondViewController.webUrl=webUrl
         //print("This is web url ev")
         //print(webUrl)
         //secondViewController.eventDetail = grp
         self.navigationController?.pushViewController(secondViewController, animated: true)
         */
        //print(sender.titleLabel?.text)

        if(sender.titleLabel?.text == nil)
        {
            
        }
        else
        {
            //print("clicxked !!!!")
            var getValue = sender.titleLabel?.text
            //print(getValue)
            if(getValue?.contains("<null>"))!
            {
                //print("if")
            }
            else
            {
                //print("else")
                /*
                let objEventAnnouncementwebViewViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventAnnouncementwebViewViewController") as! EventAnnouncementwebViewViewController
                objEventAnnouncementwebViewViewController.webUrl=webUrl
                self.navigationController?.pushViewController(objEventAnnouncementwebViewViewController, animated: true)
            */
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
                //print(url)
                
                let requestObj = URLRequest(url: url!);
                //print("http://-----------------------")
                
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
                //---
            
            }
        }
       
        
        
        
        
    }
    //-----------------------------------------------------------------------------------------------
    var varRowHeight:CGFloat!=0.0
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(tableView==tableviewShareEventDetailShare)
        {
            return tableviewShareEventDetailShare.rowHeight
        }
        return EventsDetailTableView.rowHeight
    }
    
    //--------------------------------------------------------------------------------------------------
    /*
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        let headerImage = UIImage(named: "headerBanner.jpg")
        let headerImageView = UIImageView(image: headerImage)
        header.backgroundView = headerImageView
    }
 
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as UITableViewHeaderFooterView
        let imageViewGame = UIImageView(frame: CGRectMake(5, 8, 40, 40));
        let image = UIImage(named: "ClubHeader");
        imageViewGame.image = image;
        header.contentView.addSubview(imageViewGame)
    }
    */
    
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {}
//
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {}
//
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
                        //                    appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                        //                        DispatchQueue.main.async { () -> Void in
                        //                            guard let data = data, error == nil else { return }
                        //                            //print(response?.suggestedFilename ?? "")
                        //                            //print("Download Finished")
                        //                            cell.EventPic.image = UIImage(data: data)
                        //                            cell.indicator.stopAnimating()
                        //                            //  cell.activityLoader.stopAnimating()
                        //                        }
                        //                    }
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
                    
                    //print(eventsDetails.link)
                    
                    
                    var getValue:String! =  UserDefaults.standard.value(forKey: "session_LinkValue") as! String
                    //print("this is value :-------------")
                    //print(getValue)
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

                    cell.buttonLinkEvent.addTarget(self, action: #selector(AnnouncementDetailController.buttonLinkClickEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    cell.locImageView.image=UIImage(named: "location.png")
                    cell.dotImageView.image=UIImage(named: "dot.png")
                    
   //  cell.eventAddressLabel.frame = CGRect(x: cell.eventAddressLabel.frame.origin.x, y: cell.eventAddressLabel.frame.origin.y, width: cell.eventAddressLabel.frame.width, height: self.heightForView1(text: eventsDetails.venue, font: cell.eventAddressLabel.font, width: cell.eventAddressLabel.frame.width))

                    
                    
                    cell.eventAddressLabel.isUserInteractionEnabled=true
                    cell.eventAddressLabel.text =  eventsDetails.venue
                    Venue=eventsDetails.venue
                    
                    
                    //"1st Floor Building Gala Industrial Estate Deen Dayal Upadhyay Marg Mulund West Mumbai - 400080.Mumbai Maharashtra INDIA +91 - 22 - 4151 6969 / +91- 9987 641161 "
                    cell.eventDateTimeLabel.text =  eventsDetails.eventDateTime //"21st Dec 2015 | 1:30 pm"
                    
                    eventDateTime=eventsDetails.eventDateTime
                    
                    
                    cell.delegates=self
                    cell.venueLat=eventsDetails.venueLat as! NSString
                    cell.venueLon=eventsDetails.venueLon as! NSString
                    
                    
                    
                    if eventsDetails.myResponse == "yes"
                    {
                        //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.eventANSLabel.frame=CGRectMake(8, 145, 310,35)
                        //                    cell.locImagxcveView.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.locImaxcvxcgeView.frame=CGRectMake(8, 25, 20,20)
                        if eventsDetails.goingCount == "1"
                        {
                            cell.eventAttendingLabel.text=""
                          //  cell.eventAttendingLabel.isHidden=true
                            cell.eventANSLabel.text = String(format:"YES, You have accepted the invite to this event.")
                            getText="YES, You have accepted the invite to this event."
                            
                           // cell.eventANSLabel.frame=CGRect(x: cell.eventAttendingLabel.frame.origin.x, y: cell.eventAttendingLabel.frame.origin.y, width: cell.eventANSLabel.frame.width, height: cell.eventANSLabel.frame.height)
                        }
                        else
                        {
                            cell.eventAttendingLabel.text=""
                            //cell.eventAttendingLabel.isHidden=true
                            cell.eventANSLabel.text = String(format:"YES, You have accepted the invite to this event.")
                            getText="YES, You have accepted the invite to this event."
                          //  cell.eventANSLabel.frame=CGRect(x: cell.eventAttendingLabel.frame.origin.x, y: cell.eventAttendingLabel.frame.origin.y, width: cell.eventANSLabel.frame.width, height: cell.eventANSLabel.frame.height)

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
                        //cell.eventAttendingLabel.isHidden=true
                        cell.dotImageView.image = UIImage(named: "dot_red.png")
                        cell.NOLabel.isHidden = true
                        cell.MayBELabel.isHidden = true
                        cell.NOdotImageView.isHidden = true
                        cell.MayBEdotImageView.isHidden = true
                        cell.eventAttendingLabel.isHidden = true
                        cell.eventANSLabel.isHidden = false
                        cell.dotImageView.isHidden = true
                        //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.eventANSLabel.frame=CGRectMake(8, 145, 310,35)
                        cell.eventANSLabel.text = "NO, You have declined the invite to this event."
                       // cell.eventANSLabel.frame=CGRect(x: cell.eventAttendingLabel.frame.origin.x, y: cell.eventAttendingLabel.frame.origin.y, width: cell.eventANSLabel.frame.width, height: cell.eventANSLabel.frame.height)

                        getText="NO, You have declined the invite to this event."
                        cell.eventANSLabel.textColor = UIColor(red: (255/255.0), green: (76/255.0), blue: (77/255.0), alpha: 1.0)
                        //                    cell.locImxcvageView.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.locIxcvmageView.frame=CGRectMake(8, 25, 20,20)
                        
                    }
                    else if eventsDetails.myResponse == "maybe"
                    {
                        //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.eventANSLabel.frame=CGRectMake(8, 145, 310,35)
                        cell.eventAttendingLabel.text=""
                       // cell.eventAttendingLabel.isHidden=true
                        cell.eventANSLabel.text = "You have not confirmed attendence."
                       // cell.eventANSLabel.frame=CGRect(x: cell.eventAttendingLabel.frame.origin.x, y: cell.eventAttendingLabel.frame.origin.y, width: cell.eventANSLabel.frame.width, height: cell.eventANSLabel.frame.height)

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
                        //                    cell.locImagexcvView.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.locIxcvmageView.frame=CGRectMake(8, 25, 20,20)
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
                        //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.eventANSLabel.frame=CGRectMake(8, 181, 310,35)
                        //                    cell.locImageView.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.locImageView.frame=CGRectMake(8, 25, 20,20)
                        //cell.eventANSLabel.hidden = false
                    }
                    var a:String! = (eventsDetails.goingCount) as String
                    var b:String! = (eventsDetails.notgoingCount) as String
                    var c:String! = (eventsDetails.maybeCount) as String
                    
                    
                    var varGetA:Int!=0
                    var varGetB:Int!=0
                    var varGetC:Int!=0
                    
                    //                if ((eventsDetails.rsvpEnable)as String == "0")
                    //                {
                    //                    self.buttonYes.hidden = true
                    //                    self.buttonNo.hidden = true
                    //                    self.buttonMayBe.hidden = true
                    //                    cell.eventAttendingLabel.hidden=true
                    //                    cell.eventGoingResponceLabel.hidden=true
                    //                    cell.img1.hidden=true
                    //                    cell.img2.hidden=true
                    //                    cell.eventANSLabel.hidden=true //
                    //
                    //                }
                    //                else
                    //                {
                    //                    self.buttonYes.hidden = false
                    //                    self.buttonNo.hidden = false
                    //                    self.buttonMayBe.hidden = false
                    //                    cell.eventAttendingLabel.hidden=false
                    //                    cell.eventGoingResponceLabel.hidden=false
                    //                    cell.img1.hidden=false
                    //                    cell.img2.hidden=false
                    //                }
                    
                    //////
                    
                    if(self.isCalled=="list")
                    {
                        
                        if ((eventsDetails.rsvpEnable)as String == "0"  || (eventsDetails.filterType)as String == "3" )
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
                            self.buttonYes.isHidden = false
                            self.buttonNo.isHidden = false
                            self.buttonMayBe.isHidden = false
                            cell.eventAttendingLabel.isHidden=false
                            cell.eventGoingResponceLabel.isHidden=false
                            cell.img1.isHidden=false
                            cell.img2.isHidden=false
                        }
                        
                        
                        
                    }
                    else
                    {
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
                            
                           // self.buttonYes.isHidden = false
                           // self.buttonNo.isHidden = false
                           // self.buttonMayBe.isHidden = false
                           
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
                    
                    //print(varGetA)
                    //print(varGetB)
                    //print(varGetC)
                    
                    
                    
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
            // return cell
        }
        else if(tableView==tableviewShareEventDetailShare)
        {
            if(indexPath.section == 0)
            {
                // alertController.dismiss(animated: true, completion: nil)
                
                cell = tableviewShareEventDetailShare.dequeueReusableCell(withIdentifier: "eventDetCellShare", for: indexPath) as! EventDetailCell
                
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
                        cell.indicator.stopAnimating()
                        //                    appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                        //                        DispatchQueue.main.async { () -> Void in
                        //                            guard let data = data, error == nil else { return }
                        //                            //print(response?.suggestedFilename ?? "")
                        //                            //print("Download Finished")
                        //                            cell.EventPic.image = UIImage(data: data)
                        //                            cell.indicator.stopAnimating()
                        //                            //  cell.activityLoader.stopAnimating()
                        //                        }
                        //                    }
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
                    
                    //print(eventsDetails.link)
                    
                    
                    var getValue:String! =  UserDefaults.standard.value(forKey: "session_LinkValue") as! String
                    //print("this is value :-------------")
                    //print(getValue)
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
                    
                    
                    
                    cell.buttonLinkEvent.addTarget(self, action: #selector(AnnouncementDetailController.buttonLinkClickEvent(_:)), for: UIControl.Event.touchUpInside)
                    
                    
                    
                    
                    cell.locImageView.image=UIImage(named: "location.png")
                    cell.dotImageView.image=UIImage(named: "dot.png")
                    
                    print("Before Height of Address LAbel:: \(cell.eventAddressLabel.frame.height)")
                    cell.eventAddressLabel.text =  eventsDetails.venue
                    cell.eventAddressLabel.frame = CGRect(x: cell.eventAddressLabel.frame.origin.x, y: cell.eventAddressLabel.frame.origin.y, width: cell.eventAddressLabel.frame.width, height: self.heightForView1(text: eventsDetails.venue, font: cell.eventAddressLabel.font, width: cell.eventAddressLabel.frame.width))
                    

                    Venue=eventsDetails.venue
                    print("After Height of Address LAbel:: \(cell.eventAddressLabel.frame.height)")
                    
                    print("**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**")
                    //"1st Floor Building Gala Industrial Estate Deen Dayal Upadhyay Marg Mulund West Mumbai - 400080.Mumbai Maharashtra INDIA +91 - 22 - 4151 6969 / +91- 9987 641161 "
                    cell.eventDateTimeLabel.text =  eventsDetails.eventDateTime //"21st Dec 2015 | 1:30 pm"
                    
                    eventDateTime=eventsDetails.eventDateTime
                    
                    
                    cell.delegates=self
                    cell.venueLat=eventsDetails.venueLat as! NSString
                    cell.venueLon=eventsDetails.venueLon as! NSString
                    
                    
                    
                    if eventsDetails.myResponse == "yes"
                    {
                        //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.eventANSLabel.frame=CGRectMake(8, 145, 310,35)
                        //                    cell.locImagxcveView.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.locImaxcvxcgeView.frame=CGRectMake(8, 25, 20,20)
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
                        //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.eventANSLabel.frame=CGRectMake(8, 145, 310,35)
                        cell.eventANSLabel.text = "NO, You have declined the invite to this event."
                        getText="NO, You have declined the invite to this event."
                        cell.eventANSLabel.textColor = UIColor(red: (255/255.0), green: (76/255.0), blue: (77/255.0), alpha: 1.0)
                        //                    cell.locImxcvageView.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.locIxcvmageView.frame=CGRectMake(8, 25, 20,20)
                        
                    }
                    else if eventsDetails.myResponse == "maybe"
                    {
                        //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.eventANSLabel.frame=CGRectMake(8, 145, 310,35)
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
                        //                    cell.locImagexcvView.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.locIxcvmageView.frame=CGRectMake(8, 25, 20,20)
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
                        //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.eventANSLabel.frame=CGRectMake(8, 181, 310,35)
                        //                    cell.locImageView.translatesAutoresizingMaskIntoConstraints = true
                        //                    cell.locImageView.frame=CGRectMake(8, 25, 20,20)
                        //cell.eventANSLabel.hidden = false
                    }
                    var a:String! = (eventsDetails.goingCount) as String
                    var b:String! = (eventsDetails.notgoingCount) as String
                    var c:String! = (eventsDetails.maybeCount) as String
                    
                    
                    var varGetA:Int!=0
                    var varGetB:Int!=0
                    var varGetC:Int!=0
                    
                    //                if ((eventsDetails.rsvpEnable)as String == "0")
                    //                {
                    //                    self.buttonYes.hidden = true
                    //                    self.buttonNo.hidden = true
                    //                    self.buttonMayBe.hidden = true
                    //                    cell.eventAttendingLabel.hidden=true
                    //                    cell.eventGoingResponceLabel.hidden=true
                    //                    cell.img1.hidden=true
                    //                    cell.img2.hidden=true
                    //                    cell.eventANSLabel.hidden=true //
                    //
                    //                }
                    //                else
                    //                {
                    //                    self.buttonYes.hidden = false
                    //                    self.buttonNo.hidden = false
                    //                    self.buttonMayBe.hidden = false
                    //                    cell.eventAttendingLabel.hidden=false
                    //                    cell.eventGoingResponceLabel.hidden=false
                    //                    cell.img1.hidden=false
                    //                    cell.img2.hidden=false
                    //                }
                    
                    //////
                    
                    if(self.isCalled=="list")
                    {
                        
                        if ((eventsDetails.rsvpEnable)as String == "0"  || (eventsDetails.filterType)as String == "3" )
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
                            self.buttonYes.isHidden = false
                            self.buttonNo.isHidden = false
                            self.buttonMayBe.isHidden = false
                            cell.eventAttendingLabel.isHidden=false
                            cell.eventGoingResponceLabel.isHidden=false
                            cell.img1.isHidden=false
                            cell.img2.isHidden=false
                        }
                        
                        
                        
                    }
                    else
                    {
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
                            
                            // self.buttonYes.isHidden = false
                            // self.buttonNo.isHidden = false
                            // self.buttonMayBe.isHidden = false
                            
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
                    
                    //print(varGetA)
                    //print(varGetB)
                    //print(varGetC)
                    
                    
                    
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
    
    //Old Cellfor ROw for tableview on 14 June 5:04 pm
//    func oldCellForRow() -> UITableViewCell
//    {
//    var cell:EventDetailCell=EventDetailCell()
//    if(tableView==EventsDetailTableView)
//    {
//    if(indexPath.section == 0)
//    {
//    // alertController.dismiss(animated: true, completion: nil)
//
//    cell = EventsDetailTableView.dequeueReusableCell(withIdentifier: "eventDetCell", for: indexPath) as! EventDetailCell
//
//    if mainArray.count > 0
//    {
//    SVProgressHUD.dismiss()
//    buttonProgrssBar.isHidden=true
//    EventsDetailTableView.isHidden=false
//    var eventsDetails = EventsDetail()
//    eventsDetails = mainArray.object(at: indexPath.row) as!  EventsDetail
//
//    cell.eventNameLabel.text =  eventsDetails.eventTitle //"erteiurs hkjfjkf jkqw rewiroio ds gfdfghdf  lshglewhre  ejlghejkhge  lwehrgjkewhrg k  erjhe"
//
//    TitleNew=eventsDetails.eventTitle
//
//    cell.eventDetailLabel.text =  eventsDetails.eventDesc
//
//    Description=eventsDetails.eventDesc
//
//
//    //"youi are the most dash dash person inthe world u knw wht u this about me , I dnt cate about dat bcz I am the king powweeerrr, hahahahahahahah let do it buddy , because project X is not far from us , lets do it, \n\n\n erteiurs hkjfjkf jkqw rewiroio ds gfdfghdf  lshglewhre  ejlghejkhge  lwehrgjkewhrg k  erjhe"
//    cell.indicator.startAnimating()
//    if(eventsDetails.eventImg == ""){
//    cell.EventPic.translatesAutoresizingMaskIntoConstraints = true
//    cell.EventPic.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 0)
//    cell.indicator.stopAnimating()
//    cell.imgClkBtn.isHidden=true
//
//    }else{
//    cell.EventPic.translatesAutoresizingMaskIntoConstraints = true
//    cell.EventPic.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 171)
//    cell.imgUrl=eventsDetails.eventImg as! NSString;
//    cell.imgClkBtn.isHidden=false
//    cell.delegates=self;
//    }
//    if let checkedUrl = URL(string: eventsDetails.eventImg ) {
//
//    imageScreenShot=eventsDetails.eventImg
//    cell.EventPic.sd_setImage(with: checkedUrl)
//    cell.indicator.stopAnimating()
//    //                    appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
//    //                        DispatchQueue.main.async { () -> Void in
//    //                            guard let data = data, error == nil else { return }
//    //                            //print(response?.suggestedFilename ?? "")
//    //                            //print("Download Finished")
//    //                            cell.EventPic.image = UIImage(data: data)
//    //                            cell.indicator.stopAnimating()
//    //                            //  cell.activityLoader.stopAnimating()
//    //                        }
//    //                    }
//    }
//    }
//
//    return cell
//    }
//    else
//    {
//    let cell = EventsDetailTableView.dequeueReusableCell(withIdentifier: "eventDescCell", for: indexPath) as! EventDesctiptCell
//
//    if mainArray.count > 0
//    {
//    var eventsDetails = EventsDetail()
//    eventsDetails = mainArray.object(at: indexPath.row) as!  EventsDetail
//
//    //print(eventsDetails.link)
//
//
//    var getValue:String! =  UserDefaults.standard.value(forKey: "session_LinkValue") as! String
//    //print("this is value :-------------")
//    //print(getValue)
//    reglink=getValue
//    if(getValue=="nothing")
//    {
//    webUrl="nothing"
//    cell.labelLink.isHidden=true
//    cell.buttonLinkEvent.isHidden=true
//
//    }
//    else
//    {
//    cell.buttonLinkEvent.setTitle(getValue, for: .normal)
//    webUrl=getValue
//    cell.labelLink.isHidden=false
//    cell.buttonLinkEvent.isHidden=false
//    cell.labelLink.text="Link"
//    }
//
//
//
//    cell.buttonLinkEvent.addTarget(self, action: #selector(AnnouncementDetailController.buttonLinkClickEvent(_:)), for: UIControl.Event.touchUpInside)
//
//
//
//
//    cell.locImageView.image=UIImage(named: "location.png")
//    cell.dotImageView.image=UIImage(named: "dot.png")
//
//
//    cell.eventAddressLabel.text =  eventsDetails.venue
//    Venue=eventsDetails.venue
//
//
//    //"1st Floor Building Gala Industrial Estate Deen Dayal Upadhyay Marg Mulund West Mumbai - 400080.Mumbai Maharashtra INDIA +91 - 22 - 4151 6969 / +91- 9987 641161 "
//    cell.eventDateTimeLabel.text =  eventsDetails.eventDateTime //"21st Dec 2015 | 1:30 pm"
//
//    eventDateTime=eventsDetails.eventDateTime
//
//
//    cell.delegates=self
//    cell.venueLat=eventsDetails.venueLat as! NSString
//    cell.venueLon=eventsDetails.venueLon as! NSString
//
//
//
//    if eventsDetails.myResponse == "yes"
//    {
//    //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.eventANSLabel.frame=CGRectMake(8, 145, 310,35)
//    //                    cell.locImagxcveView.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.locImaxcvxcgeView.frame=CGRectMake(8, 25, 20,20)
//    if eventsDetails.goingCount == "1"
//    {
//    cell.eventAttendingLabel.text=""
//    cell.eventANSLabel.text = String(format:"YES, You have accepted the invite to this event.")
//    getText="YES, You have accepted the invite to this event."
//    }
//    else
//    {cell.eventAttendingLabel.text=""
//    cell.eventANSLabel.text = String(format:"YES, You have accepted the invite to this event.")
//    getText="YES, You have accepted the invite to this event."
//    }
//    cell.eventANSLabel.textColor = UIColor(red: (76/255.0), green: (175/255.0), blue: (80/255.0), alpha: 1.0)
//    cell.dotImageView.image = UIImage(named: "dot.png")
//    cell.NOLabel.isHidden = true
//    cell.MayBELabel.isHidden = true
//    cell.NOdotImageView.isHidden = true
//    cell.MayBEdotImageView.isHidden = true
//    cell.eventAttendingLabel.isHidden = true
//    cell.eventANSLabel.isHidden = false
//    cell.dotImageView.isHidden = true
//
//    }
//    else if eventsDetails.myResponse == "no"
//    {
//    cell.eventAttendingLabel.text=""
//    cell.dotImageView.image = UIImage(named: "dot_red.png")
//    cell.NOLabel.isHidden = true
//    cell.MayBELabel.isHidden = true
//    cell.NOdotImageView.isHidden = true
//    cell.MayBEdotImageView.isHidden = true
//    cell.eventAttendingLabel.isHidden = true
//    cell.eventANSLabel.isHidden = false
//    cell.dotImageView.isHidden = true
//    //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.eventANSLabel.frame=CGRectMake(8, 145, 310,35)
//    cell.eventANSLabel.text = "NO, You have declined the invite to this event."
//    getText="NO, You have declined the invite to this event."
//    cell.eventANSLabel.textColor = UIColor(red: (255/255.0), green: (76/255.0), blue: (77/255.0), alpha: 1.0)
//    //                    cell.locImxcvageView.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.locIxcvmageView.frame=CGRectMake(8, 25, 20,20)
//
//    }
//    else if eventsDetails.myResponse == "maybe"
//    {
//    //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.eventANSLabel.frame=CGRectMake(8, 145, 310,35)
//    cell.eventAttendingLabel.text=""
//    cell.eventANSLabel.text = "You have not confirmed attendence."
//    getText="You have not confirmed attendence."
//    cell.eventANSLabel.textColor = UIColor(red: (114/255.0), green: (114/255.0), blue: (114/255.0), alpha: 1.0)
//    cell.dotImageView.image = UIImage(named: "dot_gray.png")
//    cell.NOLabel.isHidden = true
//    cell.MayBELabel.isHidden = true
//    cell.NOdotImageView.isHidden = true
//    cell.MayBEdotImageView.isHidden = true
//    cell.eventAttendingLabel.isHidden = true
//    cell.eventANSLabel.isHidden = false
//    cell.dotImageView.isHidden = true
//    //                    cell.locImagexcvView.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.locIxcvmageView.frame=CGRectMake(8, 25, 20,20)
//    }
//    else
//    {
//    cell.eventAttendingLabel.text = "You have not responded to this invite."
//    cell.eventAttendingLabel.isHidden = false
//
//    cell.NOdotImageView.isHidden = true
//    cell.NOLabel.isHidden = true
//
//    cell.MayBEdotImageView.isHidden = true
//    cell.MayBELabel.isHidden = true
//
//    cell.eventANSLabel.isHidden = true
//    cell.dotImageView.isHidden = true
//    //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.eventANSLabel.frame=CGRectMake(8, 181, 310,35)
//    //                    cell.locImageView.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.locImageView.frame=CGRectMake(8, 25, 20,20)
//    //cell.eventANSLabel.hidden = false
//    }
//    var a:String! = (eventsDetails.goingCount) as String
//    var b:String! = (eventsDetails.notgoingCount) as String
//    var c:String! = (eventsDetails.maybeCount) as String
//
//
//    var varGetA:Int!=0
//    var varGetB:Int!=0
//    var varGetC:Int!=0
//
//    //                if ((eventsDetails.rsvpEnable)as String == "0")
//    //                {
//    //                    self.buttonYes.hidden = true
//    //                    self.buttonNo.hidden = true
//    //                    self.buttonMayBe.hidden = true
//    //                    cell.eventAttendingLabel.hidden=true
//    //                    cell.eventGoingResponceLabel.hidden=true
//    //                    cell.img1.hidden=true
//    //                    cell.img2.hidden=true
//    //                    cell.eventANSLabel.hidden=true //
//    //
//    //                }
//    //                else
//    //                {
//    //                    self.buttonYes.hidden = false
//    //                    self.buttonNo.hidden = false
//    //                    self.buttonMayBe.hidden = false
//    //                    cell.eventAttendingLabel.hidden=false
//    //                    cell.eventGoingResponceLabel.hidden=false
//    //                    cell.img1.hidden=false
//    //                    cell.img2.hidden=false
//    //                }
//
//    //////
//
//    if(self.isCalled=="list")
//    {
//
//    if ((eventsDetails.rsvpEnable)as String == "0"  || (eventsDetails.filterType)as String == "3" )
//    {
//    self.buttonYes.isHidden = true
//    self.buttonNo.isHidden = true
//    self.buttonMayBe.isHidden = true
//    cell.eventAttendingLabel.isHidden=true
//    cell.eventGoingResponceLabel.isHidden=true
//    cell.img1.isHidden=true
//    cell.img2.isHidden=true
//    cell.eventANSLabel.isHidden=true //
//
//    }
//    else
//    {
//    self.buttonYes.isHidden = false
//    self.buttonNo.isHidden = false
//    self.buttonMayBe.isHidden = false
//    cell.eventAttendingLabel.isHidden=false
//    cell.eventGoingResponceLabel.isHidden=false
//    cell.img1.isHidden=false
//    cell.img2.isHidden=false
//    }
//
//
//
//    }
//    else
//    {
//    var eventgroupId:NSString!=eventsDetails.grpID! as NSString
//
//    if ((eventsDetails.rsvpEnable)as String == "0"  || (eventsDetails.filterType)as String == "3" || (self.grpId != eventgroupId))
//    {
//    self.buttonYes.isHidden = true
//    self.buttonNo.isHidden = true
//    self.buttonMayBe.isHidden = true
//    cell.eventAttendingLabel.isHidden=true
//    cell.eventGoingResponceLabel.isHidden=true
//    cell.img1.isHidden=true
//    cell.img2.isHidden=true
//    cell.eventANSLabel.isHidden=true //
//
//    }
//    else
//    {
//
//    var getIds:String!=""
//    getIds=eventsDetails.grpID
//    var getIds2:String!=""
//    getIds2=grpIdForCheckDifference as String!
//    if((getIds2 != getIds)  && isCategory=="2")
//    {
//    self.buttonYes.isHidden = true
//    self.buttonNo.isHidden = true
//    self.buttonMayBe.isHidden = true
//
//    cell.eventAttendingLabel.isHidden=true
//    cell.eventGoingResponceLabel.isHidden=true
//    cell.img1.isHidden=true
//    cell.img2.isHidden=true
//    }
//    else
//    {
//    self.buttonYes.isHidden = false
//    self.buttonNo.isHidden = false
//    self.buttonMayBe.isHidden = false
//
//    cell.eventAttendingLabel.isHidden=false
//    cell.eventGoingResponceLabel.isHidden=false
//    cell.img1.isHidden=false
//    cell.img2.isHidden=false
//    }
//
//    // self.buttonYes.isHidden = false
//    // self.buttonNo.isHidden = false
//    // self.buttonMayBe.isHidden = false
//
//    }
//
//    }
//    /////
//    //1.
//    if(a.characters.count<=0 || a==nil)
//    {
//    varGetA=0
//    }
//    else
//    {
//    varGetA=Int(a)
//    }
//    //2.
//    if(b.characters.count<=0 || b==nil)
//    {
//    varGetB=0
//    }
//    else
//    {
//    varGetB=Int(b)
//    }
//    //3.
//    if(c.characters.count<=0 || c==nil)
//    {
//    varGetC=0
//    }
//    else
//    {
//    varGetC=Int(c)
//    }
//
//    //print(varGetA)
//    //print(varGetB)
//    //print(varGetC)
//
//
//
//    var d:Int=0
//
//    d=varGetA+varGetB+varGetC
//
//
//    TotalCount=d
//    YesCount=varGetA
//    NoCount=varGetB
//    MaybeCount=varGetC
//
//
//
//    cell.eventGoingResponceLabel.text = String(format:"Total Response: %d   |  Yes: %@  |  No:  %@  |  Maybe:  %@" ,d, String(varGetA) ,String(varGetB),String(varGetC))
//    if isSharebuttonClick
//    {
//    cell.eventGoingResponceLabel.isHidden=true
//    cell.eventANSLabel.isHidden=true
//    cell.eventAttendingLabel.isHidden=true
//    cell.img1.isHidden=true
//    cell.img2.isHidden=true
//    }
//    }
//    return cell
//    }
//    // return cell
//    }
//    else if(tableView==tableviewShareEventDetailShare)
//    {
//    if(indexPath.section == 0)
//    {
//    // alertController.dismiss(animated: true, completion: nil)
//
//    cell = tableviewShareEventDetailShare.dequeueReusableCell(withIdentifier: "eventDetCellShare", for: indexPath) as! EventDetailCell
//
//    if mainArray.count > 0
//    {
//    SVProgressHUD.dismiss()
//    buttonProgrssBar.isHidden=true
//    EventsDetailTableView.isHidden=false
//    var eventsDetails = EventsDetail()
//    eventsDetails = mainArray.object(at: indexPath.row) as!  EventsDetail
//
//    cell.eventNameLabel.text =  eventsDetails.eventTitle //"erteiurs hkjfjkf jkqw rewiroio ds gfdfghdf  lshglewhre  ejlghejkhge  lwehrgjkewhrg k  erjhe"
//
//    TitleNew=eventsDetails.eventTitle
//
//    cell.eventDetailLabel.text =  eventsDetails.eventDesc
//
//    Description=eventsDetails.eventDesc
//
//
//    //"youi are the most dash dash person inthe world u knw wht u this about me , I dnt cate about dat bcz I am the king powweeerrr, hahahahahahahah let do it buddy , because project X is not far from us , lets do it, \n\n\n erteiurs hkjfjkf jkqw rewiroio ds gfdfghdf  lshglewhre  ejlghejkhge  lwehrgjkewhrg k  erjhe"
//    cell.indicator.startAnimating()
//    if(eventsDetails.eventImg == ""){
//    cell.EventPic.translatesAutoresizingMaskIntoConstraints = true
//    cell.EventPic.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 0)
//    cell.indicator.stopAnimating()
//    cell.imgClkBtn.isHidden=true
//
//    }else{
//    cell.EventPic.translatesAutoresizingMaskIntoConstraints = true
//    cell.EventPic.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 171)
//    cell.imgUrl=eventsDetails.eventImg as! NSString;
//    cell.imgClkBtn.isHidden=false
//    cell.delegates=self;
//    }
//    if let checkedUrl = URL(string: eventsDetails.eventImg ) {
//
//    imageScreenShot=eventsDetails.eventImg
//    cell.EventPic.sd_setImage(with: checkedUrl)
//    cell.indicator.stopAnimating()
//    //                    appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
//    //                        DispatchQueue.main.async { () -> Void in
//    //                            guard let data = data, error == nil else { return }
//    //                            //print(response?.suggestedFilename ?? "")
//    //                            //print("Download Finished")
//    //                            cell.EventPic.image = UIImage(data: data)
//    //                            cell.indicator.stopAnimating()
//    //                            //  cell.activityLoader.stopAnimating()
//    //                        }
//    //                    }
//    }
//    }
//
//    return cell
//    }
//    else
//    {
//    let cell = tableviewShareEventDetailShare.dequeueReusableCell(withIdentifier: "eventDescCellShare", for: indexPath) as! EventDesctiptCell
//
//    if mainArray.count > 0
//    {
//    var eventsDetails = EventsDetail()
//    eventsDetails = mainArray.object(at: indexPath.row) as!  EventsDetail
//
//    //print(eventsDetails.link)
//
//
//    var getValue:String! =  UserDefaults.standard.value(forKey: "session_LinkValue") as! String
//    //print("this is value :-------------")
//    //print(getValue)
//    reglink=getValue
//    if(getValue=="nothing")
//    {
//    webUrl="nothing"
//    cell.labelLink.isHidden=true
//    cell.buttonLinkEvent.isHidden=true
//
//    }
//    else
//    {
//    cell.buttonLinkEvent.setTitle(getValue, for: .normal)
//    webUrl=getValue
//    cell.labelLink.isHidden=false
//    cell.buttonLinkEvent.isHidden=false
//    cell.labelLink.text="Link"
//    }
//
//
//
//    cell.buttonLinkEvent.addTarget(self, action: #selector(AnnouncementDetailController.buttonLinkClickEvent(_:)), for: UIControl.Event.touchUpInside)
//
//
//
//
//    cell.locImageView.image=UIImage(named: "location.png")
//    cell.dotImageView.image=UIImage(named: "dot.png")
//
//
//    cell.eventAddressLabel.text =  eventsDetails.venue
//    Venue=eventsDetails.venue
//
//
//    //"1st Floor Building Gala Industrial Estate Deen Dayal Upadhyay Marg Mulund West Mumbai - 400080.Mumbai Maharashtra INDIA +91 - 22 - 4151 6969 / +91- 9987 641161 "
//    cell.eventDateTimeLabel.text =  eventsDetails.eventDateTime //"21st Dec 2015 | 1:30 pm"
//
//    eventDateTime=eventsDetails.eventDateTime
//
//
//    cell.delegates=self
//    cell.venueLat=eventsDetails.venueLat as! NSString
//    cell.venueLon=eventsDetails.venueLon as! NSString
//
//
//
//    if eventsDetails.myResponse == "yes"
//    {
//    //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.eventANSLabel.frame=CGRectMake(8, 145, 310,35)
//    //                    cell.locImagxcveView.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.locImaxcvxcgeView.frame=CGRectMake(8, 25, 20,20)
//    if eventsDetails.goingCount == "1"
//    {
//    cell.eventAttendingLabel.text=""
//    cell.eventANSLabel.text = String(format:"YES, You have accepted the invite to this event.")
//    getText="YES, You have accepted the invite to this event."
//    }
//    else
//    {cell.eventAttendingLabel.text=""
//    cell.eventANSLabel.text = String(format:"YES, You have accepted the invite to this event.")
//    getText="YES, You have accepted the invite to this event."
//    }
//    cell.eventANSLabel.textColor = UIColor(red: (76/255.0), green: (175/255.0), blue: (80/255.0), alpha: 1.0)
//    cell.dotImageView.image = UIImage(named: "dot.png")
//    cell.NOLabel.isHidden = true
//    cell.MayBELabel.isHidden = true
//    cell.NOdotImageView.isHidden = true
//    cell.MayBEdotImageView.isHidden = true
//    cell.eventAttendingLabel.isHidden = true
//    cell.eventANSLabel.isHidden = false
//    cell.dotImageView.isHidden = true
//
//    }
//    else if eventsDetails.myResponse == "no"
//    {
//    cell.eventAttendingLabel.text=""
//    cell.dotImageView.image = UIImage(named: "dot_red.png")
//    cell.NOLabel.isHidden = true
//    cell.MayBELabel.isHidden = true
//    cell.NOdotImageView.isHidden = true
//    cell.MayBEdotImageView.isHidden = true
//    cell.eventAttendingLabel.isHidden = true
//    cell.eventANSLabel.isHidden = false
//    cell.dotImageView.isHidden = true
//    //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.eventANSLabel.frame=CGRectMake(8, 145, 310,35)
//    cell.eventANSLabel.text = "NO, You have declined the invite to this event."
//    getText="NO, You have declined the invite to this event."
//    cell.eventANSLabel.textColor = UIColor(red: (255/255.0), green: (76/255.0), blue: (77/255.0), alpha: 1.0)
//    //                    cell.locImxcvageView.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.locIxcvmageView.frame=CGRectMake(8, 25, 20,20)
//
//    }
//    else if eventsDetails.myResponse == "maybe"
//    {
//    //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.eventANSLabel.frame=CGRectMake(8, 145, 310,35)
//    cell.eventAttendingLabel.text=""
//    cell.eventANSLabel.text = "You have not confirmed attendence."
//    getText="You have not confirmed attendence."
//    cell.eventANSLabel.textColor = UIColor(red: (114/255.0), green: (114/255.0), blue: (114/255.0), alpha: 1.0)
//    cell.dotImageView.image = UIImage(named: "dot_gray.png")
//    cell.NOLabel.isHidden = true
//    cell.MayBELabel.isHidden = true
//    cell.NOdotImageView.isHidden = true
//    cell.MayBEdotImageView.isHidden = true
//    cell.eventAttendingLabel.isHidden = true
//    cell.eventANSLabel.isHidden = false
//    cell.dotImageView.isHidden = true
//    //                    cell.locImagexcvView.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.locIxcvmageView.frame=CGRectMake(8, 25, 20,20)
//    }
//    else
//    {
//    cell.eventAttendingLabel.text = "You have not responded to this invite."
//    cell.eventAttendingLabel.isHidden = false
//
//    cell.NOdotImageView.isHidden = true
//    cell.NOLabel.isHidden = true
//
//    cell.MayBEdotImageView.isHidden = true
//    cell.MayBELabel.isHidden = true
//
//    cell.eventANSLabel.isHidden = true
//    cell.dotImageView.isHidden = true
//    //                    cell.eventANSLabel.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.eventANSLabel.frame=CGRectMake(8, 181, 310,35)
//    //                    cell.locImageView.translatesAutoresizingMaskIntoConstraints = true
//    //                    cell.locImageView.frame=CGRectMake(8, 25, 20,20)
//    //cell.eventANSLabel.hidden = false
//    }
//    var a:String! = (eventsDetails.goingCount) as String
//    var b:String! = (eventsDetails.notgoingCount) as String
//    var c:String! = (eventsDetails.maybeCount) as String
//
//
//    var varGetA:Int!=0
//    var varGetB:Int!=0
//    var varGetC:Int!=0
//
//    //                if ((eventsDetails.rsvpEnable)as String == "0")
//    //                {
//    //                    self.buttonYes.hidden = true
//    //                    self.buttonNo.hidden = true
//    //                    self.buttonMayBe.hidden = true
//    //                    cell.eventAttendingLabel.hidden=true
//    //                    cell.eventGoingResponceLabel.hidden=true
//    //                    cell.img1.hidden=true
//    //                    cell.img2.hidden=true
//    //                    cell.eventANSLabel.hidden=true //
//    //
//    //                }
//    //                else
//    //                {
//    //                    self.buttonYes.hidden = false
//    //                    self.buttonNo.hidden = false
//    //                    self.buttonMayBe.hidden = false
//    //                    cell.eventAttendingLabel.hidden=false
//    //                    cell.eventGoingResponceLabel.hidden=false
//    //                    cell.img1.hidden=false
//    //                    cell.img2.hidden=false
//    //                }
//
//    //////
//
//    if(self.isCalled=="list")
//    {
//
//    if ((eventsDetails.rsvpEnable)as String == "0"  || (eventsDetails.filterType)as String == "3" )
//    {
//    self.buttonYes.isHidden = true
//    self.buttonNo.isHidden = true
//    self.buttonMayBe.isHidden = true
//    cell.eventAttendingLabel.isHidden=true
//    cell.eventGoingResponceLabel.isHidden=true
//    cell.img1.isHidden=true
//    cell.img2.isHidden=true
//    cell.eventANSLabel.isHidden=true //
//
//    }
//    else
//    {
//    self.buttonYes.isHidden = false
//    self.buttonNo.isHidden = false
//    self.buttonMayBe.isHidden = false
//    cell.eventAttendingLabel.isHidden=false
//    cell.eventGoingResponceLabel.isHidden=false
//    cell.img1.isHidden=false
//    cell.img2.isHidden=false
//    }
//
//
//
//    }
//    else
//    {
//    var eventgroupId:NSString!=eventsDetails.grpID! as NSString
//
//    if ((eventsDetails.rsvpEnable)as String == "0"  || (eventsDetails.filterType)as String == "3" || (self.grpId != eventgroupId))
//    {
//    self.buttonYes.isHidden = true
//    self.buttonNo.isHidden = true
//    self.buttonMayBe.isHidden = true
//    cell.eventAttendingLabel.isHidden=true
//    cell.eventGoingResponceLabel.isHidden=true
//    cell.img1.isHidden=true
//    cell.img2.isHidden=true
//    cell.eventANSLabel.isHidden=true //
//
//    }
//    else
//    {
//    self.buttonYes.isHidden = false
//    self.buttonNo.isHidden = false
//    self.buttonMayBe.isHidden = false
//    cell.eventAttendingLabel.isHidden=false
//    cell.eventGoingResponceLabel.isHidden=false
//    cell.img1.isHidden=false
//    cell.img2.isHidden=false
//    }
//
//    }
//    /////
//    //1.
//    if(a.characters.count<=0 || a==nil)
//    {
//    varGetA=0
//    }
//    else
//    {
//    varGetA=Int(a)
//    }
//    //2.
//    if(b.characters.count<=0 || b==nil)
//    {
//    varGetB=0
//    }
//    else
//    {
//    varGetB=Int(b)
//    }
//    //3.
//    if(c.characters.count<=0 || c==nil)
//    {
//    varGetC=0
//    }
//    else
//    {
//    varGetC=Int(c)
//    }
//
//    //print(varGetA)
//    //print(varGetB)
//    //print(varGetC)
//
//
//
//    var d:Int=0
//
//    d=varGetA+varGetB+varGetC
//
//
//    TotalCount=d
//    YesCount=varGetA
//    NoCount=varGetB
//    MaybeCount=varGetC
//
//
//
//    cell.eventGoingResponceLabel.text = String(format:"Total Response: %d   |  Yes: %@  |  No:  %@  |  Maybe:  %@" ,d, String(varGetA) ,String(varGetB),String(varGetC))
//    if isSharebuttonClick
//    {
//    cell.eventGoingResponceLabel.isHidden=true
//    cell.eventANSLabel.isHidden=true
//    cell.eventAttendingLabel.isHidden=true
//    cell.img1.isHidden=true
//    cell.img2.isHidden=true
//    }
//    }
//
//    cell.NOLabel.isHidden = true
//    cell.MayBELabel.isHidden = true
//    cell.NOdotImageView.isHidden = true
//    cell.MayBEdotImageView.isHidden = true
//    cell.eventAttendingLabel.isHidden = true
//    cell.eventANSLabel.isHidden = true
//    cell.dotImageView.isHidden = true
//    cell.img1.isHidden=true
//    cell.img2.isHidden=true
//    cell.eventGoingResponceLabel.isHidden=true
//    return cell
//    }
//    // return cell
//    }
//    return cell
//    }
 //************************** End of Cell for row At index path method for table view *********************
    
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
    
    func mapBtnClk(_ vnlt:NSString,vnlon:NSString,addr:NSString){
        
        //        let addEvent = self.storyboard?.instantiateViewControllerWithIdentifier("eventmap") as! MapViewController
        //        if(vnlon == ""){
        //            addEvent.vnLat="0.000"
        //            addEvent.vnLon="0.000"
        //
        //        }else{
        //
        //            addEvent.vnLat=vnlt
        //            addEvent.vnLon=vnlon
        //        }
        //        self.navigationController?.pushViewController(addEvent, animated: true)
        //
        //        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
        //            let vname1 = addr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        //            UIApplication.sharedApplication().openURL(NSURL(string:
        //                "comgooglemaps://?daddr=\(vname1)&directionsmode=driving")!)
        //
        //        } else {
        //            let  vname1 = addr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        //            UIApplication.sharedApplication().openURL(NSURL(string:
        //                "http://maps.apple.com/?daddr=\(vname1)&dirflg=d&t=h")!);
        //            NSLog("http://maps.google.com/maps?");
        //        }
        //
        //
        
        
        
        
        
        ///////-----------------------------------------------------------
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
        
        ///////-----------------------------------------------------------
    }
    
    func EventImgBtnClk(_ imgUrl:NSString){
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "fullImg") as! ImageFullViewController
//        secondViewController.urlLink=imgUrl
//        //secondViewController.eventDetail = grp
//        self.navigationController?.pushViewController(secondViewController, animated: true)
        let objImageFullViewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ImageFullViewViewController") as! ImageFullViewViewController
        objImageFullViewViewController.varGetImageUrl=imgUrl.replacingOccurrences(of: " ", with: "%20")
        self.navigationController?.pushViewController(objImageFullViewViewController, animated: true)
    }
    @IBAction func GoingToEvent(_ sender: AnyObject)
    {
        //print("YEESSSSSSSSS")
        joiningStatus = "yes"
        
        var eventsDetails = EventsDetail()
        eventsDetails = mainArray.object(at: 0) as!  EventsDetail
        
        //print("this is by Rajendra jat need to check")
        //print(mainArray.object(at: 0) as!  EventsDetail)
        //print(eventsDetails.isQuesEnable)
        //print(eventsDetails.questionType)
        
        
        
        
        
        if eventsDetails.isQuesEnable != "0"
        {
            // var queClass = QuestionList()
            // queClass = questionArray.objectAtIndex(0) as! QuestionList
            
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
    
    
    func QuestionsWebService()
    {
        closeKB()
        QuestionViewWritten.removeFromSuperview()
        QuestionViewOptions.removeFromSuperview()
        
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        
        //print("this is rajendra jat here :))")
        //print(isCalled)
        
        
        if(isCalled == "fromcelebreation")
        {
            ///  wsm.getEventsDetail(profileId, grpID: grpId, eventID: eventID)
            // wsm.getQuestionsAnswering(grpId, profileID: profileId, eventId: eventID, joiningStatus: joiningStatus as NSString, questionId: questionID as NSString, answerByme: optionANS)
            
            
            //print("fourrrrrrrrrrr")
            //print("<<<<<<<<<<<<<<<<<<<<---->>>>>>>>>>>>>>>>>>>>>>>")
            
            //print(eventID)
            //print(joiningStatus as NSString)
            //print(questionID as NSString)
            //print(optionANS as NSString)
            //print(profileId)
            //print(grpId)
            /*
             secondViewController.profileId = stringProfileId
             secondViewController.grpId = stringGroupID as! NSString
             */
            
            
            
            // //print(grpDetailPrevious.object(forKey: "grpId") as! String as NSString)
            // //print((grpDetailPrevious.object(forKey: "grpProfileid") as! String as NSString) as String)
            
            wsm.getQuestionsAnswering(grpId, profileID:profileId, eventId: eventID, joiningStatus: joiningStatus as NSString, questionId: questionID as NSString, answerByme: optionANS as NSString)
            
            
            
        }
        else
            
        {
            if(isCalled == "notify"){
                //print("oneeeeeeeeeeee")
                wsm.getQuestionsAnswering(grpId, profileID: (profileId as! NSString) as String, eventId: eventID, joiningStatus: joiningStatus as NSString, questionId: questionID as NSString, answerByme: optionANS as NSString)
            }else if(isCalled == "notify1"){
                //print("twoooooooooo")
                wsm.getQuestionsAnswering(grpId, profileID: (profileId as! NSString) as String, eventId: eventID, joiningStatus: joiningStatus as NSString, questionId: questionID as NSString, answerByme: optionANS as NSString)
            }
            else if isfromNotificationList == "yes"{
                wsm.getQuestionsAnswering(grpId, profileID: (profileId as! NSString) as String, eventId: eventID, joiningStatus: joiningStatus as NSString, questionId: questionID as NSString, answerByme: optionANS as NSString)
            }
            else{
                //print("threeeeeeeeeeee")
                wsm.getQuestionsAnswering(grpDetailPrevious?.groupID as? NSString ?? "", profileID: (memberProfileId  as NSString) as String, eventId: eventDetail as NSString, joiningStatus: joiningStatus as NSString, questionId: questionID as NSString, answerByme: optionANS as NSString)
            }
        }
    }
    
    
    func getQueAnsInfoDetailDelegate(queAns : EventJoinResult)
    {
        //print(queAns.status)
        //print(queAns.message)
        
        
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        if(isCalled == "fromcelebreation")
        {
            wsm.getEventsDetail(groupProfileID: profileId, grpID: grpId, eventID: eventID)
            
            wsm.getEventsDetail(groupProfileID: profileId, grpID:grpId, eventID: eventID)
        }
        else
        {
            if(isCalled == "notify"){
                // grpDetail.masterProfileID = profileId as String
                // grpDetail.groupId = grpId as String
                wsm.getEventsDetail(groupProfileID: profileId, grpID: grpId, eventID: eventID)
            } else if(isCalled == "notify1"){
                //  grpDetail.masterProfileID = profileId as String
                // grpDetail.groupId = grpId as String
                wsm.getEventsDetail(groupProfileID: profileId, grpID: grpId, eventID: eventID)
            }
            else if isfromNotificationList == "yes"{
                wsm.getEventsDetail(groupProfileID:(grpDetailPrevious?.masterProfileID as? NSString ?? "") as String, grpID: grpId, eventID: eventID)
            }
            else{
                wsm.getEventsDetail(groupProfileID: (memberProfileId ), grpID: grpDetailPrevious?.groupID as? NSString ?? "", eventID: eventDetail as NSString)
            }
        }
        
        EventsDetailTableView.reloadData()
        tableviewShareEventDetailShare.reloadData()
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //       let width = bounds.size.width
        //        if(width <= 320.0)
        //        {
        closeKB()
        
        //        }
        //        else
        //        {
        //        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        /*
         UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
         {
         
         self.view.frame = CGRect(x: self.view.frame.origin.x, y: -100 , width: self.view.frame.width, height: self.view.frame.height)
         
         
         }, completion: { finished in
         
         })
         */
    }
    
    func closeKB()
    {
        //        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
        //            {
        //
        //                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
        //
        //            }, completion: { finished in
        //
        //        })
        
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
    
    
    @IBAction func buttoncLICK(_ sender: Any) {
        // //print(varWebSite)
        let objWebSiteOpenUrlViewController = self.storyboard!.instantiateViewController(withIdentifier: "EventDetailNotiViewController") as! EventDetailNotiViewController
        self.navigationController?.pushViewController(objWebSiteOpenUrlViewController, animated: true)
    }
    
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
        
//        assignHeadFootToTableView()
//        sharePDFTo(url:createPDFDataFromTableView(tableView: self.tableviewShareEventDetailShare))
        
//        {
            var headerImage:UIImage=UIImage()
            var footerImage:UIImage=UIImage()
            //print("Height of tableview before header footer:\(EventsDetailTableView.contentSize.height)")
            if(isCategory=="1")
            {
                headerImage=UIImage(named:"ClubHeader")!
                //       footerImage=UIImage(named: "ClubFooter")!
            }
            else if(isCategory=="2")
            {
                headerImage=UIImage(named:"DistHeader")!
            }
            
            footerImage=UIImage(named: "common_footer.jpg")!
            
            let topView:UIView = UIView()
            topView.frame = CGRect(x: 0, y: 0, width: EventsDetailTableView.contentSize.width, height: 95.0)
            topView.backgroundColor = UIColor.clear
            let headerImgView:UIImageView=UIImageView()
            headerImgView.frame = CGRect(x: 0, y: 0, width: EventsDetailTableView.contentSize.width, height: 95.0)
            headerImgView.image=headerImage
            topView.addSubview(headerImgView)
            
            let headerLabel:UILabel=UILabel()
            headerLabel.frame=CGRect(x: 0, y: 60, width: EventsDetailTableView.contentSize.width, height: 35.0)
            headerLabel.backgroundColor=UIColor.clear
            headerLabel.text=grpName
            headerLabel.font=UIFont(name: "Roboto-Regular", size: 18)
            headerLabel.textColor=UIColor.white
            headerLabel.textAlignment=NSTextAlignment.center
            topView.addSubview(headerLabel)
            topView.bringSubviewToFront( headerLabel)
            
            EventsDetailTableView.tableHeaderView = topView
            
        
//        let footerImage:UIImage=UIImage(named: "common_footer.jpg")!
//        print("Origin y: \(footerRect.height):::\(footerRect.height-50)")
//        let  rect:CGRect=CGRect(x:0, y:footerRect.height-50, width:footerRect.width,height:50.0)
//        footerImage.draw(in: rect)
//        
        
            let bottomView:UIView = UIView()
            bottomView.frame = CGRect(x: 0, y: 0, width: EventsDetailTableView.contentSize.width, height: 45.0)
            bottomView.backgroundColor = UIColor.clear
            
            let footerImgView:UIImageView=UIImageView()
            footerImgView.frame = CGRect(x: 0, y: 0, width: EventsDetailTableView.contentSize.width, height: 45.0)
            footerImgView.image=footerImage
            bottomView.addSubview(footerImgView)
           // EventsDetailTableView.tableFooterView = bottomView

            sharePDFTo(url:createPDFDataFromTableView(tableView: self.EventsDetailTableView))
//        }
        
        

    }
    func shareButtonClickEventBackup1()
    {
        var headerImage:UIImage=UIImage()
        var footerImage:UIImage=UIImage()
        //print("Height of tableview before header footer:\(EventsDetailTableView.contentSize.height)")
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
        
      
        
        let topView:UIView = UIView()
        topView.frame = CGRect(x: 0, y: 0, width: EventsDetailTableView.contentSize.width, height: 95.0)
        topView.backgroundColor = UIColor.clear
        let headerImgView:UIImageView=UIImageView()
        headerImgView.frame = CGRect(x: 0, y: 0, width: EventsDetailTableView.contentSize.width, height: 95.0)
        headerImgView.image=headerImage
        topView.addSubview(headerImgView)
        
        let headerLabel:UILabel=UILabel()
        headerLabel.frame=CGRect(x: 0, y: 60, width: EventsDetailTableView.contentSize.width, height: 35.0)
        headerLabel.backgroundColor=UIColor.clear
        headerLabel.text=grpName
        headerLabel.font=UIFont(name: "Roboto-Regular", size: 18)
        headerLabel.textColor=UIColor.white
        headerLabel.textAlignment=NSTextAlignment.center
        topView.addSubview(headerLabel)
        topView.bringSubviewToFront( headerLabel)
        
        EventsDetailTableView.tableHeaderView = topView
        
        let bottomView:UIView = UIView()
        bottomView.frame = CGRect(x: 0, y: 0, width: EventsDetailTableView.contentSize.width, height: 45.0)
        bottomView.backgroundColor = UIColor.clear
        
        let footerImgView:UIImageView=UIImageView()
        footerImgView.frame = CGRect(x: 0, y: 0, width: EventsDetailTableView.contentSize.width, height: 45.0)
        footerImgView.image=footerImage
        bottomView.addSubview(footerImgView)
       // EventsDetailTableView.tableFooterView = bottomView

        sharePDFTo(url:createPDFDataFromTableView(tableView: self.EventsDetailTableView))
    }
    
  func assignHeadFootToTableView()
    
  {
    var headerImage:UIImage=UIImage()
    var footerImage:UIImage=UIImage()
    //print("Height of tableview before header footer:\(EventsDetailTableView.contentSize.height)")
    if(isCategory=="1")
    {
        headerImage=UIImage(named:"ClubHeader")!
        //       footerImage=UIImage(named: "ClubFooter")!
    }
    else if(isCategory=="2")
    {
        headerImage=UIImage(named:"DistHeader")!
    }
    
    footerImage=UIImage(named: "common_footer.jpg")!
    
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
    headerLabel.text=grpName
    headerLabel.font=UIFont(name: "Roboto-Regular", size: 18)
    headerLabel.textColor=UIColor.white
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

