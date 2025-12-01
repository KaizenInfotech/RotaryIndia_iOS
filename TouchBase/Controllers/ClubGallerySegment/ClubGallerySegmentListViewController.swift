//
//  ClubGallDFGDGerySegmentListViewController.swift
//  TouchBase
//
//  Created by rajendra on 01/08/17.
//  Copyright © 2017 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
//import Kingfisher
import SDWebImage
import SVProgressHUD
class ClubGallerySegmentListViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UISearchBarDelegate  {

    
    /*--------------------------------------------------searchBar----------------------------------------------*/
    
    //MARK:- SearchBar
    
    var searchController: UISearchController!
    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
    
    func filterActivityList(searchText:String!)
    {
        isFiltered = true
        muarrayGridAlbumCollectionFiltered=NSMutableArray()
        if muarrayGridAlbumCollection.count > 0
        {
//            let predicate = NSPredicate(format: "title contains[c] %@ OR description contains[c] %@", searchText,searchText)
//            let searchDataSource = muarrayGridAlbumCollection.filtered(using: predicate)
            print("muarrayGridAlbumCollection---\(muarrayGridAlbumCollection)")
//            (muarrayGridAlbumCollectionFiltered.object(at: indexPath.row) as AnyObject).value(forKey: "Title") as? String
//            print("searchDataSource \(searchDataSource)")
            print("titleArray---\(titleArray)")
            muarrayGridAlbumCollectionFiltered.removeAllObjects()
            filterTitleArray.removeAll()
                let filteredArray = titleArray.filter { $0.localizedCaseInsensitiveContains(searchText) }
                print("filterArr---\(filteredArray)")
            
                if let muarrayGridAlbumCollectionFiltereds = (filteredArray as NSArray).mutableCopy() as? NSMutableArray {
                    muarrayGridAlbumCollectionFiltered = muarrayGridAlbumCollectionFiltereds
                    for i in 0 ..< muarrayGridAlbumCollectionFiltereds.count {
                        filterTitleArray.append(muarrayGridAlbumCollectionFiltereds[i] as? String ?? "")
                    }
                    print("muarrayGridAlbumCollectionFiltered---\(muarrayGridAlbumCollectionFiltered)")
                    filterDescArray.removeAll()
                    filteralbumIDAra.removeAll()
                    filtergroupIDAra.removeAll()
                    filterProjectDateArray.removeAll()
                for filteredTitle in filteredArray {
                    if let index = titleArray.firstIndex(where: { $0 == filteredTitle }) {
                            filterDescArray.append(descArray[index])
                            filterProjectDateArray.append(projectDateArray[index])
                        filteralbumIDAra.append(albumIDAra[index])
                        filtergroupIDAra.append(groupIDAra[index])
                        filterIndex = index
                        }
                    self.buttonNoRecords.isHidden=true
                    self.tableAlbumListView.isHidden = false
                    self.tableAlbumListView.reloadData()
                }
            }
//            if let   muarrayGridAlbumCollectionFiltereds=(searchDataSource as NSArray).mutableCopy() as? NSMutableArray
//            { muarrayGridAlbumCollectionFiltered=muarrayGridAlbumCollectionFiltereds
//                self.buttonNoRecords.isHidden=true
//                self.tableAlbumListView.isHidden = false
//                self.tableAlbumListView.reloadData()
//            }
//            else
//            {
//                self.buttonNoRecords.isHidden=false
//                self.tableAlbumListView.isHidden = true
//            }
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        print("SearchText count \(searchText.count)")
        if searchText.count > 0
        {
            print("searchteaxt---\(searchText)")
           filterActivityList(searchText: searchText)
        }
        else if searchText.count <= 0
        {
            isFiltered = false
            muarrayGridAlbumCollectionFiltered=muarrayGridAlbumCollection
            self.tableAlbumListView.isHidden=false
            self.buttonNoRecords.isHidden=true
        }
        self.tableAlbumListView.reloadData()

        print("search bar text did change in club gallary")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton=true
        print("Search bar txt did begin editing in club gallary")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        print("searchText in club gallary \(searchBar.text)")
        searchBar.resignFirstResponder()
    }
    
    
    func updateSearchResultsForSearchController(_ searchController: UISearchController)
    {
        let varGetText=searchController.searchBar.text
        if((varGetText?.characters.count)!<=0 && varGetText != "")
        {
            searchController.searchBar.placeholder="Search"
        }
        else if searchController.searchBar.text != nil
        {
            searchController.searchBar.placeholder="Search"
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        isFiltered = false
        if muarrayGridAlbumCollection.count > 0
        {
         self.buttonNoRecords.isHidden=true
         self.tableAlbumListView.isHidden = false
        muarrayGridAlbumCollectionFiltered=muarrayGridAlbumCollection
        self.tableAlbumListView.reloadData()
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        searchBar.text=nil
        }
        print("Search bar cancel button click in club gallary")
    }
    
    /*--------------------------------------------------searchBar-----------------------------------------------*/
    
    
    @IBOutlet weak var searchBarNewbyRajendra: UISearchBar!
    @IBOutlet weak var tableAlbumListView: UITableView!
    @IBOutlet weak var buttonToggleForListGrid: UIButton!
    @IBOutlet weak var collectionAlbumView: UICollectionView!
    @IBOutlet weak var buttonNoRecords: UIButton!
    @IBOutlet weak var txtClube: UITextField!
    @IBOutlet weak var btnSelectYearPickerOpn: UIButton!
    @IBOutlet weak var viewForTextFieldYear: UIView!
    @IBOutlet weak var viewForTextFieldClub: UIView!
    @IBOutlet weak var textfieldYear: UITextField!
    @IBOutlet weak var pickerViews: UIPickerView!
    @IBOutlet weak var pikerClubeView: UIPickerView!
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var loadingLabel: UILabel!
    
    
    
    let loaderClass  = WebserviceClass()
    var grpID:String!=""
    var varOpenPopUpGridList:Int=0
    var appDelegate : AppDelegate = AppDelegate()
    
    var ChekPicker:String?
    var year : Int! = 0
    var pickerDataSource :[String] = []
    var pickerClubeDataSource :[String] = []
    var getCategoryIds:String!=""
    var getClubId:String!=""
    var getDistrctId:String?
    var getYear:String!=""
    var ClubeRotaryType:String?
    var GetIsCategoryFromClubOrDistrict:String?

    var muDictionryAlbumDetails:NSMutableDictionary=NSMutableDictionary()
    var titleArray = [String]()
    var descArray = [String]()
    var projectDateArray = [String]()
    var filterDescArray = [String]()
    var filterTitleArray = [String]()
    var filterProjectDateArray = [String]()
    var muarrayGridAlbumCollection:NSMutableArray=NSMutableArray()
    var muarrayGridAlbumCollectionFiltered:NSMutableArray=NSMutableArray()
    var isFiltered = false
    var filterIndex = 0
    var albumIDAra = [Int]()
    var groupIDAra = [Int]()
    var filteralbumIDAra = [Int]()
    var filtergroupIDAra = [Int]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonNoRecords.isHidden=true
        searchBarNewbyRajendra.delegate=self
        buttonToggleForListGrid.setImage(UIImage(named:"gridGallery"),  for: UIControl.State.normal)
        varOpenPopUpGridList=1
        //viewAsGridList.hidden=false
        self.tableAlbumListView.isHidden=false
        self.collectionAlbumView.isHidden=true
        
        
        functionForSetLeftNavigation()
        grpID = UserDefaults.standard.value(forKey: "GrpID") as? String
        

        viewdidLoadDate()
        functionForYears()
        pickerViews.alpha=0.0
        pikerClubeView.alpha=0.0
        
        viewForTextFieldClub.backgroundColor = UIColor.clear
        viewForTextFieldClub.layer.cornerRadius = 5
        viewForTextFieldClub.layer.borderWidth = 1
        viewForTextFieldClub.layer.borderColor = UIColor.lightGray.cgColor

        viewForTextFieldYear.backgroundColor = UIColor.clear
        viewForTextFieldYear.layer.cornerRadius = 5
        viewForTextFieldYear.layer.borderWidth = 1
        viewForTextFieldYear.layer.borderColor = UIColor.lightGray.cgColor
        functionForFetchingAlbumListData1()

       //  viewForTextFieldYear.isHidden=true
        viewForTextFieldClub.isHidden=true
       // Do any additional setup after loading the view.
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
        pickerClubeDataSource.append("Rotary Service")
        pickerClubeDataSource.append("Club Service")
        
        
        textfieldYear.text = pickerDataSource[0]
        self.pikerClubeView.selectRow(pickerClubeDataSource.count-1, inComponent: 0, animated: false)
        //self.pickerViews.selectRow(pickerDataSourceNonAdmin.count-1, inComponent: 0, animated: false)
        // self.pikerClubeView.reloadAllComponents()
    }
    
    func viewdidLoadDate()
    {
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
    }
    
    //MARK:- Picker view delegate method
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
            functionForFetchingAlbumListData1()
        }
        else{
            self.txtClube.text = pickerClubeDataSource[row]
            self.pikerClubeView.isHidden=true
            functionForFetchingAlbumListData1()
        }
    }
    
    @IBAction func buttonSelectYearClickEvent(_ sender: AnyObject) {
        ChekPicker = "Year"
        pickerViews.isHidden = false
        pickerViews.alpha=1.0
        pikerClubeView.alpha = 0.0
        //  self.view.bringSubviewToFront( buttonOpticity)
       /// buttonOpticity.bringSubview(toFront: pickerViews)
        pickerViews.reloadAllComponents()
    }
    
    @IBAction func SelectClubeAction(_ sender: Any) {
        
        ChekPicker = " "
        pikerClubeView.isHidden = false
        pickerViews.alpha = 0.0
        pikerClubeView.alpha = 1.0
        
      //  buttonOpticity.bringSubviewToFront( pikerClubeView)
        pikerClubeView.reloadAllComponents()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Find a Club"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 10)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white//(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ClubGallerySegmentListViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
//       var editB = UIButton(type: UIButton.ButtonType.custom)
//        editB.frame = CGRectMake(50, 0, 20, 20)
//        editB.setImage(UIImage(named:"listGallary"), forState: UIControl.State.Normal)
//        editB.addTarget(self, action: #selector(ClubGaSDFGllerySegmentListViewController.RightDropDownAction), forControlEvents: UIControl.Event.TouchUpInside)
//        let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
//        let buttons : NSArray = [edit]
//        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
//    func RightDropDownAction()
//    {
//    }

    //MARK:- Server api calling
    func functionForFetchingAlbumListData()
    {
     print("functionForFetchingAlbumListData**********")
       // self.loaderClass.loaderViewMethod()
        let completeURL = baseUrl+row_GetClubPublicGallery//baseUrl+k_API_Gallery
        if(txtClube.text == "Club Service"){
                       ClubeRotaryType = "0"
                      // GetIsCategoryFromClubOrDistrict = "0"
                   }else{
                       ClubeRotaryType = "1"
                      // GetIsCategoryFromClubOrDistrict = "1"
                   }
        
        let parameterst = [ "grpID" : grpID,
                            "YearFilter": textfieldYear.text as Any,
                            "sharetype":"1"//ClubeRotaryType as Any
        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print(response)
            let dd = response as! NSDictionary
            self.muarrayGridAlbumCollection.removeAllObjects()
            self.muarrayGridAlbumCollectionFiltered.removeAllObjects()
            self.muarrayGridAlbumCollection=NSMutableArray()
            self.muarrayGridAlbumCollectionFiltered=NSMutableArray()

            print("Activities dd \(dd)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            if((dd.object(forKey: "TBPublicAlbumsList")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                for i in 0..<(((dd.value(forKey: "TBPublicAlbumsList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "albumId")! as AnyObject).count
                {
                    /*"albumId": "67",
                     "title": "Aaaa",
                     "type": "0",
                     "description": "gggg",
                     "image": "http://www.rosteronwheels.com/Documents/gallery/Group2765/WhatsApp_Image_2017-07-06_at_13.00.2306072017014230PM.jpeg",
                     "groupId": "2765",
                     "moduleId": "8",
                     "isAdmin": "Yes"*/
                    let albumId=((((dd.value(forKey: "TBPublicAlbumsList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "albumId")! as AnyObject).object(at: i)) as! String
                    let title=((((dd.value(forKey: "TBPublicAlbumsList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "title")! as AnyObject).object(at: i)) as! String
                    let type=(((dd.value(forKey: "TBPublicAlbumsList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "type")! as AnyObject).object(at: i) as! String
                    let description=(((dd.value(forKey: "TBPublicAlbumsList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "description")! as AnyObject).object(at: i) as! String
                    let image=((((dd.value(forKey: "TBPublicAlbumsList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "image")! as AnyObject).object(at: i)) as! String
                    let groupId=((((dd.value(forKey: "TBPublicAlbumsList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "groupId")! as AnyObject).object(at: i)) as! String
                    let moduleId=((((dd.value(forKey: "TBPublicAlbumsList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "moduleId")! as AnyObject).object(at: i)) as! String
                    let isAdmin=((((dd.value(forKey: "TBPublicAlbumsList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "isAdmin")! as AnyObject).object(at: i)) as! String
                    let projectDate=((((dd.value(forKey: "TBPublicAlbumsList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "project_date")! as AnyObject).object(at: i)) as! String
                    
                    self.muDictionryAlbumDetails=["albumId": albumId,
                        "title": title,
                        "type": type,
                        "description": description,
                        "image": image,
                        "groupId": groupId,
                        "moduleId": moduleId,
                        "isAdmin": isAdmin]
                    //print(self.muDictionryAlbumDetails)
                    self.titleArray.append(title)
                    self.descArray.append(description)
                    self.projectDateArray.append(projectDate)
                    print("descArray::123")
                    print("descArray::----\(self.descArray)")
                    print("projectDateArray::----\(self.projectDateArray)")
                    self.muarrayGridAlbumCollection.add(self.muDictionryAlbumDetails)
                    self.muarrayGridAlbumCollectionFiltered.add(self.muDictionryAlbumDetails)
                    print("33333333333333333333333333333333333333",self.muarrayGridAlbumCollection.count)
                }
                
                if(self.muarrayGridAlbumCollection.count>0)
                {
                    self.buttonNoRecords.isHidden=true
                    self.tableAlbumListView.isHidden = false
                }
                else
                {
                    self.buttonNoRecords.isHidden=false
                    self.tableAlbumListView.isHidden = true
                }

                self.loaderClass.window=nil
                self.tableAlbumListView.reloadData()
                self.collectionAlbumView.reloadData()
                
            }
            else
            {
                self.loaderClass.window=nil
                print("NO Result")   //DPK
            }
             SVProgressHUD.dismiss()
            }
        })
    }
    
    
    //MARK:- Server api calling1
    func functionForFetchingAlbumListData1()
    {
         SVProgressHUD.show()
         tableAlbumListView.isHidden=true
         loadingLabel.isHidden=false
         self.loadingLabel.text="Loading... Please Wait"
        self.buttonNoRecords.isHidden=true
            self.getDistrctId = "0"
            if(txtClube.text == "Club Service"){
                ClubeRotaryType = "0"
                GetIsCategoryFromClubOrDistrict = "0"
            }else{
                ClubeRotaryType = "1"
                GetIsCategoryFromClubOrDistrict = "1"
            }
        
        
        
        // loaderClass.loaderViewMethod()
        
        let completeURL = baseUrl+"FindClub/GetPublicAlbumsList"
        var parameterst:NSDictionary=NSDictionary()
//        if(self.varIsCallFrom=="ShowCaseFromDashBoard")
//        {
//            parameterst = [
//                "groupId":"0",
//                "district_id":self.getDistrctId as Any,
//                "club_id":self.getClubId,
//                "category_id":self.getCategoryIds,
//                "year": textfieldYear.text as Any,
//                "SharType":"0",
//                "profileId":"",
//                "moduleId":""
//            ]
//        }
//        else
//        {
        //MARK:Old parameters before April 27  2020
        //parameterst =  ["groupId":self.grpID,
        //"grpID":self.grpID,
        //"district_id":"0",
        //"club_id":"0",
        //"category_id":GetIsCategoryFromClubOrDistrict as Any,
        //"year": textfieldYear.text as Any,
        //"SharType":"1",
        //"profileId":"354379",
        //"moduleId":"8",
        //"ClubRotaryType":"1", //ClubeRotaryType as Any,
        //"searchText":""]
//        commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
////        commonClassHoldDataAccessibleVariable = muarrayFindAClubList.object(at: sender.tag) as! CommonAccessibleHoldVariable
//        let ClubID = commonClassHoldDataAccessibleVariable.varClubId
//        print(ClubID)
        var ClubID:String! = ""
        ClubID = UserDefaults.standard.value(forKey: "GrpID") as? String
        print(ClubID)

        //MARK: New Parameters after April 27 2020
         parameterst =  ["groupId":ClubID,
         "year": textfieldYear.text as Any,
         "SharType":"1",//ClubeRotaryType as Any,
         "moduleId":"52",
         "searchText":"",
         "club_id" : ClubID,
         "category_id" : "2",
         "district_id" : "0"]

        
//        {"club_id":"69722","year":"2021-2022","SharType":"1","category_id":"2","district_id":"0","moduleId":"52","searchText":""}
        
        
        
        
        
       // }
        
//        {"club_id":"31363","groupId":"31363","year":"2021-2022","SharType":"1","category_id":"2","district_id":"0","moduleId":"52","searchText":""}
//        {"club_id":"","groupId":"33532","year":"2020-2021","SharType":"1","category_id":"2","district_id":"0","moduleId":"52","searchText":""}
//        api name
//        http://rotaryindiaapi.rosteronwheels.com/api/Gallery/GetAlbumsList_New

        print("ttttt: \(parameterst)")
        print("ccccuuurrrll : \(completeURL)")

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
            //print("dd \(dd)")
            self.muarrayGridAlbumCollection = NSMutableArray()
            self.muarrayGridAlbumCollectionFiltered = NSMutableArray()
            SVProgressHUD.show()
            print(response)
            let varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
                self.loadingLabel.text="Could not connect to server."
            }
            else
            {
                SVProgressHUD.show()
                if((dd.object(forKey: "TBPublicAlbumsList")! as AnyObject).object(forKey: "status") as! String == "0" && (dd.object(forKey: "TBPublicAlbumsList")! as AnyObject).object(forKey: "message") as! String == "success")
                {
                   if let arrarrNewGroupList = (((dd.object(forKey: "TBPublicAlbumsList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "Table")) as? NSArray
    {
     print("arrarrNewGroupList : : \(arrarrNewGroupList)")
                       print("arrarrNewGroupListALBUMID : : \( (((dd.object(forKey: "TBPublicAlbumsList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "Table")) )")
                       if let arrarrNewGroupList = (((dd.object(forKey: "TBPublicAlbumsList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "Table")) as? [[String: Any]] {
                           for dict in arrarrNewGroupList {
                               // Access the specific value using its key
                               if let specificValue = dict["Title"],let descript = dict["Description"],let date = dict["project_date"]  {
                                   // Use specificValue here
                                   print("Specific Value: \(specificValue)")
                                   self.titleArray.append(specificValue as? String ?? "")
                                   self.descArray.append(descript as? String ?? "")
                                   self.projectDateArray.append(date as? String ?? "")
                                   
                                   print("titleArray Value: \(self.titleArray)")
                                   print("descArray Value: \(self.descArray)")
                                   print("projectDateArray Value: \(self.projectDateArray)")
                                   
                               }
                           }
                       }

                       if let publicAlbumsList = dd.object(forKey: "TBPublicAlbumsList") as? NSDictionary,
                          let result = publicAlbumsList.object(forKey: "Result") as? NSDictionary,
                          let table = result.object(forKey: "Table") as? NSArray {
                              // Now you can access values inside the "Table" array
                              for item in table {
                                  if let tableItem = item as? NSDictionary {
                                      // Access values inside tableItem dictionary
                                      if let value = tableItem["AlbumId"] as? Int {
                                          print(" ValueOfALBUMID: \(value)")
                                          self.albumIDAra.append(value)
                                      }
                                  }
                              }
                       } else {
                           // Handle the case where any of the optional bindings fail
                       }
                       
                       if let publicAlbumsList = dd.object(forKey: "TBPublicAlbumsList") as? NSDictionary,
                          let result = publicAlbumsList.object(forKey: "Result") as? NSDictionary,
                          let table = result.object(forKey: "Table") as? NSArray {
                              // Now you can access values inside the "Table" array
                              for item in table {
                                  if let tableItem = item as? NSDictionary {
                                      // Access values inside tableItem dictionary
                                      if let value = tableItem["GroupId"] as? Int {
                                          print(" ValueOfGROUPID: \(value)")
                                          self.groupIDAra.append(value)
                                      }
                                  }
                              }
                       } else {
                           // Handle the case where any of the optional bindings fail
                       }



     self.muarrayGridAlbumCollection = arrarrNewGroupList.mutableCopy() as! NSMutableArray
     self.muarrayGridAlbumCollectionFiltered = arrarrNewGroupList.mutableCopy() as! NSMutableArray
     print("muarrayGridAlbumCollectionFiltered--\(self.muarrayGridAlbumCollectionFiltered)")
     
     if(self.muarrayGridAlbumCollection.count>0)
     {
         self.tableAlbumListView.isHidden = false
         self.buttonNoRecords.isHidden=true
         self.buttonNoRecords.setTitle("",  for: UIControl.State.normal)
   //      let dict:NSDictionary = (self.muarrayGridAlbumCollection.object(at: 0) as! NSDictionary)
         self.tableAlbumListView.reloadData()
     }
     else
     {
         self.tableAlbumListView.isHidden = true
         self.buttonNoRecords.isHidden=false
         self.buttonNoRecords.setTitle("No record found.",  for: UIControl.State.normal)
         SVProgressHUD.dismiss()
     }
        self.loadingLabel.isHidden=true
 }
 else
 {
//     self.loadingLabel.isHidden=true
     self.loadingLabel.isHidden=true
         self.tableAlbumListView.isHidden = true
         self.buttonNoRecords.isHidden=false
         self.buttonNoRecords.setTitle("No record found.",  for: UIControl.State.normal)
         SVProgressHUD.dismiss()
     
     print("********Entered in else case********")
}
     SVProgressHUD.dismiss()
 }
 else
 {
     self.tableAlbumListView.isHidden = true
     SVProgressHUD.dismiss()
     self.loadingLabel.text="Could not connect to server."
     self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
    }
   }
  })
 }

    //MARK:- Table Method
    
    //MARK:- Tableview Delegate As List
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayGridAlbumCollectionFiltered.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:ClubGalleryListViewTableCell = tableView.dequeueReusableCell(withIdentifier: "ClubGalleryListViewTableCell") as! ClubGalleryListViewTableCell
      
        if (muarrayGridAlbumCollectionFiltered.count>0)
        {
            SVProgressHUD.dismiss()
            var varGetAlbumTitle = ""
            var varGetDescription = ""
            var varGetAlbumDate = ""
            var varGetAlbumImages = ""
            if isFiltered {
                varGetAlbumTitle = muarrayGridAlbumCollectionFiltered[indexPath.row] as? String ?? ""
                varGetDescription = filterDescArray[indexPath.row]
                varGetAlbumDate = filterProjectDateArray[indexPath.row]
            } else {
                varGetAlbumTitle = (muarrayGridAlbumCollectionFiltered.object(at: indexPath.row) as AnyObject).value(forKey: "Title") as? String ?? ""
                varGetDescription = (muarrayGridAlbumCollectionFiltered.object(at: indexPath.row) as AnyObject).value(forKey: "Description") as? String ?? ""
                varGetAlbumDate = (muarrayGridAlbumCollectionFiltered.object(at: indexPath.row) as AnyObject).value(forKey: "project_date") as? String ?? ""
                varGetAlbumImages = (muarrayGridAlbumCollectionFiltered.object(at: indexPath.row) as AnyObject).value(forKey: "Image") as? String ?? ""
            }
            
            
            print("varGetAlbumDate--\(varGetAlbumDate)")
            
            let dF:DateFormatter=DateFormatter()
            dF.dateFormat="YYYY-MM-dd HH:mm:ss"
           // print("Project date is \(varGetAlbumDate)")
            if let pDate = dF.date(from: varGetAlbumDate)
            {
                let dff:DateFormatter=DateFormatter()
                dff.dateFormat="dd-MMM-YYYY"
              if let pDates=dff.string(from: pDate) as? String
              {
                print("Formatted project date is \(pDates)")
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

//
//            print(varGetAlbumImages,varGetAlbumTitle,varGetDescription)
            print("--------\(varGetAlbumTitle)")
            cell.textviewDescription.text! = varGetDescription ?? ""
            cell.labelTitle.text = varGetAlbumTitle ?? ""
            
            if(varGetAlbumImages == "")
            {
                cell.imageAlbum.image = UIImage(named: "profile_pic")
            }
            else
            {
                /*------------------------------Code by --------------------DPK--------------------------- */
                if let checkedUrl = URL(string: varGetAlbumImages ?? "" ) {
                    /*
                    KingfisherManager.sharedManager.retrieveImageWithURL(checkedUrl, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                        print(image)
                        cell.imageAlbum.image = image
                    })
                    */
                    
                    var varGetImage:String!=varGetAlbumImages as! String
                    let ImageProfilePic:String = varGetImage.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    cell.imageAlbum.sd_setImage(with: checkedUrl)
                    

                    
                    
                    /*-----------------Code by --------------------DPK--------------------------- */
                }
            }

        }
        cell.buttonDelete.addTarget(self, action: #selector(ClubGallerySegmentListViewController.buttonMainClickedEventFromTable(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonDelete.tag=indexPath.row;
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select pressed")
       //self.buttonMainClickedEventFromTable(indexPath.row)
    }
    
    
    @objc func buttonMainClickedEventFromTable(_ sender:UIButton)
   // func buttonMainClickedEventFromTable(_ sender:Int)
    {
               if searchBarNewbyRajendra.isFirstResponder
               {
                   searchBarNewbyRajendra.resignFirstResponder()
               }
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
           
             print(muarrayGridAlbumCollectionFiltered.object(at: sender.tag))
             var varGetAlbumID = ""
             var varGetAlbumGroupID = ""
             var varGetDescription = ""
             var varGetAlbumTitle = ""
             if isFiltered {
                 varGetAlbumID = String(filteralbumIDAra[sender.tag])
                 varGetAlbumGroupID = String(filtergroupIDAra[sender.tag])
                 varGetDescription = filterDescArray[sender.tag]
                 varGetAlbumTitle = filterTitleArray[sender.tag]
                 print("AALBUMID____\(varGetAlbumID)")
                 print("AALBwwwUMID____\(varGetAlbumGroupID)")
             } else {
                 let x : Int = ((muarrayGridAlbumCollectionFiltered.object(at: sender.tag) as AnyObject).value(forKey: "AlbumId")) as! Int
                 varGetAlbumID = String(x)
                 
                 
                 //            let varGetAlbumGroupID = (muarrayGridAlbumCollectionFiltered.object(at: sender.tag) as AnyObject).value(forKey: "groupId") as! Int
                 
                 let x1 : Int = (muarrayGridAlbumCollectionFiltered.object(at: sender.tag) as AnyObject).value(forKey: "GroupId") as! Int
                varGetAlbumGroupID = String(x1)
                 
                varGetDescription = (muarrayGridAlbumCollectionFiltered.object(at: sender.tag) as AnyObject).value(forKey: "Description") as! String
                 varGetAlbumTitle = (muarrayGridAlbumCollectionFiltered.object(at: sender.tag) as AnyObject).value(forKey: "Title") as! String
             }
            let objClubPhotoViewController = self.storyboard?.instantiateViewController(withIdentifier: "ClubPhotoViewController") as! ClubPhotoViewController
            objClubPhotoViewController.varGroupId=varGetAlbumGroupID
            objClubPhotoViewController.varAlbumId=varGetAlbumID
            objClubPhotoViewController.YearStr = textfieldYear.text as Any as! String
            print(objClubPhotoViewController.YearStr)
            objClubPhotoViewController.varNavigationTitle=varGetAlbumTitle
            objClubPhotoViewController.varDescription=varGetDescription
            self.navigationController?.pushViewController(objClubPhotoViewController, animated: true)
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
           SVProgressHUD.dismiss()
        }
    }

    //MARK:- Collection Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return muarrayGridAlbumCollection.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        var collectionCell:ClubGalleryGridViewCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClubGalleryGridViewCollectionCell", for: indexPath) as! ClubGalleryGridViewCollectionCell
        if(muarrayGridAlbumCollection.count>0)
        {
           let varGetAlbumImages = (muarrayGridAlbumCollection.object(at: indexPath.row) as AnyObject).value(forKey: "image") as! String
           let varGetAlbumTitle = (muarrayGridAlbumCollection.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! String
            collectionCell.labelTitle.text! = varGetAlbumTitle
            print(varGetAlbumImages)
            if(varGetAlbumImages == "")
            {
                collectionCell.imageAlbum.image = UIImage(named: "profile_pic")
            }
            else
            {
                /*------------------------------Code by --------------------DPK--------------------------- */
                if let checkedUrl = URL(string: varGetAlbumImages )
                {
                    /*
                    KingfisherManager.sharedManager.retrieveImageWithURL(checkedUrl, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                        print(image)
                        collectionCell.imageAlbum.image = image
                    })
                    */
                    
                    var varGetImage:String!=varGetAlbumImages
                    let ImageProfilePic:String = varGetImage.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    collectionCell.imageAlbum.sd_setImage(with: checkedUrl)
                    
                    /*-----------------Code by --------------------DPK--------------------------- */
                }
            }
            
        }
        collectionCell.buttonMainClickEvent.addTarget(self, action: #selector(ClubGallerySegmentListViewController.buttonMainClickedEvent(_:)), for: UIControl.Event.touchUpInside)
        collectionCell.buttonMainClickEvent.tag=indexPath.row;
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let varGetAlbumID = (muarrayGridAlbumCollection.object(at: indexPath.row) as AnyObject).value(forKey: "albumId") as! String
        let varGetAlbumGroupID = (muarrayGridAlbumCollection.object(at: indexPath.row) as AnyObject).value(forKey: "groupId") as! String
        
        let objClubPhotoViewController = self.storyboard?.instantiateViewController(withIdentifier: "ClubPhotoViewController") as! ClubPhotoViewController
        objClubPhotoViewController.varGroupId=varGetAlbumGroupID
        objClubPhotoViewController.varAlbumId=varGetAlbumID
        self.navigationController?.pushViewController(objClubPhotoViewController, animated: true)
    }
    
    
  
   


/*-------------------------------------------function for remove cell row-------------------Start---------*/
    @objc func buttonMainClickedEvent(_ sender:UIButton)
{
    appDelegate = UIApplication.shared.delegate as! AppDelegate
     if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
    {
        let varGetAlbumID = (muarrayGridAlbumCollection.object(at: sender.tag) as AnyObject).value(forKey: "albumId") as! String
        let varGetAlbumGroupID = (muarrayGridAlbumCollection.object(at: sender.tag) as AnyObject).value(forKey: "groupId") as! String
        let varGetDescription = (muarrayGridAlbumCollection.object(at: sender.tag) as AnyObject).value(forKey: "description") as! String
        
        
        
        let objClubPhotoViewController = self.storyboard?.instantiateViewController(withIdentifier: "ClubPhotoViewController") as! ClubPhotoViewController
        objClubPhotoViewController.varGroupId=varGetAlbumGroupID
        objClubPhotoViewController.varAlbumId=varGetAlbumID
        objClubPhotoViewController.varNavigationTitle="Photo"
        objClubPhotoViewController.varDescription=varGetDescription
    
        self.navigationController?.pushViewController(objClubPhotoViewController, animated: true)
    }
    else
    {
         SVProgressHUD.dismiss()
        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        
    }
}




    @IBAction func buttonToggleForGridListClickEvent(_ sender: AnyObject)
    {
        RightDropDownAction()
    }
   
    
    func RightDropDownAction()
    {
        //viewAsGridList.hidden=true
        
        if(varOpenPopUpGridList==0)
        {
            buttonToggleForListGrid.setImage(UIImage(named:"gridGallery"),  for: UIControl.State.normal)
            varOpenPopUpGridList=1
            //viewAsGridList.hidden=false
            self.tableAlbumListView.isHidden=false
            self.collectionAlbumView.isHidden=true
            
        }
        else
        {
            varOpenPopUpGridList=0
            //viewAsGridList.hidden=true
            self.collectionAlbumView.isHidden=false
            self.tableAlbumListView.isHidden=true
            self.tableAlbumListView.reloadData()
            buttonToggleForListGrid.setImage(UIImage(named:"listGallary"),  for: UIControl.State.normal)
        }
    }
    
    
    // make a cell for each cell index path
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
