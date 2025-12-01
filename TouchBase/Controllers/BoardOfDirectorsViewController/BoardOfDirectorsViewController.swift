//
//  BoardOfDirectorsViewController.swift
//  TouchBase
//
//  Created by rajendra on 19/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import Alamofire
protocol protocolForUpdateListingBOD {
    func functionForUpdateListing(stringValue:String)
}
//import Kingfisher
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

protocol protocolForEBulletinListingCallingApiBOD {
    func functionForEBulletinListingCallingApi(stringFromWhereITCalling:String)
}

class BoardOfDirectorsViewController: UIViewController, UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate, UIPickerViewDataSource,UIPickerViewDelegate, webServiceDelegate,protocolForUpdateListingBOD,protocolForEBulletinListingCallingApiBOD{
    func functionForEBulletinListingCallingApi(stringFromWhereITCalling: String) {
        
        
        
        
        
        
        ////print("This is from screens :------")
//        self.noResultLbl.text=""
//        self.noResultLbl.isHidden=true
//        noResultLbl.isHidden=true
        //let getTodayMonthYear = commonClassFunction().functionForGetCurrentYear()
        
        //for getting year
        // for i in 00..<3
        // {
        //        var varGetCurrentYear:Int=Int(getTodayMonthYear)!
        //        var varGetBackYear:Int=varGetCurrentYear-1
        //        var varGetTwoBackYear:Int=varGetBackYear-1
        //
        //        ////print(varGetCurrentYear)
        //        ////print(varGetBackYear)
        //        ////print(varGetTwoBackYear)
        
        
        
        // pickerDataSource = [String(varGetCurrentYear-1)+"-"+String(varGetCurrentYear), String(varGetBackYear-1)+"-"+String(varGetBackYear), String(varGetTwoBackYear-1)+"-"+String(varGetTwoBackYear)]
        // pickerDataSourceNonAdmin = [String(varGetCurrentYear-1)+"-"+String(varGetCurrentYear), String(varGetBackYear-1)+"-"+String(varGetBackYear), String(varGetTwoBackYear-1)+"-"+String(varGetTwoBackYear)]
        
        
        
        // }
        
        
        
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        // self.listTypeTextField.text=String(varGetCurrentYear-1)+"-"+String(varGetCurrentYear)
        
//        self.annType="1"
        
//        noResultLbl.isHidden=true
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        /*-----------------------------------AdminOrNot------------------DPK--------------------------*/
        
        searchTextField.borderStyle = .roundedRect
        self.ListTypeTextField.borderStyle = .roundedRect
        
        
        // searchTextField.layer.cornerRadius = 2.0
        // searchTextField.layer.borderWidth = 1.0
        //functionForGetDataFromServer(String(varGetBackYear), toYear: String(varGetCurrentYear))  //Code by Rajendra and comment by DPK
        onlineBODMob.removeAll()
          onlineBODNam.removeAll()
          onlineBODPic.removeAll()
          onlineBODDesgn.removeAll()
        onlineBODMasterID.removeAll()
        getBoardOfDirectorList(grpID!, searchText: "")
//        functionForGetDataFromServer()
        /*-----------------------------------AdminOrNot----------DPK----------------------------------*/
//        allbulletinArry=[]
//        SMSCountStr = ""
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        let defaults = UserDefaults.standard
        
        
        
        
//        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
//            if let uid = defaults.string(forKey: "masterUID")
//            {
//                //wsm.getAllEbulletinOFUSer(grpDetail.groupId, memberProfileId: grpDetail.masterProfileID, searchText: "", type: annType, isAdmin: isAdmin)
//                wsm.getAllEbulletinOFUSer(grpDetailPrevious.object(forKey: "grpId") as! String as NSString, memberProfileId: memberProfileId  as NSString, searchText: "", type: annType, isAdmin: isAdmin)
//
//
//
//            }
//        }
//        else
//        {
//            self.view.makeToast("Please check your internet connection, Please try again later", duration: 2, position: CSToastPositionCenter)
//        }
//
        
        
        
        
        
        ////print(isAdmin)
//        noResultLbl.isHidden=true
    }

    
    
    var year : Int! = 0
    
