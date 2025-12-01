//
//  RootDashNewViewController.swift
//  TouchBase
//
//  Created by IOS 2 on 21/09/23.
//  Copyright © 2023 Parag. All rights reserved.
//

import CoreTelephony
import SystemConfiguration
import CoreTelephony
import SVProgressHUD
import UIKit
import Alamofire
import Foundation
import SJSegmentedScrollView
import SDWebImage
import SVProgressHUD
import SSZipArchive
import WebKit

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

struct Section1 {
    
    var name: String!
    var des: [String]!
    var items: [String]?
    var collapsed: Bool!
    var imagePic: [String]!
    var varLink:[String]!
    
    init(name: String, varLink: [String],des: [String], items: [String],imagePic: [String], collapsed: Bool = false) {
        
        self.name = name
        self.varLink = varLink
        self.des = des
        self.items = items
        self.collapsed = collapsed
        self.imagePic = imagePic
    }
}

class RootDashNewViewController: UIViewController {
    
    @IBOutlet weak var headerImg: UIImageView!
    @IBOutlet weak var qrCode: UIImageView!
    @IBOutlet weak var notifyCountLbl: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addWebView: WKWebView!
    var sectionss = [RotaryClubItem]()
    var masterUId = UserDefaults.standard.string(forKey: "masterUID")
    var userId = ""
    var userName = ""
    var clubName = ""
    var userImg: UIImage?
    var nudgeViewHeight: CGFloat?
    
    var listSyncOnline: Resultus?
    
    var qrName = ""
    var qrBussName = ""
    var qrBussPosition = ""
    var qrMobile = ""
    var qrSecMobile = ""
    var qrBusAddrs = ""
    var qrBussCity = ""
    var qrBussState = ""
    var qrBusspincode = ""
    var qrmemEmail = ""
    var qrBussEmail = ""
    var qrwebText = ""
    var qrFBTxt = ""
    var qrinstaTxt = ""
    var qrtwitTxt = ""
    var qrlnkdTxt = ""
    var qrytTxt = ""
    var qrkeywordTxt = ""
        
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    private let loaderView = LoaderView()
    var sections = [Section1]()
    var viewloadandwillappearCount:Int=0
    var varCheckLoadingOrPicker:Int!=0
    var muarrayIsConatinCountOrNot:NSMutableArray=NSMutableArray()
    var varGetGroupId:String!=""
    var groupListses:NSMutableArray=NSMutableArray()
    var groupList:NSMutableArray=NSMutableArray()
    var replicaOf = String()
    var muarrayRotaryBlogs:NSMutableArray=NSMutableArray()   //Rotary News Array
    var muarrauRotaryNews:NSMutableArray=NSMutableArray()   //Rotary Blogs Array
    var muarrayForBirthdayAnniversaryEvent:NSMutableArray=NSMutableArray()
    var bannerListArr:NSArray=NSArray()
    //MARK:- Curd Operation
    let loaderClass  = WebserviceClass()
    var selectedIndexForSilder:Int=0
    var isGroupAdmin:String!=""
    var varGetZipFileUrl:String!=""
    var textOfbtm:NSString=""
    fileprivate let cellIdentifier = "modulecollectionCell"
    var menuTitles:NSMutableArray=NSMutableArray();
    var unCatArray:NSArray=NSArray()
    var allmoduleCAtArry:NSArray=NSArray()
    var NallmoduleCAtArry:NSMutableArray!
    var tbgrp:TBGroupResult=TBGroupResult()
    var appDelegate : AppDelegate!
    var varGetUniqueIndex:Int!=0
    var mudict:NSMutableDictionary=NSMutableDictionary()
    var userProfileDict:NSMutableDictionary=NSMutableDictionary()
    var personalmoduleCAtArry:NSArray=NSArray()
    var socialmoduleCAtArry:NSArray=NSArray()
    var businsmoduleCAtArry:NSArray=NSArray()
    var arrarrNewGroupList :NSArray=NSArray()
    var arrDeleteGroupList :NSArray=NSArray()
    let boundss = UIScreen.main.bounds
    var tbrootgrp:TBGroupResult=TBGroupResult()
    var muarrayEntityId:NSMutableArray=NSMutableArray()
    var muarrayEntityTotalCount:NSMutableArray=NSMutableArray()
    var varISPopVisisbleorNot:Int!=0
    var pushCounter = 0
    var refresher:UIRefreshControl!
    var refreshControl: UIRefreshControl!
    var varGetCount:String!=""
    var mainArraySettingForPicker = NSArray()
    var varGetPickerSelectValue:String! = ""
    /*----------------------------------------------ROW------------------------------------------------------------------*/
    
    var ituneDynamicUrlFromServer:String!=""
    var varGetTotalFilesCount:Int!=0
    var varGetForLoopCounting:Int!=0
    
    var stringArrayStore=[String]()
    
    var stringGroupImages=[String]()
    
    var stringArrayTitle=[String]()
    
    var stringArrayRssFirstFielsDescription=[String]()
    
    var stringArrayRssSecondFielsDescription=[String]()
    
    var stringArrayTitleSecond=[String]()
    
    var GroupName:[String]!
    
    var varLinkNewsUpdate=[String]()
    var varLinkBlogs=[String]()
    var grpDetailPrevious = NSDictionary()
    
    var arrayGrpId:[String]!
    var arrayGrpProfileid:[String]!
    var arrayIsGrpAdmin:[String]!
    var arrayMyCategory:[String]!
    var arrayNotificationCount:[String]!
    /*
     grpId,grpProfileid,isGrpAdmin,myCategory,notificationCount
     
     */
    
    /**/
    
    var anArray:NSArray=NSArray()
    
