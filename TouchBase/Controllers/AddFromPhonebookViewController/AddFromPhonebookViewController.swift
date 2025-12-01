//
//  AddFromPhonebookViewController.swift
//  TouchBase
//
//  Created by Umesh on 25/08/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI
import Contacts
import ContactsUI
import CoreTelephony


class AddFromPhonebookViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate
{
    
    //
    var grpIDForPhoneBook: NSString!
    ////
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var noRecordsLbl: UILabel!
    var selectedIndexPathForCheckMark = IndexPath()
    var checked = [Bool]()
    
    let searchTextField = UITextField()
    var addressBook: ABAddressBook?
    var emptyDictionary: CFDictionary?
    
    var contactList : NSArray?
    var contactNames : NSMutableArray = NSMutableArray()
    var addedContactNames : NSMutableArray = NSMutableArray()
    var numbersArray : NSMutableArray = NSMutableArray()
    var countryCodeArray : NSMutableArray = NSMutableArray()

    
    //
     var concateArrays : NSMutableArray = NSMutableArray()
    //var concateArrays : NSMutableDictionary = NSMutableDictionary()
    var myFirstDictionary:[String :String] = [:]
    var dictNames : NSDictionary?
    var dictNumbers : NSDictionary?
      var qqq : NSArray!
    
    
    var pqr : NSMutableArray = NSMutableArray()
    var xyz : NSMutableArray = NSMutableArray()
    
    
    var searchActive : Bool = false
    
    //searchBar sadi
    var mainArray : NSArray!
    var mainArray1 : NSArray!
    var abc : NSMutableArray = NSMutableArray()
    
    var selectedIndexPaths = NSMutableSet()
    
    
    
    
    
    @IBOutlet var addContactBtn: UIButton!
    @IBAction func addContactBtnAction(_ sender: AnyObject)
    {
        //ganesh
        let addFromPhonebook = self.storyboard!.instantiateViewController(withIdentifier: "contactInfo") as! contactInfoViewController
        
        
        addFromPhonebook.grpIDForcontactDetails = grpIDForPhoneBook as String as String as NSString
        
        addFromPhonebook.contactDetailInfo = concateArrays
        addFromPhonebook.selectedPersonDeatil = addedContactNames
        
        
        addFromPhonebook.contactPersonPhoneDetail = numbersArray
        addFromPhonebook.countryCodeDetail = pqr

        self.navigationController?.pushViewController(addFromPhonebook, animated: true)
        
        print("addedContactNames",addedContactNames)
        
    }
    
    
    @IBOutlet var addFromPhonebookTblView: UITableView!
    // @IBOutlet var contactLbl: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // make sure user hadn't previously denied access
       
       // grpIDForPhoneBook
        
        
        
        self.searchDisplayController
        
