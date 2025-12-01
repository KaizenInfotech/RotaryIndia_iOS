//
//  EBulletinListingController.swift
//  TouchBase
//
//  Created by Kaizan on 21/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

protocol protocolForUpdateListing {
    func functionForUpdateListing(stringValue:String)
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
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

protocol protocolForEBulletinListingCallingApi {
    func functionForEBulletinListingCallingApi(stringFromWhereITCalling:String)
}

class EBulletinListingController: UIViewController , UITableViewDataSource ,UIPickerViewDelegate,UIPickerViewDataSource, UITableViewDelegate,UITextFieldDelegate,webServiceDelegate,protocolForEBulletinListingCallingApi,protocolForUpdateListing {
  
    var stringProfileId:String!=""
    var memberProfileId:String=""
    var varGetID = ""

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
//            year = year+1
        }
        else
        {
        }
        yearFrom = String(year)
        
        ////print(yearFrom)
        listTypeTextField.text! = String(year-1) + "-" + yearFrom //yearFrom+"-"+String(year+1)
        
        
        functionForYears()
        
        
        
        
        //  if isAdmin == "Yes"
        //  {
        searchTextField.delegate = self
        listTypeTextField.delegate = self
        
        viewFoSearchrUnderLine.frame = CGRect(x: self.viewFoSearchrUnderLine.frame.origin.x, y: self.viewFoSearchrUnderLine.frame.origin.y, width: self.view.frame.size.width, height: self.viewFoSearchrUnderLine.frame.size.height)
        /*
        searchTextField.frame = CGRect(x: self.searchTextField.frame.origin.x, y: self.searchTextField.frame.origin.y, width: self.view.frame.size.width-(self.listTypeTextField.frame.size.width+50), height: self.searchTextField.frame.size.height)
        
        listTypeTextField.frame = CGRect(x: self.searchTextField.frame.size.width+18, y: self.listTypeTextField.frame.origin.y, width: self.listTypeTextField.frame.size.width+28, height: self.listTypeTextField.frame.size.height)
        */
        listTypeTextField.isHidden = false
        self.pickerView.isHidden=true
        self.searchAnnouncemt()
        
        
        self.noResultLbl.text=""
        self.noResultLbl.isHidden=true
        noResultLbl.isHidden=true
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        // self.listTypeTextField.text=String(varGetCurrentYear-1)+"-"+String(varGetCurrentYear)
        
        self.annType="1"
        
        noResultLbl.isHidden=true
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        /*-----------------------------------AdminOrNot------------------DPK--------------------------*/
        
        searchTextField.borderStyle = .roundedRect
        listTypeTextField.borderStyle = .roundedRect
        
        
        // searchTextField.layer.cornerRadius = 2.0
        // searchTextField.layer.borderWidth = 1.0
        //functionForGetDataFromServer(String(varGetBackYear), toYear: String(varGetCurrentYear))  //Code by Rajendra and comment by DPK
        
