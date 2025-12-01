//  WebserviceClass.swift
//  TouchBase
//
//  Created by Umesh on 22/01/16. Later worked by Rajendra jat from 26 Dec 2016 to 27 May 2019
//  Copyright © 2016 Parag. All rights reserved.
//var database: FMDatabase?

import UIKit
import SVProgressHUD
import Alamofire
var cluborDistrictName:String!=""

@objc protocol webServiceDelegate
{
    @objc optional  func myDelegateFunction(_ string:NSString)
    
    @objc optional  func LoginDelegateFunction(_ loginRes: LoginResult)
    @objc optional  func OTPverifyDelegateFunction(_ loginRes: LoginResult)
    @objc optional  func WelcomeDelegateFunction(_ welcome: WelcomeResult)
    @objc optional  func memberDetailDelegateFunction(_ memDetail: MemberListDetailResult)
    @objc optional  func removeGroupsOFUSerSuccss(_ string:TBGroupResult)
    @objc optional  func mygroupsDelegateFunction(_ string:TBGroupResult)
    @objc optional  func updatemyGroupsOFUSerSuccss(_ string:TBGroupResult)
    @objc optional  func getGLobalSearchDetailDelegate(_ globalDetail : TBGlobalSearchGroupResult)
    @objc optional  func getSubGroupsResultDelegate(_ subGroupList : TBGetSubGroupListResult)
    @objc optional  func getEventsDetailsSuccess(eventsDetails : EventsListDetailResult)
    @objc optional  func addAnnounceDelegateFunction(_ addAnnoun : TBAddAnnouncementResult)
    @objc optional  func getDirectoryDetailDelegate(_ memberDetail : MemberListDetailResult)
    @objc optional  func getDirectoryResultDelegate(_ dirList : TBMemberResult)
    @objc optional  func memberDetailingDelegateFunction(_ memberListDetail : MemberListDetailResult)
    @objc optional  func UpdateMemDetailDelegateFunction(_ updateUser : UserResult)
    @objc optional  func CreateGroupDelegateFunction(_ createGRP : CreateGRpResult)
    @objc optional  func countryAndCatListDelegateFunction(_ countryCat : TBCountryResult)
    
    //ganesh
    @objc optional  func countryCodeSelectDelegateFunction(_ countryCat : TBCountryResult)
    @objc optional  func getContactPersonDetail()
    
    //album
    
    @objc optional  func getAlbumListOfUsers(_ createAlbum : TBAlbumsListResult)
    
    
    @objc optional  func modulesListDelegateFunction(_ modulesListing:TBGetGroupModuleResult)
    @objc optional  func addModulesDelegateFunction(_ addModules : TBAddModuleResult)
    @objc optional  func getallbulletinOFUSerSuccssS(string:TBEbulletinListResult)
    @objc optional  func getmoduleGroupsOFUSerSuccss(_ string:TBGetGroupModuleResult)
    @objc optional  func getallAnnounOFUSerSuccss(string:TBAnnounceListResult)
    @objc optional  func createSubGroupSucc(_ string:TBGetSubGroupListResult)
    @objc optional  func getEventListSucc(_ string:EventListDetailResult)
    @objc optional  func getsubgrpDetailListSucc(_ string:TBGetSubGroupDetailListResult)
    @objc optional  func addBulletineDelegateFunction(_ addEbulletine : TBAddEbulletinResult)
    @objc optional  func getAddMembersSuccss(_ addMembers : TBAddMemberGroupResult)
    @objc optional  func getGroupInfoDetailDelegate(_ grpInfoDetail : TBGetGroupResult)
    @objc optional  func getQueAnsInfoDetailDelegate(queAns : EventJoinResult)
    @objc optional  func addEventDelegateFunction(addAnnoun : AddEventResult)
    @objc optional  func UploadDocumentDelegateFunction(_ uploadDoc : TBAddDocumentResult)
    @objc optional  func DocumentListingDelegateFunction(_ docListing : TBDocumentistResult)
    @objc optional  func getTouchBaseSettigSucc(_ docListing : TBSettingResult)
    @objc optional  func updateTouchBaseSettigSucc(_ docListing : TBSettingResult)
    @objc optional  func getTouchBaseGroupsSettigSucc(_ docListing : TBGroupSettingResult)
    @objc optional  func updategrpTouchBaseSettigSucc(_ docListing : TBGroupSettingResult)
    @objc optional  func updatepersonalProfileSucc(_ docListing : UserResult)
    @objc optional  func getAddFamilyMembersSuccss(_ updateFamilyDetail : UpdateFamilyResult)
    @objc optional  func getAddUpdateAddressSuccss(_ updateAddressProfile:UpdateAddressResult)
    @objc optional  func deleteSucc(_ docListing : DeleteResult)
    @objc optional  func ExitGroupDelegateFunction(_ extGrp : TBRemoveSelfResult)
    @objc optional  func DeletePhotoDelegateFunction(_ dltPhoto : DeleteResult)
    @objc optional  func suggestfeatureDelegateFunction(_ dltPhoto : SuggestFeatureResult)
    @objc optional  func deleteEntityDelegateFunction(_ dltPhoto : TBDeleteEntityResult)
    @objc optional  func getEntityInfoDelegate(_ entityInfo : TBEntityInfoResult)
    @objc optional  func getServiceDirListDelegate(_ entityInfo : TBServiceDirectoryResult)
    @objc optional  func addServiceDirListDelegate(_ entityInfo : TBAddServiceResult)
    @objc optional  func getdetServiceDirListDelegate(_ entityInfo : TBServiceDirectoryListResult)
    @objc optional  func ggg(_ entityInfo : TBServiceDirectoryResult)
    @objc optional  func getallgrouplistsync(_ string:TBGetGroupModuleResult)
    @objc optional func getSMSCountdetailsDelegateFunction(_ TBsmscountResult:NSDictionary)
}

private let sharedKraken = WebserviceClass()





class WebserviceClass: NSObject {
    var window: UIWindow!
    let screenSize: CGRect = UIScreen.main.bounds
    
    var delegates : webServiceDelegate?
    var appdelegate:AppDelegate!
    
    class var sharedInstance: WebserviceClass {
        return sharedKraken
    }
    
    func loaderViewMethodNew()
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
        window?.addSubview(Loadingview)
        
        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")
        
