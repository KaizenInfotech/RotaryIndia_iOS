
//  EditUpdateProfileViewController.swift
//  TouchBase
//
//  Created by deepak on 27/06/17.
//  Copyright © 2017 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


class EditUpdateProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate,UITextFieldDelegate
{
    var appDelegate : AppDelegate = AppDelegate()
    
    @IBOutlet weak var labelLoading: UILabel!
    var muarraySelectCountry:NSMutableArray=NSMutableArray()
    var muarrayBloodGroup:NSMutableArray=NSMutableArray()
    var muarrayRelationShip:NSMutableArray=NSMutableArray()
    var objCalendarInfo : CalendarInfo = CalendarInfo()
//    dictPersonalInfoArray
    
    var dictPersonalInfoArray:NSMutableDictionary = NSMutableDictionary()
    
    var currentdate: String = ""
    let timeFormatter = Foundation.DateFormatter()
    let DateFormatter = Foundation.DateFormatter()
    var  dateTimeDisplay:String = ""
    var varRasidentialContactKeyBoardHideShow:String! = ""
    @IBOutlet weak var butonOpacityTwo: UIButton!
    //--public variable
    var stringCountryMasterId:String!=""
    var stringCountryMasterCode:String!=""
    var stringCountryMasterName:String!=""
    var varPublicSelectedRowIndex:String!=""
    var varWhichButtonSelectForCountryNameorCode:String!=""
    var varGetBloodGroup:String!=""
    var varGetRelationShipText:String!=""
    var varSelectedTableRowTextFieldTag:Int!=0
    var varSelectedTableRowIndexGet_Text:String!=""
    var varSelectedTableRowIndex:Int!=0
    var varRowHeight:CGFloat!=0.0
    //--
    var cell:EditUpdateProfileTableViewCell=EditUpdateProfileTableViewCell()
    
    
    //view popup blood group
    
    @IBOutlet weak var buttonOpacity: UIButton!
    
    //1.
    @IBOutlet weak var viewBloodGroup: UIView!
    @IBOutlet weak var pickerBloodGroup: UIPickerView!
    
    //2.
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var pickerCountry: UIPickerView!
    
    //3.
    @IBOutlet weak var viewRelationship: UIView!
    @IBOutlet weak var pickerRelationship: UIPickerView!
    
    //4.
    @IBOutlet weak var viewDOB: UIView!
    @IBOutlet weak var pickerDOB: UIDatePicker!
    
