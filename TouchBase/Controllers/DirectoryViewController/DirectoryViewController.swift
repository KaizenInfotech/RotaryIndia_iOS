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
import SVProgressHUD
import UIKit
//i//mport Kingfisher
import Alamofire
//import WPZipArchive
import SDWebImage
import SSZipArchive

var itshouldbeUpdatefromEditUpdate:Int!=0

protocol ptotocolForDirectoryScrenBackValue {
    func functionForCallingOnDirctoryuScrrenWhenBackFromProfileDynamic()
}
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


class DirectoryViewController: UIViewController,UITextFieldDelegate,webServiceDelegate,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating , UIPickerViewDelegate , UIPickerViewDataSource,ptotocolForDirectoryScrenBackValue,UITableViewDataSource,UITableViewDelegate
{
    //-----------------------------------------------------------------------------------------
    
    var dirOnline: DirectoryOnline?
    var memberDetailMemberName: [MemberDetailElement]?
    var tfCount = 0
    var memCount = 0
    
    var classOnline: DirectoryClassificationOnline?
    var classiDetailMemberName: [Resultses]?
    var classiList = [String]()
    
   var familyOnline: DirectoryFamilyOnline?
   var famDetailMemberName: [FamilyResult]?
   var filterFam = [String]()
   var filterpro = [String]()
   var famMemList = [String]()
   var famProfileList = [String]()
    
   
    
    
    func pdfDataWithTableView(tableView: UITableView) {
        let priorBounds = tableView.bounds
        let fittedSize = tableView.sizeThatFits(CGSize(width:priorBounds.size.width, height:tableView.contentSize.height))
        tableView.bounds = CGRect(x:0, y:0, width:fittedSize.width, height:fittedSize.height)
        let pdfPageBounds = CGRect(x:0, y:0, width:tableView.frame.width, height:self.view.frame.height)
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds,nil)
        var pageOriginY: CGFloat = 0
        while pageOriginY < fittedSize.height {
            UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
            UIGraphicsGetCurrentContext()!.saveGState()
            UIGraphicsGetCurrentContext()!.translateBy(x: 0, y: -pageOriginY)
            tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
            UIGraphicsGetCurrentContext()!.restoreGState()
            pageOriginY += pdfPageBounds.size.height
        }
        UIGraphicsEndPDFContext()
        tableView.bounds = priorBounds
        var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        docURL = docURL.appendingPathComponent("myDocument.pdf")
        pdfData.write(to: docURL as URL, atomically: true)
    }
    //-------------------------------------------------------------------------------------------
    var searchButton = UIButton()
    var search = UIBarButtonItem()
    //--pull to refresh data on collection view
    func refresh(_ sender:AnyObject) {
        // Code to refresh table view

        if(varGetPickerSelectValue == "Classification")
        {
            self.refreshControl?.endRefreshing()
            self.refreshControl?.isHidden=true
        }
        else
        {
            print("This is pull to refresh:---")
            //functionForGetNewUpdateDeleteMember()
            self.refreshControl?.endRefreshing()
            self.refreshControl?.isHidden=true
        }
        
    }
    
    var muarayForRefreshData:NSMutableArray=NSMutableArray()
    var varRefreshDirectory:String! = ""
    var varRefreshDatRunOneTime:String! = ""
    
    @IBOutlet weak var buttonUp: UIButton!
    @IBAction func buttonUpClickEvent(_ sender: AnyObject)
    {
        buttonUp.isHidden=true
         buttonDown.isHidden=true
       // directoryTableView.setContentOffset(CGPointZero, animated:true)
        let top = IndexPath(row: NSNotFound , section: 0)
        directoryTableView.scrollToRow(at: top, at: .bottom, animated: true)
    }
    
    @IBOutlet weak var buttonDown: UIButton!
    
    
    @IBAction func buttonDownClickEvent(_ sender: AnyObject)
    {
        buttonUp.isHidden=true
        buttonDown.isHidden=true
        let indexPath = IndexPath(row: mainArray.count - 1, section: 0)
        self.directoryTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    var varGetTotalFilesCount:Int!=0
    var varGetForLoopCounting:Int!=0

    var varGetZipFileUrl:String!=""
    var varGetSearchTextL:String!=""
    var NormalMemberOrAdmin:String!=""
    
    var refresher:UIRefreshControl!
    var refreshControl: UIRefreshControl!
    
    
    /*æææææææææææææææææææcode by depak*/
    func functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDown(_ stringSearchText:String?)
    {
        
        var moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
        var GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        
        memberDetailMemberName?.removeAll()
        
        
        
        if (varGetPickerSelectValue == "Rotarian")
        {
            buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
            fetchData()
        }
        else if (varGetPickerSelectValue == "Classification")
        {
            filterdsgns.removeAll()
            var memberDetail = self.classOnline?.classificationListResult.result
            let filteredMembers = memberDetail?.filter { member in
                guard let memberName = member.classification?.lowercased(),
                      let clubName = stringSearchText?.lowercased() else {
                    return false // Return false if either memberName or clubName is nil
                }
                print("clubName\(clubName)")
                return memberName.contains(clubName) // Return true if memberName contains clubName
            }
            self.classiDetailMemberName = filteredMembers
            print("FILTERED CLUB NAME:: \(memberDetail)")
            print("FILTERED CLUB123 NAME:: \(self.classiDetailMemberName?.count)")
            
            for i in 0 ..< (self.classiDetailMemberName?.count ?? 0) {
                var dssgn = self.classiDetailMemberName?[i].classification ?? ""
                filterdsgns.append(dssgn)
                print("filterdsgns:: \(filterdsgns)")
            }
            
            if (self.filterdsgns.count == 0) && (self.tfCount != 0) {
    //            directoryTableView.isHidden = true
                NoRecordLabel.isHidden = false
            } else {
                directoryTableView.isHidden = false
                NoRecordLabel.isHidden = true
            }
            
            directoryTableView.reloadData()

        }
            
        else if (varGetPickerSelectValue == "Family")
        {
            filterFam.removeAll()
            filterpro.removeAll()
            var memberDetail = self.familyOnline?.tbGetRotarianResult.result
            let filteredMembers = memberDetail?.filter { member in
                guard let memberName = member.memberName?.lowercased(),
                      let clubName = stringSearchText?.lowercased() else {
                    return false // Return false if either memberName or clubName is nil
                }
                print("clubName\(clubName)")
                return memberName.contains(clubName) // Return true if memberName contains clubName
            }
            self.famDetailMemberName = filteredMembers
            print("FILTERED CLUB NAME:: \(memberDetail)")
            print("FILTERED CLUB123 NAME:: \(self.famDetailMemberName?.count)")
            
            for i in 0 ..< (self.famDetailMemberName?.count ?? 0) {
                var dssgn = self.famDetailMemberName?[i].memberName ?? ""
                var profiles = self.famDetailMemberName?[i].profileID ?? ""
                filterFam.append(dssgn)
                filterpro.append(profiles)
                print("filterdsgns:: \(filterFam)")
            }
            
            if (self.filterFam.count == 0) && (self.tfCount != 0) {
    //            directoryTableView.isHidden = true
                NoRecordLabel.isHidden = false
            } else {
                directoryTableView.isHidden = false
                NoRecordLabel.isHidden = true
            }
            
            directoryTableView.reloadData()
            
        }
        else
        {
            buttonOpticity.isHidden = true
            viewForSettingPicker.isHidden = true
        }
        buttonOpticity.isHidden = true
        viewForSettingPicker.isHidden = true
        
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        // Check if the URL is valid
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        // Create a URLSessionDataTask to download the image data
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(nil)
                return
            }

            // Check if there is data
            guard let data = data else {
                completion(nil)
                return
            }

            // Create a UIImage from the downloaded data
            if let image = UIImage(data: data) {
                // Call the completion handler with the downloaded image
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }

    /*æææææææææææææææææææcode by deepak for cahnge in family or rotariam classified*/
    @IBOutlet weak var buttonOpacityFirstTime: UIButton!
    
    
    @IBOutlet weak var buttonSearchRotarianType: UIButton!
    
    
    @IBOutlet weak var textfieldForRotarianSearch: UITextField!
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var pickerSelectSettingMyProfileAboutPicker: UIPickerView!
    @IBOutlet weak var buttonDonOnPicker: UIButton!
    @IBOutlet weak var viewForSettingPicker: UIView!
    @IBOutlet weak var labelFirstLoading: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var NoRecordLabel: UILabel!
    @IBOutlet var directoryTableView: UITableView!

    
    var mainArraySettingForPicker = NSArray()
    var varGetPickerSelectValue:String! = ""
    var varISPopVisisbleorNot:Int!=0
    var varGetCount:String!=""
    
    
    
   
    
    internal typealias ActionButtonAction = (DirectoryViewController) -> Void
    internal var action: ActionButtonAction?
    
    var actionButton: ActionButton!
    let bounds = UIScreen.main.bounds
    let searchTextField = UITextField()
    let btnsearch = UIButton()
    let screenSize: CGRect = UIScreen.main.bounds
    var appDelegate : AppDelegate = AppDelegate()
    
    var mainArray : NSMutableArray!
    var copymainArray:NSArray!
    var grpID: NSString!
    var isAdmin:String! = ""
    var moduleId:NSString!
    var moduleName:String! = ""
    var isCategory:String! = ""
    var groupUniqueName:String!=""
    var dsgns = [String]()
    var filterdsgns = [String]()
    
    
    
    var userID:String! = ""
    let loaderClass  = WebserviceClass()
    ///ganesh
    fileprivate var floatButton: UIButton!
    
    //MARK:- SearchBar
    
    var searchController: UISearchController!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton=true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        mainArray.removeAllObjects()
        self.mainArray=NSMutableArray()
        searchBar.showsCancelButton = false
        //print("searchText \(searchBar.text)")
        varGetSearchTextL = searchBar.text!
        //////
        if (varGetPickerSelectValue == "Rotarian")
        {
            buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
            mainArray.removeAllObjects()     //DPK
            mainArray = NSMutableArray()
            fetchDataFORClubName(varGetSearchTextL)  //DPK
            searchBar.resignFirstResponder()
            
            /////
             
        }
        else if (varGetPickerSelectValue == "Classification")
        {
            functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDown(varGetSearchTextL)
        }
        else if (varGetPickerSelectValue == "Family")
        {
 functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDown(varGetSearchTextL)
        }
        searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController)
        
    {
        searchBar.showsCancelButton = false
        let varGetText=searchController.searchBar.text
        if(varGetText?.characters.count<=0 && varGetText != "")
        {
            searchController.searchBar.placeholder="Enter Salon Name"
            varGetSearchTextL = ""
        }
            
        else if searchController.searchBar.text != nil
        {
            searchController.searchBar.placeholder="Enter Salon Name"
        }
    }
    
    
    //    func didPresentSearchController(searchController: UISearchController) {
    //        searchBar.showsCancelButton = false
    //    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        varGetSearchTextL = ""
        if (varGetPickerSelectValue == "Rotarian")
        {
            buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
            mainArray.removeAllObjects()     //DPK
            mainArray = NSMutableArray()
            fetchDataFORClubName(varGetSearchTextL)  //DPK
            searchBar.resignFirstResponder()
        }
        else if (varGetPickerSelectValue == "Classification")
        {
            varGetSearchTextL = ""
            functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDown(varGetSearchTextL)
            
        }
        else if (varGetPickerSelectValue == "Family")
        {
            
            varGetSearchTextL = ""
            functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDown(varGetSearchTextL)
        }
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    
    
    
    
    
    /*--------------------------------------------------searchBar-----------------------------------------------*/
    
    
    
    //MARK:- viewdid load and view will appear
   
    
    
    
    func createNavigationBar(){
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
        buttonleft.addTarget(self, action: #selector(DirectoryViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
      
        
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DirectoryViewController.AddEventAction))
//        add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
//        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
//        
//         searchButton = UIButton(type: UIButton.ButtonType.custom)
//        searchButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
//        searchButton.setImage(UIImage(named:"refresh"),  for: UIControl.State.normal)
//        searchButton.addTarget(self, action: #selector(DirectoryViewController.RefreshDataClickEvent), for: UIControl.Event.touchUpInside)
//    
//         search = UIBarButtonItem(customView: searchButton)
       
