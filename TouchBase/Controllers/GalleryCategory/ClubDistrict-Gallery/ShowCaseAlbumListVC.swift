
//Service Projects
import UIKit
import SDWebImage
import Alamofire
import SVProgressHUD
protocol protocolForShowCaseAlbumListCallingApi {
    func functionForShowCaseAlbumListCallingApi(stringFromWhereITCalling:String)
}

class HeaderShowCaseAlbumListTVC: UITableViewCell {
    
    @IBOutlet weak var selctProjTileLblllllll: UILabel!
    @IBOutlet weak var subTitleProjLbl: UILabel!
    
}
//import LiquidFloatingActionButton
class ShowCaseAlbumListVC: UIViewController,UISearchBarDelegate,UISearchControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate,protocolForShowCaseAlbumListCallingApi, protocolNamePopValue{
    
    
    func functionForPopBackValue(stringValue1: String) {
        //backvalue
        print("bvalue d",stringValue1)
        strWhichType = stringValue1
        if(strWhichType == "Club Service"){
            //     self.title = "Club Meeting"
        }else{
            //    self.title = "Service Project"
        }
    }
    
    func functionForPopBackValue1(stringValue1: String) {
        //backvalue
        print("this is value ")
        print("bvalue d",stringValue1)
        strWhichType = stringValue1
        if(strWhichType == "Club Service"){
            // self.title = "District Event"
        }else{
            //  self.title = "District Project"
        }
    }
    
    
    
    
    
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
        self.noRecorLbl.isHidden = true
        selectProjjWalaViewTbl.isHidden = true
        //            self.ChekDel = ""
        //            CheckMoveToClub = ""
        if isAddButtonClick
        {
            isAddButtonClick=false
            reFreshViewIfComingFromAddPage()
        }
        //            CheckMoveToClub = ""
        functionForFetchingAlbumListData()
//        functionForYears()
        tableShowCaseList.reloadData()
        selctProjTbleView.reloadData()
    }
    //    override func viewWillDisappear(_ animated: Bool) {
    //        self.ChekDel = ""
    //        CheckMoveToClub = ""
    //
    //    }
    var varGetAlbumIDForDelete:String!=""
    var appDelegate : AppDelegate = AppDelegate()
    //  let loaderClass  = WebserviceClass()
    
    @IBOutlet weak var searchCommunityServiceTF: UITextField!
    @IBOutlet weak var ongoingProjTitleeLbl: UIButton!
    var actionButton: ActionButton?
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
    var pageTitle:String=""
    var addFloatBtn: String = ""
    var delFloatBtn: String = ""
    var ChekDel:String?
    //    var strNab:String = ""
    var CheckMoveToClub:String?
    var strClubeorRot:String?
    var strNab:String = ""
    var varGetAlbumID:String!=nil
    var galleryID:String?
    //        @IBOutlet weak var subprojTileLblllmf: UILabel!
    // added by shubhs
    var GetAlbumID:String!=""
    var GetGroupID:String!=""
    //        var MemberCount:String=""
    //        var BenificiaryCount:String=""
    var strWhichType:String?
    var isOneTimeEnable:String?
    var checkString:String!=""
    //        var pageTitle:String=""
    //        var GetUserProfileID:String!=""
    var GetModuleID:String!=""
    var addCOMM: AddCOM?
    var inddd = 0
    var avenueShareType: String? = ""
    var avenueTitle = ""
    var tag:Int = 0
    
    var titleRIZone = ""
    
    @IBOutlet var selectProjjWalaViewTbl: UIView!
    @IBOutlet weak var selctProjTbleView: UITableView!
    //MARK:-New Variable after 2020
    var MemberCount:String=""
    var BenificiaryCount:String=""
    var isAddButtonClick:Bool=false
    
    @IBOutlet weak var noRecorLbl: UILabel!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var pickerViews: UIPickerView!
    var ClubeRotaryType:String?
    var isSamePage:Bool=false
    @IBOutlet weak var pikerClubeView: UIPickerView!
    @IBOutlet weak var buttonNoResult: UIButton!
    var varGetSearchText:String!=""
    // @IBOutlet weak var searchBar: UISearchBar!
    var muarrayListData:NSArray=NSArray()
    var muarrayMainList:NSArray? = NSArray()
    var tempValue:NSMutableArray = []
    var tempName:NSMutableArray = []
    var TempArray:NSMutableArray = []
    var TempArrayName:NSMutableArray = []
    var newselectedDict:NSMutableDictionary = NSMutableDictionary()
    var hideFloatButtonDelegate: HideFloatButton?
    var arrarrNewGroupList1:NSArray=NSArray()
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var buttonYes: UIButton!
    @IBOutlet weak var buttonNo: UIButton!
    @IBOutlet weak var viewForConfirmation: UIView!
    @IBOutlet weak var tableShowCaseList: UITableView!
    
    let searchBar = UISearchBar()
    // @IBOutlet weak var txtClube: UITextField!
    @IBOutlet weak var btnSelectYearPickerOpn: UIButton!
    @IBOutlet weak var viewForTextFieldYear: UIView!
    @IBOutlet weak var textfieldYear: UITextField!
    var ifanyChanges:String! = ""
    var ChekPicker:String?
    var yearFrom:String! = ""
    var year : Int! = 0
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    //    var tableViewHeight: CGFloat = 0
    
    @IBOutlet weak var subTitleProjHeaderLbl: UILabel!
    var pickerDataSource :[String] = []
    
    var pickerClubeDataSource :[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        functionForYears()
        self.noRecorLbl.isHidden = true
        var frame = selctProjTbleView.frame
        frame.size.height = selctProjTbleView.contentSize.height
        selctProjTbleView.frame = frame
        
        selectProjjWalaViewTbl.isHidden = true
        print("This is Activity Listing Page for")
        print("\(GetModuleName)")
        print("\(strClubeorRot)")
        print("\(GetIsCategoryFromClubOrDistrict)")
        print("\(ClubeRotaryType)")
        
        switch GetModuleName {
        case "Club Service":
            pageTitle="Club Meeting"
            break
        case "Service Projects":
            pageTitle="Service Project"
            break
        case "District Projects":
            pageTitle="District Project"
            break
        case "District Events":
            pageTitle="District Event"
            break
        default:
            break
        }
        //          ChekDel
        print(ChekDel)
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.barTintColor = UIColor.blue
        searchBar.tintColor = UIColor.black
        //            searchBar.layer.borderColor = UIColor.lightGray.cgColor
        //            searchBar.layer.borderWidth = 1.0
        //            searchBar.frame = CGRect(x: 8, y: 20, width: 308, height: 44)
        //            searchBar.layer.cornerRadius = 12.0
        self.pickerViews.dataSource = self;
        self.pickerViews.delegate = self;
        self.pikerClubeView.dataSource = self;
        self.pikerClubeView.delegate = self;
        self.searchCommunityServiceTF.delegate = self
        viewForConfirmation.isHidden = true
        buttonOpticity.alpha = 0.0
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
        functionForYears()
        
        if(varIsCallFrom=="ShowCaseFromDashBoard")
        {
        }
        else
        {
            self.getYear = textfieldYear?.text
        }
        
        if(varIsCallFrom=="ShowCaseFromDashBoard")
        {
        }
        if(GetIsAdmin=="Yes") {
        self.functiuonFloatingButton()
        }
        
        //            self.edgesForExtendedLayout=[]
        buttonNoResult.isHidden=true
        self.buttonNoResult.setTitle("",  for: UIControl.State.normal)
        
        //            self.edgesForExtendedLayout=[]
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
    
    
    func reFreshViewIfComingFromAddPage()
    {
        actionButton?.toggle()
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
        for  i in (2010..<year)
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
        self.title = GetModuleName//"Activities"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        //          self.navigationController?.navigationBar.barTintColor=UIColor.white
        //            self.navigationController?.navigationBar.barTintColor=UIColor.white// (red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor=UIColor.white
        let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        
        buttonleft.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ShowCaseAlbumListViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        //            let buttonRight = UIButton(type: UIButton.ButtonType.custom)
        //            buttonRight.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        //            buttonRight.setImage(UIImage(named:"searchNew"),  for: UIControl.State.normal)
        //            buttonRight.addTarget(self, action: #selector(ShowCaseAlbumListVC.SearchClickedAction), for: UIControl.Event.touchUpInside)
        //            let RightButton: UIBarButtonItem = UIBarButtonItem(customView: buttonRight)
        //            self.navigationItem.rightBarButtonItem = RightButton
    }
    
    @objc func backClicked()
    {
        self.hideFloatButtonDelegate?.hideFloatAction()
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
    
    @objc func SearchClickedAction(){
        
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
        view.endEditing(true)
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
    
    func clearSearchView()
    {
        searchBar.text = ""
        self.navigationItem.titleView = nil
        createNavigationBar()
        muarrayListData=NSArray()
        self.muarrayListData = self.muarrayMainList ?? []
        self.tableShowCaseList.reloadData()
        searchBar.resignFirstResponder()
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
    
    //        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    //        {
    //            //appDelegate = UIApplication.shared.delegate as! AppDelegate
    //            searchBar.setShowsCancelButton(true, animated: true)
    //            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
    //
    //                varGetSearchText = searchBar.text!
    //                print(varGetSearchText)
    //                if(searchText.characters.count>0)
    //                {
    //               if(varIsCallFrom=="ShowCaseFromDashBoard")
    //                    {
    //                        let predicate =  NSPredicate(format: "title contains[c] %@ OR clubname contains[c] %@", varGetSearchText,varGetSearchText)
    //                        let searchDataSource = muarrayMainList.filtered(using: predicate)
    //                        muarrayListData=searchDataSource as NSArray
    //                        print(muarrayListData)
    //                        self.tableShowCaseList.reloadData()
    //
    //                    }
    //                    else
    //                    {
    //                        let predicate =  NSPredicate(format: "title contains[c] %@ OR description contains[c] %@", varGetSearchText,varGetSearchText)
    //                        let searchDataSource = muarrayMainList.filtered(using: predicate)
    //                        muarrayListData=searchDataSource as NSArray
    //                        print(muarrayListData)
    //                        self.tableShowCaseList.reloadData()
    //
    //                    }
    //                }
    //                else
    //                {
    //                    muarrayListData=NSArray()
    //                    self.muarrayListData = self.muarrayMainList
    //                    self.tableShowCaseList.reloadData()
    //                    searchBar.resignFirstResponder()
    //
    //                }
    //
    //                if(muarrayListData.count>0)
    //                {
    //                    self.buttonNoResult.isHidden=true
    //                    self.buttonNoResult.setTitle("",  for: UIControl.State.normal)
    //                     self.tableShowCaseList.isHidden=false
    //                }
    //                else
    //                {
    //                    self.buttonNoResult.isHidden=false
    //                    self.buttonNoResult.setTitle("No albums found",  for: UIControl.State.normal)
    //                     self.tableShowCaseList.isHidden=true
    //                }
    //            }
    //            else
    //            {
    //                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
    //
    //                searchBar.resignFirstResponder()
    //                self.navigationItem.titleView = nil
    //                createNavigationBar()
    //            }
    //        }
    
    //        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    //        {
    //            searchBar.setShowsCancelButton(true, animated: true)
    //            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
    //                print("use predicate 3 here")
    //            }
    //            else
    //            {
    //                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
    //
    //                searchBar.resignFirstResponder()
    //                self.navigationItem.titleView = nil
    //                createNavigationBar()
    //            }
    //        }
    
    //        func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    //        {
    //            print("searchText \(searchBar.text!)")
    //            varGetSearchText = searchBar.text!
    //            print("use predicate 2 here")
    //            searchBar.resignFirstResponder()
    //            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
    //                if(varGetSearchText.characters.count>0)
    //                {
    //                    let predicate =  NSPredicate(format: "title contains[c] %@ OR clubname contains[c] %@", varGetSearchText,varGetSearchText)
    //                    let searchDataSource = muarrayMainList.filtered(using: predicate)
    //                    muarrayListData=searchDataSource as NSArray
    //                    print(muarrayListData)
    //                    self.tableShowCaseList.reloadData()
    //
    //                }
    //                else
    //                {
    //                    muarrayListData=NSArray()
    //                    self.muarrayListData = self.muarrayMainList
    //                    self.tableShowCaseList.reloadData()
    //
    //                }
    //
    //                if(muarrayListData.count>0)
    //                {
    //                    self.buttonNoResult.isHidden=true
    //                    self.buttonNoResult.setTitle("",  for: UIControl.State.normal)
    //                      self.tableShowCaseList.isHidden=false
    //                }
    //                else
    //                {
    //                    self.buttonNoResult.isHidden=false
    //                    self.buttonNoResult.setTitle("No albums found",  for: UIControl.State.normal)
    //                     self.tableShowCaseList.isHidden=true
    //                }
    //
    //            }
    //            else
    //            {
    //                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
    //
    //            }
    //         //   self.navigationItem.titleView = nil
    //          //  createNavigationBar()
    //        }
    
    //        func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    //        {
    //            searchBar.text = ""
    //            self.navigationItem.titleView = nil
    //            createNavigationBar()
    //             functionForFetchingAlbumListData()
    //
    //        }
    //MARK:- Tableview Delegate As List
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if tableView == selctProjTbleView {
            return arrarrNewGroupList1.count
        }
        else{
            return muarrayListData.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == selctProjTbleView {
            let cell1 = selctProjTbleView.dequeueReusableCell(withIdentifier: "HeaderShowCaseAlbumListTVC", for: indexPath) as! HeaderShowCaseAlbumListTVC
            cell1.selectionStyle = .none
            //                if arrarrNewGroupList.count > 0 {
            cell1.selctProjTileLblllllll.text = (arrarrNewGroupList1.value(forKey: "album_title") as AnyObject).object(at: indexPath.row) as! String
            //                }
            //                else{
            //                    cell1.selctProjTileLblllllll.text = ""
            //                }
            
            print(cell1.frame.size.height, self.tableViewHeight)
            //                  self.tableViewHeight = cell1.frame.size.height
            //                  tableViewBillsHeight.constant = self.tableViewHeight
            
            
            
            return cell1
            
        }
        else{
            let cell = tableShowCaseList.dequeueReusableCell(withIdentifier: "ShowCaseAlbumListTVC", for: indexPath) as! ShowCaseAlbumListTVC
            
            //                cell.btnDelete.isHidden  = true
            cell.selectProjBtnnnn.tag = indexPath.row
            cell.selectProjBtnnnn.layer.cornerRadius = 10
            cell.selectProjBtnnnn.layer.borderWidth = 1.0
            cell.selectProjBtnnnn.layer.borderColor = UIColor .gray.cgColor
            
            
            //                if #available(iOS 13.0, *) {
            //                    if indexPath.row == 1 || indexPath.row == 3 {
            //                        cell.selectProjBtnnnn.backgroundColor = UIColor(red:135/255, green:207/255, blue:250/255, alpha: 1)
            //                        cell.selectProjBtnnnn .setTitle("Repeat Project", for: UIControl.State.normal)
            //                    }
            //                    else{
            //                    cell.selectProjBtnnnn.backgroundColor  = UIColor.groupTableViewBackground
            //                        cell.didSelectBtnnnnn .setTitle("One time project", for: UIControl.State.normal)
            //                    }
            //                } else {
            //                    // Fallback on earlier versions
            //                }
            
            //                btnApplyForLeave.backgroundColor = UIColor(red:74/255, green:175/255, blue:240/255, alpha: 1)
            
            
            if(muarrayListData.count>0)
            {
                print(muarrayListData)
                print((muarrayListData.value(forKey: "title") as AnyObject).object(at: indexPath.row) as! String)
                cell.labelTitle.text! = (muarrayListData.value(forKey: "title") as AnyObject).object(at: indexPath.row) as! String
                cell.lblDetails.text! =  (muarrayListData.value(forKey: "description") as AnyObject).object(at: indexPath.row) as! String
                
                let strDate = convertToShowFormatDate(dateString: ((muarrayListData.value(forKey: "project_date") as AnyObject).object(at: indexPath.row) as! String))
                cell.lblDate.text = strDate
                print(strDate)
                //[[NSUserDefaults standardUserDefaults]setValue:@"Yes" forKey:@"session_IsComingFromImageSave"];
                //               var ChekDelelet = [[NSUserDefaults standardUserDefaults]valueForKey:@"ChekDel"];
                
                //                OnetimeOrOngoing
                cell.selectProjBtnnnn.tag = indexPath.row
                cell.selectProjBtnnnn.addTarget(self, action: #selector(selectProjtypeBtnClickeddd), for: UIControl.Event.touchUpInside)
                //                Club Service
                print(GetModuleName)
                cell.selectProjBtnnnn.isHidden = false
                
                
                var fID = (muarrayListData.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: indexPath.row) as? String
                
                if fID == nil {
                    var fID:String = ""
                    //                    return fID
                }
                else{
                    var fID = (muarrayListData.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: indexPath.row) as! String
                    //                    return selectProj
                }
                
                
                //                let fID=(muarrayListData.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: indexPath.row) as! String
                print(fID)
                if GetModuleName != "Club Service"{
                    cell.selectProjBtnnnn.isHidden = false
                    
                    if ((muarrayListData.value(forKey: "OnetimeOrOngoing") as AnyObject).object(at: indexPath.row) as! String) == "1" {
                        cell.selectProjBtnnnn.backgroundColor  = UIColor.groupTableViewBackground
                        cell.selectProjBtnnnn .setTitle("One time project", for: UIControl.State.normal)
                        isOneTimeEnable = "no"
                        
                    }
                    //                || !((muarrayListData.value(forKey: "title") as AnyObject).object(at: indexPath.row) as! String).isEmpty
                    else if ((muarrayListData.value(forKey: "OnetimeOrOngoing") as AnyObject).object(at: indexPath.row) as! String) == "2"
                    {
                        //                    if let title = object.title, !title.isEmpty
                        
                        if fID == "" {
                            cell.selectProjBtnnnn.backgroundColor  = UIColor.groupTableViewBackground
                            cell.selectProjBtnnnn .setTitle("Ongoing/Repeat Project", for: UIControl.State.normal)
                            isOneTimeEnable = "no"
                        }
                        else{
                            
                            cell.selectProjBtnnnn.backgroundColor = UIColor(red:135/255, green:207/255, blue:250/255, alpha: 1)
                            cell.selectProjBtnnnn .setTitle("Ongoing/Repeat Main Project", for: UIControl.State.normal)
                            isOneTimeEnable = "yes"
                        }
                        
                    }
                    else{
                        cell.selectProjBtnnnn.isHidden = true
                    }
                    
                    
                    
                    if(ChekDel == "yes"){
                        
                        print(fID)
                        if fID == "" {
                            cell.btnDelete.isHidden  = false
                        }
                        else{
                            cell.btnDelete.isHidden  = false
                        }
                        
                        
                        cell.btnDelete .setImage(UIImage(named: "Delete_blue"), for:UIControl.State.normal )
                        //                    cell.btnDelete.isHidden = false
                        cell.btnDelete.tag = indexPath.row
                        cell.btnDelete.addTarget(self, action: #selector(ShowCaseAlbumListVC.DeleteAction(_:)), for: .touchUpInside)
                        //                    Image("Delete_blue")Image("moveToclub")
                    }
                    
                    else  if(CheckMoveToClub == "yes"){
                        if GetModuleName == "Club Service"{
                            cell.btnDelete .setImage(UIImage(named: "clubToService"), for:UIControl.State.normal )
                        }
                        else{
                            cell.btnDelete .setImage(UIImage(named: "serviceToClub"), for:UIControl.State.normal)
                        }
                        //                    cell.btnDelete.isHidden = false
                        cell.btnDelete.tag = indexPath.row
                        
                        print(fID)
                        if fID == "" {
                            cell.btnDelete.isHidden  = false
                        }
                        else{
                            cell.btnDelete.isHidden  = false
                        }
                        
                        
                        
                        cell.btnDelete.addTarget(self, action: #selector(ShowCaseAlbumListVC.DeleteAction(_:)), for: .touchUpInside)
                        //                    Image("Delete_blue")
                    }
                    else
                    {
                        cell.btnDelete.isHidden  = true
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                else if GetModuleName == "Club Service"
                {
                    cell.selectProjBtnnnn.isHidden = true
                    if(ChekDel == "yes"){
                        
                        
                        cell.btnDelete .setImage(UIImage(named: "Delete_blue"), for:UIControl.State.normal )
                        //                    cell.btnDelete.isHidden = false
                        cell.btnDelete.tag = indexPath.row
                        cell.btnDelete.addTarget(self, action: #selector(ShowCaseAlbumListVC.DeleteAction(_:)), for: .touchUpInside)
                        //                    Image("Delete_blue")Image("moveToclub")
                    }
                    
                    else  if(CheckMoveToClub == "yes"){
                        if GetModuleName == "Club Service"{
                            cell.btnDelete .setImage(UIImage(named: "clubToService"), for:UIControl.State.normal )
                        }
                        else{
                            cell.btnDelete .setImage(UIImage(named: "serviceToClub"), for:UIControl.State.normal)
                        }
                        //                    cell.btnDelete.isHidden = false
                        cell.btnDelete.tag = indexPath.row
                        cell.btnDelete.addTarget(self, action: #selector(ShowCaseAlbumListVC.DeleteAction(_:)), for: .touchUpInside)
                        //                    Image("Delete_blue")
                    }
                    else
                    {
                        cell.btnDelete.isHidden  = true
                    }
                }
                else{
                    cell.selectProjBtnnnn.isHidden = true
                }
                
                if(strClubeorRot == "Vocational service") {
                    cell.selectProjBtnnnn.isHidden = true
                }
                
                
                
                
                
                
                
                //                subTitleProjHeaderLbl.text! = (muarrayListData.value(forKey: "title") as AnyObject).object(at: indexPath.row) as! String
                
                cell.selectionStyle = .none
                print("Loading close @ 3")
                SVProgressHUD.dismiss()
            }else{
                print("Loading close @ 4")
                SVProgressHUD.dismiss()}
           
            return cell
        }
        
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
        if tableView == selctProjTbleView{
            return 70
            
        }
        else {
            return 120
        }
    }
    //
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if tableView == selctProjTbleView{
            return tableView.estimatedRowHeight
            
        }
        else{
            return 120
        }
    }
    //        if tableView == tableShowCaseList {
    //            <#code#>
    //        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableShowCaseList {
            
            
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
                print(moduleId)
                getGroupId = groupId
                varGetAlbumID  = albumId
                print(getGroupId)
                print(albumId)
                print(varGetAlbumID)
                print(working_hour)
                
                if(strClubeorRot == "District Events"){
                    
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
                obj.year = textfieldYear.text as Any as! String
                print("Community Add Project year---\(obj.year)")
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
                obj.checkString = strClubeorRot
                obj.MemberCount=self.MemberCount
                obj.BenificiaryCount=self.BenificiaryCount
                obj.pageTitle=self.pageTitle
                obj.strWhichType=self.GetModuleName
                obj.textfieldYear = textfieldYear.text as Any as! String
                obj.getGroupId = self.getGroupId
//                obj.avenueEditTitle = "Edit Vocational Service"
//                obj.avenueShareType = "2"
                if (self.avenueShareType == "0") {
                    obj.avenueEditTitle = "Edit Club Service"
                    obj.avenueShareType = "0"
                } else if (self.avenueShareType == "1") {
                    obj.avenueEditTitle = "Edit Community Service"
                    obj.avenueShareType = "1"
                } else if (self.avenueShareType == "4") {
                    obj.avenueEditTitle = "Edit New Generation Service"
                    obj.avenueShareType = "4"
                } else if (self.avenueShareType == "3") {
                    obj.avenueEditTitle = "Edit International Service"
                    obj.avenueShareType = "3"
                } else if (self.avenueShareType == "5") {
                    obj.avenueEditTitle = "Edit Public Image Initiative Service"
                    obj.avenueShareType = "5"
                } else if (self.avenueShareType == "2") {
                    obj.avenueEditTitle = "Edit Vocational Service"
                    obj.avenueShareType = "2"
                }
                
                var varGetValue:String!=strClubeorRot as! String
                if(varGetValue=="District Events")
                {
                    obj.checkString = "Club Service"
                }
                else  if(varGetValue=="District Projects")
                {
                    obj.checkString = "Service Projects"
                }
                print("this is my variable for check string ")
                
                
                
                
                obj.strWhichType = strClubeorRot
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
                var NumberOfRotarian:String = ""
                if let test=muarrayListData.object(at: indexPath.row) as? AnyObject
                {
                    if let str=test.value(forKey: "NumberOfRotarian") as? String
                    {
                        NumberOfRotarian=str
                    }
                }
                //  let NumberOfRotarian =      (muarrayListData.value(forKey: "NumberOfRotarian") as AnyObject).object(at: indexPath.row) as! String
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
                if(strClubeorRot == "Club Service"){
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
                //obj.GetShareType=sharetype
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
                obj.MemberCount=self.MemberCount
                obj.textfieldYear = textfieldYear.text as Any as! String
                obj.BenificiaryCount=self.BenificiaryCount
                obj.pageTitle=self.pageTitle
                obj.strWhichType = self.GetModuleName
                obj.navTitleName = self.GetModuleName
                if (self.avenueShareType == "0") {
                    obj.avenueEditTitle = "Edit Club Service"
                    obj.avenueShareType = "0"
                } else if (self.avenueShareType == "1") {
                    obj.avenueEditTitle = "Edit Community Service"
                    obj.avenueShareType = "1"
                } else if (self.avenueShareType == "4") {
                    obj.avenueEditTitle = "Edit New Generation Service"
                    obj.avenueShareType = "4"
                } else if (self.avenueShareType == "3") {
                    obj.avenueEditTitle = "Edit International Service"
                    obj.avenueShareType = "3"
                } else if (self.avenueShareType == "5") {
                    obj.avenueEditTitle = "Edit Public Image Initiative Service"
                    obj.avenueShareType = "5"
                } else if (self.avenueShareType == "2") {
                    obj.avenueEditTitle = "Edit Vocational Service"
                    obj.avenueShareType = "2"
                }
                print( obj.navTitleName)
                obj.year = textfieldYear.text as Any as! String
                
                print(obj.year)
                if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                    
                    self.navigationController?.pushViewController(obj, animated: true)
                }
                else
                {
                    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                    
                }
            }
        }
        if tableView == selctProjTbleView {
            print(arrarrNewGroupList1)
            tempValue = NSMutableArray()
            tempName = NSMutableArray()
            TempArray = NSMutableArray()
            TempArrayName = NSMutableArray()
            var NumberOfRotarian:String = ""
            if let test=arrarrNewGroupList1.object(at: indexPath.row) as? AnyObject
            {
                if let str=test.value(forKey: "NumberOfRotarian") as? String
                {
                    NumberOfRotarian=str
                }
            }
            print(indexPath.row)
            //  let NumberOfRotarian =      (muarrayListData.value(forKey: "NumberOfRotarian") as AnyObject).object(at: indexPath.row) as! String
            print( (arrarrNewGroupList1.value(forKey: "pk_gallery_id") as AnyObject).object(at: indexPath.row) as? String)
            
            let temp:NSNumber = (arrarrNewGroupList1.value(forKey: "pk_gallery_id") as AnyObject).object(at: indexPath.row)
            let albumId = temp.stringValue
            
            //                let x : Int = 42
            //                var myString = String(x)
            //
            
            
            
            
            //                let albumId   =  (arrarrNewGroupList.value(forKey: "pk_gallery_id") as AnyObject).object(at: indexPath.row) as? int64
            
            //                print(tempString)
            let beneficiary  =    (arrarrNewGroupList1.value(forKey: "beneficiary") as AnyObject).object(at: indexPath.row) as! String
            //                let clubname =              (muarrayListData.value(forKey: "clubname") as AnyObject).object(at: indexPath.row) as! String
            let cost_of_project_type =  (arrarrNewGroupList1.value(forKey: "cost_of_project") as AnyObject).object(at: indexPath.row) as! String
            //                let description  =          (muarrayListData.value(forKey: "description") as AnyObject).object(at: indexPath.row) as! String
            //                let groupId      =          (arrarrNewGroupList.value(forKey: "fk_group_master_id") as AnyObject).object(at: indexPath.row) as! String
            
            
            let temp1:NSNumber = (arrarrNewGroupList1.value(forKey: "fk_group_master_id") as AnyObject).object(at: indexPath.row)
            let groupId = temp.stringValue
            
            
            
            //                let image =                 (muarrayListData.value(forKey: "image") as AnyObject).object(at: indexPath.row) as! String
            //let isAdmin =             muarrayListData.valueForKey("isAdmin").objectAtIndex(sender.tag) as? String
            let moduleId =  "52"
            let project_cost =          (arrarrNewGroupList1.value(forKey: "cost_of_project") as AnyObject).object(at: indexPath.row) as! String
            let project_date =           (arrarrNewGroupList1.value(forKey: "date_of_project") as AnyObject).object(at: indexPath.row) as! String
            let title        =           (arrarrNewGroupList1.value(forKey: "album_title") as AnyObject).object(at: indexPath.row) as! String
            //                let type      =              (muarrayListData.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! String
            let working_hour =          (arrarrNewGroupList1.value(forKey: "man_hours_spent") as AnyObject).object(at: indexPath.row) as! String
            let working_hour_type =     (arrarrNewGroupList1.value(forKey: "man_hours_spent") as AnyObject).object(at: indexPath.row) as! String
            let sharetype =        "1"
            //                let Attendance =            (muarrayListData.value(forKey: "Attendance") as AnyObject).object(at: indexPath.row) as? String
            //                let AttendancePer =         (muarrayListData.value(forKey: "AttendancePer") as AnyObject).object(at: indexPath.row) as? String
            //                let AgendaAttachement =     (muarrayListData.value(forKey: "AgendaDocID") as AnyObject).object(at: indexPath.row) as? String
            //                let MOMAttachement =        (muarrayListData.value(forKey: "MOMDocID") as AnyObject).object(at: indexPath.row) as?String
            
            getModuleID = moduleId
            getGroupId = groupId
            varGetAlbumID  = albumId
            print(albumId)
            print(varGetAlbumID)
            print(working_hour)
            //                print(AgendaAttachement)
            //                print(MOMAttachement)
            if(strClubeorRot == "Club Service"){
                strNab = "Club Service"
                
                //                    if(AgendaAttachement == ""){
                //
                //                    }
                //                    else{
                //                        TempArrayName.add("Agenda")
                //                        TempArray.add(AgendaAttachement)
                //                    }
                //                    if(MOMAttachement == ""){
                //
                //                    }
                //                    else{
                //                        TempArrayName.add("Minutes of Meeting")
                //                        TempArray.add(MOMAttachement)
                //                    }
                //
                //                    tempValue.add(project_date)
                //                    tempValue.add(Attendance)
                //                    tempValue.add(AttendancePer)
                //                    tempValue.add(type)
                //
                //                    tempName.add("Date")
                //                    tempName.add("Attendance")
                //                    tempName.add("Attendance(%)")
                //                    tempName.add("Metting Type")
                //
                //                    print(tempValue)
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
            obj.year = textfieldYear.text as Any as! String
            //obj.GetShareType=sharetype
            obj.GetGroupID=groupId
            obj.Getdescription=description
            obj.Getbeneficiary=beneficiary
            obj.Getproject_cost=project_cost
            obj.Getproject_date=project_date
            obj.Gettitle=title
            obj.GetManHours=working_hour
            obj.GetAlbumID=albumId
            //                obj.recipientType=type
            obj.Getworking_hour_type=working_hour_type
            obj.Getcost_of_project_type=cost_of_project_type
            obj.GetNumberOfRotarian=NumberOfRotarian
            //                obj.GetClubName=clubname
            obj.GetIsAdmin=self.GetIsAdmin
            //                obj.GetImageUrl = image
            obj.GetModuleID = self.getModuleID
            obj.GetUserProfileID=self.GetUserProfileID
            obj.GetIsCategoryFromClubOrDistrict=self.GetIsCategoryFromClubOrDistrict
            obj.getGroupDistrictList=self.getGroupDistrictList
            obj.strNavi = strNab
            obj.MemberCount=self.MemberCount
            obj.BenificiaryCount=self.BenificiaryCount
            obj.pageTitle=self.pageTitle
            obj.strWhichType = self.GetModuleName
            obj.textfieldYear = textfieldYear.text as Any as! String
            if (self.avenueShareType == "0") {
                obj.avenueEditTitle = "Edit Club Service"
                obj.avenueShareType = "0"
            } else if (self.avenueShareType == "1") {
                obj.avenueEditTitle = "Edit Community Service"
                obj.avenueShareType = "1"
            } else if (self.avenueShareType == "4") {
                obj.avenueEditTitle = "Edit New Generation Service"
                obj.avenueShareType = "4"
            } else if (self.avenueShareType == "3") {
                obj.avenueEditTitle = "Edit International Service"
                obj.avenueShareType = "3"
            } else if (self.avenueShareType == "5") {
                obj.avenueEditTitle = "Edit Public Image Initiative Service"
                obj.avenueShareType = "5"
            } else if (self.avenueShareType == "2") {
                obj.avenueEditTitle = "Edit Vocational Service"
                obj.avenueShareType = "2"
            }
            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                
                self.navigationController?.pushViewController(obj, animated: true)
                
            }
            else
            {
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                
            }
        }
    }
    
    @IBAction func DidselectBtnClickedd(_ sender: Any) {
    }
    @objc func DeleteAction(_ sender:UIButton)
    {
        
        
        //            http://rowtestapi.rosteronwheels.com/V4/api/Gallery/projectmove
        //            {"GallaryId":"70","type":"1"}
        if CheckMoveToClub == "yes" {
            //                {
            
            
            //                getDataForMoveNDeleteProject
            
            self.getDataForMoveNDeleteProject(index: sender.tag)
            
            //                var alertController = UIAlertController(title: "", message: "Are you sure you want to move this \(pageTitle)", preferredStyle: .alert)
            //                if self.GetModuleName == "Service Projects"
            //                {
            ////                        service to club
            //                    alertController = UIAlertController(title: "", message: "Are you sure you want to move this service project to club meeting", preferredStyle: .alert)
            //                }
            //                if self.GetModuleName == "Club Service"
            //                {
            ////                        club to service
            //                    alertController = UIAlertController(title: "", message: "Are you sure you want to move this club meeting to service project", preferredStyle: .alert)
            //
            //                }
            //
            //
            //
            //                // Initialize Actions
            //                let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            //
            //
            //                    print("The user is okay.")
            //                    self.buttonOpticity.alpha = 1.0
            //                    self.viewForConfirmation.isHidden = true
            //                    let row = sender.tag
            //                    print("Row: \(row)")
            //                    print(self.muarrayListData)
            //                    //let dict:NSDictionary = (muarrayListData.object(at: row) as! NSDictionary)
            //                    self.varGetAlbumID=(self.muarrayListData.value(forKey: "type") as AnyObject).object(at: sender.tag) as! String
            //                    self.GetGroupID = (self.muarrayListData.value(forKey: "groupId") as AnyObject).object(at: sender.tag) as! String
            ////                    print(self.muarrayListData.objects(at: sender.tag))
            //                    self.varGetAlbumIDForDelete = (self.muarrayListData.value(forKey: "albumId") as AnyObject).object(at: sender.tag) as! String
            //                    self.GetModuleID =  (self.muarrayListData.value(forKey: "moduleId") as AnyObject).object(at: sender.tag) as! String
            //                    print(self.varGetAlbumID)
            //                    print(self.varGetAlbumIDForDelete)
            ////                    self.getMoveToClubData()
            //                    self.buttonOpticity.alpha = 0.0
            //                    self.viewForConfirmation.isHidden = true
            ////                    self.functionForDeleteAlbum()
            ////                    {
            //                        let objAddPhoto = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotoNewVC") as! AddPhotoNewVC
            //
            //
            //
            //
            //                        print(self.GetAlbumID)
            //                        objAddPhoto.strAlbumId = self.varGetAlbumIDForDelete
            //                        objAddPhoto.strGroupId = self.GetGroupID
            //                        objAddPhoto.strcreatedBy = self.GetUserProfileID
            ////                        objAddPhoto.moduleId = self.GetModuleID
            ////                    self.CheckMoveToClub = ""
            ////                    self.ChekDel = ""
            //                            objAddPhoto.isCalledFRom = "Edit"
            //                            objAddPhoto.objProtocolNameNew=self
            //                            objAddPhoto.MemberCount = self.MemberCount
            //                            objAddPhoto.BenificiaryCount = self.BenificiaryCount
            //                        objAddPhoto.checkString = "Club Service"
            //                    if self.GetModuleName == "Service Projects"
            //                    {
            ////                        service to club
            //
            //                        objAddPhoto.isFromMoveToClub = "yes"
            //                        objAddPhoto.strWitchType = "Club Service"
            //                        objAddPhoto.moduleId = "8"
            //                        objAddPhoto.alertTitle="Club Service"
            //                    }
            //                    if self.GetModuleName == "Club Service"
            //                    {
            ////                        club to service
            //                        objAddPhoto.strWitchType = "Service Projects"
            //                        objAddPhoto.moduleId = "52"
            //                        objAddPhoto.alertTitle="Service Projects"
            //                        objAddPhoto.isFromMoveToService = "yes"
            //                    }
            //
            //
            //                            self.navigationController?.pushViewController(objAddPhoto, animated: true)
            //
            ////                    }
            ////                    {
            //
            //
            ////                    }
            //
            //                }
            //
            //                let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
            //                    print("The user is not okay.")
            //                }
            //
            //                // Add Actions
            //                alertController.addAction(yesAction)
            //                alertController.addAction(noAction)
            //
            //                // Present Alert Controller
            //                self.present(alertController, animated: true, completion: nil)
            //                }
        }
        else{
            if(self.GetIsCategoryFromClubOrDistrict=="2"){
                let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this \(pageTitle)", preferredStyle: .alert)
                
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
                
                
                self.getDataForMoveNDeleteProject(index: sender.tag)
                
                //
                //            let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this \(pageTitle)", preferredStyle: .alert)
                //
                //            // Initialize Actions
                //            let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
                //                print("The user is okay.")
                //                self.buttonOpticity.alpha = 1.0
                //                self.viewForConfirmation.isHidden = true
                //                let row = sender.tag
                //                print("Row: \(row)")
                //                print(self.muarrayListData)
                //                //let dict:NSDictionary = (muarrayListData.object(at: row) as! NSDictionary)
                //                self.varGetAlbumID=(self.muarrayListData.value(forKey: "type") as AnyObject).object(at: sender.tag) as! String
                //                self.varGetAlbumIDForDelete = (self.muarrayListData.value(forKey: "albumId") as AnyObject).object(at: sender.tag) as! String
                //                print(self.varGetAlbumID)
                //                print(self.varGetAlbumIDForDelete)
                //                self.buttonOpticity.alpha = 0.0
                //                self.viewForConfirmation.isHidden = true
                //                self.functionForDeleteAlbum()
                //            }
                //
                //            let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
                //                print("The user is not okay.")
                //            }
                //
                //            // Add Actions
                //            alertController.addAction(yesAction)
                //            alertController.addAction(noAction)
                //
                //            // Present Alert Controller
                //            self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func selectProjtypeBtnClickeddd(_ sender: UIButton) {
        let fID=(muarrayListData.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: sender.tag) as! String
        print(fID)
        
        if ((muarrayListData.value(forKey: "OnetimeOrOngoing") as AnyObject).object(at: sender.tag) as! String) == "1" {
            self.view .makeToast("No sub-project found")
            
        }
        //                || !((muarrayListData.value(forKey: "title") as AnyObject).object(at: indexPath.row) as! String).isEmpty
        else if ((muarrayListData.value(forKey: "OnetimeOrOngoing") as AnyObject).object(at:sender.tag) as! String) == "2"
        {
            //                    if let title = object.title, !title.isEmpty
            
            if fID == "" {
                self.view .makeToast("No sub-project found")
            }
            else{
                ongoingProjTitleeLbl .setTitle((muarrayListData.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: sender.tag) as! String, for: UIControl.State.normal)
                let albumId = (muarrayListData.value(forKey: "albumId") as AnyObject).object(at: sender.tag) as! String
                //            varGetAlbumID = albumId
                print(albumId)
                //          var newselectedDict1:[String: String] = [:]
                //            newselectedDict1 =  muarrayListData[sender.tag] as? [String: Any]
                //            newselectedDict .addEntries(from: newselectedDict1)
                //            print(newselectedDict)
                //            functionForNewMemberWhenDataComingNotZipFile(_ dd:NSDictionary)
                
                getSubProjectListing(str: albumId as NSString)
                
                //            selectProjjWalaViewTbl = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
                //            selectProjjWalaViewTbl.center = self.view.center
                ongoingProjTitleeLbl.layer.borderWidth = 1.0
                ongoingProjTitleeLbl.layer.borderColor = UIColor .lightGray.cgColor
                ongoingProjTitleeLbl.layer.cornerRadius = 5
                
                selectProjjWalaViewTbl.isHidden = false
                
                selectProjjWalaViewTbl.layer.shadowColor = UIColor.gray.cgColor
                selectProjjWalaViewTbl.layer.shadowOpacity = 1
                selectProjjWalaViewTbl.layer.cornerRadius  = 10.0
                selectProjjWalaViewTbl.layer.shadowOffset = CGSize.zero
                selectProjjWalaViewTbl.layer.shadowRadius = 5
            }
            
        }
        
    }
    
    @IBAction func crossBtnClocked(_ sender: Any) {
        selectProjjWalaViewTbl.isHidden = true
        //            buttonOpticity.alpha = 0.0
        //            self.view.alpha = 1.0
        //            self.selectProjjWalaViewTbl.isHidden = true
        //viewClubListShow.backgroundColor = UIColor.whiteColor()
        //            buttonOpticity.alpha = 0.0
        //            self.selectProjjWalaViewTbl.alpha = 1.0
        //            viewForConfirmation.isHidden = true
        //            self.selectProjjWalaViewTbl .removeFromSuperview()
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
        SVProgressHUD.show()
        self.tableShowCaseList.isHidden=true
        self.loadingLabel.isHidden=false
        self.loadingLabel.text="Loading... Please Wait"
        self.buttonNoResult.isHidden=true
        if(self.GetIsCategoryFromClubOrDistrict=="2"){
            
            if(strClubeorRot == "District Events"){
                ClubeRotaryType = "0"
            }else if(strClubeorRot == "Vocational service"){
                ClubeRotaryType = "2"
            }else if(strClubeorRot == "International service"){
                ClubeRotaryType = "3"
            }else if(strClubeorRot == "Public Image Initiative"){
                ClubeRotaryType = "5"
            } else if(strClubeorRot == "New Generation service"){
                ClubeRotaryType = "4"
            }
            else{
                ClubeRotaryType = "1"
            }
        }else{
            self.getDistrctId = "0"
            if(strClubeorRot == "Club Service"){
                ClubeRotaryType = "0"
                GetIsCategoryFromClubOrDistrict = "0"
            }else if(strClubeorRot == "Club Service"){
                ClubeRotaryType = "0"
                GetIsCategoryFromClubOrDistrict = "0"
            }else if(strClubeorRot == "Vocational service"){
                ClubeRotaryType = "2"
                GetIsCategoryFromClubOrDistrict = "1"
            }else if(strClubeorRot == "International service"){
                ClubeRotaryType = "3"
                GetIsCategoryFromClubOrDistrict = "3"
            } else if(strClubeorRot == "Public Image Initiative"){
                ClubeRotaryType = "5"
                GetIsCategoryFromClubOrDistrict = "5"
            } else if(strClubeorRot == "New Generation service"){
                ClubeRotaryType = "4"
                GetIsCategoryFromClubOrDistrict = "4"
            }
            else {
                ClubeRotaryType = "1"
                GetIsCategoryFromClubOrDistrict = "1"
            }
            
        }
        
        //            http://rowtestapi.rosteronwheels
        //            let completeURL = baseUrl+"Gallery/GetAlbumsList_New"
        let completeURL = "http://rotaryindiaapi.rosteronwheels.com/api/Gallery/GetAlbumsList_New"
        var parameterst:NSDictionary=NSDictionary()
        if(self.varIsCallFrom=="ShowCaseFromDashBoard")
        {
            parameterst = [
                "groupId":"0",
                "district_id":self.getDistrctId as Any,
                "club_id":self.getClubId,
                "category_id":self.getCategoryIds,
                "year": textfieldYear.text as Any,
                "SharType":"0",
                "profileId":"",
                "moduleId":""
            ]
        }
        else
        {
            //MARK:Old paramters before April 27 2020
            //parameterst =  ["groupId":self.getGroupId,
            //"district_id":"0",
            //"club_id":"0",
            //"category_id":GetIsCategoryFromClubOrDistrict as Any,
            //"year": textfieldYear.text as Any,
            //"SharType":"1",
            //"profileId":self.GetUserProfileID,
            //"moduleId":self.getModuleID,
            //"ClubRotaryType":ClubeRotaryType as Any,
            //"searchText":""]
            //}
            //MARK:New parameter after April 27 2020
            parameterst =  ["groupId":self.getGroupId,
                            "year": textfieldYear.text as Any,
                            "SharType":ClubeRotaryType as Any,
                            "moduleId":self.getModuleID,
                            "searchText":""]
        }
        
        
        
        print("ttttt: \(parameterst)")
        print("ccccuuurrrll : \(completeURL)")
        let bytes = try! JSONSerialization.data(withJSONObject: parameterst, options: JSONSerialization.WritingOptions.prettyPrinted)
        //  var jsonObj = try! JSONSerialization.jsonObject(with: bytes, options: .mutableLeaves)
        if let str = String(data: bytes, encoding: String.Encoding.utf8)
        {
            
            print("<<-----------------------------json start----------------------------->>")
            print(completeURL)
            print(str)
            print("<<-----------------------------json end------------------------------->>")
            
        }
        else
        {
            print("not a valid UTF-8 sequence")
        }
        
        
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url:completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            //print("dd \(dd)")
            self.muarrayListData = NSMutableArray()
            self.muarrayMainList = NSMutableArray()
            
            print(response)
            let varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                print("Loading close @ 5")
                SVProgressHUD.dismiss()
                self.loadingLabel.text="Could not connect to the server."
            }
            else
            {
                if((dd.object(forKey: "TBAlbumsListResult")! as AnyObject).object(forKey: "status") as! String == "0")
                {
                    /* MemberCount = 55;
                     TotalList = "<null>";
                     deletedAlbums = "<null>";
                     maxBeneficiaries = 500;
                     newAlbums = */
                    let arrarrNewGroupList = (((dd.object(forKey: "TBAlbumsListResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "newAlbums")) as! NSArray
                    
                    if let TBAlbumsListResult=dd.object(forKey: "TBAlbumsListResult") as? NSDictionary
                    {
                        if let memberCount=TBAlbumsListResult.value(forKey: "MemberCount") as? String
                        {
                            self.MemberCount=memberCount
                        }
                        if let benificiaryCount=TBAlbumsListResult.value(forKey: "MaxBeneficiaries") as? String
                        {
                            self.BenificiaryCount=benificiaryCount
                        }
                    }
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
                        self.buttonNoResult.setTitle("No record found.",  for: UIControl.State.normal)
                        print("Loading close @ 1")
                        SVProgressHUD.dismiss()
                    }
                    self.loadingLabel.isHidden=true
                }
                else
                {
                    self.tableShowCaseList.isHidden = true
                    print("Loading close @ 2")
                    SVProgressHUD.dismiss()
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                    self.loadingLabel.text="Could not connect to the server."
                }
            }
            
        })
        
    }
    
    var  userID:String! = nil
    func functionForDeleteAlbum()
    
    {
        SVProgressHUD.show()
        userID = GetUserProfileID
        
        //            [typeID=686, type=Gallery, profileID=581428, Financeyear=2021-2022]
        
        var params:NSDictionary=NSDictionary()
        params = ["typeID": self.varGetAlbumIDForDelete!, "type": "Gallery" , "profileID": self.userID!,"Financeyear":textfieldYear.text as Any,]
        
        /*-------------------------------------------------------------*/
        
        let url = URL(string: baseUrl+touchbase_DeleteAlbum)!
        
        print(url)
        
        print(params)
        
        Alamofire.request(url, method: .post, parameters: params as! Parameters, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
            
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
                        SVProgressHUD.dismiss()
                        print("Hello Filed")
                        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                    }
                    
                    else
                    {
                        self.view.makeToast("\(self.pageTitle) Deleted successfully.", duration: 2, position: CSToastPositionCenter)
                        self.functionForFetchingAlbumListData()
                    }
                    //SVProgressHUD.dismiss()
                }
            case .failure(_): break
            }
        }
    }
    
    func getDataForMoveNDeleteProject(index:NSInteger)
    {
        //        SVProgressHUD.show()
        //        userID = GetUserProfileID
        
        
        //        let params = ["GallaryId": str]
        
        var params:NSDictionary=NSDictionary()
        //        if(self.varIsCallFrom=="ShowCaseFromDashBoard")
        //        {
        let gallaryID1 = (self.muarrayListData.value(forKey: "albumId") as AnyObject).object(at: index) as! String
        
        print(gallaryID1)
        
        params = [
            "GallaryId":gallaryID1,
            "FinancialYear":textfieldYear.text as Any,
            
        ]
        //        }
        
        
        
        
        //        let params = ["GallaryId": "174425", "FinancialYear": [textfieldYear.text] as [String : Any]
        /*-------------------------------------------------------------*/
        
        //        let url = URL(string: baseUrl+touchbase_DeleteAlbum)!
        
        let url = "http://rotaryindiaapi.rosteronwheels.com/api/Gallery/projectmove"
        print(url)
        
        print(params)
        
        Alamofire.request(url, method: .post, parameters: params as! Parameters, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
            
            switch response.result {
                
            case .success:
                
                // var result = [String:String]()
                
                if response.result.value != nil
                    
                {
                    print( response.result.value)
                    
                    var dictResponseData:NSDictionary=NSDictionary()
                    //                    let dd = response as! NSDictionary
                    dictResponseData = response.result.value as! NSDictionary
                    
                    print(dictResponseData)
                    
                    
                    
                    
                    let message = (dictResponseData.value(forKey: "ProjResult")! as AnyObject)as! NSDictionary
                    
                    print(message)
                    //                    let message1 = (message.value(forKey: "SubCount") as AnyObject).object(at: 0) as! String
                    
                    let message1 = (dictResponseData.value(forKey: "ProjResult")! as AnyObject).value(forKey: "Table")as! NSArray
                    
                    let message2 =   (message1.value(forKey: "SubCount") as AnyObject).object(at: 0) as! NSNumber
                    print(message1)
                    print(message2)
                    
                    //                    CheckMoveToClub
                    if self.CheckMoveToClub == "yes" {
                        if(message2 == 0)
                            
                        {
                            
                            var alertController = UIAlertController(title: "", message: "Are you sure you want to move this \(self.pageTitle)", preferredStyle: .alert)
                            if self.GetModuleName == "Service Projects"
                            {
                                //                        service to club
                                alertController = UIAlertController(title: "", message: "Are you sure you want to move this service project to club meeting", preferredStyle: .alert)
                            }
                            if self.GetModuleName == "Club Service"
                            {
                                //                        club to service
                                alertController = UIAlertController(title: "", message: "Are you sure you want to move this club meeting to service project", preferredStyle: .alert)
                                
                            }
                            
                            
                            
                            // Initialize Actions
                            let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
                                
                                
                                print("The user is okay.")
                                self.buttonOpticity.alpha = 1.0
                                self.viewForConfirmation.isHidden = true
                                let row = index
                                print("Row: \(row)")
                                print(self.muarrayListData)
                                //let dict:NSDictionary = (muarrayListData.object(at: row) as! NSDictionary)
                                self.varGetAlbumID=(self.muarrayListData.value(forKey: "type") as AnyObject).object(at: index) as! String
                                self.GetGroupID = (self.muarrayListData.value(forKey: "groupId") as AnyObject).object(at: index) as! String
                                //                    print(self.muarrayListData.objects(at: sender.tag))
                                self.varGetAlbumIDForDelete = (self.muarrayListData.value(forKey: "albumId") as AnyObject).object(at: index) as! String
                                self.GetModuleID =  (self.muarrayListData.value(forKey: "moduleId") as AnyObject).object(at: index) as! String
                                print(self.varGetAlbumID)
                                print(self.varGetAlbumIDForDelete)
                                //                    self.getMoveToClubData()
                                self.buttonOpticity.alpha = 0.0
                                self.viewForConfirmation.isHidden = true
                                //                    self.functionForDeleteAlbum()
                                //                    {
                                let objAddPhoto = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotoNewVC") as! AddPhotoNewVC
                                
                                
                                
                                
                                print(self.GetAlbumID)
                                objAddPhoto.strAlbumId = self.varGetAlbumIDForDelete
                                objAddPhoto.strGroupId = self.getGroupId
                                objAddPhoto.strcreatedBy = self.GetUserProfileID
                                objAddPhoto.titleRIZone = self.titleRIZone
                                //                        objAddPhoto.moduleId = self.GetModuleID
                                //                    self.CheckMoveToClub = ""
                                //                    self.ChekDel = ""
                                //                                textfieldYear.text as Any as! String
                                objAddPhoto.year=self.textfieldYear.text as Any as! String
                                objAddPhoto.isCalledFRom = "Edit"
                                objAddPhoto.objProtocolNameNew=self
                                objAddPhoto.MemberCount = self.MemberCount
                                objAddPhoto.BenificiaryCount = self.BenificiaryCount
                                objAddPhoto.checkString = "Club Service"
                                if self.GetModuleName == "Service Projects"
                                {
                                    //                        service to club
                                    
                                    objAddPhoto.isFromMoveToClub = "yes"
                                    objAddPhoto.strWitchType = "Club Service"
                                    objAddPhoto.moduleId = "8"
                                    objAddPhoto.alertTitle="Club Service"
                                }
                                if self.GetModuleName == "Club Service"
                                {
                                    //                        club to service
                                    objAddPhoto.strWitchType = "Service Projects"
                                    objAddPhoto.moduleId = "52"
                                    objAddPhoto.alertTitle="Service Projects"
                                    objAddPhoto.isFromMoveToService = "yes"
                                }
                                
                                
                                self.navigationController?.pushViewController(objAddPhoto, animated: true)
                                
                                //                    }
                                //                    {
                                
                                
                                //                    }
                                
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
                        
                        else
                        {
                            //                        SVProgressHUD.dismiss()
                            print("Hello Filed")
                            self.view.makeToast("This is main project, You can not move this project.", duration: 2, position: CSToastPositionCenter)
                        }
                    }
                    
                    else{
                        
                        //                        {
                        if(message2 == 0)
                        {
                            
                            let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this \(self.pageTitle)", preferredStyle: .alert)
                            
                            // Initialize Actions
                            let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
                                print("The user is okay.")
                                self.buttonOpticity.alpha = 1.0
                                self.viewForConfirmation.isHidden = true
                                let row = index
                                print("Row: \(row)")
                                print(self.muarrayListData)
                                //let dict:NSDictionary = (muarrayListData.object(at: row) as! NSDictionary)
                                self.varGetAlbumID=(self.muarrayListData.value(forKey: "type") as AnyObject).object(at: index) as! String
                                self.varGetAlbumIDForDelete = (self.muarrayListData.value(forKey: "albumId") as AnyObject).object(at: index) as! String
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
                        
                        else
                        {
                            //                        SVProgressHUD.dismiss()
                            print("Hello Filed")
                            self.view.makeToast("This is main project, You can not delete this project.", duration: 2, position: CSToastPositionCenter)
                        }
                        //                        }
                        
                        
                        
                    }
                    
                    //SVProgressHUD.dismiss()
                }
            case .failure(_): break
            }
        }
    }
    
    
    
    func getMoveToClubData()
    {
        //        SVProgressHUD.show()
        //        userID = GetUserProfileID
        
        
        
        print(self.varGetAlbumIDForDelete)
        let params = ["GallaryId":self.varGetAlbumIDForDelete,"type":"1"]
        //        let params = ["GallaryId":"70","type":"1"]
        //        {"GallaryId":"70","type":"1"}
        /*-------------------------------------------------------------*/
        
        //        let url = URL(string: baseUrl+touchbase_DeleteAlbum)!
        //        http://rowapi.rosteronwheels
        let url = "http://rotaryindiaapi.rosteronwheels.com/api/Gallery/projectmove"
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
                    //                    let dd = response as! NSDictionary
                    dictResponseData = response.result.value as! NSDictionary
                    
                    print(dictResponseData)
                    
                    
                    
                    
                    let message = (dictResponseData.value(forKey: "message")! as AnyObject)as! String
                    
                    if(message=="success")
                        
                    {
                        let objAddPhoto = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotoNewVC") as! AddPhotoNewVC
                        
                        print(self.GetAlbumID)
                        objAddPhoto.year=self.textfieldYear.text as Any as! String
                        objAddPhoto.strAlbumId = self.GetAlbumID
                        objAddPhoto.strGroupId = self.getGroupId
                        objAddPhoto.strcreatedBy = self.GetUserProfileID
                        objAddPhoto.moduleId = self.GetModuleID
                        objAddPhoto.titleRIZone = self.titleRIZone
                        objAddPhoto.isCalledFRom = "Edit"
                        objAddPhoto.objProtocolNameNew=self
                        objAddPhoto.MemberCount = self.MemberCount
                        objAddPhoto.BenificiaryCount = self.BenificiaryCount
                        objAddPhoto.checkString = self.strWhichType
                        objAddPhoto.strWitchType = self.strWhichType
                        objAddPhoto.alertTitle=self.pageTitle
                        self.navigationController?.pushViewController(objAddPhoto, animated: true)
                        
                    }
                    
                    else
                    {
                        //                        SVProgressHUD.dismiss()
                        print("Hello Filed")
                        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                    }
                    //SVProgressHUD.dismiss()
                }
            case .failure(_): break
            }
        }
    }
    func getSubProjectListing(str:NSString)
    {
        //        SVProgressHUD.show()
        //        userID = GetUserProfileID
        
        
        
        var params:NSDictionary=NSDictionary()
        params = ["GallaryId": str,"FinancialYear":textfieldYear.text as Any]
        
        /*-------------------------------------------------------------*/
        
        //        let url = URL(string: baseUrl+touchbase_DeleteAlbum)!
        
        let url = "http://rotaryindiaapi.rosteronwheels.com/api/Gallery/GetSubProjectOfOngoing"
        print(url)
        
        print(params)
        
        Alamofire.request(url, method: .post, parameters: params as! Parameters, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
            
            switch response.result {
                
            case .success:
                
                // var result = [String:String]()
                
                if response.result.value != nil
                    
                {
                    print( response.result.value)
                    
                    var dictResponseData:NSDictionary=NSDictionary()
                    //                    let dd = response as! NSDictionary
                    dictResponseData = response.result.value as! NSDictionary
                    
                    print(dictResponseData)
                    
                    self.arrarrNewGroupList1=NSArray()
                    
                    
                    let message = (dictResponseData.value(forKey: "message")! as AnyObject)as! String
                    
                    if(message=="success")
                        
                    {
                        self.arrarrNewGroupList1 = ((dictResponseData.object(forKey: "SubProjResult")! as AnyObject).object(forKey: "Table")) as! NSArray
                        print(self.arrarrNewGroupList1)
                        //                        let arrarrNewGroupList = (((dictResponseData.object(forKey: "SubProjResult")! as AnyObject).object(forKey: "Table")) as! NSArray
                        self.selctProjTbleView .reloadData()
                        //                        tableView.reloadData()
                        //                        self.selctProjTbleView.layoutIfNeeded()
                        //                        self.selctProjTbleView.heightAnchor.constraint(equalToConstant: self.selctProjTbleView.contentSize.height).isActive = true
                    }
                    
                    else
                    {
                        //                        SVProgressHUD.dismiss()
                        print("Hello Filed")
                        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                    }
                    //SVProgressHUD.dismiss()
                }
            case .failure(_): break
            }
        }
    }
    //--Floating button isAdminImage("Album_add_blue")
    func functiuonFloatingButton()
    {
        if(self.GetIsCategoryFromClubOrDistrict == "2"){
            let addAlbum = UIImage(named: "Album_add_blue.png")!
            let deleteAlbum = UIImage(named: "Album_delete_blue.png")!
            let phonebook = ActionButtonItem(title: "Add "+pageTitle, image: addAlbum)
            
            phonebook.action =
            {
                item in
                print("Twitter...")
                if self.BenificiaryCount.count > 0{
                    self.actionButton?.toggle()
                    self.clearSearchView()
                    self.isAddButtonClick=true
                    let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "DistAddPhotoNewVC") as! DistAddPhotoNewVC
                    albumControllerObject.strAlbumId = ""
                    albumControllerObject.strGroupId = self.getGroupId
                    albumControllerObject.moduleId = self.getModuleID
                    albumControllerObject.isCalledFRom = "add"
                    albumControllerObject.categoryId = ""
                    albumControllerObject.strcreatedBy = self.GetUserProfileID
                    albumControllerObject.MemberCount=self.MemberCount
                    albumControllerObject.BenificiaryCount=self.BenificiaryCount
                    albumControllerObject.alertTitle=self.pageTitle
                    albumControllerObject.strWitchType=self.GetModuleName
                    albumControllerObject.year = self.textfieldYear.text
                    
                    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                        
                        self.navigationController?.pushViewController(albumControllerObject, animated: true)
                        
                    }
                    else
                    {
                        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                        
                    }
                    
                }  else
                {
                    self.view.makeToast("Loading... Please Wait..", duration: 2, position: CSToastPositionCenter)
                }
            }
            
            let invitation = ActionButtonItem(title: "Delete "+pageTitle, image: deleteAlbum)
            invitation.action =
            {
                item in
                print("Google Plus...")
                self.actionButton?.toggle()
                self.clearSearchView()
                self.isAddButtonClick=true
                let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseAlbumListVC") as! ShowCaseAlbumListVC
                albumControllerObject.ChekDel = "yes"
                //        self.ChekDel = "yes"
                albumControllerObject.getGroupId = self.getGroupId
                albumControllerObject.GetIsCategoryFromClubOrDistrict = self.GetIsCategoryFromClubOrDistrict
                albumControllerObject.getYear =  self.getYear
                albumControllerObject.GetUserProfileID = self.GetUserProfileID
                albumControllerObject.getModuleID = self.getModuleID
                albumControllerObject.strClubeorRot = self.strClubeorRot
                albumControllerObject.GetModuleName=self.GetModuleName
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
            actionButton?.action = { button in button.toggleMenu() }
            actionButton?.setTitle("+", forState: UIControl.State.normal)
            // actionButton.textAlignment = NSTextAlignment.Center
            actionButton?.backgroundColor = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha:1.0)
        }else{
            //    Image("clubToService")
            
            let addAlbum = UIImage(named: "Album_add_blue.png")!
            let deleteAlbum = UIImage(named: "Album_delete_blue.png")!
            var moveToClub = UIImage(named: "serviceToClub")
            if self.GetModuleName == "Club Service" {
                moveToClub = UIImage(named: "clubToService")
            }
            else{
                moveToClub = UIImage(named: "serviceToClub")
            }
            //    Image("service_prj")
            //    Image("serviceToClub")
            
            let phonebook = ActionButtonItem(title: addFloatBtn, image: addAlbum)
            phonebook.action =
            {
                item in print("Twitter...")
                if self.BenificiaryCount.count > 0{
                    self.actionButton?.toggle()
                    self.addBtnAlertPopup()
                    //             let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotoNewVC") as! AddPhotoNewVC
                    //             albumControllerObject.year=self.textfieldYear.text as Any as! String
                    //             albumControllerObject.strAlbumId = ""
                    //             albumControllerObject.strGroupId = self.getGroupId
                    //             albumControllerObject.moduleId = self.getModuleID
                    //             albumControllerObject.isCalledFRom = "add"
                    //             albumControllerObject.categoryId = ""
                    //             albumControllerObject.strcreatedBy = self.GetUserProfileID
                    //             albumControllerObject.MemberCount=self.MemberCount
                    //             albumControllerObject.BenificiaryCount=self.BenificiaryCount
                    //             albumControllerObject.alertTitle=self.pageTitle
                    //             albumControllerObject.strWitchType=self.GetModuleName
                    //             albumControllerObject.navTitle = "Club Service"
                    //             albumControllerObject.isAddProject = true
                    //             if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
                    //                 self.navigationController?.pushViewController(albumControllerObject, animated: true)
                    //             }
                    //
                    //  else
                    //  {
                    //       self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                    //          }
                }
                else
                {
                    self.view.makeToast("Loading... Please Wait..", duration: 2, position: CSToastPositionCenter)
                    
                }
            }
            
            let invitation = ActionButtonItem(title: delFloatBtn, image: deleteAlbum)
            invitation.action =
            {
                item in
                print("Google Plus...")
                self.actionButton?.toggle()
                self.clearSearchView()
                self.isAddButtonClick=true
                let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseAlbumListVC") as! ShowCaseAlbumListVC
                albumControllerObject.ChekDel = "yes"
                albumControllerObject.getGroupId = self.getGroupId
                albumControllerObject.GetIsCategoryFromClubOrDistrict = self.GetIsCategoryFromClubOrDistrict
                albumControllerObject.getYear =  self.getYear
                albumControllerObject.GetUserProfileID = self.GetUserProfileID
                albumControllerObject.getModuleID = self.getModuleID
                albumControllerObject.strClubeorRot = self.strClubeorRot
                albumControllerObject.GetModuleName=self.GetModuleName
                albumControllerObject.hideFloatButtonDelegate = self
                if self.getModuleID == "8" {
                    albumControllerObject.avenueShareType = "0"
                } else if self.getModuleID == "52" {
                    albumControllerObject.avenueShareType = "1"
                } else if self.getModuleID == "79" {
                    albumControllerObject.avenueShareType = "2"
                } else if self.getModuleID == "80" {
                    albumControllerObject.avenueShareType = "3"
                } else if self.getModuleID == "81" {
                    albumControllerObject.avenueShareType = "4"
                } else if self.getModuleID == "82" {
                    albumControllerObject.avenueShareType = "5"
                }
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
            //    Image("moveToclub")
            
            print(self.GetModuleName)
            var serviceToClub = ActionButtonItem(title: "Move to club meeting", image: moveToClub)
            if self.GetModuleName == "Service Projects" {
                serviceToClub = ActionButtonItem(title: "Move to club meeting", image: moveToClub)
            }
            else{
                serviceToClub = ActionButtonItem(title: "Move to service projects", image: moveToClub)
            }
            
            serviceToClub.action =
            {
                item in
                print("Google Plus...")
                self.clearSearchView()
                self.isAddButtonClick=true
                let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseAlbumListVC") as! ShowCaseAlbumListVC
                albumControllerObject.CheckMoveToClub = "yes"
                albumControllerObject.getGroupId = self.getGroupId
                albumControllerObject.GetIsCategoryFromClubOrDistrict = self.GetIsCategoryFromClubOrDistrict
                albumControllerObject.getYear =  self.getYear
                albumControllerObject.GetUserProfileID = self.GetUserProfileID
                albumControllerObject.getModuleID = self.getModuleID
                albumControllerObject.strClubeorRot = self.strClubeorRot
                albumControllerObject.GetModuleName=self.GetModuleName
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
            actionButton?.action = { button in button.toggleMenu() }
            //actionButton.setTitle("+", forState: UIControl.State.normal)
            // actionButton.textAlignment = NSTextAlignment.Center
            actionButton?.backgroundColor = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha:1.0)
            
        }
    }
    func addBtnAlertPopup() {
        var alertController: UIAlertController?
        let avenueShareTypeForPopup = self.avenueShareType
        
        switch avenueShareTypeForPopup {
        case "0":
            alertController =   UIAlertController(title: "", message: """
   The data I will enter is for a Meeting / Event conducted by my. E.g., Installation, Navratri Celebration, Weekly Meetings, Etc.
 
   It is not a Community / Vocational / International / New Generation Service. E.g., Blood Donation Camp, Tree Plantation, Heart Surgeries, etc.
 
 Please Note : The content posted here will be displayed on the \(titleRIZone) Website, District Website, Club Monthly Report and \(titleRIZone) Integrated Club Website.
 """, preferredStyle: .alert)
            
        case "1":
            alertController =   UIAlertController(title: "", message: """
   The data I will enter is for a Community service project conducted by my club that has benefitted my community. E.g., Heart Surgeries, Tree Plantation, etc.
 
   It is not a club meeting, fellowship meeting, club celebration or any other miscellaneous event or Project. E.g., Doctor’s day celebration, Birthday and Anniversary celebration of members, Navratri Celebration, etc
 
 Please Note : The content posted here will be displayed on the \(titleRIZone) Website, District Website, Club Monthly Report and \(titleRIZone) Integrated Club Website.
 """, preferredStyle: .alert)
            
        case "2":
            alertController =   UIAlertController(title: "", message: """
   The data I will enter is for a Vocational service project conducted by my club that has benefitted my community. E.g., Career Guidance and Skill Development, Computer Literacy, etc.
 
   It is not a club meeting, fellowship meeting, club celebration or any other miscellaneous event or Project. E.g., Doctor’s day celebration, Birthday and Anniversary celebration of members, Blood Donation Camp, etc.
 
 Please Note : The content posted here will be displayed on the \(titleRIZone) Website, District Website, Club Monthly Report and \(titleRIZone) Integrated Club Website.
 """, preferredStyle: .alert)
            
        case "3":
            alertController =   UIAlertController(title: "", message: """
   The data I will enter is for an International Service Project conducted by my club that has benefitted my community. E.g., Rotary Youth Exchange, Rotary Friendship Exchange, etc.
 
   It is not a club meeting, fellowship meeting, club celebration or any other miscellaneous event or Project. E.g. Doctor’s day celebration, Birthday and Anniversary celebration of members, Blood Donation Camp, etc.
 
 Please Note : The content posted here will be displayed on the \(titleRIZone) Website, District Website, Club Monthly Report and \(titleRIZone) Integrated Club Website.
 """, preferredStyle: .alert)
            
        case "4":
            alertController =   UIAlertController(title: "", message: """
   The data I will enter is for a New generation Service Project conducted by my club that has benefitted my community. E.g., Formation of an Interact Club, Formation of a Rotaract Club, etc.
 
   It is not a club meeting, fellowship meeting, club celebration or any other miscellaneous event or Project. E.g., Doctor’s day celebration, Birthday and Anniversary celebration of members, Blood Donation Camp, etc.
 
 Please Note : The content posted here will be displayed on the \(titleRIZone) Website, District Website, Club Monthly Report and \(titleRIZone) Integrated Club Website.
 """, preferredStyle: .alert)
            
        case "5":
            alertController =   UIAlertController(title: "", message: """
   The data I will enter is for a Public Image Initiative conducted by my club. E.g., Hoardings, Marathons, Rotary Stories on News Papers / Radio / TV ads, etc.
 
   It is not a club meeting, fellowship meeting, club celebration or any other miscellaneous event or Project. E.g., Doctor’s day celebration, Birthday and Anniversary celebration of members, Blood Donation Camp, etc.
 
 Please Note : The content posted here will be displayed on the \(titleRIZone) Website, District Website, Club Monthly Report and \(titleRIZone) Integrated Club Website.
 """, preferredStyle: .alert)
            
        default:
             break
        }
        // Create the actions
        let okAction = UIAlertAction(title: "I Agree", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.clearSearchView()
            self.isAddButtonClick=true
          
            self.addcommunity()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController?.addAction(okAction)
        //        alertController.addAction(cancelAction)
        
        // Present the controller
        if let alert = alertController {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func addcommunity() {
        SVProgressHUD.show()
        let url = "http://rotaryindiaapi.rosteronwheels.com/api/Gallery/GetWebAdminAvenueofServicelink"
//                if let masterID = masterUId, let loginType = varGetLoginType, let mobile = varGetMobileNumber {
        if let grpID = getGroupId, let pro = GetUserProfileID, let sharetyp = self.avenueShareType {
            let parameterst = ["Fk_groupID":grpID,"fk_ProfileID":pro,"sharetype":sharetyp,"AlbumID": "0","Projectyear": textfieldYear.text as Any as! String]
            print("Club Online CO<Dashboard parameterst:: \(parameterst)")
            print("Club Online CO<Dashboard completeURL:: \(url)")
            
            //------------------------------------------------------
            Alamofire.request(url, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    
                    
                    if let value = response.result.value {
                        do {
                            // Attempt to decode the JSON data
                            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode(AddCOM.self, from: jsonData)
                            SVProgressHUD.dismiss()
                            print("ListSyncOnline:--- \(decodedData)")
                            self.addCOMM = decodedData
                            if self.addCOMM?.adminSubmodulesResult?.status == "0" {
                              
                                
                                let editProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
                                editProfileScreen.url = self.addCOMM?.adminSubmodulesResult?.list?[self.inddd].url ?? ""
                                editProfileScreen.moduleName = self.avenueTitle
                                editProfileScreen.varFromCalling = "Avenue Service"
                                editProfileScreen.hideFloatButtonDelegate = self
                                print(editProfileScreen.url)
                                self.navigationController?.pushViewController(editProfileScreen, animated: true)
                               
                            }
                        }
                        catch {
                            print("Error decoding JSON: \(error)")
                        }
                    }
                case .failure(_): break
                }
            }
        }
//        }
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
    }
}
extension ShowCaseAlbumListVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
        
        
        varGetSearchText = textField.text!
        print(varGetSearchText)
        if(textField.text?.count ?? 0>0)
        {
            if(varIsCallFrom=="ShowCaseFromDashBoard")
            {
                let predicate =  NSPredicate(format: "title contains[c] %@ OR clubname contains[c] %@", varGetSearchText)
                let searchDataSource = muarrayMainList?.filtered(using: predicate)
                muarrayListData=searchDataSource as? NSArray ?? []
                print(muarrayListData)
                self.tableShowCaseList.reloadData()
                if (muarrayListData.count == 0){
                    noRecorLbl.isHidden = false
                }else{
                    noRecorLbl.isHidden = true
                }
            }
            else
            {
//                let predicate =  NSPredicate(format: "title contains[c] %@ OR description contains[c] %@", varGetSearchText)
//                let searchDataSource = muarrayMainList.filtered(using: predicate)
//                muarrayListData=searchDataSource as NSArray
//                print(muarrayListData)
//                self.tableShowCaseList.reloadData()
                if let varGetSearchText = varGetSearchText {

                let predicate = NSPredicate(format: "title contains[c] %@ OR description contains[c] %@", varGetSearchText, varGetSearchText)

                if let muarrayMainList = muarrayMainList {
                    let searchDataSource = muarrayMainList.filtered(using: predicate) as NSArray
                    muarrayListData = searchDataSource
                    print(muarrayListData)

                    DispatchQueue.main.async {
                        self.tableShowCaseList.reloadData()
                    }
                }
                }

                if (muarrayListData.count == 0){
                    noRecorLbl.isHidden = false
                }else{
                    noRecorLbl.isHidden = true
                }
            }
        }
        return textField == searchCommunityServiceTF
    }
}

extension ShowCaseAlbumListVC: HideFloatButton {
    func hideFloatAction() {
        self.actionButton?.toggle()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == searchCommunityServiceTF) {
            pickerViews.isHidden = true
            pikerClubeView.isHidden = true
        } else {
            pickerViews.isHidden = false
            pikerClubeView.isHidden = false
        }
    }
}

struct AddCOM: Codable {
    let adminSubmodulesResult: AdminSubmodulesResult?

    enum CodingKeys: String, CodingKey {
        case adminSubmodulesResult = "AdminSubmodulesResult"
    }
}

// MARK: - AdminSubmodulesResult
struct AdminSubmodulesResult: Codable {
    let status, message: String?
    let list: [List]?
}

// MARK: - List
struct List: Codable {
    let moduleID, title: String?
    let imgurl: String?
    let url: String?
    let userName, pass, fkCountryID, sharetype: String?

    enum CodingKeys: String, CodingKey {
        case moduleID = "ModuleID"
        case title = "Title"
        case imgurl, url
        case userName = "UserName"
        case pass = "Pass"
        case fkCountryID = "fk_countryID"
        case sharetype
    }
}
