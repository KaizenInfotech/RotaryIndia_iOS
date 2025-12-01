//
//  RotarianProfileBusinessDetailsViewController.swift
//  TouchBase
//
//  Created by rajendra on 22/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import MessageUI
import Alamofire
import ContactsUI
import Contacts
//import Kingfisher
import Foundation


class RotarianProfileBusinessDetailsViewController: UIViewController , UITextFieldDelegate , UIScrollViewDelegate , MFMailComposeViewControllerDelegate , MFMessageComposeViewControllerDelegate , UITableViewDataSource , UITableViewDelegate, CNContactViewControllerDelegate {
    
    var isUpperImageAvailable:String!=""
   
    
    @IBOutlet weak var labelCallorMessageorEmail: UIButton!
  //  @IBOutlet weak var imageCall1: UIImageView!
  //  @IBOutlet weak var imageCall2: UIImageView!
    @IBOutlet weak var buttonCallMessageMailSend: UIButton!
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var tableRotarianDetails: UITableView!
    
    @IBOutlet weak var lblLoading: UILabel!
    @IBOutlet weak var tableMobileActionDetails: UITableView!
   // @IBOutlet weak var imagePersonalMobileCheckUncheck: UIImageView!
   // @IBOutlet weak var viewOneMobileNumber: UIView!
   // @IBOutlet weak var viewTwoMobileNumber: UIView!
 //   @IBOutlet weak var lblPersonalMobileNumber: UILabel!
 //   @IBOutlet weak var buttonPersonalMobileCheckUncheck: UIButton!
  //  @IBOutlet weak var imageBusinessMobileCheckUncheck: UIImageView!
 //   @IBOutlet weak var lblBusinessMobileNumber: UILabel!
  //  @IBOutlet weak var buttonBusinessMobileCheckUncheck: UIButton!
    @IBOutlet weak var viewForCallMAilMessagePopUP: UIView!
 //   @IBOutlet weak var lblHeadingPOpUpMobileNumberMAil: UILabel!
  //  @IBOutlet weak var lblHeadingPopUpbussinessNumberMail: UILabel!
    
    
    var phoneStr = [String]()
    var emailStr = [String]()
    var muarrayKey:NSMutableArray=NSMutableArray()
    var muarrayKeyValue:NSMutableArray=NSMutableArray()
    var muarrayContactKey:NSMutableArray=NSMutableArray()
    var muarrayContactValue:NSMutableArray=NSMutableArray()

    var SelectFromCallMessageMAil:String!=""
    var CheckUncheckMailMessage:Int = 0
    var CheckUncheckMailMessage2:Int = 0
    var buttonAction:String!=""
    
    var numberValueArray:NSMutableArray=NSMutableArray()
    var emailValueArray:NSMutableArray=NSMutableArray()
    var numberKeyArray:NSMutableArray=NSMutableArray()
    var emailKeyArray:NSMutableArray=NSMutableArray()
    var flagMSGEmailArray:NSMutableArray=NSMutableArray()
    /***************************************************************/
    
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
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    
    var savePhn = ""
    var saveUserName = ""
    
    @IBOutlet weak var lblClubName: UILabel!
    @IBOutlet weak var lblMemberName: UILabel!
    var PhoneNumberSTR  : String = ""
    var EmailSTR  : String =  ""
    var varMemberProfileID:String! = ""
    
    
    var varEmailID:String!=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myScrollView.isHidden=true
        print("this is rotarian profile business details view controller . swift")
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
    
    
    @IBAction func buttonImageviewBigClickEvent(_ sender: AnyObject) {
        buttonPicBigViewClickEvent()
    }
    
    
    
