//
//  CategoryServiceDirectoryViewController.swift
//  TouchBase
//
//  Created by Umesh on 20/03/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit


import SVProgressHUD
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


class CategoryServiceDirectoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating {
    
    var varGetSearchText:String! = ""
var copymainArray:NSArray!
    var searchController: UISearchController!
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        print("Hello")
       
        if(searchText.characters.count>0)
        {
 
        }
        else
        {
           muarrayHold=muarrayHold2
           self.tableviewCategoryServiceDircetory.reloadData()
            searchBar.resignFirstResponder()

        }
 
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton=true
       print("use predicate 3 here")
   

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        print("searchText \(searchBar.text!)")
        varGetSearchText = searchBar.text!
      
        
         print("use predicate 2 here")
        searchBar.resignFirstResponder()
        
        if(varGetSearchText.characters.count>0)
        {
            copymainArray=muarrayHold2
            let predicate =  NSPredicate(format: "memberName contains[c] %@ OR CategoryName contains[c] %@", varGetSearchText,varGetSearchText)
            let searchDataSource = copymainArray.filtered(using: predicate)
            muarrayHold=searchDataSource as! NSMutableArray
            self.tableviewCategoryServiceDircetory.reloadData()
        }
        else
        {
            muarrayHold=muarrayHold2
            self.tableviewCategoryServiceDircetory.reloadData()
        }
        
        
        
    }
    func updateSearchResults(for searchController: UISearchController)
    {
        let varGetText=searchController.searchBar.text
        if(varGetText?.characters.count<=0 && varGetText != "")
        {
            searchController.searchBar.placeholder="Search"
            varGetSearchText = ""
             print("use predicate 1 here")
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
        muarrayHold=NSMutableArray()
         print("use predicate4 here")
      
            muarrayHold=muarrayHold2
            self.tableviewCategoryServiceDircetory.reloadData()
      
    }
    
    
    
    var isNotCategoryorCategory:String!=""
    var geCategoryType:String!=""
    
    // @IBOutlet var searchBar: UISearchBar!
    
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    
    var grpID: NSString!
    var isAdmin:NSString!
    var userID:NSString!
    var moduleIdStr:NSString!
    var moduleName:String! = ""
    var muarrayCategoryServiceDirectory:NSMutableArray=NSMutableArray()
    var muarrayCategoryIdServiceDirectory:NSMutableArray=NSMutableArray()
    
    
    let reuseIdentifiers = "cell"
    var prototypeCells:CategoryServiceTableViewCell=CategoryServiceTableViewCell()
    @IBOutlet var tableviewCategoryServiceDircetory: UITableView!
    var  stringProfileId:String!=""
    var  stringGroupID:String!=""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // loaderViewMethod()
        functionForFetchingAlbumList()
        functionForSetLeftNavigation()
        functionForGetDataFromServer()
        // Do any additional setup after loading the view.
    }
    
    /*--------------------------------------------------------------------------------------------------------*/
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
    
    /*--------------------------------------------------searchBar----------------------------------------------*/
    
    //MARK:- SearchBar
    
