//
//  DistrictDirectoryDetailsVC.swift
//  TouchBase
//
//  Created by rajendra on 22/01/18.
//  Copyright © 2018 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import SDWebImage
import MessageUI
import ContactsUI
import Contacts
import Alamofire
class DistrictDirectoryDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource ,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate, CNContactViewControllerDelegate{

    @IBOutlet weak var buttonWhatsApp: UIButton!
    @IBOutlet weak var labelClubDesignation: UILabel!
    @IBOutlet weak var tableCall: UITableView!
    @IBOutlet weak var tableMessage: UITableView!
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var buttonMailPopUpClose: UIButton!
    @IBOutlet weak var buttonMailSend: UIButton!
    @IBOutlet weak var lblCall: UILabel!
    @IBOutlet weak var viewForEmailList: UIView!
    @IBOutlet weak var tableEmail: UITableView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserDesignation: UILabel!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnMail: UIButton!
    @IBOutlet weak var tableDirUserDetails: UITableView!
    @IBOutlet weak var buttonOpacityNew: UIButton!
    
    var muarrayForGetList:NSArray=NSArray()
    var muarrayForKey:NSMutableArray=NSMutableArray()
    var muarrayForValue:NSMutableArray=NSMutableArray()
    var muarrayContactKey:NSMutableArray=NSMutableArray()
    var muarrayContactValue:NSMutableArray=NSMutableArray()
    let loaderClass  = WebserviceClass()
    var appDelegate : AppDelegate!
    var EmailSTR  : String =  ""
    var varRowHeight:CGFloat!=0.0
    var userName:String!=""
    var userMobileNumber:String!=""
    var userProfile:String!=""
    var selectedMemberProfileID:String!=""
    var groupID:String!=""
    var varCallMessageEmail:String!=""
    var designationShowFromDistrictCommitee:String!=""
    var callFromDistrictCommitee:String!=""
    var cell:DistrictDirDetailsTableCell=DistrictDirDetailsTableCell()
    var cells:DistrictEmailTableViewCell=DistrictEmailTableViewCell()
    var cellss:DistrictCallMessageTableViewCell=DistrictCallMessageTableViewCell()
    var CallCell:CallTableViewCell=CallTableViewCell()
    //For POp up
    var MobileNumberArray:NSMutableArray=NSMutableArray()
    var MobileNumberCheckUncheck:NSMutableArray=NSMutableArray()
    var EmailsArray:NSMutableArray=NSMutableArray()
    var EmailCheckUncheck:NSMutableArray=NSMutableArray()
    var isUpperImageAvailable:String!=""
    var isUserProfile:String! = ""
    
