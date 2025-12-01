






import UIKit
import SDWebImage
import Alamofire
import SVProgressHUD
//import LiquidFloatingActionButton
class ShowCaseAlbumListVCForDistrictViewController: UIViewController,UISearchBarDelegate,UISearchControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate{
    
    /*---handling action by rajendra jat 5 apr for data manage start*/
    func functionForShowCaseAlbumListCallingApi(stringFromWhereITCalling:String)
    {
        print("This is comiong from screen 5 ")
        print(stringFromWhereITCalling)
        
        self.navigationItem.titleView = nil
        createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            functionForFetchingAlbumListData()
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
        self.view.backgroundColor=UIColor.white
    }
    /*---handling action by rajendra jat 5 apr for data manage end*/
    override func viewWillAppear(_ animated: Bool)
    {
        
    }
    
    
    
    var varGetAlbumIDForDelete:String!=""
    var appDelegate : AppDelegate = AppDelegate()
    //  let loaderClass  = WebserviceClass()
    var actionButton: ActionButton!
    var getGroupDistrictList:NSMutableArray=NSMutableArray()
    var getGroupId:String!=""
    var getCategoryIds:String!=""
    var getClubId:String!=""
    var getDistrctId:String?
    var getYear:String!=""
    var varIsCallFrom:String!=""
    var getModuleID:String!=""
    var GetUserProfileID:String!=""
    var GetIsAdmin:String!=""
    var GetIsCategoryFromClubOrDistrict:String?
    var GetModuleName:String!=""
    var ChekDel:String?
    var strClubeorRot:String?
    var strNab:String = ""
    var varGetAlbumID:String!=nil
    var galleryID:String?
    @IBOutlet weak var pickerViews: UIPickerView!
    var ClubeRotaryType:String?
    
    @IBOutlet weak var pikerClubeView: UIPickerView!
    @IBOutlet weak var buttonNoResult: UIButton!
    var varGetSearchText:String!=""
    // @IBOutlet weak var searchBar: UISearchBar!
    var muarrayListData:NSArray=NSArray()
    var muarrayMainList:NSArray=NSArray()
    var tempValue:NSMutableArray = []
    var tempName:NSMutableArray = []
    var TempArray:NSMutableArray = []
    var TempArrayName:NSMutableArray = []
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var buttonYes: UIButton!
    @IBOutlet weak var buttonNo: UIButton!
    @IBOutlet weak var viewForConfirmation: UIView!
    @IBOutlet weak var tableShowCaseList: UITableView!
    
    let searchBar = UISearchBar()
    @IBOutlet weak var txtClube: UITextField!
    @IBOutlet weak var btnSelectYearPickerOpn: UIButton!
    @IBOutlet weak var viewForTextFieldYear: UIView!
    @IBOutlet weak var textfieldYear: UITextField!
    var ifanyChanges:String! = ""
    var ChekPicker:String?
    var yearFrom:String! = ""
    var year : Int! = 0
    
    var pickerDataSource :[String] = []
    
    var pickerClubeDataSource :[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("This is if Activity is being deleted !!!!")
        print(strClubeorRot)
        
        SVProgressHUD.show()
        // appDelegate = UIApplication.shared.delegate as! AppDelegate
        //        tableShowCaseList.rowHeight = 95
        //        tableShowCaseList.estimatedRowHeight = UITableView.automaticDimension
        
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.barTintColor = UIColor.blue
        
        ClubeRotaryType = "0"
        self.pickerViews.dataSource = self;
        self.pickerViews.delegate = self;
        // self.pickerViews.alpha=0.0
        
        self.pikerClubeView.dataSource = self;
        self.pikerClubeView.delegate = self;
        //  self.pikerClubeView.alpha=0.0
        viewForConfirmation.isHidden = true
        
        buttonOpticity.alpha = 0.0
        
        textfieldYear.textFieldFullBorder()
        txtClube.textFieldFullBorder()
        
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
        //   textfieldYear.text! = String(year-1) + "-" + yearFrom //yearFrom+"-"+String(year+1)
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
        
        // searchBar.delegate=self
        if(self.GetIsCategoryFromClubOrDistrict=="2"){
            
            // txtClube.text = "District Event"
            if(strClubeorRot == "District Project"){
                txtClube.text = "District Project"
            }else{
                txtClube.text = "District Event"
            }
            // District Project
            
        }
        else{
            
            if(strClubeorRot == "Rotary Service"){
                txtClube.text = "Rotary Service"
            }else{
                txtClube.text = "Club Service"
            }
            
        }
//        self.edgesForExtendedLayout=[]
        
        //viewwillappear
        self.navigationItem.titleView = nil
        createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            functionForFetchingAlbumListData()
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
        self.view.backgroundColor=UIColor.white
    }
    
    
    
    
    
