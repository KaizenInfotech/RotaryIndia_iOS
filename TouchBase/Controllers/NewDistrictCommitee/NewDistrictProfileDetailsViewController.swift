
//
//  NewDistrictProfileDetailsViewController.swift
//  TouchBase
//
//  Created by rajendra on 13/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import MessageUI
import Foundation
import SVProgressHUD
import Contacts
import ContactsUI

class NewDistrictProfileDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,UIScrollViewDelegate,MFMailComposeViewControllerDelegate , MFMessageComposeViewControllerDelegate {
    
    
    
    
    @IBOutlet weak var buttonWhatsApp: UIButton!
    
    var varWhatysApporCall:String!=""
    @IBAction func buttonWhatsAppClickEvent(_ sender: Any) {
        varWhatysApporCall="whatsapp"
        viewForCallsListing.isHidden=false
        tableCallListing.isHidden=false
        buttonOpticity.isHidden=false
        tableCallListing.reloadData()
        buttonCallHeading.setTitle("WhatsApp", for: .normal)

    }
    
    //MARK:- 1. Button CALL Calling
    @objc func buttonWhatsAppClickEventsForTable(_ sender:UIButton)
    {
        
        print(sender.tag)
        let varGetValue:String!=muarrayCallValue.object(at: sender.tag) as! String
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
    
    
    
    var appDelegate : AppDelegate = AppDelegate()
    let loaderClass  = WebserviceClass()
    
    @IBOutlet weak var tableEmailListing: UITableView!
    
    @IBOutlet weak var buttonEmailCancel: UIButton!
    @IBOutlet weak var viewForMailListing: UIView!
    
    @IBOutlet weak var buttonSendMail: UIButton!
    
    @IBOutlet weak var buttonSendSMS: UIButton!
    
    @IBOutlet weak var buttonEmailHeading: UIButton!
    @IBOutlet weak var buttonMessageHeading: UIButton!
    @IBOutlet weak var buttonSMSCancel: UIButton!
    @IBOutlet weak var viewForSMSsListing: UIView!
    
    @IBOutlet weak var buttonCallHeading: UIButton!
    @IBOutlet weak var buttonCallCancel: UIButton!
    @IBOutlet weak var viewForCallsListing: UIView!
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var viewProfileFirstView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var buttonCall: UIButton!
    @IBOutlet weak var buttonMessage: UIButton!
    @IBOutlet weak var buttonMail: UIButton!
    @IBOutlet weak var tableViewProfileDetails: UITableView!
    var muarrayListKey:NSMutableArray=NSMutableArray()
    var muarrayListValue:NSMutableArray=NSMutableArray()
    var muarrayContactKey:NSMutableArray=NSMutableArray()
    var muarrayContactValue:NSMutableArray=NSMutableArray()
    var muarrayCallKey:NSMutableArray=NSMutableArray()
    var muarrayCallValue:NSMutableArray=NSMutableArray()
    var muarrayMailIDValue:NSMutableArray=NSMutableArray()
    
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblDesignation: UILabel!
    
    var muarrayForSMSCheckUnCheckCount:NSMutableArray=NSMutableArray()
    var muarrayForMailCheckUncheckCount:NSMutableArray=NSMutableArray()
    var smsArray:[String]=[]
    var mailArray:[String]=[]
    var District_ID:String!=""
    var muarrayListData:NSArray=NSArray()
    var selectedIndex:Int=0
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var tableCallListing: UITableView!
    @IBOutlet weak var tableSMSListing: UITableView!
    
    
    
    
    func functionHideCallView()
    {
        viewForCallsListing.isHidden=true
        tableCallListing.isHidden=true
        buttonOpticity.isHidden=true
    }
    func functionShowCallView()
    {
        viewForCallsListing.isHidden=false
        tableCallListing.isHidden=false
        buttonOpticity.isHidden=false
    }
    
    func functionHideSMSView()
    {
        viewForSMSsListing.isHidden=true
        tableSMSListing.isHidden=true
        buttonOpticity.isHidden=true
    }
    func functionShowSMSView()
    {
        viewForSMSsListing.isHidden=false
        tableSMSListing.isHidden=false
        buttonOpticity.isHidden=false
    }
    
    
    func functionHideMailView()
    {
        viewForMailListing.isHidden=true
        tableEmailListing.isHidden=true
        buttonOpticity.isHidden=true
    }
    func functionShowMailView()
    {
        viewForMailListing.isHidden=false
        tableEmailListing.isHidden=false
        buttonOpticity.isHidden=false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        functionHideCallView()
        functionHideSMSView()
        functionHideMailView()
        //Scroll view setting
        myScrollView.delegate=self
        myScrollView.contentSize=CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+self.viewProfileFirstView.frame.size.height)
        
        //Top boarder Setting Button Send SMS And Mail
        let b = CALayer()
        b.backgroundColor = UIColor.lightGray.cgColor
        b.frame = CGRect(x: 0, y: 0, width: buttonSendMail.frame.size.width, height: 1)
        buttonSendMail.layer.addSublayer(b)
        let a = CALayer()
        a.backgroundColor = UIColor.lightGray.cgColor
        a.frame = CGRect(x: 0, y: 0, width: buttonSendSMS.frame.size.width, height: 1)
        buttonSendSMS.layer.addSublayer(a)
        //Bottom boader set for UIVIEW
        let border = CALayer()
        border.backgroundColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: viewProfileFirstView.frame.size.height - 1, width: view.frame.size.width, height: 1)
        viewProfileFirstView.layer.addSublayer(border)
        //Image Circle
        profileImage.ImageCircle()
        //Button Setting
        buttonCallCancel.ButtonSetting()
        buttonSMSCancel.ButtonSetting()
        buttonEmailCancel.ButtonSetting()
        //buttonSendMail.functionForTopBoarder()
        //buttonSendSMS.functionForTopBoarder()
        
        
        buttonCallCancel.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonSMSCancel.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonEmailCancel.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonSendMail.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonSendSMS.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        
        //Navigation
        createNavigationBar()
        
        
        for i in 00..<muarrayListData.count
        {
            if(selectedIndex==i)
            {
                let name = (muarrayListData.value(forKey: "name") as AnyObject).object(at: i) as! String
                let img = (muarrayListData.value(forKey: "img") as AnyObject).object(at: i) as! String
                let Designation = (muarrayListData.value(forKey: "DistrictDesignation") as AnyObject).object(at: i) as! String
                
                lblUserName.text = name
                muarrayContactKey.add("Name")
                muarrayContactValue.add(name)
                lblDesignation.text = Designation
                
                if img == ""
                {
                    profileImage.image = UIImage(named: "profile_pic.png")
                }
                else
                {
                    let ImageProfilePic:String = img.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    profileImage.sd_setImage(with: checkedUrl)
                }
                //let Fk_DistrictCommitteeID = muarrayListData.valueForKey("Fk_DistrictCommitteeID").objectAtIndex(i) as! String
                //let fk_Member_profileID = muarrayListData.valueForKey("fk_Member_profileID").objectAtIndex(i) as! String
                let MobileNumber = (muarrayListData.value(forKey: "MobileNumber") as AnyObject).object(at: i) as! String
                let MailID = (muarrayListData.value(forKey: "MailID") as AnyObject).object(at: i) as! String
                let DistrictDesignation = (muarrayListData.value(forKey: "DistrictDesignation") as AnyObject).object(at: i) as! String
                let ClubName = (muarrayListData.value(forKey: "ClubName") as AnyObject).object(at: i) as! String
                //let MobileCodeID = muarrayListData.valueForKey("MobileCodeID").objectAtIndex(i) as! String
                //let type = muarrayListData.valueForKey("type").objectAtIndex(i) as! String
                //let classification = muarrayListData.valueForKey("classification").objectAtIndex(i) as! String
                // let BusinessName = muarrayListData.valueForKey("BusinessName").objectAtIndex(i) as! String
                // let BusinessAddress = muarrayListData.valueForKey("BusinessAddress").objectAtIndex(i) as! String
                //let Keywords = muarrayListData.valueForKey("Keywords").objectAtIndex(i) as! String
                //let RotaryID = muarrayListData.valueForKey("RotaryID").objectAtIndex(i) as! String
                //let DonarReco = muarrayListData.valueForKey("DonarReco").objectAtIndex(i) as! String
                
                if(MobileNumber != "")
                {
                    muarrayListKey.add("Telephone No.")
                    muarrayListValue.add(MobileNumber)
                    muarrayCallKey.add("Telephone No.")
                    muarrayContactKey.add("Telephone No.")
                    muarrayContactValue.add(MobileNumber)
                    muarrayCallValue.add(MobileNumber)
                    muarrayForSMSCheckUnCheckCount.add("0")
                    buttonCall.isUserInteractionEnabled = true
                    buttonCall.setImage(UIImage(named: "blue_call"),  for: UIControl.State.normal)
                    buttonMessage.isUserInteractionEnabled = true
                    buttonMessage.setImage(UIImage(named: "blue_message"),  for: UIControl.State.normal)
                }
                else
                {
                    buttonCall.isUserInteractionEnabled = false
                    buttonCall.setImage(UIImage(named: "call_gray.png"),  for: UIControl.State.normal)
                    buttonMessage.isUserInteractionEnabled = false
                    buttonMessage.setImage(UIImage(named: "message_gray.png"),  for: UIControl.State.normal)
                }
                if(MailID != "")
                {
                    muarrayListKey.add("Email")
                    muarrayListValue.add(MailID)
                    muarrayMailIDValue.add(MailID)
                    muarrayContactKey.add("Email")
                    muarrayContactValue.add(MailID)
                    muarrayForMailCheckUncheckCount.add("0")
                    buttonMail.isUserInteractionEnabled = true
                    buttonMail.setImage(UIImage(named: "blue_mail"),  for: UIControl.State.normal)
                }
                else
                {
                    buttonMail.isUserInteractionEnabled = false
                    buttonMail.setImage(UIImage(named: "mail_gray.png"),  for: UIControl.State.normal)
                }
                
                if(ClubName != "")
                {
                    muarrayListKey.add("Club Name")
                    muarrayListValue.add(ClubName)
                }
                if(DistrictDesignation != "")
                {
                    muarrayListKey.add("District Designation")
                    muarrayListValue.add(DistrictDesignation)
                }
                
                /*
                 if(classification != "")
                 {
                 muarrayListKey.addObject("Classification")
                 muarrayListValue.addObject(classification)
                 }
                 
                 if(Keywords != "")
                 {
                 muarrayListKey.addObject("Keywords about your profession")
                 muarrayListValue.addObject(MobileNumber)
                 }
                 if(BusinessName != "")
                 {
                 muarrayListKey.addObject("Business Name")
                 muarrayListValue.addObject(BusinessName)
                 }
                 if(Designation != "")
                 {
                 muarrayListKey.addObject("Designation")
                 muarrayListValue.addObject(Designation)
                 }
                 if(BusinessAddress != "")
                 {
                 muarrayListKey.addObject("Business Address")
                 muarrayListValue.addObject(BusinessAddress)
                 }
                 if(RotaryID != "")
                 {
                 muarrayListKey.addObject("RotaryID")
                 muarrayListValue.addObject(RotaryID)
                 }
                 if(DonarReco != "")
                 {
                 muarrayListKey.addObject("Donar Recognition")
                 muarrayListValue.addObject(DonarReco)
                 }
                 */
                
                
                //muarrayList =
            }
        }
        
        
        
        
        
        
        
        
        //Need to Dyanmic  Below is static data set
        //---------------Start of the Static data----------------------
        // muarrayListValue = ["Deepak Kumar Patidar","+91 7415243715","+91 8879548890","deepak.patidar.1990@kaizeninfotech.com","deepak.patidar@gmail.com","122, Gala complex Kaizen infotech pvt ltd Mulund West 400080, Mumbai, India","District Governer","Club ROW"]
        // muarrayCallKey = ["Mobile", "Telephone"]
        // muarrayCallValue = ["+917415243715","+918879548890"]
        // muarrayForSMSCheckUnCheckCount = ["0","0"]
        //muarrayMailIDValue = ["deepak.patidar@kaizeninfotech.com","rajendra.jat@kaizeninfotech.com"]
        //muarrayForMailCheckUncheckCount = ["0","0"]
        //---------------End of the Static data----------------------
        