    //common
    var muarrayPersonalorAddressorFamilyDetail:NSMutableArray=NSMutableArray()
    //first
    var muarrayKeyFirst:NSMutableArray=NSMutableArray()
    var muarrayValueFirst:NSMutableArray=NSMutableArray()
    var muarrayCountryTextFirst:NSMutableArray=NSMutableArray()
    var muarrayCountryCodeFirst:NSMutableArray=NSMutableArray()
    var muarrayCountryIdFirst:NSMutableArray=NSMutableArray()
    //second
    var muarrayAddressSecond:NSMutableArray=NSMutableArray()
    var muarrayCitySecond:NSMutableArray=NSMutableArray()
    var muarrayPostalCodeSecond:NSMutableArray=NSMutableArray()
    var muarrayStateSecond:NSMutableArray=NSMutableArray()
    var muarrayAddressIdSecond:NSMutableArray=NSMutableArray()
    var muarrayCountryTextSecond:NSMutableArray=NSMutableArray()
    var muarrayCountryCodeSecond:NSMutableArray=NSMutableArray()
    var muarrayCountryIdSecond:NSMutableArray=NSMutableArray()
    var muarrayBusinessContactCountryTextSecond:NSMutableArray=NSMutableArray()
    var muarrayBusinessContactCountryCodeSecond:NSMutableArray=NSMutableArray()
    var muarrayBusinessContactCountryIdSecond:NSMutableArray=NSMutableArray()
    var muarrayBusinessContactMobileNumberSecond:NSMutableArray=NSMutableArray()
    //three
    var muarrayNameThree:NSMutableArray=NSMutableArray()
    var muarrayFamilyMemberIDThree:NSMutableArray=NSMutableArray()
    var muarrayFamilyMemberDeletedIDThree:NSMutableArray=NSMutableArray()
    var muarrayRelationshipThree:NSMutableArray=NSMutableArray()
    var muarrayCountryTextThree:NSMutableArray=NSMutableArray()
    var muarrayCountryCodeThree:NSMutableArray=NSMutableArray()
    var muarrayCountryIdThree:NSMutableArray=NSMutableArray()
    var muarrayMobileNumberThree:NSMutableArray=NSMutableArray()
    var muarrayEmailIDThree:NSMutableArray=NSMutableArray()
    var muarrayBloodGroupThree:NSMutableArray=NSMutableArray()
    var muarrayBirthdayThree:NSMutableArray=NSMutableArray()
    var muarrayAnniversaryThree:NSMutableArray=NSMutableArray()
    //IB
    @IBOutlet weak var tableviewEditUpdateProfile: UITableView!
    //Varibale
    var profileId:String!=""
    var grpID:String!=""
    var isAdmin:String!=""
    
    
    //for family member detail button
    var varIsFamilyMemberorNot:String!
    //View load start and other
    override func viewWillAppear(_ animated: Bool)
    {
        Util.copyFile("Calendar.sqlite")
        muarraySelectCountry=NSMutableArray()
        muarraySelectCountry = ModelManager.getInstance().functionForSelectCountry()
        print(muarraySelectCountry.count)
        UserDefaults.standard.setValue("no", forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        pickerDOB.setStyle()
        self.addDoneButtonOnKeyboard()
        functionForHiddenAll()
        labelLoading.isHidden=true
        butonOpacityTwo.isHidden=true
        stringCountryMasterId =   "1"
        stringCountryMasterCode =   "+91"
        stringCountryMasterName =   "India"
        UserDefaults.standard.setValue("", forKey: "session_lastUpdateDate")
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EditUpdateProfileViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        tableviewEditUpdateProfile.addGestureRecognizer(tapGesture)
        muarrayPersonalorAddressorFamilyDetail=["personal","personal","personal","personal","personal","personal","personal","personal","personal","personal","personal","personal","personal","personal","personal","personal","personal","personal"]
        muarrayKeyFirst=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayValueFirst=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayCountryTextFirst=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayCountryCodeFirst=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayCountryIdFirst=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayAddressSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayCitySecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayPostalCodeSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayStateSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayAddressIdSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        
        
        muarrayCountryTextSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayCountryCodeSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayCountryIdSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayBusinessContactCountryTextSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayBusinessContactCountryCodeSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayBusinessContactCountryIdSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayBusinessContactMobileNumberSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        
        
        
        muarrayNameThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayFamilyMemberIDThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        
        
        
        muarrayRelationshipThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayCountryTextThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayCountryCodeThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayCountryIdThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayMobileNumberThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayEmailIDThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayBloodGroupThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayBirthdayThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        muarrayAnniversaryThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        
        muarrayBloodGroup.add("O +")
        muarrayBloodGroup.add("O -")
        muarrayBloodGroup.add("A +")
        muarrayBloodGroup.add("B +")
        muarrayBloodGroup.add("B -")
        muarrayBloodGroup.add("A -")
        muarrayBloodGroup.add("AB +")
        muarrayBloodGroup.add("AB -")

        muarrayRelationShip.add("Father")
        muarrayRelationShip.add("Mother")
        muarrayRelationShip.add("Sister")
        muarrayRelationShip.add("Spouse")
        muarrayRelationShip.add("Brother")
        //muarrayRelationShip.add("Friend")
        muarrayRelationShip.add("Son")
        muarrayRelationShip.add("Daughter")
        muarrayRelationShip.add("Son-in-law")
        muarrayRelationShip.add("Daughter-in-law")
        muarrayRelationShip.add("GrandSon")
        muarrayRelationShip.add("GrandDaughter")
          
        createNavigationBar()
        functionForFetchOtherDetailsFromPersonalBusinessTables()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Profile Edit"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ReportProblemController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        let UpdateButton = UIButton(type: UIButton.ButtonType.custom)
        
        UpdateButton.frame = CGRect(x: 20, y: 0, width: 80, height: 30)
        
        UpdateButton.setTitle("Update",  for: UIControl.State.normal)
        UpdateButton.backgroundColor=UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        UpdateButton.layer.cornerRadius=5
        
        UpdateButton.setTitleColor(UIColor.white,  for: UIControl.State.normal)
        
        
        
        UpdateButton.addTarget(self, action: #selector(EditUpdateProfileViewController.SettingsAction), for: UIControl.Event.touchUpInside)
        
        let buttonUpdate: UIBarButtonItem = UIBarButtonItem(customView: UpdateButton)
        
        //let buttons : NSArray = [search, setting] //14 mar
        
        let buttons : NSArray = [buttonUpdate]
      
        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
    }
    
    @objc func doneButtonAction()
    {
    }

    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditUpdateProfileViewController.doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }

    @objc func SettingsAction()
    {
        cell =  tableviewEditUpdateProfile.dequeueReusableCell(withIdentifier: "Cell") as! EditUpdateProfileTableViewCell
        cell.textviewAddressSecond.resignFirstResponder()
        cell.textfieldPostalCodeSecond.resignFirstResponder()
        cell.textfieldBusinessorResContactNoSecond.resignFirstResponder()
        cell.textfieldMobileNumberThree.resignFirstResponder()
        cell.textfieldValueFirst.resignFirstResponder()
        tableviewEditUpdateProfile.reloadData()
        functionForUpdateButtonClickEvent()
        self.resignFirstResponder()
    }

    @objc func backClicked()
    {
        self.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
    }

    func functionForFetchOtherDetailsFromPersonalBusinessTables()
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
        }

        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        if (contactDB?.open())!
        {
        let querySQLPersonalBusinessMemberDetails = "SELECT uniquekey,value,PersonalORBusiness from PersonalBusinessMemberDetails where  profileId="+profileId+""
            print(querySQLPersonalBusinessMemberDetails)
            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
            //1.
            while resultsPersonalBusinessMemberDetails?.next() == true
            {
                let letGetKey:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "uniquekey")
                let letGetValue:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "value")
                let letGetPersonalORBusiness:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "PersonalORBusiness")
                let letGetValues = letGetValue.trimmingCharacters(in: CharacterSet.whitespaces)

                
                
                print(letGetKey)
                print(letGetValue)
                if(letGetKey=="member_name")
                {
                    muarrayKeyFirst.replaceObject(at: 0, with: "Name")
                    muarrayValueFirst.replaceObject(at: 0, with: letGetValue)
                }
                else if(letGetKey=="member_mobile_no")
                {
                    muarrayKeyFirst.replaceObject(at: 1, with: "Telephone No.")
                    muarrayValueFirst.replaceObject(at: 1, with: letGetValue)
                    
                }
                else if(letGetKey=="secondry_mobile_no")
                {
                    let letGetValue = letGetValue.trimmingCharacters(in: CharacterSet.whitespaces) //DPK
                    muarrayKeyFirst.replaceObject(at: 2, with: "Telephone No.")
                    muarrayValueFirst.replaceObject(at: 2, with: letGetValue)
                    print("secondry_mobile_nosecondry_mobile_no",letGetValue)
                    
                    //----------------------------------------------------------------------------
                    if(letGetValue.hasPrefix("+"))
                    {
                        var varGetCountryCode=letGetValue.components(separatedBy: " ")
                        var databasePath : String
                        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                        let fileURL = documents.appendingPathComponent("Calendar.sqlite")
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
                        var country_master_id:String!=""
                        var country_Code:String!=""
                        if (contactDB?.open())!
                        {
                            let querySQLPersonalBusinessMemberDetails = "SELECT country_master_id,country_master_name,country_code from country_master where  country_code='"+varGetCountryCode[0]+"'"
                            print(querySQLPersonalBusinessMemberDetails)
                            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
                            while resultsPersonalBusinessMemberDetails?.next() == true
                            {
                                country_master_id=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_master_id")
                                country_Code=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_code")
                            }
                            muarrayCountryTextFirst.replaceObject(at: 2, with: "Country Name")
                            muarrayCountryCodeFirst.replaceObject(at: 2, with: country_Code)
                            muarrayCountryIdFirst.replaceObject(at: 2, with: country_master_id)
                            print("-------------------------")
                            print(country_Code)
                            
                            print(varGetCountryCode.count)
                            if(varGetCountryCode.count==2)
                            {
                                let varGetCountryCode =  varGetCountryCode[1].trimmingCharacters(in: CharacterSet.whitespaces)
                                print("Remove White Space*********************",varGetCountryCode)
                                muarrayValueFirst.replaceObject(at: 2, with: varGetCountryCode)
                            }
                            else if(varGetCountryCode.count==3)
                            {
                                let varGetCountryCode =  varGetCountryCode[2].trimmingCharacters(in: CharacterSet.whitespaces)
                                print("Remove White Space*********************",varGetCountryCode)
                                muarrayValueFirst.replaceObject(at: 2, with: varGetCountryCode)
                            }
                        }
                    }
                    else
                    {
                        
                        
                        
                        muarrayCountryTextFirst.replaceObject(at: 2, with: "Country Name")
                        muarrayCountryCodeFirst.replaceObject(at: 2, with: "")
                        muarrayCountryIdFirst.replaceObject(at: 2, with: "Country Code")
                    }
                    //-----------------------------------------------------------------------------------
                    
                    
                }
                else if(letGetKey=="member_email_id")
                {
                    muarrayKeyFirst.replaceObject(at: 3, with: "Email")
                    muarrayValueFirst.replaceObject(at: 3, with: letGetValue)
                }
                else if(letGetKey=="member_buss_email")
                {
                    muarrayKeyFirst.replaceObject(at: 4, with: "Business Email")
                    muarrayValueFirst.replaceObject(at: 4, with: letGetValue)
                }
                else if(letGetKey=="BusinessName")
                {
                    muarrayKeyFirst.replaceObject(at: 5, with: "Business Name")
                    muarrayValueFirst.replaceObject(at: 5, with: letGetValue)
                }
                else if(letGetKey=="businessPosition")
                {
                    muarrayKeyFirst.replaceObject(at: 6, with: "Designation")
                    muarrayValueFirst.replaceObject(at: 6, with: letGetValue)
                }
                    
                else if(letGetKey=="designation")
                {
                    muarrayKeyFirst.replaceObject(at: 8, with: "Classification")
                    muarrayValueFirst.replaceObject(at: 8, with: letGetValue)
                }
                else if(letGetKey=="Keywords")
                {
                    //Keywords about your profession
                    muarrayKeyFirst.replaceObject(at: 9, with: "Keywords about your profession")
                    
                    //keywords
                   // muarrayKeyFirst.replaceObject(at: 9, with: "keywords")

                    
                    muarrayValueFirst.replaceObject(at: 9, with: letGetValue)
                }
                else if(letGetKey=="member_rotary_id")
                {
                    muarrayKeyFirst.replaceObject(at: 10, with: "Rotary ID")
                    muarrayValueFirst.replaceObject(at: 10, with: letGetValue)
                }
                else if(letGetKey=="member_master_designation")
                {
                    muarrayKeyFirst.replaceObject(at: 11, with: "Club Designation")
                    muarrayValueFirst.replaceObject(at: 11, with: letGetValue)
                }
                    
                else if(letGetKey=="dg_master_designation")
                {
                    muarrayKeyFirst.replaceObject(at: 12, with: "District Designation")
                    muarrayValueFirst.replaceObject(at: 12, with: letGetValue)
                }
                else if(letGetKey=="rotary_donar_recognation")
                {
                    muarrayKeyFirst.replaceObject(at: 13, with: "Donor Recognition")
                    muarrayValueFirst.replaceObject(at: 13, with: letGetValue)
                }
                else if(letGetKey=="member_date_of_birth")
                {
                    muarrayKeyFirst.replaceObject(at: 14, with: "Birthday")
                    muarrayValueFirst.replaceObject(at: 14, with: letGetValue)
                }
                else if(letGetKey=="member_date_of_wedding")
                {
                    muarrayKeyFirst.replaceObject(at: 15, with: "Anniversary")
                    muarrayValueFirst.replaceObject(at: 15, with: letGetValue)
                }
                //                else if(letGetKey=="blood_Group")
                //                {
                //                    muarrayKeyFirst.replaceObjectAtIndex(16, withObject: "Blood group")
                //                    muarrayValueFirst.replaceObjectAtIndex(16, withObject: letGetValue)
                //                }
                
                
                
                /*
                 else if(letGetKey=="isBOD")
                 {
                 muarrayKeyFirst.replaceObjectAtIndex(16, withObject: "IsBOD")
                 muarrayValueFirst.replaceObjectAtIndex(16, withObject: letGetValue)
                 }
                 */
                //muarrayPersonalorAddressorFamilyDetail.addObject("personal")
            }
            functionForGetBusinessAddress()
        }
    }
    func functionForGetBusinessAddress()
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
        if (contactDB?.open())!
        {
            let querySQLPersonalBusinessMemberDetails = "SELECT addressType,address,city,pincode,state,country,phoneNo,addressID from AddressDetails where  profileId='"+profileId+"' and addressType='Business'"
            print(querySQLPersonalBusinessMemberDetails)
            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
            var varIsAddressAvailableorNot:Int!=0
            while resultsPersonalBusinessMemberDetails?.next() == true
            {
                varIsAddressAvailableorNot=1
                let addressType:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "addressType")
                let address:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "address")
                let city:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "city")
                let pincode:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "pincode")
                let state:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "state")
                let addressID:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "addressID")
                
                //
                let country:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "country")
                let phoneNo:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "phoneNo")
                /////////////--------------------------------------------------------------------------------
                if(country.characters.count>3)
                {
                    var databasePath : String
                    let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    let fileURL = documents.appendingPathComponent("Calendar.sqlite")
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
                    var country_master_id:String!=""
                    var country_Code:String!=""
                    if (contactDB?.open())!
                    {
                        let querySQLPersonalBusinessMemberDetails = "SELECT country_master_id,country_master_name,country_code from country_master where  country_master_name='"+country+"'"
                        print(querySQLPersonalBusinessMemberDetails)
                        let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
                        while resultsPersonalBusinessMemberDetails?.next() == true
                        {
                            country_master_id=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_master_id")
                            country_Code=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_code")
                            
                            
                        }
                    }
                    muarrayAddressSecond.replaceObject(at: 7, with: address)
                    muarrayCitySecond.replaceObject(at: 7, with: city)
                    muarrayPostalCodeSecond.replaceObject(at: 7, with: pincode)
                    muarrayStateSecond.replaceObject(at: 7, with: state)
                    muarrayAddressIdSecond.replaceObject(at: 7, with: addressID)
                    
                    //
                    //need to change
                    muarrayCountryTextSecond.replaceObject(at: 7, with: country)
                    muarrayCountryCodeSecond.replaceObject(at: 7, with: country_Code)
                    muarrayCountryIdSecond.replaceObject(at: 7, with: country_master_id)
                    
                    muarrayBusinessContactCountryTextSecond.replaceObject(at: 7, with: country)
                    muarrayBusinessContactCountryCodeSecond.replaceObject(at: 7, with: country_Code)
                    muarrayBusinessContactCountryIdSecond.replaceObject(at: 7, with: country_master_id)
                    muarrayBusinessContactMobileNumberSecond.replaceObject(at: 7, with: phoneNo)
                    muarrayPersonalorAddressorFamilyDetail.replaceObject(at: 7, with: addressType)
                    
                }
                else
                {
                    muarrayAddressSecond.replaceObject(at: 7, with: address)
                    muarrayCitySecond.replaceObject(at: 7, with: city)
                    muarrayPostalCodeSecond.replaceObject(at: 7, with: pincode)
                    muarrayStateSecond.replaceObject(at: 7, with: state)
                    muarrayAddressIdSecond.replaceObject(at: 7, with: addressID)
                    
                    //need to change
                    muarrayCountryTextSecond.replaceObject(at: 7, with: "")
                    muarrayCountryCodeSecond.replaceObject(at: 7, with: "")
                    muarrayCountryIdSecond.replaceObject(at: 7, with: "Country Code")
                    
                    muarrayBusinessContactCountryTextSecond.replaceObject(at: 7, with: country)
                    muarrayBusinessContactCountryCodeSecond.replaceObject(at: 7, with: "Select Country")
                    muarrayBusinessContactCountryIdSecond.replaceObject(at: 7, with: "Select Country")
                    muarrayBusinessContactMobileNumberSecond.replaceObject(at: 7, with: phoneNo)
                    muarrayPersonalorAddressorFamilyDetail.replaceObject(at: 7, with: addressType)
                }
            }
            if(varIsAddressAvailableorNot==0)
            {
                muarrayAddressSecond.replaceObject(at: 7, with: "")
                muarrayCitySecond.replaceObject(at: 7, with: "")
                muarrayPostalCodeSecond.replaceObject(at: 7, with: "")
                muarrayStateSecond.replaceObject(at: 7, with: "")
                muarrayAddressIdSecond.replaceObject(at: 7, with: "")
                
                //need to change
                muarrayCountryTextSecond.replaceObject(at: 7, with: "")
                muarrayCountryCodeSecond.replaceObject(at: 7, with: "")
                muarrayCountryIdSecond.replaceObject(at: 7, with: "Select Country")
                
                muarrayBusinessContactCountryTextSecond.replaceObject(at: 7, with: "")
                muarrayBusinessContactCountryCodeSecond.replaceObject(at: 7, with: "")
                muarrayBusinessContactCountryIdSecond.replaceObject(at: 7, with: "Country Code")
                muarrayBusinessContactMobileNumberSecond.replaceObject(at: 7, with: "")
                muarrayPersonalorAddressorFamilyDetail.replaceObject(at: 7, with: "Business")
            }
        }
        print(muarrayAddressIdSecond.object(at: 7))
        print(muarrayAddressIdSecond)
        functionForResidencyAddress()
    }
    func functionForResidencyAddress()
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
        if (contactDB?.open())!
        {
            let querySQLPersonalBusinessMemberDetails = "SELECT addressType,address,city,pincode,state,country,phoneNo,addressID from AddressDetails where  profileId='"+profileId+"' and addressType='Residence'"
            print(querySQLPersonalBusinessMemberDetails)
            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
            
            var varIsAddressAvailableorNot:Int!=0
            var varCounting:Int!=0
            while resultsPersonalBusinessMemberDetails?.next() == true
            {
                varIsAddressAvailableorNot=1
                let addressType:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "addressType")
                
                let address:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "address")
                let city:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "city")
                let pincode:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "pincode")
                let state:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "state")
                let addressID:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "addressID")
                varCounting=varCounting+1
                print(varCounting)
                print(addressID)
                
                let country:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "country")
                let phoneNo:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "phoneNo")
                /////////////--------------------------------------------------------------------------------
                if(country.characters.count>3)
                {
                    var databasePath : String
                    let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    let fileURL = documents.appendingPathComponent("Calendar.sqlite")
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
                    var country_master_id:String!=""
                    var country_Code:String!=""
                    if (contactDB?.open())!
                    {
                        let querySQLPersonalBusinessMemberDetails = "SELECT country_master_id,country_master_name,country_code from country_master where  country_master_name='"+country+"'"
                        print(querySQLPersonalBusinessMemberDetails)
                        let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
                        while resultsPersonalBusinessMemberDetails?.next() == true
                        {
                            country_master_id=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_master_id")
                            country_Code=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_code")
                        }
                    }
                    muarrayAddressSecond.replaceObject(at: 17, with: address)
                    muarrayCitySecond.replaceObject(at: 17, with: city)
                    muarrayPostalCodeSecond.replaceObject(at: 17, with: pincode)
                    muarrayStateSecond.replaceObject(at: 17, with: state)
                    muarrayAddressIdSecond.replaceObject(at: 17, with: addressID)
                    
                    //need to change
                    muarrayCountryTextSecond.replaceObject(at: 17, with: country)
                    muarrayCountryCodeSecond.replaceObject(at: 17, with: country_Code)
                    muarrayCountryIdSecond.replaceObject(at: 17, with: country_master_id)
                    
                    muarrayBusinessContactCountryTextSecond.replaceObject(at: 17, with: country)
                    muarrayBusinessContactCountryCodeSecond.replaceObject(at: 17, with: country_Code)
                    muarrayBusinessContactCountryIdSecond.replaceObject(at: 17, with: country_master_id)
                    muarrayBusinessContactMobileNumberSecond.replaceObject(at: 17, with: phoneNo)
                    muarrayPersonalorAddressorFamilyDetail.replaceObject(at: 17, with: addressType)
                }
                else
                {
                    muarrayAddressSecond.replaceObject(at: 17, with: address)
                    muarrayCitySecond.replaceObject(at: 17, with: city)
                    muarrayPostalCodeSecond.replaceObject(at: 17, with: pincode)
                    muarrayStateSecond.replaceObject(at: 17, with: state)
                    muarrayAddressIdSecond.replaceObject(at: 17, with: addressID)
                    
                    //need to change
                    muarrayCountryTextSecond.replaceObject(at: 17, with: "")
                    muarrayCountryCodeSecond.replaceObject(at: 17, with: "")
                    muarrayCountryIdSecond.replaceObject(at: 17, with: "Country Code")
                    
                    muarrayBusinessContactCountryTextSecond.replaceObject(at: 17, with: country)
                    muarrayBusinessContactCountryCodeSecond.replaceObject(at: 17, with: "Select Country")
                    muarrayBusinessContactCountryIdSecond.replaceObject(at: 17, with: "Select Country")
                    muarrayBusinessContactMobileNumberSecond.replaceObject(at: 17, with: phoneNo)
                    muarrayPersonalorAddressorFamilyDetail.replaceObject(at: 17, with: addressType)
                }
            }
            if(varIsAddressAvailableorNot==0)
            {
                muarrayAddressSecond.replaceObject(at: 17, with: "")
                muarrayCitySecond.replaceObject(at: 17, with:  "")
                muarrayPostalCodeSecond.replaceObject(at: 17, with:  "")
                muarrayStateSecond.replaceObject(at: 17, with:  "")
                muarrayAddressIdSecond.replaceObject(at: 17, with: "")
                
                //need to change
                muarrayCountryTextSecond.replaceObject(at: 17, with: "")
                muarrayCountryCodeSecond.replaceObject(at: 17, with: "")
                muarrayCountryIdSecond.replaceObject(at: 17, with: "Select Country")
                
                muarrayBusinessContactCountryTextSecond.replaceObject(at: 17, with:  "0")
                muarrayBusinessContactCountryCodeSecond.replaceObject(at: 17, with: "")
                muarrayBusinessContactCountryIdSecond.replaceObject(at: 17, with: "Country Code")
                muarrayBusinessContactMobileNumberSecond.replaceObject(at: 17, with:  "")
                muarrayPersonalorAddressorFamilyDetail.replaceObject(at: 17, with: "Residence")
            }
        }
        print(muarrayAddressIdSecond.object(at: 17))
        print(muarrayAddressIdSecond)
        tableviewEditUpdateProfile.reloadData()
        functionForGetFamilyDetails()
    }
    func functionForGetFamilyDetails()
    {
        //code by rajendra jat 25 june 2018 for add one family member button
        var isExist:Bool=true
        
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
        if (contactDB?.open())!
        {
            let querySQLPersonalBusinessMemberDetails = "select distinct memberName,relationship,contactNo,emailID,bloodGroup,dob,anniversary,familyMemberId from FamilyMemberDetail where  profileId='"+profileId+"'"
            
            
            print(querySQLPersonalBusinessMemberDetails)
            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
            var varIsAddressAvailableorNot:Int!=0
            while resultsPersonalBusinessMemberDetails?.next() == true
            {
                varIsAddressAvailableorNot=1
                varIsFamilyMemberorNot="yes"
                let memberName:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "memberName")
                print(memberName)
                let familyMemberId:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "familyMemberId")
                
                
                let relationship:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "relationship")
                var contactNo:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "contactNo")
                print("------valye")
                
                print(contactNo)
                let emailID:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "emailID")
                let bloodGroup:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "bloodGroup")
                let dob:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "dob")
                let anniversary:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "anniversary")
                /////////////--------------------------------------------------------------------------------
                if(contactNo.characters.count>0)
                {
                    var varGetCountryCode=contactNo.components(separatedBy: " ")
                    
                    var databasePath : String
                    let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    let fileURL = documents.appendingPathComponent("Calendar.sqlite")
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
                    var country_master_id:String!=""
                    var country_Code:String!=""
                    if (contactDB?.open())!
                    {
                        var varGetCountryCode=contactNo.components(separatedBy: " ")
                        //let querySQLPersonalBusinessMemberDetails = "SELECT country_master_id,country_master_name,country_code from country_master where  country_code='"+varGetCountryCode[0]+"'"
                        
                        
                        let querySQLPersonalBusinessMemberDetails = "SELECT country_master_id,country_master_name,country_code from country_master where  country_master_id='"+varGetCountryCode[0]+"'"
                        
                        
                        
                        
                        
                        print(querySQLPersonalBusinessMemberDetails)
                        let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
                        while resultsPersonalBusinessMemberDetails?.next() == true
                        {
                            country_master_id=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_master_id")
                            country_Code=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_code")
                            muarrayNameThree.add(memberName)
                            muarrayFamilyMemberIDThree.add(familyMemberId)
                            muarrayRelationshipThree.add(relationship)
                            muarrayCountryTextThree.add(country_Code)
                            muarrayCountryCodeThree.add(country_Code)
                            muarrayCountryIdThree.add(country_master_id)
                            muarrayMobileNumberThree.add(varGetCountryCode[1])
                            muarrayEmailIDThree.add(emailID)
                            muarrayBloodGroupThree.add(bloodGroup)
                            muarrayBirthdayThree.add(dob)
                            muarrayAnniversaryThree.add(anniversary)
                            
                            functionForAddingTempValue()
                            isExist=false
                            
                            break
                        }
                        if(isExist==true)
                        {
                            country_master_id=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_master_id")
                            country_Code=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_code")
                            muarrayNameThree.add(memberName)
                            muarrayFamilyMemberIDThree.add(familyMemberId)
                            muarrayRelationshipThree.add(relationship)
                            muarrayCountryTextThree.add("0")
                            muarrayCountryCodeThree.add("0")
                            muarrayCountryIdThree.add("0")
                            muarrayMobileNumberThree.add(varGetCountryCode[1])
                            muarrayEmailIDThree.add(emailID)
                            muarrayBloodGroupThree.add(bloodGroup)
                            muarrayBirthdayThree.add(dob)
                            muarrayAnniversaryThree.add(anniversary)
                            
                            functionForAddingTempValue()
                        }
                        
                    }
                    
                }
                else
                {
                    ///-------------------------------
                    muarrayNameThree.add(memberName)
                    muarrayFamilyMemberIDThree.add(familyMemberId)
                    muarrayRelationshipThree.add(relationship)
                    muarrayCountryTextThree.add("")
                    muarrayCountryCodeThree.add("")
                    muarrayCountryIdThree.add("Country Code")
                    muarrayMobileNumberThree.add(contactNo)
                    muarrayEmailIDThree.add(emailID)
                    muarrayBloodGroupThree.add(bloodGroup)
                    muarrayBirthdayThree.add(dob)
                    muarrayAnniversaryThree.add(anniversary)
                    functionForAddingTempValue()
                }
                
                tableviewEditUpdateProfile.reloadData()
                ///-------------------------------
                //family member available
                varIsFamilyMemberorNot="yes"
            }
            print(varIsAddressAvailableorNot)
            if(varIsAddressAvailableorNot==0)
            {
                muarrayNameThree.add("")
                muarrayFamilyMemberIDThree.add("")
                
                muarrayRelationshipThree.add("")
                muarrayCountryTextThree.add("")
                muarrayCountryCodeThree.add("")
                muarrayCountryIdThree.add("Country Code")
                muarrayMobileNumberThree.add("")
                muarrayEmailIDThree.add("")
                muarrayBloodGroupThree.add("")
                muarrayBirthdayThree.add("")
                muarrayAnniversaryThree.add("")
                functionForAddingTempValue()
                //family member not  available
                varIsFamilyMemberorNot="no"
            }
        }
        // if(isExist==true)
        //{
        
        /*
         if(varIsFamilyMemberorNot=="yes")
         {
         print("<<-----yes---->>")
         muarrayNameThree.addObject("")
         muarrayFamilyMemberIDThree.addObject("")
         
         muarrayRelationshipThree.addObject("")
         muarrayCountryTextThree.addObject("")
         muarrayCountryCodeThree.addObject("")
         muarrayCountryIdThree.addObject("Country Code")
         muarrayMobileNumberThree.addObject("")
         muarrayEmailIDThree.addObject("")
         muarrayBloodGroupThree.addObject("")
         muarrayBirthdayThree.addObject("")
         muarrayAnniversaryThree.addObject("")
         functionForAddingTempValue()
         //family member not  available
         varIsFamilyMemberorNot="no"
         }
         else
         {
         
         print("<<-----no---->>")
         
         muarrayNameThree.addObject("")
         muarrayFamilyMemberIDThree.addObject("")
         
         muarrayRelationshipThree.addObject("")
         muarrayCountryTextThree.addObject("")
         muarrayCountryCodeThree.addObject("")
         muarrayCountryIdThree.addObject("Country Code")
         muarrayMobileNumberThree.addObject("")
         muarrayEmailIDThree.addObject("")
         muarrayBloodGroupThree.addObject("")
         muarrayBirthdayThree.addObject("")
         muarrayAnniversaryThree.addObject("")
         functionForAddingTempValue()
         //family member not  available
         varIsFamilyMemberorNot="no"
         }
         */
        
        
    }
    func functionForAddingTempValue()
    {
        muarrayPersonalorAddressorFamilyDetail.add("familydetail")
        muarrayKeyFirst.add("0")
        
        
        
        muarrayCountryTextFirst.add("0")
        muarrayCountryCodeFirst.add("0")
        muarrayCountryIdFirst.add("0")
        
        
        
        
        
        
        muarrayValueFirst.add("0")
        muarrayAddressSecond.add("0")
        muarrayCitySecond.add("0")
        muarrayPostalCodeSecond.add("0")
        muarrayStateSecond.add("0")
        muarrayAddressIdSecond.add("0")
        
        muarrayCountryTextSecond.add("0")
        muarrayCountryCodeSecond.add("0")
        muarrayCountryIdSecond.add("0")
        muarrayBusinessContactCountryTextSecond.add("0")
        muarrayBusinessContactCountryCodeSecond.add("0")
        muarrayBusinessContactCountryIdSecond.add("0")
        muarrayBusinessContactMobileNumberSecond.add("0")
        
        
        
        tableviewEditUpdateProfile.reloadData()
        
    }
    //------------35-435-35-3-53-53-53-5-34-53-6-6-3-534-5-345-345-3 345345 345 3453 453 453453 4 345 345 345  345 34534 5345
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // return muarrayPersonalBusinessMemberDetails_Key_Table.count
        
        return muarrayKeyFirst.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let isPersonalBusiness:String! =  muarrayPersonalorAddressorFamilyDetail.object(at: indexPath.row)as! String
        if(isPersonalBusiness=="personal")
        {
            if(indexPath.row==16)
            {
                return 0
            }
            else
            {
                return 110//Choose your custom row height
                
            }
        }
        if(isPersonalBusiness=="Residence" || isPersonalBusiness=="Business")
        {
            return 322.0;//Choose your custom row height
        }
        else  if(isPersonalBusiness=="familydetail")
        {
            return  varRowHeight;//Choose your custom row height
        }
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! EditUpdateProfileTableViewCell
        
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = (screenSize.width)
        let screenHeight = (screenSize.height)
        
        if(muarrayKeyFirst.count>0)
        {
            let varisPersonalAddressorFamilyDetail=muarrayPersonalorAddressorFamilyDetail.object(at: indexPath.row)as! String
            cell.textfieldValueFirst.frame = CGRect(x: 7.0 ,y: 46.0, width: cell.textfieldValueFirst.frame.width,  height: cell.textfieldValueFirst.frame.height)
            cell.textfieldCountryCodeFirst.isHidden = true
            cell.buttonSelectCountry.isHidden=true
            cell.viewFirstKeyValue.frame = CGRect(x: 5.0, y: 5.0,  width: self.cell.viewFirstKeyValue.frame.size.width,  height: 99)
            cell.viewSecondBusinessPersonalAddress.frame = CGRect(x: 5.0, y: 5.0,  width: self.cell.viewSecondBusinessPersonalAddress.frame.size.width,  height: 307)
            cell.viewThreeFamilyDetails.frame = CGRect(x: 5.0, y: 5.0,  width: self.cell.viewThreeFamilyDetails.frame.size.width,  height: 618)
            cell.buttonBirthAnnivBG.isHidden=true
            cell.textfieldValueFirst.isUserInteractionEnabled=true
            cell.labelHeadingFirst.isHidden=true
            cell.labelHeadingFirst.text=""
            //-----
            let imageView = UIImageView(image: UIImage(named: "down_arrowNew"))
            imageView.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
            cell.textfieldValueFirst.rightViewMode = UITextField.ViewMode.always
            cell.textfieldValueFirst.rightView = imageView
            cell.textfieldValueFirst.keyboardType = .default
            let varGetKeyValueForReadonly=muarrayKeyFirst.object(at: indexPath.row) as! String
            //cell.textfieldValueFirst.backgroundColor=UIColor.greenColor()
            
            cell.seondmobileTX.isHidden = true
            cell.textfieldValueFirst.isHidden = false
            
            if(varisPersonalAddressorFamilyDetail=="personal")
            {
                //if secondsary mobile number
                cell.textfieldValueFirst.placeholder=muarrayKeyFirst.object(at: indexPath.row)as! String
                if (indexPath.row==0)
                {
                    cell.textfieldValueFirst.isUserInteractionEnabled=true
                    print(cell.textfieldValueFirst.placeholder)
                    // cell.textfieldValueFirst.functionForSetRemoveTextFieldAllBorder()
                }
                
                if (indexPath.row==10)
                {
                    cell.textfieldValueFirst.isUserInteractionEnabled=true
                    print(cell.textfieldValueFirst.placeholder)
                    cell.labelKeyFirst.isUserInteractionEnabled = false
                    // cell.textfieldValueFirst.functionForSetRemoveTextFieldAllBorder()
                }
                
                if(indexPath.row==1)
                {
                    cell.textfieldValueFirst.isUserInteractionEnabled=true
                    cell.textfieldValueFirst.keyboardType = .numberPad
                    // cell.textfieldValueFirst.functionForSetRemoveTextFieldAllBorder()
                }
                if (indexPath.row==2)
                {
                    cell.seondmobileTX.isHidden = false
                    cell.textfieldValueFirst.isHidden = true
                    print("-----------")
                    print( muarrayValueFirst.object(at: indexPath.row) as! String)
                    
                    
                    
                    
                    cell.textfieldValueFirst.keyboardType = .numberPad
                    
                    cell.seondmobileTX.keyboardType = .numberPad
                    
                    cell.textfieldCountryCodeFirst.isHidden = false
//                    cell.textfieldValueFirst.frame = CGRect(x: 200, y: 46.0,  width: cell.labelKeyFirst.frame.width-140,  height: cell.textfieldValueFirst.frame.height)
                   
                    cell.textfieldCountryCodeFirst.frame = CGRect(x: 8.0, y: 53.0,  width: 80,  height: cell.textfieldValueFirst.frame.height)
                    cell.buttonSelectCountry.frame = CGRect(x: 8.0, y: 53.0,  width: 80,  height: cell.textfieldValueFirst.frame.height)
                    cell.buttonSelectCountry.isHidden=false
                    cell.textfieldCountryCodeFirst.text=muarrayCountryCodeFirst.object(at: indexPath.row)as! String
                    print(muarrayCountryCodeFirst.object(at: indexPath.row)as! String)
                    
                    let imageView = UIImageView(image: UIImage(named: "downArrowCalendar"))
                    imageView.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
                    cell.textfieldCountryCodeFirst.rightViewMode = UITextField.ViewMode.always
                    cell.textfieldCountryCodeFirst.rightView = imageView
                    
                    
                }
                
                if((muarrayKeyFirst.object(at: indexPath.row)as! String)=="District Designation" || indexPath.row==0 || indexPath.row==1 || indexPath.row == 10)
                {
                    cell.textfieldValueFirst.backgroundColor=UIColor(red: 209.0/255.0, green: 209.0/255.0, blue: 209.0/255.0, alpha: 1.0)
                }
                else{
                    cell.textfieldValueFirst.backgroundColor=UIColor.white//(red: 209.0/255.0, green: 209.0/255.0, blue: 209.0/255.0, alpha: 1.0)
                }
                
                print(muarrayCountryCodeFirst.object(at: indexPath.row)as! String)
                cell.labelKeyFirst.text! = muarrayKeyFirst.object(at: indexPath.row) as! String
                cell.textfieldValueFirst.text! = muarrayValueFirst.object(at: indexPath.row) as! String
                //view hidden true false
                cell.viewFirstKeyValue.isHidden=false
                cell.viewSecondBusinessPersonalAddress.isHidden=true
                cell.viewThreeFamilyDetails.isHidden=true
                
                
                if(indexPath.row==14||indexPath.row==15||indexPath.row==16)
                {
                    cell.buttonBirthAnnivBG.isHidden=false
                }
                
                //for making readonly club designation and district designation
                
                
                //---for set heading
                //labelHeadingFirst
                if(varGetKeyValueForReadonly=="Business Name")
                {
                    cell.labelHeadingFirst.text="Business Details"
                    cell.labelHeadingFirst.isHidden=false
                }
                else if(varGetKeyValueForReadonly=="Classification")
                {
                    cell.labelHeadingFirst.text="Rotary Details"
                    cell.labelHeadingFirst.isHidden=false
                }
                //for down arrow
                /*
                 //1.
                 let imageView = UIImageView(image: UIImage(named: "down_arrow"))
                 imageView.frame = CGRectMake(0.0, 0.0, 35, 35)
                 cell.textfieldCountryId_FamilyDetail.rightViewMode = UITextField.ViewMode.always
                 cell.textfieldCountryId_FamilyDetail.rightView = imageView
                 */
                if(varGetKeyValueForReadonly=="Birthday" || varGetKeyValueForReadonly=="Anniversary" || varGetKeyValueForReadonly=="Blood group")
                {
                    let imageView = UIImageView(image: UIImage(named: "downArrowCalendar"))
                    imageView.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
                    cell.textfieldValueFirst.rightViewMode = UITextField.ViewMode.always
                    cell.textfieldValueFirst.rightView = imageView
                }
                let varGetValueForEmail =  muarrayKeyFirst.object(at: indexPath.row) as! String
                if(varGetValueForEmail=="Email")
                {
                    cell.textfieldValueFirst.keyboardType = .emailAddress
                }
                
                
            }
            else   if(varisPersonalAddressorFamilyDetail=="Residence" || varisPersonalAddressorFamilyDetail=="Business")
            {
                cell.textviewAddressSecond.text! = muarrayAddressSecond.object(at: indexPath.row) as! String
                cell.textfieldCitySecond.text! = muarrayCitySecond.object(at: indexPath.row) as! String
                cell.textfieldPostalCodeSecond.text! =  muarrayPostalCodeSecond.object(at: indexPath.row) as! String
                cell.textfieldStateSecond.text! =  muarrayStateSecond.object(at: indexPath.row) as! String
                muarrayAddressIdSecond.object(at: indexPath.row)
                
                print("this is address by rajendra jat..>>>>>>>")
                print(muarrayCountryTextSecond.object(at: indexPath.row) as! String)
                
                var varGetCountry = muarrayCountryTextSecond.object(at: indexPath.row) as! String
                
                if(varGetCountry.characters.count>0)
                {
                    cell.textfieldCountrySecond.text! =  muarrayCountryTextSecond.object(at: indexPath.row) as! String
                }
                else
                {
                    cell.textfieldCountrySecond.text! =  "India"
                }
                
                
                
                print("rajendra jat code for country code...........")
                print(muarrayCountryTextSecond.object(at: indexPath.row) as! String)
                
                
                //view hidden true false
                cell.viewFirstKeyValue.isHidden=true
                cell.viewSecondBusinessPersonalAddress.isHidden=false
                cell.viewThreeFamilyDetails.isHidden=true
                
                
                var varGetCountryCode = muarrayBusinessContactCountryCodeSecond.object(at: indexPath.row)as! String

                if(varGetCountryCode.characters.count>0)
                {
                    cell.textfieldBusinessorResSecond.text=muarrayBusinessContactCountryCodeSecond.object(at: indexPath.row)as! String

                }
                else
                {
                   cell.textfieldBusinessorResSecond.text="+91"
                }
                
                
                cell.textfieldBusinessorResContactNoSecond.text=muarrayBusinessContactMobileNumberSecond.object(at: indexPath.row)as! String
                
                
                if(varisPersonalAddressorFamilyDetail=="Residence")
                {
                    cell.labelBusinessorResiScond.text="Residential Contact No."
                    cell.labelAddressSecond.text="Residential Address"
                }
                else  if(varisPersonalAddressorFamilyDetail=="Business")
                {
                    cell.labelBusinessorResiScond.text="Business Contact No."
                    cell.labelAddressSecond.text="Business Address"
                    
                    
                }
                //labelBusinessorResiScond
                
                
            }
            else   if(varisPersonalAddressorFamilyDetail=="familydetail")
            {
                cell.labelNameThree.text! = muarrayNameThree.object(at: indexPath.row) as! String
                muarrayFamilyMemberIDThree.object(at: indexPath.row) as! String
                
                cell.textfieldNameThree.text! = muarrayNameThree.object(at: indexPath.row) as! String
                muarrayFamilyMemberIDThree.object(at: indexPath.row) as! String
                
                cell.textfieldRelationshipThree.text! = muarrayRelationshipThree.object(at: indexPath.row) as! String
                cell.textfieldMobileNumberThree.text! = muarrayMobileNumberThree.object(at: indexPath.row) as! String
                cell.textfieldCountryCodeThree.text! = muarrayCountryCodeThree.object(at: indexPath.row) as! String
                cell.textfieldEmailIdThree.text! = muarrayEmailIDThree.object(at: indexPath.row) as! String
                cell.textfieldBloodGroup.text! = muarrayBloodGroupThree.object(at: indexPath.row) as! String
                cell.textfieldBirthdayThree.text! = muarrayBirthdayThree.object(at: indexPath.row) as! String
                cell.textfieldAnniversaryThree.text! = muarrayAnniversaryThree.object(at: indexPath.row) as! String
                
                //view hidden true false
                cell.viewFirstKeyValue.isHidden=true
                cell.viewSecondBusinessPersonalAddress.isHidden=true
                cell.viewThreeFamilyDetails.isHidden=false
                
                
                
                let imageView = UIImageView(image: UIImage(named: "downArrowCalendar"))
                imageView.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
                cell.textfieldBloodGroup.rightViewMode = UITextField.ViewMode.always
                cell.textfieldBloodGroup.rightView = imageView
                
                let imageView2 = UIImageView(image: UIImage(named: "downArrowCalendar"))
                imageView2.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
                cell.textfieldBirthdayThree.rightViewMode = UITextField.ViewMode.always
                cell.textfieldBirthdayThree.rightView = imageView2
                
                let imageView3 = UIImageView(image: UIImage(named: "downArrowCalendar"))
                imageView3.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
                cell.textfieldAnniversaryThree.rightViewMode = UITextField.ViewMode.always
                cell.textfieldAnniversaryThree.rightView = imageView3
                
                
                
                
                
            }
            let varArrayCount=muarrayValueFirst.count
            if(varArrayCount-1==indexPath.row)
            {
                varRowHeight=600
                print(varRowHeight)
            }
            else
            {
                //varRowHeight=850  //comment by DPK
                varRowHeight=500
                cell.viewThreeFamilyDetails.frame = CGRect(x: 5.0, y: 5.0,  width: self.cell.viewThreeFamilyDetails.frame.size.width,  height: 540)
                print(varRowHeight)
            }
            
            //code by Rajendra Jat for checking family member
            // varIsFamilyMemberorNot
            cell.viewTempForThree.isHidden=true
            if(varIsFamilyMemberorNot=="no")
            {
                cell.viewTempForThree.isHidden=false
                varRowHeight=100
                let xPosition = cell.viewThreeFamilyDetails.frame.origin.x
                let yPosition = cell.viewThreeFamilyDetails.frame.origin.y - 20
                let height = cell.viewThreeFamilyDetails.frame.size.height
                let width = cell.viewThreeFamilyDetails.frame.size.width
                UIView.animate(withDuration: 1.0, animations: {
                    self.cell.buttonAddAnotherFamilyMemberThree.frame = CGRect(x: 10.0, y: 15.0,  width: self.cell.viewThreeFamilyDetails.frame.size.width-20,  height: 50)
                })
            }
            else if(varIsFamilyMemberorNot=="yes")
            {
                let xPosition = cell.viewThreeFamilyDetails.frame.origin.x
                let yPosition = cell.viewThreeFamilyDetails.frame.origin.y - 20
                let height = cell.viewThreeFamilyDetails.frame.size.height
                let width = cell.viewThreeFamilyDetails.frame.size.width
                UIView.animate(withDuration: 1.0, animations: {
                    self.cell.buttonAddAnotherFamilyMemberThree.frame = CGRect(x: 3.0, y: 500.0,  width: self.cell.viewThreeFamilyDetails.frame.size.width-20,  height: 30)
                })
            }
            
            
            //--button click event for all view first second three
            
            //view first
            cell.buttonSelectCountry.addTarget(self, action: #selector(EditUpdateProfileViewController.buttonSelectCountryClickedFirst(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonSelectCountry.tag=indexPath.row;
            
            cell.buttonBirthAnnivBG.addTarget(self, action: #selector(EditUpdateProfileViewController.buttonBirthAnnivBGFirstClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonBirthAnnivBG.tag=indexPath.row;
            
            
            
            //view second
            cell.buttonCountrySecond.addTarget(self, action: #selector(EditUpdateProfileViewController.buttonCountrySecondClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonCountrySecond.tag=indexPath.row;
            
            cell.buttonBusinessorResiContactNoSecond.addTarget(self, action: #selector(EditUpdateProfileViewController.buttonBusinessorResiContactNoSecondClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonBusinessorResiContactNoSecond.tag=indexPath.row;
            
            //view three
            cell.buttonRelationThree.addTarget(self, action: #selector(EditUpdateProfileViewController.buttonRelationThreeClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonRelationThree.tag=indexPath.row;
            
            cell.buttonCountryCodeThree.addTarget(self, action: #selector(EditUpdateProfileViewController.buttonCountryCodeThreeClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonCountryCodeThree.tag=indexPath.row;
            
            cell.buttonBloodGroupThree.addTarget(self, action: #selector(EditUpdateProfileViewController.buttonBloodGroupThreeClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonBloodGroupThree.tag=indexPath.row;
            
            cell.buttonBirthdayThree.addTarget(self, action: #selector(EditUpdateProfileViewController.buttonBirthdayThreeClikced(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonBirthdayThree.tag=indexPath.row;
            
            cell.buttonAnniversaryThree.addTarget(self, action: #selector(EditUpdateProfileViewController.buttonAnniversaryThreeClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonAnniversaryThree.tag=indexPath.row;
            
            cell.buttonAddAnotherFamilyMemberThree.addTarget(self, action: #selector(EditUpdateProfileViewController.buttonAddAnotherFamilyMemberThreeClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonAddAnotherFamilyMemberThree.tag=indexPath.row;
            
            
            cell.buttonDeleteFamilyMember.addTarget(self, action: #selector(EditUpdateProfileViewController.buttonDeleteFamilyMemberClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonDeleteFamilyMember.tag=indexPath.row;
            
            
            
            if(varGetKeyValueForReadonly=="Club Designation")
            {
               
                
                
                if(isAdmin=="Yes" && varGetKeyValueForReadonly=="Club Designation")
                {
                    cell.textfieldValueFirst.isUserInteractionEnabled=true
                    cell.textfieldValueFirst.frame = CGRect(x: 7.0 ,y: 46.0, width: screenWidth-40,  height: cell.textfieldValueFirst.frame.height)
                }
                else
                {
                    cell.textfieldValueFirst.isUserInteractionEnabled=false
                    cell.textfieldValueFirst.frame = CGRect(x: 7.0 ,y: 46.0, width: screenWidth-40,  height: cell.textfieldValueFirst.frame.height)
                    
                }
                
            }
            
            
            if(isAdmin=="Yes" && indexPath.row == 10)
            {
                cell.textfieldValueFirst.isUserInteractionEnabled=false
//                cell.textfieldValueFirst.isUserInteractionEnabled=true
                cell.textfieldValueFirst.frame = CGRect(x: 7.0 ,y: 46.0, width: screenWidth-40,  height: cell.textfieldValueFirst.frame.height)
            }
            else
            {
                cell.textfieldValueFirst.isUserInteractionEnabled=true
                cell.textfieldValueFirst.frame = CGRect(x: 7.0 ,y: 46.0, width: screenWidth-40,  height: cell.textfieldValueFirst.frame.height)
                
            }
            
            
            if(varGetKeyValueForReadonly=="District Designation")
            {
                
                let screenSize: CGRect = UIScreen.main.bounds
                let screenWidth = (screenSize.width)
                let screenHeight = (screenSize.height)
                cell.textfieldValueFirst.isUserInteractionEnabled=false
                cell.textfieldValueFirst.frame = CGRect(x: 7.0 ,y: 46.0, width: screenWidth-40,  height: cell.textfieldValueFirst.frame.height)
                
            }
            
            
            //
            
        }
        return cell
        
        
        
        
        
    }
    func textViewDidChange(_ textView: UITextView)
    {
        
        //cell.labelPlaceHolder.hidden = !cell.textviewAddressSecond.text.isEmpty
    }
    func functionForResignFirstREsponder()
    {
        cell.textviewAddressSecond.resignFirstResponder()
        cell.textfieldCitySecond.resignFirstResponder()
        cell.textfieldPostalCodeSecond.resignFirstResponder()
        cell.textfieldStateSecond.resignFirstResponder()
        cell.textfieldCountrySecond.resignFirstResponder()
        cell.textfieldBusinessorResSecond.resignFirstResponder()
        cell.textfieldBusinessorResContactNoSecond.resignFirstResponder()
        cell.textfieldNameThree.resignFirstResponder()
        cell.textfieldRelationshipThree.resignFirstResponder()
        cell.textfieldCountryCodeThree.resignFirstResponder()
        cell.textfieldMobileNumberThree.resignFirstResponder()
        cell.textfieldEmailIdThree.resignFirstResponder()
        cell.textfieldBloodGroup.resignFirstResponder()
        cell.textfieldBirthdayThree.resignFirstResponder()
        cell.textfieldAnniversaryThree.resignFirstResponder()
    }
    //
    @IBAction func buttonDeleteFamilyMemberClicked(_ sender: AnyObject)
    {
        print("Delete family member")
        
        hideKeyboard()
        functionForResignFirstREsponder()
        
        
        var varGetIndex:Int!=0
        varGetIndex=sender.tag
        
        muarrayPersonalorAddressorFamilyDetail.removeObject(at: varGetIndex)
        muarrayKeyFirst.removeObject(at: varGetIndex)
        
        
        
        muarrayCountryTextFirst.removeObject(at: varGetIndex)
        muarrayCountryCodeFirst.removeObject(at: varGetIndex)
        muarrayCountryIdFirst.removeObject(at: varGetIndex)
        
        
        
        
        
        
        muarrayValueFirst.removeObject(at: varGetIndex)
        muarrayAddressSecond.removeObject(at: varGetIndex)
        muarrayCitySecond.removeObject(at: varGetIndex)
        muarrayPostalCodeSecond.removeObject(at: varGetIndex)
        muarrayStateSecond.removeObject(at: varGetIndex)
        
        muarrayAddressIdSecond.removeObject(at: varGetIndex)
        
        
        muarrayCountryTextSecond.removeObject(at: varGetIndex)
        muarrayCountryCodeSecond.removeObject(at: varGetIndex)
        muarrayCountryIdSecond.removeObject(at: varGetIndex)
        muarrayBusinessContactCountryTextSecond.removeObject(at: varGetIndex)
        muarrayBusinessContactCountryCodeSecond.removeObject(at: varGetIndex)
        muarrayBusinessContactCountryIdSecond.removeObject(at: varGetIndex)
        muarrayBusinessContactMobileNumberSecond.removeObject(at: varGetIndex)
        
        
        
        
        
        let varGetDeletedId=muarrayFamilyMemberIDThree.object(at: varGetIndex)
        muarrayFamilyMemberDeletedIDThree.add(varGetDeletedId)
        muarrayNameThree.removeObject(at: varGetIndex)
        muarrayFamilyMemberIDThree.removeObject(at: varGetIndex)
        
        
        
        
        muarrayRelationshipThree.removeObject(at: varGetIndex)
        muarrayCountryTextThree.removeObject(at: varGetIndex)
        muarrayCountryCodeThree.removeObject(at: varGetIndex)
        muarrayCountryIdThree.removeObject(at: varGetIndex)
        muarrayMobileNumberThree.removeObject(at: varGetIndex)
        muarrayEmailIDThree.removeObject(at: varGetIndex)
        muarrayBloodGroupThree.removeObject(at: varGetIndex)
        muarrayBirthdayThree.removeObject(at: varGetIndex)
        muarrayAnniversaryThree.removeObject(at: varGetIndex)
        
        tableviewEditUpdateProfile.reloadData()
        
        var varGetDataValue:Int!=0
        for i in 00..<muarrayPersonalorAddressorFamilyDetail.count
        {
            let varGetvalue=muarrayPersonalorAddressorFamilyDetail.object(at: i)as! String
            if(varGetvalue=="familydetail")
            {
                varGetDataValue=1
                break
            }
        }
        
        if(varGetDataValue==0)
        {
            varIsFamilyMemberorNot="no"
            
            muarrayPersonalorAddressorFamilyDetail.add("familydetail")
            muarrayKeyFirst.add("0")
            
            muarrayCountryTextFirst.add("0")
            muarrayCountryCodeFirst.add("0")
            muarrayCountryIdFirst.add("0")
            muarrayValueFirst.add("0")
            muarrayAddressSecond.add("0")
            muarrayCitySecond.add("0")
            muarrayPostalCodeSecond.add("0")
            muarrayStateSecond.add("0")
            
            muarrayAddressIdSecond.add("0")
            
            
            muarrayCountryTextSecond.add("0")
            muarrayCountryCodeSecond.add("0")
            muarrayCountryIdSecond.add("0")
            muarrayBusinessContactCountryTextSecond.add("0")
            muarrayBusinessContactCountryCodeSecond.add("0")
            muarrayBusinessContactCountryIdSecond.add("0")
            muarrayBusinessContactMobileNumberSecond.add("0")
            
            
            muarrayNameThree.add("")
            muarrayFamilyMemberIDThree.add("")
            
            
            muarrayRelationshipThree.add("")
            muarrayCountryTextThree.add("")
            muarrayCountryCodeThree.add("")
            muarrayCountryIdThree.add("Country Code")
            muarrayMobileNumberThree.add("")
            muarrayEmailIDThree.add("")
            muarrayBloodGroupThree.add("")
            muarrayBirthdayThree.add("")
            muarrayAnniversaryThree.add("")
            tableviewEditUpdateProfile.reloadData()
        }
        
        
        
    }
    @IBAction func buttonBusinessorResiContactNoSecondClicked(_ sender: AnyObject)
    {
        hideKeyboard()
        functionForResignFirstREsponder()
        print("second view country code")
        /*
         varWhichButtonSelectForCountryNameorCode="secondCountryCode"
         buttonOpacity.hidden=false
         viewCountry.hidden=false
         varPublicSelectedRowIndex=String(sender.tag)
         */
    }
    @IBAction func buttonBirthAnnivBGFirstClicked(_ sender: AnyObject)
    {
        pickerDOB.datePickerMode = UIDatePicker.Mode.date // 4- use time only
        let currentDate = Foundation.Date()  //5 -  get the current date
        // pickerDOB.minimumDate = currentDate  //6- set the current date/time as a minimum
        pickerDOB.date = currentDate //7 - defaults to current time but shows how to use it.
        
        print("hellossssss")
        
        
        functionForResignFirstREsponder()
        hideKeyboard()
        let varGetKey=muarrayKeyFirst.object(at: sender.tag)as! String
        if(varGetKey=="Birthday")
        {
            print("first view birthday anninv blood group")
            varWhichButtonSelectForCountryNameorCode=varGetKey
            print("first view select country code")
            buttonOpacity.isHidden=false
            viewDOB.isHidden=false
            varPublicSelectedRowIndex=String(sender.tag)
        }
        else  if(varGetKey=="Anniversary")
        {
            print("first view birthday anninv blood group")
            varWhichButtonSelectForCountryNameorCode=varGetKey
            print("first view select country code")
            buttonOpacity.isHidden=false
            viewDOB.isHidden=false
            varPublicSelectedRowIndex=String(sender.tag)
        }
        else  if(varGetKey=="Blood group")
        {
            print("first view birthday anninv blood group")
            varWhichButtonSelectForCountryNameorCode=varGetKey
            print("first view select country code")
            buttonOpacity.isHidden=false
            viewBloodGroup.isHidden=false
            varPublicSelectedRowIndex=String(sender.tag)
            print(varPublicSelectedRowIndex)
            
            self.pickerBloodGroup.selectRow(0, inComponent: 0, animated: true) // DPK For by defoult value show on picker
            self.pickerView(pickerBloodGroup, didSelectRow: 0, inComponent: 0)
            
            
        }
    }
    
    @IBAction func buttonRelationThreeClicked(_ sender: AnyObject)
    {
        functionForResignFirstREsponder()
        hideKeyboard()
        print("three view relationship")
        
        
        buttonOpacity.isHidden=false
        viewRelationship.isHidden=false
        varPublicSelectedRowIndex=String(sender.tag)
        
        
    }
    @IBAction func buttonCountryCodeThreeClicked(_ sender: AnyObject)
    {
        
        
        
        
        
        
        functionForResignFirstREsponder()
        hideKeyboard()
        print("three view select country code")
        varWhichButtonSelectForCountryNameorCode="threefamilyCountryCode"
        print("first view select country code")
        buttonOpacity.isHidden=false
        viewCountry.isHidden=false
        varPublicSelectedRowIndex=String(sender.tag)
    }
    @IBAction func buttonBloodGroupThreeClicked(_ sender: AnyObject)
    {
        functionForResignFirstREsponder()
        hideKeyboard()
        print("three view blood group")
        print("first view birthday anninv blood group")
        varWhichButtonSelectForCountryNameorCode="threefamilyBloodGroup"
        print("first view select country code")
        buttonOpacity.isHidden=false
        viewBloodGroup.isHidden=false
        varPublicSelectedRowIndex=String(sender.tag)
        print(varPublicSelectedRowIndex)
        
        self.pickerBloodGroup.selectRow(0, inComponent: 0, animated: true)  // DPK For by defoult value show on picker
        self.pickerView(pickerBloodGroup, didSelectRow: 0, inComponent: 0)
    }
    @IBAction func buttonBirthdayThreeClikced(_ sender: AnyObject)
    {
        pickerDOB.datePickerMode = UIDatePicker.Mode.date // 4- use time only
        let currentDate = Foundation.Date()  //5 -  get the current date
        // pickerDOB.minimumDate = currentDate  //6- set the current date/time as a minimum
        pickerDOB.date = currentDate //7 - defaults to current time but shows how to use it.
        print("three view select birthday")
        
        functionForResignFirstREsponder()
        hideKeyboard()
        varWhichButtonSelectForCountryNameorCode="BirthdayFamilyThree"
        buttonOpacity.isHidden=false
        viewDOB.isHidden=false
        varPublicSelectedRowIndex=String(sender.tag)
        
        
        //AnniversaryFamilyThree
    }
    @IBAction func buttonAnniversaryThreeClicked(_ sender: AnyObject)
    {
        pickerDOB.datePickerMode = UIDatePicker.Mode.date // 4- use time only
        let currentDate = Foundation.Date()  //5 -  get the current date
        // pickerDOB.minimumDate = currentDate  //6- set the current date/time as a minimum
        pickerDOB.date = currentDate //7 - defaults to current time but shows how to use it.
        functionForResignFirstREsponder()
        hideKeyboard()
        print("three view annivsersary")
        varWhichButtonSelectForCountryNameorCode="AnniversaryFamilyThree"
        buttonOpacity.isHidden=false
        viewDOB.isHidden=false
        varPublicSelectedRowIndex=String(sender.tag)
    }
    //Add More family details
    @IBAction func buttonAddAnotherFamilyMemberThreeClicked(_ sender: AnyObject)
    {
        if(varIsFamilyMemberorNot=="no")
        {
            varIsFamilyMemberorNot="yes"
            tableviewEditUpdateProfile.reloadData()
        }
        else
        {
            varIsFamilyMemberorNot="yes"
            functionForResignFirstREsponder()
            hideKeyboard()
            print("three view Add another family member")
            
            muarrayPersonalorAddressorFamilyDetail.add("familydetail")
            muarrayKeyFirst.add("0")
            
            
            
            muarrayCountryTextFirst.add("0")
            muarrayCountryCodeFirst.add("0")
            muarrayCountryIdFirst.add("0")
            
            
            
            
            
            
            muarrayValueFirst.add("0")
            muarrayAddressSecond.add("0")
            muarrayCitySecond.add("0")
            muarrayPostalCodeSecond.add("0")
            muarrayStateSecond.add("0")
            
            muarrayAddressIdSecond.add("0")
            
            
            muarrayCountryTextSecond.add("0")
            muarrayCountryCodeSecond.add("0")
            muarrayCountryIdSecond.add("0")
            muarrayBusinessContactCountryTextSecond.add("0")
            muarrayBusinessContactCountryCodeSecond.add("0")
            muarrayBusinessContactCountryIdSecond.add("0")
            muarrayBusinessContactMobileNumberSecond.add("0")
            
            
            muarrayNameThree.add("")
            muarrayFamilyMemberIDThree.add("")
            
            muarrayRelationshipThree.add("")
            muarrayCountryTextThree.add("")
            muarrayCountryCodeThree.add("")
            muarrayCountryIdThree.add("Country Code")
            muarrayMobileNumberThree.add("")
            muarrayEmailIDThree.add("")
            muarrayBloodGroupThree.add("")
            muarrayBirthdayThree.add("")
            muarrayAnniversaryThree.add("")
            tableviewEditUpdateProfile.reloadData()
        }
        
    }
    @IBAction func buttonSelectCountryClickedFirst(_ sender: AnyObject)
    {
        functionForResignFirstREsponder()
        hideKeyboard()
        varWhichButtonSelectForCountryNameorCode="firstCountryCode"
        print("first view select country code")
        buttonOpacity.isHidden=false
        viewCountry.isHidden=false
        varPublicSelectedRowIndex=String(sender.tag)
    }
    @IBAction func buttonCountrySecondClicked(_ sender: AnyObject)
    {
        functionForResignFirstREsponder()
        hideKeyboard()
        
        /*
        print("this is picker reload or refresh !!!!!!")
        self.viewCountry.endEditing(false)
        pickerCountry.selectRow(0, inComponent: 0, animated: true)
        pickerCountry.reloadAllComponents();
        */
        
        
        
        
        
        print("second view select country code")
        varWhichButtonSelectForCountryNameorCode="secondCountryName"
        buttonOpacity.isHidden=false
        viewCountry.isHidden=false
        varPublicSelectedRowIndex=String(sender.tag)
    }
    //---  57349832749345347983 3 387389475 39473957363847568653847563784953785634785 6834765873
    @objc func hideKeyboard()
    {
        //cell.textFieldValue.resignFirstResponder()
        // cell.textFieldCountryCode.resignFirstResponder()
        tableviewEditUpdateProfile.endEditing(true)
    }
    //--------------------------------
    //---select country
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        if(pickerView.tag==1)
        {
            return 1
        }
        if(pickerView.tag==2)
        {
            return 1
            
        }
        if(pickerView.tag==3)
        {
            return 1
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if(pickerView.tag==1)
        {
            return muarraySelectCountry.count;
        }
        if(pickerView.tag==2)
        {
            return muarrayBloodGroup.count;
        }
        if(pickerView.tag==3)
        {
            return muarrayRelationShip.count
        }
        return 0
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        if(pickerView.tag==1)
        {
            objCalendarInfo = muarraySelectCountry.object(at: row) as! CalendarInfo
            return objCalendarInfo.stringCountryMasterName
        }
        if(pickerView.tag==2)
        {
            let vraGetDayValue:String = muarrayBloodGroup.object(at: row) as! String
            return vraGetDayValue
        }
        if(pickerView.tag==3)
        {
            let vraGetDayValue:String = muarrayRelationShip.object(at: row) as! String
            return vraGetDayValue
        }
        return "0"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView.tag==1)
        {
            objCalendarInfo  = CalendarInfo()
            objCalendarInfo = muarraySelectCountry.object(at: row) as! CalendarInfo
            
            stringCountryMasterId =   objCalendarInfo.stringCountryMasterId
            stringCountryMasterCode =   objCalendarInfo.stringCountryMasterCode
            stringCountryMasterName =   objCalendarInfo.stringCountryMasterName
        }
        if(pickerView.tag==2)
        {
            varGetBloodGroup = muarrayBloodGroup.object(at: row) as! String
        }
        if(pickerView.tag==3)
        {
            varGetRelationShipText = muarrayRelationShip.object(at: row) as! String
        }
        
        pickerBloodGroup.reloadAllComponents()
        
    }
    
    //-------------------------------------
    
    
    
    
    func functionForHiddenAll()
    {
        buttonOpacity.isHidden=true
        viewBloodGroup.isHidden=true
        viewCountry.isHidden=true
        viewRelationship.isHidden=true
        viewDOB.isHidden=true
    }
    @IBAction func buttonOpacityClickEvent(_ sender: AnyObject)
    {
        functionForHiddenAll()
        
        
        
    }
    @IBAction func buttonBloodGroupDoneClickEvent(_ sender: AnyObject)
    {
        functionForHiddenAll()
        if(varWhichButtonSelectForCountryNameorCode=="Blood group")
        {
            print(varGetBloodGroup)
            if(varGetBloodGroup.characters.count>0)
            {
            }
            else
            {
                varGetBloodGroup="O +"
            }
            muarrayValueFirst.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: varGetBloodGroup)
            tableviewEditUpdateProfile.reloadData()
        }
        if(varWhichButtonSelectForCountryNameorCode=="threefamilyBloodGroup")
        {
            muarrayBloodGroupThree.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: varGetBloodGroup)
            tableviewEditUpdateProfile.reloadData()
            
            
            //pickerBloodGroup.reloadAllComponents()
        }
        
    }
    @IBAction func buttonCountryDoneClickEvent(_ sender: AnyObject)
    {
        functionForHiddenAll()
        
        print(stringCountryMasterId)
        print(stringCountryMasterCode)
        print(stringCountryMasterName)
        if(varWhichButtonSelectForCountryNameorCode=="firstCountryCode")
        {
            muarrayCountryCodeFirst.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterCode)
            muarrayCountryTextFirst.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterId)
            muarrayCountryIdFirst.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterId)
        }
        else  if(varWhichButtonSelectForCountryNameorCode=="secondCountryName")
        {
            muarrayCountryTextSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterName)
            muarrayCountryCodeSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterCode)
            muarrayCountryIdSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterId)
            //muarrayCountryCodeSecond
            muarrayBusinessContactCountryTextSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterName)
            muarrayBusinessContactCountryCodeSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterCode)
            muarrayBusinessContactCountryIdSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterId)
            
        }
        else if(varWhichButtonSelectForCountryNameorCode=="secondCountryCode")
        {
            muarrayBusinessContactCountryTextSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterName)
            muarrayBusinessContactCountryCodeSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterCode)
            muarrayBusinessContactCountryIdSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterId)
        }
        else if(varWhichButtonSelectForCountryNameorCode=="threefamilyCountryCode")
        {
            muarrayCountryTextThree.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterName)
            muarrayCountryCodeThree.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterCode)
            muarrayCountryIdThree.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: stringCountryMasterId)
        }
        
        print("Index:--")
        print(varPublicSelectedRowIndex)
        tableviewEditUpdateProfile.reloadData()
    }
    @IBAction func buttonRelationshipDoneClickEvent(_ sender: AnyObject)
    {
        functionForHiddenAll()
        
        
        print(varGetRelationShipText)
        
        
        if(varGetRelationShipText.characters.count>0)
        {
            
        }
        else
        {
            varGetRelationShipText="Father"
        }
        muarrayRelationshipThree.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: varGetRelationShipText)
        tableviewEditUpdateProfile.reloadData()
    }

    @IBAction func buttonBirthAniiCancelClickEvent(_ sender: AnyObject)
    {
        functionForHiddenAll()
    }
    
    @IBAction func ButtonDeleteBirthdayAniiversary(_ sender: AnyObject)
    {
        
        functionForHiddenAll()
        setDateAndTimeFull()
        if(varWhichButtonSelectForCountryNameorCode=="Birthday" || varWhichButtonSelectForCountryNameorCode=="Anniversary")
        {
            muarrayValueFirst.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "")
        }
        else if (varWhichButtonSelectForCountryNameorCode=="BirthdayFamilyThree")
        {
            muarrayBirthdayThree.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "")
        }
        else  if(varWhichButtonSelectForCountryNameorCode=="AnniversaryFamilyThree")
        {
            muarrayAnniversaryThree.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "")
            //
        }
        
        
        
        
        tableviewEditUpdateProfile.reloadData()
        
    }
    
    
    
    @IBAction func buttonDOBDoneClickEvent(_ sender: AnyObject)
    {
        functionForHiddenAll()
        setDateAndTimeFull()
        if(varWhichButtonSelectForCountryNameorCode=="Birthday" || varWhichButtonSelectForCountryNameorCode=="Anniversary")
        {
            muarrayValueFirst.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: dateTimeDisplay)
            
        }
        else  if(varWhichButtonSelectForCountryNameorCode=="BirthdayFamilyThree")
        {
            muarrayBirthdayThree.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: dateTimeDisplay)
            // muarrayAnniversaryThree
        }
        else  if(varWhichButtonSelectForCountryNameorCode=="AnniversaryFamilyThree")
        {
            muarrayAnniversaryThree.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: dateTimeDisplay)
            //
        }
        
        
        
        
        
        
        
        
        tableviewEditUpdateProfile.reloadData()
        //varWhichButtonSelectForCountryNameorCode=""
        
    }
    func setDateAndTimeFull()
    {
        // muarrayGetDataFromDayWiseOrMonthWise=NSMutableArray()
        //tableviewEventAnnivBirthDay.reloadData()
        pickerDOB.datePickerMode = UIDatePicker.Mode.date
        // dateTimePickerController.locale = NSLocale(localeIdentifier: "en_GB")
        // dateTimePickerController.minuteInterval = 15
        let date = Foundation.Date()
        // let currentDate: NSDate = NSDate()
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        currentdate = formatter.string(from: date)
        //full date and time show
        DateFormatter.dateStyle = Foundation.DateFormatter.Style.short
        dateTimeDisplay = DateFormatter.string(from: pickerDOB.date) + " " + timeFormatter.string(from: pickerDOB.date)
        print(dateTimeDisplay)
        print(currentdate)
        
        
        
        pickerDOB.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = Foundation.DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let selectedDate = dateFormatter.string(from: pickerDOB.date)
        dateTimeDisplay=selectedDate
        print(selectedDate)
        print(selectedDate)
    }
    
    //textFieldShodfguldEndEditing code by DPK
    
    
    /*
     func textFieldShoudfgldEndEditing(textField: UITextField!) -> Bool {  //delegate method
     
     print(textField.tag)
     varSelectedTableRowTextFieldTag=textField.tag
     print(textField.text)
     let pointInTable = textField.convertPoint(textField.bounds.origin, toView: tableviewEditUpdateProfile)
     let indexPath = tableviewEditUpdateProfile.indexPathForRowAtPoint(pointInTable)?.row
     print(indexPath)
     
     varSelectedTableRowIndex=Int(indexPath!)
     print("This is index:----")
     print(varSelectedTableRowIndex)
     if(varSelectedTableRowTextFieldTag==555)
     {
     if(varRasidentialContactKeyBoardHideShow == "-100")
     {
     self.tableviewEditUpdateProfile.frame = CGRectMake(self.tableviewEditUpdateProfile.frame.origin.x,self.tableviewEditUpdateProfile.frame.origin.y+100, self.tableviewEditUpdateProfile.frame.size.width, self.tableviewEditUpdateProfile.frame.size.height)
     varRasidentialContactKeyBoardHideShow = "+100"
     }
     
     }
     else
     {
     if(varRasidentialContactKeyBoardHideShow == "-100")
     {
     self.tableviewEditUpdateProfile.frame = CGRectMake(self.tableviewEditUpdateProfile.frame.origin.x,self.tableviewEditUpdateProfile.frame.origin.y+100, self.tableviewEditUpdateProfile.frame.size.width, self.tableviewEditUpdateProfile.frame.size.height)
     varRasidentialContactKeyBoardHideShow = "+100"
     
     }
     }
     
     
     
     return true
     }
     */
    //---text box methods-b  3473 4 75349857324573248957435732-5723895723434 34 534 734 734875 34753457-2357892347593845 7983475893
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        print(textField.tag)
        varSelectedTableRowTextFieldTag=textField.tag
        print(textField.text)
        let pointInTable = textField.convert(textField.bounds.origin, to: tableviewEditUpdateProfile)
        let indexPath = tableviewEditUpdateProfile.indexPathForRow(at: pointInTable)?.row
        print(indexPath)
        
        varSelectedTableRowIndex=Int(indexPath!)
        print("This is index:----")
        print(varSelectedTableRowIndex)
        //if(varSelectedTableRowIndex==1 || varSelectedTableRowIndex==11 || varSelectedTableRowIndex==12)
        if(varSelectedTableRowIndex==1 || varSelectedTableRowIndex==0 || varSelectedTableRowIndex==12)
        {
            if(varSelectedTableRowTextFieldTag==111)
            {
                print(muarrayValueFirst.object(at: varSelectedTableRowIndex))
                varSelectedTableRowIndexGet_Text=muarrayValueFirst.object(at: varSelectedTableRowIndex) as! String
                print(varSelectedTableRowIndexGet_Text)
            }
            if((isAdmin=="No" || isAdmin=="Yes") && varSelectedTableRowIndex==0)
            {
                self.view.makeToast("Name can not be changed", duration: 2, position: CSToastPositionCenter)
                //return true
            }
            else if((isAdmin=="No" || isAdmin=="Yes") && varSelectedTableRowIndex==1)
            {
                self.view.makeToast("Telephone No. can not be changed", duration: 2, position: CSToastPositionCenter)
            }
            else if((isAdmin=="No" || isAdmin=="Yes") && (varSelectedTableRowIndex==0))
            {
                self.view.makeToast("Name can not be changed", duration: 2, position: CSToastPositionCenter)
            }
            else if((isAdmin=="No" || isAdmin=="Yes") && (varSelectedTableRowIndex==1))
            {
                self.view.makeToast("Telephone No. can not be changed", duration: 2, position: CSToastPositionCenter)
            }
                
            else if(isAdmin=="No" && (varSelectedTableRowIndex==12))
            {
                self.view.makeToast("District Designation can not be changed", duration: 2, position: CSToastPositionCenter)
            }
            else if(isAdmin=="No" && (varSelectedTableRowIndex==12))
            {
                self.view.makeToast("District Designation can not be changed", duration: 2, position: CSToastPositionCenter)
            }
            
            return false
        }
        else
        {
            
            
            
            if(varSelectedTableRowTextFieldTag==111)
            {
                print(muarrayValueFirst.object(at: varSelectedTableRowIndex))
                varSelectedTableRowIndexGet_Text=muarrayValueFirst.object(at: varSelectedTableRowIndex) as! String
                print(varSelectedTableRowIndexGet_Text)
            }
            else if(varSelectedTableRowTextFieldTag==222)
            {
                print(muarrayValueFirst.object(at: varSelectedTableRowIndex))
                varSelectedTableRowIndexGet_Text=muarrayCitySecond.object(at: varSelectedTableRowIndex) as! String
            }
            else if(varSelectedTableRowTextFieldTag==333)
            {
                print(muarrayValueFirst.object(at: varSelectedTableRowIndex))
                varSelectedTableRowIndexGet_Text=muarrayPostalCodeSecond.object(at: varSelectedTableRowIndex) as! String
            }
            else if(varSelectedTableRowTextFieldTag==444)
            {
                print(muarrayValueFirst.object(at: varSelectedTableRowIndex))
                varSelectedTableRowIndexGet_Text=muarrayStateSecond.object(at: varSelectedTableRowIndex) as! String
                muarrayAddressIdSecond.object(at: varSelectedTableRowIndex) as! String
            }
            else if(varSelectedTableRowTextFieldTag==555)
            {
                // varRasidentialContactKeyBoardHideShow = "-100"
                //self.tableviewEditUpdateProfile.frame = CGRectMake(self.tableviewEditUpdateProfile.frame.origin.x, self.tableviewEditUpdateProfile.frame.origin.y-100, self.tableviewEditUpdateProfile.frame.size.width, self.tableviewEditUpdateProfile.frame.size.height)
                
                print(muarrayValueFirst.object(at: varSelectedTableRowIndex))
                varSelectedTableRowIndexGet_Text=muarrayBusinessContactMobileNumberSecond.object(at: varSelectedTableRowIndex) as! String
            }
            else if(varSelectedTableRowTextFieldTag==666)
            {
                print(muarrayValueFirst.object(at: varSelectedTableRowIndex))
                varSelectedTableRowIndexGet_Text=muarrayNameThree.object(at: varSelectedTableRowIndex) as! String
                muarrayFamilyMemberIDThree.object(at: varSelectedTableRowIndex)
            }
            else if(varSelectedTableRowTextFieldTag==777)
            {
                print(muarrayValueFirst.object(at: varSelectedTableRowIndex))
                varSelectedTableRowIndexGet_Text=muarrayMobileNumberThree.object(at: varSelectedTableRowIndex) as! String
            }
            else if(varSelectedTableRowTextFieldTag==888)
            {
                print(muarrayValueFirst.object(at: varSelectedTableRowIndex))
                varSelectedTableRowIndexGet_Text=muarrayEmailIDThree.object(at: varSelectedTableRowIndex) as! String
            }
        }
        return true
    }
    
    
    //MARK:- Textfield Delegate Methods
    //    func textFieldShoudfgldReturn(textField: UITextField) -> Bool
    //    {
    //        cell =  tableviewEditUpdateProfile.dequeueReusableCellWithIdentifier("Cell") as! EditUpdateProfileTableViewCell
    //        cell.textfieldValueFirst.resignFirstResponder()
    //        cell.textfieldStateSecond.resignFirstResponder()
    //        cell.textfieldCitySecond.resignFirstResponder()
    //        cell.textfieldNameThree.resignFirstResponder()
    //        cell.textfieldRelationshipThree.resignFirstResponder()
    //        cell.textfieldValueFirst.resignFirstResponder()
    //
    //        return true
    //    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cell =  tableviewEditUpdateProfile.dequeueReusableCell(withIdentifier: "Cell") as! EditUpdateProfileTableViewCell
        
        self.view.endEditing(true)
        
        cell.textfieldValueFirst.resignFirstResponder()
        cell.textfieldRelationshipThree.resignFirstResponder()
        cell.textfieldMobileNumberThree.resignFirstResponder()
        cell.textfieldCountryCodeThree.resignFirstResponder()
        cell.textfieldBloodGroup.resignFirstResponder()
        cell.textfieldBirthdayThree.resignFirstResponder()
        cell.textfieldAnniversaryThree.resignFirstResponder()
        cell.textfieldAnniversaryThree.resignFirstResponder()
        cell.textfieldAnniversaryThree.resignFirstResponder()
        cell.textviewAddressSecond.resignFirstResponder()
        
        
        
        return false
    }

    // func textField(textField: UITextField!, shosdauldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool
    func textField(_ textField: UITextField,  shouldChangeCharactersIn range: NSRange, replacementString string: String)  -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")

        if (isBackSpace == -92)
        {
            let userEnteredString = textField.text
            let newString = (userEnteredString! as NSString?)?.replacingCharacters(in: range, with: string)
            print(newString)
            print("Backspace was pressed rajendra jat")
            if(varSelectedTableRowTextFieldTag==111)
            {
                muarrayValueFirst.replaceObject(at: varSelectedTableRowIndex, with: newString!)
            }
            else if(varSelectedTableRowTextFieldTag==222)
            {
                muarrayCitySecond.replaceObject(at: varSelectedTableRowIndex, with: newString!)
            }
            else if(varSelectedTableRowTextFieldTag==333)
            {
                muarrayPostalCodeSecond.replaceObject(at: varSelectedTableRowIndex, with: newString!)
            }
            else if(varSelectedTableRowTextFieldTag==444)
            {
                muarrayStateSecond.replaceObject(at: varSelectedTableRowIndex, with: newString!)
            }
            else if(varSelectedTableRowTextFieldTag==555)
            {
                muarrayBusinessContactMobileNumberSecond.replaceObject(at: varSelectedTableRowIndex, with: newString!)
            }
            else if(varSelectedTableRowTextFieldTag==666)
            {
                muarrayNameThree.replaceObject(at: varSelectedTableRowIndex, with: newString!)
            }
            else if(varSelectedTableRowTextFieldTag==777)
            {
                muarrayMobileNumberThree.replaceObject(at: varSelectedTableRowIndex, with: newString!)
            }
            else if(varSelectedTableRowTextFieldTag==888)
            {
                muarrayEmailIDThree.replaceObject(at: varSelectedTableRowIndex, with: newString!)
            }
        }
        else
        {
            let userEnteredString = textField.text
            let newString = (userEnteredString! as NSString?)?.replacingCharacters(in: range, with: string)
            print(newString)
            if(varSelectedTableRowTextFieldTag==111)
            {
                if(varSelectedTableRowIndex==2)
                {
                    var varGetMobileValue:String!=muarrayValueFirst.object(at: Int(varSelectedTableRowIndex)) as! String
                    print(varGetMobileValue)
                    print(string)
                    if(varGetMobileValue.characters.count <= 0 && string=="0")
                    {
                        self.view.makeToast("Mobile number cannot start with zero(0).", duration: 3, position: CSToastPositionCenter)
                        print(varGetMobileValue)
                        return false
                    }
                }
                muarrayValueFirst.replaceObject(at: Int(varSelectedTableRowIndex), with: newString!)
            }
            else if(varSelectedTableRowTextFieldTag==222)
            {
                muarrayCitySecond.replaceObject(at: Int(varSelectedTableRowIndex), with: newString!)
            }
            else if(varSelectedTableRowTextFieldTag==333)
            {
                muarrayPostalCodeSecond.replaceObject(at: Int(varSelectedTableRowIndex), with: newString!)
            }
            else if(varSelectedTableRowTextFieldTag==444)
            {
                muarrayStateSecond.replaceObject(at: Int(varSelectedTableRowIndex), with: newString!)
            }
            else if(varSelectedTableRowTextFieldTag==555)
            {
                
                var varGetMobileValue:String!=muarrayBusinessContactMobileNumberSecond.object(at: Int(varSelectedTableRowIndex)) as! String
                print(varGetMobileValue)
                print(string)
                if(varGetMobileValue.characters.count == 0 && string=="0")
                {
                    self.view.makeToast("Mobile number cannot start with zero(0).", duration: 3, position: CSToastPositionCenter)
                    print(varGetMobileValue)
                    print("1")
                    return false
                }
                else
                {
                    muarrayBusinessContactMobileNumberSecond.replaceObject(at: Int(varSelectedTableRowIndex), with: newString!)
                }
            }
            else if(varSelectedTableRowTextFieldTag==666)
            {
                muarrayNameThree.replaceObject(at: Int(varSelectedTableRowIndex), with: newString!)
            }
            else if(varSelectedTableRowTextFieldTag==777)
            {
                var varGetMobileValue:String!=muarrayMobileNumberThree.object(at: Int(varSelectedTableRowIndex)) as! String
                
                if(varGetMobileValue.characters.count == 0 && string=="0")
                {
                    self.view.makeToast("Mobile number cannot start with zero(0).", duration: 3, position: CSToastPositionCenter)
                    print(varGetMobileValue)
                    print("1")
                    return false
                }
                else
                {
                    muarrayMobileNumberThree.replaceObject(at: Int(varSelectedTableRowIndex), with: newString!)
                }
            }
            else if(varSelectedTableRowTextFieldTag==888)
            {
                muarrayEmailIDThree.replaceObject(at: Int(varSelectedTableRowIndex), with: newString!)
            }
            
        }
        
        return true
    }
    
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        let userEnteredString = textView.text
        var newString = (userEnteredString! as NSString?)?.replacingCharacters(in: range, with: text)
        print(newString?.characters.count)
        if(newString?.characters.count>0 || newString != nil || newString != "")
        {
            print("------------------__>-_>>>",userEnteredString)
            print("=========================>",newString)
            varSelectedTableRowIndexGet_Text = newString
            muarrayAddressSecond.replaceObject(at: varSelectedTableRowIndex, with: newString!)
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        let pointInTable = textView.convert(textView.bounds.origin, to: tableviewEditUpdateProfile)
        let indexPath = tableviewEditUpdateProfile.indexPathForRow(at: pointInTable)?.row
        print(indexPath)
        print(indexPath)
        print(indexPath)
        
        varSelectedTableRowIndex=Int(indexPath!)
        
        print(muarrayAddressSecond.object(at: varSelectedTableRowIndex))
        varSelectedTableRowIndexGet_Text=muarrayAddressSecond.object(at: varSelectedTableRowIndex) as! String
        
        
        
    }
    
    
    @IBAction func buttonUpdateClickEvent(_ sender: AnyObject)
    {
        functionForUpdateButtonClickEvent()
    }
    func functionForUpdateButtonClickEvent()
    {
        print("Hello")
        var varIsValidData:String!="yes"
        //««««««««««««««««««««««««ADDRESS array»»»»»»»»»»»»»»»»»»»»»»
        var muarrayAddressDetails:NSMutableArray=NSMutableArray()
        var dictaddressArray = [String: AnyObject]()
        var dictaddressArray1 = [String: AnyObject]()
        
        //1.
        var  address=muarrayAddressSecond.object(at: 7)as! String
        var  addressID=muarrayAddressIdSecond.object(at: 7)as! String
        var  addressType="Business"
        var  city=muarrayCitySecond.object(at: 7)as! String
        // var  country=muarrayCountryCodeSecond.objectAtIndex(7)as! String
        
        var  country=muarrayCountryIdSecond.object(at: 7)as! String
        var  state=muarrayStateSecond.object(at: 7)as! String
        var  pincode=muarrayPostalCodeSecond.object(at: 7)as! String
        var  phoneNo=muarrayBusinessContactMobileNumberSecond.object(at: 7)as! String
        if(phoneNo.characters.count>0)
        {
            print(phoneNo)
            print(country)
            if(country.characters.count>0 && country != "Select Country")
            {
                
            }
            else
            {
                self.view.makeToast("Please select country for business address", duration: 3, position: CSToastPositionCenter)
                varIsValidData="no"
            }
        }
        else
        {
            phoneNo=""
            // country=""
        }
        
        ///validation for if address in textview then
        if(address.characters.count>0)
        {
            print(country)
            if(country.characters.count>0 && country != "Select Country")
            {
                varIsValidData="yes"
            }
            else
            {
                varIsValidData="no"
                country=""
                self.view.makeToast("Please select country for business address", duration: 3, position: CSToastPositionCenter)
            }
        }
        else
        {
            print(country)
            print(address)
            print(city)
            print(phoneNo)
            print(pincode)
            print(state)
        }
        
        print("<<<<--->>>>>>")
        print(country)
        print(address)
        print(city)
        print(phoneNo)
        print(pincode)
        print(state)
        
        
        print(addressID)
        print(addressType)
        let  profileIds=profileId
        if(addressID.characters.count>0) //Comment by Deepak 30-01-2018 //again uncomment by rajendra jat 25 june 2018
            //if(address.characters.count>0 && state.characters.count>0 && city.characters.count>0&&addressID.characters.count==0)
        {
            //addressID="0"
            print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh")
        }
            //else if (address.characters.count<=0 && state.characters.count<=0 && city.characters.count<=0 && addressID.characters.count != 0)
        else if (addressID.characters.count != 0)
        {
            self.DeleteAddressDetailsUseProfileID("Business")
        }
        else
        {
            
        }
        /*-------------------*/
        
        if(addressID.characters.count<=0)
        {
            addressID="0"
        }
        if(country=="Country Code")
        {
            country="0"
        }
        print(addressID)
        
        
        phoneNo = phoneNo.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if(phoneNo.characters.count>0 && country=="0")
        {
            self.view.makeToast("Please select country for business address", duration: 3, position: CSToastPositionCenter)
        }
        else
        {
            
            if(country=="Select Country")
            {
                country="0"
            }
            
            dictaddressArray = ["address":address as AnyObject,"addressID":addressID as AnyObject,"addressType":addressType as AnyObject,"city":city as AnyObject,"country":country as AnyObject,"fax": "" as AnyObject ,"phoneNo":phoneNo as AnyObject,"pincode":pincode as AnyObject,"profileID":profileIds as AnyObject,"state":state as AnyObject]
            muarrayAddressDetails.add(dictaddressArray)
            print(dictaddressArray)
            
            
            
            if(varIsValidData=="yes")
            {
                
                
                print(muarrayAddressIdSecond)
                
                //2.
                var  address2=muarrayAddressSecond.object(at: 17)as! String
                var  addressID2=muarrayAddressIdSecond.object(at: 17)as! String
                var  addressType2="Residence"
                var  city2=muarrayCitySecond.object(at: 17)as! String
                // var  country2=muarrayCountryCodeSecond.objectAtIndex(17)as! String
                var country2=muarrayCountryIdSecond.object(at: 17)as! String
                var  pincode2=muarrayPostalCodeSecond.object(at: 17)as! String
                //var  profileIds2=profileId
                var  state2=muarrayStateSecond.object(at: 17)as! String
                
                
                print(addressID2)
                
                var  phoneNo2=muarrayBusinessContactMobileNumberSecond.object(at: 17)as! String
                if(phoneNo2.characters.count>0)
                {
                    print(phoneNo2)
                    print(country2)
                    if(country2.characters.count>0 && country2 != "Select Country")
                    {
                        
                    }
                    else
                    {
                        self.view.makeToast("Please select country for residential address", duration: 2, position: CSToastPositionCenter)
                        
                        varIsValidData="no"
                    }
                    print(muarrayBusinessContactCountryCodeSecond.object(at: 17)as! String)
                    print(muarrayBusinessContactCountryIdSecond.object(at: 17)as! String)
                    print(muarrayBusinessContactMobileNumberSecond.object(at: 17)as! String)
                    print(phoneNo2)
                    // phoneNo2=phoneNo2
                }
                else
                {
                    phoneNo2=""
                    //country2=""
                }
                //country2=muarrayCountryIdSecond.objectAtIndex(17)as! String
                
                ///validation for if address in textview then
                if(address2.characters.count>0)
                {
                    print(country2)
                    if(country2.characters.count>0 && country2 != "Select Country")
                    {
                        varIsValidData="yes"
                    }
                    else
                    {
                        varIsValidData="no"
                        country2=""
                        self.view.makeToast("Please select country for residential address", duration: 3, position: CSToastPositionCenter)
                        varIsValidData="no"
                    }
                }
                else
                {
                    //country2=""
                    //address2=""
                    //city2=""
                    // phoneNo2=""
                    // pincode2=""
                    //  state2=""
                }
                
                print(country2)
                if(varIsValidData=="yes")
                {
                    
                    print(addressID2)
                    //if(address2.characters.count>0 && state2.characters.count>0 && city2.characters.count>0&&addressID2.characters.count==0)
                    if(addressID2.characters.count==0)
                    {
                        // addressID2="0"
                        print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh")
                    }
                        // else if (address2.characters.count<=0 && state2.characters.count<=0 && city2.characters.count<=0 && addressID2.characters.count != 0)
                    else if (addressID2.characters.count != 0)
                    {
                        self.DeleteAddressDetailsUseProfileID("Residence")
                        // addressID2="0"
                    }
                    else
                    {
                        
                    }
                    print(addressID2)
                    if(addressID2.characters.count<=0)
                    {
                        // addressID2="0"
                    }
                    
                    print(addressID)
                    if(country2=="Country Code" || country2=="" || country2.characters.count<=0)
                    {
                        country2="0"
                    }
                    
                    print(addressID2)
                    phoneNo2 = phoneNo2.trimmingCharacters(in: CharacterSet.whitespaces)
                    
                    if(phoneNo2.characters.count>0 && country2=="0")
                    {
                        self.view.makeToast("Please select country for residential address", duration: 3, position: CSToastPositionCenter)
                    }
                        
                    else
                    {
 if(country2=="Select Country")
 {
     country2="0"
 }
 
 print("Address Id 2")
 print(addressID2)
 
 if(addressID2.characters.count<=0)
 {
     addressID2="0"
 }
 
 print("Address Id 3")
 print(addressID2)
 
 
 
 let  profileIds2=profileId
 dictaddressArray1=["address":address2 as AnyObject,"addressID":addressID2 as AnyObject,"addressType":addressType2 as AnyObject,"city":city2 as AnyObject,"country":country2 as AnyObject,"fax": "" as AnyObject, "phoneNo":phoneNo2 as AnyObject, "pincode":pincode2 as AnyObject,"profileID":profileIds2 as AnyObject,"state":state2 as AnyObject]
 muarrayAddressDetails.add(dictaddressArray1)
 print(dictaddressArray1)
 
 /*---------------------------------------------------------------------------*/
 //validation for secosdfndary mobile number
 var varGetSecondaryCountryCodeVali:String!=muarrayCountryIdFirst.object(at: 2) as! String
 var varGetSecondaryMobileNumberVali:String!=muarrayValueFirst.object(at: 2) as! String
 
 print(varGetSecondaryCountryCodeVali)
 print(varGetSecondaryMobileNumberVali)
 
 if(varGetSecondaryCountryCodeVali != "Country Code"  || varGetSecondaryCountryCodeVali != "" || varGetSecondaryCountryCodeVali != "0")
 {
     //DPK
     print("1-------------",varGetSecondaryMobileNumberVali)
     
     if(varGetSecondaryMobileNumberVali.characters.count>=1 && (varGetSecondaryCountryCodeVali == "" || varGetSecondaryCountryCodeVali == "Country Code" || varGetSecondaryCountryCodeVali == "0"))
     {
         self.view.makeToast("Please select country for secondary mobile number", duration: 3, position: CSToastPositionCenter)
         print("22222222")
         varIsValidData="no"
         print("3333333")
     }
     else if((varGetSecondaryMobileNumberVali.characters.count==0))
     {
         varGetSecondaryCountryCodeVali = "Country Code"
         self.muarrayCountryIdFirst.replaceObject(at: 2, with: varGetSecondaryCountryCodeVali)
         
         print("66666666666666")
         varIsValidData="yes"
         print("99999999999999999")
     }
     else if(varGetSecondaryMobileNumberVali.characters.count>=1 && varGetSecondaryCountryCodeVali .characters.count>0 && varGetSecondaryCountryCodeVali != "" && varGetSecondaryCountryCodeVali != "Country Code")
     {
         print("2")
         varIsValidData="yes"
         print("3")
     }
     else
     {
         print("4")
         varIsValidData="no"
         self.view.makeToast("Please enter secondary mobile number", duration: 3, position: CSToastPositionCenter)
         print("5")
     }
     print("6")
 }
 if(varIsValidData=="yes")
 {
     //«««««««««««««««««««««««««««FAMILY array»»»»»»»»»»»»»»»»»»»»»»»»»»»
     var muarrayFamilyDetails:NSMutableArray=NSMutableArray()
     var dictFamilyDetailrray = [String: AnyObject]()
     for j in 00..<muarrayPersonalorAddressorFamilyDetail.count
     {
         let varCheckFornoWordForExitLoop=muarrayPersonalorAddressorFamilyDetail.object(at: j)
         if(varCheckFornoWordForExitLoop as! String != "familydetail")
         {
             //break
         }
         else
         {
             
             var familyMemberId=muarrayFamilyMemberIDThree.object(at: j)as! String
    let memberName=muarrayNameThree.object(at: j)as! String
    let emailID=muarrayEmailIDThree.object(at: j)as! String
    var contactNo=muarrayMobileNumberThree.object(at: j) as! String
    var countryID=muarrayCountryIdThree.object(at: j)as! String
    
    let relationship=muarrayRelationshipThree.object(at: j)as! String
    var memberDOB=muarrayBirthdayThree.object(at: j)as! String
    let bloodGroup=muarrayBloodGroupThree.object(at: j)as! String
    var memberDOA=muarrayAnniversaryThree.object(at: j)as! String
    let particulars="NA"
    
    
    if(memberName.characters.count>0 && relationship.characters.count>0)
    {
        
        var varGetMobileNumber=muarrayMobileNumberThree.object(at: j) as! String
        if(varGetMobileNumber.characters.count>0)
        {
            var varGetCountryCode=muarrayCountryCodeThree.object(at: j)as! String
            print(varGetMobileNumber)
            print(varGetCountryCode)
            
            if(varGetCountryCode.characters.count>0 && varGetCountryCode.characters.count>0 && varGetCountryCode != "Select Country" && varGetCountryCode != "Country Code")
            {
                contactNo=(muarrayMobileNumberThree.object(at: j) as! String)
                countryID=(muarrayCountryIdThree.object(at: j)as! String)
                
            }
            else
            {
                self.view.makeToast("Select Country for family detail member", duration: 2, position: CSToastPositionCenter)
                varIsValidData="no"
                
            }
            
            
        }
        else
        {
            contactNo=""
            countryID=""
            print("contact number:----")
            print(contactNo)
            
        }
        
        if(familyMemberId.characters.count>0 && familyMemberId != "" && familyMemberId != "0")
        {
            
        }
        else
        {
            familyMemberId="0"
        }
        
        //need to set here DOB and DOA
        if(memberDOB != "")
        {
            var varGetValue=memberDOB.components(separatedBy: "/")
            memberDOB=varGetValue[2]+"/"+varGetValue[1]+"/"+varGetValue[0]
            
        }
        if(memberDOA != "")
        {
            var varGetValueDOA=memberDOA.components(separatedBy: "/")
            memberDOA=varGetValueDOA[2]+"/"+varGetValueDOA[1]+"/"+varGetValueDOA[0]
            
        }
        
        
        let isvalidEmails = isValidEmail(emailID)
        if(emailID != "")
        {
            if(isvalidEmails==false)
            {
                self.view.makeToast("Please enter a valid Email ID for family member.", duration: 2, position: CSToastPositionCenter)
                varIsValidData="no"
                break
            }
        }
        
        //familyMemberId
        dictFamilyDetailrray=["memberDOB":memberDOB as AnyObject,"bloodGroup":bloodGroup as AnyObject,"contactNo":"" as AnyObject,"countryID":countryID as AnyObject,"emailID":emailID as AnyObject,"profileId":profileId as AnyObject,"familyMemberId":familyMemberId as AnyObject,"memberName":memberName as AnyObject,"relationship":relationship as AnyObject,"memberDOA":memberDOA as AnyObject,"particulars":particulars as AnyObject,]
        muarrayFamilyDetails.add(dictFamilyDetailrray)
        print(muarrayFamilyDetails)
    }
    else
    {
        if(varIsFamilyMemberorNot=="no")
        {
            varIsValidData="yes"
        }
        else
        {
            varIsValidData="no"
            self.view.makeToast("name or relation can not be blank", duration: 2, position: CSToastPositionCenter)
        }
    }
    
}
}
 print("<<<<<<<<<<<<<<-------------------->>>>>>>>>>>>>")
print(varIsValidData)
if(varIsValidData=="no")
{
    
}
else
{
    print(varIsValidData)
    //«««««««««««««««««««««««««««BUSINESS array»»»»»»»»»»»»»»»»»»»»»»»»»»»
    var dictAddArray = [String: String]()
    var muarraybusinessMemberDetails:NSMutableArray=NSMutableArray()
    
    
    
    
    
    
    dictAddArray=["value":muarrayValueFirst.object(at: 5) as! String,"fieldID":"0","uniquekey":"BusinessName"]
    muarraybusinessMemberDetails.add(dictAddArray)
    print(dictAddArray)
    dictAddArray=["value":muarrayValueFirst.object(at: 6) as! String,"fieldID":"0","uniquekey":"businessPosition"]
    muarraybusinessMemberDetails.add(dictAddArray)
    
    
    //here need to get country code
    var varGetCountryMasterCode:String!=muarrayCountryIdFirst.object(at: 2) as! String
    var varGetCountryCodeNEwss:String!=functionForSelectCountry(varGetCountryMasterCode)
    
    dictAddArray=["value":varGetCountryCodeNEwss+" "+(muarrayValueFirst.object(at: 2) as! String) ,"fieldID":"0","uniquekey":"secondry_mobile_no"]
    muarraybusinessMemberDetails.add(dictAddArray)
    
    // dictAddArray=["value":"+91 "+(muarrayValueFirst.objectAtIndex(2) as! String) as! String,"fieldID":"0","uniquekey":"secondry_mobile_no"]
    //muarraybusinessMemberDetails.addObject(dictAddArray)
    
    dictAddArray=["value":muarrayValueFirst.object(at: 10) as! String,"fieldID":"0","uniquekey":"member_rotary_id"]
    muarraybusinessMemberDetails.add(dictAddArray)
    
    
    print(muarrayValueFirst.object(at: 3) as! String)
    let isvalidEmails = isValidEmail(muarrayValueFirst.object(at: 3) as! String)
    if((muarrayValueFirst.object(at: 3) as! String) != "")
    {
        if(isvalidEmails==false)
        {
            self.view.makeToast("Please enter a valid Email ID.", duration: 2, position: CSToastPositionCenter)
            varIsValidData="no"
        }
        else
        {
            dictAddArray=["value":muarrayValueFirst.object(at: 3) as! String,"fieldID":"0","uniquekey":"member_email_id"]
            muarraybusinessMemberDetails.add(dictAddArray)
            print(dictAddArray)
            varIsValidData="yes"
            
            
            
            let isvalidEmail = isValidEmail(muarrayValueFirst.object(at: 4) as! String)
            if((muarrayValueFirst.object(at: 4) as! String) != "")
            {
                if(isvalidEmail==false)
                {
                    self.view.makeToast("Please enter a valid Email ID.", duration: 2, position: CSToastPositionCenter)
                    varIsValidData="no"
                }
                else
                {
                    dictAddArray=["value":muarrayValueFirst.object(at: 4) as! String,"fieldID":"0","uniquekey":"member_buss_email"]
                    muarraybusinessMemberDetails.add(dictAddArray)
                    print(dictAddArray)
                    varIsValidData="yes"
                }
            }
            else
            {
                dictAddArray=["value":muarrayValueFirst.object(at: 4) as! String,"fieldID":"0","uniquekey":"member_buss_email"]
                muarraybusinessMemberDetails.add(dictAddArray)
                print(dictAddArray)
            }
        }
    }
    else
    {
        dictAddArray=["value":muarrayValueFirst.object(at: 3) as! String,"fieldID":"0","uniquekey":"member_email_id"]
        muarraybusinessMemberDetails.add(dictAddArray)
        print(dictAddArray)
        
        
        let isvalidEmail = isValidEmail(muarrayValueFirst.object(at: 4) as! String)
        if((muarrayValueFirst.object(at: 4) as! String) != "")
        {
            if(isvalidEmail==false)
            {
                self.view.makeToast("Please enter a valid Email ID.", duration: 2, position: CSToastPositionCenter)
                varIsValidData="no"
            }
            else
            {
                dictAddArray=["value":muarrayValueFirst.object(at: 4) as! String,"fieldID":"0","uniquekey":"member_buss_email"]
                muarraybusinessMemberDetails.add(dictAddArray)
                print(dictAddArray)
                varIsValidData="yes"
            }
        }
        else
        {
            dictAddArray=["value":muarrayValueFirst.object(at: 4) as! String,"fieldID":"0","uniquekey":"member_buss_email"]
            muarraybusinessMemberDetails.add(dictAddArray)
            print(dictAddArray)
        }
    }
    
    
    
    dictAddArray=["value":muarrayValueFirst.object(at: 0) as! String,"fieldID":"0","uniquekey":"member_name"]
    muarraybusinessMemberDetails.add(dictAddArray)
    
    
    
    
    dictAddArray=["value":muarrayValueFirst.object(at: 8) as! String,"fieldID":"0","uniquekey":"designation"]
    muarraybusinessMemberDetails.add(dictAddArray)
    
    
    
    
    dictAddArray=["value":muarrayValueFirst.object(at: 9) as! String,"fieldID":"0","uniquekey":"Keywords"]
    muarraybusinessMemberDetails.add(dictAddArray)
    
    
    dictAddArray=["value":muarrayValueFirst.object(at: 11) as! String,"fieldID":"0","uniquekey":"member_master_designation"]
    muarraybusinessMemberDetails.add(dictAddArray)
    
    
    
    
    dictAddArray=["value":muarrayValueFirst.object(at: 12) as! String,"fieldID":"0","uniquekey":"dg_master_designation"]
    muarraybusinessMemberDetails.add(dictAddArray)
    
    
    dictAddArray=["value":muarrayValueFirst.object(at: 13) as! String,"fieldID":"0","uniquekey":"rotary_donar_recognation"]
    muarraybusinessMemberDetails.add(dictAddArray)
    
    dictAddArray=["value":muarrayValueFirst.object(at: 16) as! String,"fieldID":"0","uniquekey":"blood_Group"]
    muarraybusinessMemberDetails.add(dictAddArray)
    
    //here need to check
    
    var varGetDOBValid:String!=muarrayValueFirst.object(at: 14) as! String
    print(varGetDOBValid)
    if(varGetDOBValid.characters.count>0)
    {
        let string = varGetDOBValid
        varGetDOBValid = (string as! NSString).replacingOccurrences(of: "/", with: ".")
        var varGetArray=varGetDOBValid.components(separatedBy: ".")
        varGetDOBValid=varGetArray[2]+"/"+varGetArray[1]+"/"+varGetArray[0]
    }
    else
    {
        varGetDOBValid="0000/00/00"
        
    }
    var varGetDOAValid:String!=muarrayValueFirst.object(at: 15) as! String
    print(varGetDOAValid)
    
    if(varGetDOAValid.characters.count>0)
    {
        let string = varGetDOAValid
        varGetDOAValid = (string as! NSString).replacingOccurrences(of: ".", with: ".")
        
        var varGetArray=varGetDOAValid.components(separatedBy: "/")
        varGetDOAValid=varGetArray[2]+"/"+varGetArray[1]+"/"+varGetArray[0]
        
    }
    else
    {
        varGetDOAValid="0000/00/00"
    }
    
    
    print(varGetDOBValid)
    print(varGetDOAValid)
    
    
    
    if (varGetDOBValid=="1900/5/5")    //DPK
    {
        
    }
    else
    {
        dictAddArray=["value":varGetDOBValid,"fieldID":"0","uniquekey":"member_date_of_birth"]
        muarraybusinessMemberDetails.add(dictAddArray)
    }
    if(varGetDOAValid=="1900/5/5")  //DPK
    {
        
    }
    else
    {
        dictAddArray=["value":varGetDOAValid,"fieldID":"0","uniquekey":"member_date_of_wedding"]
        muarraybusinessMemberDetails.add(dictAddArray)
    }
    
    
    
    
    
    print(dictAddArray)
    print(muarraybusinessMemberDetails)
    //muarraybusinessMemberDetails
    // print()
    
    //«««««««««««««««««««««««««««PERSONAL array»»»»»»»»»»»»»»»»»»»»»»»»»»»
    var muarrayPersonalMemberDetails:NSMutableArray=NSMutableArray()
//    var dictPersonalInfoArray = [String: AnyObject]()
    
    var varGetSecondaryMobileNumber:String!=(muarrayCountryIdFirst.object(at: 2) as! String)+" "+(muarrayValueFirst.object(at: 2) as! String)
    print(muarrayCountryIdFirst.object(at: 2) as! String)
    print(varGetSecondaryMobileNumber)
    
//    dictPersonalInfoArray = [
//        "memberDOB":"" as! String as AnyObject,
//        "memberDOA":"" as! String as AnyObject,
//        "donarRecognition":muarrayValueFirst.object(at: 13) as! String as AnyObject,
//        "districtDesignation":muarrayValueFirst.object(at: 12) as! String as AnyObject,
//        "secondaryMobileNo":varGetSecondaryMobileNumber as AnyObject,
//        "classification":muarrayValueFirst.object(at: 8) as! String as AnyObject,
//        "keywords":muarrayValueFirst.object(at: 9) as! String as AnyObject,
//        "bloodGroup":muarrayValueFirst.object(at: 16) as! String as AnyObject,
//        "memberName":muarrayValueFirst.object(at: 0) as! String as AnyObject,
//        "rotaryId":muarrayValueFirst.object(at: 10) as! String as AnyObject,
//        "memberEmail":muarrayValueFirst.object(at: 3) as! String as AnyObject,
//        "profilePic":"" as AnyObject,
//
//        "clubDesignation":muarrayValueFirst.object(at: 11) as! String as AnyObject,
//    ]
    
    dictPersonalInfoArray .setValue("", forKey: "memberDOB")
    dictPersonalInfoArray .setValue("", forKey: "memberDOA")
    dictPersonalInfoArray .setValue(muarrayValueFirst.object(at: 13) as! String as AnyObject, forKey: "donarRecognition")
    dictPersonalInfoArray .setValue(muarrayValueFirst.object(at: 12) as! String as AnyObject, forKey: "districtDesignation")
    dictPersonalInfoArray .setValue(varGetSecondaryMobileNumber as AnyObject, forKey: "secondaryMobileNo")
    dictPersonalInfoArray .setValue(muarrayValueFirst.object(at: 8) as! String as AnyObject, forKey: "classification")
    dictPersonalInfoArray .setValue(muarrayValueFirst.object(at: 9) as! String as AnyObject, forKey: "keywords")
    dictPersonalInfoArray .setValue(muarrayValueFirst.object(at: 16) as! String as AnyObject, forKey: "bloodGroup")
    dictPersonalInfoArray .setValue(muarrayValueFirst.object(at: 0) as! String as AnyObject, forKey: "memberName")
    dictPersonalInfoArray .setValue(muarrayValueFirst.object(at: 10) as! String as AnyObject, forKey: "rotaryId")
   
    dictPersonalInfoArray .setValue(muarrayValueFirst.object(at: 3) as! String as AnyObject, forKey: "memberEmail")
   
    dictPersonalInfoArray .setValue("", forKey: "profilePic")
    dictPersonalInfoArray .setValue(muarrayValueFirst.object(at: 11) as! String as AnyObject, forKey: "clubDesignation")
   
    
    
    
    muarrayPersonalMemberDetails.add(dictPersonalInfoArray)
    print(dictPersonalInfoArray)
    
    print(varIsValidData)
    
    
    
    if(varIsValidData=="yes")
    {
        
        
        var varGetCurrentDateTime =  UserDefaults.standard.value(forKey: "session_lastUpdateDate")as! String
        if(varGetCurrentDateTime.characters.count>0)
        {
            varGetCurrentDateTime =  UserDefaults.standard.value(forKey: "session_lastUpdateDate")as! String
        }
        else
        {
            varGetCurrentDateTime =  functionForGetTodayDateTime()
        }
        
        let completeURL = baseUrl+touchBase_GetUpdateProfileDetails
        
        //get family member deleted id
        var varFamilyMemberDeletedId:String!=""
        
        for t in 00..<muarrayFamilyMemberDeletedIDThree.count
        {
            
            print(muarrayFamilyMemberDeletedIDThree)
            print(muarrayFamilyMemberDeletedIDThree.count)
            
            
            var varFamilyMemberDeletedIdTemp=muarrayFamilyMemberDeletedIDThree.object(at: t)as! String
            
            print(varFamilyMemberDeletedIdTemp)
            
            if(varFamilyMemberDeletedIdTemp.characters.count>0)
            {
                if(t==0)
                {
                    varFamilyMemberDeletedId=varFamilyMemberDeletedIdTemp
                    print(varFamilyMemberDeletedId)
                    
                }
                else
                {
                    if(varFamilyMemberDeletedId.characters.count>0)
                    {
                        varFamilyMemberDeletedId=varFamilyMemberDeletedId+","+varFamilyMemberDeletedIdTemp
                    }
                    else
                    {
                        varFamilyMemberDeletedId=varFamilyMemberDeletedIdTemp
                    }
                }
                print(varFamilyMemberDeletedId)
            }
            
            
        }
        print(varFamilyMemberDeletedId)
        
        print(varFamilyMemberDeletedId)
        
        
        // var varGetGroupId:String!=grpID as! String
        //  print(varGetGroupId)
        
        //  var varGetGroupId : Int! // This is not optional.
        // varGetGroupId = grpID as! Int
        // print(varGetGroupId) // "I am a programer
        //  print("Value is \(varGetGroupId ?? 0)")
        // "Value is 42"
        
        if(grpID.hasPrefix("Optional("))
        {
            let result3 = String(grpID.dropFirst(9))    // "he"
            print(result3)
            grpID = String(result3.dropLast(1)) as Any as! String   // "o"
            print("31313113133131131331313131311331133131313131",grpID)
        }
        
        print(grpID)
        print(profileId)
        let parameterst = [
            "dynamicFields" : [],
            "businessMemberDetails" : muarraybusinessMemberDetails,
            "personalMemberDetails": dictPersonalInfoArray,
            "grpID": grpID as AnyObject,
            "updatedOn": varGetCurrentDateTime,
            "profileID": profileId as AnyObject,
            "addressDetails":muarrayAddressDetails,
            "familyMemberDetail":muarrayFamilyDetails,
            "deletedFamilyMemberIds": varFamilyMemberDeletedId,
            ] as [String : Any]
        print(parameterst)
        print(completeURL)
        
        
        ///
        let bytes = try! JSONSerialization.data(withJSONObject: parameterst, options: JSONSerialization.WritingOptions.prettyPrinted)
        var jsonObj = try! JSONSerialization.jsonObject(with: bytes, options: .mutableLeaves)
        if let str = String(data: bytes, encoding: String.Encoding.utf8)
        {
            print("<<-----------------------------json start----------------------------->>")
            print(str)
            print("<<-----------------------------json end------------------------------->>")
       
   }
   else
   {
       print("not a valid UTF-8 sequence")
   }
   
   
   
   
   print(bytes)
   print(jsonObj)
   if(varIsValidData=="no")
   {
   }
   else
   {
       if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
       {
           butonOpacityTwo.isHidden=false
           labelLoading.isHidden=false
//           ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            
            
            
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: "http://rotaryindiaapi.rosteronwheels.com/api/member/UpdateProfileDetails", parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            
               //=> Handle server response
                print(response)
               var dd = response as! NSDictionary
              
               var varGetValueServerError = response.object(forKey: "serverError")as? String
               if(varGetValueServerError == "Error")
               {
                   self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                self.butonOpacityTwo.isHidden=true
                self.labelLoading.isHidden=true
                   SVProgressHUD.dismiss()
               }
               else
               {
               
               var varGetValueServerError = response.object(forKey: "serverError")as? String
               if(varGetValueServerError == "Error")
               {
                   //self.loaderClass.window=nil
                   self.butonOpacityTwo.isHidden=true
                   self.labelLoading.isHidden=true
                   self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
              
                SVProgressHUD.dismiss()
               }
               else
               {
                  
                   print("<<<<<<<<<<<<<<.......>>>>>>>>>>>>>>")
                   if let status:String=dd.object(forKey: "status") as? String
                   {
                       print("Status of updation is \(status)")
                   }
                   
                   if let status:String=dd.object(forKey: "status") as? String
                   {
                     if (status == "0" || status == "2")
                     {
                       UserDefaults.standard.setValue("yes", forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")
                        itshouldbeUpdatefromEditUpdate=1
                       //----------------------------------------------------------------------------------------
                       var databasePath : String
                       //  print(arrdata);
                       
                       let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                       let fileURL = documents.appendingPathComponent("NewTouchbase.db")
                       // open database
                       databasePath = fileURL.path
                       var db: OpaquePointer? = nil
                       if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
                           print("error opening database")
                       }else{
                       }
                       let contactDB = FMDatabase(path: databasePath as String)
                       if contactDB == nil {
                       }
                       
                       let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                       if (contactDB?.open())! {
                           
                           //if response come from server success thn delete family member detail from local as Android type 21 june 5.01pm
                           for i in 0 ..< self.muarrayFamilyMemberDeletedIDThree.count
                           {
                               var varFamilyMemberDeletedIdTemp=self.muarrayFamilyMemberDeletedIDThree.object(at: i)as! String
                               let insertSQL = "DELETE FROM  FamilyMemberDetail where familyMemberId='"+(varFamilyMemberDeletedIdTemp as! String)+"'"
                               print(insertSQL)
                               let result = contactDB?.executeStatements(insertSQL)
                               if (result == nil)
                               {
                                   print("ErrorAi: \(contactDB?.lastErrorMessage())")
                               }
                               else
                               {
                                   print("success saved")
                                   print(databasePath);
                               }
                           }
                           
                       }
                       
                       varGetCurrentDateTime=dd.object(forKey: "curDate")as! String
                       print(varGetCurrentDateTime)
                       UserDefaults.standard.setValue(dd.object(forKey: "curDate")as! String, forKey: "session_lastUpdateDate")
                       let alertController = UIAlertController(title: "Profile Update", message: "Profile updated successfully.", preferredStyle: .alert)
                       self.present(alertController, animated: true, completion: nil)
                       let delay = 2.0 * Double(NSEC_PER_SEC)
                       let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                       DispatchQueue.main.asyncAfter(deadline: time, execute: {
                           alertController.dismiss(animated: true, completion: nil)
                           if self.navigationController?.viewControllers != nil
                           {
                           if let viewControllers: [UIViewController] = self.navigationController?.viewControllers
                           {
                             self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
                           }
                           }
                       })
                       
                       self.butonOpacityTwo.isHidden=true
                       self.labelLoading.isHidden=true
                   }
                   else
                   {
                       self.butonOpacityTwo.isHidden=true
                       self.labelLoading.isHidden=true
                       print("Something went wrong, while updaing profile")
                       self.view.makeToast("Something went wrong, while updating profile", duration: 3, position: CSToastPositionBottom)
                       //self.view.makeToast("Something went wrong, while updaing profile", duration: 3, position: CSToastPositionCenter)
                        SVProgressHUD.dismiss()
                   }
                   }
               }
               SVProgressHUD.dismiss()
           }
           })
       }
       else
       {
           self.butonOpacityTwo.isHidden=true
           self.labelLoading.isHidden=true
           self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 3, position: CSToastPositionCenter)
            SVProgressHUD.dismiss()
       }
   }
                                }
                                else
                                {
                                    
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    func functionForGetTodayDateTime()->String
    {
        let date = Foundation.Date()
        print(date)
        // "Jul 23, 2014, 11:01 AM" <-- looks local without seconds. But:
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        let defaultTimeZoneStr = formatter.string(from: date)
        print(defaultTimeZoneStr)
        var varGetProperDateTime=defaultTimeZoneStr.components(separatedBy: " ")
        // "2014-07-23 11:01:35 -0700" <-- same date, local, but with seconds
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let utcTimeZoneStr = formatter.string(from: date)
        print(utcTimeZoneStr)
        print(varGetProperDateTime[0]+" "+varGetProperDateTime[1])
        return varGetProperDateTime[0]+" "+varGetProperDateTime[1]
    }
    func functionForSelectCountry(_ stringCountryName:String)->String
    {
        var letGetLastUpdateDate:String!=""
        ModelManager.getInstance()
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("select country_code from country_master where country_master_id='"+stringCountryName+"'", withArgumentsIn: nil)
        print("select country_code from country_master where country_master_id'"+stringCountryName+"'")
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
    
    
    
    func isValidEmail(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    //-----------242 4 24 4 234 324 23 423 4 234 35 35 34 534 53 53 45 35 34 53 45 345 34 345 345 345 345 34 53 45 345 345435
    //["address":address,"addressID":addressID,"addressType":addressType,"city":city,"country":country,"phoneNo":phoneNo,"pincode":pincode,"profileID":profileIds,"state":state]
    func DeleteAddressDetailsUseProfileID(_ AddressType:String)
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
        if (contactDB?.open())!
        {
            let insertSQLDelete = "DELETE FROM  AddressDetails  where profileID='"+profileId+"' and addressType='\(AddressType)'"
            print(insertSQLDelete)
            let resultt = contactDB?.executeStatements(insertSQLDelete)
            if (resultt == nil)
            {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            }
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        contactDB?.close()
        
        
        
        //masterUID, groupId , moduleId , profileID , MemberDesignation , memberName , pic , membermobile From Board_Of_Directors_List
        
    }
    
    @IBAction func buttonRemoveRelationShipClickEvent(_ sender: AnyObject)
    {
        print("Delete relation button clicked !!")
        
        print(varWhichButtonSelectForCountryNameorCode)
        print(varPublicSelectedRowIndex)
        //if(varWhichButtonSelectForCountryNameorCode=="Birthday" || varWhichButtonSelectForCountryNameorCode=="Anniversary")
        // {
        muarrayRelationshipThree.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "")
        //}
        
        
        
        buttonOpacity.isHidden=true
        viewRelationship.isHidden=true
        tableviewEditUpdateProfile.reloadData()
    }
    
    @IBAction func buttonRemoveCountryClickEvent(_ sender: AnyObject)
    {
        print("country delete button clicked")
        
        functionForHiddenAll()
        
        print(stringCountryMasterId)
        print(stringCountryMasterCode)
        print(stringCountryMasterName)
        
        print(varWhichButtonSelectForCountryNameorCode)
        
        
        
        if(varWhichButtonSelectForCountryNameorCode=="firstCountryCode")
        {
            muarrayCountryCodeFirst.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "")
            muarrayCountryTextFirst.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "")
            muarrayCountryIdFirst.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "0")
        }
        else  if(varWhichButtonSelectForCountryNameorCode=="secondCountryName")
        {
            muarrayCountryTextSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "")
            muarrayCountryCodeSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "")
            muarrayCountryIdSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "0")
            //muarrayCountryCodeSecond
            muarrayBusinessContactCountryTextSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "")
            muarrayBusinessContactCountryCodeSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "")
            muarrayBusinessContactCountryIdSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "0")
            
        }
        else if(varWhichButtonSelectForCountryNameorCode=="secondCountryCode")
        {
            muarrayBusinessContactCountryTextSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "")
            muarrayBusinessContactCountryCodeSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "")
            muarrayBusinessContactCountryIdSecond.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "0")
        }
        else if(varWhichButtonSelectForCountryNameorCode=="threefamilyCountryCode")
        {
            muarrayCountryTextThree.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "")
            muarrayCountryCodeThree.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "")
            muarrayCountryIdThree.replaceObject(at: Int(varPublicSelectedRowIndex)!, with: "0")
        }
        
        print("Index:--")
        print(varPublicSelectedRowIndex)
        tableviewEditUpdateProfile.reloadData()
    }
    
    
    
}
