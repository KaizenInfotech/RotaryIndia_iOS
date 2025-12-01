////http://web.touchbase.in/Documents/documentsafe/Group457/ESIC_Limit_Notification13012017050358PM_(1)23012017044928PM.pdf//
////  Created by Umesh on 30/12/15.
//
//
//
////        var ClubID:String! = ""
////ClubID = UserDefaults.standard.value(forKey: "Session_Club_ID") as! String
////print(ClubID)
//
////UserDefaults.standard.setValue(ClubID, forKey: "Session_Club_ID")
//
//import CoreTelephony
//import SystemConfiguration
//import CoreTelephony
//import SVProgressHUD
//import UIKit
//import Alamofire
//import Foundation
//import SJSegmentedScrollView
//import SDWebImage
//import SVProgressHUD
//import SSZipArchive
//import WebKit
//// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
//// Consider refactoring the code to use the non-optional operators.
//fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
//    switch (lhs, rhs) {
//    case let (l?, r?):
//        return l < r
//    case (nil, _?):
//        return true
//    default:
//        return false
//    }
//}
//// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
//// Consider refactoring the code to use the non-optional operators.
//fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
//    switch (lhs, rhs) {
//    case let (l?, r?):
//        return l > r
//    default:
//        return rhs < lhs
//    }
//}
//
//enum RadioAccessTechnology: String {
//    case cdma = "CTRadioAccessTechnologyCDMA1x"
//    case edge = "CTRadioAccessTechnologyEdge"
//    case gprs = "CTRadioAccessTechnologyGPRS"
//    case hrpd = "CTRadioAccessTechnologyeHRPD"
//    case hsdpa = "CTRadioAccessTechnologyHSDPA"
//    case hsupa = "CTRadioAccessTechnologyHSUPA"
//    case lte = "CTRadioAccessTechnologyLTE"
//    case rev0 = "CTRadioAccessTechnologyCDMAEVDORev0"
//    case revA = "CTRadioAccessTechnologyCDMAEVDORevA"
//    case revB = "CTRadioAccessTechnologyCDMAEVDORevB"
//    case wcdma = "CTRadioAccessTechnologyWCDMA"
//    
//    var description: String {
//        switch self {
//        case .gprs, .edge, .cdma:
//            return "2G"
//        case .lte:
//            return "4G"
//        default:
//            return "3G"
//        }
//    }
//}
//
///*----------------------------------------------ROW------------------------------------------------------------------*/
//struct Section1 {
//    
//    var name: String!
//    var des: [String]!
//    var items: [String]!
//    var collapsed: Bool!
//    var imagePic: [String]!
//    var varLink:[String]!
//    
//    init(name: String, varLink: [String],des: [String], items: [String],imagePic: [String], collapsed: Bool = false) {
//        
//        self.name = name
//        self.varLink = varLink
//        self.des = des
//        self.items = items
//        self.collapsed = collapsed
//        self.imagePic = imagePic
//    }
//}
//var sections = [Section1]()
//
//class RootDashViewController: UIViewController, webServiceDelegate , XMLParserDelegate , UIPickerViewDelegate , UIPickerViewDataSource , UICollectionViewDataSource , UICollectionViewDelegate,UIScrollViewDelegate,WKNavigationDelegate,UICollectionViewDelegateFlowLayout
//{
//    var varCheckLoadingOrPicker:Int!=0
//    @IBOutlet weak var myCollectionView: UICollectionView!
//    @IBOutlet weak var imgFindAClub: UIImageView!
//    @IBOutlet weak var imgFindARotarian: UIImageView!
//    @IBOutlet weak var imgShowCase: UIImageView!
//  //  @IBOutlet weak var imgLibrary: UIImageView!
//    @IBOutlet weak var imgGrayIconROW: UIImageView!
//    @IBOutlet weak var lblUserName: UILabel!
//    var muarrayIsConatinCountOrNot:NSMutableArray=NSMutableArray()
//    @IBOutlet weak var btnMenu: UIButton!
//    @IBOutlet weak var lblDescForSlider: UILabel!
//    var varGetGroupId:String!=""
//    var groupList:NSMutableArray=NSMutableArray()
//    var replicaOf = String()
//    var muarrayRotaryBlogs:NSMutableArray=NSMutableArray()   //Rotary News Array
//    var muarrauRotaryNews:NSMutableArray=NSMutableArray()   //Rotary Blogs Array
//    var muarrayForBirthdayAnniversaryEvent:NSMutableArray=NSMutableArray()
//    var bannerListArr:NSArray=NSArray()
//    //MARK:- Curd Operation
//    let loaderClass  = WebserviceClass()
//    var selectedIndexForSilder:Int=0
//    var isGroupAdmin:String!=""
//    @IBOutlet weak var lblDescriptionForBirthAnni: UILabel!
//    @IBOutlet weak var lblDateEVENT: UILabel!
//    @IBOutlet weak var imgBAE: UIImageView!
//    @IBOutlet weak var viewPager: ViewPager!
//    @IBOutlet weak var lblClubDistrictName: UILabel!
//    @IBOutlet weak var lblBAEDesc: UILabel!
//    @IBOutlet weak var btnWatchLater: UIButton!
//    var varGetZipFileUrl:String!=""
//    var textOfbtm:NSString=""
//    fileprivate let cellIdentifier = "modulecollectionCell"
//    var menuTitles:NSMutableArray=NSMutableArray();
//    var unCatArray:NSArray=NSArray()
//    var allmoduleCAtArry:NSArray=NSArray()
//    var NallmoduleCAtArry:NSMutableArray!
//    var tbgrp:TBGroupResult=TBGroupResult()
//    var appDelegate : AppDelegate!
//    @IBOutlet var imageSplashScreenRoot: UIImageView!
//    @IBOutlet var buttonOpacity: UIButton!
//    var varGetUniqueIndex:Int!=0
//    var mudict:NSMutableDictionary=NSMutableDictionary()
//    var userProfileDict:NSMutableDictionary=NSMutableDictionary()
//    @IBOutlet var viewPopUp: UIView!
//    var personalmoduleCAtArry:NSArray=NSArray()
//    var socialmoduleCAtArry:NSArray=NSArray()
//    var businsmoduleCAtArry:NSArray=NSArray()
//    var arrarrNewGroupList :NSArray=NSArray()
//    var arrDeleteGroupList :NSArray=NSArray()
//    @IBOutlet var noResultLbl:UILabel!
//    let boundss = UIScreen.main.bounds
//    @IBOutlet var addGrpBTn:UIButton!
//    var tbrootgrp:TBGroupResult=TBGroupResult()
//    var muarrayEntityId:NSMutableArray=NSMutableArray()
//    var muarrayEntityTotalCount:NSMutableArray=NSMutableArray()
//    var varISPopVisisbleorNot:Int!=0
//    var pushCounter = 0
//    var refresher:UIRefreshControl!
//    var refreshControl: UIRefreshControl!
//    var varGetCount:String!=""
//    @IBOutlet weak var lblandhaveTodayBirthday: UILabel!
//    
//    
//    @IBOutlet weak var usermainprofilebtn: UIButton!
//    
//    @IBOutlet weak var lblNotifyCount: UIButton!
//    
//    @IBOutlet weak var myScrollView: UIScrollView!
//    
////    @IBOutlet weak var lblNotifyCount: UILabel!
//    @IBOutlet weak var labelFirstTimeSyncMessage: UILabel!
//    
//    @IBOutlet weak var buttonOpticity: UIButton!
//    @IBOutlet weak var pickerSelectSettingMyProfileAboutPicker: UIPickerView!
//    @IBOutlet weak var buttonDonOnPicker: UIButton!
//    @IBOutlet weak var viewForSettingPicker: UIView!
//    var mainArraySettingForPicker = NSArray()
//    var varGetPickerSelectValue:String! = ""
//    /*----------------------------------------------ROW------------------------------------------------------------------*/
//    
//    
//    var varGetTotalFilesCount:Int!=0
//    var varGetForLoopCounting:Int!=0
//    
//    var stringArrayStore=[String]()
//    
//    var stringGroupImages=[String]()
//    
//    var stringArrayTitle=[String]()
//    
//    var stringArrayRssFirstFielsDescription=[String]()
//    
//    var stringArrayRssSecondFielsDescription=[String]()
//    
//    var stringArrayTitleSecond=[String]()
//    
//    var GroupName:[String]!
//    
//    var varLinkNewsUpdate=[String]()
//    var varLinkBlogs=[String]()
//    var grpDetailPrevious = NSDictionary()
//    
//    var arrayGrpId:[String]!
//    var arrayGrpProfileid:[String]!
//    var arrayIsGrpAdmin:[String]!
//    var arrayMyCategory:[String]!
//    var arrayNotificationCount:[String]!
//    /*
//     grpId,grpProfileid,isGrpAdmin,myCategory,notificationCount
//     
//     */
//    
//    /**/
//    
//    var anArray:NSArray=NSArray()
//    
//    var isCategory:String! = ""
//    
//    
//    
//    var FirstBeginParsing :String! = ""
//    var SecondBeginParsingBlog :String! = ""
//    var parser = XMLParser()
//    var posts = NSMutableArray()
//    var elements = NSMutableDictionary()
//    var element = NSString()
//    var title1 = NSMutableString()
//    var date = NSMutableString()
//    var description11 = NSMutableString()
//    var link = NSMutableString()
//    var newsUpdateDict:NSMutableDictionary = NSMutableDictionary()
//    var moduleName:String! = ""
//    var muarrayFindARotarianList:NSMutableArray=NSMutableArray()
//    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
//    var isAdmin:String! = ""
//    var varGroupId:String! = ""
//    var varModuleId:String! = ""
//
//    
//    @IBOutlet weak var viewUpdateProfileOrNot: UIView!
//    @IBOutlet weak var buttonNoUpdateProfile: UIButton!
//    @IBOutlet weak var buttonYesUpdateProfile: UIButton!
//    @IBOutlet weak var addWebView: WKWebView!
//    @IBOutlet weak var addView: UIView!
//    @IBOutlet weak var btnRotaryWorld: UIButton!
//    @IBOutlet weak var btnRotaryIndia: UIButton!
//
//
//    //MARK:- viewdid load and view will appear
//    //--pull to refresh data on collection view
//    
//    @objc func refresh(_ sender:AnyObject) {
//        // Code to refresh table view
//        // refreshControl.endRefreshing()
//        self.refreshControl?.endRefreshing()
//        self.functionForFetchingNotificationCountList()
//        self.myCollectionView.reloadData()
//        self.refreshControl?.endRefreshing()
//        self.refreshControl?.isHidden=true
//    }
//    
//    var ituneDynamicUrlFromServer:String!=""
//    
//    func userProfileDetail(){
//        let userProfileUrl:String! = "http://rotaryindiaapi.rosteronwheels.com/api/Member/GetProfile"
//        
//        let para = ["MemberId":"376941"]
//        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: userProfileUrl, parameters: para, forTask: TaskType.kUserProfileDetailList, currentView: self.view, useAccessToken: false, completionHandler:  {(response: AnyObject) -> Void in
//            let dd = response as! NSDictionary
//            var varGetValueServerError = dd.object(forKey: "message")as? String
////            print(dd)
//            if(varGetValueServerError == "Error")
//            {
//                SVProgressHUD.dismiss()
//            }
//            else
//            {
//                if((((dd.object(forKey: "message")! as AnyObject) as! String) == "Success") && (((dd.object(forKey: "status")! as AnyObject) as! String) == "0"))
//                {
////                    var dictTemporaryDictionary:NSDictionary=((dd.value(forKey: "TBVersionResult")! as AnyObject).value(forKey: "Result")! as AnyObject).object(at: 0)
////                    self.ituneDynamicUrlFromServer=dictTemporaryDictionary.value(forKey: "URL")as! String
////                    var versionNumber:String!=dictTemporaryDictionary.value(forKey: "versionNumber")as! String
////                    self.getUpdateAppVersionPOPUP()
//                    
//                    
//                    self.userProfileDict = ((dd.value(forKey: "result")! as AnyObject).value(forKey: "Table")! as AnyObject).object(at: 0)
//                    print(self.userProfileDict)
//                }
//            }
//        })
//        
//    }
//    
//    
//    func getAppVersionDetails()
//    {
//        let completeURL:String! = baseUrl+"versionList/GetVersionList"
//        let parameterst = [
//            "Type":"IOS"
//        ]
//        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
//            let dd = response as! NSDictionary
//            var varGetValueServerError = dd.object(forKey: "serverError")as? String
//            if(varGetValueServerError == "Error")
//            {
//                SVProgressHUD.dismiss()
//            }
//            else
//            {
//                if(((dd.object(forKey: "TBVersionResult")! as AnyObject).object(forKey: "status") as! String == "0") && ((dd.object(forKey: "TBVersionResult")! as AnyObject).object(forKey: "message") as! String == "success"))
//                {
//                    var dictTemporaryDictionary:NSDictionary=((dd.value(forKey: "TBVersionResult")! as AnyObject).value(forKey: "Result")! as AnyObject).object(at: 0)
//                    self.ituneDynamicUrlFromServer=dictTemporaryDictionary.value(forKey: "URL")as! String
//                    var versionNumber:String!=dictTemporaryDictionary.value(forKey: "versionNumber")as! String
//                    self.getUpdateAppVersionPOPUP()
//                }
//            }
//        })
//    }
//    
//    @objc func getCountOfNotification()
//    {
//        lblNotifyCount.layer.cornerRadius = lblNotifyCount.frame.size.height/2
////      lblNotifyCount.layer.masksToBounds = true
//      let nModel:NotificaioModel=NotificaioModel()
//      nModel.deleteNotification(byMsgID: "", state: .Defaults)
//      nModel.getNotificationCount(byMsgID: "", state: "") { (result) in
//            print("Notification Count is here \(result)")
//            if result=="0"
//            {
//                self.lblNotifyCount.isHidden=true
//            }
//            else
//            {
//                self.lblNotifyCount.isHidden=false
////                self.lblNotifyCount.text = result
//                self.lblNotifyCount .setTitle(result, for: UIControl.State.normal)
//            }
//        }
//    }
//    
//    //1.Add new members
//    func functionForAddNewMembers(_ dictNewMemberListjsonResult:NSDictionary)
//    {
//       // print(dictNewMemberListjsonResult)
//        let moduleID = "1"
//        let GroupID=((UserDefaults.standard.string(forKey: "grpId")) as! String)
////        var moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
////        var GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
//        print(GroupID)
//        var databasePath : String
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil
//        {
//            print("Error: \(contactDB?.lastErrorMessage())")
//        }
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        if (contactDB?.open())!
//        {
//            contactDB?.beginTransaction()
//
//            for i in 0 ..< (dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).count
//            {
//              autoreleasepool {
//              // let  dict = arrdata[i] as! NSDictionary
//              let dictMain=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
//              let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
//                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
//                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
//                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
//                var memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
//                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
//                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
//                var memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
//                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
//                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
//
//                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
//                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
//                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
//                //print("Profile Master",i)
//
//                
//                
//                print(dictNewMemberListjsonResult)
//                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//
//                print("this is name by rajendra jat")
////                print(memberName)
////                print(dictNewMemberListjsonResult)
//                memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
//
//
//
//
////                print(dictMain)
////                print(profilePic)
////                print(familyPic)
//
//                if(memberCountry.characters.count>2)
//                {
//
//                }
//                else
//                {
//                    memberCountry="India"
//                }
//
//
//                let insertSQL = "INSERT INTO ProfileMaster (masterId,grpId,profileId,isAdmin,memberName,memberEmail,memberMobile,memberCountry,profilePic,familyPic,isPersonalDetVisible,isBussinessDetVisible,isFamilyDetVisible) VALUES('"+masterID+"','"+grpID+"','"+profileID+"','"+isAdmin+"','"+memberNames+"','"+memberEmail+"','"+memberMobile+"','"+memberCountry+"','"+profilePic+"','"+familyPic+"','"+isPersonalDetVisible+"','"+isBusinDetVisible+"','"+isFamilDetailVisible+"')"
//                print(insertSQL)
//                let result = contactDB?.executeStatements(insertSQL)
//                if (result == nil)
//                {
//                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                }
//                else
//                {
//                      var dihjkctTehjkmpochjkvxraryDicxcvtioxcvnary:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
//
//                    for j in 0 ..< (dihjkctTehjkmpochjkvxraryDicxcvtioxcvnary.object(forKey: "personalMemberDetails")! as AnyObject).count
//                    {
//                        let dictChild=(dihjkctTehjkmpochjkvxraryDicxcvtioxcvnary.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
//                        let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
//                        let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
//                        let key=(dictChild as AnyObject).object(forKey: "key")as! String
//                        var value=(dictChild as AnyObject).object(forKey: "value")as! String
//                        let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
//                        let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
//                        let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
//
//                        //print("PersonalBusinessMemberDetails Personal",j)
//                        value=(value as NSString).replacingOccurrences(of: "'", with: "`")
//
//
//
//                        let childSQLl = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','personal','"+masterID+"','"+moduleID+"','"+GroupID+"')"
//                        //   print(childSQLl)
//                        let result = contactDB?.executeStatements(childSQLl)
//                        if (result == nil)
//                        {
//                            print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                        }
//                        else
//                        {
//
//                        }
//                    }
//                    //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
//                    // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!./count)
//
//                      var didfgctdgTempdfgorarydfgDicdfgtionardfgyghdfg:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
//
//                    for j in 0 ..< (didfgctdgTempdfgorarydfgDicdfgtionardfgyghdfg.object(forKey: "businessMemberDetails")! as AnyObject).count
//                    {
//                        let dictChild=(didfgctdgTempdfgorarydfgDicdfgtionardfgyghdfg.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
//                        let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
//                        let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
//                        let key=(dictChild as AnyObject).object(forKey: "key")as! String
//                        let value=(dictChild as AnyObject).object(forKey: "value")as! String
//                        let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
//                        let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
//                        let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
//
//                        let childSQLNewww = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','Business','"+masterID+"','"+moduleID+"','"+GroupID+"')"
//                        // print(childSQLNewww)
//
//                        //print("PersonalBusinessMemberDetails Business",j)
//
//
//                        let result = contactDB?.executeStatements(childSQLNewww)
//                        if (result == nil)
//                        {
//                            print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                        }
//                        else
//                        {
//
//                        }
//                    }
//                    //3. PersonalBusinessMemberDetails
//                    // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("familyMembdfgerDetails")!.count)
//                    // for k in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(0).objectForKey("familyMemsdfgberDetails")!.count
//
//
//
//                      var dfdidctTemporaryDictionarybnvcxzvbnmcdsx:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
//
//
//
//                    for k in 0 ..< ((dfdidctTemporaryDictionarybnvcxzvbnmcdsx.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
//                    {
//                        let isVisible=(dfdidctTemporaryDictionarybnvcxzvbnmcdsx.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
//                        let dictChild=((dfdidctTemporaryDictionarybnvcxzvbnmcdsx.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)
//
//                        let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
//                        let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
//                        let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
//                        let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
//                        let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
//                        let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
//                        let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
//                        let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
//                        let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
//
//
//                        let familyMemberDetails = "INSERT INTO FamilyMemberDetail (profileId,isVisible,familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,particulars,bloodGroup,masterId) VALUES("+profileID+",'"+isVisible+"','"+familyMemberId+"','"+memberName+"','"+relationship+"','"+dob+"','"+emailID+"','"+anniversary+"','"+contactNo+"','"+particulars+"','"+bloodGroup+"','"+masterID+"')"
//
//                        let result = contactDB?.executeStatements(familyMemberDetails)
//                        if (result == nil)
//                        {
//                            print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                        }
//                        else
//                        {
//
//                        }
//                    }
//                    //4.  AddressDetails
//
//
//                      var hjdihjkctTemkhjporaryDictionacdzxdryhjk:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
//
//
//                    let dictChild=(hjdihjkctTemkhjporaryDictionacdzxdryhjk.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")
//
//                    print("my value:------ ")
//                    print(dictChild)
//
//   for l in 0 ..< ((hjdihjkctTemkhjporaryDictionacdzxdryhjk.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
//    {
//       let isBusinessAddrVisible=(hjdihjkctTemkhjporaryDictionacdzxdryhjk.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
//       let isResidanceAddrVisible=(hjdihjkctTemkhjporaryDictionacdzxdryhjk.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
//
//
//       var dictTemporaryDictionarydfdsdyttysfsdf:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
//
//     let dictChild=((dictTemporaryDictionarydfdsdyttysfsdf.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
//
//      let address=(dictChild as AnyObject).object(forKey: "address")as! String
//      let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
//      let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
//      let city=(dictChild as AnyObject).object(forKey: "city")as! String
//      var country=(dictChild as AnyObject).object(forKey: "country")as! String
//      let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
//      let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
//      let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
//      //print(pincode)
//      let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
//
//      let state=(dictChild as AnyObject).object(forKey: "state")as! String
//      // print(state)
//
//      print("this is country from rajendra side 88888")
//      print(country)
//
//      if(country.characters.count>2)
//      {
//
//      }
//      else
//      {
//         country="India"
//      }
//
//      print("This is value by rajenadra jat˙˙˙˙˙˙˙˙˙˙˙¬¬˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚")
//      print(country)
//      let familyMemberDetails = "INSERT INTO AddressDetails (profileId,AddressprofileId,addressID,addressType,address,city,state,country,pincode,phoneNo,fax,isBusinessAddrVisible,isResidanceAddrVisible,masterId) VALUES("+profileID+",'"+AddressprofileId+"','"+addressID+"','"+addressType+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+phoneNo+"','"+fax+"','"+isBusinessAddrVisible+"','"+isResidanceAddrVisible+"','"+masterID+"')"
//
//      //  print(familyMemberDetails)
//      //print("AddressDetails",l)
//
//      let result = contactDB?.executeStatements(familyMemberDetails)
//      if (result == nil)
//      {
//          print("ErrorAi: \(contactDB?.lastErrorMessage())")
//      }
//      else
//      {
//
//      }
//     }
//    }
//   }
//            }
//            contactDB?.commit()
//            contactDB?.close()
//        }
//        else
//        {
//            print("Error: \(contactDB?.lastErrorMessage())")
//        }
//
//        print(varGetForLoopCounting)
//        print(varGetTotalFilesCount)
//
//        if(varGetForLoopCounting==varGetTotalFilesCount)
//        {
//            fetchData()
//        }
//
//    }
//    
//    //2. Update member««««««««««««««««««««-----»»»»»»»»»»»»»»»»»»»»»
//    func functionForUpdateMembers(_ dictNewMemberListjsonResult:NSDictionary)
//    {
//        print(dictNewMemberListjsonResult)
////       print(UserDefaults.standard.value(forKey: "session_GetModuleId")as! String)
////        var moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
////        var GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
//        let moduleID = "1"
//        let GroupID=((UserDefaults.standard.string(forKey: "grpId")) as! String)
//        var databasePath : String
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            print("error opening database")
//        }
//        else
//        {
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil
//        {
//            print("Error: \(contactDB?.lastErrorMessage())")
//        }
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        if (contactDB?.open())!
//        {
//            contactDB?.beginTransaction()
//            print("11This is count of main start point of file:-----------")
//            print((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).count)
//            for i in 0 ..< (dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).count
//            {
//              
//                let dictMain=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
//                
//                
//                let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
//                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
//                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
//                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
//                let memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
//                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
//                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
//                var memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
//                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
//                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
//
//                
//                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
//                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
//                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
//                
//                
//                if(memberCountry.characters.count>2)
//                {
//                    
//                }
//                else
//                {
//                    memberCountry="India"
//                }
//                
//                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//                  memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
//                
//
//                print(profilePic)
//                 print(familyPic)
//                print(dictMain)
//                
//                let insertSQLUpdate = "UPDATE ProfileMaster SET grpId='"+grpID+"' ,isAdmin='"+isAdmin+"',memberName='"+memberNames+"',memberEmail='"+memberEmail+"',memberMobile='"+memberMobile+"',memberCountry='"+memberCountry+"',profilePic='"+profilePic+"',familyPic='"+familyPic+"',isPersonalDetVisible='"+isPersonalDetVisible+"',isBussinessDetVisible='"+isBusinDetVisible+"',isFamilyDetVisible='"+isFamilDetailVisible+"' where masterId="+masterID+" and profileId='"+profileID+"'"
//              print("user image !")
//                print(insertSQLUpdate)
//                
//                let result = contactDB?.executeStatements(insertSQLUpdate)
//                /*
//                    for j in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("personalMemberDetails")!.count
//                    {
//                        let dictChild=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("personalMemberDetails")!.objectAtIndex(j)
//                        let fieldID=dictChild.objectForKey("fieldID")as! String
//                        let uniquekey=dictChild.objectForKey("uniquekey")as! String
//                        let key=dictChild.objectForKey("key")as! String
//                        let value=dictChild.objectForKey("value")as! String
//                        let colType=dictChild.objectForKey("colType")as! String
//                        let isEditable=dictChild.objectForKey("isEditable")as! String
//                        let isVisible=dictChild.objectForKey("isVisible")as! String
//                        let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='personal',masterId='"+masterID+"' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"'and groupId='"+GroupID+"'"
//                    let result = contactDB?.executeStatements(childSQLUpdate)
//                    }
//                */
//                
//                /*££££££££££££££££££££££££‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹*/
//                
//                
//                  var diasdctTemaasdsdporarasdyDictionarysdsadsa:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
//                
//                for j in 0 ..< (diasdctTemaasdsdporarasdyDictionarysdsadsa.object(forKey: "personalMemberDetails")! as AnyObject).count
//                {
//                    let dictChild=(diasdctTemaasdsdporarasdyDictionarysdsadsa.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
//                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
//                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
//                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
//                    var value=(dictChild as AnyObject).object(forKey: "value")as! String
//                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
//                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
//                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
//                    value=(value as NSString).replacingOccurrences(of: "'", with: "`")
//                   
//                    /*
//                    let insertSQLDelete = "DELETE FROM  PersonalBusinessMemberDetails  where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"'and groupId='"+GroupID+"'"
//                    let result = contactDB?.executeStatements(insertSQLDelete)
//                    */
//                    
//                    
//                    
//                    
//                    
//                    let childSQLl = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','personal','"+masterID+"','"+moduleID+"','"+GroupID+"')"
//                    let resultT = contactDB?.executeStatements(childSQLl)
//                   
//                }
//                /*££££££££££££££££££££££££‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹*/
//               
//                  var asddasdicastTeasdmdporarydDictidaqwonarysdsasd:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
//                
//                for j in 0 ..< (asddasdicastTeasdmdporarydDictidaqwonarysdsasd.object(forKey: "businessMemberDetails")! as AnyObject).count
//                {
//                    let dictChild=(asddasdicastTeasdmdporarydDictidaqwonarysdsasd.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
//                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
//                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
//                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
//                    let value=(dictChild as AnyObject).object(forKey: "value")as! String
//                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
//                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
//                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
//                    
//                    /*
//                    let insertSQLDelete = "DELETE FROM  PersonalBusinessMemberDetails  where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"' and groupId='"+GroupID+"'"
//                    let result = contactDB?.executeStatements(insertSQLDelete)
//                    */
//                    
//                    
//                    
//                    let childSQLNewww = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','Business','"+masterID+"','"+moduleID+"','"+GroupID+"')"
//                    let resultT = contactDB?.executeStatements(childSQLNewww)
//                   
//                }
//                /*££££££££££££££££££££££££‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹*/
//
//                
//                
//                
//                
//                
//                    //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
//                /*
//                    for j in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!.count
//                    {
//                        
//                        let dictChild=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!.objectAtIndex(j)
//                        let fieldID=dictChild.objectForKey("fieldID")as! String
//                        let uniquekey=dictChild.objectForKey("uniquekey")as! String
//                        let key=dictChild.objectForKey("key")as! String
//                        let value=dictChild.objectForKey("value")as! String
//                        let colType=dictChild.objectForKey("colType")as! String
//                        let isEditable=dictChild.objectForKey("isEditable")as! String
//                        let isVisible=dictChild.objectForKey("isVisible")as! String
//                        
//                        
//                        let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='Business',masterId='"+masterID+"' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"' and groupId='"+GroupID+"'"
// 
//                        let result = contactDB?.executeStatements(childSQLUpdate)
//                        
//                    }
//                */
//                    //3. PersonalBusinessMemberDetails
//                 var dictTempsdforasdfryDictionaryfddsfsafdsfds:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
//                for k in 0 ..< ((dictTempsdforasdfryDictionaryfddsfsafdsfds.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
//                    {
//                        
//                        let isVisible=(dictTempsdforasdfryDictionaryfddsfsafdsfds.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
//                        let dictChild=((dictTempsdforasdfryDictionaryfddsfsafdsfds.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)
//                        
//                        let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
//                        let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
//                        let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
//                        let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
//                        let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
//                        let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
//                        let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
//                        let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
//                        let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
//                        
//                        let familyMemberDetailsUpdate = "UPDATE FamilyMemberDetail  SET isVisible='"+isVisible+"',memberName='"+memberName+"',relationship='"+relationship+"',dob='"+dob+"',emailID='"+emailID+"',anniversary='"+anniversary+"',contactNo='"+contactNo+"',particulars='"+particulars+"',bloodGroup='"+bloodGroup+"',masterId='"+masterID+"' WHERE familyMemberId='"+familyMemberId+"' and profileId='"+profileID+"'"
//
// let result = contactDB?.executeStatements(familyMemberDetailsUpdate)
//                      
//                    }
//                
//                    //4.  AddressDetails
//                
//                
//                var disdfctTesdfmposdfraryDictiodsdfdsnary:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
//                
//                
//                let dictChild=(disdfctTesdfmposdfraryDictiodsdfdsnary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")
//                for l in 0 ..< ((disdfctTesdfmposdfraryDictiodsdfdsnary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
//                {
//                    
//                    var dictsdadaasdTemertposdraryDictionary:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
//                    
//                    
//                    
//                    let isBusinessAddrVisible=(dictsdadaasdTemertposdraryDictionary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
//                    let isResidanceAddrVisible=(dictsdadaasdTemertposdraryDictionary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
//                    
//                    let dictChild=((dictsdadaasdTemertposdraryDictionary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
//                    
//                    let address=(dictChild as AnyObject).object(forKey: "address")as! String
//                    let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
//                    let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
//                    let city=(dictChild as AnyObject).object(forKey: "city")as! String
//                    var country=(dictChild as AnyObject).object(forKey: "country")as! String
//                    let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
//                    let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
//                    let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
//                    let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
//                    let state=(dictChild as AnyObject).object(forKey: "state")as! String
//                    
//                    
//                    print("this is country from rajendra side 666666")
//                    print(country)
//                    if(country.characters.count>2)
//                    {
//                        
//                    }
//                    else
//                    {
//                        country="India"
//                    }
//                    
//                        let addressDetailUpdate = "UPDATE AddressDetails  SET AddressprofileId='"+AddressprofileId+"',addressType='"+addressType+"',address='"+address+"',city='"+city+"',state='"+state+"',country='"+country+"',pincode='"+pincode+"',phoneNo='"+phoneNo+"',fax='"+fax+"',isBusinessAddrVisible='"+isBusinessAddrVisible+"',isResidanceAddrVisible='"+isResidanceAddrVisible+"',masterId='"+masterID+"' WHERE addressID='"+addressID+"' and profileId='"+profileID+"'"
//                        
//                       let result = contactDB?.executeStatements(addressDetailUpdate)
//                      
//                    }
//                    
//
//              
//            }
//
//        }
//        contactDB?.commit()
//        contactDB?.close()
//    }
//    //code for get new update delete record files and insert update and delete in table
//    func functionForGetNewUpdateDeleteMember()
//    {
//        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
//        //1.New members
//        let MyFilesPath = documentsPath.appendingPathComponent("/NewMembers")
//        do {
// let fileList = try FileManager.default.contentsOfDirectory(atPath: MyFilesPath)
// let count = fileList.count
// varGetTotalFilesCount=count
// print(fileList)
// print(count)
// for i in 0 ..< count
// {
// // print(fileList[i])
// if(fileList[i].hasPrefix("New"))
// {
//   
//   let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: MyFilesPath+"/"+fileList[i]))
//   do
//   {
//       let NewMemberListjsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
//       // if(fileList[i]=="New7.json")
//       //{
//        print(fileList[i])
//       //print(NewMemberListjsonResult)
//     print(NewMemberListjsonResult)
//       varGetForLoopCounting=i+1
//       /*------------§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§£££££££££££££££££££££££££££------------------------*/
//       let zipPath:String =  MyFilesPath+"/"+fileList[i]
//       let fileManager = FileManager.default
//       try fileManager.removeItem(atPath: zipPath)
//       self.functionForAddNewMembers(NewMemberListjsonResult)
//   }
//   catch
//   {
//   }
//            }
//          }
//        }
//        catch
//        {
//        }
//        //2.Update members
//        let MyFilesPath2 = documentsPath.appendingPathComponent("/UpdatedMembers")
//        do {
//            let fileList = try FileManager.default.contentsOfDirectory(atPath: MyFilesPath2)
//            let count = fileList.count
//            //print(fileList)
//            print(count)
//            for i in 0 ..< count
//            {
//                // print(fileList[i])
//                if(fileList[i].hasPrefix("Update"))
//                {
//                    let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: MyFilesPath2+"/"+fileList[i]))
//                    do
//                    {
//                        print(MyFilesPath2+"/"+fileList[i])
//                        let UpdateMemberListjsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
//                         print(UpdateMemberListjsonResult)
//                        // if(fileList[i]=="New7.json")
//                        //{
//                        //print("This is file name:----")
//                         print(fileList[i])
//                        //print(UpdateMemberListjsonResult)
//                        self.functionForUpdateMembers(UpdateMemberListjsonResult)
//
//                        let zipPath:String =  MyFilesPath2+"/"+fileList[i]
//                        
//                        //   print(zipPath)
//                        // if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
//                        //  {
//                        let fileManager = FileManager.default
//                        try fileManager.removeItem(atPath: zipPath)
//
//                        //}
//                    }
//                    catch
//                    {
//                    }
//                }
//            }
//        }
//        catch
//        {
//        }
//        //3.Delete members
//        let MyFilesPath3 = documentsPath.appendingPathComponent("/DeletedMembers")
//        do {
//            let fileList = try FileManager.default.contentsOfDirectory(atPath: MyFilesPath3)
//            let count = fileList.count
//            //print(fileList)
//            // print(count)
//            for i in 0 ..< count
//            {
//                //  print(fileList[i])
//                if(fileList[i].hasPrefix("Delete"))
//                {
//                    let letGetDeletedID = try NSString(contentsOf:URL(fileURLWithPath: (MyFilesPath3+"/"+fileList[i])), encoding: String.Encoding.utf8.rawValue)
//                    // print(letGetDeletedID)
//                    let letGetId=letGetDeletedID.components(separatedBy: ",")
//                    self.functionForDeleteMembers(letGetId)
//                    let zipPath:String =  MyFilesPath3+"/"+fileList[i]
//                    
//                    //   print(zipPath)
//                    // if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
//                    //  {
//                    let fileManager = FileManager.default
//                    try fileManager.removeItem(atPath: zipPath)
//                    
//
//                    
//                }
//            }
//        }
//        catch
//        {
//        }
//         fetchData()
//    }
//    //--download zip file and unZip it in local Directory
//    func functionForDownloadZipFile(_ stringZipFilePath:String)
//    {
//        ///-----------------------------------------------------ppppppppp---------------
//        let destinationn = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
//        
//        Alamofire.download(stringZipFilePath,method: .get,parameters: nil,encoding: JSONEncoding.default, headers: nil,to: destinationn).downloadProgress(closure: { (progress) in
//                //progress closure
//            }).response(completionHandler: { (DefaultDownloadResponse) in
//                //here you able to access the DefaultDownloadResponse
//                //---------------------------------------------------------------------------------------
//                //get zip file from document directory
//                let dirst = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as? [String]
//                // print(dirst)
//                if dirst != nil
//                {
//                    let dirt = dirst![0]
//                    do {
//                        let fileList = try FileManager.default.contentsOfDirectory(atPath: dirt)
//     // print(fileList)
//     for i in 00 ..< fileList.count
//     {
//         let file:String = "ABC"
//         var varValue=fileList[i]
//         //print(varValue)
//         if(varValue.hasSuffix(".zip"))
//         {
//             var varGetFilePAth:String=""
//             varGetFilePAth=fileList[i]
//             // print(varGetFilePAth)
//             //here need to unwip file
//             let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//             
//             print(documentsPath)
//             print(varGetFilePAth)
//             
//            /// let zipPath:String =  (string: documentsPath+"/"+varGetFilePAth) as! String ;
//             
//             let zipPath:String =  documentsPath+"/"+varGetFilePAth
//
//             print(zipPath)
//             
//             
//             
//             // print(zipPath)
//             if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first
//             {
//                 //below code zip to unzip
//                 let path:String = String(describing: NSURL(fileURLWithPath: dir).appendingPathComponent(""))
//                 // print(zipPath)
//                 // print(path)
//                 let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//                 SSZipArchive.unzipFile(atPath: String(zipPath), toDestination: String(documentsPath))
//                 //code for get unzip file insert update delete
//                 self.functionForGetNewUpdateDeleteMember()
//             }
//         }
//         else
//         {
//             //self.view.makeToast("Error occuring, While fetching data", duration: 3, position: CSToastPositionCenter)
//         }
//     }
// }
//        catch
//        {
//        }
//    }
//    else
//    {
//        self.view.makeToast("Error occuring, While fetching data", duration: 3, position: CSToastPositionCenter)
//    }
//    //
//    //-----------------------------------------------------------------------------------------
//                //result closure
//            })
//        //-------------------------------------------------------ppppppppp-----------------
//        
//        
////        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
////
////        Alamofire.download(.GET, stringZipFilePath, destination: destination)
////            .response { _, _, _, error in
////                if error != nil
////                {
////                    print("Failed with error: \(error)")
////                    let letGetResponse:String!=String(error)
////                    self.view.makeToast("Error occuring, While fetching data from server.", duration: 3, position: CSToastPositionCenter)
////                }
////                else
////                {
////                    //get zip file from document directory
////                    let dirst = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
////                    // print(dirst)
////                    if dirst != nil
////                    {
////                        let dirt = dirst![0]
////                        do {
////                            let fileList = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(dirt)
////                            // print(fileList)
////                            for i in 00 ..< fileList.count
////                            {
////                                let file:String = "ABC"
////                                var varValue=fileList[i]
////                                //print(varValue)
////                                if(varValue.hasSuffix(".zip"))
////                                {
////                                    var varGetFilePAth:String=""
////                                    varGetFilePAth=fileList[i]
////                                    // print(varGetFilePAth)
////                                    //here need to unwip file
////                                    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
////                                    let zipPath:String =  (string: documentsPath+"/"+varGetFilePAth);
////                                    // print(zipPath)
////                                    if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
////                                    {
////                                        //below code zip to unzip
////                                        let path:String = String(NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(""))
////                                        // print(zipPath)
////                                        // print(path)
////                                        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
////                                        WPZipArchive.unzipFileAtPath(String(zipPath), toDestination: String(documentsPath))
////                                        //code for get unzip file insert update delete
////
////
////
////
////                                        self.functionForGetNewUpdateDeleteMember()
////
////                                    }
////                                }
////                                else
////                                {
////                                    //self.view.makeToast("Error occuring, While fetching data", duration: 3, position: CSToastPositionCenter)
////
////                                }
////                            }
////
////
////
////                        }
////                        catch
////                        {
////                        }
////                    }
////                    else
////                    {
////                        self.view.makeToast("Error occuring, While fetching data", duration: 3, position: CSToastPositionCenter)
////                    }
////                    //
//             //   }
//       // }
//    }
//    
//    func functionForGetZipFilePath()
//    {
//        
//        
//        let grpID=((UserDefaults.standard.string(forKey: "grpId")) as! String)
//        //if any json file(New,Updated,Deleted) is remain to server then first server that
//        //code by Rajendra Jat for delete all zip files from document directory
//        SVProgressHUD.show()
//        functionForGetNewUpdateDeleteMember()
//        MainDashboardViewController().funcForRemoveZipFileFromDocumentDirectory()
//        print("™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™")
//        var updatedOn =  String ()
//        let defaults = UserDefaults.standard
//        let UpdatedefaultNew = String(format: "updatedOnDirectory%@",grpID)
//        var  testlet = defaults.value(forKey: UpdatedefaultNew) as! String?
//        if let str = defaults.value(forKey: UpdatedefaultNew) as! String?
//        {
//            updatedOn = str
//             //updatedOn = "1970-01-01 00:00:00"
//        }
//        else
//        {
//            updatedOn = "1970-01-01 00:00:00"
//            SVProgressHUD.show()
//        }
//        if(updatedOn == "1970-01-01 00:00:00")
//        {
////            self.buttonOpacityFirstTime.isHidden=false
////            self.labelFirstLoading.isHidden=false
//           // self.loaderClass.loaderViewMethod()
//        }
//        
//        
//        
//      //Refreshing data
////        if(varRefreshDatRunOneTime=="Second")
////        {
////         updatedOn = "1970-01-01 00:00:00"
////         SVProgressHUD.show()
////        }
////        else
////        {
////
////        }
//        
//     
//        //moduleId
//        var  completeURL:String!=""
//        if(isCategory=="2") //DPK
//        {
//            completeURL = baseUrl+touchBAse_GetDistrictListSync
//        }
//        else
//        {
//            completeURL = baseUrl+touchBase_GetMemberListSync
//        }
//        
//        let parameterst = [
//            k_API_DirectoryZipFile : grpID,
//            k_API_updatedOn : updatedOn
//        ] as [String : Any]
//        
//        print("Club Directory parameterst:: \(parameterst)")
//        print("Club Directory completeURL:: \(completeURL)")
//        
//        //------------------------------------------------------
//        Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
//switch response.result {
// case .success:
//     // var result = [String:String]()
//       SVProgressHUD.dismiss()
//     if let value = response.result.value {
//    let dic = response.result.value!
//    let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
//    let jsonString = String(data: jsonData!, encoding: .utf8)!
//    //print(jsonString)
//    //--
//    if(response==nil)
//    {
//        
//    }
//    else
//    {
//        let dd = response.result.value as! NSDictionary
//        print(dd)
//        var varGetValueServerError = dd.object(forKey: "serverError")as? String
//       if(varGetValueServerError == "Error")
//       {
//          self.loaderClass.window = nil
////          self.buttonOpacityFirstTime.isHidden=true
////          self.labelFirstLoading.isHidden=true
////          self.NoRecordLabel.isHidden=true
//          self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
//          SVProgressHUD.dismiss()
//       }
//       else
//       {
//          //print("//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*",dd)
//          ////code by  Rajendra Jat here need to update sesssion for last update date
//          //curDate
//          UserDefaults.standard.set(dd.object(forKey: "curDate")as! String, forKey: UpdatedefaultNew)
//          // print(NSUserDefaults.standardUserDefaults().setObject(dd.objectForKey("curDate")as! String, forKey: UpdatedefaultNew))
//          
//          // print(dd.objectForKey("curDate")as! String)
//          print(dd)
//          
//          if(dd.object(forKey: "status") as! String == "0" && dd.object(forKey: "zipFilePath") as! String != "")
//          {
//              // self.funcForRemoveZipFileFromDocumentDirectory()
//              
////              self.buttonOpacityFirstTime.isHidden=false
////              self.labelFirstLoading.isHidden=false
//              //self.loaderClass.loaderViewMethod()
//              
//              self.varGetZipFileUrl=dd.object(forKey: "zipFilePath") as! String
//              self.functionForDownloadZipFile( self.varGetZipFileUrl)
//          }
//          else
//          {
//              
//              
//              if(dd.object(forKey: "status") as! String == "1")
//              {
//                  self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
//                  SVProgressHUD.dismiss()
//              }
//              else
//              {
//
//                
//                
//                if(dd.object(forKey: "status") as! String == "2")
//                  {
//                      //self.view.makeToast("No new updates found", duration: 2, position: CSToastPositionCenter)
//                  }
//                  else
//                  {
//                      let UpdateMemberListjsonResult: NSDictionary = NSDictionary()
//                      var varGetNewMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")
//                      var varGetUpdatedMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")
//                      var varGetDeleteMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "DeletedMemberList") as! String
//                      
//                      print("------>")
//                      print(varGetUpdatedMemberList)
//                      print("<------ Deleted Memeber List::::")
//                                            
////                                            var alertController = UIAlertController()
////
////                                            alertController = UIAlertController(title: "", message: "Deleted members are \(varGetDeleteMemberList)", preferredStyle: .alert)
////                                            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil));
////                                            self.present(alertController, animated: true, completion: nil)
//         
//                      print(varGetDeleteMemberList)
//                      if(varGetDeleteMemberList.characters.count>0)
//                      {
//                          print(varGetDeleteMemberList)
//                        //  let profileIDs:[String]=varGetDeleteMemberList.split(separator: ",")
//                          self.functionForDeleteMembers([varGetDeleteMemberList])
//                      }
//                      
//                      /*555555555555555555555555555555555555555555555555555555555555555555555555555555555555*/
//                      if((varGetNewMemberList! as AnyObject).count>0)
//                      {
//                          self.functionForNewMemberWhenDataComingNotZipFile(dd)
//                          
//                      }
//                      /*555555555555555555555555555555555555555555555555555555555555555555555555555555555555*/
//                      
//                      /*6666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666*/
//                      if((varGetUpdatedMemberList! as AnyObject).count>0)
//                      {
//                          self.functionForUpdateMemberWhenDataComingNotZipFile(dd)
//                          
//                      }
//                      /*6666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666*/
//                  }
//                  
//              }
//          }
//          self.fetchData()
////          self.search.isEnabled=true
////          self.searchButton.isEnabled=true
//      }
//      SVProgressHUD.dismiss()
//                        }
//                    
//                    //----
//                }
//            case .failure(_): break
//            }
//        }
//        //----------------------------------------------------
//        
//        
//    
//        
//        
//       // ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
//            //=> Handle server response
//            
//     
//       // })
//            
//    }
//    var varGetValueModuleID:String=""
//    //added by shubhs
//    //MARK:- Zip file code foir Directory
//    func functionForUpdateMemberWhenDataComingNotZipFile(_ dd:NSDictionary)
//    {
//       //var moduleID:String!=""
//       // moduleID=varGetValueModuleID
//       // print(moduleID)
//        print(varGetValueModuleID)
////       print(UserDefaults.standard.value(forKey: "session_GetGroupId")as! String)
////        let GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
//        let GroupID=((UserDefaults.standard.string(forKey: "grpId")) as! String)
////        let grp =  UserDefaults.standard.setValue(self.GetGroupID, forKey: "session_GetGroupId")
//        var dictNewMemberListjsonResult:NSDictionary=NSDictionary()
//        dictNewMemberListjsonResult=dd
//        var databasePath : String
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            //print("error opening database")
//        }
//        else
//        {
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil
//        {
//        }
//        if (contactDB?.open())!
//        {
//            for i in 0 ..< ((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).count
//            {
//                let dictMain=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
//                print(dictMain)
//                let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
//                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
//                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
//                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
//                let memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
//                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
//                
//                print(grpID)
//                print(isAdmin)
////                savesssfetchData()
//                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
//                let memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
//                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
//                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
//                //familyPic
//                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
//                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
//                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
//                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//                memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
//                
//                let insertSQLUpdate = "UPDATE ProfileMaster SET grpId='"+grpID+"' ,isAdmin='"+isAdmin+"',memberName='"+memberNames+"',memberEmail='"+memberEmail+"',memberMobile='"+memberMobile+"',memberCountry='"+memberCountry+"',profilePic='"+profilePic+"',familyPic='"+familyPic+"',isPersonalDetVisible='"+isPersonalDetVisible+"',isBussinessDetVisible='"+isBusinDetVisible+"',isFamilyDetVisible='"+isFamilDetailVisible+"' where masterId="+masterID+" and profileId='"+profileID+"'"
//                print("Record \(i) Updating....")
//                print("*************************")
//                print("Updateing ProfileMaster Table")
//                print(insertSQLUpdate)
//                let result = contactDB?.executeStatements(insertSQLUpdate)
//                if (result == nil)
//                {
//                    
//                }
//
//                let dictTemporaryDictionary17:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
//                for j in 0 ..< (dictTemporaryDictionary17.object(forKey: "personalMemberDetails")! as AnyObject).count
//                {
//                    let dictTemporaryDictionary21:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
//                    
//                    let dictChild=(dictTemporaryDictionary21.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
//                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
//                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
//                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
//                    var value=(dictChild as AnyObject).object(forKey: "value")as! String
//                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
//                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
//                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
//                    
//                    value=(value as NSString).replacingOccurrences(of: "'", with: "`")
//                    let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='personal' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and groupId='"+GroupID+"'"
//                    print("Updateing PersonalBusinessMemberDetails Table")
//                    print(childSQLUpdate)
//
//                    let result = contactDB?.executeStatements(childSQLUpdate)
//                    print("Update result of PersonalBusinessMemberDetails \(result?.description)")
//                    print("Update result of PersonalBusinessMemberDetails 1 \(result)")
//                    
//                    if (result == nil)
//                    {
//                        //print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                    }
//                    else
//                    {
//                        
//                    }
//                }
//                //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
//                let dictTemporaryDictionary19:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
//                
//                for j in 0 ..< (dictTemporaryDictionary19.object(forKey: "businessMemberDetails")! as AnyObject).count
//                {
//                    
//                    let dictTemporaryDictionary231:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
//                    
//                    let dictChild=(dictTemporaryDictionary231.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
//                    
//                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
//                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
//                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
//                    let value=(dictChild as AnyObject).object(forKey: "value")as! String
//                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
//                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
//                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
//                    let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='Business',masterId='"+masterID+"' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and groupId='"+GroupID+"' "
//                    print("Updateing PersonalBusinessMemberDetails-Business Table")
//                    print(childSQLUpdate)
//
//                    let result = contactDB?.executeStatements(childSQLUpdate)
//                    if (result == nil)
//                    {
//                    }
//                    else
//                    {
//                        
//                    }
//                }
//                //3. PersonalBusinessMemberDetails
//                let dictTemporaryDictionarytre:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
//                
//                let varGetCountFamilyMemberDetail:Int!=((dictTemporaryDictionarytre.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
//                
//                if(varGetCountFamilyMemberDetail>0)
//                {
//                    let insertSQLDelete = "DELETE FROM  FamilyMemberDetail  where masterId="+masterID+""
//                    let result = contactDB?.executeStatements(insertSQLDelete)
//                    if (result == nil)
//                    {
//                        
//                    }
//                }
//                let dictTemporaryDictionarynnneewww:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
//                
//                for k in 0 ..< ((dictTemporaryDictionarynnneewww.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
//                {
//                    
//                    let dictTemporaryDictionarytttttt:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
//                    
//                    let dictChild=((dictTemporaryDictionarytttttt.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)
//                    let dictTemporaryDictionaryttttttrde:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
//                    let isVisible=(dictTemporaryDictionaryttttttrde.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
//                    
//                    let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
//                    let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
//                    let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
//                    let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
//                    let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
//                    let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
//                    let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
//                    let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
//                    let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
//                    let familyMemberDetailsUpdate = "INSERT INTO FamilyMemberDetail (profileId,isVisible,familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,particulars,bloodGroup,masterId) VALUES("+profileID+",'"+isVisible+"','"+familyMemberId+"','"+memberName+"','"+relationship+"','"+dob+"','"+emailID+"','"+anniversary+"','"+contactNo+"','"+particulars+"','"+bloodGroup+"','"+masterID+"')"
//                    print("Updateing FamilyMemberDetail Table")
//                    print(familyMemberDetailsUpdate)
//                    let resultinserts = contactDB?.executeStatements(familyMemberDetailsUpdate)
//                    if (resultinserts == nil)
//                    {
//                        
//                    }
//                    else
//                    {
//                        
//                    }
//                }
//                //4.  AddressDetails
//                let dictTemporaryDictionarybbrreee:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
//                
//                for l in 0 ..< ((dictTemporaryDictionarybbrreee.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
//                {
//                    let dictTemporaryDictionaryvgtr:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
//                    
//                    
//                    let dictChild=((dictTemporaryDictionaryvgtr.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
//                    
//                    
//                    let dictTemporaryDictionaryvgtrzxczx:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
//                    let isBusinessAddrVisible=(dictTemporaryDictionaryvgtrzxczx.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
//                    
//                    let dictTemporaryDictionaryvgtrxcvxcv:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
//                    let isResidanceAddrVisible=(dictTemporaryDictionaryvgtrxcvxcv.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
//                    
//                    let address=(dictChild as AnyObject).object(forKey: "address")as! String
//                    let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
//                    let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
//                    let city=(dictChild as AnyObject).object(forKey: "city")as! String
//                    var country=(dictChild as AnyObject).object(forKey: "country")as! String
//                    let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
//                    let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
//                    let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
//                    let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
//                    let state=(dictChild as AnyObject).object(forKey: "state")as! String
//                    
//                    let insertSQLDelete = "DELETE FROM  AddressDetails  where addressID='"+addressID+"' "
//                    let resultt = contactDB?.executeStatements(insertSQLDelete)
//                    if (resultt == nil)
//                    {
//                        
//                    }
//                    print("this is country from rajendra side 9898989")
//                    print(country)
//                    if(country.characters.count>2)
//                    {
//                        
//                    }
//                    else
//                    {
//                        country="India"
//                    }
//                    // print(dictChild)
//                    let familyMemberDetails = "INSERT INTO AddressDetails (profileId,AddressprofileId,addressID,addressType,address,city,state,country,pincode,phoneNo,fax,isBusinessAddrVisible,isResidanceAddrVisible,masterId) VALUES("+profileID+",'"+AddressprofileId+"','"+addressID+"','"+addressType+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+phoneNo+"','"+fax+"','"+isBusinessAddrVisible+"','"+isResidanceAddrVisible+"','"+masterID+"')"
//                    
//                    print("Updateing AddressDetails Table")
//                    print(familyMemberDetails)
//
//                    let result = contactDB?.executeStatements(familyMemberDetails)
//                    if (result == nil)
//                    {
//                        
//                    }
//                    else
//                    {
//                    }
//                }
//                print("Record \(i) Update Successfully")
//            }
//            
//            
//            print("***********UPDATE MEMBER SUCCESSFULLY**************")
//            
//        }
//        else
//        {
//            
//        }
//        contactDB?.close()
//    }
//    func functionForNewMemberWhenDataComingNotZipFile(_ dd:NSDictionary)
//    {
//        var dictNewMemberListjsonResult:NSDictionary=NSDictionary()
//        dictNewMemberListjsonResult=dd
//        var databasePath : String
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            
//        }
//        else
//        {
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil
//        {
//            
//        }
//        let moduleID = "1"
////        let moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
//        let GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        if (contactDB?.open())!
//        {
//            ((dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).count
//            
//            // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.count)
//            for i in 0 ..< ((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).count
//            {
//                
//                let dictMain=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
//                
//                let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
//                
//                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
//                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
//                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
//                let memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
//                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
//                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
//                let memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
//                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
//                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
//                
//                
//                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
//                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
//                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
//                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//                
//                memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
//                let insertSQL = "INSERT INTO ProfileMaster (masterId,grpId,profileId,isAdmin,memberName,memberEmail,memberMobile,memberCountry,profilePic,familyPic,isPersonalDetVisible,isBussinessDetVisible,isFamilyDetVisible) VALUES('"+masterID+"','"+grpID+"','"+profileID+"','"+isAdmin+"','"+memberNames+"','"+memberEmail+"','"+memberMobile+"','"+memberCountry+"','"+profilePic+"','"+familyPic+"','"+isPersonalDetVisible+"','"+isBusinDetVisible+"','"+isFamilDetailVisible+"')"
//                print("INSERTING NEW MEMBER")
//                print(insertSQL)
//                let result = contactDB?.executeStatements(insertSQL)
//                print("Result after inserting new members \(result)")
//                if (result == nil)
//                {
//                    
//                }
//                else
//                {
//                    
//                    var dictTemporaryDictionary:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
//                    for j in 0 ..< (dictTemporaryDictionary.object(forKey: "personalMemberDetails")! as AnyObject).count
//                        
//                    {
//                        var dictTemporaryDictionaryNew:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
//                        let dictChild=(dictTemporaryDictionaryNew.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
//                        //print(dictChild)
//                        let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
//                        let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
//                        let key=(dictChild as AnyObject).object(forKey: "key")as! String
//                        let value=(dictChild as AnyObject).object(forKey: "value")as! String
//                        let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
//                        let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
//                        let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
//                        let childSQLl = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','personal','"+masterID+"','"+moduleID+"','"+GroupID+"')"
//                        // print(childSQLl)
//                        let result = contactDB?.executeStatements(childSQLl)
//                        if (result == nil)
//                        {
//                            //print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                        }
//                        else
//                        {
//                        }
//                    }
//                    //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
//                    var dictTemporaryDictionary2:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
//                    
//                    for j in 0 ..< (dictTemporaryDictionary2.object(forKey: "businessMemberDetails")! as AnyObject).count
//                    {
//                        var dictTemporaryDictionary3:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
//                        let dictChild=(dictTemporaryDictionary3.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
//                        let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
//                        let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
//                        let key=(dictChild as AnyObject).object(forKey: "key")as! String
//                        let value=(dictChild as AnyObject).object(forKey: "value")as! String
//                        let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
//                        let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
//                        let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
//                        
//                        let childSQLNewww = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','Business','"+masterID+"','"+moduleID+"','"+GroupID+"')"
//                        
//                        //print(childSQLNewww)
//                        let result = contactDB?.executeStatements(childSQLNewww)
//                        if (result == nil)
//                        {
//                            //print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                        }
//                        else
//                        {
//                            
//                        }
//                    }
//                    //3. familyMemberDetails
//                    var dictTemporaryDictionary5:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
//                    
//                    print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
//                    print(((dictTemporaryDictionary5.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject))
//                    print("################################################")
//                    for k in 0 ..< ((dictTemporaryDictionary5.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
//                    {
//                        
//                        var dictTemporaryDictionary6:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
//                        
//                        let dictChild=((dictTemporaryDictionary6.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)
//                        var dictTemporaryDictionary8:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
//                        
//                        let isVisible=(dictTemporaryDictionary8.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
//                        let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
//                        let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
//                        let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
//                        let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
//                        let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
//                        let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
//                        let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
//                        let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
//                        let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
//                                                
//                        let familyMemberDetails = "INSERT INTO FamilyMemberDetail (profileId,isVisible,familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,particulars,bloodGroup,masterId) VALUES("+profileID+",'"+isVisible+"','"+familyMemberId+"','"+memberName+"','"+relationship+"','"+dob+"','"+emailID+"','"+anniversary+"','"+contactNo+"','"+particulars+"','"+bloodGroup+"','"+masterID+"')"
//                        let result = contactDB?.executeStatements(familyMemberDetails)
//                        if (result == nil)
//                        {
//                        }
//                        else
//                        {
//                        }
//                    }
//                    //4.  AddressDetails
//                    var dictTemporaryDictionary11:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
//                    
//                    for l in 0 ..< ((dictTemporaryDictionary11.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
//                    {
//                        var dictTemporaryDictionary12:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
//                        let dictChild=((dictTemporaryDictionary12.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
//                        
//                        
//                        var dictTemporaryDictionary13:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
//                        let isBusinessAddrVisible=(dictTemporaryDictionary13.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
//                        
//                        var dictTemporaryDictionary14:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
//                        let isResidanceAddrVisible=(dictTemporaryDictionary14.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
//                        let address=(dictChild as AnyObject).object(forKey: "address")as! String
//                        let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
//                        let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
//                        let city=(dictChild as AnyObject).object(forKey: "city")as! String
//                        var country=(dictChild as AnyObject).object(forKey: "country")as! String
//                        let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
//                        let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
//                        let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
//                        //print(pincode)
//                        
//                        let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
//                        
//                        let state=(dictChild as AnyObject).object(forKey: "state")as! String
//                        print("this is country from rajendra side 123123123")
//                        print(country)
//                        if(country.characters.count>2)
//                        {
//                            
//                        }
//                        else
//                        {
//                            country="India"
//                        }
//                        
//                        let familyMemberDetails = "INSERT INTO AddressDetails (profileId,AddressprofileId,addressID,addressType,address,city,state,country,pincode,phoneNo,fax,isBusinessAddrVisible,isResidanceAddrVisible,masterId) VALUES("+profileID+",'"+AddressprofileId+"','"+addressID+"','"+addressType+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+phoneNo+"','"+fax+"','"+isBusinessAddrVisible+"','"+isResidanceAddrVisible+"','"+masterID+"')"
//                        
//                        let result = contactDB?.executeStatements(familyMemberDetails)
//                        if (result == nil)
//                        {
//                            
//                        }
//                        else
//                        {
//                        }
//                    }
//                }
//            }
//        }
//        else
//        {
//        }
////        savesssfetchData()
//        fetchData()
//        
//        contactDB?.close()
//    }
//    func functionForDeleteMembers(_ muaarayDeleteMemberListjsonResult:[String])
//    {
//        // print(muaarayDeleteMemberListjsonResult)
//        var databasePath : String
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            //print("error opening database")
//        }
//        else
//        {
//            // self.Createtablecity()
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil
//        {
//            //print("Error: \(contactDB.lastErrorMessage())")
//        }
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        if (contactDB?.open())!
//        {
//            contactDB?.beginTransaction()
//            print("-------------Deleted---Queries----------------")
//            for i in 0 ..< muaarayDeleteMemberListjsonResult.count
//            {
//                let insertSQLDelete = "DELETE FROM  ProfileMaster  where profileId in ("+muaarayDeleteMemberListjsonResult[i]+")"
//                print(insertSQLDelete)
//                let result = contactDB?.executeStatements(insertSQLDelete)
//                if (result == nil)
//                {
//                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                }
//            }
//            //1......if master table entry inserted then need to data in PersonalBusinessMemberDetails
//            for j in 0 ..< muaarayDeleteMemberListjsonResult.count
//            {
//                let childSQLDelete = "DELETE FROM PersonalBusinessMemberDetails where profileId in ("+muaarayDeleteMemberListjsonResult[j]+") and PersonalORBusiness='personal'"
//                  print(childSQLDelete)
//                let result = contactDB?.executeStatements(childSQLDelete)
//                if (result == nil)
//                {
//                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                }
//                else
//                {
//                    
//                }
//            }
//            //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
//            for j in 0 ..< muaarayDeleteMemberListjsonResult.count
//            {
//                let childSQLDelete = "DELETE FROM  PersonalBusinessMemberDetails where profileId in ("+muaarayDeleteMemberListjsonResult[j]+") and PersonalORBusiness='Business'"
//                print(childSQLDelete)
//                let result = contactDB?.executeStatements(childSQLDelete)
//                if (result == nil)
//                {
//                }
//                else
//                {
//                }
//            }
//            //3. PersonalBusinessMemberDetails
//            for k in 0 ..< muaarayDeleteMemberListjsonResult.count
//            {
//                let familyMemberDetailsDelete = "DELETE FROM  FamilyMemberDetail  where profileId in ("+muaarayDeleteMemberListjsonResult[k]+")"
//                print(familyMemberDetailsDelete)
//                let result = contactDB?.executeStatements(familyMemberDetailsDelete)
//                if (result == nil)
//                {
//                }
//                else
//                {
//                }
//            }
//            //4.  AddressDetails
//            for l in 0 ..< muaarayDeleteMemberListjsonResult.count
//            {
//                let addressDetailDelete = "DELETE FROM  AddressDetails  where profileId in ("+muaarayDeleteMemberListjsonResult[l]+")"
//                print(addressDetailDelete)
//                let result = contactDB?.executeStatements(addressDetailDelete)
//                if (result == nil)
//                {
//                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                }
//                else
//                {
//                }
//            }
//        }
//        else
//        {
//        }
//        contactDB?.commit()
//        contactDB?.close()
//    }
//    
//    
//    func functionForGetAssistanceDetails()
//    {
//        let mobileNum = UserDefaults.standard.value(forKey: "session_Mobile_Number") as! String
//        let completeURL = baseUrl+"Group/GetAssistanceGov"
//        let parameterst = [
//            "mobileNo": mobileNum //"9082347692",
//        ]
//        print(parameterst)
//        print(completeURL)
//        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
//            //=> Handle server response
//            var dictResponseData:NSDictionary=NSDictionary()
//            dictResponseData = response as! NSDictionary
//             print(dictResponseData)
//            var varGetValueServerError = response.object(forKey: "serverError")as? String
//            if(varGetValueServerError == "Error")
//            {
//                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
//                SVProgressHUD.dismiss()
//            }
//            else
//            {
//                
//                let status = (dictResponseData.value(forKey: "TBClubHistoryResult") as! NSDictionary).value(forKey: "status") as! String
//                print(status)
//                if(status=="0")
//                {
//                    UserDefaults.standard.setValue("ShowMonthlyReportModule", forKey: "ShowHideMonthlyReportModule")
//                    print(UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule"))
//                }
//                else
//                {
//                    
//                    UserDefaults.standard.setValue("HideMonthlyReportModule", forKey: "ShowHideMonthlyReportModule")
//                    print(UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule"))
//                }
//                //fetchData()
//                SVProgressHUD.dismiss()
//            }
//           
//        })
//    }
//    
//    
//    
//    
////    func fetchData()
////    {
////        var databasePath : String
////        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
////        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
////        // open database
////        databasePath = fileURL.path
////        var db: OpaquePointer? = nil
////        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
////        {
////            //print("error opening database")
////        }
////        else
////        {
////            // self.Createtablecity()
////        }
////        let contactDB = FMDatabase(path: databasePath as String)
////        if contactDB == nil {
////            //print("Error: \(contactDB.lastErrorMessage())")
////        }
////        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
////        if (contactDB?.open())! {
////
////            let querySQL = "SELECT distinct * FROM MODULE_DATA_MASTER where groupId = '\(grpDetailPrevious.object(forKey: "grpId") as! String)' order  by moduleOrderNo asc"
////            print("Main Dashboard querySQL \(querySQL)")
////            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
////            allmoduleCAtArry=NSMutableArray()
////            let muarrayTemp:NSMutableArray=NSMutableArray()
////            var isGroupAdmin = UserDefaults.standard.object(forKey: "isAdmin") as! String
////            var modulenamescheck:String!=""
////            while results?.next() == true {
////                print((results?.string(forColumn: "groupId"))! as String)
////                let dd = NSMutableDictionary ()
////                dd.setValue((results?.string(forColumn: "groupId"))! as String, forKey:"groupId")
////                dd.setValue((results?.string(forColumn: "groupModuleId"))! as String, forKey:"groupModuleId")
////                dd.setValue((results?.string(forColumn: "image"))! as String, forKey:"image")
////                //dd.setValue((results?.stringForColumn("masterProfileID"))! as String, forKey:"masterProfileID")
////                dd.setValue((results?.string(forColumn: "moduleId"))! as String, forKey:"moduleId")
////                dd.setValue((results?.string(forColumn: "moduleName"))! as String, forKey:"moduleName")
////                dd.setValue((results?.string(forColumn: "moduleStaticRef"))! as String, forKey:"moduleStaticRef")
////                dd.setValue((results?.string(forColumn: "moduleOrderNo"))! as String, forKey:"moduleOrderNo")
////                dd.setValue((results?.string(forColumn: "notificationCount"))! as String, forKey:"notificationCount")
////
////                print("<<<<<<<<<<-----This is group admin or not ----->>>>>>>>>>>>>")
////                print(isGroupAdmin)
////                print((results?.string(forColumn: "moduleName"))! as String)
////
////                var modulename:String! = (results?.string(forColumn: "moduleName"))! as String
////                if(isGroupAdmin=="No" && modulename == "Attendance")
////                {
////
////                }
////                else
////                {
////                    if((results?.string(forColumn: "moduleName"))! as String=="Sub groups")
////                    {
////                    }
////                    else if((results?.string(forColumn: "moduleName"))! as String=="Club Monthly Report" || (results?.string(forColumn: "moduleName"))! as String=="Category" || (results?.string(forColumn: "moduleName"))! as String=="TRF Contribution")
////                    {
////                        if(isCategory=="1")
////                        {
////                        }
////                        else
////                        {
////                            if(isGroupAdmin=="Yes")
////                            {
////                                print("modulenamescheck \(modulenamescheck)")
////                                if(modulename != modulenamescheck)
////                                {
////                                    allmoduleCAtArry.add(dd)
////                                }
////                            }
////                            else
////                            {
////                                if(UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! Any == nil)
////                                {
////                                    print("aaaaaaaaaaaaaaaaaaaaaaaa")
////                                }
////                                else
////                                {
////                                   if let GetAssistanceGover:String = UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as? String
////                                   {
////                                    //print("Club Monthly Report":-----")
////                                    if (( GetAssistanceGover == "HideMonthlyReportModule"))
////                                    {
////                                        print("889898989898989898989898989898989898989898",UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! String)
////                                    }
////                                    else
////                                    {
////                                        print("modulenamescheck11: \(modulenamescheck)")
////                                        if(modulename != modulenamescheck)
////                                        {
////                                            allmoduleCAtArry.add(dd)
////                                        }
////                                        print("111111111111111111111111111111111111111",UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! String)
////                                    }
////                                }
////                            }
////                         }
////                      }
////                    }
////                    else
////                    {
////                         print("modulenamescheck 22 :\(modulenamescheck)")
////                        var getAdmin:String!=(results?.string(forColumn: "moduleName")) as! String
////                       if((results?.string(forColumn: "moduleName"))! as String=="Admin" && isGroupAdmin=="Yes" && isCategory=="1")
////                        {
////                                allmoduleCAtArry.add(dd)
////                        }
////                       else if(modulename != modulenamescheck)
////                        {
////                            if(getAdmin == "Admin")
////                            {
////
////                            }
////                            else
////                            {
////                                 print("modulenamescheck 33 :\(modulenamescheck)")
////                                if(modulename != modulenamescheck)
////                                {
////                                 allmoduleCAtArry.add(dd)
////                                }
////                            }
////                        }
////                    }
////                     print("modulenamescheck 44 :\(modulenamescheck)")
////                    if(modulename != modulenamescheck)
////                    {
////                        muarrayTemp.add((results?.string(forColumn: "groupId"))! as String)
////                        collectionView.reloadData()
////                    }
////                }
////                modulenamescheck = (results?.string(forColumn: "moduleName"))! as String
////            }
////            print(muarrayIsConatinCountOrNot)
////            print(muarrayTemp)
////        }
////        print("All module list \(allmoduleCAtArry)")
////    }
//    
//    
//    
//    func savesssfetchData()
//    {
//        var databasePath : String
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        print(grpDetailPrevious)
//        
//        var dict:NSDictionary!
//        dict = menuTitles[0] as! NSDictionary
//        print(dict)
////        let varGetId=(dict.object(forKey: "grpId") as! String)
////        print(varGetId)
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            //print("error opening database")
//        }
//        else
//        {
//            // self.Createtablecity()
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil {
//            //print("Error: \(contactDB.lastErrorMessage())")
//        }
//        print((UserDefaults.standard.string(forKey: "grpId")))
//        
//        if (contactDB?.open())! {
//            let grpIddd=((UserDefaults.standard.string(forKey: "grpId")) as! String)
//            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
////            Main Dashboard querySQL SELECT distinct * FROM MODULE_DATA_MASTER where groupId = '2765' order  by moduleOrderNo asc
////            (UserDefaults.standard.string(forKey: "grpId"))
//            
////            let querySQL = "SELECT distinct * FROM MODULE_DATA_MASTER where groupId = '\(grpDetailPrevious.object(forKey: "grpId") as! String)' order  by moduleOrderNo asc"
//            let querySQL = "SELECT distinct * FROM MODULE_DATA_MASTER where groupId = '\(grpIddd)' AND masterUID = '\(mainMemberID ?? "")' order  by moduleOrderNo asc"
//            print("Main Dashboard querySQL \(querySQL)")
//            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
//            allmoduleCAtArry=NSMutableArray()
//            let muarrayTemp:NSMutableArray=NSMutableArray()
////            var isGroupAdmin = UserDefaults.standard.object(forKey: "isAdmin") as! String
//            var isGroupAdmin = "Yes"
//            var modulenamescheck:String!=""
//            while results?.next() == true {
//                print((results?.string(forColumn: "groupId"))! as String)
//                let dd = NSMutableDictionary ()
//                dd.setValue((results?.string(forColumn: "groupId"))! as String, forKey:"groupId")
//                dd.setValue((results?.string(forColumn: "groupModuleId"))! as String, forKey:"groupModuleId")
//                dd.setValue((results?.string(forColumn: "image"))! as String, forKey:"image")
//                //dd.setValue((results?.stringForColumn("masterProfileID"))! as String, forKey:"masterProfileID")
//                dd.setValue((results?.string(forColumn: "moduleId"))! as String, forKey:"moduleId")
//                dd.setValue((results?.string(forColumn: "moduleName"))! as String, forKey:"moduleName")
//                dd.setValue((results?.string(forColumn: "moduleStaticRef"))! as String, forKey:"moduleStaticRef")
//                dd.setValue((results?.string(forColumn: "moduleOrderNo"))! as String, forKey:"moduleOrderNo")
//                dd.setValue((results?.string(forColumn: "notificationCount"))! as String, forKey:"notificationCount")
//                
//                print("<<<<<<<<<<-----This is group admin or not ----->>>>>>>>>>>>>")
//                print(isGroupAdmin)
//                print((results?.string(forColumn: "moduleName"))! as String)
//                
//                var modulename:String! = (results?.string(forColumn: "moduleName"))! as String
//                if(isGroupAdmin=="No" && modulename == "Attendance")
//                {
//                    
//                }
//                else
//                {
//                    if((results?.string(forColumn: "moduleName"))! as String=="Sub groups")
//                    {
//                    }
//                    else if((results?.string(forColumn: "moduleName"))! as String=="Club Monthly Report" || (results?.string(forColumn: "moduleName"))! as String=="Category" || (results?.string(forColumn: "moduleName"))! as String=="TRF Contribution")
//                    {
//                        if(isCategory=="1")
//                        {
//                        }
//                        else
//                        {
//                            if(isGroupAdmin=="Yes")
//                            {
//                                print("modulenamescheck \(modulenamescheck)")
//                                if(modulename != modulenamescheck)
//                                {
////                                    allmoduleCAtArry.add(dd)
//                                }
//                            }
//                            else
//                            {
//                                if(UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! Any == nil)
//                                {
//                                    print("aaaaaaaaaaaaaaaaaaaaaaaa")
//                                }
//                                else
//                                {
//                                   if let GetAssistanceGover:String = UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as? String
//                                   {
//                                    //print("Club Monthly Report":-----")
//                                    if (( GetAssistanceGover == "HideMonthlyReportModule"))
//                                    {
//                                        print("889898989898989898989898989898989898989898",UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! String)
//                                    }
//                                    else
//                                    {
//                                        print("modulenamescheck11: \(modulenamescheck)")
//                                        if(modulename != modulenamescheck)
//                                        {
////                                            allmoduleCAtArry.add(dd)
//                                        }
//                                        print("111111111111111111111111111111111111111",UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! String)
//                                    }
//                                }
//                            }
//                         }
//                      }
//                    }
//                    else
//                    {
//                         print("modulenamescheck 22 :\(modulenamescheck)")
//                        var getAdmin:String!=(results?.string(forColumn: "moduleName")) as! String
//                       if((results?.string(forColumn: "moduleName"))! as String=="Admin" && isGroupAdmin=="Yes" && isCategory=="1")
//                        {
////                                allmoduleCAtArry.add(dd)
//                        }
//                       else if(modulename != modulenamescheck)
//                        {
//                            if(getAdmin == "Admin")
//                            {
//                                
//                            }
//                            else
//                            {
//                                 print("modulenamescheck 33 :\(modulenamescheck)")
//                                if(modulename != modulenamescheck)
//                                {
////                                 allmoduleCAtArry.add(dd)
//                                }
//                            }
//                        }
//                    }
//                     print("modulenamescheck 44 :\(modulenamescheck)")
//                    if(modulename != modulenamescheck)
//                    {
//                        muarrayTemp.add((results?.string(forColumn: "groupId"))! as String)
////                        collectionView.reloadData()
//                    }
//                }
//                modulenamescheck = (results?.string(forColumn: "moduleName"))! as String
//            }
//            print(muarrayIsConatinCountOrNot)
//            print(muarrayTemp)
//        }
//        print("All module list \(allmoduleCAtArry)")
//    }
//    override func viewWillAppear(_ animated: Bool)
////    {
////        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
////            print("\(key) = \(value) \n")
////        }
//////        var isGroupAdmin =  UserDefaults.standard.value(forKey: (results?.string(forColumn: "isAdmin"))! as String)as? String
////        let isGroupAdmin = UserDefaults.standard.string(forKey: "isAdmin")
//////        var isGroupAdmin = UserDefaults.standard.object(forKey: "isAdmin") as! String
//////        {
//////            collectionView.isUserInteractionEnabled=true
////        print(isGroupAdmin)
////            UserDefaults.standard.set("nothing", forKey: "session_LinkValue")
////            UserDefaults.standard.set("no", forKey: "thisiscomingfromdetaileventdelete")
////            SVProgressHUD.dismiss()
////        self.functionForGetZipFilePath()
////            let getvalue = UserDefaults.standard.string(forKey: "session_IsComingFromProfileDynamicBackagainandagain")
////             let varGetValueForUpdateProfile:String!=UserDefaults.standard.value(forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")as? String
////            if(getvalue=="yes")
////            {
////                UserDefaults.standard.setValue("no", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
////                var alertController = UIAlertController()
////                self.functionForGetZipFilePath()
////                alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
////                self.present(alertController, animated: true, completion: nil)
////
////                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
////                    alertController.dismiss(animated: true, completion: nil)
////                })
////            }
////            if(varGetValueForUpdateProfile=="yes")
////            {
////                 UserDefaults.standard.setValue("no", forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")
////                var alertController = UIAlertController()
////                           self.functionForGetZipFilePath()
////                           alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
////                           self.present(alertController, animated: true, completion: nil)
////
////                           DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
////                               alertController.dismiss(animated: true, completion: nil)
////               })
////            }
////
////            self.refreshControl?.endRefreshing()
////            self.appDelegate = UIApplication.shared.delegate as? AppDelegate
//////            createNavigationBar()
////            self.allmoduleCAtArry=[]
//////            mymoduleCAtArry=[]
////            if(isGroupAdmin == "Yes" || isGroupAdmin == "yes")
////            {
//////                savesssfetchData()
////            }
////            else
////            {
////                functionForGetAssistanceDetails()
//////                savesssfetchData()
////            }
//            //code by Rajendra
////        }
//        {
//        
//        
//       
//        var databasePath1 : String
//        let documents1 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL1 = documents1.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath1 = fileURL1.path
//        var db1: OpaquePointer? = nil
//        if sqlite3_open(fileURL1.path, &db1) != SQLITE_OK {
//            print("error opening database")
//        }else{
//            // self.Createtablecity()
//        }
//        let contactDB1 = FMDatabase(path: databasePath1 as String)
//        if contactDB1 == nil {
//            print("Error: \(contactDB1?.lastErrorMessage())")
//        }
//        var varCounting:Int!=0
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        let grpIdddprofile=((UserDefaults.standard.string(forKey: "grpId")) as! String)
//        print(grpIdddprofile)
//        if (contactDB1?.open())! {
//            
//            let Count = "SELECT count(*) as Count from ProfileMaster where grpId = '\(grpIdddprofile)'"
//             print(Count)
//            let resultss:FMResultSet? = contactDB1?.executeQuery(Count,withArgumentsIn: nil)
//            while resultss?.next() == true
//            {
//                varGetCount=resultss?.string(forColumn: "Count")
//            }
//            
//            varCounting = Int(varGetCount)
//            // print(varCounting)
//        }
//        
////        self.fetchDataProfile()
//        if(varCounting>0)
//        {
//            let qualityOfServiceClass = DispatchQoS.QoSClass.background
//            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
//            backgroundQueue.async(execute: {
//                print("This is run on the background queue")
//                
//                DispatchQueue.main.async(execute: { () -> Void in
//                   // print("This is run on the main queue, after the previous code in outer block")
////                     self.fetchDataProfile()
//                })
//            })
//        }
//        else
//        {
//        }
//        contactDB1?.close()
//        //later called by Rajendra jat on 6MArch
//        self.functionForGetZipFilePath()
//
//        
//        
//        
//        
//        
//        lblNotifyCount.layer.cornerRadius = lblNotifyCount.frame.size.height/2
//        fetchData()
////            collectionView.isUserInteractionEnabled=true
//            UserDefaults.standard.set("nothing", forKey: "session_LinkValue")
//            UserDefaults.standard.set("no", forKey: "thisiscomingfromdetaileventdelete")
//            SVProgressHUD.dismiss()
//            
//            let getvalue = UserDefaults.standard.string(forKey: "session_IsComingFromProfileDynamicBackagainandagain")
//             let varGetValueForUpdateProfile:String!=UserDefaults.standard.value(forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")as? String
////            if(getvalue=="yes")
////            {
////                UserDefaults.standard.setValue("no", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
////                var alertController = UIAlertController()
////                self.functionForGetZipFilePath()
////                alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
////                self.present(alertController, animated: true, completion: nil)
////
////                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
////                    alertController.dismiss(animated: true, completion: nil)
////                })
////            }
////            if(varGetValueForUpdateProfile=="yes")
////            {
////                 UserDefaults.standard.setValue("no", forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")
////                var alertController = UIAlertController()
////                           self.functionForGetZipFilePath()
////                           alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
////                           self.present(alertController, animated: true, completion: nil)
////
////                           DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
////                               alertController.dismiss(animated: true, completion: nil)
////               })
////            }
//
//        
//
////        let qualityOfServiceClass = DispatchQoS.QoSClass.background
////        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
////        backgroundQueue.async(execute: {
////            //print("This is run on the background queue")
////            DispatchQueue.main.async(execute: { () -> Void in
////                // self.navigationController?.pushViewController(secondViewController, animated: true)
////            })
////        })
//
//
////        ["updatedOn": "1970-01-01 00:00:00", "grpID": "2765"]
//
//
//
//
////            self.refreshControl?.endRefreshing()
//            appDelegate = UIApplication.shared.delegate as? AppDelegate
////            createNavigationBar()
////            allmoduleCAtArry=[]
//////            mymoduleCAtArry=[]
////            if(isGroupAdmin == "Yes" || isGroupAdmin == "yes")
////            {
////                savesssfetchData()
////            }
////            else
////            {
////                functionForGetAssistanceDetails()
////                savesssfetchData()
////            }
//            //code by Rajendra
////        }
////        collectionView.isUserInteractionEnabled=true
//        UserDefaults.standard.set("nothing", forKey: "session_LinkValue")
//        UserDefaults.standard.set("no", forKey: "thisiscomingfromdetaileventdelete")
//        SVProgressHUD.dismiss()
//        
//        let getvalue1 = UserDefaults.standard.string(forKey: "session_IsComingFromProfileDynamicBackagainandagain")
//         let varGetValueForUpdateProfile1:String!=UserDefaults.standard.value(forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")as? String
//        if(getvalue1=="yes")
//        {
//            UserDefaults.standard.setValue("no", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
//            var alertController = UIAlertController()
//            self.functionForGetZipFilePath()
//            alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
//            self.present(alertController, animated: true, completion: nil)
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
//                alertController.dismiss(animated: true, completion: nil)
//            })
//        }
//        if(varGetValueForUpdateProfile1=="yes")
//        {
//             UserDefaults.standard.setValue("no", forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")
//            var alertController = UIAlertController()
//                       self.functionForGetZipFilePath()
//                       alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
//                       self.present(alertController, animated: true, completion: nil)
//                       
//                       DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
//                           alertController.dismiss(animated: true, completion: nil)
//           })
//        }
//
//        self.refreshControl?.endRefreshing()
//        appDelegate = UIApplication.shared.delegate as? AppDelegate
//        createNavigationBar()
//        allmoduleCAtArry=[]
////        mymoduleCAtArry=[]
//        if(isGroupAdmin == "Yes" || isGroupAdmin == "yes")
//        {
//            fetchData()
//        }
//        else
//        {
//            functionForGetAssistanceDetails()
//            fetchData()
//        }
//        
//        
//        
//        
//        appDelegate = UIApplication.shared.delegate as! AppDelegate
//        print("View Will appear is called**********************************")
////        userProfileDetail()
//        //MARK:- Get Notification Count
//    //MARK:- Uncomment this
//        getCountOfNotification()
//        NotificationCenter.default.addObserver(self, selector: #selector(getCountOfNotification), name: NSNotification.Name(rawValue: "NotifyDashboard"), object: nil)
//        
//        //MARK:- GetBannerDetailsOffline
//        functionDashBoardbirthAnniEventDataGet()
//        self.getBirthDayAnniversaryEventsDetails()
////        DispatchQueue.global(qos:.background).async {
////        //MARK:- GetBannerDetailsOnline
////        self.getBirthDayAnniversaryEventsDetails()
////        }
//
//        //MARK:- For version check
//        getAppVersionDetails()
//        UserDefaults.standard.set("nothing", forKey: "session_LinkValue")
//        viewloadandwillappearCount=viewloadandwillappearCount+1
//
//        UserDefaults.standard.set("", forKey: "isAdmin")
//        viewPopUp.isHidden=true
//        viewPopUp.superview?.bringSubviewToFront(viewPopUp)
//        var varIsExistFirstTime=UserDefaults.standard.value(forKey: "session_IsFirstTime")as! String
//        if(varIsExistFirstTime=="Yes")
//        {
//        }
//        else
//        {
//            UserDefaults.standard.setValue("No", forKey: "session_IsFirstTime")
//        }
//
//        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//        {
//            var varGetValue:String! =  UserDefaults.standard.value(forKey: "session_IsEntityExitInModuleScreen")as! String
//            if(varGetValue=="yes")
//            {
//                self.functionForFetchingNotificationCountList()
//                self.GetAllGroupListSync()
//                functionForBirthDayAnniversaryEvent()
//                UserDefaults.standard.setValue("no", forKey: "session_IsEntityExitInModuleScreen")
//            }
//            else
//            {
//                self.GetAllGroupListSync()
//                functionForBirthDayAnniversaryEvent()
//            }
//        }
//        else
//        {
//            self.GetAllGroupListSync()
//            functionForBirthDayAnniversaryEvent()
//            SVProgressHUD.dismiss()
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//            var getValue=UserDefaults.standard.value(forKey: "isitFirstTimeForDismissHUD")as? String
//
//            print(getValue)
//            if(getValue != nil)
//            {
//              print("coming in if side")
//              SVProgressHUD.dismiss()
//            }
//            else
//            {
//                print("coming in else side")
//            }
//        })
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//    }
//    
//    
////    func savesssfetchData()
////    {
////        var databasePath : String
////        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
////        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
////        // open database
////        databasePath = fileURL.path
////        var db: OpaquePointer? = nil
////        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
////        {
////            //print("error opening database")
////        }
////        else
////        {
////            // self.Createtablecity()
////        }
////        let contactDB = FMDatabase(path: databasePath as String)
////        if contactDB == nil {
////            //print("Error: \(contactDB.lastErrorMessage())")
////        }
////        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
////        if (contactDB?.open())! {
////
////            let querySQL = "SELECT distinct * FROM MODULE_DATA_MASTER where groupId = '\(grpDetailPrevious.object(forKey: "grpId") as! String)' order  by moduleOrderNo asc"
////            print("Main Dashboard querySQL \(querySQL)")
////            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
////            allmoduleCAtArry=NSMutableArray()
////            let muarrayTemp:NSMutableArray=NSMutableArray()
////            var isGroupAdmin = UserDefaults.standard.object(forKey: "isAdmin") as! String
////            var modulenamescheck:String!=""
////            while results?.next() == true {
////                print((results?.string(forColumn: "groupId"))! as String)
////                let dd = NSMutableDictionary ()
////                dd.setValue((results?.string(forColumn: "groupId"))! as String, forKey:"groupId")
////                dd.setValue((results?.string(forColumn: "groupModuleId"))! as String, forKey:"groupModuleId")
////                dd.setValue((results?.string(forColumn: "image"))! as String, forKey:"image")
////                //dd.setValue((results?.stringForColumn("masterProfileID"))! as String, forKey:"masterProfileID")
////                dd.setValue((results?.string(forColumn: "moduleId"))! as String, forKey:"moduleId")
////                dd.setValue((results?.string(forColumn: "moduleName"))! as String, forKey:"moduleName")
////                dd.setValue((results?.string(forColumn: "moduleStaticRef"))! as String, forKey:"moduleStaticRef")
////                dd.setValue((results?.string(forColumn: "moduleOrderNo"))! as String, forKey:"moduleOrderNo")
////                dd.setValue((results?.string(forColumn: "notificationCount"))! as String, forKey:"notificationCount")
////
////                print("<<<<<<<<<<-----This is group admin or not ----->>>>>>>>>>>>>")
////                print(isGroupAdmin)
////                print((results?.string(forColumn: "moduleName"))! as String)
////
////                var modulename:String! = (results?.string(forColumn: "moduleName"))! as String
////                if(isGroupAdmin=="No" && modulename == "Attendance")
////                {
////
////                }
////                else
////                {
////                    if((results?.string(forColumn: "moduleName"))! as String=="Sub groups")
////                    {
////                    }
////                    else if((results?.string(forColumn: "moduleName"))! as String=="Club Monthly Report" || (results?.string(forColumn: "moduleName"))! as String=="Category" || (results?.string(forColumn: "moduleName"))! as String=="TRF Contribution")
////                    {
////                        if(isCategory=="1")
////                        {
////                        }
////                        else
////                        {
////                            if(isGroupAdmin=="Yes")
////                            {
////                                print("modulenamescheck \(modulenamescheck)")
////                                if(modulename != modulenamescheck)
////                                {
////                                    allmoduleCAtArry.add(dd)
////                                }
////                            }
////                            else
////                            {
////                                if(UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! Any == nil)
////                                {
////                                    print("aaaaaaaaaaaaaaaaaaaaaaaa")
////                                }
////                                else
////                                {
////                                   if let GetAssistanceGover:String = UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as? String
////                                   {
////                                    //print("Club Monthly Report":-----")
////                                    if (( GetAssistanceGover == "HideMonthlyReportModule"))
////                                    {
////                                        print("889898989898989898989898989898989898989898",UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! String)
////                                    }
////                                    else
////                                    {
////                                        print("modulenamescheck11: \(modulenamescheck)")
////                                        if(modulename != modulenamescheck)
////                                        {
////                                            allmoduleCAtArry.add(dd)
////                                        }
////                                        print("111111111111111111111111111111111111111",UserDefaults.standard.value(forKey: "ShowHideMonthlyReportModule") as! String)
////                                    }
////                                }
////                            }
////                         }
////                      }
////                    }
////                    else
////                    {
////                         print("modulenamescheck 22 :\(modulenamescheck)")
////                        var getAdmin:String!=(results?.string(forColumn: "moduleName")) as! String
////                       if((results?.string(forColumn: "moduleName"))! as String=="Admin" && isGroupAdmin=="Yes" && isCategory=="1")
////                        {
////                                allmoduleCAtArry.add(dd)
////                        }
////                       else if(modulename != modulenamescheck)
////                        {
////                            if(getAdmin == "Admin")
////                            {
////
////                            }
////                            else
////                            {
////                                 print("modulenamescheck 33 :\(modulenamescheck)")
////                                if(modulename != modulenamescheck)
////                                {
////                                 allmoduleCAtArry.add(dd)
////                                }
////                            }
////                        }
////                    }
////                     print("modulenamescheck 44 :\(modulenamescheck)")
////                    if(modulename != modulenamescheck)
////                    {
////                        muarrayTemp.add((results?.string(forColumn: "groupId"))! as String)
////                        collectionView.reloadData()
////                    }
////                }
////                modulenamescheck = (results?.string(forColumn: "moduleName"))! as String
////            }
////            print(muarrayIsConatinCountOrNot)
////            print(muarrayTemp)
////        }
////        print("All module list \(allmoduleCAtArry)")
////    }
//    
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
//            /* //MARK:- Uncomment this
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "NotifyDashboard"), object: nil)*/
//        
//    }
//    
////    @objc func functionWhenAppwillActivefromBackgroundToForeground()
////    {
////        appDelegate = UIApplication.shared.delegate as! AppDelegate
////        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
////
////        {
////            DispatchQueue.global(qos:.background).async {
////                self.getBirthDayAnniversaryEventsDetails()
////            }
////        }
////        else
////        {
////        }
////    }
//    
////    @objc func functionForDeleteEventThenRefreshMainDashBoardSliderDetails()
////    {
////        appDelegate = UIApplication.shared.delegate as! AppDelegate
////        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
////        {
////            DispatchQueue.global(qos:.background).async {
////                print("---22222 second 222222")
////                self.getBirthDayAnniversaryEventsDetails()
////            }
////        }
////        else
////        {
////        }
////    }
//
//    func getUpdateAppVersionPOPUP()
//    {
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID") as AnyObject //isAdmin
//        let imeiNo = UIDevice.current.identifierForVendor!.uuidString
//        var updatedOn =  String ()
//        let defaults = UserDefaults.standard
//        if let str = defaults.value(forKey: "updatedOnForVersion") as! String?
//        {
//            updatedOn = "1970-1-1 0:0:0"
//        }
//        else
//        {
//            updatedOn = "1970-1-1 0:0:0"
//        }
//        let completeURL:String! = baseUrl+rowAppVersionGetAllGroupList
//        let parameterst = [
//            "masterUID":mainMemberID,"imeiNo":imeiNo,"updatedOn":updatedOn
//            ] as [String : Any]
//        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
//            var varGetVersionNumber:String!=""
//            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
//            {
//                varGetVersionNumber=version
//            }
//            let dd = response as! NSDictionary
//            var varGetValueServerError = dd.object(forKey: "serverError")as? String
//            
//            if(varGetValueServerError == "Error")
//            {
//               SVProgressHUD.dismiss()
//            }
//            else
//            {
//                if(((dd.object(forKey: "TBGroupResult")! as AnyObject).object(forKey: "status") as! String == "0") && ((dd.object(forKey: "TBGroupResult")! as AnyObject).object(forKey: "message") as! String == "success"))
//                {
//                    let varGetAppVersion=(dd.object(forKey: "TBGroupResult")! as AnyObject).object(forKey: "version") as! String
//                    let varGetCurrentDate=(dd.object(forKey: "TBGroupResult")! as AnyObject).object(forKey: "curDate") as! String
//                    var aServer:Float!=Float(varGetAppVersion)!
//                    var bLocal:Float!=Float(varGetVersionNumber)!
//                    if(aServer>bLocal)
//                    {
//                        SVProgressHUD.dismiss()
//                        let alert = UIAlertController(title: "Rotary India", message: "There is a newer version avaliable for download! Please update the app by visiting the Apple Store", preferredStyle: UIAlertController.Style.alert)
//                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
//                            self.GoToNewShoot()
//                        }));
//                        self.present(alert, animated: true, completion: nil)
//                    }
//                    else if(aServer<bLocal)
//                    {
//                        UserDefaults.standard.setValue(varGetCurrentDate, forKey: "updatedOnForVersion")
//                    }
//                    else if(aServer==bLocal)
//                    {
//                        UserDefaults.standard.setValue(varGetCurrentDate, forKey: "updatedOnForVersion")
//                    }
//                }
//                else
//                {
//                }
//            }
//        })
//    }
//    
//    
//    func GoToNewShoot()
//    {
//        let alert = UIAlertController(title: "Rotary India", message: "There is a newer version avaliable for download! Please update the app by visiting the Apple Store", preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
//            self.GoToNewShoot()
//        }));
//        self.present(alert, animated: true, completion: nil)
//        ////print("Method Called")
//        // App Store URL.
//        let appStoreLink = ituneDynamicUrlFromServer
//        //print("This is coming from backend side table as discuused with mukesh")
//        print("App store Link \(ituneDynamicUrlFromServer)")
//       // UIApplication.shared.openURL(URL(string:appStoreLink!)!)
//        if let url=URL(string:appStoreLink!)
//        {
//            UIApplication.shared.openURL(url)
//        }
//    }
//
//    //MARK:- All Image Click Event
//    func functionForAllimageClickEvent()
//    {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(RootDashViewController.FindAClubCE))
//        imgFindAClub.addGestureRecognizer(tap)
//        imgFindAClub.isUserInteractionEnabled = true
//        
//        let tap1 = UITapGestureRecognizer(target: self, action: #selector(RootDashViewController.FindARotarianCE))
//        imgFindARotarian.addGestureRecognizer(tap1)
//        imgFindARotarian.isUserInteractionEnabled = true
//        
//        let tap2 = UITapGestureRecognizer(target: self, action: #selector(RootDashViewController.ShowCaseCE))
//        imgShowCase.addGestureRecognizer(tap2)
//        imgShowCase.isUserInteractionEnabled = true
//        
//        let tap3 = UITapGestureRecognizer(target: self, action: #selector(RootDashViewController.COVIDCE))
//       // imgLibrary.addGestureRecognizer(tap3)
//       // imgLibrary.isUserInteractionEnabled = true
//    }
//    
//    @objc func FindAClubCE()
//    {
//        UserDefaults.standard.setValue("Find a Club", forKey: "Session_ModuleNameForNavigationHeading_FindAClubOrClubs")
//        
//        if let storyboard = self.storyboard {
//            // UserDefaults.standard.setValue("27", forKey: "session_GetModuleId")
//            
//            let AnyClubNewViewController = storyboard.instantiateViewController(withIdentifier: "AnyClubNewViewController")
//            AnyClubNewViewController.title = "Any Club"
//            let NearMeNewViewController = storyboard.instantiateViewController(withIdentifier: "NearMeNewViewController")
//            NearMeNewViewController.title = "Near Me"
//            let segmentController = SJSegmentedViewController()
//            //segmentController.headerViewController = headerViewController
//            segmentController.segmentControllers = [AnyClubNewViewController,NearMeNewViewController]
//            navigationController?.pushViewController(segmentController, animated: true)
//        }
//        ////print("Tapped on Image1")
//    }
//    @objc func FindARotarianCE()
//    {
//        let objFinddArotarianViewController = self.storyboard?.instantiateViewController(withIdentifier: "FinddArotarianViewController") as! FinddArotarianViewController
//        objFinddArotarianViewController.moduleName = "Find a Rotarian"
//        
//        
//        UserDefaults.standard.setValue("27", forKey: "session_GetModuleId")
//        
//        
//        self.navigationController?.pushViewController(objFinddArotarianViewController, animated: true)
//        ////print("Tapped on Image2")
//    }
//    @objc func ShowCaseCE()
//    {
////        let objFinddArotarianViewController = self.storyboard?.instantiateViewController(withIdentifier: "GalleryCatyegoryNewViewController") as! GalleryCatyegoryNewViewController
////        objFinddArotarianViewController.getGroupDistrictList=self.groupList
////        objFinddArotarianViewController.moduleName = "Showcase"
////        self.navigationController?.pushViewController(objFinddArotarianViewController, animated: true)
//        
//        self.WebCall(moduleName: "Showcase")
//    }
//    
//    @objc func LibraryCE()
//    {
//        let objRotaryLibraryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryLibraryViewController") as! RotaryLibraryViewController
//        objRotaryLibraryViewController.moduleName = "Rotary Library"
//        self.navigationController?.pushViewController(objRotaryLibraryViewController, animated: true)
//        ////print("Tapped on Image4")
//    }
//    @objc func RotaryNewsCE()
//    {
////        let objRotaryLibraryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryNewsViewController") as! RotaryNewsViewController
////        objRotaryLibraryViewController.moduleName="Rotary News"
////        //objRotaryLibraryViewController.muarrauRotaryNews=self.muarrauRotaryNews
////        self.navigationController?.pushViewController(objRotaryLibraryViewController, animated: true)
//        
//        let objRotaryLibraryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
//        objRotaryLibraryViewController.moduleName="Rotary News"
//        objRotaryLibraryViewController.varFromCalling = "Rotary News"
//        self.navigationController?.pushViewController(objRotaryLibraryViewController, animated: true)
//
//        
//    }
//    @objc func RotaryBlogsCE()
//    {
//        let objRotaryLibraryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryBlogViewController") as! RotaryBlogViewController
//        objRotaryLibraryViewController.moduleName="Rotary Blogs"
//        //objRotaryLibraryViewController.muarrauRotaryNews=self.muarrauRotaryNews
//        self.navigationController?.pushViewController(objRotaryLibraryViewController, animated: true)
//        
//        
//        
//        ////print("Tapped on Image6")
//    }
//    @objc func RotaryOrgCE()
//    {
//        
//        let objRotaryLibraryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
//        objRotaryLibraryViewController.moduleName="Rotary.org"
//        //objRotaryLibraryViewController.muarrauRotaryNews=self.muarrauRotaryNews
//        self.navigationController?.pushViewController(objRotaryLibraryViewController, animated: true)
//        
//        
//        
//        //        if let requestUrl = NSURL(string: "https://my.rotary.org/en") {
//        //            UIApplication.sharedApplication().openURL(requestUrl)
//        //        }
//        ////print("Tapped on Image7")
//    }
//    @objc func RotaryIndiaCE()
//    {
//        WebCall(moduleName: "Rotary India")
//    }
//    
//    
//    @objc func COVIDCE()
//      {
//   //URLstr = "https://rotaryindia.org/Covid19/Covid19Registration.aspx"
//       let  URLstr="https://rotaryindia.org/Fight_Against_Covid_19.html"
//
//          if let urlString = URLstr as? String {
//              if let whatsappURL = URL(string: urlString) {
//                  if UIApplication.shared.canOpenURL(whatsappURL) {
//                      UIApplication.shared.openURL(whatsappURL)
//                  } else {
//                      let alertView:UIAlertView = UIAlertView()
//                      alertView.title = "Rotary India"
//                      alertView.message = "Please check your network connection."
//                      alertView.delegate = self
//                      alertView.addButton(withTitle: "OK")
//                      alertView.show()
//                  }
//              }
//          }
//      }
//    
//    @objc func ROW_Features()
//      {
//          let profVC = self.storyboard!.instantiateViewController(withIdentifier: "FeatureViewController") as! FeatureViewController
//          self.navigationController?.pushViewController(profVC, animated: true)
//      }
//    
//    @objc func ROWCE()
//      {
//        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
//        self.navigationController?.pushViewController(profVC, animated: true)
//
//      }
//    
//    func WebCall(moduleName:String)
//    {
//        
//        let objRotaryLibraryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
//        objRotaryLibraryViewController.varFromCalling=moduleName
//        objRotaryLibraryViewController.moduleName=moduleName
//    self.navigationController?.pushViewController(objRotaryLibraryViewController, animated: true)
//    }
//    
//  @objc  func GlobeRewardCE()
//    {
//        let objRotaryLibraryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
//        objRotaryLibraryViewController.varFromCalling="Global Rewards"
//        objRotaryLibraryViewController.moduleName="Global Reward"
//        //objRotaryLibraryViewController.muarrauRotaryNews=self.muarrauRotaryNews
//        self.navigationController?.pushViewController(objRotaryLibraryViewController, animated: true)
//        ////print("Tapped on Image8")
//    }
//    
//    
//    @IBOutlet weak var indicator: UIActivityIndicatorView!
//
//    var viewloadandwillappearCount:Int=0
//
//    func functionForSetDeviceToken()
//    {
//        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//        {
//            
//            //if(appToken.characters.count>19)
//            print("Device Token : \(UserDefaults.standard.value(forKey: "deviceToken"))")
//            if let abc = UserDefaults.standard.value(forKey: "deviceToken") as? String
//            {
//                let varGetMobileNumber = UserDefaults.standard.value(forKey: "session_Mobile_Number")as! String
//                var arrayNotificationCount:NSArray=NSArray()
//                let completeURL = baseUrl+"Group/UpdateDeviceTokenNumber"
//                let parameterst = [
//                    "MobileNumber" : varGetMobileNumber,
//                    "DeviceToken" : abc
//                ]
//                //print("rajndra jat token in root dash board screen :---------")
//                print("this is device token :----------------------------")
//                print(parameterst)
//                print(completeURL)
//                
//                ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
//                    //=> Handle server response
//                    //print(response)
//                    print("This is device token by Rajendra JAt 1 March !!!!!")
//                    var varGetValueServerError = response.object(forKey: "serverError")as? String
//                    
//                    if(varGetValueServerError == "Error")
//                    {
//                        SVProgressHUD.dismiss()
//                    }
//                    else
//                    {
//                        
//                        if((response.value(forKey: "UpdateDeviceTokenNumberResult")! as AnyObject).value(forKey: "status") as! String == "0")
//                        {
//                            print("Device token updated successfully")
//                            SVProgressHUD.dismiss()
//                        }
//                        else
//                        {
//                            //print("22222..rajendra")
//                            SVProgressHUD.dismiss()
//                        }
//                    }
//                })
//            }
//            else
//            {
//                print("device token is null in root dash board controlewr ")
//            }
//        }
//    }
//    /*--need to set refresh button on Right side Navigation start*/
//    func functionForRightNavigation()
//    {
//        let DownArrow = UIButton(type: UIButton.ButtonType.custom)
//        DownArrow.frame = CGRect(x: 65, y: 0, width: 20, height: 20)
//        // let last1 = String(String(year-1).characters.suffix(2))
//        // let last2 = String(yearFrom.characters.suffix(2))
//        //print(last1 , last2)
//        // DownArrow.setTitle(last1 + "-" + last2, for: .normal)
//        //editB.setTitleColor(UIColor.black, for: .normal)
//        // editB.setImage(UIImage(named:"overflow_btn_blue"),  for: UIControl.State.normal)
//        
//        DownArrow.setTitleColor(UIColor(hexString: "#00aeef"), for: .normal)
//        DownArrow.setImage(UIImage(named:"refresh"),  for: UIControl.State.normal)
//        DownArrow.addTarget(self, action: #selector(RootDashViewController.buttonRefreshClickEvent), for: UIControl.Event.touchUpInside)
//        let DownArrows: UIBarButtonItem = UIBarButtonItem(customView: DownArrow)
//        let buttons : NSArray = [DownArrows]
//        
//        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
//    }
//    
//    @objc func buttonRefreshClickEvent()
//    {
//        DELETEDashboard_BirthAnniEvent_table_New()
//        print("Refresh button clicked !!!!1")
//        labelFirstTimeSyncMessage.isHidden=true
//        appDelegate = UIApplication.shared.delegate as! AppDelegate
//        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//        {
//            muarrayForBirthdayAnniversaryEvent=NSMutableArray()
//            lblandhaveTodayBirthday.text! = ""
//            lblBAEDesc.text! = ""
//            lblDescForSlider.text! = ""
//            lblDateEVENT.text! = ""
//            lblDescriptionForBirthAnni.text! = ""
//            lblandhaveTodayBirthday.text! = ""
//            lblClubDistrictName.text! = ""
////            self.imgGrayIconROW.isHidden=true
//            imgBAE.image = UIImage(named:"dummy")
////            self.viewPager.dataSource = self
////            self.indicator.startAnimating()
////            viewPager.reloadData()
////            self.viewPager.scrollToPage(0)
////            self.viewPager.animationNext()
////            self.imgGrayIconROW.isHidden=true
//            DispatchQueue.global(qos:.background).async {
//              UserDefaults.standard.removeObject(forKey: "session_DateDifference")
//                self.functionForBirthDayAnniversaryEvent()
//                self.getBirthDayAnniversaryEventsDetails()
//                self.GetAllGroupListSync()
//               
//                DispatchQueue.main.async {
//                    //  SVProgressHUD.show()
//                    self.indicator.startAnimating()
//                }
//            }
//        }
//        else
//        {
//        }
//    }
//
//    /*--need to set refresh button on Right side Navigation end*/
//    func DELETEDashboard_BirthAnniEvent_table_New()
//   {
//    var databasePath : String
//    let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//    let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        databasePath = fileURL.path
//    let contactDB = FMDatabase(path: databasePath as String)
//    if contactDB == nil
//    {
//    }
//    else if (contactDB?.open())!
//    {
//        let insertSQL = "DELETE FROM Dashboard_BirthAnniEvent_table_New"
//        let result = contactDB?.executeStatements(insertSQL)
//    }
//  }
//    
//    //added by shubhs from directory for profile
//    
//    func fetchDataProfile()
//    {
//        
//        let grpIdddprofile=((UserDefaults.standard.string(forKey: "grpId")) as! String)
//        print(grpIdddprofile)
////        mainArray.removeAllObjects()
////        mainArray=NSMutableArray()
//        var databasePath : String
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
//            print("error opening database")
//        }else{
//            // self.Createtablecity()
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil {
//            print("Error: \(contactDB?.lastErrorMessage())")
//        }
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        if (contactDB?.open())! {
//
//            //SELECT * FROM ProfileMaster
//            // WHERE (membername LIKE '%ande%' OR membermobile LIKE '%1234567%' )
//
//            let querySQL = "SELECT  DISTINCT memberName,profilePic,memberMobile,masterId,profileId,isAdmin,isPersonalDetVisible,isBussinessDetVisible,isFamilyDetVisible,grpId,familyPic  FROM ProfileMaster where grpId = '\(grpIdddprofile)'  order by memberName COLLATE NOCASE asc"
//             print(querySQL)
//             let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
//
//             var varCounting:Int!=0
//
//             while results?.next() == true {
////                autoreleasepool {
//                let dd = NSMutableDictionary ()
//                dd.setValue((results?.string(forColumn: "memberName"))! as String, forKey:"memberName")
//                dd.setValue((results?.string(forColumn: "memberMobile"))! as String, forKey:"memberMobile")
//                dd.setValue((results?.string(forColumn: "masterId"))! as String, forKey:"masterId")
//                dd.setValue((results?.string(forColumn: "profileId"))! as String, forKey:"profileId")
//                dd.setValue((results?.string(forColumn: "isAdmin"))! as String, forKey:"isAdmin")
//                dd.setValue((results?.string(forColumn: "isPersonalDetVisible"))! as String, forKey:"isPersonalDetVisible")
//                dd.setValue((results?.string(forColumn: "isBussinessDetVisible"))! as String, forKey:"isBussinessDetVisible")
//                dd.setValue((results?.string(forColumn: "isFamilyDetVisible"))! as String, forKey:"isFamilyDetVisible")
//                dd.setValue((results?.string(forColumn: "grpId"))! as String, forKey:"grpId")
//                dd.setValue((results?.string(forColumn: "profilePic"))! as String, forKey:"profilePic")
//                
//                if(self.isCategory=="2")
//                {
//                    
//                }
//                else
//                {
//                    dd.setValue((results?.string(forColumn: "familyPic"))! as String, forKey:"familyPic") //31-08-2017
//                }
//                
////                mainArray.add(dd)
//                varCounting=varCounting+1
//               
////                }
//            }
//            
////            if mainArray.count > 0
////            {
////                NoRecordLabel.isHidden = true
////                copymainArray=mainArray
////                directoryTableView.reloadData()
////                self.varRefreshDatRunOneTime="First"
////            }
////            else
////            {
////                NoRecordLabel.isHidden = false
////                mainArray.removeAllObjects()
////                mainArray = NSMutableArray()
////                copymainArray=NSArray()
////                directoryTableView.reloadData()
////                self.varRefreshDatRunOneTime="Second"
////            }
//
//            let Count = "SELECT count(*) as Count from ProfileMaster where grpId = '\(grpIdddprofile)'"
//             print(Count)
//            let resultss:FMResultSet? = contactDB?.executeQuery(Count,withArgumentsIn: nil)
//
//            while resultss?.next() == true
//            {
//                varGetCount=resultss?.string(forColumn: "Count")
//            }
//            varGetCount=String(varCounting)
//            //print(varGetCount)
//        }
//
//        contactDB?.close()
//    }
//    
//    
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        //MARK:- For showing Username
//        functionForBirthDayAnniversaryEvent()
//        self.getBirthDayAnniversaryEventsDetails()
//        lblNotifyCount.layer.cornerRadius = lblNotifyCount.frame.size.height/2
//        let values = UserDefaults.standard.hashValue
//        btnMenu.isHidden=true
//        UserDefaults.standard.setValue("no", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
//        if let username = UserDefaults.standard.value(forKey: "rotaryusername") as? String
//        {
//            self.lblUserName.text = "Hi " + username + " !"
//        }
//
//        // for profile ades by shubhs
//        
//        
//        
//        var databasePath1 : String
//        let documents1 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL1 = documents1.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath1 = fileURL1.path
//        var db1: OpaquePointer? = nil
//        if sqlite3_open(fileURL1.path, &db1) != SQLITE_OK {
//            print("error opening database")
//        }else{
//            // self.Createtablecity()
//        }
//        let contactDB1 = FMDatabase(path: databasePath1 as String)
//        if contactDB1 == nil {
//            print("Error: \(contactDB1?.lastErrorMessage())")
//        }
//        var varCounting:Int!=0
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        let grpIdddprofile=((UserDefaults.standard.string(forKey: "grpId")) as! String)
//        print(grpIdddprofile)
//        if (contactDB1?.open())! {
//            
//            let Count = "SELECT count(*) as Count from ProfileMaster where grpId = '\(grpIdddprofile)'"
//             print(Count)
//            let resultss:FMResultSet? = contactDB1?.executeQuery(Count,withArgumentsIn: nil)
//            while resultss?.next() == true
//            {
//                varGetCount=resultss?.string(forColumn: "Count")
//            }
//            
//            varCounting = Int(varGetCount)
//            // print(varCounting)
//        }
//        
////        self.fetchDataProfile()
//        if(varCounting>0)
//        {
//            let qualityOfServiceClass = DispatchQoS.QoSClass.background
//            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
//            backgroundQueue.async(execute: {
//                print("This is run on the background queue")
//                
//                DispatchQueue.main.async(execute: { () -> Void in
//                   // print("This is run on the main queue, after the previous code in outer block")
////                     self.fetchDataProfile()
//                })
//            })
//        }
//        else
//        {
//        }
//        contactDB1?.close()
//        //later called by Rajendra jat on 6MArch
////
//        
////        self.functionForGetZipFilePath()
//        
////        Club Directory parameterst:: ["updatedOn": "2021/05/10 18:04:54", "grpID": "2765"]
////        Club Directory completeURL:: Optional("http://rowtestapi.rosteronwheels.com/V4/api/Member/GetMemberListSync")
////
//        
//        
//        
//        
//        
//        
//        
//        ///
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        //MARK:- Update device token
//        self.functionForSetDeviceToken()
//
//        //MARK:- For Advertizment
//        self.getPoPupInfo()
//        
//        //MARK:- Image buttons click events
//        functionForAllimageClickEvent()
//
//        viewloadandwillappearCount=1
//        UserDefaults.standard.setValue("1", forKey: "isRootVisitedFirst")
//        let defaults1 = UserDefaults.standard
//        defaults1.set("1", forKey: "splashOver")
//        self.edgesForExtendedLayout = UIRectEdge()
//        
//        //MARK:- When app comes from back to fore
//        //NotificationCenter.default.addObserver(self, selector: #selector(RootDashViewController.functionWhenAppwillActivefromBackgroundToForeground), name: NSNotification.Name(rawValue: "functionWhenAppwillActivefromBackgroundToForeground"), object: nil)
//
//        //NotificationCenter.default.addObserver(self, selector: #selector(RootDashViewController.functionForDeleteEventThenRefreshMainDashBoardSliderDetails), name: NSNotification.Name(rawValue: "functionForDeleteEventThenRefreshMainDashBoardSliderDetails"), object: nil)
//
//        myScrollView.delegate=self
//        myCollectionView.frame = CGRect(x: self.myCollectionView.frame.origin.x+5, y: self.myCollectionView.frame.origin.y, width: self.myCollectionView.frame.size.width, height: self.myCollectionView.frame.size.height)
////        self.myCollectionView.frame.origin.x
//        
//        indicator.startAnimating()
////        viewPager.addSubview(indicator)
//        self.view.setNeedsDisplay()
//        self.view.setNeedsLayout()
//        lblClubDistrictName.textColor = UIColor.black
//        lblDescForSlider.textColor = UIColor.black
//        lblDateEVENT.textColor = UIColor.black
//        lblBAEDesc.textColor = UIColor.black
//        lblDescriptionForBirthAnni.textColor = UIColor.black
//
//        UIApplication.shared.keyWindow!.bringSubviewToFront(buttonOpticity)
//        varGetPickerSelectValue = "Settings"
//        labelFirstTimeSyncMessage.isHidden=true
//        refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl.addTarget(self, action: #selector(RootDashViewController.refresh(_:)), for: UIControl.Event.valueChanged)
//        //---
//        UserDefaults.standard.setValue("no", forKey: "session_IsEntityExitInModuleScreen")
//        //Navigation more functionality ------DPK
//        viewForSettingPicker.isHidden = true
//        buttonOpticity.isHidden = true
//        buttonDonOnPicker.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
//        mainArraySettingForPicker = ["Settings" , "About Us"]
//        menuTitles=NSMutableArray()
//        // appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        addGrpBTn.isHidden=true
//        viewPopUp.isHidden=true
//        let varGetMasterID = UserDefaults.standard.string(forKey: "masterUID") as AnyObject
//        appDelegate = UIApplication.shared.delegate as! AppDelegate
//        var varMatchRssFeed = UserDefaults.standard.string(forKey: "Session_RssFeedFirstTime")
//        let date = Foundation.Date()
//        let calendar = Calendar.current
//        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
//        let year:String! =  String(describing: components.year)
//        let month:String! = String(describing: components.month)
//        let day:String! = String(describing: components.day)
//        var varAddDayMonthYear:String!=""
//        varAddDayMonthYear=day+month+year
//
//        var varGetRSSFEEDValueDay=UserDefaults.standard.value(forKey: "session_GetFeedValueNew")
//        appDelegate = UIApplication.shared.delegate as! AppDelegate
//        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//        {
//            if(varGetRSSFEEDValueDay == nil)
//            {
//                UserDefaults.standard.setValue(varAddDayMonthYear, forKey: "session_GetFeedValueNew")
//                  self.beginParsing()
//                
//            }
//            else if(varAddDayMonthYear == (varGetRSSFEEDValueDay)as! String)
//            {
//                UserDefaults.standard.setValue(nil, forKey: "session_GetFeedValueNew")
//                self.beginParsing()
//            }
//            else
//            {
//                UserDefaults.standard.setValue(varAddDayMonthYear, forKey: "session_GetFeedValueNew")
//                self.beginParsing()
//            }
//        }
//        else
//        {
//            UserDefaults.standard.setValue(nil, forKey: "session_GetFeedValueNew")
//            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//            {
//                 self.beginParsing()
//            }
//        }
//        appDelegate = UIApplication.shared.delegate as! AppDelegate
//          
//        imageSplashScreenRoot.isHidden=false
//        var databasePath : String
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
//        }else{
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil {
//        }
//        if (contactDB?.open())! {
//            let querySQL = "SELECT distinct * FROM GROUPMASTER"
//            let results:FMResultSet? = contactDB?.executeQuery(querySQL,  withArgumentsIn: nil)
//            if results?.next() == true
//            {
//                let count = results!.int(forColumnIndex: 0)
//                let dd = NSMutableDictionary ()
//                dd.setValue((results?.string(forColumn: "grpId"))! as String, forKey:"grpId")
//                if count > 0
//                {
//                    imageSplashScreenRoot.isHidden=true
//                }
//                else
//                {
//                }
//            }
//            else
//            {
//                var varGetText:NSAttributedString!=functionForSetColorInStringFamilyDetailBG()
//                labelFirstTimeSyncMessage.attributedText=varGetText
//                buttonOpticity.isHidden=false
//                labelFirstTimeSyncMessage.isHidden=false
//                varCheckLoadingOrPicker==0
//            }
//        }
//        UIApplication.shared.keyWindow!.bringSubviewToFront( imageSplashScreenRoot)
//        let currentWindoww: UIWindow = UIApplication.shared.keyWindow!
//        currentWindoww.addSubview(imageSplashScreenRoot)
//        UserDefaults.standard.setValue("Yes", forKey: "session_IsFirstTime")
//    }
//    
//    
//    func webViewDidFinishLoad(_ webView: WKWebView) {
//        SVProgressHUD.dismiss()
//    }
//    
//func getPoPupInfo()
//{
//
//    let completeURL:String=baseUrl+getMobilePupup
//    var mainMemberID:String = UserDefaults.standard.string(forKey: "masterUID") as? String ?? ""
//    let parameters:[String:String]=["FkmasterID":mainMemberID]
//   
// print("URL for Popup \(completeURL)")
// print("Parameters for popup \(parameters)")
// SVProgressHUD.show()
//
// Alamofire.request(completeURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON(){
//     response in
//     switch response.result
//     {
//     case .success:
//print("Popup Response is \(response.result.value)")
//if let dd = response.result.value as? NSDictionary
//{
//    if let AdminmobilepupupResult = dd.value(forKey: "AdminmobilepupupResult") as? NSDictionary
//    {
//        if let description = AdminmobilepupupResult.value(forKey: "Description")
//        {
//            self.addView.isHidden=false
//
////            self.addWebView.load(URLRequest(url:URL(string: "http://kaizeninfotech.com/ads.html")!))
//            
////            self.addWebView.load(URLRequest(url: URL(string: description as! String)!))
//            
//            self.addWebView.loadHTMLString(description as! String, baseURL: nil)
//            
//        }
//        else
//        {
//                   self.addView.isHidden=true
//        }
//    }
//    else
//    {
//              self.addView.isHidden=true
//    }
//     }
//     else
//     {
//                self.addView.isHidden=true
//     }
//
//     break
//  case .failure:
//         self.addView.isHidden=true
//     break
//    }
//  }
// }
//    
//    func mygroupsDelegateFunction(_ string: TBGroupResult) {
//        //print(string.status)
//        if(string.status  == "0"){
//            if(string.allGroupListResults.count > 0){
//                
//                allmoduleCAtArry=string.allGroupListResults as! NSArray
//                let predicate3 = NSPredicate(format: "myCategory contains %@", "0")
//                //unCategoriesArry = allmoduleCAtArry.filteredArrayUsingPredicate(predicate3)
//            }else
//            {
//                allmoduleCAtArry=[]
//                //unCategoriesArry=[]
//            }
//        }else{
//            allmoduleCAtArry=[]
//            //unCategoriesArry=[]
//        }
//        //            if(unCategoriesArry.count > 0){
//        //                bottomBtn.hidden = false
//        //            }else{
//        //                bottomBtn.hidden = true
//        //            }
//    }
//    
//    
//    
//    func createNavigationBar()
//    {
//        self.navigationItem.setHidesBackButton(true, animated: false)
//        
//        let logo = UIImage(named: "rt_nav_logo")
//        let imageView = UIImageView(image:logo)
//      //  self.navigationItem.titleView = imageView
//        
//       // self.title="Roster On Wheels"
//        
//        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
//        self.navigationController!.navigationBar.titleTextAttributes = attributes
//        
//           let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        
//        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
//        
//        self.navigationController?.navigationBar.barTintColor = UIColor.white
//        
//        //self.navigationController?.navigationBar.ti = UIColor.whiteColor()
//        
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(RootDashViewController.AddGroupAction))
//        
//        add.tintColor = UIColor.white
//        
//        //self.navigationItem.rightBarButtonItem = add
//        
//        let searchButton = UIButton(type: UIButton.ButtonType.custom)
//        
//        searchButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
//        
//        searchButton.setImage(UIImage(named:"search_blue"),  for: UIControl.State.normal)
//        
//        searchButton.addTarget(self, action: #selector(RootDashViewController.searchClicked), for: UIControl.Event.touchUpInside)
//        
//        let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
//        
//        //let buttons : NSArray = [search, setting] //14 mar
//        
//        let buttonss : NSArray = [search]
//        
//        
//        
//        let settingButton = UIButton(type: UIButton.ButtonType.custom)
//        
//        settingButton.frame = CGRect(x: 0, y: 0, width: 30, height: 45)
//        
//        settingButton.setImage(UIImage(named:"overflow_btn_blue"),  for: UIControl.State.normal)
//        
//        settingButton.addTarget(self, action: #selector(RootDashViewController.SettingsAction), for: UIControl.Event.touchUpInside)
//        
//        let setting: UIBarButtonItem = UIBarButtonItem(customView: settingButton)
//        //let buttons : NSArray = [search, setting] //14 mar
//        let buttons : NSArray = [setting]
//        //self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
//        
//        self.navigationItem.setHidesBackButton(true, animated:true);
//         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
//        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
//        buttonleft.setImage(UIImage(named:"Sm"),  for: UIControl.State.normal)
//        buttonleft.addTarget(self, action: #selector(RootDashViewController.backClicked), for: UIControl.Event.touchUpInside)
//        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
//        self.navigationItem.leftBarButtonItem = leftButton
//    }
//
//    @objc func backClicked()
//    {
//     //   var dict:NSDictionary!
//       
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
//    }
//    
//    
//    
//    @objc func SettingsAction()
//    {
//        varCheckLoadingOrPicker=1
//        if(varISPopVisisbleorNot==0)
//        {
//            
//            buttonOpticity.isHidden = false
//            viewForSettingPicker.isHidden = false
//            pickerSelectSettingMyProfileAboutPicker.reloadAllComponents()
//            varISPopVisisbleorNot=1
//        }
//        else  if(varISPopVisisbleorNot==1)
//        {
//            buttonOpticity.isHidden = true
//            viewForSettingPicker.isHidden = true
//            varISPopVisisbleorNot=0
//        }
//    }
//    @objc func searchClicked()
//    {
//        viewPopUp.isHidden=true
//        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "global_search") as UIViewController, animated: true)
//    }
//    @objc func AddGroupAction()
//    {
//        let defaults = UserDefaults.standard
//        defaults.set("", forKey: "eventAddress")
//        defaults.set("", forKey: "eventLat")
//        defaults.set("", forKey: "eventLon")
//        defaults.synchronize()
//    self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "create_group") as UIViewController, animated: true)
//    }
//    override func didReceiveMemoryWarning()
//    {
//        super.didReceiveMemoryWarning()
//    }
//    func fetchData()
//    {
//        imageSplashScreenRoot.isHidden=true
//        menuTitles=[]
//        stringArrayTitle=[String]()
//        stringArrayRssFirstFielsDescription=[String]()
//        varLinkNewsUpdate=[String]()
//        
//        stringArrayTitleSecond=[String]()
//        stringArrayRssSecondFielsDescription=[String]()
//        var databasePath : String
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        print("Device Database Path  \(databasePath)")
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            ////print("error opening database")
//        }
//        else
//        {
//            // self.Createtablecity()
//        }
//        //print(databasePath)
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil
//        {
//            ////print("Error: \(contactDB.lastErrorMessage())")
//        }
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        //print(stringArrayStore)
//        stringArrayStore=[String]()
//        //print(stringArrayStore)
//        
//        if (contactDB?.open())!
//        {
//            print("Contact db is open")
//            var querySQL = ""
//            querySQL = "SELECT distinct *  FROM GROUPMASTER"
//            let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
//            
//            var groupnames:String!=""
//            var muarrayTemp:NSMutableArray=NSMutableArray()
//            while results?.next() == true
//            {
//                let dd = NSMutableDictionary ()
//                
//                ////print("222222222222222222222222222222",NSUserDefaults.standardUserDefaults().valueForKey((results?.stringForColumn("grpId"))! as String)as? String)
//                let varGetValue:String! = UserDefaults.standard.value(forKey: (results?.string(forColumn: "grpId"))! as String)as? String
//                //var varGetValue:String! = "15/12/2017"
//                if(varGetValue != nil)
//                {
//                    
//                    let inputFormatter = DateFormatter()
//                    inputFormatter.dateFormat = "dd/MM/yyyy"
//                    let showDate = inputFormatter.date(from: varGetValue)
//                    // //print(showDate)
//                    
//                    inputFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
//                    let expireDate = inputFormatter.string(from: showDate!)
//                    //  //print(expireDate)
//                    
//                    //today date
//                    var varGetTodayDate:Foundation.Date! = Foundation.Date()
//                    var dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
//                    var date = dateFormatter.string(from: varGetTodayDate)
//                    // //print(date)
//                    
//                    
//                    var varGetDatePublishISLessThanExp = commonClassFunction().functionForCompareDatewithTime(date, stringSecondDate: expireDate)
//                    //print(date)
//                    //print(expireDate)
//                    //print(varGetDatePublishISLessThanExp)
//                    /*
//                     if(menuTitles.count==1)
//                     {
//                     varGetDatePublishISLessThanExp = commonClassFunction().functionForCompareDatewithTime("2018-06-30 12:00 AM", stringSecondDate: "2017-09-21 01:53 PM")
//                     //print(date)
//                     //print(expireDate)
//                     //print(varGetDatePublishISLessThanExp)
//                     }
//                     */
//                    
//                    
//                    if(varGetDatePublishISLessThanExp=="Ascending")
//                    {
//                        SVProgressHUD.dismiss()
//                        //--->>>>>>>>>>>>>>>>>> 1
//                        var grpId=(results?.string(forColumn: "grpId"))! as String
//                        var grpIdNew:String!=""
//                        if(grpId.hasPrefix("Optional("))
//                        {
//                            let result3 = String(grpId.dropFirst(10))
//                            grpIdNew = String(result3.dropLast(2))
//                        }
//                        else {grpIdNew = grpId}
//                        //--->>>>>>>>>>>>>>>>>> 2
//                        var grpName=(results?.string(forColumn: "grpName"))! as String
//                        var grpNameNew:String!=""
//                        if(grpName.hasPrefix("Optional("))
//                        {
//                            let result3 = String(grpName.dropFirst(10))
//                            grpNameNew = String(result3.dropLast(2))
//                            //print(result3)
//                            
//                        }
//                        else {grpNameNew = grpName}
//                        
//                        
//                        //print((results?.string(forColumn: "grpName"))! as String)
//                        //print(grpNameNew)
//                        //print(grpName)
//                        
//                        
//                        
//                        //--->>>>>>>>>>>>>>>>>> 3
//                        var grpImg=(results?.string(forColumn: "grpImg"))! as String
//                        var grpImgNew:String!=""
//                        if(grpImg.hasPrefix("Optional("))
//                        {
//                            let result3 = String(grpImg.dropFirst(10))
//                            grpImgNew = String(result3.dropLast(2))
//                        }
//                        else {grpImgNew = grpImg}
//                        //--->>>>>>>>>>>>>>>>>> 4
//                        let grpProfileid=(results?.string(forColumn: "grpProfileid"))! as String
//                        var grpProfileidNew:String!=""
//                        if(grpProfileid.hasPrefix("Optional("))
//                        {
//                            let result3 = String(grpProfileid.dropFirst(10))
//                            grpProfileidNew = String(result3.dropLast(2))
//                        }
//                        else {grpProfileidNew = grpProfileid}
//                        //--->>>>>>>>>>>>>>>>>> 5
//                        var isGrpAdmin=(results?.string(forColumn: "isGrpAdmin"))! as String
//                        var isGrpAdminNew:String!=""
//                        if(isGrpAdmin.hasPrefix("Optional("))
//                        {
//                            let result3 = String(isGrpAdmin.dropFirst(10))
//                            isGrpAdminNew = String(result3.dropLast(2))
//                        }
//                        else {isGrpAdminNew = isGrpAdmin}
//                        
//                        //--->>>>>>>>>>>>>>>>>> 6
//                        var myCategory=(results?.string(forColumn: "myCategory"))! as String
//                        var myCategoryNew:String!=""
//                        if(myCategory.hasPrefix("Optional("))
//                        {
//                            let result3 = String(myCategory.dropFirst(10))
//                            myCategoryNew = String(result3.dropLast(2))
//                        }
//                        else {myCategoryNew = myCategory}
//                        //--->>>>>>>>>>>>>>>>>> 7
//                        var notificationCount=(results?.string(forColumn: "notificationCount"))! as String
//                        var notificationCountNew:String!=""
//                        if(notificationCount.hasPrefix("Optional("))
//                        {
//                            let result3 = String(notificationCountNew.dropFirst(10))
//                            notificationCountNew = String(result3.dropLast(2))
//                        }
//                        else {notificationCountNew = notificationCount}
//                        
//                        
//                        //  dd.setValue((results?.stringForColumn("expiryDate"))! as String, forKey:"expiryDate")
//                        
//                        
//                        
//                        //(grpIdNew as AnyObject).replacingOccurrences(of: "", with: "")
//                        
//                        //print((grpNameNew as AnyObject).replacingOccurrences(of: "\"", with: ""))
//                        
//                        
//                        
//                        dd.setValue((grpIdNew as AnyObject).replacingOccurrences(of: "\"", with: ""), forKey:"grpId")
//                        dd.setValue((grpNameNew as AnyObject).replacingOccurrences(of: "\"", with: ""), forKey:"grpName")
//                        dd.setValue((grpImgNew as AnyObject).replacingOccurrences(of: "\"", with: ""), forKey:"grpImg")
//                        dd.setValue((grpProfileidNew as AnyObject).replacingOccurrences(of: "\"", with: ""), forKey:"grpProfileid")
//                        dd.setValue((isGrpAdminNew as AnyObject).replacingOccurrences(of: "\"", with: ""), forKey:"isGrpAdmin")
//                        dd.setValue((myCategoryNew as AnyObject).replacingOccurrences(of: "\"", with: ""), forKey:"myCategory")
//                        dd.setValue((notificationCountNew as AnyObject).replacingOccurrences(of: "\"", with: ""), forKey:"notificationCount")
//                        
//                        //groupnames
//                        
//                        var groupnamenew:String!=grpNameNew
//                        
//                        
//                        //print("1.",groupnamenew)
//                        //print("2.",groupnames)
//                        
//                        
//                        if(muarrayTemp.contains(groupnamenew))
//                        {
//                            
//                        }
//                        else
//                        {
//                            if(groupnames != groupnamenew)
//                            {
//                                stringArrayStore.append(grpNameNew)
//                                stringGroupImages.append(grpImgNew)
//                                menuTitles.add(dd)
//                                print(menuTitles)
//                                self.groupList.add(dd)
//                            }
//                            groupnames = grpNameNew
//                            muarrayTemp.add(groupnamenew)
//                        }
//                    }
//                }
//                else
//                {
//                    
//                    SVProgressHUD.dismiss()
//                    
//                    
//                    dd.setValue((results?.string(forColumn: "grpId"))! as String, forKey:"grpId")
//                    dd.setValue((results?.string(forColumn: "grpName"))! as String, forKey:"grpName")
//                    dd.setValue((results?.string(forColumn: "grpImg"))! as String, forKey:"grpImg")
//                    dd.setValue((results?.string(forColumn: "grpProfileid"))! as String, forKey:"grpProfileid")
//                    dd.setValue((results?.string(forColumn: "isGrpAdmin"))! as String, forKey:"isGrpAdmin")
//                    dd.setValue((results?.string(forColumn: "myCategory"))! as String, forKey:"myCategory")
//                    dd.setValue((results?.string(forColumn: "notificationCount"))! as String, forKey:"notificationCount")
//                    
//                    var groupnamenew:String!=(results?.string(forColumn: "grpName"))! as String
//                    
//                    
//                    //print(groupnamenew)
//                    //print(groupnames)
//                    
//                    
//                    if(muarrayTemp.contains(groupnamenew))
//                    {
//                        
//                    }
//                    else
//                    {
//                        if(groupnames != groupnamenew)
//                        {
//                            stringArrayStore.append((results?.string(forColumn: "grpName")!)! as String)
//                            stringGroupImages.append((results?.string(forColumn: "grpImg"))! as String)
//                            menuTitles.add(dd)
//                            print(menuTitles)
//                            self.groupList.add(dd)
//                        }
//                    }
//                    groupnames = (results?.string(forColumn: "grpName"))! as String
//                    muarrayTemp.add(groupnamenew)
//                }
//                
//                
//                
//            }
//            self.buttonOpacity.isHidden=true
//            /*555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555*/
//            var databasePath : String
//            let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//            // open database
//            databasePath = fileURL.path
//            var db: OpaquePointer? = nil
//            if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//            {
//                ////print("error opening database")
//            }
//            else
//            {
//                // self.Createtablecity()
//            }
//            //print(databasePath)
//            let contactDB = FMDatabase(path: databasePath as String)
//            if contactDB == nil
//            {
//                print("Error: \(contactDB!.lastErrorMessage())")
//            }
//            var muarraySecondSection:NSMutableArray=NSMutableArray()
//            var muarrayThirdSection:NSMutableArray=NSMutableArray()
//            var stringSecond=[String]()
//            var stringThird=[String]()
//            
//            for i in 00..<1
//            {
//                ////print(i)
//                ////print("Before=====================",stringArrayTitle.count)
//                ////print("Before=====================",stringArrayRssFirstFielsDescription.count)
//                //newsUpdateTitle , newsUpdateDescription,newsUpdateDate,isFeedFirstOrSecond
//                if (contactDB?.open())!
//                {
//                    var querySQL = ""
//                    querySQL = "SELECT * FROM NewsUpdate_Table Where isFeedFirstOrSecond = 'First' LIMIT 10"
//                    let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
//                    while results?.next() == true
//                    {
//                        let dd = NSMutableDictionary ()
//                        dd.setValue((results?.string(forColumn: "newsUpdateTitle"))! as String, forKey:"title")
//                        dd.setValue((results?.string(forColumn: "newsUpdateDescription"))! as String, forKey:"description")
//                        dd.setValue((results?.string(forColumn: "newsUpdateDate"))! as String, forKey:"date")
//                        dd.setValue((results?.string(forColumn: "link"))! as String, forKey:"link")
//                        stringArrayTitle.append((results?.string(forColumn: "newsUpdateTitle")!)! as String)
//                        stringArrayRssFirstFielsDescription.append((results?.string(forColumn: "newsUpdateDescription")!)! as String)
//                        varLinkNewsUpdate.append((results?.string(forColumn: "link")!)! as String)
//                        //print(dd)
//                        menuTitles.add(dd)
//                        print(menuTitles)
//                        muarrayRotaryBlogs.add(dd)  //News
//                    }
//                }
//            }
//            for j in 00..<1
//            {
//                if (contactDB?.open())!
//                {
//                    var querySQL = ""
//                    querySQL = "SELECT *  FROM NewsUpdate_Table Where isFeedFirstOrSecond = 'Second' LIMIT 10"
//                    
//                    //print(querySQL)
//                    
//                    let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
//                    while results?.next() == true
//                    {
//                        let dd = NSMutableDictionary ()
//                        dd.setValue((results?.string(forColumn: "newsUpdateTitle"))! as String, forKey:"title")
//                        dd.setValue((results?.string(forColumn: "newsUpdateDescription"))! as String, forKey:"description")
//                        dd.setValue((results?.string(forColumn: "newsUpdateDate"))! as String, forKey:"date")
//                        dd.setValue((results?.string(forColumn: "link"))! as String, forKey:"link")
//                        //stringArrayTitle = [(results?.stringForColumn("newsUpdateTitle")!)! as String]
//                        stringArrayTitleSecond.append((results?.string(forColumn: "newsUpdateTitle")!)! as String)
//                        stringArrayRssSecondFielsDescription.append((results?.string(forColumn: "newsUpdateDescription")!)! as String)
//                        varLinkBlogs.append((results?.string(forColumn: "link")!)! as String)
//                        //print(dd)
//                        menuTitles.add(dd)
//                        print(menuTitles)
//                        muarrauRotaryNews.add(dd) //Blogs
//                    }
//                }
//            }
//            self.btnMenu.isHidden=false
//            print("Section statement called")
//            sections = [
//                Section1(name: "Group",varLink:[""],des:[""] , items: stringArrayStore,imagePic: stringGroupImages),
//                Section1(name: "News And Updates", varLink: varLinkNewsUpdate,des:stringArrayRssFirstFielsDescription , items: stringArrayTitle,imagePic: [""]),
//                Section1(name: "Blogs",varLink:varLinkBlogs,des:stringArrayRssSecondFielsDescription , items: stringArrayTitleSecond ,imagePic: [""]),]
//            
//            print("sections is \(sections)")
//            self.loaderClass.window = nil
//            self.imageSplashScreenRoot.isHidden=true
//            labelFirstTimeSyncMessage.isHidden=true
//            buttonOpticity.isHidden=true
//            DispatchQueue.main.async {
//                self.myCollectionView.reloadData()
//            }
//            
//            UserDefaults.standard.setValue("1", forKey: "Session_RssFeedFirstTime")
//            /*55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555*/
//            
//            ////print("After=====================",stringArrayTitle.count)
//            ////print("After=====================",stringArrayTitle.count)
//            ////print("After=====================",stringArrayTitleSecond.count)
//            ////print(menuTitles.count)
//        }
//        self.loaderClass.window = nil
//        myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: (self.myScrollView.frame.size.height))
//        
//    }
//    
////  {
////        viewloadandwillappearCount=0
////
////        var dict:NSDictionary!
////        viewPopUp.isHidden=true
////        UserDefaults.standard.setValue("No", forKey: "session_IsFirstTime")
////        var grp:GroupResult!
////        //print(menuTitles)
////        dict = menuTitles[indexPath.row] as! NSDictionary
////        print(dict)
////        let varGetId=(dict.object(forKey: "grpId") as! String)
////        UserDefaults.standard.setValue(varGetId, forKey: "session_GetGroupId")
////        var muarray:NSArray=NSArray()
////
////        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainDash") as! MainDashboardViewController
////        let isGroupAdminOrNot = dict.object(forKey: "isGrpAdmin") as! String
////        print("isGroupAdminOrNot c :: \(isGroupAdminOrNot)")
////        secondViewController.grpDetailPrevious=dict as NSDictionary
////
////        //print(indexPath.row)
////
////        // //print(muarrayNotificationCount.objectAtIndex(indexPath.row) as! NSMutableArray)
////        // secondViewController.muarrayNotificationCount=muarrayNotificationCount
////        secondViewController.isGroupAdmin = dict.object(forKey: "isGrpAdmin") as! String
////        secondViewController.isCategory=dict.object(forKey: "myCategory") as! String
////        secondViewController.varGetId=varGetId
////        print(dict)
////        secondViewController.groupUniqueName = dict.object(forKey: "grpName") as! String // Rajendra
////
////        //print(varGetId)
////        //group admin
////        UserDefaults.standard.set(dict.object(forKey: "isGrpAdmin") as! String, forKey: "isAdmin")
////        UserDefaults.standard.setValue(dict.object(forKey: "grpProfileid") as! String, forKey: "session_grpProfileid")
////        secondViewController.varGetGroupId = dict.object(forKey: "grpId") as! String // Rajendra
////        self.navigationController?.pushViewController(secondViewController, animated: true)
////    }
//    
//    @IBAction func userdetailProfileBtnClicked(_ sender: Any) {
////        UserDefaults.standard.set("no", forKey: "picadded")
//        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
//        
////        Optional("2765")
////        Optional("354379")
////
//        var dict:NSDictionary!
//        
//        dict = menuTitles[0] as! NSDictionary
//        print(menuTitles)
//        print(dict)
//        profVC.grpID = (dict.object(forKey: "grpId") as! String)
//       print(((UserDefaults.standard.string(forKey: "grpId")) as! String))
////        profVC.grpID =  self.userProfileDict["fk_group_master_id"] as? String
////        profVC.grpID =  "2765" //nameTitles[indexPath.row]
//        profVC.isUserProfile = "yes"
//        profVC.profileId = (dict.object(forKey: "grpProfileid") as! String)
//        print(profVC.profileId)
////        profVC.isAdmin = "Yes"
//        profVC.isAdmin = dict.object(forKey: "isGrpAdmin") as! String
//
//        profVC.NormalMemberOrAdmin = "ForSelf"
//        profVC.isCategory="1"
//        let varProfileID = UserDefaults.standard.value(forKey: "session_grpProfileid") as? String
//        print(varProfileID)
////           profVC.isAdmin = "Yes"
//           profVC.NormalMemberOrAdmin="ForSelf"
//
//        profVC.isAdmin = dict.object(forKey: "isGrpAdmin") as! String
//        profVC.isCategory = dict.object(forKey: "myCategory") as! String
//
//        print(dict)
//
//        UserDefaults.standard.set(dict.object(forKey: "isGrpAdmin") as! String, forKey: "isAdmin")
//
//        self.navigationController?.pushViewController(profVC, animated: true)
//    }
//    
//    
//    
//    
//    @IBAction func btnNotificationClickEvent(_ sender: Any) {
//        let viewController=self.storyboard?.instantiateViewController(withIdentifier: "AllNotificationViewController") as! AllNotificationViewController
//        self.navigationController?.pushViewController(viewController, animated: false)
//    }
//    
//    @IBAction func btnRefreshClickEvent(_ sender: Any) {
//        buttonRefreshClickEvent()
//    }
//    
//    @IBAction func btnMenuClickEvent(_ sender: Any) {
//        
//        backClicked()
//    }
//    
//    @IBAction func btnCloseAddClickEvent(_ sender: Any) {
//        let completeURL:String=baseUrl+UpdateMobilePupupflag
//        let mainMemberID:String = UserDefaults.standard.string(forKey: "masterUID") ?? ""
//        let parameters:[String:String]=["FkmasterID":mainMemberID,"Type":"1"]
//        self.addView.isHidden=true
//
//        Alamofire.request(completeURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON(){
//                    response in
//           switch response.result
//           {
//             case .success:
//            print("Popup Response Close Add is \(response.result.value)")
//             break
//         case .failure:
//           break
//             }
//       }
//    }
//
//    @IBAction func btnWatchLaterClickEvent(_ sender: Any) {
//        let completeURL:String=baseUrl+UpdateMobilePupupflag
//        let mainMemberID:String = UserDefaults.standard.string(forKey: "masterUID") ?? ""
//        let parameters:[String:String]=["FkmasterID":mainMemberID,"Type":"2"]
//
//        self.addView.isHidden=true
//
//        Alamofire.request(completeURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON(){
//                    response in
//           switch response.result
//           {
//             case .success:
//            print("Popup Response Watch Later is \(response.result.value)")
//             break
//         case .failure:
//
//           break
//             }
//       }
//    }
//    
//    
//    
//    //1.
//    @IBAction func buttonSettingClickEvent(_ sender: AnyObject)
//    {
//        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "settings") as UIViewController, animated: true)
//        viewPopUp.isHidden=true
//    }
//    //2.
//    @IBAction func buttonAboutUSClickEvent(_ sender: AnyObject)
//    {
//        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController, animated: true)
//        viewPopUp.isHidden=true
//    }
//    //3.
//    @IBAction func buttonCreateEntityClickEvent(_ sender: AnyObject)
//    {
//        viewPopUp.isHidden=true
//        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "CreateEntityViewController") as! CreateEntityViewController, animated: true)
//    }
//    //4.
//    @IBAction func creategrpButtonAction(_ sender: AnyObject){
//        let defaults = UserDefaults.standard
//        defaults.set("", forKey: "eventAddress")
//        defaults.set("", forKey: "eventLat")
//        defaults.set("", forKey: "eventLon")
//        defaults.synchronize()
//        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "create_group") as UIViewController, animated: true)
//    }
//    
//    
//    @IBAction func btnRotaryWorldAction(_ sender: Any) {
//        let viewController=self.storyboard?.instantiateViewController(withIdentifier: "RotaryWorldViewController") as! RotaryWorldViewController
//        self.navigationController?.pushViewController(viewController, animated: true)
//    }
//    
//    @IBAction func btnRotaryIndiaAction(_ sender: Any) {
//        let viewController=self.storyboard?.instantiateViewController(withIdentifier: "RotaryIndiaViewController") as! RotaryIndiaViewController
//        self.navigationController?.pushViewController(viewController, animated: true)
//    }
//
//    
//    //MARK:- Curd Operation
//    //MARK:- function all
//    func buttonAboutUsClickEvent()
//    {
//        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController, animated: true)
//    }
//    //MARK:- function main for manage everything
//    /*-----------------------------------------------------------------Code by Rajendra Jat--------------------------------------------*/
//    //MARK:- in future can be used there below code
//    /*--if coming new update insert delete data then set screen from inittiallly--------------------------------------*/
//    /*----root view controller----------------------------------------------------*/
//    func functionForFetchingNotificationCountList()
//    {
//
//        var muarray:NSMutableArray=NSMutableArray()
//        var muarrayGroupId:NSMutableArray!=NSMutableArray()
//        appDelegate = UIApplication.shared.delegate as! AppDelegate
//        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//        {
//            var arrayNotificationCount:NSArray=NSArray()
//            let completeURL = baseUrl+touchBase_fetchNotificationCount
//            let parameterst = [
//                k_API_masterUID : UserDefaults.standard.string(forKey: "masterUID") as AnyObject
//            ]
//            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
//                //=> Handle server response
//                //print(response)
//                
//                var varGetValueServerError = response.object(forKey: "serverError")as? String
//                
//                if(varGetValueServerError == "Error")
//                {
//                    SVProgressHUD.dismiss()
//                    
//                }
//                else
//                {
//                    if((response.value(forKey: "TBGroupResult")! as AnyObject).value(forKey: "status") as! String == "1")
//                    {
//                    }
//                    else
//                    {
//                        for i in 0..<((response.value(forKey: "TBGroupResult")! as AnyObject).value(forKey: "GrpCountList")! as AnyObject).count
//                        {
//                            let letGetEntityId=((((response.value(forKey: "TBGroupResult")! as AnyObject).value(forKey: "GrpCountList")! as AnyObject).value(forKey: "groupId")! as AnyObject).object(at: i))
//                            let letTotalCount=((((response.value(forKey: "TBGroupResult")! as AnyObject).value(forKey: "GrpCountList")! as AnyObject).value(forKey: "totalCount")! as AnyObject).object(at: i))
//                            let letEntityModuleIdNotificationCount=(((response.value(forKey: "TBGroupResult")! as AnyObject).value(forKey: "GrpCountList")! as AnyObject).value(forKey: "ModCount")! as AnyObject).object(at: i)
//                            muarray.add(letEntityModuleIdNotificationCount)
//                            muarrayGroupId.add(letGetEntityId)
//                            self.mudict.setValue(letTotalCount, forKey: letGetEntityId as! String)
//                            
//                        }
//                        UserDefaults.standard.setValue(self.mudict, forKey: "session_notificationCount")
//                        UserDefaults.standard.setValue(muarray, forKey: "session_notificationCountForModule")
//                        UserDefaults.standard.setValue(muarrayGroupId, forKey: "session_EntityId")
//                    }
//                }
//            })
//            
//        }
//        else
//        {
//            mudict=NSMutableDictionary()
//            UserDefaults.standard.setValue(mudict, forKey: "session_notificationCount")
//            muarray=NSMutableArray()
//            UserDefaults.standard.setValue(muarray, forKey: "session_notificationCountForModule")
//            muarrayGroupId=NSMutableArray()
//            //print(muarrayGroupId)
//            UserDefaults.standard.setValue(muarrayGroupId, forKey: "session_EntityId")
//            //print(muarrayGroupId)
//        }
//    }
//    
//    func UpdateDataInlocal (_ memberID: NSString,memberMainId:NSString)
//    {
//        var databasePath : String
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            ////print("error opening database")
//        }
//        else
//        {
//            // self.Createtablecity()
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil
//        {
//            ////print("Error: \(contactDB.lastErrorMessage())")
//        }
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        if (contactDB?.open())!
//        {
//            //print(stringArrayStore)
//            let insertSQL = "UPDATE  GROUPMASTER SET myCategory='0' WHERE grpProfileid = '\(memberID)'  "
//            //print(insertSQL)
//            let result = contactDB?.executeStatements(insertSQL)
//            
//            if (result == nil)
//            {
//                ////print("ErrorAi: \(contactDB?.lastErrorMessage())")
//            }
//            else
//            {
//                ////print("success saved")
//                //print(databasePath);
//            }
//        }
//        else
//        {
//            ////print("Error: \(contactDB?.lastErrorMessage())")
//        }
//    }
//    func GetAllGroupListSync()
//    {
//        appDelegate = UIApplication.shared.delegate as! AppDelegate
//        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//        {
//            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//            var updatedOn =  String ()
//            let defaults = UserDefaults.standard
//            let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
//            updatedOn = "1970-01-01 00:00:00"
//            if let str = defaults.value(forKey: Updatedefault) as! String?
//            {
//                print("updated on \(str)")
////                updatedOn = str
//                updatedOn = "1970-01-01 00:00:00"
//            }
//            else
//            {
//                print("New app install")
//                updatedOn = "1970-01-01 00:00:00"
//                // SVProgressHUD.show()
//            }
//            do {
//                var varGetMobileNumber = UserDefaults.standard.value(forKey: "session_Mobile_Number")as! String
//                var varGetCountryCode = UserDefaults.standard.value(forKey: "session_Country_Code")as! String
//                var varGetLoginType = UserDefaults.standard.value(forKey: "session_Login_Type")as! String
//                let url = baseUrl+"Group/GetAllGroupListSync"
//                var params: [String: String] =
//                ["masterUID": mainMemberID!,
//                 "imeiNo": UIDevice.current.identifierForVendor!.uuidString,
//                 "updatedOn": updatedOn,
//                 "loginType": varGetLoginType,
//                 "mobileNo": varGetMobileNumber,
//                 "countryCode": varGetCountryCode
//                ]
//                print(url)
//                print(params)
//                print("Fetching data of dashboard from Server... @ \(Date())")
//                if(viewloadandwillappearCount==2)
//                {
//                }
//                else
//                {
//                    SVProgressHUD.dismiss()
//                }
//                
//                Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
//                    switch response.result {
//                    case .success:
//                        if let value = response.result.value {
//                            let dic = response.result.value!
//                            let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
//                            let jsonString = String(data: jsonData!, encoding: .utf8)!
//                            if(response==nil)
//                            {
//                            }
//                            else
//                            {
//                                let dd = response.result.value as! NSDictionary
//                                print("Session result 1 \(dd)")
//                                if (dd.object(forKey: "status") as! String == "0"){
//                                    if ((dd.object(forKey: "updatedOn")) != nil)
//                                    {
//                                        UserDefaults.standard.set(dd.object(forKey: "updatedOn"), forKey: Updatedefault)
//                                    }
//                                    self.arrarrNewGroupList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "GroupList")! as AnyObject).object(forKey: "NewGroupList")) as! NSArray
//                                    self.arrDeleteGroupList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "GroupList")! as AnyObject).object(forKey: "DeletedGroupList")) as! NSArray
//                                    let  arrUpdateGroupList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "GroupList")! as AnyObject).object(forKey: "UpdatedGroupList")) as! NSArray
//                                    self.stringArrayTitle=[String]()
//                                    self.stringArrayRssFirstFielsDescription=[String]()
//                                    self.stringArrayTitleSecond=[String]()
//                                    self.stringArrayRssSecondFielsDescription=[String]()
//                                    //delete group data from local database
//                                    if(self.arrDeleteGroupList.count > 0 || self.arrarrNewGroupList.count > 0 || arrUpdateGroupList.count>0)
//                                    {
//                                        //delete group data from local database
//                                        if(self.arrDeleteGroupList.count > 0)
//                                        {
//                                             self.DeleteDataInlocal(self.arrDeleteGroupList)
//                                        }
//                                        //update group data from local database
//                                        if(arrUpdateGroupList.count > 0)
//                                        {
//                                            self.UpdateDataInlocal(arrUpdateGroupList)
//                                        }
//                                        if(self.arrarrNewGroupList.count > 0)
//                                        {
//                                            //save group data from local database
//                                            self.SaveDataInlocal(self.arrarrNewGroupList)
//                                            //print(self.arrarrNewGroupList)
//                                            let arrModuleList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "ModuleList")! as AnyObject).object(forKey: "NewModuleList")) as! NSArray
//                                            let arrDeleteList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "ModuleList")! as AnyObject).object(forKey: "DeletedModuleList")) as! NSArray
//                                            let arrUpdateList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "ModuleList")! as AnyObject).object(forKey: "UpdatedModuleList")) as! NSArray
//                                            //print()
//                                            if(arrModuleList.count > 0)
//                                            {
//                                                //////print("arrModuleList \(arrModuleList)")
//                                                self.SaveModuleDataInlocal(arrModuleList)
//                                            }
//                                            else  if(arrUpdateList.count > 0)
//                                            {
//                                                self.UpdateModuleDataInlocal(arrUpdateList)
//                                            }
//                                            if(arrDeleteList.count > 0)
//                                            {
//                                                self.DeleteModuleDataInlocal(arrDeleteList)
//                                            }
//                                        }
//                                        self.imageSplashScreenRoot.isHidden=true
//                                        print("Fetching data of dashboard... @ \(Date())")
//                                        self.fetchData()
//                                    }
//                                    else
//                                    {
//                                        self.imageSplashScreenRoot.isHidden=true
//                                        self.loaderClass.window = nil
//                                        let arrModuleList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "ModuleList")! as AnyObject).object(forKey: "NewModuleList")) as! NSArray
//                                        let arrDeleteList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "ModuleList")! as AnyObject).object(forKey: "DeletedModuleList")) as! NSArray
//                                        let arrUpdateList = (((dd.object(forKey: "Result")! as AnyObject).object(forKey: "ModuleList")! as AnyObject).object(forKey: "UpdatedModuleList")) as! NSArray
//                                        
//                                        if(arrModuleList.count > 0)
//                                        {
//                                            self.SaveModuleDataInlocal(arrModuleList)
//                                        }
//                                        if(arrUpdateList.count > 0)
//                                        {
//                                            print("UpdateModuleDataInlocal \(arrUpdateList)")
//                                            self.UpdateModuleDataInlocal(arrUpdateList)
//                                        }
//                                        if(arrDeleteList.count > 0)
//                                        {
//                                            self.DeleteModuleDataInlocal(arrDeleteList)
//                                        }
//                                        SVProgressHUD.dismiss()
//                                        //--------------
//                                        var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//                                        var updatedOn =  String ()
//                                        let defaults = UserDefaults.standard
//                                        let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
//                                        updatedOn = "1970-01-01 00:00:00"
//                                        if let str = defaults.value(forKey: Updatedefault) as! String?
//                                        {
//                                            self.loaderClass.window = nil
//                                            self.imageSplashScreenRoot.isHidden=true
//                                            self.labelFirstTimeSyncMessage.isHidden=true
//                                            self.buttonOpticity.isHidden=true
//                                        }
//                                        else
//                                        {
//                                            updatedOn = "1970-01-01 00:00:00"
//                                        }
//                                    }
//                                }
//                                else if (dd.object(forKey: "status") as! String == "2")
//                                {
//                                    //----------------------------------------------
//                                    //---delete old value from server in case of Birthday Anniversary Event start
//                                    self.DELETEDashboard_BirthAnniEvent_table_New()
//                                    //---delete old value from server in case of Birthday Anniversary Event ens
//                                    //-------------------------------------------------
//                                    // self.appDelegate.showAlsertView()
//                                    self.imageSplashScreenRoot.isHidden=true
//                                    self.loaderClass.window = nil
//                                    UserDefaults.standard.removeObject(forKey: "updatedOn")
//                                    let alert=UIAlertController(title: "Rotary India", message:dd.object(forKey: "message") as! String, preferredStyle: UIAlertController.Style.alert);
//                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
//                                        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
//                                        self.appDelegate.setMobileViewAsRoot()
//                                    }));
//                                    self.present(alert, animated: true, completion: nil);
//                                    self.labelFirstTimeSyncMessage.isHidden=true
//                                    self.buttonOpticity.isHidden=true
//                                }
//                                self.refreshControl?.endRefreshing()
//                            }
//                        }
//                    case .failure(let error):
//                        print("API GetAllGroupListSync failed due to \(error)")
//                        break
//                    }
//                }
//                self.loaderClass.window = nil
//                self.loaderClass.window = nil
//                self.imageSplashScreenRoot.isHidden=true
//                self.labelFirstTimeSyncMessage.isHidden=true
//                self.buttonOpticity.isHidden=true
//            }
//        }
//        else
//        {
//            self.imageSplashScreenRoot.isHidden=true
//            self.loaderClass.window = nil
//            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//            let defaults = UserDefaults.standard
//            let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
//            if let str = defaults.value(forKey: Updatedefault) as! String?
//            {
//                self.appDelegate = UIApplication.shared.delegate as! AppDelegate
//            }
//            else
//            {
//            }
//        }
//    }
//    
//    //MARK:- Group master insert update delete (main table)
//    func SaveDataInlocal (_ arrdata:NSArray)
//    {
//        var databasePath : String
//        ////print(arrdata);
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            ////print("error opening database")
//        }
//        else
//        {
//            // self.Createtablecity()
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil
//        {
//            ////print("Error: \(contactDB.lastErrorMessage())")
//        }
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        if (contactDB?.open())!
//        {
//            for i in 0 ..< arrdata.count {
//                let  dict = arrdata[i] as! NSDictionary
//                
//                // //print(mudict)
//                let letGetCount=mudict.value(forKey: dict.object(forKey: "grpId") as! String)
//                //print(letGetCount)
//                //print(stringArrayStore)
//                
//                
//                
//                
//                
//                //--->>>>>>>>>>>>>>>>>> 1
//                var masterUID=mainMemberID as! String
//                var masterUIDNew:String!=""
//                if(masterUID.hasPrefix("Optional("))
//                {
//                    let result3 = String(masterUID.dropFirst(9))
//                    masterUIDNew = String(result3.dropLast(1))
//                }
//                else
//                {
//                    masterUIDNew = masterUID
//                }
//                //--->>>>>>>>>>>>>>>>>> 2
//                var groupId:String!=dict.object(forKey: "grpId") as! String
//                var groupIdNew:String!=""
//                if(groupId.hasPrefix("Optional("))
//                {
//                    let result3 = String(groupId.dropFirst(9))
//                    groupIdNew = String(result3.dropLast(1))
//                }
//                else
//                {
//                    groupIdNew = groupId
//                }
//                //--->>>>>>>>>>>>>>>>>> 3
//                var grpName:String!=dict.object(forKey: "grpName") as! String
//                var groupNameNew:String!=""
//                if(grpName.hasPrefix("Optional("))
//                {
//                    let result3 = String(grpName.dropFirst(9))
//                    groupNameNew = String(result3.dropLast(1))
//                }
//                else
//                {
//                    groupNameNew = grpName
//                }
//                //--->>>>>>>>>>>>>>>>>> 4
//                var grpImg:String!=dict.object(forKey: "grpImg") as! String
//                var grpImgNew:String!=""
//                if(grpImg.hasPrefix("Optional("))
//                {
//                    let result3 = String(grpImg.dropFirst(9))
//                    grpImgNew = String(result3.dropLast(1))
//                }
//                else
//                {
//                    grpImgNew = grpImg
//                }
//                //--->>>>>>>>>>>>>>>>>> 5
//                var grpProfileId:String!=dict.object(forKey: "grpProfileId") as! String
//                var grpProfileIdNew:String!=""
//                if(grpProfileId.hasPrefix("Optional("))
//                {
//                    let result3 = String(grpProfileId.dropFirst(9))
//                    grpProfileIdNew = String(result3.dropLast(1))
//                }
//                else
//                {
//                    grpProfileIdNew = grpProfileId
//                }
//                //--->>>>>>>>>>>>>>>>>> 6
//                var myCategory:String!=dict.object(forKey: "myCategory") as! String
//                var myCategoryNew:String!=""
//                if(myCategory.hasPrefix("Optional("))
//                {
//                    let result3 = String(myCategory.dropFirst(9))
//                    myCategoryNew = String(result3.dropLast(1))
//                }
//                else
//                {
//                    myCategoryNew = myCategory
//                }
//                //--->>>>>>>>>>>>>>>>>> 7
//                var isGrpAdmin:String!=dict.object(forKey: "isGrpAdmin") as! String
//                var isGrpAdminNew:String!=""
//                if(isGrpAdmin.hasPrefix("Optional("))
//                {
//                    let result3 = String(isGrpAdmin.dropFirst(9))
//                    isGrpAdminNew = String(result3.dropLast(1))
//                }
//                else
//                {
//                    isGrpAdminNew = isGrpAdmin
//                }
//                //--->>>>>>>>>>>>>>>>>> 8
//                var notificationCounts:String!="0" as! String
//                var notificationCountsNew:String!=""
//                if(notificationCounts.hasPrefix("Optional("))
//                {
//                    let result3 = String(notificationCounts.dropFirst(9))
//                    notificationCountsNew = String(result3.dropLast(1))
//                }
//                else
//                {
//                    notificationCountsNew = notificationCounts
//                }
//                
//                
//                let insertSQL = "INSERT INTO GROUPMASTER (masterUID, grpId, grpName , grpImg ,grpProfileid, myCategory, isGrpAdmin,notificationCount) VALUES ('\(masterUIDNew as! String )', '\(groupIdNew as! String)', '\(groupNameNew as! String)', '\(grpImgNew as! String)', '\(grpProfileIdNew as! String)', '\(myCategoryNew as! String)', '\(isGrpAdminNew as! String)','\(notificationCountsNew as! String)')"
//                
//                
//                //'\(notificationCountsNew)'
//                UserDefaults.standard.setValue(dict.object(forKey: "expiryDate") as! String, forKey: groupIdNew)
//                
//                print(insertSQL)
//                let result = contactDB?.executeStatements(insertSQL)
//                if (result == nil)
//                {
//                    ////print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                }
//                else
//                {
//                    ////print("success saved")
//                    //print(databasePath);
//                }
//            }
//        }
//        else
//        {
//            ////print("Error: \(contactDB?.lastErrorMessage())")
//        }
//    }
//    //MARK:-
//    func UpdateDataInlocal (_ arrdata:NSArray)
//    {
//        var databasePath : String
//        ////print(arrdata);
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
//            ////print("error opening database")
//        }else{
//            // self.Createtablecity()
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil
//        {
//            ////print("Error: \(contactDB.lastErrorMessage())")
//        }
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        if (contactDB?.open())! {
//            for i in 0 ..< arrdata.count
//            {
//                
//                //print(stringArrayStore)
//                let  dict = arrdata[i] as! NSDictionary
//                let insertSQL1 = "UPDATE  GROUPMASTER SET grpName='\(dict.object(forKey: "grpName") as! String!)',grpImg='\(dict.object(forKey: "grpImg") as! String!)',grpProfileid='\(dict.object(forKey: "grpProfileId") as! String!)',myCategory='\(dict.object(forKey: "myCategory") as! String!)',isGrpAdmin='\(dict.object(forKey: "isGrpAdmin") as! String!)' WHERE grpId = '\(dict.object(forKey: "grpId") as! String)'  "
//                print(insertSQL1)
//                
//                
//                UserDefaults.standard.setValue(dict.object(forKey: "expiryDate") as! String, forKey: dict.object(forKey: "grpId") as! String)
//                
//                
//                
//                
//                let result1 = contactDB?.executeStatements(insertSQL1)
//                if (result1 == nil)
//                {
//                    ////print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                }
//                else
//                {
//                    ////print("success saved")
//                    //print(databasePath);
//                }
//            }
//        }
//        else
//        {
//            ////print("Error: \(contactDB?.lastErrorMessage())")
//        }
//    }
//    //MARK:-
//    func DeleteDataInlocal (_ arrdata:NSArray){
//        var databasePath : String
//        // //print(arrdata);
//        
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
//            ////print("error opening database")
//        }else{
//            // self.Createtablecity()
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil {
//            ////print("Error: \(contactDB.lastErrorMessage())")
//        }
//        
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        if (contactDB?.open())! {
//            for i in 0 ..< arrdata.count {
//                let  dict = arrdata[i] as! NSDictionary
//                let insertSQL = "DELETE FROM GROUPMASTER WHERE grpId = '\(dict.object(forKey: "grpId") as! String)'"
//                print(insertSQL)
//                UserDefaults.standard.setValue(nil, forKey: dict.object(forKey: "grpId") as! String)
//                let result = contactDB?.executeStatements(insertSQL)
//                
//                if (result == nil) {
//                    ////print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                } else {
//                    ////print("success saved")
//                    //print(databasePath);
//                }
//                
//                /////////////----------------------------------------
//                let insertSQLr = "DELETE FROM MODULE_DATA_MASTER WHERE groupId = '\(dict.object(forKey: "grpId") as! String)'"
//                //print(insertSQLr)
//                
//                let resultr = contactDB?.executeStatements(insertSQLr)
//                if (resultr == nil)
//                {
//                    ////print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                }
//                else
//                {
//                    ////print("success saved")
//                    //print(databasePath);
//                }
//                ////////////---------------------------------------------
//                
//                
//                
//                
//            }
//            
//        } else {
//            ////print("Error: \(contactDB?.lastErrorMessage())")
//        }
//        contactDB?.close()
//    }
//    
//    func UpdateModuleDataInlocal (_ arrdata:NSArray)
//    {
//        
//        let varGetValue = UserDefaults.standard.value(forKey: "session_MaintainNewAddingModuleWhenFirstTimeAppInstalled") as! String
//        
//        if(varGetValue=="Yes")
//        {
//            UserDefaults.standard.setValue("no", forKey: "session_MaintainNewAddingModuleWhenFirstTimeAppInstalled")
//        }
//        else
//        {
//            var databasePath : String
//            //print(arrdata);
//            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//            
//            let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//            // open database
//            databasePath = fileURL.path
//            var db: OpaquePointer? = nil
//            if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//            {
//                ////print("error opening database")
//            }
//            else
//            {
//                // self.Createtablecity()
//            }
//            let contactDB = FMDatabase(path: databasePath as String)
//            if contactDB == nil
//            {
//                ////print("Error: \(contactDB.lastErrorMessage())")
//            }
//            //print(databasePath)
//            
//            if (contactDB?.open())!
//            {
//                
//                //---code by Rajendr Jat if any changes in module then delete all data that belong to particular group id
//               
//                for i in 0 ..< arrdata.count
//                {
//                let  dict = arrdata[i] as! NSDictionary
//                let insertSQL1 = "DELETE FROM MODULE_DATA_MASTER WHERE groupModuleId = '\(dict.object(forKey: "groupModuleId") as! String)'"
//                print("Update module list query = \(insertSQL1)")
//                let result1 = contactDB?.executeStatements(insertSQL1)
//                if (result1 == nil)
//                {
//                print("ErrorAi update: \(contactDB?.lastErrorMessage())")
//                }
//                else
//                {
//                    print("success update module list.")
//                    //print(databasePath);
//                }
//              
//                   // let  dict = arrdata[i] as! NSDictionary
//                    // let varGetModuleId=functionForAddingCounting((dict.object(forKey: "groupId") as! String), stringModuleId: (dict.object(forKey: "moduleId") as! String ))
//                    let varGetModuleId = "0"
//                    
//                    //print(varGetModuleId)
//                    let insertSQL = "INSERT INTO MODULE_DATA_MASTER (masterUID, groupModuleId, groupId , moduleId ,moduleName, moduleStaticRef, image,moduleOrderNo,notificationCount, flag, linkUrl) VALUES ('\(mainMemberID!)', '\(dict.object(forKey: "groupModuleId") as! String)', '\(dict.object(forKey: "groupId") as! String)', '\(dict.object(forKey: "moduleId") as! String )', '\(dict.object(forKey: "moduleName") as! String)', '\(dict.object(forKey: "moduleStaticRef") as! String)', '\(dict.object(forKey: "image") as! String)','\(dict.object(forKey: "moduleOrderNo") as! String)',\(varGetModuleId),'\(dict.object(forKey: "flag") as! String)','\(dict.object(forKey: "link_url") as! String)')"
//                    print("Insert module query= \(insertSQL)")
//                    let result = contactDB?.executeStatements(insertSQL)
//                    if (result == nil)
//                    {
//                        print("ErrorAi insert : \(contactDB?.lastErrorMessage())")
//                    }
//                    else
//                    {
//                        //print("success saved")
//                        //print(databasePath);
//                    }
//                }
//                // self.buttonOpacity.hidden=true
//            } else {
//                ////print("Error: \(contactDB?.lastErrorMessage())")
//            }
//            
//            contactDB?.close()
//        }
//    }
//    
//    /*--------update module in end---------------------------------------------------------------------------------------------------------------------*/
//    func DeleteModuleDataInlocal (_ arrdata:NSArray)
//    {
//        var databasePath : String
//        //print(arrdata);
//        
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            ////print("error opening database")
//        }
//        else
//        {
//            // self.Createtablecity()
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil {
//            ////print("Error: \(contactDB.lastErrorMessage())")
//        }
//        
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        if (contactDB?.open())!
//        {
//            for i in 0 ..< arrdata.count
//            {
//                let  dict = arrdata[i] as! NSDictionary
//                let insertSQL = "DELETE FROM MODULE_DATA_MASTER WHERE groupModuleId = '\(dict.object(forKey: "groupModuleId") as! String)'"
//                //print(insertSQL)
//                
//                let result = contactDB?.executeStatements(insertSQL)
//                if (result == nil)
//                {
//                    ////print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                }
//                else
//                {
//                    ////print("success saved")
//                    //print(databasePath);
//                }
//            }
//            
//        }
//        else
//        {
//            ////print("Error: \(contactDB?.lastErrorMessage())")
//        }
//    }
//    
//    func SaveModuleDataInlocal (_ arrdata:NSArray)
//    {
//        var databasePath : String
//        //print(arrdata);
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            ////print("error opening database")
//        }
//        else
//        {
//            // self.Createtablecity()
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil
//        {
//            ////print("Error: \(contactDB.lastErrorMessage())")
//        }
//        //print(databasePath)
//        
//        if (contactDB?.open())!
//        {
//            for i in 0 ..< arrdata.count
//            {
//                let  dict = arrdata[i] as! NSDictionary
//                // let varGetModuleId=functionForAddingCounting((dict.object(forKey: "groupId") as! String), stringModuleId: (dict.object(forKey: "moduleId") as! String ))
//                
//                let varGetModuleId = "0"
//                var staticRef = dict.object(forKey: "moduleStaticRef") ?? ""
//                let insertSQL1 = "DELETE FROM MODULE_DATA_MASTER WHERE groupModuleId = '\(dict.object(forKey: "groupModuleId") as! String)'"
//                print("Insert module list query = \(insertSQL1)")
//                let result1 = contactDB?.executeStatements(insertSQL1)
//                if (result1 == nil)
//                {
//                print("ErrorAi update: \(contactDB?.lastErrorMessage())")
//                }
//                else
//                {
//                    print("success update module list.")
//                    //print(databasePath);
//                }
//                
//                //print(varGetModuleId)
//                let insertSQL = "INSERT INTO MODULE_DATA_MASTER (masterUID, groupModuleId, groupId , moduleId ,moduleName, moduleStaticRef, image,moduleOrderNo,notificationCount,flag,linkUrl) VALUES ('\(mainMemberID!)', '\(dict.object(forKey: "groupModuleId") as! String)', '\(dict.object(forKey: "groupId") as! String)', '\(dict.object(forKey: "moduleId") as! String )', '\(dict.object(forKey: "moduleName") as! String)', '\(dict.object(forKey: "moduleStaticRef") ?? "")', '\(dict.object(forKey: "image") as! String)','\(dict.object(forKey: "moduleOrderNo") as! String)','\(varGetModuleId)','\(dict.object(forKey: "flag") as! String)','\(dict.object(forKey: "link_url") as! String)')"
//                print(insertSQL)
//                if let adminModule = dict.object(forKey: "moduleName") as? String
//                {
//                    if adminModule=="Admin"
//                    {
//                print("New Admin Module insertSQL:: \(insertSQL)")
//                    }
//                }
//                let result = contactDB?.executeStatements(insertSQL)
//                if (result == nil)
//                {
//                    ////print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                }
//                else
//                {
//                    ////print("success saved")
//                    //print(databasePath);
//                }
//            }
//            // self.buttonOpacity.hidden=true
//        } else {
//            ////print("Error: \(contactDB?.lastErrorMessage())")
//        }
//    }
//    
//    func functionForAddingCounting(_ stringGroupId:String,stringModuleId:String)->Int
//    {
//        var varGetId=stringGroupId
//        var muarray:NSMutableArray=NSMutableArray()
//        var varGet=UserDefaults.standard.value(forKey: "session_EntityId")as! NSArray
//        // muarray=(NSUserDefaults.standardUserDefaults().valueForKey("session_EntityId")as! NSArray) as! NSMutableArray
//        var arrayTemp:NSArray=NSArray()
//        arrayTemp = (UserDefaults.standard.value(forKey: "session_EntityId")as! NSArray)
//        //print(arrayTemp.count)
//        for i in 0 ..< arrayTemp.count
//        {
//            muarray.add(arrayTemp.object(at: i))
//        }
//        //print(muarray)
//        var muarrayNotificationCount:NSMutableArray=NSMutableArray()
//        var varDefaultModuleId:Int=0
//        for i in 0 ..< muarray.count
//        {
//            let letGetValue=muarray.object(at: i) as! String
//            //print(letGetValue)
//            if(letGetValue==varGetId)
//            {
//                let letGetArray=muarray.object(at: i)
//                var muarrayTemp:NSMutableArray=NSMutableArray()
//                var arrayTemporary:NSArray=NSArray()
//                arrayTemporary = (UserDefaults.standard.value(forKey: "session_notificationCountForModule")as! NSArray)
//                muarrayTemp = NSMutableArray(array: arrayTemporary)
//                //print(muarrayTemp)
//                //muarrayNotificationCount=((muarrayTemp.object(at: i) as AnyObject).mutableCopy()) as! NSMutableArray
//                
//                muarrayNotificationCount=((muarrayTemp.object(at: i) as AnyObject)) as! NSMutableArray
//                //  muarrayNotificationCount=muarrayTemp.object(at: i) as! NSMutableArray
//                
//                
//                
//                
//                ////print("Group Id:-")
//                //print(stringGroupId)
//                ////print("module Id:-")
//                //print(stringModuleId)
//                //print(muarrayNotificationCount)
//                
//                if(stringGroupId=="339")
//                {
//                    ////print("hello")
//                }
//                for j in 00..<muarrayNotificationCount.count
//                {
//                    var varGetValuesModuleIDForCompare=muarrayNotificationCount.object(at: j)
//                    ////print("This is value:-")
//                    //print(varGetValuesModuleIDForCompare)
//                    var varGetValuesNew=(varGetValuesModuleIDForCompare as AnyObject).value(forKey: "moduleId")as! String
//                    if(stringModuleId==varGetValuesNew)
//                    {
//                        var varGetTempValue:String=((varGetValuesModuleIDForCompare as AnyObject).value(forKey: "count"))as! String
//                        varDefaultModuleId=Int(varGetTempValue)!
//                    }
//                }
//            }
//        }
//        //print(varDefaultModuleId)
//        return varDefaultModuleId
//    }
//    //More time consume
//    func functionForCheckIsSessionTimeoutOrNot()
//    {
//        appDelegate = UIApplication.shared.delegate as! AppDelegate
//        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//            
//        {
//            var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//            var updatedOn =  String ()
//            let defaults = UserDefaults.standard
//            let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
//            updatedOn = "1970-01-01 00:00:00"
//            if let str = defaults.value(forKey: Updatedefault) as! String?
//            {
//                updatedOn = str
//            }
//            else
//            {
//                updatedOn = "1970-01-01 00:00:00"
//            }
//            var varGetMobileNumber = UserDefaults.standard.value(forKey: "session_Mobile_Number")as! String
//            var varGetCountryCode = UserDefaults.standard.value(forKey: "session_Country_Code")as! String
//            var varGetLoginType = UserDefaults.standard.value(forKey: "session_Login_Type")as! String
//            let completeURL = baseUrl+touchBase_GetAllGroupListSync
//            let parameterst = [
//                "masterUID" : mainMemberID!,
//                "imeiNo" : UIDevice.current.identifierForVendor!.uuidString,
//                "updatedOn" : updatedOn,
//                "loginType" : varGetLoginType,
//                "mobileNo" : varGetMobileNumber,
//                "countryCode" : varGetLoginType
//            ]
//             ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
//                let dd = response as! NSDictionary
//                print("Session result 2: \(dd)")
//                var varGetValueServerError = response.object(forKey: "serverError")as? String
//                if(varGetValueServerError == "Error")
//                {
//                SVProgressHUD.dismiss()
//                }
//else
//{
//    if (dd.object(forKey: "status") as! String == "0")
//    {
//        
//    }
//    else if (dd.object(forKey: "status") as! String == "2")
//    {
//    //----------------------------------------------
//    //---delete old value from server in case of Birthday Anniversary Event start
//    self.DELETEDashboard_BirthAnniEvent_table_New()
//    //---delete old value from server in case of Birthday Anniversary Event ens
//    //-------------------------------------------------
//    // self.appDelegate.showAlsertView()
//    self.imageSplashScreenRoot.isHidden=true
//    self.loaderClass.window = nil
//    SVProgressHUD.dismiss()
//    UserDefaults.standard.removeObject(forKey: "updatedOn")
//    let alert=UIAlertController(title: "Rotary India", message:dd.object(forKey: "message") as! String, preferredStyle: UIAlertController.Style.alert);
//    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
//        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
//        self.appDelegate.setMobileViewAsRoot()
//        // self.appDelegate.showAlsertView()
//    }));
//    self.present(alert, animated: true, completion: nil);
//  }
// }
//})
//}
//    }
//    /*----root view controller----------------------------------------------------*/
//    /*--------------------ROW----------*/
//    
//    //banner btn  clicked action
//    
//    
//    @IBAction func bannerBtnClickedAction(_ sender: Any) {
//        
//        let BannerController = self.storyboard?.instantiateViewController(withIdentifier: "BannerListViewController") as! BannerListViewController
// 
//        BannerController.bannerListArr = self.bannerListArr
//        print(BannerController.bannerListArr)
//        self.navigationController?.pushViewController(BannerController, animated: true)
//    }
//    
//    
//    
//    @IBAction func buttonNoUpdateProfileClickEvent(_ sender: AnyObject) {
//        buttonOpacity.isHidden = true
//        viewUpdateProfileOrNot.isHidden = true
//        self.loaderClass.window = nil
//    }
//    
//    @IBAction func buttonYesUpdateProfileClickEvent(_ sender: AnyObject)
//    {
//        //        let profVC = self.storyboard!.instantiateViewControllerWithIdentifier("profileView") as! ProfileViewController
//        
//        //        self.navigationController?.pushViewController(profVC, animated: true)
//        self.loaderClass.window = nil
//    }
//    
//    /*--------------------ROW----------*/
//    
//    /*---------------------------------------------XML Parsing Delegate------------Start------------------------------------------------*/
//    //MARK:- XML Parsing Delegate
//    func beginParsing()
//    {
//        
//        self.posts = []
//        self.parser = XMLParser(contentsOf:(URL(string:"https://my.rotary.org/en/rss.xml"))!)!
//        self.parser.delegate = self
//        self.parser.parse()
//        
//    }
//    
//    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
//    {
//        element = elementName as NSString
//        if (elementName as NSString).isEqual(to: "item")
//        {
//            elements = NSMutableDictionary()
//            elements = [:]
//            title1 = NSMutableString()
//            title1 = ""
//            date = NSMutableString()
//            date = ""
//            description11 = NSMutableString()
//            description11 = ""
//            link = NSMutableString()
//            link = ""
//        }
//    }
//    
//    func parser(_ parser: XMLParser, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
//    {
//        if (elementName as NSString).isEqual(to: "item") {
//            if !title1.isEqual(nil)
//            {
//                elements.setObject(title1, forKey: "title" as NSCopying)
//            }
//            if !date.isEqual(nil)
//            {
//                elements.setObject(date, forKey: "date" as NSCopying)
//            }
//            if !description11.isEqual(nil)
//            {
//                elements.setObject(description11, forKey: "description" as NSCopying)
//            }
//            if !link.isEqual(nil)
//            {
//                elements.setObject(link, forKey: "link" as NSCopying)
//            }
//            /*------------------------------------Store Data local--------------Start------------------------------------*/
//            var databasePath : String
//            let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//            databasePath = fileURL.path
//            var db: OpaquePointer? = nil
//            if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//            {
//            }
//            else
//            {
//            }
//            let contactDB = FMDatabase(path: databasePath as String)
//            if contactDB == nil
//            {
//            }
//            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//            if (contactDB?.open())!
//            {
//                var insertSQL:String! = ""
//                
//                insertSQL = "INSERT INTO NewsUpdate_Table (newsUpdateTitle , newsUpdateDescription,newsUpdateDate,link,isFeedFirstOrSecond) VALUES ( '\(title1)', '\(description11)', '\(date)','\(link)','\("First")')"
//                print("4.NewsUpdate Insert Query::\(insertSQL)")
//                let result = contactDB?.executeStatements(insertSQL)
//                if (result == nil)
//                {
//                }
//                else
//                {
//                    
//                }
//            }
//            else
//            {
//            }
//            /*------------------------------------Store Data local--------------Start------------------------------------*/
//            posts.add(elements)
//            
//        }
//        
//        
//        UserDefaults.standard.setValue("0", forKey: "Session_RssFeedFirstTime")
//        
//    }
//    
//    func parser(_ parser: XMLParser, foundCharacters string: String!)
//    {
//        if element.isEqual(to: "title") {
//            title1.append(string)
//        }
//            
//        else if element.isEqual(to: "pubDate") {
//            date.append(string)
//        }
//            
//        else if element.isEqual(to: "description") {
//            description11.append(string)
//        }
//        else if element.isEqual(to: "link") {
//            link.append(string)
//        }
//    }
//    
//    @IBAction func buttonOpticityClickEvent(_ sender: AnyObject)
//    {
//        if(varCheckLoadingOrPicker==0)
//        {
//            
//        }
//        else if(varCheckLoadingOrPicker==1)
//        {
//            
//            
//            buttonOpticity.isHidden=true
//            
//            viewForSettingPicker.isHidden=true
//        }
//    }
//    
//    @IBAction func buttonDoneClickeventOnPicker(_ sender: AnyObject)
//    {
//        
//        
//        
//        
//        
//        if (varGetPickerSelectValue == "Settings")
//        {
//            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "settings") as UIViewController, animated: true)
//            
//        }
//        else if (varGetPickerSelectValue == "About Us")
//        {
//            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController, animated: true)
//        }
//        else
//        {
//            buttonOpticity.isHidden = true
//            viewForSettingPicker.isHidden = true
//        }
//        buttonOpticity.isHidden = true
//        viewForSettingPicker.isHidden = true
//        
//        
//    }
//    
//    
//    
//    
//    
//    
//    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return mainArraySettingForPicker.count;
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
//    {
//        //let countryList = GrpCountryList()
//        let varGetCountry:String = mainArraySettingForPicker.object(at: row) as! String
//        
//        return varGetCountry
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
//    {
//        let varGetCountry:String = mainArraySettingForPicker.object(at: row) as! String
//        varGetPickerSelectValue =   varGetCountry
//        //print(varGetPickerSelectValue)
//    }
//    func functionForSetColorInStringFamilyDetailBG()->NSAttributedString
//    {
//        let text = "I agree with TERMS and CONDITION"
//        let linkTextWithColor = "CONDITION"
//        let range = (text as NSString).range(of: linkTextWithColor)
//        let attributedString = NSMutableAttributedString(string:text)
//        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
//        var attributedStringss:NSAttributedString=NSAttributedString()
//        let htmlStringss = "<p style='text-align: center; font-family: Roboto; font-size: 20px; line-height: 20px;'><span style='color: #ffffff;'>Loading Please wait... </span><br /><span style='color: #ffffff;'></span><br /><span style='color: #ffffff;'> <marquee behavior='alternate' scrollamount='10'></marquee></span></p>"
//        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
//           let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
//        do {
//            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
//            
//            // labelIAgreeWith.attributedText=attributedStringss;
//        } catch _ {
//            ////print("Cannot create attributed String")
//        }
//        
//        labelFirstTimeSyncMessage.attributedText=attributedStringss
//        
//        //print(attributedStringss)
//        return attributedStringss
//    }
//    
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int
//    {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if(sections.count == 0)
//        {
//            return 0//sections[section].items.count
//        }
//        else
//        {
//            return sections[section].items.count
//        }
//        
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cells = myCollectionView.dequeueReusableCell(withReuseIdentifier: "ClubsCollectionViewCell", for: indexPath) as! ClubsCollectionViewCell
//
//        if indexPath.section == 0
//        {
//            UserDefaults.standard.setValue("yes", forKey: "isitFirstTimeForDismissHUD")
//            if sections[0].imagePic.count>0
//            {
//                let imageGroupPicUrl = sections[indexPath.section].imagePic[indexPath.row]
//                if(imageGroupPicUrl == "")
//                {
//                    cells.imgClubs.image = UIImage(named: "rt_dash_logo")
//                }
//                else
//                {
//                  if let checkedUrl = URL(string: imageGroupPicUrl) {
//                  cells.imgClubs.sd_setImage(with: checkedUrl, placeholderImage: UIImage(named: "rt_dash_logo"))
//                    }
//                }
//                cells.lblClubsname.text! = sections[indexPath.section].items[indexPath.row]
//            }
//            
//        }
//        return cells
//        
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
//    {
//        
//
////
//        
//        
//        
//        
//        if indexPath.section == 0
//        {
//            viewloadandwillappearCount=0
//            
//            var dict:NSDictionary!
//            viewPopUp.isHidden=true
//            UserDefaults.standard.setValue("No", forKey: "session_IsFirstTime")
//            var grp:GroupResult!
//            //print(menuTitles)
//            dict = menuTitles[indexPath.row] as! NSDictionary
//            print(dict)
//            let varGetId=(dict.object(forKey: "grpId") as! String)
//            UserDefaults.standard.setValue(varGetId, forKey: "session_GetGroupId")
//            var muarray:NSArray=NSArray()
//            ////print("app crashing first time")
//            // //print(UserDefaults.standard.value(forKey: "session_EntityId")as! NSArray)
//            
//            
//            //print("this is nil array")
//            /*
//             //print(UserDefaults.standard.value(forKey: "session_EntityId") as! NSArray)
//             muarray=UserDefaults.standard.value(forKey: "session_EntityId") as! NSArray
//             var muarrayNotificationCount:NSArray=NSArray()
//             for i in 0 ..< muarray.count
//             {
//             let letGetValue=muarray.object(at: i) as! String
//             //print(letGetValue)
//             if(letGetValue==varGetId)
//             {
//             let letGetArray=muarray.object(at: i)
//             //print(letGetArray)
//             var muarrayTemp:NSArray=NSArray()
//             muarrayTemp=UserDefaults.standard.value(forKey: "session_notificationCountForModule") as! NSArray
//             //print(muarrayTemp)
//             muarrayNotificationCount=muarrayTemp.object(at: i) as! NSArray
//             }
//             }
//             */
//            // //print(muarrayNotificationCount)
//            
//            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainDash") as! MainDashboardViewController
//            let isGroupAdminOrNot = dict.object(forKey: "isGrpAdmin") as! String
//            print("isGroupAdminOrNot c :: \(isGroupAdminOrNot)")
//            secondViewController.grpDetailPrevious=dict as NSDictionary
//            
//            //print(indexPath.row)
//            
//            // //print(muarrayNotificationCount.objectAtIndex(indexPath.row) as! NSMutableArray)
//            // secondViewController.muarrayNotificationCount=muarrayNotificationCount
//            secondViewController.isGroupAdmin = dict.object(forKey: "isGrpAdmin") as! String
//            secondViewController.isCategory=dict.object(forKey: "myCategory") as! String
//            secondViewController.varGetId=varGetId
//          ///  print(dict)
//            secondViewController.groupUniqueName = dict.object(forKey: "grpName") as! String // Rajendra
//
//            //print(varGetId)
//            //group admin
//            UserDefaults.standard.set(dict.object(forKey: "isGrpAdmin") as! String, forKey: "isAdmin")
//            UserDefaults.standard.setValue(dict.object(forKey: "grpProfileid") as! String, forKey: "session_grpProfileid")
//            secondViewController.varGetGroupId = dict.object(forKey: "grpId") as! String // Rajendra
//            self.navigationController?.pushViewController(secondViewController, animated: true)
//        }
//    }
////
////    lazy var collectionView: UICollectionView = {
////        let layout = UICollectionViewFlowLayout()
////        layout.minimumLineSpacing = 0
////        layout.headerReferenceSize = .zero
////        layout.sectionInset = .zero
////        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
////        cv.backgroundColor = .green
////        cv.dataSource = self
////        cv.delegate = self
////        cv.contentInset = .zero
////        return cv
////    }()
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//        {
//            if sections[0].items.count % 2 == 0
//            {
//                print("333333333333333333333333333")
//                return CGSize(width: (self.view.bounds.width/2)-10, height:80)
//            }
//            else
//            {
//                if(indexPath.row == sections[0].items.count-1)
//                {
//                    print("11111111111111111111")
//                    return CGSize(width: self.view.bounds.width, height:80)
//                }
//                else if (indexPath.row != sections[0].items.count-1)
//                {
//                    return CGSize(width: (self.view.bounds.width-10)/2, height:80)
//                }
//                else
//                {
//                    return CGSize(width: (self.view.bounds.width-10)/2, height:80)
//                }
//            }
//        }
//    
//    //MARK:- Server Calling BAE
//    func getBirthDayAnniversaryEventsDetails()
//    {
//        
//        let date = Date()
//        let calendar = Calendar.current
//        let day = calendar.component(.day, from: date)
//        let month = calendar.component(.month, from: date)
//        let year = calendar.component(.year, from: date)
//        
//        print(day)
//        print(month)
//        print(year)
//        var todayDate:String!=String(day)+String(month)+String(year)
//        var getDifferenceofDate=UserDefaults.standard.value(forKey: "session_DateDifference")as? String
//         print(todayDate)
//         print(getDifferenceofDate)
//        if(todayDate==getDifferenceofDate)
//        {
//           print("if coming")
//            if(muarrayForBirthdayAnniversaryEvent.count>0)
//            {
//              print("This is if condition 7 may")
//            }
//            else
//            {
//                print("This is else condition 7 may")
////                functionForBirthDayAnniversaryEvent()
//            }
//        }
//        else
//        {
//        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//        {
//            print("This is if-else condition 7 may")
//            //---delete old value from server in case of Birthday Anniversary Event start
//            DELETEDashboard_BirthAnniEvent_table_New()
//            //---delete old value from server in case of Birthday Anniversary Event ens
//            print("else coming")
//            UserDefaults.standard.setValue(todayDate, forKey: "session_DateDifference")
////            functionForBirthDayAnniversaryEvent()
//        }
//      }
//    }
//    
//    func functionForBirthDayAnniversaryEvent()
//    {
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//            let completeURL:String! = baseUrl+row_GetDashboardBirthAnniEvent
//            let parameterst = [
//                "MasterId": mainMemberID!
////                "MasterId": "2345672"
////                "MasterId": "43115"
//
//            ]
//        
////        let completeURL:String! = "http://rotaryindiaapi.rosteronwheels.com/api/Group/GetNewDashboard"
////        let parameterst = [
////            "MasterId": 370933
//////                "MasterId": "2345672"
//////                "MasterId": "43115"
////
////        ]
//        
//        
//        
//            print(parameterst)
//            print(completeURL)
////           print("Banner API Call @ \(Date())")
//        
//            DispatchQueue.main.async{
////                self.imgGrayIconROW.isHidden=true
//                self.indicator.startAnimating()
//                self.lblBAEDesc.text!=""
//            }
////        let manager = Alamofire.SessionManager.default
////        manager.session.configuration.timeoutIntervalForRequest = 200
////
////        Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON()
////
////
//        
//        let manager = Alamofire.SessionManager.default
//        manager.session.configuration.timeoutIntervalForRequest = 200
//
//        manager.request(completeURL, method: .post, parameters:parameterst,encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
//            
////            let sessionConfig = URLSessionConfiguration.default
////            sessionConfig.timeoutIntervalForRequest = 30.0
////            sessionConfig.timeoutIntervalForResource = 60.0
////            let session = URLSession(configuration: sessionConfig)
//            
//            
//                switch response.result {
//                case .success:
//                    print("Banner API main response @ \(Date())")
//                    if let value = response.result.value {
//                        self.labelFirstTimeSyncMessage.isHidden=true
//                        print("22222222This is device token by Rajendra JAt 1 March !!!!!")
//                        SVProgressHUD.dismiss()
//                        let dd = response.result.value as! NSDictionary
//                        var varGetValueServerError = dd.object(forKey: "serverError")as? String
//                        
//                        if(varGetValueServerError == "Error")
//                        {
//                            //comment by seema for 5 dec
////                            DispatchQueue.global(qos:.background).async {
//                                self.getBirthDayAnniversaryEventsDetails()
////                            }
//                            SVProgressHUD.dismiss()
//                        }
//                        else
//                        {
//                            SVProgressHUD.dismiss()
//                            print(dd)
//                            if((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "status") as! String == "0")
//                            {
//                                self.functionDashboardBirthAnniEventDelete()
//                                self.muarrayForBirthdayAnniversaryEvent=NSMutableArray()
//                                
//                                if let subToSubCategoryList = (dd.value(forKey: "TBDashboardResult")! as AnyObject).value(forKey: "Result") as? NSArray
//                               {
//                                self.bannerListArr=subToSubCategoryList
//                               }
////                                self.bannerListArr =  (dd.value(forKey: "TBDashboardResult")! as AnyObject).value(forKey: "Result") as? NSArray
//
//                            print(self.bannerListArr)
////                                dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "status") as! String
//                                
//                                // Club Birthday
////                                for i in 0 ..< (((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Birthday") as! NSArray).count
////                                {
////                                    let bday = (((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Birthday") as! NSArray).object(at: i)
////
////
////                                    var dictTemporaryDictionary:NSDictionary=((((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Birthday") as! NSArray).object(at: i) as! NSDictionary)
////
////
////                                    let ClubCategory = dictTemporaryDictionary.object(forKey: "ClubCategory") as? String
////                                    let ClubId = dictTemporaryDictionary.object(forKey: "ClubId") as! String
////                                    let ClubName = dictTemporaryDictionary.object(forKey: "ClubName") as! String
////                                    let Description = dictTemporaryDictionary.object(forKey: "Description") as! String
////                                    let ProfileId = dictTemporaryDictionary.object(forKey: "ProfileId") as! String
////                                    let Title = dictTemporaryDictionary.object(forKey: "Title") as! String
////                                    let TodaysCount = dictTemporaryDictionary.object(forKey: "TodaysCount") as! String
////                                    let Type = dictTemporaryDictionary.object(forKey: "Type") as! String
////                                    let IsAdmin = dictTemporaryDictionary.object(forKey: "IsAdmin") as! String
//////                                    if((dictTemporaryDictionary.value(forKey: "ClubCategory") as! String ) == "1")
//////                                    {
////                                        print("6 march calling 1 !!!!!!")
////                                    self.functionForStoreBirthEventAnni(ClubCategory!, ClubIds: ClubId, ClubNames: ClubName, Descriptions: Description, ProfileId: ProfileId, Titles: Title, TodaysCounts: TodaysCount, Types: Type,isAdmin: IsAdmin)
////                                        self.muarrayForBirthdayAnniversaryEvent.add(bday)
//////                                    }
////                                }
////                                for j in 0 ..< (((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Birthday") as! NSArray).count
////                                {
////                                    let bday = (((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Birthday") as! NSArray).object(at: j)
////
////                                    var dictTemporaryDictionary:NSDictionary=((((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Birthday") as! NSArray).object(at: j) as! NSDictionary)
////
////                                    let ClubCategory = dictTemporaryDictionary.object(forKey: "ClubCategory") as! String
////                                    let ClubId = dictTemporaryDictionary.object(forKey: "ClubId") as! String
////                                    let ClubName = dictTemporaryDictionary.object(forKey: "ClubName") as! String
////                                    let Description = dictTemporaryDictionary.object(forKey: "Description") as! String
////                                    let ProfileId = dictTemporaryDictionary.object(forKey: "ProfileId") as! String
////                                    let Title = dictTemporaryDictionary.object(forKey: "Title") as! String
////                                    let TodaysCount = dictTemporaryDictionary.object(forKey: "TodaysCount") as! String
////                                    let Type = dictTemporaryDictionary.object(forKey: "Type") as! String
////                                    let IsAdmin = dictTemporaryDictionary.object(forKey: "IsAdmin") as! String
////
////                                    if((dictTemporaryDictionary.value(forKey: "ClubCategory") as! String ) == "2")
////                                    {
////                                        print("6 march calling 2 !!!!!!")
////                                        self.functionForStoreBirthEventAnni(ClubCategory, ClubIds: ClubId, ClubNames: ClubName, Descriptions: Description, ProfileId: ProfileId, Titles: Title, TodaysCounts: TodaysCount, Types: Type,isAdmin: IsAdmin)
////                                        self.muarrayForBirthdayAnniversaryEvent.add(bday)
////                                    }
////                                }
//                                //Club Anniversary
////                                for k in 0 ..< (((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Anniversary") as! NSArray).count
////                                {
////                                    let bday = (((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Anniversary") as! NSArray).object(at: k)
////
////                                    var dictTemporaryDictionary:NSDictionary=((((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Anniversary") as! NSArray).object(at: k) as! NSDictionary)
////
////
////
////                                    let ClubCategory = dictTemporaryDictionary.object(forKey: "ClubCategory") as! String
////                                    let ClubId = dictTemporaryDictionary.object(forKey: "ClubId") as! String
////                                    let ClubName = dictTemporaryDictionary.object(forKey: "ClubName") as! String
////                                    let Description = dictTemporaryDictionary.object(forKey: "Description") as! String
////                                    let ProfileId = dictTemporaryDictionary.object(forKey: "ProfileId") as! String
////                                    let Title = dictTemporaryDictionary.object(forKey: "Title") as! String
////                                    let TodaysCount = dictTemporaryDictionary.object(forKey: "TodaysCount") as! String
////                                    let Type = dictTemporaryDictionary.object(forKey: "Type") as! String
////                                    let IsAdmin = dictTemporaryDictionary.object(forKey: "IsAdmin") as! String
////
//////                                    if((dictTemporaryDictionary.value(forKey: "ClubCategory") as! String ) == "1")
//////                                    {
////                                        print("6 march calling 3 !!!!!!")
////                                        self.functionForStoreBirthEventAnni(ClubCategory, ClubIds: ClubId, ClubNames: ClubName, Descriptions: Description, ProfileId: ProfileId, Titles: Title, TodaysCounts: TodaysCount, Types: Type,isAdmin: IsAdmin)
////                                        self.muarrayForBirthdayAnniversaryEvent.add(bday)
//////                                    }
////                                }
////                                //District Anniversary
//////                                for l in 0 ..< (((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Anniversary") as! NSArray).count
//////                                {
//////                                    let bday = (((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Anniversary") as! NSArray).object(at: l)
//////                                    //print(bday)
//////
//////
//////                                    var dictTemporaryDictionary:NSDictionary=((((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Anniversary") as! NSArray).object(at: l) as! NSDictionary)
//////
//////
//////
//////                                    let ClubCategory = dictTemporaryDictionary.object(forKey: "ClubCategory") as! String
//////                                    let ClubId = dictTemporaryDictionary.object(forKey: "ClubId") as! String
//////                                    let ClubName = dictTemporaryDictionary.object(forKey: "ClubName") as! String
//////                                    let Description = dictTemporaryDictionary.object(forKey: "Description") as! String
//////                                    let ProfileId = dictTemporaryDictionary.object(forKey: "ProfileId") as! String
//////                                    let Title = dictTemporaryDictionary.object(forKey: "Title") as! String
//////                                    let TodaysCount = dictTemporaryDictionary.object(forKey: "TodaysCount") as! String
//////                                    let Type = dictTemporaryDictionary.object(forKey: "Type") as! String
//////                                    let IsAdmin = dictTemporaryDictionary.object(forKey: "IsAdmin") as! String
//////
//////
//////
//////                                    if((dictTemporaryDictionary.value(forKey: "ClubCategory") as! String ) == "2")
//////                                    {
//////                                        print("6 march calling 4 !!!!!!")
//////                                        self.functionForStoreBirthEventAnni(ClubCategory, ClubIds: ClubId, ClubNames: ClubName, Descriptions: Description, ProfileId: ProfileId, Titles: Title, TodaysCounts: TodaysCount, Types: Type,isAdmin: IsAdmin)
//////                                        self.muarrayForBirthdayAnniversaryEvent.add(bday)
//////                                    }
//////                                }
////                                //Club Event
////                                for m in 0 ..< (((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Event") as! NSArray).count
////                                {
////                                    let bday = (((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Event") as! NSArray).object(at: m)
////                                    //print(bday)
////
////                                    var dictTemporaryDictionary:NSDictionary=((((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Event") as! NSArray).object(at: m) as! NSDictionary)
////
////
////
////                                    let ClubCategory = dictTemporaryDictionary.object(forKey: "ClubCategory") as! String
////                                    let ClubId = dictTemporaryDictionary.object(forKey: "ClubId") as! String
////                                    let ClubName = dictTemporaryDictionary.object(forKey: "ClubName") as! String
////                                    let Description = dictTemporaryDictionary.object(forKey: "Description") as! String
////                                    let ProfileId = dictTemporaryDictionary.object(forKey: "ProfileId") as! String
////                                    let Title = dictTemporaryDictionary.object(forKey: "Title") as! String
////                                    let TodaysCount = dictTemporaryDictionary.object(forKey: "TodaysCount") as! String
////                                    let Type = dictTemporaryDictionary.object(forKey: "Type") as! String
////                                    let IsAdmin = dictTemporaryDictionary.object(forKey: "IsAdmin") as! String
////
////
////
//////                                    if((dictTemporaryDictionary.value(forKey: "ClubCategory") as! String ) == "1")
//////                                    {
////                                        print("6 march calling 5 !!!!!!")
////                                        self.functionForStoreBirthEventAnni(ClubCategory, ClubIds: ClubId, ClubNames: ClubName, Descriptions: Description, ProfileId: ProfileId, Titles: Title, TodaysCounts: TodaysCount, Types: Type,isAdmin: IsAdmin)
////                                        self.muarrayForBirthdayAnniversaryEvent.add(bday)
//////                                    }
////                                }
//                                //District Event
////                                for n in 0 ..< (((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Event") as! NSArray).count
////                                {
////                                    let bday = (((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Event") as! NSArray).object(at: n)
////
////                                    var dictTemporaryDictionary:NSDictionary=((((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "Result") as! NSDictionary).value(forKey: "Event") as! NSArray).object(at: n) as! NSDictionary)
////
////                                    let ClubCategory = dictTemporaryDictionary.object(forKey: "ClubCategory") as! String
////                                    let ClubId = dictTemporaryDictionary.object(forKey: "ClubId") as! String
////                                    let ClubName = dictTemporaryDictionary.object(forKey: "ClubName") as! String
////                                    let Description = dictTemporaryDictionary.object(forKey: "Description") as! String
////                                    let ProfileId = dictTemporaryDictionary.object(forKey: "ProfileId") as! String
////                                    let Title = dictTemporaryDictionary.object(forKey: "Title") as! String
////                                    let TodaysCount = dictTemporaryDictionary.object(forKey: "TodaysCount") as! String
////                                    let Type = dictTemporaryDictionary.object(forKey: "Type") as! String
////                                    //print(bday)
////                                    let IsAdmin = dictTemporaryDictionary.object(forKey: "IsAdmin") as! String
////
////
////                                    if((dictTemporaryDictionary.value(forKey: "ClubCategory") as! String ) == "2")
////                                    {
////                                        print("6 march calling 6 !!!!!!")
////                                        self.functionForStoreBirthEventAnni(ClubCategory, ClubIds: ClubId, ClubNames: ClubName, Descriptions: Description, ProfileId: ProfileId, Titles: Title, TodaysCounts: TodaysCount, Types: Type,isAdmin: IsAdmin)
////                                        self.muarrayForBirthdayAnniversaryEvent.add(bday)
////                                    }
////                                }
//                                 print("Banner API Response @ \(Date())")
////                                self.viewPager.scrollToPage(0)
////                                self.viewPager.dataSource = self
////                                self.viewPager.animationNext()
//////                                self.imgGrayIconROW.isHidden=true
////                                self.viewPager.reloadData()
////                                self.viewPager.reloadInputViews()
////                                self.indicator.stopAnimating()
//                            }
//                            else
//                            {
//                                self.indicator.stopAnimating()
//                                self.imgGrayIconROW.isHidden=false
//                            }
//                        }
//                        if self.muarrayForBirthdayAnniversaryEvent.count == 0
//                        {
//                             self.imgGrayIconROW.isHidden=false
//                        }
//                    }
////                    else{
////
////                    }
//                    self.labelFirstTimeSyncMessage.isHidden=true
////                    self.view.makeToast("Network issue")
//                    print("Rotaryyyy India failed")
//                case .failure(_):break
//                }
//            
//            print("Rotaryyyy Indiaaaaa")
//            
//            }
//       
//        print("Rotaryyyy Indiaaaaa 1234567890")
//    }
//    
//
//    
//    func functionForStoreBirthEventAnni(_ ClubCategorys:String,ClubIds:String,ClubNames:String,Descriptions:String,ProfileId:String,Titles:String,TodaysCounts:String,Types:String,isAdmin:String)
//    {
//        
//        let mainDescriptin=Descriptions.replacingOccurrences(of: "'", with: "")
//        var databasePath : String
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            ////print("error opening database")
//        }
//        else
//        {
//            // self.Createtablecity()
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil
//        {
//            ////print("Error: \(contactDB.lastErrorMessage())")
//        }
//        
//        /*need to delete previous data start*/
//        // var databasePath : String
//        
//        // let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        // let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        // databasePath = fileURL.path
//        // var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//        }
//        else
//        {
//        }
//        // let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil
//        {
//        }
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        if (contactDB?.open())!
//        {
//            if(ClubIds.characters.count>0)
//            {
//            }
//        }
//        if (contactDB?.open())!
//        {
//            let  insertSQL = "INSERT INTO Dashboard_BirthAnniEvent_table_New (ClubCategory , ClubId,ClubName,Description,ProfileId,Title,TodaysCount,Type,ExtraOne,ExtraTwo,IsAdmin,ISUpdate) VALUES ( '\(ClubCategorys)', '\(ClubIds)', '\(ClubNames)','\(mainDescriptin)','\(ProfileId)', '\(Titles)', '\(TodaysCounts)', '\(Types)', '\("ExtraOne")' ,'\("ExtraTwo")','\(isAdmin)','\("IsUpdate")')"
////            print(insertSQL)
//            
//            
//            let result = contactDB?.executeStatements(insertSQL)
//            if (result == nil)
//            {
//            }
//            else
//            {
//            }
//        }
//        else
//        {
//        }
//        posts.add(elements)
//    }
//    func  functionDashBoardbirthAnniEventDataGet()
//    {
//        //this function is being called due to if date change then should not show old date data
//        var databasePath : String
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//        }
//        else
//        {
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil
//        {
//
//        }
//        if (contactDB?.open())!
//        {
//            print("Entered in sql database")
//            var querySQL = ""
//            var previousTitle:String!=""
//            querySQL = "SELECT distinct(Title),ClubCategory,ClubId,ClubName,Description,ProfileId,TodaysCount,Type,IsAdmin  FROM Dashboard_BirthAnniEvent_table_New"
//            let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
//            muarrayForBirthdayAnniversaryEvent=NSMutableArray()
//            while results?.next() == true
//            {
//                let dd = NSMutableDictionary ()
//                dd.setValue((results?.string(forColumn: "ClubCategory"))! as String, forKey:"ClubCategory")
//                dd.setValue((results?.string(forColumn: "ClubId"))! as String, forKey:"ClubId")
//                dd.setValue((results?.string(forColumn: "ClubName"))! as String, forKey:"ClubName")
//                dd.setValue((results?.string(forColumn: "Description"))! as String, forKey:"Description")
//                dd.setValue((results?.string(forColumn: "ProfileId"))! as String, forKey:"ProfileId")
//                dd.setValue((results?.string(forColumn: "Title"))! as String, forKey:"Title")
//                dd.setValue((results?.string(forColumn: "TodaysCount"))! as String, forKey:"TodaysCount")
//                dd.setValue((results?.string(forColumn: "Type"))! as String, forKey:"Type")
//                dd.setValue((results?.string(forColumn: "IsAdmin"))! as String, forKey:"IsAdmin")
//                muarrayForBirthdayAnniversaryEvent.add(dd)
//                UserDefaults.standard.setValue(muarrayForBirthdayAnniversaryEvent, forKey: "session_notificationBirAnniEventNar")
//            }
////            self.viewPager.scrollToPage(0)
////            self.viewPager.dataSource = self
////            self.viewPager.animationNext()
////            self.imgGrayIconROW.isHidden=true
//        }
//        contactDB?.close()
//    }
//    
//    func functionDashboardBirthAnniEventDelete()
//    {
//            let date = Date()
//            let calendar = Calendar.current
//            let day = calendar.component(.day, from: date)
//            let month = calendar.component(.month, from: date)
//            let year = calendar.component(.year, from: date)
//            
//            var getDateForCompare = UserDefaults.standard.value(forKey: "session_isCompareDateNew") as? String
//            var finalDate:String=String(day)+String(month)+String(year)
//            if((getDateForCompare == nil) || (getDateForCompare != finalDate))
//            {
//                DELETEDashboard_BirthAnniEvent_table_New()
//                UserDefaults.standard.setValue(finalDate, forKey: "session_isCompareDateNew")
//            }
//            else
//            {
//                print("else")
//            }
//    }
//}
//
////MARK- Extensions
//extension RootDashViewController:ViewPagerDataSource
//{
//    
//    func numberOfItems(_ viewPager:ViewPager) -> Int
//    {
//        //muarrayForBirthdayAnniversaryEvent
//        return muarrayForBirthdayAnniversaryEvent.count
//    }
//    func viewAtIndex(_ viewPager:ViewPager, index:Int, view:UIView?) -> UIView {
//        
//        if(muarrayForBirthdayAnniversaryEvent.count>0)
//        {
//            self.indicator.stopAnimating()
//        }
//        
//        var newView = view;
//        var label:UILabel?
//        if(newView == nil){
//            newView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:  self.view.frame.height))
//            //newView!.backgroundColor = .randomColor()
//            label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:  30))//newView!.bounds)
//            label!.tag = 1
//            label!.autoresizingMask =  [.flexibleWidth, .flexibleHeight]
//            label!.textAlignment = .center
//            label?.numberOfLines = 0
//            //label!.font =  label!.Font.withSize(28)
//            label?.font = UIFont(name: "Roboto-Regular", size: 20)
//            newView?.addSubview(label!)
//        }else
//        {
//            label = newView?.viewWithTag(index) as? UILabel
//        }
//        
//        lblBAEDesc.numberOfLines=3
//        lblDescForSlider.numberOfLines = 3
//        lblDateEVENT.numberOfLines = 1
//        lblDescriptionForBirthAnni.numberOfLines=2
//        lblandhaveTodayBirthday.numberOfLines=1
//        
//        selectedIndexForSilder = index
//        if(muarrayForBirthdayAnniversaryEvent.count>0)
//        {
//        let varBAEType = (muarrayForBirthdayAnniversaryEvent.object(at: index) as AnyObject).value(forKey: "Type") as? String
//        let clubname = (muarrayForBirthdayAnniversaryEvent.object(at: index) as AnyObject).value(forKey: "ClubName") as? String
//        let Description = (muarrayForBirthdayAnniversaryEvent.object(at: index) as AnyObject).value(forKey: "Description") as? String
//        var Title = (muarrayForBirthdayAnniversaryEvent.object(at: index) as AnyObject).value(forKey: "Title") as? String
//        let TodaysCount = (muarrayForBirthdayAnniversaryEvent.object(at: index) as AnyObject).value(forKey: "TodaysCount") as? String
//        let ClubCategory = (muarrayForBirthdayAnniversaryEvent.object(at: index) as AnyObject).value(forKey: "ClubCategory") as? String
//        var isAdmin = (muarrayForBirthdayAnniversaryEvent.object(at: index) as AnyObject).value(forKey: "IsAdmin") as? String
//        
//        let paragraphStyle = NSMutableParagraphStyle()
//        //line height size
//        paragraphStyle.lineSpacing = 1.6
//        let attrString = NSMutableAttributedString(string: Description!)
//            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
//        
//        
//        if(Int(TodaysCount!)>2)
//        {
//            let fullNameArr = Title?.components(separatedBy: ",")
//            // //print(fullNameArr[0])
//            Title = fullNameArr?[0]
//        }
//        
//      //  self.viewPager.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
//        
//        //Birthday
//        if(varBAEType=="Birthday")
//        {
//
//            let Titles = Title?.replacingOccurrences(of: ",", with: " & ")
//            
//            var descBA :String!=""
//            
//            if(Int(TodaysCount!)!==1 || Int(TodaysCount!)!==2)
//            {
//                if(Int(TodaysCount!)!==1)
//                {
//                    descBA = Titles
////                    lblandhaveTodayBirthday.text! = "has \(varBAEType!) today."
//                }
//                else
//                {
//                    descBA = Titles  //+" have \(varBAEType) today."
////                    lblandhaveTodayBirthday.text! = "have \(varBAEType!) today."
//                }
//                
//            }
//            else if (Int(TodaysCount!)>2)
//            {
//                
//                descBA = Titles //+" and \(Int(TodaysCount)! - 1) others have \(varBAEType) today."
//                
//                
////                lblandhaveTodayBirthday.text! = "and \(Int(TodaysCount!)! - 1) others have \(varBAEType!) today."
//            }
//            
//            
//            let paragraphStyleBA = NSMutableParagraphStyle()
//            //line height size
//            paragraphStyleBA.lineSpacing = 1.6
//            let attrStringBA = NSMutableAttributedString(string: descBA)
//            attrStringBA.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrStringBA.length))
//            
//            
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
//            //            if(ClubCategory=="1")
//            //            {
//            //             self.viasdewPager.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
//            //            }
//            //            else if(ClubCategory=="2")
//            //            {
//            //             self.visdfewPager.backgroundColor =  UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
//            //            }
//        }
//        //Anniversary
//        if(varBAEType=="Anniversary")
//        {
//            // let descBA = Title+" and \(TodaysCount) others \n have \(varBAEType) today."
//            
//            let Titles = Title?.replacingOccurrences(of: ",", with: " & ")
//            
//            var descBA :String!=""
//            if(Int(TodaysCount!)!==1 || Int(TodaysCount!)!==2)
//            {
//                if(Int(TodaysCount!)!==1)
//                {
//                    descBA = Titles //+" has \(varBAEType) today."
////                    lblandhaveTodayBirthday.text! = "has \(varBAEType!) today."
//                }
//                else
//                    
//                {
//                    descBA = Titles //+" have \(varBAEType) today."
////                    lblandhaveTodayBirthday.text! = "have \(varBAEType!) today."
//                }
//            }
//            else if (Int(TodaysCount!)>2)
//            {
//                
//                descBA = Titles  //+" and  \(Int(TodaysCount)! - 1) others have \(varBAEType) today."
////                lblandhaveTodayBirthday.text! = "and  \(Int(TodaysCount!)! - 1) others have \(varBAEType!) today."
//            }
//            
//            
//            let paragraphStyleBA = NSMutableParagraphStyle()
//            //line height size
//            paragraphStyleBA.lineSpacing = 1.6
//            let attrStringBA = NSMutableAttributedString(string: descBA)
//            attrStringBA.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrStringBA.length))
//            
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
//            
//            //print(clubname)
//            
//        }
//        //Event
//        if(varBAEType=="Event")
//        {
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
//            
//        }
//        if(varBAEType=="Announcement")
//        {
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
//            
//            
//            
//            // self.viesdfwPager.backgroundColor =  UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
//            
//        }
//        
//        
//        
//        //Image bday and Anniversary
//        viewPager.addSubview(lblClubDistrictName)
//        viewPager.addSubview(lblBAEDesc)
//        viewPager.addSubview(lblDescForSlider)
//        viewPager.addSubview(lblDateEVENT)
//        viewPager.addSubview(imgBAE)
//        viewPager.addSubview(lblDescriptionForBirthAnni)
//        viewPager.addSubview(lblandhaveTodayBirthday)
//        // label?.text = "Deepak Kumar Patidar and 4 others have birthday today \(index+1)."
//        }
//        return newView!
//    }
//    
//    
//    
//    func didSelectedItem(_ index: Int) {
//        ////print("select index \(selectedIndexForSilder)")
//       // print(muarrayForBirthdayAnniversaryEvent)
//        let varBAEType = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "Type") as! String
//        let clubname = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "ClubName") as! String
//        let Description = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "Description") as! String
//        let Title = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "Title") as! String
//        let TodaysCount = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "TodaysCount") as! String
//        let ClubCategory = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "ClubCategory") as! String
//        
//        let ClubId = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "ClubId") as! String
//        
//        let ProfileId = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "ProfileId") as! String
//        let isAdmin = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "IsAdmin") as! String
//        
//        //Birthday
//        if(varBAEType=="Birthday")
//        {
//            
//            UserDefaults.standard.setValue(ProfileId, forKey: "user_auth_token_profileId")
//            UserDefaults.standard.setValue(ClubId, forKey: "user_auth_token_groupId")
//            UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
//            
//            //Need to Code by Rajendra Sir
//            if #available(iOS 13.0, *) { let objCelebrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
//                objCelebrationViewController.stringProfileId = ProfileId
//                objCelebrationViewController.stringGroupID = ClubId
//                objCelebrationViewController.isCategory=ClubCategory
//                objCelebrationViewController.varType="B"
//                objCelebrationViewController.moduleName="Calendar"
//                objCelebrationViewController.isBirthdayorAnniv="birthday"
//                objCelebrationViewController.isAdmin=isAdmin
//                self.navigationController?.pushViewController(objCelebrationViewController, animated: true)
//                
//            }
//            else {
//                // Fallback on earlier versions
//            }
//           
//            /* objCelebrationViewController.stringProfileId = grpDetailPrevious["grpProfileid"] as! String
//             objCelebrationViewController.stringGroupID = dict["groupId"] as! String*/
//        }
//        //Anniversary
//        if(varBAEType=="Anniversary")
//        {
//            UserDefaults.standard.setValue(ProfileId, forKey: "user_auth_token_profileId")
//            UserDefaults.standard.setValue(ClubId, forKey: "user_auth_token_groupId")
//            UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
//            //Need to Code by Rajendra Sir
//            if #available(iOS 13.0, *) {
//                let objCelebrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
//                objCelebrationViewController.stringProfileId = ProfileId
//                objCelebrationViewController.stringGroupID = ClubId
//                objCelebrationViewController.isCategory=ClubCategory
//                objCelebrationViewController.varType="A"
//                objCelebrationViewController.moduleName="Calendar"
//                objCelebrationViewController.isBirthdayorAnniv="anniv"
//                objCelebrationViewController.isAdmin=isAdmin
//                self.navigationController?.pushViewController(objCelebrationViewController, animated: true) }
//            else {
//                // Fallback on earlier versions
//            }
//           
//        }
//        //Event
//        if(varBAEType=="Event")
//        {
//            //  //print(isAdmin)
//            UserDefaults.standard.setValue(ProfileId, forKey: "user_auth_token_profileId")
//            UserDefaults.standard.setValue(ClubId, forKey: "user_auth_token_groupId")
//            UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
//            //Need to Code by Rajendra Sir
//            if #available(iOS 13.0, *) {
//                let objCelebrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
//                objCelebrationViewController.stringProfileId = ProfileId
//                objCelebrationViewController.stringGroupID = ClubId
//                objCelebrationViewController.isCategory=ClubCategory
//                objCelebrationViewController.varType="E"
//                objCelebrationViewController.moduleName="Calendar"
//                objCelebrationViewController.isBirthdayorAnniv=""
//                objCelebrationViewController.isAdmin=isAdmin
//                objCelebrationViewController.grpName=clubname
//    //            print("Club name to send \(clubname)")
//                self.navigationController?.pushViewController(objCelebrationViewController, animated: true)
//            } else {
//                // Fallback on earlier versions
//            }
//            
//        }
//        if(varBAEType=="Announcement")
//        {
//            //Need to Code by Rajendra Sir
//        }
//    }
//}
//
//extension CGFloat {
//    static func random() -> CGFloat {
//        return CGFloat(arc4random()) / CGFloat(UInt32.max)
//    }
//}
//
//extension UIColor {
//    static func randomColor() -> UIColor {
//        // If you wanted a random alpha, just create another
//        // random number for that too.
//        return UIColor(red:   .random(),
//                       green: .random(),
//                       blue:  .random(),
//                       alpha: 1.0)
//    }
//}
//
//protocol Utilities {
//}
//
//extension NSObject:Utilities{
//    enum ReachabilityStatus {
//        case notReachable
//        case reachableViaWWAN
//        case reachableViaWiFi
//    }
//    
//    var currentReachabilityStatus: ReachabilityStatus {
//        
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        
//        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
//                SCNetworkReachabilityCreateWithAddress(nil, $0)
//            }
//        }) else {
//            return .notReachable
//        }
//        
//        var flags: SCNetworkReachabilityFlags = []
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
//            return .notReachable
//        }
//        
//        if flags.contains(.reachable) == false {
//            // The target host is not reachable.
//            return .notReachable
//        }
//        else if flags.contains(.isWWAN) == true {
//            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
//            return .reachableViaWWAN
//        }
//        else if flags.contains(.connectionRequired) == false {
//            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
//            return .reachableViaWiFi
//        }
//        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
//            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
//            return .reachableViaWiFi
//        }
//        else {
//            return .notReachable
//        }
//    }
//}
//
//
//
