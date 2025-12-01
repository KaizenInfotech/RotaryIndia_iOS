//
//  contactInfoViewController.swift
//  TouchBase
//
//  Created by Umesh on 30/08/16.
//  Copyright © 2016 Parag. All rights reserved.
//
//userName
//mobile,countryId,totalMember
import UIKit
import CoreData

class contactInfoViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,webServiceDelegate
{
    var grpIDForcontactDetails: NSString!
    var grpDetail:GroupResult!
    var groupMasterInfoDetail : NSMutableArray = NSMutableArray()

     var strGroupIDs : String = ""
    // var mineSpillere2 = [NSMutableArray]()
     var contactDetailInfo : NSMutableArray = NSMutableArray()
    var selectedPersonDeatil : NSMutableArray = NSMutableArray()
    
    
    var contactPersonPhoneDetail : NSMutableArray = NSMutableArray()
    var countryCodeDetail : NSMutableArray = NSMutableArray()
     var selectedIndexPathForCheckMark = IndexPath()
    
    //
    var people = [NSManagedObject]()
    
   //for edit
    @IBOutlet var editContactView: UIView!
    @IBOutlet var nameTxtField: UITextField!
    @IBOutlet var mobileNumberTxtField: UITextField!
    @IBOutlet var countryCodeTxtField: UITextField!
    @IBOutlet var countryBtn: UIButton!
    
    @IBOutlet var exitViewBtn: UIButton!
    @IBAction func exitViewBtnAction(_ sender: AnyObject)
    {
        editContactView.isHidden = true
    }
    @IBAction func countryBtnAction(_ sender: AnyObject)
    {
        let countrySelect = self.storyboard!.instantiateViewController(withIdentifier: "countryCodeSelect") as! CountryCodeSelectionViewController
        self.navigationController?.pushViewController(countrySelect, animated: true)
        
    }
    @IBOutlet var seperatorImg: UIImageView!
    @IBOutlet var confirmBtn: UIButton!
    @IBAction func confirmBtnAction(_ sender: AnyObject)
    {
        if nameTxtField.text == ""
        {
            
            let alertView = UIAlertView(title: "Alert", message: String(format: "Please Enter Contact Name"), delegate: self, cancelButtonTitle: "Cancel")
            alertView.show()
            self.editContactView.isHidden = false
            
        }
        else if mobileNumberTxtField.text == ""
        {
            let alertView = UIAlertView(title: "Alert", message: String(format: "Please Enter Mobile Number"), delegate: self, cancelButtonTitle: "Cancel")
            alertView.show()
            self.editContactView.isHidden = false
        }
        else if countryCodeTxtField.text == ""
        {
            let alertView = UIAlertView(title: "Alert", message: String(format: "Please Enter CountryCode Name"), delegate: self, cancelButtonTitle: "Cancel")
            alertView.show()
            self.editContactView.isHidden = false
        }
        else
        {
            self.editContactView.isHidden = true
            print("mobileNumberTxtField.text \(mobileNumberTxtField.text)")
            print("qqqqqqq \(nameTxtField.text)")
            //let sen: UIButton = sender as! UIButton
            // let sen: UIButton = sender as! UIButton
            let g : IndexPath = IndexPath(row: confirmBtn.tag, section: 0)
            print(confirmBtn.tag)
            let t : contactInfoDetailCell = self.contactTblView.cellForRow(at: g) as!   contactInfoDetailCell
            t.personName.text = nameTxtField.text
            t.personContact.text = mobileNumberTxtField.text
            t.countryCode.text = countryCodeTxtField.text
            //  print("!!!!!! \(contactPersonPhoneDetail)")
            
             var myDictionary = [AnyHashable: Any]()
            for i in 0 ..< selectedPersonDeatil.count
            {
               
                myDictionary["userName"] = t.personName.text
                myDictionary["mobile"] = t.personContact.text
                myDictionary["countryId"] = t.countryCode.text
              //  concateArrays.addObject(myDictionary)
                

            }
           
            
            let string = t.countryCode.text

            // renamed to range(of:"") in Swift 3.0
            if string!.contains("+")
            {
                t.contentView.layer.borderColor = UIColor.white.cgColor
                t.contentView.layer.borderWidth = 1.0
                
                
            }
            else
            {
                t.contentView.layer.borderColor = UIColor.red.cgColor
                t.contentView.layer.borderWidth = 1.0
            }
            selectedPersonDeatil.replaceObject(at: confirmBtn.tag, with: myDictionary)
            print("$$$$$$$ \(selectedPersonDeatil)")
            
            
//            contactPersonPhoneDetail.replaceObjectAtIndex(confirmBtn.tag, withObject: t.personContact.text!)
//            selectedPersonDeatil.replaceObjectAtIndex(confirmBtn.tag, withObject: t.personName.text!)
            //        print("$$$$$$$ \(contactPersonPhoneDetail)")
            //         print("$$$$$$$ \(contactPersonNameDetail)")
        }
        
        
        
       
        
    }
    
    
    @IBOutlet var addContactInfoBtn: UIButton!
    