        tableViewProfileDetails.estimatedRowHeight = 70
        tableViewProfileDetails.rowHeight = UITableView.automaticDimension
        tableViewProfileDetails.reloadData()
        viewProfileFirstView.backgroundColor=UIColor.white
        tableViewProfileDetails.backgroundColor=UIColor.white
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            //Need to API Call and Uncomment and implement
            // fucntionForGetProfileDetails()
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
       SVProgressHUD.dismiss()
        
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title="Profile"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        self.navigationController?.navigationBar.backgroundColor=UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(NewDistrictProfileDetailsViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        shareButton.addTarget(self, action: #selector(self.shareContact), for: UIControl.Event.touchUpInside)
        let sharing: UIBarButtonItem = UIBarButtonItem(customView: shareButton)

        self.navigationItem.rightBarButtonItem=sharing
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Share contact methods
    
    
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
    
    
    func createContact() -> CNContact {
        
        var contactName:String=""
        var mobileNo:String=""
        var emailID:String=""
        print(muarrayContactKey)
        print(muarrayContactValue)
        for i in 0..<muarrayContactKey.count
        {
            let varGetKeyValue=muarrayContactKey.object(at: i)as! String
            if varGetKeyValue.contains("Telephone No.") && mobileNo == ""
            {
                mobileNo=muarrayContactValue.object(at: i) as! String
            }
            if varGetKeyValue=="Name"
            {
                let ename:String=muarrayContactValue.object(at: i) as! String
                contactName=ename.replacingOccurrences(of: ",", with: " ")
            }
            if varGetKeyValue=="Email" && emailID == ""
            {
                emailID=muarrayContactValue.object(at: i) as! String
            }
//            if varGetKeyValue=="address" && addresses == ""
//            {
//                let addresss=muarrayContactValue.object(at: i) as! String
//                addresses=addresss.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\'", with: "").replacingOccurrences(of: ",", with: " ")
//            }
//            if varGetKeyValue=="city" && city == ""
//            {
//                city=muarrayContactValue.object(at: i) as! String
//            }
//            if varGetKeyValue=="state" && state == ""
//            {
//                state=muarrayContactValue.object(at: i) as! String
//            }
//            if varGetKeyValue=="country" && country == ""
//            {
//                country=muarrayContactValue.object(at: i) as! String
//            }
//            if varGetKeyValue=="pincode" && postalCode == ""
//            {
//                postalCode=muarrayContactValue.object(at: i) as! String
//            }
//            print("Address removing slash PDNVC::\(addresses)")
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
        
        
//        let address = CNMutablePostalAddress()
//        address.street = addresses
//        address.city = city
//        address.state = state
//        address.postalCode = postalCode
//        address.country = country
//        let workAddress = CNLabeledValue<CNPostalAddress>(label:CNLabelWork, value:address)
//        contact.postalAddresses = [workAddress]
        
        return contact
    }
    
    
    
    //MARK:- Call Cancel Action
    @IBAction func buttonCallCE(_ sender: AnyObject)
    {
        varWhatysApporCall="call"
         buttonCallHeading.setTitle("Call", for: .normal)
        tableCallListing.reloadData()
        functionShowCallView()
    }
    @IBAction func buttonCancelCallClickEvent(_ sender: AnyObject)
    {
        functionHideCallView()
    }
    
    
    
    
    //MARK:- SMS Click Events
    @IBAction func buttonMessageCE(_ sender: AnyObject)
    {
        functionShowSMSView()
    }
    
    @IBAction func buttonSMSCancelClickEvent(_ sender: AnyObject) {
        functionHideSMSView()
        for i in 0..<self.muarrayForSMSCheckUnCheckCount.count
        {
            muarrayForSMSCheckUnCheckCount.replaceObject(at: i, with: "0")
        }
        
        tableSMSListing.reloadData()
    }
    
    @IBAction func buttonSMSSendClickEvent(_ sender: AnyObject)
    {
        smsArray=[]
        for i in 0..<self.muarrayForSMSCheckUnCheckCount.count
        {
            if(muarrayForSMSCheckUnCheckCount.object(at: i) as! String == "1")
            {
                let mobileNumber = muarrayCallValue.object(at: i) as! String
                smsArray.append(mobileNumber)
            }
        }
        if(smsArray.count>0)
        {
            let messageVC = MFMessageComposeViewController()
            messageVC.body = ""
            messageVC.recipients = smsArray // [PhoneNumberSTR] // Optionally add some tel numbers
            messageVC.messageComposeDelegate = self
            // Open the SMS View controller
            present(messageVC, animated: true, completion: nil)
        }
        else
        {
            self.view.makeToast("Please select at least One Number", duration: 2, position: CSToastPositionCenter)
        }
    }
    
    //MARK:- MAIL Click Events
    @IBAction func buttonMailCE(_ sender: AnyObject)
    {
        functionShowMailView()
        
        
    }
    @IBAction func buttonEmailCancelClickEvent(_ sender: AnyObject)
    {
        functionHideMailView()
        for i in 0..<self.muarrayForMailCheckUncheckCount.count
        {
            muarrayForMailCheckUncheckCount.replaceObject(at: i, with: "0")
        }
        
        tableEmailListing.reloadData()
    }
    @IBAction func buttonEmailSendClickEvent(_ sender: AnyObject)
    {
        mailArray=[]
        for i in 0..<self.muarrayForMailCheckUncheckCount.count
        {
            if(muarrayForMailCheckUncheckCount.object(at: i) as! String == "1")
            {
                let mail = muarrayMailIDValue.object(at: i) as! String
                mailArray.append(mail)
            }
        }
        print(mailArray)
        
        
        if(mailArray.count>0)
        {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(mailArray)      // gg@hing.co.in
                mail.setMessageBody("", isHTML: true)
                
                present(mail, animated: true, completion: nil)
            }
            else
            {
                // show failure alert
            }
            
        }
        else
        {
            self.view.makeToast("Please select at least One EMail ID", duration: 2, position: CSToastPositionCenter)
            
        }
    }
    @IBAction func buttonOpticityClickEvent(_ sender: AnyObject)
    {
        //Need when click on opticity check field uncheck initilization
        //Hide call/sms/mail view and table and opticity
        
        
    }
    //MARK:- Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView==tableViewProfileDetails)
        {
            return muarrayListValue.count
        }
        else if(tableView==tableSMSListing)
        {
            return muarrayCallKey.count
        }
        else if(tableView==tableEmailListing)
        {
            return muarrayMailIDValue.count
        }
        else
        {
            return muarrayCallKey.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if(tableView==tableViewProfileDetails)
        {
            let cell = tableViewProfileDetails.dequeueReusableCell(withIdentifier: "NewDistrictProfileTableViewCell", for: indexPath) as! NewDistrictProfileTableViewCell
            cell.lblKey.text = muarrayListKey.object(at: indexPath.row) as! String
            cell.lblvalue.text = muarrayListValue.object(at: indexPath.row) as! String
            
            let keys = muarrayListKey.object(at: indexPath.row) as! String
            
            if(keys == "Telephone No."  || keys == "Email")
            {
                cell.lblvalue.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
            }
            else
            {
                cell.lblvalue.textColor = UIColor.black
            }
            
            
            
            
            
            return cell
        }
        else if(tableView==tableSMSListing)
        {
            let cell = tableSMSListing.dequeueReusableCell(withIdentifier: "NewDistrictSMSCell", for: indexPath) as! NewDistrictSMSCell
            cell.lblKey.text = muarrayCallKey.object(at: indexPath.row) as! String
            cell.lblValue.text = muarrayCallValue.object(at: indexPath.row) as! String
            cell.lblValue.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
            
            if(muarrayForSMSCheckUnCheckCount.object(at: indexPath.row) as! String == "0")
            {
                cell.buttonCheckUncheckSMSClickEvent.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
            }
            else if (muarrayForSMSCheckUnCheckCount.object(at: indexPath.row) as! String == "1")
            {
                cell.buttonCheckUncheckSMSClickEvent.setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
            }
            
            cell.buttonCheckUncheckSMSClickEvent.addTarget(self, action: #selector(NewDistrictProfileDetailsViewController.buttonCheckUncheckSMSClickEvents(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonCheckUncheckSMSClickEvent.tag=indexPath.row
            return cell
            
        }
        else if(tableView==tableEmailListing)
        {
            let cell = tableEmailListing.dequeueReusableCell(withIdentifier: "NewDistrictMailCell", for: indexPath) as! NewDistrictMailCell
            cell.lblKey.text = "Email"
            cell.lblValue.text = muarrayMailIDValue.object(at: indexPath.row) as! String
            cell.lblValue.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
            
            if(muarrayForMailCheckUncheckCount.object(at: indexPath.row) as! String == "0")
            {
                cell.buttonEmailCheckUncheckElickEvent.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
            }
            else if (muarrayForMailCheckUncheckCount.object(at: indexPath.row) as! String == "1")
            {
                cell.buttonEmailCheckUncheckElickEvent.setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
            }
            
            cell.buttonEmailCheckUncheckElickEvent.addTarget(self, action: #selector(NewDistrictProfileDetailsViewController.buttonEmailCheckUncheckElickEvents(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonEmailCheckUncheckElickEvent.tag=indexPath.row
            return cell
        }
        else
        {
            let cell = tableCallListing.dequeueReusableCell(withIdentifier: "NewDistrictCallCell", for: indexPath) as! NewDistrictCallCell
            cell.labelKey.text = muarrayCallKey.object(at: indexPath.row) as! String
            cell.lblValue.text = muarrayCallValue.object(at: indexPath.row) as! String
            cell.lblValue.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
            cell.buttonCallClickEvent.addTarget(self, action: #selector(NewDistrictProfileDetailsViewController.buttonCallClickEventsForTable(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonCallClickEvent.tag=indexPath.row
            
            
            cell.buttonWhatsApp.addTarget(self, action: #selector(NewDistrictProfileDetailsViewController.buttonWhatsAppClickEventsForTable(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonWhatsApp.tag=indexPath.row
            
             if(varWhatysApporCall=="whatsapp")
             {
                 cell.buttonWhatsApp.isHidden=false
                 cell.buttonCallClickEvent.isHidden=true
             }
             else  if(varWhatysApporCall=="call")
             {
                cell.buttonWhatsApp.isHidden=true
                  cell.buttonCallClickEvent.isHidden=false
            }
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView==tableViewProfileDetails)
        {
            let keys = muarrayListKey.object(at: indexPath.row) as! String
            let values = muarrayListValue.object(at: indexPath.row) as! String
            
            if(keys == "Telephone No.")
            {
                let PhoneNumberSTR:String = values.replacingOccurrences(of: " ", with: "")

                        if let url = URL(string: "tel://\(PhoneNumberSTR)"), UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            print("Unable to make a call. Invalid phone number or URL.")
                        }
            }
            else if (keys ==  "Email")
            {
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients([values])      // gg@hing.co.in
                    mail.setMessageBody("", isHTML: true)
                    
                    present(mail, animated: true, completion: nil)
                }
                else
                {
                    // show failure alert
                }
                
            }
            else
                
            {
                
            }
            
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(tableView==tableViewProfileDetails)
        {
            return UITableView.automaticDimension
        }
        else if(tableView==tableSMSListing)
        {
            return 55.0
        }
        else if(tableView==tableEmailListing)
        {
            return 55.0
        }
        else
        {
            return 55.0
        }
    }
    
    //MARK:- 1. Button CALL Calling
    @objc func buttonCallClickEventsForTable(_ sender:UIButton)
    {
        print(sender.tag)
        let varGetKeyValue:String!=muarrayCallKey.object(at: sender.tag)as! String
        //        if(varGetKeyValue=="Mobile" || varGetKeyValue=="Telephone No." || varGetKeyValue=="Residential Contact No." || varGetKeyValue=="Business Contact No.")
        //        {
        if(varGetKeyValue=="Telephone No.")
        {
            let varGetValue:String!=muarrayCallValue.object(at: sender.tag) as! String
            print(varGetValue)
            let PhoneNumberSTR:String = varGetValue.replacingOccurrences(of: " ", with: "")
            if let url = URL(string: "tel://\(PhoneNumberSTR)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Unable to make a call. Invalid phone number or URL.")
            }
        }
    }
    //MARK:- 2. Button SMS Check Uncheck
    @objc func buttonCheckUncheckSMSClickEvents(_ sender:UIButton)
    {
        print(sender.tag)
        
        if(muarrayForSMSCheckUnCheckCount.object(at: sender.tag) as! String == "0")
        {
            muarrayForSMSCheckUnCheckCount.replaceObject(at: sender.tag, with: "1")
            tableSMSListing.reloadData()
        }
        else if(muarrayForSMSCheckUnCheckCount.object(at: sender.tag) as! String == "1")
        {
            muarrayForSMSCheckUnCheckCount.replaceObject(at: sender.tag, with: "0")
            tableSMSListing.reloadData()
        }
    }
    //MARK:- 3. Button EMAIL Check Uncheck
    @objc func buttonEmailCheckUncheckElickEvents(_ sender:UIButton)
    {
        print(sender.tag)
        if(muarrayForMailCheckUncheckCount.object(at: sender.tag) as! String == "0")
        {
            muarrayForMailCheckUncheckCount.replaceObject(at: sender.tag, with: "1")
            tableEmailListing.reloadData()
        }
        else if(muarrayForMailCheckUncheckCount.object(at: sender.tag) as! String == "1")
        {
            muarrayForMailCheckUncheckCount.replaceObject(at: sender.tag, with: "0")
            tableEmailListing.reloadData()
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
        self.dismiss(animated: true, completion: nil)
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    /*
     //MARK:- WEB API First Time
     func fucntionForGetProfileDetails()
     {
     loaderClass.loaderViewMethod()
     let completeURL = baseUrl+"DistrictCommittee/districtCommitteeDetails"
     let parameterst =  [ "DistrictCommitteID":"0"]
     print(parameterst)
     print(completeURL)
     ServiceManager().webserviceWithRequestMethod(HTTPMethod.POST, url: completeURL, parameters: parameterst as [NSObject : AnyObject], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
     //=> Handle server response
     print(response)
     var varGetValueServerError = response.objectForKey("serverError")as? String
     if(varGetValueServerError == "Error")
     {
     self.loaderClass.window=nil
     self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
    
      SVProgressHUD.dismiss()
     }
     else
     {
     let responseDict = response.valueForKey("TBDistrictCommitteeDetailsResult")as! NSDictionary
     let letGetMessage = (responseDict.valueForKey("message"))as! String
     let letGetStatus = (responseDict.valueForKey("status"))as! String
     if(letGetStatus == "0" && letGetMessage == "success")
     {
     
     let arrarrNewDirectoryData = (responseDict.objectForKey("Result")!.objectForKey("districtCommitteeWithoutCatList")) as! NSArray
     print(arrarrNewDirectoryData)
     
     
     self.loaderClass.window=nil
     }
     else
     {
     self.loaderClass.window=nil
     }
     self.loaderClass.window=nil
     }
     })
     }
     
     
     */
    
    
}



extension UIImageView {
    
    func ImageCircle()
    {
        self.contentMode = .scaleAspectFit
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
}
extension UIButton
{
    func ButtonSetting()
        
    {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        self.layer.cornerRadius = 5
    }
    
    
    
    func functionForTopBoarder()
    {
        let border = CALayer()
        border.backgroundColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.origin.y, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(border)
    }
}
