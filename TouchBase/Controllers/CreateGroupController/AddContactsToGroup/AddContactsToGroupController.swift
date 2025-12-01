//
//  AddContactsToGroupController.swift
//  TouchBase
//
//  Created by Kaizan on 03/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI

class AddContactsToGroupController: UIViewController,UITextFieldDelegate , UITableViewDataSource, UITableViewDelegate {
    var phoneNumberStr : String!
    let bounds = UIScreen.main.bounds
    let searchTextField = UITextField()
    // Define bounds
    @IBOutlet var contactsTableView: UITableView!
    
    var SelectedNameArray:NSMutableArray!
    var SelectedNumberArray:NSMutableArray!
    var SelectedIndexArray:NSMutableArray!

    @IBOutlet weak var buttonAdd: UIButton!
    var nameTitles : NSMutableArray!
    var mobileTitles : NSMutableArray!
    
    var EditCondition : Bool = false
    
    var is_searching = false   // It's flag for searching
    
    var searchingNameArray:NSMutableArray!
    var searchingNumberArray:NSMutableArray! // Its data searching array that need for search
    var searchingIndexArray : NSMutableArray!
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let lbel = UILabel()
        lbel.frame = CGRect(x: 0, y: self.buttonAdd.frame.size.height-52, width: self.view.frame.size.width, height: 1)
        lbel.backgroundColor =  UIColor.lightGray
        buttonAdd.addSubview(lbel)
        self.createNavigationBar()
       
        if EditCondition == false
        {
            nameTitles = NSMutableArray()
            mobileTitles = NSMutableArray()
            
            SelectedNameArray = NSMutableArray()
            SelectedNumberArray = NSMutableArray()
            SelectedIndexArray = NSMutableArray()
            
            searchingNameArray = []
            searchingNumberArray = []
            searchingIndexArray = []
            
         //   searchTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControl.Event.EditingChanged)
            
            
            let status = ABAddressBookGetAuthorizationStatus()
            if status == .denied || status == .restricted {
                print("Not authorized: Go to settings and authorize this app")
                return
            }
            
            var error: Unmanaged<CFError>?
            let addressBook: ABAddressBook? = ABAddressBookCreateWithOptions(nil, &error)?.takeRetainedValue()
            if addressBook == nil {
                print(error?.takeRetainedValue())
                return
            }
            
            ABAddressBookRequestAccessWithCompletion(addressBook) { granted, error in
                if !granted {
                    print("Not authorized: Go to settings and authorize this app: \(error)")
                    return
                }
                
                
                let allContacts : NSArray = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
                print(String(format:"All ContactsCount =%d",allContacts.count))
                /* myy code
                for contactRef:ABRecord in allContacts { // first name if
                    
                   
                    
                    let unmanagedPhones = ABRecordCopyValue(contactRef, kABPersonPhoneProperty)
                    let phones: ABMultiValueRef =
                    Unmanaged.fromOpaque(unmanagedPhones.toOpaque()).takeRetainedValue()
                        as NSObject as ABMultiValueRef
                    
                    let countOfPhones = ABMultiValueGetCount(phones)
                    
                    print(countOfPhones)
                    
                    if countOfPhones == 0
                    {
                        
                    }
                    else
                    {
                        
                        
                        if let first = ABRecordCopyValue(contactRef, kABPersonFirstNameProperty)?.takeRetainedValue() as? String {
                            // use `first` here
                            
                          //  print(String(format:"firstName=%@",first))
                            
                            
                            if let last  = ABRecordCopyValue(contactRef, kABPersonLastNameProperty)?.takeRetainedValue() as? String
                            {
                                let CompleteName = String(format:"%@ %@",first,last) as String
                                // print(String(format:"completeName=%@",CompleteName))
                                self.nameTitles.add(CompleteName)
                            }
                            else
                            {
                                self.nameTitles.add(first)
                            }
                            
                        }
                            
                            
                        else
                        {
                            if let last  = ABRecordCopyValue(contactRef, kABPersonLastNameProperty)?.takeRetainedValue() as? String
                            {
                               // print(String(format:"LastName=%@",last))
                                self.nameTitles.add(last)
                            }
                            else
                            {
                                let CompleteName = String(format:"%@","Unknown") as String
                              //  print(String(format:"No Name=%@",CompleteName))
                                self.nameTitles.add(CompleteName)
                            }
                        }
                        

                        
                        for index in 0..<1{
                            let unmanagedPhone = ABMultiValueCopyValueAtIndex(phones, index)
                            
                            if let phone11  = Unmanaged.fromOpaque(
                                unmanagedPhone.toOpaque()).takeRetainedValue() as NSObject as? String
                            {
                                print(phone11)
                                
                                var phoneNumberst = phone11//.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                                phoneNumberst = phoneNumberst.replacingOccurrences(of: ")", with: "")
                                phoneNumberst = phoneNumberst.replacingOccurrences(of: "-", with: "")
                                phoneNumberst = phoneNumberst.replacingOccurrences(of: "(", with: "")
                               // phoneNumberst = phoneNumberst.stringByReplacingOccurrencesOfString(" ", withString: "")
                                
                                
                                
                                let firstChar = String(phoneNumberst.characters.prefix(1))
                                
                                print(firstChar)
                                
                             //   var completeNUmberArr = NSArray()
                                var mainNumber : String!
                                let cmpltNumber : String!
                                
                                if firstChar == "+"
                                {
                                    let numberArr = phoneNumberst.components(separatedBy: " ")
                                    
                                    
                                    print(numberArr.count)
                                    print(numberArr)
                                    
                                    if numberArr.count == 3
                                    {
                                        mainNumber = String(format:"%@%@",numberArr[1],numberArr[2])
                                    }
                                    else if numberArr.count == 2
                                    {
                                        mainNumber = numberArr[1]
                                    }
                                    else
                                    {
                                        mainNumber = ""
                                    }
                                    
                                     cmpltNumber = String(format:"%@ %@",numberArr[0],mainNumber)
                                    
                                    print(cmpltNumber)
                                    
                                }
                                else
                                {
                                    let numberArr = phoneNumberst.characters.split{$0 == " "}.map(String.init)
                                    
                                    if numberArr.count == 3
                                    {
                                        mainNumber = String(format:"%@%@",numberArr[1],numberArr[2])
                                    }
                                    else if numberArr.count == 2
                                    {
                                        mainNumber = numberArr[1]
                                    }
                                    else
                                    {
                                        mainNumber = ""
                                    }
                                    
                                     cmpltNumber = String(format:"%@ %@",numberArr[0],mainNumber)
                                    
                                    print(cmpltNumber)
                                }
                                
                                
                                
                                
                                
                                
                                self.mobileTitles.add(cmpltNumber)
                                
                                
                            }
                            //                      self.phoneNumberStr = Unmanaged.fromOpaque(
                            //                          unmanagedPhone.toOpaque()).takeRetainedValue() as NSObject as! String
                            
                        }
                        
                        print(self.nameTitles.count)
                        print(self.mobileTitles.count)
                        
                        self.contactsTableView.reloadData()
                    }
                    
                }
                */
            }
        }
        