    func functionForUpdateListing(stringValue:String)
    {
        
      //  //print("this is value from add ebulletin !!!!")
        //////print(stringValue)
        
        
        let date = Foundation.Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        year =  components.year
        let month = components.month
        let day = components.day
        ////print(year , month ,day )
        if(month!>=7)
        {
            year = year+1
        }
        else
        {
        }
        yearFrom = String(year)
        ////print(yearFrom)
        ListTypeTextField.text! = "2023-2024"
//        String(year-1) + "-" + yearFrom //yearFrom+"-"+String(year+1)
        
        
        functionForYears()
        
        
        
        
        //  if isAdmin == "Yes"
        //  {
        searchTextField.delegate = self
        ListTypeTextField.delegate = self
        
        ViewFoSearchrUnderLine.frame = CGRect(x: self.ViewFoSearchrUnderLine.frame.origin.x, y: self.ViewFoSearchrUnderLine.frame.origin.y, width: self.view.frame.size.width, height: self.ViewFoSearchrUnderLine.frame.size.height)
        /*
        searchTextField.frame = CGRect(x: self.searchTextField.frame.origin.x, y: self.searchTextField.frame.origin.y, width: self.view.frame.size.width-(self.listTypeTextField.frame.size.width+50), height: self.searchTextField.frame.size.height)
        
        listTypeTextField.frame = CGRect(x: self.searchTextField.frame.size.width+18, y: self.listTypeTextField.frame.origin.y, width: self.listTypeTextField.frame.size.width+28, height: self.listTypeTextField.frame.size.height)
        */
        ListTypeTextField.isHidden = false
        self.pickerView.isHidden=true
        self.searchAnnouncemt()
        
        
//        self.noResultLbl.text=""
//        self.noResultLbl.isHidden=true
//        noResultLbl.isHidden=true
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        // self.listTypeTextField.text=String(varGetCurrentYear-1)+"-"+String(varGetCurrentYear)
        
//        self.annType="1"
        
//        noResultLbl.isHidden=true
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        /*-----------------------------------AdminOrNot------------------DPK--------------------------*/
        
        searchTextField.borderStyle = .roundedRect
        ListTypeTextField.borderStyle = .roundedRect
        
        
        // searchTextField.layer.cornerRadius = 2.0
        // searchTextField.layer.borderWidth = 1.0
        //functionForGetDataFromServer(String(varGetBackYear), toYear: String(varGetCurrentYear))  //Code by Rajendra and comment by DPK
        onlineBODMob.removeAll()
          onlineBODNam.removeAll()
          onlineBODPic.removeAll()
          onlineBODDesgn.removeAll()
        onlineBODMasterID.removeAll()
        getBoardOfDirectorList(grpID!, searchText: "")
//        functionForGetDataFromServer()
        /*-----------------------------------AdminOrNot----------DPK----------------------------------*/
//        allbulletinArry=[]
//        SMSCountStr = ""
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        let defaults = UserDefaults.standard
        
        
//
//
//        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
//            if let uid = defaults.string(forKey: "masterUID")
//            {
//                //wsm.getAllEbulletinOFUSer(grpDetail.groupId, memberProfileId: grpDetail.masterProfileID, searchText: "", type: annType, isAdmin: isAdmin)
//                wsm.getAllEbulletinOFUSer(grpDetailPrevious.object(forKey: "grpId") as! String as NSString, memberProfileId: memberProfileId  as NSString, searchText: "", type: annType, isAdmin: isAdmin)
//            }
//        }
//        else
//        {
//            self.view.makeToast("Please check your internet connection, Please try again later", duration: 2, position: CSToastPositionCenter)
//        }
        ////print(isAdmin)
//        noResultLbl.isHidden=true
    }
    
    
    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
    @IBOutlet weak var tableBodListShow: UITableView!
    //MARK:- local Variable
    let loaderClass  = WebserviceClass()
    var appDelegate : AppDelegate = AppDelegate()
    var mainArray : NSMutableArray!
    var copymainArray:NSArray!
    let bounds = UIScreen.main.bounds
//    let searchTextField = UITextField()
    var grpID: NSString!
    var isAdmin:String! = ""
    var checkRow: NSString!
    var varGetCellDateSelected:String! = ""
    var searchingNameArray : NSMutableArray!
    var searchingkeywordArray :NSMutableArray!
    var searchingMobileNoArray : NSMutableArray!
    var str = String()
    var varGetSearchText:String! = ""
    //MARK:- Array Declration
    var muarrayBodList:NSMutableArray = NSMutableArray()
    var updatedOn =  String ()
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    // var moduleId = NSString!
    var userID:NSString!
    var moduleId:String! = ""
    
    var filterMob = [String]()
    var filteredMem = [String]()
    var filteredDesgn = [String]()
    var filteredPic = [String]()
    var filteredMasterID = [String]()
    var filterIndex = 0
    var onlineBODNam = [String]()
    var onlineBODMob = [String]()
    var onlineBODDesgn = [String]()
    var onlineBODPic = [String]()
    var onlineBODMasterID = [String]()
    var secCount = 0
    var letGetCategoryId:String!=""
    var moduleName:String! = ""
    var isCategory:String! = ""
    var isfilter = false
    @IBOutlet weak var NoRecordLabel: UILabel!
    