        functionForGetDataFromServer()
        /*-----------------------------------AdminOrNot----------DPK----------------------------------*/
        allbulletinArry=[]
        SMSCountStr = ""
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        let defaults = UserDefaults.standard
        
        
        
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            if let uid = defaults.string(forKey: "masterUID")
            {
                //wsm.getAllEbulletinOFUSer(grpDetail.groupId, memberProfileId: grpDetail.masterProfileID, searchText: "", type: annType, isAdmin: isAdmin)
                wsm.getAllEbulletinOFUSer(varGetID as NSString, memberProfileId: memberProfileId  as NSString, searchText: "", type: annType, isAdmin: isAdmin)
            }
        }
        else
        {
            self.view.makeToast("Please check your internet connection, Please try again later", duration: 2, position: CSToastPositionCenter)
        }
        ////print(isAdmin)
        noResultLbl.isHidden=true
    }
    
    
    func functionForEBulletinListingCallingApi(stringFromWhereITCalling: String) {
        
        
        
        
        
        
        ////print("This is from screens :------")
        self.noResultLbl.text=""
        self.noResultLbl.isHidden=true
        noResultLbl.isHidden=true
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
        
        self.annType="1"
        
        noResultLbl.isHidden=true
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        /*-----------------------------------AdminOrNot------------------DPK--------------------------*/
        
        searchTextField.borderStyle = .roundedRect
        listTypeTextField.borderStyle = .roundedRect
        
        
        // searchTextField.layer.cornerRadius = 2.0
        // searchTextField.layer.borderWidth = 1.0
        //functionForGetDataFromServer(String(varGetBackYear), toYear: String(varGetCurrentYear))  //Code by Rajendra and comment by DPK
        
        functionForGetDataFromServer()
        /*-----------------------------------AdminOrNot----------DPK----------------------------------*/
        allbulletinArry=[]
        SMSCountStr = ""
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        let defaults = UserDefaults.standard
        
        
        
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            if let uid = defaults.string(forKey: "masterUID")
            {
                //wsm.getAllEbulletinOFUSer(grpDetail.groupId, memberProfileId: grpDetail.masterProfileID, searchText: "", type: annType, isAdmin: isAdmin)
                wsm.getAllEbulletinOFUSer(varGetID as NSString, memberProfileId: memberProfileId  as NSString, searchText: "", type: annType, isAdmin: isAdmin)
                
                
                
            }
        }
        else
        {
            self.view.makeToast("Please check your internet connection, Please try again later", duration: 2, position: CSToastPositionCenter)
        }
        
        
        
        
        
        
        ////print(isAdmin)
        noResultLbl.isHidden=true
    }

    override func viewWillAppear(_ animated: Bool) {
      print("Ebulletin View Will Appear")
        functionForGetDataFromServer()
        getClubDetails()
    }

    var arrayResponse=NSArray()
    var dcitHoldingArray=NSArray()
    var appDelegate : AppDelegate!
    var SMSCountStr : String!
    var varGetSearchBoxValue:String!=""
    let bounds = UIScreen.main.bounds
    @IBOutlet weak  var searchTextField : UITextField!
    @IBOutlet weak  var listTypeTextField : UITextField!
    @IBOutlet var headerVC:UIView!
    
    // @IBOutlet weak var viewFoSearchrUnderLine: UITextField!
    
    @IBOutlet weak var viewFoSearchrUnderLine: UILabel!
    
    @IBOutlet var EBulletinTableView: UITableView!
    var allbulletinArry:NSArray!
    
    
    
    var yearFrom:String! = ""
    var year : Int! = 0
    
    
    //    var pickerDataSource = [ "Published", "All", "Scheduled", "Expired"];
    //    var pickerDataSourceNonAdmin = [ "Published", "All" ,"Expired"];
    
    var pickerDataSource = [ "Published", "All", "Scheduled", "Expired"];
    var pickerDataSourceNonAdmin = [ "Published", "All" ,"Expired"];
    
    
    @IBOutlet var pickerView:UIPickerView!
    var annType:NSString!
    var isAdmin:NSString!
    var moduleName:String! = ""
    @IBOutlet var noResultLbl: UILabel!
    var alertController = UIAlertController()
    var currentYear = ""
    var grpDetail:GroupList!
    var grpDetailPrevious:NSDictionary!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getClubDetails()
        let date = Foundation.Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        year =  components.year
        let month = components.month
        let day = components.day
        if(month!>=7)
        {
            year = year+1
        }
        else
        {
        }
//        year = year+1
        yearFrom = String(year)
        print(yearFrom)
//        listTypeTextField.text! = String(year-1) + "-" + yearFrom //yearFrom+"-"+String(year+1)
//        listTypeTextField.text! = String(year-1) + "-" + String(year)
        listTypeTextField.text! = String(year-1) + "-" + yearFrom
        self.currentYear = String(year-1) + "-" + yearFrom
        print(year)
        functionForYears()
        
