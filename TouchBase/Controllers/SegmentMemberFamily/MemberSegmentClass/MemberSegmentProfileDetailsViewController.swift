
import UIKit
import MessageUI
import Alamofire
import ContactsUI
import Contacts

//import Kingfisher
import Foundation

import SVProgressHUD
class MemberSegmentProfileDetailsViewController: UIViewController , UITextFieldDelegate , UIScrollViewDelegate , MFMailComposeViewControllerDelegate , MFMessageComposeViewControllerDelegate , UITableViewDataSource , UITableViewDelegate, CNContactViewControllerDelegate {
    
    
    
    var varProfileId:String!=""
    var muarrayKey:NSMutableArray=NSMutableArray()
    var muarrayKeyValue:NSMutableArray=NSMutableArray()
    var muarrayContactKey:NSMutableArray=NSMutableArray()
    var muarrayContactValue:NSMutableArray=NSMutableArray()

    var SelectFromCallMessageMAil:String!=""
    var CheckUncheckMailMessage:Int = 0
    var CheckUncheckMailMessage2:Int = 0
    
    var numberValueArray:NSMutableArray=NSMutableArray()
    var emailValueArray:NSMutableArray=NSMutableArray()
    var numberKeyArray:NSMutableArray=NSMutableArray()
    var emailKeyArray:NSMutableArray=NSMutableArray()
    var flagMSGEmailArray:NSMutableArray=NSMutableArray()
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    var PhoneNumberSTR  : String = ""
    
    var savePhn = ""
    var saveUserName = ""
    
    var phoneStr = [String]()
    var emailStr = [String]()
    var EmailSTR  : String =  ""
    var varMemberProfileID:String! = ""
    
    
    var isUpperImageAvailable:String!=""
    

    /***************************************************************/
    
    
    
    //  @IBOutlet weak var buttonWhatsApp2: UIButton!
    @IBOutlet weak var buttonWhatsApp: UIButton!
    @IBOutlet weak var buttonCallTitle: UIButton!
    
    //    @IBOutlet weak var imageCall1: UIImageView!
    //   @IBOutlet weak var imageCall2: UIImageView!
    
    @IBOutlet weak var buttonCallMessageMailSend: UIButton!
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var tableRotarianDetails: UITableView!
    @IBOutlet weak var tableMobileActionDetails: UITableView!
    
    
    
    //    @IBOutlet weak var imagePersonalMobileCheckUncheck: UIImageView!
    //    @IBOutlet weak var viewOneMobileNumber: UIView!
    //    @IBOutlet weak var viewTwoMobileNumber: UIView!
    //    @IBOutlet weak var lblPersonalMobileNumber: UILabel!
    //    @IBOutlet weak var buttonPersonalMobileCheckUncheck: UIButton!
    //    @IBOutlet weak var imageBusinessMobileCheckUncheck: UIImageView!
    //    @IBOutlet weak var lblBusinessMobileNumber: UILabel!
    //    @IBOutlet weak var buttonBusinessMobileCheckUncheck: UIButton!
    @IBOutlet weak var viewForCallMAilMessagePopUP: UIView!
    //    @IBOutlet weak var lblHeadingPOpUpMobileNumberMAil: UILabel!
    //    @IBOutlet weak var lblHeadingPopUpbussinessNumberMail: UILabel!
    

    @IBOutlet weak var buttonMessage: UIButton!
    @IBOutlet weak var buttonCall: UIButton!
    @IBOutlet weak var buttonMail: UIButton!
    @IBOutlet weak var imageRotarianProfileImage: UIImageView!
    @IBOutlet weak var textfieldMobile: UITextField!
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldAddress: UITextField!
    @IBOutlet weak var textfieldBusinessName: UITextField!
    @IBOutlet weak var textfieldDesignation: UITextField!
    @IBOutlet weak var textfieldBusinessPhone: UITextField!
    @IBOutlet weak var textfieldFax: UITextField!
    @IBOutlet weak var myScrollView: UIScrollView!
    
    
    @IBOutlet weak var lblHeadingAddress: UILabel!
    @IBOutlet weak var lblHeadingBusinessName: UILabel!
    @IBOutlet weak var lblHeadingDesignation: UILabel!
    @IBOutlet weak var lblHeadingFax: UILabel!
    @IBOutlet weak var lblHeadingBusinessPhone: UILabel!
    @IBOutlet weak var lblHeadingEmail: UILabel!
    @IBOutlet weak var lblHeadingMob: UILabel!
    
    @IBOutlet weak var lblLoading: UILabel!
    @IBOutlet weak var lblClubName: UILabel!
    @IBOutlet weak var lblMemberName: UILabel!
    
    
    @IBAction func buttonImageBigViewClickEvent(_ sender: AnyObject) {
        buttonPicBigViewClickEvent()
    }
    