        else
        {
             // Edit
        }
        
    }
    
    func createNavigationBar(){
       
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        if EditCondition == false
        {
            self.title="Create Entity"
        }
        else
        {
            self.title="Edit Members"
        }
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AddContactsToGroupController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if is_searching
        {
            return searchingNameArray.count
            
        }else
        {
            if EditCondition == false
            {
                return nameTitles.count
            }
            else
            {
                return SelectedNameArray.count
            }
            //return nameTitles.count //Currently Giving default Value
        }
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
        searchTextField.placeholder = ""
        searchTextField.textColor = UIColor.black
        searchTextField.font = UIFont(name: "Roboto-Regular", size: 18) 
        searchTextField.backgroundColor = UIColor.clear
        searchTextField.isUserInteractionEnabled = true
        searchTextField.borderStyle = UITextField.BorderStyle.none
        searchTextField.delegate=self
        
        headerView.addSubview(searchTextField)
        headerView.bringSubviewToFront( searchTextField)
        
        return headerView
    }
    
    
//    func textFieldDidChange(textField: UITextField)
//    {
//        if textField.text!.isEmpty
//        {
//            is_searching = false
//            contactsTableView.reloadData()
//        }
//    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
//        if textField.text == ""
//        {
//            
//        }
//        else
//        {
     //   print(SelectedIndexArray)
     //   SelectedIndexArray.removeAllObjects()
     //   print(SelectedIndexArray)
           is_searching = false
            textField.text = ""
            contactsTableView.reloadData()
      //  }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        if textField.text!.isEmpty
        {
            is_searching = false
            contactsTableView.reloadData()
        }
        else
        {
            
            
            if EditCondition == false
            {
                print(" search text %@ %d",textField.text! as NSString , nameTitles.count)
                is_searching = true
                searchingNameArray.removeAllObjects()
                searchingNumberArray.removeAllObjects()
                for index in 0 ..< nameTitles.count
                {
                    
                    
                    var currentString = String()
                    currentString = (nameTitles.object(at: index) as? String)!
                    
                    var currentString1 = String()
                    currentString1 = (mobileTitles.object(at: index) as? String)!
                    
                    
                    
                    if currentString.lowercased().range(of: textField.text!.lowercased())  != nil
                    {
                        searchingNameArray.add(currentString)
                        searchingNumberArray.add(currentString1)
                    }
                }
                contactsTableView.reloadData()
            }

            else
            {
                print(" search text %@ %d",textField.text! as NSString , SelectedNameArray.count)
                is_searching = true
                searchingNameArray.removeAllObjects()
                searchingNumberArray.removeAllObjects()
                searchingIndexArray.removeAllObjects()
                for index in 0 ..< SelectedNameArray.count
                {
                    
                    var currentString = String()
                    currentString = (SelectedNameArray.object(at: index) as? String)!
                    
                    var currentString1 = String()
                    currentString1 = (SelectedNumberArray.object(at: index) as? String)!
                    
 //                   print(SelectedIndexArray)
                    var indexSTR = String()
                    
                    
                    if currentString.lowercased().range(of: textField.text!.lowercased())  != nil
                    {
                        searchingNameArray.add(currentString)
                        searchingNumberArray.add(currentString1)
                        
                        if SelectedIndexArray.count == 0
                        {
                            
                        }
                        else
                        {
                            
                            indexSTR = (SelectedIndexArray.object(at: index) as? String)!
                            searchingIndexArray.add(indexSTR)
                        }

                        
                    }
                }
                print(searchingIndexArray)
                contactsTableView.reloadData()
            }
        
        }
        
        
        print(SelectedIndexArray)
        searchTextField.resignFirstResponder()
        
        return true
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool{
//        
//        return true
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath) as! ContactsCell
        
        
        if is_searching == true
        {
            
            if EditCondition == false
            {
                cell.contactNameLabel.text = self.searchingNameArray[indexPath.row] as? String
                cell.contactNumberLabel.text = self.searchingNumberArray[indexPath.row] as? String
                
                if(self.SelectedNumberArray.count>0){
                    if   (self.SelectedNumberArray.contains(cell.contactNumberLabel.text!)){
                        print("yes it exists")
                        cell.chkBTn .setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                    }else{
                        
                        cell.chkBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                        print("no")
                    }
                }
            }
            else
            {
                
                cell.contactNameLabel.text = self.searchingNameArray[indexPath.row] as? String
                cell.contactNumberLabel.text = self.searchingNumberArray[indexPath.row] as? String
                
                cell.chkBTn.setImage(UIImage(named: "green_edit"),  for: UIControl.State.normal)
                cell.chkBTn.addTarget(self, action: #selector(AddContactsToGroupController.editAction(_:)), for: UIControl.Event.touchUpInside)
                cell.chkBTn.tag = indexPath.row
            }
            

            
        }
        else
        {
            
            if EditCondition == false
            {
                
                cell.contactNameLabel.text = self.nameTitles[indexPath.row] as? String
                cell.contactNumberLabel.text = self.mobileTitles[indexPath.row] as? String
                
                
                print(self.nameTitles[indexPath.row])
                 print(self.mobileTitles[indexPath.row])
                
                if(self.SelectedNumberArray.count>0){
                    if   (self.SelectedNumberArray.contains(cell.contactNumberLabel.text!)){
                        print("yes it exists")
                        cell.chkBTn .setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                    }else{
                        
                        cell.chkBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                        print("no")
                    }
                }


            }
            else
            {
                
//                var mainArray = NSArray()
//                if let i = SelectedNameArray.indexOf("Jason") {
//                    print("Jason is at index \(i)")
//                } else {
//                    print("Jason isn't in the array")
//                }

                
                cell.contactNameLabel.text = self.SelectedNameArray[indexPath.row] as? String
                cell.contactNumberLabel.text = self.SelectedNumberArray[indexPath.row] as? String
                
                cell.chkBTn.setImage(UIImage(named: "green_edit"),  for: UIControl.State.normal)
                cell.chkBTn.addTarget(self, action: #selector(AddContactsToGroupController.editAction(_:)), for: UIControl.Event.touchUpInside)
                cell.chkBTn.tag = indexPath.row
            }
        }

        
        return cell
    }
    
    
    @IBAction func editAction(_ sender: AnyObject)
    {
        
        if is_searching == true
        {
            
            
//            let foundIndex = SelectedNameArray.indexOfObject("Hank Zakroff")
//            if foundIndex != NSNotFound {
//                // do something with the found index...
//                
//                print(foundIndex)
//                
//            }

            
            searchTextField.text = ""
            is_searching = false
            searchTextField.resignFirstResponder()
            contactsTableView.reloadData()
            
            let EditVC = self.storyboard!.instantiateViewController(withIdentifier: "edit_contact_view") as! EditContactViewController
            EditVC.ContactName =  (self.searchingNameArray[sender.tag] as? String)!  //nameTitles[indexPath.row]
            EditVC.ContactNumber =  (self.searchingNumberArray[sender.tag] as? String)!   //mobileTitles[indexPath.row]
            
            let index : Int? = Int(searchingIndexArray[sender.tag] as! String)
            
            print(index)
            
            EditVC.tagIndex = index!
            self.navigationController?.pushViewController(EditVC, animated: true)
            
        }else
        {
            let EditVC = self.storyboard!.instantiateViewController(withIdentifier: "edit_contact_view") as! EditContactViewController
            EditVC.ContactName =  (self.SelectedNameArray[sender.tag] as? String)!  //nameTitles[indexPath.row]
            EditVC.ContactNumber =  (self.SelectedNumberArray[sender.tag] as? String)!   //mobileTitles[indexPath.row]
            EditVC.tagIndex = sender.tag
            self.navigationController?.pushViewController(EditVC, animated: true)
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if EditCondition == true
        {
            let NaMe : NSArray = UserDefaults.standard.array(forKey: "EditcontactNameForGroup")! as NSArray
            let MobileNum : NSArray = UserDefaults.standard.array(forKey: "EditcontactNumberForGroup")! as NSArray
            print(NaMe)
            print(MobileNum)
            
            SelectedNameArray = NaMe.mutableCopy()as! NSMutableArray
            SelectedNumberArray = MobileNum.mutableCopy()as! NSMutableArray
            
            contactsTableView.reloadData()
        }
        
      
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if EditCondition == false
        {
            let cell : ContactsCell = tableView.cellForRow(at: indexPath) as! ContactsCell
            
            if cell.chkBTn.currentImage!.isEqual(UIImage(named: "CHECK_BLUE_ROW")) {
                //do something here
                cell.chkBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                print("inside if")
                
                SelectedNameArray.remove(nameTitles.object(at: indexPath.row))
                SelectedNumberArray.remove(mobileTitles.object(at: indexPath.row))
              //  SelectedIndexArray.removeObject(String(format:"%d",indexPath.row))
                print(SelectedNameArray)
                print(SelectedNumberArray)
               // print(SelectedIndexArray)
                
            }
            else
            {
                
                if is_searching == false
                {
                    SelectedNameArray.add(nameTitles.object(at: indexPath.row))
                    SelectedNumberArray.add(mobileTitles.object(at: indexPath.row))
                  //  SelectedIndexArray.addObject((String(format:"%d",indexPath.row)))
                    print(SelectedNameArray)
                    print(SelectedNumberArray)
                 //   print(SelectedIndexArray)
                 //   print(String(format:"adding index=%d",indexPath.row))
                    cell.chkBTn .setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                    print("inside else")
                }
                else
                {
                    SelectedNameArray.add(searchingNameArray.object(at: indexPath.row))
                    SelectedNumberArray.add(searchingNumberArray.object(at: indexPath.row))
                  //  SelectedIndexArray.addObject((String(format:"%d",indexPath.row)))
                    print(SelectedNameArray)
                    print(SelectedNumberArray)
                 //   print(SelectedIndexArray)
                 //   print(String(format:"adding with search index=%d",indexPath.row))
                    cell.chkBTn .setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                    print("inside else")
                    
                    
                }
                
            }
            
        }
        else
        {
        }
        
    }
    
    
    @IBAction func AddContactsToGroupsAction(_ sender: AnyObject)
    {
        
        searchTextField.text = ""
        searchTextField.resignFirstResponder()
        is_searching = false
     //   contactsTableView.reloadData()
        
        if EditCondition == true
        {
            if SelectedNameArray.count == 0
            {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Rotary India"
                alertView.message = "Please select members"
                alertView.delegate = self
                alertView.addButton(withTitle: "Okay")
                alertView.show()
            }
            else
            {
                UserDefaults.standard.set(SelectedNameArray, forKey: "contactNameForGroup")
                UserDefaults.standard.set(SelectedNumberArray, forKey: "contactNumberForGroup")
                self.navigationController?.popViewController(animated: true)
            }
        }
        else
        {
            
            if SelectedNameArray.count == 0
            {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Rotary India"
                alertView.message = "Please select members"
                alertView.delegate = self
                alertView.addButton(withTitle: "Okay")
                alertView.show()
            }
            else
            {
                EditCondition = true
                self.title="Edit Members"
                
                UserDefaults.standard.set(SelectedNameArray, forKey: "EditcontactNameForGroup")
                UserDefaults.standard.set(SelectedNumberArray, forKey: "EditcontactNumberForGroup")
                
                for i in 0  ..< SelectedNameArray.count 
                {
                    SelectedIndexArray.add(String(format:"%d",i))
                    print(String(format:"Selected === >>>> %@",SelectedIndexArray))
                }
                
                contactsTableView.reloadData()
            }
        }
    }
}