    var isCategory:String! = ""
    
    
    var varGetValueModuleID:String=""
    var FirstBeginParsing :String! = ""
    var SecondBeginParsingBlog :String! = ""
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    var description11 = NSMutableString()
    var link = NSMutableString()
    var newsUpdateDict:NSMutableDictionary = NSMutableDictionary()
    var moduleName:String! = ""
    var muarrayFindARotarianList:NSMutableArray=NSMutableArray()
    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
    var isAdmin:String! = ""
    var varGroupId:String! = ""
    var varModuleId:String! = ""
    var listsyncOnlineResponse: ListSyncOnline?
    var dirQROnline: DirectoryOnline?
    var headImg = ""
    var uTubeLink = ""
    var instaLink = ""
    var fbLink = ""
    var headTitle = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: Notification.Name("DataSaved"), object: nil)
        self.addView.isHidden=true
        indicator.isHidden = true
        rotaryIndiaRewampRIZoneAPI()
        loadDashBoardData()
        getAllGroupListOnline()
        register()
        configure()
        hideNavBar()
        qrCode.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        qrCode.addGestureRecognizer(tapGestureRecognizer)
        functionForBirthDayAnniversaryEvent()
        self.getBirthDayAnniversaryEventsDetails()
        let values = UserDefaults.standard.hashValue
        UserDefaults.standard.setValue("no", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
        //        if let username = UserDefaults.standard.value(forKey: "rotaryusername") as? String
        //        {
        //            self.lblUserName.text = "Hi " + username + " !"
        //        }
        
        // for profile ades by shubhs
        
        
        
        var databasePath1 : String
        let documents1 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL1 = documents1.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath1 = fileURL1.path
        var db1: OpaquePointer? = nil
        if sqlite3_open(fileURL1.path, &db1) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB1 = FMDatabase(path: databasePath1 as String)
        if contactDB1 == nil {
            print("Error: \(contactDB1?.lastErrorMessage())")
        }
        var varCounting:Int!=0
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        let grpIdddprofile=((UserDefaults.standard.string(forKey: "grpId")) as! String)
        print(grpIdddprofile)
        if (contactDB1?.open())! {
            
            let Count = "SELECT count(*) as Count from ProfileMaster where grpId = '\(grpIdddprofile)'"
            print(Count)
            let resultss:FMResultSet? = contactDB1?.executeQuery(Count,withArgumentsIn: nil)
            while resultss?.next() == true
            {
                varGetCount=resultss?.string(forColumn: "Count")
            }
            
            varCounting = Int(varGetCount)
            // print(varCounting)
        }
        
        //        self.fetchDataProfile()
        if(varCounting>0)
        {
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
            backgroundQueue.async(execute: {
                print("This is run on the background queue")
                
                DispatchQueue.main.async(execute: { () -> Void in
                    // print("This is run on the main queue, after the previous code in outer block")
                    //                     self.fetchDataProfile()
                })
            })
        }
        else
        {
        }
        contactDB1?.close()
        //later called by Rajendra jat on 6MArch
        //
        
        //        self.functionForGetZipFilePath()
        
        //        Club Directory parameterst:: ["updatedOn": "2021/05/10 18:04:54", "grpID": "2765"]
        //        Club Directory completeURL:: Optional("http://rowtestapi.rosteronwheels.com/V4/api/Member/GetMemberListSync")
        //
        
        
        
        
        
        
        
        ///
        
        
        
        
        
        
        
        
        
        //MARK:- Update device token
        self.functionForSetDeviceToken()
        
        //MARK:- For Advertizment
        self.getPoPupInfo()
        
        //MARK:- Image buttons click events
        
        viewloadandwillappearCount=1
        UserDefaults.standard.setValue("1", forKey: "isRootVisitedFirst")
        let defaults1 = UserDefaults.standard
        defaults1.set("1", forKey: "splashOver")
        self.edgesForExtendedLayout = UIRectEdge()
        
        //MARK:- When app comes from back to fore
        //NotificationCenter.default.addObserver(self, selector: #selector(RootDashViewController.functionWhenAppwillActivefromBackgroundToForeground), name: NSNotification.Name(rawValue: "functionWhenAppwillActivefromBackgroundToForeground"), object: nil)
        
        //NotificationCenter.default.addObserver(self, selector: #selector(RootDashViewController.functionForDeleteEventThenRefreshMainDashBoardSliderDetails), name: NSNotification.Name(rawValue: "functionForDeleteEventThenRefreshMainDashBoardSliderDetails"), object: nil)
        
        self.view.setNeedsDisplay()
        self.view.setNeedsLayout()
        //        lblClubDistrictName.textColor = UIColor.black
        //        lblDescForSlider.textColor = UIColor.black
        //        lblDateEVENT.textColor = UIColor.black
        //        lblBAEDesc.textColor = UIColor.black
        //        lblDescriptionForBirthAnni.textColor = UIColor.black
        
        //        UIApplication.shared.keyWindow!.bringSubviewToFront(buttonOpticity)
        varGetPickerSelectValue = "Settings"
        //        labelFirstTimeSyncMessage.isHidden=true
//        refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl.addTarget(self, action: #selector(RootDashNewViewController.refresh(_:)), for: UIControl.Event.valueChanged)
        //---
        UserDefaults.standard.setValue("no", forKey: "session_IsEntityExitInModuleScreen")
        //Navigation more functionality ------DPK
        //        viewForSettingPicker.isHidden = true
        //        buttonOpticity.isHidden = true
        //        buttonDonOnPicker.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        mainArraySettingForPicker = ["Settings" , "About Us"]
        menuTitles=NSMutableArray()
        // appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //        addGrpBTn.isHidden=true
        //        viewPopUp.isHidden=true
        let varGetMasterID = UserDefaults.standard.string(forKey: "masterUID") as AnyObject
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        var varMatchRssFeed = UserDefaults.standard.string(forKey: "Session_RssFeedFirstTime")
        let date = Foundation.Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        let year:String! =  String(describing: components.year)
        let month:String! = String(describing: components.month)
        let day:String! = String(describing: components.day)
        var varAddDayMonthYear:String!=""
        varAddDayMonthYear=day+month+year
        
        var varGetRSSFEEDValueDay=UserDefaults.standard.value(forKey: "session_GetFeedValueNew")
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if(varGetRSSFEEDValueDay == nil)
            {
                UserDefaults.standard.setValue(varAddDayMonthYear, forKey: "session_GetFeedValueNew")
                self.beginParsing()
                
            }
            else if(varAddDayMonthYear == (varGetRSSFEEDValueDay)as! String)
            {
                UserDefaults.standard.setValue(nil, forKey: "session_GetFeedValueNew")
                self.beginParsing()
            }
            else
            {
                UserDefaults.standard.setValue(varAddDayMonthYear, forKey: "session_GetFeedValueNew")
                self.beginParsing()
            }
        }
        else
        {
            UserDefaults.standard.setValue(nil, forKey: "session_GetFeedValueNew")
            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
            {
                self.beginParsing()
            }
        }
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //        imageSplashScreenRoot.isHidden=false
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
        }else{
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
        }
        if (contactDB?.open())! {
            let querySQL = "SELECT distinct * FROM GROUPMASTER"
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,  withArgumentsIn: nil)
            if results?.next() == true
            {
                let count = results!.int(forColumnIndex: 0)
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "grpId"))! as String, forKey:"grpId")
                if count > 0
                {
                    //                    imageSplashScreenRoot.isHidden=true
                }
                else
                {
                }
            }
            else
            {
                
                varCheckLoadingOrPicker==0
            }
        }
        //        UIApplication.shared.keyWindow!.bringSubviewToFront( imageSplashScreenRoot)
        let currentWindoww: UIWindow = UIApplication.shared.keyWindow!
        //        currentWindoww.addSubview(imageSplashScreenRoot)
        UserDefaults.standard.setValue("Yes", forKey: "session_IsFirstTime")
    }
    
    @objc func updateData() {
        print("^^^^^^^^^^^^^^API CALLED ROOTVIEW^^^^^^^^^^^^^^^^^^")
        if let value = UserDefaults.standard.string(forKey: "myKey") {
            print("Updated Value: \(value)")
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
                                 self.headTitle = decodedData.registrationResult.result.table[0].applicationNameText
                                 self.uTubeLink = decodedData.registrationResult.result.table[0].youtube
                                 self.instaLink = decodedData.registrationResult.result.table[0].instagram
                                 self.fbLink = decodedData.registrationResult.result.table[0].facebook
                                 self.headImg = decodedData.registrationResult.result.table[0].afterloginlogo
                                 self.loadHeaderLogo(headImg: self.headImg)
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
    
    func loadHeaderLogo(headImg: String) {
            self.downloadImage(from: headImg) { downloadedImage in
                // Use the downloaded image here
                DispatchQueue.main.async {
                    if let image = downloadedImage {
                        // Set the downloaded image to an existing UIImageView
                        self.headerImg.image = image
                        print("IMAGE LOADED4")
                    } else {
                        // Handle the case where the image couldn't be downloaded
                        print("Failed to download image4")
                    }
                }
            }
        }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
            // Check if the URL is valid
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            // Create a URLSessionDataTask to download the image data
            URLSession.shared.dataTask(with: url) { data, response, error in
                // Check for errors
                if let error = error {
                    print("Error downloading image: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                // Check if there is data
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                // Create a UIImage from the downloaded data
                if let image = UIImage(data: data) {
                    // Call the completion handler with the downloaded image
                    completion(image)
                } else {
                    completion(nil)
                }
            }.resume()
        }
    
    @objc func imageViewTapped() {
            print("ImageView tapped!")
        loadDirectoryForQR()
    }
    
    @IBAction func watchLaterAction(_ sender: Any) {
        let completeURL:String=baseUrl+UpdateMobilePupupflag
        let mainMemberID:String = UserDefaults.standard.string(forKey: "masterUID") ?? ""
        let parameters:[String:String]=["FkmasterID":mainMemberID,"Type":"2"]
        
        self.addView.isHidden=true
        
        Alamofire.request(completeURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON(){
            response in
            switch response.result
            {
            case .success:
                print("Popup Response Watch Later is \(response.result.value)")
                break
            case .failure:
                
                break
            }
        }
    }
    
    @IBAction func closePopUpAction(_ sender: Any) {
        let completeURL:String=baseUrl+UpdateMobilePupupflag
        let mainMemberID:String = UserDefaults.standard.string(forKey: "masterUID") ?? ""
        let parameters:[String:String]=["FkmasterID":mainMemberID,"Type":"1"]
        self.addView.isHidden=true
        
        Alamofire.request(completeURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON(){
            response in
            switch response.result
            {
            case .success:
                print("Popup Response Close Add is \(response.result.value)")
                break
            case .failure:
                break
            }
        }
    }
    
    func loadDirectoryForQR() {
        SVProgressHUD.show()
        if let grpIdd = self.listSyncOnline?.groupList?.newGroupList?[0].grpID {
            
            let completeURL = baseUrl + directoryOnline
            
            let parameterst = ["grpID": grpIdd]
            
            print("Club Online Directory parameterst:: \(parameterst)")
            print("Club Online Directory completeURL:: \(completeURL)")
            
            //------------------------------------------------------
            Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    
                    
                         if let value = response.result.value {
                             do {
                                 // Attempt to decode the JSON data
                                 let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                                 let decoder = JSONDecoder()
                                 let decodedData = try decoder.decode(DirectoryOnline.self, from: jsonData)
                                 
                                 // Access the properties of the decoded data
                                 print("Decoded Data --:--- \(decodedData)")
                                 self.dirQROnline = decodedData
                                 for i in 0 ..< (self.dirQROnline?.memberDetail?.memberDetails?.count ?? 0) {
                                     if ((String(self.dirQROnline?.memberDetail?.memberDetails?[i].profileID ?? 0)) == (UserDefaults.standard.string(forKey: "grpProfileID"))) {
                                         self.qrName = self.dirQROnline?.memberDetail?.memberDetails?[i].memberName ?? ""
                                         self.qrMobile = self.dirQROnline?.memberDetail?.memberDetails?[i].memberMobile ?? ""
                                         self.qrSecMobile = self.dirQROnline?.memberDetail?.memberDetails?[i].secondryMobileNo ?? ""
                                         self.qrmemEmail = self.dirQROnline?.memberDetail?.memberDetails?[i].memberEmail ?? ""
                                         self.qrwebText = self.dirQROnline?.memberDetail?.memberDetails?[i].websiteTxt ?? ""
                                         self.qrFBTxt = self.dirQROnline?.memberDetail?.memberDetails?[i].faceBookTxt ?? ""
                                         self.qrinstaTxt = self.dirQROnline?.memberDetail?.memberDetails?[i].instagramTxt ?? ""
                                         self.qrtwitTxt = (self.dirQROnline?.memberDetail?.memberDetails?[i].twitterTxt ?? "") ?? ""
                                         self.qrlnkdTxt = self.dirQROnline?.memberDetail?.memberDetails?[i].linkedInTxt ?? ""
                                         self.qrytTxt = self.dirQROnline?.memberDetail?.memberDetails?[i].youtubeTxt ?? ""
                                         self.qrkeywordTxt = self.dirQROnline?.memberDetail?.memberDetails?[i].keywords ?? ""
                                     }
                                 }
                                 for i in 0 ..< (self.dirQROnline?.memberDetail?.businessDetails?.count ?? 0) {
                                     if ((String(self.dirQROnline?.memberDetail?.businessDetails?[i].profileID ?? 0)) == (UserDefaults.standard.string(forKey: "grpProfileID"))) {
                                         self.qrBussName = self.dirQROnline?.memberDetail?.businessDetails?[i].businessName ?? ""
                                         self.qrBussPosition = self.dirQROnline?.memberDetail?.businessDetails?[i].businessPosition ?? ""
                                         self.qrBussEmail = self.dirQROnline?.memberDetail?.businessDetails?[i].memberBussEmail ?? ""
                                     }
                                 }
                                 for i in 0 ..< (self.dirQROnline?.memberDetail?.addressDetails?.count ?? 0) {
                                     if ((String(self.dirQROnline?.memberDetail?.addressDetails?[i].profileID ?? 0)) == (UserDefaults.standard.string(forKey: "grpProfileID"))) {
                                         if (self.dirQROnline?.memberDetail?.addressDetails?[i].addressType == "Business") {
                                             self.qrBusAddrs = self.dirQROnline?.memberDetail?.addressDetails?[i].address ?? ""
                                             self.qrBussCity = self.dirQROnline?.memberDetail?.addressDetails?[i].city ?? ""
                                             self.qrBussState = self.dirQROnline?.memberDetail?.addressDetails?[i].state ?? ""
                                             self.qrBusspincode = self.dirQROnline?.memberDetail?.addressDetails?[i].pincode ?? ""
                                         }
                                     }
                                 }
                                 DispatchQueue.main.async {
                                     SVProgressHUD.dismiss()
                                     let qrCodeVC = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeViewController") as! QRCodeViewController
                                     qrCodeVC.memName = self.qrName
                                     qrCodeVC.bussName = self.qrBussName
                                     qrCodeVC.memEmail = self.qrmemEmail
                                     qrCodeVC.mobile = self.qrMobile
                                     qrCodeVC.bMail = self.qrBussEmail
                                     qrCodeVC.baddresses = self.qrBusAddrs
                                     qrCodeVC.bcity = self.qrBussCity
                                     qrCodeVC.bstate = self.qrBussState
                                     qrCodeVC.bpostalCode = self.qrBusspincode
                                     qrCodeVC.web = self.qrwebText
                                     qrCodeVC.lnkd = self.qrlnkdTxt
                                     qrCodeVC.yt = self.qrytTxt
                                     qrCodeVC.fb = self.qrFBTxt
                                     qrCodeVC.twit = self.qrtwitTxt
                                     qrCodeVC.insta = self.qrinstaTxt
                                     
                                     self.navigationController?.pushViewController(qrCodeVC, animated: false)
                                 }
                                 
                                 // Access individual properties like decodedData.propertyName
                             } catch {
                                 print("Error decoding JSON: \(error)")
                             }
                         }
                case .failure(_): break
                }
            }
        }
    }
    
    func activityIndicator(_ title: String) {
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        strLabel = UILabel(frame: CGRect(x: view.frame.minX + ((UIScreen.main.bounds.size.width / 4) + 30), y: view.frame.midY, width: 200, height: 60))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 17, weight: .bold)
        strLabel.textColor = UIColor.black
        effectView.frame = CGRect(x: 0, y: 0 , width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        //        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: view.frame.minX + (UIScreen.main.bounds.size.width / 6), y: view.frame.midY, width: 30, height: 60)
        activityIndicator.startAnimating()
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavBar()
        loadDashBoardData()
        //        getCountOfNotification()
        //        NotificationCenter.default.addObserver(self, selector: #selector(getCountOfNotification), name: NSNotification.Name(rawValue: "NotifyDashboard"), object: nil)
        
        
        var databasePath1 : String
        let documents1 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL1 = documents1.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath1 = fileURL1.path
        var db1: OpaquePointer? = nil
        if sqlite3_open(fileURL1.path, &db1) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB1 = FMDatabase(path: databasePath1 as String)
        if contactDB1 == nil {
            print("Error: \(contactDB1?.lastErrorMessage())")
        }
        var varCounting:Int!=0
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        let grpIdddprofile=((UserDefaults.standard.string(forKey: "grpId")) as! String)
        print(grpIdddprofile)
        if (contactDB1?.open())! {
            
            let Count = "SELECT count(*) as Count from ProfileMaster where grpId = '\(grpIdddprofile)'"
            print(Count)
            let resultss:FMResultSet? = contactDB1?.executeQuery(Count,withArgumentsIn: nil)
            while resultss?.next() == true
            {
                varGetCount=resultss?.string(forColumn: "Count")
            }
            
            varCounting = Int(varGetCount)
            // print(varCounting)
        }
        
        //        self.fetchDataProfile()
        if(varCounting>0)
        {
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
            backgroundQueue.async(execute: {
                print("This is run on the background queue")
                
                DispatchQueue.main.async(execute: { () -> Void in
                    // print("This is run on the main queue, after the previous code in outer block")
                    //                     self.fetchDataProfile()
                })
            })
        }
        else
        {
        }
        contactDB1?.close()
        //later called by Rajendra jat on 6MArch
//        self.functionForGetZipFilePath()
        
        
        
        
        
        
        //        fetchData()
        //            collectionView.isUserInteractionEnabled=true
        UserDefaults.standard.set("nothing", forKey: "session_LinkValue")
        UserDefaults.standard.set("no", forKey: "thisiscomingfromdetaileventdelete")
        SVProgressHUD.dismiss()
        
        let getvalue = UserDefaults.standard.string(forKey: "session_IsComingFromProfileDynamicBackagainandagain")
        let varGetValueForUpdateProfile:String!=UserDefaults.standard.value(forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")as? String
        //            if(getvalue=="yes")
        //            {
        //                UserDefaults.standard.setValue("no", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
        //                var alertController = UIAlertController()
        //                self.functionForGetZipFilePath()
        //                alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
        //                self.present(alertController, animated: true, completion: nil)
        //
        //                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
        //                    alertController.dismiss(animated: true, completion: nil)
        //                })
        //            }
        //            if(varGetValueForUpdateProfile=="yes")
        //            {
        //                 UserDefaults.standard.setValue("no", forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")
        //                var alertController = UIAlertController()
        //                           self.functionForGetZipFilePath()
        //                           alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
        //                           self.present(alertController, animated: true, completion: nil)
        //
        //                           DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
        //                               alertController.dismiss(animated: true, completion: nil)
        //               })
        //            }
        
        
        
        //        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        //        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        //        backgroundQueue.async(execute: {
        //            //print("This is run on the background queue")
        //            DispatchQueue.main.async(execute: { () -> Void in
        //                // self.navigationController?.pushViewController(secondViewController, animated: true)
        //            })
        //        })
        
        
        //        ["updatedOn": "1970-01-01 00:00:00", "grpID": "2765"]
        
        
        
        
        //            self.refreshControl?.endRefreshing()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        //            createNavigationBar()
        //            allmoduleCAtArry=[]
        ////            mymoduleCAtArry=[]
        //            if(isGroupAdmin == "Yes" || isGroupAdmin == "yes")
        //            {
        //                savesssfetchData()
        //            }
        //            else
        //            {
        //                functionForGetAssistanceDetails()
        //                savesssfetchData()
        //            }
        //code by Rajendra
        //        }
        //        collectionView.isUserInteractionEnabled=true
        UserDefaults.standard.set("nothing", forKey: "session_LinkValue")
        UserDefaults.standard.set("no", forKey: "thisiscomingfromdetaileventdelete")
        SVProgressHUD.dismiss()
        
        let getvalue1 = UserDefaults.standard.string(forKey: "session_IsComingFromProfileDynamicBackagainandagain")
        let varGetValueForUpdateProfile1:String!=UserDefaults.standard.value(forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")as? String
        if(getvalue1=="yes")
        {
            UserDefaults.standard.setValue("no", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
            var alertController = UIAlertController()
            self.functionForGetZipFilePath()
            alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                alertController.dismiss(animated: true, completion: nil)
            })
        }
        if(varGetValueForUpdateProfile1=="yes")
        {
            UserDefaults.standard.setValue("no", forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")
            var alertController = UIAlertController()
//            self.functionForGetZipFilePath()
            alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                alertController.dismiss(animated: true, completion: nil)
            })
        }
        
        self.refreshControl?.endRefreshing()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        allmoduleCAtArry=[]
        //        mymoduleCAtArry=[]
        if(isGroupAdmin == "Yes" || isGroupAdmin == "yes")
        {
            fetchData()
        }
        else
        {
            functionForGetAssistanceDetails()
            fetchData()
        }
        
        
        
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        print("View Will appear is called**********************************")
        //        userProfileDetail()
        //MARK:- Get Notification Count
        //MARK:- Uncomment this
        getCountOfNotification()
        NotificationCenter.default.addObserver(self, selector: #selector(getCountOfNotification), name: NSNotification.Name(rawValue: "NotifyDashboard"), object: nil)
        
        //MARK:- GetBannerDetailsOffline
        functionDashBoardbirthAnniEventDataGet()
        self.getBirthDayAnniversaryEventsDetails()
        //        DispatchQueue.global(qos:.background).async {
        //        //MARK:- GetBannerDetailsOnline
        //        self.getBirthDayAnniversaryEventsDetails()
        //        }
       
        //MARK:- For version check
        getAppVersionDetails()
        UserDefaults.standard.set("nothing", forKey: "session_LinkValue")
        viewloadandwillappearCount=viewloadandwillappearCount+1
        
        UserDefaults.standard.set("", forKey: "isAdmin")
        //        viewPopUp.isHidden=true
        //        viewPopUp.superview?.bringSubviewToFront(viewPopUp)
        var varIsExistFirstTime=UserDefaults.standard.value(forKey: "session_IsFirstTime")as! String
        if(varIsExistFirstTime=="Yes")
        {
//            self.GetAllGroupListSync()
            self.getAllGroupListOnline()
        }
        else
        {
            UserDefaults.standard.setValue("No", forKey: "session_IsFirstTime")
        }
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            var varGetValue:String! =  UserDefaults.standard.value(forKey: "session_IsEntityExitInModuleScreen")as! String
            if(varGetValue=="yes")
            {
                self.functionForFetchingNotificationCountList()
//                self.GetAllGroupListSync()
                self.getAllGroupListOnline()
                functionForBirthDayAnniversaryEvent()
                UserDefaults.standard.setValue("no", forKey: "session_IsEntityExitInModuleScreen")
            }
            else
            {
//                self.GetAllGroupListSync()
                self.getAllGroupListOnline()
                functionForBirthDayAnniversaryEvent()
            }
        }
        else
        {
//            self.GetAllGroupListSync()
            self.getAllGroupListOnline()
            functionForBirthDayAnniversaryEvent()
            SVProgressHUD.dismiss()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            var getValue=UserDefaults.standard.value(forKey: "isitFirstTimeForDismissHUD")as? String
            
            print(getValue)
            if(getValue != nil)
            {
                print("coming in if side")
                SVProgressHUD.dismiss()
            }
            else
            {
                print("coming in else side")
            }
        })
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupLoaderView() {
        // Set up loader view
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loaderView)
        
        NSLayoutConstraint.activate([
            loaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loaderView.topAnchor.constraint(equalTo: view.topAnchor),
            loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    @objc func refresh(_ sender:AnyObject) {
        // Code to refresh table view
        // refreshControl.endRefreshing()
        self.refreshControl?.endRefreshing()
        self.functionForFetchingNotificationCountList()
        self.collView.reloadData()
        self.refreshControl?.endRefreshing()
        self.refreshControl?.isHidden=true
    }
    
    func hideNavBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func register() {
        collView.register(UINib(nibName: "RootDashNewCVCell", bundle: nil), forCellWithReuseIdentifier: "RootDashNewCVCell")
        collView.register(UINib(nibName: "RotaryIconCVCell", bundle: nil), forCellWithReuseIdentifier: "RotaryIconCVCell")
        collView.register(UINib(nibName: "SocialMediaCVCell", bundle: nil), forCellWithReuseIdentifier: "SocialMediaCVCell")
        self.notifyCountLbl.layer.masksToBounds = true
        self.notifyCountLbl.layer.cornerRadius = 9
    }
    
    func configure() {
        sectionss.removeAll()
        sectionss.append(.clubItems)
        sectionss.append(.infoItems)
        sectionss.append(.socialMedia)
        self.collView.reloadData()
    }
    
    @IBAction func showMenuBtnAction(_ sender: Any) {
        backClicked()
    }
    
    @IBAction func refreshBtnAction(_ sender: Any) {
        self.activityIndicator("Loading Please Wait")
        self.loadDashBoardData()
//        self.GetAllGroupListSync()
        self.getAllGroupListOnline()
        self.collView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.effectView.removeFromSuperview()
        }
    }
    
    @IBAction func notificationBtnAction(_ sender: Any) {
        let viewController=self.storyboard?.instantiateViewController(withIdentifier: "AllNotificationViewController") as! AllNotificationViewController
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

extension RootDashNewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sectionss[section]
        switch section {
        case .clubItems:
            return 1
        case .infoItems:
            return 1
        case .socialMedia:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sectionss[indexPath.section]
        switch section {
        case .clubItems:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"RootDashNewCVCell", for: indexPath) as? RootDashNewCVCell else { return UICollectionViewCell() }
            cell.profilePhotoImgView.image = userImg
            cell.profileNameLbl.text = "Hi \(userName)!"
            cell.editProfile.addTarget(self, action: #selector(moveToEditProfile), for: UIControl.Event.touchUpInside)
            cell.listSyncOnline = self.listSyncOnline
            //            cell.imgView.isUserInteractionEnabled = true
            //            let tap = UITapGestureRecognizer(target: self, action: #selector(self.moveToBanner))
            //            cell.imgView.addGestureRecognizer(tap)
            cell.sections = self.sections
            cell.collectionViewHeight()
            cell.didselectDelegate = self
//            cell.nudgeDelegate = self
//            cell.userProfileEdit.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
            return cell
            
        case .infoItems:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"RotaryIconCVCell", for: indexPath) as? RotaryIconCVCell else { return UICollectionViewCell() }
            cell.navigateIconCellDelegate = self
            cell.headTitle = self.headTitle
            return cell
        case .socialMedia:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"SocialMediaCVCell", for: indexPath) as? SocialMediaCVCell else { return UICollectionViewCell() }
            
            cell.youtube.isUserInteractionEnabled = true
            let tapYoutube = UITapGestureRecognizer(target: self, action: #selector(self.moveToYoutube))
            cell.youtube.addGestureRecognizer(tapYoutube)
            
            cell.facebook.isUserInteractionEnabled = true
            let tapFacebook = UITapGestureRecognizer(target: self, action: #selector(self.moveToFacebook))
            cell.facebook.addGestureRecognizer(tapFacebook)
            
            cell.instagram.isUserInteractionEnabled = true
            let tapInstagram = UITapGestureRecognizer(target: self, action: #selector(self.moveToInstagram))
            cell.instagram.addGestureRecognizer(tapInstagram)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = sectionss[indexPath.section]
        switch section {
        case .clubItems:
            print("self.nudgeViewHeight********************************************\(self.nudgeViewHeight)")
            return CGSize(width: UIScreen.main.bounds.size.width , height: (self.nudgeViewHeight ?? 0) + 70)
        case .infoItems:
            return CGSize(width: UIScreen.main.bounds.size.width, height: 320)
        case .socialMedia:
            return CGSize(width: UIScreen.main.bounds.size.width, height: 86)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let section = sectionss[section]
        switch section {
        case .clubItems:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .infoItems:
            return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        case .socialMedia:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
}
extension RootDashNewViewController {
    @objc func goToProfile() {
        UserDefaults.standard.set("no", forKey: "picadded")
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
        
        profVC.userGroupID =  self.grpDetailPrevious["grpId"] as! String as NSString  //nameTitles[indexPath.row]
        profVC.userProfileID =  self.grpDetailPrevious["grpProfileid"] as! String as NSString  //mobileTitles[indexPath.row]
        profVC.isAdmin = grpDetailPrevious["isGrpAdmin"] as! String as NSString
        profVC.isCalled = "list"
        profVC.mainUSerPRofileID = self.grpDetailPrevious["grpProfileid"] as! String as NSString
        // profVC.isAdmin = "No"
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        // profVC.mainUSerPRofileID = mainMemberID
        self.navigationController?.pushViewController(profVC, animated: true)
    }
}
extension RootDashNewViewController: DidselectDelegate {
    func nudgeHeight(hgt: CGFloat) {
        print("PROTOCOL----------nudgeViewHeight----------------\(hgt)")
        self.collView.collectionViewLayout.invalidateLayout()
        self.nudgeViewHeight = hgt
        
    }
    
    
    func tapBanner() {
        moveToBanner()
    }
    
    
    func didselect(index: Int) {
        viewloadandwillappearCount=0
        
//        var dict:NSDictionary!
        UserDefaults.standard.setValue("No", forKey: "session_IsFirstTime")
        var grp:GroupResult!
        //print(menuTitles)
//        dict = menuTitles[index] as! NSDictionary
//        print(dict)
        let varGetId=listSyncOnline?.groupList?.newGroupList?[index].grpID
        UserDefaults.standard.setValue(varGetId, forKey: "session_GetGroupId")
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainDash") as! MainDashboardViewController
        let isGroupAdminOrNot = listSyncOnline?.groupList?.newGroupList?[index].isGrpAdmin
        print("isGroupAdminOrNot c :: \(String(describing: isGroupAdminOrNot))")
        secondViewController.isGroupAdmin = listSyncOnline?.groupList?.newGroupList?[index].isGrpAdmin
        secondViewController.isGroupProfileID = listSyncOnline?.groupList?.newGroupList?[index].grpProfileID
        secondViewController.isCategory=listSyncOnline?.groupList?.newGroupList?[index].myCategory
        secondViewController.varGetId=varGetId
        secondViewController.groupUniqueName = listSyncOnline?.groupList?.newGroupList?[index].grpName
        secondViewController.listSyncOnline = self.listSyncOnline
        secondViewController.titleRIZone = self.headTitle
        
        UserDefaults.standard.set(listSyncOnline?.groupList?.newGroupList?[index].isGrpAdmin, forKey: "isAdmin")
        UserDefaults.standard.setValue(listSyncOnline?.groupList?.newGroupList?[index].grpProfileID, forKey: "session_grpProfileid")
        secondViewController.varGetGroupId = listSyncOnline?.groupList?.newGroupList?[index].grpID
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}
extension RootDashNewViewController: NavigateIconCell {
    
    func findClub() {
        if let storyboard = self.storyboard {
            let AnyClubNewViewController = storyboard.instantiateViewController(withIdentifier: "AnyClubNewViewController")
            AnyClubNewViewController.title = "Any Club"
            
            let NearMeNewViewController = storyboard.instantiateViewController(withIdentifier: "NearMeNewViewController")
            NearMeNewViewController.title = "Near Me"
            
            let segmentController = SJSegmentedViewController()
            //            segmentController.navHide = true
            segmentController.segmentControllers = [AnyClubNewViewController,NearMeNewViewController]
            segmentController.isFrom = true
            navigationController?.pushViewController(segmentController, animated: true)
        }
    }
    
    func findRotarian() {
        let objFinddArotarianViewController = self.storyboard?.instantiateViewController(withIdentifier: "FinddArotarianViewController") as! FinddArotarianViewController
        objFinddArotarianViewController.moduleName = "Find a Rotarian"
        //            UserDefaults.standard.setValue("27", forKey: "session_GetModuleId")
        self.navigationController?.pushViewController(objFinddArotarianViewController, animated: true)
    }
    
    func referFriend() {
        let webScreen = self.storyboard?.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        webScreen.varOpenUrl = "https://prospective.rotaryindia.org/prospective?fk_main_member_master_id=\(mainMemberID ?? "")"
        webScreen.navTitle = "Refer A Friend"
        print(webScreen.varOpenUrl)
        self.navigationController?.pushViewController(webScreen, animated: true)
    }
    
    
    func webView(url: String?, title: String?) {
        
//        let webScreen = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
//        webScreen.url = url ?? ""
//        webScreen.moduleName = title ?? ""
//        webScreen.varFromCalling = "Edit Profile"
//        print(webScreen.URLstr)
//        self.navigationController?.pushViewController(webScreen, animated: true)
        
        let webScreen = self.storyboard?.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
        webScreen.varOpenUrl = url ?? ""
        webScreen.navTitle = title ?? ""
        print(webScreen.varOpenUrl)
        self.navigationController?.pushViewController(webScreen, animated: true)
    }
    
}

extension RootDashNewViewController {
    
    @objc func backClicked() {
        
        //        if  menuTitles.count == 0
        //        {
        //           return
        //        }
        //        if let dict:NSDictionary = menuTitles[0] as? NSDictionary
        //        {
        //         let obj = self.storyboard?.instantiateViewController(withIdentifier: "MainDashboardWithSideBarViewController") as! MainDashboardWithSideBarViewController
        //         obj.grpDetailPrevious=dict
        //         obj.getGroupDistrictList = groupList
        //         self.navigationController?.pushViewController(obj, animated: true)
        //        }
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "MainDashboardWithSideBarViewController") as! MainDashboardWithSideBarViewController
        //                obj.grpDetailPrevious=dict
        print(groupList)
        obj.getGroupDistrictList = groupList
        obj.listSyncOnline = self.listSyncOnline
        obj.headTitle = self.headTitle
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @objc func moveToYoutube() {
        let editProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
        editProfileScreen.varOpenUrl = self.uTubeLink
        editProfileScreen.navTitle = "Youtube"
        print(editProfileScreen.varOpenUrl)
        self.navigationController?.pushViewController(editProfileScreen, animated: true)
        
    }
    
    @objc func moveToInstagram() {
        let editProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
        editProfileScreen.varOpenUrl = self.instaLink
        editProfileScreen.navTitle = "Instagram"
        print(editProfileScreen.varOpenUrl)
        self.navigationController?.pushViewController(editProfileScreen, animated: true)
        
    }
    
    @objc func moveToFacebook() {
        let editProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
        editProfileScreen.varOpenUrl = self.fbLink
        editProfileScreen.navTitle = "Facebook"
        print(editProfileScreen.varOpenUrl)
        self.navigationController?.pushViewController(editProfileScreen, animated: true)
        
    }
    
    @objc func moveToEditProfile() {
        let editProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
        editProfileScreen.varOpenUrl = "https://profile.rotaryindia.org/?fk_main_member_master_id=\(self.masterUId!)&isadmin=\(self.userId)"
        editProfileScreen.navTitle = "Edit Profile"
        print(editProfileScreen.varOpenUrl)
        self.navigationController?.pushViewController(editProfileScreen, animated: true)
        
//        let editProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
//        editProfileScreen.url = "https://profile.rotaryindia.org/?fk_main_member_master_id=\(self.masterUId!)&isadmin=\(self.userId)"
//        editProfileScreen.moduleName = "Edit Profile"
//        editProfileScreen.varFromCalling = "Edit Profile"
//        print(editProfileScreen.URLstr)
//        self.navigationController?.pushViewController(editProfileScreen, animated: true)
    
}
    
    func moveToBanner() {
        let BannerController = self.storyboard?.instantiateViewController(withIdentifier: "BannerListViewController") as! BannerListViewController
        BannerController.bannerListArr = self.bannerListArr
        print(BannerController.bannerListArr)
        self.navigationController?.pushViewController(BannerController, animated: true)
    }
}

extension RootDashNewViewController {
    
    func loadDashBoardData() {
        let completeURL = baseUrl+"Login/GetWelcomeScreen"
        var masterUId = UserDefaults.standard.string(forKey: "masterUID")
        var varGetMobileNumber: String? = UserDefaults.standard.value(forKey: "session_Mobile_Number")as! String
        var varGetLoginType: String?  = UserDefaults.standard.value(forKey: "session_Login_Type")as! String
                if let masterID = masterUId, let loginType = varGetLoginType, let mobile = varGetMobileNumber {
        let parameterst = [ "masterUID": masterID, "loginType": loginType, "mobileNo": mobile]
        
        print(parameterst)
        print(completeURL)
        
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            print(response)
            
            var loadedDataResult = response
            //            let arrayNew=((response.value(forKey: "TBEventListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newEvents")as! NSArray
            print(loadedDataResult)
            print( (loadedDataResult.value(forKey: "WelcomeResult")as? AnyObject)?.value(forKey: "isadmin")as? String )
            self.userId = (loadedDataResult.value(forKey: "WelcomeResult")as? AnyObject)?.value(forKey: "isadmin")as? String ?? ""
            UserDefaults.standard.set(self.userId, forKey: "userID")
            self.userName = (loadedDataResult.value(forKey: "WelcomeResult")as? AnyObject)?.value(forKey: "Name")as? String ?? ""
            //            self.clubName =
            DispatchQueue.main.async {
                let userProfileURL = (loadedDataResult.value(forKey: "WelcomeResult")as? AnyObject)?.value(forKey: "ProfilePhoto")as? String
                if let url = URL(string:userProfileURL ?? "") {
                    if let data = try? Data(contentsOf: url)
                    {
                        self.userImg = UIImage(data: data)
                    }
                }
            }
            self.collView.reloadData()
        })
        self.indicator.isHidden = true
    }
    }
    
    func functionForBirthDayAnniversaryEvent()
    {
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        let completeURL:String! = baseUrl+row_GetDashboardBirthAnniEvent
        let parameterst = ["MasterId": mainMemberID!]
        
        
        print(parameterst)
        print(completeURL)
        
        DispatchQueue.main.async{
            //            self.indicator.startAnimating()
            //            self.lblBAEDesc.text!=""
        }
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 200
        
        manager.request(completeURL, method: .post, parameters:parameterst,encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
            
            switch response.result {
            case .success:
                print("Banner API main response @ \(Date())")
                if let value = response.result.value {
                    //                    self.labelFirstTimeSyncMessage.isHidden=true
                    print("22222222This is device token by Rajendra JAt 1 March !!!!!")
                    SVProgressHUD.dismiss()
                    let dd = response.result.value as! NSDictionary
                    var varGetValueServerError = dd.object(forKey: "serverError")as? String
                    
                    if(varGetValueServerError == "Error")
                    {
                        self.getBirthDayAnniversaryEventsDetails()
                        SVProgressHUD.dismiss()
                    }
                    else
                    {
                        SVProgressHUD.dismiss()
                        print(dd)
                        if((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "status") as! String == "0")
                        {
                            self.functionDashboardBirthAnniEventDelete()
                            self.muarrayForBirthdayAnniversaryEvent=NSMutableArray()
                            
                            if let subToSubCategoryList = (dd.value(forKey: "TBDashboardResult")! as AnyObject).value(forKey: "Result") as? NSArray
                            {
                                self.bannerListArr=subToSubCategoryList
                            }
                            
                            print(self.bannerListArr)
                            
                            print("Banner API Response @ \(Date())")
                            
                        }
                        else
                        {
                            //                            self.indicator.stopAnimating()
                            //                            self.imgGrayIconROW.isHidden=false
                        }
                    }
                    if self.muarrayForBirthdayAnniversaryEvent.count == 0
                    {
                        //                        self.imgGrayIconROW.isHidden=false
                    }
                }
                //                self.labelFirstTimeSyncMessage.isHidden=true
                print("Rotaryyyy India failed")
            case .failure(_):break
            }
            
            print("Rotaryyyy Indiaaaaa")
            
        }
        
        print("Rotaryyyy Indiaaaaa 1234567890")
    }
    
    func getBirthDayAnniversaryEventsDetails()
    {
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        print(day)
        print(month)
        print(year)
        var todayDate:String!=String(day)+String(month)+String(year)
        var getDifferenceofDate=UserDefaults.standard.value(forKey: "session_DateDifference")as? String
        print(todayDate)
        print(getDifferenceofDate)
        if(todayDate==getDifferenceofDate)
        {
            print("if coming")
            if(muarrayForBirthdayAnniversaryEvent.count>0)
            {
                print("This is if condition 7 may")
            }
            else
            {
                print("This is else condition 7 may")
                //                functionForBirthDayAnniversaryEvent()
            }
        }
        else
        {
            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
            {
                print("This is if-else condition 7 may")
                //---delete old value from server in case of Birthday Anniversary Event start
                DELETEDashboard_BirthAnniEvent_table_New()
                //---delete old value from server in case of Birthday Anniversary Event ens
                print("else coming")
                UserDefaults.standard.setValue(todayDate, forKey: "session_DateDifference")
                //            functionForBirthDayAnniversaryEvent()
            }
        }
    }
    
    func functionDashboardBirthAnniEventDelete()
    {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        var getDateForCompare = UserDefaults.standard.value(forKey: "session_isCompareDateNew") as? String
        var finalDate:String=String(day)+String(month)+String(year)
        if((getDateForCompare == nil) || (getDateForCompare != finalDate))
        {
            DELETEDashboard_BirthAnniEvent_table_New()
            UserDefaults.standard.setValue(finalDate, forKey: "session_isCompareDateNew")
        }
        else
        {
            print("else")
        }
    }
    
    func DELETEDashboard_BirthAnniEvent_table_New()
    {
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        databasePath = fileURL.path
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
        }
        else if (contactDB?.open())!
        {
            let insertSQL = "DELETE FROM Dashboard_BirthAnniEvent_table_New"
            let result = contactDB?.executeStatements(insertSQL)
        }
    }
}


enum RotaryClubItem {
    case clubItems
    case infoItems
    case socialMedia
}


//TODO: ROOTDASH VIEWCONTROLLER

extension RootDashNewViewController {
    
    func userProfileDetail(){
        let userProfileUrl:String! = "http://rotaryindiaapi.rosteronwheels.com/api/Member/GetProfile"
        
        let para = ["MemberId":"376941"]
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: userProfileUrl, parameters: para, forTask: TaskType.kUserProfileDetailList, currentView: self.view, useAccessToken: false, completionHandler:  {(response: AnyObject) -> Void in
            let dd = response as! NSDictionary
            var varGetValueServerError = dd.object(forKey: "message")as? String
            //            print(dd)
            if(varGetValueServerError == "Error")
            {
                SVProgressHUD.dismiss()
            }
            else
            {
                if((((dd.object(forKey: "message")! as AnyObject) as! String) == "Success") && (((dd.object(forKey: "status")! as AnyObject) as! String) == "0"))
                {
                    //                    var dictTemporaryDictionary:NSDictionary=((dd.value(forKey: "TBVersionResult")! as AnyObject).value(forKey: "Result")! as AnyObject).object(at: 0)
                    //                    self.ituneDynamicUrlFromServer=dictTemporaryDictionary.value(forKey: "URL")as! String
                    //                    var versionNumber:String!=dictTemporaryDictionary.value(forKey: "versionNumber")as! String
                    self.getUpdateAppVersionPOPUP()
                    
                    
                    self.userProfileDict = ((dd.value(forKey: "result")! as AnyObject).value(forKey: "Table")! as AnyObject).object(at: 0)
                    print(self.userProfileDict)
                }
            }
        })
        
    }
    
    func getAppVersionDetails()
    {
        let completeURL:String! = baseUrl+"versionList/GetVersionList"
        let parameterst = [
            "Type":"IOS"
        ]
        print(completeURL)
        print(parameterst)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            let dd = response as! NSDictionary
            print(dd)
            var varGetValueServerError = dd.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                SVProgressHUD.dismiss()
            }
            else
            {
                if(((dd.object(forKey: "TBVersionResult")! as AnyObject).object(forKey: "status") as! String == "0") && ((dd.object(forKey: "TBVersionResult")! as AnyObject).object(forKey: "message") as! String == "success"))
                {
                    var dictTemporaryDictionary:NSDictionary=((dd.value(forKey: "TBVersionResult")! as AnyObject).value(forKey: "Result")! as AnyObject).object(at: 0)
                    self.ituneDynamicUrlFromServer=dictTemporaryDictionary.value(forKey: "URL")as? String
                    var versionNumber:String!=dictTemporaryDictionary.value(forKey: "versionNumber")as? String
                    self.getUpdateAppVersionPOPUP()
                }
            }
        })
    }
    
    @objc func getCountOfNotification()
    {
        let nModel:NotificaioModel=NotificaioModel()
        nModel.deleteNotification(byMsgID: "", state: .Defaults)
        nModel.getNotificationCount(byMsgID: "", state: "") { (result) in
            print("Notification Count is here \(result)")
            if result=="0"
            {
                self.notifyCountLbl.isHidden=true
            }
            else
            {
                self.notifyCountLbl.isHidden=false
                                self.notifyCountLbl.text = result
//                                self.notifyCountLbl .setTitle(result, for: UIControl.State.normal)
            }
        }
    }
    
    func functionForAddNewMembers(_ dictNewMemberListjsonResult:NSDictionary)
    {
        // print(dictNewMemberListjsonResult)
        let moduleID = "1"
        let GroupID=((UserDefaults.standard.string(forKey: "grpId")) as! String)
        //        var moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
        //        var GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        print(GroupID)
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            contactDB?.beginTransaction()
            
            for i in 0 ..< (dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).count
            {
                autoreleasepool {
                    // let  dict = arrdata[i] as! NSDictionary
                    let dictMain=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                    let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
                    let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
                    let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
                    let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
                    var memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
                    let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
                    let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
                    var memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
                    let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
                    let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
                    
                    let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
                    let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
                    let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
                    //print("Profile Master",i)
                    
                    
                    
                    print(dictNewMemberListjsonResult)
                    var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    
                    print("this is name by rajendra jat")
                    //                print(memberName)
                    //                print(dictNewMemberListjsonResult)
                    memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
                    
                    
                    
                    
                    //                print(dictMain)
                    //                print(profilePic)
                    //                print(familyPic)
                    
                    if(memberCountry.characters.count>2)
                    {
                        
                    }
                    else
                    {
                        memberCountry="India"
                    }
                    
                    
                    let insertSQL = "INSERT INTO ProfileMaster (masterId,grpId,profileId,isAdmin,memberName,memberEmail,memberMobile,memberCountry,profilePic,familyPic,isPersonalDetVisible,isBussinessDetVisible,isFamilyDetVisible) VALUES('"+masterID+"','"+grpID+"','"+profileID+"','"+isAdmin+"','"+memberNames+"','"+memberEmail+"','"+memberMobile+"','"+memberCountry+"','"+profilePic+"','"+familyPic+"','"+isPersonalDetVisible+"','"+isBusinDetVisible+"','"+isFamilDetailVisible+"')"
                    print(insertSQL)
                    let result = contactDB?.executeStatements(insertSQL)
                    if (result == nil)
                    {
                        print("ErrorAi: \(contactDB?.lastErrorMessage())")
                    }
                    else
                    {
                        var dihjkctTehjkmpochjkvxraryDicxcvtioxcvnary:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                        
                        for j in 0 ..< (dihjkctTehjkmpochjkvxraryDicxcvtioxcvnary.object(forKey: "personalMemberDetails")! as AnyObject).count
                        {
                            let dictChild=(dihjkctTehjkmpochjkvxraryDicxcvtioxcvnary.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
                            let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                            let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                            let key=(dictChild as AnyObject).object(forKey: "key")as! String
                            var value=(dictChild as AnyObject).object(forKey: "value")as! String
                            let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                            let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                            let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                            
                            //print("PersonalBusinessMemberDetails Personal",j)
                            value=(value as NSString).replacingOccurrences(of: "'", with: "`")
                            
                            
                            
                            let childSQLl = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','personal','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                            //   print(childSQLl)
                            let result = contactDB?.executeStatements(childSQLl)
                            if (result == nil)
                            {
                                print("ErrorAi: \(contactDB?.lastErrorMessage())")
                            }
                            else
                            {
                                
                            }
                        }
                        //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                        // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!./count)
                        
                        var didfgctdgTempdfgorarydfgDicdfgtionardfgyghdfg:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                        
                        for j in 0 ..< (didfgctdgTempdfgorarydfgDicdfgtionardfgyghdfg.object(forKey: "businessMemberDetails")! as AnyObject).count
                        {
                            let dictChild=(didfgctdgTempdfgorarydfgDicdfgtionardfgyghdfg.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
                            let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                            let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                            let key=(dictChild as AnyObject).object(forKey: "key")as! String
                            let value=(dictChild as AnyObject).object(forKey: "value")as! String
                            let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                            let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                            let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                            
                            let childSQLNewww = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','Business','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                            // print(childSQLNewww)
                            
                            //print("PersonalBusinessMemberDetails Business",j)
                            
                            
                            let result = contactDB?.executeStatements(childSQLNewww)
                            if (result == nil)
                            {
                                print("ErrorAi: \(contactDB?.lastErrorMessage())")
                            }
                            else
                            {
                                
                            }
                        }
                        //3. PersonalBusinessMemberDetails
                        // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("familyMembdfgerDetails")!.count)
                        // for k in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(0).objectForKey("familyMemsdfgberDetails")!.count
                        
                        
                        
                        var dfdidctTemporaryDictionarybnvcxzvbnmcdsx:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                        
                        
                        
                        for k in 0 ..< ((dfdidctTemporaryDictionarybnvcxzvbnmcdsx.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                        {
                            let isVisible=(dfdidctTemporaryDictionarybnvcxzvbnmcdsx.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
                            let dictChild=((dfdidctTemporaryDictionarybnvcxzvbnmcdsx.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)
                            
                            let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
                            let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
                            let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
                            let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
                            let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
                            let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
                            let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
                            let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
                            let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
                            
                            
                            let familyMemberDetails = "INSERT INTO FamilyMemberDetail (profileId,isVisible,familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,particulars,bloodGroup,masterId) VALUES("+profileID+",'"+isVisible+"','"+familyMemberId+"','"+memberName+"','"+relationship+"','"+dob+"','"+emailID+"','"+anniversary+"','"+contactNo+"','"+particulars+"','"+bloodGroup+"','"+masterID+"')"
                            
                            let result = contactDB?.executeStatements(familyMemberDetails)
                            if (result == nil)
                            {
                                print("ErrorAi: \(contactDB?.lastErrorMessage())")
                            }
                            else
                            {
                                
                            }
                        }
                        //4.  AddressDetails
                        
                        
                        var hjdihjkctTemkhjporaryDictionacdzxdryhjk:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                        
                        
                        let dictChild=(hjdihjkctTemkhjporaryDictionacdzxdryhjk.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")
                        
                        print("my value:------ ")
                        print(dictChild)
                        
                        for l in 0 ..< ((hjdihjkctTemkhjporaryDictionacdzxdryhjk.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
                        {
                            let isBusinessAddrVisible=(hjdihjkctTemkhjporaryDictionacdzxdryhjk.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
                            let isResidanceAddrVisible=(hjdihjkctTemkhjporaryDictionacdzxdryhjk.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
                            
                            
                            var dictTemporaryDictionarydfdsdyttysfsdf:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                            
                            let dictChild=((dictTemporaryDictionarydfdsdyttysfsdf.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
                            
                            let address=(dictChild as AnyObject).object(forKey: "address")as! String
                            let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
                            let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
                            let city=(dictChild as AnyObject).object(forKey: "city")as! String
                            var country=(dictChild as AnyObject).object(forKey: "country")as! String
                            let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
                            let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
                            let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
                            //print(pincode)
                            let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
                            
                            let state=(dictChild as AnyObject).object(forKey: "state")as! String
                            // print(state)
                            
                            print("this is country from rajendra side 88888")
                            print(country)
                            
                            if(country.characters.count>2)
                            {
                                
                            }
                            else
                            {
                                country="India"
                            }
                            
                            print("This is value by rajenadra jat˙˙˙˙˙˙˙˙˙˙˙¬¬˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚")
                            print(country)
                            let familyMemberDetails = "INSERT INTO AddressDetails (profileId,AddressprofileId,addressID,addressType,address,city,state,country,pincode,phoneNo,fax,isBusinessAddrVisible,isResidanceAddrVisible,masterId) VALUES("+profileID+",'"+AddressprofileId+"','"+addressID+"','"+addressType+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+phoneNo+"','"+fax+"','"+isBusinessAddrVisible+"','"+isResidanceAddrVisible+"','"+masterID+"')"
                            
                            //  print(familyMemberDetails)
                            //print("AddressDetails",l)
                            
                            let result = contactDB?.executeStatements(familyMemberDetails)
                            if (result == nil)
                            {
                                print("ErrorAi: \(contactDB?.lastErrorMessage())")
                            }
                            else
                            {
                                
                            }
                        }
                    }
                }
            }
            contactDB?.commit()
            contactDB?.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        print(varGetForLoopCounting)
        print(varGetTotalFilesCount)
        
        if(varGetForLoopCounting==varGetTotalFilesCount)
        {
            fetchData()
        }
        
    }
    
    func functionForUpdateMembers(_ dictNewMemberListjsonResult:NSDictionary)
    {
        print(dictNewMemberListjsonResult)
        //       print(UserDefaults.standard.value(forKey: "session_GetModuleId")as! String)
        //        var moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
        //        var GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        let moduleID = "1"
        let GroupID=((UserDefaults.standard.string(forKey: "grpId")) as! String)
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
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            contactDB?.beginTransaction()
            print("11This is count of main start point of file:-----------")
            print((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).count)
            for i in 0 ..< (dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).count
            {
                
                let dictMain=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                
                
                let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
                let memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
                var memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
                
                
                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
                
                
                if(memberCountry.characters.count>2)
                {
                    
                }
                else
                {
                    memberCountry="India"
                }
                
                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
                
                
                print(profilePic)
                print(familyPic)
                print(dictMain)
                
                let insertSQLUpdate = "UPDATE ProfileMaster SET grpId='"+grpID+"' ,isAdmin='"+isAdmin+"',memberName='"+memberNames+"',memberEmail='"+memberEmail+"',memberMobile='"+memberMobile+"',memberCountry='"+memberCountry+"',profilePic='"+profilePic+"',familyPic='"+familyPic+"',isPersonalDetVisible='"+isPersonalDetVisible+"',isBussinessDetVisible='"+isBusinDetVisible+"',isFamilyDetVisible='"+isFamilDetailVisible+"' where masterId="+masterID+" and profileId='"+profileID+"'"
                print("user image !")
                print(insertSQLUpdate)
                
                let result = contactDB?.executeStatements(insertSQLUpdate)
                /*
                 for j in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("personalMemberDetails")!.count
                 {
                 let dictChild=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("personalMemberDetails")!.objectAtIndex(j)
                 let fieldID=dictChild.objectForKey("fieldID")as! String
                 let uniquekey=dictChild.objectForKey("uniquekey")as! String
                 let key=dictChild.objectForKey("key")as! String
                 let value=dictChild.objectForKey("value")as! String
                 let colType=dictChild.objectForKey("colType")as! String
                 let isEditable=dictChild.objectForKey("isEditable")as! String
                 let isVisible=dictChild.objectForKey("isVisible")as! String
                 let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='personal',masterId='"+masterID+"' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"'and groupId='"+GroupID+"'"
                 let result = contactDB?.executeStatements(childSQLUpdate)
                 }
                 */
                
                /*££££££££££££££££££££££££‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹*/
                
                
                var diasdctTemaasdsdporarasdyDictionarysdsadsa:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                
                for j in 0 ..< (diasdctTemaasdsdporarasdyDictionarysdsadsa.object(forKey: "personalMemberDetails")! as AnyObject).count
                {
                    let dictChild=(diasdctTemaasdsdporarasdyDictionarysdsadsa.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
                    var value=(dictChild as AnyObject).object(forKey: "value")as! String
                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                    value=(value as NSString).replacingOccurrences(of: "'", with: "`")
                    
                    /*
                     let insertSQLDelete = "DELETE FROM  PersonalBusinessMemberDetails  where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"'and groupId='"+GroupID+"'"
                     let result = contactDB?.executeStatements(insertSQLDelete)
                     */
                    
                    
                    
                    
                    
                    let childSQLl = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','personal','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                    let resultT = contactDB?.executeStatements(childSQLl)
                    
                }
                /*££££££££££££££££££££££££‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹*/
                
                var asddasdicastTeasdmdporarydDictidaqwonarysdsasd:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                
                for j in 0 ..< (asddasdicastTeasdmdporarydDictidaqwonarysdsasd.object(forKey: "businessMemberDetails")! as AnyObject).count
                {
                    let dictChild=(asddasdicastTeasdmdporarydDictidaqwonarysdsasd.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
                    let value=(dictChild as AnyObject).object(forKey: "value")as! String
                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                    
                    /*
                     let insertSQLDelete = "DELETE FROM  PersonalBusinessMemberDetails  where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"' and groupId='"+GroupID+"'"
                     let result = contactDB?.executeStatements(insertSQLDelete)
                     */
                    
                    
                    
                    let childSQLNewww = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','Business','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                    let resultT = contactDB?.executeStatements(childSQLNewww)
                    
                }
                /*££££££££££££££££££££££££‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹*/
                
                
                
                
                
                
                //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                /*
                 for j in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!.count
                 {
                 
                 let dictChild=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!.objectAtIndex(j)
                 let fieldID=dictChild.objectForKey("fieldID")as! String
                 let uniquekey=dictChild.objectForKey("uniquekey")as! String
                 let key=dictChild.objectForKey("key")as! String
                 let value=dictChild.objectForKey("value")as! String
                 let colType=dictChild.objectForKey("colType")as! String
                 let isEditable=dictChild.objectForKey("isEditable")as! String
                 let isVisible=dictChild.objectForKey("isVisible")as! String
                 
                 
                 let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='Business',masterId='"+masterID+"' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"' and groupId='"+GroupID+"'"
                 
                 let result = contactDB?.executeStatements(childSQLUpdate)
                 
                 }
                 */
                //3. PersonalBusinessMemberDetails
                var dictTempsdforasdfryDictionaryfddsfsafdsfds:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                for k in 0 ..< ((dictTempsdforasdfryDictionaryfddsfsafdsfds.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                {
                    
                    let isVisible=(dictTempsdforasdfryDictionaryfddsfsafdsfds.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
                    let dictChild=((dictTempsdforasdfryDictionaryfddsfsafdsfds.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)
                    
                    let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
                    let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
                    let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
                    let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
                    let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
                    let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
                    let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
                    let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
                    let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
                    
                    let familyMemberDetailsUpdate = "UPDATE FamilyMemberDetail  SET isVisible='"+isVisible+"',memberName='"+memberName+"',relationship='"+relationship+"',dob='"+dob+"',emailID='"+emailID+"',anniversary='"+anniversary+"',contactNo='"+contactNo+"',particulars='"+particulars+"',bloodGroup='"+bloodGroup+"',masterId='"+masterID+"' WHERE familyMemberId='"+familyMemberId+"' and profileId='"+profileID+"'"
                    
                    let result = contactDB?.executeStatements(familyMemberDetailsUpdate)
                    
                }
                
                //4.  AddressDetails
                
                
                var disdfctTesdfmposdfraryDictiodsdfdsnary:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                
                
                let dictChild=(disdfctTesdfmposdfraryDictiodsdfdsnary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")
                for l in 0 ..< ((disdfctTesdfmposdfraryDictiodsdfdsnary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
                {
                    
                    var dictsdadaasdTemertposdraryDictionary:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                    
                    
                    
                    let isBusinessAddrVisible=(dictsdadaasdTemertposdraryDictionary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
                    let isResidanceAddrVisible=(dictsdadaasdTemertposdraryDictionary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
                    
                    let dictChild=((dictsdadaasdTemertposdraryDictionary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
                    
                    let address=(dictChild as AnyObject).object(forKey: "address")as! String
                    let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
                    let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
                    let city=(dictChild as AnyObject).object(forKey: "city")as! String
                    var country=(dictChild as AnyObject).object(forKey: "country")as! String
                    let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
                    let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
                    let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
                    let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
                    let state=(dictChild as AnyObject).object(forKey: "state")as! String
                    
                    
                    print("this is country from rajendra side 666666")
                    print(country)
                    if(country.characters.count>2)
                    {
                        
                    }
                    else
                    {
                        country="India"
                    }
                    
                    let addressDetailUpdate = "UPDATE AddressDetails  SET AddressprofileId='"+AddressprofileId+"',addressType='"+addressType+"',address='"+address+"',city='"+city+"',state='"+state+"',country='"+country+"',pincode='"+pincode+"',phoneNo='"+phoneNo+"',fax='"+fax+"',isBusinessAddrVisible='"+isBusinessAddrVisible+"',isResidanceAddrVisible='"+isResidanceAddrVisible+"',masterId='"+masterID+"' WHERE addressID='"+addressID+"' and profileId='"+profileID+"'"
                    
                    let result = contactDB?.executeStatements(addressDetailUpdate)
                    
                }
                
                
                
            }
            
        }
        contactDB?.commit()
        contactDB?.close()
    }
    
    func functionForGetNewUpdateDeleteMember()
    {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        //1.New members
        let MyFilesPath = documentsPath.appendingPathComponent("/NewMembers")
        do {
            let fileList = try FileManager.default.contentsOfDirectory(atPath: MyFilesPath)
            let count = fileList.count
            varGetTotalFilesCount=count
            print(fileList)
            print(count)
            for i in 0 ..< count
            {
                // print(fileList[i])
                if(fileList[i].hasPrefix("New"))
                {
                    
                    let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: MyFilesPath+"/"+fileList[i]))
                    do
                    {
                        let NewMemberListjsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
                        // if(fileList[i]=="New7.json")
                        //{
                        print(fileList[i])
                        //print(NewMemberListjsonResult)
                        print(NewMemberListjsonResult)
                        varGetForLoopCounting=i+1
                        /*------------§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§£££££££££££££££££££££££££££------------------------*/
                        let zipPath:String =  MyFilesPath+"/"+fileList[i]
                        let fileManager = FileManager.default
                        try fileManager.removeItem(atPath: zipPath)
                        self.functionForAddNewMembers(NewMemberListjsonResult)
                    }
                    catch
                    {
                    }
                }
            }
        }
        catch
        {
        }
        //2.Update members
        let MyFilesPath2 = documentsPath.appendingPathComponent("/UpdatedMembers")
        do {
            let fileList = try FileManager.default.contentsOfDirectory(atPath: MyFilesPath2)
            let count = fileList.count
            //print(fileList)
            print(count)
            for i in 0 ..< count
            {
                // print(fileList[i])
                if(fileList[i].hasPrefix("Update"))
                {
                    let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: MyFilesPath2+"/"+fileList[i]))
                    do
                    {
                        print(MyFilesPath2+"/"+fileList[i])
                        let UpdateMemberListjsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
                        print(UpdateMemberListjsonResult)
                        // if(fileList[i]=="New7.json")
                        //{
                        //print("This is file name:----")
                        print(fileList[i])
                        //print(UpdateMemberListjsonResult)
                        self.functionForUpdateMembers(UpdateMemberListjsonResult)
                        
                        let zipPath:String =  MyFilesPath2+"/"+fileList[i]
                        
                        //   print(zipPath)
                        // if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
                        //  {
                        let fileManager = FileManager.default
                        try fileManager.removeItem(atPath: zipPath)
                        
                        //}
                    }
                    catch
                    {
                    }
                }
            }
        }
        catch
        {
        }
        //3.Delete members
        let MyFilesPath3 = documentsPath.appendingPathComponent("/DeletedMembers")
        do {
            let fileList = try FileManager.default.contentsOfDirectory(atPath: MyFilesPath3)
            let count = fileList.count
            //print(fileList)
            // print(count)
            for i in 0 ..< count
            {
                //  print(fileList[i])
                if(fileList[i].hasPrefix("Delete"))
                {
                    let letGetDeletedID = try NSString(contentsOf:URL(fileURLWithPath: (MyFilesPath3+"/"+fileList[i])), encoding: String.Encoding.utf8.rawValue)
                    // print(letGetDeletedID)
                    let letGetId=letGetDeletedID.components(separatedBy: ",")
                    self.functionForDeleteMembers(letGetId)
                    let zipPath:String =  MyFilesPath3+"/"+fileList[i]
                    
                    //   print(zipPath)
                    // if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
                    //  {
                    let fileManager = FileManager.default
                    try fileManager.removeItem(atPath: zipPath)
                    
                    
                    
                }
            }
        }
        catch
        {
        }
        fetchData()
    }
    
    func functionForDeleteMembers(_ muaarayDeleteMemberListjsonResult:[String])
    {
        // print(muaarayDeleteMemberListjsonResult)
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            //print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            //print("Error: \(contactDB.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            contactDB?.beginTransaction()
            print("-------------Deleted---Queries----------------")
            for i in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let insertSQLDelete = "DELETE FROM  ProfileMaster  where profileId in ("+muaarayDeleteMemberListjsonResult[i]+")"
                print(insertSQLDelete)
                let result = contactDB?.executeStatements(insertSQLDelete)
                if (result == nil)
                {
                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
            }
            //1......if master table entry inserted then need to data in PersonalBusinessMemberDetails
            for j in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let childSQLDelete = "DELETE FROM PersonalBusinessMemberDetails where profileId in ("+muaarayDeleteMemberListjsonResult[j]+") and PersonalORBusiness='personal'"
                print(childSQLDelete)
                let result = contactDB?.executeStatements(childSQLDelete)
                if (result == nil)
                {
                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    
                }
            }
            //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
            for j in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let childSQLDelete = "DELETE FROM  PersonalBusinessMemberDetails where profileId in ("+muaarayDeleteMemberListjsonResult[j]+") and PersonalORBusiness='Business'"
                print(childSQLDelete)
                let result = contactDB?.executeStatements(childSQLDelete)
                if (result == nil)
                {
                }
                else
                {
                }
            }
            //3. PersonalBusinessMemberDetails
            for k in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let familyMemberDetailsDelete = "DELETE FROM  FamilyMemberDetail  where profileId in ("+muaarayDeleteMemberListjsonResult[k]+")"
                print(familyMemberDetailsDelete)
                let result = contactDB?.executeStatements(familyMemberDetailsDelete)
                if (result == nil)
                {
                }
                else
                {
                }
            }
            //4.  AddressDetails
            for l in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let addressDetailDelete = "DELETE FROM  AddressDetails  where profileId in ("+muaarayDeleteMemberListjsonResult[l]+")"
                print(addressDetailDelete)
                let result = contactDB?.executeStatements(addressDetailDelete)
                if (result == nil)
                {
                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                }
            }
        }
        else
        {
        }
        contactDB?.commit()
        contactDB?.close()
    }
    
    func savesssfetchData()
    {
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        print(grpDetailPrevious)
        
        var dict:NSDictionary!
        dict = menuTitles[0] as! NSDictionary
        print(dict)
        //        let varGetId=(dict.object(forKey: "grpId") as! String)
        //        print(varGetId)
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            //print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            //print("Error: \(contactDB.lastErrorMessage())")
        }
        print((UserDefaults.standard.string(forKey: "grpId")))
        
        if (contactDB?.open())! {
            let grpIddd=((UserDefaults.standard.string(forKey: "grpId")) as! String)
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            //            Main Dashboard querySQL SELECT distinct * FROM MODULE_DATA_MASTER where groupId = '2765' order  by moduleOrderNo asc
            //            (UserDefaults.standard.string(forKey: "grpId"))
            
            //            let querySQL = "SELECT distinct * FROM MODULE_DATA_MASTER where groupId = '\(grpDetailPrevious.object(forKey: "grpId") as! String)' order  by moduleOrderNo asc"
            let querySQL = "SELECT distinct * FROM MODULE_DATA_MASTER where groupId = '\(grpIddd)' AND masterUID = '\(mainMemberID ?? "")' order  by moduleOrderNo asc"
            print("Main Dashboard querySQL \(querySQL)")
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            allmoduleCAtArry=NSMutableArray()
            let muarrayTemp:NSMutableArray=NSMutableArray()
            //            var isGroupAdmin = UserDefaults.standard.object(forKey: "isAdmin") as! String
            var isGroupAdmin = "Yes"
            var modulenamescheck:String!=""
            while results?.next() == true {
                print((results?.string(forColumn: "groupId"))! as String)
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "groupId"))! as String, forKey:"groupId")
                dd.setValue((results?.string(forColumn: "groupModuleId"))! as String, forKey:"groupModuleId")
                dd.setValue((results?.string(forColumn: "image"))! as String, forKey:"image")
                //dd.setValue((results?.stringForColumn("masterProfileID"))! as String, forKey:"masterProfileID")
                dd.setValue((results?.string(forColumn: "moduleId"))! as String, forKey:"moduleId")
                dd.setValue((results?.string(forColumn: "moduleName"))! as String, forKey:"moduleName")
                dd.setValue((results?.string(forColumn: "moduleStaticRef"))! as String, forKey:"moduleStaticRef")
                dd.setValue((results?.string(forColumn: "moduleOrderNo"))! as String, forKey:"moduleOrderNo")
                dd.setValue((results?.string(forColumn: "notificationCount"))! as String, forKey:"notificationCount")
                
                print("<<<<<<<<<<-----This is group admin or not ----->>>>>>>>>>>>>")
                print(isGroupAdmin)
                print((results?.string(forColumn: "moduleName"))! as String)
                
                var modulename:String! = (results?.string(forColumn: "moduleName"))! as String
                if(isGroupAdmin=="No" && modulename == "Attendance")
                {
                    
                }
                else
                {
                    if((results?.string(forColumn: "moduleName"))! as String=="Sub groups")
                    {
                    }
                    else if((results?.string(forColumn: "moduleName"))! as String=="Club Monthly Report" || (results?.string(forColumn: "moduleName"))! as String=="Category" || (results?.string(forColumn: "moduleName"))! as String=="TRF Contribution")
                    {
                        if(isCategory=="1")
                        {
                        }
                        else
                        {
                            if(isGroupAdmin=="Yes")
                            {
                                print("modulenamescheck \(modulenamescheck)")
                                if(modulename != modulenamescheck)
                                {
                                    //                                    allmoduleCAtArry.add(dd)
                                }
                            }
                            else
                            {
                                if(UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! Any == nil)
                                {
                                    print("aaaaaaaaaaaaaaaaaaaaaaaa")
                                }
                                else
                                {
                                    if let GetAssistanceGover:String = UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as? String
                                    {
                                        //print("Club Monthly Report":-----")
                                        if (( GetAssistanceGover == "HideMonthlyReportModule"))
                                        {
                                            print("889898989898989898989898989898989898989898",UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! String)
                                        }
                                        else
                                        {
                                            print("modulenamescheck11: \(modulenamescheck)")
                                            if(modulename != modulenamescheck)
                                            {
                                                //                                            allmoduleCAtArry.add(dd)
                                            }
                                            print("111111111111111111111111111111111111111",UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! String)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        print("modulenamescheck 22 :\(modulenamescheck)")
                        var getAdmin:String!=(results?.string(forColumn: "moduleName")) as! String
                        if((results?.string(forColumn: "moduleName"))! as String=="Admin" && isGroupAdmin=="Yes" && isCategory=="1")
                        {
                            //                                allmoduleCAtArry.add(dd)
                        }
                        else if(modulename != modulenamescheck)
                        {
                            if(getAdmin == "Admin")
                            {
                                
                            }
                            else
                            {
                                print("modulenamescheck 33 :\(modulenamescheck)")
                                if(modulename != modulenamescheck)
                                {
                                    //                                 allmoduleCAtArry.add(dd)
                                }
                            }
                        }
                    }
                    print("modulenamescheck 44 :\(modulenamescheck)")
                    if(modulename != modulenamescheck)
                    {
                        muarrayTemp.add((results?.string(forColumn: "groupId"))! as String)
                        //                        collectionView.reloadData()
                    }
                }
                modulenamescheck = (results?.string(forColumn: "moduleName"))! as String
            }
            print(muarrayIsConatinCountOrNot)
            print(muarrayTemp)
        }
        print("All module list \(allmoduleCAtArry)")
    }
    
    func getUpdateAppVersionPOPUP()
    {
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID") as AnyObject //isAdmin
        let imeiNo = UIDevice.current.identifierForVendor!.uuidString
        var updatedOn =  String ()
        let defaults = UserDefaults.standard
        if let str = defaults.value(forKey: "updatedOnForVersion") as! String?
        {
            updatedOn = "1970-1-1 0:0:0"
        }
        else
        {
            updatedOn = "1970-1-1 0:0:0"
        }
        let completeURL:String! = baseUrl+rowAppVersionGetAllGroupList
        let parameterst = [
            "masterUID":mainMemberID,"imeiNo":imeiNo,"updatedOn":updatedOn
        ] as [String : Any]
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            var varGetVersionNumber:String!=""
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            {
                varGetVersionNumber=version
            }
            let dd = response as! NSDictionary
            var varGetValueServerError = dd.object(forKey: "serverError")as? String
            
            if(varGetValueServerError == "Error")
            {
                SVProgressHUD.dismiss()
            }
            else
            {
                if(((dd.object(forKey: "TBGroupResult")! as AnyObject).object(forKey: "status") as! String == "0") && ((dd.object(forKey: "TBGroupResult")! as AnyObject).object(forKey: "message") as! String == "success"))
                {
                    let varGetAppVersion=(dd.object(forKey: "TBGroupResult")! as AnyObject).object(forKey: "version") as! String
                    let varGetCurrentDate=(dd.object(forKey: "TBGroupResult")! as AnyObject).object(forKey: "curDate") as! String
                    let aServer:Float?=Float(varGetAppVersion)
                    let bLocal:Float?=Float(varGetVersionNumber)
                    if((aServer ?? 0.0)>(bLocal ?? 0.0))
                    {
                        print("app version",aServer)
                        SVProgressHUD.dismiss()
                        let alert = UIAlertController(title:  "New Version Available", message: "There is a newer version avaliable for download! Please update the app by visiting the Apple Store", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                            self.GoToNewShoot()
                        }));
                        self.present(alert, animated: true, completion: nil)
                    }
                    else if((aServer ?? 0.0)<(bLocal ?? 0.0))
                    {
                        UserDefaults.standard.setValue(varGetCurrentDate, forKey: "updatedOnForVersion")
                    }
                    else if(aServer==bLocal)
                    {
                        UserDefaults.standard.setValue(varGetCurrentDate, forKey: "updatedOnForVersion")
                    }
                }
                else
                {
                }
            }
        })
    }
    
    func GoToNewShoot()
    {
        let alert = UIAlertController(title: "New Version Available", message: "There is a newer version avaliable for download! Please update the app by visiting the Apple Store", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
            self.GoToNewShoot()
        }));
        self.present(alert, animated: true, completion: nil)
        ////print("Method Called")
        // App Store URL.
        let appStoreLink = ituneDynamicUrlFromServer
        //print("This is coming from backend side table as discuused with mukesh")
        print("App store Link \(ituneDynamicUrlFromServer)")
        // UIApplication.shared.openURL(URL(string:appStoreLink!)!)
        if let url = URL(string:appStoreLink!) {
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
    
    
    func functionForSetDeviceToken()
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            //if(appToken.characters.count>19)
            print("Device Token : \(UserDefaults.standard.value(forKey: "deviceToken"))")
            if let abc = UserDefaults.standard.value(forKey: "deviceToken") as? String
            {
                let varGetMobileNumber = UserDefaults.standard.value(forKey: "session_Mobile_Number")as! String
                var arrayNotificationCount:NSArray=NSArray()
                let completeURL = baseUrl+"Group/UpdateDeviceTokenNumber"
                let parameterst = [
                    "MobileNumber" : varGetMobileNumber,
                    "DeviceToken" : abc
                ]
                //print("rajndra jat token in root dash board screen :---------")
                print("this is device token :----------------------------")
                print(parameterst)
                print(completeURL)
                
                ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                    //=> Handle server response
                    //print(response)
                    print("This is device token by Rajendra JAt 1 March !!!!!")
                    var varGetValueServerError = response.object(forKey: "serverError")as? String
                    
                    if(varGetValueServerError == "Error")
                    {
                        SVProgressHUD.dismiss()
                    }
                    else
                    {
                        
                        if((response.value(forKey: "UpdateDeviceTokenNumberResult")! as AnyObject).value(forKey: "status") as! String == "0")
                        {
                            print("Device token updated successfully")
                            SVProgressHUD.dismiss()
                        }
                        else
                        {
                            //print("22222..rajendra")
                            SVProgressHUD.dismiss()
                        }
                    }
                })
            }
            else
            {
                print("device token is null in root dash board controlewr ")
            }
        }
    }
    
    
    
    //added by shubhs from directory for profile
    
    func fetchDataProfile()
    {
        
        let grpIdddprofile=((UserDefaults.standard.string(forKey: "grpId")) as! String)
        print(grpIdddprofile)
        //        mainArray.removeAllObjects()
        //        mainArray=NSMutableArray()
        var databasePath : String
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
            
            //SELECT * FROM ProfileMaster
            // WHERE (membername LIKE '%ande%' OR membermobile LIKE '%1234567%' )
            
            let querySQL = "SELECT  DISTINCT memberName,profilePic,memberMobile,masterId,profileId,isAdmin,isPersonalDetVisible,isBussinessDetVisible,isFamilyDetVisible,grpId,familyPic  FROM ProfileMaster where grpId = '\(grpIdddprofile)'  order by memberName COLLATE NOCASE asc"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            
            var varCounting:Int!=0
            
            while results?.next() == true {
                //                autoreleasepool {
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "memberName"))! as String, forKey:"memberName")
                dd.setValue((results?.string(forColumn: "memberMobile"))! as String, forKey:"memberMobile")
                dd.setValue((results?.string(forColumn: "masterId"))! as String, forKey:"masterId")
                dd.setValue((results?.string(forColumn: "profileId"))! as String, forKey:"profileId")
                dd.setValue((results?.string(forColumn: "isAdmin"))! as String, forKey:"isAdmin")
                dd.setValue((results?.string(forColumn: "isPersonalDetVisible"))! as String, forKey:"isPersonalDetVisible")
                dd.setValue((results?.string(forColumn: "isBussinessDetVisible"))! as String, forKey:"isBussinessDetVisible")
                dd.setValue((results?.string(forColumn: "isFamilyDetVisible"))! as String, forKey:"isFamilyDetVisible")
                dd.setValue((results?.string(forColumn: "grpId"))! as String, forKey:"grpId")
                dd.setValue((results?.string(forColumn: "profilePic"))! as String, forKey:"profilePic")
                
                if(self.isCategory=="2")
                {
                    
                }
                else
                {
                    dd.setValue((results?.string(forColumn: "familyPic"))! as String, forKey:"familyPic") //31-08-2017
                }
                
                //                mainArray.add(dd)
                varCounting=varCounting+1
                
                //                }
            }
            
            //            if mainArray.count > 0
            //            {
            //                NoRecordLabel.isHidden = true
            //                copymainArray=mainArray
            //                directoryTableView.reloadData()
            //                self.varRefreshDatRunOneTime="First"
            //            }
            //            else
            //            {
            //                NoRecordLabel.isHidden = false
            //                mainArray.removeAllObjects()
            //                mainArray = NSMutableArray()
            //                copymainArray=NSArray()
            //                directoryTableView.reloadData()
            //                self.varRefreshDatRunOneTime="Second"
            //            }
            
            let Count = "SELECT count(*) as Count from ProfileMaster where grpId = '\(grpIdddprofile)'"
            print(Count)
            let resultss:FMResultSet? = contactDB?.executeQuery(Count,withArgumentsIn: nil)
            
            while resultss?.next() == true
            {
                varGetCount=resultss?.string(forColumn: "Count")
            }
            varGetCount=String(varCounting)
            //print(varGetCount)
        }
        
        contactDB?.close()
    }
    
    func getPoPupInfo()
    {
        
        let completeURL:String=baseUrl+getMobilePupup
        var mainMemberID:String = UserDefaults.standard.string(forKey: "masterUID") as? String ?? ""
        let parameters:[String:String]=["FkmasterID":mainMemberID]
//        let parameters:[String:String]=["FkmasterID":"457495"]
        print("URL for Popup \(completeURL)")
        print("Parameters for popup \(parameters)")
        SVProgressHUD.show()
        
        Alamofire.request(completeURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON(){
            response in
            switch response.result
            {
            case .success:
                print("Popup Response is \(response.result.value)")
                if let dd = response.result.value as? NSDictionary
                {
                    if let AdminmobilepupupResult = dd.value(forKey: "AdminmobilepupupResult") as? NSDictionary
                    {
                        if let description = AdminmobilepupupResult.value(forKey: "Description")
                        {
                                            self.addView.isHidden=false
                            
                                        self.addWebView.load(URLRequest(url:URL(string: "http://kaizeninfotech.com/ads.html")!))
                            
//                            self.addWebView.load(URLRequest(url: URL(string: description as? String ?? "")!))
                            
                                            self.addWebView.loadHTMLString(description as! String, baseURL: nil)
                            
                        }
                        else
                        {
                                                   self.addView.isHidden=true
                        }
                    }
                    else
                    {
                                          self.addView.isHidden=true
                    }
                }
                else
                {
                                        self.addView.isHidden=true
                }
                
                break
            case .failure:
                             self.addView.isHidden=true
                break
            }
        }
    }
    
    func fetchData()
    {
        //        imageSplashScreenRoot.isHidden=true
        self.groupList.removeAllObjects()
        menuTitles=[]
        stringArrayTitle=[String]()
        stringArrayRssFirstFielsDescription=[String]()
        varLinkNewsUpdate=[String]()
        
        stringArrayTitleSecond=[String]()
        stringArrayRssSecondFielsDescription=[String]()
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        print("Device Database Path  \(databasePath)")
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            ////print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        //print(databasePath)
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            ////print("Error: \(contactDB.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        //print(stringArrayStore)
        stringArrayStore=[String]()
        //print(stringArrayStore)
        
        if (contactDB?.open())!
        {
            print("Contact db is open")
            var querySQL = ""
            querySQL = "SELECT distinct *  FROM GROUPMASTER"
            let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
            
            var groupnames:String!=""
            var muarrayTemp:NSMutableArray=NSMutableArray()
            while results?.next() == true
            {
                let dd = NSMutableDictionary ()
                
                ////print("222222222222222222222222222222",NSUserDefaults.standardUserDefaults().valueForKey((results?.stringForColumn("grpId"))! as String)as? String)
                let varGetValue:String! = UserDefaults.standard.value(forKey: (results?.string(forColumn: "grpId"))! as String)as? String
                //var varGetValue:String! = "15/12/2017"
                if(varGetValue != nil)
                {
                    
                    let inputFormatter = DateFormatter()
                    inputFormatter.dateFormat = "dd/MM/yyyy"
                    let showDate = inputFormatter.date(from: varGetValue)
                    // //print(showDate)
                    
                    inputFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
                    let expireDate = inputFormatter.string(from: showDate!)
                    //  //print(expireDate)
                    
                    //today date
                    var varGetTodayDate:Foundation.Date! = Foundation.Date()
                    var dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
                    var date = dateFormatter.string(from: varGetTodayDate)
                    // //print(date)
                    
                    
                    var varGetDatePublishISLessThanExp = commonClassFunction().functionForCompareDatewithTime(date, stringSecondDate: expireDate)
                    //print(date)
                    //print(expireDate)
                    //print(varGetDatePublishISLessThanExp)
                    /*
                     if(menuTitles.count==1)
                     {
                     varGetDatePublishISLessThanExp = commonClassFunction().functionForCompareDatewithTime("2018-06-30 12:00 AM", stringSecondDate: "2017-09-21 01:53 PM")
                     //print(date)
                     //print(expireDate)
                     //print(varGetDatePublishISLessThanExp)
                     }
                     */
                    
                    
                    if(varGetDatePublishISLessThanExp=="Ascending")
                    {
                        SVProgressHUD.dismiss()
                        //--->>>>>>>>>>>>>>>>>> 1
                        var grpId=(results?.string(forColumn: "grpId"))! as String
                        var grpIdNew:String!=""
                        if(grpId.hasPrefix("Optional("))
                        {
                            let result3 = String(grpId.dropFirst(10))
                            grpIdNew = String(result3.dropLast(2))
                        }
                        else {grpIdNew = grpId}
                        //--->>>>>>>>>>>>>>>>>> 2
                        var grpName=(results?.string(forColumn: "grpName"))! as String
                        var grpNameNew:String!=""
                        if(grpName.hasPrefix("Optional("))
                        {
                            let result3 = String(grpName.dropFirst(9))
                            grpNameNew = String(result3.dropLast(2))
                            //print(result3)
                            
                        }
                        else {grpNameNew = grpName}
                        
                        
                        //print((results?.string(forColumn: "grpName"))! as String)
                        //print(grpNameNew)
                        //print(grpName)
                        
                        
                        
                        //--->>>>>>>>>>>>>>>>>> 3
                        var grpImg=(results?.string(forColumn: "grpImg"))! as String
                        var grpImgNew:String!=""
                        if(grpImg.hasPrefix("Optional("))
                        {
                            let result3 = String(grpImg.dropFirst(10))
                            grpImgNew = String(result3.dropLast(2))
                        }
                        else {grpImgNew = grpImg}
                        //--->>>>>>>>>>>>>>>>>> 4
                        let grpProfileid=(results?.string(forColumn: "grpProfileid"))! as String
                        var grpProfileidNew:String!=""
                        if(grpProfileid.hasPrefix("Optional("))
                        {
                            let result3 = String(grpProfileid.dropFirst(10))
                            grpProfileidNew = String(result3.dropLast(2))
                        }
                        else {grpProfileidNew = grpProfileid}
                        //--->>>>>>>>>>>>>>>>>> 5
                        var isGrpAdmin=(results?.string(forColumn: "isGrpAdmin"))! as String
                        var isGrpAdminNew:String!=""
                        if(isGrpAdmin.hasPrefix("Optional("))
                        {
                            let result3 = String(isGrpAdmin.dropFirst(10))
                            isGrpAdminNew = String(result3.dropLast(2))
                        }
                        else {isGrpAdminNew = isGrpAdmin}
                        
                        //--->>>>>>>>>>>>>>>>>> 6
                        var myCategory=(results?.string(forColumn: "myCategory"))! as String
                        var myCategoryNew:String!=""
                        if(myCategory.hasPrefix("Optional("))
                        {
                            let result3 = String(myCategory.dropFirst(10))
                            myCategoryNew = String(result3.dropLast(2))
                        }
                        else {myCategoryNew = myCategory}
                        //--->>>>>>>>>>>>>>>>>> 7
                        var notificationCount=(results?.string(forColumn: "notificationCount"))! as String
                        var notificationCountNew:String!=""
                        if(notificationCount.hasPrefix("Optional("))
                        {
                            let result3 = String(notificationCountNew.dropFirst(10))
                            notificationCountNew = String(result3.dropLast(2))
                        }
                        else {notificationCountNew = notificationCount}
                        
                        
                        //  dd.setValue((results?.stringForColumn("expiryDate"))! as String, forKey:"expiryDate")
                        
                        
                        
                        //(grpIdNew as AnyObject).replacingOccurrences(of: "", with: "")
                        
                        //print((grpNameNew as AnyObject).replacingOccurrences(of: "\"", with: ""))
                        
                        
                        
                        dd.setValue((grpIdNew as AnyObject).replacingOccurrences(of: "\"", with: ""), forKey:"grpId")
                        dd.setValue((grpNameNew as AnyObject).replacingOccurrences(of: "\"", with: ""), forKey:"grpName")
                        dd.setValue((grpImgNew as AnyObject).replacingOccurrences(of: "\"", with: ""), forKey:"grpImg")
                        dd.setValue((grpProfileidNew as AnyObject).replacingOccurrences(of: "\"", with: ""), forKey:"grpProfileid")
                        dd.setValue((isGrpAdminNew as AnyObject).replacingOccurrences(of: "\"", with: ""), forKey:"isGrpAdmin")
                        dd.setValue((myCategoryNew as AnyObject).replacingOccurrences(of: "\"", with: ""), forKey:"myCategory")
                        dd.setValue((notificationCountNew as AnyObject).replacingOccurrences(of: "\"", with: ""), forKey:"notificationCount")
                        
                        //groupnames
                        
                        var groupnamenew:String!=grpNameNew
                        
                        
                        //print("1.",groupnamenew)
                        //print("2.",groupnames)
                        
                        
                        if(muarrayTemp.contains(groupnamenew))
                        {
                            
                        }
                        else
                        {
                            if(groupnames != groupnamenew)
                            {
                                stringArrayStore.append(grpNameNew)
                                stringGroupImages.append(grpImgNew)
                                menuTitles.add(dd)
                                print(menuTitles)
                                self.groupList.add(dd)
                                print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm")
                                print(self.groupList)
                            }
                            groupnames = grpNameNew
                            muarrayTemp.add(groupnamenew)
                        }
                    }
                }
                else
                {
                    
                    SVProgressHUD.dismiss()
                    
                    
                    dd.setValue((results?.string(forColumn: "grpId"))! as String, forKey:"grpId")
                    dd.setValue((results?.string(forColumn: "grpName"))! as String, forKey:"grpName")
                    dd.setValue((results?.string(forColumn: "grpImg"))! as String, forKey:"grpImg")
                    dd.setValue((results?.string(forColumn: "grpProfileid"))! as String, forKey:"grpProfileid")
                    dd.setValue((results?.string(forColumn: "isGrpAdmin"))! as String, forKey:"isGrpAdmin")
                    dd.setValue((results?.string(forColumn: "myCategory"))! as String, forKey:"myCategory")
                    dd.setValue((results?.string(forColumn: "notificationCount"))! as String, forKey:"notificationCount")
                    
                    var groupnamenew:String!=(results?.string(forColumn: "grpName"))! as String
                    
                    
                    //print(groupnamenew)
                    //print(groupnames)
                    
                    
                    if(muarrayTemp.contains(groupnamenew))
                    {
                        
                    }
                    else
                    {
                        if(groupnames != groupnamenew)
                        {
                            stringArrayStore.append((results?.string(forColumn: "grpName")!)! as String)
                            stringGroupImages.append((results?.string(forColumn: "grpImg"))! as String)
                            menuTitles.add(dd)
                            print(menuTitles)
                            print("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn")
                            self.groupList.add(dd)
                        }
                    }
                    groupnames = (results?.string(forColumn: "grpName"))! as String
                    muarrayTemp.add(groupnamenew)
                }
                
                
                
            }
            //TODO: MANI CHANGE
            //            let mutableArray = NSMutableArray(array: self.groupList)
            //            let set = Set<AnyHashable>(mutableArray as! [AnyHashable])
            //            mutableArray.removeAllObjects()
            //            mutableArray.addObjects(from: Array(set))
            //            self.groupList.add(mutableArray)
            //            print("FUNCTION CHECK1 --------------------------------")
            //            print(mutableArray)
            //            print("FUNCTION CHECK1 =================================")
            //            print("FUNCTION CHECK2 --------------------------------")
            //            print(self.groupList)
            //            print("FUNCTION CHECK2 =================================")
            
            
            
            
            //            self.buttonOpacity.isHidden=true
            /*555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555*/
            var databasePath : String
            let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documents.appendingPathComponent("NewTouchbase.db")
            // open database
            databasePath = fileURL.path
            var db: OpaquePointer? = nil
            if sqlite3_open(fileURL.path, &db) != SQLITE_OK
            {
                ////print("error opening database")
            }
            else
            {
                // self.Createtablecity()
            }
            //print(databasePath)
            let contactDB = FMDatabase(path: databasePath as String)
            if contactDB == nil
            {
                print("Error: \(contactDB!.lastErrorMessage())")
            }
            var muarraySecondSection:NSMutableArray=NSMutableArray()
            var muarrayThirdSection:NSMutableArray=NSMutableArray()
            var stringSecond=[String]()
            var stringThird=[String]()
            
            for i in 00..<1
            {
                ////print(i)
                ////print("Before=====================",stringArrayTitle.count)
                ////print("Before=====================",stringArrayRssFirstFielsDescription.count)
                //newsUpdateTitle , newsUpdateDescription,newsUpdateDate,isFeedFirstOrSecond
                if (contactDB?.open())!
                {
                    var querySQL = ""
                    querySQL = "SELECT * FROM NewsUpdate_Table Where isFeedFirstOrSecond = 'First' LIMIT 10"
                    let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
                    while results?.next() == true
                    {
                        let dd = NSMutableDictionary ()
                        dd.setValue((results?.string(forColumn: "newsUpdateTitle"))! as String, forKey:"title")
                        dd.setValue((results?.string(forColumn: "newsUpdateDescription"))! as String, forKey:"description")
                        dd.setValue((results?.string(forColumn: "newsUpdateDate"))! as String, forKey:"date")
                        dd.setValue((results?.string(forColumn: "link"))! as String, forKey:"link")
                        stringArrayTitle.append((results?.string(forColumn: "newsUpdateTitle")!)! as String)
                        stringArrayRssFirstFielsDescription.append((results?.string(forColumn: "newsUpdateDescription")!)! as String)
                        varLinkNewsUpdate.append((results?.string(forColumn: "link")!)! as String)
                        //print(dd)
                        menuTitles.add(dd)
                        print(menuTitles)
                        muarrayRotaryBlogs.add(dd)  //News
                    }
                }
            }
            for j in 00..<1
            {
                if (contactDB?.open())!
                {
                    var querySQL = ""
                    querySQL = "SELECT *  FROM NewsUpdate_Table Where isFeedFirstOrSecond = 'Second' LIMIT 10"
                    
                    //print(querySQL)
                    
                    let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
                    while results?.next() == true
                    {
                        let dd = NSMutableDictionary ()
                        dd.setValue((results?.string(forColumn: "newsUpdateTitle"))! as String, forKey:"title")
                        dd.setValue((results?.string(forColumn: "newsUpdateDescription"))! as String, forKey:"description")
                        dd.setValue((results?.string(forColumn: "newsUpdateDate"))! as String, forKey:"date")
                        dd.setValue((results?.string(forColumn: "link"))! as String, forKey:"link")
                        //stringArrayTitle = [(results?.stringForColumn("newsUpdateTitle")!)! as String]
                        stringArrayTitleSecond.append((results?.string(forColumn: "newsUpdateTitle")!)! as String)
                        stringArrayRssSecondFielsDescription.append((results?.string(forColumn: "newsUpdateDescription")!)! as String)
                        varLinkBlogs.append((results?.string(forColumn: "link")!)! as String)
                        //print(dd)
                        menuTitles.add(dd)
                        print(menuTitles)
                        muarrauRotaryNews.add(dd) //Blogs
                    }
                }
            }
            //            self.btnMenu.isHidden=false
            print("Section statement called")
            sections = [
                Section1(name: "Group",varLink:[""],des:[""] , items: stringArrayStore,imagePic: stringGroupImages),
                Section1(name: "News And Updates", varLink: varLinkNewsUpdate,des:stringArrayRssFirstFielsDescription , items: stringArrayTitle,imagePic: [""]),
                Section1(name: "Blogs",varLink:varLinkBlogs,des:stringArrayRssSecondFielsDescription , items: stringArrayTitleSecond ,imagePic: [""]),]
            //            self.groupList = stringArrayStore as! NSMutableArray
            
            print("sections is \(sections)")
            self.loaderClass.window = nil
            //            self.imageSplashScreenRoot.isHidden=true
            //            labelFirstTimeSyncMessage.isHidden=true
            //            buttonOpticity.isHidden=true
            DispatchQueue.main.async {
                self.collView.reloadData()
            }
            
            UserDefaults.standard.setValue("1", forKey: "Session_RssFeedFirstTime")
            /*55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555*/
            
            ////print("After=====================",stringArrayTitle.count)
            ////print("After=====================",stringArrayTitle.count)
            ////print("After=====================",stringArrayTitleSecond.count)
            ////print(menuTitles.count)
        }
        self.loaderClass.window = nil
        //        myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: (self.myScrollView.frame.size.height))
        
    }
    
    func functionForFetchingNotificationCountList()
    {
        
        var muarray:NSMutableArray=NSMutableArray()
        var muarrayGroupId:NSMutableArray!=NSMutableArray()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            var arrayNotificationCount:NSArray=NSArray()
            let completeURL = baseUrl+touchBase_fetchNotificationCount
            let parameterst = [
                k_API_masterUID : UserDefaults.standard.string(forKey: "masterUID") as AnyObject
            ]
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
                //print(response)
                
                var varGetValueServerError = response.object(forKey: "serverError")as? String
                
                if(varGetValueServerError == "Error")
                {
                    SVProgressHUD.dismiss()
                    
                }
                else
                {
                    if((response.value(forKey: "TBGroupResult")! as AnyObject).value(forKey: "status") as! String == "1")
                    {
                    }
                    else
                    {
                        for i in 0..<((response.value(forKey: "TBGroupResult")! as AnyObject).value(forKey: "GrpCountList")! as AnyObject).count
                        {
                            let letGetEntityId=((((response.value(forKey: "TBGroupResult")! as AnyObject).value(forKey: "GrpCountList")! as AnyObject).value(forKey: "groupId")! as AnyObject).object(at: i))
                            let letTotalCount=((((response.value(forKey: "TBGroupResult")! as AnyObject).value(forKey: "GrpCountList")! as AnyObject).value(forKey: "totalCount")! as AnyObject).object(at: i))
                            let letEntityModuleIdNotificationCount=(((response.value(forKey: "TBGroupResult")! as AnyObject).value(forKey: "GrpCountList")! as AnyObject).value(forKey: "ModCount")! as AnyObject).object(at: i)
                            muarray.add(letEntityModuleIdNotificationCount)
                            muarrayGroupId.add(letGetEntityId)
                            self.mudict.setValue(letTotalCount, forKey: letGetEntityId as! String)
                            
                        }
                        UserDefaults.standard.setValue(self.mudict, forKey: "session_notificationCount")
                        UserDefaults.standard.setValue(muarray, forKey: "session_notificationCountForModule")
                        UserDefaults.standard.setValue(muarrayGroupId, forKey: "session_EntityId")
                    }
                }
            })
            
        }
        else
        {
            mudict=NSMutableDictionary()
            UserDefaults.standard.setValue(mudict, forKey: "session_notificationCount")
            muarray=NSMutableArray()
            UserDefaults.standard.setValue(muarray, forKey: "session_notificationCountForModule")
            muarrayGroupId=NSMutableArray()
            //print(muarrayGroupId)
            UserDefaults.standard.setValue(muarrayGroupId, forKey: "session_EntityId")
            //print(muarrayGroupId)
        }
    }
    
    func UpdateDataInlocal (_ memberID: NSString,memberMainId:NSString)
    {
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            ////print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            ////print("Error: \(contactDB.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            //print(stringArrayStore)
            let insertSQL = "UPDATE  GROUPMASTER SET myCategory='0' WHERE grpProfileid = '\(memberID)'  "
            //print(insertSQL)
            let result = contactDB?.executeStatements(insertSQL)
            
            if (result == nil)
            {
                ////print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                ////print("success saved")
                //print(databasePath);
            }
        }
        else
        {
            ////print("Error: \(contactDB?.lastErrorMessage())")
        }
    }
    func GetAllGroupListSync()
    {
        //        setupLoaderView()
        //        self.loaderView.startAnimating()
        SVProgressHUD.show()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            var updatedOn =  String ()
            let defaults = UserDefaults.standard
            let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
            updatedOn = "1970-01-01 00:00:00"
            if let str = defaults.value(forKey: Updatedefault) as! String?
            {
                print("updated on \(str)")
                //                updatedOn = str
                updatedOn = "1970-01-01 00:00:00"
            }
            else
            {
                print("New app install")
                updatedOn = "1970-01-01 00:00:00"
                // SVProgressHUD.show()
            }
            do {
                var varGetMobileNumber = UserDefaults.standard.value(forKey: "session_Mobile_Number")as! String
                var varGetCountryCode = UserDefaults.standard.value(forKey: "session_Country_Code")as! String
                var varGetLoginType = UserDefaults.standard.value(forKey: "session_Login_Type")as! String
                let url = baseUrl+"Group/GetAllGroupListSync"
                var params: [String: String] =
                ["masterUID": mainMemberID!,
                 "imeiNo": UIDevice.current.identifierForVendor!.uuidString,
                 "updatedOn": updatedOn,
                 "loginType": varGetLoginType,
                 "mobileNo": varGetMobileNumber,
                 "countryCode": varGetCountryCode
                ]
                print(url)
                print(params)
                print("Fetching data of dashboard from Server... @ \(Date())")
                if(viewloadandwillappearCount==2)
                {
                }
                else
                {
                    SVProgressHUD.dismiss()
                }
                
                Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                    //                    self.loaderView.stopAnimating()
                    //                    self.loaderView.removeFromSuperview()
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let dic = response.result.value!
                            let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                            let jsonString = String(data: jsonData!, encoding: .utf8)!
                            if(response==nil)
                            {
                            }
                            else
                            {
                                let dd = response.result.value as! NSDictionary
                                print("Session result 1 \(dd)")
                                if (dd.object(forKey: "status") as! String == "0"){
                                    if ((dd.object(forKey: "updatedOn")) != nil)
                                    {
                                        UserDefaults.standard.set(dd.object(forKey: "updatedOn"), forKey: Updatedefault)
                                    }
                                    self.arrarrNewGroupList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "GroupList")! as AnyObject).object(forKey: "NewGroupList")) as! NSArray
                                    self.arrDeleteGroupList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "GroupList")! as AnyObject).object(forKey: "DeletedGroupList")) as! NSArray
                                    let  arrUpdateGroupList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "GroupList")! as AnyObject).object(forKey: "UpdatedGroupList")) as! NSArray
                                    self.stringArrayTitle=[String]()
                                    self.stringArrayRssFirstFielsDescription=[String]()
                                    self.stringArrayTitleSecond=[String]()
                                    self.stringArrayRssSecondFielsDescription=[String]()
                                    //delete group data from local database
                                    if(self.arrDeleteGroupList.count > 0 || self.arrarrNewGroupList.count > 0 || arrUpdateGroupList.count>0)
                                    {
                                        //delete group data from local database
                                        if(self.arrDeleteGroupList.count > 0)
                                        {
                                            self.DeleteDataInlocal(self.arrDeleteGroupList)
                                        }
                                        //update group data from local database
                                        if(arrUpdateGroupList.count > 0)
                                        {
                                            self.UpdateDataInlocal(arrUpdateGroupList)
                                        }
                                        if(self.arrarrNewGroupList.count > 0)
                                        {
                                            //save group data from local database
                                            self.SaveDataInlocal(self.arrarrNewGroupList)
                                            //print(self.arrarrNewGroupList)
                                            let arrModuleList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "ModuleList")! as AnyObject).object(forKey: "NewModuleList")) as! NSArray
                                            let arrDeleteList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "ModuleList")! as AnyObject).object(forKey: "DeletedModuleList")) as! NSArray
                                            let arrUpdateList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "ModuleList")! as AnyObject).object(forKey: "UpdatedModuleList")) as! NSArray
                                            //print()
                                            if(arrModuleList.count > 0)
                                            {
                                                //////print("arrModuleList \(arrModuleList)")
                                                self.SaveModuleDataInlocal(arrModuleList)
                                            }
                                            else  if(arrUpdateList.count > 0)
                                            {
                                                self.UpdateModuleDataInlocal(arrUpdateList)
                                            }
                                            if(arrDeleteList.count > 0)
                                            {
                                                self.DeleteModuleDataInlocal(arrDeleteList)
                                            }
                                        }
                                        //                                        self.imageSplashScreenRoot.isHidden=true
                                        print("Fetching data of dashboard... @ \(Date())")
                                        self.fetchData()
                                    }
                                    else
                                    {
                                        //                                        self.imageSplashScreenRoot.isHidden=true
                                        self.loaderClass.window = nil
                                        let arrModuleList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "ModuleList")! as AnyObject).object(forKey: "NewModuleList")) as! NSArray
                                        let arrDeleteList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "ModuleList")! as AnyObject).object(forKey: "DeletedModuleList")) as! NSArray
                                        let arrUpdateList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "ModuleList")! as AnyObject).object(forKey: "UpdatedModuleList")) as! NSArray
                                        
                                        if(arrModuleList.count > 0)
                                        {
                                            self.SaveModuleDataInlocal(arrModuleList)
                                        }
                                        if(arrUpdateList.count > 0)
                                        {
                                            print("UpdateModuleDataInlocal \(arrUpdateList)")
                                            self.UpdateModuleDataInlocal(arrUpdateList)
                                        }
                                        if(arrDeleteList.count > 0)
                                        {
                                            self.DeleteModuleDataInlocal(arrDeleteList)
                                        }
                                        SVProgressHUD.dismiss()
                                        //--------------
                                        var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                                        var updatedOn =  String ()
                                        let defaults = UserDefaults.standard
                                        let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
                                        updatedOn = "1970-01-01 00:00:00"
                                        if let str = defaults.value(forKey: Updatedefault) as! String?
                                        {
                                            self.loaderClass.window = nil
                                            //                                            self.imageSplashScreenRoot.isHidden=true
                                            //                                            self.labelFirstTimeSyncMessage.isHidden=true
                                            //                                            self.buttonOpticity.isHidden=true
                                        }
                                        else
                                        {
                                            updatedOn = "1970-01-01 00:00:00"
                                        }
                                    }
                                }
                                else if (dd.object(forKey: "status") as! String == "2")
                                {
                                    //----------------------------------------------
                                    //---delete old value from server in case of Birthday Anniversary Event start
                                    self.DELETEDashboard_BirthAnniEvent_table_New()
                                    //---delete old value from server in case of Birthday Anniversary Event ens
                                    //-------------------------------------------------
                                    // self.appDelegate.showAlsertView()
                                    //                                    self.imageSplashScreenRoot.isHidden=true
                                    self.loaderClass.window = nil
                                    UserDefaults.standard.removeObject(forKey: "updatedOn")
                                    let alert=UIAlertController(title: self.headTitle, message:dd.object(forKey: "message") as! String, preferredStyle: UIAlertController.Style.alert);
                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
                                        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        self.appDelegate.setMobileViewAsRoot()
                                    }));
                                    self.present(alert, animated: true, completion: nil);
                                    //                                    self.labelFirstTimeSyncMessage.isHidden=true
                                    //                                    self.buttonOpticity.isHidden=true
                                }
                                self.refreshControl?.endRefreshing()
                            }
                        }
                    case .failure(let error):
                        print("API GetAllGroupListSync failed due to \(error)")
                        break
                    }
                }
                self.loaderClass.window = nil
                self.loaderClass.window = nil
                //                self.imageSplashScreenRoot.isHidden=true
                //                self.labelFirstTimeSyncMessage.isHidden=true
                //                self.buttonOpticity.isHidden=true
            }
        }
        else
        {
            //            self.imageSplashScreenRoot.isHidden=true
            self.loaderClass.window = nil
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            let defaults = UserDefaults.standard
            let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
            if let str = defaults.value(forKey: Updatedefault) as! String?
            {
                self.appDelegate = UIApplication.shared.delegate as! AppDelegate
            }
            else
            {
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.collView.reloadData()
            SVProgressHUD.dismiss()
        })
        
    }
    
    //MARK:- Group master insert update delete (main table)
    func SaveDataInlocal (_ arrdata:NSArray)
    {
        var databasePath : String
        ////print(arrdata);
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            ////print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            ////print("Error: \(contactDB.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            for i in 0 ..< arrdata.count {
                let  dict = arrdata[i] as! NSDictionary
                
                // //print(mudict)
                let letGetCount=mudict.value(forKey: dict.object(forKey: "grpId") as! String)
                //print(letGetCount)
                //print(stringArrayStore)
                
                
                
                
                
                //--->>>>>>>>>>>>>>>>>> 1
                var masterUID=mainMemberID as! String
                var masterUIDNew:String!=""
                if(masterUID.hasPrefix("Optional("))
                {
                    let result3 = String(masterUID.dropFirst(9))
                    masterUIDNew = String(result3.dropLast(1))
                }
                else
                {
                    masterUIDNew = masterUID
                }
                //--->>>>>>>>>>>>>>>>>> 2
                var groupId:String!=dict.object(forKey: "grpId") as! String
                var groupIdNew:String!=""
                if(groupId.hasPrefix("Optional("))
                {
                    let result3 = String(groupId.dropFirst(9))
                    groupIdNew = String(result3.dropLast(1))
                }
                else
                {
                    groupIdNew = groupId
                }
                //--->>>>>>>>>>>>>>>>>> 3
                var grpName:String!=dict.object(forKey: "grpName") as! String
                var groupNameNew:String!=""
                if(grpName.hasPrefix("Optional("))
                {
                    let result3 = String(grpName.dropFirst(9))
                    groupNameNew = String(result3.dropLast(1))
                }
                else
                {
                    groupNameNew = grpName
                }
                //--->>>>>>>>>>>>>>>>>> 4
                var grpImg:String!=dict.object(forKey: "grpImg") as! String
                var grpImgNew:String!=""
                if(grpImg.hasPrefix("Optional("))
                {
                    let result3 = String(grpImg.dropFirst(9))
                    grpImgNew = String(result3.dropLast(1))
                }
                else
                {
                    grpImgNew = grpImg
                }
                //--->>>>>>>>>>>>>>>>>> 5
                var grpProfileId:String!=dict.object(forKey: "grpProfileId") as! String
                var grpProfileIdNew:String!=""
                if(grpProfileId.hasPrefix("Optional("))
                {
                    let result3 = String(grpProfileId.dropFirst(9))
                    grpProfileIdNew = String(result3.dropLast(1))
                }
                else
                {
                    grpProfileIdNew = grpProfileId
                }
                //--->>>>>>>>>>>>>>>>>> 6
                var myCategory:String!=dict.object(forKey: "myCategory") as! String
                var myCategoryNew:String!=""
                if(myCategory.hasPrefix("Optional("))
                {
                    let result3 = String(myCategory.dropFirst(9))
                    myCategoryNew = String(result3.dropLast(1))
                }
                else
                {
                    myCategoryNew = myCategory
                }
                //--->>>>>>>>>>>>>>>>>> 7
                var isGrpAdmin:String!=dict.object(forKey: "isGrpAdmin") as! String
                var isGrpAdminNew:String!=""
                if(isGrpAdmin.hasPrefix("Optional("))
                {
                    let result3 = String(isGrpAdmin.dropFirst(9))
                    isGrpAdminNew = String(result3.dropLast(1))
                }
                else
                {
                    isGrpAdminNew = isGrpAdmin
                }
                //--->>>>>>>>>>>>>>>>>> 8
                var notificationCounts:String!="0" as! String
                var notificationCountsNew:String!=""
                if(notificationCounts.hasPrefix("Optional("))
                {
                    let result3 = String(notificationCounts.dropFirst(9))
                    notificationCountsNew = String(result3.dropLast(1))
                }
                else
                {
                    notificationCountsNew = notificationCounts
                }
                
                
                let insertSQL = "INSERT INTO GROUPMASTER (masterUID, grpId, grpName , grpImg ,grpProfileid, myCategory, isGrpAdmin,notificationCount) VALUES ('\(masterUIDNew as! String )', '\(groupIdNew as! String)', '\(groupNameNew as! String)', '\(grpImgNew as! String)', '\(grpProfileIdNew as! String)', '\(myCategoryNew as! String)', '\(isGrpAdminNew as! String)','\(notificationCountsNew as! String)')"
                
                
                //'\(notificationCountsNew)'
                UserDefaults.standard.setValue(dict.object(forKey: "expiryDate") as! String, forKey: groupIdNew)
                
                print(insertSQL)
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil)
                {
                    ////print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    ////print("success saved")
                    //print(databasePath);
                }
            }
        }
        else
        {
            ////print("Error: \(contactDB?.lastErrorMessage())")
        }
    }
    
    func UpdateDataInlocal (_ arrdata:NSArray)
    {
        var databasePath : String
        ////print(arrdata);
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            ////print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            ////print("Error: \(contactDB.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            for i in 0 ..< arrdata.count
            {
                
                //print(stringArrayStore)
                let  dict = arrdata[i] as! NSDictionary
                let insertSQL1 = "UPDATE  GROUPMASTER SET grpName='\(dict.object(forKey: "grpName") as! String!)',grpImg='\(dict.object(forKey: "grpImg") as! String!)',grpProfileid='\(dict.object(forKey: "grpProfileId") as! String!)',myCategory='\(dict.object(forKey: "myCategory") as! String!)',isGrpAdmin='\(dict.object(forKey: "isGrpAdmin") as! String!)' WHERE grpId = '\(dict.object(forKey: "grpId") as! String)'  "
                print(insertSQL1)
                
                
                UserDefaults.standard.setValue(dict.object(forKey: "expiryDate") as! String, forKey: dict.object(forKey: "grpId") as! String)
                
                
                
                
                let result1 = contactDB?.executeStatements(insertSQL1)
                if (result1 == nil)
                {
                    ////print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    ////print("success saved")
                    //print(databasePath);
                }
            }
        }
        else
        {
            ////print("Error: \(contactDB?.lastErrorMessage())")
        }
    }
    
    func DeleteDataInlocal (_ arrdata:NSArray){
        var databasePath : String
        // //print(arrdata);
        
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            ////print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            ////print("Error: \(contactDB.lastErrorMessage())")
        }
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            for i in 0 ..< arrdata.count {
                let  dict = arrdata[i] as! NSDictionary
                let insertSQL = "DELETE FROM GROUPMASTER WHERE grpId = '\(dict.object(forKey: "grpId") as! String)'"
                print(insertSQL)
                UserDefaults.standard.setValue(nil, forKey: dict.object(forKey: "grpId") as! String)
                let result = contactDB?.executeStatements(insertSQL)
                
                if (result == nil) {
                    ////print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    ////print("success saved")
                    //print(databasePath);
                }
                
                /////////////----------------------------------------
                let insertSQLr = "DELETE FROM MODULE_DATA_MASTER WHERE groupId = '\(dict.object(forKey: "grpId") as! String)'"
                //print(insertSQLr)
                
                let resultr = contactDB?.executeStatements(insertSQLr)
                if (resultr == nil)
                {
                    ////print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    ////print("success saved")
                    //print(databasePath);
                }
                ////////////---------------------------------------------
                
                
                
                
            }
            
        } else {
            ////print("Error: \(contactDB?.lastErrorMessage())")
        }
        contactDB?.close()
    }
    
    func UpdateModuleDataInlocal (_ arrdata:NSArray)
    {
        
        let varGetValue = UserDefaults.standard.value(forKey: "session_MaintainNewAddingModuleWhenFirstTimeAppInstalled") as! String
        
        if(varGetValue=="Yes")
        {
            UserDefaults.standard.setValue("no", forKey: "session_MaintainNewAddingModuleWhenFirstTimeAppInstalled")
        }
        else
        {
            var databasePath : String
            //print(arrdata);
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            
            let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documents.appendingPathComponent("NewTouchbase.db")
            // open database
            databasePath = fileURL.path
            var db: OpaquePointer? = nil
            if sqlite3_open(fileURL.path, &db) != SQLITE_OK
            {
                ////print("error opening database")
            }
            else
            {
                // self.Createtablecity()
            }
            let contactDB = FMDatabase(path: databasePath as String)
            if contactDB == nil
            {
                ////print("Error: \(contactDB.lastErrorMessage())")
            }
            //print(databasePath)
            
            if (contactDB?.open())!
            {
                
                //---code by Rajendr Jat if any changes in module then delete all data that belong to particular group id
                
                for i in 0 ..< arrdata.count
                {
                    let  dict = arrdata[i] as! NSDictionary
                    let insertSQL1 = "DELETE FROM MODULE_DATA_MASTER WHERE groupModuleId = '\(dict.object(forKey: "groupModuleId") as! String)'"
                    print("Update module list query = \(insertSQL1)")
                    let result1 = contactDB?.executeStatements(insertSQL1)
                    if (result1 == nil)
                    {
                        print("ErrorAi update: \(contactDB?.lastErrorMessage())")
                    }
                    else
                    {
                        print("success update module list.")
                        //print(databasePath);
                    }
                    
                    // let  dict = arrdata[i] as! NSDictionary
                    // let varGetModuleId=functionForAddingCounting((dict.object(forKey: "groupId") as! String), stringModuleId: (dict.object(forKey: "moduleId") as! String ))
                    let varGetModuleId = "0"
                    
                    //print(varGetModuleId)
                    let insertSQL = "INSERT INTO MODULE_DATA_MASTER (masterUID, groupModuleId, groupId , moduleId ,moduleName, moduleStaticRef, image,moduleOrderNo,notificationCount, flag, linkUrl) VALUES ('\(mainMemberID!)', '\(dict.object(forKey: "groupModuleId") as! String)', '\(dict.object(forKey: "groupId") as! String)', '\(dict.object(forKey: "moduleId") as! String )', '\(dict.object(forKey: "moduleName") as! String)', '\(dict.object(forKey: "moduleStaticRef") as! String)', '\(dict.object(forKey: "image") as! String)','\(dict.object(forKey: "moduleOrderNo") as! String)',\(varGetModuleId),'\(dict.object(forKey: "flag") as! String)','\(dict.object(forKey: "link_url") as! String)')"
                    print("Insert module query= \(insertSQL)")
                    let result = contactDB?.executeStatements(insertSQL)
                    if (result == nil)
                    {
                        print("ErrorAi insert : \(contactDB?.lastErrorMessage())")
                    }
                    else
                    {
                        //print("success saved")
                        //print(databasePath);
                    }
                }
                // self.buttonOpacity.hidden=true
            } else {
                ////print("Error: \(contactDB?.lastErrorMessage())")
            }
            
            contactDB?.close()
        }
    }
    
    func DeleteModuleDataInlocal (_ arrdata:NSArray)
    {
        var databasePath : String
        //print(arrdata);
        
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            ////print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            ////print("Error: \(contactDB.lastErrorMessage())")
        }
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            for i in 0 ..< arrdata.count
            {
                let  dict = arrdata[i] as! NSDictionary
                let insertSQL = "DELETE FROM MODULE_DATA_MASTER WHERE groupModuleId = '\(dict.object(forKey: "groupModuleId") as! String)'"
                //print(insertSQL)
                
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil)
                {
                    ////print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    ////print("success saved")
                    //print(databasePath);
                }
            }
            
        }
        else
        {
            ////print("Error: \(contactDB?.lastErrorMessage())")
        }
    }
    
    func SaveModuleDataInlocal (_ arrdata:NSArray)
    {
        var databasePath : String
        //print(arrdata);
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            ////print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            ////print("Error: \(contactDB.lastErrorMessage())")
        }
        //print(databasePath)
        
        if (contactDB?.open())!
        {
            for i in 0 ..< arrdata.count
            {
                let  dict = arrdata[i] as! NSDictionary
                // let varGetModuleId=functionForAddingCounting((dict.object(forKey: "groupId") as! String), stringModuleId: (dict.object(forKey: "moduleId") as! String ))
                
                let varGetModuleId = "0"
                var staticRef = dict.object(forKey: "moduleStaticRef") ?? ""
                let insertSQL1 = "DELETE FROM MODULE_DATA_MASTER WHERE groupModuleId = '\(dict.object(forKey: "groupModuleId") as! String)'"
                print("Insert module list query = \(insertSQL1)")
                let result1 = contactDB?.executeStatements(insertSQL1)
                if (result1 == nil)
                {
                    print("ErrorAi update: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    print("success update module list.")
                    //print(databasePath);
                }
                
                //print(varGetModuleId)
                let insertSQL = "INSERT INTO MODULE_DATA_MASTER (masterUID, groupModuleId, groupId , moduleId ,moduleName, moduleStaticRef, image,moduleOrderNo,notificationCount,flag,linkUrl) VALUES ('\(mainMemberID!)', '\(dict.object(forKey: "groupModuleId") as! String)', '\(dict.object(forKey: "groupId") as! String)', '\(dict.object(forKey: "moduleId") as! String )', '\(dict.object(forKey: "moduleName") as! String)', '\(dict.object(forKey: "moduleStaticRef") ?? "")', '\(dict.object(forKey: "image") as! String)','\(dict.object(forKey: "moduleOrderNo") as! String)','\(varGetModuleId)','\(dict.object(forKey: "flag") as! String)','\(dict.object(forKey: "link_url") as! String)')"
                print(insertSQL)
                if let adminModule = dict.object(forKey: "moduleName") as? String
                {
                    if adminModule=="Admin"
                    {
                        print("New Admin Module insertSQL:: \(insertSQL)")
                    }
                }
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil)
                {
                    ////print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    ////print("success saved")
                    //print(databasePath);
                }
            }
            // self.buttonOpacity.hidden=true
        } else {
            ////print("Error: \(contactDB?.lastErrorMessage())")
        }
    }
    
    func functionForAddingCounting(_ stringGroupId:String,stringModuleId:String)->Int
    {
        var varGetId=stringGroupId
        var muarray:NSMutableArray=NSMutableArray()
        var varGet=UserDefaults.standard.value(forKey: "session_EntityId")as! NSArray
        // muarray=(NSUserDefaults.standardUserDefaults().valueForKey("session_EntityId")as! NSArray) as! NSMutableArray
        var arrayTemp:NSArray=NSArray()
        arrayTemp = (UserDefaults.standard.value(forKey: "session_EntityId")as! NSArray)
        //print(arrayTemp.count)
        for i in 0 ..< arrayTemp.count
        {
            muarray.add(arrayTemp.object(at: i))
        }
        //print(muarray)
        var muarrayNotificationCount:NSMutableArray=NSMutableArray()
        var varDefaultModuleId:Int=0
        for i in 0 ..< muarray.count
        {
            let letGetValue=muarray.object(at: i) as! String
            //print(letGetValue)
            if(letGetValue==varGetId)
            {
                let letGetArray=muarray.object(at: i)
                var muarrayTemp:NSMutableArray=NSMutableArray()
                var arrayTemporary:NSArray=NSArray()
                arrayTemporary = (UserDefaults.standard.value(forKey: "session_notificationCountForModule")as! NSArray)
                muarrayTemp = NSMutableArray(array: arrayTemporary)
                //print(muarrayTemp)
                //muarrayNotificationCount=((muarrayTemp.object(at: i) as AnyObject).mutableCopy()) as! NSMutableArray
                
                muarrayNotificationCount=((muarrayTemp.object(at: i) as AnyObject)) as! NSMutableArray
                //  muarrayNotificationCount=muarrayTemp.object(at: i) as! NSMutableArray
                
                
                
                
                ////print("Group Id:-")
                //print(stringGroupId)
                ////print("module Id:-")
                //print(stringModuleId)
                //print(muarrayNotificationCount)
                
                if(stringGroupId=="339")
                {
                    ////print("hello")
                }
                for j in 00..<muarrayNotificationCount.count
                {
                    var varGetValuesModuleIDForCompare=muarrayNotificationCount.object(at: j)
                    ////print("This is value:-")
                    //print(varGetValuesModuleIDForCompare)
                    var varGetValuesNew=(varGetValuesModuleIDForCompare as AnyObject).value(forKey: "moduleId")as! String
                    if(stringModuleId==varGetValuesNew)
                    {
                        var varGetTempValue:String=((varGetValuesModuleIDForCompare as AnyObject).value(forKey: "count"))as! String
                        varDefaultModuleId=Int(varGetTempValue)!
                    }
                }
            }
        }
        //print(varDefaultModuleId)
        return varDefaultModuleId
    }
    
    func functionForCheckIsSessionTimeoutOrNot()
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
            
        {
            var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            var updatedOn =  String ()
            let defaults = UserDefaults.standard
            let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
            updatedOn = "1970-01-01 00:00:00"
            if let str = defaults.value(forKey: Updatedefault) as! String?
            {
                updatedOn = str
            }
            else
            {
                updatedOn = "1970-01-01 00:00:00"
            }
            var varGetMobileNumber = UserDefaults.standard.value(forKey: "session_Mobile_Number")as! String
            var varGetCountryCode = UserDefaults.standard.value(forKey: "session_Country_Code")as! String
            var varGetLoginType = UserDefaults.standard.value(forKey: "session_Login_Type")as! String
            let completeURL = baseUrl+touchBase_GetAllGroupListSync
            let parameterst = [
                "masterUID" : mainMemberID!,
                "imeiNo" : UIDevice.current.identifierForVendor!.uuidString,
                "updatedOn" : updatedOn,
                "loginType" : varGetLoginType,
                "mobileNo" : varGetMobileNumber,
                "countryCode" : varGetLoginType
            ]
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                let dd = response as! NSDictionary
                print("Session result 2: \(dd)")
                var varGetValueServerError = response.object(forKey: "serverError")as? String
                if(varGetValueServerError == "Error")
                {
                    SVProgressHUD.dismiss()
                }
                else
                {
                    if (dd.object(forKey: "status") as! String == "0")
                    {
                        
                    }
                    else if (dd.object(forKey: "status") as! String == "2")
                    {
                        //----------------------------------------------
                        //---delete old value from server in case of Birthday Anniversary Event start
                        self.DELETEDashboard_BirthAnniEvent_table_New()
                        //---delete old value from server in case of Birthday Anniversary Event ens
                        //-------------------------------------------------
                        // self.appDelegate.showAlsertView()
                        //    self.imageSplashScreenRoot.isHidden=true
                        self.loaderClass.window = nil
                        SVProgressHUD.dismiss()
                        UserDefaults.standard.removeObject(forKey: "updatedOn")
                        let alert=UIAlertController(title: self.headTitle, message:dd.object(forKey: "message") as! String, preferredStyle: UIAlertController.Style.alert);
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
                            self.appDelegate = UIApplication.shared.delegate as! AppDelegate
                            self.appDelegate.setMobileViewAsRoot()
                            // self.appDelegate.showAlsertView()
                        }));
                        self.present(alert, animated: true, completion: nil);
                    }
                }
            })
        }
    }
    
    func beginParsing()
    {
        
        self.posts = []
        self.parser = XMLParser(contentsOf:(URL(string:"https://my.rotary.org/en/rss.xml"))!)!
        self.parser.delegate = self
        self.parser.parse()
        
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
            link = NSMutableString()
            link = ""
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (elementName as NSString).isEqual(to: "item") {
            if !title1.isEqual(nil)
            {
                elements.setObject(title1, forKey: "title" as NSCopying)
            }
            if !date.isEqual(nil)
            {
                elements.setObject(date, forKey: "date" as NSCopying)
            }
            if !description11.isEqual(nil)
            {
                elements.setObject(description11, forKey: "description" as NSCopying)
            }
            if !link.isEqual(nil)
            {
                elements.setObject(link, forKey: "link" as NSCopying)
            }
            /*------------------------------------Store Data local--------------Start------------------------------------*/
            var databasePath : String
            let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documents.appendingPathComponent("NewTouchbase.db")
            databasePath = fileURL.path
            var db: OpaquePointer? = nil
            if sqlite3_open(fileURL.path, &db) != SQLITE_OK
            {
            }
            else
            {
            }
            let contactDB = FMDatabase(path: databasePath as String)
            if contactDB == nil
            {
            }
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            if (contactDB?.open())!
            {
                var insertSQL:String! = ""
                
                insertSQL = "INSERT INTO NewsUpdate_Table (newsUpdateTitle , newsUpdateDescription,newsUpdateDate,link,isFeedFirstOrSecond) VALUES ( '\(title1)', '\(description11)', '\(date)','\(link)','\("First")')"
                print("4.NewsUpdate Insert Query::\(insertSQL)")
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil)
                {
                }
                else
                {
                    
                }
            }
            else
            {
            }
            /*------------------------------------Store Data local--------------Start------------------------------------*/
            posts.add(elements)
            
        }
        
        
        UserDefaults.standard.setValue("0", forKey: "Session_RssFeedFirstTime")
        
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
            link.append(string)
        }
    }
    
    
    
    func functionForStoreBirthEventAnni(_ ClubCategorys:String,ClubIds:String,ClubNames:String,Descriptions:String,ProfileId:String,Titles:String,TodaysCounts:String,Types:String,isAdmin:String)
    {
        
        let mainDescriptin=Descriptions.replacingOccurrences(of: "'", with: "")
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            ////print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            ////print("Error: \(contactDB.lastErrorMessage())")
        }
        
        /*need to delete previous data start*/
        // var databasePath : String
        
        // let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        // let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        // databasePath = fileURL.path
        // var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
        }
        else
        {
        }
        // let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            if(ClubIds.characters.count>0)
            {
            }
        }
        if (contactDB?.open())!
        {
            let  insertSQL = "INSERT INTO Dashboard_BirthAnniEvent_table_New (ClubCategory , ClubId,ClubName,Description,ProfileId,Title,TodaysCount,Type,ExtraOne,ExtraTwo,IsAdmin,ISUpdate) VALUES ( '\(ClubCategorys)', '\(ClubIds)', '\(ClubNames)','\(mainDescriptin)','\(ProfileId)', '\(Titles)', '\(TodaysCounts)', '\(Types)', '\("ExtraOne")' ,'\("ExtraTwo")','\(isAdmin)','\("IsUpdate")')"
            //            print(insertSQL)
            
            
            let result = contactDB?.executeStatements(insertSQL)
            if (result == nil)
            {
            }
            else
            {
            }
        }
        else
        {
        }
        posts.add(elements)
    }
    func  functionDashBoardbirthAnniEventDataGet()
    {
        //this function is being called due to if date change then should not show old date data
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
        }
        else
        {
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            
        }
        if (contactDB?.open())!
        {
            print("Entered in sql database")
            var querySQL = ""
            var previousTitle:String!=""
            querySQL = "SELECT distinct(Title),ClubCategory,ClubId,ClubName,Description,ProfileId,TodaysCount,Type,IsAdmin  FROM Dashboard_BirthAnniEvent_table_New"
            let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
            muarrayForBirthdayAnniversaryEvent=NSMutableArray()
            while results?.next() == true
            {
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "ClubCategory"))! as String, forKey:"ClubCategory")
                dd.setValue((results?.string(forColumn: "ClubId"))! as String, forKey:"ClubId")
                dd.setValue((results?.string(forColumn: "ClubName"))! as String, forKey:"ClubName")
                dd.setValue((results?.string(forColumn: "Description"))! as String, forKey:"Description")
                dd.setValue((results?.string(forColumn: "ProfileId"))! as String, forKey:"ProfileId")
                dd.setValue((results?.string(forColumn: "Title"))! as String, forKey:"Title")
                dd.setValue((results?.string(forColumn: "TodaysCount"))! as String, forKey:"TodaysCount")
                dd.setValue((results?.string(forColumn: "Type"))! as String, forKey:"Type")
                dd.setValue((results?.string(forColumn: "IsAdmin"))! as String, forKey:"IsAdmin")
                muarrayForBirthdayAnniversaryEvent.add(dd)
                UserDefaults.standard.setValue(muarrayForBirthdayAnniversaryEvent, forKey: "session_notificationBirAnniEventNar")
            }
            //            self.viewPager.scrollToPage(0)
            //            self.viewPager.dataSource = self
            //            self.viewPager.animationNext()
            //            self.imgGrayIconROW.isHidden=true
        }
        contactDB?.close()
    }
    
}

