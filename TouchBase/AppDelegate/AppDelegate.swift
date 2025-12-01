// 05.07.2019 10.20 AM code transfered by Harshada to Rajendra---- VERSIO0N 13.5

import SVProgressHUD
import Firebase
import UIKit
import CoreData
import EventKit
import UserNotifications
var appToken:String!=""
var myTempDictForScreenShotDataHolding:NSDictionary=NSDictionary()
import IQKeyboardManagerSwift
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder,UIApplicationDelegate,XMLParserDelegate,UIAlertViewDelegate,UNUserNotificationCenterDelegate, MessagingDelegate  {
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    var description11 = NSMutableString()
    var newsUpdateDict:NSMutableDictionary = NSMutableDictionary()
    var varLink = NSMutableString()
    var varWhichRssFeedRun:String! = ""
    var arrDeleteGroupList :NSArray!
    var arrarrNewGroupList :NSArray!
    var mudict:NSMutableDictionary=NSMutableDictionary()
    var appDelegate : AppDelegate!
    var window: UIWindow?
    var filteredArray = [String]()
    var eventStore: EKEventStore?
    var isReachable:Bool!
    var interNetStatus:Reachability!
    let bounds = UIScreen.main.bounds
    var imageView : UIImageView!
    var isAppInBackground : Bool!
    var rootViewNav =  UINavigationController()
    var databasePath = String()
    var list = NSMutableArray()
    var notifyDict:NSDictionary!
    let userDefault=UserDefaults.standard
    var headerImg = ""
    var headTitle = ""
    func getDataFromUrl(_ url:URL, completion: @escaping ((_ data: Data?, _ response: URLResponse?, _ error: NSError? ) -> Void)) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            completion(data, response, error as! NSError)
        }) .resume()
    }
    
    /*-------------------------------------------FIREBASE START---------------------------------------------------------------------------------------*/
    /*this is firebase by Rajendra Jat on 17 Dec 2018 start*/
    
    //func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("User info of notification \(userInfo)")
        let content = UNMutableNotificationContent()

//        if let aps = userInfo["aps"] as? NSDictionary
//        {
//            if let alert = aps.object(forKey: "alert") as? NSDictionary
//            {
//                if let titles = alert.object(forKey: "title") as? String
//                {
//                    if titles.contains("\n")
//                    {
//                        let aTitle = titles.split(separator: "\n")
//                        content.body=String(aTitle[0])
//                    }
//                }
//            }
//        }
        if let msgsss = userInfo["Message"] as? String {
            content.body = msgsss
            print("\(content.body)")
        }
        
        if let titlesss = userInfo["Message"] as? String {
            if titlesss.contains("\n")
               {
                   let aTitle = titlesss.split(separator: "\n")
                   content.body=String(aTitle[0])
                }
        }
        
        content.sound = UNNotificationSound(named: UNNotificationSoundName("water.wav"))
        registerPushNotifications()
        //      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let requestIdentifier = UUID().uuidString
              let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: nil)
              UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                  print("Error adding notification: \(error)")
                } else {
                  print("Notification scheduled")
                  // Remove the notification after it appears (for example, 2 seconds later)
//                  DispatchQueue.main.asyncAfter(deadline: .now() + 15) { // 7 seconds total: 5 to show, 2 to stay
//                    UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["fred"])
//                    print("Notification removed")
//                  }
                }
              }
        
        var notifyDictMain:NSDictionary=NSDictionary()
        notifyDictMain=userInfo as NSDictionary
        let aps = userInfo["aps"] as? NSDictionary
        notifyDict = notifyDictMain
        /*//MARK:- Uncomment this
        //MARK:- Save data in notification table here
        let nModel:NotificaioModel=NotificaioModel()
        nModel.saveNotificationDetails(nsData: notifyDictMain)*/
