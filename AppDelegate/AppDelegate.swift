
//
//  AppDelegate.swift
//  TouchBase
//
//  Created by Umesh on 24/11/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import EventKit

//import AVFoundation



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var filteredArray = [String]()
    var eventStore: EKEventStore?
    var isReachable:Bool!
    var interNetStatus:Reachability!
    let bounds = UIScreen.mainScreen().bounds
    var imageView : UIImageView!
    var isAppInBackground : Bool!
    var rootViewNav =  UINavigationController()
    var databasePath = String()
    var list = NSMutableArray()
    var notifyDict:NSDictionary!
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        // [START tracker_swift]
        // Configure tracker from GoogleService-Info.plist.
//        var configureError:NSError?
//        GGLContext.sharedInstance().configureWithError(&configureError)
//        assert(configureError == nil, "Error configuring Google services: \(configureError)")
//        
//        // Optional: configure GAI options.
//        let gai = GAI.sharedInstance()
//        gai.trackUncaughtExceptions = true  // report uncaught exceptions
//        gai.logger.logLevel = GAILogLevel.Verbose  // remove before app release
//        // [END tracker_swift]
//
        
        
        
        
        
        //ganesh
        
        let pageControl = UIPageControl.appearance()
        pageControl.backgroundColor = UIColor.clearColor()
       // pageControl.pageIndicatorTintColor! = UIColor.whiteColor()
     //   pageControl.currentPageIndicatorTintColor! = UIColor.redColor()
        
        
        
         ceateDatabase()
        
        GMSServices.provideAPIKey("AIzaSyAEkT9PZ1QJJkKvbrH2XXr17RJhrTDF4l8")
        
        notifyDict=NSDictionary()
        UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        print("UDID *** \(UIDevice.currentDevice().identifierForVendor!.UUIDString)")
        let defaults = NSUserDefaults.standardUserDefaults()
        if let str = defaults.valueForKey("completeReg") as! String?
        {
            print(str)
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
            let rootViewController =  UINavigationController()
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("rootDash") as! RootDashViewController
            //rootViewController.pushViewController(dashBoardController, animated: true)
            self.rootViewNav = UINavigationController(rootViewController: dashBoardController)
            self.window!.rootViewController = self.rootViewNav
            self.window!.backgroundColor = UIColor.clearColor()
            self.window!.makeKeyAndVisible()
            
            
        }
        else
        {
           if let str = defaults.valueForKey("splashOver") as! String?
            {
                print(str)
        
                self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                
                let mobileLoginController =  UINavigationController()
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("mobile_login") as! MobileLoginController

                let rootViewController =  UINavigationController()
                self.rootViewNav = UINavigationController(rootViewController: dashBoardController)
                self.window!.rootViewController = self.rootViewNav
                self.window!.backgroundColor = UIColor.clearColor()
                self.window!.makeKeyAndVisible() //contact_list
            }
        }
        
        let mainQueue = NSOperationQueue.mainQueue()
        NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationUserDidTakeScreenshotNotification,
            object: nil,
            queue: mainQueue) { notification in
                // executes after screenshot
                print("screenshot taken")
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.checkInternetStatus(_:)), name: kReachabilityChangedNotification, object: nil)
        
        interNetStatus=Reachability.reachabilityForInternetConnection()
        interNetStatus.startNotifier()
        isReachable=isReachableNet()
        if(!isReachable){
            imageView  = UIImageView(frame:CGRectMake(0, 65, bounds.width, 40));
            
            imageView.image = UIImage(named:"nointernet")
            self.window?.addSubview(imageView)
        }
        
        
//        let type: UIUserNotificationType = [UIUserNotificationType.Badge, UIUserNotificationType.Alert, UIUserNotificationType.Sound]
//        let setting = UIUserNotificationSettings(forTypes: type, categories: nil)
//        UIApplication.sharedApplication().registerUserNotificationSettings(setting)
//        UIApplication.sharedApplication().registerForRemoteNotifications()
        
         let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