    var dirOnline: DistDirectoryDetailOnline?
    var classificationMemberDetails: ClassificationDetail?
    var onlineKeyArray = [String]()
    var onlineValueArray = [String]()
    var onlineEmail = [String]()
    var onlineMobNo = [String]()
    var onlineContactKey = [String]()
    var onlineContactValue = [String]()
    var cellHeightForFamily = 80.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonMailPopUpClose.layer.borderWidth = 1
        buttonMailPopUpClose.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        buttonMailPopUpClose.layer.cornerRadius = 5
        let lineView2 = UIView(frame: CGRect(x: 0, y: 0, width: buttonMailSend.frame.size.width, height: 1))
        lineView2.backgroundColor=UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        buttonMailSend.addSubview(lineView2)
        buttonMailSend.layer.borderWidth = 1
        buttonMailSend.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        buttonOpacityNew.isHidden=true
        functionForEmailViewAndButonOpticityHide()
        tableDirUserDetails.estimatedRowHeight=90.0
        tableDirUserDetails.rowHeight=UITableView.automaticDimension
        createNavigationBar()
//        self.edgesForExtendedLayout=[]
        functionForProfileSetting()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            functionForGetDistrictMemberList()
            loadDistDirectDetail()
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            SVProgressHUD.dismiss()
        }
        // Do any additional setup after loading the view.
    }

    
    
    func loadDistDirectDetail() {
        if let grpIdd = self.groupID, let proID = self.selectedMemberProfileID {
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")! as String
            let completeURL = baseUrl + distdirectoryDetailOnline
            
            let parameterst = ["memberProfileId":proID,"groupId":grpIdd]
            
            print("District Online Directory parameterst:: \(parameterst)")
            print("District Online Directory completeURL:: \(completeURL)")
            
            //------------------------------------------------------
            Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    
                    SVProgressHUD.dismiss()
                         if let value = response.result.value {
                             do {
                                 print("value::: \(value)")
                                 // Attempt to decode the JSON data
                                 let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                                 let decoder = JSONDecoder()
                                 let decodedData = try decoder.decode(DistDirectoryDetailOnline.self, from: jsonData)
                                 
                                 // Access the properties of the decoded data
                                 print("Decoded Data: \(decodedData)")
                                 self.dirOnline = decodedData
                                 self.appendArrayElements()
                                 self.tableDirUserDetails.reloadData()
                                 self.tableCall.reloadData()
                                 self.tableEmail.reloadData()
                                 self.tableMessage.reloadData()
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
    
    func loadClassificationDetail(profileID: String?, groupID: String?) {
        
        if let profileIdd = profileID, let grpID = groupID {
            
            let completeURL = baseUrl + dirClassificationDetail
            
            let parameterst = ["memberProfileId":profileIdd,"groupId":grpID]
            
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
                            let decodedData = try decoder.decode(ClassificationDetail.self, from: jsonData)
                            
                            // Access the properties of the decoded data
                            print("Decoded Data:--- \(decodedData)")
                            self.classificationMemberDetails = decodedData
                            self.onlineMobNo.removeAll()
                            self.onlineEmail.removeAll()
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberMobile != "" {
                                self.onlineKeyArray.append("Mobile Number")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberMobile ?? "")
                                self.onlineMobNo.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberMobile ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.secondaryMobile != "" {
                                self.onlineKeyArray.append("Secondary Mobile Number")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.secondaryMobile ?? "")
                                self.onlineMobNo.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.secondaryMobile ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberEmail != "" {
                                self.onlineKeyArray.append("Email ID")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberEmail ?? "")
                                self.onlineEmail.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberEmail ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.rotaryid != "" {
                                self.onlineKeyArray.append("Rotary ID")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.rotaryid ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.clubDesignation != "" {
                                self.onlineKeyArray.append("Club Designation")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.clubDesignation ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.classification != "" {
                                self.onlineKeyArray.append("Classification")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.classification ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberDateOfBirth != "" {
                                self.onlineKeyArray.append("Birthday")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberDateOfBirth ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.bloodGroup != "" {
                                self.onlineKeyArray.append("Blood group")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.bloodGroup ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessName != "" {
                                self.onlineKeyArray.append("Business Name")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessName ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessDesignation != "" {
                                self.onlineKeyArray.append("Business Designation")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessDesignation ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessAdress != "" {
                                self.onlineKeyArray.append("Business Address")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessAdress ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessPhoneNo != "" {
                                self.onlineKeyArray.append("Business Contact No.")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessPhoneNo ?? "")
                                self.onlineMobNo.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessPhoneNo ?? "")
                            }
                           
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.keywords != "" {
                                self.onlineKeyArray.append("Keywords about your profession")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.keywords ?? "")
                            }
                        
                            
//                            if mother != "" {
//                                lblKeyArray.append(relati)
//                                lblValueArray.append(mother)
//                            }
//                            if resMob != "" {
//                                lblKeyArray.append("Mobile")
//                                lblValueArray.append(resMob)
//                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.familyPic != "" {
                                self.onlineKeyArray.append("Family Photo")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.familyPic ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberInfo != "" {
                                self.onlineKeyArray.append("Member Introduction")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberInfo ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.faceBookTxt != "" {
                                self.onlineKeyArray.append("Facebook")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.faceBookTxt ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.instagramTxt != "" {
                                self.onlineKeyArray.append("Instagram")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.instagramTxt ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.linkedInTxt != "" {
                                self.onlineKeyArray.append("Linkedin")
                                self.onlineValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.linkedInTxt ?? "")
                            }
                            
                            self.lblUserName.text = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberName
                            self.lblUserDesignation.text = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.clubName
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.profilePic == ""  || self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.profilePic == "profile_photo.png"
                            {
                                self.userProfileImageView.image = UIImage(named: "profile_pic")
                            }
                            else
                            {
                                
                                // /*------------------------------Code by --------------------DPK--------------------------- */
                                let ImageProfilePic:String = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.profilePic?.replacingOccurrences(of: " ", with: "%20") ?? ""
                                print("ImageProfilePic: \(ImageProfilePic)")
                                let checkedUrl = URL(string: ImageProfilePic)
                                self.userProfileImageView.sd_setImage(with: checkedUrl)
                                
                            }
                            SVProgressHUD.dismiss()
                            self.tableDirUserDetails.reloadData()
                            self.tableCall.reloadData()
                            self.tableEmail.reloadData()
                            self.tableMessage.reloadData()
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

    func appendArrayElements() {
        
        var mob1 = ""
        var emai1 = ""
        var mob2 = ""
        var emai2 = ""
        var addrs = ""
        var city = ""
        var pincode = ""
        var state = ""
        var country = ""
            
        for i in 0 ..< (dirOnline?.memberListDetailResultss.memberDetailsss.personalMemberDetails?.count ?? 0) {
            let personalKey = dirOnline?.memberListDetailResultss.memberDetailsss.personalMemberDetails?[i].key ?? ""
            let personalVals = dirOnline?.memberListDetailResultss.memberDetailsss.personalMemberDetails?[i].value ?? ""
            
            if (!(personalKey == "Name") && !(personalVals == "")) {
                onlineKeyArray.append(personalKey)
                onlineValueArray.append(personalVals)
                if (personalKey == "Email" && !(personalVals == "")) {
                    onlineEmail.append(personalVals)
                    emai1 = personalVals
                    self.EmailCheckUncheck.add("0")
                }
                if (personalKey == "Telephone No" && !(personalVals == "")) {
                    onlineMobNo.append(personalVals)
                    emai1 = personalVals
                    self.MobileNumberCheckUncheck.add("0")
                    print("onlineMobNo:: \(onlineMobNo)")
                }
            }
            
            lblUserName.text = dirOnline?.memberListDetailResultss.memberDetailsss.personalMemberDetails?[0].value ?? ""
            
        }
        onlineContactKey.append("address")
        onlineContactKey.append("city")
        onlineContactKey.append("country")
        onlineContactKey.append("state")
        onlineContactKey.append("pincode")
        onlineContactKey.append("telephoneno")
        onlineContactValue.append(mob1)
        onlineContactKey.append("email")
        onlineContactValue.append(emai1)
        
        for j in 0 ..< (dirOnline?.memberListDetailResultss.memberDetailsss.businessMemberDetails?.count ?? 0) {
            let businessKey = dirOnline?.memberListDetailResultss.memberDetailsss.businessMemberDetails?[j].key ?? ""
            let businessValue = dirOnline?.memberListDetailResultss.memberDetailsss.businessMemberDetails?[j].value ?? ""
            
            if (!(businessKey == "Name") && !(businessValue == "")) {
                onlineKeyArray.append(businessKey)
                onlineValueArray.append(businessValue)
                if (businessKey == "Email" && !(businessValue == "")) {
                    onlineEmail.append(businessValue)
                    emai2 = businessValue
                    self.EmailCheckUncheck.add("0")
                }
                if (businessKey == "Telephone No" && !(businessValue == "")) {
                    onlineMobNo.append(businessValue)
                    mob2 = businessValue
                    self.MobileNumberCheckUncheck.add("0")
                    print("onlineMobNoBusiness:: \(onlineMobNo)")
                }
            }
        }
        
//        onlineContactValue.append(<#T##newElement: String##String#>)
        
        for k in 0 ..< (dirOnline?.memberListDetailResultss.memberDetailsss.addressDetails?.addressResult?.count ?? 0) {
            let addressValue = dirOnline?.memberListDetailResultss.memberDetailsss.addressDetails?.addressResult?[k].address ?? ""
            let cityValue = dirOnline?.memberListDetailResultss.memberDetailsss.addressDetails?.addressResult?[k].city ?? ""
            let stateValue = dirOnline?.memberListDetailResultss.memberDetailsss.addressDetails?.addressResult?[k].state ?? ""
            let countryValue = dirOnline?.memberListDetailResultss.memberDetailsss.addressDetails?.addressResult?[k].country ?? ""
            let pincodeValue = dirOnline?.memberListDetailResultss.memberDetailsss.addressDetails?.addressResult?[k].pincode ?? ""
            let busMob = dirOnline?.memberListDetailResultss.memberDetailsss.addressDetails?.addressResult?[k].phoneNo ?? ""
            
            var addressComponents = [String]()
                if !addressValue.isEmpty {
                    addressComponents.append(addressValue)
                    
                    addrs = addressValue
                }
                if !cityValue.isEmpty {
                    addressComponents.append(cityValue)
                    city = cityValue
                }
                if !stateValue.isEmpty {
                    addressComponents.append(stateValue)
                    state = stateValue
                }
                if !countryValue.isEmpty {
                    addressComponents.append(countryValue)
                    
                    onlineContactValue.append(countryValue)
                }
                if !pincodeValue.isEmpty {
                    addressComponents.append(pincodeValue)
                    
                    onlineContactValue.append(pincodeValue)
                }
            
            let fullAddress = addressComponents.joined(separator: ", ")
            print("fullAddress:: \(fullAddress)")
            
            if (!(addressValue == "") || !(cityValue == "") || !(stateValue == "") || !(countryValue == "") || !(pincodeValue == "")) {
                onlineKeyArray.append("Business Address")
                onlineValueArray.append(fullAddress)
                
            }
            
            if !(busMob == "") {
                onlineKeyArray.append("Business Contact No.")
                onlineValueArray.append("+91 \(busMob)")
                onlineMobNo.append("+91 \(busMob)")
                self.MobileNumberCheckUncheck.add("0")
            }
            
            if !(dirOnline?.memberListDetailResultss.memberDetailsss.familyPic == "") {
                onlineKeyArray.append("Family Photo")
                onlineValueArray.append(dirOnline?.memberListDetailResultss.memberDetailsss.familyPic ?? "")
            }
            
        }
        
        print("onlineKeyArray:: \(onlineKeyArray)")
        print("onlineValueArray:: \(onlineValueArray)")
    }
    
    
    @IBAction func buttonWhatsAppClickEvent(_ sender: Any) {
        buttonMailSend.isHidden=true
        tableCall.isHidden=false
        tableMessage.isHidden=true
        tableEmail.isHidden=true
        lblCall.text! = "WhatsApp"
        varCallMessageEmail="whatsapp"
        
        functionForEmailViewAndButonOpticityShow()
        tableCall.reloadData()
    }
    
    
    
    @IBAction func buttonImageViewBigClickEvent(_ sender: AnyObject)
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
    
    
    
    
    //MARK:- Contact share methods
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
        let ename:String = self.lblUserName.text!
        let contactName:String = ename.replacingOccurrences(of: ",", with: " ")
        var mobileNo:String = ""
        var emailID:String = ""
            var addresses:String = ""
            var city:String = ""
            var state:String = ""
            var postalCode:String = ""
            var country:String = ""
        if self.dirOnline?.memberListDetailResultss.memberDetailsss.memberMobile != ""   {
            mobileNo = self.dirOnline?.memberListDetailResultss.memberDetailsss.memberMobile ?? ""
        }
        if self.dirOnline?.memberListDetailResultss.memberDetailsss.memberEmail != ""   {
            emailID = self.dirOnline?.memberListDetailResultss.memberDetailsss.memberEmail ?? ""
        }
        if self.dirOnline?.memberListDetailResultss.memberDetailsss.addressDetails?.addressResult?.count ?? 0 > 0 {
             addresses = self.dirOnline?.memberListDetailResultss.memberDetailsss.addressDetails?.addressResult?[0].address ?? ""
             city = self.dirOnline?.memberListDetailResultss.memberDetailsss.addressDetails?.addressResult?[0].city ?? ""
             state = self.dirOnline?.memberListDetailResultss.memberDetailsss.addressDetails?.addressResult?[0].state ?? ""
             postalCode = self.dirOnline?.memberListDetailResultss.memberDetailsss.addressDetails?.addressResult?[0].pincode ?? ""
             country = self.dirOnline?.memberListDetailResultss.memberDetailsss.addressDetails?.addressResult?[0].country ?? ""
        }
        
//        print(muarrayContactKey)
//        for i in 0..<muarrayContactKey.count
//        {
//            let varGetKeyValue=muarrayContactKey.object(at: i)as! String
//            if varGetKeyValue.contains("Telephone No") && mobileNo == ""
//            {
//                mobileNo=muarrayContactValue.object(at: i) as! String
//            }
//            
//            if varGetKeyValue=="Email" && emailID == ""
//            {
//                emailID=muarrayContactValue.object(at: i) as! String
//            }
//            if varGetKeyValue=="address" && addresses == ""
//            {
//                let addresss=muarrayContactValue.object(at: i) as! String
//                addresses=addresss.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\'", with: "").replacingOccurrences(of: ",", with: " ")
//            }
//            if varGetKeyValue=="city" && city==""
//            {
//                city=muarrayContactValue.object(at: i) as! String
//            }
//            if varGetKeyValue=="state" && state==""
//            {
//                state=muarrayContactValue.object(at: i) as! String
//            }
//            if varGetKeyValue=="pincode" && postalCode==""
//            {
//                postalCode=muarrayContactValue.object(at: i) as! String
//            }
//            if varGetKeyValue=="country" && country==""
//            {
//                country=muarrayContactValue.object(at: i) as! String
//            }
//
//            
//         print("Address removing slash DDDVC::\(addresses)")
//        }
        
        
        
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
        contact.note=""
        
        return contact
    }
   
    
    @IBAction func buttonOpacityNewClickEvent(_ sender: AnyObject) {
        
       buttonOpacityNew.isHidden=true
        viewForEmailList.isHidden=true
    }
    
    func functionForEmailViewAndButonOpticityHide()
    {
        viewForEmailList.isHidden=true
        buttonOpticity.isHidden=true
    }
    func functionForEmailViewAndButonOpticityShow()
    {
        viewForEmailList.isHidden=false
        buttonOpticity.isHidden=false
    }
    
    //MARK:- Profile Setting
    func functionForProfileSetting()
    {
        userProfileImageView.layer.borderWidth = 1.0
        userProfileImageView.layer.masksToBounds = false
        userProfileImageView.contentMode = .scaleAspectFit
        userProfileImageView.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.size.width/2
        userProfileImageView.clipsToBounds = true
//        lblUserName.text! = userName
        
        
        if userProfile == ""  || userProfile == "profile_photo.png" || userProfile.hasSuffix("profile_photo.png")
        {
            userProfileImageView.image = UIImage(named: "profile_pic")
        }
        else
        {
        //lblUserDesignation.text! = userMobileNumber
        let ImageProfilePic:String = userProfile.replacingOccurrences(of: " ", with: "%20")
        let checkedUrl = URL(string: ImageProfilePic)
        userProfileImageView.sd_setImage(with: checkedUrl)
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- Naviogation Setting
   
//    func functionForGetContactNumberFromProfileBusinessAddressDetailProMaster()
        
    
    
    @objc func savedContactButtonclicked()
        {
        
        var letGetPhoneNumber:String! = ""
//        if(varCallMessageEmail=="whatsapp")
//        {
//            commonClassHoldDataAccessibleVariable = muarrayGetContactProfileUpper.object(at:0) as! CommonAccessibleHoldVariable

//        userMobileNumber = MobileNumberArray.object(at: 0) as? String
            userMobileNumber = onlineMobNo[0]
        userMobileNumber = userMobileNumber.replacingOccurrences(of: " ", with: "")

//            letGetPhoneNumber = commonClassHoldDataAccessibleVariable.varPhoneNumberDynamicProf
            print(userMobileNumber)
            var varGetValue = userMobileNumber
            var userName = dirOnline?.memberListDetailResultss.memberDetailsss.memberName
//            let string = varGetValue!.replacingOccurrences(of: "+", with: "")
//            let newString = string.replacingOccurrences(of: " ", with: "")

        let newContact = CNMutableContact()
        newContact.givenName = userName ?? ""
        newContact.phoneNumbers.append(CNLabeledValue(label: "home", value: CNPhoneNumber(stringValue: varGetValue!)))
        let contactVC = CNContactViewController(forUnknownContact: newContact)
        contactVC.contactStore = CNContactStore()
        contactVC.delegate = self
        contactVC.allowsActions = false
//        self.navigationController?.navigationItem.setHidesBackButton(false, animated: false)
//        let navigationController = UINavigationController(rootViewController: contactVC) //For presenting the vc you have to make it navigation controller otherwise it will not work, if you already have navigatiation controllerjust push it you dont have to make it a navigation controller
//        self.present(contactVC, animated: true, completion: nil)
            self.navigationController?.navigationBar.tintColor = UIColor.systemBlue
            if #available(iOS 11.0, *) {
                contactVC.additionalSafeAreaInsets.top = self.navigationController?.navigationBar.frame.height ?? 0
            }
        self.navigationController?.pushViewController(contactVC, animated: true)

    }

    func createNavigationBar()
    {
        print("Enter in district details directory")
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title="Profile"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(DistrictDirectoryDetailsVC.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(UIImage(named:"share"), for: UIControl.State.normal)
        shareButton.addTarget(self, action: #selector(DistrictDirectoryDetailsVC.shareContact), for: UIControl.Event.touchUpInside)
        let sharing: UIBarButtonItem = UIBarButtonItem(customView: shareButton)

        var buttons:NSArray=NSArray()
        
//        if(isCategory=="2")
//        {
//           self.buttonEditsss.isHidden = true
//            buttons=[sharing]
//        }
//        else
//        {
//        if(isAdmin=="Yes")
//        {
//            buttons=[sharing]
             //print("this is if part edit button")
//            if (NormalMemberOrAdmin == "comingfromcelebreationscreen")
//            {
//                self.buttonEditsss.isHidden = true
//            }
//            else if (NormalMemberOrAdmin == "Classification")
//            {
//                self.buttonEditsss.isHidden = true
//            }
//            else if (NormalMemberOrAdmin == "Family")
//            {
//                self.buttonEditsss.isHidden = true
//            }
//            else if (NormalMemberOrAdmin == "BOD")
//            {
//                self.buttonEditsss.isHidden = true
//            }
//            else
//            {
//            let searchButton = UIButton(type: UIButton.ButtonType.custom)
//            searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//            searchButton.setImage(UIImage(named:"Delete_blue"),  for: UIControl.State.normal)
//            searchButton.addTarget(self, action: #selector(DistrictDirectoryDetailsVC.deleteClicked), for: UIControl.Event.touchUpInside)
//            let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
                
                
//            let settingButton = UIButton(type: UIButton.ButtonType.custom)
//            settingButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//            settingButton.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
//            settingButton.addTarget(self, action: #selector(DistrictDirectoryDetailsVC.editClicked), for: UIControl.Event.touchUpInside)
//            let setting: UIBarButtonItem = UIBarButtonItem(customView: settingButton)
             
              //added by shubhs
                
                if isUserProfile != "yes" {
                    let saveContactButton = UIButton(type: UIButton.ButtonType.custom)
                    saveContactButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                    saveContactButton.setImage(UIImage(named:"saveContact"),  for: UIControl.State.normal)
                    saveContactButton.addTarget(self, action: #selector(DistrictDirectoryDetailsVC.savedContactButtonclicked), for: UIControl.Event.touchUpInside)
                    let savecontact: UIBarButtonItem = UIBarButtonItem(customView: saveContactButton)
                     

                    
//                 buttons = [sharing,search,setting,savecontact]
                    buttons = [sharing,savecontact]
                
                }
                else{
                    buttons = [sharing]
//                    buttons = [sharing,search,setting]
                }
             
            //self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            
//            self.buttonEditsss.isHidden = false
//           }
//        }
//        else
//        {
//            buttons=[sharing]
//            //print("this is else part edit button")
//            //print(NormalMemberOrAdmin)
////            if(NormalMemberOrAdmin == "NormalMemberFromMainDash")
////            {
////                self.buttonEditsss.isHidden = true
////                //self.buttonEditProfileImage.hidden=true
////            }
////            else if (NormalMemberOrAdmin == "comingfromcelebreationscreen")
////            {
////               self.buttonEditsss.isHidden = true
////            }
////            else if (NormalMemberOrAdmin == "Classification")
////            {
////                self.buttonEditsss.isHidden = true
////            }
////            else if (NormalMemberOrAdmin == "Family")
////            {
////                self.buttonEditsss.isHidden = true
////            }
////            else if (NormalMemberOrAdmin == "BOD")
////            {
////                self.buttonEditsss.isHidden = true
////            }
//            else
//            {
//                self.buttonEditProfileImage.isHidden=false
//                let settingButton = UIButton(type: UIButton.ButtonType.custom)
//                settingButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//                settingButton.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
//                settingButton.addTarget(self, action: #selector(ProfileDynamicNewViewController.editClicked), for: UIControl.Event.touchUpInside)
//                let setting: UIBarButtonItem = UIBarButtonItem(customView: settingButton)
//                //let buttons : NSArray = [search, setting] //14 mar
//                 buttons = [sharing,setting]
//                //self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
//                self.buttonEditsss.isHidden = false
//            }
//         }
//        }
         self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
    }
        
//    }
    
//    {
//
//        if(isCategory=="2")
//        {
//           self.buttonEditsss.isHidden = true
//            buttons=[sharing]
//        }
//        else
//        {
//        if(isAdmin=="Yes")
//        {
//            buttons=[sharing]
//             //print("this is if part edit button")
//            if (NormalMemberOrAdmin == "comingfromcelebreationscreen")
//            {
//                self.buttonEditsss.isHidden = true
//            }
//            else if (NormalMemberOrAdmin == "Classification")
//            {
//                self.buttonEditsss.isHidden = true
//            }
//            else if (NormalMemberOrAdmin == "Family")
//            {
//                self.buttonEditsss.isHidden = true
//            }
//            else if (NormalMemberOrAdmin == "BOD")
//            {
//                self.buttonEditsss.isHidden = true
//            }
//            else
//            {
//            let searchButton = UIButton(type: UIButton.ButtonType.custom)
//            searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//            searchButton.setImage(UIImage(named:"Delete_blue"),  for: UIControl.State.normal)
//            searchButton.addTarget(self, action: #selector(ProfileDynamicNewViewController.deleteClicked), for: UIControl.Event.touchUpInside)
//            let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
//
//
//            let settingButton = UIButton(type: UIButton.ButtonType.custom)
//            settingButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//            settingButton.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
//            settingButton.addTarget(self, action: #selector(ProfileDynamicNewViewController.editClicked), for: UIControl.Event.touchUpInside)
//            let setting: UIBarButtonItem = UIBarButtonItem(customView: settingButton)
//
//              //added by shubhs
//
//                if isUserProfile != "yes" {
//                    let saveContactButton = UIButton(type: UIButton.ButtonType.custom)
//                    saveContactButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//                    saveContactButton.setImage(UIImage(named:"saveContact"),  for: UIControl.State.normal)
//                    saveContactButton.addTarget(self, action: #selector(ProfileDynamicNewViewController.savedContactButtonclicked), for: UIControl.Event.touchUpInside)
//                    let savecontact: UIBarButtonItem = UIBarButtonItem(customView: saveContactButton)
//
//
//
//                 buttons = [sharing,search,setting,savecontact]
//
//                }
//                else{
//                    buttons = [sharing,search,setting]
//                }
//
//            //self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
//
//            self.buttonEditsss.isHidden = false
//           }
//        }
//        else
//        {
//            buttons=[sharing]
//            //print("this is else part edit button")
//            //print(NormalMemberOrAdmin)
//            if(NormalMemberOrAdmin == "NormalMemberFromMainDash")
//            {
//                self.buttonEditsss.isHidden = true
//                //self.buttonEditProfileImage.hidden=true
//            }
//            else if (NormalMemberOrAdmin == "comingfromcelebreationscreen")
//            {
//               self.buttonEditsss.isHidden = true
//            }
//            else if (NormalMemberOrAdmin == "Classification")
//            {
//                self.buttonEditsss.isHidden = true
//            }
//            else if (NormalMemberOrAdmin == "Family")
//            {
//                self.buttonEditsss.isHidden = true
//            }
//            else if (NormalMemberOrAdmin == "BOD")
//            {
//                self.buttonEditsss.isHidden = true
//            }
//            else
//            {
//                self.buttonEditProfileImage.isHidden=false
//                let settingButton = UIButton(type: UIButton.ButtonType.custom)
//                settingButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//                settingButton.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
//                settingButton.addTarget(self, action: #selector(ProfileDynamicNewViewController.editClicked), for: UIControl.Event.touchUpInside)
//                let setting: UIBarButtonItem = UIBarButtonItem(customView: settingButton)
//                //let buttons : NSArray = [search, setting] //14 mar
//                 buttons = [sharing,setting]
//                //self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
//                self.buttonEditsss.isHidden = false
//            }
//         }
//        }
//         self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
//    }
//
//
//
//
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    

    
//MARK:- Button Action
    @IBAction func buttonCallAction(_ sender: AnyObject)
    {
        buttonMailSend.isHidden=true
        tableCall.isHidden=false
        tableMessage.isHidden=true
        tableEmail.isHidden=true
        lblCall.text = "Call"
        varCallMessageEmail="Call"
        
        functionForEmailViewAndButonOpticityShow()
        tableCall.reloadData()
       
        //PhoneCallAction()
    }
    @IBAction func buttonMessageAction(_ sender: AnyObject)
    {
        buttonMailSend.isHidden=false
        tableMessage.isHidden=false
        tableEmail.isHidden=true
        tableCall.isHidden=true
        lblCall.text! = "Message"
        varCallMessageEmail="Message"
        functionForEmailViewAndButonOpticityShow()
        tableMessage.reloadData()
        
        //SMSAction()
    }
    @IBAction func buttonEmailAction(_ sender: AnyObject)
    {
        buttonMailSend.isHidden=false
        tableCall.isHidden=true
        tableMessage.isHidden=true
        tableEmail.isHidden=false
        lblCall.text! = "Email"
        functionForEmailViewAndButonOpticityShow()
        tableEmail.reloadData()
        if(EmailsArray.count>0)
        {
         MailAction()
        }
        
        varCallMessageEmail="Email"
       
    }
    
    //MARK:- Call Action
    func PhoneCallAction()
    {
        userMobileNumber = MobileNumberArray.object(at: 0) as! String
        userMobileNumber = userMobileNumber.replacingOccurrences(of: " ", with: "")
        print("calling\(userMobileNumber)")
       
//        let url = URL(string: "tel://\(userMobileNumber)")
//        UIApplication.shared.openURL(url!)
        
        if let url = URL(string: "tel://\(userMobileNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Unable to make a call. Invalid phone number or URL.")
        }
        
        
        /*
        if userMobileNumber.characters.count > 1
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Rotary India"
            alertView.message = String(format:"Do you want to make call with %@",userMobileNumber)
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
                
//                let url = URL(string: "tel://\(userMobileNumber)")
//                UIApplication.shared.openURL(url!)
                
                if let url = URL(string: "tel://\(userMobileNumber)"), UIApplication.shared.canOpenURL(url) {
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
        // PhoneNumberSTR = textfieldMobile.text!
        print("SMS sent")
        let messageVC = MFMessageComposeViewController()
        messageVC.body = ""
        messageVC.recipients = [userMobileNumber] // Optionally add some tel numbers
        messageVC.messageComposeDelegate = self
        // Open the SMS View controller
        present(messageVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {

        controller.dismiss(animated: true, completion: nil)
    }
    
    func MailAction()
    {
       
        //EmailSTR =  EmailsArray.objectAtIndex(0) as! String
        print("Email Sent------------>" , EmailSTR)
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([EmailSTR])      // gg@hing.co.in
            mail.setMessageBody("", isHTML: true)
            
            present(mail, animated: true, completion: nil)
        }
        else
        {
//            let alertView:UIAlertView = UIAlertView()
//            alertView.title = "Rotary India"
//            alertView.message = "Please check whether you have logged in to your mail account."
//            alertView.delegate = self
//            alertView.addButton(withTitle: "OK")
//            alertView.show()
            sendEmailFallback(mail: EmailSTR)
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

    
    
    

    //MARK:- Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(tableView.tag==1)
        {
          return onlineKeyArray.count
        }
        else if(tableView.tag==2)
        {
//         return EmailsArray.count
            return onlineEmail.count
        }
        else if(tableView.tag==3)
        {
            return onlineMobNo.count
        }
        else if(tableView.tag==4)
        {
            return onlineMobNo.count
        }
        else
        {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if(tableView.tag==1)
        {
                cellHeightForFamily = 80
                cell =  tableView.dequeueReusableCell(withIdentifier: "DistrictDirDetailsTableCell") as! DistrictDirDetailsTableCell
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.imgView.isHidden = true
//                if(muarrayForKey.count>0)
                  if(onlineKeyArray.count>0)
                {
                    //            let key = muarrayForKey.object(at: indexPath.row) as! String
                    let key = onlineKeyArray[indexPath.row]
                    //            let value = muarrayForValue.object(at: indexPath.row) as! String
                    let value = onlineValueArray[indexPath.row]
                    if(key == "Email" || key == "Telephone No" || key == "Business Contact No.")
                    {
                        cell.lblValue.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
                    }
                    else
                    {
                        cell.lblValue.textColor = UIColor.black
                    }
                    print(key , value)
                      if (key == "Family Photo") {
                          cellHeightForFamily = 200
                          cell.lblValue.isHidden = true
                          cell.imgView.isHidden = false
                          NSLayoutConstraint.activate([
                            cell.imgView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
                            cell.imgView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8),
                            cell.imgView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
                            cell.imgView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -8)
                                  ])
                          cell.lblKey.text = key
                          let ImageProfilePic = value.replacingOccurrences(of: " ", with: "%20")
                          let checkedUrl = URL(string: ImageProfilePic)
                          print(ImageProfilePic)
                          cell.imgView.sd_setImage(with: checkedUrl)
                      } else if (key == "Birthday" || key == "Anniversary"){
                          cellHeightForFamily = 80
                          cell.lblValue.isHidden = false
                          cell.imgView.isHidden = true
                          cell.lblKey.text = key
                          if let convertedDate = convertDateToWords(dateString: value) {
                              print("Converted date: \(convertedDate)")
                              cell.lblValue.text = convertedDate
                          } else {
                              print("Invalid date format")
                          }
                          
                      } else {
                          cellHeightForFamily = 80
                          cell.lblValue.isHidden = false
                          cell.imgView.isHidden = true
                          cell.lblKey.text = key
                          cell.lblValue.text = value
                      }
                    
                }
        return cell
        }
        else if(tableView.tag==2)
        {
            cellHeightForFamily = 80
          cells =  tableView.dequeueReusableCell(withIdentifier: "DistrictDirDetailsTableCell") as! DistrictEmailTableViewCell
            cells.selectionStyle = UITableViewCell.SelectionStyle.none
//            if(EmailsArray.count>0)
            if (onlineEmail.count > 0)
            {
//              let abc = EmailsArray.object(at: indexPath.row) as! String
                let abc = onlineEmail[indexPath.row]
                cells.labelNameEmail.text = "Email"
                cells.buttonEmailEmailSend.setTitle(abc,  for: UIControl.State.normal)
                print(abc)
                if(EmailCheckUncheck.object(at: indexPath.row) as? String=="0")
                    
                {
                    cells.buttonCheckboxEmail.setImage(UIImage(named: "Uncheck_DynaProfile.png"),  for: UIControl.State.normal)
                }
                else
                {
                    cells.buttonCheckboxEmail.setImage(UIImage(named: "Check_DynaProfile.png"),  for: UIControl.State.normal)
                }
            }
            //Check Uncheck
            cells.buttonCheckboxEmail.addTarget(self, action: #selector(DistrictDirectoryDetailsVC.buttonEmailCheckUncheckClicked(_:)), for: UIControl.Event.touchUpInside)
            cells.buttonCheckboxEmail.tag=indexPath.row;
            //Maion Button
            cells.buttonCheckBoxEmailMain.addTarget(self, action: #selector(DistrictDirectoryDetailsVC.buttonEmailCheckUncheckClicked(_:)), for: UIControl.Event.touchUpInside)
            cells.buttonCheckBoxEmailMain.tag=indexPath.row;
            
            return cells
        }
        else if(tableView.tag==3)
        {
            cellHeightForFamily = 80
            cellss =  tableView.dequeueReusableCell(withIdentifier: "DistrictDirDetailsTableCell") as! DistrictCallMessageTableViewCell
            cellss.selectionStyle = UITableViewCell.SelectionStyle.none
//            if(MobileNumberArray.count>0)
            if (onlineMobNo.count > 0)
            {
//                let abc = MobileNumberArray.object(at: indexPath.row) as! String
                let abc = onlineMobNo[indexPath.row]
                cellss.labelName.text = "Telephone No."
                cellss.buttonMobileNumber.setTitle(abc,  for: UIControl.State.normal)
                print(abc)
                if(MobileNumberCheckUncheck.object(at: indexPath.row) as? String=="0")
                    
                {
                    cellss.buttonCheckBoxMobileNumber.setImage(UIImage(named: "Uncheck_DynaProfile.png"),  for: UIControl.State.normal)
                }
                else
                {
                    cellss.buttonCheckBoxMobileNumber.setImage(UIImage(named: "Check_DynaProfile.png"),  for: UIControl.State.normal)
                }
            }
            //Check Uncheck
            cellss.buttonCheckBoxMobileNumber.addTarget(self, action: #selector(DistrictDirectoryDetailsVC.buttonEmailCheckUncheckClicked(_:)), for: UIControl.Event.touchUpInside)
            cellss.buttonCheckBoxMobileNumber.tag=indexPath.row;
            //Maion Button
            cellss.buttonCheckBoxMobileNumberMain.addTarget(self, action: #selector(DistrictDirectoryDetailsVC.buttonEmailCheckUncheckClicked(_:)), for: UIControl.Event.touchUpInside)
            cellss.buttonCheckBoxMobileNumberMain.tag=indexPath.row;
            
            return cellss
        }
        else if(tableView.tag==4)
        {
            cellHeightForFamily = 80
            CallCell =  tableView.dequeueReusableCell(withIdentifier: "DistrictDirDetailsTableCell") as! CallTableViewCell
            CallCell.selectionStyle = UITableViewCell.SelectionStyle.none
//            if(MobileNumberArray.count>0)
            if (onlineMobNo.count > 0)
            {
//                let abc = MobileNumberArray.object(at: indexPath.row) as! String
                let abc = onlineMobNo[indexPath.row]
                CallCell.labelName.text = "Telephone No."
                CallCell.buttonCallNumber.setTitle(abc,  for: UIControl.State.normal)
                print(abc)
                
            }
            //Check Uncheck
            CallCell.buttonCalling.addTarget(self, action: #selector(DistrictDirectoryDetailsVC.buttonEmailCheckUncheckClicked(_:)), for: UIControl.Event.touchUpInside)
            CallCell.buttonCalling.tag=indexPath.row;
            
            
            CallCell.buttonWhatsApp.addTarget(self, action: #selector(DistrictDirectoryDetailsVC.buttonWhatsAppClicked(_:)), for: UIControl.Event.touchUpInside)
            CallCell.buttonWhatsApp.tag=indexPath.row;
            
           // varCallMessageEmail=="Call"
            
             if(varCallMessageEmail=="whatsapp")
             {
                  CallCell.buttonWhatsApp.isHidden=false
                 CallCell.buttonCalling.isHidden=true
             }
            else
             {
                CallCell.buttonWhatsApp.isHidden=true
                CallCell.buttonCalling.isHidden=false
            }
            
            
            
            
            //CallCell.buttonWhatsApp.addTarget(self, action: #selector(DistrictDirectoryDetailsVC.buttonWhatsAppClicked(_:)), for: UIControl.Event.touchUpInside)
           // CallCell.buttonWhatsApp.tag=indexPath.row;
            
            
            
            
            return CallCell
        }
        
        
        
       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("Select Row Index --  ", indexPath.row)
        if(tableView.tag==1)
        {
            //            let key = muarrayForKey.object(at: indexPath.row) as! String
            var key = onlineKeyArray[indexPath.row]
            //            let value = muarrayForValue.object(at: indexPath.row) as! String
            var value = onlineValueArray[indexPath.row]
            if(key == "Business Email ID" || key == "Email ID" || key == "Email")
            {
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients([value])      // gg@hing.co.in
                    mail.setMessageBody("", isHTML: true)
                    present(mail, animated: true, completion: nil)
                }
                else
                {
                    sendEmailFallback(mail: value)

                }
            }
            else if key == "Facebook" || key == "Instagram" || key == "Linkedin" {
                let webScreen = self.storyboard?.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
                webScreen.varOpenUrl = value
                webScreen.navTitle = key
                print(webScreen.varOpenUrl)
                self.navigationController?.pushViewController(webScreen, animated: true)
            }
            else if(key == "Telephone No" || key == "Mobile Number" || key == "Secondary Mobile Number" || key == "Mobile")
            {
                value = value.replacingOccurrences(of: " ", with: "")
                print("calling\(value)")
                if value.characters.count > 1
                {
//                    let url = URL(string: "tel://\(value)")
//                    UIApplication.shared.openURL(url!)
                    
                    if let url = URL(string: "tel://\(value)"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        print("Unable to make a call. Invalid phone number or URL.")
                    }
                }
                else
                {
                }
            }
            else             if key == "Member Introduction" {
                let memberIntroVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfileMemberIntroViewController") as! ProfileMemberIntroViewController
                memberIntroVC.desc = value
                memberIntroVC.navTitle = "Member Introduction"
                self.navigationController?.pushViewController(memberIntroVC, animated: true)
            }
            
            if key == "Address" || key == "Business Address"{
                let memberIntroVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfileMemberIntroViewController") as! ProfileMemberIntroViewController
                memberIntroVC.desc = value
                memberIntroVC.navTitle = "Address"
                self.navigationController?.pushViewController(memberIntroVC, animated: true)
            }

            else if(key == "Business Contact No.")
            {
                value = value.replacingOccurrences(of: " ", with: "")
                print("calling\(value)")
                if value.characters.count > 1
                {
//                    let url = URL(string: "tel://\(value)")
//                    UIApplication.shared.openURL(url!)
                    
                    if let url = URL(string: "tel://\(value)"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        print("Unable to make a call. Invalid phone number or URL.")
                    }
                }
                else
                {
                }
            }
            else
            {
            print("Nothing")
            }
        }
        else
        {
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(tableView.tag==2 || tableView.tag==3 || tableView.tag==4)
        {
          return 70
        }
        else if tableView.tag == 1 {
         return cellHeightForFamily
        }
        else
        {
         return UITableView.automaticDimension
        }
        //Choose your custom row height
    }
    
    //buttonWhatsAppClicked
    @objc func buttonWhatsAppClicked(_ sender:UIButton)
    {
        print("2")
        print(sender.tag)
        print("map clicked !")
        if(varCallMessageEmail=="whatsapp")
        {
            var mobileNumber = MobileNumberArray.object(at: sender.tag) as! String
            let string = mobileNumber.replacingOccurrences(of: "+", with: "")
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
            else
            {
                
            }
            
        }
    }
    @IBAction func buttonEmailCheckUncheckClicked(_ sender: AnyObject)
    {
        if(varCallMessageEmail=="Email")
        {
            let varGetValue = EmailCheckUncheck.object(at: sender.tag)
            if(varGetValue as! String=="0")
                
            {
                EmailCheckUncheck.replaceObject(at: sender.tag, with: "1")
            }
            else  if(varGetValue as! String=="1")
            {
                EmailCheckUncheck.replaceObject(at: sender.tag, with: "0")
            }
            tableEmail.reloadData()
        }
        
        else if(varCallMessageEmail=="Message")
        {
            let varGetValue = MobileNumberCheckUncheck.object(at: sender.tag)
            if(varGetValue as! String=="0")
                
            {
                MobileNumberCheckUncheck.replaceObject(at: sender.tag, with: "1")
            }
            else  if(varGetValue as! String=="1")
            {
                MobileNumberCheckUncheck.replaceObject(at: sender.tag, with: "0")
            }
            tableMessage.reloadData()
        }
        else if(varCallMessageEmail=="Call")
        {
           var mobileNumber = MobileNumberArray.object(at: sender.tag) as! String
            mobileNumber = mobileNumber.replacingOccurrences(of: " ", with: "")
            print("calling\(mobileNumber)")
            if mobileNumber.characters.count > 1
            {
//                let url = URL(string: "tel://\(mobileNumber)")
//                UIApplication.shared.openURL(url!)
                
                if let url = URL(string: "tel://\(mobileNumber)"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    print("Unable to make a call. Invalid phone number or URL.")
                }
            }
            else
            {
                
            }
            
        }
        else if(varCallMessageEmail=="whatsapp")
        {
            var mobileNumber = MobileNumberArray.object(at: sender.tag) as! String
            let string = mobileNumber.replacingOccurrences(of: "+", with: "")
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
            else
            {
                
            }
            
        }
        else
        {
            
        }
        //varCallMessageEmail="whatsapp"
    }
    
    @IBAction func buttonMobileNumberCheckUncheckClicked(_ sender: AnyObject)
    {
        

    }

    
    
    //MARK:- Server Calling
    func functionForGetDistrictMemberList()
    {
       // loaderClass.loaderViewMethod()
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")! as String
        var  completeURL:String!=""
        completeURL = baseUrl+"District/GetMemberWithDynamicFields"
        
     
        
        print(selectedMemberProfileID)
        print(groupID)

        let parameterst = ["memberProfileId":selectedMemberProfileID,"groupId":groupID]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print("District Directory Details Details DC !!!!!")
            let dd = response as! NSDictionary
            print(dd)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            let status = (dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "status") as! String
            let message = (dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "message") as! String
            print(status,message)
            
            if((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "status") as! String == "0" )
            {
                self.getContactDetails(dd: dd)
                let profilePic = ((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "profilePic") as! String
                
                
                
                self.isUpperImageAvailable=profilePic
                if(profilePic=="")
                {
                    
                    self.userProfileImageView.image = UIImage(named: "profile_pic")
                }
                else
                {
                    //lblUserDesignation.text! = userMobileNumber
                    let ImageProfilePic:String = profilePic.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    self.userProfileImageView.sd_setImage(with: checkedUrl)
                    
                }
                
                
                let memberNames = ((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "memberName") as! String
//                self.lblUserName.text! = memberNames

                print(((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "profilePic") as! String)
                
                //Personal Details Geting from server
                for i in 0 ..< (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).value(forKey: "MemberDetails")! as AnyObject).value(forKey: "personalMemberDetails")! as AnyObject).value(forKey: "uniquekey")! as AnyObject).count)
                {
                    let keyString = ((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "personalMemberDetails")! as AnyObject).value(forKey: "key")! as AnyObject).object(at: i) as! String
                    let valueString = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).value(forKey: "MemberDetails")! as AnyObject).value(forKey: "personalMemberDetails")! as AnyObject).value(forKey: "value")! as AnyObject).object(at: i) as! String)
                    print(keyString,valueString)
                    let trimedValue = valueString.trimmingCharacters(in: CharacterSet.whitespaces)
                    
                    if(keyString == "Club Name")
                    {
                        if(trimedValue.characters.count>0)
                        {
                       self.lblUserDesignation.text! = trimedValue
                        }
                        else
                        {
                            self.lblUserDesignation.text! = trimedValue
 
                        }
                    }
                    if(keyString == "Club Designation")
                    {
                        if(trimedValue.characters.count>0)
                        {
                          //  self.labelClubDesignation.text! = trimedValue+" (Club)"

                        }
                        else
                        {
                           // self.labelClubDesignation.text! = trimedValue

                        }
                    }
                    //GetEmailArray
                    if(keyString == "Email" && trimedValue != "")
                    {
                        self.EmailsArray.add(trimedValue)
                        self.EmailCheckUncheck.add("0")
                    }
                    //Getting Telephone No
                    if(keyString == "Telephone No" && trimedValue != "")
                    {
                        self.MobileNumberArray.add(trimedValue)
                        self.MobileNumberCheckUncheck.add("0")
                    }
                    
                    if(keyString=="" || trimedValue == "" || keyString=="Name")
                    {
                    }
                    else
                    {
                        if(keyString=="Birthday" || keyString=="Anniversary" )
                        {
                            var DOB: String = valueString
                            let dobArray = DOB.components(separatedBy: "/")
                            
                            var getMonth: String = dobArray[1]
                            var varPassMonth = commonClassFunction().functionForMonthWordWise(String(getMonth))
                            
                            
                            self.muarrayForKey.add(keyString)
                            self.muarrayForValue.add(dobArray[0]+" "+varPassMonth)
                        }
                        else
                        {
                            print("this is key value pair !!!!")
                            print(keyString)
                            print(trimedValue)
                            if(keyString=="Blood Group")
                            {
                                
                            }
                            else
                            {
                        self.muarrayForKey.add(keyString)
                        self.muarrayForValue.add(trimedValue)
                            }
                        }
                    }
                }
                
                //Business Details Geting from server
                for i in 0 ..< (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).value(forKey: "MemberDetails")! as AnyObject).value(forKey: "businessMemberDetails")! as AnyObject).value(forKey: "uniquekey")! as AnyObject).count)
                {
                    let keyString = ((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "businessMemberDetails")! as AnyObject).value(forKey: "key")! as AnyObject).object(at: i) as! String
                    let valueString = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).value(forKey: "MemberDetails")! as AnyObject).value(forKey: "businessMemberDetails")! as AnyObject).value(forKey: "value")! as AnyObject).object(at: i) as! String)
                    print(keyString,valueString)
                    let trimedValue = valueString.trimmingCharacters(in: CharacterSet.whitespaces)
                    if(keyString=="" || trimedValue == "")
                    {
                    }
                    else
                    {
                        print(keyString)
                     
                            self.muarrayForKey.add(keyString)
                            self.muarrayForValue.add(trimedValue)
                  
                       
                    }
                    
                    
                    //GetEmailArray
                    if(keyString == "Email" && trimedValue != "")
                    {
                        self.EmailsArray.add(trimedValue)
                        self.EmailCheckUncheck.add("0")
                    }
                }
                //Address Details Geting from server
                let ResidancyAddress = (((dd.object(forKey: "MemberListDetailResult")! as AnyObject).value(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "isResidanceAddrVisible") as! String
                let BusinessAddress = (((dd.object(forKey: "MemberListDetailResult")! as AnyObject).value(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "isBusinessAddrVisible") as! String
                
                print(ResidancyAddress , BusinessAddress)
                if(BusinessAddress=="n")
                {
                }
                else
                {
                    var intvalue:Int=0
                    var intvalue1:Int=0
                    var intvalue2:Int=0
                    for i in 0 ..< ((((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).value(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "addressID")! as AnyObject).count)
                    {
                        let address = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "address")! as AnyObject).object(at: i) as! String
                        let city = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "city")! as AnyObject).object(at: i) as! String
                        let state = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "state")! as AnyObject).object(at: i) as! String
                        let country = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "country")! as AnyObject).object(at: i) as! String
                        let pincode = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "pincode")! as AnyObject).object(at: i) as! String
                        let fax = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "fax")! as AnyObject).object(at: i) as! String
                        let phoneNo = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "phoneNo")! as AnyObject).object(at: i) as! String
                        print(address,city,state,country,pincode,fax,phoneNo)
                        
                       let fullAddress = address+","+city+","+state+","+pincode+","+country
                        let address1 = fullAddress.replacingOccurrences(of: ",,", with: ",")
                        let address2 = address1.replacingOccurrences(of: ",,", with: ",")
                        self.muarrayContactKey.add("address")
                        self.muarrayContactValue.add(address)
                        self.muarrayContactKey.add("city")
                        self.muarrayContactValue.add(city)
                        self.muarrayContactKey.add("state")
                        self.muarrayContactValue.add(state)
                        self.muarrayContactKey.add("country")
                        self.muarrayContactValue.add(country)
                        self.muarrayContactKey.add("pincode")
                        self.muarrayContactValue.add(pincode)
                        
                        
                        
                        var varGetstringGetcountryId:String! =  self.functionForSelectCountry(country)
                        
                        
                        if(address2 != "" && address2 != ",," && address2 != ",")
                        {
                            if(intvalue1==0)
                            {
                            self.muarrayForKey.add("Business Address")
                            self.muarrayForValue.add(address2)
                                 intvalue1=1
                            }
                        }
                        if(phoneNo != "")
                        {
                            if(intvalue==0)
                            {
                            self.muarrayForKey.add("Business Contact")
                            self.muarrayForValue.add(varGetstringGetcountryId+" "+phoneNo)
                            //rajendra added on 21 oct 12.25pm
                           
                            self.MobileNumberArray.add(varGetstringGetcountryId+" "+phoneNo)
                            self.MobileNumberCheckUncheck.add("0")
                                intvalue=1
                            }
                            
                        }
                        if(fax != "")
                        {
                            if(intvalue2==0)
                            {
                            self.muarrayForKey.add("Fax Number")
                            self.muarrayForValue.add(fax)
                             intvalue2=1
                            }
                        }
                    }
                    
                    
                    
                    
                }
                if(ResidancyAddress=="n")
                {
                }
                else
                {
                }
               //Email validation
                if(self.EmailsArray.count>0)
                {
                    print(self.EmailsArray)
                }
                else
                {
                    self.btnMail.setImage(UIImage(named: "mail_gray"),  for: UIControl.State.normal)

                  print("Email Gray Image setting")
                }
                //Telephone No Validation
                if(self.MobileNumberArray.count>0)
                {
                    print(self.MobileNumberArray)
                }
                else
                {
                    self.btnMail.setImage(UIImage(named: "call_gray"),  for: UIControl.State.normal)
                 print("Calling Gray Image setting")
                }
                self.tableDirUserDetails.reloadData()
                self.loaderClass.window=nil
            }
            else
            {
                self.loaderClass.window=nil
                 SVProgressHUD.dismiss()
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            }
            SVProgressHUD.dismiss()
            }
        })
    }
    
    
    func getContactDetails(dd:NSDictionary)
    {
        let memberEmail=((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "memberEmail") as! String
        let memberName=((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "memberName") as! String
        let memberMobile=((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "memberMobile") as! String

        let fullAddress:NSArray=(((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult") as! NSArray
        print("Full address:: \(fullAddress)")
        
        if fullAddress.count>0
        {
        let address = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "address")! as AnyObject).object(at: 0) as! String
        let city = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "city")! as AnyObject).object(at: 0) as! String
        let state = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "state")! as AnyObject).object(at: 0) as! String
        let country = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "country")! as AnyObject).object(at: 0) as! String
        let pincode = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "pincode")! as AnyObject).object(at: 0) as! String
        let fax = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "fax")! as AnyObject).object(at: 0) as! String
        let phoneNo = (((((dd.object(forKey: "MemberListDetailResult")! as AnyObject).object(forKey: "MemberDetails")! as AnyObject).value(forKey: "addressDetails")! as AnyObject).value(forKey: "addressResult")! as AnyObject).value(forKey: "phoneNo")! as AnyObject).object(at: 0) as! String
        print(address,city,state,country,pincode,fax,phoneNo)
        

        self.muarrayContactKey.add("address")
        self.muarrayContactValue.add(address)
        self.muarrayContactKey.add("city")
        self.muarrayContactValue.add(city)
        self.muarrayContactKey.add("state")
        self.muarrayContactValue.add(state)
        self.muarrayContactKey.add("country")
        self.muarrayContactValue.add(country)
        self.muarrayContactKey.add("pincode")
        self.muarrayContactValue.add(pincode)
        }
        self.muarrayContactKey.add("memberName")
        self.muarrayContactValue.add(memberName)
        self.muarrayContactKey.add("Email")
        self.muarrayContactValue.add(memberEmail)
        self.muarrayContactKey.add("Telephone No")
        self.muarrayContactValue.add(memberMobile)
    }
    func functionForSelectCountry(_ stringCountryName:String)->String
    {
        var letGetLastUpdateDate:String!=""
        
        ModelManager.getInstance()
        
        //  ModelManager.getInstance().getAllStudentData(String(NSCalendar.currentCalendar().components([.Day , .Month , .Year], fromDate: NSDate()).month), stringYear: String(NSCalendar.currentCalendar().components([.Day , .Month , .Year], fromDate: NSDate()).year))
        
        
        
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("select DISTINCT country_code from country_master where country_master_name='"+stringCountryName+"'", withArgumentsIn: nil)
        
        print("select DISTINCT country_code from country_master where country_master_name='"+stringCountryName+"'")
        
        
        
        var stringGetcountryId:String!=""
        if (resultSet != nil)
        {
            while resultSet.next()
            {
                stringGetcountryId = resultSet.string(forColumn: "country_code")
                
            }
        }
        sharedInstance.database!.close()
        print(stringGetcountryId)
        return stringGetcountryId
    }
    
    
    
    
    
    
    @IBAction func buttonSendPopUpClickEvent(_ sender: AnyObject)
    {
       if varCallMessageEmail=="Email"
            {
                var arrayEmailAddress = [String]()
                let varEmailString:String!=""
                var varISEmailNumberContain:String!="no"
                
                for i in 00..<EmailsArray.count
                {
                    let varGetValue = EmailCheckUncheck.object(at: i)
                    if(varGetValue as! String=="1")
                    {
                        let emailID  =   EmailsArray.object(at: i) as! String
                        print(emailID)
                        varISEmailNumberContain="yes"
                        arrayEmailAddress.append(emailID)
                    }
                }
                if(varISEmailNumberContain=="no")
                {
                    self.view.makeToast("Please select at least one Email id ", duration: 2, position: CSToastPositionCenter)
                }
                else if(varISEmailNumberContain=="yes")
                {
                    if MFMailComposeViewController.canSendMail()
                    {
                        print(varEmailString)
                        let mail = MFMailComposeViewController()
                        mail.mailComposeDelegate = self
                        mail.setToRecipients(arrayEmailAddress)// gg@hing.co.in
                        mail.setMessageBody("", isHTML: true)
                        present(mail, animated: true, completion: nil)
                    }
                    else
                    {
                    }
                }
            }
        else if(varCallMessageEmail=="Message")
       {
        var varContactString = [String]()
        var varISPhoneNumberContain:String!="no"
        for i in 00..<MobileNumberArray.count
        {
            let varGetValue = MobileNumberCheckUncheck.object(at: i)
            if(varGetValue as! String=="1")
            {
               let  varGetPhoneNumber = MobileNumberArray.object(at: i) as! String
                varContactString.append(varGetPhoneNumber)
                varISPhoneNumberContain="yes"
            }
            
        }
        if(varISPhoneNumberContain=="no")
        {
            self.view.makeToast("Please select at least one contact number", duration: 2, position: CSToastPositionCenter)
        }
        else if(varISPhoneNumberContain=="yes")
        {
            //varContactString
            print("SMS sent")
            let messageVC = MFMessageComposeViewController()
            messageVC.body = ""
            messageVC.recipients = varContactString // Optionally add some tel numbers
            messageVC.messageComposeDelegate = self
            // Open the SMS View controller
            present(messageVC, animated: true, completion: nil)
        }
        }
    }
    
    @IBAction func buttonClosePopUpClickEvent(_ sender: AnyObject)
    {
        functionForEmailViewAndButonOpticityHide()
        
        if(varCallMessageEmail=="Message")
        {
            MobileNumberCheckUncheck=NSMutableArray()
            for i in 0..<MobileNumberArray.count
            {
                MobileNumberCheckUncheck.add("0")
                //cells.buttonCheckboxEmail.setImage(UIImage(named: "Uncheck_DynaProfile.png"), forState: .Normal)
            }
            tableMessage.reloadData()
            tableMessage.isHidden = true
        }
        if(varCallMessageEmail=="Email")
        {
            EmailCheckUncheck=NSMutableArray()
            
            for i in 0..<EmailsArray.count
            {
                EmailCheckUncheck.add("0")
                //cells.buttonCheckboxEmail.setImage(UIImage(named: "Uncheck_DynaProfile.png"), forState: .Normal)
            }
            tableEmail.reloadData()
            tableMessage.isHidden = true
        }
    }
    
    func convertDateToWords(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
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
      
}

struct DistDirectoryDetailOnline: Codable {
    let memberListDetailResultss: MemberListDetailResultss

    enum CodingKeys: String, CodingKey {
        case memberListDetailResultss = "MemberListDetailResult"
    }
}

// MARK: - MemberListDetailResult
struct MemberListDetailResultss: Codable {
    let status, message: String
    let memberDetailsss: MemberDetailss

    enum CodingKeys: String, CodingKey {
        case status, message
        case memberDetailsss = "MemberDetails"
    }
}

// MARK: - MemberDetails
struct MemberDetailss: Codable {
    let masterID, grpID, profileID, isAdmin: String?
    let memberName, memberEmail, memberMobile, memberCountry: String?
    let profilePic, familyPic: String?
    let gender, youthFlag, memberSuffix, memberPrefix: String?
    let primaryLanguage: String?
    let memberInfo: String?
    let faceBookTxt: String?
    let instagramTxt, twitterTxt, linkedInTxt, websiteTxt: String?
    let youtubeTxt, isPersonalDetVisible, isBusinDetVisible, isFamilDetailVisible: String?
    let secondaryMobile, businessName, businessPhoneNo, businessAdress: String?
    let businessDesignation, classification, keywords, rotaryid: String?
    let clubDesignation, memberDateOfBirth, memberDateOfWedding, bloodGroup: String?
    let donorRecognition, clubName: String?
    let personalMemberDetails, businessMemberDetails: [MemberDetailses]?
    let familyMemberDetails: FamilyMemberDetails?
    let addressDetails: AddressDetails?

    enum CodingKeys: String, CodingKey {
        case masterID, grpID, profileID, isAdmin, memberName, memberEmail, memberMobile, memberCountry, profilePic, familyPic
        case gender = "Gender"
        case youthFlag = "Youth_Flag"
        case memberSuffix = "Member_Suffix"
        case memberPrefix = "Member_Prefix"
        case primaryLanguage = "PrimaryLanguage"
        case memberInfo = "member_info"
        case faceBookTxt = "FaceBook_Txt"
        case instagramTxt = "Instagram_Txt"
        case twitterTxt = "Twitter_Txt"
        case linkedInTxt = "LinkedIn_Txt"
        case websiteTxt = "Website_Txt"
        case youtubeTxt = "Youtube_Txt"
        case isPersonalDetVisible, isBusinDetVisible, isFamilDetailVisible
        case secondaryMobile = "SecondaryMobile"
        case businessName = "BusinessName"
        case businessPhoneNo = "Business_Phone_no"
        case businessAdress = "Business_Adress"
        case businessDesignation = "Business_Designation"
        case classification = "Classification"
        case keywords = "Keywords"
        case rotaryid, clubDesignation
        case memberDateOfBirth = "member_date_of_birth"
        case memberDateOfWedding = "member_date_of_wedding"
        case bloodGroup = "blood_Group"
        case donorRecognition = "Donor_Recognition"
        case clubName = "Club_Name"
        case personalMemberDetails, businessMemberDetails, familyMemberDetails, addressDetails
    }
}

// MARK: - AddressDetails
struct AddressDetails: Codable {
    let isResidanceAddrVisible: String?
    let isBusinessAddrVisible: IsVisible?
    let addressResult: [AddressResult]?
}

// MARK: - AddressResult
struct AddressResult: Codable {
    let addressID, addressType, address, city: String?
    let state, country, pincode, phoneNo: String?
    let fax, profileID: String?
}

enum IsVisible: String, Codable {
    case y = "y"
}

// MARK: - MemberDetail
struct MemberDetailses: Codable {
    let fieldID, uniquekey, key, value: String?
    let colType, isEditable: String?
    let isVisible: IsVisible?
}

// MARK: - FamilyMemberDetails
struct FamilyMemberDetails: Codable {
    let isVisible: String?
    let familyMemberDetail: [JSONAny]?
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
