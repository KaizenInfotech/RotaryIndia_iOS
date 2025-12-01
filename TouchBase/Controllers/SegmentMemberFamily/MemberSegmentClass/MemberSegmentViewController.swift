//
//  DirectoryViewController.swift
//  TouchBase
//
//  Created by Kaizan on 16/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//
/*
 loaderClass.loaderViewMethod()
 */
import UIKit
//import Kingfisher
import Alamofire
//import WPZipArchive
import SVProgressHUD
import SSZipArchive
import SDWebImage
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
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l <= r
    default:
        return !(rhs < lhs)
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


class MemberSegmentViewController: UIViewController,UITextFieldDelegate,webServiceDelegate,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating , UIPickerViewDelegate , UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate
{
    var varGetZipFileUrl:String!=""
    var varGetSearchTextL:String!=""
    var NormalMemberOrAdmin:String!=""
    @IBOutlet weak var buttonOpacityFirstTime: UIButton!
    @IBOutlet weak var buttonSearchRotarianType: UIButton!
    @IBOutlet weak var textfieldForRotarianSearch: UITextField!
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var pickerSelectSettingMyProfileAboutPicker: UIPickerView!
    @IBOutlet weak var buttonDonOnPicker: UIButton!
    @IBOutlet weak var viewForSettingPicker: UIView!
    var mainArraySettingForPicker = NSArray()
    var varGetPickerSelectValue:String! = ""
    var varISPopVisisbleorNot:Int!=0
    @IBOutlet weak var labelFirstLoading: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lblPleaseWait: UILabel!
    