    @IBOutlet weak var headerVC: UIView!
    
  
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet weak var ViewFoSearchrUnderLine: UILabel!
    @IBOutlet weak var ListTypeTextField: UITextField!
    @IBOutlet weak var searchTextField: UITextField!
    var filtered:[String] = []
     var searchActive : Bool = false
    var yearFrom:String! = ""
    var yearSeen: Bool = false
    var pickerDataSource = [ "Published", "All", "Scheduled", "Expired"];
    var pickerDataSourceNonAdmin = [ "Published", "All" ,"Expired"];
    //MARK:- Function Year
    func functionForYears()
    {
        pickerDataSource=[]
        //Code by Deepak
        // year = year+1 // for one year next
        //year = year
        //        for var i in ((year-3)..<year)
        //        {
        
        // start from 2015 to current year and start from july and end with june // Code by DPK 25-06-2018
        
        
        
        for  i in (2005..<year)
        {
            //print(i)
            let letSetYear = String(i)+"-"+String(Int(i+1))
            print(letSetYear)
            pickerDataSource.append(letSetYear)
        }
      //  self.pickerView.selectRow(pickerDataSource.count, inComponent: 0, animated: false)
        self.pickerView.selectRow(pickerDataSource.count-1, inComponent: 0, animated: false)

        
        // self.pickerView.selectRow(pickerDataSourceNonAdmin.count, inComponent: 0, animated: false)
        self.pickerView.reloadAllComponents()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //CHANGE MANI
        let date = Foundation.Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        year =  components.year
        print(year)
        let month = components.month
        let day = components.day
        if(month!>=7)
        {
//            year = year+1
        }
        else
        {
        }
        year = year+1
        print(year)
        yearFrom = String(year)
        print(yearFrom)
        ListTypeTextField.text! = "2023-2024"
       // MANI---------
//        String(year-1) + "-" + yearFrom /*yearFrom+"-"+String(year+1)*/
//        ListTypeTextField.text! = String(year-1) + "-" + String(year)
        print(year)
        functionForYears()
        
        
        
        searchTextField.delegate = self
        ListTypeTextField.delegate = self
        
         
         NoRecordLabel.isHidden = true
        createNavigationBar()
        
        
        ViewFoSearchrUnderLine.frame = CGRect(x: self.ViewFoSearchrUnderLine.frame.origin.x, y: self.ViewFoSearchrUnderLine.frame.origin.y, width: self.view.frame.size.width, height: self.ViewFoSearchrUnderLine.frame.size.height)
        searchTextField.frame = CGRect(x: self.searchTextField.frame.origin.x, y: self.searchTextField.frame.origin.y, width: self.view.frame.size.width-(self.ListTypeTextField.frame.size.width+50), height: self.searchTextField.frame.size.height)
        
        ListTypeTextField.frame = CGRect(x: self.searchTextField.frame.size.width+18, y: self.ListTypeTextField.frame.origin.y, width: self.ListTypeTextField.frame.size.width+28, height: self.ListTypeTextField.frame.size.height)
        ListTypeTextField.isHidden = false
        self.pickerView.isHidden=true
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        
        
        searchTextField.borderStyle = .roundedRect
        ListTypeTextField.borderStyle = .roundedRect
        functionForTextFieldLableButtonViewTableScrollViewSetting()
        
        
        /*
        mainArray = NSMutableArray()
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            print(moduleId)
            getBoardOfDirectorList(grpID, searchText: "")
        }
        else
        {
          SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            mainArray = NSMutableArray()
            fetchData()
        }
        
        
        
        */
        // Do any additional setup after loading the view.
    }
   //pickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // if isAdmin == "Yes"
        // {
        return pickerDataSource.count;
        //        }
        //        else
        //        {
        //            return pickerDataSourceNonAdmin.count;
        //        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // if isAdmin == "Yes"
        //{
        self.ListTypeTextField.text = pickerDataSource[pickerDataSource.count - 1]
            return pickerDataSource[row]
        
        //        }
        //        else
        //        {
        //            return pickerDataSourceNonAdmin[row]
        //        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        //print(pickerDataSource[row])
        //var pickerDataSource = ["All", "Published", "Scheduled", "Expired"];
        //if isAdmin == "Yes"
        //{
        //print(index)
        
        self.ListTypeTextField.text=pickerDataSource[row]
        
        
//        if(pickerDataSource[row]=="All"){
//            self.listTypeTextField.text="All"
//            self.annType="0"
//        }else if(pickerDataSource[row]=="Published"){
//            self.listTypeTextField.text="Published"
//            
//            self.annType="1"
//        }else if(pickerDataSource[row]=="Scheduled"){
//            self.listTypeTextField.text="Scheduled"
//            self.annType="2"
//        }else if(pickerDataSource[row]=="Expired"){
//            self.listTypeTextField.text="Expired"
//            self.annType="3"
//        }else{
//            self.annType="1"
//        }
        self.pickerView.isHidden=true
        // self.searchAnxcvnouncemt()
        