//        http://rotaryindiaapi.rosteronwheels.com/api/Ebulletin/AddEbulletin
        
        
        //  if isAdmin == "Yes"
        //  {
        searchTextField.delegate = self
        listTypeTextField.delegate = self
        
        viewFoSearchrUnderLine.frame = CGRect(x: self.viewFoSearchrUnderLine.frame.origin.x, y: self.viewFoSearchrUnderLine.frame.origin.y, width: self.view.frame.size.width, height: self.viewFoSearchrUnderLine.frame.size.height)
        searchTextField.frame = CGRect(x: self.searchTextField.frame.origin.x, y: self.searchTextField.frame.origin.y, width: self.view.frame.size.width-(self.listTypeTextField.frame.size.width+50), height: self.searchTextField.frame.size.height)
        
        listTypeTextField.frame = CGRect(x: self.searchTextField.frame.size.width+18, y: self.listTypeTextField.frame.origin.y, width: self.listTypeTextField.frame.size.width+28, height: self.listTypeTextField.frame.size.height)
        listTypeTextField.isHidden = false
        self.pickerView.isHidden=true
        self.searchAnnouncemt()

        
        self.noResultLbl.text=""
        self.noResultLbl.isHidden=true
        noResultLbl.isHidden=true
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        // self.listTypeTextField.text=String(varGetCurrentYear-1)+"-"+String(varGetCurrentYear)
        
        self.annType="1"
        
        noResultLbl.isHidden=true
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        /*-----------------------------------AdminOrNot------------------DPK--------------------------*/
        
        searchTextField.borderStyle = .roundedRect
        listTypeTextField.borderStyle = .roundedRect
        
        
        // searchTextField.layer.cornerRadius = 2.0
        // searchTextField.layer.borderWidth = 1.0
        //functionForGetDataFromServer(String(varGetBackYear), toYear: String(varGetCurrentYear))  //Code by Rajendra and comment by DPK
        
        functionForGetDataFromServer()
        /*-----------------------------------AdminOrNot----------DPK----------------------------------*/
        allbulletinArry=[]
        SMSCountStr = ""
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        let defaults = UserDefaults.standard
        
        
        
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            if let uid = defaults.string(forKey: "masterUID")
            {
                //wsm.getAllEbulletinOFUSer(grpDetail.groupId, memberProfileId: grpDetail.masterProfileID, searchText: "", type: annType, isAdmin: isAdmin)
                //wsm.getAllEbulletinOFUSer(grpDetailPrevious.object(forKey: "grpId") as! String as NSString, memberProfileId: memberProfileId  as NSString, searchText: "", type: annType, isAdmin: isAdmin)
            }
        }
        else
        {
            self.view.makeToast("Please check your internet connection, Please try again later", duration: 2, position: CSToastPositionCenter)
        }
        ////print(isAdmin)
        noResultLbl.isHidden=true
    }
    
    
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
        
        
        
        for  i in (2015..<year)
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
        
        
        if(searchTextField.text?.characters.count>0)
        {
            //print(searchTextField.text!)
            
            
            
            let searchPredicate = NSPredicate(format: "ebulletinTitle CONTAINS[C] %@", searchTextField.text!)
            //let array = (arrayResponse as NSArray).filtered(using: searchPredicate)
            let array = (dcitHoldingArray as NSArray).filtered(using: searchPredicate)
            
            //print("array = \(array)")
            arrayResponse = array as NSArray as NSArray
            EBulletinTableView.reloadData()
            
            
            if(arrayResponse.count>0)
            {
                noResultLbl.isHidden=true
                //print("if condition")
            }
            else
            {
                noResultLbl.isHidden=false
                noResultLbl.text="No Results"
                 //print("else condition")
            }
        }
        else
        {
            arrayResponse=dcitHoldingArray
             print("self.arrayResponse 2::: \(self.arrayResponse)")
            EBulletinTableView.reloadData()
        }
        
        
        if(arrayResponse.count>0)
        {
            noResultLbl.isHidden=true
            //print("if condition111")
        }
        else
        {
            noResultLbl.isHidden=false
            noResultLbl.text="No Results"
            //print("else condition222")
        }
        // var resultPredicate : NSPredicate = NSPredicate(format: "name contains[c]\(searchText)", nil)
        
        //var recipes : NSArray = NSArray()
        
        //  var searchResults = recipes.filteredArrayUsingPredicate(resultPredicate)
    }
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title=moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(EBulletinListingController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(EBulletinListingController.AddEbullAction))
        add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)//UIColor.whiteColor()
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
        if isAdmin == "Yes"
        {
            self.navigationItem.rightBarButtonItem = add
        }
        
        
        
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    //  //for whatsapp count
    func getClubDetails()
    {
        //loaderViewMethod()
        SVProgressHUD.show()
        let completeURL:String! = baseUrl+row_ClubInfoDetails
        var parameterst:NSDictionary=NSDictionary()
        parameterst = ["grpID":varGetID]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable : Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            print(response)
            print(response)
            let dd = response as! NSDictionary
            print("dd-----SMS \(dd)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            if((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let MeetingPlace =    ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "MeetingPlace") as! String
                let smsCount = ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "SMSCount") as! String
                self.SMSCountStr = smsCount

//                if self.isCalledFRom=="add"
//                {
////                self.MeetingPlace = MeetingPlace
////                let cell : HeaderCelll = self.self.cellArray.object(at: 0) as! HeaderCelll
//
////                cell.eventVenueTextView.text! = self.MeetingPlace
//                self.SMSCountStr = smsCount
////                let cell1 : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
////                    self.balancedWhatsappLbl.text="Balance WhatsApp : "+self.SMSCountStr
////                self.addEventTableView.reloadData()
//               // self.window = nil
//              }
//                if self.isCalledFRom=="Edit"
//                {
////                    let cell1 : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
//                    self.SMSCountStr = smsCount
//                    print(self.SMSCountStr)
//                    self.balancedWhatsappLbl.text="Balance WhatsApp : "+self.SMSCountStr
////                    self.addEventTableView.reloadData()
//                }
            }
            else
            {
                //self.window = nil
            }