        let gifView = UIImageView()
        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
        gifView.backgroundColor = UIColor.clear
        Loadingview.addSubview(gifView)
    }
    
    
    
    //    func loaderViewMethod()
    //    {
    //        window = UIWindow(frame: UIScreen.main.bounds)
    //        if let window = window {
    //            window.backgroundColor = UIColor.clear
    //            window.rootViewController = UIViewController()
    //            window.makeKeyAndVisible()
    //        }
    //        let Loadingview = UIView()
    //
    //        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
    //        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
    //        window?.addSubview(Loadingview)
    //
    //        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")
    //
    //        let gifView = UIImageView()
    //        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
    //        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
    //        gifView.backgroundColor = UIColor.clear
    //        Loadingview.addSubview(gifView)
    //
    //
    //    }
    
    func stopLoader() {
        self.window = nil
    }
    
    func signinTapped(_ mobileNumber : String , countryCode : String ,loginType:String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            SVProgressHUD.show()
            if appToken != nil {
            if let appTokens = appToken{
            UserDefaults.standard.setValue(appTokens, forKey: "deviceToken")
            UserDefaults.standard.synchronize()
            }
            }
            //loaderViewMethod()
            var params: [String: String] = [ "mobileNo":mobileNumber]
            let defaults = UserDefaults.standard
            if let abc = defaults.value(forKey: "deviceToken") as? NSString
            {
                //  post =  String(format: "mobileNo=%@&deviceToken=%@&countryCode=%@&loginType=%@", ,,,) as NSString
                params=[
                    "mobileNo":mobileNumber,
                    "deviceToken":abc as String,
                    "countryCode":countryCode,
                    "loginType":loginType
                ]
            }
            else
            {
                // post =  String(format: "mobileNo=%@&devicdfseToken=%@&countryCode=%@&loginType=%@", mobileNumber,"",countryCode,loginType) as NSString
                
                
                params=[
                    "mobileNo":mobileNumber,
                    "deviceToken":"",
                    "countryCode":countryCode,
                    "loginType":loginType
                ]
                
                
            }
            
            
            let url = baseUrl+"Login/UserLogin"
            
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let login:LoginResult!
                        
                        login = LoginResult.fromJSONData(jsonData) as! LoginResult
                        //self.window = nil
                        //  self.window = nil
                       // self.showAlert1(otp: jsonString)
                        self.delegates?.LoginDelegateFunction!(login)
                        SVProgressHUD.dismiss()
                    }
                case .failure(_): break
                    //  self.window = nil
               // self.showAlert1(otp: "jsonString fail!!!!")
                    
                }
                // self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            //            do {
            //                let defaults = UserDefaults.standard
            //                let post:NSString!
            //               // let abc = defaults.valueForKey("devsdficeToken") as? NSString
            //               if let abc = defaults.value(forKey: "devicesdfToken") as? NSString
            //                {
            //                 post =  String(format: "mobileNo=%@&devicsdfeToken=%@&countryCode=%@&loginType=%@", mobileNumber,abc,countryCode,loginType) as NSString    //"mobileNo=8928389197&dsdfeviceToken=0&countryCode=91"
            //                }
            //               else
            //               {
            //                     post =  String(format: "mobileNo=%@&devicesdfToken=%@&countryCode=%@&loginType=%@", mobileNumber,"",countryCode,loginType) as NSString
            //                }
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@Login/UserLogin",baseUrl))!
            //                //let url:NSURL = NSURL(string:"%@Login/UserLogin")!
            //                print(url)
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //                do {
            //
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //
            //                        if(data == nil)
            //                        {
            //                            print("data is nil")
            //                            ///
            //                            self.window.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            //                        }
            //                        else
            //                        {
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //
            //                        let data = string!.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //                        let login:LoginResult!
            //                        login = LoginResult.fromJSONData(data) as! LoginResult
            //                        self.window = nil
            //                        //  self.window = nil
            //                        self.delegates?.LoginDelegateFunction!(login)
            //
            //
            //                        NSLog("login data %@", login.otp)
            //
            //                        }
            //                    } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //            }
        }
    }
    
    func showAlert(){
        SVProgressHUD.dismiss()
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Rotary India"
        alertView.message = "Oops! Something went wrong. Please check your Internet Connection and try again."
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
    }
    
    func showAlert1(otp:String!){
        SVProgressHUD.dismiss()
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Rotary India"
        alertView.message = "Successin login with otp :: \(otp!)"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
    }

    
    func OTPverify(_ mobileNumber : String , deviceTokenStr : String ,countryCode : String , loginType:String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            SVProgressHUD.show()
            
            //loaderViewMethod()
            var params: [String: String] = [ "mobileNo":mobileNumber]
            let post:NSString!
            let defaults = UserDefaults.standard
            //{"mobileNo":"8928389197","deviceToken":"0","countryCode":"1","deviceName":"Android/iOS","imeiNo":"123456789"}
            print("devcie Token")
            print(defaults.value(forKey: "deviceToken") as? NSString)
            
            if let abc = defaults.value(forKey: "deviceToken") as? NSString
            {
                params=[
                    "mobileNo":mobileNumber,
                    "deviceToken":abc as String,
                    "countryCode":countryCode,
                    "deviceName":"iOS",
                    "imeiNo":UIDevice.current.identifierForVendor!.uuidString,
                    "versionNo":verSion,
                    "loginType":loginType
                ]
            }
            else
            {
                params=[
                    "mobileNo":mobileNumber,
                    "deviceToken":"",
                    "countryCode":countryCode,
                    "deviceName":"iOS",
                    "imeiNo":UIDevice.current.identifierForVendor!.uuidString,
                    "versionNo":verSion,
                    "loginType":loginType
                ]
            }
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Login/PostOTP"
            
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let login:LoginResult!
                        login = LoginResult.fromJSONData(jsonData) as! LoginResult
                        print(login)
                        self.window = nil
                        //  self.window = nil
                        self.delegates?.OTPverifyDelegateFunction!(login)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            /*-------------------------------------------------------------*/
            
            
            
            
            
            
            
            
            //            do {
            //
            //
            //                UIDevice.current.identifierForVendor!.uuidString
            //                print("UDID *** \(UIDevice.current.identifierForVendor!.uuidString)")
            //                let post:NSString!
            //                let defaults = UserDefaults.standard
            //                //{"mobileNo":"8928389197","devicdfseToken":"0","countryCode":"1","deviceName":"Android/iOS","imeiNo":"123456789"}
            //                print("devcie Token")
            //                print(defaults.value(forKey: "devicesdfToken") as? NSString)
            //
            //                if let abc = defaults.value(forKey: "devicsdfeToken") as? NSString
            //                {
            //                    post =  String(format: "mobileNo=%@&devicesdfToken=%@&countryCode=%@&deviceName=iOS&imeiNo=%@&versionNo=%@&loginType=%@", mobileNumber,abc,countryCode,UIDevice.current.identifierForVendor!.uuidString,verSion,loginType) as NSString    //"mobileNo=8928389197&devicesdfsToken=0&countryCode=91"
            //                }else{
            //                    post =  String(format: "mobileNo=%@&deviceTsdfoken=%@&countryCode=%@&deviceName=iOS&imeiNo=%@&versionNo=%@&loginType=%@", mobileNumber,"",countryCode,UIDevice.current.identifierForVendor!.uuidString,verSion,loginType) as NSString    //"mobileNo=8928389197&devicesdfToken=0&countryCode=91"
            //                }
            //
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@Login/PostOTP",baseUrl))!
            //
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.timeoutInterval = 300
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //
            //                do {
            //
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //
            //                        let data = string!.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //                        let login:LoginResult!
            //                        login = LoginResult.fromJSONData(data) as! LoginResult
            //                        print(login)
            //                        self.window = nil
            //                        //  self.window = nil
            //                        self.delegates?.OTPverifyDelegateFunction!(login)
            //
            //                        // NSLog("login data %@", login.otp)
            //                        } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //            }
        }
    }
    
    
    func getAllGroupsWelcome(_ memberUID : String ,mobileno:String,loginType:String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            SVProgressHUD.show()
            //loaderViewMethod()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Login/GetWelcomeScreen"
            var params: [String: String] = ["masterUID": memberUID,"mobileno": mobileno,"loginType": loginType]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let welcome:WelcomeResult!
                        welcome = WelcomeResult.fromJSONData(jsonData) as! WelcomeResult
                        self.window = nil
                        print("this is welcome api problem")
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.WelcomeDelegateFunction!(welcome)
                        SVProgressHUD.dismiss()
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            
            
            
            
            
            
            //            do {
            //                let post:NSString =  String(format: "masterUID=%@&mobileno=%@&loginType=%@", memberUID,mobileno,loginType) as NSString
            //
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@Login/GetWelcomeScreen",baseUrl))!
            //
            //                print(url)
            //
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.timeoutInterval = 180
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //                do {
            //
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //
            //                        let data = string!.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //                        let welcome:WelcomeResult!
            //                        welcome = WelcomeResult.fromJSONData(data) as! WelcomeResult
            //                        self.window = nil
            //                        //self.Loadingview.removeFromSuperview()
            //                        self.delegates?.WelcomeDelegateFunction!(welcome)
            //                        // self.window = nil
            //                        // NSLog("login data %@", login.otp)
            //                        } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //
            //            }
        }
    }
    
    
    
    func MemberDetail(_ memberUUID : String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            
            //loaderViewMethod()
            
            SVProgressHUD.show()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Login/GetMemberDetails"
            var params: [String: String] = ["masterUID": memberUUID]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let memberDetailss : MemberListDetailResult!
                        memberDetailss = MemberListDetailResult.fromJSONData(jsonData) as! MemberListDetailResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.memberDetailingDelegateFunction!(memberDetailss)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            
            
            
            
            
            
            
            
            //            do {
            //                let post:NSString =  String(format: "masterUID=%@", memberUUID) as NSString
            //
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@Login/GetMemberDetails",baseUrl))!
            //
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //                do {
            //
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //
            //
            //                        let data = string!.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //
            //                        // self.window = nil
            //
            //                        // NSLog("login data %@", login.otp)
            //                        } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //            }
        }
    }
    
    func UpdateMemberDetail(_ memberUUID : String , memberMobile : String , memberName : String , memberEmailID : String , ProfilePicPath : String , ImageId : String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            SVProgressHUD.show()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Member/UpdateProfile"
            var params: [String: String] = ["ProfileId": memberUUID,"memberMobile": memberMobile,"memberName": memberName,"memberEmailid": memberEmailID,"ProfilePicPath": ProfilePicPath,"ImageId": ImageId]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let updateMemberDetailss : UserResult!
                        updateMemberDetailss = UserResult.fromJSONData(jsonData) as! UserResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.UpdateMemDetailDelegateFunction!(updateMemberDetailss)
                        SVProgressHUD.dismiss()
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            
            
            
            
            //            do {
            //                let post:NSString =  String(format: "=%@&=%@&=%@&=%@&=%@&=%@", ,,,,,) as NSString
            //
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@Member/UpdateProfile",baseUrl))!
            //
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //
            //                do {
            //
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //
            //                        let data = string!.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //
            //                        // self.window = nil
            //                        // NSLog("login data %@", login.otp)
            //                        } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //            }
        }
    }
    
    func createGroup(_ grpId : String , grpName : String , grpImageID : String , grpType : String , grpCategory : String , addrss1 : String , addrss2 : String , city : String, state : String, pincode : String, country : String, emailid : String, mobile : String, userId : String, website : String , other : String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            SVProgressHUD.show()
            
            
            //loaderViewMethod()
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/CreateGroup"
            var params: [String: String] = ["grpId":grpId]
            
            params=[
                "grpId":grpId,
                "grpName":grpName,
                "grpImageID":grpImageID,
                "grpType":grpType,
                "grpCategory":grpCategory,
                "addrss1":addrss1,
                "addrss2":addrss2,
                "city":city,
                "state":state,
                "pincode":pincode,
                "country":country,
                "emailid":emailid,
                "mobile":mobile,
                "userId":userId,
                "website":website,
                "other":other
            ]
            
            
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let createGRP:CreateGRpResult!
                        createGRP = CreateGRpResult.fromJSONData(jsonData) as! CreateGRpResult
                        
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.CreateGroupDelegateFunction!(createGRP)
                        SVProgressHUD.dismiss()
                        
                        self.window = nil
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
        }
    }
    
    
    
    func getCountryAndCategories() {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            SVProgressHUD.show()
            
            //loaderViewMethod()
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/GetAllCountriesAndCategories"
            var params: [String: String] = ["":""]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let country: TBCountryResult!
                        country = TBCountryResult.fromJSONData(jsonData) as! TBCountryResult
                        
                        //self.Loadingview.removeFromSuperview()
                        //NSLog("login data %@", grp.status)
                        if(country.status == "0")
                        {
                            self.delegates?.countryAndCatListDelegateFunction!(country)
                        }
                        self.window = nil
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            
            
            
            //            do {
            //                let post:NSString = ""
            //
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@",baseUrl))!
            //                print(url)
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //
            //                do {
            //                    //  urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //                        //
            //                        let data = string!.data(using: String.Encoding.utf8,allowLossyConversion: false)
            //
            //
            //                        } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //
            //            }
        }
    }
    //ganeshK
    //  optional  func countryCodeSelectDelegateFunction(countryCat : TBCountryResult)
    
    func getCountryCodeSelection() {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/GetAllCountriesAndCategories"
            var params: [String: String] = ["": ""]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let country: TBCountryResult!
                        country = TBCountryResult.fromJSONData(jsonData) as! TBCountryResult
                        
                        //self.Loadingview.removeFromSuperview()
                        //NSLog("login data %@", grp.status)
                        if(country.status == "0")
                        {
                            self.delegates?.countryCodeSelectDelegateFunction!(country)
                        }
                        self.window = nil
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            //            do {
            //                let post:NSString = ""
            //
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@",baseUrl))!
            //
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //
            //                do {
            //                    //  urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //                        //
            //                        let data = string!.data(using: String.Encoding.utf8,allowLossyConversion: false)
            //
            //
            //                        } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //
            //            }
        }
    }
    
    
    
    func getModules() {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/GetModulesList"
            var params: [String: String] = ["": ""]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let grp: TBGetGroupModuleResult!
                        grp = TBGetGroupModuleResult.fromJSONData(jsonData) as! TBGetGroupModuleResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        //NSLog("login data %@", grp.status)
                        if(grp.status == "0"){
                            self.delegates?.modulesListDelegateFunction!(grp)
                        }
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            /*-------------------------------------------------------------*/
        }
    }
    
    
    
    
    
    
    func getAddModules(_ grpId : String , moduleIDs : String , userID : String , noOfmember : String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            
            SVProgressHUD.show()
            
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/AddSelectedModule"
            var params: [String: String] = ["grpId": grpId,"moduleIDs": moduleIDs,"userID": userID,"noOfmember": noOfmember]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let mod:TBAddModuleResult!
                        mod = TBAddModuleResult.fromJSONData(jsonData) as! TBAddModuleResult
                        self.window = nil
                        self.delegates?.addModulesDelegateFunction!(mod)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            /*-------------------------------------------------------------*/
        }
    }
    func getAllGroupsOFUSer(_ memberID: NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            SVProgressHUD.show()
            
            //NSUserDefaults.standardUserDefaults().setObject("1970-1-1 0:0:0", forKey: "updatedOn")
            var updatedOn =  String ()
            let defaults = UserDefaults.standard
            if let str = defaults.value(forKey: "updatedOn") as! String?
            {
                print(str)
                updatedOn = str
            }else{
                updatedOn = "1970-1-1 0:0:0"
            }
            
            //loaderViewMethod()
            
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/GetAllGroupsList"
            var params: [String: String] = ["masterUID": memberID as String as String,"imeiNo": UIDevice.current.identifierForVendor!.uuidString]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        
                        let grp:TBGroupResult!
                        grp = TBGroupResult.fromJSONData(jsonData) as! TBGroupResult
                        NSLog("GetAllGroupListSync %@", grp.status)
                        self.window = nil
                        self.delegates?.mygroupsDelegateFunction!(grp)
                        SVProgressHUD.dismiss()
                        
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            
            
            
            
            
            
            //{"masterUID":"1","imeiNo":""}   0-All, 1-Business, 2-Personal ,3-Social
            //            do {
            //                // let post:NSString = "masterUID=\(memberID)"
            //                let post:NSString =  String(format: "=%@&=%@",,) as NSString
            //                NSLog("PostDataSumit: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@",baseUrl))!
            //
            //                print(url)
            //
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //                do {
            //                    //  urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //
            //                        let data = string!.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //
            //                        } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //            }
        }
    }
    
    func removeGroupsOFUSer(_ memberID: NSString,memberMainId:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/RemoveGroupCategory"
            var params: [String: String] = ["memberProfileId": memberID as String,"memberMainId": memberMainId as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let grp:TBGroupResult!
                        grp = TBGroupResult.fromJSONData(jsonData) as! TBGroupResult
                        NSLog("login data %@", grp.status)
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        if(grp.status == "0"){
                            self.delegates?.removeGroupsOFUSerSuccss!(grp)
                        }
                        SVProgressHUD.dismiss()
                        
                        self.window = nil
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            
            
            
            //            do {
            //                let post:NSString = String(format: "=%@&=%@",,) as NSString
            //
            //
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@",baseUrl))!
            //
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //                do {
            //                    //  urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //                        //
            //                        let data = string!.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //
            //
            //                        } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //
            //            }
        }
    }
    func updateGroupsOFUSer(_ memberProfileId: NSString,mycategory:NSString,memberMainId:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/UpdateMemberGroupCategory"
            var params: [String: String] = ["memberProfileId": memberProfileId as String,"mycategory": mycategory as String,"memberMainId": memberMainId as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let grp:TBGroupResult!
                        grp = TBGroupResult.fromJSONData(jsonData) as! TBGroupResult
                        NSLog("login data %@", grp.status)
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        if(grp.status == "0"){
                            self.delegates?.updatemyGroupsOFUSerSuccss!(grp)
                        }
                        
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            //
            //
            //
            //
            //            do {
            //                let post:NSString = String(format: "=%@&=%@&=%@",,,) as NSString
            //
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@",baseUrl))!
            //
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //
            //                do {
            //                    //  urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //                        //
            //                        let data = string!.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //
            //                        } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //
            //            }
        }
    }
    func GetallmodulesofGroupsOFUSer(_ groupId: NSString,memberProfileId:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/GetGroupModulesList"
            var params: [String: String] = ["groupId": groupId as String,"memberProfileId": memberProfileId as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        
                        let grp:TBGetGroupModuleResult!
                        grp = TBGetGroupModuleResult.fromJSONData(jsonData) as! TBGetGroupModuleResult
                        NSLog("login data %@", grp.status)
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        if(grp.status == "0"){
                            self.delegates?.getmoduleGroupsOFUSerSuccss!(grp)
                        }
                        SVProgressHUD.dismiss()
                        
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            
            //            do {
            //                let post:NSString = String(format: "=%@&=%@",,) as NSString
            //                //let post:NSString = String(format: "grpID=%@&masterUID=%@&searchText=%@&page=1","1","1","")
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@",baseUrl))!
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //
            //                do {
            //                    //  urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //                        //
            //                        let data = string!.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //
            //                        } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //            }
        }
    }
    func updateMymodulesofGroupsOFUSer(_ memberProfileId: NSString,modulelist:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/UpdateModuleDashboard"
            var params: [String: String] = ["memberProfileId": memberProfileId as String,"modulelist": modulelist as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        
                        let grp:TBGetGroupModuleResult!
                        grp = TBGetGroupModuleResult.fromJSONData(jsonData) as! TBGetGroupModuleResult
                        NSLog("login data %@", grp.status)
                        if(grp.status == "0"){
                            self.delegates?.getmoduleGroupsOFUSerSuccss!(grp)
                        }
                        
                        SVProgressHUD.dismiss()
                        
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            //            do {
            //                let post:NSString = String(format: "memberProfileId=%@&=%@",memberProfileId,) as NSString
            //
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@",baseUrl))!
            //
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //                do {
            //                    //  urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //                        //
            //                        //                    let data = string!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            //                        //                    let grp:TBGetGroupModuleResult!
            //                        //                    grp = TBGetGroupModuleResult.fromJSONData(data) as! TBGetGroupModuleResult
            //                        //                    NSLog("login data %@", grp.status)
            //                        //                    if(grp.status == "0"){
            //                        //                        self.delegates?.getmoduleGroupsOFUSerSuccss!(grp)
            //                        //                    }
            //
            //                        self.window = nil
            //
            //                        } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //            }
        }
    }
    
    
    func getDirectoryListGroupsOFUSer(_ masterUID: NSString,grpID:NSString,searchText:NSString,page:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            //loaderViewMethod()
            
            SVProgressHUD.show()
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Member/GetDirectoryList"
            var params: [String: String] = ["masterUID": masterUID as String,"grpID": grpID as String,"searchText": searchText as String,"page": page as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        
                        let dir:TBMemberResult!
                        dir = TBMemberResult.fromJSONData(jsonData) as! TBMemberResult
                        NSLog("login data %@", dir.status)
                        self.window = nil
                        self.delegates?.getDirectoryResultDelegate!(dir)
                        SVProgressHUD.dismiss()
                        
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            
            
            
            //            do {
            //                let post:NSString = String(format: "=%@&=%@&=%@&=%@",,,,) as NSString
            //
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@",baseUrl))!
            //                print(url)
            //                // print(grpCount)
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //                do {
            //                    //  urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //
            //                        let data = string!.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //
            //                        } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //
            //            }
        }
    }
    
    
    func getMemberDetail(_ memberProfID: NSString,grpID:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Member/GetMember"
            var params: [String: String] = ["memberProfileId": memberProfID as String,"groupId": grpID as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        
                        
                        let dirDetail:MemberListDetailResult!
                        dirDetail = MemberListDetailResult.fromJSONData(jsonData) as! MemberListDetailResult
                        NSLog("login data %@", dirDetail.status)
                        self.window = nil
                        //self.window = nil
                        if(dirDetail.status == "0")
                        {
                            self.delegates?.getDirectoryDetailDelegate!(dirDetail)
                        }
                        SVProgressHUD.dismiss()
                        
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
        }
    }
    func getAllAnnouncementOFUSer(_ groupId: NSString,memberProfileId:NSString,searchText:NSString,type:NSString,isAdmin:NSString,moduleId:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            var admi:NSString!
            if(isAdmin=="No"){
                admi="0"
            }else{
                admi="1"
            }
            /*-------------------------------------------------------------*/
            let url = URL(string: baseUrl+"Announcement/GetAnnouncementList")!
            var params: [String: String] = ["groupId":groupId as String,
                                            "memberProfileId":memberProfileId as String,
                                            "searchText":searchText as String,
                                            "type":type as String,
                                            "isAdmin":admi as String,
                                            "moduleId":moduleId as String
            ]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print("Announcement List--------\(jsonString)")
                        let announ:TBAnnounceListResult!
                        announ = TBAnnounceListResult.fromJSONData(jsonData) as! TBAnnounceListResult
                        NSLog("login data %@", announ.status)
                        self.window = nil
                        self.delegates?.getallAnnounOFUSerSuccss!(string: announ)
                        SVProgressHUD.dismiss()
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
        }
    }
    /*
     func addEventsResult(eventID : NSString , questionEnable : NSString , eventType : NSString , membersIDs : NSString , eventImageID : NSString , evntTitle : NSString , evntDesc : NSString , eventVenue : NSString, venueLat : NSString, venueLong : NSString  , evntDate : NSString ,  publishDate : NSString , expiryDate : NSString , notifyDate : NSString , userID : NSString , grpID : NSString , RepeatDateTime : NSString, questionType : NSString, questionText : NSString, option1 : NSString, option2 : NSString,sendSMSNonSmartPh:NSString,sendSMSAll:NSString,rsvpEnable:Int) {
     //  "sendSMSNonSmartPh":"0",//off          "sendSMSAll":"1",
     
     appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
     if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
     
     //loaderViewMethod()
     do {
     
     
     let post:NSString =  String(format: "eventID=%@&questionEnable=%@&eventType=%@&membersIDs=%@&eventImageID=%@&evntTitle=%@&evntDesc=%@&eventVenue=%@&venueLat=%@&venueLong=%@&evntDate=%@&publishDate=%@&expiryDate=%@&notifyDate=%@&userID=%@&grpID=%@&RepeatDateTime=%@&questionType=%@&questionText=%@&option1=%@&option2=%@&sendSMSNonSmartPh=%@&sendSMSAll=%@&rsvpEnable=%d",eventID,questionEnable,eventType,membersIDs,eventImageID,evntTitle,evntDesc,eventVenue,venueLat,venueLong,evntDate,publishDate,expiryDate,notifyDate,userID,grpID,RepeatDateTime,questionType,questionText,option1,option2,sendSMSNonSmartPh,sendSMSAll,rsvpEnable)
     
     NSLog("PostData: %@",post);
     
     let url:NSURL = NSURL(string:String(format: "%@Event/AddEvent",baseUrl))!
     
     NSLog("url: %@",url);
     let postData:NSData = post.dataUsingEncoding(NSUTF8StringEncoding)!
     
     let postLength:NSString = String( postData.length )
     
     let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
     request.HTTPMethod = "POST"
     request.HTTPBody = postData
     request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
     request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
     request.setValue("application/json", forHTTPHeaderField: "Accept")
     
     
     do {
     
     NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) in
     let string = NSString(data: data!, encoding: NSISOLatin1StringEncoding)
     print("Response 8888 \(string!)")
     
     let data = string!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
     let addAnnoun:AddEventResult!
     addAnnoun = AddEventResult.fromJSONData(data) as! AddEventResult
     self.window = nil
     
     self.delegates?.addEventDelegateFunction!(addAnnoun)
     
     }
     }
     
     
     }
     }
     }
     */
    //    func addEventsResult(_ eventID : NSString , questionEnable : NSString , eventType : NSString , membersIDs : NSString , eventImageID : NSString , evntTitle : NSString , evntDesc : NSString , eventVenue : NSString, venueLat : NSString, venueLong : NSString  , evntDate : NSString ,  publishDate : NSString , expiryDate : NSString , notifyDate : NSString , userID : NSString , grpID : NSString , RepeatDateTime : NSString, questionType : NSString, questionText : NSString, option1 : NSString, option2 : NSString,sendSMSNonSmartPh:NSString,sendSMSAll:NSString,rsvpEnable:Int,displayOnBanners:NSString)
    //    {
    //
    //    }
    