extension RootDashNewViewController: ViewPagerDataSource, XMLParserDelegate
{
    
    func numberOfItems(_ viewPager:ViewPager) -> Int
    {
        //muarrayForBirthdayAnniversaryEvent
        return muarrayForBirthdayAnniversaryEvent.count
    }
    func viewAtIndex(_ viewPager:ViewPager, index:Int, view:UIView?) -> UIView {
        
        if(muarrayForBirthdayAnniversaryEvent.count>0)
        {
            self.indicator.stopAnimating()
        }
        
        var newView = view;
        var label:UILabel?
        if(newView == nil){
            newView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:  self.view.frame.height))
            //newView!.backgroundColor = .randomColor()
            label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:  30))//newView!.bounds)
            label!.tag = 1
            label!.autoresizingMask =  [.flexibleWidth, .flexibleHeight]
            label!.textAlignment = .center
            label?.numberOfLines = 0
            //label!.font =  label!.Font.withSize(28)
            label?.font = UIFont(name: "Roboto-Regular", size: 20)
            newView?.addSubview(label!)
        }else
        {
            label = newView?.viewWithTag(index) as? UILabel
        }
        
        //        lblBAEDesc.numberOfLines=3
        //        lblDescForSlider.numberOfLines = 3
        //        lblDateEVENT.numberOfLines = 1
        //        lblDescriptionForBirthAnni.numberOfLines=2
        //        lblandhaveTodayBirthday.numberOfLines=1
        
        selectedIndexForSilder = index
        if(muarrayForBirthdayAnniversaryEvent.count>0)
        {
            let varBAEType = (muarrayForBirthdayAnniversaryEvent.object(at: index) as AnyObject).value(forKey: "Type") as? String
            let clubname = (muarrayForBirthdayAnniversaryEvent.object(at: index) as AnyObject).value(forKey: "ClubName") as? String
            let Description = (muarrayForBirthdayAnniversaryEvent.object(at: index) as AnyObject).value(forKey: "Description") as? String
            var Title = (muarrayForBirthdayAnniversaryEvent.object(at: index) as AnyObject).value(forKey: "Title") as? String
            let TodaysCount = (muarrayForBirthdayAnniversaryEvent.object(at: index) as AnyObject).value(forKey: "TodaysCount") as? String
            let ClubCategory = (muarrayForBirthdayAnniversaryEvent.object(at: index) as AnyObject).value(forKey: "ClubCategory") as? String
            var isAdmin = (muarrayForBirthdayAnniversaryEvent.object(at: index) as AnyObject).value(forKey: "IsAdmin") as? String
            
            let paragraphStyle = NSMutableParagraphStyle()
            //line height size
            paragraphStyle.lineSpacing = 1.6
            let attrString = NSMutableAttributedString(string: Description!)
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
            
            
            if(Int(TodaysCount!) ?? 0>2)
            {
                let fullNameArr = Title?.components(separatedBy: ",")
                // //print(fullNameArr[0])
                Title = fullNameArr?[0]
            }
            
            //  self.viewPager.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
            
            //Birthday
            if(varBAEType=="Birthday")
            {
                
                let Titles = Title?.replacingOccurrences(of: ",", with: " & ")
                
                var descBA :String!=""
                
                if(Int(TodaysCount!)!==1 || Int(TodaysCount!)!==2)
                {
                    if(Int(TodaysCount!)!==1)
                    {
                        descBA = Titles
                        //                    lblandhaveTodayBirthday.text! = "has \(varBAEType!) today."
                    }
                    else
                    {
                        descBA = Titles  //+" have \(varBAEType) today."
                        //                    lblandhaveTodayBirthday.text! = "have \(varBAEType!) today."
                    }
                    
                }
                else if (Int(TodaysCount!) ?? 0>2)
                {
                    
                    descBA = Titles //+" and \(Int(TodaysCount)! - 1) others have \(varBAEType) today."
                    
                    
                    //                lblandhaveTodayBirthday.text! = "and \(Int(TodaysCount!)! - 1) others have \(varBAEType!) today."
                }
                
                
                let paragraphStyleBA = NSMutableParagraphStyle()
                //line height size
                paragraphStyleBA.lineSpacing = 1.6
                let attrStringBA = NSMutableAttributedString(string: descBA)
                attrStringBA.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrStringBA.length))
                
                
                //            lblBAEDesc.isHidden=true
                //            lblDescriptionForBirthAnni.isHidden=false
                //            lblandhaveTodayBirthday.isHidden=false
                //            imgBAE.isHidden=false
                //            lblClubDistrictName.text! = clubname!
                //            lblDescriptionForBirthAnni.attributedText = attrStringBA
                //            //  lblDescriptionForBirthAnni.textAlignment = NSTextAlignment.Center
                //            lblDateEVENT.isHidden=true
                //            lblDescForSlider.isHidden=true
                //            //lblDescriptionForBirthAnni.text! = Description
                //            imgBAE.image = UIImage(named:"bday")
                //            if(ClubCategory=="1")
                //            {
                //             self.viasdewPager.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
                //            }
                //            else if(ClubCategory=="2")
                //            {
                //             self.visdfewPager.backgroundColor =  UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
                //            }
            }
            //Anniversary
            if(varBAEType=="Anniversary")
            {
                // let descBA = Title+" and \(TodaysCount) others \n have \(varBAEType) today."
                
                let Titles = Title?.replacingOccurrences(of: ",", with: " & ")
                
                var descBA :String!=""
                if(Int(TodaysCount!)!==1 || Int(TodaysCount!)!==2)
                {
                    if(Int(TodaysCount!)!==1)
                    {
                        descBA = Titles //+" has \(varBAEType) today."
                        //                    lblandhaveTodayBirthday.text! = "has \(varBAEType!) today."
                    }
                    else
                    
                    {
                        descBA = Titles //+" have \(varBAEType) today."
                        //                    lblandhaveTodayBirthday.text! = "have \(varBAEType!) today."
                    }
                }
                else if (Int(TodaysCount!) ?? 0>2)
                {
                    
                    descBA = Titles  //+" and  \(Int(TodaysCount)! - 1) others have \(varBAEType) today."
                    //                lblandhaveTodayBirthday.text! = "and  \(Int(TodaysCount!)! - 1) others have \(varBAEType!) today."
                }
                
                
                let paragraphStyleBA = NSMutableParagraphStyle()
                //line height size
                paragraphStyleBA.lineSpacing = 1.6
                let attrStringBA = NSMutableAttributedString(string: descBA)
                attrStringBA.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrStringBA.length))
                
                //            lblBAEDesc.isHidden=true
                //            lblDescriptionForBirthAnni.isHidden=false
                //            lblandhaveTodayBirthday.isHidden=false
                //            imgBAE.isHidden=false
                //            lblClubDistrictName.text! = clubname!
                //            lblDescriptionForBirthAnni.attributedText = attrStringBA
                //            //lblDescriptionForBirthAnni.textAlignment = NSTextAlignment.Center
                //            lblDateEVENT.isHidden=true
                //            // lblDescriptionForBirthAnni.text! = Description
                //            imgBAE.image = UIImage(named:"Anni")
                //            lblDescForSlider.isHidden=true
                
                print(clubname)
                
            }
            //Event
            if(varBAEType=="Event")
            {
                //            lblBAEDesc.isHidden=false
                //            lblDescForSlider.isHidden=false
                //            lblDateEVENT.isHidden=false
                //            lblClubDistrictName.text! = clubname!
                //            lblBAEDesc.text! = Title!
                //            lblDateEVENT.text! = TodaysCount!
                //            lblDescForSlider.attributedText = attrString
                //            lblDescForSlider.textAlignment = NSTextAlignment.center
                //            //lblDescForSlider.attributedText = attributedString
                //            // lblDescForSlider.textAlignment = .Center
                //            imgBAE.isHidden=true
                //            lblDescriptionForBirthAnni.isHidden=true
                //            lblandhaveTodayBirthday.isHidden=true
                
            }
            if(varBAEType=="Announcement")
            {
                //            lblBAEDesc.isHidden=false
                //            lblDateEVENT.isHidden=false
                //            lblDescForSlider.isHidden=false
                //            lblClubDistrictName.text! = clubname!
                //            lblBAEDesc.text! = Title!
                //            lblDateEVENT.text! = TodaysCount!
                //            lblDescForSlider.attributedText = attrString
                //            lblDescForSlider.textAlignment = NSTextAlignment.center
                //            //  lblDescForSlider.attributedText = attributedString
                //            // lblDescForSlider.textAlignment = .Center
                //            imgBAE.isHidden=true
                //            lblDescriptionForBirthAnni.isHidden=true
                //            lblandhaveTodayBirthday.isHidden=true
                
                
                
                // self.viesdfwPager.backgroundColor =  UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
                
            }
            
            
            
            //Image bday and Anniversary
            //        viewPager.addSubview(lblClubDistrictName)
            //        viewPager.addSubview(lblBAEDesc)
            //        viewPager.addSubview(lblDescForSlider)
            //        viewPager.addSubview(lblDateEVENT)
            //        viewPager.addSubview(imgBAE)
            //        viewPager.addSubview(lblDescriptionForBirthAnni)
            //        viewPager.addSubview(lblandhaveTodayBirthday)
            // label?.text = "Deepak Kumar Patidar and 4 others have birthday today \(index+1)."
        }
        return newView!
    }
    
    
    
    func didSelectedItem(_ index: Int) {
        ////print("select index \(selectedIndexForSilder)")
        // print(muarrayForBirthdayAnniversaryEvent)
        let varBAEType = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "Type") as! String
        let clubname = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "ClubName") as! String
        let Description = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "Description") as! String
        let Title = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "Title") as! String
        let TodaysCount = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "TodaysCount") as! String
        let ClubCategory = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "ClubCategory") as! String
        
        let ClubId = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "ClubId") as! String
        
        let ProfileId = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "ProfileId") as! String
        let isAdmin = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "IsAdmin") as! String
        
        //Birthday
        if(varBAEType=="Birthday")
        {
            
            UserDefaults.standard.setValue(ProfileId, forKey: "user_auth_token_profileId")
            UserDefaults.standard.setValue(ClubId, forKey: "user_auth_token_groupId")
            UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
            
            //Need to Code by Rajendra Sir
            if #available(iOS 13.0, *) { let objCelebrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
                objCelebrationViewController.stringProfileId = ProfileId
                objCelebrationViewController.stringGroupID = ClubId
                objCelebrationViewController.isCategory=ClubCategory
                objCelebrationViewController.varType="B"
                objCelebrationViewController.moduleName="Calendar"
                objCelebrationViewController.isBirthdayorAnniv="birthday"
                objCelebrationViewController.isAdmin=isAdmin
                self.navigationController?.pushViewController(objCelebrationViewController, animated: true)
                
            }
            else {
                // Fallback on earlier versions
            }
            
            /* objCelebrationViewController.stringProfileId = grpDetailPrevious["grpProfileid"] as! String
             objCelebrationViewController.stringGroupID = dict["groupId"] as! String*/
        }
        //Anniversary
        if(varBAEType=="Anniversary")
        {
            UserDefaults.standard.setValue(ProfileId, forKey: "user_auth_token_profileId")
            UserDefaults.standard.setValue(ClubId, forKey: "user_auth_token_groupId")
            UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
            //Need to Code by Rajendra Sir
            if #available(iOS 13.0, *) {
                let objCelebrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
                objCelebrationViewController.stringProfileId = ProfileId
                objCelebrationViewController.stringGroupID = ClubId
                objCelebrationViewController.isCategory=ClubCategory
                objCelebrationViewController.varType="A"
                objCelebrationViewController.moduleName="Calendar"
                objCelebrationViewController.isBirthdayorAnniv="anniv"
                objCelebrationViewController.isAdmin=isAdmin
                self.navigationController?.pushViewController(objCelebrationViewController, animated: true) }
            else {
                // Fallback on earlier versions
            }
            
        }
        //Event
        if(varBAEType=="Event")
        {
            //  //print(isAdmin)
            UserDefaults.standard.setValue(ProfileId, forKey: "user_auth_token_profileId")
            UserDefaults.standard.setValue(ClubId, forKey: "user_auth_token_groupId")
            UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
            //Need to Code by Rajendra Sir
            if #available(iOS 13.0, *) {
                let objCelebrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
                objCelebrationViewController.stringProfileId = ProfileId
                objCelebrationViewController.stringGroupID = ClubId
                objCelebrationViewController.isCategory=ClubCategory
                objCelebrationViewController.varType="E"
                objCelebrationViewController.moduleName="Calendar"
                objCelebrationViewController.isBirthdayorAnniv=""
                objCelebrationViewController.isAdmin=isAdmin
                objCelebrationViewController.grpName=clubname
                //            print("Club name to send \(clubname)")
                self.navigationController?.pushViewController(objCelebrationViewController, animated: true)
            } else {
                // Fallback on earlier versions
            }
            
        }
        if(varBAEType=="Announcement")
        {
            //Need to Code by Rajendra Sir
        }
    }
}