    func buttonPicBigViewClickEvent()
    {
        

        print(isUpperImageAvailable)
        print("Clicked !!")
        if(isUpperImageAvailable!.characters.count>10)
        {
            print(isUpperImageAvailable)
            print("available")
            let objImageFullViewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ImageFullViewViewController") as! ImageFullViewViewController
            objImageFullViewViewController.varGetImageUrl=isUpperImageAvailable
            self.navigationController?.pushViewController(objImageFullViewViewController, animated: true)
        }
        else
        {
            print("User image is not available !!")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myScrollView.isHidden=true
        
        let lbel = UILabel()
        lbel.frame = CGRect(x: 0, y: self.buttonCallMessageMailSend.frame.size.height-50, width: self.view.frame.size.width, height: 1)
        lbel.backgroundColor =  UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        buttonCallMessageMailSend.addSubview(lbel)
        buttonCallMessageMailSend.titleLabel?.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        
        buttonClose.layer.cornerRadius = 5
        buttonClose.layer.borderWidth = 1
        buttonClose.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        
        buttonOpticity.isHidden = true
        viewForCallMAilMessagePopUP.isHidden = true
        buttonCallMessageMailSend.isHidden = true
        
        
        functionForSetLeftNavigation() //Navigationbar Setting
        funcForScrollView() //ScrollView Setting
        functionForImageCurv() // IMage Setting
        functionForGetRotarianDetails(varMemberProfileID)
        functionForTextfield() //Textfield Setting
    }
    
    @IBAction func buttonWhatsAppClickEvent(_ sender: Any)
    {
        print("WhatsApp- up ")
        buttonCallTitle.setTitle("WhatsApp",  for: UIControl.State.normal)
        SelectFromCallMessageMAil = "WhatsApp"
        viewForCallMAilMessagePopUP.isHidden = false
        buttonOpticity.isHidden = false
        buttonCallMessageMailSend.isHidden=true
        tableMobileActionDetails.reloadData()
        
        //        buttonWhatsApp1.isHidden=false
        //        buttonWhatsApp2.isHidden=false
    }
    @IBAction func buttonWhats2AppClickEvent(_ sender: Any)
    {
        var varGetValue=PhoneNumberSTR
        let string = varGetValue.replacingOccurrences(of: "+", with: "")
        let newString = string.replacingOccurrences(of: " ", with: "")
        if(newString.characters.count>7)
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
    
    
    //   @IBOutlet weak var buttonWhatsApp1: UIButton!
    @IBAction func buttonWhatsApp1ClickEvent(_ sender: Any)
    {
        print("WhatsApp-1")
        
        print("this is whats aap")
        
        var varGetValue=PhoneNumberSTR
        let string = varGetValue.replacingOccurrences(of: "+", with: "")
        let newString = string.replacingOccurrences(of: " ", with: "")
        if(newString.characters.count>7)
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
    
    
    
    
    
    func functionForImageCurv()
    {
        imageRotarianProfileImage.contentMode = .scaleAspectFit
        imageRotarianProfileImage.layer.borderWidth = 1.0
        imageRotarianProfileImage.layer.masksToBounds = false
        imageRotarianProfileImage.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imageRotarianProfileImage.layer.cornerRadius = imageRotarianProfileImage.frame.size.width/2
        imageRotarianProfileImage.clipsToBounds = true
    }
    func functionForTextfield()
    {
        textfieldMobile.delegate = self
        textfieldEmail.delegate = self
        textfieldAddress.delegate = self
        textfieldBusinessName.delegate = self
        textfieldBusinessPhone.delegate = self
        textfieldDesignation.delegate = self
        textfieldFax.delegate = self
        textfieldMobile.functionForSetTextFieldBottomBorder()
        textfieldEmail.functionForSetTextFieldBottomBorder()
        textfieldAddress.functionForSetTextFieldBottomBorder()
        textfieldBusinessName.functionForSetTextFieldBottomBorder()
        textfieldBusinessPhone.functionForSetTextFieldBottomBorder()
        textfieldDesignation.functionForSetTextFieldBottomBorder()
        textfieldFax.functionForSetTextFieldBottomBorder()
        if(textfieldMobile.text! != "")
        {
            textfieldMobile.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        }
        if(textfieldEmail.text! != "")
        {
            textfieldEmail.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        }
    }
    func funcForScrollView()
    {
        myScrollView.delegate = self
        myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 600)
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
        if PhoneNumberSTR.characters.count > 1
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

        phoneStr.removeAll()
        for i in 00..<flagMSGEmailArray.count
        {
            if (flagMSGEmailArray.object(at: i) as! String)=="1"
            {
                phoneStr.append(numberValueArray.object(at: i) as! String)
            }
        }
        
        if(phoneStr.count>0)
        {
            let messageVC = MFMessageComposeViewController()
            messageVC.body = ""
            messageVC.recipients = phoneStr // Optionally add some tel numbers
            messageVC.messageComposeDelegate = self
            // Open the SMS View controller
            present(messageVC, animated: true, completion: nil)
        }
        else
        {
            self.view.makeToast("Please select at least one contact number", duration: 2, position: CSToastPositionCenter)
        }
        
    }
    
    
    
    //MARK:- Mail Action
    
    func MailAction()
    {
        //EmailSTR = textfieldEmail.text!
        if emailValueArray.count>1
        {
            emailStr.removeAll()
            for i in 00..<flagMSGEmailArray.count
            {
                if (flagMSGEmailArray.object(at: i) as! String)=="1"
                {
                    emailStr.append(emailValueArray.object(at: i) as! String)
                }
            }
        }
        
        print(emailStr)
        if emailStr.count>0{
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(emailStr)      // gg@hing.co.in
            mail.setMessageBody("", isHTML: true)
            
            present(mail, animated: true, completion: nil)
        }
        else
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Rotary India"
            alertView.message = "Please check whether you have logged in to your mail account."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()

        }
        }
        else
        {
            self.view.makeToast("Please select at least one email address",
                                duration: 2, position: CSToastPositionCenter)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case .cancelled:
            print("Mail cancelled")
        case .saved:
            print("Mail saved")
        case .sent:
            print("Mail sent")
        case .failed:
            print("Mail sent failure: \(error?.localizedDescription)")
        default:
            break
        }
        //self.dis(animated: true, completion: nil)
        
        self.dismiss(animated: true, completion: nil)
        
        //controller.dismissViewControllerAnimated(true, completion: nil)
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
    
    
    
    
    //MARK:- navigation
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Profile"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(RotarianProfileBusinessDetailsViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        shareButton.addTarget(self, action: #selector(MemberSegmentProfileDetailsViewController.shareContact), for: UIControl.Event.touchUpInside)
        let sharing: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
        var buttons:NSArray=NSArray()
        buttons = [sharing]
        
        let saveContactButton = UIButton(type: UIButton.ButtonType.custom)
        saveContactButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        saveContactButton.setImage(UIImage(named:"saveContact"),  for: UIControl.State.normal)
        saveContactButton.addTarget(self, action: #selector(MemberSegmentProfileDetailsViewController.savedContactButtonclicked), for: UIControl.Event.touchUpInside)
        let savecontact: UIBarButtonItem = UIBarButtonItem(customView: saveContactButton)
        buttons = [sharing,savecontact]
        
        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
    
    }
    
    @objc func savedContactButtonclicked()
    {
            var letGetPhoneNumber:String = ""
            letGetPhoneNumber = self.savePhn
            var userName = self.saveUserName
            print(letGetPhoneNumber)
            let varGetValue=letGetPhoneNumber
            
            let newContact = CNMutableContact()
            newContact.givenName = userName
            newContact.phoneNumbers.append(CNLabeledValue(label: "home", value: CNPhoneNumber(stringValue: varGetValue)))
            let contactVC = CNContactViewController(forUnknownContact: newContact)
            contactVC.contactStore = CNContactStore()
            contactVC.delegate = self
            contactVC.allowsActions = false
            self.navigationController?.navigationBar.tintColor = UIColor.systemBlue
            if #available(iOS 11.0, *) {
                contactVC.additionalSafeAreaInsets.top = self.navigationController?.navigationBar.frame.height ?? 0
            }
            self.navigationController?.pushViewController(contactVC, animated: true)

        }
    