        /*
         }
         else
         {
         self.listTypeTextField.text=pickerDataSource[row]
         
         if(pickerDataSourceNonAdmin[row]=="All"){
         self.listTypeTextField.text="All"
         self.annType="0"
         }else if(pickerDataSourceNonAdmin[row]=="Published"){
         self.listTypeTextField.text="Published"
         self.annType="1"
         }else if(pickerDataSourceNonAdmin[row]=="Expired"){
         self.listTypeTextField.text="Expired"
         
         self.annType="3"
         }else{
         self.annType="1"
         }
         self.pickerView.isHidden=true
         // self.searchAnnxcvouncemt()
         }
         
         */
        let getSelectYearsValue:String!=self.ListTypeTextField.text
        var varGetArrayValue=getSelectYearsValue.components(separatedBy: "-")
        // functionForGetDataFromServer(varGetArrayValue[0], toYear: varGetArrayValue[1]) //Code by Rajendra and comment by DPK
//        self.functionForGetDataFromServer()
        muarrayBodList=NSMutableArray()
        onlineBODMob.removeAll()
        onlineBODNam.removeAll()
        onlineBODPic.removeAll()
        onlineBODDesgn.removeAll()
        onlineBODMasterID.removeAll()
        getBoardOfDirectorList(grpID!, searchText: "")
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            muarrayBodList=NSMutableArray()
             onlineBODMob.removeAll()
               onlineBODNam.removeAll()
               onlineBODPic.removeAll()
               onlineBODDesgn.removeAll()
             onlineBODMasterID.removeAll()
            getBoardOfDirectorList(grpID!, searchText: "")
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            mainArray = NSMutableArray()
            fetchData()
        }
    }
    
    
    //MARK:- SearchBar
    
    var searchController: UISearchController!
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        print("Hello")
     
        
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton=true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        print("searchText \(searchBar.text!)")
        varGetSearchText = searchBar.text!
        muarrayBodList.removeAllObjects()
        SearchFromMemberNameAndYear(varGetSearchText)
        searchBar.resignFirstResponder()
    }
    func updateSearchResults(for searchController: UISearchController)
    {
        let varGetText=searchController.searchBar.text
        if(varGetText?.characters.count<=0 && varGetText != "")
        {
            searchController.searchBar.placeholder="Search"
            varGetSearchText = ""
        }
        else if searchController.searchBar.text != nil
        {
            searchController.searchBar.placeholder="Search"
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        varGetSearchText = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        searchBar.text=nil
        mainArray = NSMutableArray()
        fetchData()
        self.tableBodListShow.reloadData()
    }
    
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        //  if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//        //{
//        var  strValue = varGetSearchText
//        let strValues = strValue.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())as NSString
//        
//        print(strValue)
//        print(strValues)
//        print(searchTextField.text)
//    return true
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func functionForTextFieldLableButtonViewTableScrollViewSetting()
    {
        muarrayBodList = NSMutableArray()
        searchTextField.autocorrectionType = .no
        
    }
    
    //TextField Methods
    func searchAnnouncemt()
    {
        /*
         let wsm : WebserviceClass = WebserviceClass.sharedInstance
         wsm.delegates=self
         let defaults = NSUserDefaults.standardUserDefaults()
         if let uid = defaults.stringForKey("masterUID")
         {
         noResultLbl.hidden=true
         wsm.getAllEbulletinOFUSer(grpDetailPrevious.objectForKey("grpId") as! String, memberProfileId: grpDetailPrevious.objectForKey("grpProfileid") as! String, searchText: searchTextField.text!,type:annType,isAdmin: isAdmin)
         }
         */
        
        
        if((searchTextField.text?.characters.count)!>0)
        {
            //print(searchTextField.text!)
            
            
            
            //            let searchPredicate = NSPredicate(format: "memberName CONTAINS[C] %@", searchTextField.text!)
            //            //let array = (arrayResponse as NSArray).filtered(using: searchPredicate)
            //            print("muarrayBodList2---\(muarrayBodList)")
            //            let array = (muarrayBodList as NSArray).filtered(using: searchPredicate)
            //
            //            //print("array = \(array)")
            //            muarrayBodList = array as NSArray as NSArray as! NSMutableArray
            //            self.tableBodListShow.reloadData()
            
            filteredMem.removeAll()
            filterMob.removeAll()
            filteredDesgn.removeAll()
            filteredMasterID.removeAll()
            filteredPic.removeAll()
            let searchString = searchTextField.text?.lowercased() ?? ""
            
            print("self.onlineBODNam----\(self.onlineBODNam)")
            let filteredMember = self.onlineBODNam.filter { $0.lowercased().contains(searchString) }
            
            filteredMem.append(contentsOf:filteredMember)
            for memberfilter in filteredMem {
                if let index = self.onlineBODNam.firstIndex(where: { $0 == memberfilter }) {
                    filteredDesgn.append(self.onlineBODDesgn[index])
                    filterMob.append(self.onlineBODMob[index])
                    filteredPic.append(self.onlineBODPic[index])
                    filteredMasterID.append(self.onlineBODMasterID[index])
                    filterIndex = index
                }
            }
                print("filteredMember----\(filteredMember)")
                print("filteredMem----\(filteredMem)")
                if(filteredMem.count>0)
                {
                    isfilter = true
                    self.NoRecordLabel.isHidden = true
                    self.tableBodListShow.reloadData()
                }
                else
                {
                    isfilter = true
                    self.NoRecordLabel.isHidden = false
                    self.tableBodListShow.reloadData()
                }
        }
        else
        {
//            arrayResponse=dcitHoldingArray
             print("self.arrayResponse 2::: \(self.muarrayBodList)")
            self.tableBodListShow.reloadData()
        }
        
        
//        if(arrayResponse.count>0)
//        {
////            noResultLbl.isHidden=true
//            //print("if condition111")
//        }
//        else
//        {
////            noResultLbl.isHidden=false
////            noResultLbl.text="No Results"
//            //print("else conditionno 2")
//        }
        // var resultPredicate : NSPredicate = NSPredicate(format: "name contains[c]\(searchText)", nil)
        
        //var recipes : NSArray = NSArray()
        
        //  var searchResults = recipes.filteredArrayUsingPredicate(resultPredicate)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if(textField.tag==22){
            
            ListTypeTextField.resignFirstResponder()
            self.view .bringSubviewToFront( self.pickerView)
            self.pickerView.isHidden=true
//
        }else{
            self.pickerView.isHidden=true
            searchTextField.resignFirstResponder()
            print("muarrayBodList1---\(muarrayBodList)")
            if ((searchTextField.text?.characters.count ?? 0) > 0) {
                self.searchAnnouncemt()
            } else if ((searchTextField.text?.characters.count ?? 0) == 0) {
                isfilter = false
                tableBodListShow.reloadData()
            }
        }
        return true
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            if(textField.tag==22){
                self.view .bringSubviewToFront( self.pickerView)
                self.pickerView.isHidden=false
                searchTextField.resignFirstResponder()
                return false
            }else{
                
                return true
            }
        }
        else
        {
            self.view.makeToast("Please check your internet connection, Please try again later", duration: 2, position: CSToastPositionCenter)
            self.view .bringSubviewToFront( self.pickerView)
            self.pickerView.isHidden=true
            searchTextField.resignFirstResponder()
            return false
            
        }
        
        
        
        
    }
    
    func clickSearch()
    {
//        print("button click")
//                let predicate = NSPredicate(format: "memberName contains[c] %@", varGetSearchText)
//                muarrayBodList =  muarrayBodList.filteredArrayUsingPredicate(predicate) as! NSMutableArray
//                print(muarrayBodList)
        
    }

    //MARK:- Function
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
        buttonleft.addTarget(self, action: #selector(BoardOfDirectorsViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DirectoryViewController.AddEventAction))
        add.tintColor = UIColor.white
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Table Methods
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isfilter {
            return self.filteredMem.count
        } else {
            return secCount
        }
        
    }
    
    @objc func buttonPicBigViewnewClickEvent(_ sender:UIButton)
    {
        
        
        var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
        objCommonHoldDataVariable = muarrayBodList.object(at: sender.tag) as! CommonAccessibleHoldVariable;
        let isUpperImageAvailable=objCommonHoldDataVariable.varBodMemberPic
        
        
        
        
       // let  directoryList = mainArray[sender.tag] as! NSDictionary
        //let isUpperImageAvailable = directoryList.object(forKey: "profilePic") as? String
        
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableBodListShow.dequeueReusableCell(withIdentifier: "customBodCell", for: indexPath) as! customBodCell
        
        cell.imageBodProfilePic.layer.borderWidth = 1.0
        cell.imageBodProfilePic.layer.masksToBounds = false
        cell.imageBodProfilePic.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        cell.imageBodProfilePic.layer.cornerRadius = cell.imageBodProfilePic.frame.size.width/2
        cell.imageBodProfilePic.clipsToBounds = true
        
//        var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
//        objCommonHoldDataVariable = muarrayBodList.object(at: indexPath.row) as! CommonAccessibleHoldVariable;
//        let varBodMemberName=objCommonHoldDataVariable.varBodMemberName
//        let varBodMemberDesignation=objCommonHoldDataVariable.varBodMemberDesignation
//        let varBodMemberPic=objCommonHoldDataVariable.varBodMemberPic
//        print("member name  ----------\(varBodMemberName)")
//        cell.lblBodMemberName.text = varBodMemberName
        if isfilter {
            if filteredMem.count > 0 {
                cell.lblBodMemberName.text = filteredMem[indexPath.row]
                cell.lblDesignation.text = filteredDesgn[indexPath.row]
                if(filteredPic[indexPath.row] == "")
                {
                   cell.imageBodProfilePic.image = UIImage(named: "profile_pic")
                }
                else
                {
                    
                    var ImageProfilePic:String = filteredPic[indexPath.row].replacingOccurrences(of: " ", with: "%20")
                    /*------------------------------Code by --------------------DPK--------------------------- */
                    if let checkedUrl = URL(string: ImageProfilePic) {
                        /*
                         KingfisherManager.sharedManager.retrieveImageWithURL(checkedUrl, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                         print(image)
                         cell.imageBodProfilePic.image = image
                         })
                         */
                        
                        var varGetImage:String!=ImageProfilePic
                        let ImageProfilePic:String = varGetImage.replacingOccurrences(of: " ", with: "%20")
                        let checkedUrl = URL(string: ImageProfilePic)
                        cell.imageBodProfilePic.sd_setImage(with: checkedUrl)
                        
                        
                        
                        
                        
                        
                        
                        
                        /*-----------------Code by --------------------DPK--------------------------- */
                    }
                    }
            }
            
        } else {
            self.NoRecordLabel.isHidden = true
        if secCount > 0 {
            cell.lblBodMemberName.text = onlineBODNam[indexPath.row]
            print("member name  --------\(cell.lblBodMemberName.text)")
            
            //        cell.lblDesignation.text = varBodMemberDesignation
            cell.lblDesignation.text = onlineBODDesgn[indexPath.row]
            
            
            //         cell.buttonMainImageBig.addTarget(self, action: #selector(BoardOfDirectorsViewController.buttonPicBigViewnewClickEvent(_:)), for: UIControl.Event.touchUpInside)
            //
            //         cell.buttonMainImageBig.tag=indexPath.row
            
            if(onlineBODPic[indexPath.row] == "")
            {
               cell.imageBodProfilePic.image = UIImage(named: "profile_pic")
            }
            else
            {
                
                var ImageProfilePic:String = onlineBODPic[indexPath.row].replacingOccurrences(of: " ", with: "%20")
                /*------------------------------Code by --------------------DPK--------------------------- */
                if let checkedUrl = URL(string: ImageProfilePic) {
                    /*
                     KingfisherManager.sharedManager.retrieveImageWithURL(checkedUrl, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                     print(image)
                     cell.imageBodProfilePic.image = image
                     })
                     */
                    
                    var varGetImage:String!=ImageProfilePic
                    let ImageProfilePic:String = varGetImage.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    cell.imageBodProfilePic.sd_setImage(with: checkedUrl)
                    
                    
                    
                    
                    
                    
                    
                    
                    /*-----------------Code by --------------------DPK--------------------------- */
                }
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        appDelegate = UIApplication.shared.delegate as! AppDelegate
        // if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        //{
            tableView.deselectRow(at: indexPath, animated: true)
            
          
            
            
            //        NSUserDefaults.standardUserDefaults().setObject("no", forKey: "picadded")
            //var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
            // objCommonHoldDataVariable = muarrayBodList.objectAtIndex(indexPath.row) as! CommonAccessibleHoldVariable;
            //let profVC = self.storyboard!.instantiateViewControllerWithIdentifier("profileView") as! ProfileViewController
            //profVC.userGroupID =  objCommonHoldDataVariable.varBodMemberGroupID  //nameTitles[indexPath.row]
           // profVC.userProfileID =  objCommonHoldDataVariable.varBodMemberProfileId  //mobileTitles[indexPath.row]
           // profVC.isAdmin = isAdmin
           // profVC.isCalled = "BOD"
            //self.navigationController?.pushViewController(profVC, animated: true)
            
            
//            var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
//            objCommonHoldDataVariable = muarrayBodList.object(at: indexPath.row) as! CommonAccessibleHoldVariable;
//        print(objCommonHoldDataVariable)
        if isfilter{
            let objProfileDynamicNewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
        objProfileDynamicNewViewController.from = "BOD"
        objProfileDynamicNewViewController.fromBOD = true
        objProfileDynamicNewViewController.isUpperImageAvailable = filteredPic[indexPath.row]
        objProfileDynamicNewViewController.userImg = filteredPic[indexPath.row]
        objProfileDynamicNewViewController.userNam = filteredMem[indexPath.row]
        objProfileDynamicNewViewController.mob = filterMob[indexPath.row]
        objProfileDynamicNewViewController.desgn = filteredDesgn[indexPath.row]
        objProfileDynamicNewViewController.mastersId = Int(filteredMasterID[indexPath.row])
            self.navigationController?.pushViewController(objProfileDynamicNewViewController, animated: true)
        } else {
            let objProfileDynamicNewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
        objProfileDynamicNewViewController.from = "BOD"
        objProfileDynamicNewViewController.fromBOD = true
        objProfileDynamicNewViewController.isUpperImageAvailable = onlineBODPic[indexPath.row]
        objProfileDynamicNewViewController.userImg = onlineBODPic[indexPath.row]
        objProfileDynamicNewViewController.userNam = onlineBODNam[indexPath.row]
        objProfileDynamicNewViewController.mob = onlineBODMob[indexPath.row]
        objProfileDynamicNewViewController.desgn = onlineBODDesgn[indexPath.row]
        objProfileDynamicNewViewController.mastersId = Int(onlineBODMasterID[indexPath.row])
            self.navigationController?.pushViewController(objProfileDynamicNewViewController, animated: true)
        }
            
//            let grpID =  objCommonHoldDataVariable.varBodMemberGroupID
//            let profileId = objCommonHoldDataVariable.varBodMemberProfileId
//             let masterId = objCommonHoldDataVariable.varBodMemberMasterUID
//            
//            
//            objProfileDynamicNewViewController.masterId=masterId
//            objProfileDynamicNewViewController.profileId=profileId
//            objProfileDynamicNewViewController.grpID=grpID
//            objProfileDynamicNewViewController.isAdmin = isAdmin
//            objProfileDynamicNewViewController.NormalMemberOrAdmin="BOD"
//            objProfileDynamicNewViewController.isCategory = isCategory
//            objProfileDynamicNewViewController.ClubNameFotShowProfile=objCommonHoldDataVariable.varBodMemberDesignation
//            objProfileDynamicNewViewController.FromDistrictOrBOD = "FromDistrictOrBOD"
         // objProfileDynamicNewViewController.FromDistrictHideFamilyDetails = "FromDistrictHideFamilyDetails"
        

        
            
//        }
//        else
//        {
//            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
//        }
    }
    
    //MARK:- Server Calling
    func getBoardOfDirectorList(_ groupId:NSString,searchText:NSString)
    {
      //  loaderViewMethod()
        let completeURL:String! = baseUrl+row_GetBodMemberList
//        let parameterst = ["grpId" : groupId, "searchText" : searchText]
        
        
        var parameterst:NSDictionary=NSDictionary()
        
//            http://rotaryindiaapi.rosteronwheels.com/api//Gallery/DeleteAlbumPhoto :- [photoId=77098, albumId=23357, deletedBy=581428, Financeyear=2021-2022]
            
        parameterst =  [ "searchText": searchText  as AnyObject,
                        "grpId":groupId,
                        "YearFilter" : ListTypeTextField.text as Any]
        
        
        
        print(parameterst)
        print(completeURL)
        SVProgressHUD.show()
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable : Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            print(response)
            print(response)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            let dd = response as! NSDictionary
            print("dd \(dd)")
            if((dd.object(forKey: "TBGetBODResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                self.NoRecordLabel.isHidden = true
                self.secCount = (((response.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "memberName")! as AnyObject).count
                for i in 0..<(((response.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "memberName")! as AnyObject).count
                {
                    self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
//                    print((((response.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "memberName")! as AnyObject).object(at: i))
                    let varBodMemberMasterUID=((((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "masterUID")! as AnyObject).object(at: i))
                    let varBodMemberGroupID=((((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "grpID")! as AnyObject).object(at: i))
                    let varBodMemberProfileId=(((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "profileID")! as AnyObject).object(at: i)
                    let varBodMemberName=((((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "memberName")! as AnyObject).object(at: i))
                    let varBodMemberMobile=((((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "membermobile")! as AnyObject).object(at: i))
                    let varBodMemberDesignation=(((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "MemberDesignation")! as AnyObject).object(at: i)
                    let varBodMemberPic=(((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "pic")! as AnyObject).object(at: i)
                    var namm = ((((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "memberName")! as AnyObject).object(at: i))
                    print("nammmmm:: \(namm)")
                    self.onlineBODNam.append(namm as? String ?? "")
                    print("onlineBODNam: \(self.onlineBODNam)")
                     var mobb = ((((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "membermobile")! as AnyObject).object(at: i))
                    self.onlineBODMob.append(mobb as? String ?? "")
                     var dsgn = ((((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "MemberDesignation")! as AnyObject).object(at: i))
                    self.onlineBODDesgn.append(dsgn as? String ?? "")
                    var pics = ((((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "pic")! as AnyObject).object(at: i))
                    self.onlineBODPic.append(pics as? String ?? "")
                    
                    var masID = ((((dd.value(forKey: "TBGetBODResult")! as AnyObject).value(forKey: "BODResult")! as AnyObject).value(forKey: "masterUID")! as AnyObject).object(at: i))
                    self.onlineBODMasterID.append(masID as? String ?? "")

                    self.commonClassHoldDataAccessibleVariable.varBodMemberMasterUID = varBodMemberMasterUID as? String;
                    self.commonClassHoldDataAccessibleVariable.varBodMemberName = varBodMemberName as? String;
                    self.commonClassHoldDataAccessibleVariable.varBodMemberGroupID = varBodMemberGroupID as? String;
                    self.commonClassHoldDataAccessibleVariable.varBodMemberProfileId = varBodMemberProfileId as? String;
                    self.commonClassHoldDataAccessibleVariable.varBodMemberMobile = varBodMemberMobile as? String;
                    self.commonClassHoldDataAccessibleVariable.varBodMemberDesignation = varBodMemberDesignation as? String;
                    self.commonClassHoldDataAccessibleVariable.varBodMemberPic = varBodMemberPic as? String;
                    
                    self.muarrayBodList.add(self.commonClassHoldDataAccessibleVariable)
//                    [self.tableBodListShow .reloadData()];
                    self.tableBodListShow .reloadData()
                }
                
                if self.secCount == 0 {
                    self.NoRecordLabel.isHidden = false
                    self.tableBodListShow .reloadData()
                }
                
//                self.appDelegate = UIApplication.shared.delegate as! AppDelegate
//               if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
//                    self.DeleteDataInlocal()
//                    if(self.muarrayBodList.count>0)
//                    {
//                         self.NoRecordLabel.isHidden = true
//                        self.SaveDataInlocal(self.muarrayBodList)
//                        self.mainArray = NSMutableArray()
////                        self.tableBodListShow.isHidden = false
//                        self.fetchData()
//                    }
//                    else
//                    {
//                       self.NoRecordLabel.isHidden = false
//                        self.window = nil
//                        self.tableBodListShow.reloadData()
////                        self.tableBodListShow.isHidden = true
//                    }
//                }
//                else
//                {
//                     self.mainArray = NSMutableArray()
//                     self.fetchData()
//                     self.tableBodListShow.reloadData()
//                }
            }
            else
            {
//                self.tableBodListShow.isHidden = true
                self.NoRecordLabel.isHidden = false
                self.window = nil
            }
            self.window = nil
            SVProgressHUD.dismiss()
            }
        })
    }
    
    /*----------------------------------------------------------------------------DPK----------------------------*/
    //MARK:- Loader Method
//    func loaderViewMethod()
//    {
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
    //MARK:- Local Data Store
   /*---------------Save / Delete / update / fetch -------------------DPK----------------------------*/
    //Save Data
    
    func SaveDataInlocal (_ arrdata:NSMutableArray){
        var databasePath : String
        print(arrdata);
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
            var ProrityValue:Int = 0
            for i in 0 ..< arrdata.count {
                
                
                var objCommonHoldDataVariable: CommonAccessibleHoldVariable = CommonAccessibleHoldVariable()
                 objCommonHoldDataVariable = arrdata.object(at: i) as! CommonAccessibleHoldVariable;
                let varBodMemberName=objCommonHoldDataVariable.varBodMemberName!
                let varBodMemberDesignation=objCommonHoldDataVariable.varBodMemberDesignation
                let varBodMemberPic=objCommonHoldDataVariable.varBodMemberPic!
                let varBodMemberProfileId = objCommonHoldDataVariable.varBodMemberProfileId
                let varBodMemberMobile = objCommonHoldDataVariable.varBodMemberMobile
                let varGroupID = objCommonHoldDataVariable.varBodMemberGroupID
                //let  dict = arrdata[i] as! NSDictionary
                //masterUID, groupId , moduleId , profileID , MemberDesignation , memberName , pic , membermobile From Board_Of_Directors_List
                
               if (varBodMemberDesignation == "President")
               {
                ProrityValue = 1
                }
                else if (varBodMemberDesignation == "Secretary")
               {
                ProrityValue = 2
                }
               else if (varBodMemberDesignation == "Treasurer")
               {
                ProrityValue = 3
                }
               else if (varBodMemberDesignation == "Chairman")
               {
                ProrityValue = 4
                }
                else
               {
                ProrityValue = 5
                }
                
                let insertSQL = "INSERT INTO Board_Of_Directors_List (masterUID , groupId, moduleId, profileID , MemberDesignation,memberName,pic,membermobile,sortingBYDesignation) VALUES ('\(mainMemberID!)', '\(varGroupID!)', '\(moduleId!)', '\(varBodMemberProfileId!)', '\(varBodMemberDesignation!)', '\(String(describing: varBodMemberName))', '\(String(describing: varBodMemberPic))', '\(varBodMemberMobile!)','\(ProrityValue)')"
                print(insertSQL)
                
                let result = contactDB?.executeStatements(insertSQL)
                
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("success saved")
                    print(databasePath);
                }
            }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
    }

    //Fetch Data
    func fetchData()
    {
       // loaderClass.loaderViewMethod()
        checkRow = ""
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
        if (contactDB?.open())! {
          //  let querySQL = "SELECT * FROM Board_Of_Directors_List where groupId = '\(grpID)' and moduleId='\(moduleId)'  order by sortingBYDesignation asc"
            
            let querySQL = "SELECT * FROM Board_Of_Directors_List where groupId = '\(grpID!)' and moduleId='\(moduleId!)'"
            
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {
                print((results?.string(forColumn: "profileID"))! as String)
                // let dd = NSMutableDictionary ()
                self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                let varBodMemberGroupID:String! =   (results?.string(forColumn: "groupId"))
                print(varBodMemberGroupID)
                let varBodMemberMasterUID:String!=(results?.string(forColumn: "moduleId"))! as String
                let varBodMemberProfileId:String!=(results?.string(forColumn: "profileID"))! as String
                let varBodMemberDesignation:String!=(results?.string(forColumn: "MemberDesignation"))! as String
                let varBodMemberName:String!=(results?.string(forColumn: "memberName"))! as String
                let varBodMemberPic:String!=(results?.string(forColumn: "pic"))! as String
                let varBodMemberMobile:String!=(results?.string(forColumn: "membermobile"))! as String
                
                self.commonClassHoldDataAccessibleVariable.varBodMemberMasterUID = varBodMemberMasterUID
                self.commonClassHoldDataAccessibleVariable.varBodMemberName = varBodMemberName
                self.commonClassHoldDataAccessibleVariable.varBodMemberGroupID = varBodMemberGroupID
                self.commonClassHoldDataAccessibleVariable.varBodMemberProfileId = varBodMemberProfileId
                self.commonClassHoldDataAccessibleVariable.varBodMemberMobile = varBodMemberMobile
                self.commonClassHoldDataAccessibleVariable.varBodMemberDesignation = varBodMemberDesignation
                self.commonClassHoldDataAccessibleVariable.varBodMemberPic = varBodMemberPic
                self.mainArray.add(self.commonClassHoldDataAccessibleVariable)
                //print(dd)
                //mainArray.addObject(dd)
            }
            self.loaderClass.window = nil
            self.tableBodListShow.reloadData()
            if mainArray.count > 0 {
                checkRow = ""
                 NoRecordLabel.isHidden = true
                muarrayBodList=mainArray
                tableBodListShow.reloadData()
            }else{
                checkRow = "1"
                 NoRecordLabel.isHidden = false
                mainArray = NSMutableArray()
                muarrayBodList=NSMutableArray()
                //directoryTableView.reloadData()
            }
        }
        
    }
    
    
    func SearchFromMemberNameAndYear(_ MemberName:String)
    {
        //loaderClass.loaderViewMethod()
        checkRow = ""
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
        if (contactDB?.open())! {
            let querySQL = "SELECT * FROM Board_Of_Directors_List where MemberDesignation like '%\(MemberName)%' or memberName like '%\(MemberName)%' and groupId = '\(grpID!)' and moduleId='\(moduleId!)'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
            while results?.next() == true
            {
                print((results?.string(forColumn: "profileID"))! as String)
               // let dd = NSMutableDictionary ()
                self.commonClassHoldDataAccessibleVariable = CommonAccessibleHoldVariable()
                let varBodMemberGroupID:String! =   (results?.string(forColumn: "groupId"))
                print(varBodMemberGroupID)
                let varBodMemberMasterUID:String!=(results?.string(forColumn: "moduleId"))! as String
                let varBodMemberProfileId:String!=(results?.string(forColumn: "profileID"))! as String
                let varBodMemberDesignation:String!=(results?.string(forColumn: "MemberDesignation"))! as String
                let varBodMemberName:String!=(results?.string(forColumn: "memberName"))! as String
                let varBodMemberPic:String!=(results?.string(forColumn: "pic"))! as String
                let varBodMemberMobile:String!=(results?.string(forColumn: "membermobile"))! as String
   
                self.commonClassHoldDataAccessibleVariable.varBodMemberMasterUID = varBodMemberMasterUID
                self.commonClassHoldDataAccessibleVariable.varBodMemberName = varBodMemberName
                self.commonClassHoldDataAccessibleVariable.varBodMemberGroupID = varBodMemberGroupID
                self.commonClassHoldDataAccessibleVariable.varBodMemberProfileId = varBodMemberProfileId
                self.commonClassHoldDataAccessibleVariable.varBodMemberMobile = varBodMemberMobile
                self.commonClassHoldDataAccessibleVariable.varBodMemberDesignation = varBodMemberDesignation
                self.commonClassHoldDataAccessibleVariable.varBodMemberPic = varBodMemberPic
                self.mainArray.add(self.commonClassHoldDataAccessibleVariable)
                //print(dd)
                //mainArray.addObject(dd)
            }
            self.loaderClass.window = nil
            self.tableBodListShow.reloadData()
            if mainArray.count > 0 {
                checkRow = ""
                NoRecordLabel.isHidden = true
                muarrayBodList=mainArray
                tableBodListShow.reloadData()
            }else{
                checkRow = "1"
                NoRecordLabel.isHidden = false
                mainArray = NSMutableArray()
                muarrayBodList=NSMutableArray()
                //directoryTableView.reloadData()
            }
        }
     
    }
    
    
    
    
    
    //DeleteData
    
    func DeleteDataInlocal (){
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
                let insertSQL = "DELETE FROM Board_Of_Directors_List" // WHERE profileID = '\(dict.objectForKey("serviceDirId") as! String)'
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
        
    }
    
}