    //MARK:- Function Year
    func functionForYears()
    {
        pickerClubeDataSource=[]
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
        
        pickerDataSource.reverse()
        self.pickerViews.selectRow(pickerDataSource.count-1, inComponent: 0, animated: false)
        //self.pickerViews.selectRow(pickerDataSourceNonAdmin.count-1, inComponent: 0, animated: false)
        //  self.pickerViews.reloadAllComponents()
        if(self.GetIsCategoryFromClubOrDistrict=="2"){
            
            pickerClubeDataSource.append("District Project")
            pickerClubeDataSource.append("District Event")
            
            
        }else{
            pickerClubeDataSource.append("Rotary Service")
            pickerClubeDataSource.append("Club Service")
            
        }
        textfieldYear.text = pickerDataSource[0]
        self.pikerClubeView.selectRow(pickerClubeDataSource.count-1, inComponent: 0, animated: false)
        //self.pickerViews.selectRow(pickerDataSourceNonAdmin.count-1, inComponent: 0, animated: false)
        // self.pikerClubeView.reloadAllComponents()
        
    }
    
    
    //MARK:- Navigation bar setting
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        if(self.GetIsCategoryFromClubOrDistrict=="2"){
            self.title = "Gallery"
        }else{
            self.title = "Activities"
        }
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        //  self.navigationController?.navigationBar.barTintColor=UIColor.white// (red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor=UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        
        buttonleft.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ShowCaseAlbumListViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let buttonRight = UIButton(type: UIButton.ButtonType.custom)
        buttonRight.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        buttonRight.setImage(UIImage(named:"searchNew"),  for: UIControl.State.normal)
        buttonRight.addTarget(self, action: #selector(ShowCaseAlbumListVC.SearchClickedAction), for: UIControl.Event.touchUpInside)
        let RightButton: UIBarButtonItem = UIBarButtonItem(customView: buttonRight)
        self.navigationItem.rightBarButtonItem = RightButton
    }
    
     @objc func backClicked()
    {
        self.pickerViews.isHidden=true
        self.navigationController?.popViewController(animated: true)
        
        //            if(self.GetIsCategoryFromClubOrDistrict=="2"){
        //
        //            }
        //            else{
        //
        //                let objMaindesh = self.storyboard?.instantiateViewController(withIdentifier: "mainDash") as! MainDashboardViewController
        //                self.navigationController?.pudshViewController(objMaindesh, animated: true)
        //            }
        
    }
    
