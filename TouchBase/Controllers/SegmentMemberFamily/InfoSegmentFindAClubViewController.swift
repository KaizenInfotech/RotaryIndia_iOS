
//
//  InfoSegmentFindAClubViewController.swift
//  TouchBase
//
//  Created by rajendra on 26/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//







import SVProgressHUD
import UIKit
import MessageUI
import MapKit
import SVProgressHUD
import Alamofire

struct Section2 {
    
    var name: String!
    var urlLink:[String]!
    var Heading:[String]!
    var MemberName: [String]!
    var mobileNumber: [String]!
    var collapsed: Bool!
    var email: [String]!
    
    
    init(name: String,urlLink:[String],Heading:[String],MemberName: [String],mobileNumber: [String],email: [String], collapsed: Bool = false) {
        
        self.name = name
        self.urlLink = urlLink
        self.Heading = Heading
        self.MemberName = MemberName
        self.mobileNumber = mobileNumber
        self.collapsed = collapsed
        self.email = email
        
        
        
    }
    
}


class InfoSegmentFindAClubViewController: UIViewController , UIScrollViewDelegate , MFMailComposeViewControllerDelegate , MFMessageComposeViewControllerDelegate,UITableViewDataSource,UITableViewDelegate
{
    
    @IBOutlet weak var tableClubDetails: UITableView!
    @IBOutlet weak var buttonGovernorCall: UIButton!
    @IBOutlet weak var buttonGovernorMail: UIButton!
    @IBOutlet weak var buttonGovernorMessage: UIButton!
    @IBOutlet weak var buttonSecretaryCall: UIButton!
    @IBOutlet weak var buttonSecreataryMail: UIButton!
    @IBOutlet weak var buttonSecretaryMessage: UIButton!
    @IBOutlet weak var buttonPresidentMessage: UIButton!
    
    @IBOutlet weak var lblHeadingPresident: UILabel!
    @IBOutlet weak var lblHeadingSecretary: UILabel!
    
    
    @IBOutlet weak var viewForUnderLineMeetingDayDown: UIView!
    @IBOutlet weak var lblHeadingAddressInfo: UILabel!
    
    
    @IBOutlet weak var lblHeadingMeetingDayTimeInfo: UILabel!
    
    var infoFrom = ""
    
    
    
    
    
    
    
    @IBOutlet weak var lblHeadingDistrictGov: UILabel!
    @IBOutlet weak var lblHeadingWebSiteForButton: UILabel!
    @IBOutlet weak var buttonPresidentMail: UIButton!
    @IBOutlet weak var buttonPresidentCall: UIButton!
//    @IBOutlet weak var viewUnderLine6: UIView!
    @IBOutlet weak var viewUnderLine5: UIView!
    @IBOutlet weak var viewUnderLine4: UIView!
    @IBOutlet weak var viewUnderLine3: UIView!
    @IBOutlet weak var viewUnderLine2: UIView!
    @IBOutlet weak var viewUnderLine1: UIView!
    @IBOutlet weak var buttonLink: UIButton!
    @IBOutlet weak var lblDistrictGovernorName: UILabel!
    @IBOutlet weak var lblSecretaryName: UILabel!
    @IBOutlet weak var lblPresidentName: UILabel!
    @IBOutlet weak var lblMeetingDayAndTime: UILabel!
    @IBOutlet weak var lblAddressClub: UILabel!
    @IBOutlet weak var lblDistrictID: UILabel!
    @IBOutlet weak var lblClubID: UILabel!
    @IBOutlet weak var lblClubName: UILabel!
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var lblAddressClubTwo: UILabel!
    @IBOutlet weak var lblMeetingDayAndTimeTwo: UILabel!
    @IBOutlet weak var viewForScrollWhenTwoAddress: UIView!
    
    @IBOutlet weak var buttonAddressLocation: UIButton!
    //261
    //420
    
    
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    
    
    var Latitute:String!=""
    var Longitude:String!=""
    var venueName:String!=""
    
    var sections = [Section2]()
    var stringEmailID=[String]()
    
    var varCallMessageEmail:String!=""
    
    //NAME
    var stringNamePresident=[String]()
    var stringNameSecretary=[String]()
    var stringNameDistrictGovernor=[String]()
    
    //HEADING - like President , Secretary , Governor ,website
    var stringHeading1=[String]()
    var stringHeading2=[String]()
    var stringHeading3=[String]()
    var stringHeading4=[String]()
    //Mobile Number
    var stringMobileNumberPresident=[String]()
    var stringMobileNumberSecretary=[String]()
    var stringMobileNumberGovernor=[String]()
    //Link
    var stringLinkUrl=[String]()
    
    
    var PhoneNumberSTR:String = ""
    var EmailSTR:String =  ""
    var varGetPresidentMobNo:String! = ""
    var varGetSecretaryMobNo:String! = ""
    var varGetGovernorMobNo:String! = ""
    
    var varGetPresidentMail:String!=""
    var varGetSecretaryMail:String!=""
    var varGetGovernorMail:String!=""
    
    
    
    
  //  let loaderClass  = WebserviceClass()
    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
    var appDelegate : AppDelegate = AppDelegate()
//    var muarrayGetClubAddresses:NSMutableArray=NSMutableArray()
    var varAuthorizationToken:String! = ""
    var ClubID:String! = ""
    var ClubType:String! = ""
    var Website:String! = ""
    var DistrictID:String! = ""
    var ViewOriginalDefaultValue:CGFloat = 0.0
    var varClubName:String! = ""
    var moduleName:String! = ""
    var varGroupID:String! = ""
    var meetingDayAndTime:String! = ""
    var address:String! = ""
    
    
    
    var muarrayKey:NSMutableArray = NSMutableArray()
    var muarrayKeyValue:NSMutableArray = NSMutableArray()
    var muarrayMobileNumber:NSMutableArray = NSMutableArray()
    var muarrayMailID:NSMutableArray = NSMutableArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        stringHeading1 = ["President","President"]
        //        stringHeading1 = ["Secretary","Secretary"]
        //        stringHeading1 = ["District Governor","District Governor"]
        ViewOriginalDefaultValue  = self.viewForScrollWhenTwoAddress.frame.origin.y
        varAuthorizationToken = UserDefaults.standard.value(forKey: "Session_AutorizationToken") as? String
        ClubType = UserDefaults.standard.value(forKey: "Session_Club_TYPE") as? String
        ClubID = UserDefaults.standard.value(forKey: "Session_Club_ID") as? String
        Website = UserDefaults.standard.value(forKey: "Session_Website") as? String
        DistrictID =  UserDefaults.standard.value(forKey: "Session_District_ID") as? String
        varClubName = UserDefaults.standard.value(forKey: "Session_ClubName") as? String
        varGroupID = UserDefaults.standard.value(forKey: "GrpID") as? String
        meetingDayAndTime = UserDefaults.standard.value(forKey: "varCharterDate") as? String
        address = UserDefaults.standard.value(forKey: "addressClub") as? String
        print(ViewOriginalDefaultValue)
        print(varAuthorizationToken)
        print(ClubType)
        print(ClubID)
        print(Website)
        print(DistrictID)
        print(varClubName)
        print(varGroupID)
        
        self.lblHeadingAddressInfo.isHidden=false
//        self.lblHeadingMeetingDayTimeInfo.isHidden=false
        self.buttonAddressLocation.isHidden=false
        self.viewForUnderLineMeetingDayDown.isHidden=false
        
        
        lblClubID.text = ClubID
        lblClubName.text = varClubName
//        lblDistrictID.text = DistrictID
//        lblMeetingDayAndTime.text = meetingDayAndTime
//        lblHeadingWebSiteForButton.text = Website
//        lblClubID.text = ""
//        lblClubName.text = ""
//        lblDistrictID.text = ""
        //buttonLink.setTitle(Website, forState: .Normal)
        funcForScrollView()
        functionForSearchFindAclubTestPurpose()
        // GetCulbSearchDetails(ClubID, ClubType: ClubType)
        // GetOfficerDetails(ClubID, ClubType: ClubType)
        
        
        