//    var searchController: UISearchController!
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
//    {
//        var varGetValue=""
//    }
//    func searchBarTextDidBeginEditing(searchBar: UISearchBar)
//    {
//        searchBar.showsCancelButton=true
//    }
//    func searchBarSearchButtonClicked(searchBar: UISearchBar)
//    {
//        print("searchText \(searchBar.text)")
//        var varGetSalonName = searchBar.text!
//        searchBar.resignFirstResponder()
//    }
//    func updateSearchResultsForSearchController(searchController: UISearchController)
//    {
//        let varGetText=searchController.searchBar.text
//        if(varGetText?.characters.count<=0 && varGetText != "")
//        {
//            searchController.searchBar.placeholder="Enter Salon Name"
//        }
//        else if searchController.searchBar.text != nil
//        {
//            searchController.searchBar.placeholder="Enter Salon Name"
//        }
//    }
//    func searchBarCancelButtonClicked(searchBar: UISearchBar)
//    {
//        searchBar.showsCancelButton = false
//        searchBar.resignFirstResponder()
//        searchBar.text=nil
//    }
//    
    /*--------------------------------------------------searchBar-----------------------------------------------*/
    func functionForFetchingAlbumList()
    {
        //moduleId
        var varIsFirstTimeExecute=UserDefaults.standard.value(forKey: "session_IsFirstTime")
        var varSelectedDate:String=""
        var varUpdateOns:String=""
        
        let completeURL = baseUrl+touchBase_GetServiceDirectoryCategories
        
        let parameterst = [
            "groupId" : grpID,
            "moduleId" : moduleIdStr
        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            // self.muarrayListData=response as! NSMutableArray;
            //print(self.muarrayListData)
            print(response)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            // let letCount=response.valueForKey("ServiceCategoriesResult")!.valueForKey("ID").count
            for i in 00..<((response.value(forKey: "ServiceCategoriesResult")! as AnyObject).value(forKey: "ID")! as AnyObject).count
            {
                let stringCategoryName=((response.value(forKey: "ServiceCategoriesResult")! as AnyObject).value(forKey: "CategoryName")! as AnyObject).object(at: i)
                let stringCategoryID=((response.value(forKey: "ServiceCategoriesResult")! as AnyObject).value(forKey: "ID")! as AnyObject).object(at: i)
                print(stringCategoryName)
                print(stringCategoryID)
                
                self.muarrayCategoryServiceDirectory.add(stringCategoryName)
                self.muarrayCategoryIdServiceDirectory.add(stringCategoryID)
                
                self.tableviewCategoryServiceDircetory.reloadData()
            }
            self.window=nil;
            
            /*
             ServiceCategoriesResult =     (
             {
             CategoryName = "Ministry of Finance";
             ID = 1;
             */
            SVProgressHUD.dismiss()
        }
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Tableview Delegate As List
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayHold.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        print(geCategoryType)
        if(geCategoryType=="category")
        {
        return 90
        }
        else if(geCategoryType=="notcategory")
        {
            return 90
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        prototypeCells  = tableviewCategoryServiceDircetory.dequeueReusableCell(withIdentifier: reuseIdentifiers) as! CategoryServiceTableViewCell
        if(muarrayHold.count>0)
        {
            print(muarrayHold)
            
            prototypeCells.viewMain.isHidden=true
            prototypeCells.viewSecond.isHidden=true
            
            
            
            let geCategoryType:String! = (muarrayHold.object(at: indexPath.row) as AnyObject).value(forKey: "CategoryType")as? String
            if(geCategoryType=="notcategory")
            {
               
                print("notcategory")
                print((muarrayHold.object(at: indexPath.row) as AnyObject).value(forKey: "memberName")as! String)
                print((muarrayHold.object(at: indexPath.row) as AnyObject).value(forKey: "CategoryName")as! String)
                let varGetProfilePic = (muarrayHold.object(at: indexPath.row) as AnyObject).value(forKey: "image")as? String
                if(varGetProfilePic == "" ||  varGetProfilePic == "profile_photo.png" || varGetProfilePic!.characters.count<=0)
                {
                    prototypeCells.imageUSerImages.image = UIImage(named: "profile_pic.png")
                }
                else
                {
                    
                    let ImageProfilePic:String = varGetProfilePic!.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    prototypeCells.imageUSerImages.sd_setImage(with: checkedUrl)
                }
                
                prototypeCells.viewMain.isHidden=false
                prototypeCells.viewSecond.isHidden=true
                prototypeCells.labelCategoryName.text=(muarrayHold.object(at: indexPath.row) as AnyObject).value(forKey: "memberName")as? String
                prototypeCells.labelMemberDesignation.text=(muarrayHold.object(at: indexPath.row) as AnyObject).value(forKey: "csvKeywords")as? String
                
                 isNotCategoryorCategory="notcategory"
            }
            else if(geCategoryType=="category")
            {

                print("category")
                print((muarrayHold.object(at: indexPath.row) as AnyObject).value(forKey: "memberName")as! String)
                print((muarrayHold.object(at: indexPath.row) as AnyObject).value(forKey: "CategoryName")as! String)
                
                prototypeCells.viewMain.isHidden=true
                prototypeCells.viewSecond.isHidden=false
                prototypeCells.labelValue.text=(muarrayHold.object(at: indexPath.row) as AnyObject).value(forKey: "CategoryName")as? String
                isNotCategoryorCategory="category"

                
            }
            prototypeCells.buttonMain.setTitle("",  for: UIControl.State.normal)
            
            
            prototypeCells.buttonMain.addTarget(self, action: #selector(CategoryServiceDirectoryViewController.buttonDetailClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonMain.tag = indexPath.row
            
            
            
            prototypeCells.buttonMainSecond.addTarget(self, action: #selector(CategoryServiceDirectoryViewController.buttongotoProfileClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonMainSecond.tag = indexPath.row
            
        }
        return prototypeCells
    }
    //delete album
    // print(muarrayHold.objectAtIndex(indexPath.row).valueForKey("memberName")as! String)
    
    @objc func buttongotoProfileClickEvent(_ sender:UIButton)
    {
        
        
        let letGetCategoryId=muarrayHold.object(at: sender.tag)
        
        
        //  let dict:NSDictionary = (muarrayCategoryServiceDirectory.objectAtIndex(sender.tag) as! NSDictionary)
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "servicelist") as! ServiceDirectoryListViewController
        secondViewController.grpID = grpID
        secondViewController.isAdmin = isAdmin
        secondViewController.userID = userID
        secondViewController.moduleIdStr = moduleIdStr
        print(moduleIdStr)
        secondViewController.moduleName = (muarrayHold.object(at: sender.tag) as AnyObject).value(forKey: "CategoryName")as? String
        secondViewController.letGetCategoryId = (muarrayHold.object(at: sender.tag) as AnyObject).value(forKey: "ID")as? String
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
        // print(dict)
    }
    
    
    
    @objc func buttonDetailClickEvent(_ sender:UIButton)
    {
        print(muarrayHold.object(at: sender.tag))
        
        
       // tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //        NSUserDefaults.standardUserDefaults().setObject("no", forKey: "picadded")
        let directoryList = muarrayHold.object(at: sender.tag) as! NSDictionary
        print(directoryList)
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "servicedet") as! ServiceDetailViewController
        profVC.grpID =  grpID  //nameTitles[indexPath.row]
        
        
        var dictTemporaryDictionary:NSDictionary=((muarrayHold.object(at: sender.tag) as AnyObject) as! NSDictionary)
        
        
        profVC.serviceId =  dictTemporaryDictionary.value(forKey: "serviceDirId")as? String as! NSString// directoryList.objectForKey("serviceDirId") as! String   //mobileTitles[indexPath.row]
        profVC.userID = userID
        profVC.moduleId = moduleIdStr
        
        
        profVC.varCity=(muarrayHold.object(at: sender.tag) as AnyObject).value(forKey: "city")as? String
        profVC.varState=(muarrayHold.object(at: sender.tag) as AnyObject).value(forKey: "state")as? String
        profVC.varCountry=(muarrayHold.object(at: sender.tag) as AnyObject).value(forKey: "addressCountry")as? String
        profVC.varZip=(muarrayHold.object(at: sender.tag) as AnyObject).value(forKey: "zip")as? String
        print(directoryList.object(forKey: "website") as? String)
        
        profVC.varWebSite=(muarrayHold.object(at: sender.tag) as AnyObject).value(forKey: "website")as? String
        print(directoryList)
        profVC.directoryList = directoryList
        
        /*---code by rajenda jat hold value for service directory edit mode city state country zip----------*/
        UserDefaults.standard.setValue((muarrayHold.object(at: sender.tag) as AnyObject).value(forKey: "city")as? String, forKey: "session_City")
        UserDefaults.standard.setValue((muarrayHold.object(at: sender.tag) as AnyObject).value(forKey: "state")as? String, forKey: "session_State")
        UserDefaults.standard.setValue((muarrayHold.object(at: sender.tag) as AnyObject).value(forKey: "country")as? String, forKey: "session_Country")
        UserDefaults.standard.setValue((muarrayHold.object(at: sender.tag) as AnyObject).value(forKey: "zip")as? String, forKey: "session_Zip")
        
        
        
        //        profVC.isAdmin = isAdmin
        //        profVC.mainUSerPRofileID = userID
        //        profVC.isCalled = "list"
        self.navigationController?.pushViewController(profVC, animated: true)

        
        
        
        

    }
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(CreateAlbumViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    //-----
    /*---code by rajendra jat in 14 march 2018-*/
    func functionForGetDataFromServer()
    {
        
        
        let completeURL =  baseUrl + touchBase_fetchDistrictCommittee
        let parameterst: [String: AnyObject] = [
            /*
             "groupId": grpID,
             "moduleId":moduleId
             */
            // "groupId": "2765",
            // "moduleId":"15"
            "groupId" : grpID,
            "moduleId" : moduleIdStr
        ]
        
        print(completeURL)
        print(parameterst)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print(response)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            if((response.object(forKey: "TBGetServiceCategoriesDataList")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                
                
                
               // print((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "Category"))
             //   print((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "DirectoryData"))
                
                
                
                
                
                print((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "Category"))
                print((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "DirectoryData"))
                
                var muDict:NSMutableDictionary=NSMutableDictionary()
                //1111111............................
                for i in 00..<((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "DirectoryData")! as AnyObject).count
                {
                    
                    var dictTemporaryDictionary:NSDictionary=((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "DirectoryData")! as AnyObject).object(at: i)
                    
                    
                    let address = dictTemporaryDictionary.value(forKey: "address")
                    let addressCountry = dictTemporaryDictionary.value(forKey: "addressCountry")
                    let categoryId = dictTemporaryDictionary.value(forKey: "categoryId")
                    
                    
                    
                    
                    let city = dictTemporaryDictionary.value(forKey: "city")
                    let contactNo = dictTemporaryDictionary.value(forKey: "contactNo")
                    
                    
                    let contactNo2 = dictTemporaryDictionary.value(forKey: "contactNo2")
                    let countryCode1 = dictTemporaryDictionary.value(forKey: "countryCode1")
                    let countryCode2 = dictTemporaryDictionary.value(forKey: "countryCode2")
                    let countryId1 = dictTemporaryDictionary.value(forKey: "countryId1")
                    let countryId2 = dictTemporaryDictionary.value(forKey: "countryId2")
                    let descriptn = dictTemporaryDictionary.value(forKey: "descriptn")
                    
                    
                    let email = dictTemporaryDictionary.value(forKey: "email")
                    let groupId = dictTemporaryDictionary.value(forKey: "groupId")
                    let image = dictTemporaryDictionary.value(forKey: "image")
                    let isdeleted = dictTemporaryDictionary.value(forKey: "isdeleted")
                    let keywords = dictTemporaryDictionary.value(forKey: "keywords")
                    let latitude = dictTemporaryDictionary.value(forKey: "latitude")
                    let longitude = dictTemporaryDictionary.value(forKey: "longitude")
                    let memberName = dictTemporaryDictionary.value(forKey: "memberName")
                    
                    let moduleId = dictTemporaryDictionary.value(forKey: "moduleId")
                    let pax_no = dictTemporaryDictionary.value(forKey: "pax_no")
                    let serviceDirId = dictTemporaryDictionary.value(forKey: "serviceDirId")
                    let state = dictTemporaryDictionary.value(forKey: "state")
                    let website = dictTemporaryDictionary.value(forKey: "website")
                    let zipCode = dictTemporaryDictionary.value(forKey: "zipCode")
                    
                    
                    muDict=NSMutableDictionary()
                    muDict.setValue(address, forKey: "address")
                    muDict.setValue(addressCountry, forKey: "country")
                    muDict.setValue(categoryId, forKey: "categoryId")
                    muDict.setValue(city, forKey: "city")
                    muDict.setValue(contactNo, forKey: "contactNo")
                    muDict.setValue(contactNo2, forKey: "contactNo2")
                    muDict.setValue(countryCode1, forKey: "countryCode1")
                    muDict.setValue(countryCode2, forKey: "countryCode2")
                    muDict.setValue(countryId1, forKey: "countryId1")
                    muDict.setValue(countryId2, forKey: "countryId2")
                    muDict.setValue(descriptn, forKey: "description")
                    muDict.setValue(email, forKey: "email")
                    muDict.setValue(groupId, forKey: "groupId")
                    muDict.setValue(image, forKey: "image")
                    muDict.setValue(isdeleted, forKey: "isdeleted")
                    muDict.setValue(keywords, forKey: "csvKeywords")
                    muDict.setValue(latitude, forKey: "lat")
                    muDict.setValue(longitude, forKey: "long")
                    muDict.setValue(memberName, forKey: "memberName")
                    muDict.setValue(moduleId, forKey: "moduleId")
                    muDict.setValue(pax_no, forKey: "pax")
                    muDict.setValue(serviceDirId, forKey: "serviceDirId")
                    muDict.setValue(state, forKey: "state")
                    muDict.setValue(website, forKey: "website")
                    muDict.setValue(zipCode, forKey: "zip")
                    muDict.setValue("", forKey: "CategoryName")
                    muDict.setValue("", forKey: "ID")
                    muDict.setValue("", forKey: "TotalCount")
                    muDict.setValue("notcategory", forKey: "CategoryType")
                    
                    print(muDict)
                    
                    self.muarrayHold.add(muDict)
                    self.muarrayHold2.add(muDict)

                    print(self.muarrayHold)
                    
                }
                //2222222..............
                for i in 00..<((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "Category")! as AnyObject).count
                {
                    
                    var dictTemporaryDictionary:NSDictionary=((((response.object(forKey: "TBGetServiceCategoriesDataList"))! as AnyObject).object( forKey: "Result")! as AnyObject).object(forKey: "Category")! as AnyObject).object(at: i)
                    
                    
                    let CategoryName = dictTemporaryDictionary.value(forKey: "CategoryName")
                    let ID = dictTemporaryDictionary.value(forKey: "ID")
                    let TotalCount = dictTemporaryDictionary.value(forKey: "TotalCount")
                    
                    print(CategoryName)
                    print(ID)
                    print(TotalCount)
                    
                    muDict=NSMutableDictionary()
                    muDict.setValue("", forKey: "address")
                    muDict.setValue("", forKey: "country")
                    muDict.setValue("", forKey: "categoryId")
                    muDict.setValue("", forKey: "city")
                    muDict.setValue("", forKey: "contactNo")
                    muDict.setValue("", forKey: "contactNo2")
                    muDict.setValue("", forKey: "countryCode1")
                    muDict.setValue("", forKey: "countryCode2")
                    muDict.setValue("", forKey: "countryId1")
                    muDict.setValue("", forKey: "countryId2")
                    muDict.setValue("", forKey: "description")
                    muDict.setValue("", forKey: "email")
                    muDict.setValue("", forKey: "groupId")
                    muDict.setValue("", forKey: "image")
                    muDict.setValue("", forKey: "isdeleted")
                    muDict.setValue("", forKey: "csvKeywords")
                    muDict.setValue("", forKey: "lat")
                    muDict.setValue("", forKey: "long")
                    muDict.setValue("", forKey: "memberName")
                    muDict.setValue("", forKey: "moduleId")
                    muDict.setValue("", forKey: "pax")
                    muDict.setValue("", forKey: "serviceDirId")
                    muDict.setValue("", forKey: "state")
                    muDict.setValue("", forKey: "website")
                    muDict.setValue("", forKey: "zip")
                    muDict.setValue(CategoryName, forKey: "CategoryName")
                    muDict.setValue(ID, forKey: "ID")
                    muDict.setValue(TotalCount, forKey: "TotalCount")
                    muDict.setValue("category", forKey: "CategoryType")
                    
                    self.muarrayHold.add(muDict)
                    self.muarrayHold2.add(muDict)

                    print(self.muarrayHold)
                    
                }
                
                print(self.muarrayHold)
                
             
                
        
                self.tableviewCategoryServiceDircetory.reloadData()
            }
            SVProgressHUD.dismiss()
        }
        })
    }
    
   
    var muarrayHold:NSMutableArray=NSMutableArray()
    var muarrayHold2:NSMutableArray=NSMutableArray()

}