    var varGetCount:String!=""
    internal typealias ActionButtonAction = (DirectoryViewController) -> Void
    internal var action: ActionButtonAction?
    var actionButton: ActionButton!
    let bounds = UIScreen.main.bounds
    let searchTextField = UITextField()
    let btnsearch = UIButton()
    let screenSize: CGRect = UIScreen.main.bounds
    var appDelegate : AppDelegate = AppDelegate()
    @IBOutlet var NoRecordLabel: UILabel!
    @IBOutlet var directoryTableView: UITableView!
    var mainArray : NSMutableArray!
    var copymainArray:NSArray!
    var grpID: NSString!
    var isAdmin:String! = ""
    var moduleId:NSString!
    var moduleName:String! = ""
    var isCategory:String!=""
    var userID:NSString!
    //  let loaderClass  = WebserviceClass()
    var refresher:UIRefreshControl!
    var refreshControl: UIRefreshControl!
    var searchController: UISearchController!
    
    
    /*æææææææææææææææææææcode by depak*/
    var isRotarianorClassification:String!=""
    func functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDown(_ stringSearchText:String)
    {
        var moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
        var GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        if (varGetPickerSelectValue == "Rotarian")
        {
            isRotarianorClassification="Rotarian"
            buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
            fetchData("0")
        }
        else if (varGetPickerSelectValue == "Classification")
        {//Classification
             isRotarianorClassification="Classification"
            buttonSearchRotarianType.setTitle("Classification",  for: UIControl.State.normal)
            fetchData("1")
        }
        else
        {
            buttonOpticity.isHidden = true
            viewForSettingPicker.isHidden = true
        }
        buttonOpticity.isHidden = true
        viewForSettingPicker.isHidden = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        
        searchBar.showsCancelButton=true
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton = false
        buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
        searchBar.resignFirstResponder()
    }
    func updateSearchResults(for searchController: UISearchController)
    {
        searchBar.showsCancelButton = false
        let varGetText=searchController.searchBar.text
        if(varGetText?.characters.count<=0 && varGetText != "")
        {
            searchController.searchBar.placeholder="Search"
            varGetSearchTextL = ""
        }
        else if searchController.searchBar.text != nil
        {
            searchController.searchBar.placeholder="Enter Salon Name"
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        varGetSearchTextL = ""
        if (varGetPickerSelectValue == "Rotarian")
        {
            buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
            mainArray.removeAllObjects()     //DPK
            searchBar.resignFirstResponder()
        }
        else if (varGetPickerSelectValue == "Classification")
        {
            varGetSearchTextL = ""
            functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDown(varGetSearchTextL)
        }
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    func createNavigationBar()
    {
        print("Enter in MemberSegmentViewController")
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(MemberSegmentViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return mainArray.count
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        searchBar.resignFirstResponder()
        if scrollView == directoryTableView
        {
             if(isRotarianorClassification=="Classification")
            {
                self.view.makeToast("Total classification "+varGetCount, duration: 2, position: CATransitionSubtype.fromBottom)
            }
            else
             {
                self.view.makeToast("Total members "+varGetCount, duration: 2, position: CATransitionSubtype.fromBottom)

            }
        }
    }
    
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (varGetPickerSelectValue == "Rotarian")
        {
            return 90
        }
        else  if (varGetPickerSelectValue == "Classification" && isRotarianFromClassification=="yes")
        {
            return 90
        }
        else  if (varGetPickerSelectValue == "Classification")
        {
            return 57
        }
        return 0
    }
    
    @objc func buttonPicBigViewLaterClickEvent(_ sender:UIButton)
    {
        
        let  directoryList = mainArray[sender.tag] as! NSDictionary
        var varGetImage = directoryList.object(forKey: "pic") as? String
        
        if(varGetImage?.characters.count>10)
        {
            let ImageProfilePic:String = varGetImage!.replacingOccurrences(of: " ", with: "%20")
            
            let isUpperImageAvailable = ImageProfilePic
            
            print(isUpperImageAvailable)
            print("Clicked !!")
            if(isUpperImageAvailable.characters.count>10)
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
    }
    /*
     isRotarianorClassification="Rotarian"
     buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
     fetchData("0")
     }
     else if (varGetPickerSelectValue == "Classification")
     {//Classification
     isRotarianorClassification="Classification"
     
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "dirCell") as! DirectoryCell
        if(isRotarianorClassification=="Rotarian")
        {
            print("if condition here ")
            print(isRotarianorClassification)
            let  directoryList = mainArray[indexPath.row] as! NSDictionary
            buttonOpacityFirstTime.isHidden=true
            labelFirstLoading.isHidden=true
            print("This is countri9ng:-----")
            print(indexPath.row)
            SVProgressHUD.dismiss()
            
            cell.viewClassified.isHidden=true
            cell.viewFamily.isHidden=true
            // self.window = nil
            
            cell.profilePic.isHidden=false
            cell.nameLabel.isHidden=false
            //cell.mobileLabel.isHidden=false
            cell.buttonRotarian.isHidden=false
            
            cell.buttonRotarian.addTarget(self, action: #selector(MemberSegmentViewController.buttonRotarianClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonRotarian.tag=indexPath.row;
            
            cell.profilePic.layer.borderColor = UIColor.lightGray.cgColor
            cell.nameLabel.text   =  directoryList.object(forKey: "memberName") as? String
            cell.mobileLabel.text =  directoryList.object(forKey: "membermobile") as? String
            /////-----------
            let varGetImage = directoryList.object(forKey: "pic") as? String
            print("************************************",varGetImage)
            
            if directoryList.object(forKey: "pic") as! String == ""
            {
                cell.profilePic.image = UIImage(named: "profile_pic")
            }
            else
            {
                let ImageProfilePic:String = varGetImage!.replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                cell.profilePic.sd_setImage(with: checkedUrl)
            }
            cell.buttonPicBigViewLater.tag=indexPath.row
            cell.buttonPicBigViewLater.isHidden=false
            cell.buttonPicBigViewLater.addTarget(self, action: #selector(MemberSegmentViewController.buttonPicBigViewLaterClickEvent(_:)), for: UIControl.Event.touchUpInside)
            cell.groupsLabel.text =  ""
            return cell
        }
       else  if (varGetPickerSelectValue == "Classification" && isRotarianFromClassification=="yes")
        {
            
            // self.window = nil
            cell.profilePic.isHidden=false
            cell.nameLabel.isHidden=false
            //cell.mobileLabel.isHidden=false
            cell.buttonRotarian.isHidden=false
            
            print("if condition here ")
            print(isRotarianorClassification)
            let  directoryList = mainArray[indexPath.row] as! NSDictionary
            buttonOpacityFirstTime.isHidden=true
            labelFirstLoading.isHidden=true
            print("This is countri9ng:-----")
            print(indexPath.row)
            SVProgressHUD.dismiss()
            
            cell.viewClassified.isHidden=true
            cell.viewFamily.isHidden=true
            // self.window = nil
            
            cell.profilePic.isHidden=false
            cell.nameLabel.isHidden=false
           // cell.mobileLabel.isHidden=false
            cell.buttonRotarian.isHidden=false
            
            cell.buttonRotarian.addTarget(self, action: #selector(MemberSegmentViewController.buttonRotarianClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonRotarian.tag=indexPath.row;
            
            cell.profilePic.layer.borderColor = UIColor.lightGray.cgColor
            cell.nameLabel.text   =  directoryList.object(forKey: "memberName") as? String
            cell.mobileLabel.text =  directoryList.object(forKey: "membermobile") as? String
            /////-----------
            let varGetImage = directoryList.object(forKey: "pic") as? String
            print("************************************",varGetImage)
            
            if (directoryList.object(forKey: "pic") as? String == "" || varGetImage == nil)
            {
                cell.profilePic.image = UIImage(named: "profile_pic")
            }
            else
            {
                let ImageProfilePic:String = varGetImage!.replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                cell.profilePic.sd_setImage(with: checkedUrl)
            }
            cell.buttonPicBigViewLater.tag=indexPath.row
            cell.buttonPicBigViewLater.isHidden=false
            cell.buttonPicBigViewLater.addTarget(self, action: #selector(MemberSegmentViewController.buttonPicBigViewLaterClickEvent(_:)), for: UIControl.Event.touchUpInside)
            cell.groupsLabel.text =  ""
            return cell
        }
        else if(isRotarianorClassification=="Classification")
        {
            print("else condition here ")
            print(isRotarianorClassification)
            let  directoryList = mainArray[indexPath.row] as! NSDictionary

            print(directoryList)
            print(mainArray)
            /*---------------------*/
            cell.viewClassified.isHidden=false
            // self.window = nil
             cell.viewFamily.isHidden=true
            cell.profilePic.isHidden=true
            cell.nameLabel.isHidden=true
            //cell.mobileLabel.isHidden=true
            cell.buttonRotarian.isHidden=true
            /*---------------------*/
            cell.labelClassified.text=directoryList.object(forKey: "classification") as? String
            
            
            
            cell.buttonClassified.tag=indexPath.row
            cell.buttonClassified.isHidden=false
            cell.buttonClassified.addTarget(self, action: #selector(MemberSegmentViewController.buttonClassificationClickEvent(_:)), for: UIControl.Event.touchUpInside)
            return cell
        }
        return cell
        
    }
    var isRotarianFromClassification:String!="no"
    var ThisisClassificationClickedNAme:String!=""
    @objc func buttonClassificationClickEvent(_ sender:UIButton)
    {
         isRotarianFromClassification="yes"

        textfieldForRotarianSearch.text=""
        varGetPickerSelectValue = "Classification"
        let  directoryList = mainArray[sender.tag] as! NSDictionary
        var classification = directoryList.object(forKey: "classification") as? String
        ThisisClassificationClickedNAme=classification
        print("this is classification fileds !!!")
        print(classification)
        var stringRotarianorDistrictCommittee:String!="0"
        ///-------cfgfdgfgsdfgfsdgdfggdfgdfsgdsdfgsdsfgsdfgdfsgdsfgdsfgdfgdsfgfsgdfgdfsgdsfgdfgsdfgdfsgdfsgdfsgdfdfgdf-----
      
            mainArray=NSMutableArray()
            var databasePath : String
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
                print("Error: \(contactDB?.lastErrorMessage() ?? "")")
            }
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            if (contactDB?.open())! {
                
                var querySQL:String! = ""
                
                if(UserDefaults.standard.value(forKey: "Session_ModuleNameForNavigationHeading_FindAClubOrClubs") != nil && UserDefaults.standard.value(forKey: "Session_ModuleNameForNavigationHeading_FindAClubOrClubs") as! String == "Find a Club" && stringRotarianorDistrictCommittee == "0")
                {
                    querySQL = "SELECT masterUID,grpID,profileID,memberName,membermobile,pic,distDesignation  FROM clubMember_Segment_List where (distDesignation = '0' or  distDesignation = '1') and classification='"+classification!+"'"
                    
                    print(querySQL)
                    
                    
                }
                else
                {
                    if(stringRotarianorDistrictCommittee=="0")
                    {
                        querySQL = "SELECT masterUID,grpID,profileID,memberName,membermobile,pic,distDesignation  FROM clubMember_Segment_List where classification='"+classification!+"'   order by memberName  COLLATE NOCASE asc"
                        
                         print(querySQL)
                    }
                    
                }
                
                print(querySQL!)
                if(stringRotarianorDistrictCommittee=="0")
                {
                    mainArray = NSMutableArray()
                    isRotarianorClassification="Rotarian"
                    let results:FMResultSet? = contactDB?.executeQuery(querySQL!,withArgumentsIn: nil)
                    
                    var varCounting:Int!=0
                    
                    while results?.next() == true {
                        let dd = NSMutableDictionary ()
                        dd.setValue((results?.string(forColumn: "masterUID"))! as String, forKey:"masterUID")
                        dd.setValue((results?.string(forColumn: "grpID"))! as String, forKey:"grpID")
                        dd.setValue((results?.string(forColumn: "profileID"))! as String, forKey:"profileID")
                        dd.setValue((results?.string(forColumn: "memberName"))! as String, forKey:"memberName")
                        dd.setValue((results?.string(forColumn: "membermobile"))! as String, forKey:"membermobile")
                        dd.setValue((results?.string(forColumn: "pic"))! as String, forKey:"pic")
                        dd.setValue((results?.string(forColumn: "distDesignation"))! as String, forKey:"distDesignation")
                        
                        mainArray.add(dd)
                        varCounting=varCounting+1
                        print(dd)
                    }
                    if mainArray.count > 0
                    {
                        NoRecordLabel.isHidden = true
                        copymainArray=mainArray
                        directoryTableView.reloadData()
                    }
                    else
                    {
     NoRecordLabel.isHidden = false
     mainArray = NSMutableArray()
     copymainArray=NSArray()
     self.labelFirstLoading.isHidden=true
     self.buttonOpacityFirstTime.isHidden=true
     directoryTableView.reloadData()
    }
    //------
    
    
    // self.window = nil
    let Count = "SELECT count(*) from clubMember_Segment_List where classification='"+classification!+"'"
                    // print(Count)
                    let resultss:FMResultSet? = contactDB?.executeQuery(Count,withArgumentsIn: nil)
                    
                    while resultss?.next() == true
                    {
                        varGetCount=resultss?.string(forColumn: "Count")
                    }
                    varGetCount=String(varCounting)
                    directoryTableView.reloadData()
                }
            }

        ///-------gdsfgfdgddsfgdsfgdfsgdsdfgdfsdfgsdgdsfgdsgsgdsfgdsfgsdfgfgsdfgdsfgddsgdfsgfdsgdsfgdfsgdsfgdfsgfgdsf--
        
        
    }
    
    @objc func buttonRotarianClicked(_ sender:UIButton)
    {
        let  directoryList = mainArray[sender.tag] as! NSDictionary
        
        //MemberSegmentProfileDetailsViewController
        
        let objMemberSegmentProfileDetailsViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemberSegmentProfileDetailsViewController") as! MemberSegmentProfileDetailsViewController
        objMemberSegmentProfileDetailsViewController.varProfileId=directoryList.object(forKey: "profileID") as? String
        
        self.navigationController?.pushViewController(objMemberSegmentProfileDetailsViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let  directoryList = mainArray[indexPath.row] as! NSDictionary
        let objProfileDynamicNewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
        
        let masterId =  directoryList.object(forKey: "masterId") as? String
        let profileId = directoryList.object(forKey: "profileId") as? String
        
        objProfileDynamicNewViewController.masterId=masterId
        objProfileDynamicNewViewController.profileId=profileId
        objProfileDynamicNewViewController.grpID=grpID as String?
        objProfileDynamicNewViewController.varAdminProfileID=userID as String?
        objProfileDynamicNewViewController.isAdmin=isAdmin  //directoryList.objectForKey("isAdmin") as? String
        objProfileDynamicNewViewController.NormalMemberOrAdmin="NormalMemberFromMainDash"
        
        self.navigationController?.pushViewController(objProfileDynamicNewViewController, animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {   //delegate method
        
//        self.mainArray=NSMutableArray()
//        var strValues = self.textfieldForRotarianSearch.text!
//        if (varGetPickerSelectValue == "Rotarian")
//        {
//            self.buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
//            self.mainArray.removeAllObjects()
//            self.fetchDataFORClubName(strValues)
//            textfieldForRotarianSearch.resignFirstResponder()
//            /////
//            //  fetchData()
//        }
//        else if (varGetPickerSelectValue == "Classification")
//        {
//            self.buttonSearchRotarianType.setTitle("Classification",  for: UIControl.State.normal)
//            //
//            
//            if(strValues=="" || strValues.characters.count==0 || strValues.characters.count<=0)
//            {
//                self.mainArray.removeAllObjects()
//                self.functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDown(strValues as String)
//            }
//            else
//            {
//                self.fetchDataFORDistrictCommitee(strValues as String)
//            }
//            
//            
//            
//        }
        textfieldForRotarianSearch.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        self.mainArray=NSMutableArray()
        var strValues = self.textfieldForRotarianSearch.text!
        
        
        
        let userEnteredString = textField.text
        strValues = ((userEnteredString! as NSString?)?.replacingCharacters(in: range, with: string))!
        print(strValues)
        print("this is value from search text ")
        
        
        
        
        
        
        
       // sfhjsdh sdfhdfha jhf dshjf hf hjh djkfghjkghdfkl;ghdsf lgdh gjkds fg h
        
        print("3333333333333333333333333333333333333333",strValues)
        if (varGetPickerSelectValue == "Rotarian")
        {
            print("this is rotarain if condition")
            self.buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
            self.fetchDataFORClubName(strValues as String)
        }
        else  if (varGetPickerSelectValue == "Classification" && isRotarianFromClassification=="yes")
        {
            print("else -if condition bny Rajendfra JAt")
           functionForSearchRotarianWhenClassificationSelected(stringValueEnteredCharacter: strValues)
        }
        else if (varGetPickerSelectValue == "Classification")
        {
            print("this is classififcation from classification from else conditio9n :-0-------")
            self.fetchDataFORDistrictCommitee(strValues as String)
            //self.functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDown(strValues as String)
        }
        return true
    }
    
    func functionForSearchRotarianWhenClassificationSelected(stringValueEnteredCharacter:String)
    {
        var querySQL:String!=""
        
          querySQL = "SELECT masterUID,grpID,profileID,memberName,membermobile,pic,distDesignation  FROM clubMember_Segment_List where classification='"+ThisisClassificationClickedNAme!+"' and ( memberMobile like '%\(stringValueEnteredCharacter)%' or memberName like '%\(stringValueEnteredCharacter)%' )  order by memberName  COLLATE NOCASE asc"
        
        print("this is Query ")
        print(querySQL)
        
            mainArray=NSMutableArray()
            var moduleID = UserDefaults.standard.string(forKey: "session_GetModuleId")
            var GroupID = UserDefaults.standard.string(forKey: "session_GetGroupId")
            
            var databasePath : String
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
            //masterUID, groupId , moduleId , profileID , MemberDesignation , memberName , pic , membermobile From Board_Of_Directors_List
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            if (contactDB?.open())!
                
            {
              

                mainArray = NSMutableArray()
                isRotarianorClassification="Classification"
                print("sdfhhdsfgh as hfjhd gh a hfakjsd hfjkasdh f")
                print(isRotarianorClassification)
                ////////////gyjgtjhhjthjthjtjhtjhtjht/hjt/hjt/h/th//ht/jhthj/t
                let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
                
                
                var varCounting:Int!=0
                
                while results?.next() == true {
                    let dd = NSMutableDictionary ()
                    dd.setValue((results?.string(forColumn: "masterUID"))! as String, forKey:"masterUID")
                    dd.setValue((results?.string(forColumn: "grpID"))! as String, forKey:"grpID")
                    dd.setValue((results?.string(forColumn: "profileID"))! as String, forKey:"profileID")
                    dd.setValue((results?.string(forColumn: "memberName"))! as String, forKey:"memberName")
                    dd.setValue((results?.string(forColumn: "membermobile"))! as String, forKey:"membermobile")
                    dd.setValue((results?.string(forColumn: "pic"))! as String, forKey:"pic")
                    dd.setValue((results?.string(forColumn: "distDesignation"))! as String, forKey:"distDesignation")
                    
                    mainArray.add(dd)
                    varCounting=varCounting+1
                    print(dd)
                }
                if mainArray.count > 0
                {
                    NoRecordLabel.isHidden = true
                    copymainArray=mainArray
                    directoryTableView.reloadData()
                }
                else
                {
                    NoRecordLabel.isHidden = false
                    mainArray = NSMutableArray()
                    copymainArray=NSArray()
                    self.labelFirstLoading.isHidden=true
                    self.buttonOpacityFirstTime.isHidden=true
                    directoryTableView.reloadData()
                }
              
                //------
                
               // var querySQL:String! = ""
                
                //querySQL = "SELECT *  FROM clubMember_Segment_List where ( memberMobile like '%\(stringValueEnteredCharacter)%' or memberName like '%\(stringValueEnteredCharacter)%' ) "
                
                print("This is value from server :-----!!!!1")
                print(querySQL)
                // self.window = nil
                let Count = "SELECT count(*) as Count from clubMember_Segment_List where distDesignation = '0' "
                // print(Count)
                let resultss:FMResultSet? = contactDB?.executeQuery(Count,withArgumentsIn: nil)
                
                while resultss?.next() == true
                {
                    varGetCount=resultss?.string(forColumn: "Count")
                }
                varGetCount=String(varCounting)
                directoryTableView.reloadData()
            }
    }
    
    
    
    func textFieldDidChange(_ textField: UITextField)
    {
        //your code
        if(textField.text!==""){
            mainArray = copymainArray .mutableCopy() as! NSMutableArray
            if(mainArray.count == 0) {
                //directoryTableView.hidden = true;
            }
            else
            {
                // memberTableView.hidden = false;
            }
            searchTextField.text="";
            searchTextField.resignFirstResponder()
            directoryTableView.reloadData()
        }
        else
        {
            mainArray=[]
            
            let predicate = NSPredicate(format: "memberName contains[c] %@", searchTextField.text!)
            mainArray =  copymainArray.filtered(using: predicate) as! NSMutableArray
            print(mainArray)
            if (mainArray.count==0) {
                
                NoRecordLabel.isHidden = false
                directoryTableView.reloadData()
                searchTextField.resignFirstResponder()
                searchTextField.delegate = self
            }
            else{
                
                NoRecordLabel.isHidden = true
                directoryTableView.reloadData()
            }
        }
    }
    
    func functionForDelete()
    {
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
            let insertSQL = "DELETE FROM clubMember_Segment_List" // WHERE profileID = '\(dict.objectForKey("serviceDirId") as! String)'
            print(insertSQL)
            let result = contactDB?.executeStatements(insertSQL)
            if (result == nil) {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            } else {
                print("success saved")
                print(databasePath);
            }
            // }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        //clubMember_Segment_List_DropDown_Classification
        if (contactDB?.open())! {
            //for i in 0 ..< arrdata.count {
            // let  dict = arrdata[i] as! NSDictionary
            let insertSQL2 = "DELETE FROM clubMember_Segment_List_DropDown_Classification" // WHERE profileID = '\(dict.objectForKey("serviceDirId") as! String)'
            print(insertSQL2)
            let result2 = contactDB?.executeStatements(insertSQL2)
            if (result2 == nil) {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            } else {
                print("success saved")
                print(databasePath);
            }
            // }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        
        
    }
    override func viewDidLoad()
    {
        // funcForRemoveZipFileFromDocumentDirectory()
        super.viewDidLoad()
        
       // buttonDoneClickeventOnPicker.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "buttonDoneClickeventOnPicker"))

        isRotarianorClassification="Rotarian"
     
        
        
        
        
        functionForDelete()
        /* this code is comment by Rajendra jat on Seema bugs on 27 Dec 2018 6.16pm
         if(UserDefaults.standard.value(forKey: "Session_ModuleNameForNavigationHeading_FindAClubOrClubs") != nil && UserDefaults.standard.value(forKey: "Session_ModuleNameForNavigationHeading_FindAClubOrClubs") as! String == "Find a Club")
         {
         
         buttonSearchRotarianType.isHidden=true
         self.textfieldForRotarianSearch.frame=CGRect(x: self.textfieldForRotarianSearch.frame.origin.x, y: self.textfieldForRotarianSearch.frame.origin.y, width: self.directoryTableView.frame.size.width-20.0, height: self.textfieldForRotarianSearch.frame.size.height)
         }
         else
         {
         */
        buttonSearchRotarianType.isHidden=false
        self.textfieldForRotarianSearch.frame=CGRect(x: self.textfieldForRotarianSearch.frame.origin.x, y: self.textfieldForRotarianSearch.frame.origin.y, width: self.textfieldForRotarianSearch.frame.size.width, height: self.textfieldForRotarianSearch.frame.size.height)
        
        /*}*/
        
        //buttonSearchRotarianType.hidden=true
        
        
        self.textfieldForRotarianSearch.delegate=self
        grpID = UserDefaults.standard.value(forKey: "GrpID") as! String as NSString
        
        print(grpID)
        functionForCallinWEbApi()
        //---pulll to refresh
        self.directoryTableView.alwaysBounceVertical = true;
        
        
        self.textfieldForRotarianSearch.layer.cornerRadius = 10.0
        self.textfieldForRotarianSearch.layer.borderColor = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0).cgColor
        self.textfieldForRotarianSearch.layer.borderWidth = 1.0
        
        self.buttonSearchRotarianType.titleLabel?.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        self.buttonSearchRotarianType.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        self.buttonSearchRotarianType.layer.cornerRadius = 10.0
        self.buttonSearchRotarianType.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor////UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0).CGColor
        self.buttonSearchRotarianType.layer.borderWidth = 1.0
        
        self.buttonOpacityFirstTime.isHidden=true
        self.labelFirstLoading.isHidden=true
        // self.loaderClass.loaderViewMethod()
        
        
        varGetPickerSelectValue = "Rotarian"
        //Navigation more functionality ------DPK
        viewForSettingPicker.isHidden = true
        buttonOpticity.isHidden = true
        buttonDonOnPicker.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        mainArraySettingForPicker = ["Rotarian" , "Classification" ]
        
        searchTextField.delegate = self
        NoRecordLabel.isHidden = true
//        self.edgesForExtendedLayout = []
        self.createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        mainArray = NSMutableArray()
        copymainArray = NSArray()
        let tblView =  UIView(frame: CGRect.zero)
        directoryTableView.tableFooterView = tblView
        directoryTableView.tableFooterView!.isHidden = true
        
        
        mainArray=NSMutableArray()
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        var varCounting:Int!=0
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            
            
            let Count = "SELECT count(*) as Count from clubMember_Segment_List where distDesignation = '0' "
            print(Count)
            let resultss:FMResultSet? = contactDB?.executeQuery(Count,withArgumentsIn: nil)
            while resultss?.next() == true
            {
                varGetCount=resultss?.string(forColumn: "Count")
            }
            
            varCounting = Int(varGetCount)
            // print(varCounting)
        }
        if(varCounting>0)
        {
            fetchData("0")
        }
        else
        {
            
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
        
        
    }
    
    @IBAction func buttonOpticityClickEvent(_ sender: AnyObject)
    {
         varISPopVisisbleorNot=0
        buttonOpticity.isHidden=true
        viewForSettingPicker.isHidden=true
    }
    @IBAction func buttonDoneClickeventOnPicker(_ sender: AnyObject)
    {
         varISPopVisisbleorNot=0
        textfieldForRotarianSearch.resignFirstResponder()
        
        
       
        
        print("This is value from scearch screen !!!!")
        print(varGetPickerSelectValue)
        textfieldForRotarianSearch.text=""
        //var moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
        // var GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        if (varGetPickerSelectValue == "Rotarian")
        {
            print("This is Rotarian !!!")
            buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
            fetchData("0")
        }
        else if (varGetPickerSelectValue == "Classification")
        {
            print("This is Classification !!!")

            isRotarianFromClassification="no"
            buttonSearchRotarianType.setTitle("Classification",  for: UIControl.State.normal)
            fetchData("1")
        }
        else
        {
            buttonOpticity.isHidden = true
            viewForSettingPicker.isHidden = true
        }
        buttonOpticity.isHidden = true
        viewForSettingPicker.isHidden = true
        
        self.view.endEditing(true)

    }
    @IBAction func buttonSearchRoatrainTypeClickEvent(_ sender: AnyObject)
    {
       

        if(varISPopVisisbleorNot==0)
        {
            buttonOpticity.isHidden = false
            viewForSettingPicker.isHidden = false
            pickerSelectSettingMyProfileAboutPicker.reloadAllComponents()
            varISPopVisisbleorNot=1
        }
        else if(varISPopVisisbleorNot==1)
        {
            buttonOpticity.isHidden = true
            viewForSettingPicker.isHidden = true
            varISPopVisisbleorNot=0
        }
        searchBar.resignFirstResponder()
        self.view.endEditing(true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return mainArraySettingForPicker.count;
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        //let countryList = GrpCountryList()
        let varGetCountry:String = mainArraySettingForPicker.object(at: row) as! String
        return varGetCountry
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let varGetCountry:String = mainArraySettingForPicker.object(at: row) as! String
        varGetPickerSelectValue =   varGetCountry
    }
    //    func loaderViewMethod()
    //    {
    //        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
    //        if let window = appDelegate.window {
    //            window.backgroundColor = UIColor.clear
    //            window.rootViewController = UIViewController()
    //            window.makeKeyAndVisible()
    //        }
    //        let Loadingview = UIView()
    //
    //        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
    //        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
    //        appDelegate.window?.addSubview(Loadingview)
    //
    //        let url = Bundle.main.url(forResource: "tb_preloader8", withExtension: "gif")
    //
    //        let gifView = UIImageView()
    //        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
    //        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
    //        gifView.backgroundColor = UIColor.clear
    //        Loadingview.addSubview(gifView)
    //    }
    //-----fetch data
    func fetchData (_ stringRotarianorDistrictCommittee:String)
    {
        mainArray=NSMutableArray()
        var databasePath : String
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
            
            var querySQL:String! = ""
            
            if(UserDefaults.standard.value(forKey: "Session_ModuleNameForNavigationHeading_FindAClubOrClubs") != nil && UserDefaults.standard.value(forKey: "Session_ModuleNameForNavigationHeading_FindAClubOrClubs") as! String == "Find a Club" && stringRotarianorDistrictCommittee == "0")
            {
                querySQL = "SELECT masterUID,grpID,profileID,memberName,membermobile,pic,distDesignation  FROM clubMember_Segment_List where distDesignation = '0' or  distDesignation = '1' order by memberName COLLATE NOCASE asc"
            }
            else
            {
                if(stringRotarianorDistrictCommittee=="0")
                {
                    querySQL = "SELECT masterUID,grpID,profileID,memberName,membermobile,pic,distDesignation  FROM clubMember_Segment_List   order by memberName  COLLATE NOCASE asc"
                }
                if(stringRotarianorDistrictCommittee=="1")
                {
                    querySQL = "SELECT *  FROM clubMember_Segment_List_DropDown_Classification "
                }
                
            }

            print(querySQL!)
            if(stringRotarianorDistrictCommittee=="0")
            {
                isRotarianorClassification="Rotarian"
                let results:FMResultSet? = contactDB?.executeQuery(querySQL!,withArgumentsIn: nil)
                
                var varCounting:Int!=0
                
                while results?.next() == true {
                    let dd = NSMutableDictionary ()
                    dd.setValue((results?.string(forColumn: "masterUID"))! as String, forKey:"masterUID")
                    dd.setValue((results?.string(forColumn: "grpID"))! as String, forKey:"grpID")
                    dd.setValue((results?.string(forColumn: "profileID"))! as String, forKey:"profileID")
                    dd.setValue((results?.string(forColumn: "memberName"))! as String, forKey:"memberName")
                    dd.setValue((results?.string(forColumn: "membermobile"))! as String, forKey:"membermobile")
                    dd.setValue((results?.string(forColumn: "pic"))! as String, forKey:"pic")
                    dd.setValue((results?.string(forColumn: "distDesignation"))! as String, forKey:"distDesignation")
                    
                    mainArray.add(dd)
                    varCounting=varCounting+1
                    print(dd)
                }
                if mainArray.count > 0
                {
                    NoRecordLabel.isHidden = true
                    copymainArray=mainArray
                    directoryTableView.reloadData()
                }
                else
                {
                    NoRecordLabel.isHidden = false
                    mainArray = NSMutableArray()
                    copymainArray=NSArray()
                    self.labelFirstLoading.isHidden=true
                    self.buttonOpacityFirstTime.isHidden=true
                    directoryTableView.reloadData()
                }
                //------
                
                
                // self.window = nil
                let Count = "SELECT count(*) as Count from clubMember_Segment_List where distDesignation = '0' "
                // print(Count)
                let resultss:FMResultSet? = contactDB?.executeQuery(Count,withArgumentsIn: nil)
                
                while resultss?.next() == true
                {
                    varGetCount=resultss?.string(forColumn: "Count")
                }
                varGetCount=String(varCounting)
                directoryTableView.reloadData()
            }
            else
            {
                 mainArray = NSMutableArray()
                 isRotarianorClassification="Classification"
                print("sdfhhdsfgh as hfjhd gh a hfakjsd hfjkasdh f")
                print(isRotarianorClassification)
                ////////////gyjgtjhhjthjthjtjhtjhtjht/hjt/hjt/h/th//ht/jhthj/t
                let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
                
                var varCounting:Int!=0
                
                while results?.next() == true {
                    let dd = NSMutableDictionary ()
                    dd.setValue((results?.string(forColumn: "classification"))! as String, forKey:"classification")
                    
                    mainArray.add(dd)
                    varCounting=varCounting+1
                    print(dd)
                }
                if mainArray.count > 0
                {
                    NoRecordLabel.isHidden = true
                    copymainArray=mainArray
                    directoryTableView.reloadData()
                }
                else
                {
                    NoRecordLabel.isHidden = false
                    mainArray = NSMutableArray()
                    copymainArray=NSArray()
                    self.labelFirstLoading.isHidden=true
                    self.buttonOpacityFirstTime.isHidden=true
                    directoryTableView.reloadData()
                }
                //------
                
                
                // self.window = nil
                let Count = "SELECT count(*) as Count from clubMember_Segment_List where distDesignation = '0' "
                // print(Count)
                let resultss:FMResultSet? = contactDB?.executeQuery(Count,withArgumentsIn: nil)
                
                while resultss?.next() == true
                {
                    varGetCount=resultss?.string(forColumn: "Count")
                }
                varGetCount=String(varCounting)
                directoryTableView.reloadData()
                ////d/d/gd/g/dh/d/hgd/fgd/fgd/gf/dgf/dfg/dfg/d/fd/fgd/gfd/fg/d
            }
        }
        
    }
    func functionForCallinWEbApi()
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
            print("Error: \(contactDB?.lastErrorMessage() ?? "")")
        }
        var  completeURL:String!=""
        var ClubID12:String! = ""
        ClubID12 = UserDefaults.standard.value(forKey: "GrpID") as? String
      print(ClubID12)

        completeURL = baseUrl+row_GetMemberSegmentList
        
        self.lblPleaseWait.isHidden=false
        self.directoryTableView.isHidden=true
        self.lblPleaseWait.text="Loading... Please Wait"
        var parameterst:NSDictionary=NSDictionary()
        parameterst = [
            "grpID" : ClubID12,
            "SearchText" : ""
        ]
        
        print("Member Segment:\(parameterst)")
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable : Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            
            print(response)
            let dd = response as! NSDictionary
            print(dd)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                self.lblPleaseWait.text="Could not connect to server."
                self.directoryTableView.isHidden=true
                SVProgressHUD.dismiss()
            }
            else
            {
                var varGetMessage:String!=(dd.object(forKey: "TBMemberList")! as AnyObject).object(forKey: "message") as? String
                print(varGetMessage)
                
                if(varGetMessage == "success")
                {
                    self.buttonOpacityFirstTime.isHidden=false
                    self.labelFirstLoading.isHidden=false
                    //self.loaderClass.loaderViewMethod()
                    /*
                     TBMemberList =     {
                     Result =         (
                     {
                     distDesignation = 0;
                     grpID = 2765;
                     masterUID = 151263;
                     memberName = "AARNA.";
                     membermobile = "+91 8828380678";
                     pic = "http://www.rosteronwheels.com/Documents/directory/14062017065246PM.png";
                     profileID = 151302;
                     */
                    for i in 0 ..< (((dd.object(forKey: "TBMemberList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "Table")! as AnyObject).count
                    {
                        var dictTemporaryDictionary:NSDictionary=(((dd.object(forKey: "TBMemberList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "Table")! as AnyObject).object(at: i)
//                        let distDesignation=dictTemporaryDictionary.object(forKey: "distDesignation")as! String
                        
                        let x : Int = dictTemporaryDictionary.object(forKey: "distDesignation") as? Int ?? 0
                        let distDesignation = String(x)
                        
                        let x1 : Int = dictTemporaryDictionary.object(forKey: "grpID") as? Int ?? 0
                        let grpID = String(x1)
                        
                        let x2 : Int = dictTemporaryDictionary.object(forKey: "masterUID") as? Int ?? 0
                        let masterUID = String(x2)
                        
//                        let grpID=dictTemporaryDictionary.object(forKey: "grpID")as! String
//                        let masterUID=dictTemporaryDictionary.object(forKey: "masterUID")as! String
                        let x3 : Int = dictTemporaryDictionary.object(forKey: "profileID") as? Int ?? 0
                        let profileID = String(x3)
                        
                        
                        let memberName=dictTemporaryDictionary.object(forKey: "memberName")as? String ?? ""
                        let pic=dictTemporaryDictionary.object(forKey: "pic")as! String
                        let membermobile=dictTemporaryDictionary.object(forKey: "membermobile")as? String ?? ""
//                        let profileID=dictTemporaryDictionary.object(forKey: "profileID")as! String
                        let classification=dictTemporaryDictionary.object(forKey: "classification")as? String ?? ""

                        //self.functionForSaveData(masterUID, grpID: grpID, profileID: profileID, memberName: memberName, membermobile: membermobile, pic: pic, distDesignation: distDesignation)
                        
                        if (contactDB?.open())!
                        {
                            
                            let insertSQL = "INSERT INTO clubMember_Segment_List (masterUID,grpID,profileID,memberName,membermobile,pic,distDesignation,classification) VALUES('"+masterUID+"','"+grpID+"','"+profileID+"','"+memberName+"','"+membermobile+"','"+pic+"','"+distDesignation+"','"+classification+"')"
                            print("This is insert query :----")
                            print(insertSQL)
                            let result = contactDB?.executeStatements(insertSQL)
                            if (result == nil)
                            {
                                print("ErrorAi: \(contactDB?.lastErrorMessage())")
                            }
                            else
                            {
                                print("success")
                            }
                        }
                        else
                        {
                            print("Error: \(contactDB?.lastErrorMessage())")
                        }
                    }
                    //---------------------------------------------------------------------------------------------
                    //27.05.2019 this is code for adding classification start------
                    
                    /*clubMember_Segment_List_DropDown_Classification (_id INTEGER PRIMARY KEY AUTOINCREMENT,masterUID TEXT, classificationName TEXT)"*/
                    print((((dd.object(forKey: "TBMemberList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "Table1")! as AnyObject).count)
//                    for i in 0 ..< (((dd.object(forKey: "TBMemberList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "Table1")! as AnyObject).count
//                    {
//                        // print()
//                        var dictTemporaryDictionary:NSDictionary=(((dd.object(forKey: "TBMemberList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "Table1") as! AnyObject).object(at: i)
//                        print("This is classification data later add -on")
//                        print(dictTemporaryDictionary)
//                        let classificationName=dictTemporaryDictionary.object(forKey: "classification")as! String
//                        print(classificationName)
//                        if (contactDB?.open())!
//                        {
//                            let insertSQL = "INSERT INTO clubMember_Segment_List_DropDown_Classification(classification) VALUES('"+classificationName+"')"
//                            let result = contactDB?.executeStatements(insertSQL)
//                            if (result == nil)
//                            {
//                                print("ErrorAi: \(contactDB?.lastErrorMessage())")
//                            }
//                            else
//                            {
//                                print("success")
//                            }
//                        }
//                        else
//                        {
//                            print ("Error: \(contactDB?.lastErrorMessage())")
//                        }
//                    }
                    //27.05.2019 this is code for adding classification end
                    //-----------------------------------------------------------------------------------------------
                    self.lblPleaseWait.isHidden=true
                    self.directoryTableView.isHidden=false
                    self.fetchData("0")
                }
                else
                {
                    SVProgressHUD.dismiss()
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                    self.lblPleaseWait.text="Could not connect to server."
                    self.directoryTableView.isHidden=true                }
                SVProgressHUD.dismiss()
            }
        })
    }
    //---save data
    /*
     func functionForSaveData(masterUID:String,grpID:String,profileID:String,memberName:String,membermobile:String,pic:String,distDesignation:String)
     {
     var databasePath : String
     let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
     let fileURL = documents.URLByAppendingPathComponent("NewTouchbase.db")
     // open database
     databasePath = fileURL!.path!
     var db: COpaquePointer = nil
     if sqlite3_open(fileURL!.path!, &db) != SQLITE_OK
     {
     print("error opening database")
     }
     else
     {
     }
     let contactDB = FMDatabase(path: databasePath as String)
     if contactDB == nil
     {
     print("Error: \(contactDB.lastErrorMessage())")
     }
     if (contactDB?.open())!
     {
     
     let insertSQL = "INSERT INTO clubMember_Segment_List (masterUID,grpID,profileID,memberName,membermobile,pic,distDesignation) VALUES('"+masterUID+"','"+grpID+"','"+profileID+"','"+memberName+"','"+membermobile+"','"+pic+"','"+distDesignation+"')"
     
     let result = contactDB?.executeStatements(insertSQL)
     if (result == nil)
     {
     print("ErrorAi: \(contactDB?.lastErrorMessage())")
     }
     else
     {
     print("success")
     }
     
     }
     else
     {
     print("Error: \(contactDB?.lastErrorMessage())")
     }
     self.fetchData()
     }
     */
    
    
    
    /*------------------------------Search by Name And Mobile Number-------------by dpk----------------------------*/
    func fetchDataFORClubName(_ varClubName:String)
    {
        mainArray=NSMutableArray()
        var moduleID = UserDefaults.standard.string(forKey: "session_GetModuleId")
        var GroupID = UserDefaults.standard.string(forKey: "session_GetGroupId")
        
        var databasePath : String
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
        //masterUID, groupId , moduleId , profileID , MemberDesignation , memberName , pic , membermobile From Board_Of_Directors_List
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
            
        {
            
            //let querySQL = "SELECT * FROM ProfileMaster where memberName like '%\(varClubName)%' or memberMobile like '%\(varClubName)%' and grpId = '\(GroupID!)'"
            // When Search narendra and No available in directory but show in after search
            //let querySQL = "SELECT * FROM ProfileMaster where grpId  = '\(grpID)' and memberName like '%\(varClubName)%' or  memberMobile like '%\(varClubName)%' order by memberName asc"
            //let querySQL = "SELECT * FROM clubMember_Segment_List where (grpId  = '\(grpID)' and memberName like '%\(varClubName)%')  or (grpId  = '\(grpID)' and  memberMobile like '%\(varClubName)%') and distDesignation = '0' order by memberName asc"
            
            
            
            //
            var querySQL:String! = ""
            
            if(UserDefaults.standard.value(forKey: "Session_ModuleNameForNavigationHeading_FindAClubOrClubs") != nil && UserDefaults.standard.value(forKey: "Session_ModuleNameForNavigationHeading_FindAClubOrClubs") as! String == "Find a Club")
            {
                querySQL = "SELECT masterUID,grpID,profileID,memberName,membermobile,pic,distDesignation  FROM clubMember_Segment_List where  grpId  = '\(grpID!)' and  ( memberMobile like '%\(varClubName)%' or memberName like '%\(varClubName)%' ) order by memberName  COLLATE NOCASE  asc"
                
            }
            else
            {
                
                
                querySQL = "SELECT masterUID,grpID,profileID,memberName,membermobile,pic,distDesignation  FROM clubMember_Segment_List where  grpId  = '\(grpID!)' and  ( memberMobile like '%\(varClubName)%' or memberName like '%\(varClubName)%' ) order by memberName  COLLATE NOCASE  asc"
            }
            
            
            
            
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            
            while results?.next() == true {
                let dd = NSMutableDictionary ()
                //(masterUID,grpID,profileID,memberName,membermobile,pic,distDesignation)
                dd.setValue((results?.string(forColumn: "masterUID"))! as String, forKey:"masterUID")
                dd.setValue((results?.string(forColumn: "grpID"))! as String, forKey:"grpID")
                dd.setValue((results?.string(forColumn: "profileID"))! as String, forKey:"profileID")
                dd.setValue((results?.string(forColumn: "memberName"))! as String, forKey:"memberName")
                dd.setValue((results?.string(forColumn: "membermobile"))! as String, forKey:"membermobile")
                dd.setValue((results?.string(forColumn: "pic"))! as String, forKey:"pic")
                dd.setValue((results?.string(forColumn: "distDesignation"))! as String, forKey:"distDesignation")
                mainArray.add(dd)
                //print(dd)
            }
            if mainArray.count > 0
            {
                NoRecordLabel.isHidden = true
                copymainArray=mainArray
                directoryTableView.reloadData()
            }
            else
            {
                NoRecordLabel.isHidden = false
                mainArray = NSMutableArray()
                copymainArray=NSArray()
                directoryTableView.reloadData()
            }
        }
    }
    
    func fetchDataFORDistrictCommitee(_ varClubName:String)
    {
        mainArray=NSMutableArray()
        var moduleID = UserDefaults.standard.string(forKey: "session_GetModuleId")
        var GroupID = UserDefaults.standard.string(forKey: "session_GetGroupId")
        
        var databasePath : String
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
        //masterUID, groupId , moduleId , profileID , MemberDesignation , memberName , pic , membermobile From Board_Of_Directors_List
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
            
        {
            var querySQL:String! = ""
          
                    querySQL = "SELECT *  FROM clubMember_Segment_List_DropDown_Classification where classification like '"+varClubName+"%' "
           
            print("This is value from server :-----!!!!1")
         print(querySQL)
            
            
            
            
            
            
            
            
            
            
            mainArray = NSMutableArray()
            isRotarianorClassification="Classification"
            print("sdfhhdsfgh as hfjhd gh a hfakjsd hfjkasdh f")
            print(isRotarianorClassification)
            ////////////gyjgtjhhjthjthjtjhtjhtjht/hjt/hjt/h/th//ht/jhthj/t
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            
            var varCounting:Int!=0
            
            while results?.next() == true {
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "classification"))! as String, forKey:"classification")
                
                mainArray.add(dd)
                varCounting=varCounting+1
                print(dd)
            }
            if mainArray.count > 0
            {
                NoRecordLabel.isHidden = true
                copymainArray=mainArray
                directoryTableView.reloadData()
            }
            else
            {
                NoRecordLabel.isHidden = false
                mainArray = NSMutableArray()
                copymainArray=NSArray()
                self.labelFirstLoading.isHidden=true
                self.buttonOpacityFirstTime.isHidden=true
                directoryTableView.reloadData()
            }
            //------
            
            
            // self.window = nil
            let Count = "SELECT count(*) as Count from clubMember_Segment_List where distDesignation = '0' "
            // print(Count)
            let resultss:FMResultSet? = contactDB?.executeQuery(Count,withArgumentsIn: nil)
            
            while resultss?.next() == true
            {
                varGetCount=resultss?.string(forColumn: "Count")
            }
            varGetCount=String(varCounting)
            directoryTableView.reloadData()
           // textfieldForRotarianSearch.resi
            ////d/d/gd/g/dh/d/hgd/fgd/fgd/gf/dgf/dfg/dfg/d/fd/fgd/gfd/fg/d
         /*
            print(buttonSearchRotarianType.titleLabel!.text)

           // buttonSearchRotarianType.te
            
            let querySQL = "SELECT *  FROM clubMember_Segment_List where classification = '"+textfieldForRotarianSearch.text!+"'  order by classification  COLLATE NOCASE asc"
            
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            
            while results?.next() == true {
                let dd = NSMutableDictionary ()
                //(masterUID,grpID,profileID,memberName,membermobile,pic,distDesignation)
                dd.setValue((results?.string(forColumn: "masterUID"))! as String, forKey:"masterUID")
                dd.setValue((results?.string(forColumn: "grpID"))! as String, forKey:"grpID")
                dd.setValue((results?.string(forColumn: "profileID"))! as String, forKey:"profileID")
                dd.setValue((results?.string(forColumn: "memberName"))! as String, forKey:"memberName")
                dd.setValue((results?.string(forColumn: "membermobile"))! as String, forKey:"membermobile")
                dd.setValue((results?.string(forColumn: "pic"))! as String, forKey:"pic")
                dd.setValue((results?.string(forColumn: "distDesignation"))! as String, forKey:"distDesignation")
                mainArray.add(dd)
                //print(dd)
            }
            if mainArray.count > 0
            {
                NoRecordLabel.isHidden = true
                copymainArray=mainArray
                directoryTableView.reloadData()
            }
            else
            {
                NoRecordLabel.isHidden = false
                mainArray = NSMutableArray()
                copymainArray=NSArray()
                directoryTableView.reloadData()
            }
        }
        */
    }
    }
    
    
}