//        var alert=UIAlertController(title:"", message: "inside didfinish", preferredStyle: UIAlertControllerStyle.Alert);
//        
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil));
//        //event handler with closure
//       
//        
//        self.rootViewNav.presentViewController(alert, animated: true, completion: nil);
        if let userInfo = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
            // ...do stuff...
            CallNoti(userInfo)
            
        }
       GetReplicaInfo()
        return true
                //return true
    }
    
    func showAlsertView(){
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "TouchBase"
        alertView.message = "This feature is coming soon!"
        alertView.delegate = nil
        alertView.addButtonWithTitle("OK")
        alertView.show()
    }
   
//    func setRootView(){
//        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        
//        let rootViewController =  UINavigationController()
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("rootDash") as! RootDashViewController
//        //rootViewController.pushViewController(dashBoardController, animated: true)
//        self.rootViewNav = UINavigationController(rootViewController: dashBoardController)
//        self.window!.rootViewController = self.rootViewNav
//        self.window!.backgroundColor = UIColor.clearColor()
//        self.window!.makeKeyAndVisible()
//    }
//    func setRootViewBack(aps:NSDictionary){
//        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        
//        let rootViewController =  UINavigationController()
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("rootDash") as! RootDashViewController
//        //rootViewController.pushViewController(dashBoardController, animated: true)
//        self.rootViewNav = UINavigationController(rootViewController: dashBoardController)
//        self.window!.rootViewController = self.rootViewNav
//        self.window!.backgroundColor = UIColor.clearColor()
//        self.window!.makeKeyAndVisible()
//        notifyDict = aps.mutableCopy() as! NSDictionary
//        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "DropboxAction", userInfo: nil, repeats: false)
//        
//    }
    
//    func  DropboxAction(){
//    var alert=UIAlertController(title: "Notification", message: notifyDict["alert"] as? String, preferredStyle: UIAlertControllerStyle.Alert);
//    
//    alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil));
//    //event handler with closure
//    alert.addAction(UIAlertAction(title: "Show", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction) in
//        if(self.notifyDict["type"] as? NSString == "Event"){
//            
//            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("eventDetail") as! EventsDetailController
//            dashBoardController.eventID = self.notifyDict["tyID"] as? NSString
//            dashBoardController.grpId = self.notifyDict["grpID"] as? NSString
//            dashBoardController.profileId = self.notifyDict["memID"] as? NSString
//            dashBoardController.isCalled = "notify1"
//            //isAdmin
//            NSUserDefaults.standardUserDefaults().setObject("No", forKey: "isAdmin")
//            
//            
//            let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
//            self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
//        }
//        if(self.notifyDict["type"] as? NSString == "ann"){
//            
//            
//            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("announceDetail") as! AnnouncementDetailController
//            dashBoardController.annID = self.notifyDict["tyID"] as? NSString
//            dashBoardController.grpID = self.notifyDict["grpID"] as? NSString
//            dashBoardController.profileId = self.notifyDict["memID"] as? NSString
//            dashBoardController.isCalled = "notify1"
//            NSUserDefaults.standardUserDefaults().setObject("No", forKey: "isAdmin")
//            let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
//            self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
//        }
//        if(self.notifyDict["type"] as? NSString == "Ebulle"){
//            
//            
//            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("ebdetail") as! EbulletinDetailViewController
//            dashBoardController.urlLink = self.notifyDict["link"] as! String
//            dashBoardController.isCalled = "notify1"
//            NSUserDefaults.standardUserDefaults().setObject("No", forKey: "isAdmin")
//            let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
//            self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
//            
//        }
//        
//    }));
//    
//    self.window?.rootViewController!.presentViewController(alert, animated: true, completion: nil);
//        
//    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        if (DBChooser.defaultChooser().handleOpenURL(url)) {
            return true
        }
        return false
    }

    