     @objc func backClicked()
    {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- share contact methods
    @objc func shareContact()
    {
        let contact = createContact()
        
        do {
            try shareContacts(contacts: [contact])
        }
        catch {
            // Handle error
        }
    }
    
    func shareContacts(contacts: [CNContact]) throws {
        
        guard let directoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return
        }
        
        var filename = NSUUID().uuidString
        
        // Create a human friendly file name if sharing a single contact.
        if let contact = contacts.first, contacts.count == 1 {
            
            if let fullname = CNContactFormatter().string(from: contact) {
                //filename = fullname.componentsSeparatedBy(" ").joinWithSeparator("")
                filename = fullname.components(separatedBy: " ").joined(separator: "")
            }
        }
        
        let fileURL = directoryURL.appendingPathComponent(filename).appendingPathExtension("vcf")
        
        let data = try CNContactVCardSerialization.data(with: contacts)
        
        print("filename: \(filename)")
        print("contact: \(String(data: data, encoding: String.Encoding.utf8))")
        
        //   try data.writeToURL(fileURL, options: [.AtomicWrite])
        try data.write(to: fileURL, options: [.atomicWrite])
        let activityViewController = UIActivityViewController(
            activityItems: [fileURL],
            applicationActivities: nil
        )
        
        present(activityViewController, animated: true, completion: {})
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
    
    func createContact() -> CNContact {
        let ename:String=self.lblMemberName.text!
        let contactName:String=ename.replacingOccurrences(of: ",", with: " ")
        var mobileNo:String=""
        var emailID:String=""
        var addresses:String=""
        var city:String=""
        var state:String=""
        var country:String=""
        var postalCode:String=""
        
        print(muarrayContactKey)
        print(muarrayContactValue)
        for i in 0..<muarrayContactKey.count
        {
            let varGetKeyValue=muarrayContactKey.object(at: i)as! String
            if varGetKeyValue.contains("Mobile") && mobileNo == ""
            {
                mobileNo=muarrayContactValue.object(at: i) as! String
            }
            
            if varGetKeyValue=="Email" && emailID == ""
            {
                emailID=muarrayContactValue.object(at: i) as! String
            }
            
            if varGetKeyValue=="address" && addresses == ""
            {
                let addresss1=muarrayContactValue.object(at: i) as! String
                addresses=addresss1.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\'", with: "").replacingOccurrences(of: ",", with: "")
                addresses=addresses.trimmingCharacters(in: .whitespacesAndNewlines)
                addresses = addresses.trimmingCharacters(in: .whitespaces)
                
            }
            if varGetKeyValue=="city" && city == ""
            {
                city=muarrayContactValue.object(at: i) as! String
            }
            
            if varGetKeyValue=="state" && state == ""
            {
                state=muarrayContactValue.object(at: i) as! String
            }
            
            if varGetKeyValue=="country" && country == ""
            {
                country=muarrayContactValue.object(at: i) as! String
            }
            
            if varGetKeyValue=="pincode" && postalCode == ""
            {
                postalCode=muarrayContactValue.object(at: i) as! String
            }
            print("Address removing slash MSPDVC::\(addresses)")
        }
        
        
        
        // Creating a mutable object to add to the contact
        let contact = CNMutableContact()
        contact.imageData = NSData() as Data // The profile picture as a NSData object
        contact.givenName = contactName
        contact.familyName = ""
        
        let workEmail = CNLabeledValue(label: CNLabelWork, value: emailID as NSString)
        let homeEmail = CNLabeledValue(label: CNLabelHome , value: "" as NSString)
        contact.emailAddresses = [homeEmail, workEmail]
        
        contact.phoneNumbers = [CNLabeledValue(
            label:CNLabelPhoneNumberiPhone,
            value:CNPhoneNumber(stringValue:mobileNo))]
        
        let address = CNMutablePostalAddress()
        address.street = addresses
        address.city = city
        address.state = state
        address.postalCode = postalCode
        address.country = country
        
        let workAddress = CNLabeledValue<CNPostalAddress>(label:CNLabelWork, value:address)
        contact.postalAddresses = [workAddress]

        
        return contact
    }
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- Button Action
    @IBAction func buttonCallClickEvent(_ sender: AnyObject) {
     
//        buttonWhatsApp1.isHidden=true
//         buttonWhatsApp2.isHidden=true
         buttonCallTitle.setTitle("Call",  for: UIControl.State.normal)
        SelectFromCallMessageMAil = "Call"
        viewForCallMAilMessagePopUP.isHidden = false
        buttonOpticity.isHidden = false
        buttonCallMessageMailSend.isHidden=true
        
        
      tableMobileActionDetails.reloadData()
        
//        for i in 00..<muarrayKey.count
//        {
//            let mobile = muarrayKey.objectAtIndex(i) as! String
//            print(mobile)
//            
//            if(mobile != "Mobile" && mobile == "Business Phone")
//            {
//                viewTwoMobileNumber.frame=CGRectMake(0, self.viewOneMobileNumber.frame.origin.y, self.viewTwoMobileNumber.frame.size.width, self.viewTwoMobileNumber.frame.size.height)
//            }
//            else
//            {
//                
//            }
//        }
//        
        
        
        
        //
        // PhoneCallAction()
    }
    
    @IBAction func buttonMessageClickEvent(_ sender: AnyObject) {
        
//        buttonWhatsApp1.isHidden=true
//        buttonWhatsApp2.isHidden=true
 
        buttonCallMessageMailSend.isHidden=false
        buttonCallTitle.setTitle("Message",  for: UIControl.State.normal)
        viewForCallMAilMessagePopUP.isHidden = false
        buttonOpticity.isHidden = false
        SelectFromCallMessageMAil = "Message"
        
        flagMSGEmailArray.removeAllObjects()
        flagMSGEmailArray=NSMutableArray()
        
        for i in 00..<numberValueArray.count
        {
            flagMSGEmailArray.add("0")
        }
        
        tableMobileActionDetails.reloadData()


    }
    
    @IBAction func buttonMailClickEvent(_ sender: AnyObject) {
        SelectFromCallMessageMAil = "Email"
        buttonCallTitle.setTitle("Email",  for: UIControl.State.normal)
        if emailValueArray.count==1
        {
            emailStr.append(emailValueArray.object(at: 0) as! String)
            
            MailAction()
        }
        else if emailValueArray.count>1
        {
            buttonCallMessageMailSend.isHidden=false
            viewForCallMAilMessagePopUP.isHidden = false
            buttonOpticity.isHidden = false
            flagMSGEmailArray.removeAllObjects()
            flagMSGEmailArray=NSMutableArray()
            for i in 00..<emailValueArray.count
            {
                flagMSGEmailArray.add("0")
            }
            tableMobileActionDetails.reloadData()
        }
    }
    
    /*"profileID": "46",
     "memberName": "NARENDRA RAO",
     "memberMobile": "+91 9821130855",
     "designation": "IT Software and Hardware services",
     "clubName": "Thane Hills",
     "pixcvcxvc": "http://192.168.2.224:8068/Documents/MemberProfile/1.png",
     "Email": "Naren@kaizeninfotech.com",
     "BusinessName": "Kaizen Infotech Solutions pvt Ltd",
     "BusinessAddress": "\r\n1st Floor, Building A, Gala Ind Complex, Deen Dayal Upadhyay Marg",
     "city": "Mumbai",
     "state": "Maharashtra",
     "country": "India",
     "phoneNo": "2225890055",
     "Fax": ""
     */
    
    /*--------------------------------------------------------------------------------------------------------*/
    //MARK:- Loader Method
//    func loaderViewMethod()
//    {
//        
//        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        if let window = window {
//            window.backgroundColor = UIColor.clear
//            window.rootViewController = UIViewController()
//            window.makeKeyAndVisible()
//        }
//        let Loadingview = UIView()
//        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
//        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
//        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")
//        let gifView = UIImageView()
//        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
//        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
//        gifView.backgroundColor = UIColor.clear
//        //                gifView.contentMode = .Center
//        Loadingview.addSubview(gifView)
//        window?.addSubview(Loadingview)
//        
//    }
    //MARK:- SERVER CALLING
    var varEmailID:String!=""
    
    func containsLetters(input: String) -> Bool {
        var contains:Bool=false
    
        for chr in input.characters {
            if ((chr >= "a" && chr <= "z") || (chr >= "A" && chr <= "Z") ) {
                contains=true
                break
            }
        }
        
        return contains
    }
    
    func functionForGetRotarianDetails(_ memberProfileId:String)
    {
       // loaderViewMethod()
        let completeURL = baseUrl+row_GetMemberSegmentDetails
        let parameterst = ["memberProfileId": varProfileId]
        print(parameterst)
        print(completeURL)
        lblLoading.isHidden=false
        self.lblLoading.text="Loading.. Please Wait"
        tableRotarianDetails.isHidden=true
        
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print(response)
            var dictResponseData:NSDictionary=NSDictionary()
            dictResponseData = response as! NSDictionary
            print(dictResponseData)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
                self.lblLoading.text="Could not connect to server."
            }
            else
            {
            let status = (dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "status") as! String
            if(status == "0")
            {
                
                let varGetMemberName = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "memberName") as! String)
                print(varGetMemberName)
                
                var varGetProfilePic = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "pic") as! String)
                print(varGetProfilePic)
                
                self.isUpperImageAvailable=varGetProfilePic
                
                let varGetMasterUID = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "masterUID") as? String)
                print(varGetMasterUID)
                let varGetMobileNumber = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "memberMobile") as! String)
                print(varGetMobileNumber)
                
                if(varGetMobileNumber.characters.count>6)
                {
                    self.savePhn = varGetMobileNumber
                    self.PhoneNumberSTR = varGetMobileNumber
                    self.muarrayKey.add("Mobile")
                    self.muarrayKeyValue.add(varGetMobileNumber)
                    self.muarrayContactKey.add("Mobile")
                    self.muarrayContactValue.add(varGetMobileNumber)
                }
                else
                {
                }
                //2....
                let SecondaryMobile = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "SecondaryMobile") as! String)
                print(SecondaryMobile)
                print(SecondaryMobile.count)

                if(SecondaryMobile.characters.count>6)
                {
                    self.PhoneNumberSTR = SecondaryMobile
                    self.muarrayKey.add("Mobile")
                    self.muarrayKeyValue.add(SecondaryMobile)
                }
                else
                {
                }
                
                
                
                
                let memberEmail = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "memberEmail") as! String)
                print(memberEmail)
                if(memberEmail.characters.count>0)
                {
                    self.EmailSTR=memberEmail
                    self.muarrayKey.add("Email")
                    self.muarrayKeyValue.add(memberEmail)
                    self.varEmailID = memberEmail
                    self.muarrayContactKey.add("Email")
                    self.muarrayContactValue.add(memberEmail)

                    
                }
                else
                {
                    self.varEmailID = ""
                }
                
                let varGetEmailID = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "Email") as! String)
                print(varGetEmailID)
                if(varGetEmailID.characters.count>0)
                {
                    self.EmailSTR=varGetEmailID
                    self.muarrayKey.add("Business Email")
                    self.muarrayKeyValue.add(varGetEmailID)
                    self.varEmailID = varGetEmailID
                    
                }
                else
                {
                    self.varEmailID = ""
                }
                //----
              
                var varGetBusinessAddress = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "BusinessAddress") as! String)
                print(varGetBusinessAddress)
                self.muarrayContactKey.add("address")
                self.muarrayContactValue.add(varGetBusinessAddress)

                let varGetMemberCity = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "city") as! String)
                self.muarrayContactKey.add("city")
                self.muarrayContactValue.add(varGetMemberCity)

                let varGetMemberState = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "state") as! String)
                print(varGetMemberState)
                self.muarrayContactKey.add("state")
                self.muarrayContactValue.add(varGetMemberState)

                let varGetMemberCountry = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "country") as! String)
                print(varGetMemberCountry)
                self.muarrayContactKey.add("country")
                self.muarrayContactValue.add(varGetMemberCountry)

                
                
                varGetBusinessAddress = varGetBusinessAddress+", "+varGetMemberCity+", "+varGetMemberState//+", "+varGetMemberCountry
                
                
                //Business Address
                print("Full Business address ::: in find a Club ::: \(varGetBusinessAddress)")
               if(varGetBusinessAddress.characters.count>0)
                {
                    let varGetBusinessAddress  = (varGetBusinessAddress as NSString).replacingOccurrences(of: ",,", with: ",")
//                    if(varGetBusinessAddress=="," || varGetBusinessAddress==",,")
//                    {
//
//                    }
                    if (!self.containsLetters(input: varGetBusinessAddress))
                    {
                        print("Not contains any alphabets in address: \( varGetBusinessAddress)")
                    }
                  else
                    {
                        print("contains alphabets in address: \( varGetBusinessAddress)")

                        let pincode = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "pincode") as! String)
                        print(pincode)
                        self.muarrayContactKey.add("pincode")
                        self.muarrayContactValue.add(pincode)

                        let aString = varGetBusinessAddress+", "+pincode+", "+varGetMemberCountry
                        let newString = aString.replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
                        self.muarrayKey.add("Address")
                        self.muarrayKeyValue.add(newString)
                     }
                    }
                else
                {
                }
                
                let varGetBusinessName = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "BusinessName") as! String)
                print(varGetBusinessName)
                
                
                if(varGetBusinessName.characters.count>0)
                {
                    self.muarrayKey.add("Business Name")
                    self.muarrayKeyValue.add(varGetBusinessName)
                }
                else
                {
                    
                }
                let varGetMemberDesignation = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "designation") as! String)
                print(varGetMemberDesignation)
                
                //Designation
                if(varGetMemberDesignation.characters.count>0)
                {
                    self.muarrayKey.add("Designation")
                    self.muarrayKeyValue.add(varGetMemberDesignation)
                }
                else
                {
                    
                }
                
              
                
                
                
                
                let varGetMemberClubName = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "clubName") as! String)
                print(varGetMemberClubName)
               
                print(varGetMemberCity)
                let varGetMemberFaxNumber = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "Fax") as! String)
                print(varGetMemberFaxNumber)
                //
                //                if(varGetMemberFaxNumber.characters.count>0)
                //                {
                //                    self.muarrayKey.addObject("Fax")
                //                    self.muarrayKeyValue.addObject(varGetMemberFaxNumber)
                //                }
                //                else
                //                {
                //
                //                }
                
                
                var varGetMemberPhoneNumber = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "phoneNo") as! String)
                print(varGetMemberPhoneNumber)
                // Mobile Number
                if(varGetMemberPhoneNumber.characters.count>0)
                {
                    
                    if varGetMemberPhoneNumber.hasPrefix("+")
                    {
                        self.muarrayKey.add("Business Phone")
                        self.muarrayKeyValue.add(varGetMemberPhoneNumber)
                    }
                    else
                    {
                        varGetMemberPhoneNumber = "+91"+varGetMemberPhoneNumber
                        self.muarrayKey.add("Business Phone")
                        self.muarrayKeyValue.add(varGetMemberPhoneNumber)
                    }
                }
                else
                {
                }
                let varGetMemberClassification = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "Classification") as! String)
                print(varGetMemberClassification)
                
                //Designation
                if(varGetMemberClassification.characters.count>0)
                {
                    self.muarrayKey.add("Classification")
                    self.muarrayKeyValue.add(varGetMemberClassification)
                }
                else
                {
                    
                }
                /////////----
                let Keywords = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "Keywords") as! String)
                print(Keywords)
                
                //Designation
                if(Keywords.characters.count>0)
                {
                    self.muarrayKey.add("Keywords")
                    self.muarrayKeyValue.add(Keywords)
                }
                else
                {
                    
                }
                /////////------------
                /////////----
                let clubDesignation = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "clubDesignation") as! String)
                print(clubDesignation)
                
                //Designation
                if(clubDesignation.characters.count>0)
                {
                    self.muarrayKey.add("Club Designation")
                    self.muarrayKeyValue.add(clubDesignation)
                     // self.lblClubName.text=clubDesignation+" (Club)"
                }
                else
                {
                    
                }
                //clubName
                let clubNameeee = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "clubName") as! String)
                print(clubNameeee)
                
                //Designation
                if(clubNameeee.characters.count>0)
                {
                    self.muarrayKey.add("Club Name")
                    self.muarrayKeyValue.add(clubNameeee)
                     self.lblClubName.text=clubNameeee
                }
                else
                {
                    
                }
              
                
                
                
                /////////------------
                
                /////////----
                let rotaryid = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "rotaryid") as! String)
                print(rotaryid)
                
                //Designation
                if(rotaryid.characters.count>0)
                {
                    self.muarrayKey.add("Rotary ID")
                    self.muarrayKeyValue.add(rotaryid)
                }
                else
                {
                    
                }
                /////////------------
                /////////----
                let blood_Group = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "blood_Group") as! String)
                print(blood_Group)
                
                //Designation
                if(blood_Group.characters.count>0)
                {
                    /*Comment by Rajendra 29 may as said Seema
                    self.muarrayKey.add("Blood Group")
                    self.muarrayKeyValue.add(blood_Group)
                    */
                }
                else
                {
                    
                }
                /////////------------
                /////////----
                let Donor_Recognition = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "Donor_Recognition") as! String)
                print(Donor_Recognition)
                
                //Designation
                if(Donor_Recognition.characters.count>0)
                {
                    self.muarrayKey.add("Donor Recognition")
                    self.muarrayKeyValue.add(Donor_Recognition)
                }
                else
                {
                    
                }
                /////////------------
                /////////----
                let member_date_of_birth = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "member_date_of_birth") as! String)
                print(member_date_of_birth)
                
                //Designation
                if(member_date_of_birth.characters.count>0)
                {
                    
                    
                    
                    var DOB: String = member_date_of_birth
                    let dobArray = DOB.components(separatedBy: "/")
                    
                    var getMonth: String = dobArray[0]
                   var varPassMonth = commonClassFunction().functionForMonthWordWise(String(getMonth))
                    
                    
                    
                    self.muarrayKey.add("Birthday")
                    self.muarrayKeyValue.add(dobArray[0]+" "+varPassMonth)
                }
                else
                {
                    
                }
                /////////------------
                
                /////////----
                let member_date_of_wedding = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "member_date_of_wedding") as! String)
                print(member_date_of_wedding)
                
                //Designation
                if(member_date_of_wedding.characters.count>0)
                {
                    
                    
                    
                    
                    var DOB: String = member_date_of_wedding
                    let dobArray = DOB.components(separatedBy: "/")
                    
                    var getMonth: String = dobArray[0]
                    var varPassMonth = commonClassFunction().functionForMonthWordWise(String(getMonth))
                    self.muarrayKey.add("Anniversary")
                    self.muarrayKeyValue.add(dobArray[0]+" "+varPassMonth)
                }
                else
                {
                    
                }
                
                let varGetMemberInfo = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "member_info") as! String)
                print(varGetMemberInfo)
                
                //Designation
                if(varGetMemberInfo.characters.count>0)
                {
                    self.muarrayKey.add("Member Introduction")
                    self.muarrayKeyValue.add(varGetMemberInfo)
                }
                else
                {
                    
                }
                
                let varGetFB = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "FaceBook_Txt") as! String)
                print(varGetFB)
                
                //Designation
                if(varGetFB.characters.count>0)
                {
                    self.muarrayKey.add("Facebook")
                    self.muarrayKeyValue.add(varGetFB)
                }
                else
                {
                    
                }
                
                let varGetInsta = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "Instagram_Txt") as! String)
                print(varGetInsta)
                
                //Designation
                if(varGetInsta.characters.count>0)
                {
                    self.muarrayKey.add("Instagram")
                    self.muarrayKeyValue.add(varGetInsta)
                }
                else
                {
                    
                }
                
                let varGetTwit = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "Twitter_Txt") as! String)
                print(varGetTwit)
                
                //Designation
                if(varGetTwit.characters.count>0)
                {
                    self.muarrayKey.add("Twitter")
                    self.muarrayKeyValue.add(varGetTwit)
                }
                else
                {
                    
                }
                
                let varGetLnkd = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "LinkedIn_Txt") as! String)
                print(varGetLnkd)
                
                //Designation
                if(varGetLnkd.characters.count>0)
                {
                    self.muarrayKey.add("Linkedin")
                    self.muarrayKeyValue.add(varGetLnkd)
                }
                else
                {
                    
                }
                
                let varGetWeb = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "Website_Txt") as! String)
                print(varGetWeb)
                
                //Designation
                if(varGetWeb.characters.count>0)
                {
                    self.muarrayKey.add("Website")
                    self.muarrayKeyValue.add(varGetWeb)
                }
                else
                {
                    
                }
                
                let varGetYoutube = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "Youtube_Txt") as! String)
                print(varGetYoutube)
                
                //Designation
                if(varGetYoutube.characters.count>0)
                {
                    self.muarrayKey.add("Youtube")
                    self.muarrayKeyValue.add(varGetYoutube)
                }
                else
                {
                    
                }
                /////////------------
                
                
                if (varGetMobileNumber != "")
                {
                    //self.viewForCallMAilMessagePopUP.frame = CGRectMake(self.viewForCallMAilMessagePopUP.frame.origin.x, self.viewForCallMAilMessagePopUP.frame.origin.y, self.viewForCallMAilMessagePopUP.frame.size.width, self.viewForCallMAilMessagePopUP.frame.size.height-70)
                }
                if (varGetMobileNumber != "" && varGetMemberPhoneNumber != "")
                {
                    //self.viewForCallMAilMessagePopUP.frame = CGRectMake(self.viewForCallMAilMessagePopUP.frame.origin.x, self.viewForCallMAilMessagePopUP.frame.origin.y, self.viewForCallMAilMessagePopUP.frame.size.width, self.viewForCallMAilMessagePopUP.frame.size.height+70)
                }
                
                
                
                if (varGetMobileNumber == "" && varGetMemberPhoneNumber != "")
                {
                    
                    self.PhoneNumberSTR = varGetMemberPhoneNumber
                }
                else
                {
                }
                
                //            if(varGetMobileNumber != "")
                //            {
                //                self.textfieldMobile.hidden = false
                //                self.textfieldMobile.text! = varGetMobileNumber
                //                self.textfieldMobile.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
                //            }
                //            else
                //            {
                //              self.textfieldMobile.hidden = true
                //            }
                
                
                
                
                if(varGetMobileNumber=="" && varGetMemberPhoneNumber == "" && SecondaryMobile == "")
                {
                    
                    self.buttonCall.isUserInteractionEnabled = false
                    self.buttonMessage.isUserInteractionEnabled = false
                    self.buttonCall.setImage(UIImage(named:"call_gray.png"),  for: UIControl.State.normal)
                    self.buttonMessage.setImage(UIImage(named:"message_gray.png"),  for: UIControl.State.normal)
                }
                else
                {
                    self.buttonCall.isUserInteractionEnabled = true
                    self.buttonMessage.isUserInteractionEnabled = true
                    self.buttonCall.setImage(UIImage(named:"blue_call"),  for: UIControl.State.normal)
                    self.buttonMessage.setImage(UIImage(named:"blue_message"),  for: UIControl.State.normal)
                    
                }
                if(varGetEmailID != "")
                {
                    self.textfieldEmail.text! = varGetEmailID
                    self.textfieldEmail.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
                }
                if(varGetEmailID == "" && memberEmail=="" && varGetEmailID.count<5 && memberEmail.count<5)
                {
                    
                    self.buttonMail.isUserInteractionEnabled = false
                    self.buttonMail.setImage(UIImage(named:"mail_gray.png"),  for: UIControl.State.normal)
                }
                else
                {
                    self.buttonMail.isUserInteractionEnabled = true
                    self.buttonMail.setImage(UIImage(named:"blue_mail"),  for: UIControl.State.normal)
                }
                
                
                //            if (varGetMemberPhoneNumber == "")
                //            {
                //                self.textfieldBusinessPhone.text! = ""
                //                self.textfieldBusinessPhone.hidden = true
                //                self.lblHeadingBusinessPhone.hidden = true
                //            }
                //            else
                //            {
                //                self.textfieldBusinessPhone.hidden = false
                //                self.lblHeadingBusinessPhone.hidden = false
                //            }
                
                
                //            if (varGetMemberFaxNumber == "")
                //            {
                //                self.textfieldFax.text! = ""
                //                self.textfieldFax.hidden = true
                //                self.lblHeadingFax.hidden = true
                //            }
                //            else
                //            {
                //                self.textfieldFax.hidden = false
                //                self.lblHeadingFax.hidden = false
                //            }
                //
                self.lblMemberName.text! = varGetMemberName
                self.saveUserName = varGetMemberName
                //self.lblClubName.text! = varGetMemberClubName //varGetMemberDesignation+" - "+varGetMemberClubName
                //            self.textfieldBusinessName.text! = varGetBusinessName
                //            self.textfieldFax.text! = varGetMemberFaxNumber
                //            self.textfieldBusinessPhone.text! = varGetMemberPhoneNumber
                //            self.textfieldAddress.text! = varGetBusinessAddress
                //            self.textfieldDesignation.text! = varGetMemberDesignation
                
                if(varGetProfilePic == "")
                {
                    self.imageRotarianProfileImage.image = UIImage(named: "profile_pic.png")
                }
                else
                {
                    let ImageProfilePic:String = varGetProfilePic.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    self.imageRotarianProfileImage.sd_setImage(with: checkedUrl)
                }
                self.lblLoading.isHidden=true
                self.tableRotarianDetails.isHidden=false
                self.tableRotarianDetails.reloadData()
                self.CallMessageWhatsEmailActionPopup()
            }
            else
            {
                self.lblLoading.text="Failed to load."
                self.window = nil
            }
            self.window = nil
            SVProgressHUD.dismiss()
        }
        })
    }
    
    func CallMessageWhatsEmailActionPopup()
    {
        if muarrayKey.count>0
        {
            for i in 00..<muarrayKey.count
            {
                
                let key=muarrayKey.object(at: i) as! String
                if key=="Mobile" || key=="Business Phone"
                {
                    let values=muarrayKeyValue.object(at: i) as! String
                    print("Values \(values)")
                   
                    if values != "" && values.count>2
                    {
                        numberKeyArray.add(key)
                        numberValueArray.add(values)
                    }
                }
                if key=="Email"
                {
                    let values=muarrayKeyValue.object(at: i) as! String
                    if values != "" && values.count>5
                    {
                        emailKeyArray.add(key)
                        emailValueArray.add(values)
                    }
                }
            }
        }
    }
    
    //MARK:- TABLE METHOD
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView==tableRotarianDetails
        {
            return muarrayKey.count
        }
        else if tableView==tableMobileActionDetails
        {
            if SelectFromCallMessageMAil=="Call" || SelectFromCallMessageMAil=="WhatsApp" || SelectFromCallMessageMAil=="Message"
            {
                return numberValueArray.count
            }
            else if SelectFromCallMessageMAil=="Email"
            {
                return emailValueArray.count
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView==tableRotarianDetails
        {
        let cell : RotarianDetailsTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "RotarianDetailsTableViewCell") as! RotarianDetailsTableViewCell
        
        if(muarrayKey.count>0)
        {
            
            let heading = muarrayKey.object(at: indexPath.row) as! String
            cell.lblHeading.text! = muarrayKey.object(at: indexPath.row) as! String
            if(heading == "Birthday" || heading == "Anniversary") {
                if let convertedDate = convertDateToWords(dateString: muarrayKeyValue.object(at: indexPath.row) as? String ?? "") {
                    print("Converted date: \(convertedDate)")
                    cell.lblKeyValue.text! = convertedDate
                } else {
                    print("Invalid date format")
                }
            } else {
                cell.lblKeyValue.text! = muarrayKeyValue.object(at: indexPath.row) as! String
            }
            print("Hello.........")
            print(muarrayKey.count)
            if(heading == "Email" || heading == "Mobile" || heading == "Business Phone" || heading == "Business Email" || heading == "Facebook" || heading == "Website" || heading == "Instagram" || heading == "Youtube" || heading == "Linkedin" || heading == "Twitter" || heading == "Member Introduction" || heading == "Address" || heading == "Business Address")
            {
                if (heading == "Member Introduction" || heading == "Address" || heading == "Business Address") {
                    cell.lblKeyValue.textColor = UIColor.black
                } else {
                    cell.lblKeyValue.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
                }
                
                cell.tagBtn.isUserInteractionEnabled = true
                cell.tagBtn.tag = indexPath.row
                cell.tagBtn.addTarget(self, action: #selector(labelTapped(_:)), for: .touchUpInside)
            }
            else
                
            {
                cell.tagBtn.isUserInteractionEnabled = false
                cell.lblKeyValue.textColor = UIColor.black
            }
            
        }
        
        return cell as RotarianDetailsTableViewCell
        }
        else if tableView==tableMobileActionDetails
        {
            
            let cell : MobileActionDetailsCell! = tableView.dequeueReusableCell(withIdentifier: "MobileActionDetailsCell") as? MobileActionDetailsCell
            
            cell.lblMobileNumber.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
            cell.btnAction.tag=indexPath.row
            cell.btnCheckUncheck.tag=indexPath.row
            cell.lblMobileNumber.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
            
            if(SelectFromCallMessageMAil != "Email")
            {
                cell.lblTitle.text! = numberKeyArray.object(at: indexPath.row) as! String
                cell.lblMobileNumber.text! = numberValueArray.object(at: indexPath.row) as! String
            }
            
            switch(SelectFromCallMessageMAil)
            {
            case "Call":
                cell.btnAction.setImage(UIImage(named: "call_blue"),  for: UIControl.State.normal)
              //  cell.btnCheckUncheck.isEnabled=false
                break
            case "Message":
                if (flagMSGEmailArray.object(at: indexPath.row) as! String) == "0"
                {
                    cell.btnAction.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                }
                else if (flagMSGEmailArray.object(at: indexPath.row) as! String) == "1"
                {
                    cell.btnAction.setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                }
               // cell.btnCheckUncheck.isEnabled=true
                break
            case "WhatsApp":
                cell.btnAction.setImage(UIImage(named: "whatsWithoutBorder"),  for: UIControl.State.normal)
               // cell.btnCheckUncheck.isEnabled=false
                break
            case "Email":
                if (flagMSGEmailArray.object(at: indexPath.row) as! String) == "0"
                {
                    cell.btnAction.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                }
                else if (flagMSGEmailArray.object(at: indexPath.row) as! String) == "1"
                {
                    cell.btnAction.setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                }
                cell.lblTitle.text! = emailKeyArray.object(at: indexPath.row) as! String
                cell.lblMobileNumber.text! = emailValueArray.object(at: indexPath.row) as! String
              //  cell.btnCheckUncheck.isEnabled=true
                break
            default:
                break
            }
            
            cell.btnAction.addTarget(self, action: #selector(cellCommonButtonClickEvent(_:)), for:UIControl.Event.touchUpInside)
            
            cell.btnCheckUncheck.addTarget(self, action: #selector(cellCommonButtonClickEvent(_:)), for:UIControl.Event.touchUpInside)
            
            return cell as MobileActionDetailsCell
        }
        return UITableViewCell()
    }
    
    @objc func labelTapped(_ sender: UIButton) {
        print("Label tapped!")
        let lblTag = sender.tag
        print("lblTag:: \(lblTag)")
            let key = muarrayKey.object(at: lblTag) as? String
            var value = muarrayKeyValue.object(at: lblTag) as? String
            if key == "Facebook" || key == "Instagram" || key == "Linkedin" || key == "Website" || key == "Twitter" {
                let webScreen = self.storyboard?.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
                webScreen.varOpenUrl = value
                webScreen.navTitle = key ?? ""
                print(webScreen.varOpenUrl)
                self.navigationController?.pushViewController(webScreen, animated: true)
            }
        
        if key == "Business Email" || key == "Email" {
            print("MAIL--\(value)")
            if let mailValue = value {
                print("MAIL--\(mailValue)")
                var mails = [String]()
                mails.append(mailValue)
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients(mails)      // gg@hing.co.in
                    mail.setMessageBody("", isHTML: true)
                    present(mail, animated: true, completion: nil)
                }
                else
                {
                    if let mailValue = value {
                        sendEmailFallback(mail: mailValue)
                     }
                    
                }
            }
        }
        
        if key == "Member Introduction" {
            let memberIntroVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfileMemberIntroViewController") as! ProfileMemberIntroViewController
            memberIntroVC.desc = value ?? ""
            memberIntroVC.navTitle = "Member Introduction"
            self.navigationController?.pushViewController(memberIntroVC, animated: true)
        }
        
        if key == "Address" || key == "Business Address" {
            let memberIntroVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfileMemberIntroViewController") as! ProfileMemberIntroViewController
            memberIntroVC.desc = value ?? ""
            memberIntroVC.navTitle = "Address"
            self.navigationController?.pushViewController(memberIntroVC, animated: true)
        }

          
        if key == "Mobile Number" || key == "Secondary Mobile Number" || key == "Mobile" || key == "Business Phone" {
            value = value?.replacingOccurrences(of: " ", with: "")
            print("calling\(value)")
            if value?.characters.count ?? 0 > 1
            {
                if let mob = value {
//                    let url = URL(string: "tel://\(mob)")
//                    UIApplication.shared.openURL(url!)
                    if let url = URL(string: "tel://\(mob)"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        print("Unable to make a call. Invalid phone number or URL.")
                    }
                }
            }
            else
            {
            }
        }
     
    }
        
        func sendEmailFallback(mail: String) {
            let recipientEmail = mail // Replace with the recipient email address
            
            let emailURLString = "mailto:\(recipientEmail)"
            if let emailURL = URL(string: emailURLString) {
                if UIApplication.shared.canOpenURL(emailURL) {
                    UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
                } else {
                    // Provide an alert indicating that email sending is not available
                    let alert = UIAlertController(title: "Error", message: "Email sending is not available on this device.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView==tableMobileActionDetails
        {
            return 80.0
        }
        else
        {
            return 100.0
        }
    }
    
    func convertDateToWords(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM"
        
        if let date = dateFormatter.date(from: dateString) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "dd"
            let day = dayFormatter.string(from: date)
            
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMM"
            let month = monthFormatter.string(from: date)
            
            return "\(day) \(month)"
        } else {
            return nil // Handle invalid date format
        }
    }

    
    @IBAction func cellCommonButtonClickEvent(_ sender: UIButton)
    {
        
        print(sender.tag)
        var letGetPhoneNumber:String=""
        switch(SelectFromCallMessageMAil)
        {
        case "Call":
            letGetPhoneNumber=numberValueArray.object(at: sender.tag) as! String
            if(letGetPhoneNumber.hasPrefix("+"))
            {
                let PhoneNumberSTR:String = letGetPhoneNumber.replacingOccurrences(of: " ", with: "")
//                let url = URL(string: "tel://\(PhoneNumberSTR)")
//                UIApplication.shared.openURL(url!)
                if let url = URL(string: "tel://\(PhoneNumberSTR)"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    print("Unable to make a call. Invalid phone number or URL.")
                }
            }
            else
            {
                let trimmedString = letGetPhoneNumber.trimmingCharacters(in: CharacterSet.whitespaces)
                let url:URL = URL(string: "telprompt://"+trimmedString+"")!
                UIApplication.shared.openURL(url)
            }
            break
        case "Message":
            if((flagMSGEmailArray.object(at: sender.tag) as! String)=="0")
            {
                flagMSGEmailArray.replaceObject(at: sender.tag, with: "1")
            }
            else
            {
                flagMSGEmailArray.replaceObject(at: sender.tag, with: "0")
            }
            tableMobileActionDetails.reloadData()
            
            break
        case "WhatsApp":
            letGetPhoneNumber=numberValueArray.object(at: sender.tag) as! String
            let varGetValue=letGetPhoneNumber
            let string = varGetValue.replacingOccurrences(of: "+", with: "")
            let newString = string.replacingOccurrences(of: " ", with: "")
            if(newString.characters.count>7)
            {
                var varGetValue=newString
                let urlWhats = "https://wa.me/\(varGetValue)"
                    if let whatsappURL = URL(string: urlWhats) {
                        if UIApplication.shared.canOpenURL(whatsappURL) {
//                            UIApplication.shared.openURL(whatsappURL)
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
            
            break
        case "Email":
            
            if((flagMSGEmailArray.object(at: sender.tag) as! String)=="0")
            {
                flagMSGEmailArray.replaceObject(at: sender.tag, with: "1")
            }
            else
            {
                flagMSGEmailArray.replaceObject(at: sender.tag, with: "0")
            }
            
            tableMobileActionDetails.reloadData()
        default:
            break
        }
        
    }
    
    
    @IBAction func buttonOpticityClickEvent(_ sender: AnyObject)
    {
        buttonOpticity.isHidden = true
        buttonCallMessageMailSend.isHidden=true
        buttonCallTitle.setTitle("",  for: UIControl.State.normal)
        buttonCallMessageMailSend.isHidden=true
        tableMobileActionDetails.reloadData()
        phoneStr.removeAll()
        CheckUncheckMailMessage = 0
        CheckUncheckMailMessage2 = 0
        emailStr.removeAll()
        buttonOpticity.isHidden = true
        viewForCallMAilMessagePopUP.isHidden=true
    }
    @IBAction func buttonPersonalMobileCheckUncheckClickEvent(_ sender: AnyObject)
    {
        // imagePersonalMobileCheckUncheck.image = UIImage(named: "CHECK_BLUE_ROW")
        
        
        if (SelectFromCallMessageMAil == "Call")
        {
            PhoneCallAction()
        }
        else  if (SelectFromCallMessageMAil == "whatsapp")
        {
            print("this is whats aap")
            
            var varGetValue=PhoneNumberSTR
            let string = varGetValue.replacingOccurrences(of: "+", with: "")
            let newString = string.replacingOccurrences(of: " ", with: "")
            if(newString.characters.count>7)
            {
                var varGetValue=newString
                let urlWhats = "https://wa.me/\(varGetValue)"
                    if let whatsappURL = URL(string: urlWhats) {
                        if UIApplication.shared.canOpenURL(whatsappURL) {
//                            UIApplication.shared.openURL(whatsappURL)
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
            
            //SelectFromCallMessageMAil = "whatsapp"
        else if (SelectFromCallMessageMAil == "Message")
        {
            if(CheckUncheckMailMessage==0)
            {
                
                //SMSAction()
                CheckUncheckMailMessage = 1
                phoneStr.append(PhoneNumberSTR)
                print(phoneStr)
                
            }
            else
            {
                //SMSAction()
                phoneStr.removeLast()
                CheckUncheckMailMessage = 0
                 print(phoneStr)
            }
            
            
        }
        else
        {
            
        }
        
        
        
    }
    
    @IBAction func buttonBusinessMobileCheckUncheckClickEvent(_ sender: AnyObject)
    {
        //imagePersonalMobileCheckUncheck.image = UIImage(named: "CHECK_BLUE_ROW")
        if (SelectFromCallMessageMAil == "Call")
        {
            PhoneCallAction()
        }
        else if (SelectFromCallMessageMAil == "Message")
        {
            
            if(CheckUncheckMailMessage2==0)
            {
                CheckUncheckMailMessage2 = 1
                phoneStr.append(PhoneNumberSTR)
                //SMSAction()
                 print(phoneStr)
            }
            else
            {
                phoneStr.removeLast()
                CheckUncheckMailMessage2 = 0
                print(phoneStr)
            }
        }
        else
        {
            
        }
        
        
    }
    
    @IBAction func buttonCallMessageMailSendClickEvent(_ sender: AnyObject)
    {
        print(flagMSGEmailArray)
        
        if (SelectFromCallMessageMAil == "Message")
        {
            SMSAction()
        }
        else if(SelectFromCallMessageMAil == "Email")
        {
            MailAction()
        }
        else
        {
            phoneStr.removeAll()
            emailStr.removeAll()
            CheckUncheckMailMessage = 0
            CheckUncheckMailMessage2 = 0
        }
    }
    @IBAction func buttonPopUpCloseClickEvent(_ sender: AnyObject) {
        buttonCallTitle.setTitle("",  for: UIControl.State.normal)
        buttonCallMessageMailSend.isHidden=true
        phoneStr.removeAll()
        emailStr.removeAll()
        tableMobileActionDetails.reloadData()

        CheckUncheckMailMessage = 0
        CheckUncheckMailMessage2 = 0
        buttonOpticity.isHidden = true
        viewForCallMAilMessagePopUP.isHidden=true
    }
    
}