    func buttonPicBigViewClickEvent()
    {
        isUpperImageAvailable = isUpperImageAvailable.replacingOccurrences(of: " ", with: "%20")
        
        
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
    
    func functionForImageCurv()
    {
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

       // PhoneNumberSTR = textfieldMobile.text!
        print("SMS sent to ")
            print(phoneStr)
        let messageVC = MFMessageComposeViewController()
        messageVC.body = ""
        messageVC.recipients = phoneStr // [PhoneNumberSTR] // Optionally add some tel numbers
        messageVC.messageComposeDelegate = self
        // Open the SMS View controller
        present(messageVC, animated: true, completion: nil)
            
        }
        else
        {
            self.view.makeToast("Please select at least one contact number",
                                duration: 2, position: CSToastPositionCenter)
   
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
        shareButton.addTarget(self, action: #selector(RotarianProfileBusinessDetailsViewController.shareContact), for: UIControl.Event.touchUpInside)
        let sharing: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
        var buttons:NSArray=NSArray()
        buttons = [sharing]
        
        let saveContactButton = UIButton(type: UIButton.ButtonType.custom)
        saveContactButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        saveContactButton.setImage(UIImage(named:"saveContact"),  for: UIControl.State.normal)
        saveContactButton.addTarget(self, action: #selector(RotarianProfileBusinessDetailsViewController.savedContactButtonclicked), for: UIControl.Event.touchUpInside)
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
        
        print("filename : \(filename)")
        print("contact: \(data)")
        
        //   try data.writeToURL(fileURL, options: [.AtomicWrite])
        try data.write(to: fileURL, options: [.atomicWrite])
        let activityViewController = UIActivityViewController(
            activityItems: [fileURL],
            applicationActivities: nil
        )
        
        present(activityViewController, animated: true, completion: {})
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
        var note:String=""
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
                let addresss=muarrayContactValue.object(at: i) as! String
                addresses=addresss.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\'", with: "").replacingOccurrences(of: ",", with: " ")
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
            if varGetKeyValue=="Classification" && note == ""
            {
                note=muarrayContactValue.object(at: i) as! String
            }
          print("Address removing slash RPBDVC::\(addresses)")
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
        address.street = addresses.trimmingCharacters(in: .newlines)
        address.city = city
        address.state = state
        address.postalCode = postalCode
        address.country = country
        
        let workAddress = CNLabeledValue<CNPostalAddress>(label:CNLabelWork, value:address)
        contact.postalAddresses = [workAddress]
        contact.note=note
        return contact
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Button Action
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
            
            let string = letGetPhoneNumber.replacingOccurrences(of: "+", with: "")
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
    

    @IBOutlet weak var buttonWhatsApp: UIButton!
    
    @IBAction func buttonWhatsAppClickEvent(_ sender: Any)
    {
        labelCallorMessageorEmail.setTitle("WhatsApp",  for: UIControl.State.normal)
        SelectFromCallMessageMAil = "WhatsApp"
        viewForCallMAilMessagePopUP.isHidden = false
        buttonOpticity.isHidden = false
        buttonCallMessageMailSend.isHidden=true
        tableMobileActionDetails.reloadData()
    }
    
    @IBAction func buttonCallClickEvent(_ sender: AnyObject) {
        labelCallorMessageorEmail.setTitle("Call",  for: UIControl.State.normal)
        SelectFromCallMessageMAil = "Call"
        viewForCallMAilMessagePopUP.isHidden = false
        buttonOpticity.isHidden = false
        buttonCallMessageMailSend.isHidden=true
        
          tableMobileActionDetails.reloadData()
//
//        for i in 00..<muarrayKey.count
//        {
//            let mobile = muarrayKey.objectAtIndex(i) as! String
//            print(mobile)
//            
//            if(mobile != "Mobile" && mobile == "Business Phone")
//            {
//                viewTwoMobileNumber.frame=CGRectMake(0, 50, self.viewTwoMobileNumber.frame.size.width, self.viewTwoMobileNumber.frame.size.height)
//            }
//            if(mobile == "Mobile" && mobile == "Business Phone")
//            {
//                viewOneMobileNumber.frame=CGRectMake(0, 50, self.viewOneMobileNumber.frame.size.width, self.viewOneMobileNumber.frame.size.height)
//                viewTwoMobileNumber.frame=CGRectMake(0, self.viewOneMobileNumber.frame.size.height+100, self.viewTwoMobileNumber.frame.size.width, self.viewTwoMobileNumber.frame.size.height)
//            }
//            else
//            {
// 
//            }
//        }
        
        
        
        
        //
       // PhoneCallAction()
    }
    
    @IBAction func buttonMessageClickEvent(_ sender: AnyObject) {
        buttonOpticity.isHidden = false
        labelCallorMessageorEmail.setTitle("Message",  for: UIControl.State.normal)
        buttonCallMessageMailSend.isHidden=false
        viewForCallMAilMessagePopUP.isHidden = false
        SelectFromCallMessageMAil = "Message"
        flagMSGEmailArray.removeAllObjects()
        flagMSGEmailArray=NSMutableArray()
        
        for i in 00..<numberValueArray.count
        {
            flagMSGEmailArray.add("0")
        }
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

            }

    @IBAction func buttonMailClickEvent(_ sender: AnyObject) {
        labelCallorMessageorEmail.setTitle("Email",  for: UIControl.State.normal)

        //imageCall1.isHidden = true
        //imageCall2.isHidden = true
        SelectFromCallMessageMAil = "Email"
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
     "pic": "http://192.168.2.224:8068/Documents/MemberProfile/1.png",
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
        //loaderViewMethod()
        let completeURL = baseUrl+row_GetFindRotarianDetails
        let parameterst = ["memberProfileId": memberProfileId]
        
        print("Roterian parameterst:: \(parameterst)")
        print("Roterian completeURL:: \(completeURL)")
        lblLoading.isHidden=false
        lblLoading.text="Loading.. Please Wait"
        tableRotarianDetails.isHidden=true
        
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            var dictResponseData:NSDictionary=NSDictionary()
            dictResponseData = response as! NSDictionary
            print("RPBDVC response: \(dictResponseData)")
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
                    self.muarrayContactKey.add("memberName")
                    self.muarrayContactValue.add(varGetMemberName)
                    
                    var varGetProfilePic = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "pic") as! String)
                    print(varGetProfilePic)
                    
                    self.isUpperImageAvailable=varGetProfilePic
                    
                    
                    
                    let varGetMasterUID = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "masterUID") as? String)
                    print(varGetMasterUID)
                    let varGetMobileNumber = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "memberMobile") as! String)
                    print(varGetMobileNumber)
                    self.muarrayContactKey.add("Mobile")
                    self.muarrayContactValue.add(varGetMobileNumber)
                    self.savePhn = varGetMobileNumber
                    self.saveUserName = varGetMemberName

                    
                    if(varGetMobileNumber.characters.count>0 && varGetMobileNumber != " ")
                    {
                        print("varGetMobileNumber::\(varGetMobileNumber)fff")
                        self.PhoneNumberSTR = varGetMobileNumber
                        self.muarrayKey.add("Mobile")
                        self.muarrayKeyValue.add(varGetMobileNumber)
                    }
                   
                    //here need to add secondary mobile number
                    
                    let SecondaryMobile = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "SecondaryMobile") as! String)
                    print(SecondaryMobile)
                    if(SecondaryMobile.characters.count>0 && SecondaryMobile != " ")
                    {
                        print("SecondaryMobile ::\(SecondaryMobile)ttt")
                        self.PhoneNumberSTR = SecondaryMobile
                        self.muarrayKey.add("Secondary Mobile")
                        self.muarrayKeyValue.add(SecondaryMobile)
                    }

                   
                    //need to add memberEmail
                    let memberEmail = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "memberEmail") as! String)
                    print(memberEmail)
                    

                    
                    //Email
                    
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
                    
                    
                    //Email
                    
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
                    var varGetBusinessAddress = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "BusinessAddress") as! String)
                    print(varGetBusinessAddress)
                    self.muarrayContactKey.add("address")
                    self.muarrayContactValue.add(varGetBusinessAddress)

                    let varGetMemberCity = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "city") as! String)
                    self.muarrayContactKey.add("city")
                    self.muarrayContactValue.add(varGetMemberCity)

                    let varGetMemberState = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "state") as! String)
                    self.muarrayContactKey.add("state")
                    self.muarrayContactValue.add(varGetMemberState)

                    print(varGetMemberState)
                    let varGetMemberCountry = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "country") as! String)
                    self.muarrayContactKey.add("country")
                    self.muarrayContactValue.add(varGetMemberCountry)

                    let varGetMemberpincode = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "pincode") as! String)
                    print(varGetMemberCountry)
                    self.muarrayContactKey.add("pincode")
                    self.muarrayContactValue.add(varGetMemberpincode)

                    if(varGetMemberpincode.characters.count>0)
                    {
                        varGetBusinessAddress = varGetBusinessAddress+", "+varGetMemberCity+", "+varGetMemberState+","+varGetMemberpincode+", "+varGetMemberCountry
                    }
                    else  if(varGetBusinessAddress.characters.count>0 || varGetMemberCity.characters.count>0 || varGetMemberCountry.characters.count>0 || varGetMemberCountry.characters.count>0 ||  varGetMemberpincode.characters.count>0)
                    {
                        varGetBusinessAddress = varGetBusinessAddress+", "+varGetMemberCity+", "+varGetMemberState+", "+varGetMemberCountry
                    }
                    
                    
                    
                    
                    
                    
                    print("Full Business address ::: in find a Rotarian ::: \(varGetBusinessAddress)")
                    
                    //Business Address
                    if(varGetBusinessAddress.characters.count>0)
                    {
                        let varGetBusinessAddress  = (varGetBusinessAddress as NSString).replacingOccurrences(of: ",,", with: ",")
//                        if(varGetBusinessAddress=="," || varGetBusinessAddress==",,")
//                        {
//
//                        }
                        if (!self.containsLetters(input: varGetBusinessAddress))
                        {
                            print("Not contains any alphabets in address: \( varGetBusinessAddress)")

                        }
                        else
                        {
                            print("contains alphabets in address: \( varGetBusinessAddress)")

                            let aString = varGetBusinessAddress
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
                    
                    
                    var varGetMemberPhoneNumber = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "phoneNo") as! String)
                    print(varGetMemberPhoneNumber)
                    // Mobile Number
                    if(varGetMemberPhoneNumber.characters.count>0)
                    {
                        
                        if varGetMemberPhoneNumber.hasPrefix("+")
                        {
                            self.muarrayKey.add("Business Phone")
                            self.muarrayKeyValue.add(varGetMemberPhoneNumber)
                            //self.lblBusinessMobileNumber.text! = varGetMemberPhoneNumber
                        }
                        else
                        {
                            varGetMemberPhoneNumber = "+91"+varGetMemberPhoneNumber
                            self.muarrayKey.add("Business Phone")
                            self.muarrayKeyValue.add(varGetMemberPhoneNumber)
                            // self.lblBusinessMobileNumber.text! = varGetMemberPhoneNumber
                        }
                    }
                    else
                    {
                        // self.viewTwoMobileNumber.isHidden = true
                    }
                    
                    
                    
                    
                    let varGetMemberClassification = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "Classification") as! String)
                    print(varGetMemberClassification)
                    if(varGetMemberClassification.characters.count>0)
                    {
                        self.muarrayKey.add("Classification")
                        self.muarrayKeyValue.add(varGetMemberClassification)
                        self.muarrayContactKey.add("Classification")
                        self.muarrayContactValue.add(varGetMemberClassification)

                    }
                    else
                    {
                        
                    }
                    
                    
                    
                    
                    let varGetMemberClubName = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "clubName") as! String)
                    print(varGetMemberClubName)
                    
                    print(varGetMemberCity)
                    let varGetMemberFaxNumber = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "Fax") as! String)
                    print(varGetMemberFaxNumber)
                    
                    
                    //---need to work later by Rajendra Jat 15.05.2019
                    let Keywords = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "Keywords") as! String)
                    print(Keywords)
                    if(Keywords.characters.count>0)
                    {
                        self.muarrayKey.add("Keywords")
                        self.muarrayKeyValue.add(Keywords)
                    }
                    else
                    {
                        
                    }
                    
                    
                    let clubDesignation = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "clubDesignation") as! String)
                    print(clubDesignation)
                    if(clubDesignation.characters.count>0)
                    {
                        self.muarrayKey.add("Club Designation")
                        self.muarrayKeyValue.add(clubDesignation)
                       // self.lblClubName.text=clubDesignation+" (Club)"
                    }
                    else
                    {
                        
                    }
                    //-------------------
                    let clubNameee = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "clubName") as! String)
                    print(clubNameee)
                    if(clubNameee.characters.count>0)
                    {
                        self.muarrayKey.add("Club Name")
                        self.muarrayKeyValue.add(clubNameee)
                        self.lblClubName.text=clubNameee
                        self.lblClubName.text=clubNameee


                    }
                    else
                    {
                        
                    }
                    //-----------------
                    let blood_Group = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "blood_Group") as! String)
                    print(blood_Group)
                    if(blood_Group.characters.count>0)
                    {
                    }
                    else
                    {
                        
                    }
                    
                    
                    
                    
                    let Donor_Recognition = (((dictResponseData.value(forKey: "TBGetRotarianResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "Donor_Recognition") as! String)
                    print(Donor_Recognition)
                    if(Donor_Recognition.characters.count>0)
                    {
                        self.muarrayKey.add("Donor Recognition")
                        self.muarrayKeyValue.add(Donor_Recognition)
                    }
                    else
                    {
                        
                    }
                    
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
                    
                    
                    
                    
                    
                    

                    if (varGetMobileNumber == "" && varGetMemberPhoneNumber != "")
                    {
                        self.PhoneNumberSTR = varGetMemberPhoneNumber
                    }
                    
                    
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
                    
                    
                    self.lblMemberName.text! = varGetMemberName
                   // self.lblClubName.text! = varGetMemberClubName
                    
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
                    self.window = nil
                    print("No Results")
                    self.lblLoading.text="Failed to load."
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
                    if values != ""
                    {
                     numberKeyArray.add(key)
                        numberValueArray.add(values)
                    }
                }
                if key=="Email"
                {
                    let values=muarrayKeyValue.object(at: i) as! String
                    print("EmailValues \(values)")
                    if values != ""
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
            print("Hello.........\(indexPath.row)")
            print(muarrayKey.count)
            
            if(heading == "Email" || heading == "Mobile" || heading == "Business Phone" || heading == "Business Email" || heading == "Facebook" || heading == "Website" || heading == "Instagram" || heading == "Youtube" || heading == "Linkedin" || heading == "Twitter" || heading == "Member Introduction" || heading == "Address" || heading == "Business Address" || heading == "Secondary Mobile")
            {
                if (heading == "Member Introduction" || heading == "Address" || heading == "Business Address") {
                    cell.lblKeyValue.textColor = UIColor.black
                } else {
                    cell.lblKeyValue.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
                }
                cell.btnTag.isUserInteractionEnabled = true
                cell.btnTag.tag = indexPath.row
                cell.btnTag.addTarget(self, action: #selector(labelTapped(_:)), for: .touchUpInside)
            }
            else
                
            {
                cell.btnTag.isUserInteractionEnabled = false
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
              //   cell.btnCheckUncheck.isEnabled=false
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
             //   cell.btnCheckUncheck.isEnabled=true
                break
            case "WhatsApp":
                cell.btnAction.setImage(UIImage(named: "whatsWithoutBorder"),  for: UIControl.State.normal)
              //   cell.btnCheckUncheck.isEnabled=false
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
              //   cell.btnCheckUncheck.isEnabled=true
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
            if key == "Facebook" || key == "Instagram" || key == "Linkedin" || key == "Website" {
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
        
          
        if key == "Mobile Number" || key == "Secondary Mobile" || key == "Mobile" || key == "Business Phone" {
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
    
    @IBAction func buttonOpticityClickEvent(_ sender: AnyObject)
    {
        buttonOpticity.isHidden = true
        labelCallorMessageorEmail.setTitle("",  for: UIControl.State.normal)
        buttonCallMessageMailSend.isHidden=true
        tableMobileActionDetails.reloadData()
        phoneStr.removeAll()
        CheckUncheckMailMessage = 0
        CheckUncheckMailMessage2 = 0
        emailStr.removeAll()
        buttonOpticity.isHidden = true
        viewForCallMAilMessagePopUP.isHidden=true
    }
    
    @IBAction func buttonPersonalMobileCheckUncheckClickEvent(_ sender: UIButton)
    {
        let indexRow=sender.tag
        let cell:MobileActionDetailsCell=tableMobileActionDetails.cellForRow(at: NSIndexPath.init(index: indexRow) as IndexPath) as! MobileActionDetailsCell
        
        if (SelectFromCallMessageMAil == "Message")
        {
             if(CheckUncheckMailMessage==0)
             {
                cell.btnAction.setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                PhoneNumberSTR = cell.lblMobileNumber.text!
               // SMSAction()
                CheckUncheckMailMessage = 1
                phoneStr.append(PhoneNumberSTR)
             }
            else
             {
                //SMSAction()
                CheckUncheckMailMessage = 0
                //imagePersonalMobileCheckUncheck.hidden = false
                
                phoneStr.removeLast()
            }
        }
//         else if (SelectFromCallMessageMAil == "WhatsApp")
//        {
//            print("me clicked !!22222222")
//
//             PhoneNumberSTR = lblPersonalMobileNumber.text!
//
//            var varGetValue=PhoneNumberSTR.components(separatedBy: " ")
//            let urlWhats = "whatsapp://send?phone='\(varGetValue)'"
//            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
//                if let whatsappURL = URL(string: urlString) {
//                    if UIApplication.shared.canOpenURL(whatsappURL) {
//                        UIApplication.shared.openURL(whatsappURL)
//                    } else {
//                        print("Install Whatsapp")
//                        let alertView:UIAlertView = UIAlertView()
//                        alertView.title = "Rotary India"
//                        alertView.message = "WhatsApp is not installed"
//                        alertView.delegate = self
//                        alertView.addButton(withTitle: "OK")
//                        alertView.show()
//                    }
//                }
//            }
//        }
 
    }
    
//    @IBAction func buttonBusinessMobileCheckUncheckClickEvent(_ sender: AnyObject)
//    {
//        //imagePersonalMobileCheckUncheck.image = UIImage(named: "CHECK_BLUE_ROW")
//
//
//        if (SelectFromCallMessageMAil == "Call")
//        {
//            imageCall2.image = UIImage(named: "call_blue")
//            imageCall2.isHidden = false
//        imageBusinessMobileCheckUncheck.isHidden = true
//        PhoneNumberSTR = lblBusinessMobileNumber.text!
//        PhoneCallAction()
//        }
//        else if (SelectFromCallMessageMAil == "Message")
//        {
//
//            if(CheckUncheckMailMessage2==0)
//            {
//
//                imageCall2.image = UIImage(named: "blue_message")
//                imageCall2.isHidden = true
//                imageBusinessMobileCheckUncheck.image = UIImage(named: "CHECK_BLUE_ROW")
//                imageBusinessMobileCheckUncheck.isHidden = false //Need to change
//                PhoneNumberSTR = lblBusinessMobileNumber.text!
//                CheckUncheckMailMessage2 = 1
//                phoneStr.append(PhoneNumberSTR)
//                 //SMSAction()
//            }
//            else
//            {
//                CheckUncheckMailMessage2 = 0
//                imageBusinessMobileCheckUncheck.isHidden = false // Need to change
//                imageBusinessMobileCheckUncheck.image = UIImage(named: "UN_CHECK_BLUE_ROW")
//                phoneStr.removeLast()
//            }
//        }
//            //  SelectFromCallMessageMAil = "WhatsApp"
//        else if (SelectFromCallMessageMAil == "WhatsApp")
//        {
//            print("me clicked !!!1")
//                PhoneNumberSTR = lblBusinessMobileNumber.text!
//            var varGetValue=PhoneNumberSTR.components(separatedBy: " ")
//            let urlWhats = "whatsapp://send?phone='\(varGetValue)'"
//            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
//                if let whatsappURL = URL(string: urlString) {
//                    if UIApplication.shared.canOpenURL(whatsappURL) {
//                        UIApplication.shared.openURL(whatsappURL)
//                    } else {
//                        print("Install Whatsapp")
//                        let alertView:UIAlertView = UIAlertView()
//                        alertView.title = "Rotary India"
//                        alertView.message = "WhatsApp is not installed"
//                        alertView.delegate = self
//                        alertView.addButton(withTitle: "OK")
//                        alertView.show()
//                    }
//                }
//            }
//
//        }
//
//
//    }
    
    
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

    @IBAction func buttonCallMessageMailSendClickEvent(_ sender: UIButton)
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

    }
    @IBAction func buttonPopUpCloseClickEvent(_ sender: AnyObject) {
        labelCallorMessageorEmail.setTitle("",  for: UIControl.State.normal)
        buttonCallMessageMailSend.isHidden=true
        tableMobileActionDetails.reloadData()
        phoneStr.removeAll()
        emailStr.removeAll()
        CheckUncheckMailMessage = 0
        CheckUncheckMailMessage2 = 0
        buttonOpticity.isHidden = true
        viewForCallMAilMessagePopUP.isHidden=true
    }
    
}