//                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6), execute: {
//                    SVProgressHUD.dismiss()
//                })
            }
        })
    }
    @objc func AddEbullAction()
    {
        let addEBull = self.storyboard?.instantiateViewController(withIdentifier: "add_ebull") as! AddEBulletineController
        UserDefaults.standard.set("", forKey: "groupsID")
        addEBull.groupID = self.varGetID
        let defaults = UserDefaults.standard
        let uid = defaults.string(forKey: "masterUID")
        
        addEBull.groupProfileID = memberProfileId
        addEBull.SMSCountStr = SMSCountStr
        addEBull.moduleName = moduleName
        addEBull.objprotocolForEBulletinListingCallingApi=self
        addEBull.getFinanceYear = self.currentYear
        print(self.currentYear)
        
        self.pickerView.isHidden=true
        self.navigationController?.pushViewController(addEBull, animated: true)
        
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        self.headerVC.translatesAutoresizingMaskIntoConstraints = true
//        self.headerVC.frame=CGRect(x: 0, y: 0, width: bounds.width, height: 60)
//        return self.headerVC;
//    }

//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
//    {
//        return 60
//    }
    
   func functionToCall()
    {
        alertController.dismiss(animated: true, completion: nil)
    }
    
     func getallbulletinOFUSerSuccssS(string:TBEbulletinListResult)
    {
        
//        SVProgressHUD.dismiss()
        noResultLbl.isHidden=true
        // self.headerVC.translatesAutoresizingMaskIntoConstraints = true
        //  self.headerVC.frame=CGRectMake(0, 0, bounds.width, 60)
        //self.EBulletinTableView.tableHeaderView=self.headerVC
        //print(string.smscount)
//        SMSCountStr = string.smscount
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.functionToCall()

        })
        
        //print(string.ebulletinListResult.count)
        //print(string.ebulletinListResult)
        if string.status == "1"
        {
            allbulletinArry=[]
            EBulletinTableView.reloadData()
            noResultLbl.text="No Results"
            noResultLbl.isHidden=false
        }
        else if(string.ebulletinListResult.count <= 0){
            allbulletinArry=[]
            EBulletinTableView.reloadData()
            noResultLbl.text=""
            noResultLbl.isHidden=false
        }else
        {
            noResultLbl.isHidden=true
            allbulletinArry = string.ebulletinListResult as NSArray
            print("allbulletinArry:: \(allbulletinArry)")
            EBulletinTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayResponse.count
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        if(textField.tag==22){
            
            listTypeTextField.resignFirstResponder()
            self.view .bringSubviewToFront( self.pickerView)
            self.pickerView.isHidden=true
            
        }else{
            self.pickerView.isHidden=true
            searchTextField.resignFirstResponder()
            self.searchAnnouncemt()
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
    //    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    //    {
    //        return 60
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = EBulletinTableView.dequeueReusableCell(withIdentifier: "ebulletineCell", for: indexPath) as! EbulletineCell
        var ebullList = EbulletinList()
        if arrayResponse.count > 0
        {
            //print(arrayResponse)
            //ebullList = allbulletinArry.objectAtIndex(indexPath.row) as! EbulletinList
            cell.bulletineNameLabel.text    = (arrayResponse.object(at: indexPath.row) as AnyObject).object(forKey: "ebulletinTitle")as! String
            cell.bulletinDateTimeLabel.text = (arrayResponse.object(at: indexPath.row) as AnyObject).object(forKey: "publishDateTime")as! String
            
            ////print((arrayResponse.object(at: indexPath.row) as AnyObject).object(forKey: "ebulletinTitle")as! String)
            ////print((arrayResponse.object(at: indexPath.row) as AnyObject).object(forKey: "publishDateTime")as! String)
            
        }
        
        let getReadStatus:String! = (arrayResponse.object(at: indexPath.row) as AnyObject).object(forKey: "isRead")as! String
        
        
        if(getReadStatus == "No"){
            cell.bulletineNameLabel.textColor=UIColor(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0)
            //  cell.contentView.backgroundColor = UIColor.lightGrayColor()
        }else{
            cell.bulletineNameLabel.textColor=UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
            //  cell.contentView.backgroundColor = UIColor.whiteColor()
        }
        
        
        cell.buttonmDeleteClickEvent.addTarget(self, action: #selector(EBulletinListingController.buttonDeleteClickedEvent(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonmDeleteClickEvent.tag=indexPath.row;
        //buttonmDeleteClickEvent
        cell.selectionStyle = .none
        
        
        return cell
    }
    var ebulletinID:String!=""
    @objc func buttonDeleteClickedEvent(_ sender:UIButton)
    {
        
        var dictTemporaryDictionary:NSDictionary = ((arrayResponse.object(at: sender.tag) as AnyObject) as! NSDictionary)
        
       ebulletinID=dictTemporaryDictionary.object(forKey: "ebulletinID")as! String 
        
        
        
        let alert=UIAlertController(title: "Confirm", message:"Are you sure, you want to delete?", preferredStyle: UIAlertController.Style.alert);
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil));
        //event handler with closure
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
            SVProgressHUD.show()
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=nil
            wsm.delegates=self
            wsm.deleteDataWebservice(self.ebulletinID as String, type: "Ebulletin", profileID:  self.memberProfileId )
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(20), execute: {
                SVProgressHUD.dismiss()
            })
        }));
        self.present(alert, animated: true, completion: nil);
        
    }
 
    func deleteSucc(_ docListing : DeleteResult){
        
        self.view.makeToast("Deleted successfully.", duration: 2, position: CSToastPositionCenter)

       functionForUpdateListing(stringValue: "hello called from self !!!")
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

        print("Array is \(arrayResponse)")
        print("**************************")
        
        var stringUrl:String! = (arrayResponse.object(at: indexPath.row) as AnyObject).object(forKey: "ebulletinlink")as! String
        print("string URL \(stringUrl)")
        
        if(stringUrl.contains(".pdf") || stringUrl.contains(".docx") || stringUrl.contains(".doc") || stringUrl.contains(".html") || stringUrl.contains(".gif") || stringUrl.contains(".jpg") || stringUrl.contains(".jpeg") || stringUrl.contains(".png"))
        {
            EBulletinTableView.deselectRow(at: indexPath, animated: true)
            self.pickerView.isHidden=true
            
            UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ebdetail") as! EbulletinDetailViewController
            secondViewController.isCalled = "list"
            secondViewController.urlLink=(arrayResponse.object(at: indexPath.row) as AnyObject).object(forKey: "ebulletinlink")as! String
            
            let dictTemporaryDictionary:NSDictionary = ((arrayResponse.object(at: indexPath.row) as AnyObject) as! NSDictionary)
            
            secondViewController.bulletinID = dictTemporaryDictionary.object(forKey: "ebulletinID")as! String as NSString
            secondViewController.moduleName = moduleName
            secondViewController.objprotocolForUpdateListing=self
            secondViewController.profileID = memberProfileId  as NSString
            secondViewController.SMSCountStr = SMSCountStr
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        else
        {

        if(stringUrl.contains("http"))
        {
            
        }
        else
        {
            stringUrl="http://"+stringUrl
        }
        let url = URL (string: (stringUrl)!)
        print("url to be shown \(url)")
        
        let requestObj = URLRequest(url: url!)
        //print("http://-----------------------")
        
        if let url = NSURL(string: stringUrl){
//            UIApplication.shared.openURL(url as URL)
            
            if UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL, options: [:]) { success in
                        if success {
                            print("The URL was successfully opened.")
                        } else {
                            print("Failed to open the URL.")
                        }
                    }
                }
            
        }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
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
        
        self.listTypeTextField.text=pickerDataSource[row]
        
        
        if(pickerDataSource[row]=="All"){
            self.listTypeTextField.text="All"
            self.annType="0"
        }else if(pickerDataSource[row]=="Published"){
            self.listTypeTextField.text="Published"
            
            self.annType="1"
        }else if(pickerDataSource[row]=="Scheduled"){
            self.listTypeTextField.text="Scheduled"
            self.annType="2"
        }else if(pickerDataSource[row]=="Expired"){
            self.listTypeTextField.text="Expired"
            self.annType="3"
        }else{
            self.annType="1"
        }
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
        let getSelectYearsValue:String!=self.listTypeTextField.text
        var varGetArrayValue=getSelectYearsValue.components(separatedBy: "-")
        // functionForGetDataFromServer(varGetArrayValue[0], toYear: varGetArrayValue[1]) //Code by Rajendra and comment by DPK
        self.functionForGetDataFromServer()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        varGetSearchBoxValue = (self.searchTextField.text! as NSString).replacingCharacters(in: range, with: string) as NSString as String
        let strValues = varGetSearchBoxValue.trimmingCharacters(in: CharacterSet.whitespaces)as NSString
        
        // //print(strValue)
        //print(strValues)
        //print(searchTextField.text)
        
        //        if(strValues.length != 0)
        //        {
        //            if(textField.tag==22)
        //            {
        //                listTypeTextField.resignFirstResponder()
        //                self.view .bringSubviewToFront(self.pickerView)
        //                self.pickerView.hidden=true
        //                //return false
        //            }
        //            else
        //            {
        //                //searchTextField.resignFirstResponder()
        //                self.searchAnxcvcxnouncemt()
        //                self.pickerView.hidden=true
        //            }
        //        }
        return true
    }
    //code by Rajendra jat
    //func functionForGetDataFromServer(_ fromyear:String,toYear:String)
    func functionForGetDataFromServer()
    {
        
        var getSelectYearsValue:String!=self.listTypeTextField.text
        var varGetArrayValue=getSelectYearsValue.components(separatedBy: "-")
        
        let fromYear = varGetArrayValue[0]
        let toYear = varGetArrayValue[1]
        SVProgressHUD.show()
        let completeURL =  baseUrl + touchBase_fetchNewsletterInfo
//        let parameterst: [String: AnyObject] = [
//            "memberProfileId": memberProfileId  as AnyObject,
//            "groupId":grpDetailPrevious.object(forKey: "grpId") as! String as AnyObject,
////            "fromYear":
////            var str1 = fromYear as AnyObject,
////            var str2 = toYear as AnyObject
////            "toYear":toYear as AnyObject
//            "YearFilter" : listTypeTextField.text as Any
//        ]
        
        
        var parameterst:NSDictionary=NSDictionary()
        
//            http://rotaryindiaapi.rosteronwheels.com/api//Gallery/DeleteAlbumPhoto :- [photoId=77098, albumId=23357, deletedBy=581428, Financeyear=2021-2022]
            
        parameterst =  [ "memberProfileId": memberProfileId  as AnyObject,
                        "groupId":varGetID,
                        "YearFilter" : listTypeTextField.text as Any]
        
       print("E-Bulletins completeURL :: \(completeURL)")
       print("E-Bulletins parameterst :: \(parameterst)")
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable : Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            ////print(response)
            
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                 SVProgressHUD.dismiss()
            }
            else
            {
            
            if((response.object(forKey: "TBYearWiseEbulletinList")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                self.arrayResponse=(response.object(forKey: "TBYearWiseEbulletinList")as! NSDictionary).object( forKey: "Result") as! NSArray
                self.dcitHoldingArray=(response.object(forKey: "TBYearWiseEbulletinList")as! NSDictionary).object(forKey: "Result") as! NSArray
                
                print("self.arrayResponse 1::: \(self.arrayResponse)")
                ////print(self.arrayResponse.count)
                self.EBulletinTableView.reloadData()
                SVProgressHUD.dismiss()
                
                if(self.arrayResponse.count>0)
                {
                    self.noResultLbl.text=""
                    self.noResultLbl.isHidden=true
                    self.EBulletinTableView.isHidden=false
                }
                else
                {
                    self.EBulletinTableView.reloadData()
                    self.noResultLbl.text="No Results"
                    self.noResultLbl.isHidden=false
                    //self.EBulletinTableView.isHidden=true
                }
            }
            else
            {
                self.EBulletinTableView.reloadData()
                self.noResultLbl.text="No Results"
                self.noResultLbl.isHidden=false
            }
            }
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 8.0, execute: {
//                SVProgressHUD.dismiss()
//            })
            
        })
    }
    
}