        switch ABAddressBookGetAuthorizationStatus(){
        case .authorized:
            print("Already authorized")
            // createAddressBook()
            self.getContactNames()
            addFromPhonebookTblView.reloadData()
            
        case .denied:
            print("Denied access to address book")
            
        case .notDetermined:
            createAddressBook()
            if let theBook: ABAddressBook = addressBook{
                ABAddressBookRequestAccessWithCompletion(theBook,
                                                         {(granted: Bool, error: CFError!) in
                                                            
                                                            if granted{
                                                                print("Access granted")
                                                            } else {
                                                                print("Access not granted")
                                                            }
                                                            
                })
            }
            
        case .restricted:
            print("Access restricted")
            
        default:
            print("Other Problem")
        }
        // Do any additional setup after loading the view.
        
    }
    func getContactNames()
    {
      
        var contactName = NSString()
        var allNumbers: [AnyObject] = []
        let adbk : ABAddressBook? = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
        let people = ABAddressBookCopyArrayOfAllPeople(adbk).takeRetainedValue() as NSArray as [ABRecord]
        for person in people {
            let phones: ABMultiValue = ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue()
            for j in 0..<ABMultiValueGetCount(phones) {
                let phone: String = ABMultiValueCopyValueAtIndex(phones, j).takeRetainedValue() as! String
                let phoneNumber = phone
              //  let allowedCharactersSet = NSMutableCharacterSet.decimalDigitCharacterSet()
             //   allowedCharactersSet.addCharactersInString("+")
                //let condensedPhoneNumber = phoneNumber.componentsSeparatedByCharactersInSet(allowedCharactersSet.invertedSet).joinWithSeparator("")
                if phoneNumber.contains("+")
                {
                    let sentence = phoneNumber
                    
                    let abc = sentence.components(separatedBy: .punctuationCharacters).joined(separator: "").components(separatedBy: " ").filter{!$0.isEmpty}
                    print(abc)
                    
                    let fullName = abc[0]
                    let fullName1 = abc[1]
                    let pqr = fullName
                    let xyz = fullName1
                    countryCodeArray.add(pqr)
                    numbersArray.add(xyz)

                    
                }
                else
                {
                    var pqr = phoneNumber
                    if (pqr.contains("+"))
                    {
                        pqr = ""
                    }
                    else
                    {
                        pqr = phoneNumber
                    }
                    countryCodeArray.add("")
                    numbersArray.add(pqr)
                    
                   
                }
                 
            }
        }
        // print("allNumbers \(allNumbers)")
        //    contactNames.addObject(allNumbers)
        
        var errorRef: Unmanaged<CFError>?
        addressBook = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
        let contactList: NSArray = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
        print("records in the array \(contactList.count)")
        
        //  contactNames.removeAllObjects()
        
        //myy code
//        for record:ABRecord in contactList
//        {
//            let contactPerson: ABRecordRef = record
//            let contactName: String = ABRecordCopyCompositeName(contactPerson).takeRetainedValue() as NSString as String
//            print ("contactName \(contactName)")
//
//
//
//            contactNames.add(contactName)
//
//        }
//
        for i in 0 ..< contactNames.count
        {
             var myDictionary = [AnyHashable: Any]()
            //userName
            //mobile,countryId,totalMember
            myDictionary["userName"] = contactNames[i]
            myDictionary["mobile"] = numbersArray[i]
            myDictionary["countryId"] = countryCodeArray[i]
            myDictionary["groupId"] = ""
            myDictionary["masterID"] = ""
            myDictionary["memberEmail"] = ""
            myDictionary["totalMember"] = ""

            
            concateArrays.add(myDictionary)
        }
        
   //  countryCodeArray
       
        print("concateArrays \(concateArrays)")
        print("++++ \(contactNames)")
        print("**** \(numbersArray)")
       
        
    }
    func extractABAddressBookRef(_ abRef: Unmanaged<ABAddressBook>!) -> ABAddressBook? {
        if let ab = abRef {
            return Unmanaged<NSObject>.fromOpaque(ab.toOpaque()).takeUnretainedValue()
        }
        return nil
    }
    
    
    
    func createAddressBook()
    {
        
        var error: Unmanaged<CFError>?
        addressBook = ABAddressBookCreateWithOptions(nil, &error).takeRetainedValue()
        print((addressBook))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {

        if(searchActive)
        {
            return mainArray.count;
        }
        return concateArrays.count;
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let cell = addFromPhonebookTblView.dequeueReusableCellWithIdentifier("add_contact") as! contactListCell
       // dictNames?.setValue(contactNames, forKey: "userName")
        
        

        let cell = addFromPhonebookTblView.dequeueReusableCell(withIdentifier: "add_contact", for: indexPath) as! contactListCell
//myy code
      
//        if(searchActive)
//        {
//
//            cell.phoneNoLbl.text = mainArray[indexPath.row]["mobile"] as? String
//            cell.contactLbl.text = mainArray[indexPath.row]["userName"] as? String
//            cell.codeForCountryLbl.text = mainArray[indexPath.row]["countryId"] as? String
//
//
//
//        }
//        else
//        {
//            cell.contactLbl.text = concateArrays[indexPath.row]["userName"] as? String
//            cell.phoneNoLbl.text = concateArrays[indexPath.row]["mobile"] as? String
//            cell.codeForCountryLbl.text = concateArrays[indexPath.row]["countryId"] as? String
//
//
//        }

        
        cell.checkMarkBtn.tag = indexPath.row
        
//         print("indexPath.row \(indexPath.row)")
//        print("cell.checkMarkBtn.tag \(cell.checkMarkBtn.tag)")
        
        // cell.checkMarkBtn.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
      //  print("cell.checkMarkBtn.currentImage \(cell.checkMarkBtn.currentImage)")
        
        if addedContactNames.contains(concateArrays[indexPath.row]) {
            
            cell.checkMarkBtn .setImage(UIImage(named: "ck_Box@1x"),  for: UIControl.State.normal)
            
        }
        else {
            
            cell.checkMarkBtn .setImage(UIImage(named: "box@1x"),  for: UIControl.State.normal)
            
        }
        configure(cell, forRowAtIndexPath: indexPath)
        
        return cell;
    }
    func configure(_ cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
       
        if selectedIndexPaths.contains(indexPath)
        {
            // selected
            //cell.backgroundColor = UIColor.redColor()
        }
        else
        {
            // not selected
            cell.backgroundColor = UIColor.white
        }
    }
    
    
    
    func buttonClicked(_ sender:UIButton)
    {
        // let cell = addFromPhonebookTblView.dequeueReusableCellWithIdentifier("add_contact") as! contactListCell
       
        
        let buttonRow = sender.tag
        
        let cell = addFromPhonebookTblView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! contactListCell
        
        if cell.checkMarkBtn.currentImage!.isEqual(UIImage(named: "box@1x"))
        {
            //do something here
            
            cell.checkMarkBtn .setImage(UIImage(named: "ck_Box@1x"),  for: UIControl.State.normal)
            print("inside if")
            
            addedContactNames.add(contactNames[sender.tag])
            
            
        }
        else
        {
            cell.checkMarkBtn.setImage(UIImage(named: "box@1x"),  for: UIControl.State.normal)
            
            addedContactNames.remove(contactNames[sender.tag])
            
            print("outside if")
            
        }
        addFromPhonebookTblView .reloadData();
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
     
        
        let cell : contactListCell = addFromPhonebookTblView.cellForRow(at: indexPath) as! contactListCell
        
        if cell.checkMarkBtn.currentImage!.isEqual(UIImage(named: "box@1x"))
        {
            //do something here
            cell.checkMarkBtn .setImage(UIImage(named: "ck_Box@1x"),  for: UIControl.State.normal)
            
            addedContactNames.add(concateArrays[indexPath.row])
            print("++++ \(contactNames)")
            print("&&& \(addedContactNames)")
            print("inside if")
            
        }else
        {
            
            cell.checkMarkBtn .setImage(UIImage(named: "box@1x"),  for: UIControl.State.normal)
            
            addedContactNames.remove(concateArrays[indexPath.row])
            print("++++ \(contactNames)")
            print("&&& \(addedContactNames)")
            print("inside else")
        }
        addFromPhonebookTblView .reloadData();
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
        }
        
        
        selectedIndexPathForCheckMark = indexPath
        if selectedIndexPaths.contains(indexPath)
        {
            // deselect
            selectedIndexPaths.remove(indexPath)
        }
        else
        {
            // select
            selectedIndexPaths.add(indexPath)
            print(";;;;;;; \(selectedIndexPaths)")
        }
     
        configure(cell, forRowAtIndexPath: indexPath)
        
        
        print("selectedIndexPathForCheckMark \(selectedIndexPathForCheckMark)")
        
        
        //       let cell = addFromPhonebookTblView.dequeueReusableCellWithIdentifier("add_contact") as! contactListCell
        //        // cross checking for checked rows
        
    }
    
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width+5, height: 60)
        headerView.backgroundColor = UIColor.white
        
        
        let headerImageView = UIImageView()
        headerImageView.frame = CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: 60)
        headerImageView.image = UIImage(named: "heder2")
        headerView.addSubview(headerImageView)
        
        let textImageView = UIImageView()
        textImageView.frame = CGRect(x: 30, y: 10, width: self.view.frame.size.width-60, height: 35)
        textImageView.image = UIImage(named: "textfield")
        textImageView.isUserInteractionEnabled = true
        headerImageView.addSubview(textImageView)
        
        
        searchTextField.frame = CGRect(x: 35, y: 12, width: self.view.frame.size.width-60, height: 35)
        searchTextField.placeholder = "Search from Phonebook"
        searchTextField.textColor = UIColor.black
        searchTextField.font = UIFont(name: "Roboto-Regular", size: 18)
        searchTextField.backgroundColor = UIColor.clear
        searchTextField.isUserInteractionEnabled = true
        searchTextField.borderStyle = UITextField.BorderStyle.none
        searchTextField.delegate=self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
        headerView.addSubview(searchTextField)
        headerView.bringSubviewToFront( searchTextField)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 60
    }

    func textFieldDidBeginEditing(_ textField: UITextField)
    {
       searchActive = true;
        addFromPhonebookTblView.reloadData()
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        searchActive = false;
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        searchTextField.resignFirstResponder()
        
        return true
    }
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        if(textField.text!==""){
            mainArray = concateArrays .mutableCopy() as! NSMutableArray
            if(mainArray.count == 0) {
                //directoryTableView.hidden = true;
            }
            else {
                
                // memberTableView.hidden = false;
                
            }
            searchTextField.text="";
            searchTextField.resignFirstResponder()
            noRecordsLbl.isHidden = true
            addFromPhonebookTblView.reloadData()
        }else
        {
            
             mainArray=[]
            
//
//            let results = concateArrays.filter({ person in
//                if let firstname = person["userName"] as? String, let mobileNo = person["mobile"] as? String,let countryCode = person["countryId"] as? String, let query = searchTextField.text {
//                    return firstname.range(of: query, options: [.caseInsensitive, .diacriticInsensitive]) != nil || mobileNo.range(of: query, options: [.caseInsensitive, .diacriticInsensitive]) != nil || countryCode.range(of: query, options: [.caseInsensitive, .diacriticInsensitive]) != nil
//                }
//                return false
//            })
            //mainArray = NSMutableArray(array: results)
          //  print(mainArray)
            
            
//             let predicate = NSPredicate(format: "SELF CONTAINS %@", searchTextField.text!)
//            mainArray = concateArrays.filteredArrayUsingPredicate(predicate)
//            
//            print(mainArray)
           

            if (mainArray.count==0)
            {
                searchActive = true;
                print(noRecordsLbl.text)
                noRecordsLbl.isHidden = false
               // addFromPhonebookTblView.hidden = true
                addFromPhonebookTblView.reloadData()
            }
            else
            {
                searchActive = true;
                noRecordsLbl.isHidden = true
               // addFromPhonebookTblView.hidden = false

                addFromPhonebookTblView.reloadData()
            }
        }
        
    }
    
 
 
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        
        self.createNavigationBar()
    }
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "Add From Phonebook"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AddFromPhonebookViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
 
    

}
