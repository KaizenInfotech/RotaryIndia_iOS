//
//  ShowCaseAlbumListViewController.swift
//  TouchBase
//
//  Created by tt on 07/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import SDWebImage
import SVProgressHUD
//import LiquidFloatingActionButton

class ShowCaseAlbumListViewController: UIViewController,UISearchBarDelegate,UISearchControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource {
    
    var appDelegate : AppDelegate = AppDelegate()
   // let loaderClass  = WebserviceClass()
    var actionButton: ActionButton!
    var getGroupDistrictList:NSMutableArray=NSMutableArray()
    var getGroupId:String!=""
    var getCategoryIds:String!=""
    var getClubId:String!=""
    var getDistrctId:String!=""
    var getYear:String!=""
    var varIsCallFrom:String!=""
    var getModuleID:String!=""
    var GetUserProfileID:String!=""
    var GetIsAdmin:String!=""
    var GetIsCategoryFromClubOrDistrict:String!=""
    var GetModuleName:String!=""
    
      var txtsearchByProject:String!=""
    
    
    
    @IBOutlet weak var pickerViews: UIPickerView!
    
    @IBOutlet weak var buttonNoResult: UIButton!
    var varGetSearchText:String!=""
    @IBOutlet weak var searchBar: UISearchBar!
    var muarrayListData:NSArray=NSArray()
    var muarrayMainList:NSArray=NSArray()
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var buttonYes: UIButton!
    @IBOutlet weak var buttonNo: UIButton!
    @IBOutlet weak var viewForConfirmation: UIView!
    @IBOutlet weak var tableShowCaseList: UITableView!
    
    
    @IBOutlet weak var btnSelectYearPickerOpn: UIButton!
    @IBOutlet weak var viewForTextFieldYear: UIView!
    @IBOutlet weak var textfieldYear: UITextField!
    var ifanyChanges:String! = ""
    
    var yearFrom:String! = ""
    var year : Int! = 0
    
