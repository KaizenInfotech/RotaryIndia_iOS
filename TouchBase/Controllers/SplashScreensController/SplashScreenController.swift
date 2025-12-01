//
//  SplashScreenController.swift
//  TouchBase
//
//  Created by Kaizan on 04/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import SJSegmentedScrollView
import WebKit
import Alamofire

class SplashScreenController: UIViewController, UIPageViewControllerDataSource {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var textviewTermsAndCondition: UITextView!
    @IBOutlet weak var viewForTermsAndConditions: UIView!
    @IBOutlet weak var webViewInfo: WKWebView!
    let images = [
        UIImage(named: "screens1.png")!,
        UIImage(named: "screens2.png")!,
        UIImage(named: "screens3.png")!,
        UIImage(named: "screens4.png")!,
        UIImage(named: "screen5.png")!]
    var index = 0
    var headerImg = ""
    let animationDuration: TimeInterval = 0.25
    let switchingInterval: TimeInterval = 5

    func animateImageView() {
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            let delay = DispatchTime.now() + Double(Int64(self.switchingInterval * TimeInterval(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.animateImageView()
            }
        }
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        /*
         transition.type = kCATransitionPush
         transition.subtype = kCATransitionFromRight
         */
        imageView.layer.add(transition, forKey: kCATransition)
        imageView.image = images[index]
        
        CATransaction.commit()
        
        index = index < images.count - 1 ? index + 1 : 0
    }
    
    
    @IBOutlet weak var buttonTermsAndCondition: UIButton!
    
   // @IBOutlet var pageControl: UIPageControl!
    var pageViewController: UIPageViewController!
  //  var pageTitles: NSArray!
    var pageImages: NSArray!
   var appDelegate : AppDelegate!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var termsAndConditionButton: UIButton!
    override func viewWillAppear(_ animated: Bool)
    {
        print("Entered in splash screen ViewWill Appear")
        DeleteDataInlocal()
        self.navigationController!.isNavigationBarHidden = true
    }
    
    
    //MARK:-
    func DeleteDataInlocal()
    {
        var databasePath : String
        // print(arrdata);
        
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
            //for i in 0 ..< arrdata.count {
               // let  dict = arrdata[i] as! NSDictionary
            
            
            
            /*
             
             
             3. Gallary_Album_Photo_Data
             
             4. Past_President_List_Details
             
            5.  Club_NewsLetter_Details
             
             6. Club_Events_Details
             
             
             7. Board_Of_Directors_List
             
             8. District_Commitee_List
             
             9. Rotary_Library_Details
             
             10. WebLink_Details
             Find_A_Club_List
             District_Club_List
             Find_A_Rotarian_List
             
             GROUPMASTER_NEW
             MODULE_DATA_MASTER_NEW
             NewsUpdate_Table
             Dashboard_BirthAnniEvent_table
             
             DIRECTORY_DATA_MASTER
             
             SERVICE_DIRECTORY_DATA_MASTER
             GALLERY_MASTER
             
             ALBUM_PHOTO_MASTER
             
             tableCalendar
             ProfileMaster
             PersonalBusinessMemberDetails
             FamilyMemberDetail
             
             AddressDetails
             clubMember_Segment_List
             */
            
            
            //1.
                let insertSQL = "DELETE FROM GROUPMASTER"
                //print(insertSQL)
                
                let result = contactDB?.executeStatements(insertSQL)
                
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("success saved")
                    print(databasePath);
                }
            
            //2.
                let insertSQLr = "DELETE FROM MODULE_DATA_MASTER"
                print(insertSQLr)
                
                let resultr = contactDB?.executeStatements(insertSQLr)
                if (resultr == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    print("success saved")
                    print(databasePath);
                }
            
            //3.
            let insertSQL3 = "DELETE FROM Gallary_Album_Photo_Data"
            print(insertSQL3)
            
            let resultr3 = contactDB?.executeStatements(insertSQL3)
            if (resultr3 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //4.
            let insertSQL4 = "DELETE FROM Past_President_List_Details"
            print(insertSQL4)
            
            let resultr4 = contactDB?.executeStatements(insertSQL4)
            if (resultr4 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //5.
            
            let Club_NewsLetter_Details = "DELETE FROM Club_NewsLetter_Details"
            print(Club_NewsLetter_Details)
            
            let resultr5 = contactDB?.executeStatements(Club_NewsLetter_Details)
            if (resultr5 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }

            //6.
            let Club_Events_Details = "DELETE FROM Club_Events_Details"
            print(Club_Events_Details)
            
            let resultr6 = contactDB?.executeStatements(Club_Events_Details)
            if (resultr6 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //7.
            let Board_Of_Directors_List = "DELETE FROM Board_Of_Directors_List"
            print(Board_Of_Directors_List)
            
            let resultr7 = contactDB?.executeStatements(Board_Of_Directors_List)
            if (resultr7 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //8.
            let District_Commitee_List = "DELETE FROM District_Commitee_List"
            print(District_Commitee_List)
            
            let resultr8 = contactDB?.executeStatements(District_Commitee_List)
            if (resultr8 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //9.
            let Rotary_Library_Details = "DELETE FROM Rotary_Library_Details"
            print(Rotary_Library_Details)
            
            let resultr9 = contactDB?.executeStatements(Rotary_Library_Details)
            if (resultr9 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //10.
            let WebLink_Details = "DELETE FROM WebLink_Details"
            print(WebLink_Details)
            
            let resultr10 = contactDB?.executeStatements(WebLink_Details)
            if (resultr10 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            
            //11.
            let Find_A_Club_List = "DELETE FROM Find_A_Club_List"
            //print(insertSQL)
            
            let result11 = contactDB?.executeStatements(Find_A_Club_List)
            
            if (result11 == nil) {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            } else {
                print("success saved")
                print(databasePath);
            }
            
            //12.
            let District_Club_List = "DELETE FROM District_Club_List"
            print(District_Club_List)
            
            let resultr12 = contactDB?.executeStatements(District_Club_List)
            if (resultr12 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //13.
            let Find_A_Rotarian_List = "DELETE FROM Find_A_Rotarian_List"
            print(Find_A_Rotarian_List)
            
            let resultr13 = contactDB?.executeStatements(Find_A_Rotarian_List)
            if (resultr13 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //14.
            let GROUPMASTER_NEW = "DELETE FROM GROUPMASTER_NEW"
            print(GROUPMASTER_NEW)
            
            let resultr14 = contactDB?.executeStatements(GROUPMASTER_NEW)
            if (resultr14 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //15.
            
            let MODULE_DATA_MASTER_NEW = "DELETE FROM MODULE_DATA_MASTER_NEW"
            print(MODULE_DATA_MASTER_NEW)
            
            let resultr15 = contactDB?.executeStatements(MODULE_DATA_MASTER_NEW)
            if (resultr15 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //16.
            let NewsUpdate_Table = "DELETE FROM NewsUpdate_Table"
            print(NewsUpdate_Table)
            
            let resultr16 = contactDB?.executeStatements(NewsUpdate_Table)
            if (resultr16 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success delete NewsUpdate_Table from splash screen")
                print(databasePath);
            }
            
            //7.
            let Dashboard_BirthAnniEvent_table = "DELETE FROM Dashboard_BirthAnniEvent_table_New"
            print(Dashboard_BirthAnniEvent_table)
            
            let resultr17 = contactDB?.executeStatements(Dashboard_BirthAnniEvent_table)
            if (resultr17 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //18.
            let DIRECTORY_DATA_MASTER = "DELETE FROM DIRECTORY_DATA_MASTER"
            print(DIRECTORY_DATA_MASTER)
            
            let resultr18 = contactDB?.executeStatements(DIRECTORY_DATA_MASTER)
            if (resultr18 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //19.
            let SERVICE_DIRECTORY_DATA_MASTER = "DELETE FROM SERVICE_DIRECTORY_DATA_MASTER"
            print(SERVICE_DIRECTORY_DATA_MASTER)
            
            let resultr19 = contactDB?.executeStatements(SERVICE_DIRECTORY_DATA_MASTER)
            if (resultr19 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //20.
            let GALLERY_MASTER = "DELETE FROM GALLERY_MASTER"
            print(GALLERY_MASTER)
            
            let resultr20 = contactDB?.executeStatements(GALLERY_MASTER)
            if (resultr20 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //21.
            let ALBUM_PHOTO_MASTER = "DELETE FROM ALBUM_PHOTO_MASTER"
            
            let result21 = contactDB?.executeStatements(ALBUM_PHOTO_MASTER)
            
            if (result21 == nil) {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            } else {
                print("success saved")
                print(databasePath);
            }
            
            //12.
            let tableCalendar = "DELETE FROM tableCalendar"
            print(tableCalendar)
            
            let resultr22 = contactDB?.executeStatements(tableCalendar)
            if (resultr22 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //23.
            let ProfileMaster = "DELETE FROM ProfileMaster"
            print(ProfileMaster)
            
            let resultr23 = contactDB?.executeStatements(ProfileMaster)
            if (resultr23 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //24.
            let PersonalBusinessMemberDetails = "DELETE FROM PersonalBusinessMemberDetails"
            print(PersonalBusinessMemberDetails)
            
            let resultr24 = contactDB?.executeStatements(PersonalBusinessMemberDetails)
            if (resultr24 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //25.
            
            let FamilyMemberDetail = "DELETE FROM FamilyMemberDetail"
            print(FamilyMemberDetail)
            
            let resultr25 = contactDB?.executeStatements(FamilyMemberDetail)
            if (resultr25 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //26.
            let AddressDetails = "DELETE FROM AddressDetails"
            print(AddressDetails)
            
            let resultr26 = contactDB?.executeStatements(AddressDetails)
            if (resultr26 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }
            
            //27.
            let clubMember_Segment_List = "DELETE FROM clubMember_Segment_List"
            print(clubMember_Segment_List)
            
            let resultr27 = contactDB?.executeStatements(clubMember_Segment_List)
            if (resultr27 == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
            else
            {
                print("success saved")
                print(databasePath);
            }

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            //}
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        contactDB?.close()
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    /*
     {
           //  Util.copyFile("Calendar.sqlite")
             //clean user default
             
     //        var mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("masterUID")
     //        var updatedOn =  String ()
     //        let defaults = NSUserDefaults.standardUserDefaults()
     //        let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
     //        updatedOn = "1970-01-01 00:00:00"
     //        if let str = defaults.valueForKey(Updatedefault) as! String?
     //        {
     //            print(str)
     //            updatedOn = str
     //        }
     //        else
     //        {
     //            updatedOn = "1970-01-01 00:00:00"
     //        }
     //
             
              UserDefaults.standard.setValue(nil, forKey: "masterUID")
             /*
             ModelManager.getInstance()
             sharedInstance.database!.open()
             sharedInstance.database!.executeUpdate("DELETE FROM tableCalendarMonth", withArgumentsInArray:nil)
             sharedInstance.database!.close()
             */
            // DeleteDataInlocal ()
             if let storyboard = self.storyboard {
                 let MemberSegmentViewController = storyboard.instantiateViewController(withIdentifier: "mobile_login")
                 //instantiateViewController(withIdentifier: "MemberSegmentViewController")
                 MemberSegmentViewController.title = "Member"
                 let FamilySegmentViewController = storyboard.instantiateViewController(withIdentifier: "mobile_login") //FamilySegmentViewController
                 FamilySegmentViewController.title = "Family"
                 let segmentController = SJSegmentedViewController()
                 //segmentController.headerViewController = headerViewController
                 segmentController.segmentControllers = [MemberSegmentViewController,
                                                         FamilySegmentViewController]
                 segmentController.headerViewHeight = 0.0
                 navigationController?.pushViewController(segmentController, animated: true)
             }
             
             
             
     //         self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("mobile_login") as UIViewController, animated: true)
     //
     //        let defaults1 = NSUserDefaults.standardUserDefaults()
     //        defaults1.setObject("1", forKey: "splashOver")
     //        defaults1.synchronize()
         }
     */
    
    
    //Only for Member Login
    /*
     {
         
          UserDefaults.standard.setValue(nil, forKey: "masterUID")
         if let storyboard = self.storyboard {
             let viewController=storyboard.instantiateViewController(withIdentifier: "mobile_login") as! MobileLoginController
             self.navigationController?.pushViewController(viewController, animated: true)
         }
     }
     */
    
    //Login for both Member and family
    /*
         UserDefaults.standard.setValue(nil, forKey: "masterUID")
        /*
        ModelManager.getInstance()
        sharedInstance.database!.open()
        sharedInstance.database!.executeUpdate("DELETE FROM tableCalendarMonth", withArgumentsInArray:nil)
        sharedInstance.database!.close()
        */
       // DeleteDataInlocal ()
        if let storyboard = self.storyboard {
            let MemberSegmentViewController = storyboard.instantiateViewController(withIdentifier: "mobile_login")
            //instantiateViewController(withIdentifier: "MemberSegmentViewController")
            MemberSegmentViewController.title = "Member"
            let FamilySegmentViewController = storyboard.instantiateViewController(withIdentifier: "mobile_login") //FamilySegmentViewController
            FamilySegmentViewController.title = "Family"
            
            let segmentController = SJSegmentedViewController()
            //segmentController.headerViewController = headerViewController
            segmentController.segmentControllers = [MemberSegmentViewController,
                                                    FamilySegmentViewController]
            segmentController.headerViewHeight = 0.0
            navigationController?.pushViewController(segmentController, animated: true)
        }
     */
    
    @IBAction func continueAction(_ sender: AnyObject)
    {
          UserDefaults.standard.setValue(nil, forKey: "masterUID")
         /*
         ModelManager.getInstance()
         sharedInstance.database!.open()
         sharedInstance.database!.executeUpdate("DELETE FROM tableCalendarMonth", withArgumentsInArray:nil)
         sharedInstance.database!.close()
         */
        // DeleteDataInlocal ()
         if let storyboard = self.storyboard {
             let MemberSegmentViewController = storyboard.instantiateViewController(withIdentifier: "mobile_login")
             //instantiateViewController(withIdentifier: "MemberSegmentViewController")
             MemberSegmentViewController.title = "Member"
             let FamilySegmentViewController = storyboard.instantiateViewController(withIdentifier: "mobile_login") //FamilySegmentViewController
             FamilySegmentViewController.title = "Family"
             
             let segmentController = SJSegmentedViewController()
             //segmentController.headerViewController = headerViewController
             segmentController.segmentControllers = [MemberSegmentViewController,
                                                     FamilySegmentViewController]
             segmentController.headerViewHeight = 0.0
             segmentController.isFrom = false
             navigationController?.pushViewController(segmentController, animated: true)
         }
    }
    
    @IBAction func buttonExitClickEvent(_ sender: AnyObject)
    {
        exit(0)
    }
    
    @IBAction func buttonCloseTermsAndConditionViewClickEvent(_ sender: AnyObject) {
        buttonOpticity.isHidden = true
        viewForTermsAndConditions.isHidden = true
        
    }
    @IBAction func termsAndConditionAction(_ sender: AnyObject)
    {
//        let url = Bundle.main.url(forResource: "termscondition", withExtension:"html")
        let url = "https://rotaryindia.org/pdf/TERMS%20OF%20SERVICE%20(rotaryindia.org).pdf"
//        let urlReq = URL (string: url)
//        let requestObj = URLRequest(url: urlReq!);
//        print("url")
//        webViewInfo.load(requestObj)
        guard let url = URL(string: url) else { return }
        
           if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:]) { success in
                    if success {
                        print("The URL was successfully opened.")
                    } else {
                        print("Failed to open the URL.")
                    }
                }
            }
        buttonOpticity.isHidden = false
        viewForTermsAndConditions.isHidden = false
//        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("terms_conditions") as! TermsConditionsController
//        secondViewController.isCalledFrom="splash"
//
//        self.navigationController?.pushViewController(secondViewController, animated: true)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //continueButton.hidden = true
//        self.rotaryIndiaRewampRIZoneAPI()        
        webViewInfo.backgroundColor = UIColor.clear
        textviewTermsAndCondition.isHidden = true
        buttonOpticity.isHidden = true
        viewForTermsAndConditions.isHidden = true
        //var indexs:Int!=index+1
        //imageView.image = images[indexs]
        //animateImageView()
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
                                 self.loadHeaderLogo(headImg: self.headerImg)
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
                        self.imageView.image = image
                        print("IMAGE LOADED2")
                    } else {
                        // Handle the case where the image couldn't be downloaded
                        print("Failed to download image2")
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewControllerAtIndex(_ index: Int) -> PagingViewController
    {
        if ((self.pageImages.count == 0) || (index >= self.pageImages.count)) {
            return PagingViewController()
    }

        let vc: PagingViewController = (self.storyboard?.instantiateViewController(withIdentifier: "PagingViewController") as? PagingViewController)!

        vc.imageFile = self.pageImages[index] as! String
        vc.pageIndex = index
        
        return vc
        
        
    }
    
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        
        let vc = viewController as! PagingViewController
        var index = vc.pageIndex as Int
        
        
        print(index)
        
        //self.pageControl.currentPage = index
        
        if (index == 0 || index == NSNotFound)
        {
            return nil
            
        }
        
        if index < 3
        {
            
            
            continueButton.isHidden = true
            termsAndConditionButton.isHidden = false

        }
        
        index -= 1
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! PagingViewController
        var index = vc.pageIndex as Int
        
        print(index)
        
        if (index == NSNotFound)
        {
            return nil
        }
        
        if index == 3
        {
            continueButton.isHidden = false
            termsAndConditionButton.isHidden = false

        }
        
       // self.pageControl.currentPage = index
        
        index += 1
        
        if (index == self.pageImages.count)
        {
            return nil
        }
        
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        return self.pageImages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
    
    
    
    
    

}