//        dbManger.saveEventNotificationLocal(dict: dict)
        
        let nModel:NotificaioModel=NotificaioModel()
        nModel.saveNotificationDetails(nsData: notifyDict)
        if(isAppInBackground != nil)
        {
    //MARK:- Uncomment this
           NotificationCenter.default.post(name: Notification.Name("NotifyDashboard"), object: nil)
           NotificationCenter.default.post(name: Notification.Name("NotifyList"), object: nil)
           
           if let BAType=userInfo["BAType"] as? String
            {
//                let varGetTypeTitle:String!=(aps?.value(forKey: "alert")as! AnyObject).value(forKey: "title")as! String
               let varGetTypeTitle:String! = userInfo["Message"] as? String
               let msg:String = ""
                let alertView:UIAlertView = UIAlertView()
                alertView.title = varGetTypeTitle //+"Alert 2222222"
                alertView.message = msg
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
            }
            else
            {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = self.headTitle
            var varGetType:String!=notifyDictMain.value(forKey: "type")as? String
            var varGetTypeBody:String=""
            if let cgtype = (aps?.value(forKey: "alert")as! AnyObject).value(forKey: "body")as? String
                {
                    varGetTypeBody=cgtype
                }
                
                if varGetTypeBody.elementsEqual(self.headTitle)
                {
                    varGetTypeBody = ""
                }
                else
                {
                    varGetTypeBody=varGetTypeBody+" \n"
                }
                
//            var varGetTypeTitle:String!=(aps?.value(forKey: "alert")as! AnyObject).value(forKey: "title")as! String
            var varGetTypeTitle:String!=(userInfo["Message"] as? String)
            
            alertView.message = varGetTypeBody+"Title : "+varGetTypeTitle
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            }
        }
        else
        {
            /* MARK:- Coded only for showing detail page when app is in background.
             
            if notifyDictMain != nil{
            if let msgID = notifyDictMain.object(forKey: "gcm.message_id") as? String
            {
                 nModel.changeReadStatus(ofMsgID: msgID)
            }
            }
           

            var varGetType:String!=notifyDictMain.value(forKey: "type")as? String
            if(varGetType == "Event"){
                
                var tyID:String!=notifyDictMain.value(forKey: "tyID")as? String
                var grpID:String!=notifyDictMain.value(forKey: "grpID")as? String
                var memID:String!=notifyDictMain.value(forKey: "memID")as? String
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "EventDetailNotiViewController") as! EventDetailNotiViewController
                let profID = memID

                dashBoardController.eventDate = notifyDict["eventDate"]  as! String
                dashBoardController.eventDesc = notifyDict["eventDesc"] as! String
                
                dashBoardController.eventImg = notifyDict["eventImg"] as! String
                dashBoardController.eventTitle = notifyDict["eventTitle"] as! String
                dashBoardController.goingCount = notifyDict["goingCount"] as! String
                
                dashBoardController.grpID = notifyDict["grpID"] as! String
                dashBoardController.maybeCount = notifyDict["maybeCount"] as! String
                dashBoardController.memID = notifyDict["memID"] as! String
                
                dashBoardController.notgoingCount = notifyDict["notgoingCount"] as! String
                dashBoardController.reglink = notifyDict["reglink"] as! String
                dashBoardController.rsvpEnable = notifyDict["rsvpEnable"] as! String
                
                dashBoardController.tyID = notifyDict["tyID"] as! String
                dashBoardController.type = notifyDict["type"] as! String
                dashBoardController.venue = notifyDict["venue"] as! String
                dashBoardController.questionID = notifyDict["questionID"] as! String
                dashBoardController.questionText = notifyDict["questionText"] as! String
                dashBoardController.questionType = notifyDict["questionType"] as! String
                dashBoardController.myResponse = notifyDict["myResponse"] as! String
                dashBoardController.totalCountServerResponse = notifyDict["totalCount"] as! String
                dashBoardController.isQuesEnable = notifyDict["isQuesEnable"] as! String
                dashBoardController.option1 = notifyDict["option1"] as! String
                dashBoardController.option2 = notifyDict["option2"] as! String
                
                if let body=((notifyDict["aps"] as! NSDictionary).value(forKey: "alert") as AnyObject).value(forKey: "body") as? String
                {
                    dashBoardController.grpName = body
                }
                else
                {
                  dashBoardController.grpName = ""
                }
                
                if  let category:String=notifyDict["group_category"] as? String
                {
                    dashBoardController.isCategory=category
                }
                else
                {
                    dashBoardController.isCategory="1"
                }
                let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                }
            }
            if(varGetType == "Calender"){
                UserDefaults.standard.setValue(notifyDict["memID"] as? NSString, forKey: "user_auth_token_profileId")
                UserDefaults.standard.setValue(notifyDict["grpID"] as? NSString, forKey: "user_auth_token_groupId")
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let objCelebrationViewController = mainStoryboard.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
                objCelebrationViewController.stringProfileId = notifyDict["memID"]  as! String
                objCelebrationViewController.stringGroupID = notifyDict["grpID"] as! String
                objCelebrationViewController.isCategory=notifyDict["GroupType"] as! String
                let varType:String!=notifyDict["CelebrationType"] as? String
                if(varType=="A")
                {
                    objCelebrationViewController.varType="A"
                    objCelebrationViewController.isBirthdayorAnniv="anniv"
                }
                else  if(varType=="B")
                {
                    objCelebrationViewController.varType="B"
                    objCelebrationViewController.isBirthdayorAnniv="birthday"
                }
                else  if(varType=="E")
                {
                    objCelebrationViewController.varType="E"
                    objCelebrationViewController.isBirthdayorAnniv=""
                }
                objCelebrationViewController.moduleName="Calendar"
                
                let navigationController: UINavigationController = UINavigationController(rootViewController: objCelebrationViewController)
                
                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                }
            }
            
            if(varGetType == "ann"){
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "AnnouncementDetailNotiViewController") as! AnnouncementDetailNotiViewController
                dashBoardController.ann_img =  notifyDict["ann_img"] as! String
                dashBoardController.ann_title =  notifyDict["ann_title"] as! String
                dashBoardController.Ann_date =  notifyDict["Ann_date"] as! String
                dashBoardController.ann_lnk =  notifyDict["ann_lnk"] as! String
                dashBoardController.ann_desc =  notifyDict["ann_desc"] as! String
                if let body=((notifyDict["aps"] as! NSDictionary).value(forKey: "alert") as AnyObject).value(forKey: "body") as? String
                {
                    dashBoardController.grpName = body
                }
                else
                {
                  dashBoardController.grpName = ""
                }
                
                if  let category:String=notifyDict["group_category"] as? String
                {
                    dashBoardController.isCategory=category
                }
                else
                {
                    dashBoardController.isCategory="1"
                }
                let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                }
                
                
                
                
            }
            if(varGetType == "Ebulle"){
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "ebdetail") as! EbulletinDetailViewController
                let tyID:String!=notifyDictMain.value(forKey: "tyID")as! String
                let grpID:String!=notifyDictMain.value(forKey: "grpID")as! String
                let memID:String!=notifyDictMain.value(forKey: "memID")as! String
                dashBoardController.urlLink = notifyDictMain.value(forKey: "link")as! String
                dashBoardController.isCalled = "notify"
                dashBoardController.profileID = memID as! NSString
                dashBoardController.bulletinID = tyID as! NSString
                let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                }
        }
            if(varGetType == "Doc"){

                let tyID:String!=notifyDictMain.value(forKey: "tyID")as? String
                let grpID:String!=notifyDictMain.value(forKey: "grpID")as? String
                let memID:String!=notifyDictMain.value(forKey: "memID")as? String

                if grpID == "-1"
                {
                    //Call RI Document here
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let secondViewController = mainStoryboard.instantiateViewController(withIdentifier: "RIDocumentListVC") as! RIDocumentListVC
                    
                    let navigationController: UINavigationController = UINavigationController(rootViewController: secondViewController)
                    if let window = self.window, let rootViewController = window.rootViewController
                    {
                        var currentController = rootViewController
                        while let presentedController = currentController.presentedViewController
                        {
                            currentController = presentedController
                        }
                        currentController.present(navigationController, animated: true, completion: nil)
                     }

                }
                else
                {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "docmVC") as! DocumentListViewControlller
                dashBoardController.moduleName="Documents"
                dashBoardController.groupIDX = (grpID as! NSString) as String
                dashBoardController.grpPRofileID = memID as! NSString
                dashBoardController.isCalled = "notify"
                let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                 }
              }
            }
            if(varGetType == "RemoveMember"){
                
            }
            if(varGetType == "AddMember")
            {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
                
                var tyID:String!=notifyDictMain.value(forKey: "tyID")as! String
                var grpID:String!=notifyDictMain.value(forKey: "grpID")as! String
                var memID:String!=notifyDictMain.value(forKey: "memID")as! String
                UserDefaults.standard.set("no", forKey: "picadded")
                dashBoardController.userGroupID =  grpID as! NSString
                dashBoardController.userProfileID =  tyID as! NSString //mobileTitles[indexPath.row]
                dashBoardController.isAdmin = "No"
                dashBoardController.mainUSerPRofileID = memID as! NSString
                dashBoardController.isCalled = "notify"
                //code comment by Rajendra jat on 2.28pm 26dec
                // UserDefaults.standard.set("No", forKey: "isAdmin")
                let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                //self.rootViewNav.presentViewController(navController, animated: true, completion: nil) //DPK
                // self.rootViewNav.pushViewController(dashBoardController, animated: true)
                
                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                }
            }
            if(varGetType == "EditGroup")
            {
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "profNewInfo_view") as! ProfileInfoController
                
                
                var tyID:String!=notifyDictMain.value(forKey: "tyID")as! String
                var grpID:String!=notifyDictMain.value(forKey: "grpID")as! String
                var memID:String!=notifyDictMain.value(forKey: "memID")as! String
                
                dashBoardController.userGroupID =  grpID as! NSString
                dashBoardController.userProfileID =  memID as! NSString //mobileTitles[indexPath.row]
                dashBoardController.isCalled = "notify"
                //                dashBoardController.isGrpAdmin = "No"
                
                
                //let profVC = self.storyboard!.instantiateViewControllerWithIdentifier("profNewInfo_view") as! ProfileInfoController
                dashBoardController.groupIDX =  (grpID as! NSString) as String
                //code comment by Rajendra jat on 2.28pm 26dec
                //  UserDefaults.standard.set("No", forKey: "isAdmin")
                let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                // self.rootViewNav.presentViewController(navController, animated: true, completion: nil) //DPK
                // self.rootViewNav.pushViewController(dashBoardController, animated: true)
                
                
                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                }
            }
            if(varGetType == "club")  // 11-09-2017
            {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "ClubEventDetailsShowViewController") as! ClubEventDetailsShowViewController

                var tyID:String!=notifyDictMain.value(forKey: "tyID")as! String
                var grpID:String!=notifyDictMain.value(forKey: "grpID")as! String
                var memID:String!=notifyDictMain.value(forKey: "memID")as! String
                
                dashBoardController.grpId = grpID as! String
                dashBoardController.profileId = memID as! String
                dashBoardController.isCalled = "notify"
                //code comment by Rajendra jat on 2.28pm 26dec
                // UserDefaults.standard.set("No", forKey: "isAdmin")
                let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                // self.rootViewNav.pushViewController(dashBoardController, animated: true)
                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                }
            }
            else
            {
                if   let BAType=userInfo["BAType"] as? String
                {
                    let varGetTypeTitle:String!=(aps?.value(forKey: "alert")as! AnyObject).value(forKey: "title")as! String
                    let msg:String=(userInfo["msg"] as? String)!
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = varGetTypeTitle //+"Alert 3333333"
                    alertView.message = msg
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                }
            }
            */
        }
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    private func registerPushNotifications() {
        if #available(iOS 10.0, *) {
            print("Registered of UN User notification")
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { granted, error in
                
                if granted {
                    DispatchQueue.main.async{
                    UIApplication.shared.registerForRemoteNotifications()
                    }
                } else
                    {
                            UNUserNotificationCenter.current().getNotificationSettings { settings in
                                switch settings.authorizationStatus {
                                case .authorized:
                                  DispatchQueue.main.async {
                                    UIApplication.shared.registerForRemoteNotifications()
                                  }
                                case .denied:
                                  print("Notifications are denied.")
                                  UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                                      DispatchQueue.main.async {
                                        UIApplication.shared.registerForRemoteNotifications()
                                      }
                                  }
                                case .notDetermined:
                                  // Request authorization
                                  UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                                    if granted {
                                      DispatchQueue.main.async {
                                        UIApplication.shared.registerForRemoteNotifications()
                                      }
                                    } else {
                                      print("User denied notification permission.")
                                    }
                                  }
                                default:
                                  break
                                }
                              }
                }
            })
        } else {
            print("Registered for normal remote notification")
            let userNotificationTypes: UIUserNotificationType = [.alert, .badge, .sound]
            let settings = UIUserNotificationSettings(types: userNotificationTypes, categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(self.tokenRefreshNotification),
//                                               name: .firInstanceIDTokenRefresh,
//                                               object: nil)
        print("Store notificationTable Notification \(notificationTable)")
    }

    internal func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
//        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
//        print(token)
//
//
//
//        // Pass device token to auth
////          Auth.auth().setAPNSToken(deviceToken, type: .prod)
//
////           Further handling of the device token if needed by the app
//          // ...
//        print("DidRegister for Device Token below")
//        print(FIRInstanceID.instanceID().token())
//        if var refreshedToken = FIRInstanceID.instanceID().token()
//        {
//            //  sleep(10)
//            refreshedToken = FIRInstanceID.instanceID().token()!
//            print("InstanceID token by rajendra: \(refreshedToken)")
//            print("Firebase registration token: \(refreshedToken)")
//            appToken=refreshedToken
//            let dataDict:[String: String] = ["token": refreshedToken]
//            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//
//        }
        print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        if let tempFCMToken = fcmToken {
            print("Firebase registration token: \(String(describing: tempFCMToken))")
            appToken = (String(describing: tempFCMToken))
            print("deviceTokennnnn: \(appToken)")
//            getdeviceToken()
            let dataDict:[String: String] = ["token": tempFCMToken ]
            NotificationCenter.default.post(name: Notification.Name("deviceToken"), object: nil, userInfo: dataDict)
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(fcmToken, forKey: "deviceToken")
            
            // TODO: If necessary send token to application server.
            // Note: This callback is fired at each app startup and whenever a new token is generated.
        }
    }
    
    func gotoFirstPage()
    {
        let getValuesForRoot=UserDefaults.standard.string(forKey: "isRootVisitedFirst")
        if(getValuesForRoot==nil)
        {
            let defaults = UserDefaults.standard
            if let str = defaults.value(forKey: "splashOver") as! String?
            {
                self.window = UIWindow(frame: UIScreen.main.bounds)
                
                let mobileLoginController =  UINavigationController()
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "mobile_login") as! MobileLoginController
                
                let rootViewController =  UINavigationController()
                self.rootViewNav = UINavigationController(rootViewController: dashBoardController)
                self.window!.rootViewController = self.rootViewNav
                self.window!.backgroundColor = UIColor.clear
                self.window!.makeKeyAndVisible() //contact_list
            }
        }
        else
        {
            let defaults = UserDefaults.standard
            if let str = defaults.value(forKey: "completeReg") as! String?
            {
                self.window = UIWindow(frame: UIScreen.main.bounds)
                
                let rootViewController =  UINavigationController()
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "rootDashss") as! RootDashNewViewController
                //rootViewController.pushViewController(dashBoardController, animated: true)
                self.rootViewNav = UINavigationController(rootViewController: dashBoardController)
                self.window!.rootViewController = self.rootViewNav
                self.window!.backgroundColor = UIColor.clear
                self.window!.makeKeyAndVisible()
            }
            else
            {
                if let str = defaults.value(forKey: "splashOver") as! String?
                {
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    let mobileLoginController =  UINavigationController()
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "mobile_login") as! MobileLoginController
                    let rootViewController =  UINavigationController()
                    self.rootViewNav = UINavigationController(rootViewController: dashBoardController)
                    self.window!.rootViewController = self.rootViewNav
                    self.window!.backgroundColor = UIColor.clear
                    self.window!.makeKeyAndVisible() //contact_list
                }
            }
        }
    }
    
    
    @objc func tokenRefreshNotification() {
//        guard let contents = FIRInstanceID.instanceID().token()
//            else {
//                return
//        }
//        print("InstanceID token jat: \(contents)")
//        appToken=contents
//        connectToFcm(completion: {
//            result in
//            print(result)
//            print("Saved device token is \(appToken)")
//        })
        
        //5jully
        
        InstanceID.instanceID().instanceID { result, error in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }
    }
    
   
    
    
    func connectToFcm(completion: @escaping(Bool)->()) {
        // Won't connect since there is no token
//        guard FIRInstanceID.instanceID().token() != nil else {
//            print("**** return")
//            return
//        }
//
//        // Disconnect previous FCM connection if it exists.
//        FIRMessaging.messaging().disconnect()
//
//        FIRMessaging.messaging().connect { (error) in
//            if error != nil {
//                print("Unable to connect with FCM. \(error?.localizedDescription ?? "")")
//                completion(false)
//            } else {
//                print("Connected to FCM.")
//                completion(true)
//            }
//        }
        //5jully
        InstanceID.instanceID().instanceID { result, error in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            let navBarAppearance = UINavigationBarAppearance()
                       navBarAppearance.configureWithOpaqueBackground()
                       navBarAppearance.backgroundColor = UIColor.white
           
                       UINavigationBar.appearance().standardAppearance = navBarAppearance
        }
        let date2 = Date()
        let calendar2 = Calendar.current
        let day2 = calendar2.component(.day, from: date2)
        let month2 = calendar2.component(.month, from: date2)
        let year2 = calendar2.component(.year, from: date2)
        var todayDate:String!=String(day2)+String(month2)+String(year2)
        var getDifferenceofDate=UserDefaults.standard.value(forKey: "session_DateDifference")as? String
        if(todayDate==getDifferenceofDate)
        {
            
        }
        else
        {
            //---delete old value from server in case of Birthday Anniversary Event start
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
                let insertSQL = "DELETE FROM Dashboard_BirthAnniEvent_table_New"
                let result = contactDB?.executeStatements(insertSQL)
            }
        }
        UserDefaults.standard.setValue("nothing", forKey: "session_LinkValueAnnouncement")
        UserDefaults.standard.setValue("nothing", forKey: "session_LinkValue")
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        registerPushNotifications()
        if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? NSDictionary {
            // ...do stuff...app
            CallNoti(userInfo)
        }

        UserDefaults.standard.removeObject(forKey: "session_GetModuleId")
        UserDefaults.standard.set("no", forKey: "thisiscomingfromdetaileventdelete")
        UserDefaults.standard.setValue("no", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
//        UserDefaults.standard.setValue("0", forKey: "Session_SelectedIndexValue")
        UserDefaults.standard.setValue("no", forKey: "session_IsComingFromDownloadedvieworUploadDocumnetScreen")
        UserDefaults.standard.setValue("", forKey: "session_IsComingFromPop")


        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.setForegroundColor(UIColor.black)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.checkInternetStatus(_:)), name: NSNotification.Name.reachabilityChanged, object: nil)
        IQKeyboardManager.shared.enable = true
        interNetStatus=Reachability.forInternetConnection()
        interNetStatus.startNotifier()
        isReachable=isReachableNet()
        
        ceateDatabase()
        let date = Foundation.Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        let year:String! =  String(describing: components.year)
        let month:String! = String(describing: components.month)
        let day:String! = String(describing: components.day)
        var varAddDayMonthYear:String! = ""
        varAddDayMonthYear=day+month+year
        var varGetRSSFEEDValueDay=UserDefaults.standard.value(forKey: "session_GetFeedValue")
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            if(varGetRSSFEEDValueDay == nil)
            {
                functionForTruncateXMLData()
                UserDefaults.standard.setValue(varAddDayMonthYear, forKey: "session_GetFeedValue")
                beginParsingBlog()
            }
            else if(varAddDayMonthYear == (varGetRSSFEEDValueDay)as! String)
            {
                functionForTruncateXMLData()
                UserDefaults.standard.setValue(nil, forKey: "session_GetFeedValue")
                beginParsingBlog()
                //NSUserDefaults.standardUserDefaults().setValue(varAddDayMonthYear, forKey: "session_GetFeedValue")
            }
            else
            {
                functionForTruncateXMLData()
                UserDefaults.standard.setValue(varAddDayMonthYear, forKey: "session_GetFeedValue")
                beginParsingBlog()
            }
        }
        else
        {
            UserDefaults.standard.setValue(nil, forKey: "session_GetFeedValue")
        }
        
        let varGetValue = UserDefaults.standard.string(forKey: "session_MaintainNewAddingModuleWhenFirstTimeAppInstalled")
        if(varGetValue == nil )
        {
            UserDefaults.standard.setValue("Yes", forKey: "session_MaintainNewAddingModuleWhenFirstTimeAppInstalled")
        }
        else
        {
            UserDefaults.standard.setValue("no", forKey: "session_MaintainNewAddingModuleWhenFirstTimeAppInstalled")
        }
        
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pageControl = UIPageControl.appearance()
        pageControl.backgroundColor = UIColor.clear
        notifyDict=NSDictionary()
        gotoFirstPage()
        let mainQueue = OperationQueue.main
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification,
                                               object: nil,
                                               queue: mainQueue) { notification in
                                                // executes after screenshot
        }
        
        
        GetReplicaInfo()
        rotaryIndiaRewampRIZoneAPI()
        Thread.sleep(forTimeInterval: 3.0)   
        return true
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
                                 
                                 self.headerImg = decodedData.registrationResult.result.table[0].headerlogo
                                 self.headTitle = decodedData.registrationResult.result.table[0].applicationNameText
                                 print("^^^^^^^^^^^^^^API CALLED^^^^^^^^^^^^^^^^^^")
                                 UserDefaults.standard.set(decodedData.registrationResult.result.table[0].supportMailID, forKey: "myKey")
                                 NotificationCenter.default.post(name: Notification.Name("DataSaved"), object: nil)
                                 
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

    
    
    func showAlsertViewTest(strinf:String){
        let alertView:UIAlertView = UIAlertView()
        alertView.title = self.headTitle
        alertView.message = strinf
        alertView.delegate = nil
        alertView.addButton(withTitle: "OK")
        alertView.show()
    }
    
    func showAlsertView(){
        let alertView:UIAlertView = UIAlertView()
        alertView.title = self.headTitle
        alertView.message = "This feature is coming soon!"
        alertView.delegate = nil
        alertView.addButton(withTitle: "OK")
        alertView.show()
    }
    
    func showAlsertViewWhenSessionTimeOut(_ stringMessage:String){
        let alertView:UIAlertView = UIAlertView()
        alertView.title = self.headTitle
        alertView.message = stringMessage
        alertView.delegate = nil
        alertView.addButton(withTitle: "OK")
        alertView.show()
    }
   
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if (DBChooser.default().handleOpen(url)) {
            return true
        }
        return false
    }
    
    
   
    
    func setMobileViewAsRoot() {
        
        let nModel:NotificaioModel=NotificaioModel()
        nModel.deleteNotification(byMsgID: "", state: .All)

        let defaults1 = UserDefaults.standard
        defaults1.removeObject(forKey: "splashOver")
        
        UserDefaults.standard.removeObject(forKey: "isRootVisitedFirst")
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mobileLoginController =  UINavigationController()
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "splash_screens") as! SplashScreenController
        let rootViewController =  UINavigationController()
        self.rootViewNav = UINavigationController(rootViewController: dashBoardController)
        self.window!.rootViewController = self.rootViewNav
        self.window!.backgroundColor = UIColor.clear
        self.window!.makeKeyAndVisible()
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Error to registered remote notifcation...")
        print(error)
    }
    
    
    @objc func checkInternetStatus(_ notice:Notification){
        let s:NSString = "www.apple.com"
        let r:Reachability!
        r = Reachability(hostName: s as String)
        var internetStatus:NetworkStatus!
        internetStatus=r.currentReachabilityStatus()
        if(internetStatus != 0){
            print("Internet connection OK")
            // imageView.removeFromSuperview()
            isReachable=true
        } else {
            print("Oops! Something went wrong. Please check your Internet Connection and try again.")
            isReachable=false
            SVProgressHUD.dismiss()
            let alert = UIAlertView(title: "No Internet Connection", message: "Oops! Something went wrong. Please check your Internet Connection and try again.", delegate: nil, cancelButtonTitle: "OK")
            
            alert.show()
        }
    }
    func isReachableNet()->Bool{
        let s : NSString = "www.apple.com"
        let r:Reachability!
        r = Reachability(hostName: s as String)
        var internetStatus:NetworkStatus!
        internetStatus=r.currentReachabilityStatus()
        let status = Reach().connectionStatus()
        print("internet status \(status)")
        switch status {
        case .unknown, .offline:
            print("Not connected")
            
            return false;
            
        case .online(.wwan):
            print("Connected via WWAN")
            return true;
            
            
        case .online(.wiFi):
            print("Connected via WiFi")
            return true;
        }
    }
    
    func CallNoti(_ userInfo:NSDictionary){
        let aps = userInfo["aps"] as? NSDictionary
        notifyDict = aps!.mutableCopy() as! NSDictionary
        
        if   let BAType=userInfo["BAType"] as? String
        {
            let varGetTypeTitle:String!=(userInfo["Message"] as? String)
            
            let msg:String=(userInfo["msg"] as? String ?? "")
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = varGetTypeTitle //+"Alert 1111111"
            alertView.message = msg
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
        }
        else
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = self.headTitle
            
            var varGetTypeBody:String=""
            if let cgtype = (userInfo["Message"] as? String)
            {
                varGetTypeBody=cgtype
            }
            
            if varGetTypeBody.elementsEqual(self.headTitle)
            {
                varGetTypeBody = ""
            }
            else
            {
                varGetTypeBody=varGetTypeBody+" \n"
            }
            
            let varGetTypeTitle:String!=(userInfo["Message"] as? String)
            alertView.message = varGetTypeBody+"Title : "+varGetTypeTitle
            alertView.delegate = self
            alertView.tag = 12
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
    }
    
   
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
         //MARK:- Uncomment this
        if notifyDict != nil{
        if let msgID = notifyDict.object(forKey: "gcm.message_id") as? String
        {
         let nModel:NotificaioModel=NotificaioModel()
             nModel.changeReadStatus(ofMsgID: msgID, completion: {result in
                print(result)
                NotificationCenter.default.post(name: Notification.Name("NotifyDashboard"), object: nil)
                NotificationCenter.default.post(name: Notification.Name("NotifyList"), object: nil)
            })
          }
        }
        
 

        if(alertView.tag == 12){
            if(buttonIndex == 0){
                if(notifyDict["type"] as? NSString == "Event"){
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "EventDetailNotiViewController") as! EventDetailNotiViewController
    let profID =  notifyDict["memID"] as? NSString
    
    dashBoardController.eventDate = notifyDict["eventDate"]  as! String
    dashBoardController.eventDesc = notifyDict["eventDesc"] as! String
    
    dashBoardController.eventImg = notifyDict["eventImg"] as! String
    dashBoardController.eventTitle = notifyDict["eventTitle"] as! String
    dashBoardController.goingCount = notifyDict["goingCount"] as! String
  
    dashBoardController.grpID = notifyDict["grpID"] as! String
    dashBoardController.maybeCount = notifyDict["maybeCount"] as! String
    dashBoardController.memID = notifyDict["memID"] as! String
                    
    dashBoardController.notgoingCount = notifyDict["notgoingCount"] as! String
    dashBoardController.reglink = notifyDict["reglink"] as! String
    dashBoardController.rsvpEnable = notifyDict["rsvpEnable"] as! String
  
    dashBoardController.tyID = notifyDict["typeID"] as! String
    dashBoardController.type = notifyDict["type"] as! String
    dashBoardController.venue = notifyDict["venue"] as! String
                    
                    
    dashBoardController.questionID = notifyDict["questionID"] as! String
    dashBoardController.questionText = notifyDict["questionText"] as! String
    dashBoardController.questionType = notifyDict["questionType"] as! String
    
    
    dashBoardController.myResponse = notifyDict["myResponse"] as! String
    dashBoardController.totalCountServerResponse = notifyDict["totalCount"] as! String
                    
   dashBoardController.isQuesEnable = notifyDict["isQuesEnable"] as! String
   dashBoardController.option1 = notifyDict["option1"] as! String
   dashBoardController.option2 = notifyDict["option2"] as! String
   if let body=((notifyDict["aps"] as! NSDictionary).value(forKey: "alert") as AnyObject).value(forKey: "body") as? String
     {
         dashBoardController.grpName = body
     }
     else
     {
       dashBoardController.grpName = ""
     }
     
   if  let category:String=notifyDict["group_category"] as? String
   {
     dashBoardController.isCategory=category
    }
  else
   {
     dashBoardController.isCategory="1"
                  }

     //   /*dashBoardController.isCategory=notifyDict["group_category"] as! String */ dashBoardController.isCategory="1"

     let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
     //  self.rootViewNav.pushViewController(dashBoardController, animated: true)
     
     if let window = self.window, let rootViewController = window.rootViewController
                    {
           var currentController = rootViewController
           while let presentedController = currentController.presentedViewController
           {
               currentController = presentedController
           }
           currentController.present(navigationController, animated: true, completion: nil)
         }
        }
                if(notifyDict["type"] as? NSString == "Calender"){
                    UserDefaults.standard.setValue(notifyDict["memID"] as? NSString, forKey: "user_auth_token_profileId")
                    UserDefaults.standard.setValue(notifyDict["grpID"] as? NSString, forKey: "user_auth_token_groupId")
                    
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if #available(iOS 13.0, *) {
                        let objCelebrationViewController = mainStoryboard.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
                        objCelebrationViewController.stringProfileId = notifyDict["memID"]  as! String
                        objCelebrationViewController.stringGroupID = notifyDict["grpID"] as! String
                        objCelebrationViewController.isCategory=notifyDict["GroupType"] as! String
                        
                        
                        let varType:String!=notifyDict["CelebrationType"] as? String
                        if(varType=="A")
                        {
                            objCelebrationViewController.varType="A"
                            objCelebrationViewController.isBirthdayorAnniv="anniv"
                        }
                        else  if(varType=="B")
                        {
                            objCelebrationViewController.varType="B"
                            objCelebrationViewController.isBirthdayorAnniv="birthday"
                        }
                        else  if(varType=="E")
                        {
                            objCelebrationViewController.varType="E"
                            objCelebrationViewController.isBirthdayorAnniv=""
                        }
                        objCelebrationViewController.moduleName="Calendar"
                        
                        let navigationController: UINavigationController = UINavigationController(rootViewController: objCelebrationViewController)
                        
                        if let window = self.window, let rootViewController = window.rootViewController
                        {
                            var currentController = rootViewController
                            while let presentedController = currentController.presentedViewController
                            {
                                currentController = presentedController
                            }
                            currentController.present(navigationController, animated: true, completion: nil)
                        }
                    } else {
                        // Fallback on earlier versions
                    }

                 
                    // self.rootViewNav.pushViewController(objCelebrationViewController, animated: true)
                    
                    
                   
                    
                    
                }
                
                if(notifyDict["type"] as? NSString == "ann"){
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "AnnouncementDetailNotiViewController") as! AnnouncementDetailNotiViewController
                    
                    
                    dashBoardController.ann_img =  notifyDict["ann_img"] as! String 
                    dashBoardController.ann_title =  notifyDict["ann_title"] as! String
                    dashBoardController.Ann_date =  notifyDict["Ann_date"] as! String
                    dashBoardController.ann_lnk =  notifyDict["ann_lnk"] as! String
                    dashBoardController.ann_desc =  notifyDict["ann_desc"] as! String
                    if let body=((notifyDict["aps"] as! NSDictionary).value(forKey: "alert") as AnyObject).value(forKey: "body") as? String
                    {
                        dashBoardController.grpName = body
                    }
                    else
                    {
                      dashBoardController.grpName = ""
                    }
            
                    if  let category:String=notifyDict["group_category"] as? String
                {
                    dashBoardController.isCategory=category
                }
                else
                {
                    dashBoardController.isCategory="1"
                }
               //   /*dashBoardController.isCategory=notifyDict["group_category"] as! String */ dashBoardController.isCategory="1"

                    
                    // dashBoardController.annID =  notifyDict["tyID"] as? NSString
                    //  dashBoardController.grpID = notifyDict["grpID"] as? NSString
                    //  dashBoardController.profileId = notifyDict["memID"] as? NSString
                    //  dashBoardController.isCalled = "notify"
                    // dashBoardController.moduleName = "Announcements"
                    let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                    // self.rootViewNav.pushViewController(dashBoardController, animated: true)
                    
                    
                    if let window = self.window, let rootViewController = window.rootViewController
                    {
                        var currentController = rootViewController
                        while let presentedController = currentController.presentedViewController
                        {
                            currentController = presentedController
                        }
                        currentController.present(navigationController, animated: true, completion: nil)
                    }
                }
                if(notifyDict["type"] as? NSString == "Ebulletin"){
                    if let link = notifyDict["link"] as? String
                    {
                      if(link.contains(".pdf") || link.contains(".docx") || link.contains(".doc") || link.contains(".html") || link.contains(".gif") || link.contains(".jpg") || link.contains(".jpeg") || link.contains(".png"))
                      {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "ebdetail") as! EbulletinDetailViewController
                        dashBoardController.urlLink = notifyDict["link"] as! String
                        dashBoardController.isCalled = "notify"
                        dashBoardController.profileID = notifyDict["memID"] as! String as NSString//memID
                        dashBoardController.bulletinID = notifyDict["typeID"] as! String as NSString
                        let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                        
                        
                        if let window = self.window, let rootViewController = window.rootViewController
                        {
                            var currentController = rootViewController
                            while let presentedController = currentController.presentedViewController
                            {
                                currentController = presentedController
                            }
                            currentController.present(navigationController, animated: true, completion: nil)
                        }
                      }
                        else
                      {
                        if let urls = NSURL(string: link){
//                            UIApplication.shared.openURL(urls as URL)
                            
                            if UIApplication.shared.canOpenURL(urls as URL) {
                                UIApplication.shared.open(urls as URL, options: [:]) { success in
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
                if(notifyDict["type"] as? NSString == "Doc"){
                    if notifyDict["grpID"] as! String == "-1"
                    {
                        //Call RI Document here
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let secondViewController = mainStoryboard.instantiateViewController(withIdentifier: "RIDocumentListVC") as! RIDocumentListVC
                        
                        let navigationController: UINavigationController = UINavigationController(rootViewController: secondViewController)
                        if let window = self.window, let rootViewController = window.rootViewController
                        {
                            var currentController = rootViewController
                            while let presentedController = currentController.presentedViewController
                            {
                                currentController = presentedController
                            }
                            currentController.present(navigationController, animated: true, completion: nil)
                         }
                    }
                    else{
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "docmVC") as! DocumentListViewControlller
                    dashBoardController.groupIDX = notifyDict["grpID"] as! String
                    dashBoardController.grpPRofileID = notifyDict["memID"] as! String as NSString
                    dashBoardController.isCalled = "notify"
                    dashBoardController.moduleName="Documents"
                    
                    let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                    if let window = self.window, let rootViewController = window.rootViewController
                    {
                        var currentController = rootViewController
                        while let presentedController = currentController.presentedViewController
                        {
                            currentController = presentedController
                        }
                        currentController.present(navigationController, animated: true, completion: nil)
                    }
                 }
                }
                if(notifyDict["type"] as? NSString == "RemoveMember")
                {
                    
                    
                    
                }
                if(notifyDict["type"] as? NSString == "AddMember"){
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
                    UserDefaults.standard.set("no", forKey: "picadded")
                    dashBoardController.userGroupID =  notifyDict["grpID"] as! String as NSString
                    dashBoardController.userProfileID =  notifyDict["typeID"] as! String as NSString //mobileTitles[indexPath.row]
                    dashBoardController.isAdmin = "No"
                    dashBoardController.mainUSerPRofileID = notifyDict["memID"] as! String as NSString
                    dashBoardController.isCalled = "notify"
                    //code comment by Rajendra jat on 2.28pm 26dec
                    // UserDefaults.standard.set("No", forKey: "isAdmin")
                    let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                    // self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
                    //   self.rootViewNav.pushViewController(dashBoardController, animated: true)
                    
                    if let window = self.window, let rootViewController = window.rootViewController
                    {
                        var currentController = rootViewController
                        while let presentedController = currentController.presentedViewController
                        {
                            currentController = presentedController
                        }
                        currentController.present(navigationController, animated: true, completion: nil)
                    }
                    
                    
                    
                }
                if(notifyDict["type"] as? NSString == "EditGroup"){
                    
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "profNewInfo_view") as! ProfileInfoController
                    
                    //let profVC = self.storyboard!.instantiateViewControllerWithIdentifier("profNewInfo_view") as! ProfileInfoController
                    dashBoardController.groupIDX =  notifyDict["grpID"] as! String
                    //code comment by Rajendra jat on 2.28pm 26dec
                    // UserDefaults.standard.set("No", forKey: "isAdmin")
                    dashBoardController.userGroupID =  notifyDict["grpID"] as! String as NSString
                    dashBoardController.userProfileID =  notifyDict["memID"] as! String as NSString //mobileTitles[indexPath.row]
                    dashBoardController.isCalled = "notify"
                    let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                    //  self.rootViewNav.present(navController, animated: true, completion: nil)
                    
                    
                    if let window = self.window, let rootViewController = window.rootViewController
                    {
                        var currentController = rootViewController
                        while let presentedController = currentController.presentedViewController
                        {
                            currentController = presentedController
                        }
                        currentController.present(navigationController, animated: true, completion: nil)
                    }
                    
                }
                
                if(notifyDict["type"] as? NSString == "club")  // 11-09-2017
                {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "ClubEventDetailsShowViewController") as! ClubEventDetailsShowViewController
                    dashBoardController.grpId = notifyDict["grpID"] as? String
                    dashBoardController.profileId = notifyDict["memID"] as? String
                    dashBoardController.isCalled = "notify"
                    //code comment by Rajendra jat on 2.28pm 26dec
                    // UserDefaults.standard.set("No", forKey: "isAdmin")
                    let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                    // self.rootViewNav.pushViewController(dashBoardController, animated: true)
                    
                    
                    if let window = self.window, let rootViewController = window.rootViewController
                    {
                        var currentController = rootViewController
                        while let presentedController = currentController.presentedViewController
                        {
                            currentController = presentedController
                        }
                        currentController.present(navigationController, animated: true, completion: nil)
                    }
                    
                    
                }
                
                //------------------for on 26Dec 6.08 pm
                if(notifyDict["type"] as? NSString == "Activity")  // 11-09-2017
                {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let objShowCaseAlbumListViewController = mainStoryboard.instantiateViewController(withIdentifier: "NewShowCasePhotoDetailsVCGooglePushNotificaton") as! NewShowCasePhotoDetailsVCGooglePushNotificaton
                    objShowCaseAlbumListViewController.GetAlbumID = notifyDict["typeID"] as? String
                    objShowCaseAlbumListViewController.GetGroupID=notifyDict["grpID"] as? String
                    print("\(objShowCaseAlbumListViewController.GetAlbumID)")
                    let navigationController: UINavigationController = UINavigationController(rootViewController: objShowCaseAlbumListViewController)
                    //  self.rootViewNav.pushViewController(objShowCaseAlbumListViewController, animated: true)
                    
                    if let window = self.window, let rootViewController = window.rootViewController
                    {
                        var currentController = rootViewController
                        while let presentedController = currentController.presentedViewController
                        {
                            currentController = presentedController
                        }
                        currentController.present(navigationController, animated: true, completion: nil)
                    }
                }
                if(notifyDict["type"] as? NSString == "Gallery")  // 11-09-2017
                {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let objShowCaseAlbumListViewController = mainStoryboard.instantiateViewController(withIdentifier: "NewShowCasePhotoDetailsVCGooglePushNotificatonDistrict") as! NewShowCasePhotoDetailsVCGooglePushNotificatonDistrict
                    objShowCaseAlbumListViewController.GetAlbumID = notifyDict["typeID"] as? String
                    objShowCaseAlbumListViewController.GetGroupID=notifyDict["grpID"] as? String
                    let navigationController: UINavigationController = UINavigationController(rootViewController: objShowCaseAlbumListViewController)

                    if let window = self.window, let rootViewController = window.rootViewController
                    {
                        var currentController = rootViewController
                        while let presentedController = currentController.presentedViewController
                        {
                            currentController = presentedController
                        }
                        currentController.present(navigationController, animated: true, completion: nil)
                    }
                }
            }
        }
        else
        {
            if(notifyDict["type"] as? NSString == "Event"){
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                var dashBoardController = storyboard.instantiateViewController(withIdentifier: "EventDetailNotiViewController") as! EventDetailNotiViewController
                var navigationController = UINavigationController(rootViewController: dashBoardController)
//                let profID =  notifyDict["memID"] as? NSString
                dashBoardController.eventDate = notifyDict["eventDate"]  as! String
                dashBoardController.eventDesc = notifyDict["eventDesc"] as! String
                
                dashBoardController.eventImg = notifyDict["eventImg"] as! String
                dashBoardController.eventTitle = notifyDict["eventTitle"] as! String
                dashBoardController.goingCount = notifyDict["goingCount"] as! String
                
                dashBoardController.grpID = notifyDict["grpID"] as! String
                dashBoardController.maybeCount = notifyDict["maybeCount"] as! String
//                dashBoardController.memID = notifyDict["memID"] as! String
                
                dashBoardController.notgoingCount = notifyDict["notgoingCount"] as! String
                dashBoardController.reglink = notifyDict["reglink"] as! String
                dashBoardController.rsvpEnable = notifyDict["rsvpEnable"] as! String
                
                dashBoardController.tyID = notifyDict["typeID"] as! String
                dashBoardController.type = notifyDict["type"] as! String
                dashBoardController.venue = notifyDict["venue"] as! String
                
                dashBoardController.questionID = notifyDict["questionID"] as! String
                dashBoardController.questionText = notifyDict["questionText"] as! String
                dashBoardController.questionType = notifyDict["questionType"] as! String
                
                dashBoardController.myResponse = notifyDict["myResponse"] as! String
                dashBoardController.totalCountServerResponse = notifyDict["totalCount"] as! String
                
                dashBoardController.isQuesEnable = notifyDict["isQuesEnable"] as! String
                dashBoardController.option1 = notifyDict["option1"] as! String
                dashBoardController.option2 = notifyDict["option2"] as! String
                if let body=((notifyDict["aps"] as! NSDictionary).value(forKey: "alert") as AnyObject).value(forKey: "body") as? String
                {
                    dashBoardController.grpName = body
                }
                else
                {
                  dashBoardController.grpName = ""
                }
                
              if  let category:String=notifyDict["group_category"] as? String
                {
                    dashBoardController.isCategory=category
                }
                else
                {
                    dashBoardController.isCategory="1"
                }
              
                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                }
                
            }
            
            if(notifyDict["type"] as? NSString == "ann"){
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "AnnouncementDetailNotiViewController") as! AnnouncementDetailNotiViewController
                dashBoardController.ann_img =  notifyDict["ann_img"] as! String
                dashBoardController.ann_title =  notifyDict["ann_title"] as! String
                dashBoardController.Ann_date =  notifyDict["Ann_date"] as! String
                dashBoardController.ann_lnk =  notifyDict["ann_lnk"] as! String
                dashBoardController.ann_desc =  notifyDict["ann_desc"] as! String
                if let body=((notifyDict["aps"] as! NSDictionary).value(forKey: "alert") as AnyObject).value(forKey: "body") as? String
                {
                    dashBoardController.grpName = body
                }
                else
                {
                  dashBoardController.grpName = ""
                }
                
             if  let category:String=notifyDict["group_category"] as? String
                {
                    dashBoardController.isCategory=category
                }
                else
                {
                    dashBoardController.isCategory="1"
                }
              //   /*dashBoardController.isCategory=notifyDict["group_category"] as! String */ dashBoardController.isCategory="1"

                let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)

                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                }

            }
  if(notifyDict["type"] as? NSString == "Ebulletin"){
    if let link = notifyDict["link"] as? String
  {
      if(link.contains(".pdf") || link.contains(".docx") || link.contains(".doc") || link.contains(".html") || link.contains(".gif") || link.contains(".jpg") || link.contains(".jpeg") || link.contains(".png"))
      {
          let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "ebdetail") as! EbulletinDetailViewController
          dashBoardController.urlLink = notifyDict["link"] as! String
          dashBoardController.isCalled = "notify"
          dashBoardController.profileID = notifyDict["memID"] as! String as NSString//memID
          dashBoardController.bulletinID = notifyDict["typeID"] as! String as NSString
          let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
          if let window = self.window, let rootViewController = window.rootViewController
          {
              var currentController = rootViewController
              while let presentedController = currentController.presentedViewController
              {
                  currentController = presentedController
              }
              currentController.present(navigationController, animated: true, completion: nil)
           }
         }
        else
        {
          if let urls = NSURL(string: link) {
//                  UIApplication.shared.openURL(urls as URL)
              
              if UIApplication.shared.canOpenURL(urls as URL) {
                  UIApplication.shared.open(urls as URL, options: [:]) { success in
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
            if(notifyDict["type"] as? NSString == "Doc"){
                if notifyDict["grpID"] as! String == "-1"
                {
                    //Call RI Document here
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let secondViewController = mainStoryboard.instantiateViewController(withIdentifier: "RIDocumentListVC") as! RIDocumentListVC
                    
                    let navigationController: UINavigationController = UINavigationController(rootViewController: secondViewController)
                    if let window = self.window, let rootViewController = window.rootViewController
                    {
                        var currentController = rootViewController
                        while let presentedController = currentController.presentedViewController
                        {
                            currentController = presentedController
                        }
                        currentController.present(navigationController, animated: true, completion: nil)
                     }
                }
                else{
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "docmVC") as! DocumentListViewControlller
                dashBoardController.groupIDX = notifyDict["grpID"] as! String
                dashBoardController.grpPRofileID = notifyDict["memID"] as! String as NSString
                dashBoardController.isCalled = "notify"
                dashBoardController.moduleName="Documents"
                let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                }
              }
            }
            
            if(notifyDict["type"] as? NSString == "Calender"){
                UserDefaults.standard.setValue(notifyDict["memID"] as? NSString, forKey: "user_auth_token_profileId")
                UserDefaults.standard.setValue(notifyDict["grpID"] as? NSString, forKey: "user_auth_token_groupId")
                
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if #available(iOS 13.0, *) {
                    let objCelebrationViewController = mainStoryboard.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
                    objCelebrationViewController.stringProfileId = notifyDict["memID"] as? String
                    objCelebrationViewController.stringGroupID = notifyDict["grpID"] as? String
                    objCelebrationViewController.isCategory=notifyDict["GroupType"] as? String
                    objCelebrationViewController.iscalledFromNoti = "notify"
                   
                    let varType:String!=notifyDict["CelebrationType"] as? String
                    if(varType=="A")
                    {
                        objCelebrationViewController.varType="A"
                        objCelebrationViewController.isBirthdayorAnniv="anniv"
                    }
                    else  if(varType=="B")
                    {
                        objCelebrationViewController.varType="B"
                        objCelebrationViewController.isBirthdayorAnniv="birthday"
                    }
                    else  if(varType=="E")
                    {
                        objCelebrationViewController.varType="E"
                        objCelebrationViewController.isBirthdayorAnniv=""
                    }
                    objCelebrationViewController.moduleName="Calendar"
                    
                    let navigationController: UINavigationController = UINavigationController(rootViewController: objCelebrationViewController)
                    
                 } else {
                    // Fallback on earlier versions
                }
             
              
            }
            
            if(notifyDict["type"] as? NSString == "club")
            {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewController(withIdentifier: "ClubEventDetailsShowViewController") as! ClubEventDetailsShowViewController
                dashBoardController.grpId = notifyDict["grpID"] as? String
                dashBoardController.profileId = notifyDict["memID"] as? String
                dashBoardController.isCalled = "notify"
                
                //code comment by Rajendra jat on 2.28pm 26dec
                // UserDefaults.standard.set("No", forKey: "isAdmin")
                let navigationController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                //  self.rootViewNav.pushViewController(dashBoardController, animated: true)
                
                
                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                }
            }
            if(notifyDict["type"] as? NSString == "Activity")  // 11-09-2017
            {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let objShowCaseAlbumListViewController = mainStoryboard.instantiateViewController(withIdentifier: "NewShowCasePhotoDetailsVCGooglePushNotificaton") as! NewShowCasePhotoDetailsVCGooglePushNotificaton
                objShowCaseAlbumListViewController.GetAlbumID = notifyDict["typeID"] as? String
                objShowCaseAlbumListViewController.GetGroupID=notifyDict["grpID"] as? String
                objShowCaseAlbumListViewController.getFinanceYear = "2024-2025"
                objShowCaseAlbumListViewController.isCalled = "notify"
                let navigationController: UINavigationController = UINavigationController(rootViewController: objShowCaseAlbumListViewController)
                //  self.rootViewNav.pushViewController(objShowCaseAlbumListViewController, animated: true)
                
                
                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                }
            }
            if(notifyDict["type"] as? NSString == "Gallery")  // 11-09-2017
            {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let objShowCaseAlbumListViewController = mainStoryboard.instantiateViewController(withIdentifier: "NewShowCasePhotoDetailsVCGooglePushNotificatonDistrict") as! NewShowCasePhotoDetailsVCGooglePushNotificatonDistrict
                objShowCaseAlbumListViewController.GetAlbumID = notifyDict["typeID"] as? String
                objShowCaseAlbumListViewController.GetGroupID=notifyDict["grpID"] as? String
                objShowCaseAlbumListViewController.getFinanceYear = "2024-2025"
                objShowCaseAlbumListViewController.isCalled = "notify"
                
                
                let navigationController: UINavigationController = UINavigationController(rootViewController: objShowCaseAlbumListViewController)
                //  self.rootViewNav.pushViewController(objShowCaseAlbumListViewController, animated: true)
                
                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                }
            }
        }
    }
    
    //Not in use
    func gotoRINewsLetterDetails(url:String)
    {
        var stringUrl:String=url
        print("Notify string URL \(stringUrl)")
        if(stringUrl.contains(".pdf") || stringUrl.contains(".docx") || stringUrl.contains(".doc") || stringUrl.contains(".html") || stringUrl.contains(".gif") || stringUrl.contains(".jpg") || stringUrl.contains(".jpeg") || stringUrl.contains(".png"))
            {
                //Call RI Document here
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let secondViewController = mainStoryboard.instantiateViewController(withIdentifier: "webViewCommonViewController") as! webViewCommonViewController
                secondViewController.URLstr=stringUrl
                secondViewController.moduleName="Newsletter"
                
                let navigationController: UINavigationController = UINavigationController(rootViewController: secondViewController)
                if let window = self.window, let rootViewController = window.rootViewController
                {
                    var currentController = rootViewController
                    while let presentedController = currentController.presentedViewController
                    {
                        currentController = presentedController
                    }
                    currentController.present(navigationController, animated: true, completion: nil)
                 }
            }
        
        else
        {

        if(stringUrl.contains("http"))
        {
        }
        else
        {
            stringUrl="http://"+stringUrl
        }
            let url = URL (string: (stringUrl))
        print("url to be shown \(url)")
        let requestObj = URLRequest(url: url!)
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
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        isAppInBackground = true
        print("applicationWillResignActive \(isAppInBackground)")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        isAppInBackground = true
        print("applicationDidEnterBackground \(isAppInBackground)")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        isAppInBackground = false
        print("applicationWillEnterForeground \(isAppInBackground)")

        /*//MARK:- Uncomment this
        NotificationCenter.default.post(name: Notification.Name("NotifyDashboard"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("NotifyList"), object: nil)*/
        
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "functionWhenAppwillActivefromBackgroundToForeground"), object: nil)
        // SVProgressHUD.dismiss()
        isAppInBackground = false
        print("applicationDidBecomeActive \(isAppInBackground)")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        isAppInBackground = true
        print("applicationWillTerminate \(isAppInBackground)")

        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return true