        //Session_AddressesValueInArray
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func funcForScrollView()
    {
        myScrollView.delegate = self
        myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1100)
    }
    
    
    @IBAction func buttonMessageDistrictGovernorClickEvent(_ sender: AnyObject) {
    }
    @IBAction func buttonCallDistrictGovernorClickEvent(_ sender: AnyObject) {
    }
    
    @IBAction func buttonMailDistrictGovernorClickEvent(_ sender: AnyObject) {
        
        EmailSTR = varGetGovernorMail
        MailAction()
    }
    
    
    @IBAction func buttonMessageSecretaryClickEvent(_ sender: AnyObject) {
        PhoneNumberSTR = varGetSecretaryMobNo
        SMSAction()
    }
    @IBAction func buttonCallSecretaryClickEvent(_ sender: AnyObject) {
        PhoneNumberSTR = varGetSecretaryMobNo
        PhoneCallAction()
    }
    
    @IBAction func buttonMailSecretaryClickEvent(_ sender: AnyObject) {
        EmailSTR = varGetSecretaryMail
        MailAction()
    }
    
    @IBAction func buttonCallPresidentClickEvent(_ sender: AnyObject)
        
    {
        PhoneNumberSTR = varGetPresidentMobNo
        PhoneCallAction()
    }
    
    @IBAction func buttonMessagePresidentClickEvent(_ sender: AnyObject)
    {
        PhoneNumberSTR = varGetPresidentMobNo
        SMSAction()
    }
    @IBAction func buttonMailPresidentClickEvent(_ sender: AnyObject)
    {
        EmailSTR = varGetPresidentMail
        MailAction()
    }
    
    
    @IBAction func buttonAddressLocationClickEvent(_ sender: AnyObject) {
        print(Longitude)
        print(Latitute)
        openMapForPlace()
        
    }
    
    /************************Location Show with address**********************Code by DPK************************************/
    func openMapForPlace() {
        
        let lat1 : NSString = self.Latitute as! NSString
        let lng1 : NSString = self.Longitude as! NSString
        
        let latitude:CLLocationDegrees =  lat1.doubleValue
        let longitude:CLLocationDegrees =  lng1.doubleValue
        if(self.Latitute.count>0 && self.Longitude.count>0)
        {
            //Working in Swift new versions.
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
            {
//                UIApplication.shared.openURL(NSURL(string:
//                    "comgooglemaps://?saddr=&daddr=\(Float(Latitute!)!),\(Float(Longitude!)!)&directionsmode=driving")! as URL)
                
                if UIApplication.shared.canOpenURL(NSURL(string:
                                                            "comgooglemaps://?saddr=&daddr=\(Float(Latitute!)!),\(Float(Longitude!)!)&directionsmode=driving")! as URL) {
                    UIApplication.shared.open(NSURL(string:
                                                        "comgooglemaps://?saddr=&daddr=\(Float(Latitute!)!),\(Float(Longitude!)!)&directionsmode=driving")! as URL, options: [:]) { success in
                            if success {
                                print("The URL was successfully opened.")
                            } else {
                                print("Failed to open the URL.")
                            }
                        }
                    }

                
            } else
            {
                let directionsURL = "http://maps.apple.com/?saddr=&daddr=\(Float(Latitute!)!),\(Float(Longitude!)!)"
                guard let url = URL(string: directionsURL) else {
                    return
                }
                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    
                    if UIApplication.shared.canOpenURL(url as URL) {
                        UIApplication.shared.open(url as URL, options: [:]) { success in
                                if success {
                                    print("The URL was successfully opened.")
                                } else {
                                    print("Failed to open the URL.")
                                }
                            }
                        }

                } else {
//                    UIApplication.shared.openURL(url)
                    
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
                
                NSLog("Can't use com.google.maps://");
            }
        }
            
        else
        {
            ///////-----------------------------------------------------------
            guard let address = self.lblAddressClub.text else { return  }
            print("your address\(address)")
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
                if((error) != nil){
                    print("This is Error:------>")
                    self.view.makeToast("Address is not valid", duration: 3, position: CSToastPositionCenter)
                    if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
                    {
//                        UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\("InvaidAddress"),\("InvaidAddress")&directionsmode=driving")!)
                        
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
//                            UIApplication.shared.openURL(NSURL(string:
//                                "comgooglemaps://?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))&directionsmode=driving")! as URL)
                            
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
//                                UIApplication.shared.openURL(url)
                                
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
    }
    /****************************Location Show with address*************************Code by DPK*****************************/
    
    
    
    
    
    
    @IBAction func buttonLinkClickEvent(_ sender: AnyObject)
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            let objWebViewToUrlOpenViewControllr = self.storyboard?.instantiateViewController(withIdentifier: "WebViewToUrlOpenViewController") as! WebViewToUrlOpenViewController
            objWebViewToUrlOpenViewControllr.URLstr = buttonLink.titleLabel?.text!
            objWebViewToUrlOpenViewControllr.moduleName = "Find a Club"
            self.navigationController?.pushViewController(objWebViewToUrlOpenViewControllr, animated: true)
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
    }
    
    
    
    //MARK:- Call Action
    func PhoneCallAction()
    {
        PhoneNumberSTR = PhoneNumberSTR.replacingOccurrences(of: " ", with: "")
        print("calling\(PhoneNumberSTR)")
        
        
//        let url = URL(string: "tel://\(PhoneNumberSTR)")
//        UIApplication.shared.openURL(url!)
        if let url = URL(string: "tel://\(PhoneNumberSTR)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Unable to make a call. Invalid phone number or URL.")
        }
        /*
         if PhoneNumberSTR.count > 1
         {
         let alertView:UIAlertView = UIAlertView()
         alertView.title = "Rotary India"
         alertView.message = String(format:"Do you want to make call with %@",PhoneNumberSTR)
         alertView.delegate = self
         alertView.tag = 1
         alertView.addButtonWithTitle("No")
         alertView.addButtonWithTitle("Yes")
         alertView.show()
         }
         */
    }
    
    func alertView(_ View: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(View.tag == 1)
        {
            switch buttonIndex{
                
            case 1:
                
//                let url = URL(string: "tel://\(PhoneNumberSTR)")
//                UIApplication.shared.openURL(url!)
                
                if let url = URL(string: "tel://\(PhoneNumberSTR)"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    print("Unable to make a call. Invalid phone number or URL.")
                }
                
                break;
            case 0:
                
                //mobileNumberField.becomeFirstResponder()
                
                break;
            default:
                NSLog("Default");
                break;
            }
        }
        else
        {
        }
    }
    
    //MARK:- Message Action
    func SMSAction()
    {
        //PhoneNumberSTR = ""
        print("SMS sent")
        let messageVC = MFMessageComposeViewController()
        messageVC.body = ""
        messageVC.recipients = [PhoneNumberSTR] // Optionally add some tel numbers
        messageVC.messageComposeDelegate = self
        // Open the SMS View controller
        present(messageVC, animated: true, completion: nil)
    }
    
    //MARK:- Mail Action
    func MailAction()
    {
        //EmailSTR = ""
        print("Email Sent")
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([EmailSTR])      // gg@hing.co.in
            mail.setMessageBody("", isHTML: true)
            
            present(mail, animated: true, completion: nil)
        } else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Rotary India"
            alertView.message = "Please check whether you have logged in to your mail account."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()

        }
        
        
        //
        //        let mailComposerVC = MFMailComposeViewController()
        //        mailComposerVC.mailComposeDelegate = self
        //        mailComposerVC.setToRecipients([EmailSTR])
        //        mailComposerVC.setSubject("")
        //        mailComposerVC.setMessageBody("", isHTML: false)
        //        self.presentViewController(mailComposerVC, animated: true, completion: nil)
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        /*
         switch result.rawValue {
         case MessageComposeResultCancelled.rawValue :
         print("message canceled")
         
         case MessageComposeResultFailed.rawValue :
         print("message failed")
         
         case MessageComposeResultSent.rawValue :0
         print("message sent")
         
         default:
         break
         }
         */
        controller.dismiss(animated: true, completion: nil)
    }
    
    func GetCulbSearchDetails(_ ClubID:String , ClubType:String)
    {
        //self.loaderClass.loaderViewMethod()
        var varGetTempValue:String! = ""
        // var varGetClubType:String!="clubType="
        // var varGetClubId:String!=""
        
        
        var getValidUrl="https://apiuat.rotary.org:8443/v1.1/clubs/"+ClubType+"/"+ClubID+"/addresses"
        let urlwithPercentEscapes = getValidUrl.addingPercentEncoding( withAllowedCharacters: CharacterSet.urlFragmentAllowed)
        print(urlwithPercentEscapes as Any)
        
        
        let headers = ["auth_token" :varAuthorizationToken!]
        
        
        ////---
        guard let urlString = urlwithPercentEscapes, let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
//        Alamofire.request(url, method: .get, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
//            response in
//            switch response.result
//            {
//            case .success:
//                print(response)
//                if response.result.value != nil
//                {
//                    if response.result.value != nil
//                    {
//                        if let status = response.response?.statusCode {
//                            switch(status)
//                            {
//                            case 200:
//                                print("example success")
//                                
//                                var dictResponseData:NSArray=NSArray()
//                                dictResponseData = response.result.value as! NSArray
//                                print(dictResponseData)
//                                print(dictResponseData.count)
//                                var AddressLineFIRST :String! = ""
//                                var AddressLineSECOND :String! = ""
//                                for i in 0..<(dictResponseData.value(forKey: "ClubId") as AnyObject).count
//                                {
//                                    
//                                    if(i == 0)
//                                    {
//                                        //self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
//                                        //let ClubType=((dictResponseData.value(forKey: "ClubType") as AnyObject).object(i)) as! String
//                                       // print(ClubType)
//                                        
//                                         let ClubType=((dictResponseData as AnyObject).object(forKey: "ClubType")as AnyObject).object(at: i) as? String
//                                        let ClubId=((dictResponseData as AnyObject).object(forKey: "ClubId")as AnyObject).object(at: i) as? String
//
//                                        
//                                        let AddressLine1=((dictResponseData as AnyObject).object(forKey: "AddressLine1")as AnyObject).object(at: i) as? String
//                                        let AddressLine2=((dictResponseData as AnyObject).object(forKey: "AddressLine2")as AnyObject).object(at: i) as? String
//                                        let AddressLine3=((dictResponseData as AnyObject).object(forKey: "AddressLine3")as AnyObject).object(at: i) as? String
//
//                                    
//                                        
//                                        let PostalCode=((dictResponseData as AnyObject).object(forKey: "PostalCode")as AnyObject).object(at: i) as? String
//                                        let MeetingDay=((dictResponseData as AnyObject).object(forKey: "MeetingDay")as AnyObject).object(at: i) as? String
//                                        let MeetingTime=((dictResponseData as AnyObject).object(forKey: "MeetingTime")as AnyObject).object(at: i) as! String
//                                        
//                                        
//                                        
//                                        if((MeetingDay ) == nil || MeetingTime==nil || MeetingTime.count<=0)
//                                        {
//                                            self.lblMeetingDayAndTime.text = "NA"
//                                        }
//                                        else
//                                        {
//                                            self.lblMeetingDayAndTime.text = (MeetingDay ?? "")+" | "+MeetingTime
//                                        }
//                                        
//                                        AddressLineFIRST = AddressLine1+", "+AddressLine2+", "+AddressLine3+", "+PostalCode
//                                        print("your address line\(String(describing: AddressLineFIRST))")
//                                        self.lblAddressClub.text = AddressLineFIRST
//                                        self.lblPresidentName.text = "NA"
//                                        self.lblSecretaryName.text = "NA"
//                                        self.lblDistrictGovernorName.text = "NA"
//                                        
//                                        self.viewForScrollWhenTwoAddress.frame =  CGRect(x:self.viewForScrollWhenTwoAddress.frame.origin.x, y:self.ViewOriginalDefaultValue, width:self.myScrollView.frame.size.width, height:self.viewForScrollWhenTwoAddress.frame.size.height + 100)
//                                    }
//                                    if(i == 1)
//                                    {
//                                        //self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
//                                       
//                                        
//                                        let ClubType=((dictResponseData as AnyObject).object(forKey: "ClubType")as AnyObject).object(at: i) as? String
//                                        let ClubId=((dictResponseData as AnyObject).object(forKey: "ClubId")as AnyObject).object(at: i) as? String
//                                        let AddressLine1=((dictResponseData as AnyObject).object(forKey: "AddressLine1")as AnyObject).object(at: i) as? String
//
//                                        
//                                        let AddressLine2=((dictResponseData as AnyObject).object(forKey: "AddressLine2")as AnyObject).object(at: i) as? String
//                                        let AddressLine3=((dictResponseData as AnyObject).object(forKey: "AddressLine3")as AnyObject).object(at: i) as? String
//                                        let PostalCode=((dictResponseData as AnyObject).object(forKey: "PostalCode")as AnyObject).object(at: i) as? String
//
//                                        let MeetingDay=((dictResponseData as AnyObject).object(forKey: "MeetingDay")as AnyObject).object(at: i) as? String
//                                        let MeetingTime=((dictResponseData as AnyObject).object(forKey: "MeetingTime")as AnyObject).object(at: i) as? String
//
//                                    
//                                      
//                                        
//                                        if(MeetingDay==nil || MeetingTime==nil || MeetingTime.count<=0)
//                                        {
//                                            self.lblMeetingDayAndTimeTwo.text = "NA"
//                                        }
//                                        else
//                                        {
//                                            self.lblMeetingDayAndTimeTwo.text = MeetingDay+" | "+MeetingTime
//                                        }
//                                        
//                                        
//                                        AddressLineSECOND = AddressLine1+", "+AddressLine2+", "+AddressLine3+", "+PostalCode
//                                        print(AddressLineSECOND)
//                                        self.lblAddressClubTwo.text! = AddressLineSECOND
//                                        
//                                        self.viewForScrollWhenTwoAddress.frame =  CGRect(x:self.viewForScrollWhenTwoAddress.frame.origin.x, y:self.viewForScrollWhenTwoAddress.frame.origin.y+160, width:self.myScrollView.frame.size.width, height:self.viewForScrollWhenTwoAddress.frame.size.height + 100)
//                                        
//                                        
//                                        
//                                        //CGRect(x: 0, y: 0, width: 100, height: 100)
//                                        
//                                    }
//                                    
//                                    self.window = nil
//                                }
//                            default:
//                                var dictResponseDataA:NSDictionary=NSDictionary()
//                                dictResponseDataA = response.result.value as! NSDictionary
//                                varGetTempValue = (dictResponseDataA.object(forKey: "Message"))as? String
//                                print(varGetTempValue)
//                                self.lblPresidentName.text = "NA"
//                                self.lblSecretaryName.text = "NA"
//                                self.lblDistrictGovernorName.text = "NA"
//                                self.lblAddressClub.text = "NA"
//                                self.lblMeetingDayAndTime.text = "NA"
//                                print("error with response status: \(status)")
//                                self.window = nil
//                                self.view.makeToast(varGetTempValue!, duration: 3, position: CSToastPositionCenter)
//                                
//                                
//                            }
//                        }
//                    }
//                }
//                break
//            case .failure(let error):
//                print(error)
//            }
//        }
        ////---
        

        
        /*
        Alamofire.request(.GET,urlwithPercentEscapes!, parameters: nil, encoding: .JSON, headers:headers).responseJSON { response in
            if response.result.value != nil
            {
                
                
                if let status = response.response?.statusCode {
                    switch(status)
                    {
                    case 200:
                        print("example success")
                        
                        var dictResponseData:NSArray=NSArray()
                        dictResponseData = response.result.value as! NSArray
                        print(dictResponseData)
                        print(dictResponseData.count)
                        var AddressLineFIRST :String! = ""
                        var AddressLineSECOND :String! = ""
                        for i in 0..<dictResponseData.valueForKey("ClubId").count
                        {
                            
                            if(i == 0)
                            {
                                //self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                                let ClubType=(dictResponseData.valueForKey("ClubType").objectAtIndex(i)) as! String
                                print(ClubType)
                                let ClubId=(dictResponseData.valueForKey("ClubId").objectAtIndex(i)) as! Int
                                print(ClubId)
                                let AddressLine1=(dictResponseData.valueForKey("AddressLine1").objectAtIndex(i)) as? String
                                print(AddressLine1)
                                let AddressLine2=(dictResponseData.valueForKey("AddressLine2").objectAtIndex(i)) as? String
                                print(AddressLine2)
                                let AddressLine3=(dictResponseData.valueForKey("AddressLine3").objectAtIndex(i)) as? String
                                print(AddressLine3)
                                let PostalCode=(dictResponseData.valueForKey("PostalCode").objectAtIndex(i)) as? String
                                print(PostalCode)
                                
                                let MeetingDay=(dictResponseData.valueForKey("MeetingDay").objectAtIndex(i)) as? String
                                print(MeetingDay)
                                let MeetingTime=(dictResponseData.valueForKey("MeetingTime").objectAtIndex(i)) as? String
                                print(MeetingTime)
                                
                                if(MeetingDay==nil || MeetingTime==nil || MeetingTime?.count<=0)
                                {
                                    self.lblMeetingDayAndTime.text! = "NA"
                                }
                                else
                                {
                                    self.lblMeetingDayAndTime.text! = MeetingDay!+" | "+MeetingTime!
                                }
                                
                                AddressLineFIRST = AddressLine1!+", "+AddressLine2!+", "+AddressLine3!+", "+PostalCode!
                                print(AddressLineFIRST)
                                self.lblAddressClub.text! = AddressLineFIRST
                                self.lblPresidentName.text! = "NA"
                                self.lblSecretaryName.text! = "NA"
                                self.lblDistrictGovernorName.text! = "NA"
                                
                                self.viewForScrollWhenTwoAddress.frame =  CGRectMake(self.viewForScrollWhenTwoAddress.frame.origin.x, self.ViewOriginalDefaultValue, self.myScrollView.frame.size.width, self.viewForScrollWhenTwoAddress.frame.size.height)
                            }
                            if(i == 1)
                            {
                                //self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                                let ClubType=(dictResponseData.valueForKey("ClubType").objectAtIndex(i)) as! String
                                print(ClubType)
                                let ClubId=(dictResponseData.valueForKey("ClubId").objectAtIndex(i)) as! Int
                                print(ClubId)
                                let AddressLine1=(dictResponseData.valueForKey("AddressLine1").objectAtIndex(i)) as? String
                                print(AddressLine1)
                                let AddressLine2=(dictResponseData.valueForKey("AddressLine2").objectAtIndex(i)) as? String
                                print(AddressLine2)
                                let AddressLine3=(dictResponseData.valueForKey("AddressLine3").objectAtIndex(i)) as? String
                                print(AddressLine3)
                                let PostalCode=(dictResponseData.valueForKey("PostalCode").objectAtIndex(i)) as? String
                                print(PostalCode)
                                let MeetingDay=(dictResponseData.valueForKey("MeetingDay").objectAtIndex(i)) as? String
                                print(MeetingDay)
                                let MeetingTime=(dictResponseData.valueForKey("MeetingTime").objectAtIndex(i)) as? String
                                print(MeetingTime)
                                
                                if(MeetingDay==nil || MeetingTime==nil || MeetingTime?.count<=0)
                                {
                                    self.lblMeetingDayAndTimeTwo.text! = "NA"
                                }
                                else
                                {
                                    self.lblMeetingDayAndTimeTwo.text! = MeetingDay!+" | "+MeetingTime!
                                }
                                
                                
                                AddressLineSECOND = AddressLine1!+", "+AddressLine2!+", "+AddressLine3!+", "+PostalCode!
                                print(AddressLineSECOND)
                                self.lblAddressClubTwo.text! = AddressLineSECOND
                                
                                self.viewForScrollWhenTwoAddress.frame =  CGRectMake(self.viewForScrollWhenTwoAddress.frame.origin.x, self.viewForScrollWhenTwoAddress.frame.origin.y+160, self.myScrollView.frame.size.width, self.viewForScrollWhenTwoAddress.frame.size.height)
                            }
                            
                            self.loaderClass.window = nil
                        }
                    default:
                        var dictResponseDataA:NSDictionary=NSDictionary()
                        dictResponseDataA = response.result.value as! NSDictionary
                        varGetTempValue = (dictResponseDataA.objectForKey("Message"))as? String
                        print(varGetTempValue)
                        self.lblPresidentName.text! = "NA"
                        self.lblSecretaryName.text! = "NA"
                        self.lblDistrictGovernorName.text! = "NA"
                        self.lblAddressClub.text! = "NA"
                        self.lblMeetingDayAndTime.text! = "NA"
                        print("error with response status: \(status)")
                        self.loaderClass.window = nil
                        self.view.makeToast(varGetTempValue!, duration: 3, position: CSToastPositionCenter)
                        
                        
                    }
                }
            }
            else
            {
                
                print("response.result.value != nil ")
            }
        }
        */
        
    }
    
    
    func GetOfficerDetails(_ ClubID:String , ClubType:String)
    {
        var varGetTempValue:String! = ""
        // var varGetClubType:String!="clubType="
        // var varGetClubId:String!=""
        
        
        let getValidUrl="https://apiuat.rotary.org:8443/v1.1/clubs/"+ClubType+"/"+ClubID+"/officers/current"
        let urlwithPercentEscapes = getValidUrl.addingPercentEncoding( withAllowedCharacters: CharacterSet.urlFragmentAllowed)
        print(urlwithPercentEscapes)
        
        
        let headers = ["auth_token" :varAuthorizationToken!]
        
        
       Alamofire.request(urlwithPercentEscapes!, method: .post, parameters: nil,encoding: JSONEncoding.default, headers: headers).responseJSON {
                response in
                switch response.result
                {
                case .success:
                    print(response)
                    if response.result.value != nil
                    {
                        
                        
                        if let status = response.response?.statusCode {
                            switch(status)
                            {
                            case 200:
                                print("example success")
                                
                                var dictResponseData:NSArray=NSArray()
                                dictResponseData = response.result.value as! NSArray
                                print(dictResponseData)
                                print(dictResponseData.count)
                                var AddressLineFIRST :String! = ""
                                var AddressLineSECOND :String! = ""
                                for i in 0..<(dictResponseData.value(forKey: "ClubId") as AnyObject).count
                                {
                                    
                                    if(i == 0)
                                    {
                                        //self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                                        
                                        
                                        
                                        var ClubType = ((dictResponseData as AnyObject).object(forKey: "ClubType")as AnyObject).object(at: i)as! String
                                        var ClubId = ((dictResponseData as AnyObject).object(forKey: "ClubId")as AnyObject).object(at: i)as! String
                                        var AddressLine1 = ((dictResponseData as AnyObject).object(forKey: "AddressLine1")as AnyObject).object(at: i)as! String

                                        
                                        var AddressLine2 = ((dictResponseData as AnyObject).object(forKey: "AddressLine2")as AnyObject).object(at: i)as! String
                                        var AddressLine3 = ((dictResponseData as AnyObject).object(forKey: "AddressLine3")as AnyObject).object(at: i)as! String
                                        var PostalCode = ((dictResponseData as AnyObject).object(forKey: "PostalCode")as AnyObject).object(at: i)as! String
                                        var MeetingDay = ((dictResponseData as AnyObject).object(forKey: "MeetingDay")as AnyObject).object(at: i)as! String
                                        var MeetingTime = ((dictResponseData as AnyObject).object(forKey: "MeetingTime")as AnyObject).object(at: i)as! String

                                        if(MeetingDay==nil || MeetingTime==nil || MeetingTime.count<=0)
                                        {
                                            self.lblMeetingDayAndTime.text! = "NA"
                                        }
                                        else
                                        {
                                            self.lblMeetingDayAndTime.text! = MeetingDay+" | "+MeetingTime
                                        }
                                        
                                        AddressLineFIRST = AddressLine1+","+AddressLine2+","+AddressLine3+","+PostalCode
                                        print(AddressLineFIRST)
                                        self.lblAddressClub.text = AddressLineFIRST
                                        self.lblPresidentName.text = "NA"
                                        self.lblSecretaryName.text = "NA"
                                        self.lblDistrictGovernorName.text = "NA"
                                        
                                        self.viewForScrollWhenTwoAddress.frame =  CGRect(x:self.viewForScrollWhenTwoAddress.frame.origin.x, y:self.ViewOriginalDefaultValue, width:self.myScrollView.frame.size.width, height:self.viewForScrollWhenTwoAddress.frame.size.height + 100)
                                    }
                                    if(i == 1)
                                    {
                                        //self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                                        
                                        
                                        var ClubType = ((dictResponseData as AnyObject).object(forKey: "ClubType")as AnyObject).object(at: i)as! String
                                        var ClubId = ((dictResponseData as AnyObject).object(forKey: "ClubId")as AnyObject).object(at: i)as! String
                                        var AddressLine1 = ((dictResponseData as AnyObject).object(forKey: "AddressLine1")as AnyObject).object(at: i)as! String
                                        
                                        var AddressLine2 = ((dictResponseData as AnyObject).object(forKey: "AddressLine2")as AnyObject).object(at: i)as! String
                                        var AddressLine3 = ((dictResponseData as AnyObject).object(forKey: "AddressLine3")as AnyObject).object(at: i)as! String
                                        var PostalCode = ((dictResponseData as AnyObject).object(forKey: "PostalCode")as AnyObject).object(at: i)as! String

                                        var MeetingDay = ((dictResponseData as AnyObject).object(forKey: "MeetingDay")as AnyObject).object(at: i)as! String
                                        var MeetingTime = ((dictResponseData as AnyObject).object(forKey: "MeetingTime")as AnyObject).object(at: i)as! String
                                        
                                        if(MeetingDay==nil || MeetingTime==nil || MeetingTime.count<=0)
                                        {
                                            self.lblMeetingDayAndTimeTwo.text = "NA"
                                        }
                                        else
                                        {
                                            self.lblMeetingDayAndTimeTwo.text = MeetingDay+" | "+MeetingTime
                                        }
                                        
                                        AddressLineSECOND = AddressLine1+","+AddressLine2+","+AddressLine3+","+PostalCode
                                        print(AddressLineSECOND)
                                        self.lblAddressClubTwo.text! = AddressLineSECOND
                                        
                                        self.viewForScrollWhenTwoAddress.frame =  CGRect(x:self.viewForScrollWhenTwoAddress.frame.origin.x, y:self.viewForScrollWhenTwoAddress.frame.origin.y+160, width:self.myScrollView.frame.size.width, height:self.viewForScrollWhenTwoAddress.frame.size.height + 100)
                                    }
                                }
                            default:
                                var dictResponseDataA:NSDictionary=NSDictionary()
                                dictResponseDataA = response.result.value as! NSDictionary
                                varGetTempValue = (dictResponseDataA.object(forKey: "Message"))as? String
                                print(varGetTempValue)
                                
                                print("error with response status: \(status)")
                            }
                        }
                    }
                    break
                case .failure(let error):
                    print(error)
                }
        
            }
        
        
        /*
        Alamofire.request(.POST,urlwithPercentEscapes!, parameters: nil, encoding: .JSON, headers:headers).responseJSON { response in
        
            else
            {
                print("response.result.value != nil ")
            }
        }
        */
        
        
    }
    func convertToShowFormatDate(dateString: String) -> String {
        
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = "MM/dd/yyyy" //Your date format
        
        let serverDate: Date = dateFormatterDate.date(from: dateString)! //according to date format your date string
        
        let dateFormatterString = DateFormatter()
        dateFormatterString.dateFormat = "dd MMM yyyy" //Your New Date format as per requirement change it own
        let newDate: String = dateFormatterString.string(from: serverDate) //pass Date here
        print(newDate) // New formatted Date string
        
        return newDate
    }
    
    
    //MARK:- SERVER CALLING
    /*----------------------------------------------------------------------------*/
    func functionForSearchFindAclubTestPurpose()
    {
        //loaderViewMethod()
        //  if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        //{
        //Change by shubhs

        var ClubID11:String! = ""
        ClubID11 = UserDefaults.standard.value(forKey: "Session_Club_ID") as? String
print(ClubID11)
        var completeURL = ""
        var parameterst:NSDictionary=NSDictionary()
        
        if infoFrom == "District Clubs" {
            completeURL = baseUrl+row_GetDistrictClubDetails
            parameterst = ["grpId" : varGroupID]
        } else {
            completeURL = baseUrl+row_GetClubDetails
            parameterst = ["grpId" : varGroupID]
        }
        
        
//        parameterst = ["grpId" : "31377"]
        print("Info find a club completeURL:: \(completeURL)")
        print("Info find a club parameterst:: \(parameterst)")

        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable : Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: { [self](response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("dd \(dd)")
            let varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            if((dd.object(forKey: "TBGetClubDetailResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let subdicttt=(dd.object(forKey: "TBGetClubDetailResult")! as AnyObject).object(forKey: "ClubDetailResult") as! NSDictionary
                print(subdicttt)
                var varClubWebSiteLink = ""
                var varClubLang = ""
                var clubContact = ""
                var clubEmail = ""
                var strdate = ""
                let mainDict = (subdicttt.object(forKey: "Table")! as AnyObject).object(at: 0)
                print("mainDict::  \(mainDict)")
                if ((subdicttt.object(forKey: "Table")! as AnyObject).count > 0) {
                    let mainCount = (subdicttt.object(forKey: "Table")! as AnyObject).count
                    print("mainCount: \(mainCount)")
                    //                if(mainCount!) > 0{
                    let mainDict = (subdicttt.object(forKey: "Table")! as AnyObject).object(at: 0)
                    let varGrpID=""
                    print(varGrpID)
                    let varClubId=""
                    print(varClubId)
                    let varClubName=""
                    print(varClubName)
                    //                    let varCity=""
                    //                     print(varCity)
                    //                    let varState=""
                    //                     print(varState)
                    let varCountry=""
                    print(varCountry)
                    //                     let pinnnnnn=""
                    print(varClubWebSiteLink)
                    clubEmail=(mainDict as AnyObject).object(forKey: "club_Email") as? String ?? ""
                    print(clubEmail ?? "")
                    //                     let clubContact=""
                    //                    print(clubContact)
                    //                    let varGrpID=(mainDict as AnyObject).object(forKey: "ClubId")!
                    //                    print(varGrpID)
                    //                    let varClubId=(mainDict as AnyObject).object(forKey: "District")!
                    //                    print(varClubId)
                    //                    let varClubName=(mainDict as AnyObject).object(forKey: "clubName")!
                    //                    print(varClubName)
                    let varAddress=(mainDict as AnyObject).object(forKey: "address")
                    print(varAddress ?? "")
                    let varCity=(mainDict as AnyObject).object(forKey: "city")
                    print(varCity ?? "")
                    let varState=(mainDict as AnyObject).object(forKey: "state")
                    print(varState ?? "")
                    //                    let varCountry=(mainDict as AnyObject).object(forKey: "country")
                    //                    print(varCountry ?? "")
                    let pinnnnnn=(mainDict as AnyObject).object(forKey: "address_PostalCode")!
                    varClubWebSiteLink=(mainDict as AnyObject).object(forKey: "clubWebsite") as? String ?? ""
                                        print(varClubWebSiteLink)
                    varClubLang=(mainDict as AnyObject).object(forKey: "ClubLanguage") as? String ?? ""
                    clubContact=(mainDict as AnyObject).object(forKey: "PhoneNumber") as? String ?? ""
                    print(clubContact ?? "")
                    //                    let clubEmail=(mainDict as AnyObject).object(forKey: "club_Email")!
                    //                    print(clubEmail)
                    
                    print("CHARTERDATE ::\((mainDict as AnyObject).object(forKey: "CharterDate") as? String ?? "")")
                    strdate = (mainDict as AnyObject).object(forKey: "CharterDate") as? String ?? ""
                                    print("strdate :: \(strdate)")
                                        if strdate as? String == nil || strdate as? String == ""{
                                            strdate = ""
                                        }else{
                                           strdate = ""
                                           strdate = self.convertToShowFormatDate(dateString: (mainDict as AnyObject).object(forKey: "CharterDate")as! String)
                                        }
                                        let charterDate = (strdate)
                                        print("your charter date\(charterDate)")
                    let Language=(mainDict as AnyObject).object(forKey: "ClubLanguage") as? String
                                        print(Language ?? "")
                    var varMeetingDay=(mainDict as AnyObject).object(forKey: "meetingDay")as? String
                    print(varMeetingDay ?? "")
                    var varMeetingTime = (mainDict as AnyObject).object(forKey: "club_meeting_to_time")as? String
                    print(varMeetingTime ?? "")
                    if varMeetingTime == nil{
                        varMeetingTime = ""
                    }
                    
                    if varMeetingDay == nil{
                        varMeetingDay = ""
                    }
                    
                    self.Latitute=(mainDict as AnyObject).object(forKey: "lat")as? String
                    self.Longitude=(mainDict as AnyObject).object(forKey: "longi") as? String
                    if(self.Longitude=="" && self.Latitute=="")
                    {
                        self.buttonAddressLocation.isHidden = true
                    }
                    else
                    {
                        self.buttonAddressLocation.isHidden = false
                        
                    }
                    
                    let varDistrictId=(mainDict as AnyObject).object(forKey: "District")
                    print("District id:\(varDistrictId ?? "")")
                    self.lblDistrictID.text = varDistrictId as? String
                    self.lblMeetingDayAndTime.text =  (varMeetingDay!)+"  |  "+(varMeetingTime!)
                    
                    
                    var varGetFullAddress:String!=""
                    
                    var varGetFullAddress1:String!=""
                    var varGetFullAddress2:String!=""
                    var varGetFullAddress3:String!=""
                    var varGetFullAddress4:String!=""
                    var varGetFullAddress5:String!=""
                    varGetFullAddress = (varAddress as? String ?? "")+" "
                    varGetFullAddress1 = (varCity as? String ?? "") + ", "
                    varGetFullAddress2 = (varState as? String ?? "") + ", "
                    varGetFullAddress3 = (varCountry as? String ?? "") + " "
                    varGetFullAddress4 = (pinnnnnn as? String ?? "")+""
                    
                    varGetFullAddress5 = varGetFullAddress + varGetFullAddress1 + varGetFullAddress2 + varGetFullAddress3
                    
                    let varGetFullAddress6 = varGetFullAddress5 + varGetFullAddress4
                    //              let  varGetFullAddress
                    print("varGetFullAddress6---\(varGetFullAddress6)")
                    var mainaddewss = (varAddress as? String ?? "") + ","
                    self.lblAddressClub.text! = varGetFullAddress6
                    //                    self.clubE
                    //                }else{
                    //                    self.view.makeToast("data not available", duration: 2, position: CSToastPositionCenter)
                    //                }
                    
                    //                let mainDict = (subdicttt.object(forKey: "Table")! as AnyObject).object(at: 0)
                    //                print(mainDict)
                }
                //TODO: mani changes
                if ((subdicttt.object(forKey: "Table1")! as AnyObject).count > 0) {
                    let mainSecondCount = (subdicttt.object(forKey: "Table1") as AnyObject).count
                    //                let mainSecondCount = (subdicttt.object(forKey: "Table") as AnyObject).count
                    print("mainSecondCount: \(mainSecondCount)")
                    let mainPresidentDict = (subdicttt.object(forKey: "Table1") as AnyObject).object(at: 0)
                    //                let mainPresidentDict = (subdicttt.object(forKey: "Table") as AnyObject).object(at: 0)
                    var VarPresident=""
                    var VarPresidentMobileNumber=""
                    var VarPresidentEmail=""
                    
                    VarPresident = (mainPresidentDict as AnyObject).object(forKey: "name") as? String ?? ""
                    VarPresidentMobileNumber = (mainPresidentDict as AnyObject).object(forKey: "mobileNo") as? String ?? ""
                    VarPresidentEmail = (mainPresidentDict as AnyObject).object(forKey: "emailId") as? String ?? ""
                    print("your president Name\(VarPresident ?? "")")
                    self.lblPresidentName.text = VarPresident ?? ""
                    self.varGetPresidentMobNo = VarPresidentMobileNumber as String
                    self.varGetPresidentMail = VarPresidentEmail as String
                    self.muarrayKey.add("President")
                    self.muarrayKeyValue.add(VarPresident as String)
                    self.muarrayMailID.add(VarPresidentEmail as String)
                    self.muarrayMobileNumber.add(VarPresidentMobileNumber as String)
                    
                    //PRESIDENT
                    //                    if (((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table1")! as AnyObject).count > 0{
                    //                        for i in 0..<((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table1")! as AnyObject).value(forKey: "name")! as AnyObject).count
                    //                        {
                    //                            VarPresident=((((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table1")! as AnyObject).value(forKey: "name")! as AnyObject).object(at: i)) as! String)
                    //
                    //                            VarPresidentMobileNumber=((((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table1")! as AnyObject).value(forKey: "mobileNo")! as AnyObject).object(at: i)) as! String)
                    //
                    //
                    //                            VarPresidentEmail=((((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table1")! as AnyObject).value(forKey: "emailId")! as AnyObject).object(at: i)) as! String)
                    //                            print("aaaaaaaaaaaaaaaaaaaaaaaaa",i)
                    //                            self.lblPresidentName.text = VarPresident as String
                    //                            self.varGetPresidentMobNo = VarPresidentMobileNumber as String
                    //                            self.varGetPresidentMail = VarPresidentEmail as String
                    //                            // if(i==0)
                    //                            // {
                    //                            self.muarrayKey.add("President")
                    //                            self.muarrayKeyValue.add(VarPresident as String)
                    //                            self.muarrayMailID.add(VarPresidentEmail as String)
                    //                            self.muarrayMobileNumber.add(VarPresidentMobileNumber as String)
                    //                            //                    }
                    //                            //                    else
                    //                            //                    {
                    //                            //
                    //                            //                    }
                    //                        }
                    //                    }else{
                    //                        print("Data not found")
                    //                    }
                    //                    if(VarPresidentMobileNumber == "")
                    //                                    {
                    //                                        self.buttonPresidentCall.isHidden = false
                    //                                        self.buttonPresidentMessage.isHidden = false
                    //                                        self.buttonPresidentCall.setImage(UIImage(named:"sercall.png"),  for: UIControl.State.normal)
                    //                                        self.buttonPresidentMessage.setImage(UIImage(named:"sermessage.png"),  for: UIControl.State.normal)
                    //                                    }
                    //                                    else
                    //                                    {
                    //                                        self.buttonPresidentCall.isHidden = false
                    //                                        self.buttonPresidentMessage.isHidden = false
                    //                                    }
                    //                                    if(VarPresidentEmail as String == "")
                    //                                    {
                    //                                        //self.buttonPresidentMail.hidden = true
                    //                                        self.buttonPresidentMail.setImage(UIImage(named:"sermail.png"),  for: UIControl.State.normal)
                    //                                    }
                    //                                    else
                    //                                    {
                    //                                        self.buttonPresidentMail.isHidden = false
                    //   
                }
                    var VarSecretaryName=""
                    var VarSecretaryMobileNumber=""
                    var VarSecretaryEmail=""
                    //                    let subArray=(dd.object(forKey: "TBGetClubDetailResult")! as AnyObject).object(forKey: "ClubDetailResult") as! NSDictionary
                    //                    print(subdicttt)
                    //                let mainDict = (subdicttt.object(forKey: "Table")! as AnyObject).object(at: 0)
                    //                print(mainDict)
                
                //TODO: Mani changes
                if ((subdicttt.object(forKey: "Table2")! as AnyObject).count > 0) {
                    let mainThirdCount = (subdicttt.object(forKey: "Table2") as AnyObject).count
                    print("mainThirdCount: \(mainThirdCount)")
                    let mainSecretaryDict = (subdicttt.object(forKey: "Table2") as AnyObject).object(at: 0)
                    VarSecretaryName = (mainSecretaryDict as AnyObject).object(forKey: "name") as? String ?? ""
                    VarSecretaryMobileNumber = (mainSecretaryDict as AnyObject).object(forKey: "mobileNo") as? String ?? ""
                    VarSecretaryEmail = (mainSecretaryDict as AnyObject).object(forKey: "emailId") as? String ?? ""
                    self.lblSecretaryName.text = VarSecretaryName as String
                    self.varGetSecretaryMobNo = VarSecretaryMobileNumber as String
                    self.varGetSecretaryMail = VarSecretaryEmail as String
                    self.muarrayKey.add("Secretary")
                    self.muarrayKeyValue.add(VarSecretaryName as String)
                    self.muarrayMobileNumber.add(VarSecretaryMobileNumber as String)
                    self.muarrayMailID.add(VarSecretaryEmail as String)
                    //SECRETARY
                    //                                    for j in 0..<(mainThirdCount.value(forKey: "name")! as AnyObject).count
                    //                                    {
                    //                                        VarSecretaryName=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table2")! as AnyObject).value(forKey: "name")! as AnyObject).object(at: j)) as? String
                    //                                        print("secretary:\(VarSecretaryName ?? "")")
                    //                                        VarSecretaryMobileNumber=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table2")! as AnyObject).value(forKey: "mobileNo")! as AnyObject).object(at: j)) as? String
                    //
                    //                                        VarSecretaryEmail=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table2")! as AnyObject).value(forKey: "emailId")! as AnyObject).object(at: j)) as? String
                    //
                    //                                        self.lblSecretaryName.text! = VarSecretaryName as String
                    //                                        self.varGetSecretaryMobNo = VarSecretaryMobileNumber as String
                    //                                        self.varGetSecretaryMail = VarSecretaryEmail as String
                    //                                        self.muarrayKey.add("Secretary")
                    //                                        self.muarrayKeyValue.add(VarSecretaryName as String)
                    //                                        self.muarrayMobileNumber.add(VarSecretaryMobileNumber as String)
                    //                                        self.muarrayMailID.add(VarSecretaryEmail as String)
                    //                                    }
                    //                                    if(VarSecretaryMobileNumber as String == "")
                    //                                    {
                    //                                        self.buttonSecretaryCall.isHidden = false
                    //                                        self.buttonSecretaryMessage.isHidden = false
                    //                                        self.buttonSecretaryCall.setImage(UIImage(named:"sercall.png"),  for: UIControl.State.normal)
                    //                                        self.buttonSecretaryMessage.setImage(UIImage(named:"sermessage.png"),  for: UIControl.State.normal)
                    //                                    }
                    //                                    else
                    //                                    {
                    //                                        self.buttonSecretaryCall.isHidden = false
                    //                                        self.buttonSecretaryMessage.isHidden = false
                    //                                    }
                    //                                    if(VarSecretaryEmail as String == "")
                    //                                    {
                    //                                        //self.buttonSecreataryMail.hidden = true
                    //                                        self.buttonSecreataryMail.setImage(UIImage(named:"sermail.png"),  for: UIControl.State.normal)
                    //                                    }
                    //                                    else
                    //                                    {
                    //                                        self.buttonSecreataryMail.isHidden = false
                    //  
                }
                    var VarDistGovernorName=""
                    var VarDistGovernorMobileNumber=""
                    var VarDistGovernorEmail=""
                

//                                     said by madhura
//                    if ((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "districtGovernor")! as AnyObject).value(forKey: "name")! as AnyObject).count > 0{
//                        //                                    District GOVERNOR
//                        for k in 0..<((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "districtGovernor")! as AnyObject).value(forKey: "name")! as AnyObject).count
//                        {
//
//                            VarDistGovernorName=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "districtGovernor")! as AnyObject).value(forKey: "name")! as AnyObject).object(at: k)) as? String
//                            VarDistGovernorMobileNumber=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "districtGovernor")! as AnyObject).value(forKey: "mobileNo")! as AnyObject).object(at: k)) as? String
//                            VarDistGovernorEmail=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "districtGovernor")! as AnyObject).value(forKey: "emailId")! as AnyObject).object(at: k)) as? String
//                            self.lblDistrictGovernorName.text = VarDistGovernorName as String
//                            self.varGetGovernorMobNo = VarDistGovernorMobileNumber as String
//                            self.varGetGovernorMail = VarDistGovernorEmail
//                            self.muarrayKey.add("District Governor")
//                            self.muarrayKeyValue.add(VarDistGovernorName as String)
//                            self.muarrayMobileNumber.add(VarDistGovernorMobileNumber as String)
//                            self.muarrayMailID.add(VarDistGovernorEmail as String)
//                        }
//                    }else{
//                        print("Data not available")
//                    }
//
//                                  if(VarDistGovernorMobileNumber == "")
//                                    {
//                                        self.buttonGovernorCall.isHidden = false
//                                        self.buttonGovernorMessage.isHidden = false
//                                        self.buttonGovernorCall.setImage(UIImage(named:"sercall.png"),  for: UIControl.State.normal)
//                                        self.buttonGovernorMessage.setImage(UIImage(named:"sermessage.png"),  for: UIControl.State.normal)
//                                    }
//                                    else
//                                    {
//                                        self.buttonGovernorCall.isHidden = false
//                                        self.buttonGovernorMessage.isHidden = false
//                                    }
//                                    if(VarDistGovernorEmail  == "")
//                                    {
//                                        //self.buttonGovernorMail.hidden = true
//                                        self.buttonGovernorMail.setImage(UIImage(named:"sermail.png"),  for: UIControl.State.normal)
//                                    }
//                                    else
//                                    {
//                                        self.buttonGovernorMail.isHidden = false
//                                    }
print("varClubWebSiteLink:: \(varClubWebSiteLink)")
                                   if(varClubWebSiteLink == "" || varClubWebSiteLink == "Not Known")
                                    {
                                    }
                                    else
                                    {
                                        self.muarrayKey.add("Club Website")
                                        self.muarrayKeyValue.add(varClubWebSiteLink)
                                        self.muarrayMobileNumber.add("")
                                        self.muarrayMailID.add("")
                                    }
//
                                    
                                    if(clubContact as? String == "" || clubContact as? String == "Not Known")
                                    {
                                    }
                                    else
                                    {
                                        self.muarrayKey.add("Club Contact No.")
                                        self.muarrayKeyValue.add(clubContact)
                                        self.muarrayMobileNumber.add("")
                                        self.muarrayMailID.add("")
                                    }
//
                                   if(clubEmail as? String == "" || clubEmail as? String == "Not Known")
                                    {
                                    }
                                   else
                                    {
                                       self.muarrayKey.add("Club Email")
                                       self.muarrayKeyValue.add(clubEmail ?? "")
                                       self.muarrayMobileNumber.add("")
                                       self.muarrayMailID.add("")
                                    }
                
                if(strdate == "" || strdate == "Not Known")
                 {
                 }
                 else
                 {
                     self.muarrayKey.add("Charter Date")
                     self.muarrayKeyValue.add(strdate)
                     self.muarrayMobileNumber.add("")
                     self.muarrayMailID.add("")
                 }
//
                    
//                                    if(meetingDayAndTime! == "" || meetingDayAndTime! == "Not Known")
//                                    {
//                                    }
//                                    else
//                                    {
//                                        self.muarrayKey.add("Charter Date")
//                                        self.muarrayKeyValue.add(meetingDayAndTime)
//                                        self.muarrayMobileNumber.add("")
//                                        self.muarrayMailID.add("")
//                                    }
                                    if(varClubLang as! String=="" || varClubLang as? String == "Not Known")
                                    {
                                    }
                                    else
                                    {
                                        self.muarrayKey.add("Club Language")
                                        self.muarrayKeyValue.add(varClubLang)
                                        self.muarrayMobileNumber.add("")
                                        self.muarrayMailID.add("")
                                    }
                    
                                    print(self.muarrayKey)
                                    print(self.muarrayKeyValue)
                                    self.tableClubDetails.reloadData()
                                    self.window = nil
                
//                let varGrpID=(mainDict as AnyObject).object(forKey: "ClubId")!
//                print(varGrpID)
//                let varClubId=(mainDict as AnyObject).object(forKey: "District")!
//                print(varClubId)
//                let varClubName=(mainDict as AnyObject).object(forKey: "clubName")!
//                print(varClubName)
//                let varAddress=(mainDict as AnyObject).object(forKey: "address")
//                print(varAddress ?? "")
//                let varCity=(mainDict as AnyObject).object(forKey: "city")!
//                print(varCity)
//                let varState=(mainDict as AnyObject).object(forKey: "state")!
//                print(varState)
//                let varCountry=(mainDict as AnyObject).object(forKey: "country")!
//                print(varCountry)
//                let pinnnnnn=(mainDict as AnyObject).object(forKey: "address_PostalCode")!
//                let varClubWebSiteLink=(mainDict as AnyObject).object(forKey: "clubWebsite")!
//                print(varClubWebSiteLink)
//                let clubContact=(mainDict as AnyObject).object(forKey: "PhoneNumber")!
//                print(clubContact)
//
//                let clubEmail=(mainDict as AnyObject).object(forKey: "club_Email")!
//                print(clubEmail)
//                var strdate = (mainDict as AnyObject).object(forKey: "CharterDate")as? String
////                print(varMeetingTime)
//                if strdate == nil || strdate == ""{
//                    strdate = ""
//                }
//                else{
//                    strdate = ""
//                    strdate = self.convertToShowFormatDate(dateString: (mainDict as AnyObject).object(forKey: "CharterDate")as! String)
//                }
//
//                let charterDate = strdate
//                print(charterDate)
//                let Language=(mainDict as AnyObject).object(forKey: "ClubLanguage")!
//                print(Language)
//
//
//
//                var varMeetingDay=(mainDict as AnyObject).object(forKey: "meetingDay")as? String
//                print(varMeetingDay)
//                var varMeetingTime = (mainDict as AnyObject).object(forKey: "club_meeting_to_time")as? String
//                print(varMeetingTime)
//                if varMeetingTime == nil{
//                    varMeetingTime = ""
//                }
//
//                if varMeetingDay == nil{
//                    varMeetingDay = ""
//                }
//
//                self.Latitute=(mainDict as AnyObject).object(forKey: "lat")as! String
//                self.Longitude=(mainDict as AnyObject).object(forKey: "longi") as! String
//                if(self.Longitude=="" && self.Latitute=="")
//                {
//                    self.buttonAddressLocation.isHidden = true
//                }
//                else
//                {
//                    self.buttonAddressLocation.isHidden = false
//
//                }
//
//                let varDistrictId=(mainDict as AnyObject).object(forKey: "District")!
//                self.lblDistrictID.text = varDistrictId as! String
//                self.lblMeetingDayAndTime.text =  (varMeetingDay as! String)+"  |  "+(varMeetingTime as! String)
//
//
//                var varGetFullAddress:String!=""
//
//                var varGetFullAddress1:String!=""
//                var varGetFullAddress2:String!=""
//                var varGetFullAddress3:String!=""
//                var varGetFullAddress4:String!=""
//                var varGetFullAddress5:String!=""
//                varGetFullAddress = (varAddress as! String)+" "
//                varGetFullAddress1 = varCity as! String+" "
//                varGetFullAddress2 = varState as! String+" "
//                varGetFullAddress3 = varCountry as! String+" "
//                varGetFullAddress4 = pinnnnnn as! String+""
//
//                varGetFullAddress5 = varGetFullAddress + varGetFullAddress1 + varGetFullAddress2 + varGetFullAddress3
//
//                let varGetFullAddress6 = varGetFullAddress5 + varGetFullAddress4
////              let  varGetFullAddress
//
//
//
//
//
//                var mainaddewss = varAddress as! String + ","
//                self.lblAddressClub.text! = varGetFullAddress6
//
//                var VarPresident:String!=""
//                var VarPresidentMobileNumber:String!=""
//                var VarPresidentEmail:String!=""
//                //PRESIDENT
//                for i in 0..<((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table1")! as AnyObject).value(forKey: "name")! as AnyObject).count
//                {
//                    VarPresident=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table1")! as AnyObject).value(forKey: "name")! as AnyObject).object(at: i)) as? String
//
//                    VarPresidentMobileNumber=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table1")! as AnyObject).value(forKey: "mobileNo")! as AnyObject).object(at: i)) as? String
//                    VarPresidentEmail=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table1")! as AnyObject).value(forKey: "emailId")! as AnyObject).object(at: i)) as? String
//                    print("aaaaaaaaaaaaaaaaaaaaaaaaa",i)
//                    self.lblPresidentName.text! = VarPresident as String
//                    self.varGetPresidentMobNo = VarPresidentMobileNumber as String
//                    self.varGetPresidentMail = VarPresidentEmail as String
//                    // if(i==0)
//                    // {
//                    self.muarrayKey.add("President")
//                    self.muarrayKeyValue.add(VarPresident as String)
//                    self.muarrayMailID.add(VarPresidentEmail as String)
//                    self.muarrayMobileNumber.add(VarPresidentMobileNumber as String)
//                    //                    }
//                    //                    else
//                    //                    {
//                    //
//                    //                    }
//                }
//                if(VarPresidentMobileNumber as String == "")
//                {
//                    self.buttonPresidentCall.isHidden = false
//                    self.buttonPresidentMessage.isHidden = false
//                    self.buttonPresidentCall.setImage(UIImage(named:"sercall.png"),  for: UIControl.State.normal)
//                    self.buttonPresidentMessage.setImage(UIImage(named:"sermessage.png"),  for: UIControl.State.normal)
//                }
//                else
//                {
//                    self.buttonPresidentCall.isHidden = false
//                    self.buttonPresidentMessage.isHidden = false
//                }
//                if(VarPresidentEmail as String == "")
//                {
//                    //self.buttonPresidentMail.hidden = true
//                    self.buttonPresidentMail.setImage(UIImage(named:"sermail.png"),  for: UIControl.State.normal)
//                }
//                else
//                {
//                    self.buttonPresidentMail.isHidden = false
//                }
//                var VarSecretaryName:String!=""
//                var VarSecretaryMobileNumber:String!=""
//                var VarSecretaryEmail:String!=""
//                //SECRETARY
//                for j in 0..<((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table2")! as AnyObject).value(forKey: "name")! as AnyObject).count
//                {
//                    VarSecretaryName=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table2")! as AnyObject).value(forKey: "name")! as AnyObject).object(at: j)) as? String
//
//                    VarSecretaryMobileNumber=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table2")! as AnyObject).value(forKey: "mobileNo")! as AnyObject).object(at: j)) as? String
//
//                    VarSecretaryEmail=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "Table2")! as AnyObject).value(forKey: "emailId")! as AnyObject).object(at: j)) as? String
//
//                    self.lblSecretaryName.text! = VarSecretaryName as String
//                    self.varGetSecretaryMobNo = VarSecretaryMobileNumber as String
//                    self.varGetSecretaryMail = VarSecretaryEmail as String
//                    self.muarrayKey.add("Secretary")
//                    self.muarrayKeyValue.add(VarSecretaryName as String)
//                    self.muarrayMobileNumber.add(VarSecretaryMobileNumber as String)
//                    self.muarrayMailID.add(VarSecretaryEmail as String)
//                }
//                if(VarSecretaryMobileNumber as String == "")
//                {
//                    self.buttonSecretaryCall.isHidden = false
//                    self.buttonSecretaryMessage.isHidden = false
//                    self.buttonSecretaryCall.setImage(UIImage(named:"sercall.png"),  for: UIControl.State.normal)
//                    self.buttonSecretaryMessage.setImage(UIImage(named:"sermessage.png"),  for: UIControl.State.normal)
//                }
//                else
//                {
//                    self.buttonSecretaryCall.isHidden = false
//                    self.buttonSecretaryMessage.isHidden = false
//                }
//                if(VarSecretaryEmail as String == "")
//                {
//                    //self.buttonSecreataryMail.hidden = true
//                    self.buttonSecreataryMail.setImage(UIImage(named:"sermail.png"),  for: UIControl.State.normal)
//                }
//                else
//                {
//                    self.buttonSecreataryMail.isHidden = false
//                }
//                var VarDistGovernorName:String!=""
//                var VarDistGovernorMobileNumber:String!=""
//                var VarDistGovernorEmail:String!=""

                // said by madhura

                //District GOVERNOR
//                for k in 0..<((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "districtGovernor")! as AnyObject).value(forKey: "name")! as AnyObject).count
//                {
//                    VarDistGovernorName=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "districtGovernor")! as AnyObject).value(forKey: "name")! as AnyObject).object(at: k)) as! String
//                    VarDistGovernorMobileNumber=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "districtGovernor")! as AnyObject).value(forKey: "mobileNo")! as AnyObject).object(at: k)) as! String
//                    VarDistGovernorEmail=(((((dd.value(forKey: "TBGetClubDetailResult")! as AnyObject).value(forKey: "ClubDetailResult")! as AnyObject).value(forKey: "districtGovernor")! as AnyObject).value(forKey: "emailId")! as AnyObject).object(at: k)) as! String
//                    self.lblDistrictGovernorName.text! = VarDistGovernorName as String
//                    self.varGetGovernorMobNo = VarDistGovernorMobileNumber as String
//                    self.varGetGovernorMail = VarDistGovernorEmail as String
//                    self.muarrayKey.add("District Governor")
//                    self.muarrayKeyValue.add(VarDistGovernorName as String)
//                    self.muarrayMobileNumber.add(VarDistGovernorMobileNumber as String)
//                    self.muarrayMailID.add(VarDistGovernorEmail as String)
//                }
//
//                if(VarDistGovernorMobileNumber as String == "")
//                {
//                    self.buttonGovernorCall.isHidden = false
//                    self.buttonGovernorMessage.isHidden = false
//                    self.buttonGovernorCall.setImage(UIImage(named:"sercall.png"),  for: UIControl.State.normal)
//                    self.buttonGovernorMessage.setImage(UIImage(named:"sermessage.png"),  for: UIControl.State.normal)
//                }
//                else
//                {
//                    self.buttonGovernorCall.isHidden = false
//                    self.buttonGovernorMessage.isHidden = false
//                }
//                if(VarDistGovernorEmail as String == "")
//                {
//                    //self.buttonGovernorMail.hidden = true
//                    self.buttonGovernorMail.setImage(UIImage(named:"sermail.png"),  for: UIControl.State.normal)
//                }
//                else
//                {
//                    self.buttonGovernorMail.isHidden = false
//                }

//                if(varClubWebSiteLink as! String=="" || varClubWebSiteLink as! String == "Not Known")
//                {
//                }
//                else
//                {
//                    self.muarrayKey.add("Club Website")
//                    self.muarrayKeyValue.add(varClubWebSiteLink as? String)
//                    self.muarrayMobileNumber.add("")
//                    self.muarrayMailID.add("")
//                }
//
//
//                if(clubContact as! String=="" || clubContact as! String == "Not Known")
//                {
//                }
//                else
//                {
//                    self.muarrayKey.add("Club Contact No.")
//                    self.muarrayKeyValue.add(clubContact ?? "")
//                    self.muarrayMobileNumber.add("")
//                    self.muarrayMailID.add("")
//                }
//
//                if(clubEmail as! String=="" || clubEmail as! String == "Not Known")
//                {
//                }
//                else
//                {
//                    self.muarrayKey.add("Club Email")
//                    self.muarrayKeyValue.add(clubEmail as? String)
//                    self.muarrayMobileNumber.add("")
//                    self.muarrayMailID.add("")
//                }
//
//
//                if(charterDate == "" || charterDate == "Not Known")
//                {
//                }
//                else
//                {
//                    self.muarrayKey.add("Charter Date")
//                    self.muarrayKeyValue.add(charterDate ?? "")
//                    self.muarrayMobileNumber.add("")
//                    self.muarrayMailID.add("")
//                }
//                if(Language as! String=="" || Language as! String == "Not Known")
//                {
//                }
//                else
//                {
//                    self.muarrayKey.add("Language")
//                    self.muarrayKeyValue.add(Language as? String)
//                    self.muarrayMobileNumber.add("")
//                    self.muarrayMailID.add("")
//                }
//
//
//
//
////
//                print(self.muarrayKey)
//                print(self.muarrayKeyValue)
//                self.tableClubDetails.reloadData()
//                self.window = nil
            }
            else
            {
                self.lblHeadingAddressInfo.isHidden=true
                self.lblHeadingMeetingDayTimeInfo.isHidden=true
                self.buttonAddressLocation.isHidden=true
                self.viewForUnderLineMeetingDayDown.isHidden=true
//                self.window = nil
            }
            SVProgressHUD.dismiss()
        }
        })
        //}
//
    }
    
    //MARK:- Loader Method
    func loaderViewMethod()
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
        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")
        let gifView = UIImageView()
        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
        gifView.backgroundColor = UIColor.clear
        //                gifView.contentMode = .Center
        Loadingview.addSubview(gifView)
        window?.addSubview(Loadingview)

    }

    
    
    //MARK:- Table Methods
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayKey.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell : ClubDetailsTableViewCell! = tableClubDetails.dequeueReusableCell(withIdentifier: "ClubDetailsTableViewCell") as? ClubDetailsTableViewCell
        if(muarrayKey.count>0 || muarrayKeyValue.count>0)
        {
            SVProgressHUD.dismiss()
            let heading = muarrayKey.object(at: indexPath.row) as? String
            cell.lblHeading.text = muarrayKey.object(at: indexPath.row) as? String
            cell.lblName.text = muarrayKeyValue.object(at: indexPath.row) as? String
            print("Hello.........\(cell.lblHeading.text)")
            print("Hello.........\(cell.lblName.text)")
            print(muarrayKey.count)
            print(muarrayMobileNumber.count)
            
            let varGetMobileNumber=muarrayMobileNumber.object(at: indexPath.row)as? String
            if((varGetMobileNumber?.count ?? 0)>2)
            {
                cell.buttonCall.setImage(UIImage(named: "call_blue"),  for: UIControl.State.normal)
                cell.buttonMessage.setImage(UIImage(named: "message_blue"),  for: UIControl.State.normal)
                cell.buttonCall.isUserInteractionEnabled=true
                cell.buttonMessage.isUserInteractionEnabled=true
            }
            else
            {
                cell.buttonCall.setImage(UIImage(named: "sercall.png"),  for: UIControl.State.normal)
                cell.buttonMessage.setImage(UIImage(named: "sermessage.png"),  for: UIControl.State.normal)
                cell.buttonCall.isUserInteractionEnabled=false
                cell.buttonMessage.isUserInteractionEnabled=false
            }
            let varGetMailID:String!=muarrayMailID.object(at: indexPath.row)as? String
            if(varGetMailID.count>2)
            {
                cell.buttonMail.setImage(UIImage(named: "mail_blue"),  for: UIControl.State.normal)
                cell.buttonMail.isUserInteractionEnabled=true
            }
            else
            {
                cell.buttonMail.setImage(UIImage(named: "sermail.png"),  for: UIControl.State.normal)
                cell.buttonMail.isUserInteractionEnabled=false
            }
            if(heading == "Club Website")
            {
                cell.lblName.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
                cell.buttonMail.isHidden = true
                cell.buttonCall.isHidden = true
                cell.buttonMessage.isHidden = true
                 cell.buttonWhatsApp.isHidden = true
                
            }
            
            if(heading == "Club Language")
            {
                cell.lblName.textColor = UIColor.black
                cell.buttonMail.isHidden = true
                cell.buttonCall.isHidden = true
                cell.buttonMessage.isHidden = true
                 cell.buttonWhatsApp.isHidden = true
                
            }
            if(heading == "Charter Date")
            {
                cell.lblName.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
                cell.buttonMail.isHidden = true
                cell.buttonCall.isHidden = true
                cell.buttonMessage.isHidden = true
                 cell.buttonWhatsApp.isHidden = true
                
            }
            
//            "Club Contact No."
            //Club Email
            if(heading == "Club Email")
            {
                cell.lblName.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
                cell.buttonMail.isHidden = true
                cell.buttonCall.isHidden = true
                cell.buttonMessage.isHidden = true
                 cell.buttonWhatsApp.isHidden = true
                
            }
            if(heading == "Club Contact No.")
            {
                cell.lblName.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
                cell.buttonMail.isHidden = true
                cell.buttonCall.isHidden = true
                cell.buttonMessage.isHidden = true
                 cell.buttonWhatsApp.isHidden = true
                
            }
            var aa = muarrayMobileNumber.object(at: indexPath.row)as? String
            print("your data \(aa ?? "")")
            //print(varGetKey)
            //print(varGetKeyValue)
            //print(varGetKeyMobileNumber)
            
        }
        
        //buttonWhatsApp
        cell.buttonWhatsApp.addTarget(self, action: #selector(InfoSegmentFindAClubViewController.buttonWhatsAppclickEvent(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonWhatsApp.tag=indexPath.row;
        
        cell.buttonCall.addTarget(self, action: #selector(InfoSegmentFindAClubViewController.buttonCall(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonCall.tag=indexPath.row;
        cell.buttonMessage.addTarget(self, action: #selector(InfoSegmentFindAClubViewController.buttonMessage(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonMessage.tag=indexPath.row;
        cell.buttonMail.addTarget(self, action: #selector(InfoSegmentFindAClubViewController.buttonMail(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonMail.tag=indexPath.row;
        return cell as ClubDetailsTableViewCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            tableView.deselectRow(at: indexPath, animated: true)
            let heading = muarrayKey.object(at: indexPath.row) as! String
            if(heading=="Club Website")
            {
                /*
                let urlLink = muarrayKeyValue.object(at: indexPath.row) as! String
                let objWebViewToUrlOpenViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebViewToUrlOpenViewController") as! WebViewToUrlOpenViewController
                objWebViewToUrlOpenViewController.moduleName = "Find a Club"
                objWebViewToUrlOpenViewController.URLstr=urlLink
                self.navigationController?.pushViewController(objWebViewToUrlOpenViewController, animated: true)
                */
                let urlLink = muarrayKeyValue.object(at: indexPath.row) as! String

            
                
                var stringUrl:String!=""
                stringUrl=urlLink as? String
                if(stringUrl.contains("http"))
                {
                    
                }
                else
                {
                    stringUrl="http://"+stringUrl
                }
                let url = URL (string: (stringUrl));
                print(url)
                if let urll = url {
                    let requestObj = URLRequest(url: urll);
                    print("http://-----------------------")
                }
                
                if let url = NSURL(string: stringUrl){
//                    UIApplication.shared.openURL(url as URL)
                    if let url = URL(string: stringUrl) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
            }
            
//             Club Email
             if(heading=="Club Email"){
                 let  varGetKeyMailId =  muarrayKeyValue.object(at: indexPath.row) as! String
                 print(varGetKeyMailId)
                 
                 EmailSTR = varGetKeyMailId
                 MailAction()
             }
             if(heading=="Club Contact No."){
//                 {
                     let  varGetKeyMobileNumber =  muarrayKeyValue.object(at: indexPath.row) as! String
                     print(varGetKeyMobileNumber)
                     
                     PhoneNumberSTR = varGetKeyMobileNumber
                     PhoneCallAction()
//                 }
             }
        }
    }
    
    @objc func buttonWhatsAppclickEvent(_ sender:UIButton)
    {
        let  varGetKeyMobileNumber =  muarrayMobileNumber.object(at: sender.tag) as! String
        print(varGetKeyMobileNumber)
        
        PhoneNumberSTR = varGetKeyMobileNumber
        print("whatsapp clicked !!!!")
        
        var varGetValue=PhoneNumberSTR
        let string = varGetValue.replacingOccurrences(of: "+", with: "")
        let newString = string.replacingOccurrences(of: " ", with: "")
        if(newString.count>7)
        {
            var varGetValue=newString
            let urlWhats = "https://wa.me/\(varGetValue)"
                if let whatsappURL = URL(string: urlWhats) {
                    if UIApplication.shared.canOpenURL(whatsappURL) {
//                        UIApplication.shared.openURL(whatsappURL)
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Rotary India"
                        alertView.message = "WhatsApp is not installed"
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                    }
                }
        }
    }
    
    
    @objc func buttonCall(_ sender:UIButton)
    {
        let  varGetKeyMobileNumber =  muarrayMobileNumber.object(at: sender.tag) as! String
        print(varGetKeyMobileNumber)
        
        PhoneNumberSTR = varGetKeyMobileNumber
        PhoneCallAction()
    }
    @objc func buttonMessage(_ sender:UIButton)
    {
        let  varGetKeyMobileNumber =  muarrayMobileNumber.object(at: sender.tag) as! String
        print(varGetKeyMobileNumber)
        PhoneNumberSTR = varGetKeyMobileNumber
        SMSAction()
    }
    @objc func buttonMail(_ sender:UIButton)
    {
        let  varGetKeyMailId =  muarrayMailID.object(at: sender.tag) as! String
        print(varGetKeyMailId)
        
        EmailSTR = varGetKeyMailId
        MailAction()
    }
}