//    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
//        
//        if DBSession.sharedSession().handleOpenURL(url) {
//            if DBSession.sharedSession().isLinked() {
//                NSNotificationCenter.defaultCenter().postNotificationName("didLinkToDropboxAccountNotification", object: nil)
//                return true
//            }
//        }
//        
//        return false
//    }
    
    func setMobileViewAsRoot() {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let mobileLoginController =  UINavigationController()
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("mobile_login") as! MobileLoginController
        
        let rootViewController =  UINavigationController()
        self.rootViewNav = UINavigationController(rootViewController: dashBoardController)
        self.window!.rootViewController = self.rootViewNav
        self.window!.backgroundColor = UIColor.clearColor()
        self.window!.makeKeyAndVisible()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let deviceTokenStr = convertDeviceTokenToString(deviceToken)
        // ...register device token with our Time Entry API server via REST
       
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Device token for push notifications: FAIL -- ")
        print(error.description)
    }
   
    private func convertDeviceTokenToString(deviceToken:NSData) -> String {
        //  Convert binary Device Token to a String (and remove the <,> and white space charaters).
        let characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
        
        let deviceTokenString: String = ( deviceToken.description as NSString )
            .stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        print("Device token for push notifications ")
        print( deviceTokenString )
         NSUserDefaults.standardUserDefaults().setObject(deviceTokenString, forKey: "deviceToken")
        return deviceTokenString
    }
    
    func checkInternetStatus(notice:NSNotification){
        let s:NSString = "www.apple.com"
        let r:Reachability!
        r = Reachability(hostName: s as String)
        var internetStatus:NetworkStatus!
        internetStatus=r.currentReachabilityStatus()
        print("internet status \(internetStatus)")
        if(internetStatus != 0){
            print("Internet connection OK")
            imageView.removeFromSuperview()
            isReachable=true
        } else {
            print("Internet connection FAILED")
             isReachable=false
            
            imageView  = UIImageView(frame:CGRectMake(0, 65, bounds.width, 40));
            
            imageView.image = UIImage(named:"nointernet")
            self.window?.addSubview(imageView)
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
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
        case .Unknown, .Offline:
            print("Not connected")
            
            return false;
            
        case .Online(.WWAN):
            print("Connected via WWAN")
             return true;
           
            
        case .Online(.WiFi):
            print("Connected via WiFi")
             return true;
            
            
        }
        
//        if(internetStatus != 0){
//            //            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
//            //            alert.show()
//            return true;
//        }
//        return false;


    }
    func CallNoti(userInfo:NSDictionary){
        print("inside else")
        print("userinfo \(userInfo)")
     //   let msg = userInfo["aps"] as? Dictionary<String,AnyObject>
        let aps = userInfo["aps"] as? NSDictionary
        notifyDict = aps!.mutableCopy() as! NSDictionary
        print(aps)
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "TouchBase"
        alertView.message = notifyDict["alert"] as? String
        alertView.delegate = self
        alertView.tag = 12
        alertView.addButtonWithTitle("OK")
        alertView.show()
        
    
    }
   func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    //func  application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void){
    

        print("userinfo \(userInfo)")
        let msg = userInfo["aps"] as? Dictionary<String,AnyObject>
        let aps = userInfo["aps"] as? NSDictionary
        print(aps)

        
        print(aps!["typeID"] as? NSString)
        if(isAppInBackground == false){
            print("inside if")
//            var alert=UIAlertController(title: "Notification", message: aps!["alert"] as? String, preferredStyle:
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "TouchBase"
                        alertView.message = aps!["alert"] as? String
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()

        }else{
        
        print("inside else")
        if(aps!["type"] as? NSString == "Event"){
           
          
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("eventDetail") as! EventsDetailController
            dashBoardController.eventID = aps!["tyID"] as? NSString
            dashBoardController.grpId = aps!["grpID"] as? NSString
            dashBoardController.profileId = aps!["memID"] as? NSString
            dashBoardController.isCalled = "notify"
             NSUserDefaults.standardUserDefaults().setObject("No", forKey: "isAdmin")
            let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
             self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
           
        }
            
        if(aps!["type"] as? NSString == "ann"){
            
           let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("announceDetail") as! AnnouncementDetailController
            dashBoardController.annID = aps!["tyID"] as? NSString
            dashBoardController.grpID = aps!["grpID"] as? NSString
            dashBoardController.profileId = aps!["memID"] as? NSString
            dashBoardController.isCalled = "notify"
             NSUserDefaults.standardUserDefaults().setObject("No", forKey: "isAdmin")
            let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
             //self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
            self.rootViewNav.pushViewController(dashBoardController, animated: true)
        }
        if(aps!["type"] as? NSString == "Ebulle"){
            
           
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("ebdetail") as! EbulletinDetailViewController
            dashBoardController.urlLink = aps!["link"] as! String
            dashBoardController.isCalled = "notify"
            dashBoardController.profileID = aps!["memID"] as! String//memID
            dashBoardController.bulletinID = aps!["tyID"] as! String
             NSUserDefaults.standardUserDefaults().setObject("No", forKey: "isAdmin")
            let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
            self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
        }
            if(aps!["type"] as? NSString == "Doc"){
                
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("docmVC") as! DocumentListViewControlller
                dashBoardController.groupIDX = aps!["grpID"] as! String
                dashBoardController.grpPRofileID = aps!["memID"] as! String
                dashBoardController.isCalled = "notify"
                
                
                let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
                
            }
            if(aps!["type"] as? NSString == "RemoveMember"){
                
            }
            if(aps!["type"] as? NSString == "AddMember"){
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("profileView") as! ProfileViewController
                 NSUserDefaults.standardUserDefaults().setObject("no", forKey: "picadded")
                dashBoardController.userGroupID =  aps!["grpID"] as! String
                dashBoardController.userProfileID =  aps!["tyID"] as! String //mobileTitles[indexPath.row]
                dashBoardController.isAdmin = "No"
                dashBoardController.mainUSerPRofileID = aps!["memID"] as! String
                dashBoardController.isCalled = "notify"
                 NSUserDefaults.standardUserDefaults().setObject("No", forKey: "isAdmin")
                let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
                
            }
            if(aps!["type"] as? NSString == "EditGroup"){
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("profNewInfo_view") as! ProfileInfoController
                
                dashBoardController.userGroupID =  aps!["grpID"] as! String
                dashBoardController.userProfileID =  aps!["memID"] as! String //mobileTitles[indexPath.row]
                dashBoardController.isCalled = "notify"
//                dashBoardController.isGrpAdmin = "No"
                
                
                //let profVC = self.storyboard!.instantiateViewControllerWithIdentifier("profNewInfo_view") as! ProfileInfoController
                dashBoardController.groupIDX =  aps!["grpID"] as! String
                NSUserDefaults.standardUserDefaults().setObject("No", forKey: "isAdmin")
                let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
                
            }
        }
    
    }
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int)
    {
        if(alertView.tag == 12){
            if(buttonIndex == 0){
                if(notifyDict["type"] as? NSString == "Event"){
                    
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("eventDetail") as! EventsDetailController
                    dashBoardController.eventID = notifyDict["tyID"] as? NSString
                    dashBoardController.grpId = notifyDict["grpID"] as? NSString
                    dashBoardController.profileId = notifyDict["memID"] as? NSString
                    dashBoardController.isCalled = "notify"
                    NSUserDefaults.standardUserDefaults().setObject("No", forKey: "isAdmin")
                  //  let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                    //self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
                    self.rootViewNav.pushViewController(dashBoardController, animated: true)
                }
                
                if(notifyDict["type"] as? NSString == "ann"){
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("announceDetail") as! AnnouncementDetailController
                    dashBoardController.annID =  notifyDict["tyID"] as? NSString
                    dashBoardController.grpID = notifyDict["grpID"] as? NSString
                    dashBoardController.profileId = notifyDict["memID"] as? NSString
                    dashBoardController.isCalled = "notify"
                    NSUserDefaults.standardUserDefaults().setObject("No", forKey: "isAdmin")
                 //   let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                    //self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
                    self.rootViewNav.pushViewController(dashBoardController, animated: true)
                    //self.rootViewNav.pushViewController(dashBoardController, animated: true)
                    
//                    let SubGroupController = mainStoryboard.instantiateViewControllerWithIdentifier("sub_group1") as! SubGroupListController
//                    SubGroupController.isCalledFrom="list"
//                    SubGroupController.groupIDX = "1"
//                    self.rootViewNav.pushViewController(SubGroupController, animated: true)
                }
                if(notifyDict["type"] as? NSString == "Ebulle"){
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("ebdetail") as! EbulletinDetailViewController
                    dashBoardController.urlLink = notifyDict["link"] as! String
                    dashBoardController.isCalled = "notify"
                    dashBoardController.profileID = notifyDict["memID"] as! String//memID
                    dashBoardController.bulletinID = notifyDict["tyID"] as! String
                    NSUserDefaults.standardUserDefaults().setObject("No", forKey: "isAdmin")
                 //   let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                    //self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
                    self.rootViewNav.pushViewController(dashBoardController, animated: true)
                }
                if(notifyDict["type"] as? NSString == "Doc"){
                    
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("docmVC") as! DocumentListViewControlller
                    dashBoardController.groupIDX = notifyDict["grpID"] as! String
                    dashBoardController.grpPRofileID = notifyDict["memID"] as! String
                    dashBoardController.isCalled = "notify"
                    
                    
                   // let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                    //self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
                    self.rootViewNav.pushViewController(dashBoardController, animated: true)
                }
                if(notifyDict["type"] as? NSString == "RemoveMember"){
                    
                    
                    
                }
                if(notifyDict["type"] as? NSString == "AddMember"){
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("profileView") as! ProfileViewController
                     NSUserDefaults.standardUserDefaults().setObject("no", forKey: "picadded")
                    dashBoardController.userGroupID =  notifyDict["grpID"] as! String
                    dashBoardController.userProfileID =  notifyDict["tyID"] as! String //mobileTitles[indexPath.row]
                    dashBoardController.isAdmin = "No"
                    dashBoardController.mainUSerPRofileID = notifyDict["memID"] as! String
                    dashBoardController.isCalled = "notify"
                    NSUserDefaults.standardUserDefaults().setObject("No", forKey: "isAdmin")
                   // let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                   // self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
                    self.rootViewNav.pushViewController(dashBoardController, animated: true)
                }
                if(notifyDict["type"] as? NSString == "EditGroup"){
                    
//                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("group_info") as! GroupInfoController
//                    
//                    dashBoardController.userGroupID =  notifyDict["grpID"] as! String
//                    dashBoardController.userProfileID =  notifyDict["memID"] as! String //mobileTitles[indexPath.row]
                    
//                    dashBoardController.isGrpAdmin = "No"
//                    NSUserDefaults.standardUserDefaults().setObject("No", forKey: "isAdmin")
//                   // let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
//                   self.rootViewNav.pushViewController(dashBoardController, animated: true)
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = mainStoryboard.instantiateViewControllerWithIdentifier("profNewInfo_view") as! ProfileInfoController
                    
                    //                dashBoardController.userGroupID =  aps!["grpID"] as! String
                    //                dashBoardController.userProfileID =  aps!["memID"] as! String //mobileTitles[indexPath.row]
                    //                dashBoardController.isCalled = "notify"
                    //                dashBoardController.isGrpAdmin = "No"
                    
                    
                    //let profVC = self.storyboard!.instantiateViewControllerWithIdentifier("profNewInfo_view") as! ProfileInfoController
                    dashBoardController.groupIDX =  notifyDict["grpID"] as! String
                    NSUserDefaults.standardUserDefaults().setObject("No", forKey: "isAdmin")
                                        dashBoardController.userGroupID =  notifyDict["grpID"] as! String
                                        dashBoardController.userProfileID =  notifyDict["memID"] as! String //mobileTitles[indexPath.row]
                    dashBoardController.isCalled = "notify"
                    let navController: UINavigationController = UINavigationController(rootViewController: dashBoardController)
                    self.rootViewNav.presentViewController(navController, animated: true, completion: nil)
                    
                }
            }
        }
        
        
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        isAppInBackground = true
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        isAppInBackground = false
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        isAppInBackground = false
        application.applicationIconBadgeNumber = 0;
    }

    func applicationWillTerminate(application: UIApplication) {
        isAppInBackground = true
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "testApp.TouchBase" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("TouchBase", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as! NSError
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
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
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
        if(self.isReachable == true){
            //self.loaderViewMethod()
            do {
                
                
                var updatedOn =  String ()
                let defaults = NSUserDefaults.standardUserDefaults()
                let Updatedefault = String(format: "LastModuleID")
                if let str = defaults.valueForKey(Updatedefault) as! String?
                {
                    print(str)
                    updatedOn = str
                }else{
                    updatedOn = "0"   //1970-1-1 0:0:0
                }
                
                let post:NSString = String(format: "")
                
                NSLog("PostData: %@",post);
                
                let url:NSURL = NSURL(string:String(format: "%@Group/GetReplicaInfo?LastModuleID=%@",baseUrl,updatedOn))!
                
                let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
                
                let postLength:NSString = String( postData.length )
                
                let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "GET"
                request.HTTPBody = postData
                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                
                do {
                    //  urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) in
                        let string = NSString(data: data!, encoding: NSISOLatin1StringEncoding)
                        print("Response 8888 \(string!)")
                        
                        let data = string!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                        let jsonObject: AnyObject? = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
                        print("jsonObject \(jsonObject!)")
                        let dd = jsonObject as! NSDictionary
                        print("dd \(dd)")
                        
                        if (dd.objectForKey("ModuleResult")!.objectForKey("status") as! String == "0"){
                            let  arrList = (dd.objectForKey("ModuleResult")!.objectForKey("ModuleList")) as! NSArray
                            
                            if arrList.count > 0 {
                                self.DeleteModuleDataInlocal()
                                self.SaveDataInlocal(arrList)
                                self.fetchData()
                                
                            }
                            
                            
                        }
                        
                        
                    }
                }
                
                
            }
        }
    }
    
    
    func SaveDataInlocal (arrdata:NSArray){
        var databasePath : String
        print(arrdata);
        
        let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        let fileURL = documents.URLByAppendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL!.path!
        var db: COpaquePointer = nil
        if sqlite3_open(fileURL!.path!, &db) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
        let sql_stmt = "CREATE TABLE IF NOT EXISTS ReplicaInfo (_id INTEGER PRIMARY KEY AUTOINCREMENT, moduleId INTEGER, replicaOf TEXT)"
        
        
        
        let mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("masterUID")
        if (contactDB?.open())! {
            for i in 0 ..< arrdata.count {
                let  dict = arrdata[i] as! NSDictionary
                let insertSQL = "INSERT INTO ReplicaInfo (moduleId, replicaOf) VALUES ('\(dict.objectForKey("moduleID") as! String)', '\(dict.objectForKey("replicaOfModule") as! String)')"
                print(insertSQL)
                
                let result = contactDB?.executeStatements(insertSQL)
                
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("success saved replicaoof")
                    print(databasePath);
                }
            }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
    }
    
    
    func fetchData (){
        list = NSMutableArray ()
        var databasePath : String
        let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        let fileURL = documents.URLByAppendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL!.path!
        var db: COpaquePointer = nil
        if sqlite3_open(fileURL!.path!, &db) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        let mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("masterUID")
        if (contactDB?.open())! {
            
            
            let querySQL = "SELECT * FROM ReplicaInfo order  by moduleId desc"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,
                                                               withArgumentsInArray: nil)
            
            while results?.next() == true {
               // print((results?.stringForColumn("moduleId"))! as String)
                let dd = NSMutableDictionary ()
                dd.setValue((results?.stringForColumn("moduleId"))! as String, forKey:"moduleId")
                dd.setValue((results?.stringForColumn("replicaOf"))! as String, forKey:"replicaOf")
              list.addObject(dd)
                
            }
            print(list)
            if list.count > 0 {
               let Updatedefault = String(format: "LastModuleID")
                NSUserDefaults.standardUserDefaults().setObject(list[0].objectForKey("moduleId"), forKey: Updatedefault)
            }
        }
    }
    
    
    
    
    
    func DeleteModuleDataInlocal (){
        var databasePath : String
        
        let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        let fileURL = documents.URLByAppendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL!.path!
        var db: COpaquePointer = nil
        if sqlite3_open(fileURL!.path!, &db) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
        let mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("masterUID")
        if (contactDB?.open())! {
            let insertSQL = "DELETE FROM ReplicaInfo"
            print(insertSQL)
            
            let result = contactDB?.executeStatements(insertSQL)
            
            if (result == nil) {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            } else {
                print("success saved")
                print(databasePath);
            }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
    }
    
    
    
    
    // MARK: - create database
    func ceateDatabase () {
        let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        let fileURL = documents.URLByAppendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL!.path!
        var db: COpaquePointer = nil
        if sqlite3_open(fileURL!.path!, &db) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
        contactDB.open()
            // open database
            //ceate table Group_master
            if contactDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS GROUPMASTER (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, grpId INTEGER, grpName TEXT, grpImg TEXT, grpProfileid INTEGER , myCategory TEXT, isGrpAdmin TEXT)"
                if !contactDB.executeStatements(sql_stmt) {
                    print("Error: \(contactDB.lastErrorMessage())")
                }
               // contactDB.close()
            } else {
                print("Error: \(contactDB.lastErrorMessage())")
            }
        
         //ceate table MODULE_DATA_MASTER
        if contactDB.open() {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS MODULE_DATA_MASTER (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, groupModuleId INTEGER, groupId TEXT, moduleId TEXT, moduleName TEXT , moduleStaticRef TEXT,image TEXT,moduleOrderNo INTEGER)"
            if !contactDB.executeStatements(sql_stmt) {
                print("Error: \(contactDB.lastErrorMessage())")
            }
           // contactDB.close()
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
        
        //ceate table DIRECTORY_DATA_MASTER
        if contactDB.open() {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS DIRECTORY_DATA_MASTER (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, groupId INTEGER, memberMasterUID INTEGER, profileID INTEGER , groupName TEXT,memberName TEXT,pic TEXT,membermobile TEXT,grpCount INTEGER,moduleId TEXT)"
            if !contactDB.executeStatements(sql_stmt) {
                print("Error: \(contactDB.lastErrorMessage())")
            }
            //contactDB.close()
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
        
        //ceate table service_directory_data_master
        if contactDB.open() {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS SERVICE_DIRECTORY_DATA_MASTER (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, groupId INTEGER, memberName TEXT, image TEXT , contactNo TEXT,isdeleted TEXT,description TEXT,contactNo2 TEXT,pax TEXT,email TEXT,address TEXT,long TEXT,lat TEXT,countryId1 INTEGER,countryId2 INTEGER,csvKeywords TEXT,city TEXT,state TEXT,country TEXT,zip TEXT,moduleId TEXT,serviceDirId TEXT)"
            if !contactDB.executeStatements(sql_stmt) {
                print("Error: \(contactDB.lastErrorMessage())")
            }
            //contactDB.close()
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
        //ceate table ReplicaInfo
        if contactDB.open() {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS ReplicaInfo (_id INTEGER PRIMARY KEY AUTOINCREMENT, moduleId INTEGER, replicaOf TEXT)"
            if !contactDB.executeStatements(sql_stmt) {
                print("Error: \(contactDB.lastErrorMessage())")
            }
            //contactDB.close()
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
        //ceate table GALLERY_MASTER
        if contactDB.open() {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS GALLERY_MASTER (_id INTEGER PRIMARY KEY AUTOINCREMENT, masterUID INTEGER, albumId INTEGER, title TEXT ,description TEXT,image TEXT,groupId INTEGER,isAdmin TEXT,moduleId TEXT)"
            if !contactDB.executeStatements(sql_stmt) {
                print("Error: \(contactDB.lastErrorMessage())")
            }
            //contactDB.close()
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
        
        //ceate table album_photo_master
        if contactDB.open() {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS ALBUM_PHOTO_MASTER (_id INTEGER PRIMARY KEY AUTOINCREMENT, groupId INTEGER, albumId INTEGER, photoId INTEGER ,url TEXT,description TEXT)"
            if !contactDB.executeStatements(sql_stmt) {
                print("Error: \(contactDB.lastErrorMessage())")
            }
            //contactDB.close()
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
        
        
    }
}