//  Parameter from android ----  [isSubGrpAdmin:0, eventID:0, questionEnable:0, eventType:0, membersIDs:, eventImageID:36952, evntTitle:Ttt, evntDesc:G, eventVenue:Kaizen Infotech Solutions Pvt Ltd.1st Floor, Building A, Gala Industrial Estate, Dindayal Upadhyay Marg Mulund W  400 080 India., venueLat:0.0, venueLong:0.0, evntDate:2021-11-19 15:03, evntTime:, publishDate:2021-11-19 15:02, publishTime:, expiryDate:2021-11-23 15:01, expiryTime:, notifyDate:2021-11-19 15:02, notifyTime:, userID:643779, grpID:2765, RepeatDateTime:, sendSMSAll:0, questionType:0, questionText:, option1:, option2:, rsvpEnable:0, displayonbanner:0, reglink:]
    
// ios parameterr -------- ["sendSMSNonSmartPh": "0", "userID": "288982", "membersIDs": "", "evntTitle": "21 dec ", "rsvpEnable": "0", "questionEnable": "0", "reglink": "https://iosinterviewguide.com/ios-interview-questions-for-senior-developers-in-2020", "venueLat": "", "venueLong": "", "questionType": "0", "eventID": "0", "grpID": "2765", "eventVenue": "Kaizen Infotech Solutions Pvt Ltd.1st Floor, Building A, Gala Industrial Estate, Dindayal Upadhyay Marg Mulund (W)  400 080 India.", "RepeatDateTime": "", "questionText": "", "displayonbanner": "1", "eventType": "0", "notifyDate": "", "sendSMSAll": "0", "eventImageID": "37893", "publishDate": "2021-12-21 12:04:00", "option2": "", "option1": "", "expiryDate": "2021-12-23 12:02:00", "evntDesc": "Dggdgxfhjvjg", "evntDate": "2021-12-21 13:02:00"]
    
    
    
    
    //Working in swift new version
    func addEventsResult(eventID : NSString , questionEnable : NSString , eventType : NSString , membersIDs : NSString , eventImageID : NSString , evntTitle : NSString , evntDesc : NSString , eventVenue : NSString, venueLat : NSString, venueLong : NSString  , evntDate : NSString ,  publishDate : NSString , expiryDate : NSString , notifyDate : NSString , userID : NSString , grpID : NSString , RepeatDateTime : NSString, questionType : NSString, questionText : NSString, option1 : NSString, option2 : NSString,sendSMSNonSmartPh:NSString,sendSMSAll:NSString,rsvpEnable:Int,displayOnBanners:NSString,link:NSString,isSubGrpAdmin:String)
    {
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            
            
            var getLinkValue:String!=link as! String
            if(getLinkValue.characters.count>3)
            {
            }
            else
            {
                UserDefaults.standard.setValue("nothing", forKey: "session_LinkValue")
            }
            
            //loaderViewMethod()
            SVProgressHUD.show()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Event/AddEvent_New"
            var params: [String: String] = ["eventID":eventID as String ,"questionEnable":questionEnable as String ,"eventType":eventType as String ,"membersIDs":membersIDs as String ,"eventImageID":eventImageID as String ,"evntTitle":evntTitle as String ,"evntDesc":evntDesc as String ,"eventVenue":eventVenue as String ,"venueLat":venueLat as String ,"venueLong":venueLong as String ,"evntDate":evntDate as String ,"publishDate":publishDate as String ,"expiryDate":expiryDate as String ,"notifyDate":notifyDate as String ,"userID":userID as String ,"grpID":grpID as String ,"RepeatDateTime":RepeatDateTime as String ,"questionType":questionType as String ,"questionText":questionText as String ,"option1":option1 as String ,"option2":option2 as String ,"sendSMSNonSmartPh":sendSMSNonSmartPh as String ,"sendSMSAll":sendSMSAll as String ,"rsvpEnable":String(rsvpEnable),"displayonbanner":displayOnBanners as String,"reglink":link as String,"isSubGrpAdmin" : isSubGrpAdmin as String,"evntTime":"","publishTime":"","expiryTime":"","notifyTime":"",]
            
            
//            Parameter from android ----  [isSubGrpAdmin:0, eventID:0, questionEnable:0, eventType:0, membersIDs:, eventImageID:36952, evntTitle:Ttt, evntDesc:G, eventVenue:Kaizen Infotech Solutions Pvt Ltd.1st Floor, Building A, Gala Industrial Estate, Dindayal Upadhyay Marg Mulund W  400 080 India., venueLat:0.0, venueLong:0.0, evntDate:2021-11-19 15:03, evntTime:, publishDate:2021-11-19 15:02, publishTime:, expiryDate:2021-11-23 15:01, expiryTime:, notifyDate:2021-11-19 15:02, notifyTime:, userID:643779, grpID:2765, RepeatDateTime:, sendSMSAll:0, questionType:0, questionText:, option1:, option2:, rsvpEnable:0, displayonbanner:0, reglink:]
            
            
            
            
            
            
            
            
            
            
            
            print("Add/Update Event url:: \(url)")
            print("Add/Update params:: \(params)")
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let sub:AddEventResult!
                        sub = AddEventResult.fromJSONData(jsonData) as! AddEventResult
                        NSLog("login data %@", sub.status)
                        print(sub.status)
                        
                        self.delegates?.addEventDelegateFunction!(addAnnoun: sub)
                    }
                case .failure(_): break
                    
                }
                SVProgressHUD.dismiss()
            }
            
            /*-------------------------------------------------------------*/
        }
        
    }
    
    func getSubGroupsList(_ groupId: NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            //loaderViewMethod()
            SVProgressHUD.show()
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/GetSubGroupList"
            var params: [String: String] = ["groupId": groupId as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let sub:TBGetSubGroupListResult!
                        sub = TBGetSubGroupListResult.fromJSONData(jsonData) as! TBGetSubGroupListResult
                        print("login data \(sub.status)")
                        self.window = nil
                        self.delegates?.getSubGroupsResultDelegate!(sub)
                        SVProgressHUD.dismiss()
                    }
                    
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
        }
    }
    
    func getAnnouceDetail(_ announID: NSString,grpID:NSString,memberProfileID:NSString) {
        //{"announID":"20","grpID":"1","memberProfileID":"1"}
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Announcement/GetAnnouncementDetails"
            var params: [String: String] = ["announID": announID as String,"grpID": grpID as String,"memberProfileID": memberProfileID as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        print(value)
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        
                        
                       if (((value as AnyObject).object(forKey: "TBAnnounceListResult")! as AnyObject).object(forKey: "message") as! String != "Record not found"){



                            let dictMain=(((dic as AnyObject).object(forKey: "TBAnnounceListResult")! as AnyObject).object(forKey: "AnnounListResult")! as AnyObject).object(at: 0)


                            print(dictMain)
                            print(((dictMain as AnyObject).object(forKey: "AnnounceList")! as AnyObject).value(forKey: "reglink")as! String)


                            let valueLink:String=((dictMain as AnyObject).object(forKey: "AnnounceList")! as AnyObject).value(forKey: "reglink")as! String
                            if(valueLink.characters.count>8)
                            {
                                UserDefaults.standard.setValue(valueLink, forKey: "session_LinkValueAnnouncement")
                            }
                            else
                            {
                                UserDefaults.standard.setValue("nothing", forKey: "session_LinkValueAnnouncement")
                            }

                            let announ:TBAnnounceListResult!
                            announ = TBAnnounceListResult.fromJSONData(jsonData) as! TBAnnounceListResult
                            NSLog("login data %@", announ.status)
                            self.window = nil
                            self.delegates?.getallAnnounOFUSerSuccss!(string: announ)

                            SVProgressHUD.dismiss()
                        }
                        else{
                            SVProgressHUD.dismiss()
                            let announ:TBAnnounceListResult!
                            announ = TBAnnounceListResult.fromJSONData(jsonData) as! TBAnnounceListResult
                            NSLog("login data %@", announ.status)
                            self.window = nil
                            self.delegates?.getallAnnounOFUSerSuccss!(string: announ)
                        }
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
        }
    }
    
    //Working in swift new version
    func getEventsDetail(groupProfileID:String,grpID:NSString,eventID:NSString)
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            //loaderViewMethod()
            SVProgressHUD.show()
            
            do {
                let url = baseUrl+"Event/GetEventDetails"
                var params: [String: String] = [
                    "groupProfileID": groupProfileID,
                    "eventID": eventID as String,
                    "grpId":grpID as String]
                print(url)
                print(params)
                print("here is the event detail ..............")
                Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                    switch response.result {
                    case .success:
                        if response.result.value != nil {
                            let dic:NSDictionary = response.result.value! as! NSDictionary
                            let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                            let jsonString = String(data: jsonData!, encoding: .utf8)!
                            print(jsonString)
                            
                            //----
                            // var mydict:NSDictionary=NSDictionary()
                            // mydict = ((dic as AnyObject).value(forKey: "EventsListDetailResult")! as AnyObject).value(forKey: (("EventsDetailResult") as AnyObject) as! String) as! String).object(at: 0)

                            print("Event Details Response::\(dic)")
                            if let dictMainnew=((dic.object(forKey: "EventsListDetailResult") as? AnyObject)!.object(forKey: "EventsDetailResult") as? AnyObject)
                            {
                            myTempDictForScreenShotDataHolding=dic
                            print(myTempDictForScreenShotDataHolding)
                            if(dictMainnew.count>0)
                            {
                                let dictMain=((dic.object(forKey: "EventsListDetailResult")! as AnyObject).object(forKey: "EventsDetailResult")! as AnyObject).object(at: 0)
                                
                                
                                print(dictMain)
                                print(((dictMain as AnyObject).object(forKey: "EventsDetail")! as AnyObject).value(forKey: "reglink")as! String)
                                
                                let letGetFilterTypeValue=((dictMain as AnyObject).object(forKey: "EventsDetail")! as AnyObject).value(forKey: "filterType")
                                                                
                                let valueDistrictorClubName=((dictMain as AnyObject).object(forKey: "EventsDetail")! as AnyObject).value(forKey: "grpname")
                                
                                cluborDistrictName=valueDistrictorClubName as! String
                                
                                
                                
                                let valueLink:String=((dictMain as AnyObject).object(forKey: "EventsDetail")! as AnyObject).value(forKey: "reglink")as! String
                                if(valueLink.characters.count>8)
                                {
                                    UserDefaults.standard.setValue(valueLink, forKey: "session_LinkValue")
                                }
                                else
                                {
                                    UserDefaults.standard.setValue("nothing", forKey: "session_LinkValue")
                                    
                                }
                                
                                
                                print("----------------:this is value:-------------")
                                print(letGetFilterTypeValue)
                                
                                 
                                
                                UserDefaults.standard.setValue(letGetFilterTypeValue!, forKey: "session_GetFilterTypeValue")
                                
                                
                                
                                print("this is value for my value:-----")
                                print(letGetFilterTypeValue)
                                print(letGetFilterTypeValue)
                                
                                
                                
                                let eventDetails:EventsListDetailResult!
                                eventDetails = EventsListDetailResult.fromJSONData(jsonData) as! EventsListDetailResult
                                NSLog("login data %@", eventDetails.status)
                                self.window = nil
                                  var vargetvale:String! =  (dic.value(forKey: "EventsListDetailResult") as! NSDictionary).value(forKey: "status") as! String
                                
                                if(vargetvale=="1")
                                {
                                    self.window.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                                    SVProgressHUD.dismiss()
                                }
                                else
                                {
                                    if(((dic.value(forKey: "EventsListDetailResult") as! NSDictionary).value(forKey: "EventsDetailResult") as! NSArray).count>0)
                                    {
                                        let letGetFilterTypeValue = (((((dic.value(forKey: "EventsListDetailResult") as! NSDictionary).value(forKey: "EventsDetailResult") as! NSArray).object(at: 0) as AnyObject).value(forKey: "EventsDetail") as! NSDictionary).value(forKey: "filterType") as! String)
                                        print(letGetFilterTypeValue)
                                        
                                        UserDefaults.standard.setValue(letGetFilterTypeValue, forKey: "session_GetFilterTypeValue")
                                    }
                                    self.delegates?.getEventsDetailsSuccess!(eventsDetails: eventDetails)
                                    SVProgressHUD.dismiss()
                                }
                                
                            }
                            else
                            {
                                SVProgressHUD.dismiss()
                            }
                        }else
                        {
                            print("Not set event details")
                        }
                    }
                        
                    case .failure(_): break
                    }
                }
            }
        }
    }
    
    func getSMSCountDetailWebService(url:String,parameter:[String:Any])
    {
        print("URL:___:\(url)")
        print("Parameter:___:\(parameter)")
        SVProgressHUD.show()
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() {
            response in
            switch response.result
            {
            case .success:
                if let value = response.result.value
                {
                    var TBsmscountResult:NSDictionary=NSDictionary()
                    TBsmscountResult = response.result.value as! NSDictionary
                     print ("Response for getsmscount details:: \(TBsmscountResult)")
                    
                    self.delegates?.getSMSCountdetailsDelegateFunction!(TBsmscountResult)
                    SVProgressHUD.dismiss()
                }
                break
            case .failure(_): break
            }
        }
    }
    
    //{"subGroupTitle":"Software Team","memberProfileId":"1,3,4","groupId":"1","memberMainId":"1"}
    func createSubGroup(_ subGroupTitle: NSString,memberProfileId:NSString,groupId:NSString,memberMainId:NSString,parentID:NSString) {
        //{"announID":"20","grpID":"1","memberProfileID":"1"}
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/CreateSubGroup"
            var params: [String: String] = ["subGroupTitle": subGroupTitle as String,"memberProfileId": memberProfileId as String,"groupId": groupId as String,"memberMainId": memberMainId as String,"parentID": parentID as String]
            
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let announ:TBGetSubGroupListResult!
                        announ = TBGetSubGroupListResult.fromJSONData(jsonData) as! TBGetSubGroupListResult
                        NSLog("login data %@", announ.status)
                        self.window = nil
                        self.delegates?.createSubGroupSucc!(announ)
                        SVProgressHUD.dismiss()
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            
            
        }
    }
    func getEventListofUserGrp(_ groupProfileID: NSString,grpId:NSString,Type:NSString,Admin:NSString,searchText:NSString) {
        //{"groupProfileID":"43","grpId":"74","Type":"0","Admin":"0","searchText":"eve"}
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            SVProgressHUD.show()
            
            
            //loaderViewMethod()
            do {
                var admi:NSString!
                if(Admin=="No"){
                    admi="0"
                }else{
                    admi="1"
                }
                /*-------------------------------------------------------------*/
                let url = baseUrl+"Event/GetEventList"
                var params: [String: String] = [
                    "groupProfileID": groupProfileID as String,
                    "grpId": grpId as String,
                    "Type": Type as String,
                    "Admin": admi as String,
                    "searchText": searchText  as String
                ]
                print("GetEventList url \(url)")
                print(params)
                Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                    switch response.result {
                    case .success:
                        // var result = [String:String]()
                        if let value = response.result.value {
                            let dic = response.result.value!
                            let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                            let jsonString = String(data: jsonData!, encoding: .utf8)!
                            
                            print("This is value lllll")
                            print(jsonString)
                            let announ:EventListDetailResult!
                            announ = TBGetSubGroupListResult.fromJSONData(jsonData) as! EventListDetailResult
                            NSLog("login data %@", announ.status)
                            print(announ.status)
                            //  if(announ.status == "0"){
                            self.window = nil
                            //self.Loadingview.removeFromSuperview()
                            self.delegates?.getEventListSucc!(announ)
                            
                            SVProgressHUD.dismiss()
                        }
                    case .failure(_): break
                    }
                }
                /*-------------------------------------------------------------*/
            }
        }
    }
    func subGrpDEtailofUserGrp(_ groupId: NSString,subgrpId:NSString) {
        //{"groupId":"1","subgrpId":"50"}
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/GetSubGroupDetail"
            var params: [String: String] = ["groupId": groupId as String,"subgrpId": subgrpId as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        
                        
                        let announ:TBGetSubGroupDetailListResult!
                        announ = TBGetSubGroupListResult.fromJSONData(jsonData) as! TBGetSubGroupDetailListResult
                        NSLog("login data %@", announ.status)
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        if(announ.status == "0"){
                            self.delegates?.getsubgrpDetailListSucc!(announ)
                        }
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
        }
    }
    
    
    func getGlobalSearchDetail(_ memId: NSString,otherMemId:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/GlobalSearchGroup"
            var params: [String: String] = ["memId": memId as String,"otherMemId": otherMemId as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        
                        let globalSearchDetail:TBGlobalSearchGroupResult!
                        globalSearchDetail = TBGlobalSearchGroupResult.fromJSONData(jsonData) as! TBGlobalSearchGroupResult
                        NSLog("login data %@", globalSearchDetail.status)
                        self.window = nil
                        self.delegates?.getGLobalSearchDetailDelegate!(globalSearchDetail)
                        SVProgressHUD.dismiss()
                        
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
        }
    }
    
    func getAllEbulletinOFUSer(_ groupId: NSString,memberProfileId:NSString,searchText:NSString,type:NSString,isAdmin:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            SVProgressHUD.show()
            //loaderViewMethod()
            /*-------------------------------------------------------------*/
            
            var admi:NSString!
            if(isAdmin=="No"){
                admi="0"
            }else{
                admi="1"
            }
            let url = URL(string: baseUrl+"Ebulletin/GetEbulletinList")!
            var params: [String: String] = [
                "groupId": groupId as String,
                "memberProfileId": memberProfileId as String,
                "searchText": searchText as String,
                "type": type as String,
                "isAdmin": admi as String
            ]
            
            
            print(url)
            print(params)
            
            
            
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    if let value = response.result.value
                    {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let announ:TBEbulletinListResult!
                        announ = TBEbulletinListResult.fromJSONData(jsonData) as! TBEbulletinListResult
                        NSLog("login data %@", announ.status)
                        NSLog("login data %@", announ)
                        self.window = nil
                        self.delegates?.getallbulletinOFUSerSuccssS!(string: announ)
                        SVProgressHUD.dismiss()
                        
                    }
            }
            
            
            //            print(url)
            //            print(params)
            //            let urlPath: String = baseUrl+"Ebulletin/GetEbulletinList"
            //            var urls: NSURL = NSURL(string: urlPath)!
            //            var request: NSMutableURLRequest = NSMutableURLRequest(URL: urls)
            //
            //            request.httpMethod = "POST"
            //            var stringPost="groupId="+groupId+"&memberProfileId="+memberProfileId+"&searchText="+searchText+"&type="+type+"&isAdmin="+admi // Key and Value
            //
            //            let data = stringPost.dataUsingEncoding(NSUTF8StringEncoding)
            //
            //            request.timeoutInterval = 60
            //            request.HTTPBody=data
            //            request.httpShouldHandleCookies=false
            //
            //            let queue:OperationQueue = OperationQueue()
            //
            //            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue(), completionHandler:{ (response:URLResponse!, data: NSData!, error: NSError!) -> Void in
            //                var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            //                let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            //
            //                if (jsonResult != nil)
            //                {
            //                    // Success
            //                    print(jsonResult)
            //                    if let value = response.result.value
            //                    {
            //                        let dic = response.result.value!
            //                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
            //                        let jsonString = String(data: jsonData!, encoding: .utf8)!
            //                        print(jsonString)
            //                        let announ:TBEbulletinListResult!
            //                        announ = TBEbulletinListResult.fromJSONData(jsonData) as! TBEbulletinListResult
            //                        NSLog("login data %@", announ.status)
            //                        NSLog("login data %@", announ)
            //                        self.window = nil
            //                        self.delegates?.getallbulletinOFUSerSuccssS!(string: announ)
            //                    }
            //                    print(message)
            //                }
            //                else
            //                {
            //                    print("Failed")
            //                }
            //
            //            })
            
            
            /*
             Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
             switch response.result {
             case .success:
             if let value = response.result.value {
             let dic = response.result.value!
             let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
             let jsonString = String(data: jsonData!, encoding: .utf8)!
             print(jsonString)
             let announ:TBEbulletinListResult!
             announ = TBEbulletinListResult.fromJSONData(jsonData) as! TBEbulletinListResult
             NSLog("login data %@", announ.status)
             NSLog("login data %@", announ)
             self.window = nil
             self.delegates?.getallbulletinOFUSerSuccssS!(string: announ)
             }
             case .failure(_): break
             self.window = nil
             }
             self.window = nil
             }
             */
            
            /*-------------------------------------------------------------*/

        }
    }
    
    
    
    
    func addAnnouncementResult(_ announID : String , annType : String , announTitle : String , announceDEsc : String , memID : String , grpID : String , inputIDs : String ,announImg:String, publishDate : String,  expiryDate : String,sendSMSNonSmartPh:NSString,sendSMSAll:NSString,moduleId:NSString,AnnouncementRepeatDates:String ) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            
            
            /*-------------------------------------------------------------*/
            let url = URL(string: baseUrl+"Announcement/AddAnnouncement")!
            var params: [String: String] = [
                "announID":announID,
                "annType":annType,
                "announTitle":announTitle,
                "announceDEsc":announceDEsc,
                "memID":memID,
                "grpID":grpID,
                "inputIDs":inputIDs,
                "announImg":announImg,
                "publishDate":publishDate,
                "expiryDate":expiryDate,
                "sendSMSNonSmartPh":sendSMSNonSmartPh as String,
                "sendSMSAll":sendSMSAll as String,
                "moduleId":moduleId as String,
                "AnnouncementRepeatDates":AnnouncementRepeatDates
            ]
            
            
            
            print("Add/Update Announcement url:: \(url)")
            print("Add/Update Announcement params:: \(params)")
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let addAnnoun:TBAddAnnouncementResult!
                        addAnnoun = TBAddAnnouncementResult.fromJSONData(jsonData) as! TBAddAnnouncementResult
                        self.window = nil
                        self.delegates?.addAnnounceDelegateFunction!(addAnnoun)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            /*-------------------------------------------------------------*/
        }
    }
    
    
    
    
    func addEBulletineResult(_ ebulletinID : String , ebulletinType : String , ebulletinTitle : String , ebulletinlink : String , ebulletinfileid : String,memID : String , grpID : String , inputIDs : String , publishDate : String,  expiryDate : String,sendSMSAll:NSString,isSubGrpAdmin:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Ebulletin/AddEbulletin"
            var params: [String: String] = [
                "ebulletinID":ebulletinID,
                "ebulletinType":ebulletinType,
                "ebulletinTitle":ebulletinTitle,
                "ebulletinlink":ebulletinlink,
                "ebulletinfileid":ebulletinfileid,
                "memID":memID,
                "grpID":grpID,
                "inputIDs":inputIDs,
                "publishDate":publishDate,
                "expiryDate":"2099-04-05 15:09:00",
//              "sendSMSNonSmartPh":sendSMSNonSmartPh as String,
                "sendSMSAll":sendSMSAll as String,
                "isSubGrpAdmin": isSubGrpAdmin as String,
            ]
            
//
           
//            http://rotaryindiaapi.rosteronwheels.com/api/Ebulletin/AddEbulletin :- [isSubGrpAdmin:0, ebulletinID:0, ebulletinType:0, ebulletinTitle:Ebull, ebulletinlink:www.google.com, ebulletinfileid:0, memID:643779, grpID:2765, inputIDs:, publishDate:2021-11-12 18:03, expiryDate:2099-04-05 15:09:00, sendSMSAll:0]

            
            
            
            
            print("Add E-Bulleting url :: \(url)")
            print("Add E-Bulleting params:: \(params)")
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let addBulletine:TBAddEbulletinResult!
                        addBulletine = TBAddEbulletinResult.fromJSONData(jsonData) as! TBAddEbulletinResult
                        //  self.window = nil
                        self.delegates?.addBulletineDelegateFunction!(addBulletine)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                    //  self.window = nil
                }
                //  self.window = nil
            }
            
            /*-------------------------------------------------------------*/
        }
    }
    
    
    func getAddMembersToGroup(_ mobile : String , userName : String , groupId : String,masterID : String , countryId : String , memberEmail : String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/AddMemberToGroup"
            var params: [String: String] = [
                "mobile":mobile,
                "userName":userName,
                "groupId":groupId,
                "masterID":masterID,
                "countryId":countryId,
                "memberEmail":memberEmail
            ]
            
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let addMembers:TBAddMemberGroupResult!
                        addMembers = TBAddMemberGroupResult.fromJSONData(jsonData) as! TBAddMemberGroupResult
                        NSLog("login data %@", addMembers.status)
                        self.window = nil
                        self.delegates?.getAddMembersSuccss!(addMembers)
                        SVProgressHUD.dismiss()
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            /*-------------------------------------------------------------*/
        }
    }

    func getGroupInfoDetail(_ memberUID: NSString,grpID:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/GetGroupDetail"
            var params: [String: String] = ["memberMainId": memberUID as String,"groupId":grpID as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let grpInfo:TBGetGroupResult!
                        grpInfo = TBGetGroupResult.fromJSONData(jsonData) as! TBGetGroupResult
                        NSLog("login data %@", grpInfo.status)
                        self.window = nil
                        self.delegates?.getGroupInfoDetailDelegate!(grpInfo)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
        }
    }
    
    
    
    func getGroupInfoForEdit(_ grpID:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            /*-------------------------------------------------------------*/
            let url = URL(string: baseUrl+"group/GetGroupInfo")!
            var params: [String: String] = ["grpId": grpID as String as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let grpInfo:TBGetGroupResult!
                        grpInfo = TBGetGroupResult.fromJSONData(jsonData) as! TBGetGroupResult
                        NSLog("login data %@", grpInfo.status)
                        self.window = nil
                        self.delegates?.getGroupInfoDetailDelegate!(grpInfo)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
        }
    }
    
    
    
    
    func getQuestionsAnswering(_ grpId: NSString,profileID:String,eventId: NSString,joiningStatus:NSString,questionId: NSString,answerByme:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Event/AnsweringEvent"
            var params: [String: String] = [
                "grpId": grpId as String,
                "profileID": profileID,
                "eventId": eventId as String,
                "joiningStatus": joiningStatus as String,
                "questionId": questionId as String,
                "answerByme": answerByme as String
            ]
            
            
            
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let queAns:EventJoinResult!
                        queAns = EventJoinResult.fromJSONData(jsonData) as! EventJoinResult
                        NSLog("login data %@", queAns.status)
                        self.window = nil
                        self.delegates?.getQueAnsInfoDetailDelegate!(queAns: queAns)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            /*-------------------------------------------------------------*/
        }
    }
    
    
    
    
    
    func uploadDocument(_ docID : String , docType : String , docTitle : String , memID : String , grpID : String , inputIDs : String , documentFileId : String, docAccessType : String,publishDate:String,expiryDate:String,isSubGrpAdmin:String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            SVProgressHUD.show()
            //loaderViewMethod()
//            0,
//            207974,
//            0,
//            208061,
//            208062
//            )
//            )
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"DocumentSafe/AddDocument"
            var params: [String: String] = [
                "docID": docID,
                "docType": docType,
                "docTitle": docTitle,
                "memID": memID,
                "grpID": grpID,
                "inputIDs": inputIDs,
                "documentFileId": documentFileId,
                "docAccessType": docAccessType,
                "publishDate": publishDate,
                "expiryDate": expiryDate,
                "isSubGrpAdmin": isSubGrpAdmin
                ]
            
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let uploadDoc : TBAddDocumentResult!
                        uploadDoc = TBAddDocumentResult.fromJSONData(jsonData) as! TBAddDocumentResult
                        self.delegates?.UploadDocumentDelegateFunction!(uploadDoc)
                        SVProgressHUD.dismiss()
                        // self.window = nil
                    }
                case .failure(_): break
                    // self.window = nil
                }
                //self.window = nil
            }
            
            /*-------------------------------------------------------------*/
        }
    }
    
    //{"grpID":"1","memberProfileID":"95"}
    /*
     "type":"0","isAdmin":"0","searchText":
     */
    func DocumentsListing(_ grpID : String , memberProfileID : String,stringType:String,stringIsAdmin:String,StringSearchTest:String)
    {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            SVProgressHUD.show()
            
            //loaderViewMethod()
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"DocumentSafe/GetDocumentList"
            var params: [String: String] = [
                "grpID": grpID,
                "memberProfileID": memberProfileID,
                "type": stringType,
                "isAdmin": stringIsAdmin,
                "searchText": StringSearchTest
            ]
            
            
            print(url)
            print(params)
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let docList : TBDocumentistResult!
                        docList = TBDocumentistResult.fromJSONData(jsonData) as! TBDocumentistResult
                        self.delegates?.DocumentListingDelegateFunction?(docList)
                        SVProgressHUD.dismiss()
                        //  self.window = nil
                    }
                case .failure(_): break
                    // self.window = nil
                }
                //self.window = nil
            }
            
            
            //-----------
            /*
             Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
             .responseJSON { response in
             print(response.request as Any)  // original URL request
             print(response.response as Any) // URL response
             print(response.result.value as Any)   // result of response serialization
             
             if let value = response.result.value {
             let dic = response.result.value!
             let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
             let jsonString = String(data: jsonData!, encoding: .utf8)!
             print(jsonString)
             let docList : TBDocumentistResult!
             docList = TBDocumentistResult.fromJSONData(jsonData) as! TBDocumentistResult
             self.delegates?.DocumentListingDelegateFunction!(docList)
             self.window = nil
             }
             
             }
             */
            //-----------
            /*-------------------------------------------------------------*/
        }
    }
    func getTouchBaseSetting(_ mainMasterId : String ) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            SVProgressHUD.show()
            //loaderViewMethod()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"setting/GetTouchbaseSetting"
            var params: [String: String] = ["mainMasterId": mainMasterId]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let docList : TBSettingResult!
                        docList = TBSettingResult.fromJSONData(jsonData) as! TBSettingResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.getTouchBaseSettigSucc!(docList)
                        SVProgressHUD.dismiss()
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            /*-------------------------------------------------------------*/
        }
    }
    
    func updateTouchBaseSetting(_ GroupId : String , UpdatedValue : String , mainMasterId : String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            SVProgressHUD.show()
            //loaderViewMethod()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"setting/TouchbaseSetting"
            var params: [String: String] = ["GroupId": GroupId,"UpdatedValue": UpdatedValue,"mainMasterId": mainMasterId]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let docList : TBSettingResult!
                        docList = TBSettingResult.fromJSONData(jsonData) as! TBSettingResult
                        self.window = nil
                        self.delegates?.updateTouchBaseSettigSucc!(docList)
                        SVProgressHUD.dismiss()
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            /*-------------------------------------------------------------*/
        }
    }
    
    //{"GroupId":"","GroupProfileId":""}
    func getTouchBasegroupsSetting(_ GroupProfileId : String , GroupId : String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            //loaderViewMethod()
            SVProgressHUD.show()
            /*-------------------------------------------------------------*/
            let url = URL(string: baseUrl+"setting/GetGroupSetting")!
            var params: [String: String] = ["GroupProfileId": GroupProfileId,"GroupId": GroupId]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let docList : TBGroupSettingResult!
                        docList = TBGroupSettingResult.fromJSONData(jsonData) as! TBGroupSettingResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.getTouchBaseGroupsSettigSucc!(docList)
                        SVProgressHUD.dismiss()
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
        }
    }
    //{"GroupId":"","ModuleId":"","GroupProfileId":"","UpdatedValue":"0","isMob":"0","isEmail":"0","isPersonal":"1","isFamily":"1","isBusiness":"1"}
    func updategrpTouchBaseSetting(_ GroupId : String , UpdatedValue : String , GroupProfileId : String, ModuleId : String, isMob : String, isEmail : String, isPersonal : String, isFamily : String , isBusiness:String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            SVProgressHUD.show()
            
            //loaderViewMethod()
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"setting/GroupSetting"
            var params: [String: String] = ["GroupId": GroupId,"UpdatedValue": UpdatedValue,"GroupProfileId": GroupProfileId,
                                            "ModuleId": ModuleId,"isMob": isMob,"isEmail": isEmail,
                                            "isPersonal": isPersonal,"isFamily": isFamily,"isBusiness": isBusiness
            ]

            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let docList : TBGroupSettingResult!
                        docList = TBGroupSettingResult.fromJSONData(jsonData) as! TBGroupSettingResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.updategrpTouchBaseSettigSucc!(docList)
                        SVProgressHUD.dismiss()
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            /*-------------------------------------------------------------*/
        }
    }
    
    func updatepersonalProfile(_ profileID : String , key : NSMutableArray ) {
        // appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //------------------------------------
            SVProgressHUD.show()
            
            
            
            //-----------------------------------------
            let abc = ""
            
            do {
                let jsonData: Data = try JSONSerialization.data(withJSONObject: key, options: JSONSerialization.WritingOptions.prettyPrinted);
                let abc = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
                
            }
            catch
            {
                
            }
            
            /*-------------------------------------------------------------*/
            let url =  baseUrl+"Member/UpdateProfilePersonalDetails"
            var params: [String: String] = ["key": abc,"profileID": profileID]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let docList : UserResult!
                        docList = UserResult.fromJSONData(jsonData) as! UserResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.updatepersonalProfileSucc!(docList)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
        }
    }
    func getAddFamilyMembersToProfile(_ familyMemberId : String , memberName : String , relationship : String,dOB : String , anniversary : String , contactNo : String,particulars : String , bloodGroup : String , profileId : String , emailID : String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Member/UpdateFamilyDetails"
            var params: [String: String] = [
                "familyMemberId": familyMemberId,"memberName": memberName,"relationship": relationship,
                "dOB": dOB,"anniversary": anniversary,"contactNo": contactNo,
                "particulars": particulars,"profileId": profileId,"emailID": emailID,"bloodGroup": bloodGroup
            ]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let addFamilyMembers:UpdateFamilyResult!
                        addFamilyMembers = UpdateFamilyResult.fromJSONData(jsonData) as! UpdateFamilyResult
                        NSLog("login data %@", addFamilyMembers.status)
                        self.window = nil
                        self.delegates?.getAddFamilyMembersSuccss!(addFamilyMembers)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            /*-------------------------------------------------------------*/
        }
    }
    
    func getAddAddressToProfile(_ addressID : String , addressType : String , address : String,city : String , state : String , country : String,pincode : String , phoneNo : String , fax : String , profileID : String , groupID:String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Member/UpdateAddressDetails"
            var params: [String: String] = [
                "addressID":addressID,
                "addressType":addressType,
                "address":address,
                "city":city,
                "state":state,
                "country":country,
                "pincode":pincode,
                "phoneNo":phoneNo,
                "fax":fax,
                "profileID":profileID,
                "groupID":groupID
            ]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let addAddress:UpdateAddressResult!
                        addAddress = UpdateAddressResult.fromJSONData(jsonData) as! UpdateAddressResult
                        NSLog("login data %@", addAddress.status)
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        //if(announ.status == "0"){
                        self.delegates?.getAddUpdateAddressSuccss!(addAddress)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            /*-------------------------------------------------------------*/
        }
    }
    
    
    func deleteDataWebservice(_ typeID : String , type : String ,profileID : String) {
        //{
        
        //}   (type - Event / Announcement / Ebulletin / Document / Member)
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
//            SVProgressHUD.show()
            
            
            //loaderViewMethod()
            
            
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/DeleteByModuleName"
            var params: [String: String] = ["typeID": typeID,"type": type,"profileID": profileID]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let docList : DeleteResult!
                        docList = DeleteResult.fromJSONData(jsonData) as! DeleteResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.deleteSucc!(docList)
//                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            /*-------------------------------------------------------------*/
        }
    }
    
    
    
    func ExitGroupUser(_ memberProfileId : String , groupId : String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            /*-------------------------------------------------------------*/
            let url = URL(string: baseUrl+"group/RemoveSelfFromGroup")!
            var params: [String: String] = ["memberProfileId": memberProfileId,"groupId": groupId]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let extGrp :TBRemoveSelfResult!
                        extGrp = TBRemoveSelfResult.fromJSONData(jsonData) as! TBRemoveSelfResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.ExitGroupDelegateFunction!(extGrp)
                        SVProgressHUD.dismiss()
                        
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            /*-------------------------------------------------------------*/
        }
    }
    
    func DeletePhotoEdit(_ typeID : String , grpID : String , type : String,moduleId: String) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            SVProgressHUD.show()
            
            
            //loaderViewMethod()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/DeleteImage"
            var params: [String: String] = [
                "typeID": typeID,
                "grpID": grpID,
                "type": type,
                "moduleId": moduleId,
                ]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let dltImage :DeleteResult!
                        dltImage = DeleteResult.fromJSONData(jsonData) as! DeleteResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.DeletePhotoDelegateFunction!(dltImage)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
        }
    }
    
    
    func suggestFeature(_ title : String , description : String , profileID : String ,grpId:NSString) {
        
        
        
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            SVProgressHUD.show()
            
            //loaderViewMethod()
            
            /*-------------------------------------------------------------*/
            let url =  baseUrl+"Group/SuggestFeature"
            var params: [String: String] = ["title": title,
                                            "description": description,
                                            "profileID": profileID,
                                            "grpId": grpId as String
            ]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let dltImage :SuggestFeatureResult!
                        dltImage = SuggestFeatureResult.fromJSONData(jsonData) as! SuggestFeatureResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.suggestfeatureDelegateFunction!(dltImage)
                        SVProgressHUD.dismiss()
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
        }
    }
    
    func deleteAnEntity(_ memberProfileId : String ,groupId:NSString) {
        
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            SVProgressHUD.show()
            
            
            //loaderViewMethod()
            
            /*-------------------------------------------------------------*/
            let url =  baseUrl+"Group/DeleteEntity"
            var params: [String: String] = ["memberProfileId": memberProfileId,"groupId": groupId as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let dltImage :TBDeleteEntityResult!
                        dltImage = TBDeleteEntityResult.fromJSONData(jsonData) as! TBDeleteEntityResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.deleteEntityDelegateFunction!(dltImage)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            
            
            
        }
    }
    
    
    
    func getEntityInfoList(_ grpID:NSString ,moduleID:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            SVProgressHUD.show()
            
            //loaderViewMethod()
            
            /*-------------------------------------------------------------*/
            let url = URL(string: baseUrl+"Group/GetEntityInfo")!
            var params: [String: String] = ["grpID": grpID as String,"moduleID": moduleID as String,]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let welcome:TBEntityInfoResult!
                        welcome = TBEntityInfoResult.fromJSONData(jsonData) as! TBEntityInfoResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.getEntityInfoDelegate!(welcome)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
        }
    }
    
    
    func getServiceDirList(_ groupId:NSString,searchText:NSString,moduleId:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            SVProgressHUD.show()
            
            //loaderViewMethod()
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Login/GetWelcomeScreen"
            var params: [String: String] = ["groupId": groupId as String,"searchText": searchText as String,"moduleId": moduleId as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        
                        
                        let welcome:TBServiceDirectoryResult!
                        welcome = TBServiceDirectoryResult.fromJSONData(jsonData) as! TBServiceDirectoryResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.getServiceDirListDelegate!(welcome)
                        
                        
                        SVProgressHUD.dismiss()
                        
                        
                        
                        print(jsonString)
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            //            do {
            //                let post:NSString =  String(format: "groupId=%@&searchText=%@&moduleId=%@", groupId,searchText,moduleId) as NSString
            //
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@ServiceDirectory/GetServiceDirectoryList",baseUrl))!
            //
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //                do {
            //
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //
            //                        let data = string?.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //                        let welcome:TBServiceDirectoryResult!
            //                        welcome = TBServiceDirectoryResult.fromJSONData(data) as! TBServiceDirectoryResult
            //                        self.window = nil
            //                        //self.Loadingview.removeFromSuperview()
            //                        self.delegates?.getServiceDirListDelegate!(welcome)
            //                        // self.window = nil
            //                        // NSLog("login data %@", login.otp)
            //                    } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //
            //            }
        }
    }
    
    
    
    func addeditServiceDirList(_ serviceId:NSString,groupId:NSString,memberName:NSString,description:NSString,image:NSString,countryCode1:NSString,mobileNo1:NSString,countryCode2:NSString,mobileNo2:NSString,paxNo:NSString,email:NSString,keywords:NSString,address:NSString,latitude:NSString,longitude:NSString,createdBy:NSString,city:NSString,state:NSString,country:NSString,zip_Code:NSString,moduleId:NSString,stringWebSite:NSString) {
        
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            /*-------------------------------------------------------------*/
            let url = URL(string: baseUrl+"ServiceDirectory/AddServiceDirectory")!
            //var params: [String: String] = ["groupId": groupId,"serviceDirId": serviceDirId]
            
            
            var params: [String: String] = ["serviceId":serviceId as String,
                                            "groupId":groupId as String,
                                            "memberName":memberName as String,
                                            "description":description as String,
                                            "image":image as String,
                                            "countryCode1":countryCode1 as String,
                                            "mobileNo1":mobileNo1 as String,
                                            "countryCode2":countryCode2 as String,
                                            "mobileNo2":mobileNo2 as String,
                                            "paxNo":paxNo as String,
                                            "email":email as String,
                                            "keywords":keywords as String,
                                            "address":address as String,
                                            "latitude":latitude as String,
                                            "longitude":longitude as String,
                                            "createdBy":createdBy as String,
                                            "city":city as String,
                                            "state":state as String,
                                            "addressCountry":country as String,
                                            "zipcode":zip_Code as String,
                                            "moduleId":moduleId as String,
                                            "website":stringWebSite  as String
            ]
            
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        let welcome:TBAddServiceResult!
                        welcome = TBAddServiceResult.fromJSONData(jsonData) as! TBAddServiceResult
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        self.delegates?.addServiceDirListDelegate!(welcome)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            
            
            
            
            /*
             do {
             let post:NSString =  String(format: "serviceId=%@&groupId=%@&memberName=%@&description=%@&image=%@&countryCode1=%@&mobileNo1=%@&countryCode2=%@&mobileNo2=%@&paxNo=%@&email=%@&keywords=%@&address=%@&latitude=%@&longitude=%@&createdBy=%@&city=%@&state=%@&addressCountry=%@&zipcode=%@&moduleId=%@&website=%@", serviceId,groupId,memberName,description,image,countryCode1,mobileNo1,countryCode2,mobileNo2,paxNo,email,keywords,address,latitude,longitude,createdBy,city,state,country,zip_Code,moduleId,stringWebSite) as NSString
             
             NSLog("PostData: %@",post);
             
             let url:URL = URL(string:String(format: "%@ServiceDirectory/AddServiceDirectory",baseUrl))!
             
             let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
             
             let postLength:NSString = String( postData.count ) as NSString
             
             let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
             request.httpMethod = "POST"
             request.httpBody = postData
             request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
             request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
             request.setValue("application/json", forHTTPHeaderField: "Accept")
             
             do {
             
             NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
             let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
             print("Response 8888 \(string!)")
             
             let data = string?.data(using: String.Encoding.utf8, allowLossyConversion: false)
             let welcome:TBAddServiceResult!
             welcome = TBAddServiceResult.fromJSONData(data) as! TBAddServiceResult
             self.window = nil
             //self.Loadingview.removeFromSuperview()
             self.delegates?.addServiceDirListDelegate!(welcome)
             // self.window = nil
             // NSLog("login data %@", login.otp)
             } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
             }
             
             
             }
             */
        }
    }
    
    func getDetailServiceDirList(_ groupId:NSString,serviceDirId:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            SVProgressHUD.show()
            
            //loaderViewMethod()
            
            /*-------------------------------------------------------------*/
            let url = URL(string: baseUrl+"ServiceDirectory/GetServiceDirectoryDetails")!
            var params: [String: String] = ["groupId": groupId as String,"serviceDirId": serviceDirId as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        let welcome:TBServiceDirectoryListResult!
                        welcome = TBServiceDirectoryListResult.fromJSONData(jsonData) as! TBServiceDirectoryListResult
                        self.window = nil
                        self.delegates?.getdetServiceDirListDelegate!(welcome)
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            
            
            
            
            
            //            do {
            //                let post:NSString =  String(format: "groupId=%@&serviceDirId=%@", groupId,serviceDirId) as NSString
            //
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: "%@ServiceDirectory/GetServiceDirectoryDetails",baseUrl))!
            //
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            ////
            ////                do {
            ////
            ////                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            ////                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            ////                        print("Response 8888 \(string!)")
            ////
            ////                        let data = string?.data(using: String.Encoding.utf8, allowLossyConversion: false)
            ////
            ////                        // self.window = nil
            ////                        // NSLog("login data %@", login.otp)
            ////                    } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            ////                }
            ////
            //
            //            }
        }
    }
    
    /*
     {"newmembers":
     [{
     "mobile": "6666666666",
     "userName": "test666",
     "totalMember": "1",
     "groupId": "313",
     "masterID": "1541",
     "countryId": "+91",
     "memberEmail": "test666@gmail.com"
     },
     {
     "mobile": "1111111111",
     "userName": "test111",
     "totalMember": "1",
     "groupId": "313",
     "masterID": "1541",
     "countryId": "+91",
     "memberEmail": "test111@gmail.com"
     }]
     }
     */
    
    ///Ganesh kendre
    //  wsm.sendAllPersonContactDetails(membersArr : Array)
    func sendAllPersonContactDetails(_ membersArr :NSDictionary)
    {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            SVProgressHUD.show()
            
            //loaderViewMethod()
            // let post:NSString = String(format: "subGroupTitle=%@&memberProfileId=%@&groupId=%@&memberMainId=%@",subGroupTitle,memberProfileId,groupId,memberMainId)
            /*-------------------------------------------------------------*/
            let url = baseUrl+"Group/AddMultipleMemberToGroup"
            //  var params: [String: String] = ["subGroupTitle": subGroupTitle,"memberProfileId": memberProfileId,"groupId": groupId,"memberMainId": memberMainId]
            
            var params: [String: String] = [:]
            
            
            
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        
                        
                        let grp: TBGetGroupModuleResult!
                        grp = TBGetGroupModuleResult.fromJSONData(jsonData) as! TBGetGroupModuleResult
                        self.window = nil
                        
                        
                        if(grp.status == "0"){
                            
                            self.delegates?.getContactPersonDetail!()
                        }
                        
                        
                        SVProgressHUD.dismiss()
                        
                        
                        
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            
            
            
            
            
            //            do {
            //                //  /Group/AddMultipleMemberToGroup
            //                //    let post:NSString = String(format: "subGroupTitle=%@&memberProfileId=%@&groupId=%@&memberMainId=%@",subGroupTitle,memberProfileId,groupId,memberMainId)
            //                NSLog("membersArr: %@",membersArr);
            //                let post:NSString = ""
            //
            //                NSLog("PostData: %@",post);
            //
            //                let url:URL = URL(string:String(format: baseUrl+"Group/AddMultipleMemberToGroup"))!
            //
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //
            //                let postLength:NSString = String( postData.count ) as NSString
            //
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //                do {
            //                    //  urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //                        //
            //                        let data = string!.data(using: String.Encoding.utf8,allowLossyConversion: false)
            //                        let grp: TBGetGroupModuleResult!
            //                        grp = TBGetGroupModuleResult.fromJSONData(data) as! TBGetGroupModuleResult
            //                        self.window = nil
            //                        //self.Loadingview.removeFromSuperview()
            //                        //NSLog("login data %@", grp.status)
            //                        if(grp.status == "0"){
            //                            //  self.delegates?.modulesListDelegateFunction!(grp)
            //                            self.delegates?.getContactPersonDetail!()
            //                        }
            //                    } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //
            //            }
        }
    }
    
    
    func getAlbumList(_ memberId:NSString,grpID:NSString,updatedOn:NSString)
    {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            //loaderViewMethod()
            SVProgressHUD.show()
            
            
            
            /*-------------------------------------------------------------*/
            let url = URL(string: baseUrl+"Gallery/GetAlbumsList")!
            var params: [String: String] = ["profileId": memberId as String,"groupId": grpID as String,"updatedOn": updatedOn as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let grp:TBAlbumsListResult!
                        grp = TBAlbumsListResult.fromJSONData(jsonData) as! TBAlbumsListResult
                        NSLog("login data %@", grp.status)
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        if(grp.status == "0"){
                            self.delegates?.getAlbumListOfUsers!(grp)
                        }
                        
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
        }
    }
    
    func GetAllGroupListSync(_ masterUID: NSString,imeiNo:NSString,updatedOn:NSString) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            //loaderViewMethod()
            
            SVProgressHUD.show()
            
            /*-------------------------------------------------------------*/
            let url = URL(string: baseUrl+"Group/GetAllGroupListSync")!
            var params: [String: String] = ["masterUID": masterUID as String,"imeiNo": imeiNo as String,"updatedOn": updatedOn as String]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print(jsonString)
                        let grp:TBGetGroupModuleResult!
                        grp = TBGetGroupModuleResult.fromJSONData(jsonData) as! TBGetGroupModuleResult
                        
                        NSLog(" grp %@", grp)
                        NSLog("GetAllGroupListSync data %@", grp.status)
                        self.window = nil
                        //self.Loadingview.removeFromSuperview()
                        if(grp.status == "0"){
                            self.delegates?.getallgrouplistsync!(grp)
                        }
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(_): break
                self.window = nil
                }
                self.window = nil
            }
            
            /*-------------------------------------------------------------*/
            
        }
    }
    
}