    //Giving a server call
    @IBAction func addContactInfoBtnAction(_ sender: AnyObject)
    {
        print(strGroupIDs)
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
       // wsm.GetallmodulesofGroupsOFUSer(grpDetail.grpId,memberProfileId: grpDetail.grpProfileId)
        wsm.delegates = self
        
        
        
        
        var myDictionary = [AnyHashable: Any]()
        myDictionary["AddMember"] = selectedPersonDeatil
        
        print("----myDictionary",myDictionary)
        wsm.sendAllPersonContactDetails(myDictionary as NSDictionary)
        
        
        
        
        /*
        print(strGroupIDs)
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates = self
        wsm.sendAllPersonContactDetails(selectedPersonDeatil)
        */
     
    }
    ///
    func getContactPersonDetail()
    {
        
    }
    
    @objc func editClicked(_ sender: AnyObject)
    {
        
        
        let button = (sender as! UIButton)
        print("Tag Value = \(button.tag)")
        confirmBtn.tag = button.tag
        self.editContactView.isHidden = false
        let cell = (sender.superview!!.superview as! contactInfoDetailCell)
        //Since you are adding to cell.contentView, navigate two levels to get cell object
        var indexPath = contactTblView!.indexPath(for: cell)!
        nameTxtField.text = cell.personName.text
        mobileNumberTxtField.text = cell.personContact.text
        countryCodeTxtField.text = cell.countryCode.text
        
        
        
        
        
        //        print("nameTxtField.text \(nameTxtField.text)")
        //        print("mobileNumberTxtField.text \(mobileNumberTxtField.text)")
        
    }
    @objc func deleteClicked(_ sender: AnyObject)
    {
        
//    
//        let button = (sender as! UIButton)
//        print("Tag Value = \(button.tag)")
//       let storeDictAtIndex = selectedPersonDeatil.object(at: button.tag)
//       //  var storePersonName : String!
//      //   storePersonName = storeDictAtIndex["userName"]
//      let storePersonName: String! = storeDictAtIndex["userName"] as AnyObject? as? String
//        
//   
//        let alertController = UIAlertController(title: "Alert", message:"Are you sure want to delete \(storePersonName)", preferredStyle: .alert)
//        
//        // Create the actions
//        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
//        {
//            UIAlertAction in
//            self.selectedPersonDeatil.removeObject(at: button.tag)
//            self.contactTblView.reloadData()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
//        {
//            UIAlertAction in
//            NSLog("Cancel Pressed")
//        }
//        
//        // Add the actions
//        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
//        
//        // Present the controller
//        self.present(alertController, animated: true, completion: nil)
//        
       
        
    }
    @IBOutlet var contactTblView: UITableView!
    override func viewDidLoad()
    {
       // self.editContactView.viewWithTag(1)?.hidden = true
        
        
        //getting the groupId and mainmemberProfileId
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        print("....\(grpIDForcontactDetails)")
        
        
        
        self.editContactView.isHidden = true
        self.editContactView.backgroundColor = UIColor.lightGray
        self.editContactView.layer.borderWidth = 0.5
        editContactView.layer.cornerRadius = 10.0
        
        self.editContactView.layer.borderColor = UIColor(red:153/255.0, green:223/255.0, blue:246/255.0, alpha: 1.0).cgColor
 //       print("contactPersonNameDetail \(contactPersonNameDetail)")
        nameTxtField.tintColor = UIColor.gray
        mobileNumberTxtField.tintColor =  UIColor.black
        countryCodeTxtField.textColor = UIColor.black
    }