//        if mainMemberID == "Yes"
//        {
//             if(isCategory=="2")
//             {
//                let buttons : NSArray = [search]
//                self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
//             }
//            else
//             {
//
//                let buttons : NSArray = [add,search]
//                self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
//              // self.navigationItem.rightBarButtonItem = add
//             }
//        }
//        else
//        {
//            let buttons : NSArray = [search]
//            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
//        }
        //Partial
    }
    @objc func RefreshDataClickEvent()
    {
        print("refresh button clicked now directoryviewcontrollewr !!!")
        SVProgressHUD.show()
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
        //1.
        let insertSQLDelete1 = "DELETE FROM  ProfileMaster"
        let result1 = contactDB?.executeStatements(insertSQLDelete1)
        if (result1 == nil)
        {
            print("ErrorAi: \(contactDB?.lastErrorMessage())")
        }
        //2.
        let insertSQLDelete2 = "DELETE FROM  PersonalBusinessMemberDetails"
        let result2 = contactDB?.executeStatements(insertSQLDelete2)
        if (result2 == nil)
        {
            print("ErrorAi: \(contactDB?.lastErrorMessage())")
        }
        //3.
        let insertSQLDelete3 = "DELETE FROM  AddressDetails"
        let result3 = contactDB?.executeStatements(insertSQLDelete3)
        if (result3 == nil)
        {
            print("ErrorAi: \(contactDB?.lastErrorMessage())")
        }
        //4.
        let insertSQLDelete4 = "DELETE FROM  FamilyMemberDetail"
        let result4 = contactDB?.executeStatements(insertSQLDelete4)
        if (result4 == nil)
        {
            print("ErrorAi: \(contactDB?.lastErrorMessage())")
        }
        
        print("Deepak")
         searchButton.isEnabled=false
         search.isEnabled=false
      //  navigationItem.rightBarButtonItems!.enabled = false
        if(varRefreshDatRunOneTime=="First")
        {
            
            buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
            varGetPickerSelectValue = "Rotarian"
           
            print("Before",varRefreshDatRunOneTime)
            buttonOpacityFirstTime.isHidden=false
            labelFirstLoading.isHidden=false
            //self.loaderClass.loaderViewMethod()
            //fetchDataFORGetProfileID(grpID as String)
            functionForDeleteMembersRefreshDataGroupID()
//            functionForGetZipFilePath()
            
            print("After",varRefreshDatRunOneTime)
        }
 
       
        
        
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func AddEventAction()
    {
        //varRefreshDatRunOneTime="Second"
        
        //       let profVC = self.storyboard!.instantiateViewControllerWithIdentifier("contact_list") as! AddContactsToGroupController
        //iphone  profVC.GroupID =  grpID as String
        //        self.navigationController?.pushViewController(profVC, animated: true)
        
       // let indexPath = IndexPath(row: mainArray.count - 1, section: 0)
       // self.directoryTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)

        // let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 4 * Int64(NSEC_PER_SEC))
       // dispatch_after(time, dispatch_get_main_queue()) {
            // Put your code which should be executed with a delay here
           
       // }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.pdfDataWithTableView(tableView: self.directoryTableView)
        })

        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "add_member_group") as! AddMemberToGroupController
        profVC.GroupID =  grpID as String
        self.navigationController?.pushViewController(profVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if (varGetPickerSelectValue == "Classification")
        {
//            return classiList.count 
            if ((classiList.count != 0) && (self.filterdsgns.count == nil) && (self.tfCount == 0)) {
                print("Classification list count \(classiList.count)")
                return classiList.count
            } else if ((classiList.count != 0) && (self.filterdsgns.count == 0) && (self.tfCount == 0)) {
                print("Classification list count \(classiList.count)")
                return classiList.count
            } else if (self.filterdsgns.count != nil) && (self.tfCount != 0){
                print("self.memberDetailMemberName?.count \(self.filterdsgns.count ?? 0)")
                return self.filterdsgns.count ?? 0
            } else if ((self.filterdsgns.count == 0) && (self.tfCount != 0)){
                print("self.memberDetailMemberName?.count123 \(self.filterdsgns.count)")
                return 0
            } else {
                return 0
            }
        }
            
        else if(varGetPickerSelectValue == "Family")
        {
            if ((famMemList.count != 0) && (self.filterFam.count == nil) && (self.tfCount == 0)) {
                print("Classification list count \(famMemList.count)")
                return famMemList.count
            } else if ((famMemList.count != 0) && (self.filterFam.count == 0) && (self.tfCount == 0)) {
                print("Classification list count \(famMemList.count)")
                return famMemList.count
            } else if (self.filterFam.count != nil) && (self.tfCount != 0){
                print("self.memberDetailMemberName?.count \(self.filterFam.count ?? 0)")
                return self.filterFam.count ?? 0
            } else if ((self.filterFam.count == 0) && (self.tfCount != 0)){
                print("self.memberDetailMemberName?.count123 \(self.filterdsgns.count)")
                return 0
            } else {
                return 0
            }

        }
        else if (varGetPickerSelectValue == "Rotarian")
        {
            print("self.memberDetailMemberName?.count. Check :: \(self.memberDetailMemberName?.count)")
            print("TFCOUNT. Check :: \(self.tfCount)")
          print("Rotarian list count \(mainArray.count)")
            var countss = 0
            if let countsss = dirOnline?.memberDetail?.memberDetails?.count {
                countss = countsss
                print("countss:: \(countss)")
            }
            if ((countss != 0) && (self.memberDetailMemberName?.count == nil) && (self.tfCount == 0)) {
                    print("self.dirOnline?.memberDetail?.memberDetails?.count1 \(self.dirOnline?.memberDetail?.memberDetails?.count)")
                    return countss
            } else  if ((countss != 0) && (self.memberDetailMemberName?.count == 0) && (self.tfCount == 0)) {
                print("self.dirOnline?.memberDetail?.memberDetails?.count1 \(self.dirOnline?.memberDetail?.memberDetails?.count)")
                return countss
        } else if (self.memberDetailMemberName?.count != nil) && (self.tfCount != 0) {
                print("self.memberDetailMemberName?.count12 \(self.memberDetailMemberName?.count)")
                return self.memberDetailMemberName?.count ?? 0
            } else if (self.memberDetailMemberName?.count == 0) && (self.tfCount != 0) {
                print("self.dirOnline?.memberDetail?.memberDetails?.count123 \(countss)")
                print("self.memberDetailMemberName?.count \(self.memberDetailMemberName?.count)")
                return 0
            } else {
                return 0
            }
//            return 1
        }
        else
        {
            return 0
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        searchBar.resignFirstResponder()
        if scrollView == directoryTableView
        {
//            buttonUp.isHidden=false
//            buttonDown.isHidden=false
//            //print(varGetCount)
//            //self.lastKnowContentOfsset = scrollView.contentOffset.y
//            // print("lastKnowContentOfsset: ", scrollView.contentOffset.y)
            if (varGetPickerSelectValue == "Rotarian") {
                self.view.makeToast("Total members "+varGetCount, duration: 2, position: CATransitionSubtype.fromBottom)
            }
//             /* var helloWorldTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #*/selector(DirectoryViewController.functionForHideTopandDownButton), userInfo: nil, repeats: false)
        }
    }
  
    
    @objc func functionForHideTopandDownButton()
    {
         NSLog("hello World")
         buttonUp.isHidden=true
         buttonDown.isHidden=true
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
        else  if (varGetPickerSelectValue == "Classification")
        {
            return 57
            
        }
        else if (varGetPickerSelectValue == "Family")
        {
            return 57
        }
        return 0
    }
    
    @objc func buttonPicBigViewClickEvent(_ sender:UIButton)
    {
        var countss = 0
        if let countsss = dirOnline?.memberDetail?.memberDetails?.count {
            countss = countsss
            print("countss:: \(countss)")
            print("self.memberDetailMemberName?.count :: \(self.memberDetailMemberName?.count)")
        }
        
        if ((countss != 0) && (self.memberDetailMemberName?.count == nil) && (tfCount == 0)) {
//            let  directoryList = mainArray[sender.tag] as? NSDictionary
            if dirOnline?.memberDetail?.memberDetails?.count ?? 0 > sender.tag {
                let  directoryList = dirOnline?.memberDetail?.memberDetails?[sender.tag].profilePic
                
                let isUpperImageAvailable = directoryList
                
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
        } else         if ((countss != 0) && (self.memberDetailMemberName?.count == 0) && (tfCount == 0)) {
            //            let  directoryList = mainArray[sender.tag] as? NSDictionary
            if dirOnline?.memberDetail?.memberDetails?.count ?? 0 > sender.tag {
                let  directoryList = dirOnline?.memberDetail?.memberDetails?[sender.tag].profilePic
                
                let isUpperImageAvailable = directoryList
                
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
        } else if (self.memberDetailMemberName?.count != nil) && (tfCount != 0) {
            if self.memberDetailMemberName?.count ?? 0 > sender.tag {
                let  directoryList = self.memberDetailMemberName?[sender.tag].profilePic
                
                let isUpperImageAvailable = directoryList
                
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
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "dirCell") as! DirectoryCell
//        let  directoryList = mainArray[indexPath.row] as! NSDictionary
        
        buttonOpacityFirstTime.isHidden=true
        labelFirstLoading.isHidden=true
        
         cell.buttonPicBigView.isHidden=true
        
        //print("This is countri9ng:-----")
        //print(indexPath.row)
        
        if (varGetPickerSelectValue == "Rotarian")
        {
            
            var countss = 0
            if let countsss = dirOnline?.memberDetail?.memberDetails?.count {
                countss = countsss
                print("countss:: \(countss)")
            }
            
            if ((countss != 0) && (self.memberDetailMemberName?.count == nil) && (self.tfCount == 0)) {
                    cell.viewClassified.isHidden=true
                    cell.viewFamily.isHidden=true
                    self.loaderClass.window = nil
                    cell.profilePic.isHidden=false
                    cell.nameLabel.isHidden=false
                    cell.buttonRotarian.isHidden=false
                    cell.buttonRotarian.addTarget(self, action: #selector(DirectoryViewController.buttonRotarianClicked(_:)), for: UIControl.Event.touchUpInside)
                    cell.buttonRotarian.tag=indexPath.row;
                cell.profilePic.layer.borderColor = UIColor.lightGray.cgColor
                if let memberNamess = self.dirOnline?.memberDetail?.memberDetails?[indexPath.row].memberName, let memberMobile = self.dirOnline?.memberDetail?.memberDetails?[indexPath.row].memberMobile, let img = self.dirOnline?.memberDetail?.memberDetails?[indexPath.row].profilePic {
                    cell.nameLabel.text   = memberNamess
                    cell.mobileLabel.text = memberMobile
                
                    if img == ""  || img == "profile_photo.png"
                    {
                        cell.profilePic.image = UIImage(named: "profile_pic")
                    }
                    else
                    {
                        let ImageProfilePic:String = img.replacingOccurrences(of: " ", with: "%20")
                        print("ImageProfilePic: \(ImageProfilePic)")
                        let checkedUrl = URL(string: ImageProfilePic)
                        cell.profilePic.sd_setImage(with: checkedUrl)
                    }
                    
                    print("memberNamess:: \(memberNamess)")
                    print("RessssData:: \(self.dirOnline?.memberDetail?.memberDetails?[0].memberName)")
                }
                cell.buttonPicBigView.tag=indexPath.row
                cell.buttonPicBigView.isHidden=false
                cell.buttonPicBigView.addTarget(self, action: #selector(DirectoryViewController.buttonPicBigViewClickEvent(_:)), for: UIControl.Event.touchUpInside)
                if(self.isCategory=="2")
                {
                    
                }
                else
                {
                    /*31-08-2017----------------------------------------------DPK-----------------------*/
                    //            let varGetImages = directoryList.object(forKey: "familyPic") as? String
                    let varGetImages = dirOnline?.memberDetail?.memberDetails?[indexPath.row].familyPic
                    
                    //            if directoryList.object(forKey: "familyPic") as! String == ""  || directoryList.object(forKey: "familyPic") as! String == "profile_photo.png"
                    if dirOnline?.memberDetail?.memberDetails?[indexPath.row].familyPic == ""  || dirOnline?.memberDetail?.memberDetails?[indexPath.row].familyPic == "profile_photo.png"
                    {
                        cell.familyPics.image = UIImage(named: "profile_pic")
                    }
                    else
                    {
                        
                        // /*------------------------------Code by --------------------DPK--------------------------- */
                        let ImageProfilePic:String = varGetImages?.replacingOccurrences(of: " ", with: "%20") ?? ""
                        print("ImageProfilePic: \(ImageProfilePic)")
                        let checkedUrl = URL(string: ImageProfilePic)
                        cell.familyPics.sd_setImage(with: checkedUrl)
                        
                    }
                    /*31-08-2017----------------------------------------------DPK-----------------------*/
                }
                
                cell.groupsLabel.text =  ""
                
                return cell
            } else if ((countss != 0) && (self.memberDetailMemberName?.count == 0) && (self.tfCount == 0)) {
                cell.viewClassified.isHidden=true
                cell.viewFamily.isHidden=true
                self.loaderClass.window = nil
                
                cell.profilePic.isHidden=false
                cell.nameLabel.isHidden=false
                //cell.mobileLabel.isHidden=false
                cell.buttonRotarian.isHidden=false
                
                cell.buttonRotarian.addTarget(self, action: #selector(DirectoryViewController.buttonRotarianClicked(_:)), for: UIControl.Event.touchUpInside)
                cell.buttonRotarian.tag=indexPath.row;
            
            cell.profilePic.layer.borderColor = UIColor.lightGray.cgColor
            if let memberNamess = self.dirOnline?.memberDetail?.memberDetails?[indexPath.row].memberName, let memberMobile = self.dirOnline?.memberDetail?.memberDetails?[indexPath.row].memberMobile, let img = self.dirOnline?.memberDetail?.memberDetails?[indexPath.row].profilePic {
                cell.nameLabel.text   = memberNamess
                cell.mobileLabel.text = memberMobile
                if img == ""  || img == "profile_photo.png"
                {
                    cell.profilePic.image = UIImage(named: "profile_pic")
                }
                else
                {
                    
                    // /*------------------------------Code by --------------------DPK--------------------------- */
                    let ImageProfilePic:String = img.replacingOccurrences(of: " ", with: "%20")
                    print("ImageProfilePic: \(ImageProfilePic)")
                    let checkedUrl = URL(string: ImageProfilePic)
                    cell.profilePic.sd_setImage(with: checkedUrl)
                    
                }
                
                print("memberNamess:: \(memberNamess)")
                print("RessssData:: \(self.dirOnline?.memberDetail?.memberDetails?[0].memberName)")
            }
            cell.buttonPicBigView.tag=indexPath.row
            cell.buttonPicBigView.isHidden=false
            cell.buttonPicBigView.addTarget(self, action: #selector(DirectoryViewController.buttonPicBigViewClickEvent(_:)), for: UIControl.Event.touchUpInside)
            
            if(self.isCategory=="2")
            {
                
            }
            else
            {
                /*31-08-2017----------------------------------------------DPK-----------------------*/
                //            let varGetImages = directoryList.object(forKey: "familyPic") as? String
                let varGetImages = dirOnline?.memberDetail?.memberDetails?[indexPath.row].familyPic
                
                //            if directoryList.object(forKey: "familyPic") as! String == ""  || directoryList.object(forKey: "familyPic") as! String == "profile_photo.png"
                if dirOnline?.memberDetail?.memberDetails?[indexPath.row].familyPic == ""  || dirOnline?.memberDetail?.memberDetails?[indexPath.row].familyPic == "profile_photo.png"
                {
                    cell.familyPics.image = UIImage(named: "profile_pic")
                }
                else
                {
                    
                    // /*------------------------------Code by --------------------DPK--------------------------- */
                    let ImageProfilePic:String = varGetImages?.replacingOccurrences(of: " ", with: "%20") ?? ""
                    print("ImageProfilePic: \(ImageProfilePic)")
                    let checkedUrl = URL(string: ImageProfilePic)
                    cell.familyPics.sd_setImage(with: checkedUrl)
                    
                }
                /*31-08-2017----------------------------------------------DPK-----------------------*/
            }
            
            cell.groupsLabel.text =  ""
            
            return cell
        } else if (self.memberDetailMemberName?.count != nil) && (self.tfCount != 0) {
            print(" CELL checking----------\(self.memberDetailMemberName)")
            
                cell.viewClassified.isHidden=true
                cell.viewFamily.isHidden=true
                self.loaderClass.window = nil
                
                cell.profilePic.isHidden=false
                cell.nameLabel.isHidden=false
                //cell.mobileLabel.isHidden=false
                cell.buttonRotarian.isHidden=false
                
                cell.buttonRotarian.addTarget(self, action: #selector(DirectoryViewController.buttonRotarianClicked(_:)), for: UIControl.Event.touchUpInside)
                cell.buttonRotarian.tag=indexPath.row;
                
                cell.profilePic.layer.borderColor = UIColor.lightGray.cgColor
                //            cell.nameLabel.text   =  directoryList.object(forKey: "memberName") as? String
                if let memberNamess = self.memberDetailMemberName?[indexPath.row].memberName, let memberMobile = self.memberDetailMemberName?[indexPath.row].memberMobile, let img = self.memberDetailMemberName?[indexPath.row].profilePic {
                    cell.nameLabel.text   = memberNamess
                    cell.mobileLabel.text = memberMobile
                    
                
                    if img == ""  || img == "profile_photo.png"
                    {
                        cell.profilePic.image = UIImage(named: "profile_pic")
                    }
                    else
                    {
                        
                        // /*------------------------------Code by --------------------DPK--------------------------- */
                        let ImageProfilePic:String = img.replacingOccurrences(of: " ", with: "%20")
                        print("ImageProfilePic: \(ImageProfilePic)")
                        let checkedUrl = URL(string: ImageProfilePic)
                        cell.profilePic.sd_setImage(with: checkedUrl)
                        
                    }
                    
                    print("memberNamess:: \(memberNamess)")
                    print("RessssData:: \(self.dirOnline?.memberDetail?.memberDetails?[0].memberName)")
                }
                
                //            cell.mobileLabel.text =  directoryList.object(forKey: "memberMobile") as? String
                
                cell.buttonPicBigView.tag=indexPath.row
                
                cell.buttonPicBigView.isHidden=false
                cell.buttonPicBigView.addTarget(self, action: #selector(DirectoryViewController.buttonPicBigViewClickEvent(_:)), for: UIControl.Event.touchUpInside)
            
                if(self.isCategory=="2")
                {
                    
                }
                else
                {
                    /*31-08-2017----------------------------------------------DPK-----------------------*/
                    //            let varGetImages = directoryList.object(forKey: "familyPic") as? String
                    let varGetImages = dirOnline?.memberDetail?.memberDetails?[indexPath.row].familyPic
                    
                    //            if directoryList.object(forKey: "familyPic") as! String == ""  || directoryList.object(forKey: "familyPic") as! String == "profile_photo.png"
                    if dirOnline?.memberDetail?.memberDetails?[indexPath.row].familyPic == ""  || dirOnline?.memberDetail?.memberDetails?[indexPath.row].familyPic == "profile_photo.png"
                    {
                        cell.familyPics.image = UIImage(named: "profile_pic")
                    }
                    else
                    {
                        
                        // /*------------------------------Code by --------------------DPK--------------------------- */
                        let ImageProfilePic:String = varGetImages?.replacingOccurrences(of: " ", with: "%20") ?? ""
                        print("ImageProfilePic: \(ImageProfilePic)")
                        let checkedUrl = URL(string: ImageProfilePic)
                        cell.familyPics.sd_setImage(with: checkedUrl)
                        
                    }
                    /*31-08-2017----------------------------------------------DPK-----------------------*/
                }
                
                cell.groupsLabel.text =  ""
                
                return cell
            } else if (self.memberDetailMemberName?.count == 0) && (self.tfCount != 0) {
                NoRecordLabel.isHidden = false
                return UITableViewCell()
            }
            }
            else if (varGetPickerSelectValue == "Classification")
            {
               
                cell.classifiedArrow.isHidden = false
                cell.viewClassified.isHidden=false
                cell.viewFamily.isHidden=true
                //            cell.labelClassified.text=directoryList.object(forKey: "value") as? String
                
                
                //            if let designationsss = dsgns{
                
                //            }
                self.loaderClass.window = nil
                //cell.mobileLabel.isHidden=true
                cell.profilePic.isHidden=true
                /////-----------
                ///
                if ((self.classiList.count != 0) && (self.filterdsgns.count == 0) && (self.tfCount == 0)) {
                cell.labelClassified.text = classiList[indexPath.row]
                print("designationsss::\(dsgns)")
            } else if (self.filterdsgns.count != 0) && (self.tfCount != 0) {
//                var dsgnation = memberDetailMemberName?[indexPath.row].designation ?? ""
//                filterdsgns.append(dsgnation)
                cell.labelClassified.text = filterdsgns[indexPath.row]
                print("designationsss::\(dsgns)")
            } else if ((self.classiList.count != 0) && (self.filterdsgns.count == 0) && (self.tfCount == 0)) {
                cell.labelClassified.text = self.classiList[indexPath.row]
                print("designationsss::\(dsgns)")
            } else if (self.filterdsgns.count == 0) && (self.tfCount != 0) {
                cell.labelClassified.text = ""
            }
                cell.groupsLabel.text =  ""
                cell.profilePic.isHidden=true
                cell.nameLabel.isHidden=true
                //cell.mobileLabel.isHidden=true
                cell.buttonRotarian.isHidden=true
                
                cell.buttonClassified.addTarget(self, action: #selector(DirectoryViewController.buttonClassifiedClicked(_:)), for: UIControl.Event.touchUpInside)
                cell.buttonClassified.tag=indexPath.row;
                return cell
            }
            else if (varGetPickerSelectValue == "Family")
            {
                
                self.loaderClass.window = nil
                cell.profilePic.isHidden=true
                cell.nameLabel.isHidden=true
                // cell.mobileLabel.isHidden=true
                cell.buttonRotarian.isHidden=true
                cell.viewClassified.isHidden=true
                cell.viewFamily.isHidden=false
                cell.buttonRotarian.isHidden=true
                cell.labelFamilyWithRelationShip.isHidden = true
                
   if ((self.famMemList.count != 0) && (self.filterFam.count == 0) && (self.tfCount == 0)) {
                    cell.labelFamilyMemberName.text = self.famMemList[indexPath.row]
                    
            } else if (self.filterFam.count != 0) && (self.tfCount != 0) {
                
                cell.labelFamilyMemberName.text = self.filterFam[indexPath.row]
                
            } else if ((self.famMemList.count != 0) && (self.filterFam.count == 0) && (self.tfCount == 0)) {
                
                cell.labelFamilyMemberName.text = self.famMemList[indexPath.row]
                
            } else if (self.filterFam.count == 0) && (self.tfCount != 0) {
                
                cell.labelFamilyMemberName.text = ""
                
            }
                cell.buttonFamilyMain.addTarget(self, action: #selector(DirectoryViewController.buttonFamilyMainClicked(_:)), for: UIControl.Event.touchUpInside)
                cell.buttonFamilyMain.tag=indexPath.row;
                return cell
            }
            return cell
    }
    
    @objc func buttonFamilyMainClicked(_ sender:UIButton)
    {
        //TODO: MANICHANGES

        let objProfileDynamicNewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController

        objProfileDynamicNewViewController.varGetPickerSelectValue="Family"
        
        if ((famMemList.count != 0) && (self.filterFam.count == nil) && (tfCount == 0)) {
            objProfileDynamicNewViewController.profileId=self.famProfileList[sender.tag]
        } else if ((famMemList.count != 0) && (self.filterFam.count == 0) && (tfCount == 0)) {
            objProfileDynamicNewViewController.profileId=self.famProfileList[sender.tag]
        } else if (self.filterFam.count != nil) && (tfCount != 0) {
            objProfileDynamicNewViewController.profileId=self.filterpro[sender.tag]
        }
        
        
        
        objProfileDynamicNewViewController.objptotocolForDirectoryScrenBackValue=self
        objProfileDynamicNewViewController.groupUniqueName=groupUniqueName
        
        self.navigationController?.pushViewController(objProfileDynamicNewViewController, animated: true)
    }
    
    @objc func buttonClassifiedClicked(_ sender:UIButton)
    {
        //TODO: MANICHANGES
        let objDirectoryClassifiedViewController = self.storyboard!.instantiateViewController(withIdentifier: "DirectoryClassifiedViewController") as! DirectoryClassifiedViewController
        objDirectoryClassifiedViewController.varGetPickerSelectValue="Classification"
        if ((classiList.count != 0) && (self.filterdsgns.count == nil) && (tfCount == 0)) {
            objDirectoryClassifiedViewController.groupID=self.grpID
            objDirectoryClassifiedViewController.classification=classiList[sender.tag]
        } else if ((classiList.count != 0) && (self.filterdsgns.count == 0) && (tfCount == 0)) {
            objDirectoryClassifiedViewController.groupID=self.grpID
            objDirectoryClassifiedViewController.classification=classiList[sender.tag]
        } else if (self.filterdsgns.count != nil) && (tfCount != 0) {
            objDirectoryClassifiedViewController.groupID=self.grpID
            objDirectoryClassifiedViewController.classification=filterdsgns[sender.tag]
        }
            objDirectoryClassifiedViewController.NormalMemberOrAdmin="Classification"
            objDirectoryClassifiedViewController.isCategory=isCategory
            objDirectoryClassifiedViewController.groupUniqueName=groupUniqueName
            self.navigationController?.pushViewController(objDirectoryClassifiedViewController, animated: true)
    }
    
    @objc func buttonRotarianClicked(_ sender:UIButton)
    {
//        textfieldForRotarianSearch.resignFirstResponder()
        var countss = 0
        if let countsss = dirOnline?.memberDetail?.memberDetails?.count {
            countss = countsss
            print("countss:: \(countss)")
            print("self.memberDetailMemberName?.count :: \(self.memberDetailMemberName?.count)")
        }
        
        if ((countss != 0) && (self.memberDetailMemberName?.count == nil) && (tfCount == 0)) {
//            var familys = [String]()
//            var bussAddrs = ""
//            var resAddrs = ""
//            var bussCntct = ""
//            var resCntct = ""
//            var bussName: String?
//            var bussMail: String?
//            var bussPosition: String?
            
            print("sender.tag::: \(sender.tag)")
            
            //        let  directoryList = mainArray[sender.tag] as! NSDictionary
            print(isCategory)
            
            let objProfileDynamicNewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
            
            objProfileDynamicNewViewController.varGetPickerSelectValue = "Rotarian"
            objProfileDynamicNewViewController.isAdminss = self.isAdmin
            var masterId = 0
            var profileId = 0
            var grppID = 0
            if dirOnline?.memberDetail?.memberDetails?.count ?? 0 > sender.tag {
                masterId =  dirOnline?.memberDetail?.memberDetails?[sender.tag].masterID ?? 0
                profileId = dirOnline?.memberDetail?.memberDetails?[sender.tag].profileID ?? 0
                grppID = dirOnline?.memberDetail?.memberDetails?[sender.tag].grpID ?? 0
            }
            
            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",profileId)
            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",masterId , userID)
            objProfileDynamicNewViewController.mastersId = masterId
            objProfileDynamicNewViewController.profileId = "\(profileId)"
            objProfileDynamicNewViewController.grpID = "\(grppID)"
            objProfileDynamicNewViewController.varAdminProfileID = self.userID
            
            //        objProfileDynamicNewViewController.mastersId = dirOnline?.memberDetail?.memberDetails[sender.tag].masterID
//            if dirOnline?.memberDetail?.memberDetails?.count ?? 0 > sender.tag {
//                objProfileDynamicNewViewController.userNam = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberName ?? ""
//                objProfileDynamicNewViewController.userImg = dirOnline?.memberDetail?.memberDetails?[sender.tag].profilePic ?? ""
//                objProfileDynamicNewViewController.mob = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberMobile ?? ""
//                objProfileDynamicNewViewController.secMob = dirOnline?.memberDetail?.memberDetails?[sender.tag].secondryMobileNo ?? ""
//                objProfileDynamicNewViewController.mail = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberEmail ?? ""
//                objProfileDynamicNewViewController.classifica = dirOnline?.memberDetail?.memberDetails?[sender.tag].designation ?? ""
//                objProfileDynamicNewViewController.kayProf = dirOnline?.memberDetail?.memberDetails?[sender.tag].keywords ?? ""
//                objProfileDynamicNewViewController.rotarId = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberRotaryID ?? ""
//                objProfileDynamicNewViewController.clubDesgn = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberMasterDesignation ?? ""
//                objProfileDynamicNewViewController.donor = dirOnline?.memberDetail?.memberDetails?[sender.tag].rotaryDonarRecognation ?? ""
//                objProfileDynamicNewViewController.bthday = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberDateOfBirth ?? ""
//                objProfileDynamicNewViewController.anniDate = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberDateOfWedding ?? ""
//                objProfileDynamicNewViewController.bldGrp = dirOnline?.memberDetail?.memberDetails?[sender.tag].bloodGroup ?? ""
//                objProfileDynamicNewViewController.famImg = dirOnline?.memberDetail?.memberDetails?[sender.tag].familyPic ?? ""
//                objProfileDynamicNewViewController.memIntro = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberInfo ?? ""
//                objProfileDynamicNewViewController.fb = dirOnline?.memberDetail?.memberDetails?[sender.tag].faceBookTxt ?? ""
//                objProfileDynamicNewViewController.insta = dirOnline?.memberDetail?.memberDetails?[sender.tag].instagramTxt ?? ""
//                objProfileDynamicNewViewController.lnkdin = dirOnline?.memberDetail?.memberDetails?[sender.tag].linkedInTxt ?? ""
//                objProfileDynamicNewViewController.web = dirOnline?.memberDetail?.memberDetails?[sender.tag].websiteTxt ?? ""
//                objProfileDynamicNewViewController.twit = (dirOnline?.memberDetail?.memberDetails?[sender.tag].twitterTxt ?? "") ?? ""
//                objProfileDynamicNewViewController.yt = dirOnline?.memberDetail?.memberDetails?[sender.tag].youtubeTxt ?? ""
//            }
//            
//            for i in 0 ..< (dirOnline?.memberDetail?.businessDetails?.count ?? 0) {
//                if dirOnline?.memberDetail?.businessDetails?[i].profileID == (profileId) {
//                    bussName = ("\(dirOnline?.memberDetail?.businessDetails?[i].businessName ?? "")")
//                    bussMail = ("\(dirOnline?.memberDetail?.businessDetails?[i].memberBussEmail ?? "")")
//                    bussPosition = ("\(dirOnline?.memberDetail?.businessDetails?[i].businessPosition ?? "")")
//                }
//            }
//            
//            if let mail = bussMail, let name = bussName, let dsgn = bussPosition {
//                objProfileDynamicNewViewController.bEmail = mail
//                objProfileDynamicNewViewController.bName = name
//                objProfileDynamicNewViewController.desgn = dsgn
//            }
//            
//            var busAd = ""
//            var busCity = ""
//            var busState = ""
//            var busCountry = ""
//            var busPincode = ""
//            var bacom = ""
//            var bccom = ""
//            var bscom = ""
//            var bcocom = ""
//            var bpcom = ""
//            
//            var resAd = ""
//            var resCity = ""
//            var resState = ""
//            var resCountry = ""
//            var resPincode = ""
//            var acom = ""
//            var ccom = ""
//            var scom = ""
//            var cocom = ""
//            var pcom = ""
//            
//            for i in 0 ..< (dirOnline?.memberDetail?.addressDetails?.count ?? 0) {
//                if dirOnline?.memberDetail?.addressDetails?[i].profileID == (profileId) {
//                    if dirOnline?.memberDetail?.addressDetails?[i].addressType == "Business" {
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].address == "") {
//                            busAd = dirOnline?.memberDetail?.addressDetails?[i].address ?? ""
//                            acom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].city == "") {
//                            busCity = dirOnline?.memberDetail?.addressDetails?[i].city ?? ""
//                            ccom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].state == "") {
//                            busState = dirOnline?.memberDetail?.addressDetails?[i].state ?? ""
//                            scom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].country == "") {
//                            busCountry = dirOnline?.memberDetail?.addressDetails?[i].country ?? ""
//                            cocom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].pincode == "") {
//                            busPincode = dirOnline?.memberDetail?.addressDetails?[i].pincode ?? ""
//                            pcom = "."
//                        }
//                        bussAddrs = busAd + acom + busCity + ccom + busState + scom + busCountry + cocom + busPincode + pcom
//                        bussCntct = dirOnline?.memberDetail?.addressDetails?[i].phoneNo ?? ""
//                    } else {
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].address == "") {
//                            resAd = dirOnline?.memberDetail?.addressDetails?[i].address ?? ""
//                            bacom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].city == "") {
//                            resCity = dirOnline?.memberDetail?.addressDetails?[i].city ?? ""
//                            bccom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].state == "") {
//                            resState = dirOnline?.memberDetail?.addressDetails?[i].state ?? ""
//                            bscom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].country == "") {
//                            resCountry = dirOnline?.memberDetail?.addressDetails?[i].country ?? ""
//                            bcocom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].pincode == "") {
//                            resPincode = dirOnline?.memberDetail?.addressDetails?[i].pincode ?? ""
//                            bpcom = "."
//                        }
//                        resAddrs = resAd + bacom + resCity + bccom + resState + bscom + resCountry + bcocom + resPincode + bpcom
//                        resCntct = dirOnline?.memberDetail?.addressDetails?[i].phoneNo ?? ""
//                    }
//                }
//            }
//            
//            //        if dirOnline?.memberDetail?.addressDetails?.count ?? 0 > sender.tag {
//            objProfileDynamicNewViewController.bAddrs = bussAddrs
//            objProfileDynamicNewViewController.bCntcNo = bussCntct
//            objProfileDynamicNewViewController.resAddres = resAddrs
//            //            objProfileDynamicNewViewController.city = dirOnline?.memberDetail?.addressDetails?[sender.tag].city ?? ""
//            //            objProfileDynamicNewViewController.state = dirOnline?.memberDetail?.addressDetails?[sender.tag].state ?? ""
//            //            objProfileDynamicNewViewController.country = dirOnline?.memberDetail?.addressDetails?[sender.tag].country ?? ""
//            //            objProfileDynamicNewViewController.pincode = dirOnline?.memberDetail?.addressDetails?[sender.tag].pincode ?? ""
//            //        }
//            var relation = ""
//            var relName = ""
//            
//            for i in 0 ..< (dirOnline?.memberDetail?.familyDetails?.count ?? 0) {
//                if dirOnline?.memberDetail?.familyDetails?[i].profileID == (profileId) {
//                    relation = dirOnline?.memberDetail?.familyDetails?[i].relationship ?? ""
//                    relName = dirOnline?.memberDetail?.familyDetails?[i].memberName ?? ""
//                }
//            }
//            
//            //        if dirOnline?.memberDetail?.familyDetails?.count ?? 0 > sender.tag {
//            objProfileDynamicNewViewController.relati = relation
//            objProfileDynamicNewViewController.mother = relName
//            objProfileDynamicNewViewController.resMob = resCntct
            //        }
            
            objProfileDynamicNewViewController.groupUniqueName=groupUniqueName
            
            objProfileDynamicNewViewController.isCategory=isCategory
            
            //objProfileDynamicNewViewController.isAdmin=isAdmin  //directoryList.objectForKey("isAdmin") as? String
            
            
            //        var varProfileID = NSUserDefaults.standardUserDefaults().valueForKey("session_grpProfileid") as! String
            //        print(varProfileID)
            //        print(profileId)
            
            //        if(varProfileID==profileId)
            //        {
            //            objProfileDynamicNewViewController.isAdmin="abc"
            //            objProfileDynamicNewViewController.NormalMemberOrAdmin="SelfNormalMemberFromMainDash"
            //        }
            //        else
            //        {
            //             objProfileDynamicNewViewController.isAdmin=isAdmin
            //            objProfileDynamicNewViewController.NormalMemberOrAdmin="NormalMemberFromMainDash"
            //        }
            //
            
            let varProfileID = UserDefaults.standard.value(forKey: "session_grpProfileid") as! String
            // print(varProfileID)
            if(varProfileID=="\(profileId)")
            {
                if(dirOnline?.memberDetail?.memberDetails?[sender.tag].isAdmin == "yes")
                {
                    
                    objProfileDynamicNewViewController.isAdmin = dirOnline?.memberDetail?.memberDetails?[sender.tag].isAdmin
                }
                else
                {
                    objProfileDynamicNewViewController.isAdmin="no"
                    //objProfileDynamicNewViewController.NormalMemberOrAdmin="NormalMemberFromMainDash"
                }
            }
            else
            {
                objProfileDynamicNewViewController.isAdmin=dirOnline?.memberDetail?.memberDetails?[sender.tag].isAdmin
                objProfileDynamicNewViewController.NormalMemberOrAdmin="NormalMemberFromMainDash"
            }
            //  print(directoryList)
            objProfileDynamicNewViewController.objptotocolForDirectoryScrenBackValue=self
            
            self.navigationController?.pushViewController(objProfileDynamicNewViewController, animated: true)
        } else if ((countss != 0) && (self.memberDetailMemberName?.count == 0) && (tfCount == 0)) {
//            var familys = [String]()
//            var bussAddrs = ""
//            var resAddrs = ""
//            var bussCntct = ""
//            var resCntct = ""
//            var bussName: String?
//            var bussMail: String?
//            var bussPosition: String?
            
            print("sender.tag::: \(sender.tag)")
            
            //        let  directoryList = mainArray[sender.tag] as! NSDictionary
            print(isCategory)
            
            let objProfileDynamicNewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
            objProfileDynamicNewViewController.varGetPickerSelectValue = "Rotarian"
            objProfileDynamicNewViewController.isAdminss = self.isAdmin
            //print(directoryList.objectForKey("isAdmin") as? String)
            //        let masterId =  directoryList.object(forKey: "masterId") as? String
            //        let profileId = directoryList.object(forKey: "profileId") as? String
            var masterId = 0
            var profileId = 0
            var grppID = 0
            if dirOnline?.memberDetail?.memberDetails?.count ?? 0 > sender.tag {
                masterId =  dirOnline?.memberDetail?.memberDetails?[sender.tag].masterID ?? 0
                profileId = dirOnline?.memberDetail?.memberDetails?[sender.tag].profileID ?? 0
                grppID = dirOnline?.memberDetail?.memberDetails?[sender.tag].grpID ?? 0
            }
            
            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",profileId)
            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",masterId , userID)
            objProfileDynamicNewViewController.mastersId = masterId
            objProfileDynamicNewViewController.profileId = "\(profileId)"
            objProfileDynamicNewViewController.grpID = "\(grppID)"
            objProfileDynamicNewViewController.varAdminProfileID = self.userID
            
            //        objProfileDynamicNewViewController.mastersId = dirOnline?.memberDetail?.memberDetails[sender.tag].masterID
//            if dirOnline?.memberDetail?.memberDetails?.count ?? 0 > sender.tag {
//                objProfileDynamicNewViewController.userNam = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberName ?? ""
//                objProfileDynamicNewViewController.userImg = dirOnline?.memberDetail?.memberDetails?[sender.tag].profilePic ?? ""
//                objProfileDynamicNewViewController.mob = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberMobile ?? ""
//                objProfileDynamicNewViewController.secMob = dirOnline?.memberDetail?.memberDetails?[sender.tag].secondryMobileNo ?? ""
//                objProfileDynamicNewViewController.mail = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberEmail ?? ""
//                objProfileDynamicNewViewController.classifica = dirOnline?.memberDetail?.memberDetails?[sender.tag].designation ?? ""
//                objProfileDynamicNewViewController.kayProf = dirOnline?.memberDetail?.memberDetails?[sender.tag].keywords ?? ""
//                objProfileDynamicNewViewController.rotarId = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberRotaryID ?? ""
//                objProfileDynamicNewViewController.clubDesgn = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberMasterDesignation ?? ""
//                objProfileDynamicNewViewController.donor = dirOnline?.memberDetail?.memberDetails?[sender.tag].rotaryDonarRecognation ?? ""
//                objProfileDynamicNewViewController.bthday = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberDateOfBirth ?? ""
//                objProfileDynamicNewViewController.anniDate = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberDateOfWedding ?? ""
//                objProfileDynamicNewViewController.bldGrp = dirOnline?.memberDetail?.memberDetails?[sender.tag].bloodGroup ?? ""
//                objProfileDynamicNewViewController.famImg = dirOnline?.memberDetail?.memberDetails?[sender.tag].familyPic ?? ""
//                objProfileDynamicNewViewController.memIntro = dirOnline?.memberDetail?.memberDetails?[sender.tag].memberInfo ?? ""
//                objProfileDynamicNewViewController.fb = dirOnline?.memberDetail?.memberDetails?[sender.tag].faceBookTxt ?? ""
//                objProfileDynamicNewViewController.insta = dirOnline?.memberDetail?.memberDetails?[sender.tag].instagramTxt ?? ""
//                objProfileDynamicNewViewController.lnkdin = dirOnline?.memberDetail?.memberDetails?[sender.tag].linkedInTxt ?? ""
//            }
//            
//            for i in 0 ..< (dirOnline?.memberDetail?.businessDetails?.count ?? 0) {
//                if dirOnline?.memberDetail?.businessDetails?[i].profileID == (profileId) {
//                    bussName = ("\(dirOnline?.memberDetail?.businessDetails?[i].businessName ?? "")")
//                    bussMail = ("\(dirOnline?.memberDetail?.businessDetails?[i].memberBussEmail ?? "")")
//                    bussPosition = ("\(dirOnline?.memberDetail?.businessDetails?[i].businessPosition ?? "")")
//                }
//            }
//            
//            if let mail = bussMail, let name = bussName, let dsgn = bussPosition {
//                objProfileDynamicNewViewController.bEmail = mail
//                objProfileDynamicNewViewController.bName = name
//                objProfileDynamicNewViewController.desgn = dsgn
//            }
//            
//            var busAd = ""
//            var busCity = ""
//            var busState = ""
//            var busCountry = ""
//            var busPincode = ""
//            var bacom = ""
//            var bccom = ""
//            var bscom = ""
//            var bcocom = ""
//            var bpcom = ""
//            
//            var resAd = ""
//            var resCity = ""
//            var resState = ""
//            var resCountry = ""
//            var resPincode = ""
//            var acom = ""
//            var ccom = ""
//            var scom = ""
//            var cocom = ""
//            var pcom = ""
//            
//            for i in 0 ..< (dirOnline?.memberDetail?.addressDetails?.count ?? 0) {
//                if dirOnline?.memberDetail?.addressDetails?[i].profileID == (profileId) {
//                    if dirOnline?.memberDetail?.addressDetails?[i].addressType == "Business" {
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].address == "") {
//                            busAd = dirOnline?.memberDetail?.addressDetails?[i].address ?? ""
//                            acom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].city == "") {
//                            busCity = dirOnline?.memberDetail?.addressDetails?[i].city ?? ""
//                            ccom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].state == "") {
//                            busState = dirOnline?.memberDetail?.addressDetails?[i].state ?? ""
//                            scom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].country == "") {
//                            busCountry = dirOnline?.memberDetail?.addressDetails?[i].country ?? ""
//                            cocom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].pincode == "") {
//                            busPincode = dirOnline?.memberDetail?.addressDetails?[i].pincode ?? ""
//                            pcom = "."
//                        }
//                        bussAddrs = busAd + acom + busCity + ccom + busState + scom + busCountry + cocom + busPincode + pcom
//                        bussCntct = dirOnline?.memberDetail?.addressDetails?[i].phoneNo ?? ""
//                    } else {
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].address == "") {
//                            resAd = dirOnline?.memberDetail?.addressDetails?[i].address ?? ""
//                            bacom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].city == "") {
//                            resCity = dirOnline?.memberDetail?.addressDetails?[i].city ?? ""
//                            bccom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].state == "") {
//                            resState = dirOnline?.memberDetail?.addressDetails?[i].state ?? ""
//                            bscom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].country == "") {
//                            resCountry = dirOnline?.memberDetail?.addressDetails?[i].country ?? ""
//                            bcocom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].pincode == "") {
//                            resPincode = dirOnline?.memberDetail?.addressDetails?[i].pincode ?? ""
//                            bpcom = "."
//                        }
//                        resAddrs = resAd + bacom + resCity + bccom + resState + bscom + resCountry + bcocom + resPincode + bpcom
//                        resCntct = dirOnline?.memberDetail?.addressDetails?[i].phoneNo ?? ""
//                    }
//                }
//            }
//            
//            //        if dirOnline?.memberDetail?.addressDetails?.count ?? 0 > sender.tag {
//            objProfileDynamicNewViewController.bAddrs = bussAddrs
//            objProfileDynamicNewViewController.bCntcNo = bussCntct
//            objProfileDynamicNewViewController.resAddres = resAddrs
//            //            objProfileDynamicNewViewController.city = dirOnline?.memberDetail?.addressDetails?[sender.tag].city ?? ""
//            //            objProfileDynamicNewViewController.state = dirOnline?.memberDetail?.addressDetails?[sender.tag].state ?? ""
//            //            objProfileDynamicNewViewController.country = dirOnline?.memberDetail?.addressDetails?[sender.tag].country ?? ""
//            //            objProfileDynamicNewViewController.pincode = dirOnline?.memberDetail?.addressDetails?[sender.tag].pincode ?? ""
//            //        }
//            var relation = ""
//            var relName = ""
//            
//            for i in 0 ..< (dirOnline?.memberDetail?.familyDetails?.count ?? 0) {
//                if dirOnline?.memberDetail?.familyDetails?[i].profileID == (profileId) {
//                    relation = dirOnline?.memberDetail?.familyDetails?[i].relationship ?? ""
//                    relName = dirOnline?.memberDetail?.familyDetails?[i].memberName ?? ""
//                }
//            }
//            
//            //        if dirOnline?.memberDetail?.familyDetails?.count ?? 0 > sender.tag {
//            objProfileDynamicNewViewController.relati = relation
//            objProfileDynamicNewViewController.mother = relName
//            objProfileDynamicNewViewController.resMob = resCntct
            //        }
            
            objProfileDynamicNewViewController.groupUniqueName=groupUniqueName
            
            objProfileDynamicNewViewController.isCategory=isCategory
            
            //objProfileDynamicNewViewController.isAdmin=isAdmin  //directoryList.objectForKey("isAdmin") as? String
            
            
            //        var varProfileID = NSUserDefaults.standardUserDefaults().valueForKey("session_grpProfileid") as! String
            //        print(varProfileID)
            //        print(profileId)
            
            //        if(varProfileID==profileId)
            //        {
            //            objProfileDynamicNewViewController.isAdmin="abc"
            //            objProfileDynamicNewViewController.NormalMemberOrAdmin="SelfNormalMemberFromMainDash"
            //        }
            //        else
            //        {
            //             objProfileDynamicNewViewController.isAdmin=isAdmin
            //            objProfileDynamicNewViewController.NormalMemberOrAdmin="NormalMemberFromMainDash"
            //        }
            //
            
            let varProfileID = UserDefaults.standard.value(forKey: "session_grpProfileid") as! String
            // print(varProfileID)
            if(varProfileID=="\(profileId)")
            {
                if(dirOnline?.memberDetail?.memberDetails?[sender.tag].isAdmin == "yes")
                {
                    
                    objProfileDynamicNewViewController.isAdmin = dirOnline?.memberDetail?.memberDetails?[sender.tag].isAdmin
                }
                else
                {
                    objProfileDynamicNewViewController.isAdmin="no"
                    //objProfileDynamicNewViewController.NormalMemberOrAdmin="NormalMemberFromMainDash"
                }
            }
            else
            {
                objProfileDynamicNewViewController.isAdmin=dirOnline?.memberDetail?.memberDetails?[sender.tag].isAdmin
                objProfileDynamicNewViewController.NormalMemberOrAdmin="NormalMemberFromMainDash"
            }
            //  print(directoryList)
            objProfileDynamicNewViewController.objptotocolForDirectoryScrenBackValue=self
            
            self.navigationController?.pushViewController(objProfileDynamicNewViewController, animated: true)
        } else if (self.memberDetailMemberName?.count != nil) && (tfCount != 0) {
//            var familys = [String]()
//            var bussAddrs = ""
//            var resAddrs = ""
//            var bussCntct = ""
//            var resCntct = ""
//            var bussName: String?
//            var bussMail: String?
//            var bussPosition: String?
            
            print("sender.tag::: \(sender.tag)")
            
    //        let  directoryList = mainArray[sender.tag] as! NSDictionary
            print(isCategory)
            
            let objProfileDynamicNewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
            objProfileDynamicNewViewController.varGetPickerSelectValue = "Rotarian"
            objProfileDynamicNewViewController.isAdminss = self.isAdmin
            //print(directoryList.objectForKey("isAdmin") as? String)
    //        let masterId =  directoryList.object(forKey: "masterId") as? String
    //        let profileId = directoryList.object(forKey: "profileId") as? String
            var masterId = 0
            var profileId = 0
            var grppID = 0
            print(" checking----------\(self.memberDetailMemberName)")
            
            if self.memberDetailMemberName?.count ?? 0 > sender.tag {
                masterId =  self.memberDetailMemberName?[sender.tag].masterID ?? 0
                 profileId = self.memberDetailMemberName?[sender.tag].profileID ?? 0
                 grppID = self.memberDetailMemberName?[sender.tag].grpID ?? 0
            }
           
            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",profileId)
            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",masterId , userID)
            objProfileDynamicNewViewController.mastersId = masterId
            objProfileDynamicNewViewController.profileId = "\(profileId)"
            objProfileDynamicNewViewController.grpID = "\(grppID)"
            objProfileDynamicNewViewController.varAdminProfileID = self.userID
            
    //        objProfileDynamicNewViewController.mastersId = dirOnline?.memberDetail?.memberDetails[sender.tag].masterID
//            if self.memberDetailMemberName?.count ?? 0 > sender.tag {
//                objProfileDynamicNewViewController.userNam = self.memberDetailMemberName?[sender.tag].memberName ?? ""
//                objProfileDynamicNewViewController.userImg = self.memberDetailMemberName?[sender.tag].profilePic ?? ""
//                objProfileDynamicNewViewController.mob = self.memberDetailMemberName?[sender.tag].memberMobile ?? ""
//                objProfileDynamicNewViewController.secMob = self.memberDetailMemberName?[sender.tag].secondryMobileNo ?? ""
//                objProfileDynamicNewViewController.mail = self.memberDetailMemberName?[sender.tag].memberEmail ?? ""
//                objProfileDynamicNewViewController.classifica = self.memberDetailMemberName?[sender.tag].designation ?? ""
//                objProfileDynamicNewViewController.kayProf = self.memberDetailMemberName?[sender.tag].keywords ?? ""
//                objProfileDynamicNewViewController.rotarId = self.memberDetailMemberName?[sender.tag].memberRotaryID ?? ""
//                objProfileDynamicNewViewController.clubDesgn = self.memberDetailMemberName?[sender.tag].memberMasterDesignation ?? ""
//                objProfileDynamicNewViewController.donor = self.memberDetailMemberName?[sender.tag].rotaryDonarRecognation ?? ""
//                objProfileDynamicNewViewController.bthday = self.memberDetailMemberName?[sender.tag].memberDateOfBirth ?? ""
//                objProfileDynamicNewViewController.anniDate = self.memberDetailMemberName?[sender.tag].memberDateOfWedding ?? ""
//                objProfileDynamicNewViewController.bldGrp = self.memberDetailMemberName?[sender.tag].bloodGroup ?? ""
//                objProfileDynamicNewViewController.famImg = self.memberDetailMemberName?[sender.tag].familyPic ?? ""
//                objProfileDynamicNewViewController.memIntro = self.memberDetailMemberName?[sender.tag].memberInfo ?? ""
//                objProfileDynamicNewViewController.fb = self.memberDetailMemberName?[sender.tag].faceBookTxt ?? ""
//                objProfileDynamicNewViewController.insta = self.memberDetailMemberName?[sender.tag].instagramTxt ?? ""
//                objProfileDynamicNewViewController.lnkdin = self.memberDetailMemberName?[sender.tag].linkedInTxt ?? ""
//            }
//            
//            for i in 0 ..< (dirOnline?.memberDetail?.businessDetails?.count ?? 0) {
//                if dirOnline?.memberDetail?.businessDetails?[i].profileID == (profileId) {
//                    bussName = ("\(dirOnline?.memberDetail?.businessDetails?[i].businessName ?? "")")
//                    bussMail = ("\(dirOnline?.memberDetail?.businessDetails?[i].memberBussEmail ?? "")")
//                    bussPosition = ("\(dirOnline?.memberDetail?.businessDetails?[i].businessPosition ?? "")")
//                }
//            }
//            
//            if let mail = bussMail, let name = bussName, let dsgn = bussPosition {
//                objProfileDynamicNewViewController.bEmail = mail
//                objProfileDynamicNewViewController.bName = name
//                objProfileDynamicNewViewController.desgn = dsgn
//            }
//            
//            var busAd = ""
//            var busCity = ""
//            var busState = ""
//            var busCountry = ""
//            var busPincode = ""
//            var bacom = ""
//            var bccom = ""
//            var bscom = ""
//            var bcocom = ""
//            var bpcom = ""
//            
//            var resAd = ""
//            var resCity = ""
//            var resState = ""
//            var resCountry = ""
//            var resPincode = ""
//            var acom = ""
//            var ccom = ""
//            var scom = ""
//            var cocom = ""
//            var pcom = ""
//
//            for i in 0 ..< (dirOnline?.memberDetail?.addressDetails?.count ?? 0) {
//                if dirOnline?.memberDetail?.addressDetails?[i].profileID == (profileId) {
//                    if dirOnline?.memberDetail?.addressDetails?[i].addressType == "Business" {
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].address == "") {
//                            busAd = dirOnline?.memberDetail?.addressDetails?[i].address ?? ""
//                            acom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].city == "") {
//                            busCity = dirOnline?.memberDetail?.addressDetails?[i].city ?? ""
//                            ccom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].state == "") {
//                            busState = dirOnline?.memberDetail?.addressDetails?[i].state ?? ""
//                            scom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].country == "") {
//                            busCountry = dirOnline?.memberDetail?.addressDetails?[i].country ?? ""
//                            cocom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].pincode == "") {
//                            busPincode = dirOnline?.memberDetail?.addressDetails?[i].pincode ?? ""
//                            pcom = "."
//                        }
//                        bussAddrs = busAd + acom + busCity + ccom + busState + scom + busCountry + cocom + busPincode + pcom
//                        bussCntct = dirOnline?.memberDetail?.addressDetails?[i].phoneNo ?? ""
//                    } else {
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].address == "") {
//                            resAd = dirOnline?.memberDetail?.addressDetails?[i].address ?? ""
//                            bacom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].city == "") {
//                            resCity = dirOnline?.memberDetail?.addressDetails?[i].city ?? ""
//                            bccom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].state == "") {
//                            resState = dirOnline?.memberDetail?.addressDetails?[i].state ?? ""
//                            bscom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].country == "") {
//                            resCountry = dirOnline?.memberDetail?.addressDetails?[i].country ?? ""
//                            bcocom = ","
//                        }
//                        if !(dirOnline?.memberDetail?.addressDetails?[i].pincode == "") {
//                            resPincode = dirOnline?.memberDetail?.addressDetails?[i].pincode ?? ""
//                            bpcom = "."
//                        }
//                        resAddrs = resAd + bacom + resCity + bccom + resState + bscom + resCountry + bcocom + resPincode + bpcom
//                        resCntct = dirOnline?.memberDetail?.addressDetails?[i].phoneNo ?? ""
//                    }
//                }
//            }
//            
//    //        if dirOnline?.memberDetail?.addressDetails?.count ?? 0 > sender.tag {
//                objProfileDynamicNewViewController.bAddrs = bussAddrs
//                objProfileDynamicNewViewController.bCntcNo = bussCntct
//                objProfileDynamicNewViewController.resAddres = resAddrs
//    //            objProfileDynamicNewViewController.city = dirOnline?.memberDetail?.addressDetails?[sender.tag].city ?? ""
//    //            objProfileDynamicNewViewController.state = dirOnline?.memberDetail?.addressDetails?[sender.tag].state ?? ""
//    //            objProfileDynamicNewViewController.country = dirOnline?.memberDetail?.addressDetails?[sender.tag].country ?? ""
//    //            objProfileDynamicNewViewController.pincode = dirOnline?.memberDetail?.addressDetails?[sender.tag].pincode ?? ""
//    //        }
//            var relation = ""
//            var relName = ""
//            
//            for i in 0 ..< (dirOnline?.memberDetail?.familyDetails?.count ?? 0) {
//                if dirOnline?.memberDetail?.familyDetails?[i].profileID == (profileId) {
//                    relation = dirOnline?.memberDetail?.familyDetails?[i].relationship ?? ""
//                    relName = dirOnline?.memberDetail?.familyDetails?[i].memberName ?? ""
//                }
//            }
//            
//    //        if dirOnline?.memberDetail?.familyDetails?.count ?? 0 > sender.tag {
//            objProfileDynamicNewViewController.relati = relation
//                objProfileDynamicNewViewController.mother = relName
//                objProfileDynamicNewViewController.resMob = resCntct
    //        }
           
            objProfileDynamicNewViewController.groupUniqueName=groupUniqueName

            objProfileDynamicNewViewController.isCategory=isCategory
            
            
            let varProfileID = UserDefaults.standard.value(forKey: "session_grpProfileid") as! String
            // print(varProfileID)
            if(varProfileID=="\(profileId)")
            {
                if(dirOnline?.memberDetail?.memberDetails?[sender.tag].isAdmin == "yes")
                {
                    
                    objProfileDynamicNewViewController.isAdmin = dirOnline?.memberDetail?.memberDetails?[sender.tag].isAdmin
                }
                else
                {
                    objProfileDynamicNewViewController.isAdmin="no"
                    //objProfileDynamicNewViewController.NormalMemberOrAdmin="NormalMemberFromMainDash"
                }
            }
            else
            {
                objProfileDynamicNewViewController.isAdmin=dirOnline?.memberDetail?.memberDetails?[sender.tag].isAdmin
                objProfileDynamicNewViewController.NormalMemberOrAdmin="NormalMemberFromMainDash"
            }
            //  print(directoryList)
            objProfileDynamicNewViewController.objptotocolForDirectoryScrenBackValue=self

            self.navigationController?.pushViewController(objProfileDynamicNewViewController, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        let  directoryList = mainArray[indexPath.row] as! NSDictionary
//        let objProfileDynamicNewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
//        
//        print(directoryList)
//        let masterId =  directoryList.object(forKey: "masterId") as? String
//        let profileId = directoryList.object(forKey: "profileId") as? String
//        print(profileId , masterId)
//        objProfileDynamicNewViewController.masterId=masterId
//        objProfileDynamicNewViewController.profileId=profileId
//        objProfileDynamicNewViewController.grpID="\(grpID)"
//        objProfileDynamicNewViewController.varAdminProfileID="\(userID)"
//        objProfileDynamicNewViewController.isAdmin=isAdmin  //directoryList.objectForKey("isAdmin") as? String
//        objProfileDynamicNewViewController.NormalMemberOrAdmin="NormalMemberFromMainDash"
//        objProfileDynamicNewViewController.isCategory=isCategory
//        // print(directoryList)
//        objProfileDynamicNewViewController.groupUniqueName=groupUniqueName
//        objProfileDynamicNewViewController.objptotocolForDirectoryScrenBackValue=self
//        self.navigationController?.pushViewController(objProfileDynamicNewViewController, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {   //delegate method
        mainArray.removeAllObjects()
        self.mainArray=NSMutableArray()
        let strValues = self.textfieldForRotarianSearch.text!
        if (varGetPickerSelectValue == "Rotarian")
        {
            self.buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
            self.mainArray.removeAllObjects()
            mainArray = NSMutableArray()
            fetchDataFORClubName(strValues as String)
            textfieldForRotarianSearch.resignFirstResponder()
            /////
             
        }
        else if (varGetPickerSelectValue == "Classification")
        {
            self.functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDown(strValues as String)
            
        }
        else if (varGetPickerSelectValue == "Family")
        {
            print("this is value by Rajendra jat !!!!!!!! :)")
            print(strValues)
            
            self.functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDown(strValues as String)
        }
        
        
        textfieldForRotarianSearch.resignFirstResponder()
        return true
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        mainArray.removeAllObjects()
        self.mainArray=NSMutableArray()
        var strValues = self.textfieldForRotarianSearch.text!
        
        
       var varGetSearchBoxValue = (self.textfieldForRotarianSearch.text! as NSString).replacingCharacters(in: range, with: string) as NSString as String
        strValues = (varGetSearchBoxValue.trimmingCharacters(in: CharacterSet.whitespaces)as NSString) as String
        
        if (strValues.characters.count != 0) {
            self.tfCount = 1
        } else if (strValues.characters.count == 0) {
            self.tfCount = 0
        }
        
        print("This is value by Rajendra jat !!! :)")
        print(strValues)
        print("strValues.characters.count:: \(strValues.characters.count)")
        // print(strValues2)
        // print("5555555555555555555555555555555555555555555555555555555555",strValues,self.textfieldForRotarianSearch.text!)
        if (varGetPickerSelectValue == "Rotarian")
        {
            self.buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
            fetchDataFORClubName(strValues as String)  //DPK
            // textfieldForRotarianSearch.resignFirstResponder()
            
            /////
             
            
        }
        else if (varGetPickerSelectValue == "Classification")
        {
            self.functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDown(strValues as String)
        }
        else if (varGetPickerSelectValue == "Family")
        {
            
            print("this is value by Rajendra jat 2 !!!!!!!! :)")
            print(strValues)
            self.functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDown(strValues as String)
        }
        
        
        //textfieldForRotarianSearch.resignFirstResponder()
        // if(appDelegate.isReachable == true)
        //{

        //        var  strValue = (self.searchTextField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string) as NSString as String
        //        let strValues = strValue.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())as NSString
        //        print(strValue)
        //        print(strValues)
        //        print(searchTextField.text)
        //textfieldForRotarianSearch.resignFirstResponder()

        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        //your code
        if(textField.text!==""){
            mainArray.removeAllObjects()
            mainArray = copymainArray .mutableCopy() as! NSMutableArray
            if(mainArray.count == 0) {
                //directoryTableView.hidden = true;
            }
            else {
                
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
            mainArray.removeAllObjects()
            mainArray =  copymainArray.filtered(using: predicate) as! NSMutableArray
            // print(mainArray)
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
    
    
    /*
    func loaderViewMethod()
    {
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        if let window = appDelegate.window {
            window.backgroundColor = UIColor.clear
            window.rootViewController = UIViewController()
            window.makeKeyAndVisible()
        }
        let Loadingview = UIView()
        
        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
        appDelegate.window?.addSubview(Loadingview)
        
        let url = Bundle.main.url(forResource: "tb_preloader8", withExtension: "gif")
        
        let gifView = UIImageView()
        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
        gifView.backgroundColor = UIColor.clear
        Loadingview.addSubview(gifView)
        
        
    }
    */
    func fetchData()
    {
        mainArray.removeAllObjects()
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

            //SELECT * FROM ProfileMaster
            // WHERE (membername LIKE '%ande%' OR membermobile LIKE '%1234567%' )

            let querySQL = "SELECT  DISTINCT memberName,profilePic,memberMobile,masterId,profileId,isAdmin,isPersonalDetVisible,isBussinessDetVisible,isFamilyDetVisible,grpId,familyPic  FROM ProfileMaster where grpId = '\(grpID!)'  order by memberName COLLATE NOCASE asc"
             print(querySQL)
             let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)

             var varCounting:Int!=0

             while results?.next() == true {
                autoreleasepool {
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "memberName"))! as String, forKey:"memberName")
                dd.setValue((results?.string(forColumn: "memberMobile"))! as String, forKey:"memberMobile")
                dd.setValue((results?.string(forColumn: "masterId"))! as String, forKey:"masterId")
                dd.setValue((results?.string(forColumn: "profileId"))! as String, forKey:"profileId")
                dd.setValue((results?.string(forColumn: "isAdmin"))! as String, forKey:"isAdmin")
                dd.setValue((results?.string(forColumn: "isPersonalDetVisible"))! as String, forKey:"isPersonalDetVisible")
                dd.setValue((results?.string(forColumn: "isBussinessDetVisible"))! as String, forKey:"isBussinessDetVisible")
                dd.setValue((results?.string(forColumn: "isFamilyDetVisible"))! as String, forKey:"isFamilyDetVisible")
                dd.setValue((results?.string(forColumn: "grpId"))! as String, forKey:"grpId")
                dd.setValue((results?.string(forColumn: "profilePic"))! as String, forKey:"profilePic")
                
                if(self.isCategory=="2")
                {
                    
                }
                else
                {
                    dd.setValue((results?.string(forColumn: "familyPic"))! as String, forKey:"familyPic") //31-08-2017
                }
                
                mainArray.add(dd)
                varCounting=varCounting+1
               
                }
            }
            
            if mainArray.count > 0
            {
                NoRecordLabel.isHidden = true
                copymainArray=mainArray
                directoryTableView.reloadData()
                self.varRefreshDatRunOneTime="First"
            }
            else
            {
                NoRecordLabel.isHidden = false
                mainArray.removeAllObjects()
                mainArray = NSMutableArray()
                copymainArray=NSArray()
                directoryTableView.reloadData()
                self.varRefreshDatRunOneTime="Second"
            }

            let Count = "SELECT count(*) as Count from ProfileMaster where grpId = '\(grpID!)'"
             print(Count)
            let resultss:FMResultSet? = contactDB?.executeQuery(Count,withArgumentsIn: nil)

            while resultss?.next() == true
            {
                varGetCount=resultss?.string(forColumn: "Count")
            }
            varGetCount=String(varCounting)
            //print(varGetCount)
        }

        contactDB?.close()
    }
    
    override func viewDidLoad()
    {
        // funcForRemoveZipFileFromDocumentDirectory()
//        self.edgesForExtendedLayout = []
//        appDelegate.window!.backgroundColor = UIColor.white
        super.viewDidLoad()
        SVProgressHUD.show()
        UserDefaults.standard.setValue("no", forKey: "session_IsComingFromProfileDynamicBack")
        

        let iconWidth = 20;
        let iconHeight = 20;
        textfieldForRotarianSearch.placeholder = "Search Rotarian"
        //Define the imageView
        let imageView = UIImageView();
        let imageEmail = UIImage(named: "searchNew.png");
        imageView.image = imageEmail;
        // set frame on image before adding it to the uitextfield
        imageView.frame = CGRect(x: 5, y: 5, width: iconWidth, height: iconHeight)
        textfieldForRotarianSearch.leftViewMode = UITextField.ViewMode.always
        textfieldForRotarianSearch.addSubview(imageView)
        
        //set Padding
        let paddingView = UIView(frame: CGRect(x:0, y:0,width: 25,height: self.textfieldForRotarianSearch.frame.height))
        textfieldForRotarianSearch.leftView = paddingView
        
        self.NoRecordLabel.isHidden=true
        buttonDown.isHidden=true
        buttonUp.isHidden=true
        varRefreshDirectory="Refresh"
        varRefreshDatRunOneTime = "First"
        //---pulll to refresh
    
        self.directoryTableView.alwaysBounceVertical = true;
        self.textfieldForRotarianSearch.layer.cornerRadius = 10.0
        self.textfieldForRotarianSearch.layer.borderColor = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0).cgColor
        self.textfieldForRotarianSearch.layer.borderWidth = 1.0
        self.buttonSearchRotarianType.layer.cornerRadius = 10.0
        self.buttonSearchRotarianType.layer.borderColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1.0).cgColor
        self.buttonSearchRotarianType.layer.borderWidth = 1.0
        self.buttonOpacityFirstTime.isHidden=true
        self.labelFirstLoading.isHidden=true
        varGetPickerSelectValue = "Rotarian"
        //Navigation more functionality ------DPK
        viewForSettingPicker.isHidden = true
        buttonOpticity.isHidden = true
        buttonDonOnPicker.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        
        print(isCategory)
        if isCategory=="2"
        {
            print("Come From District.........")
        mainArraySettingForPicker = ["Rotarian" , "Classification"]
        }
        else
        {
         mainArraySettingForPicker = ["Rotarian" , "Classification" , "Family"]
        }
        
        
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
        
        mainArray.removeAllObjects()
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
        var varCounting:Int!=0
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            
            let Count = "SELECT count(*) as Count from ProfileMaster where grpId = '\(grpID)'"
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
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
            backgroundQueue.async(execute: {
                print("This is run on the background queue")
                
                DispatchQueue.main.async(execute: { () -> Void in
                   // print("This is run on the main queue, after the previous code in outer block")
                     self.fetchData()
                })
            })
        }
        else
        {
        }
        contactDB?.close()
        //later called by Rajendra jat on 6MArch
//        self.functionForGetZipFilePath()
       // functionForViewDidloadCalling()
        memberDetailMemberName?.removeAll()
//        loadDirectoryList()
//        loadClassificationList()
    }
    
    func loadDirectoryList() {
        SVProgressHUD.show()
        if let grpIdd = self.grpID {
            
            let completeURL = baseUrl + directoryOnline
            
            let parameterst = ["grpID": grpIdd]
            
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
                                 let decodedData = try decoder.decode(DirectoryOnline.self, from: jsonData)
                                 
                                 // Access the properties of the decoded data
                                 print("Decoded Data:--- \(decodedData)")
                                 self.dirOnline = decodedData
                                 for i in 0 ..< (self.dirOnline?.memberDetail?.memberDetails?.count ?? 0) {
                                     if !(self.dirOnline?.memberDetail?.memberDetails?[i].designation == "") {
                                         self.dsgns.append(self.dirOnline?.memberDetail?.memberDetails?[i].designation ?? "")
                                         print(self.dsgns)
                                     }
                                     self.varGetCount = "\(self.dirOnline?.memberDetail?.memberDetails?.count ?? 0)"
                                 }
                                 
                                 self.directoryTableView.reloadData()
                                 DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                                     SVProgressHUD.dismiss()
                                 })
                                 
                                 // Access individual properties like decodedData.propertyName
                             } catch {
                                 print("Error decoding JSON: \(error)")
                             }
                         }
                    
                    
                    
                    
                    
                    // var result = [String:String]()
//                    SVProgressHUD.dismiss()
//                    print("jsonString:: \(response)")
//                    if let value = response.result.value {
//                        let dic = response.result.value!
//                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
//                        let jsonString = String(data: jsonData!, encoding: .utf8)!
//                        print("jsonString:: \(jsonData)")
//                    }
                case .failure(_): break
                }
            }
        }
    }
    
    func loadClassificationList() {
        
        if let grpIdd = self.grpID {
            
            let completeURL = baseUrl + dirClassificationOnline
            
            let parameterst = ["pageNo":"1","grpID":grpIdd,"recordCount":"","searchText":""]
            
            print("Club Online Directory Classification parameterst:: \(parameterst)")
            print("Club Online Directory Classification completeURL:: \(completeURL)")
            
            //------------------------------------------------------
            Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    
                    
                         if let value = response.result.value {
                             do {
                                 // Attempt to decode the JSON data
                                 let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                                 let decoder = JSONDecoder()
                                 let decodedData = try decoder.decode(DirectoryClassificationOnline.self, from: jsonData)
                                 
                                 // Access the properties of the decoded data
                                 print("Decoded Data:--- \(decodedData)")
                                 self.classOnline = decodedData
                                 self.classiList.removeAll()
                                 for i in 0 ..< (self.classOnline?.classificationListResult.result.count ?? 0) {
                                     if !(self.classOnline?.classificationListResult.result[i].classification == "") {
                                         self.classiList.append(self.classOnline?.classificationListResult.result[i].classification ?? "")
                                         print(self.classiList)
                                     }
//                                     self.varGetCount = "\(self.classOnline?.classificationListResult.result.count ?? 0)"
                                 }
                                 SVProgressHUD.dismiss()
                                 self.directoryTableView.reloadData()
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
    
    func loadFamilyOnline() {
        
        if let grpIdd = self.grpID {
            
            let completeURL = baseUrl + dirFamilyOnline
            
            let parameterst = ["groupId":grpIdd]
            
            print("Club Online Directory Family parameterst:: \(parameterst)")
            print("Club Online Directory Family completeURL:: \(completeURL)")
            
            //------------------------------------------------------
            Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    
                    
                         if let value = response.result.value {
                             do {
                                 // Attempt to decode the JSON data
                                 let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                                 let decoder = JSONDecoder()
                                 let decodedData = try decoder.decode(DirectoryFamilyOnline.self, from: jsonData)
                                 
                                 // Access the properties of the decoded data
                                 print("Decoded Data:--- \(decodedData)")
                                 self.familyOnline = decodedData
                                 self.famMemList.removeAll()
                                 self.famProfileList.removeAll()
                                 for i in 0 ..< (self.familyOnline?.tbGetRotarianResult.result.count ?? 0) {
                                     if !(self.familyOnline?.tbGetRotarianResult.result[i].memberName == "") {
                                         self.famMemList.append(self.familyOnline?.tbGetRotarianResult.result[i].memberName ?? "")
                                         self.famProfileList.append(self.familyOnline?.tbGetRotarianResult.result[i].profileID ?? "")
                                         print(self.famMemList)
                                     }
//                                     self.varGetCount = "\(self.classOnline?.classificationListResult.result.count ?? 0)"
                                 }
                                 SVProgressHUD.dismiss()
                                 self.directoryTableView.reloadData()
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
    
    // func functionForCallingOnDirctoryuScrrenWhenBackFromProfileDynamic()
    func functionForCallingOnDirctoryuScrrenWhenBackFromProfileDynamic() {
         SVProgressHUD.show()
         functionForViewDidloadCalling()
    }
    
    /*---function for view did looad before it was on viewwillappear-*/
    func functionForViewDidloadCalling()
    {
        let getvalue = UserDefaults.standard.string(forKey: "session_IsComingFromProfileDynamicBackagainandagain")
        if(getvalue=="yes")
        {
            UserDefaults.standard.setValue("no", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
            var alertController = UIAlertController()
            alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
//            self.functionForGetZipFilePath()
            self.present(alertController, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 20.0, execute: {
                alertController.dismiss(animated: true, completion: nil)
            })
        }
        UserDefaults.standard.setValue("no", forKey: "session_IsComingFromEditUpdateProfileForUpdateUserProfile")
        self.textfieldForRotarianSearch.text=""
        textfieldForRotarianSearch.resignFirstResponder()
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
//            if varGetPickerSelectValue=="Classification" ||  varGetPickerSelectValue == "Family"
//            {
//
//            }
//            else
//            {
//                self.functionForGetZipFilePath()
//            }
        }
        else
        {
            
            
            functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDownBack()   //DPK for Classification offline data blank in table
        }
        textfieldForRotarianSearch.text=""
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        loadDirectoryList()
        loadClassificationList()
        loadFamilyOnline()
        self.tfCount = 0
        if self.memberDetailMemberName?.count == nil {
            memCount = 0
        }
        textfieldForRotarianSearch.text=""
        textfieldForRotarianSearch.resignFirstResponder()
        self.memberDetailMemberName?.removeAll()
        self.filterdsgns.removeAll()
        self.filterFam.removeAll()
        self.filterpro.removeAll()
        self.directoryTableView.reloadData()
        print ("self.memberDetailMemberName?.count:: \(self.memberDetailMemberName?.count)")
        if(itshouldbeUpdatefromEditUpdate==0)
        {
            
        }
        else
        {
            SVProgressHUD.show()
            //functionForViewDidloadCalling()
//            functionForGetZipFilePath()
            itshouldbeUpdatefromEditUpdate=0
        }
    }
    
   
    /*--code by Rajendra Jat download zip file and unzip and insert data in table----*/
    
    func functionForGetZipFilePath()
    {
        //if any json file(New,Updated,Deleted) is remain to server then first server that
        //code by Rajendra Jat for delete all zip files from document directory
        SVProgressHUD.show()
        functionForGetNewUpdateDeleteMember()
        MainDashboardViewController().funcForRemoveZipFileFromDocumentDirectory()
        print("™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™")
        var updatedOn =  String ()
        let defaults = UserDefaults.standard
        let UpdatedefaultNew = String(format: "updatedOnDirectory%@",grpID)
        var  testlet = defaults.value(forKey: UpdatedefaultNew) as! String?
        if let str = defaults.value(forKey: UpdatedefaultNew) as! String?
        {
            updatedOn = str
             //updatedOn = "1970-01-01 00:00:00"
        }
        else
        {
            updatedOn = "1970-01-01 00:00:00"
            SVProgressHUD.show()
        }
        if(updatedOn == "1970-01-01 00:00:00")
        {
            self.buttonOpacityFirstTime.isHidden=false
            self.labelFirstLoading.isHidden=false
           // self.loaderClass.loaderViewMethod()
        }
        
        
        
      //Refreshing data
        if(varRefreshDatRunOneTime=="Second")
        {
         updatedOn = "1970-01-01 00:00:00"
         SVProgressHUD.show()
        }
        else
        {
            
        }
        
     
        //moduleId
        var  completeURL:String!=""
        if(isCategory=="2") //DPK
        {
            completeURL = baseUrl+touchBAse_GetDistrictListSync
        }
        else
        {
            completeURL = baseUrl+touchBase_GetMemberListSync
        }
        
        let parameterst = [
            k_API_DirectoryZipFile : self.grpID!,
            k_API_updatedOn : updatedOn
        ] as [String : Any]
        
        print("Club Directory parameterst:: \(parameterst)")
        print("Club Directory completeURL:: \(completeURL)")
        
        //------------------------------------------------------
        Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
switch response.result {
 case .success:
     // var result = [String:String]()
       SVProgressHUD.dismiss()
     if let value = response.result.value {
    let dic = response.result.value!
         print("dic::::::::: \(dic)")
    let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
    let jsonString = String(data: jsonData!, encoding: .utf8)!
    //print(jsonString)
    //--
    if(response==nil)
    {
        
    }
    else
    {
        let dd = response.result.value as! NSDictionary
        var varGetValueServerError = dd.object(forKey: "serverError")as? String
       if(varGetValueServerError == "Error")
       {
          self.loaderClass.window = nil
          self.buttonOpacityFirstTime.isHidden=true
          self.labelFirstLoading.isHidden=true
          self.NoRecordLabel.isHidden=true
          self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
          SVProgressHUD.dismiss()
       }
       else
       {
          //print("//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*",dd)
          ////code by  Rajendra Jat here need to update sesssion for last update date
          //curDate
          UserDefaults.standard.set(dd.object(forKey: "curDate")as! String, forKey: UpdatedefaultNew)
          // print(NSUserDefaults.standardUserDefaults().setObject(dd.objectForKey("curDate")as! String, forKey: UpdatedefaultNew))
          
          // print(dd.objectForKey("curDate")as! String)
          print(dd)
          
          if(dd.object(forKey: "status") as! String == "0" && dd.object(forKey: "zipFilePath") as! String != "")
          {
              // self.funcForRemoveZipFileFromDocumentDirectory()
              
              self.buttonOpacityFirstTime.isHidden=false
              self.labelFirstLoading.isHidden=false
              //self.loaderClass.loaderViewMethod()
              
              self.varGetZipFileUrl=dd.object(forKey: "zipFilePath") as! String
              self.functionForDownloadZipFile( self.varGetZipFileUrl)
          }
          else
          {
              
              
              if(dd.object(forKey: "status") as! String == "1")
              {
                  self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                  SVProgressHUD.dismiss()
              }
              else
              {
                  
                  if(dd.object(forKey: "status") as! String == "2")
                  {
                      //self.view.makeToast("No new updates found", duration: 2, position: CSToastPositionCenter)
                  }
                  else
                  {
                      let UpdateMemberListjsonResult: NSDictionary = NSDictionary()
                      var varGetNewMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")
                      var varGetUpdatedMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")
                      var varGetDeleteMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "DeletedMemberList") as! String
                      
                      print("------>")
                      print(varGetUpdatedMemberList)
                      print("<------ Deleted Memeber List::::")
                                            
//                                            var alertController = UIAlertController()
//
//                                            alertController = UIAlertController(title: "", message: "Deleted members are \(varGetDeleteMemberList)", preferredStyle: .alert)
//                                            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil));
//                                            self.present(alertController, animated: true, completion: nil)
         
                      print(varGetDeleteMemberList)
                      if(varGetDeleteMemberList.characters.count>0)
                      {
                          print(varGetDeleteMemberList)
                        //  let profileIDs:[String]=varGetDeleteMemberList.split(separator: ",")
                          self.functionForDeleteMembers([varGetDeleteMemberList])
                      }
                      
                      /*555555555555555555555555555555555555555555555555555555555555555555555555555555555555*/
                      if((varGetNewMemberList! as AnyObject).count>0)
                      {
                          self.functionForNewMemberWhenDataComingNotZipFile(dd)
                          
                      }
                      /*555555555555555555555555555555555555555555555555555555555555555555555555555555555555*/
                      
                      /*6666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666*/
                      if((varGetUpdatedMemberList! as AnyObject).count>0)
                      {
                          self.functionForUpdateMemberWhenDataComingNotZipFile(dd)
                          
                      }
                      /*6666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666*/
                  }
                  
              }
          }
          self.fetchData()
          self.search.isEnabled=true
          self.searchButton.isEnabled=true
      }
      SVProgressHUD.dismiss()
                        }
                    
                    //----
                }
            case .failure(_): break
            }
        }
        //----------------------------------------------------
        
        
    
        
        
       // ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            
     
       // })
            
    }
    
    /*666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666*/
    func functionForNewMemberWhenDataComingNotZipFile(_ dd:NSDictionary)
    {
        
        var dictNewMemberListjsonResult:NSDictionary=NSDictionary()
        dictNewMemberListjsonResult=dd
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
        var moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
        var GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            ((dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).count
            
            // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.count)
            for i in 0 ..< ((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).count
            {
                
                let dictMain=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                // print(dictMain)
                
                print(dictMain)
                
                // let  dict = arrdata[i] as! NSDictionary
                //let dictMain=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i)
                let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
                let memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
                var memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
                
                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
                
                //
              
    print(dictMain)
                
                
                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                
                memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
                
                if(memberCountry.characters.count>2)
                {
                    
                }
                else
                {
                    memberCountry="India"
                }
                
                 //print(profileID)
                let insertSQL = "INSERT INTO ProfileMaster (masterId,grpId,profileId,isAdmin,memberName,memberEmail,memberMobile,memberCountry,profilePic,familyPic,isPersonalDetVisible,isBussinessDetVisible,isFamilyDetVisible) VALUES('"+masterID+"','"+grpID+"','"+profileID+"','"+isAdmin+"','"+memberNames+"','"+memberEmail+"','"+memberMobile+"','"+memberCountry+"','"+profilePic+"','"+familyPic+"','"+isPersonalDetVisible+"','"+isBusinDetVisible+"','"+isFamilDetailVisible+"')"
                print(insertSQL)
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    // print("success saved");print(databasePath);
                    //1......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                    // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectForKey("NewMemberList")!.objectAtIndex(i).objectForKey("personalMemberDetails")!.count)
                    
                    var didfgctTdfgempordfgaryDictdfgionavxry:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                    
                    for j in 0 ..< (didfgctTdfgempordfgaryDictdfgionavxry.object(forKey: "personalMemberDetails")! as AnyObject).count
                    {
                        let dictChild=(didfgctTdfgempordfgaryDictdfgionavxry.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
                        //print(dictChild)
                        let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                        let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                        let key=(dictChild as AnyObject).object(forKey: "key")as! String
                        let value=(dictChild as AnyObject).object(forKey: "value")as! String
                        let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                        let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                        let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                        
                        let childSQLl = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','personal','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                         print(childSQLl)
                        let result = contactDB?.executeStatements(childSQLl)
                        if (result == nil)
                        {
                            print("ErrorAi: \(contactDB?.lastErrorMessage())")
                        }
                        else
                        {
                        }
                    }
                    //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                    // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!.count)
                    
                    
                    
                    var dihjkctTemphjkoraryhjkDicsdftionardfsdy:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                    for j in 0 ..< (dihjkctTemphjkoraryhjkDicsdftionardfsdy.object(forKey: "businessMemberDetails")! as AnyObject).count
                    {
                        let dictChild=(dihjkctTemphjkoraryhjkDicsdftionardfsdy.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
                        //   let dictChild=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!.objectAtIndex(j)
                        let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                        let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                        let key=(dictChild as AnyObject).object(forKey: "key")as! String
                        let value=(dictChild as AnyObject).object(forKey: "value")as! String
                        let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                        let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                        let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                        
                        let childSQLNewww = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','Business','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                        print(childSQLNewww)
                        let result = contactDB?.executeStatements(childSQLNewww)
                        if (result == nil)
                        {
                            print("ErrorAi: \(contactDB?.lastErrorMessage())")
                        }
                        else
                        {
                            
                        }
                    }
                    //3. PersonalBusinessMemberDetails
                    // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("familyMemberDdsfgetails")!.count)
                    // for k in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(0).objectForKey("familyMemberdfgDetails")!.count
                    //for k in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectForKey("NewMemberList")!.objectAtIndex(i).objectForKey("familyMfxgemberDetails")!.objectForKey("familyMemberDetail")!.count
                    
                    
                    let dictTemporaryDictionarytemporarybewss:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                    
                    
                    for k in 0 ..< ((dictTemporaryDictionarytemporarybewss.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                    {
                        let dictChild=((dictTemporaryDictionarytemporarybewss.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)  // DPK
                        // let dictChild=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("familyMemdfgberDetails")!.objectForKey("familyMemberDetail")!.objectAtIndex(k)   // Comment by DPK
                        print("app Crashhed Check",dictChild)
                        let isVisible=(dictTemporaryDictionarytemporarybewss.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
                        
                        
                        let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
                        let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
                        let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
                        let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
                        let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
                        let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
                        let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
                        let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
                        let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
                        
                        let familyMemberDetails = "INSERT INTO FamilyMemberDetail (profileId,isVisible,familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,particulars,bloodGroup,masterId) VALUES("+profileID+",'"+isVisible+"','"+familyMemberId+"','"+memberName+"','"+relationship+"','"+dob+"','"+emailID+"','"+anniversary+"','"+contactNo+"','"+particulars+"','"+bloodGroup+"','"+masterID+"')"
                        
                        print(familyMemberDetails)
                        
                        let result = contactDB?.executeStatements(familyMemberDetails)
                        if (result == nil)
                        {
                            print("ErrorAi: \(contactDB?.lastErrorMessage())")
                        }
                        else
                        {
                            
                        }
                    }
                    //4.  AddressDetails
                    //for l in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(0).objectForKey("addressDetails")!.count
                    
                    // print("This is count:------")
                    
                    // let dictChild=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("addressDetails")!.objectForKey("addressResult")
                    // print(dictChild)
                    
                    // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(0))
                    // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("addressDetails")!.objectForKey("addressResult"))
                   
                    var dictTemsfdsfsfsdfporaryDictionary:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                    
                    
                    for l in 0 ..< ((dictTemsfdsfsfsdfporaryDictionary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
                    {
                        
                        
                        
                        let dictChild=((dictTemsfdsfsfsdfporaryDictionary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
                        
                        let isBusinessAddrVisible=(dictTemsfdsfsfsdfporaryDictionary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
                        let isResidanceAddrVisible=(dictTemsfdsfsfsdfporaryDictionary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
                        
                        
                        let address=(dictChild as AnyObject).object(forKey: "address")as! String
                        let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
                        let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
                        let city=(dictChild as AnyObject).object(forKey: "city")as! String
                        var country=(dictChild as AnyObject).object(forKey: "country")as! String
                        let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
                        let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
                        let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
                        //print(pincode)
                        let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
                        
                        let state=(dictChild as AnyObject).object(forKey: "state")as! String
                        // print(state)
                        
                        
                        print("this is country from rajendra side 1212121212")
                        print(country)
                        if(country.characters.count>2)
                        {
                            
                        }
                        else
                        {
                            country="India"
                        }
                        
                        let familyMemberDetails = "INSERT INTO AddressDetails (profileId,AddressprofileId,addressID,addressType,address,city,state,country,pincode,phoneNo,fax,isBusinessAddrVisible,isResidanceAddrVisible,masterId) VALUES("+profileID+",'"+AddressprofileId+"','"+addressID+"','"+addressType+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+phoneNo+"','"+fax+"','"+isBusinessAddrVisible+"','"+isResidanceAddrVisible+"','"+masterID+"')"
                        
                        //print(familyMemberDetails)
                        
                        
                        let result = contactDB?.executeStatements(familyMemberDetails)
                        if (result == nil)
                        {
                            print("ErrorAi: \(contactDB?.lastErrorMessage())")
                        }
                        else
                        {
                            
                        }
                    }
                    
                    
                }
            }
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        fetchData()
        contactDB?.close()
        
        
    }
    /*666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666*/
    
    
    func functionForUpdateMemberWhenDataComingNotZipFile(_ dd:NSDictionary)
    {
        // print(dd)
        var moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
        var GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        
        var dictNewMemberListjsonResult:NSDictionary=NSDictionary()
        dictNewMemberListjsonResult=dd
        
        
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
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
             print("33This is count of main start point of file:-----------")
            //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.count)
            
            // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!)
            
            ((dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).count
            
            //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.count)
            for i in 0 ..< ((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).count
            {
                // let  dict = arrdata[i] as! NSDictionary
                let dictMain=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                // print(dictMain)
                // let dictMain=dictNewMemberListjsonResult.objectForKey("MemberDetail")!
                let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
                var memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
                var memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
                //familyPic
                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
                //
                
                //////////-----------
                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                
                memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
                if(memberCountry.characters.count>2)
                {
                    
                }
                else
                {
                    memberCountry="India"
                }

                /////////-----------
                
                
                
                let insertSQLUpdate = "UPDATE ProfileMaster SET grpId='"+grpID+"' ,isAdmin='"+isAdmin+"',memberName='"+memberNames+"',memberEmail='"+memberEmail+"',memberMobile='"+memberMobile+"',memberCountry='"+memberCountry+"',profilePic='"+profilePic+"',familyPic='"+familyPic+"',isPersonalDetVisible='"+isPersonalDetVisible+"',isBussinessDetVisible='"+isBusinDetVisible+"',isFamilyDetVisible='"+isFamilDetailVisible+"' where masterId="+masterID+" and profileId='"+profileID+"'"
                
                
                
                
                
                
                
                
                
                let result = contactDB?.executeStatements(insertSQLUpdate)
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                
                var cdicvxcTempxcvoxcvraryDxcvictionavcry:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                
                
                
                let dictMainasdas=cdicvxcTempxcvoxcvraryDxcvictionavcry.object(forKey: "personalMemberDetails")
                // print(dictMainasdas)
                
                for j in 0 ..< (cdicvxcTempxcvoxcvraryDxcvictionavcry.object(forKey: "personalMemberDetails")! as AnyObject).count
                {
                    let dictChild=(cdicvxcTempxcvoxcvraryDxcvictionavcry.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
                    
                    //print(dictChild)
                    
                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
                    var value=(dictChild as AnyObject).object(forKey: "value")as! String
                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                    
                    
                    value=(value as NSString).replacingOccurrences(of: "'", with: "`")

                    
                    
                    
                    let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='personal' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"' and groupId='"+GroupID+"'"
                    
                    let result = contactDB?.executeStatements(childSQLUpdate)
                    if (result == nil)
                    {
                        print("ErrorAi: \(contactDB?.lastErrorMessage())")
                    }
                    else
                    {
                    }
                }
                //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectForKey("UpdatedMemberList")!.objectAtIndex(i).objectForKey("businessMemberDetails")!.count)
                // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectForKey("UpdatedMemberList")!.objectAtIndex(i).objectForKey("businessMemberDetails")!)
              
                var dictTemporaryDictionaryzfdhjhhjkhkhjkhj:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                
                
                for j in 0 ..< (dictTemporaryDictionaryzfdhjhhjkhkhjkhj.object(forKey: "businessMemberDetails")! as AnyObject).count
                {
                    
                    let dictChild=(dictTemporaryDictionaryzfdhjhhjkhkhjkhj.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
                    
                    print("businessMemberDetails**businessMemberDetails**businessMemberDetails**",dictChild)
                    
                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
                    let value=(dictChild as AnyObject).object(forKey: "value")as! String
                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                    
                    
                    let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='Business',masterId='"+masterID+"' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"'  and moduleID='"+moduleID+"' and groupId='"+GroupID+"' "
                    
                    // print(childSQL)
                    let result = contactDB?.executeStatements(childSQLUpdate)
                    if (result == nil)
                    {
                        print("ErrorAi: \(contactDB?.lastErrorMessage())")
                    }
                    else
                    {
                        
                    }
                }
                
                //3. PersonalBusinessMemberDetails
                
                var dictsTempsoraryDisctionsarylaterss:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                
                
                var varGetCountFamilyMemberDetail:Int!=((dictsTempsoraryDisctionsarylaterss.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
              
                
                print(masterID)
                if(varGetCountFamilyMemberDetail>0)
                {
                    let insertSQLDelete = "DELETE FROM  FamilyMemberDetail  where masterId="+masterID+""
                    let result = contactDB?.executeStatements(insertSQLDelete)
                    if (result == nil)
                    {
                        print("ErrorAi: \(contactDB?.lastErrorMessage())")
                    }
                }
                
                
                var dictTemporaryDictionary:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                
                for k in 0 ..< ((dictTemporaryDictionary.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                    
                {
                    
                    // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectForKey("UpdatedMemberList")!.objectAtIndex(i).objectForKey("familyMemdfgberDetails")!.objectForKey("familyMemberDetail")!)
                    
                    
                    var dictTsdfemporsdfaryDictidfsfonary:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                    
                    let dictChild=((dictTemporaryDictionary.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)
                    
                    let isVisible=(dictTsdfemporsdfaryDictidfsfonary.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
                    
                    let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
                    let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
                    let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
                    let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
                    let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
                    let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
                    let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
                    let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
                    let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
                    /*
                     let familyMemberDetailsUpdate = "UPDATE FamilyMemberDetail  SET isVisible='"+isVisible+"',memberName='"+memberName+"',relationship='"+relationship+"',dob='"+dob+"',emailID='"+emailID+"',anniversary='"+anniversary+"',contactNo='"+contactNo+"',particulars='"+particulars+"',bloodGroup='"+bloodGroup+"',masterId='"+masterID+"' WHERE familyMemberId='"+familyMemberId+"' and profileId='"+profileID+"'"
                     
                     */
                    
                    
                    
                    
                    
                    
                    let familyMemberDetailsUpdate = "INSERT INTO FamilyMemberDetail (profileId,isVisible,familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,particulars,bloodGroup,masterId) VALUES("+profileID+",'"+isVisible+"','"+familyMemberId+"','"+memberName+"','"+relationship+"','"+dob+"','"+emailID+"','"+anniversary+"','"+contactNo+"','"+particulars+"','"+bloodGroup+"','"+masterID+"')"
                    let resultinserts = contactDB?.executeStatements(familyMemberDetailsUpdate)
                    if (resultinserts == nil)
                    {
                        print("ErrorAi: \(contactDB?.lastErrorMessage())")
                    }
                    else
                    {
                        
                    }
                }
                
                //4.  AddressDetails
                
                var diasdctTasdemposdrrasdaryDsdaictioasdnary:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                
                
                for l in 0 ..< ((diasdctTasdemposdrrasdaryDsdaictioasdnary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
                {
                    
                    
                    
                    let dictChild=((diasdctTasdemposdrrasdaryDsdaictioasdnary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
                    
                    let isBusinessAddrVisible=(diasdctTasdemposdrrasdaryDsdaictioasdnary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
                    let isResidanceAddrVisible=(diasdctTasdemposdrrasdaryDsdaictioasdnary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
                    
                    
                    // print(dictChild)
                    
                    // print(isBusinessAddrVisible)
                    // print(isResidanceAddrVisible)
                    
                    let address=(dictChild as AnyObject).object(forKey: "address")as! String
                    let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
                    let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
                    let city=(dictChild as AnyObject).object(forKey: "city")as! String
                    var country=(dictChild as AnyObject).object(forKey: "country")as! String
                    let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
                    let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
                    let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
                    let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
                    let state=(dictChild as AnyObject).object(forKey: "state")as! String
                    
                    
                    
                    let insertSQLDelete = "DELETE FROM  AddressDetails  where addressID='"+addressID+"' "
                    let resultt = contactDB?.executeStatements(insertSQLDelete)
                    if (resultt == nil)
                    {
                        print("ErrorAi: \(contactDB?.lastErrorMessage())")
                    }
                    
                    
                    print("this is country from rajendra side 999666")
                    print(country)
                    
                    if(country.characters.count>2)
                    {
                        
                    }
                    else
                    {
                        country="India"
                    }
                    // print(dictChild)
                    let familyMemberDetails = "INSERT INTO AddressDetails (profileId,AddressprofileId,addressID,addressType,address,city,state,country,pincode,phoneNo,fax,isBusinessAddrVisible,isResidanceAddrVisible,masterId) VALUES("+profileID+",'"+AddressprofileId+"','"+addressID+"','"+addressType+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+phoneNo+"','"+fax+"','"+isBusinessAddrVisible+"','"+isResidanceAddrVisible+"','"+masterID+"')"
                    
                      print(familyMemberDetails)
                    print("AddressDetails")
                    
                    let result = contactDB?.executeStatements(familyMemberDetails)
                    if (result == nil)
                    {
                        print("ErrorAi: \(contactDB?.lastErrorMessage())")
                    }
                    else
                    {
                        
                    }
                    /*
                     let addressDetailUpdate = "UPDATE AddressDetails  SET AddressprofileId='"+AddressprofileId+"',addressType='"+addressType+"',address='"+address+"',city='"+city+"',state='"+state+"',country='"+country+"',pincode='"+pincode+"',phoneNo='"+phoneNo+"',fax='"+fax+"',isBusinessAddrVisible='"+isBusinessAddrVisible+"',isResidanceAddrVisible='"+isResidanceAddrVisible+"',masterId='"+masterID+"' WHERE addressID='"+addressID+"' and profileId='"+profileID+"'"
                     
                     
                     let result = contactDB?.executeStatements(addressDetailUpdate)
                     if (result == nil)
                     {
                     print("ErrorAi: \(contactDB?.lastErrorMessage())")
                     }
                     else
                     {
                     
                     }
                     */
                }
                
            }
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        contactDB?.close()
    }
    
    
    
    //--download zip file and unZip it in local Directory
    func functionForDownloadZipFile(_ stringZipFilePath:String)
    {
        ///-----------------------------------------------------ppppppppp---------------
        let destinationn = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        
        Alamofire.download(stringZipFilePath,method: .get,parameters: nil,encoding: JSONEncoding.default, headers: nil,to: destinationn).downloadProgress(closure: { (progress) in
                //progress closure
            }).response(completionHandler: { (DefaultDownloadResponse) in
                //here you able to access the DefaultDownloadResponse
                //---------------------------------------------------------------------------------------
                //get zip file from document directory
                let dirst = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as? [String]
                // print(dirst)
                if dirst != nil
                {
                    let dirt = dirst![0]
                    do {
                        let fileList = try FileManager.default.contentsOfDirectory(atPath: dirt)
     // print(fileList)
     for i in 00 ..< fileList.count
     {
         let file:String = "ABC"
         var varValue=fileList[i]
         //print(varValue)
         if(varValue.hasSuffix(".zip"))
         {
             var varGetFilePAth:String=""
             varGetFilePAth=fileList[i]
             // print(varGetFilePAth)
             //here need to unwip file
             let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
             
             print(documentsPath)
             print(varGetFilePAth)
             
            /// let zipPath:String =  (string: documentsPath+"/"+varGetFilePAth) as! String ;
             
             let zipPath:String =  documentsPath+"/"+varGetFilePAth

             print(zipPath)
             
             
             
             // print(zipPath)
             if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first
             {
                 //below code zip to unzip
                 let path:String = String(describing: NSURL(fileURLWithPath: dir).appendingPathComponent(""))
                 // print(zipPath)
                 // print(path)
                 let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                 SSZipArchive.unzipFile(atPath: String(zipPath), toDestination: String(documentsPath))
                 //code for get unzip file insert update delete
                 self.functionForGetNewUpdateDeleteMember()
             }
         }
         else
         {
             //self.view.makeToast("Error occuring, While fetching data", duration: 3, position: CSToastPositionCenter)
         }
     }
 }
        catch
        {
        }
    }
    else
    {
        self.view.makeToast("Error occuring, While fetching data", duration: 3, position: CSToastPositionCenter)
    }
    //
    //-----------------------------------------------------------------------------------------
                //result closure
            })
        //-------------------------------------------------------ppppppppp-----------------
        
        
//        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
//
//        Alamofire.download(.GET, stringZipFilePath, destination: destination)
//            .response { _, _, _, error in
//                if error != nil
//                {
//                    print("Failed with error: \(error)")
//                    let letGetResponse:String!=String(error)
//                    self.view.makeToast("Error occuring, While fetching data from server.", duration: 3, position: CSToastPositionCenter)
//                }
//                else
//                {
//                    //get zip file from document directory
//                    let dirst = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
//                    // print(dirst)
//                    if dirst != nil
//                    {
//                        let dirt = dirst![0]
//                        do {
//                            let fileList = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(dirt)
//                            // print(fileList)
//                            for i in 00 ..< fileList.count
//                            {
//                                let file:String = "ABC"
//                                var varValue=fileList[i]
//                                //print(varValue)
//                                if(varValue.hasSuffix(".zip"))
//                                {
//                                    var varGetFilePAth:String=""
//                                    varGetFilePAth=fileList[i]
//                                    // print(varGetFilePAth)
//                                    //here need to unwip file
//                                    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
//                                    let zipPath:String =  (string: documentsPath+"/"+varGetFilePAth);
//                                    // print(zipPath)
//                                    if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
//                                    {
//                                        //below code zip to unzip
//                                        let path:String = String(NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(""))
//                                        // print(zipPath)
//                                        // print(path)
//                                        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
//                                        WPZipArchive.unzipFileAtPath(String(zipPath), toDestination: String(documentsPath))
//                                        //code for get unzip file insert update delete
//
//
//
//
//                                        self.functionForGetNewUpdateDeleteMember()
//
//                                    }
//                                }
//                                else
//                                {
//                                    //self.view.makeToast("Error occuring, While fetching data", duration: 3, position: CSToastPositionCenter)
//
//                                }
//                            }
//
//
//
//                        }
//                        catch
//                        {
//                        }
//                    }
//                    else
//                    {
//                        self.view.makeToast("Error occuring, While fetching data", duration: 3, position: CSToastPositionCenter)
//                    }
//                    //
             //   }
       // }
    }

    //code for get new update delete record files and insert update and delete in table
    func functionForGetNewUpdateDeleteMember()
    {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        //1.New members
        let MyFilesPath = documentsPath.appendingPathComponent("/NewMembers")
        do {
 let fileList = try FileManager.default.contentsOfDirectory(atPath: MyFilesPath)
 let count = fileList.count
 varGetTotalFilesCount=count
 print(fileList)
 print(count)
 for i in 0 ..< count
 {
 // print(fileList[i])
 if(fileList[i].hasPrefix("New"))
 {
   
   let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: MyFilesPath+"/"+fileList[i]))
   do
   {
       let NewMemberListjsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
       // if(fileList[i]=="New7.json")
       //{
        print(fileList[i])
       //print(NewMemberListjsonResult)
     
       varGetForLoopCounting=i+1
       /*------------§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§£££££££££££££££££££££££££££------------------------*/
       let zipPath:String =  MyFilesPath+"/"+fileList[i]
       let fileManager = FileManager.default
       try fileManager.removeItem(atPath: zipPath)
       self.functionForAddNewMembers(NewMemberListjsonResult)
   }
   catch
   {
   }
            }
          }
        }
        catch
        {
        }
        //2.Update members
        let MyFilesPath2 = documentsPath.appendingPathComponent("/UpdatedMembers")
        do {
            let fileList = try FileManager.default.contentsOfDirectory(atPath: MyFilesPath2)
            let count = fileList.count
            //print(fileList)
            print(count)
            for i in 0 ..< count
            {
                // print(fileList[i])
                if(fileList[i].hasPrefix("Update"))
                {
                    let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: MyFilesPath2+"/"+fileList[i]))
                    do
                    {
                        print(MyFilesPath2+"/"+fileList[i])
                        let UpdateMemberListjsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
                        // print(UpdateMemberListjsonResult)
                        // if(fileList[i]=="New7.json")
                        //{
                        //print("This is file name:----")
                         print(fileList[i])
                        //print(UpdateMemberListjsonResult)
                        self.functionForUpdateMembers(UpdateMemberListjsonResult)

                        let zipPath:String =  MyFilesPath2+"/"+fileList[i]
                        
                        //   print(zipPath)
                        // if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
                        //  {
                        let fileManager = FileManager.default
                        try fileManager.removeItem(atPath: zipPath)

                        //}
                    }
                    catch
                    {
                    }
                }
            }
        }
        catch
        {
        }
        //3.Delete members
        let MyFilesPath3 = documentsPath.appendingPathComponent("/DeletedMembers")
        do {
            let fileList = try FileManager.default.contentsOfDirectory(atPath: MyFilesPath3)
            let count = fileList.count
            //print(fileList)
            // print(count)
            for i in 0 ..< count
            {
                //  print(fileList[i])
                if(fileList[i].hasPrefix("Delete"))
                {
                    let letGetDeletedID = try NSString(contentsOf:URL(fileURLWithPath: (MyFilesPath3+"/"+fileList[i])), encoding: String.Encoding.utf8.rawValue)
                    // print(letGetDeletedID)
                    let letGetId=letGetDeletedID.components(separatedBy: ",")
                    self.functionForDeleteMembers(letGetId)
                    let zipPath:String =  MyFilesPath3+"/"+fileList[i]
                    
                    //   print(zipPath)
                    // if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
                    //  {
                    let fileManager = FileManager.default
                    try fileManager.removeItem(atPath: zipPath)
                    

                    
                }
            }
        }
        catch
        {
        }
         fetchData()
    }
    //1.Add new members
    func functionForAddNewMembers(_ dictNewMemberListjsonResult:NSDictionary)
    {
       // print(dictNewMemberListjsonResult)
        var moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
        
        
        print(UserDefaults.standard.value(forKey: "session_GetModuleId")as! String)
        print(UserDefaults.standard.value(forKey: "session_GetGroupId")as! String)
        var GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path

        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            contactDB?.beginTransaction()

            for i in 0 ..< (dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).count
            {
              autoreleasepool {
              // let  dict = arrdata[i] as! NSDictionary
              let dictMain=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
              let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
                var memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
                var memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
                
                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
                //print("Profile Master",i)
                
                print(dictNewMemberListjsonResult)
                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                print("this is name by rajendra jat")
                print(memberName)
                print(dictNewMemberListjsonResult)
                memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")

           
                
                
                print(dictMain)
                print(profilePic)
                print(familyPic)

                if(memberCountry.characters.count>2)
                {
                    
                }
                else
                {
                    memberCountry="India"
                }
                
                
                let insertSQL = "INSERT INTO ProfileMaster (masterId,grpId,profileId,isAdmin,memberName,memberEmail,memberMobile,memberCountry,profilePic,familyPic,isPersonalDetVisible,isBussinessDetVisible,isFamilyDetVisible) VALUES('"+masterID+"','"+grpID+"','"+profileID+"','"+isAdmin+"','"+memberNames+"','"+memberEmail+"','"+memberMobile+"','"+memberCountry+"','"+profilePic+"','"+familyPic+"','"+isPersonalDetVisible+"','"+isBusinDetVisible+"','"+isFamilDetailVisible+"')"
                print(insertSQL)
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                      var dihjkctTehjkmpochjkvxraryDicxcvtioxcvnary:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)

                    for j in 0 ..< (dihjkctTehjkmpochjkvxraryDicxcvtioxcvnary.object(forKey: "personalMemberDetails")! as AnyObject).count
                    {
                        let dictChild=(dihjkctTehjkmpochjkvxraryDicxcvtioxcvnary.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
                        let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                        let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                        let key=(dictChild as AnyObject).object(forKey: "key")as! String
                        var value=(dictChild as AnyObject).object(forKey: "value")as! String
                        let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                        let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                        let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                        
                        //print("PersonalBusinessMemberDetails Personal",j)
                        value=(value as NSString).replacingOccurrences(of: "'", with: "`")

                        
                        
                        let childSQLl = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','personal','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                        //   print(childSQLl)
                        let result = contactDB?.executeStatements(childSQLl)
                        if (result == nil)
                        {
                            print("ErrorAi: \(contactDB?.lastErrorMessage())")
                        }
                        else
                        {
                            
                        }
                    }
                    //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                    // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!./count)
                    
                      var didfgctdgTempdfgorarydfgDicdfgtionardfgyghdfg:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                    
                    for j in 0 ..< (didfgctdgTempdfgorarydfgDicdfgtionardfgyghdfg.object(forKey: "businessMemberDetails")! as AnyObject).count
                    {
                        let dictChild=(didfgctdgTempdfgorarydfgDicdfgtionardfgyghdfg.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
                        let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                        let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                        let key=(dictChild as AnyObject).object(forKey: "key")as! String
                        let value=(dictChild as AnyObject).object(forKey: "value")as! String
                        let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                        let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                        let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                        
                        let childSQLNewww = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','Business','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                        // print(childSQLNewww)
                        
                        //print("PersonalBusinessMemberDetails Business",j)
                        
                        
                        let result = contactDB?.executeStatements(childSQLNewww)
                        if (result == nil)
                        {
                            print("ErrorAi: \(contactDB?.lastErrorMessage())")
                        }
                        else
                        {
                            
                        }
                    }
                    //3. PersonalBusinessMemberDetails
                    // print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("familyMembdfgerDetails")!.count)
                    // for k in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(0).objectForKey("familyMemsdfgberDetails")!.count
                    
                    
                    
                      var dfdidctTemporaryDictionarybnvcxzvbnmcdsx:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                    
                    
                    
                    for k in 0 ..< ((dfdidctTemporaryDictionarybnvcxzvbnmcdsx.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                    {
                        let isVisible=(dfdidctTemporaryDictionarybnvcxzvbnmcdsx.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
                        let dictChild=((dfdidctTemporaryDictionarybnvcxzvbnmcdsx.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)
                        
                        let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
                        let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
                        let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
                        let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
                        let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
                        let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
                        let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
                        let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
                        let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
                        

                        let familyMemberDetails = "INSERT INTO FamilyMemberDetail (profileId,isVisible,familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,particulars,bloodGroup,masterId) VALUES("+profileID+",'"+isVisible+"','"+familyMemberId+"','"+memberName+"','"+relationship+"','"+dob+"','"+emailID+"','"+anniversary+"','"+contactNo+"','"+particulars+"','"+bloodGroup+"','"+masterID+"')"
                        
                        let result = contactDB?.executeStatements(familyMemberDetails)
                        if (result == nil)
                        {
                            print("ErrorAi: \(contactDB?.lastErrorMessage())")
                        }
                        else
                        {
                            
                        }
                    }
                    //4.  AddressDetails
                   
                    
                      var hjdihjkctTemkhjporaryDictionacdzxdryhjk:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                    
                    
                    let dictChild=(hjdihjkctTemkhjporaryDictionacdzxdryhjk.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")

                    print("my value:------ ")
                    print(dictChild)

   for l in 0 ..< ((hjdihjkctTemkhjporaryDictionacdzxdryhjk.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
    {
       let isBusinessAddrVisible=(hjdihjkctTemkhjporaryDictionacdzxdryhjk.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
       let isResidanceAddrVisible=(hjdihjkctTemkhjporaryDictionacdzxdryhjk.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
       
       
       var dictTemporaryDictionarydfdsdyttysfsdf:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)

     let dictChild=((dictTemporaryDictionarydfdsdyttysfsdf.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
      
      let address=(dictChild as AnyObject).object(forKey: "address")as! String
      let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
      let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
      let city=(dictChild as AnyObject).object(forKey: "city")as! String
      var country=(dictChild as AnyObject).object(forKey: "country")as! String
      let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
      let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
      let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
      //print(pincode)
      let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
      
      let state=(dictChild as AnyObject).object(forKey: "state")as! String
      // print(state)
      
      print("this is country from rajendra side 88888")
      print(country)
      
      if(country.characters.count>2)
      {
          
      }
      else
      {
         country="India"
      }
    
      print("This is value by rajenadra jat˙˙˙˙˙˙˙˙˙˙˙¬¬˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚")
      print(country)
      let familyMemberDetails = "INSERT INTO AddressDetails (profileId,AddressprofileId,addressID,addressType,address,city,state,country,pincode,phoneNo,fax,isBusinessAddrVisible,isResidanceAddrVisible,masterId) VALUES("+profileID+",'"+AddressprofileId+"','"+addressID+"','"+addressType+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+phoneNo+"','"+fax+"','"+isBusinessAddrVisible+"','"+isResidanceAddrVisible+"','"+masterID+"')"
      
      //  print(familyMemberDetails)
      //print("AddressDetails",l)
      
      let result = contactDB?.executeStatements(familyMemberDetails)
      if (result == nil)
      {
          print("ErrorAi: \(contactDB?.lastErrorMessage())")
      }
      else
      {
          
      }
     }
    }
   }
            }
            contactDB?.commit()
            contactDB?.close()
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }

        print(varGetForLoopCounting)
        print(varGetTotalFilesCount)

        if(varGetForLoopCounting==varGetTotalFilesCount)
        {
            fetchData()
        }

    }
    //2. Update member««««««««««««««««««««-----»»»»»»»»»»»»»»»»»»»»»
    func functionForUpdateMembers(_ dictNewMemberListjsonResult:NSDictionary)
    {
        print(dictNewMemberListjsonResult)
       
        var moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
        var GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        
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
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            contactDB?.beginTransaction()
            print("11This is count of main start point of file:-----------")
            print((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).count)
            for i in 0 ..< (dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).count
            {
              
                let dictMain=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                
                
                let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
                let memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
                var memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String

                
                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
                
                
                if(memberCountry.characters.count>2)
                {
                    
                }
                else
                {
                    memberCountry="India"
                }
                
                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                  memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
                

                print(profilePic)
                 print(familyPic)
                print(dictMain)
                
                let insertSQLUpdate = "UPDATE ProfileMaster SET grpId='"+grpID+"' ,isAdmin='"+isAdmin+"',memberName='"+memberNames+"',memberEmail='"+memberEmail+"',memberMobile='"+memberMobile+"',memberCountry='"+memberCountry+"',profilePic='"+profilePic+"',familyPic='"+familyPic+"',isPersonalDetVisible='"+isPersonalDetVisible+"',isBussinessDetVisible='"+isBusinDetVisible+"',isFamilyDetVisible='"+isFamilDetailVisible+"' where masterId="+masterID+" and profileId='"+profileID+"'"
              print("user image !")
                print(insertSQLUpdate)
                
                let result = contactDB?.executeStatements(insertSQLUpdate)
                /*
                    for j in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("personalMemberDetails")!.count
                    {
                        let dictChild=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("personalMemberDetails")!.objectAtIndex(j)
                        let fieldID=dictChild.objectForKey("fieldID")as! String
                        let uniquekey=dictChild.objectForKey("uniquekey")as! String
                        let key=dictChild.objectForKey("key")as! String
                        let value=dictChild.objectForKey("value")as! String
                        let colType=dictChild.objectForKey("colType")as! String
                        let isEditable=dictChild.objectForKey("isEditable")as! String
                        let isVisible=dictChild.objectForKey("isVisible")as! String
                        let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='personal',masterId='"+masterID+"' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"'and groupId='"+GroupID+"'"
                    let result = contactDB?.executeStatements(childSQLUpdate)
                    }
                */
                
                /*££££££££££££££££££££££££‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹*/
                
                
                  var diasdctTemaasdsdporarasdyDictionarysdsadsa:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                
                for j in 0 ..< (diasdctTemaasdsdporarasdyDictionarysdsadsa.object(forKey: "personalMemberDetails")! as AnyObject).count
                {
                    let dictChild=(diasdctTemaasdsdporarasdyDictionarysdsadsa.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
                    var value=(dictChild as AnyObject).object(forKey: "value")as! String
                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                    value=(value as NSString).replacingOccurrences(of: "'", with: "`")
                   
                    /*
                    let insertSQLDelete = "DELETE FROM  PersonalBusinessMemberDetails  where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"'and groupId='"+GroupID+"'"
                    let result = contactDB?.executeStatements(insertSQLDelete)
                    */
                    
                    
                    
                    
                    
                    let childSQLl = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','personal','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                    let resultT = contactDB?.executeStatements(childSQLl)
                   
                }
                /*££££££££££££££££££££££££‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹*/
               
                  var asddasdicastTeasdmdporarydDictidaqwonarysdsasd:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                
                for j in 0 ..< (asddasdicastTeasdmdporarydDictidaqwonarysdsasd.object(forKey: "businessMemberDetails")! as AnyObject).count
                {
                    let dictChild=(asddasdicastTeasdmdporarydDictidaqwonarysdsasd.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
                    let value=(dictChild as AnyObject).object(forKey: "value")as! String
                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                    
                    /*
                    let insertSQLDelete = "DELETE FROM  PersonalBusinessMemberDetails  where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"' and groupId='"+GroupID+"'"
                    let result = contactDB?.executeStatements(insertSQLDelete)
                    */
                    
                    
                    
                    let childSQLNewww = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','Business','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                    let resultT = contactDB?.executeStatements(childSQLNewww)
                   
                }
                /*££££££££££££££££££££££££‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹*/

                
                
                
                
                
                    //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                /*
                    for j in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!.count
                    {
                        
                        let dictChild=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!.objectAtIndex(j)
                        let fieldID=dictChild.objectForKey("fieldID")as! String
                        let uniquekey=dictChild.objectForKey("uniquekey")as! String
                        let key=dictChild.objectForKey("key")as! String
                        let value=dictChild.objectForKey("value")as! String
                        let colType=dictChild.objectForKey("colType")as! String
                        let isEditable=dictChild.objectForKey("isEditable")as! String
                        let isVisible=dictChild.objectForKey("isVisible")as! String
                        
                        
                        let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='Business',masterId='"+masterID+"' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"' and groupId='"+GroupID+"'"
 
                        let result = contactDB?.executeStatements(childSQLUpdate)
                        
                    }
                */
                    //3. PersonalBusinessMemberDetails
                 var dictTempsdforasdfryDictionaryfddsfsafdsfds:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                for k in 0 ..< ((dictTempsdforasdfryDictionaryfddsfsafdsfds.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                    {
                        
                        let isVisible=(dictTempsdforasdfryDictionaryfddsfsafdsfds.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
                        let dictChild=((dictTempsdforasdfryDictionaryfddsfsafdsfds.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)
                        
                        let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
                        let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
                        let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
                        let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
                        let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
                        let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
                        let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
                        let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
                        let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
                        
                        let familyMemberDetailsUpdate = "UPDATE FamilyMemberDetail  SET isVisible='"+isVisible+"',memberName='"+memberName+"',relationship='"+relationship+"',dob='"+dob+"',emailID='"+emailID+"',anniversary='"+anniversary+"',contactNo='"+contactNo+"',particulars='"+particulars+"',bloodGroup='"+bloodGroup+"',masterId='"+masterID+"' WHERE familyMemberId='"+familyMemberId+"' and profileId='"+profileID+"'"

 let result = contactDB?.executeStatements(familyMemberDetailsUpdate)
                      
                    }
                
                    //4.  AddressDetails
                
                
                var disdfctTesdfmposdfraryDictiodsdfdsnary:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                
                
                let dictChild=(disdfctTesdfmposdfraryDictiodsdfdsnary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")
                for l in 0 ..< ((disdfctTesdfmposdfraryDictiodsdfdsnary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
                {
                    
                    var dictsdadaasdTemertposdraryDictionary:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                    
                    
                    
                    let isBusinessAddrVisible=(dictsdadaasdTemertposdraryDictionary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
                    let isResidanceAddrVisible=(dictsdadaasdTemertposdraryDictionary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
                    
                    let dictChild=((dictsdadaasdTemertposdraryDictionary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
                    
                    let address=(dictChild as AnyObject).object(forKey: "address")as! String
                    let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
                    let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
                    let city=(dictChild as AnyObject).object(forKey: "city")as! String
                    var country=(dictChild as AnyObject).object(forKey: "country")as! String
                    let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
                    let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
                    let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
                    let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
                    let state=(dictChild as AnyObject).object(forKey: "state")as! String
                    
                    
                    print("this is country from rajendra side 666666")
                    print(country)
                    if(country.characters.count>2)
                    {
                        
                    }
                    else
                    {
                        country="India"
                    }
                    
                        let addressDetailUpdate = "UPDATE AddressDetails  SET AddressprofileId='"+AddressprofileId+"',addressType='"+addressType+"',address='"+address+"',city='"+city+"',state='"+state+"',country='"+country+"',pincode='"+pincode+"',phoneNo='"+phoneNo+"',fax='"+fax+"',isBusinessAddrVisible='"+isBusinessAddrVisible+"',isResidanceAddrVisible='"+isResidanceAddrVisible+"',masterId='"+masterID+"' WHERE addressID='"+addressID+"' and profileId='"+profileID+"'"
                        
                       let result = contactDB?.executeStatements(addressDetailUpdate)
                      
                    }
                    

              
            }

        }
        contactDB?.commit()
        contactDB?.close()
    }
    //3. Delete member««««««««««««««««««««-----»»»»»»»»»»»»»»»»»»»»»
    func functionForDeleteMembers(_ muaarayDeleteMemberListjsonResult:[String])
    {
        // print(muaarayDeleteMemberListjsonResult)
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
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
              contactDB?.beginTransaction()
            print("22This is count of main start point of file:-----------")
            for i in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                
//                let insertSQLDelete = "DELETE FROM  ProfileMaster  where profileId="+muaarayDeleteMemberListjsonResult[i]+""
                let insertSQLDelete = "DELETE FROM  ProfileMaster  where profileId in (\(muaarayDeleteMemberListjsonResult[i]))"
                print(insertSQLDelete)
                let result = contactDB?.executeStatements(insertSQLDelete)
                if (result == nil)
                {
                    print("ErrorAi 11: \(contactDB?.lastErrorMessage())")
                }
            }
            //1......if master table entry inserted then need to data in PersonalBusinessMemberDetails
            
            print("_____________________________________________________________________________________________________\n")
            for j in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
//                let childSQLDelete = "DELETE FROM PersonalBusinessMemberDetails where profileId="+muaarayDeleteMemberListjsonResult[j]+" and PersonalORBusiness='personal'"
                let childSQLDelete = "DELETE FROM PersonalBusinessMemberDetails where profileId in ("+muaarayDeleteMemberListjsonResult[j]+") and PersonalORBusiness='personal'"

                print(childSQLDelete)
                let result = contactDB?.executeStatements(childSQLDelete)
                if (result == nil)
                {
                    print("ErrorAi 22: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    
                }
            }
             print("_____________________________________________________________________________________________________\n")
            //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
            for j in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
//                let childSQLDelete = "DELETE FROM  PersonalBusinessMemberDetails where profileId="+muaarayDeleteMemberListjsonResult[j]+" and PersonalORBusiness='Business'"
                let childSQLDelete = "DELETE FROM  PersonalBusinessMemberDetails where profileId in ("+muaarayDeleteMemberListjsonResult[j]+") and PersonalORBusiness='Business'"

                print(childSQLDelete)
                let result = contactDB?.executeStatements(childSQLDelete)
                if (result == nil)
                {
                    print("ErrorAi 33: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    
                }
            }
             print("_____________________________________________________________________________________________________\n")
            //3. PersonalBusinessMemberDetails
            for k in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
//                let familyMemberDetailsDelete = "DELETE FROM  FamilyMemberDetail  where profileId="+muaarayDeleteMemberListjsonResult[k]+""
                 let familyMemberDetailsDelete = "DELETE FROM  FamilyMemberDetail  where profileId in ("+muaarayDeleteMemberListjsonResult[k]+")"
                print(familyMemberDetailsDelete)
                let result = contactDB?.executeStatements(familyMemberDetailsDelete)
                if (result == nil)
                {
                    print("ErrorAi 44: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    
                }
            }
             print("_____________________________________________________________________________________________________\n")
            //4.  AddressDetails
            for l in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
//                let addressDetailDelete = "DELETE FROM  AddressDetails  where profileId="+muaarayDeleteMemberListjsonResult[l]+""
                let addressDetailDelete = "DELETE FROM  AddressDetails  where profileId in ("+muaarayDeleteMemberListjsonResult[l]+")"
                
                print(addressDetailDelete)
                let result = contactDB?.executeStatements(addressDetailDelete)
                if (result == nil)
                {
                    print("ErrorAi 55: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    
                }
            }
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //---
        contactDB?.commit()
        contactDB?.close()
        if(varGetForLoopCounting==varGetTotalFilesCount)
        {
            print("∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞")
            print(varGetForLoopCounting)
            print(varGetTotalFilesCount)
            
            
        }
    }
    //--««««««««««««««««««««««««««««–--select query for select data------»»»»»»»»»»»»»»»»»»»»»»»»»»»»
    
    /*------------------------------Search by Name And Mobile Number-------------by dpk----------------------------*/
    func fetchDataFORClubName(_ varClubName:String?)
    {
//            var memberDetail = self.dirOnline?.memberDetail?.memberDetails
//            let filteredMembers = memberDetail?.filter { $0.memberName?.lowercased().contains(varClubName?.lowercased() ?? "")}
//            memberDetail = filteredMembers
//            directoryTableView.reloadData()
        var memberDetail = self.dirOnline?.memberDetail?.memberDetails
        let filteredMembers = memberDetail?.filter { member in
            guard let memberName = member.memberName?.lowercased(),
                  let clubName = varClubName?.lowercased() else { return false }
            print("clubName\(clubName)")
            print("FILTERmemberName\(memberName)")
            return memberName.contains(clubName) // Return true if memberName contains clubName
        }
        memberDetail = filteredMembers 
        self.memberDetailMemberName = filteredMembers
//        print("FILTERED CLUB NAME:: \(memberDetail)")
        print("FILTERED CLUB NAME:: \(self.memberDetailMemberName)")
        print("FILTERED CLUB COUNT:: \(self.memberDetailMemberName?.count)")
        
        directoryTableView.reloadData() // Reload table view data

        
        
//        var memberDetail = self.dirOnline?.memberDetail?.memberDetails
//        print("DETAILED CLUB NAME:: \(memberDetail)")
//        if let varClubName = varClubName {
//            let filteredMembers = memberDetail?.filter { member in
//                if let memberName = member.memberName {
//                    return memberName.lowercased().contains(varClubName.lowercased())
//                }
//                NoRecordLabel.isHidden = false
//                return false
//            }
//            NoRecordLabel.isHidden = true
//            memberDetail = filteredMembers
//            directoryTableView.reloadData()
//            
//            print("FILTERED CLUB NAME:: \(memberDetail)")
//        }

        
//        mainArray.removeAllObjects()
//        mainArray=NSMutableArray()
//        var moduleID = UserDefaults.standard.string(forKey: "session_GetModuleId")
//        var GroupID = UserDefaults.standard.string(forKey: "session_GetGroupId")
//        
//        var databasePath : String
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
//            print("error opening database")
//        }else{
//            // self.Createtablecity()
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil {
//            print("Error: \(contactDB?.lastErrorMessage())")
//        }
//        //masterUID, groupId , moduleId , profileID , MemberDesignation , memberName , pic , membermobile From Board_Of_Directors_List
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//        if (contactDB?.open())!
//            
//        {
//            
//            //let querySQL = "SELECT * FROM ProfileMaster where memberName like '%\(varClubName)%' or memberMobile like '%\(varClubName)%' and grpId = '\(GroupID!)'"
//            // When Search narendra and No available in directory but show in after search
//            //let querySQL = "SELECT * FROM ProfileMaster where grpId  = '\(grpID)' and memberName like '%\(varClubName)%' or  memberMobile like '%\(varClubName)%' order by memberName asc"
//           // let querySQL = "SELECT *  FROM ProfileMaster where (grpId  = '\(grpID)' and memberName like '%\(varClubName)%')  or (grpId  = '\(grpID)' and  memberMobile like '%\(varClubName)%') order by memberName COLLATE NOCASE asc"
//            
//            
//            let querySQL = "SELECT DISTINCT memberName,memberMobile,masterId,profileId,isAdmin,isPersonalDetVisible,isBussinessDetVisible,isFamilyDetVisible,grpId,profilePic,familyPic  FROM ProfileMaster where (grpId  = '\(grpID!)' and memberName like '%\(varClubName)%')  or (grpId  = '\(grpID!)' and  memberMobile like '%\(varClubName)%') order by memberName COLLATE NOCASE asc"
//            
//            
//            
//            
//            
//            // print(querySQL)
//            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
//            
//            while results?.next() == true {
//                let dd = NSMutableDictionary ()
//                dd.setValue((results?.string(forColumn: "memberName"))! as String, forKey:"memberName")
//                dd.setValue((results?.string(forColumn: "memberMobile"))! as String, forKey:"memberMobile")
//                dd.setValue((results?.string(forColumn: "masterId"))! as String, forKey:"masterId")
//                dd.setValue((results?.string(forColumn: "profileId"))! as String, forKey:"profileId")
//                dd.setValue((results?.string(forColumn: "isAdmin"))! as String, forKey:"isAdmin")
//                dd.setValue((results?.string(forColumn: "isPersonalDetVisible"))! as String, forKey:"isPersonalDetVisible")
//                dd.setValue((results?.string(forColumn: "isBussinessDetVisible"))! as String, forKey:"isBussinessDetVisible")
//                dd.setValue((results?.string(forColumn: "isFamilyDetVisible"))! as String, forKey:"isFamilyDetVisible")
//                dd.setValue((results?.string(forColumn: "grpId"))! as String, forKey:"grpId")
//                dd.setValue((results?.string(forColumn: "profilePic"))! as String, forKey:"profilePic")
//                
//                if(self.isCategory=="2")
//                {
//                    
//                }
//                else
//                {
//                    dd.setValue((results?.string(forColumn: "familyPic"))! as String, forKey:"familyPic") //31-08-2017
//                    
//                }
//
//                //
//                
//                
//                mainArray.add(dd)
//                print(dd)
//            }
//            if mainArray.count > 0
//            {
//                NoRecordLabel.isHidden = true
//                copymainArray=mainArray
//                directoryTableView.reloadData()
//            }
//            else
//            {
//                NoRecordLabel.isHidden = false
//                mainArray.removeAllObjects()
//                mainArray = NSMutableArray()
//                copymainArray=NSArray()
//                directoryTableView.reloadData()
//            }
//        }
        
//        contactDB?.close()
        if (self.memberDetailMemberName?.count == 0) && (self.tfCount != 0) {
//            directoryTableView.isHidden = true
            NoRecordLabel.isHidden = false
        } else {
            directoryTableView.isHidden = false
            NoRecordLabel.isHidden = true
            directoryTableView.reloadData()
        }
    }
    
    /*------------------------------Search by Name And Mobile Number-------------by dpk----------------------------*/
    
    
    
    //----
    //--Floating button isAdmin
    //--Floating button
    func functiuonFloatingAddButton()
    {
        let addAlbum = UIImage(named: "Add_member.png")!
        let deleteAlbum = UIImage(named: "deletedoc.png")!
        let phonebook = ActionButtonItem(title: "Add Photo", image: addAlbum)
        let editAlbum = UIImage(named: "green_edit.png")
        let editAlbums = ActionButtonItem(title: "Edit Album", image: editAlbum)
        
        phonebook.action =
            {
                item in print("Twitter...")
                
                
        }
        editAlbums.action =
            {
                item in print("Album...")
                let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotoViewController") as! AddPhotoViewController
                
                
        }
        let invitation = ActionButtonItem(title: "Delete Photo", image: deleteAlbum)
        invitation.action =
            {
                item in print("Google Plus...")
                
        }
        actionButton = ActionButton(attachedToView: self.view, items: [phonebook, invitation,editAlbums])
        actionButton.action = { button in button.toggleMenu() }
        actionButton.setTitle("+", forState: UIControl.State.normal)
        actionButton.backgroundColor = UIColor(red: 76.0/255.0, green: 176.0/255.0, blue: 80.0/255.0, alpha:1.0)
    }
    
    
    
    
    /*------------Search picker-------------Code by Deepak -------------------------------Start---------------------------------*/
    
    
    @IBAction func buttonOpticityClickEvent(_ sender: AnyObject)
    {
        buttonOpticity.isHidden=true
        viewForSettingPicker.isHidden=true
        varISPopVisisbleorNot=0
    }
    
    @IBAction func buttonDoneClickeventOnPicker(_ sender: AnyObject)
    {
//        mainArray.removeAllObjects()
//        mainArray=NSMutableArray()
//        var moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
//        var GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
//        
        varISPopVisisbleorNot=0
         textfieldForRotarianSearch.text! = ""
        if (varGetPickerSelectValue == "Rotarian")
        {
            buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
            directoryTableView.reloadData()
//            fetchData()
        }
        else if (varGetPickerSelectValue == "Classification")
        {
            buttonSearchRotarianType.setTitle("Classification",  for: UIControl.State.normal)
            directoryTableView.reloadData()
//    var databasePath : String
//    let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//    let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//    // open database
//    databasePath = fileURL.path
//    var db: OpaquePointer? = nil
//    if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//    {
//        print("error opening database")
//    }
//    else
//    {
//        // self.Createtablecity()
//    }
//    //print(databasePath)
//    let contactDB = FMDatabase(path: databasePath as String)
//    if contactDB == nil
//            {
//                print("Error: \(contactDB?.lastErrorMessage())")
//            }
//            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//            var varCounting:Int!=0
//            
//            
//            if (contactDB?.open())!
//            {
//                var querySQL = ""
//                querySQL = "SELECT value FROM PersonalBusinessMemberDetails where uniquekey='designation' and value!='' and moduleID='"+moduleID+"' and groupId='"+GroupID+"' group by value order by value COLLATE NOCASE asc"
//                print("thi sis print >>>>------")
//                print(querySQL)
//                let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
//  while results?.next() == true
//  {
//      let dd = NSMutableDictionary ()
//      dd.setValue((results?.string(forColumn: "value"))! as String, forKey:"value")
//      
//      mainArray.add(dd)
//      varCounting=varCounting+1
//      //print(dd)
//  }
//  if mainArray.count > 0
//  {
//      NoRecordLabel.isHidden = true
//      copymainArray=mainArray
//      directoryTableView.reloadData()
//  }
//  else
//  {
//      NoRecordLabel.isHidden = false
//      mainArray.removeAllObjects()
//      mainArray = NSMutableArray()
//      copymainArray=NSArray()
//      directoryTableView.reloadData()
//  }
//  //------
//  var result4:String!=""
//  var result6:String!=""
//  if(grpID.hasPrefix("Optional("))
//  {
//      var get:String!=grpID as String!
//      
//      
//      let result3 = String(get.dropFirst(9))    // "he"
//      print(result3)
//      grpID = String(result3.dropLast(1)) as NSString   // "o"
//      print("31313113133131131331313131311331133131313131",result4)
//      print(grpID)
//  }
//    print("print 2")
//  print(grpID)
//  let Count = "SELECT count(*) as Count from ProfileMaster where grpId = '\(grpID!)' and  uniquekey=designation"
//  print(Count)
//  let resultss:FMResultSet? = contactDB?.executeQuery(Count,withArgumentsIn: nil)
//  
//  while resultss?.next() == true
//  {
//      varGetCount=resultss?.string(forColumn: "Count")
//  }
//  varGetCount=String(varCounting)
//  //print(varGetCount)
//            }
//            contactDB?.close()
//            /*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/
//            
        }
            
        else if (varGetPickerSelectValue == "Family")
        {
            buttonSearchRotarianType.setTitle("Family",  for: UIControl.State.normal)
            directoryTableView.reloadData()
//            mainArray.removeAllObjects()
//            mainArray=NSMutableArray()
//            /*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/
//            var databasePath : String
//            let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//            // open database
//            databasePath = fileURL.path
//            var db: OpaquePointer? = nil
//            if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//            {
//                print("error opening database")
//            }
//            else
//            {
//                // self.Createtablecity()
//            }
//            // print(databasePath)
//            let contactDB = FMDatabase(path: databasePath as String)
//            if contactDB == nil
//            {
//                print("Error: \(contactDB?.lastErrorMessage())")
//            }
//            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
//            var varCounting:Int!=0
//            
//            
//            if (contactDB?.open())!
//            {
//                var querySQL = ""
//                querySQL = "SELECT DISTINCT t1.profileId as t1profileid,t1.masterId as t1masterId,t1.memberName as t1memberName,t1.grpId as t1grpId,t1.isAdmin as t1isAdmin,t2.memberName as t2memberName,t2.relationship as t2relationship,t2.familyMemberId as t2familyMemberId from ProfileMaster as t1   left  join FamilyMemberDetail as t2  on t1.profileId=t2.profileId where t2.familyMemberId!='' and t1.grpId='"+GroupID+"' order by t1.memberName"
//                let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
//                
//                
//                print("this is swl query")
//                print(querySQL)
//                var memberName:String!=""
//                
//                while results?.next() == true
//                {
//                    let dd = NSMutableDictionary ()
//                    
//                    
//                    
//                    dd.setValue((results?.string(forColumn: "t1profileid"))! as String, forKey:"t1profileid")
//                    dd.setValue((results?.string(forColumn: "t1masterId"))! as String, forKey:"t1masterId")
//                    dd.setValue((results?.string(forColumn: "t1memberName"))! as String, forKey:"t1memberName")
//                    dd.setValue((results?.string(forColumn: "t1grpId"))! as String, forKey:"t1grpId")
//                    
//                    dd.setValue((results?.string(forColumn: "t2memberName"))! as String, forKey:"t2memberName")
//                    
//                    dd.setValue((results?.string(forColumn: "t2relationship"))! as String, forKey:"t2relationship")
//                    
//                    dd.setValue((results?.string(forColumn: "t2familyMemberId"))! as String, forKey:"t2familyMemberId")
//                    dd.setValue((results?.string(forColumn: "t1isAdmin"))! as String, forKey:"isAdmin")
//                    
//                    
//                    var memberAgainName:String!=(results?.string(forColumn: "t1memberName"))! as String
//
//                    print(memberName)
//                    print(memberAgainName)
//
//                        mainArray.add(dd)
//                        varCounting=varCounting+1
//                    //}
//                    memberName=(results?.string(forColumn: "t1memberName"))! as String
//
//                   
//                    // print(dd)
//                }
//
//               // let uniqueUnordered = Array(Set(mainArray))
//                let uniqueOrdered = Array(NSOrderedSet(array: mainArray as! [Any]))
//               // mainArray=uniqueOrdered as! NSMutableArray
//                
//               // print(unique)
//                
//                
//                if mainArray.count > 0
//                {
//                    NoRecordLabel.isHidden = true
//                    copymainArray=mainArray
//                    directoryTableView.reloadData()
//                }
//                else
//                {
//                    NoRecordLabel.isHidden = false
//                    mainArray.removeAllObjects()
//                    mainArray = NSMutableArray()
//                    copymainArray=NSArray()
//                    directoryTableView.reloadData()
//                }
//                //------
//                var result4:String!=""
//                var result6:String!=""
//                if(grpID.hasPrefix("Optional("))
//                {
//                    var get:String!=grpID as String!
//                    let result3 = String(get.dropFirst(9))    // "he"
//                    print(result3)
//                    grpID = String(result3.dropLast(1)) as NSString   // "o"
//                    print("31313113133131131331313131311331133131313131",result4)
//                    
//                }
//                
//                  print("3")
//                let Count = "SELECT count(*) as Count from ProfileMaster where grpId = '\(grpID!)' and  uniquekey=designation"
//                //print(Count)
//                let resultss:FMResultSet? = contactDB?.executeQuery(Count,withArgumentsIn: nil)
//                
//                while resultss?.next() == true
//                {
//                    varGetCount=resultss?.string(forColumn: "Count")
//                }
//                varGetCount=String(varCounting)
//                //print(varGetCount)
//            }
//            
//            
//            
//            contactDB?.close()
//            /*458934725908375893572389762489073248958734289574329587435982375983475928347523940857238497289567586758967589678290678294056*/
//            
        }
//        else
//        {
//            buttonOpticity.isHidden = true
//            viewForSettingPicker.isHidden = true
//        }
        buttonOpticity.isHidden = true
        viewForSettingPicker.isHidden = true
//        
//        print("my search buitton array 22222")
//        print(mainArray)
//         print(mainArray.count)
    }
    
    
    
    @IBAction func buttonSearchRoatrainTypeClickEvent(_ sender: AnyObject)
    {
        
        print(varISPopVisisbleorNot)
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
        textfieldForRotarianSearch.resignFirstResponder()
       
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
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
        // print(varGetPickerSelectValue)
    }
    /*------------Search picker-------------Code by Deepak ---------------------------------------End-------------------------*/
    
    
    
    
    func functionForSearchInSearchBArWhenSelectedAnyValuefromSearchDropDownBack()
        {
            
            var moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
            var GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
            
            
            
            
            
            if (varGetPickerSelectValue == "Rotarian")
            {
                buttonSearchRotarianType.setTitle("Rotarian",  for: UIControl.State.normal)
                fetchData()
            }
            else if (varGetPickerSelectValue == "Classification")
            {
                
                buttonSearchRotarianType.setTitle("Classification",  for: UIControl.State.normal)
                mainArray.removeAllObjects()
                mainArray=NSMutableArray()
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
                //print(databasePath)
                let contactDB = FMDatabase(path: databasePath as String)
                if contactDB == nil
                {
                    print("Error: \(contactDB?.lastErrorMessage())")
                }
                let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                var varCounting:Int!=0
                
                
                if (contactDB?.open())!
                {
                    var querySQL = ""
                    
                    querySQL = "SELECT DISTINCT value FROM PersonalBusinessMemberDetails where uniquekey='designation' and value!='' and moduleID='"+moduleID+"' and groupId='"+GroupID+"' group by value  order by value COLLATE NOCASE  asc"
                    
                    print(querySQL)
                    let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
                    while results?.next() == true
                    {
                        let dd = NSMutableDictionary ()
                        dd.setValue((results?.string(forColumn: "value"))! as String, forKey:"value")
                        
                        mainArray.add(dd)
                        varCounting=varCounting+1
                        // print(dd)
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
                        mainArray.removeAllObjects()
                        mainArray = NSMutableArray()
                        copymainArray=NSArray()
                        directoryTableView.reloadData()
                    }
                    
                    // print("99999999999999999999999999999999999999999999999999999",mainArray.count)
                    
                    //------
                    var result4:String!=""
                    var result6:String!=""
                    if(grpID.hasPrefix("Optional("))
                    {
                        var get:String!=grpID as String!
                        
                        
                        let result3 = String(get.dropFirst(9))    // "he"
                        print(result3)
                        grpID = String(result3.dropLast(1)) as NSString   // "o"
                        print("31313113133131131331313131311331133131313131",result4)
                        
                    }
                    print("4")
                    let Count = "SELECT count(*) as Count from ProfileMaster where grpId = '\(grpID!)' and  uniquekey=designation"
                    //print(Count)
                    let resultss:FMResultSet? = contactDB?.executeQuery(Count,withArgumentsIn: nil)
                    
                    while resultss?.next() == true
                    {
                        varGetCount=resultss?.string(forColumn: "Count")
                    }
                    varGetCount=String(varCounting)
                    // print(varGetCount)
                }
                contactDB?.close()
            }
            
            else if (varGetPickerSelectValue == "Family")
            {
                buttonSearchRotarianType.setTitle("Family",  for: UIControl.State.normal)
                mainArray.removeAllObjects()
                mainArray=NSMutableArray()
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
                // print(databasePath)
                let contactDB = FMDatabase(path: databasePath as String)
                if contactDB == nil
                {
                    print("Error: \(contactDB?.lastErrorMessage())")
                }
                let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                var varCounting:Int!=0
                
                
                if (contactDB?.open())!
                {
                    var querySQL = ""
                    
                    querySQL = "SELECT DISTINCT t1.profileId as t1profileid,t1.masterId as t1masterId,t1.memberName as t1memberName,t1.grpId as t1grpId,t1.isAdmin as t1isAdmin,t2.memberName as t2memberName,t2.relationship as t2relationship,t2.familyMemberId as t2familyMemberId from ProfileMaster as t1   left  join FamilyMemberDetail as t2  on t1.profileId=t2.profileId where t2.familyMemberId!='' and t1.grpId='"+GroupID+"'  order by t1memberName"
                    
                    //and  t1memberName='"+stringSearchText+"'
                    //print(querySQL)
                    let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
                    while results?.next() == true
                    {
                        let dd = NSMutableDictionary ()
                        
                        
                        
                        dd.setValue((results?.string(forColumn: "t1profileid"))! as String, forKey:"t1profileid")
                        dd.setValue((results?.string(forColumn: "t1masterId"))! as String, forKey:"t1masterId")
                        dd.setValue((results?.string(forColumn: "t1memberName"))! as String, forKey:"t1memberName")
                        dd.setValue((results?.string(forColumn: "t1grpId"))! as String, forKey:"t1grpId")
                        
                        dd.setValue((results?.string(forColumn: "t2memberName"))! as String, forKey:"t2memberName")
                        
                        dd.setValue((results?.string(forColumn: "t2relationship"))! as String, forKey:"t2relationship")
                        
                        dd.setValue((results?.string(forColumn: "t2familyMemberId"))! as String, forKey:"t2familyMemberId")
                        
                        dd.setValue((results?.string(forColumn: "t1isAdmin"))! as String, forKey:"isAdmin")
                        
                        //masterId
                        
                        
                        // dd.setValue((results?.stringForColumn("t2relationship"))! as String, forKey:"t2relationship")
                        // dd.setValue((results?.stringForColumn("t2familyMemberId"))! as String, forKey:"t2familyMemberId")
                        
                        
                        
                        
                        
                        mainArray.add(dd)
                        varCounting=varCounting+1
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
                        mainArray.removeAllObjects()
                        mainArray = NSMutableArray()
                        copymainArray=NSArray()
                        directoryTableView.reloadData()
                    }
                    //------
                    var result4:String!=""
                    var result6:String!=""
                    if(grpID.hasPrefix("Optional("))
                    {
                        var get:String!=grpID as String!
                        
                        
                        let result3 = String(get.dropFirst(9))    // "he"
                        print(result3)
                        grpID = String(result3.dropLast(1)) as NSString   // "o"
                        print("31313113133131131331313131311331133131313131",result4)
                        
                    }
                    print("5")
                    //print("88888888888888888888888888888888888888",mainArray.count)
                    let Count = "SELECT count(*) as Count from ProfileMaster where grpId = '\(grpID!)' and  uniquekey=designation"
                    // print(Count)
                    let resultss:FMResultSet? = contactDB?.executeQuery(Count,withArgumentsIn: nil)
                    
                    while resultss?.next() == true
                    {
                        varGetCount=resultss?.string(forColumn: "Count")
                    }
                    varGetCount=String(varCounting)
                    // print(varGetCount)
                }
                
                contactDB?.close()
                /*458934725908375893572389762489073248958734289574329587435982375983475928347523940857238497289567586758967589678290678294056*/
                
            }
            else
            {
                buttonOpticity.isHidden = true
                viewForSettingPicker.isHidden = true
            }
            buttonOpticity.isHidden = true
            viewForSettingPicker.isHidden = true
        
    }
    
   /*
    
    /*****************************************Refresh Data************************************************************/
    
    
    ///For Refreshing Data
    func fetchDataFORGetProfileID(varGroupID:String)
    {
         muarayForRefreshData=NSMutableArray()
        var databasePath : String
        let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        let fileURL = documents.URLByAppendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL!.path!
        var db: COpaquePointer = nil
        if sqlite3_open(fileURL!.path!, &db) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        //masterUID, groupId , moduleId , profileID , MemberDesignation , memberName , pic , membermobile From Board_Of_Directors_List
        let mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("masterUID")
        if (contactDB?.open())!
            
        {
            contactDB.beginTransaction()
            let querySQL = "SELECT profileId FROM ProfileMaster where grpId  = '\(varGroupID)'"
             print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsInArray: nil)
            while results?.next() == true {
                let dd = NSMutableDictionary ()
                 dd.setValue((results?.stringForColumn("profileId"))! as String, forKey:"profileId")
                print(dd)
               muarayForRefreshData.addObject(dd)
                functionFordfgDeleteMembersRefreshData([String(muarayForRefreshData)])
            }
        }
        contactDB.close()
    }

    
    
    
  //Delete When Refresh Data
    func functionForDdfgeleteMembersRefreshData(muaarayDeleteMemberListjsonResult:[String])
    {
         print(muaarayDeleteMemberListjsonResult)
        print(muaarayDeleteMemberListjsonResult.count)
        
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
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        let mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("masterUID")
        if (contactDB?.open())!
        {
            contactDB.beginTransaction()
            print("22This is count of main start point of file:-----------")
                        //3. PersonalBusinessMemberDetails
            for k in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let familyMemberDetailsDelete = "DELETE FROM  FvbvcbcamilyMexcvmberDetail  where profileId="+muaarayDeleteMemberListjsonResult[k]+""
                let result = contactDB?.executeStatements(familyMemberDetailsDelete)
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    
                }
            }
            //4.  AddressDetails
            for l in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let addressDetailDelete = "DELETE FROM  AddressDetails  where profileId="+muaarayDeleteMemberListjsonResult[l]+""
                let result = contactDB?.executeStatements(addressDetailDelete)
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    
                }
            }
            
            for i in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                
                let insertSQLDelete = "DELETE FROM  ProfileMaster  where grpId = '\(grpID)' "
                let result = contactDB?.executeStatements(insertSQLDelete)
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
            }
            //1......if master table entry inserted then need to data in PersonalBusinessMemberDetails
            for j in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let childSQLDelete = "DELETE FROM PersonalBusinessMemberDetails where groupId = '\(grpID)'"
                //  print(childSQL)
                let result = contactDB?.executeStatements(childSQLDelete)
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    
                }
            }

        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //---
         
        contactDB.commit()
        contactDB.close()
        if(varGetForLoopCounting==varGetTotalFilesCount)
        {
            print("∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞")
            print(varGetForLoopCounting)
            print(varGetTotalFilesCount)
             
            
        }
    }
    
    */
    
    
    
    
    func functionForDeleteMembersRefreshDataGroupID()
    {
        // print(muaarayDeleteMemberListjsonResult)
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
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            contactDB?.beginTransaction()
            print("22This is count of main start point of file:-----------")
            //for i in 0 ..< muaarayDeleteMemberListjsonResult.count
            //{
                
                let insertSQLDelete = "DELETE FROM  ProfileMaster  where grpId = '\(grpID)' "
                let result = contactDB?.executeStatements(insertSQLDelete)
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
           // }
            //1......if master table entry inserted then need to data in PersonalBusinessMemberDetails
           // for j in 0 ..< muaarayDeleteMemberListjsonResult.count
           // {
                let childSQLDelete = "DELETE FROM PersonalBusinessMemberDetails where groupId = '\(grpID)'"
                //  print(childSQL)
                let results = contactDB?.executeStatements(childSQLDelete)
                if (results == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    
                }
            //}
            
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        //---
         
        contactDB?.commit()
        contactDB?.close()
        if(varGetForLoopCounting==varGetTotalFilesCount)
        {
            print("∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞")
            print(varGetForLoopCounting)
            print(varGetTotalFilesCount)
        }
    }
}
class ButtonWithImage: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        }
    }
}

// MARK: - DirectoryClassificationOnline

struct DirectoryClassificationOnline: Codable {
    let classificationListResult: ClassificationListResult

    enum CodingKeys: String, CodingKey {
        case classificationListResult = "ClassificationListResult"
    }
}

// MARK: - ClassificationListResult
struct ClassificationListResult: Codable {
    let status, message, resultCount, totalPages: String
    let currentPage: String
    let result: [Resultses]

    enum CodingKeys: String, CodingKey {
        case status, message, resultCount
        case totalPages = "TotalPages"
        case currentPage
        case result = "Result"
    }
}

// MARK: - Result
struct Resultses: Codable {
    let rowNo, classification: String?

    enum CodingKeys: String, CodingKey {
        case rowNo = "RowNo"
        case classification
    }
}

// MARK: - DirectoryFamilyOnline
struct DirectoryFamilyOnline: Codable {
    let tbGetRotarianResult: TBGetRotarianResult

    enum CodingKeys: String, CodingKey {
        case tbGetRotarianResult = "TBGetRotarianResult"
    }
}

// MARK: - TBGetRotarianResult
struct TBGetRotarianResult: Codable {
    let status, message: String
    let result: [FamilyResult]

    enum CodingKeys: String, CodingKey {
        case status, message
        case result = "Result"
    }
}

// MARK: - Result
struct FamilyResult: Codable {
    let profileID, memberName: String?
}




// MARK: - DirectoryOnline
struct DirectoryOnline: Codable {
    let status, message: String?
    let memberDetail: MembersDetail?

    enum CodingKeys: String, CodingKey {
        case status, message
        case memberDetail = "MemberDetail"
    }
}

// MARK: - MemberDetail
struct MembersDetail: Codable {
    let memberDetails: [MemberDetailElement]?
    let businessDetails: [BusinessDetail]?
    let addressDetails: [AddressDetail]?
    let familyDetails: [FamilyDetail]?

    enum CodingKeys: String, CodingKey {
        case memberDetails = "Member_Details"
        case businessDetails = "business_Details"
        case addressDetails = "Address_Details"
        case familyDetails = "Family_Details"
    }
}

// MARK: - AddressDetail
struct AddressDetail: Codable {
    let addressID, profileID, fkGroupMasterID: Int?
    let address, city, state: String?
    let country: String?
    let pincode, phoneNo, fax: String?
    let addressType: String?
    let memberName: String?

    enum CodingKeys: String, CodingKey {
        case addressID, profileID
        case fkGroupMasterID = "fk_group_master_id"
        case address = "Address"
        case city, state, country, pincode, phoneNo, fax, addressType
        case memberName = "MemberName"
    }
}

enum AddressType: String, Codable {
    case business = "Business"
    case residence = "Residence"
}

enum Country: String, Codable {
    case empty = ""
    case india = "India"
    case nepal = "Nepal"
    case sriLanka = "Sri Lanka "
}

// MARK: - BusinessDetail
struct BusinessDetail: Codable {
    let memberBussEmail, businessPosition, businessName: String?
    let profileID: Int?

    enum CodingKeys: String, CodingKey {
        case memberBussEmail = "member_buss_email"
        case businessPosition
        case businessName = "BusinessName"
        case profileID
    }
}

// MARK: - FamilyDetail
struct FamilyDetail: Codable {
    let familyMemberID, fkMainMemberMasterID: Int?
    let emailID: String?
    let memberName: String?
    let relationship: String?
    let contactNo, dob, anniversary: String?
    let bloodGroup: String?
    let particulars: String?
    let profileID: Int?

    enum CodingKeys: String, CodingKey {
        case familyMemberID = "familyMemberId"
        case fkMainMemberMasterID = "fk_main_member_master_id"
        case emailID, memberName
        case relationship = "Relationship"
        case contactNo
        case dob = "DOB"
        case anniversary
        case bloodGroup = "BloodGroup"
        case particulars, profileID
    }
}

enum BloodGroup: String, Codable {
    case abVe = "AB +ve"
    case bVe = "B+ Ve"
    case bloodGroupOVe = "O- Ve"
    case empty = ""
    case oVe = "O+ Ve"
}

enum EmailID: String, Codable {
    case adrijaBandyopadhyayGmailCOM = "adrija.bandyopadhyay@gmail.com"
    case advocatesavitagGmailCOM = "advocatesavitag@gmail.com"
    case alamharpalGmailCOM = "alamharpal@gmail.com"
    case alkakantoorGmailCOM = "alkakantoor@gmail.com"
    case anandDamarajuGmailCOM = "anand.damaraju@gmail.com"
    case boopathiavnGmailCOM = "boopathiavn@gmail.com"
    case dibhaiHotmailCOM = "dibhai@hotmail.com"
    case drmpadma13GmailCOM = "drmpadma13@gmail.com"
    case empty = ""
    case hitaJaniYahooCoIn = "hita.jani@yahoo.co.in"
    case jyotimehta2002GmailCOM = "jyotimehta2002@gmail.com"
    case mohitSbpGmailCOM = "mohit.sbp@gmail.com"
    case pritsmbdGmailCOM = "pritsmbd@gmail.com"
    case rajamjitheshGmailCOM = "rajamjithesh@gmail.com"
    case rajamyogeshGmailCOM = "rajamyogesh@gmail.com"
    case ranjanahsrGmailCOM = "ranjanahsr@gmail.com"
    case riyasundararajanGmailCOM = "riyasundararajan@gmail.com"
    case roopalpilaniGmailCOM = "roopalpilani@gmail.com"
    case rtndrvijendraGmailCOM = "rtndrvijendra@gmail.com"
    case rtnswatishahGmailCOM = "rtnswatishah@gmail.com"
    case rtntnaGmailCOM = "rtntna@gmail.com"
    case sarkanmduGmailCOM = "sarkanmdu@gmail.com"
    case satpalUnitedACIn = "Satpal@united.ac.in"
    case shraj89GmailCOM = "shraj89@gmail.com"
    case sipra1986GmailCOM = "sipra1986@gmail.com"
    case sundarorthoGmailCOM = "sundarortho@gmail.com"
    case valsalakumari54GmailCOM = "Valsalakumari54@gmail.com"
    case vidyarthiShalini06GmailCOM = "Vidyarthi.shalini06@gmail.com"
}

enum Particulars: String, Codable {
    case empty = ""
    case na = "NA"
}

enum Relationship: String, Codable {
    case brother = "Brother"
    case daughter = "Daughter"
    case son = "Son"
    case spouse = "Spouse"
}

// MARK: - MemberDetailElement
struct MemberDetailElement: Codable {
    let masterID, grpID, profileID: Int?
    let memberName, memberEmail, memberMobile: String?
    let memberCountry: String?
    let profilePic, familyPic: String?
    let gender: String?
    let youthFlag, memberSuffix, memberPrefix: String?
    let primaryLanguage: String?
    let memberInfo: String?
    let faceBookTxt, instagramTxt: String?
    let twitterTxt: String??
    let linkedInTxt, websiteTxt: String?
    let youtubeTxt: String?
    let isAdmin, isPersonalDetVisible, isBusinDetVisible, isFamilDetailVisible: String?
    let secondryMobileNo, memberDateOfBirth, memberDateOfWedding, bloodGroup: String?
    let memberMasterDesignation: String?
    let rotaryDonarRecognation, designation: String?
    let isBOD: Int?
    let dgMasterDesignation, memberRotaryID, keywords: String?

    enum CodingKeys: String, CodingKey {
        case masterID, grpID, profileID, memberName, memberEmail, memberMobile, memberCountry, profilePic, familyPic
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
        case isAdmin, isPersonalDetVisible, isBusinDetVisible, isFamilDetailVisible
        case secondryMobileNo = "secondry_mobile_no"
        case memberDateOfBirth = "member_date_of_birth"
        case memberDateOfWedding = "member_date_of_wedding"
        case bloodGroup = "blood_Group"
        case memberMasterDesignation = "member_master_designation"
        case rotaryDonarRecognation = "rotary_donar_recognation"
        case designation, isBOD
        case dgMasterDesignation = "dg_master_designation"
        case memberRotaryID = "member_rotary_id"
        case keywords = "Keywords"
    }
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
}

enum Is: String, Codable {
    case no = "no"
    case yes = "yes"
}

enum MemberMasterDesignation: String, Codable {
    case advisor = "ADVISOR "
    case empty = ""
    case pdg = "PDG"
    case rotarian = "Rotarian"
}

enum PrimaryLanguage: String, Codable {
    case bengali = "Bengali"
    case english = "English"
    case french = "French"
    case hindi = "Hindi"
    case kannada = "Kannada"
    case marathi = "Marathi"
    case oriya = "Oriya"
    case tamil = "Tamil"
    case telugu = "Telugu"
}

enum TwitterTxt: String, Codable {
    case empty = ""
    case rajivworld = "rajivworld"
    case subhasishRaja = "@SubhasishRaja"
}

enum YoutubeTxt: String, Codable {
    case empty = ""
    case pdgShiva = "PDG Shiva"
    case rotary3240 = "Rotary 3240"
}