    func SearchClickedAction(){
        
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = nil
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.setShowsCancelButton(true, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSelectYearClickEvent(_ sender: AnyObject) {
        ChekPicker = "Year"
        pickerViews.isHidden = false
        pickerViews.alpha=1.0
        pikerClubeView.alpha = 0.0
        //  self.view.bringSubview(toFront: buttonOpticity)
        buttonOpticity.bringSubviewToFront( pickerViews)
        pickerViews.reloadAllComponents()
        
    }
    
    @IBAction func SelectClubeAction(_ sender: Any) {
        
        ChekPicker = " "
        pikerClubeView.isHidden = false
        pickerViews.alpha = 0.0
        pikerClubeView.alpha = 1.0
        
        buttonOpticity.bringSubviewToFront( pikerClubeView)
        pikerClubeView.reloadAllComponents()
    }
    
    @IBAction func buttonYESClickEvent(_ sender: AnyObject) {
        buttonOpticity.alpha = 0.0
        viewForConfirmation.isHidden = true
        functionForDeleteAlbum()
    }
    
    @IBAction func buttonNOClickEvent(_ sender: AnyObject) {
        buttonOpticity.alpha = 0.0
        viewForConfirmation.isHidden = true
    }
    
    @IBAction func buttonOpticityClickEvent(_ sender: AnyObject) {
    }
    
    //MARK:- Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        //appDelegate = UIApplication.shared.delegate as! AppDelegate
        searchBar.setShowsCancelButton(true, animated: true)
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
                self.tableShowCaseList.isHidden=false
            }
            else
            {
                self.buttonNoResult.isHidden=false
                self.buttonNoResult.setTitle("No albums found",  for: UIControl.State.normal)
                self.tableShowCaseList.isHidden=true
            }
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            
            searchBar.resignFirstResponder()
            self.navigationItem.titleView = nil
            createNavigationBar()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.setShowsCancelButton(true, animated: true)
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            print("use predicate 3 here")
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            
            searchBar.resignFirstResponder()
            self.navigationItem.titleView = nil
            createNavigationBar()
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
                self.tableShowCaseList.isHidden=false
            }
            else
            {
                self.buttonNoResult.isHidden=false
                self.buttonNoResult.setTitle("No albums found",  for: UIControl.State.normal)
                self.tableShowCaseList.isHidden=true
            }
            
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            
        }
        //   self.navigationItem.titleView = nil
        //  createNavigationBar()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.text = ""
        self.navigationItem.titleView = nil
        createNavigationBar()
        functionForFetchingAlbumListData()
        
    }
    //MARK:- Tableview Delegate As List
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableShowCaseList.dequeueReusableCell(withIdentifier: "ShowCaseAlbumListTVC", for: indexPath) as! ShowCaseAlbumListTVC
        if(muarrayListData.count>0)
        {
            SVProgressHUD.dismiss()
            print((muarrayListData.value(forKey: "title") as AnyObject).object(at: indexPath.row) as! String)
            cell.labelTitle.text! = (muarrayListData.value(forKey: "title") as AnyObject).object(at: indexPath.row) as! String
            cell.lblDetails.text! =  (muarrayListData.value(forKey: "description") as AnyObject).object(at: indexPath.row) as! String
            
            let strDate = convertToShowFormatDate(dateString: ((muarrayListData.value(forKey: "project_date") as AnyObject).object(at: indexPath.row) as! String))
            cell.lblDate.text = strDate
            
            if(ChekDel == "yes"){
                
                cell.btnDelete.isHidden = false
                cell.btnDelete.tag = indexPath.row
                cell.btnDelete.addTarget(self, action: #selector(ShowCaseAlbumListVC.DeleteAction(_:)), for: .touchUpInside)
                
            }
            else
            {
                cell.btnDelete.isHidden  = true
            }
            cell.selectionStyle = .none
            
        }
        return cell
    }
    
    /// To Show the Date in String format
    func convertToShowFormatDate(dateString: String) -> String {
        
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        
        let serverDate: Date = dateFormatterDate.date(from: dateString)! //according to date format your date string
        
        let dateFormatterString = DateFormatter()
        dateFormatterString.dateFormat = "dd MMM yyyy" //Your New Date format as per requirement change it own
        let newDate: String = dateFormatterString.string(from: serverDate) //pass Date here
        print(newDate) // New formatted Date string
        
        return newDate
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(self.GetIsCategoryFromClubOrDistrict=="2"){
            print("District datassssssss--------------",muarrayListData)
            
            tempValue = NSMutableArray()
            tempName = NSMutableArray()
            TempArray = NSMutableArray()
            TempArrayName = NSMutableArray()
            
            let NumberOfRotarian =      (muarrayListData.value(forKey: "NumberOfRotarian") as AnyObject).object(at: indexPath.row) as! String
            let albumId      =          (muarrayListData.value(forKey: "albumId") as AnyObject).object(at: indexPath.row) as! String
            let beneficiary  =          (muarrayListData.value(forKey: "beneficiary") as AnyObject).object(at: indexPath.row) as! String
            let clubname =              (muarrayListData.value(forKey: "clubname") as AnyObject).object(at: indexPath.row) as! String
            let cost_of_project_type =  (muarrayListData.value(forKey: "cost_of_project_type") as AnyObject).object(at: indexPath.row) as! String
            let description  =          (muarrayListData.value(forKey: "description") as AnyObject).object(at: indexPath.row) as! String
            let groupId      =          (muarrayListData.value(forKey: "groupId") as AnyObject).object(at: indexPath.row) as! String
            let image =                 (muarrayListData.value(forKey: "image") as AnyObject).object(at: indexPath.row) as! String
            //let isAdmin =             muarrayListData.valueForKey("isAdmin").objectAtIndex(sender.tag) as? String
            let moduleId =              ((muarrayListData.value(forKey: "moduleId") as AnyObject).object(at: indexPath.row) as! String)
            let project_cost =          (muarrayListData.value(forKey: "project_cost") as AnyObject).object(at: indexPath.row) as! String
            let project_date =           (muarrayListData.value(forKey: "project_date") as AnyObject).object(at: indexPath.row) as! String
            let title        =           (muarrayListData.value(forKey: "title") as AnyObject).object(at: indexPath.row) as! String
            let type      =              (muarrayListData.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! String
            let working_hour =          (muarrayListData.value(forKey: "working_hour") as AnyObject).object(at: indexPath.row) as! String
            let working_hour_type =     (muarrayListData.value(forKey: "working_hour_type") as AnyObject).object(at: indexPath.row) as! String
            let sharetype =             (muarrayListData.value(forKey: "sharetype") as AnyObject).object(at: indexPath.row) as! String
            
            getModuleID = moduleId
            getGroupId = groupId
            varGetAlbumID  = albumId
            print(albumId)
            print(varGetAlbumID)
            print(working_hour)
            
            if(txtClube.text == "District Event"){
                
                strNab = title
                tempValue.add(project_date)
                tempValue.add(type)
                tempName.add("Date")
                
                print(tempValue)
            }
            else {
                
                strNab = title
                tempName.add("Date")
                tempName.add("Cost")
                tempName.add("Beneficiaries")
                tempName.add("Man hours")
                tempName.add("Rotarians")
                
                tempValue.add(project_date)
                tempValue.add(" ₹" + project_cost)
                tempValue.add(beneficiary)
                tempValue.add(working_hour + "Hours")
                tempValue.add(NumberOfRotarian)
                
                print(tempValue)
            }
            
            //        pickerClubeDataSource.append("Club Service")
            //        pickerClubeDataSource.append("Rotary Service")
            
            self.pickerViews.isHidden=true
            
            print(tempValue)
            // let obj = storyboard?.instantiateViewControllerWithIdentifier("ShowCaseAlbumPhtotosShowViewController") as! ShowCaseAlbumPhtotosShowViewController
            let obj = storyboard?.instantiateViewController(withIdentifier: "NewShowCasePhotoDetailsVC") as! NewShowCasePhotoDetailsVC
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
            obj.strNavi = strNab
            obj.muaaryHoriZontal = tempValue
            obj.muaaryHoriZontalName = tempName
            obj.muarrayAgendaorMetting = TempArray
            obj.muarrayAgendaorMettingName = TempArrayName
            obj.strdistorClube = "District"
            obj.checkString = txtClube.text
            //code by rajendra jat 7 dec 1.05pm
            //obj.checkString = "Club Service"
            //Club Service
            print(txtClube.text)
            
            
            var varGetValue:String!=txtClube.text as! String
            if(varGetValue=="District Event")
            {
                obj.checkString = "Club Service"
            }
            else  if(varGetValue=="District Project")
            {
                obj.checkString = "Rotary Service"
            }
            print("this is my variable for check string ")
            
            
            
            
            obj.strWhichType = txtClube.text
            obj.strNavi = strNab
            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                
                self.navigationController?.pushViewController(obj, animated: true)
                
            }
            else
            {
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                
            }
            
        }
        else{
            print(muarrayListData)
            tempValue = NSMutableArray()
            tempName = NSMutableArray()
            TempArray = NSMutableArray()
            TempArrayName = NSMutableArray()
            
            let NumberOfRotarian =      (muarrayListData.value(forKey: "NumberOfRotarian") as AnyObject).object(at: indexPath.row) as! String
            let albumId      =          (muarrayListData.value(forKey: "albumId") as AnyObject).object(at: indexPath.row) as! String
            let beneficiary  =          (muarrayListData.value(forKey: "beneficiary") as AnyObject).object(at: indexPath.row) as! String
            let clubname =              (muarrayListData.value(forKey: "clubname") as AnyObject).object(at: indexPath.row) as! String
            let cost_of_project_type =  (muarrayListData.value(forKey: "cost_of_project_type") as AnyObject).object(at: indexPath.row) as! String
            let description  =          (muarrayListData.value(forKey: "description") as AnyObject).object(at: indexPath.row) as! String
            let groupId      =          (muarrayListData.value(forKey: "groupId") as AnyObject).object(at: indexPath.row) as! String
            let image =                 (muarrayListData.value(forKey: "image") as AnyObject).object(at: indexPath.row) as! String
            //let isAdmin =             muarrayListData.valueForKey("isAdmin").objectAtIndex(sender.tag) as? String
            let moduleId =              ((muarrayListData.value(forKey: "moduleId") as AnyObject).object(at: indexPath.row) as! String)
            let project_cost =          (muarrayListData.value(forKey: "project_cost") as AnyObject).object(at: indexPath.row) as! String
            let project_date =           (muarrayListData.value(forKey: "project_date") as AnyObject).object(at: indexPath.row) as! String
            let title        =           (muarrayListData.value(forKey: "title") as AnyObject).object(at: indexPath.row) as! String
            let type      =              (muarrayListData.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! String
            let working_hour =          (muarrayListData.value(forKey: "working_hour") as AnyObject).object(at: indexPath.row) as! String
            let working_hour_type =     (muarrayListData.value(forKey: "working_hour_type") as AnyObject).object(at: indexPath.row) as! String
            let sharetype =             (muarrayListData.value(forKey: "sharetype") as AnyObject).object(at: indexPath.row) as! String
            let Attendance =            (muarrayListData.value(forKey: "Attendance") as AnyObject).object(at: indexPath.row) as? String
            let AttendancePer =         (muarrayListData.value(forKey: "AttendancePer") as AnyObject).object(at: indexPath.row) as? String
            let AgendaAttachement =     (muarrayListData.value(forKey: "AgendaDocID") as AnyObject).object(at: indexPath.row) as? String
            let MOMAttachement =        (muarrayListData.value(forKey: "MOMDocID") as AnyObject).object(at: indexPath.row) as?String
            
            getModuleID = moduleId
            getGroupId = groupId
            varGetAlbumID  = albumId
            print(albumId)
            print(varGetAlbumID)
            print(working_hour)
            print(AgendaAttachement)
            print(MOMAttachement)
            if(txtClube.text == "Club Service"){
                strNab = "Club Service"
                
                if(AgendaAttachement == ""){
                    
                }
                else{
                    TempArrayName.add("Agenda")
                    TempArray.add(AgendaAttachement)
                }
                if(MOMAttachement == ""){
                    
                }
                else{
                    TempArrayName.add("Minutes of Meeting")
                    TempArray.add(MOMAttachement)
                }
                
                tempValue.add(project_date)
                tempValue.add(Attendance)
                tempValue.add(AttendancePer)
                tempValue.add(type)
                
                tempName.add("Date")
                tempName.add("Attendance")
                tempName.add("Attendance(%)")
                tempName.add("Metting Type")
                
                print(tempValue)
            }
            else {
                
                strNab = "Rotary Service"
                tempName.add("Date")
                tempName.add("Cost")
                tempName.add("Beneficiaries")
                tempName.add("Man hours")
                tempName.add("Rotarians")
                
                tempValue.add(project_date)
                tempValue.add(project_cost)
                tempValue.add(beneficiary)
                tempValue.add(working_hour)
                tempValue.add(NumberOfRotarian)
                
                print(tempValue)
            }
            
            //        pickerClubeDataSource.append("Club Service")
            //        pickerClubeDataSource.append("Rotary Service")
            
            print(tempValue)
            // let obj = storyboard?.instantiateViewControllerWithIdentifier("ShowCaseAlbumPhtotosShowViewController") as! ShowCaseAlbumPhtotosShowViewController
            let obj = storyboard?.instantiateViewController(withIdentifier: "NewShowCasePhotoDetailsVC") as! NewShowCasePhotoDetailsVC
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
            obj.strNavi = strNab
            obj.strWhichType = self.txtClube.text
            
            
            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                
                self.navigationController?.pushViewController(obj, animated: true)
                
            }
            else
            {
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                
            }
        }
    }
    
    func DeleteAction(_ sender:UIButton)
    {
        
        if(self.GetIsCategoryFromClubOrDistrict=="2"){
            let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this album", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
                print("The user is okay.")
                self.buttonOpticity.alpha = 1.0
                self.viewForConfirmation.isHidden = true
                let row = sender.tag
                print("Row: \(row)")
                print(self.muarrayListData)
                //let dict:NSDictionary = (muarrayListData.object(at: row) as! NSDictionary)
                self.varGetAlbumID=(self.muarrayListData.value(forKey: "type") as AnyObject).object(at: sender.tag) as! String
                self.varGetAlbumIDForDelete = (self.muarrayListData.value(forKey: "albumId") as AnyObject).object(at: sender.tag) as! String
                print(self.varGetAlbumID)
                print(self.varGetAlbumIDForDelete)
                self.buttonOpticity.alpha = 0.0
                self.viewForConfirmation.isHidden = true
                self.functionForDeleteAlbum()
            }
            
            let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
                print("The user is not okay.")
            }
            
            // Add Actions
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            
            // Present Alert Controller
            self.present(alertController, animated: true, completion: nil)
            
        }
        else{
            let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this Activity", preferredStyle: .alert)
            
            // Initialize Actions
            let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
                print("The user is okay.")
                self.buttonOpticity.alpha = 1.0
                self.viewForConfirmation.isHidden = true
                let row = sender.tag
                print("Row: \(row)")
                print(self.muarrayListData)
                //let dict:NSDictionary = (muarrayListData.object(at: row) as! NSDictionary)
                self.varGetAlbumID=(self.muarrayListData.value(forKey: "type") as AnyObject).object(at: sender.tag) as! String
                self.varGetAlbumIDForDelete = (self.muarrayListData.value(forKey: "albumId") as AnyObject).object(at: sender.tag) as! String
                print(self.varGetAlbumID)
                print(self.varGetAlbumIDForDelete)
                self.buttonOpticity.alpha = 0.0
                self.viewForConfirmation.isHidden = true
                self.functionForDeleteAlbum()
            }
            
            let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
                print("The user is not okay.")
            }
            
            // Add Actions
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            
            // Present Alert Controller
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    //details album
    func buttonDetailClickEvent(_ sender:UIButton)
    {
        self.pickerViews.isHidden=true
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
        let moduleId =              ((muarrayListData.value(forKey: "moduleId") as AnyObject).object(at: sender.tag) as! String)
        let project_cost =          (muarrayListData.value(forKey: "project_cost") as AnyObject).object(at: sender.tag) as! String
        let project_date =          (muarrayListData.value(forKey: "project_date") as AnyObject).object(at: sender.tag) as! String
        let title        =          (muarrayListData.value(forKey: "title") as AnyObject).object(at: sender.tag) as! String
        let type      =             (muarrayListData.value(forKey: "type") as AnyObject).object(at: sender.tag) as! String
        let working_hour =          (muarrayListData.value(forKey: "working_hour") as AnyObject).object(at: sender.tag) as! String
        let working_hour_type =     (muarrayListData.value(forKey: "working_hour_type") as AnyObject).object(at: sender.tag) as! String
        let sharetype     =         (muarrayListData.value(forKey: "sharetype") as AnyObject).object(at: sender.tag) as! String
        
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
            
        }
    }
    //MARK:- Server api calling
    func functionForFetchingAlbumListData()
    {
        //   {"groupId":"2765","profileId":"255671","moduleId":"8","district_id":"0","club_id":"0","category_id":"0","year":"2018-2019","SharType":"1","ClubRotaryType":"0"}
        SVProgressHUD.show()
        //print(txtClube.text)
        
        
            if(txtClube.text == "District Event"){
                ClubeRotaryType = "0"
                
            }else{
                ClubeRotaryType = "1"
            }
            
            
       
        
        // loaderClass.loaderViewMethod()
        
        let completeURL = baseUrl+"Gallery/GetAlbumsList_New"
        var parameterst:NSDictionary=NSDictionary()
     
        
        
        //UserDefaults.standard.set(dict["groupId"] as! String, forKey: "groupId_Session")
       // UserDefaults.standard.set(dict["isGrpAdmin"] as! String, forKey: "isGrpAdmin_Session")
       // UserDefaults.standard.set(dict["grpProfileid"] as! String, forKey: "grpProfileid_Session")
       // UserDefaults.standard.set(dict["moduleId"] as! String, forKey: "moduleId_Session")
       // UserDefaults.standard.set(dict["moduleName"] as! String, forKey: "moduleName_Session")
     //   UserDefaults.standard.set(self.isCategory, forKey: "isCategory_Session")
        
        
        self.getGroupId=UserDefaults.standard.value(forKey: "groupId_Session") as? String
        self.GetIsCategoryFromClubOrDistrict=UserDefaults.standard.value(forKey: "isCategory_Session") as? String
        self.GetUserProfileID=UserDefaults.standard.value(forKey: "grpProfileid_Session") as? String
        self.getModuleID=UserDefaults.standard.value(forKey: "moduleId_Session") as? String

            
            parameterst =  ["groupId":self.getGroupId,
                            "district_id":"0",
                            "club_id":"0",
                            "category_id":GetIsCategoryFromClubOrDistrict as Any,
                            "year": textfieldYear.text as Any,
                            "SharType":"1",
                            "profileId":self.GetUserProfileID,
                            "moduleId":self.getModuleID,
                            "ClubRotaryType":ClubeRotaryType as Any]
        
        
        print(parameterst)
        print(completeURL)
        
        let bytes = try! JSONSerialization.data(withJSONObject: parameterst, options: JSONSerialization.WritingOptions.prettyPrinted)
        //  var jsonObj = try! JSONSerialization.jsonObject(with: bytes, options: .mutableLeaves)
        if let str = String(data: bytes, encoding: String.Encoding.utf8)
        {
            //                {"groupId":"2765","profileId":"284691","moduleId":"8","district_id":"0","club_id":"0","category_id":"0","year":"2018-2019","SharType":"1","ClubRotaryType":"0"}
            
            print("<<-----------------------------json start----------------------------->>")
            print(completeURL)
            print(str)
            print("<<-----------------------------json end------------------------------->>")
            
        }
        else
        {
            print("not a valid UTF-8 sequence")
        }
        
        
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("dd \(dd)")
            self.muarrayListData = NSMutableArray()
            self.muarrayMainList = NSMutableArray()
            SVProgressHUD.show()
            print(response)
            let varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
                SVProgressHUD.show()
                if((dd.object(forKey: "TBAlbumsListResult")! as AnyObject).object(forKey: "status") as! String == "0")
                {
                    let arrarrNewGroupList = (((dd.object(forKey: "TBAlbumsListResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "newAlbums")) as! NSArray
                    print(arrarrNewGroupList)
                    self.muarrayMainList = arrarrNewGroupList
                    self.muarrayListData = arrarrNewGroupList
                    
                    if(self.muarrayListData.count>0)
                    {
                        
                        self.tableShowCaseList.isHidden = false
                        self.buttonNoResult.isHidden=true
                        self.buttonNoResult.setTitle("",  for: UIControl.State.normal)
                        let dict:NSDictionary = (self.muarrayListData.object(at: 0) as! NSDictionary)
                        self.varGetAlbumID = (dict.value(forKey: "albumId")as! String)
                        
                        self.tableShowCaseList.reloadData()
                    }
                    else
                    {
                        self.tableShowCaseList.isHidden = true
                        self.buttonNoResult.isHidden=false
                        self.buttonNoResult.setTitle("No albums found",  for: UIControl.State.normal)
                        SVProgressHUD.dismiss()
                    }
                    
                    //  SVProgressHUD.dismiss()
                }
                    
                else
                {
                    self.tableShowCaseList.isHidden = true
                    SVProgressHUD.dismiss()
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                    
                }
            }
            
        })
        
    }
    
    var  userID:String! = nil
    func functionForDeleteAlbum()
        
    {
        SVProgressHUD.show()
        userID = GetUserProfileID
        
        
        //            let varMemberID = UserDefaults.standard.string(forKey: "masterUID")
        //
        //            var urlStr = baseUrl+touchbase_DeleteAlbum
        
        // define parameters
        
        let params = ["typeID": self.varGetAlbumIDForDelete!, "type": "Gallery" , "profileID": self.userID!]
        
        /*-------------------------------------------------------------*/
        
        let url = URL(string: baseUrl+touchbase_DeleteAlbum)!
        
        print(url)
        
        print(params)
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
            
            switch response.result {
                
            case .success:
                
                // var result = [String:String]()
                
                if response.result.value != nil
                    
                {
                    print( response.result.value)
                    
                    var dictResponseData:NSDictionary=NSDictionary()
                    
                    dictResponseData = response.result.value as! NSDictionary
                    
                    print(dictResponseData)
                    
                    let message = (dictResponseData.value(forKey: "DeleteResult")! as AnyObject).value(forKey: "message")as! String
                    
                    if(message=="failed")
                        
                    {
                        print("Hello Filed")
                        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                    }
                        
                    else
                    {
                        if(self.GetIsCategoryFromClubOrDistrict=="2"){
                            
                            self.view.makeToast("Album Deleted successfully.", duration: 2, position: CSToastPositionCenter)
                            
                        }else{
                            self.view.makeToast(" Activity Deleted successfully.", duration: 2, position: CSToastPositionCenter)
                        }
                        
                        
                        
                        self.functionForFetchingAlbumListData()
                        
                    }
                    
                }
                
            case .failure(_): break
                
            }
            
        }
        
    }
    
    
    //--Floating button isAdmin
    func functiuonFloatingButton()
    {
        if(self.GetIsCategoryFromClubOrDistrict == "2"){
            
            let addAlbum = UIImage(named: "Album_add_blue.png")!
            let deleteAlbum = UIImage(named: "Album_delete_blue.png")!
            let phonebook = ActionButtonItem(title: "Add Activity", image: addAlbum)
            phonebook.action =
                {
                    item in print("Twitter...")
                    let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "DistAddPhotoNewVC") as! DistAddPhotoNewVC
                    albumControllerObject.strAlbumId = ""
                    albumControllerObject.strGroupId = self.getGroupId
                    albumControllerObject.moduleId = self.getModuleID
                    albumControllerObject.isCalledFRom = "add"
                    albumControllerObject.categoryId = ""
                    albumControllerObject.strcreatedBy = self.GetUserProfileID
                    albumControllerObject.strWitchType = self.txtClube.text
                    
                    albumControllerObject.year = self.getYear
                    print(albumControllerObject.year)
                    
                    //
                    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                        
                        self.navigationController?.pushViewController(albumControllerObject, animated: true)
                        
                    }
                    else
                    {
                        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                        
                    }
            }
            
            let invitation = ActionButtonItem(title: "Delete Activity", image: deleteAlbum)
            invitation.action =
                {
                    item in print("Google Plus...")
                    let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseAlbumListVC") as! ShowCaseAlbumListVC
                    albumControllerObject.ChekDel = "yes"
                    albumControllerObject.getGroupId = self.getGroupId
                    albumControllerObject.GetIsCategoryFromClubOrDistrict = self.GetIsCategoryFromClubOrDistrict
                    albumControllerObject.getYear =  self.getYear
                    albumControllerObject.GetUserProfileID = self.GetUserProfileID
                    albumControllerObject.getModuleID = self.getModuleID
                    albumControllerObject.strClubeorRot = self.txtClube.text
                    self.navigationController?.pushViewController(albumControllerObject, animated: true)
                    //self.tableShowCaseList.reloadData()
                    //self.actionButton = ActionButton(attachedToView: self.view, items: [invitation,phonebook])
                    
                    
                    //                let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "DeleteCreatedAlbumViewController") as! DeleteCreatedAlbumViewController
                    //                albumControllerObject.getGroupId = self.getGroupId
                    //                albumControllerObject.GetUserProfileID = self.GetUserProfileID
                    //                albumControllerObject.getModuleID = self.getModuleID
                    //               // albumControllerObject.textfieldYear.text=self.textfieldYear.text!
                    //                albumControllerObject.getCategoryIds = self.getCategoryIds
                    //
                    //                if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                    //
                    //                    if(self.muarrayMainList.count>0)
                    //                    {
                    //
                    //                        self.navigationController?.pushViewController(albumControllerObject, animated: true)
                    //                    }
                    //                    else
                    //                    {
                    //                        self.view.makeToast("Please first add album.", duration: 2, position: CSToastPositionCenter)
                    //                        print("First Add Album")
                    //                    }
                    //                }
                    //                else
                    //                {
                    //                    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                    //
                    //                }
                    
                    
            }
            
            actionButton = ActionButton(attachedToView: self.view, items: [invitation,phonebook])
            actionButton.action = { button in button.toggleMenu() }
            actionButton.setTitle("+", forState: UIControl.State.normal)
            // actionButton.textAlignment = NSTextAlignment.Center
            actionButton.backgroundColor = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha:1.0)
            
            
        }else{
            
            let addAlbum = UIImage(named: "Album_add_blue.png")!
            let deleteAlbum = UIImage(named: "Album_delete_blue.png")!
            let phonebook = ActionButtonItem(title: "Add Activity", image: addAlbum)
            phonebook.action =
                {
                    item in print("Twitter...")
                    let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotoNewVC") as! AddPhotoNewVC
                    albumControllerObject.strAlbumId = ""
                    albumControllerObject.strGroupId = self.getGroupId
                    albumControllerObject.moduleId = self.getModuleID
                    albumControllerObject.isCalledFRom = "add"
                    albumControllerObject.categoryId = ""
                    albumControllerObject.strcreatedBy = self.GetUserProfileID
                    // albumControllerObject.strWitchType = "Club Service" as discussed with Hitendra comment aand use dynamic 4 dec 4.07pm
                    //checkString
                    // self.txtClube.text
                    print(self.txtClube.text)
                    albumControllerObject.strWitchType = self.txtClube.text
                    
                    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                        
                        self.navigationController?.pushViewController(albumControllerObject, animated: true)
                        
                    }
                    else
                    {
                        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                        
                    }
            }
            let invitation = ActionButtonItem(title: "Delete Activity", image: deleteAlbum)
            invitation.action =
                {
                    item in print("Google Plus...")
                    let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseAlbumListVC") as! ShowCaseAlbumListVC
                    albumControllerObject.ChekDel = "yes"
                    albumControllerObject.getGroupId = self.getGroupId
                    albumControllerObject.GetIsCategoryFromClubOrDistrict = self.GetIsCategoryFromClubOrDistrict
                    albumControllerObject.getYear =  self.getYear
                    albumControllerObject.GetUserProfileID = self.GetUserProfileID
                    albumControllerObject.getModuleID = self.getModuleID
                    albumControllerObject.strClubeorRot = self.txtClube.text
                    self.navigationController?.pushViewController(albumControllerObject, animated: true)
                    //self.tableShowCaseList.reloadData()
                    //self.actionButton = ActionButton(attachedToView: self.view, items: [invitation,phonebook])
                    
                    
                    //                let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "DeleteCreatedAlbumViewController") as! DeleteCreatedAlbumViewController
                    //                albumControllerObject.getGroupId = self.getGroupId
                    //                albumControllerObject.GetUserProfileID = self.GetUserProfileID
                    //                albumControllerObject.getModuleID = self.getModuleID
                    //               // albumControllerObject.textfieldYear.text=self.textfieldYear.text!
                    //                albumControllerObject.getCategoryIds = self.getCategoryIds
                    //
                    //                if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                    //
                    //                    if(self.muarrayMainList.count>0)
                    //                    {
                    //
                    //                        self.navigationController?.pushViewController(albumControllerObject, animated: true)
                    //                    }
                    //                    else
                    //                    {
                    //                        self.view.makeToast("Please first add album.", duration: 2, position: CSToastPositionCenter)
                    //                        print("First Add Album")
                    //                    }
                    //                }
                    //                else
                    //                {
                    //                    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                    //
                    //                }
                    
                    
            }
            
            actionButton = ActionButton(attachedToView: self.view, items: [invitation,phonebook])
            actionButton.action = { button in button.toggleMenu() }
            actionButton.setTitle("+", forState: UIControl.State.normal)
            // actionButton.textAlignment = NSTextAlignment.Center
            actionButton.backgroundColor = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha:1.0)
            
            
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(ChekPicker == "Year"){
            return pickerDataSource.count;
        }else{
            return pickerClubeDataSource.count;
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(ChekPicker == "Year"){
            return pickerDataSource[row]
        }else{
            return pickerClubeDataSource[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        if(ChekPicker == "Year"){
            print(pickerDataSource[row] )
            // strNab = pickerDataSource[row]
            self.textfieldYear.text = pickerDataSource[row]
            self.pickerViews.isHidden=true
            self.getYear = self.textfieldYear.text!
            functionForFetchingAlbumListData()
        }
        else{
            //  strNab = pickerDataSource[row]
            print("name is-----",strNab)
            self.txtClube.text = pickerClubeDataSource[row]
            self.pikerClubeView.isHidden=true
            functionForFetchingAlbumListData()
        }
    }
    
    
    
    
    
    
}