    override func viewWillAppear(_ animated: Bool)
    {
         self.createNavigationBar()
        super.viewWillAppear(animated)
        
        
       
        //   self.view.userInteractionEnabled = true
        
        let defaults = UserDefaults.standard
        let country =  defaults.object(forKey: "countryName")
        let code    =  defaults.object(forKey: "countryId")
        // let str = defaults.valueForKey("countryId") as! String?
        print(country)
        print(code)
        
        if let code =  defaults.object(forKey: "countryId")
        {
            countryCodeTxtField.text = code as? String
             print("countryCodeTxtField.text \(countryCodeTxtField.text)")
           // codeLabel.text = code as? String
            
        }
        else
        {
            
            countryCodeTxtField.text = "India"
            print("nameTxtField.text \(nameTxtField.text)")
           // codeLabel.text = "+91"
            let defaults = UserDefaults.standard
            defaults.set("1", forKey: "countryId")
            defaults.synchronize()
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       // print("++++ \(contactNames)")
        return selectedPersonDeatil.count
        
    }
    func tableView(_ tableView: UITableView!,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell!
    {
        
        let cell = contactTblView.dequeueReusableCell(withIdentifier: "contactInfoDetailCell", for: indexPath) as! contactInfoDetailCell
        
        
        
        
       // cell.personContact.text = contactPersonPhoneDetail[indexPath.row] as? String
        
      //   print("++++ \(countryCodeDetail)")
        
        confirmBtn.tag = indexPath.row;
      //  cell.personName.text = contactNames[indexPath.row] as! String
      //  print("cell.checkMarkBtn.currentImage \(cell.checkMarkBtn.currentImage)")
        
        let editBtn = UIButton(type: UIButton.ButtonType.custom)
        editBtn.frame = CGRect(x: 236, y: 18, width: 35, height: 23)
        editBtn.setImage(UIImage(named:"green_edit.png"),  for: UIControl.State.normal)
        editBtn.addTarget(self, action: #selector(contactInfoViewController.editClicked), for: UIControl.Event.touchUpInside)
      //  editBtn.tag = indexPath.row
        editBtn.tag = indexPath.row
        
       // confirmBtn.tag = editBtn.tag
        cell.contentView.addSubview(editBtn)
        
        let deleteBtn = UIButton(type: UIButton.ButtonType.custom)
        deleteBtn.frame = CGRect(x: 281, y: 18, width: 35, height: 23)
        deleteBtn.setImage(UIImage(named:"delete_gray.png"),  for: UIControl.State.normal)
        deleteBtn.addTarget(self, action: #selector(contactInfoViewController.deleteClicked), for: UIControl.Event.touchUpInside)
        deleteBtn.tag = indexPath.row
        
        cell.contentView.addSubview(deleteBtn)
        
       // cell.personName.text = selectedPersonDeatil[indexPath.row]["userName"] as? String
       // cell.personContact.text = selectedPersonDeatil[indexPath.row]["mobile"] as? String
       /// cell.countryCode.text = selectedPersonDeatil[indexPath.row]["countryId"] as? String
        let string = cell.countryCode.text
        
        // renamed to range(of:"") in Swift 3.0
        if string!.contains("+")
        {
            cell.contentView.layer.borderColor = UIColor.white.cgColor
            cell.contentView.layer.borderWidth = 1.0
            
            
        }
        else
        {
            cell.contentView.layer.borderColor = UIColor.red.cgColor
            cell.contentView.layer.borderWidth = 1.0
        }
    
        
        
        return cell;
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            contactPersonPhoneDetail.removeObject(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
         selectedIndexPathForCheckMark = indexPath
        let cell : contactInfoDetailCell = contactTblView.cellForRow(at: indexPath) as! contactInfoDetailCell
        
        
       

        
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60;
        
    }
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "ContactDetail"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(contactInfoViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        nameTxtField.resignFirstResponder()
        mobileNumberTxtField.resignFirstResponder()
        countryCodeTxtField.resignFirstResponder()
        return true
        
    }
    
   

}