    var pickerDataSource :[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textfieldYear.textFieldFullBorder()
        
        let date = Foundation.Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        year =  components.year
        let month = components.month
        let day = components.day
        print(year , month ,day )
        if(month!>=7)
        {
            year = year+1
        }
        else
        {
        }
        yearFrom = String(year)
        print(yearFrom)
        textfieldYear.text! = String(year-1) + "-" + yearFrom //yearFrom+"-"+String(year+1)
        functionForYears()
        
        
        if(varIsCallFrom=="ShowCaseFromDashBoard")
        {
        }
        else
        {
            self.getYear = textfieldYear.text!
        }
        
        
        if(varIsCallFrom=="ShowCaseFromDashBoard")
        {
            print("From Show case  floating button Not Show")
        }
            //        else if(self.GetIsCategoryFromClubOrDistrict=="2")
            //        {
            //            print("From District floating button Not Show")
            //        }
            //        else if(self.GetIsCategoryFromClubOrDistrict=="1" && GetIsAdmin=="Yes")
            //        {
        else if(GetIsAdmin=="Yes")
        {
            print("From Club floating button Show")
            self.functiuonFloatingButton()
        }
        else
        {
            print("111111111111111111111111")
        }
//        self.edgesForExtendedLayout=[]
        buttonNoResult.isHidden=true
        self.buttonNoResult.setTitle("",  for: UIControl.State.normal)
        createNavigationBar()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        searchBar.delegate=self

        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            functionForFetchingAlbumListData()
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
          SVProgressHUD.dismiss()
        }
        self.pickerViews.dataSource = self;
        self.pickerViews.delegate = self;
        self.pickerViews.isHidden=true
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
       
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
            print(i)
            let letSetYear = String(i)+"-"+String(Int(i+1))
            print(letSetYear)
            pickerDataSource.append(letSetYear)
        }
        self.pickerViews.selectRow(pickerDataSource.count-1, inComponent: 0, animated: false)
        //self.pickerViews.selectRow(pickerDataSourceNonAdmin.count-1, inComponent: 0, animated: false)
        self.pickerViews.reloadAllComponents()
    }
    
    
    //MARK:- Navigation bar setting
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = GetModuleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white// (red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor=UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        
        buttonleft.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ShowCaseAlbumListViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSelectYearClickEvent(_ sender: AnyObject) {
        self.pickerViews.isHidden=false
    }
    @IBAction func buttonYESClickEvent(_ sender: AnyObject) {
    }
    @IBAction func buttonNOClickEvent(_ sender: AnyObject) {
    }
    @IBAction func buttonOpticityClickEvent(_ sender: AnyObject) {
    }
    //MARK:- Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        //appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            varGetSearchText = searchBar.text!
            print(varGetSearchText)
            if(searchText.characters.count>0)
            {
                
                if(varIsCallFrom=="ShowCaseFromDashBoard")
                {
                    let predicate =  NSPredicate(format: "title contains[c] %@ OR clubname contains[c] %@", varGetSearchText,varGetSearchText)
                    let searchDataSource = muarrayMainList.filtered(using: predicate)
                    muarrayListData=searchDataSource as NSArray
                    print(muarrayListData)
                    self.tableShowCaseList.reloadData()
                }
                else
                {
                    let predicate =  NSPredicate(format: "title contains[c] %@ OR description contains[c] %@", varGetSearchText,varGetSearchText)
                    let searchDataSource = muarrayMainList.filtered(using: predicate)
                    muarrayListData=searchDataSource as NSArray
                    print(muarrayListData)
                    self.tableShowCaseList.reloadData()
                }
            }
            else
            {
                muarrayListData=NSArray()
                self.muarrayListData = self.muarrayMainList
                self.tableShowCaseList.reloadData()
                searchBar.resignFirstResponder()
            }
            
            
            
            if(muarrayListData.count>0)
            {
                self.buttonNoResult.isHidden=true
                self.buttonNoResult.setTitle("",  for: UIControl.State.normal)
            }
            else
            {
                self.buttonNoResult.isHidden=false
                self.buttonNoResult.setTitle("No albums found",  for: UIControl.State.normal)
            }
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
             SVProgressHUD.dismiss()
            searchBar.resignFirstResponder()
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton=true
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            print("use predicate 3 here")
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
             SVProgressHUD.dismiss()
            searchBar.resignFirstResponder()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        print("searchText \(searchBar.text!)")
        varGetSearchText = searchBar.text!
        print("use predicate 2 here")
        searchBar.resignFirstResponder()
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            if(varGetSearchText.characters.count>0)
            {
                let predicate =  NSPredicate(format: "title contains[c] %@ OR clubname contains[c] %@", varGetSearchText,varGetSearchText)
                let searchDataSource = muarrayMainList.filtered(using: predicate)
                muarrayListData=searchDataSource as NSArray
                print(muarrayListData)
                self.tableShowCaseList.reloadData()
            }
            else
            {
                muarrayListData=NSArray()
                self.muarrayListData = self.muarrayMainList
                self.tableShowCaseList.reloadData()
            }
            
            if(muarrayListData.count>0)
            {
                self.buttonNoResult.isHidden=true
                self.buttonNoResult.setTitle("",  for: UIControl.State.normal)
            }
            else
            {
                self.buttonNoResult.isHidden=false
                self.buttonNoResult.setTitle("No albums found",  for: UIControl.State.normal)
            }
            
            
            
            
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            SVProgressHUD.dismiss()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            muarrayListData=NSArray()
            self.muarrayListData = self.muarrayMainList
            self.tableShowCaseList.reloadData()
            searchBar.resignFirstResponder()
            if(muarrayListData.count>0)
            {
                self.buttonNoResult.isHidden=true
                self.buttonNoResult.setTitle("",  for: UIControl.State.normal)
            }
            else
            {
                self.buttonNoResult.isHidden=false
                self.buttonNoResult.setTitle("No albums found",  for: UIControl.State.normal)
            }
            
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
             SVProgressHUD.dismiss()
            searchBar.resignFirstResponder()
        }
    }
    //MARK:- Tableview Delegate As List
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayListData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableShowCaseList.dequeueReusableCell(withIdentifier: "ShowCaseAlbumListTableViewCell", for: indexPath) as! ShowCaseAlbumListTableViewCell
        if(muarrayListData.count>0)
        {
            if(varIsCallFrom=="ShowCaseFromDashBoard")
            {
                cell.labelTitle.text! = (muarrayListData.value(forKey: "clubname") as AnyObject).object(at: indexPath.row) as! String
                cell.textviewDescription.text! =  (muarrayListData.value(forKey: "title") as AnyObject).object(at: indexPath.row) as! String
            }
            else
            {
                cell.labelTitle.text! = (muarrayListData.value(forKey: "title") as AnyObject).object(at: indexPath.row) as! String
                cell.textviewDescription.text! =  (muarrayListData.value(forKey: "description") as AnyObject).object(at: indexPath.row) as! String
                
            }
            
             let varGetAlbumDate = (muarrayListData.value(forKey: "project_date") as AnyObject).object(at: indexPath.row) as! String
             
             let dF:DateFormatter=DateFormatter()
             dF.dateFormat="YYYY-MM-dd HH:mm:ss"
            // print("Project date is \(varGetAlbumDate)")
             if let pDate = dF.date(from: varGetAlbumDate)
             {
                 let dff:DateFormatter=DateFormatter()
                 dff.dateFormat="dd-MMM-YYYY"
               if let pDates=dff.string(from: pDate) as? String
               {
                 print("Formatted project date in showcase is \(pDates)")
                 cell.labelDate.text=pDates
               }
               else
               {
                 cell.labelDate.text=""
               }
             }
             else
             {
               cell.labelDate.text=""
             }

            
            
            let varImage = (muarrayListData.value(forKey: "image") as AnyObject).object(at: indexPath.row) as! String
            if varImage == ""
            {
                cell.imageAlbum.image = UIImage(named: "logo")
            }
            else
            {
                // /*------------------------------Code by --------------------DPK--------------------------- */
                let ImageProfilePic:String = varImage.replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                cell.imageAlbum.sd_setImage(with: checkedUrl)
            }
            cell.buttonDelete.isHidden=false
            cell.buttonDelete.addTarget(self, action: #selector(ShowCaseAlbumListViewController.buttonDetailClickEvent(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonDelete.tag = indexPath.row
        }
        return cell
    }
    //details album
    @objc func buttonDetailClickEvent(_ sender:UIButton)
    {
        print(sender.tag)
        
        let NumberOfRotarian =      (muarrayListData.value(forKey: "NumberOfRotarian") as AnyObject).object(at: sender.tag) as! String
        let albumId      =          (muarrayListData.value(forKey: "albumId") as AnyObject).object(at: sender.tag) as! String
        let beneficiary  =          (muarrayListData.value(forKey: "beneficiary") as AnyObject).object(at: sender.tag) as! String
        let clubname =              (muarrayListData.value(forKey: "clubname") as AnyObject).object(at: sender.tag) as! String
        let cost_of_project_type =  (muarrayListData.value(forKey: "cost_of_project_type") as AnyObject).object(at: sender.tag) as! String
        let description  =          (muarrayListData.value(forKey: "description") as AnyObject).object(at: sender.tag) as! String
        let groupId      =          (muarrayListData.value(forKey: "groupId") as AnyObject).object(at: sender.tag) as! String
        let image =                 (muarrayListData.value(forKey: "image") as AnyObject).object(at: sender.tag) as! String
        //let isAdmin =             muarrayListData.valueForKey("isAdmin").objectAtIndex(sender.tag) as? String
        let moduleId =              (muarrayListData.value(forKey: "moduleId") as AnyObject).object(at: sender.tag) as! String
        let project_cost =          (muarrayListData.value(forKey: "project_cost") as AnyObject).object(at: sender.tag) as! String
        let project_date =           (muarrayListData.value(forKey: "project_date") as AnyObject).object(at: sender.tag) as! String
        let title        =           (muarrayListData.value(forKey: "title") as AnyObject).object(at: sender.tag) as! String
        let type      =              (muarrayListData.value(forKey: "type") as AnyObject).object(at: sender.tag) as! String
        let working_hour =          (muarrayListData.value(forKey: "working_hour") as AnyObject).object(at: sender.tag) as! String
        let working_hour_type =     (muarrayListData.value(forKey: "working_hour_type") as AnyObject).object(at: sender.tag) as! String
        let sharetype =     (muarrayListData.value(forKey: "sharetype") as AnyObject).object(at: sender.tag) as! String
        
        
        // let obj = storyboard?.instantiateViewControllerWithIdentifier("ShowCaseAlbumPhtotosShowViewController") as! ShowCaseAlbumPhtotosShowViewController
        let obj = storyboard?.instantiateViewController(withIdentifier: "NewShowCasePhotoDetailsViewController") as! NewShowCasePhotoDetailsViewController
        obj.GetShareType=sharetype
        obj.GetGroupID=groupId
        obj.Getdescription=description
        obj.Getbeneficiary=beneficiary
        obj.Getproject_cost=project_cost
        obj.Getproject_date=project_date
        obj.Gettitle=title
        obj.GetManHours=working_hour
        obj.GetAlbumID=albumId
        obj.recipientType=type
        obj.Getworking_hour_type=working_hour_type
        obj.Getcost_of_project_type=cost_of_project_type
        obj.GetNumberOfRotarian=NumberOfRotarian
        obj.GetClubName=clubname
        obj.GetIsAdmin=self.GetIsAdmin
        obj.GetImageUrl = image
        obj.GetModuleID = self.getModuleID
        obj.GetUserProfileID=self.GetUserProfileID
        obj.GetIsCategoryFromClubOrDistrict=self.GetIsCategoryFromClubOrDistrict
        obj.getGroupDistrictList=self.getGroupDistrictList
        
        
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            self.navigationController?.pushViewController(obj, animated: true)
            
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
           SVProgressHUD.dismiss()
        }
    }
    //MARK:- Server api calling
    func functionForFetchingAlbumListData()
    {
      //  loaderClass.loaderViewMethod()
        let completeURL = baseUrl+"Gallery/GetAlbumsList_New"
        var parameterst:NSDictionary=NSDictionary()
        if(self.varIsCallFrom=="ShowCaseFromDashBoard")
        {
            parameterst = [
                "groupId":"0",
                "district_id":self.getDistrctId,
                "club_id":self.getClubId,
                "category_id":self.getCategoryIds,
                "year":self.getYear,
                "SharType":"0",
                "profileId":"",
                "moduleId":"",
                "searchText":txtsearchByProject
            ]
        }
        else
        {
            parameterst =  ["groupId":self.getGroupId,
                            "district_id":"",
                            "club_id":"",
                            "category_id":GetIsCategoryFromClubOrDistrict,
                            "year":self.getYear,
                            "SharType":"1",
                            "profileId":self.GetUserProfileID,
                            "moduleId":self.getModuleID ]
        }
        
        print(parameterst)
        print(completeURL)
        SVProgressHUD.show()
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("dd \(dd)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            if((dd.object(forKey: "TBAlbumsListResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let arrarrNewGroupList = (((dd.object(forKey: "TBAlbumsListResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "newAlbums")) as! NSArray
                print(arrarrNewGroupList)
                self.muarrayMainList = arrarrNewGroupList
                self.muarrayListData = arrarrNewGroupList
                if(self.muarrayMainList.count>0)
                {
                    self.buttonNoResult.isHidden=true
                    self.buttonNoResult.setTitle("",  for: UIControl.State.normal)
                }
                else
                {
                    self.buttonNoResult.isHidden=false
                    self.buttonNoResult.setTitle("No albums found",  for: UIControl.State.normal)
                }
                self.tableShowCaseList.reloadData()
                
              //  self.loaderClass.window = nil
            }
            else
            {
               // self.loaderClass.window = nil
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
               SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
            }
           // self.loaderClass.window = nil
        })
    }
    //--Floating button isAdmin
    func functiuonFloatingButton()
    {
        let addAlbum = UIImage(named: "Album_add_blue.png")!
        let deleteAlbum = UIImage(named: "Album_delete_blue.png")!
        let phonebook = ActionButtonItem(title: "Add Activity", image: addAlbum)
        phonebook.action =
            {
                item in print("Twitter...")
                let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotoViewController") as! AddPhotoViewController
                albumControllerObject.grpID = self.getGroupId
                albumControllerObject.createdByORUserIdOrProfileId = self.GetUserProfileID
                albumControllerObject.stringModuleId=self.getModuleID
                albumControllerObject.isCalledFRom = "add"
                albumControllerObject.isCategory=self.GetIsCategoryFromClubOrDistrict
                
                if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                    
                    self.navigationController?.pushViewController(albumControllerObject, animated: true)
                    
                }
                else
                {
                    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                    
                SVProgressHUD.dismiss()
                
                }
        }
        let invitation = ActionButtonItem(title: "Delete album", image: deleteAlbum)
        invitation.action =
            {
                item in print("Google Plus...")
                let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "DeleteCreatedAlbumViewController") as! DeleteCreatedAlbumViewController
                albumControllerObject.grpID = self.getGroupId
                albumControllerObject.userID = self.GetUserProfileID
                albumControllerObject.stringModuleId = self.getModuleID
                albumControllerObject.Year=self.textfieldYear.text!
                albumControllerObject.categoryID = self.getCategoryIds
                
                if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                    
                    if(self.muarrayMainList.count>0)
                    {
                        
                        self.navigationController?.pushViewController(albumControllerObject, animated: true)
                    }
                    else
                    {
                        self.view.makeToast("Please first add album.", duration: 2, position: CSToastPositionCenter)
                        print("First Add Album")
                    }
                }
                else
                {
                    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                   SVProgressHUD.dismiss()
                }
                
                
        }
        
        actionButton = ActionButton(attachedToView: self.view, items: [invitation,phonebook])
        actionButton.action = { button in button.toggleMenu() }
        actionButton.setTitle("+", forState: UIControl.State.normal)
        actionButton.backgroundColor = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha:1.0)
        
    }
    
    
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        print(pickerDataSource[row] )
        self.textfieldYear.text = pickerDataSource[row]
        self.pickerViews.isHidden=true
        self.getYear = self.textfieldYear.text!
        functionForFetchingAlbumListData()
    }
    
    
    
    
    
    
}