//    }
    
    // MARK: - Core Data stack
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "testApp.TouchBase" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "TouchBase", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    
    func GetReplicaInfo() {
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            let url:URL = URL(string:String(format: "%@Group/GetReplicaInfo?LastModuleID=0",baseUrl))!
            
            // let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
            do {
                
                //
                var updatedOn =  String ()
                let defaults = UserDefaults.standard
                let Updatedefault = String(format: "LastModuleID")
                if let str = defaults.value(forKey: Updatedefault) as! String?
                {
                    /*-----code by rajendra jat--*/
                    
                    // updatedOn = str
                    updatedOn="0"
                }else{
                    updatedOn = "0"   //1970-1-1 0:0:0
                }
                
                let post:NSString = String(format: "") as NSString
                
                NSLog("PostData: %@",post);
                
                updatedOn = "0"
                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
                let postLength:NSString = String( postData.count ) as NSString
                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
                request.httpMethod = "GET"
                request.httpBody = postData
                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                    if(response==nil || data==nil)
                    {
                        
                    }
                    else
                    {
                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1.rawValue)
                        
                        /*
                         var varGetValueServerError = response.object(forKey: "serverError")as? String
                         if(varGetValueServerError == "Error")
                         {
                         self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                         }
                         else
                         {
                         */
                        
                        let data = string!.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)
                        if(string?.contains("<html"))!
                        {
                            
                        }
                        else
                        {
                            if(string?.contains("Connection Timed O"))!
                            {
                                
                            }
                            else
                            {
                            let jsonObject: AnyObject? = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as AnyObject
                            let dd = jsonObject as! NSDictionary
                            
                                if ((dd.object(forKey: "ModuleResult") as! NSDictionary).object(forKey: "status") as! String == "0")
                            {
                                let  arrList = ((dd.object(forKey: "ModuleResult") as! NSDictionary).object(forKey: "ModuleList")) as! NSArray
                                if arrList.count > 0
                                {
                                    self.DeleteModuleDataInlocal()
                                    self.SaveDataInlocal(arrList)
                                    self.fetchData()
                                }
                              }
                           }
                        }
                     }
                  }
                task.resume()
            }
        }
    }
    
    
    func SaveDataInlocal (_ arrdata:NSArray){
//        var databasePath : String
//        
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
//        
//        let sql_stmt = "CREATE TABLE IF NOT EXISTS ReplicaInfo (_id INTEGER PRIMARY KEY AUTOINCREMENT, moduleId INTEGER, replicaOf TEXT)"
//        
//        
//        
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        if (contactDB?.open())! {
//            for i in 0 ..< arrdata.count {
//                let  dict = arrdata[i] as! NSDictionary
//                let insertSQL = "INSERT INTO ReplicaInfo (moduleId, replicaOf) VALUES ('\(dict.object(forKey: "moduleID") as! String)', '\(dict.object(forKey: "replicaOfModule") as! String)')"
//                let result = contactDB?.executeStatements(insertSQL)
//                
//                if (result == nil)
//                {
//                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                }
//                else
//                {
//                    print("success saved replicaoof")
//                    print(databasePath);
//                }
//                
//            }
//        } else {
//            print("Error: \(contactDB?.lastErrorMessage())")
//        }
//        
    }
    
    
    func fetchData (){
        list = NSMutableArray ()
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
            
            
            let querySQL = "SELECT * FROM ReplicaInfo order  by moduleId desc"
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,
                                                               withArgumentsIn: nil)
            
            while results?.next() == true {
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "moduleId"))! as String, forKey:"moduleId")
                dd.setValue((results?.string(forColumn: "replicaOf"))! as String, forKey:"replicaOf")
                list.add(dd)
                
            }
            if list.count > 0 {
                let Updatedefault = String(format: "LastModuleID")
                UserDefaults.standard.set((list[0] as AnyObject).object(forKey: "moduleId"), forKey: Updatedefault)
            }
        }
    }
    
    
    
    
    
    func DeleteModuleDataInlocal (){
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
            let insertSQL = "DELETE FROM ReplicaInfo"
            
            let result = contactDB?.executeStatements(insertSQL)
            
            if (result == nil) {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            } else {
                print("success saved")
            }
            
        }
        else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
    }
    
    
    
    
    // MARK: - create database
    func ceateDatabase () {
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
        
        contactDB?.open()
        // open database
        //ceate table Group_master
        
        //MARK:- Created notification table on 29 June 2020
        if (contactDB?.open())! {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS Notification_Table (MsgID TEXT,Title  TEXT,Details TEXT,Type TEXT,ClubDistrictType TEXT ,NotifyDate TEXT,ExpiryDate TEXT,SortDate DATE,ReadStatus TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        if (contactDB?.open())! {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS GROUPMASTER (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, grpId INTEGER, grpName TEXT, grpImg TEXT, grpProfileid INTEGER , myCategory TEXT, isGrpAdmin TEXT,notificationCount INTEGER)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        //ceate table MODULE_DATA_MASTER
        if (contactDB?.open())! {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS MODULE_DATA_MASTER (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, groupModuleId INTEGER, groupId TEXT, moduleId TEXT, moduleName TEXT , moduleStaticRef TEXT,image TEXT,moduleOrderNo INTEGER,notificationCount INTEGER, flag TEXT, linkUrl TEXT)"
            
            
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        // Create Table Gallary_Album_Photo_Data (Galary>Album>Photo) ------DPK
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS Gallary_Album_Photo_Data (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, description VARCHAR , groupId TEXT, albumId TEXT, photoId TEXT , url TEXT , IsLastUpdateDate TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        // Create Table Past President (Entity>Past President) ------DPK
        if (contactDB?.open())!{
            let sql_stmt = "CREATE TABLE IF NOT EXISTS Past_President_List_Details (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, groupId TEXT , moduleId TEXT ,PastPresidentId TEXT, MemberName TEXT, PhotoPath TEXT , TenureYear TEXT , IsLastUpdateDate TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS Club_NewsLetter_Details (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, ebulletinID TEXT, ebulletinTitle TEXT,ebulletinlink TEXT,ebulletinType TEXT,filterType TEXT,createDateTime TEXT,publishDateTime TEXT,expiryDateTime TEXT,isAdmin TEXT,isRead TEXT,grpID TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))!
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS Club_Events_Details (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, eventID TEXT, eventImg TEXT,eventTitle TEXT,eventDesc TEXT,eventDateTime TEXT,goingCount TEXT,maybeCount TEXT,notgoingCount TEXT,venue TEXT,myResponse TEXT,filterType TEXT,grpID TEXT,grpAdminId TEXT,isRead TEXT,venueLat TEXT,venueLon TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }

        // Create Table Board Of Director List  ------DPK
        //masterUID, groupId , moduleId , profileID , MemberDesignation , memberName , pic , membermobile From Board_Of_Directors_List
        if (contactDB?.open())! {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS Board_Of_Directors_List (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, groupId TEXT , moduleId TEXT ,profileID TEXT, MemberDesignation TEXT, memberName TEXT, pic TEXT , membermobile TEXT , sortingBYDesignation INTEGER)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }

        // Create Table District Commitee List  ------DPK
        //masterUID, groupId , moduleId , profileID , MemberDesignation , memberName , pic , membermobile From Board_Of_Directors_List
        if (contactDB?.open())! {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS District_Commitee_List (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, groupId TEXT , moduleId TEXT ,profileID TEXT, MemberDesignation TEXT, memberName TEXT, pic TEXT , membermobile TEXT , clubName TEXT , sortingBYDesignation INTEGER)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        // Create Table Rotary Library  ------DPK
        //"INSERT INTO Rotary_Library_Details (masterUID , groupId, moduleId, title , description,) VALUES ('
        if (contactDB?.open())! {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS Rotary_Library_Details (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, groupId TEXT , moduleId TEXT ,title TEXT, description TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }

        //WebLink_Details (masterUID,GroupId,moduleId,WeblinkId,Title,Description,LinkUrl
        // Create Table Web Link  ------DPK
        if (contactDB?.open())! {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS WebLink_Details (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, GroupId TEXT , moduleId TEXT ,WeblinkId TEXT, Title TEXT , Description TEXT ,LinkUrl TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }

        if (contactDB?.open())! {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS Find_A_Club_List (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, GroupId TEXT , moduleId TEXT ,District TEXT, CharterDate TEXT , ClubName TEXT ,ClubType TEXT,ClubId TEXT , Website TEXT,distance TEXT)"
            print(sql_stmt)
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS District_Club_List (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, GroupId TEXT , moduleId TEXT ,District TEXT, CharterDate TEXT , ClubName TEXT ,ClubType TEXT,ClubId TEXT , Website TEXT,distance TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //Find_A_Rotarian_List---------------DPK
        ///masterUID ,GroupId , moduleId ,clubName , designation  , memberMobile ,memberName , pic ,,profileID  , Find_A_Rotarian_List
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS Find_A_Rotarian_List (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, GroupId TEXT , moduleId TEXT ,clubName TEXT, designation TEXT , memberMobile TEXT ,memberName TEXT,pic TEXT , profileID TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }

        /*------------------------------------New--------------------------*/
        if (contactDB?.open())! {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS GROUPMASTER_NEW (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, grpId INTEGER, grpName TEXT, grpImg TEXT, grpProfileid INTEGER , myCategory TEXT, isGrpAdmin TEXT,notificationCount INTEGER,newsUpdateTitle TEXT ,newsUpdateDescription TEXT , newsUpdateDate TEXT ,BlogTitle TEXT,BlogDescription TEXT ,BlogDate TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //ceate table MODULE_DATA_MASTER_NEW
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS MODULE_DATA_MASTER_NEW (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, groupModuleId INTEGER, groupId TEXT, moduleId TEXT, moduleName TEXT , moduleStaticRef TEXT,image TEXT,moduleOrderNo INTEGER,notificationCount INTEGER,flag TEXT, linkUrl TEXT)"
            
            if !(contactDB?.executeStatements(sql_stmt))!
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }

        if (contactDB?.open())! {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS NewsUpdate_Table (_id INTEGER PRIMARY KEY AUTOINCREMENT, newsUpdateTitle TEXT, newsUpdateDescription TEXT , newsUpdateDate TEXT,link TEXT ,isFeedFirstOrSecond TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //---------------Dashboard-------
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS Dashboard_BirthAnniEvent_table_New (_id INTEGER PRIMARY KEY AUTOINCREMENT,  ClubCategory TEXT, ClubId TEXT , ClubName TEXT,Description TEXT ,ProfileId TEXT,Title TEXT,TodaysCount TEXT,Type TEXT,ExtraOne TEXT,ExtraTwo TEXT,IsAdmin TEXT,ISUpdate TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            // contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //ceate table DIRECTORY_DATA_MASTER
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS DIRECTORY_DATA_MASTER (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, groupId INTEGER, memberMasterUID INTEGER, profileID INTEGER , groupName TEXT,memberName TEXT,pic TEXT,membermobile TEXT,grpCount INTEGER,moduleId TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            //contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //ceate table service_directory_data_master
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS SERVICE_DIRECTORY_DATA_MASTER (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, groupId INTEGER, memberName TEXT, image TEXT , contactNo TEXT,isdeleted TEXT,description VARCHAR,contactNo2 TEXT,pax TEXT,email TEXT,address TEXT,long TEXT,lat TEXT,countryId1 INTEGER,countryId2 INTEGER,csvKeywords TEXT,city TEXT,state TEXT,country TEXT,zip TEXT,moduleId TEXT,serviceDirId TEXT,categoryId TEXT,website TEXT,IsLastUpdateDate TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            //contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        //ceate table ReplicaInfo
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS ReplicaInfo (_id INTEGER PRIMARY KEY AUTOINCREMENT, moduleId INTEGER, replicaOf TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            //contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        //ceate table GALLERY_MASTER
        if (contactDB?.open())! {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS GALLERY_MASTER (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, albumId INTEGER, title TEXT ,description TEXT,image TEXT,groupId INTEGER,isAdmin TEXT,moduleId TEXT,type TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            //contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }

        //ceate table album_photo_master
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS ALBUM_PHOTO_MASTER (_id INTEGER PRIMARY KEY AUTOINCREMENT, groupId INTEGER, albumId INTEGER, photoId INTEGER ,url TEXT,description TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            //contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //ceate table album_photo_master
        if (contactDB?.open())!
        {
            let sql_stmt = " CREATE  TABLE tableCalendar (WeekDayName VARCHAR,WeekDay VARCHAR,TotalDay VARCHAR,FullDate VARCHAR,Day VARCHAR,Month VARCHAR,Year VARCHAR,groupID TEXT,EventDonAnniv VARCHAR,Remark TEXT)"
            
            if !(contactDB?.executeStatements(sql_stmt))!
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                var vardsf=""
            }
            //contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //---dynamic profile database
        //1.
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS ProfileMaster (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterId TEXT, grpId TEXT, profileId TEXT , isAdmin TEXT, memberName TEXT, memberEmail TEXT, memberMobile TEXT, memberCountry TEXT, profilePic TEXT,familyPic TEXT, isPersonalDetVisible TEXT, isBussinessDetVisible TEXT, isFamilyDetVisible TEXT,userFamilyImage TEXT,uniquekey TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))!
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            //contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //2.
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS PersonalBusinessMemberDetails (_id INTEGER PRIMARY KEY AUTOINCREMENT, profileId TEXT , fieldId TEXT, uniquekey TEXT, key TEXT, value TEXT, colType TEXT, isEditable TEXT, isVisible TEXT, PersonalORBusiness TEXT,masterId TEXT, moduleID TEXT,groupId TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))!
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            //contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //3.
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS FamilyMemberDetail (_id INTEGER PRIMARY KEY AUTOINCREMENT, profileId TEXT , isVisible TEXT, familyMemberId TEXT, memberName TEXT, relationship TEXT, dob TEXT, emailID TEXT, anniversary TEXT, contactNo TEXT, particulars TEXT, bloodGroup TEXT,masterId TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))!
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            //contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //4.
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS AddressDetails (_id INTEGER PRIMARY KEY AUTOINCREMENT,profileId TEXT,AddressprofileId TEXT , addressID TEXT, addressType TEXT, address TEXT, city TEXT, state TEXT, country TEXT, pincode TEXT, phoneNo TEXT, fax TEXT, isBusinessAddrVisible TEXT, isResidanceAddrVisible TEXT,masterId TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))!
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            //contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //5.
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS clubMember_Segment_List (_id INTEGER PRIMARY KEY AUTOINCREMENT,masterUID TEXT,grpID TEXT , profileID TEXT, memberName TEXT, membermobile TEXT, pic TEXT, distDesignation TEXT,classification TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))!
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            //contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //6. 27.05.2019 Adding classification on MemberSegmentViewController class or Districty -> Club -> Member -> DropDown -> Classifictaion select
        if (contactDB?.open())!
        {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS clubMember_Segment_List_DropDown_Classification (_id INTEGER PRIMARY KEY AUTOINCREMENT, classification TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))!
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            //contactDB.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //6---------------------------------------------------------------------------------------------------------------------------------
    }
    func beginParsingBlog()
    {
        
        let todoEndpoint: String = "https://blog.rotary.org/feed/"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            // do stuff with response, data & error here
            if data == nil {
            print("dataTaskWithRequest error: \(error)")
                return
            }
            else
            {
                self.varWhichRssFeedRun = "Blogs"
                self.posts = []
                // parser = NSXMLParser(contentsOfURL:(NSURL(string:"https://blog.rotary.org/feed/"))!)!
                self.parser = XMLParser(contentsOf:(URL(string:"https://blog.rotary.org/feed/"))!)!
                
                self.parser.delegate = self
                self.parser.parse()
            }
        })
        task.resume()
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
            varLink = NSMutableString()
            varLink = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (elementName as NSString).isEqual(to: "item") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title" as NSCopying)
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "date" as NSCopying)
            }
            if !description11.isEqual(nil) {
                elements.setObject(description11, forKey: "description" as NSCopying)
            }
            if !varLink.isEqual(nil) {
                elements.setObject(varLink, forKey: "link" as NSCopying)
            }
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
                // self.Createtablecity()
            }
            let contactDB = FMDatabase(path: databasePath as String)
            if contactDB == nil
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            if (contactDB?.open())!
            {
                
                let  insertSQL = "INSERT INTO NewsUpdate_Table (newsUpdateTitle , newsUpdateDescription,newsUpdateDate,link,isFeedFirstOrSecond) VALUES ( '\(title1)', '\(description11)', '\(date)','\(varLink)','\("Second")')"
               print("3.NewsUpdate Insert Query::\(insertSQL)")
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    print("success saved")
                }
            }
            else
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            
            posts.add(elements)
        }
        else
        {
            
        }
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
            varLink.append(string)
        }
    }
    
    func functionForTruncateXMLData()
    {
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
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            //1.
            let insertSQL = "DELETE FROM NewsUpdate_Table"
            print(insertSQL)
            let result = contactDB?.executeStatements(insertSQL)
            if (result == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success delete NewsUpdate_Table from appDelegate")
                
            }
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
    }
    /*hittu deep linking or Dynamic linking 15 jan 2019 start*/
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if let incomingURL = userActivity.webpageURL {
            let handleLink = DynamicLinks.dynamicLinks().handleUniversalLink(incomingURL, completion: { (dynamicLink, error) in
                if let dynamicLink = dynamicLink, let _ = dynamicLink.url
                {
                    let message = dynamicLink.url
                    // NotificationCenter.default.post(name: Notification.Name("DeepLinking"), object: message)
                } else {
                    // Check for errors
                }
            })
            return handleLink
        }
        return false
    }
    func handleDynamicLink(_ dynamicLink: DynamicLink) {
        print("Your Dynamic Link parameter: \(dynamicLink)")
    }
    /*hittu deep linking or Dynamic linking 15 jan 2019 end*/
    
  
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent \(notification)")
        completionHandler([.banner, .sound, .badge])
    }

  
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive \(response.notification)")
    }

}

struct RIImgText: Codable {
    let registrationResult: RegistrationResultess

    enum CodingKeys: String, CodingKey {
        case registrationResult = "RegistrationResult"
    }
}

// MARK: - RegistrationResult
struct RegistrationResultess: Codable {
    let status, message: String
    let result: Resulte
}

// MARK: - Result
struct Resulte: Codable {
    let table: [Table]

    enum CodingKeys: String, CodingKey {
        case table = "Table"
    }
}

// MARK: - Table
struct Table: Codable {
    let pkCommonID: Int
    let applicationType, applicationNameText: String
    let headerlogo, footerlogo, afterloginlogo: String
    let createddate, modifieddate, isdeleted, deleteddate: JSONNull?
    let deletedby: JSONNull?
    let websiteClickURL: String
    let applicationNameText1: String
    let facebook, instagram, youtube: String
    let websiteShowURL, helplineNumber, websiteShowURL1: String
    let membershipduesApproveRejectURL: String
    let supportMailID, communicationMailID, imgPathSave: String
    let webmarketplaceForwebsiteinfo: String
    let webmarketplaceForwebsiteinfoFilepath, notificationFilePath, notificationProjectID: String

    enum CodingKeys: String, CodingKey {
        case pkCommonID = "pk_common_id"
        case applicationType = "Application_type"
        case applicationNameText = "Application_name_text"
        case headerlogo, footerlogo, afterloginlogo, createddate, modifieddate, isdeleted, deleteddate, deletedby
        case websiteClickURL = "website_click_URL"
        case applicationNameText1 = "Application_name_text1"
        case facebook, instagram, youtube
        case websiteShowURL = "website_show_URL"
        case helplineNumber = "Helpline_number"
        case websiteShowURL1 = "website_show_URL1"
        case membershipduesApproveRejectURL = "membershipdues_approve_reject_url"
        case supportMailID = "support_mail_id"
        case communicationMailID = "communication_mail_id"
        case imgPathSave
        case webmarketplaceForwebsiteinfo = "webmarketplace_forwebsiteinfo"
        case webmarketplaceForwebsiteinfoFilepath = "webmarketplace_forwebsiteinfo_filepath"
        case notificationFilePath = "Notification_file_path"
        case notificationProjectID = "Notification_projectId"
    }
}