extension RootDashNewViewController {
    
    func functionForGetZipFilePath()
    {
        
        
        let grpID=((UserDefaults.standard.string(forKey: "grpId")) as! String)
        //if any json file(New,Updated,Deleted) is remain to server then first server that
        //code by Rajendra Jat for delete all zip files from document directory
        SVProgressHUD.show()
        functionForGetNewUpdateDeleteMember()
        MainDashboardViewController().funcForRemoveZipFileFromDocumentDirectory()
        print("™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™")
        var updatedOn =  String ()
        let defaults = UserDefaults.standard
        let UpdatedefaultNew = String(format: "updatedOnDirectory%@",grpID)
        var  testlet = defaults.value(forKey: UpdatedefaultNew) as! String?
        if let str = defaults.value(forKey: UpdatedefaultNew) as! String?
        {
            updatedOn = str
            //updatedOn = "1970-01-01 00:00:00"
        }
        else
        {
            updatedOn = "1970-01-01 00:00:00"
            SVProgressHUD.show()
        }
        if(updatedOn == "1970-01-01 00:00:00")
        {
            //            self.buttonOpacityFirstTime.isHidden=false
            //            self.labelFirstLoading.isHidden=false
            // self.loaderClass.loaderViewMethod()
        }
        
        
        
        //Refreshing data
        //        if(varRefreshDatRunOneTime=="Second")
        //        {
        //         updatedOn = "1970-01-01 00:00:00"
        //         SVProgressHUD.show()
        //        }
        //        else
        //        {
        //
        //        }
        
        
        //moduleId
        var  completeURL:String!=""
        if(isCategory=="2") //DPK
        {
            completeURL = baseUrl+touchBAse_GetDistrictListSync
        }
        else
        {
            completeURL = baseUrl+touchBase_GetMemberListSync
        }
        
        let parameterst = [
            k_API_DirectoryZipFile : grpID,
            k_API_updatedOn : updatedOn
        ] as [String : Any]
        
        print("Club Directory parameterst:: \(parameterst)")
        print("Club Directory completeURL:: \(completeURL)")
        
        //------------------------------------------------------
        Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
            switch response.result {
            case .success:
                // var result = [String:String]()
                SVProgressHUD.dismiss()
                if let value = response.result.value {
                    let dic = response.result.value!
                    let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                    let jsonString = String(data: jsonData!, encoding: .utf8)!
                    //print(jsonString)
                    //--
                    if(response==nil)
                    {
                        
                    }
                    else
                    {
                        let dd = response.result.value as! NSDictionary
                        print(dd)
                        var varGetValueServerError = dd.object(forKey: "serverError")as? String
                        if(varGetValueServerError == "Error")
                        {
                            self.loaderClass.window = nil
                            //          self.buttonOpacityFirstTime.isHidden=true
                            //          self.labelFirstLoading.isHidden=true
                            //          self.NoRecordLabel.isHidden=true
                            self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                            SVProgressHUD.dismiss()
                        }
                        else
                        {
                            //print("//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*",dd)
                            ////code by  Rajendra Jat here need to update sesssion for last update date
                            //curDate
                            UserDefaults.standard.set(dd.object(forKey: "curDate")as! String, forKey: UpdatedefaultNew)
                            // print(NSUserDefaults.standardUserDefaults().setObject(dd.objectForKey("curDate")as! String, forKey: UpdatedefaultNew))
                            
                            // print(dd.objectForKey("curDate")as! String)
                            print(dd)
                            
                            if(dd.object(forKey: "status") as! String == "0" && dd.object(forKey: "zipFilePath") as! String != "")
                            {
                                // self.funcForRemoveZipFileFromDocumentDirectory()
                                
                                //              self.buttonOpacityFirstTime.isHidden=false
                                //              self.labelFirstLoading.isHidden=false
                                //self.loaderClass.loaderViewMethod()
                                
                                self.varGetZipFileUrl=dd.object(forKey: "zipFilePath") as! String
                                self.functionForDownloadZipFile( self.varGetZipFileUrl)
                            }
                            else
                            {
                                
                                
                                if(dd.object(forKey: "status") as! String == "1")
                                {
                                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                                    SVProgressHUD.dismiss()
                                }
                                else
                                {
                                    
                                    
                                    
                                    if(dd.object(forKey: "status") as! String == "2")
                                    {
                                        //self.view.makeToast("No new updates found", duration: 2, position: CSToastPositionCenter)
                                    }
                                    else
                                    {
                                        let UpdateMemberListjsonResult: NSDictionary = NSDictionary()
                                        var varGetNewMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")
                                        var varGetUpdatedMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")
                                        var varGetDeleteMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "DeletedMemberList") as! String
                                        
                                        print("------>")
                                        print(varGetUpdatedMemberList)
                                        print("<------ Deleted Memeber List::::")
                                        
                                        //                                            var alertController = UIAlertController()
                                        //
                                        //                                            alertController = UIAlertController(title: "", message: "Deleted members are \(varGetDeleteMemberList)", preferredStyle: .alert)
                                        //                                            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil));
                                        //                                            self.present(alertController, animated: true, completion: nil)
                                        
                                        print(varGetDeleteMemberList)
                                        if(varGetDeleteMemberList.characters.count>0)
                                        {
                                            print(varGetDeleteMemberList)
                                            //  let profileIDs:[String]=varGetDeleteMemberList.split(separator: ",")
                                            self.functionForDeleteMembers([varGetDeleteMemberList])
                                        }
                                        
                                        /*555555555555555555555555555555555555555555555555555555555555555555555555555555555555*/
                                        if((varGetNewMemberList! as AnyObject).count>0)
                                        {
                                            self.functionForNewMemberWhenDataComingNotZipFile(dd)
                                            
                                        }
                                        /*555555555555555555555555555555555555555555555555555555555555555555555555555555555555*/
                                        
                                        /*6666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666*/
                                        if((varGetUpdatedMemberList! as AnyObject).count>0)
                                        {
                                            self.functionForUpdateMemberWhenDataComingNotZipFile(dd)
                                            
                                        }
                                        /*6666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666*/
                                    }
                                    
                                }
                            }
                            self.fetchData()
                            //          self.search.isEnabled=true
                            //          self.searchButton.isEnabled=true
                        }
                        SVProgressHUD.dismiss()
                    }
                    
                    //----
                }
            case .failure(_): break
            }
        }
        //----------------------------------------------------
        
        
        
        
        
        // ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
        //=> Handle server response
        
        
        // })
        
    }
    
    func functionForDownloadZipFile(_ stringZipFilePath:String)
    {
        ///-----------------------------------------------------ppppppppp---------------
        let destinationn = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        
        Alamofire.download(stringZipFilePath,method: .get,parameters: nil,encoding: JSONEncoding.default, headers: nil,to: destinationn).downloadProgress(closure: { (progress) in
            //progress closure
        }).response(completionHandler: { (DefaultDownloadResponse) in
            //here you able to access the DefaultDownloadResponse
            //---------------------------------------------------------------------------------------
            //get zip file from document directory
            let dirst = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as? [String]
            // print(dirst)
            if dirst != nil
            {
                let dirt = dirst![0]
                do {
                    let fileList = try FileManager.default.contentsOfDirectory(atPath: dirt)
                    // print(fileList)
                    for i in 00 ..< fileList.count
                    {
                        let file:String = "ABC"
                        var varValue=fileList[i]
                        //print(varValue)
                        if(varValue.hasSuffix(".zip"))
                        {
                            var varGetFilePAth:String=""
                            varGetFilePAth=fileList[i]
                            // print(varGetFilePAth)
                            //here need to unwip file
                            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                            
                            print(documentsPath)
                            print(varGetFilePAth)
                            
                            /// let zipPath:String =  (string: documentsPath+"/"+varGetFilePAth) as! String ;
                            
                            let zipPath:String =  documentsPath+"/"+varGetFilePAth
                            
                            print(zipPath)
                            
                            
                            
                            // print(zipPath)
                            if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first
                            {
                                //below code zip to unzip
                                let path:String = String(describing: NSURL(fileURLWithPath: dir).appendingPathComponent(""))
                                // print(zipPath)
                                // print(path)
                                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                                SSZipArchive.unzipFile(atPath: String(zipPath), toDestination: String(documentsPath))
                                //code for get unzip file insert update delete
                                self.functionForGetNewUpdateDeleteMember()
                            }
                        }
                        else
                        {
                            //self.view.makeToast("Error occuring, While fetching data", duration: 3, position: CSToastPositionCenter)
                        }
                    }
                }
                catch
                {
                }
            }
            else
            {
                self.view.makeToast("Error occuring, While fetching data", duration: 3, position: CSToastPositionCenter)
            }
            //
            //-----------------------------------------------------------------------------------------
            //result closure
        })
        //-------------------------------------------------------ppppppppp-----------------
        
        
        //        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        //
        //        Alamofire.download(.GET, stringZipFilePath, destination: destination)
        //            .response { _, _, _, error in
        //                if error != nil
        //                {
        //                    print("Failed with error: \(error)")
        //                    let letGetResponse:String!=String(error)
        //                    self.view.makeToast("Error occuring, While fetching data from server.", duration: 3, position: CSToastPositionCenter)
        //                }
        //                else
        //                {
        //                    //get zip file from document directory
        //                    let dirst = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        //                    // print(dirst)
        //                    if dirst != nil
        //                    {
        //                        let dirt = dirst![0]
        //                        do {
        //                            let fileList = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(dirt)
        //                            // print(fileList)
        //                            for i in 00 ..< fileList.count
        //                            {
        //                                let file:String = "ABC"
        //                                var varValue=fileList[i]
        //                                //print(varValue)
        //                                if(varValue.hasSuffix(".zip"))
        //                                {
        //                                    var varGetFilePAth:String=""
        //                                    varGetFilePAth=fileList[i]
        //                                    // print(varGetFilePAth)
        //                                    //here need to unwip file
        //                                    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        //                                    let zipPath:String =  (string: documentsPath+"/"+varGetFilePAth);
        //                                    // print(zipPath)
        //                                    if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
        //                                    {
        //                                        //below code zip to unzip
        //                                        let path:String = String(NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(""))
        //                                        // print(zipPath)
        //                                        // print(path)
        //                                        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        //                                        WPZipArchive.unzipFileAtPath(String(zipPath), toDestination: String(documentsPath))
        //                                        //code for get unzip file insert update delete
        //
        //
        //
        //
        //                                        self.functionForGetNewUpdateDeleteMember()
        //
        //                                    }
        //                                }
        //                                else
        //                                {
        //                                    //self.view.makeToast("Error occuring, While fetching data", duration: 3, position: CSToastPositionCenter)
        //
        //                                }
        //                            }
        //
        //
        //
        //                        }
        //                        catch
        //                        {
        //                        }
        //                    }
        //                    else
        //                    {
        //                        self.view.makeToast("Error occuring, While fetching data", duration: 3, position: CSToastPositionCenter)
        //                    }
        //                    //
        //   }
        // }
    }
    
    func functionForNewMemberWhenDataComingNotZipFile(_ dd:NSDictionary)
    {
        var dictNewMemberListjsonResult:NSDictionary=NSDictionary()
        dictNewMemberListjsonResult=dd
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            
        }
        else
        {
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            
        }
        let moduleID = "1"
        //        let moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
        let GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            ((dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).count
            
            // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.count)
            for i in 0 ..< ((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).count
            {
                
                let dictMain=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                
                let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
                
                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
                let memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
                let memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
                
                
                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
                let insertSQL = "INSERT INTO ProfileMaster (masterId,grpId,profileId,isAdmin,memberName,memberEmail,memberMobile,memberCountry,profilePic,familyPic,isPersonalDetVisible,isBussinessDetVisible,isFamilyDetVisible) VALUES('"+masterID+"','"+grpID+"','"+profileID+"','"+isAdmin+"','"+memberNames+"','"+memberEmail+"','"+memberMobile+"','"+memberCountry+"','"+profilePic+"','"+familyPic+"','"+isPersonalDetVisible+"','"+isBusinDetVisible+"','"+isFamilDetailVisible+"')"
                print("INSERTING NEW MEMBER")
                print(insertSQL)
                let result = contactDB?.executeStatements(insertSQL)
                print("Result after inserting new members \(result)")
                if (result == nil)
                {
                    
                }
                else
                {
                    
                    var dictTemporaryDictionary:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                    for j in 0 ..< (dictTemporaryDictionary.object(forKey: "personalMemberDetails")! as AnyObject).count
                            
                    {
                        var dictTemporaryDictionaryNew:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                        let dictChild=(dictTemporaryDictionaryNew.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
                        //print(dictChild)
                        let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                        let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                        let key=(dictChild as AnyObject).object(forKey: "key")as! String
                        let value=(dictChild as AnyObject).object(forKey: "value")as! String
                        let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                        let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                        let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                        let childSQLl = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','personal','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                        // print(childSQLl)
                        let result = contactDB?.executeStatements(childSQLl)
                        if (result == nil)
                        {
                            //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                        }
                        else
                        {
                        }
                    }
                    //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                    var dictTemporaryDictionary2:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                    
                    for j in 0 ..< (dictTemporaryDictionary2.object(forKey: "businessMemberDetails")! as AnyObject).count
                    {
                        var dictTemporaryDictionary3:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                        let dictChild=(dictTemporaryDictionary3.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
                        let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                        let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                        let key=(dictChild as AnyObject).object(forKey: "key")as! String
                        let value=(dictChild as AnyObject).object(forKey: "value")as! String
                        let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                        let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                        let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                        
                        let childSQLNewww = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','Business','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                        
                        //print(childSQLNewww)
                        let result = contactDB?.executeStatements(childSQLNewww)
                        if (result == nil)
                        {
                            //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                        }
                        else
                        {
                            
                        }
                    }
                    //3. familyMemberDetails
                    var dictTemporaryDictionary5:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                    
                    print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
                    print(((dictTemporaryDictionary5.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject))
                    print("################################################")
                    for k in 0 ..< ((dictTemporaryDictionary5.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                    {
                        
                        var dictTemporaryDictionary6:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                        
                        let dictChild=((dictTemporaryDictionary6.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)
                        var dictTemporaryDictionary8:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                        
                        let isVisible=(dictTemporaryDictionary8.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
                        let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
                        let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
                        let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
                        let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
                        let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
                        let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
                        let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
                        let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
                        let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
                        
                        let familyMemberDetails = "INSERT INTO FamilyMemberDetail (profileId,isVisible,familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,particulars,bloodGroup,masterId) VALUES("+profileID+",'"+isVisible+"','"+familyMemberId+"','"+memberName+"','"+relationship+"','"+dob+"','"+emailID+"','"+anniversary+"','"+contactNo+"','"+particulars+"','"+bloodGroup+"','"+masterID+"')"
                        let result = contactDB?.executeStatements(familyMemberDetails)
                        if (result == nil)
                        {
                        }
                        else
                        {
                        }
                    }
                    //4.  AddressDetails
                    var dictTemporaryDictionary11:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                    
                    for l in 0 ..< ((dictTemporaryDictionary11.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
                    {
                        var dictTemporaryDictionary12:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                        let dictChild=((dictTemporaryDictionary12.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
                        
                        
                        var dictTemporaryDictionary13:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                        let isBusinessAddrVisible=(dictTemporaryDictionary13.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
                        
                        var dictTemporaryDictionary14:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                        let isResidanceAddrVisible=(dictTemporaryDictionary14.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
                        let address=(dictChild as AnyObject).object(forKey: "address")as! String
                        let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
                        let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
                        let city=(dictChild as AnyObject).object(forKey: "city")as! String
                        var country=(dictChild as AnyObject).object(forKey: "country")as! String
                        let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
                        let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
                        let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
                        //print(pincode)
                        
                        let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
                        
                        let state=(dictChild as AnyObject).object(forKey: "state")as! String
                        print("this is country from rajendra side 123123123")
                        print(country)
                        if(country.characters.count>2)
                        {
                            
                        }
                        else
                        {
                            country="India"
                        }
                        
                        let familyMemberDetails = "INSERT INTO AddressDetails (profileId,AddressprofileId,addressID,addressType,address,city,state,country,pincode,phoneNo,fax,isBusinessAddrVisible,isResidanceAddrVisible,masterId) VALUES("+profileID+",'"+AddressprofileId+"','"+addressID+"','"+addressType+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+phoneNo+"','"+fax+"','"+isBusinessAddrVisible+"','"+isResidanceAddrVisible+"','"+masterID+"')"
                        
                        let result = contactDB?.executeStatements(familyMemberDetails)
                        if (result == nil)
                        {
                            
                        }
                        else
                        {
                        }
                    }
                }
            }
        }
        else
        {
        }
        //        savesssfetchData()
        fetchData()
        
        contactDB?.close()
    }
    
    
    
    func functionForUpdateMemberWhenDataComingNotZipFile(_ dd:NSDictionary)
    {
        //var moduleID:String!=""
        // moduleID=varGetValueModuleID
        // print(moduleID)
        print(varGetValueModuleID)
        //       print(UserDefaults.standard.value(forKey: "session_GetGroupId")as! String)
        //        let GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        let GroupID=((UserDefaults.standard.string(forKey: "grpId")) as! String)
        //        let grp =  UserDefaults.standard.setValue(self.GetGroupID, forKey: "session_GetGroupId")
        var dictNewMemberListjsonResult:NSDictionary=NSDictionary()
        dictNewMemberListjsonResult=dd
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            //print("error opening database")
        }
        else
        {
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
        }
        if (contactDB?.open())!
        {
            for i in 0 ..< ((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).count
            {
                let dictMain=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                print(dictMain)
                let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
                let memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
                
                print(grpID)
                print(isAdmin)
                //                savesssfetchData()
                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
                let memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
                //familyPic
                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
                
                let insertSQLUpdate = "UPDATE ProfileMaster SET grpId='"+grpID+"' ,isAdmin='"+isAdmin+"',memberName='"+memberNames+"',memberEmail='"+memberEmail+"',memberMobile='"+memberMobile+"',memberCountry='"+memberCountry+"',profilePic='"+profilePic+"',familyPic='"+familyPic+"',isPersonalDetVisible='"+isPersonalDetVisible+"',isBussinessDetVisible='"+isBusinDetVisible+"',isFamilyDetVisible='"+isFamilDetailVisible+"' where masterId="+masterID+" and profileId='"+profileID+"'"
                print("Record \(i) Updating....")
                print("*************************")
                print("Updateing ProfileMaster Table")
                print(insertSQLUpdate)
                let result = contactDB?.executeStatements(insertSQLUpdate)
                if (result == nil)
                {
                    
                }
                
                let dictTemporaryDictionary17:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                for j in 0 ..< (dictTemporaryDictionary17.object(forKey: "personalMemberDetails")! as AnyObject).count
                {
                    let dictTemporaryDictionary21:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    
                    let dictChild=(dictTemporaryDictionary21.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
                    var value=(dictChild as AnyObject).object(forKey: "value")as! String
                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                    
                    value=(value as NSString).replacingOccurrences(of: "'", with: "`")
                    let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='personal' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and groupId='"+GroupID+"'"
                    print("Updateing PersonalBusinessMemberDetails Table")
                    print(childSQLUpdate)
                    
                    let result = contactDB?.executeStatements(childSQLUpdate)
                    print("Update result of PersonalBusinessMemberDetails \(result?.description)")
                    print("Update result of PersonalBusinessMemberDetails 1 \(result)")
                    
                    if (result == nil)
                    {
                        //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                    }
                    else
                    {
                        
                    }
                }
                //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                let dictTemporaryDictionary19:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                
                for j in 0 ..< (dictTemporaryDictionary19.object(forKey: "businessMemberDetails")! as AnyObject).count
                {
                    
                    let dictTemporaryDictionary231:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    
                    let dictChild=(dictTemporaryDictionary231.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
                    
                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
                    let value=(dictChild as AnyObject).object(forKey: "value")as! String
                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                    let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='Business',masterId='"+masterID+"' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and groupId='"+GroupID+"' "
                    print("Updateing PersonalBusinessMemberDetails-Business Table")
                    print(childSQLUpdate)
                    
                    let result = contactDB?.executeStatements(childSQLUpdate)
                    if (result == nil)
                    {
                    }
                    else
                    {
                        
                    }
                }
                //3. PersonalBusinessMemberDetails
                let dictTemporaryDictionarytre:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                
                let varGetCountFamilyMemberDetail:Int!=((dictTemporaryDictionarytre.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                
                if(varGetCountFamilyMemberDetail>0)
                {
                    let insertSQLDelete = "DELETE FROM  FamilyMemberDetail  where masterId="+masterID+""
                    let result = contactDB?.executeStatements(insertSQLDelete)
                    if (result == nil)
                    {
                        
                    }
                }
                let dictTemporaryDictionarynnneewww:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                
                for k in 0 ..< ((dictTemporaryDictionarynnneewww.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                {
                    
                    let dictTemporaryDictionarytttttt:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    
                    let dictChild=((dictTemporaryDictionarytttttt.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)
                    let dictTemporaryDictionaryttttttrde:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    let isVisible=(dictTemporaryDictionaryttttttrde.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
                    
                    let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
                    let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
                    let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
                    let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
                    let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
                    let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
                    let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
                    let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
                    let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
                    let familyMemberDetailsUpdate = "INSERT INTO FamilyMemberDetail (profileId,isVisible,familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,particulars,bloodGroup,masterId) VALUES("+profileID+",'"+isVisible+"','"+familyMemberId+"','"+memberName+"','"+relationship+"','"+dob+"','"+emailID+"','"+anniversary+"','"+contactNo+"','"+particulars+"','"+bloodGroup+"','"+masterID+"')"
                    print("Updateing FamilyMemberDetail Table")
                    print(familyMemberDetailsUpdate)
                    let resultinserts = contactDB?.executeStatements(familyMemberDetailsUpdate)
                    if (resultinserts == nil)
                    {
                        
                    }
                    else
                    {
                        
                    }
                }
                //4.  AddressDetails
                let dictTemporaryDictionarybbrreee:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                
                for l in 0 ..< ((dictTemporaryDictionarybbrreee.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
                {
                    let dictTemporaryDictionaryvgtr:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    
                    
                    let dictChild=((dictTemporaryDictionaryvgtr.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
                    
                    
                    let dictTemporaryDictionaryvgtrzxczx:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    let isBusinessAddrVisible=(dictTemporaryDictionaryvgtrzxczx.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
                    
                    let dictTemporaryDictionaryvgtrxcvxcv:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    let isResidanceAddrVisible=(dictTemporaryDictionaryvgtrxcvxcv.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
                    
                    let address=(dictChild as AnyObject).object(forKey: "address")as! String
                    let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
                    let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
                    let city=(dictChild as AnyObject).object(forKey: "city")as! String
                    var country=(dictChild as AnyObject).object(forKey: "country")as! String
                    let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
                    let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
                    let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
                    let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
                    let state=(dictChild as AnyObject).object(forKey: "state")as! String
                    
                    let insertSQLDelete = "DELETE FROM  AddressDetails  where addressID='"+addressID+"' "
                    let resultt = contactDB?.executeStatements(insertSQLDelete)
                    if (resultt == nil)
                    {
                        
                    }
                    print("this is country from rajendra side 9898989")
                    print(country)
                    if(country.characters.count>2)
                    {
                        
                    }
                    else
                    {
                        country="India"
                    }
                    // print(dictChild)
                    let familyMemberDetails = "INSERT INTO AddressDetails (profileId,AddressprofileId,addressID,addressType,address,city,state,country,pincode,phoneNo,fax,isBusinessAddrVisible,isResidanceAddrVisible,masterId) VALUES("+profileID+",'"+AddressprofileId+"','"+addressID+"','"+addressType+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+phoneNo+"','"+fax+"','"+isBusinessAddrVisible+"','"+isResidanceAddrVisible+"','"+masterID+"')"
                    
                    print("Updateing AddressDetails Table")
                    print(familyMemberDetails)
                    
                    let result = contactDB?.executeStatements(familyMemberDetails)
                    if (result == nil)
                    {
                        
                    }
                    else
                    {
                    }
                }
                print("Record \(i) Update Successfully")
            }
            
            
            print("***********UPDATE MEMBER SUCCESSFULLY**************")
            
        }
        else
        {
            
        }
        contactDB?.close()
    }
    
    func functionForGetAssistanceDetails()
    {
        let mobileNum = UserDefaults.standard.value(forKey: "session_Mobile_Number") as! String
        let completeURL = baseUrl+"Group/GetAssistanceGov"
        let parameterst = [
            "mobileNo": mobileNum //"9082347692",
        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            var dictResponseData:NSDictionary=NSDictionary()
            dictResponseData = response as! NSDictionary
            print(dictResponseData)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
                
                let status = (dictResponseData.value(forKey: "TBClubHistoryResult") as! NSDictionary).value(forKey: "status") as! String
                print(status)
                if(status=="0")
                {
                    UserDefaults.standard.setValue("ShowMonthlyReportModule", forKey: "ShowHideMonthlyReportModule")
                    print(UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule"))
                }
                else
                {
                    
                    UserDefaults.standard.setValue("HideMonthlyReportModule", forKey: "ShowHideMonthlyReportModule")
                    print(UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule"))
                }
                //fetchData()
                SVProgressHUD.dismiss()
            }
            
        })
    }
    
    func getAllGroupListOnline() {
        SVProgressHUD.show()
        var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        var varGetMobileNumber = UserDefaults.standard.value(forKey: "session_Mobile_Number")as! String
        var varGetCountryCode = UserDefaults.standard.value(forKey: "session_Country_Code")as! String
        var varGetLoginType = UserDefaults.standard.value(forKey: "session_Login_Type")as! String
        let url = baseUrl+"Group/GetAllGroupListSynconline"
        var parameterst: [String: String] =
        ["masterUID": mainMemberID!,
         "imeiNo": UIDevice.current.identifierForVendor!.uuidString,
         "loginType": varGetLoginType,
         "mobileNo": varGetMobileNumber,
         "countryCode": varGetCountryCode
        ]
            print("Club Online Dashboard parameterst:: \(parameterst)")
            print("Club Online Dashboard completeURL:: \(url)")
            
            //------------------------------------------------------
            Alamofire.request(url, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    
                    
                    if let value = response.result.value {
                        do {
                            // Attempt to decode the JSON data
                            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode(ListSyncOnline.self, from: jsonData)
                            self.listsyncOnlineResponse = decodedData
                            print("ListSyncOnline:--- \(decodedData)")
                            if self.listsyncOnlineResponse?.status == "0" {
                                self.listSyncOnline = decodedData.result
                                UserDefaults.standard.setValue(self.listSyncOnline?.groupList?.newGroupList?[0].grpProfileID, forKey: "grpProfileID")
                            } else if self.listsyncOnlineResponse?.status == "2" {
                                self.DELETEDashboard_BirthAnniEvent_table_New()
                                self.loaderClass.window = nil
                                UserDefaults.standard.removeObject(forKey: "updatedOn")
                                let alert=UIAlertController(title: self.headTitle, message:self.listsyncOnlineResponse?.message, preferredStyle: UIAlertController.Style.alert);
                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
                                    self.appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    self.appDelegate.setMobileViewAsRoot()
                                }));
                                self.present(alert, animated: true, completion: nil);
                            }
                            SVProgressHUD.dismiss()
                            DispatchQueue.main.async {
                                self.collView.reloadData()
                            }
                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    }
                case .failure(_): break
                }
            }
    }
}

class LoaderView: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLoaderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLoaderView()
    }
    
    private func setupLoaderView() {
        backgroundColor = UIColor(white: 0, alpha: 0.7)
        //        layer.cornerRadius = 10
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}


struct ListSyncOnline: Codable {
    let status, version, message: String?
    let result: Resultus?

    enum CodingKeys: String, CodingKey {
        case status, version, message
        case result = "Result"
    }
}

// MARK: - Result
struct Resultus: Codable {
    let groupList: GroupListus?
    let moduleList: ModuleList?

    enum CodingKeys: String, CodingKey {
        case groupList = "GroupList"
        case moduleList = "ModuleList"
    }
}

// MARK: - GroupList
struct GroupListus: Codable {
    let newGroupList: [NewGroupList]?

    enum CodingKeys: String, CodingKey {
        case newGroupList = "NewGroupList"
    }
}

// MARK: - NewGroupList
struct NewGroupList: Codable {
    let grpID, grpName: String?
    let grpImg: String?
    let grpProfileID, myCategory, isGrpAdmin: String?
    let isSubGrpAdmin: String?
    let expiryDate, expiryflag: String?

    enum CodingKeys: String, CodingKey {
        case grpID = "grpId"
        case grpName, grpImg
        case grpProfileID = "grpProfileId"
        case myCategory, isGrpAdmin
        case isSubGrpAdmin = "IsSubGrpAdmin"
        case expiryDate, expiryflag
    }
}

// MARK: - ModuleList
struct ModuleList: Codable {
    let newModuleList: [NewModuleList]?

    enum CodingKeys: String, CodingKey {
        case newModuleList = "NewModuleList"
    }
}

// MARK: - NewModuleList
struct NewModuleList: Codable {
    let groupModuleID, groupID, moduleID, moduleName: String?
    let moduleOrderNo: String?
    let moduleStaticRef: String?
    let image: String?
    let masterProfileID: String?
    let isCustomized: String?
    let flag: String?
    let linkURL: String?

    enum CodingKeys: String, CodingKey {
        case groupModuleID = "groupModuleId"
        case groupID = "groupId"
        case moduleID = "moduleId"
        case moduleName, moduleOrderNo, moduleStaticRef, image, masterProfileID, isCustomized, flag
        case linkURL = "link_url"
    }
}
